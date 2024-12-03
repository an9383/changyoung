package mes.web.qm;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.mindrot.jbcrypt.BCrypt;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import mes.domain.bm.LocationVo;
import mes.domain.pm.PurchaseOrderVo;
import mes.domain.qm.ProdQualityVo;
import mes.domain.stock.InProdWhsAdmVo;
import mes.domain.stock.OutMatrWhsAdmVo;
import mes.domain.stock.OutProdWhsAdmVo;
import mes.domain.stock.StockManagementVo;
import mes.domain.stock.StockPaymentAdmVo;
import mes.domain.wm.WorkOrderVo;
import mes.service.bm.LocationService;
import mes.service.pm.PurchaseOrderService;
import mes.service.qm.ProdQualityService;
import mes.service.stock.InProdWhsAdmService;
import mes.service.stock.OutMatrWhsAdmService;
import mes.service.stock.OutProdWhsAdmService;
import mes.service.stock.StockPaymentAdmService;
import mes.service.wm.WorkOrderService;
import mes.web.stock.StockManagementController;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
@RequestMapping("/")
public class ProdQualityController {
	
	@Inject
	private ProdQualityService prodQualityService;
	
	@Inject
	private LocationService locationService;
	
	@Inject
	private WorkOrderService workOrderService;
	
	@Inject
	private StockManagementController stockManagementController;

	@Inject
	private StockPaymentAdmService stockPaymentAdmService;
	
	@Inject
	private InProdWhsAdmService inProdWhsAdmService;
	
	@Inject
	private OutProdWhsAdmService outProdWhsAdmService;
	
	private static final Logger logger = LoggerFactory.getLogger(ProdQualityController.class);
	
	// qmsc0010
	@RequestMapping(value = "/qm/qmsc0010", method = RequestMethod.GET)
	public ModelAndView qmsc0010(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /qm/qmsc0010");
		mav.setViewName("/qm/qmsc0010");
		return mav;
	}
	
	// qmsc0020
	@RequestMapping(value = "/qm/qmsc0020", method = RequestMethod.GET)
	public ModelAndView qmsc0020(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /qm/qmsc0020");
		mav.setViewName("/qm/qmsc0020");
		return mav;
	}
	
	// qmsc0030
	@RequestMapping(value = "/qm/qmsc0030", method = RequestMethod.GET)
	public ModelAndView qmsc0030(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /qm/qmsc0030");
		mav.setViewName("/qm/qmsc0030");
		return mav;
	}
	
	// qmsc0040
	@RequestMapping(value = "/qm/qmsc0040", method = RequestMethod.GET)
	public ModelAndView qmsc0040(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /qm/qmsc0040");
		mav.setViewName("/qm/qmsc0040");
		return mav;
	}
	
