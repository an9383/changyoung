package mes.web.stock;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import mes.domain.bm.LocationVo;
import mes.domain.stock.ItemDisposalAdmVo;
import mes.domain.stock.StockManagementVo;
import mes.service.bm.LocationService;
import mes.service.stock.ItemDisposalAdmService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class ItemDisposalAdmController {
	private static final Logger logger = LoggerFactory.getLogger(ItemDisposalAdmController.class);
	
	@Inject
	private ItemDisposalAdmService itemDisposalAdmService;
	@Inject
	private StockManagementController stockManagementController;
	@Inject
	private LocationService locationService;
	
	//제품 재고폐기 조회
	@RequestMapping(value = "stock/itemDisposalAdmLst", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> itemDisposalAdmLst(ItemDisposalAdmVo itemDisposalAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품 재고폐기 조회");
		try {
			List<ItemDisposalAdmVo> itemDisposalAdmVoList = itemDisposalAdmService.itemDisposalAdmLst(itemDisposalAdmVo);
			jsonData.put("data", itemDisposalAdmVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//제품 재고폐기 등록
	@RequestMapping(value = "stock/itemDisposalAdmIns", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> itemDisposalAdmIns(ItemDisposalAdmVo itemDisposalAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품 재고폐기 등록");
		try {
			//제품 출고 가능한 창고
			LocationVo locationVo = new LocationVo();
			locationVo = locationService.possibleOutItemLocationList(locationVo);
			
			//제품 폐기 입고가능한 창고
			LocationVo locationDisposalVo = new LocationVo();
			locationDisposalVo = locationService.possibleDisposalLocationList(locationDisposalVo);
			if(locationVo == null) {
				jsonData.put("message", "제품 출고 가능한 창고가 <br>없습니다.");
				jsonData.put("result", "fail");
			} else if(locationDisposalVo == null) {
				jsonData.put("message", "제품 폐기 입고 가능한 창고가 <br>없습니다.");
				jsonData.put("result", "fail");
			} else {
				//폐기등록테이블 등록
				itemDisposalAdmVo.setRegIdx(Utils.getUserIdx());
				itemDisposalAdmVo.setRegDate(DateUtil.getCurrentDateTime());
				itemDisposalAdmService.itemDisposalAdmIns(itemDisposalAdmVo);
				//폐기처리 업데이트
				itemDisposalAdmVo.setIdx(itemDisposalAdmVo.getResIdx());
				itemDisposalAdmVo.setWorkYn("Y");
				itemDisposalAdmVo.setFinalCheckYn("Y");
				itemDisposalAdmVo.setUpdIdx(Utils.getUserIdx());
				itemDisposalAdmVo.setUpdDate(DateUtil.getCurrentDateTime());
				itemDisposalAdmService.itemDisposalAdmCheckYnUpd(itemDisposalAdmVo);
				if("Y".equals(itemDisposalAdmVo.getResultYn()) ) {
					//제조책임자 확인을 업데이트한 경우 수불 발생
					if("Y".equals(itemDisposalAdmVo.getFinalCheckYn())) {
						List<StockManagementVo> stockManagementVoList = new ArrayList<>();
						Date today = new Date();	// 오늘 날짜
						SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
						// 문자열을 Date 객체로 파싱
						String strToday = sdf.format(today);
						
						//제품 폐기 출고
						StockManagementVo stockManagementVo = new StockManagementVo();
						stockManagementVo.setSmItemGubun("001");
			    		stockManagementVo.setSmOutGubun("폐기");
			    		stockManagementVo.setSmItemIdx(itemDisposalAdmVo.getItemIdx());
			    		stockManagementVo.setSmItemVersionIdx(itemDisposalAdmVo.getItemVerIdx());
			    		stockManagementVo.setSmCarAssignment(null);
			    		//stockManagementVo.setSmItemCd(jsonObject.get("itemCd").toString());
			    		stockManagementVo.setSmQty(itemDisposalAdmVo.getDisposalQty());
			    		stockManagementVo.setSmDate(strToday);
			    		stockManagementVo.setSmOutCorpIdx(null);
			    		stockManagementVo.setSmStatus("B");
			    		stockManagementVo.setSmLotNo("");
			    		stockManagementVo.setSmOutRelationNo(itemDisposalAdmVo.getIdx());
			    		stockManagementVo.setSmOutWhsGubun("");
			    		stockManagementVo.setSmOutWhsIdx(locationVo.getIdx());
			    		stockManagementVo.setSmOutLocIdx(null);
			    		stockManagementVo.setSmEtc1(null);
			    		stockManagementVo.setSmEtc2(null);
			    		stockManagementVo.setSmEtc3(null);
			    		
			    		
			    		stockManagementVo.setSmType("출고");
			    		stockManagementVo.setSmType2("ODP");
			    		stockManagementVo.setSmInWhsGubun("");
			    		stockManagementVo.setSmInWhsIdx(locationVo.getIdx()); //폐기창고로 입고
			    		stockManagementVo.setSmLotNo("");
			    		stockManagementVo.setSmInRelationNo(itemDisposalAdmVo.getIdx());
			    		stockManagementVo.setSmDesc("");
			    		stockManagementVo.setSmEtc1("");
			    		stockManagementVo.setSmEtc2("");
			    		stockManagementVo.setSmEtc3("");
			    		stockManagementVoList.add(stockManagementVo);
			    		stockManagementController.ProdOutput(stockManagementVoList);
			    		
			    		//제품 폐기 창고 입고
			    		
			    		// 제품 입고 처리 목록
						List<StockManagementVo> stockManagementVoInList = new ArrayList<>();
						
						StockManagementVo stockManagementInVo = new StockManagementVo();
						stockManagementInVo.setSmItemGubun("001"); //001:제품 , 002:자재
						stockManagementInVo.setSmItemCd(itemDisposalAdmVo.getItemIdx()); //품목(제품) 식별자
						stockManagementInVo.setSmItemVersionIdx(itemDisposalAdmVo.getItemVerIdx()); //품목(제품) 식별자
						stockManagementInVo.setSmType("입고"); //수불구분
						stockManagementInVo.setSmType2("IDP"); //업무구분
						stockManagementInVo.setSmDate(strToday); //수불일자
						stockManagementInVo.setSmQty( itemDisposalAdmVo.getDisposalQty() ); // 수불수량
						stockManagementInVo.setSmLotNo(""); //LOT번호 -> 채번이라서 빈값넘겨줌
						stockManagementInVo.setSmSourceNo(itemDisposalAdmVo.getIdx()); //원천번호 -> 폐기등록의의 식별자
						stockManagementInVo.setSmInWhsGubun(""); //창고구분 -> 없음 빈값 
						stockManagementInVo.setSmOutWhsIdx(locationDisposalVo.getIdx()); //창고식별자 
						stockManagementInVo.setSmInWhsIdx(locationDisposalVo.getIdx()); //창고식별자  
			    		
						stockManagementInVo.setSmInGubun("폐기"); //입고구분
						stockManagementInVo.setSmInCorpIdx(""); //입고처
						stockManagementInVo.setSmInRelationNo(itemDisposalAdmVo.getIdx()); //연관번호 -> 폐기등록의 식별자
			    		stockManagementVoInList.add(stockManagementInVo);
			    		//제품입고처리
						stockManagementController.ProdInput(stockManagementVoInList);
						jsonData.put("data", itemDisposalAdmVo);
						jsonData.put("result", "ok");					    		
					}
				} else {
					jsonData.put("result", "fail");
					jsonData.put("message", itemDisposalAdmVo.getResMessage());
				}
				
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//제품 재고폐기 수정
	@RequestMapping(value = "stock/itemDisposalAdmUpd", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> itemDisposalAdmUpd(ItemDisposalAdmVo itemDisposalAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품 재고폐기 수정");
		try {
			itemDisposalAdmVo.setUpdIdx(Utils.getUserIdx());
			itemDisposalAdmVo.setUpdDate(DateUtil.getCurrentDateTime());
			itemDisposalAdmService.itemDisposalAdmUpd(itemDisposalAdmVo);
			jsonData.put("data", itemDisposalAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//제품 재고폐기 수정 - 폐기로직 변경되면서 해당 URL 없어짐
	/*@RequestMapping(value = "stock/itemDisposalAdmCheckYnUpd", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> itemDisposalAdmCheckYnUpd(ItemDisposalAdmVo itemDisposalAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품 재고폐기 수정");
		try {
			//제품 출고 가능한 창고
			LocationVo locationVo = new LocationVo();
			locationVo = locationService.possibleOutItemLocationList(locationVo);
			
			//제품 폐기 입고가능한 창고
			LocationVo locationDisposalVo = new LocationVo();
			locationDisposalVo = locationService.possibleDisposalLocationList(locationDisposalVo);
			if(locationVo == null) {
				jsonData.put("message", "제품 출고 가능한 창고가 <br>없습니다.");
				jsonData.put("result", "fail");
			} else if(locationDisposalVo == null) {
				jsonData.put("message", "제품 폐기 입고 가능한 창고가 <br>없습니다.");
				jsonData.put("result", "fail");
			} else {
				itemDisposalAdmVo.setUpdIdx(Utils.getUserIdx());
				itemDisposalAdmVo.setUpdDate(DateUtil.getCurrentDateTime());
				itemDisposalAdmService.itemDisposalAdmCheckYnUpd(itemDisposalAdmVo);
				jsonData.put("data", itemDisposalAdmVo);
				if("Y".equals(itemDisposalAdmVo.getResultYn()) ) {
					jsonData.put("result", "ok");
					//제조책임자 확인을 업데이트한 경우 수불 발생
					if("Y".equals(itemDisposalAdmVo.getFinalCheckYn())) {
						List<StockManagementVo> stockManagementVoList = new ArrayList<>();
						Date today = new Date();	// 오늘 날짜
						SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
						// 문자열을 Date 객체로 파싱
						String strToday = sdf.format(today);
						
						//제품 폐기 출고
						StockManagementVo stockManagementVo = new StockManagementVo();
						stockManagementVo.setSmItemGubun("001");
			    		stockManagementVo.setSmOutGubun("폐기");
			    		stockManagementVo.setSmItemIdx(itemDisposalAdmVo.getItemIdx());
			    		stockManagementVo.setSmCarAssignment(null);
			    		//stockManagementVo.setSmItemCd(jsonObject.get("itemCd").toString());
			    		stockManagementVo.setSmQty(itemDisposalAdmVo.getDisposalQty());
			    		stockManagementVo.setSmDate(strToday);
			    		stockManagementVo.setSmOutCorpIdx(null);
			    		stockManagementVo.setSmStatus("B");
			    		stockManagementVo.setSmLotNo("");
			    		stockManagementVo.setSmOutRelationNo(itemDisposalAdmVo.getIdx());
			    		stockManagementVo.setSmOutWhsGubun("");
			    		stockManagementVo.setSmOutWhsIdx(locationVo.getIdx());
			    		stockManagementVo.setSmOutLocIdx(null);
			    		stockManagementVo.setSmEtc1(null);
			    		stockManagementVo.setSmEtc2(null);
			    		stockManagementVo.setSmEtc3(null);
			    		
			    		
			    		stockManagementVo.setSmType("출고");
			    		stockManagementVo.setSmType2("ODP");
			    		stockManagementVo.setSmInWhsGubun("");
			    		stockManagementVo.setSmInWhsIdx(locationVo.getIdx()); //폐기창고로 입고
			    		stockManagementVo.setSmLotNo("");
			    		stockManagementVo.setSmInRelationNo(itemDisposalAdmVo.getIdx());
			    		stockManagementVo.setSmDesc("");
			    		stockManagementVo.setSmEtc1("");
			    		stockManagementVo.setSmEtc2("");
			    		stockManagementVo.setSmEtc3("");
			    		stockManagementVoList.add(stockManagementVo);
			    		stockManagementController.ProdOutput(stockManagementVoList);
			    		
			    		//제품 폐기 창고 입고
			    		
			    		// 제품 입고 처리 목록
						List<StockManagementVo> stockManagementVoInList = new ArrayList<>();
						
						StockManagementVo stockManagementInVo = new StockManagementVo();
						stockManagementInVo.setSmItemGubun("001"); //001:제품 , 002:자재
						stockManagementInVo.setSmItemCd(itemDisposalAdmVo.getItemIdx()); //품목(제품) 식별자
						stockManagementInVo.setSmType("입고"); //수불구분
						stockManagementInVo.setSmType2("IDP"); //업무구분
						stockManagementInVo.setSmDate(strToday); //수불일자
						stockManagementInVo.setSmQty( itemDisposalAdmVo.getDisposalQty() ); // 수불수량
						stockManagementInVo.setSmLotNo(""); //LOT번호 -> 채번이라서 빈값넘겨줌
						stockManagementInVo.setSmSourceNo(itemDisposalAdmVo.getIdx()); //원천번호 -> 폐기등록의의 식별자
						stockManagementInVo.setSmInWhsGubun(""); //창고구분 -> 없음 빈값 
						stockManagementInVo.setSmOutWhsIdx(locationDisposalVo.getIdx()); //창고식별자 
						stockManagementInVo.setSmInWhsIdx(locationDisposalVo.getIdx()); //창고식별자  
			    		
						stockManagementInVo.setSmInGubun("폐기"); //입고구분
						stockManagementInVo.setSmInCorpIdx(""); //입고처
						stockManagementInVo.setSmInRelationNo(itemDisposalAdmVo.getIdx()); //연관번호 -> 폐기등록의 식별자
			    		stockManagementVoInList.add(stockManagementInVo);
			    		//제품입고처리
						stockManagementController.ProdInput(stockManagementVoInList);
			    		
					}
				} else {
					jsonData.put("result", "fail");
					jsonData.put("message", itemDisposalAdmVo.getResMessage());
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}*/
	
	//제품 재고폐기 삭제
	@RequestMapping(value = "stock/itemDisposalAdmDel", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> itemDisposalAdmDel(ItemDisposalAdmVo itemDisposalAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품 재고폐기 삭제");
		try {
			itemDisposalAdmService.itemDisposalAdmDel(itemDisposalAdmVo);
			jsonData.put("data", itemDisposalAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
}
