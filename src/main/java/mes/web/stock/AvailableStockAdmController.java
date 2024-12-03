package mes.web.stock;

import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.inject.Inject;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import mes.domain.pm.PurchaseOrderVo;
import mes.domain.sm.CommonCodeVo;
import mes.domain.stock.AvailableStockAdmVo;
import mes.domain.stock.InMatrWhsAdmVo;
import mes.domain.stock.StockManagementVo;
import mes.domain.stock.StockPaymentAdmVo;
import mes.scheduler.Scheduler;
import mes.service.pm.PurchaseOrderService;
import mes.service.sm.CommonCodeService;
import mes.service.stock.AvailableStockAdmService;
import mes.service.stock.InMatrWhsAdmService;
import mes.service.stock.StockPaymentAdmService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class AvailableStockAdmController {
	private static final Logger logger = LoggerFactory.getLogger(AvailableStockAdmController.class);
	
	@Inject
	private AvailableStockAdmService availableStockAdmService;
	@Inject
	private Scheduler scheduler;
	@Inject
	private CommonCodeService commonCodeService;
	@Inject
	private PurchaseOrderService purchaseOrderService;
	//가용재고 등록
	@RequestMapping(value = "stock/availableStockAdmIns", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> availableStockAdmIns(AvailableStockAdmVo availableStockAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("가용재고 등록");
		try {
			String startDate = availableStockAdmVo.getStartDate();
			String endDate = availableStockAdmVo.getEndDate();
			
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
			LocalDate startDateLocal = LocalDate.parse(startDate, formatter);
			
			AvailableStockAdmVo availableStockSelVo = new AvailableStockAdmVo();
			availableStockSelVo.setStartDate(startDate);
			availableStockSelVo.setEndDate(endDate);
			List<AvailableStockAdmVo> purchaseOrderVoList = availableStockAdmService.availableStockPurchaseLst(availableStockSelVo);
			
			//마감기간 차이
			int startYear = Integer.parseInt(startDate.substring(0,4));
			int startMonth = Integer.parseInt(startDate.substring(4,6));
			int startDay = Integer.parseInt(startDate.substring(6,8));
			int endYear = Integer.parseInt(endDate.substring(0,4));
			int endMonth = Integer.parseInt(endDate.substring(4,6));
			int endDay = Integer.parseInt(endDate.substring(6,8));
			
			LocalDate localStartDate = LocalDate.of(startYear, startMonth, startDay);
			LocalDate localEndDate = LocalDate.of(endYear, endMonth, endDay);
			Period period = Period.between(localStartDate, localEndDate);
			
			//int diffDays = period.getDays();
			long diffDays = ChronoUnit.DAYS.between(localStartDate, localEndDate);
			
			// 조회된 리스트에서 idx(자재식별자)로 uniq하게 만든 리스트
			List<String> uniqueIdxList = purchaseOrderVoList.stream()
													        .map(AvailableStockAdmVo::getIdx) // AvailableStockAdmVo 객체에서 idx 필드값만 가져오기
													        .distinct() // 중복 제거
													        .collect(Collectors.toList());
			JSONArray insertArray = new JSONArray();
			
			// i = 자재 개수 , q = 날짜 개수 , j = 해당 자재및날짜기준의 리스트
			for(int i = 0 ; i < uniqueIdxList.size(); i++) {
				boolean p = true;
				//자재식별자
				String matrlIdx = uniqueIdxList.get(i);
				int todayStockQty = 0;
				int yesterdayAsQty = 0;
				for(int q = 0 ; q <= diffDays; q++ ) {
					
					//해당 자재식별자를 가진 목록 && 마감일에 수주등록/개별발주 나간항목
					LocalDate nextDay = startDateLocal.plusDays(q);
					String nextDayStr = nextDay.format(formatter);
					int selctDateVal = Integer.parseInt(nextDayStr);
					List<AvailableStockAdmVo> matrlFilterList = purchaseOrderVoList.stream()
																	        .filter(vo -> vo.getIdx().equals(matrlIdx) && vo.getOrdDate().equals(Integer.toString(selctDateVal)))
																	        .collect(Collectors.toList());
					//마감된 가용재고량-> 모든행에 전일 마감량이 들어있으므로 0번째행꺼만 가져오면됨
					int yesterdayStockQty = 0;
					//마감일에 나간 항목이 없을 경우 -> 종이재고표에서도 안보이므로 마감대상이 아님
					if(matrlFilterList.size() > 0) {
						//해당 마감시 첫번째로 마감등록하는 경우 -> 전일재고꺼 들고와서 계산
						//마감기한의 첫날이 아닌경우 마감데이터가 p == true에서 생성되므로 해당 내용에 계속해서 리스트에 있는거 가져오면됨
						if(p) {
							if(matrlFilterList.get(0).getAsQty() == null) {
								yesterdayStockQty = 0;
							} else {
								yesterdayStockQty = (int)Double.parseDouble(matrlFilterList.get(0).getAsQty());
							}	
							todayStockQty = yesterdayStockQty; 
							p = false;
						} else {
							todayStockQty = yesterdayAsQty;
						}
						
						for(int j = 0; j < matrlFilterList.size(); j++) {
							//가용재고량 계산식
							//일단 수주별발주이면 - 처리 , 입고량이 있는 경우 + 처리
							//개별발주이면서 발주확정된 경우 -> 재고 +
							AvailableStockAdmVo targetVo = new AvailableStockAdmVo();
							targetVo = matrlFilterList.get(j);
							if( targetVo.getBizOrdDtlNo().contains("D") ) {
								//개별발주이며 확정된경우
								if( "Y".equals(targetVo.getConfirmYn()) ) {
									todayStockQty += (int)Double.parseDouble(targetVo.getStockQty());
								}
							} else {
								//수주별발주인경우
								todayStockQty -= (int)Double.parseDouble(targetVo.getStockQty());
								if( (int)Double.parseDouble(targetVo.getInQty()) > 0 ) {
									//입고량이 있는 경우
									todayStockQty += (int)Double.parseDouble(targetVo.getInQty());
								}
							}
						}
						yesterdayAsQty = todayStockQty;
						//해당날짜 마감량 계산된거 넣어놓기
						JSONObject stockData = new JSONObject();
						stockData.put("matrlIdx", matrlIdx);
						stockData.put("todayStockQty", todayStockQty);
						stockData.put("endDate", selctDateVal);
						stockData.put("asGubun", "001");//수동마감001 , 자동일경우 002임
						insertArray.add(stockData);
					}
					
				}
				
				
			}
			AvailableStockAdmVo availableStockAdmInsVo = new AvailableStockAdmVo();
			availableStockAdmInsVo.setJsonArray(insertArray.toJSONString());
			availableStockAdmInsVo.setRegIdx(Utils.getUserIdx());
			availableStockAdmInsVo.setRegDate(DateUtil.getCurrentDateTime());
			availableStockAdmService.availableStockAdmIns(availableStockAdmInsVo);
			
			//availableStockAdmVo.setRegIdx(Utils.getUserIdx());
			//availableStockAdmVo.setRegDate(DateUtil.getCurrentDateTime());
			//availableStockAdmService.availableStockAdmIns(availableStockAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}

}
