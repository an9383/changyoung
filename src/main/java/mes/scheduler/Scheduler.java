package mes.scheduler;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.stream.Collectors;

import javax.inject.Inject;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.jcraft.jsch.Logger;

import mes.domain.pm.PurchaseOrderVo;
import mes.domain.sm.BatchProcVo;
import mes.domain.sm.SystemAccessLogVo;
import mes.domain.stock.AvailableStockAdmVo;
import mes.service.pm.PurchaseOrderService;
import mes.service.sm.BatchProcService;

import mes.domain.sm.CommonCodeVo;
import mes.service.sm.CommonCodeService;
import mes.service.sm.SystemAccessLogService;
import mes.service.stock.AvailableStockAdmService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Component
public class Scheduler {
	
	@Inject
	private CommonCodeService commonCodeService;
	@Inject
	private SystemAccessLogService systemAccessLogService;
	@Inject
	private BatchProcService batchProcService;
	@Inject
	private PurchaseOrderService purchaseOrderService;
	@Inject
	private AvailableStockAdmService availableStockAdmService;
	@Scheduled(cron = "00 00 23 * * *") // 초/분/시/일/월/요일/년도(생략가능)
	public void sendLogdataJSON() { // API LOG 전송
		try {
	        System.out.println("로그 시작");
			CommonCodeVo commonCodeVo = new CommonCodeVo();
			commonCodeVo.setCommonType("시스템"); // schduler
			commonCodeVo.setCommonCd("017");
			List<CommonCodeVo> commonCodeVoList = commonCodeService.commonCodeDtlLstByCommonCd(commonCodeVo);
			
			CommonCodeVo result = commonCodeVoList.stream().filter(x -> x.getCommonCd().equals("001")).findAny().get();
			String batchId = "001";
			String batchNm = result.getCommonNm();
			String batchStartTime = DateUtil.getDay("yyyy-mm-dd hh:mm:ss:ms", 0);
			String apiKey = result.getEtc1(); // API Key
			String useYn = result.getAttr(); // scheduler 사용여부
			String date = DateUtil.getDay("yyyy-mm-dd", 0);
			
			//로그 전송 성공 여부 변수
			boolean httpResponse = false;
			
			if(useYn.equals("Y")) {
				SystemAccessLogVo systemAccessLogVo = new SystemAccessLogVo();
				systemAccessLogVo.setStartDate(date + " 00:00:00");
				systemAccessLogVo.setEndDate(date + " 23:00:00");
				List<SystemAccessLogVo> systemAccessLogVoList = systemAccessLogService.systemAccessLogLst(systemAccessLogVo);
				
				for(int i=0;i<systemAccessLogVoList.size();i++) {
					if (systemAccessLogVoList.get(i).getAccessMenuNm() != null) {
						System.out.println("systemAccessLogVoList -> " + systemAccessLogVoList);
						
						// 로그인/로그아웃 여부
						String useSe = "";
						String logDate = "";
						//창영에서는 모든 로그 보내도록
						/*if (systemAccessLogVoList.get(i).getAccessMenuNm() == null) {
							useSe = "로그아웃";
							logDate = systemAccessLogVoList.get(i).getLogoutDate()+".000";
						} else {
							useSe = "로그인";
							logDate = systemAccessLogVoList.get(i).getLoginDate()+".000";
						}*/
						useSe = systemAccessLogVoList.get(i).getAccessMenuNm();
						logDate = systemAccessLogVoList.get(i).getAccessDate()+"00";
						// 전송할 데이터 생성
						JSONObject jsonObj = new JSONObject();
						jsonObj.put("crtfcKey", apiKey); // api 인증키
						jsonObj.put("logDt", logDate); // 로그일시
						jsonObj.put("useSe", useSe); // 접속구분
						jsonObj.put("sysUser", systemAccessLogVoList.get(i).getUserIdx() + "/" + systemAccessLogVoList.get(i).getUserNm()); // 사용자
						jsonObj.put("conectIp", systemAccessLogVoList.get(i).getAccessIp()); // IP정보
						jsonObj.put("dataUsgqty", 0); // 데이터사용량(숫자)
						
						System.out.println("jsonObj --> " + jsonObj);
						
						// 데이터 전송
						StringBuilder urlBuilder = new StringBuilder("https://log.smart-factory.kr/apisvc/sendLogDataJSON.do"); /*URL*/
				        urlBuilder.append("?" + URLEncoder.encode("logData","UTF-8") + "=" + URLEncoder.encode(jsonObj.toJSONString(), "UTF-8"));
				        URL url = new URL(urlBuilder.toString());
				        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
				        conn.setRequestMethod("POST");
				        conn.setRequestProperty("Content-type", "application/json");
				        
				        
				        System.out.println("Response code: " + conn.getResponseCode());
				        BufferedReader rd;
				        // 200번대 응답 -> 성공인 경우
				        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
				            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
				            httpResponse = true;
				        } else {
				            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
				        }
				        StringBuilder sb = new StringBuilder();
				        String line;
				        while ((line = rd.readLine()) != null) {
				            sb.append(line);
				        }
				        rd.close();
				        conn.disconnect();
				        System.out.println(sb.toString());
					}
				}
				//0건인경우 CRM에 데이터 보내도록 추가
				if(systemAccessLogVoList.size()==0) {
					httpResponse = true;					
				}
				//하나의 로그라도 전송 성공일 경우에만 CRM에 보내게끔 변경
				if(httpResponse) {
					// 전송할 데이터 생성
					JSONObject jsonObj2 = new JSONObject();
					jsonObj2.put("dealCorpIdx", 12); // 고객사 식별자
					jsonObj2.put("sendDate", date.replaceAll("-", "")); // 전송일자
					jsonObj2.put("sendQty", systemAccessLogVoList.size()); // 총 접속건수
					jsonObj2.put("regIdx", '1'); // 사용자
					
					System.out.println("jsonObj2 --> " + jsonObj2);
					
					// 데이터 전송
					StringBuilder urlBuilder = new StringBuilder("http://crm.hygino.co.kr/mt/sfApiLogIns"); /*URL*/
					urlBuilder.append("?");
					urlBuilder.append("dealCorpIdx="+jsonObj2.get("dealCorpIdx").toString()+"&");
					urlBuilder.append("sendDate="+jsonObj2.get("sendDate").toString()+"&");
					urlBuilder.append("sendQty="+jsonObj2.get("sendQty").toString()+"&");
					urlBuilder.append("regIdx="+jsonObj2.get("regIdx").toString());
			        
			        System.out.println(urlBuilder.toString());
			        URL url = new URL(urlBuilder.toString());
			        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			        conn.setRequestMethod("POST");
			        conn.setRequestProperty("Content-type", "application/json");
			        conn.setDoOutput(true);
			        
			        BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			        bw.write(jsonObj2.toString());
			        bw.flush();
			        bw.close();
			        
			        System.out.println("Response code: " + conn.getResponseCode());
			        BufferedReader rd;
			        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			        } else {
			            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
			        }
			        StringBuilder sb = new StringBuilder();
			        String line;
			        while ((line = rd.readLine()) != null) {
			            sb.append(line);
			        }
			        rd.close();
			        conn.disconnect();
			        System.out.println(sb.toString());
					
					BatchProcVo batchProcVo = new BatchProcVo();
					batchProcVo.setBatchId(batchId);
					batchProcVo.setBatchNm(batchNm);
					batchProcVo.setBatchStartTime(batchStartTime);
					batchProcVo.setBatchEndTime(DateUtil.getDay("yyyy-mm-dd hh:mm:ss:ms", 0));
					batchProcVo.setSuccessYn("Y");
					batchProcVo.setCreatedAt(DateUtil.getCurrentDateTime());
					batchProcService.batchProcLog(batchProcVo);
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	@Scheduled(cron = "00 30 23 * * *") // 초/분/시/일/월/요일/년도(생략가능)
	public void endAvailbleStock() { //자동 가용재고량 마감 기능
		try {
			String batchStartTime = DateUtil.getDay("yyyy-mm-dd hh:mm:ss:ms", 0);
			
			PurchaseOrderVo purchaseOrderVo = new PurchaseOrderVo(); 
			
			CommonCodeVo commonCodeVo = new CommonCodeVo();
			commonCodeVo.setCommonType("시스템"); // 마감기간
			commonCodeVo.setCommonCd("037");
			List<CommonCodeVo> commonCodeVoList = commonCodeService.commonCodeDtlLstByCommonCd(commonCodeVo);
			//period-> 마감기간
			CommonCodeVo result = commonCodeVoList.stream().filter(x -> x.getCommonNm().equals("period")).findAny().get();
			String batchYn = result.getAttr();
			int commonCd = Integer.parseInt(result.getCommonCd());
			//사용여부가 Y이고 commonCd가 음수 or 0일경우 (마감기간이 있는 경우)
			if("Y".equals(batchYn) && commonCd <= 0) {
				String startDate = DateUtil.getDay("yyyymmdd", Integer.parseInt(commonCodeVoList.get(0).getCommonCd()));
				String endDate = DateUtil.getDay("yyyymmdd", 0);
				
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
							stockData.put("asGubun", "002");//수동마감001 , 자동일경우 002임
							insertArray.add(stockData);
						}
						
					}
					
					
				}
				AvailableStockAdmVo availableStockAdmVo = new AvailableStockAdmVo();
				availableStockAdmVo.setJsonArray(insertArray.toJSONString());
				availableStockAdmVo.setRegIdx("batChAdmin");
				availableStockAdmVo.setRegDate(DateUtil.getCurrentDateTime());
				availableStockAdmService.availableStockAdmIns(availableStockAdmVo);
				
				BatchProcVo batchProcVo = new BatchProcVo();
				batchProcVo.setBatchId("001");
				batchProcVo.setBatchNm("11시30분 재고마감");
				batchProcVo.setBatchStartTime(batchStartTime);
				batchProcVo.setBatchEndTime(DateUtil.getDay("yyyy-mm-dd hh:mm:ss:ms", 0));
				batchProcVo.setSuccessYn("Y");
				batchProcVo.setCreatedAt(DateUtil.getCurrentDateTime());
				batchProcService.batchProcLog(batchProcVo);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