	//품질관리 - 제품검사 목록 조회
	@RequestMapping(value = "qm/prodQualityAdmLst", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> prodQualityAdmLst(ProdQualityVo prodQualityVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품검사 목록 조회");
		try {
			List<ProdQualityVo> prodQualityVoList = prodQualityService.prodQualityAdmLst(prodQualityVo);
			jsonData.put("data", prodQualityVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//품질관리 - 제품검사 현황 조회
	@RequestMapping(value = "qm/prodQualityProgressLst", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> prodQualityProgressLst(ProdQualityVo prodQualityVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품검사 현황 조회");
		try {
			List<ProdQualityVo> prodQualityVoList = prodQualityService.prodQualityProgressLst(prodQualityVo);
			jsonData.put("data", prodQualityVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//제품검사 합격 및 승인 목록 조회
	@RequestMapping(value = "qm/prodQualityPassLst", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> prodQualityPassLst(ProdQualityVo prodQualityVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품검사 합격 및 승인 목록 조회");
		try {
			List<ProdQualityVo> prodQualityVoList = prodQualityService.prodQualityPassLst(prodQualityVo);
			jsonData.put("data", prodQualityVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//제품검사 수량,판정,승인자 수정
	@RequestMapping(value = "qm/prodQualityAdmUpd", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> prodQualityAdmUpd(ProdQualityVo prodQualityVo,
										@RequestParam(value="insertConfimList", required=false) String jsonArray) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품검사 수량,판정,승인자 수정");
		try {
			JSONParser jsonParser = new JSONParser();
			JSONArray dataArray = (JSONArray) jsonParser.parse(jsonArray);
			JSONObject jsonObj = new JSONObject();

			//dataArray == 0 인경우 => 미판정만 등록,수정하는 경우
			//0보다 큰 경우는 적합,부적합이 있으므로 승인까지 자동으로 해줘야함 
			if(dataArray.size() > 0) {
				//제품 입고 가능한 창고
				LocationVo locationVo = new LocationVo();
				LocationVo locationInVo = locationService.possibleOutItemLocationList(locationVo);
				
				//제품 품질창고(QC) 가능한 창고 조회
				WorkOrderVo workOrderVo = new WorkOrderVo();
				WorkOrderVo prodLocationVo = workOrderService.workInProdLocationList(workOrderVo);
				
				//제품 폐기 입고가능한 창고
				LocationVo locationDisposalVo = locationService.possibleDisposalLocationList(locationVo);
				if(prodLocationVo == null) {
					jsonData.put("message", "QC 출고 가능한 창고가 <br>없습니다.");
					jsonData.put("result", "fail");
				} else if(locationInVo == null) {
					jsonData.put("message", "제품 입고 가능한 창고가 <br>없습니다.");
					jsonData.put("result", "fail");
				} else if(locationDisposalVo == null) {
					jsonData.put("message", "제품 폐기 입고 가능한 창고가 <br>없습니다.");
					jsonData.put("result", "fail");
				} else {
					//해당 검사내역 저장/수정
					prodQualityVo.setRegIdx(Utils.getUserIdx());
					prodQualityVo.setRegDate(DateUtil.getCurrentDateTime());
					prodQualityVo.setUpdIdx(Utils.getUserIdx());
					prodQualityVo.setUpdDate(DateUtil.getCurrentDateTime());
					prodQualityService.prodQualityAdmUpd(prodQualityVo);
					prodQualityService.prodQualityAdmIns(prodQualityVo);
					
					
					//해당 제품검사결과 리스트
					List<ProdQualityVo> prodQualityList = prodQualityService.prodQualityJudgmentEndLstByWorkOrdResultIdx(prodQualityVo);
					
					 for(int i=0;i<prodQualityList.size();i++) {
			    		
			    		prodQualityVo.setIdx(prodQualityList.get(i).getIdx().toString());
			    		prodQualityVo.setBizOrdDtlIdx(prodQualityList.get(i).getBizOrdDtlIdx().toString());
						prodQualityService.prodQualityAdmConfirmUpd(prodQualityVo);
						
						Date today = new Date();	// 오늘 날짜
						SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
						// 문자열을 Date 객체로 파싱
						String strToday = sdf.format(today);
						
			    		if("Y".equals(prodQualityVo.getResultYn())) {
			    			//수불발생대상
			    			if("02".equals(prodQualityVo.getResultCd())) {
			    				//적합
								List<StockManagementVo> stockManagementVoList = new ArrayList<>();
			    				//제품 qc창고에서 출고
								StockManagementVo stockManagementVo = new StockManagementVo();
								stockManagementVo.setSmItemGubun("001");
					    		stockManagementVo.setSmOutGubun("품질");
					    		stockManagementVo.setSmItemIdx(prodQualityList.get(i).getItemIdx().toString());
					    		stockManagementVo.setSmItemVersionIdx(prodQualityList.get(i).getItemVersionIdx().toString());
					    		stockManagementVo.setSmCarAssignment(null);
					    		//stockManagementVo.setSmItemCd(jsonObject.get("itemCd").toString());
					    		stockManagementVo.setSmQty(prodQualityVo.getResultQty());
					    		stockManagementVo.setSmDate(strToday);
					    		stockManagementVo.setSmOutCorpIdx(null);
					    		stockManagementVo.setSmStatus("B"); //출고
					    		stockManagementVo.setSmLotNo("");
					    		stockManagementVo.setSmOutRelationNo(prodQualityList.get(i).getIdx().toString()); 
					    		stockManagementVo.setSmOutWhsGubun("");
					    		stockManagementVo.setSmOutWhsIdx(prodLocationVo.getLocationIdx());
					    		stockManagementVo.setSmOutLocIdx(null);
					    		stockManagementVo.setSmEtc1(null);
					    		stockManagementVo.setSmEtc2(null);
					    		stockManagementVo.setSmEtc3(null);
					    		
					    		stockManagementVo.setSmType("출고");
					    		stockManagementVo.setSmType2("OQP");
					    		stockManagementVo.setSmInWhsGubun("");
					    		stockManagementVo.setSmInWhsIdx(prodLocationVo.getIdx()); 
					    		stockManagementVo.setSmLotNo("");
					    		stockManagementVo.setSmInRelationNo(prodQualityList.get(i).getIdx().toString());
					    		stockManagementVo.setSmDesc("");
					    		stockManagementVo.setSmEtc1("");
					    		stockManagementVo.setSmEtc2("");
					    		stockManagementVo.setSmEtc3("");
					    		stockManagementVoList.add(stockManagementVo);
					    		stockManagementController.ProdOutput(stockManagementVoList);

					    		// 제품 입고 처리 목록
								List<StockManagementVo> stockManagementVoInList = new ArrayList<>();
								
								StockManagementVo stockManagementInVo = new StockManagementVo();
								stockManagementInVo.setSmItemGubun("001"); //001:제품 , 002:자재
								stockManagementInVo.setSmItemCd(prodQualityList.get(i).getItemIdx().toString()); //품목(제품) 식별자
								stockManagementInVo.setSmItemVersionIdx(prodQualityList.get(i).getItemVersionIdx().toString()); //품목(제품 버전) 식별자
								stockManagementInVo.setSmType("입고"); //수불구분
								stockManagementInVo.setSmType2("IQP"); //업무구분
								stockManagementInVo.setSmDate(strToday); //수불일자
								stockManagementInVo.setSmQty( prodQualityVo.getResultQty() ); // 수불수량
								stockManagementInVo.setSmLotNo(""); //LOT번호 -> 채번이라서 빈값넘겨줌
								stockManagementInVo.setSmSourceNo(prodQualityList.get(i).getIdx().toString()); //원천번호 -> 검사식별자
								stockManagementInVo.setSmInWhsGubun(""); //창고구분 -> 없음 빈값 
								stockManagementInVo.setSmOutWhsIdx(locationInVo.getIdx()); //창고식별자 
								stockManagementInVo.setSmInWhsIdx(locationInVo.getIdx()); //창고식별자  
					    		
								stockManagementInVo.setSmInGubun("품질적합"); //입고구분
								stockManagementInVo.setSmInCorpIdx(""); //입고처
								stockManagementInVo.setSmInRelationNo(prodQualityList.get(i).getIdx().toString()); //원천번호 -> 검사식별자
					    		stockManagementVoInList.add(stockManagementInVo);
					    		//제품입고처리
								stockManagementController.ProdInput(stockManagementVoInList);
					    		
			    			} else if("03".equals(prodQualityVo.getResultCd())) {
			    				//부적합
				    			
			    				List<StockManagementVo> stockManagementVoList = new ArrayList<>();
			    				//제품 qc창고에서 출고
								StockManagementVo stockManagementVo = new StockManagementVo();
								stockManagementVo.setSmItemGubun("001");
					    		stockManagementVo.setSmOutGubun("품질");
					    		stockManagementVo.setSmItemIdx(prodQualityList.get(i).getItemIdx().toString());
					    		stockManagementVo.setSmItemVersionIdx(prodQualityList.get(i).getItemVersionIdx().toString());
					    		stockManagementVo.setSmCarAssignment(null);
					    		//stockManagementVo.setSmItemCd(jsonObject.get("itemCd").toString());
					    		stockManagementVo.setSmQty(prodQualityVo.getResultQty());
					    		stockManagementVo.setSmDate(strToday);
					    		stockManagementVo.setSmOutCorpIdx(null);
					    		stockManagementVo.setSmStatus("B"); //출고
					    		stockManagementVo.setSmLotNo("");
					    		stockManagementVo.setSmOutRelationNo(prodQualityList.get(i).getIdx().toString()); 
					    		stockManagementVo.setSmOutWhsGubun("");
					    		stockManagementVo.setSmOutWhsIdx(prodLocationVo.getLocationIdx());
					    		stockManagementVo.setSmOutLocIdx(null);
					    		stockManagementVo.setSmEtc1(null);
					    		stockManagementVo.setSmEtc2(null);
					    		stockManagementVo.setSmEtc3(null);
					    		
					    		stockManagementVo.setSmType("출고");
					    		stockManagementVo.setSmType2("OQDP");
					    		stockManagementVo.setSmInWhsGubun("");
					    		stockManagementVo.setSmInWhsIdx(prodLocationVo.getIdx()); 
					    		stockManagementVo.setSmLotNo("");
					    		stockManagementVo.setSmInRelationNo(prodQualityList.get(i).getIdx().toString());
					    		stockManagementVo.setSmDesc("");
					    		stockManagementVo.setSmEtc1("");
					    		stockManagementVo.setSmEtc2("");
					    		stockManagementVo.setSmEtc3("");
					    		stockManagementVoList.add(stockManagementVo);
					    		stockManagementController.ProdOutput(stockManagementVoList);

					    		// 제품 입고 처리 목록
								List<StockManagementVo> stockManagementVoInList = new ArrayList<>();
								
								StockManagementVo stockManagementInVo = new StockManagementVo();
								stockManagementInVo.setSmItemGubun("001"); //001:제품 , 002:자재
								stockManagementInVo.setSmItemCd(prodQualityList.get(i).getItemIdx().toString()); //품목(제품) 식별자
								stockManagementInVo.setSmItemVersionIdx(prodQualityList.get(i).getItemVersionIdx().toString()); //품목(제품 버전) 식별자
								stockManagementInVo.setSmType("입고"); //수불구분
								stockManagementInVo.setSmType2("IQDP"); //업무구분
								stockManagementInVo.setSmDate(strToday); //수불일자
								stockManagementInVo.setSmQty( prodQualityVo.getResultQty() ); // 수불수량
								stockManagementInVo.setSmLotNo(""); //LOT번호 -> 채번이라서 빈값넘겨줌
								stockManagementInVo.setSmSourceNo(prodQualityList.get(i).getIdx().toString()); //원천번호 -> 검사식별자
								stockManagementInVo.setSmInWhsGubun(""); //창고구분 -> 없음 빈값 
								stockManagementInVo.setSmOutWhsIdx(locationDisposalVo.getIdx()); //창고식별자 
								stockManagementInVo.setSmInWhsIdx(locationDisposalVo.getIdx()); //창고식별자  
					    		
								stockManagementInVo.setSmInGubun("품질폐기"); //입고구분
								stockManagementInVo.setSmInCorpIdx(""); //입고처
								stockManagementInVo.setSmInRelationNo(prodQualityList.get(i).getIdx().toString()); //원천번호 -> 검사식별자
					    		stockManagementVoInList.add(stockManagementInVo);
					    		//제품입고처리
								stockManagementController.ProdInput(stockManagementVoInList);
			    			}
			    		}
			        }

					jsonData.put("result", "ok");
				}
			} else {
				prodQualityVo.setRegIdx(Utils.getUserIdx());
				prodQualityVo.setRegDate(DateUtil.getCurrentDateTime());
				prodQualityVo.setUpdIdx(Utils.getUserIdx());
				prodQualityVo.setUpdDate(DateUtil.getCurrentDateTime());
				prodQualityService.prodQualityAdmUpd(prodQualityVo);
				prodQualityService.prodQualityAdmIns(prodQualityVo);
				jsonData.put("result", "ok");
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//제품검사 판정 삭제
	@RequestMapping(value = "qm/prodQualityAdmDel", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> prodQualityAdmDel(ProdQualityVo prodQualityVo,
															@RequestParam(value="deleteList", required=false) String jsonArray) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품검사 판정 삭제");
		try {
			JSONParser jsonParser = new JSONParser();
			JSONArray dataArray = (JSONArray) jsonParser.parse(jsonArray);
			JSONObject jsonObj = new JSONObject();			
			prodQualityVo.setUpdIdx(Utils.getUserIdx());
			prodQualityVo.setUpdDate(DateUtil.getCurrentDateTime());
			//제품출고 전표 삭제 JSON 배열
			JSONArray outProdDel_array = new JSONArray();
			//제품입고전표 삭제 배열
			JSONArray inProdDel_array = new JSONArray();
			//수불 삭제 JSON배열
			JSONArray stockDel_array = new JSONArray();
			
			 for(int i=0;i<dataArray.size();i++) {
		        	jsonObj.put(i, dataArray.get(i));	        	
		    		JSONObject jsonObject = (JSONObject) jsonParser.parse(jsonObj.get(i).toString());
		    		
		    		prodQualityVo.setIdx(jsonObject.get("idx").toString());
		    		prodQualityVo.setBizOrdDtlIdx(jsonObject.get("bizOrdDtlIdx").toString());
		    		prodQualityVo.setBizOrdDtlNo(jsonObject.get("bizOrdDtlNo").toString());
		    		prodQualityService.prodQualityAdmDel(prodQualityVo);
					if("Y".equals(prodQualityVo.getResultYn())) {
						//해당 품질적합으로 입고 , 출고, 수불 삭제처리
						//입고
						InProdWhsAdmVo inProdWhsAdmVo = new InProdWhsAdmVo();
						inProdWhsAdmVo.setRelationNo(prodQualityVo.getIdx());
						//적합
						if("02".equals(prodQualityVo.getResultCd())) {
							inProdWhsAdmVo.setInGubun("품질적합");
						} else if("03".equals(prodQualityVo.getResultCd())) {
							inProdWhsAdmVo.setInGubun("품질폐기");
						}
						inProdWhsAdmVo = inProdWhsAdmService.getInSlipNoByRelationNo(inProdWhsAdmVo);
						//해당 전표가 존재한다면 지우고 하도록
						if(inProdWhsAdmVo != null) {
							JSONObject inProdData = new JSONObject();
							inProdData.put("IN_SLIP_NO", inProdWhsAdmVo.getInSlipNo() );
							inProdData.put("IN_SLIP_SEQ", inProdWhsAdmVo.getInSlipSeq());
							inProdDel_array.add(inProdData);

							JSONObject stockData = new JSONObject();
							stockData.put("SP_SOURCE_NO", inProdWhsAdmVo.getInSlipNo() + "-" + inProdWhsAdmVo.getInSlipSeq());
							stockDel_array.add(stockData);
						}
						//출고
						//제품 출고 수불 삭제처리
			    		OutProdWhsAdmVo outProdWhsAdmVo = new OutProdWhsAdmVo();
			    		outProdWhsAdmVo.setRelationNo(prodQualityVo.getIdx());
			    		outProdWhsAdmVo.setOutGubun("품질");
			    		List<OutProdWhsAdmVo> outProdWhsAdmList = new ArrayList<>();
			    		outProdWhsAdmList = outProdWhsAdmService.getOutSlipNoByRelationNo(outProdWhsAdmVo);
			    		
			    		//해당 전표가 존재한다면 지우고 하도록
						if(outProdWhsAdmList.size() != 0) {
							for(int j=0;j<outProdWhsAdmList.size();j++) {
								JSONObject outProdData = new JSONObject();
								JSONObject stockDelData = new JSONObject();
								
								outProdData.put("OUT_SLIP_NO", outProdWhsAdmList.get(j).getOutSlipNo());
								outProdData.put("OUT_SLIP_SEQ", outProdWhsAdmList.get(j).getOutSlipSeq());
								outProdDel_array.add(outProdData);
								
						        stockDelData.put("SP_SOURCE_NO", outProdWhsAdmList.get(j).getOutSlipNo() + "-" + outProdWhsAdmList.get(j).getOutSlipSeq());
						        stockDel_array.add(stockDelData);
							}
						}
					}
			 }
			 InProdWhsAdmVo inProdWhsAdmVo = new InProdWhsAdmVo();
			 inProdWhsAdmVo.setDeleteJson(inProdDel_array.toJSONString());
			 inProdWhsAdmService.inProdWhsAdmDel(inProdWhsAdmVo); //제품입고 전표 삭제
			 
			 OutProdWhsAdmVo outProdWhsAdmVo = new OutProdWhsAdmVo();
			 outProdWhsAdmVo.setDeleteJson(outProdDel_array.toJSONString());
			 outProdWhsAdmService.outProdWhsAdmDel(outProdWhsAdmVo); //제품출고 전표 삭제
			 
			 StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();
			 stockPaymentAdmVo.setDeleteJson(stockDel_array.toJSONString());
			 stockPaymentAdmService.stockPaymentAdmDel(stockPaymentAdmVo); // 제품 입고수불 삭제
			 
			 
			 jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//제품검사 승인 처리
	@RequestMapping(value = "qm/prodQualityAdmConfirmUpd", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> prodQualityAdmConfirmUpd(ProdQualityVo prodQualityVo,
														@RequestParam(value="updateList", required=false) String jsonArray) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품검사 승인 처리");
		try {
			prodQualityVo.setUpdIdx(Utils.getUserIdx());
			prodQualityVo.setUpdDate(DateUtil.getCurrentDateTime());
			
			JSONParser jsonParser = new JSONParser();
			JSONArray dataArray = (JSONArray) jsonParser.parse(jsonArray);
			JSONObject jsonObj = new JSONObject();
			
			//제품 입고 가능한 창고
			LocationVo locationVo = new LocationVo();
			LocationVo locationInVo = locationService.possibleOutItemLocationList(locationVo);
			
			//제품 품질창고(QC) 가능한 창고 조회
			WorkOrderVo workOrderVo = new WorkOrderVo();
			WorkOrderVo prodLocationVo = workOrderService.workInProdLocationList(workOrderVo);
			
			//제품 폐기 입고가능한 창고
			LocationVo locationDisposalVo = locationService.possibleDisposalLocationList(locationVo);
			if(prodLocationVo == null) {
				jsonData.put("message", "QC 출고 가능한 창고가 <br>없습니다.");
				jsonData.put("result", "fail");
			} else if(locationInVo == null) {
				jsonData.put("message", "제품 입고 가능한 창고가 <br>없습니다.");
				jsonData.put("result", "fail");
			} else if(locationDisposalVo == null) {
				jsonData.put("message", "제품 폐기 입고 가능한 창고가 <br>없습니다.");
				jsonData.put("result", "fail");
			} else {
				 for(int i=0;i<dataArray.size();i++) {
		        	jsonObj.put(i, dataArray.get(i));	        	
		    		JSONObject jsonObject = (JSONObject) jsonParser.parse(jsonObj.get(i).toString());
		    		
		    		prodQualityVo.setIdx(jsonObject.get("idx").toString());
		    		prodQualityVo.setBizOrdDtlIdx(jsonObject.get("bizOrdDtlIdx").toString());
					prodQualityService.prodQualityAdmConfirmUpd(prodQualityVo);
					
					Date today = new Date();	// 오늘 날짜
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
					// 문자열을 Date 객체로 파싱
					String strToday = sdf.format(today);
					
		    		if("Y".equals(prodQualityVo.getResultYn())) {
		    			//수불발생대상
		    			if("02".equals(prodQualityVo.getResultCd())) {
		    				//적합

							List<StockManagementVo> stockManagementVoList = new ArrayList<>();
		    				//제품 qc창고에서 출고
							StockManagementVo stockManagementVo = new StockManagementVo();
							stockManagementVo.setSmItemGubun("001");
				    		stockManagementVo.setSmOutGubun("품질");
				    		stockManagementVo.setSmItemIdx(jsonObject.get("itemIdx").toString());
				    		stockManagementVo.setSmItemVersionIdx(jsonObject.get("itemVersionIdx").toString());
				    		stockManagementVo.setSmCarAssignment(null);
				    		//stockManagementVo.setSmItemCd(jsonObject.get("itemCd").toString());
				    		stockManagementVo.setSmQty(prodQualityVo.getResultQty());
				    		stockManagementVo.setSmDate(strToday);
				    		stockManagementVo.setSmOutCorpIdx(null);
				    		stockManagementVo.setSmStatus("B"); //출고
				    		stockManagementVo.setSmLotNo("");
				    		stockManagementVo.setSmOutRelationNo(jsonObject.get("bizOrdDtlNo").toString()); 
				    		stockManagementVo.setSmOutWhsGubun("");
				    		stockManagementVo.setSmOutWhsIdx(prodLocationVo.getLocationIdx());
				    		stockManagementVo.setSmOutLocIdx(null);
				    		stockManagementVo.setSmEtc1(null);
				    		stockManagementVo.setSmEtc2(null);
				    		stockManagementVo.setSmEtc3(null);
				    		
				    		stockManagementVo.setSmType("출고");
				    		stockManagementVo.setSmType2("OQP");
				    		stockManagementVo.setSmInWhsGubun("");
				    		stockManagementVo.setSmInWhsIdx(prodLocationVo.getIdx()); 
				    		stockManagementVo.setSmLotNo("");
				    		stockManagementVo.setSmInRelationNo(jsonObject.get("bizOrdDtlNo").toString());
				    		stockManagementVo.setSmDesc("");
				    		stockManagementVo.setSmEtc1("");
				    		stockManagementVo.setSmEtc2("");
				    		stockManagementVo.setSmEtc3("");
				    		stockManagementVoList.add(stockManagementVo);
				    		stockManagementController.ProdOutput(stockManagementVoList);

				    		// 제품 입고 처리 목록
							List<StockManagementVo> stockManagementVoInList = new ArrayList<>();
							
							StockManagementVo stockManagementInVo = new StockManagementVo();
							stockManagementInVo.setSmItemGubun("001"); //001:제품 , 002:자재
							stockManagementInVo.setSmItemCd(jsonObject.get("itemIdx").toString()); //품목(제품) 식별자
							stockManagementInVo.setSmItemVersionIdx(jsonObject.get("itemVersionIdx").toString()); //품목(제품) 식별자
							stockManagementInVo.setSmType("입고"); //수불구분
							stockManagementInVo.setSmType2("IQP"); //업무구분
							stockManagementInVo.setSmDate(strToday); //수불일자
							stockManagementInVo.setSmQty( prodQualityVo.getResultQty() ); // 수불수량
							stockManagementInVo.setSmLotNo(""); //LOT번호 -> 채번이라서 빈값넘겨줌
							stockManagementInVo.setSmSourceNo(jsonObject.get("bizOrdDtlNo").toString()); //원천번호 -> 수주번호
							stockManagementInVo.setSmInWhsGubun(""); //창고구분 -> 없음 빈값 
							stockManagementInVo.setSmOutWhsIdx(locationInVo.getIdx()); //창고식별자 
							stockManagementInVo.setSmInWhsIdx(locationInVo.getIdx()); //창고식별자  
				    		
							stockManagementInVo.setSmInGubun("품질적합"); //입고구분
							stockManagementInVo.setSmInCorpIdx(""); //입고처
							stockManagementInVo.setSmInRelationNo(jsonObject.get("bizOrdDtlNo").toString()); //원천번호 -> 수주번호
				    		stockManagementVoInList.add(stockManagementInVo);
				    		//제품입고처리
							stockManagementController.ProdInput(stockManagementVoInList);
				    		
		    			} else if("03".equals(prodQualityVo.getResultCd())) {
		    				//부적합
			    			
		    				List<StockManagementVo> stockManagementVoList = new ArrayList<>();
		    				//제품 qc창고에서 출고
							StockManagementVo stockManagementVo = new StockManagementVo();
							stockManagementVo.setSmItemGubun("001");
				    		stockManagementVo.setSmOutGubun("품질");
				    		stockManagementVo.setSmItemIdx(jsonObject.get("itemIdx").toString());
				    		stockManagementVo.setSmItemVersionIdx(jsonObject.get("itemVersionIdx").toString());
				    		stockManagementVo.setSmCarAssignment(null);
				    		//stockManagementVo.setSmItemCd(jsonObject.get("itemCd").toString());
				    		stockManagementVo.setSmQty(prodQualityVo.getResultQty());
				    		stockManagementVo.setSmDate(strToday);
				    		stockManagementVo.setSmOutCorpIdx(null);
				    		stockManagementVo.setSmStatus("B"); //출고
				    		stockManagementVo.setSmLotNo("");
				    		stockManagementVo.setSmOutRelationNo(jsonObject.get("bizOrdDtlNo").toString()); 
				    		stockManagementVo.setSmOutWhsGubun("");
				    		stockManagementVo.setSmOutWhsIdx(prodLocationVo.getLocationIdx());
				    		stockManagementVo.setSmOutLocIdx(null);
				    		stockManagementVo.setSmEtc1(null);
				    		stockManagementVo.setSmEtc2(null);
				    		stockManagementVo.setSmEtc3(null);
				    		
				    		stockManagementVo.setSmType("출고");
				    		stockManagementVo.setSmType2("OQDP");
				    		stockManagementVo.setSmInWhsGubun("");
				    		stockManagementVo.setSmInWhsIdx(prodLocationVo.getIdx()); 
				    		stockManagementVo.setSmLotNo("");
				    		stockManagementVo.setSmInRelationNo(jsonObject.get("bizOrdDtlNo").toString());
				    		stockManagementVo.setSmDesc("");
				    		stockManagementVo.setSmEtc1("");
				    		stockManagementVo.setSmEtc2("");
				    		stockManagementVo.setSmEtc3("");
				    		stockManagementVoList.add(stockManagementVo);
				    		stockManagementController.ProdOutput(stockManagementVoList);

				    		// 제품 입고 처리 목록
							List<StockManagementVo> stockManagementVoInList = new ArrayList<>();
							
							StockManagementVo stockManagementInVo = new StockManagementVo();
							stockManagementInVo.setSmItemGubun("001"); //001:제품 , 002:자재
							stockManagementInVo.setSmItemCd(jsonObject.get("itemIdx").toString()); //품목(제품) 식별자
							stockManagementInVo.setSmItemVersionIdx(jsonObject.get("itemVersionIdx").toString()); //품목(제품) 식별자
							stockManagementInVo.setSmType("입고"); //수불구분
							stockManagementInVo.setSmType2("IQDP"); //업무구분
							stockManagementInVo.setSmDate(strToday); //수불일자
							stockManagementInVo.setSmQty( prodQualityVo.getResultQty() ); // 수불수량
							stockManagementInVo.setSmLotNo(""); //LOT번호 -> 채번이라서 빈값넘겨줌
							stockManagementInVo.setSmSourceNo(jsonObject.get("bizOrdDtlNo").toString()); //원천번호 -> 수주번호
							stockManagementInVo.setSmInWhsGubun(""); //창고구분 -> 없음 빈값 
							stockManagementInVo.setSmOutWhsIdx(locationDisposalVo.getIdx()); //창고식별자 
							stockManagementInVo.setSmInWhsIdx(locationDisposalVo.getIdx()); //창고식별자  
				    		
							stockManagementInVo.setSmInGubun("품질폐기"); //입고구분
							stockManagementInVo.setSmInCorpIdx(""); //입고처
							stockManagementInVo.setSmInRelationNo(jsonObject.get("bizOrdDtlNo").toString()); //원천번호 -> 수주번호
				    		stockManagementVoInList.add(stockManagementInVo);
				    		//제품입고처리
							stockManagementController.ProdInput(stockManagementVoInList);
		    			}
		    		}
		        }

				jsonData.put("result", "ok");
			}
	       
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//검사성적서 출력
	@RequestMapping(value = "qm/prodQualityPaperUpd", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> prodQualityPaperUpd(ProdQualityVo prodQualityVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("검사성적서 출력");
		try {
			prodQualityVo.setUpdIdx(Utils.getUserIdx());
			prodQualityVo.setUpdDate(DateUtil.getCurrentDateTime());
			prodQualityService.prodQualityPaperUpd(prodQualityVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//제품검사 - 공정불량내역
	@RequestMapping(value = "qm/workFaultyLst", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workFaultyLst(ProdQualityVo prodQualityVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품검사 - 공정불량내역");
		try {
			List<ProdQualityVo> prodQualityVoList = prodQualityService.workFaultyLst(prodQualityVo);
			jsonData.put("data", prodQualityVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
}

