package mes.web.stock;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.binary.StringUtils;
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
import org.springframework.web.servlet.ModelAndView;

import mes.domain.bm.ItemInfoAdmVo;
import mes.domain.bs.BizOrderVo;
import mes.domain.stock.OutProdWhsAdmVo;
import mes.domain.stock.StockManagementVo;
import mes.domain.stock.StockPaymentAdmVo;
import mes.service.bs.BizOrderService;
import mes.service.stock.OutProdWhsAdmService;
import mes.service.stock.StockPaymentAdmService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class OutProdWhsAdmController {
	private static final Logger logger = LoggerFactory.getLogger(OutProdWhsAdmController.class);
	
	@Inject
	private OutProdWhsAdmService outProdWhsAdmService;
	@Inject
	private StockPaymentAdmService stockPaymentAdmService;
	@Inject
	private BizOrderService bizOrderService;
	@Inject
	private StockManagementController stockManagementController;
	
	// iosc0010 페이지
	@RequestMapping(value = "/io/iosc0010", method = RequestMethod.GET)
	public ModelAndView iosc0010(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /io/iosc0010");
		mav.setViewName("/io/iosc0010");
		return mav;
	}
	
	// iosc0020 페이지
	@RequestMapping(value = "/io/iosc0020", method = RequestMethod.GET)
	public ModelAndView iosc0020(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /io/iosc0020");
		mav.setViewName("/io/iosc0020");
		return mav;
	}
	
	// iosc0030 페이지
	@RequestMapping(value = "/io/iosc0030", method = RequestMethod.GET)
	public ModelAndView iosc0030(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /io/iosc0030");
		mav.setViewName("/io/iosc0030");
		return mav;
	}
	
	// iosc0040 페이지
	@RequestMapping(value = "/io/iosc0040", method = RequestMethod.GET)
	public ModelAndView iosc0040(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /io/iosc0040");
		mav.setViewName("/io/iosc0040");
		return mav;
	}
	
	// 제품 출고 리스트 조회(수주) 
	@RequestMapping(value = "stock/bizOrderDtlList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrderDtlList(OutProdWhsAdmVo outProdWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품 출고 리스트 조회");
		try {
			List<OutProdWhsAdmVo> outProdWhsAdmVoList = outProdWhsAdmService.bizOrderDtlList(outProdWhsAdmVo);
			jsonData.put("data", outProdWhsAdmVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 수주의 출고 내역
	@RequestMapping(value = "stock/bizOrderProdOutLst", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrderProdOutLst(OutProdWhsAdmVo outProdWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주의 출고 내역 조회");
		try {
			List<OutProdWhsAdmVo> outProdWhsAdmVoList = outProdWhsAdmService.bizOrderProdOutLst(outProdWhsAdmVo);
			jsonData.put("data", outProdWhsAdmVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 제품 출고등록
	@RequestMapping(value = "stock/outProdWhsAdmIns", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> outProdWhsAdmIns(@RequestParam(value="jsonArray", required=false) String jsonArray) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품 출고등록");
		try {
			JSONParser jsonParser = new JSONParser();
			JSONArray dataArray = (JSONArray) jsonParser.parse(jsonArray);
			
			List<StockManagementVo> stockManagementVoList = new ArrayList<>();
			
			JSONObject jsonObj = new JSONObject();
	        for(int i=0;i<dataArray.size();i++) {
	        	jsonObj.put(i, dataArray.get(i));
	    		JSONObject jsonObject = (JSONObject) jsonParser.parse(jsonObj.get(i).toString());
	    		
	    		StockManagementVo stockManagementVo = new StockManagementVo();
	    		stockManagementVo.setSmItemGubun("001");
	    		stockManagementVo.setSmOutGubun("제품출고");
	    		stockManagementVo.setSmItemIdx(jsonObject.get("itemIdx").toString());
	    		stockManagementVo.setSmItemVersionIdx(jsonObject.get("itemVersionIdx").toString());
	    		stockManagementVo.setSmCarAssignment(jsonObject.get("carAssignment").toString());
	    		stockManagementVo.setSmItemCd(jsonObject.get("itemCd").toString());
	    		stockManagementVo.setSmQty(jsonObject.get("outQty").toString());
	    		stockManagementVo.setSmDate(jsonObject.get("outDate").toString());
	    		stockManagementVo.setSmOutCorpIdx(jsonObject.get("outCorpIdx").toString());
	    		stockManagementVo.setSmStatus("B");
	    		stockManagementVo.setSmLotNo("");
	    		stockManagementVo.setSmOutRelationNo(jsonObject.get("bizOrdDtlNo").toString());
	    		stockManagementVo.setSmOutWhsGubun("");
	    		stockManagementVo.setSmOutWhsIdx(jsonObject.get("whsIdx").toString());
	    		stockManagementVo.setSmOutLocIdx(null);
	    		stockManagementVo.setSmEtc1(jsonObject.get("outProdEtc1").toString());
	    		stockManagementVo.setSmEtc2(jsonObject.get("outProdEtc2").toString());
	    		stockManagementVo.setSmEtc3(jsonObject.get("outProdEtc3").toString());
	    		
	    		
	    		stockManagementVo.setSmType("출고");
	    		stockManagementVo.setSmType2("OP");
	    		stockManagementVo.setSmInWhsGubun("");
	    		stockManagementVo.setSmInWhsIdx(jsonObject.get("whsIdx").toString());
	    		stockManagementVo.setSmLotNo("");
	    		stockManagementVo.setSmInRelationNo(jsonObject.get("bizOrdDtlNo").toString());
	    		stockManagementVo.setSmDesc(jsonObject.get("outDesc").toString());
	    		stockManagementVo.setSmEtc1(jsonObject.get("outProdEtc1").toString());
	    		stockManagementVo.setSmEtc2(jsonObject.get("outProdEtc2").toString());
	    		stockManagementVo.setSmEtc3(jsonObject.get("outProdEtc3").toString());
	    		stockManagementVoList.add(stockManagementVo);
	        }
	        
	        
	        stockManagementController.ProdOutput(stockManagementVoList);
	        
	        //해당 수주의 출고가 완료되면 상태값 업데이트
	        BizOrderVo bizOrderVo = new BizOrderVo();
	        bizOrderVo.setUpdIdx(Utils.getUserIdx());
	        bizOrderVo.setUpdDate(DateUtil.getCurrentDateTime());
	        bizOrderVo.setUpdateJson(jsonArray);
	        bizOrderService.bizOrderDtlStatusUpdWithItemOut(bizOrderVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();	
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
		
	// 제품 출고삭제
	@RequestMapping(value = "stock/outProdWhsAdmDel", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> outProdWhsAdmDel(OutProdWhsAdmVo outProdWhsAdmVo,
										@RequestParam(value="deleteJson", required=false) String jsonArray) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품 출고삭제");
		try {
			//삭제대상인 출고전표들
			List<OutProdWhsAdmVo> outProdLst = outProdWhsAdmService.getOutProdLstByOutNo(outProdWhsAdmVo);
			
			boolean trigger = outProdLst.stream()
						.filter(v-> v.getOutProdEtc4() != null && !"".equals(v.getOutProdEtc4()))
						.count() > 0;
			
			//0보다 큰경우 삭제불가능
			if(trigger) {
				jsonData.put("result", "fail");
				jsonData.put("message", "거래명세서가 출력된 경우<br>삭제 할 수 없습니다.");
			} else {
				JSONParser jsonParser = new JSONParser();
				JSONArray dataArray = (JSONArray) jsonParser.parse(jsonArray);
				JSONObject jsonObj = new JSONObject();
				//제품입고 전표 삭제 JSON 배열
				JSONArray outProd_array = new JSONArray();
				//수불 삭제 JSON배열
				JSONArray stock_array = new JSONArray();
				//업데이트해야할(출고완료, 출고대기 상태로 업데이트할 수주상세번호 JSON배열)
				JSONArray biz_array = new JSONArray();
				//출고전표랑 수불수량 같아서 for문 한번이면됨
	    		for(int i=0;i<dataArray.size();i++) {
		        	jsonObj.put(i, dataArray.get(i));
		    		JSONObject jsonObject = (JSONObject) jsonParser.parse(jsonObj.get(i).toString());
		    		
		    		JSONObject outProdData = new JSONObject();
					JSONObject stockData = new JSONObject();
					JSONObject bizData = new JSONObject();
					
					//업데이트할 수주
					bizData.put("bizOrdDtlNo", jsonObject.get("bizOrdDtlNo").toString());
					biz_array.add(bizData);
					
					outProdData.put("OUT_SLIP_NO", jsonObject.get("outSlipNo").toString());
					outProdData.put("OUT_SLIP_SEQ", jsonObject.get("outSlipSeq").toString());
					outProd_array.add(outProdData);
					
					stockData.put("SP_SOURCE_NO", jsonObject.get("outSlipNo").toString() + "-" + jsonObject.get("outSlipSeq").toString());
					stock_array.add(stockData);
					
	    		}
	    		OutProdWhsAdmVo outProdWhsAdmDisposalVo = new OutProdWhsAdmVo();
	    		outProdWhsAdmDisposalVo.setDeleteJson(outProd_array.toJSONString());
				outProdWhsAdmService.outProdWhsAdmDel(outProdWhsAdmDisposalVo); //제품출고 전표 삭제
				
				StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();
				stockPaymentAdmVo.setDeleteJson(stock_array.toJSONString());
				stockPaymentAdmService.stockPaymentAdmDel(stockPaymentAdmVo); //제품 출고수불 삭제
				
				//해당 수주의 출고완료 / 출고 대기 상태값 업데이트
		        BizOrderVo bizOrderVo = new BizOrderVo();
		        bizOrderVo.setUpdIdx(Utils.getUserIdx());
		        bizOrderVo.setUpdDate(DateUtil.getCurrentDateTime());
		        bizOrderVo.setUpdateJson(biz_array.toJSONString());
		        bizOrderService.bizOrderDtlStatusUpdWithItemOut(bizOrderVo);
				jsonData.put("result", "ok");
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 제품 출고수정
	@RequestMapping(value = "stock/outProdWhsAdmUpd", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> outProdWhsAdmUpd(OutProdWhsAdmVo outProdWhsAdmVo,
																@RequestParam(value="updateJson", required=false) String jsonArray) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품 출고수정");
		try {
			JSONParser jsonParser = new JSONParser();
			JSONArray dataArray = (JSONArray) jsonParser.parse(jsonArray);
			List<StockManagementVo> stockManagementVoList = new ArrayList<>();
			
			//수정대상인 출고전표들
			List<OutProdWhsAdmVo> outProdLst = outProdWhsAdmService.getOutProdLstByOutNo(outProdWhsAdmVo);
			//수정대상인 수불들
			StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();
			stockPaymentAdmVo.setSpSourceNoString(outProdWhsAdmVo.getOutNoString());
			List<StockPaymentAdmVo> stockLst = stockPaymentAdmService.stockLstBySpSourceNo(stockPaymentAdmVo);
			
			boolean trigger = outProdLst.stream()
					.filter(v-> v.getOutProdEtc4() != null && !"".equals(v.getOutProdEtc4()))
					.count() > 0;
		
			if(trigger) {
				jsonData.put("result", "fail");
				jsonData.put("message", "거래명세서가 출력된 경우<br>수정 할 수 없습니다.");
			
			} else {
				JSONObject jsonObj = new JSONObject();
			
				//제품입고 전표 삭제 JSON 배열
				JSONArray outProd_array = new JSONArray();
				//수불 삭제 JSON배열
				JSONArray stock_array = new JSONArray();
				
				//업데이트해야할(출고완료, 출고대기 상태로 업데이트할 수주상세번호 JSON배열)
				JSONArray biz_array = new JSONArray();
				
				//출고전표랑 수불수량 같아서 for문 한번이면됨
	    		for(int i=0;i<dataArray.size();i++) {
		        	jsonObj.put(i, dataArray.get(i));
		    		JSONObject jsonObject = (JSONObject) jsonParser.parse(jsonObj.get(i).toString());
		    		OutProdWhsAdmVo outProdFilterVo = outProdLst.stream()
						    									.filter(v-> StringUtils.equals(jsonObject.get("outSlipNo").toString(), v.getOutSlipNo()) 
						    												&& StringUtils.equals(jsonObject.get("outSlipSeq").toString(), v.getOutSlipSeq()) )
						    									.findAny()
																.orElse(null);
		    		StockPaymentAdmVo stockFilterVo = stockLst.stream()
																.filter(v-> StringUtils.equals(jsonObject.get("outSlipNo").toString() + "-" + jsonObject.get("outSlipSeq").toString(), v.getSpSourceNo()))
																.findAny()
																.orElse(null);					
		    		JSONObject outProdData = new JSONObject();
					JSONObject stockData = new JSONObject();
					JSONObject bizData = new JSONObject();
					//업데이트할 수주
					bizData.put("bizOrdDtlNo", outProdFilterVo.getRelationNo());
					biz_array.add(bizData);
					
					//출고
					outProdData.put("OUT_SLIP_NO", outProdFilterVo.getOutSlipNo());
					outProdData.put("OUT_SLIP_SEQ", outProdFilterVo.getOutSlipSeq());
					outProdData.put("ITEM_GUBUN", outProdFilterVo.getItemGubun());
					outProdData.put("OUT_GUBUN", outProdFilterVo.getOutGubun());
					outProdData.put("ITEM_IDX", outProdFilterVo.getItemIdx());
					outProdData.put("CAR_ASSIGNMENT", outProdFilterVo.getCarAssignment());
					outProdData.put("PRE_OUT_QTY", outProdFilterVo.getPreOutQty());
					outProdData.put("OUT_QTY", jsonObject.get("outQty").toString());
					outProdData.put("REMAIN_QTY", jsonObject.get("outQty").toString());
					outProdData.put("PRE_OUT_DATE", outProdFilterVo.getPreOutDate());
					outProdData.put("OUT_DATE", outProdFilterVo.getOutDate());
					outProdData.put("OUT_CORP_IDX", outProdFilterVo.getOutCorpIdx());
					outProdData.put("OUT_STATUS", outProdFilterVo.getOutStatus());
					outProdData.put("LOT_NO", outProdFilterVo.getLotNo());
					outProdData.put("RELATION_NO", outProdFilterVo.getRelationNo());
					outProdData.put("WHS_GUBUN", outProdFilterVo.getWhsGubun());
					outProdData.put("WHS_IDX", outProdFilterVo.getWhsIdx());
					outProdData.put("LOC_IDX", outProdFilterVo.getLocIdx());
					outProdData.put("OUT_DESC", outProdFilterVo.getOutDesc());
					outProdData.put("OUT_PROD_ETC1", outProdFilterVo.getOutProdEtc1());
					outProdData.put("OUT_PROD_ETC2", outProdFilterVo.getOutProdEtc2());
					outProdData.put("OUT_PROD_ETC3", outProdFilterVo.getOutProdEtc3());
					outProdData.put("OUT_PROD_ETC4", outProdFilterVo.getOutProdEtc4());
					outProdData.put("OUT_PROD_ETC5", outProdFilterVo.getOutProdEtc5());
					outProd_array.add(outProdData);
					
					stockData.put("SP_NO", stockFilterVo.getSpNo());
					stockData.put("SP_SEQ", stockFilterVo.getSpSeq());
					stockData.put("SP_GUBUN", stockFilterVo.getSpGubun());
					stockData.put("SP_IDX", stockFilterVo.getSpIdx());
					stockData.put("SP_TYPE", stockFilterVo.getSpType());
					stockData.put("SP_TYPE2", stockFilterVo.getSpType2());
					stockData.put("SP_DATE", stockFilterVo.getSpDate());
					stockData.put("SP_QTY", jsonObject.get("outQty").toString());
					stockData.put("SP_LOT_NO", stockFilterVo.getSpLotNo());
			        stockData.put("SP_SOURCE_NO", stockFilterVo.getSpSourceNo());
					stockData.put("SP_WHS_GUBUN", stockFilterVo.getSpWhsGubun());
					stockData.put("SP_WHS_IDX", stockFilterVo.getSpWhsIdx());
					stockData.put("SP_LOC_IDX", stockFilterVo.getSpLocIdx());
					stockData.put("SP_DESC", stockFilterVo.getSpDesc());
					stockData.put("SP_ETC1", stockFilterVo.getSpEtc1());
					stockData.put("SP_ETC2", stockFilterVo.getSpEtc2());
					stockData.put("SP_ETC2", stockFilterVo.getSpEtc3());
					stock_array.add(stockData);
					
		        }
	    		OutProdWhsAdmVo outProdWhsAdmDisposalVo = new OutProdWhsAdmVo();
	    		outProdWhsAdmDisposalVo.setDeleteJson(outProd_array.toJSONString());
				outProdWhsAdmService.outProdWhsAdmDel(outProdWhsAdmDisposalVo); //제품출고 전표 삭제
				stockPaymentAdmVo.setDeleteJson(stock_array.toJSONString());
				stockPaymentAdmService.stockPaymentAdmDel(stockPaymentAdmVo); //제품 출고수불 삭제
				
				outProdWhsAdmDisposalVo.setRegIdx(Utils.getUserIdx());
				outProdWhsAdmDisposalVo.setRegDate(DateUtil.getCurrentDateTime());
				outProdWhsAdmDisposalVo.setInsertJson(outProd_array.toJSONString());
				
				stockPaymentAdmVo.setRegIdx(Utils.getUserIdx());
				stockPaymentAdmVo.setRegDate(DateUtil.getCurrentDateTime());
				stockPaymentAdmVo.setInsertJson(stock_array.toJSONString());
				
				outProdWhsAdmService.outProdWhsAdmCompulsionIns(outProdWhsAdmDisposalVo); //제품출고 전표 등록
				stockPaymentAdmService.stockPaymentAdmCompulsionIns(stockPaymentAdmVo); //제품 입,출고수불 등록
				
				//해당 수주의 출고완료 / 출고 대기 상태값 업데이트
		        BizOrderVo bizOrderVo = new BizOrderVo();
		        bizOrderVo.setUpdIdx(Utils.getUserIdx());
		        bizOrderVo.setUpdDate(DateUtil.getCurrentDateTime());
		        bizOrderVo.setUpdateJson(biz_array.toJSONString());
		        bizOrderService.bizOrderDtlStatusUpdWithItemOut(bizOrderVo);
				
				jsonData.put("result", "ok");
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	
	//********************************** 납품계획등록 **********************************
	//납품계획등록 조회
	@RequestMapping(value = "stock/deliveryPlanList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> deliveryPlanList(OutProdWhsAdmVo outProdWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("납품계획등록 조회");
		try {
			List<OutProdWhsAdmVo> outProdWhsAdmVoList = outProdWhsAdmService.deliveryPlanList(outProdWhsAdmVo);
			jsonData.put("data", outProdWhsAdmVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//********************************** 납품계획등록 **********************************
	// 제품 출고내역 조회
	@RequestMapping(value = "stock/outProdDtlList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> outProdDtlList(OutProdWhsAdmVo outProdWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품 출고내역 조회");
		try {
			List<OutProdWhsAdmVo> outProdWhsAdmVoList = outProdWhsAdmService.outProdDtlList(outProdWhsAdmVo);
			jsonData.put("data", outProdWhsAdmVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//원거래명세서출력 번호 발급
	@RequestMapping(value = "stock/tradingStatementUpd", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> tradingStatementUpd(OutProdWhsAdmVo outProdWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("원거래명세서출력 번호 발급");
		try {
			outProdWhsAdmVo.setUpdIdx(Utils.getUserIdx());
			outProdWhsAdmVo.setUpdDate(DateUtil.getCurrentDateTime());
			outProdWhsAdmService.tradingStatementUpd(outProdWhsAdmVo);
			if("Y".equals(outProdWhsAdmVo.getResultYn())) {
				jsonData.put("result", "ok");	
			} else {
				jsonData.put("message", outProdWhsAdmVo.getResMessage());
				jsonData.put("result", "fail");	
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//원거래명세서출력 번호 삭제
	@RequestMapping(value = "stock/tradingStatementDel", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> tradingStatementDel(OutProdWhsAdmVo outProdWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("원거래명세서출력 번호 삭제");
		try {
			outProdWhsAdmVo.setUpdIdx(Utils.getUserIdx());
			outProdWhsAdmVo.setUpdDate(DateUtil.getCurrentDateTime());
			outProdWhsAdmService.tradingStatementDel(outProdWhsAdmVo);
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//bizOrdDtlNo로 번들링 목록 조회
	@RequestMapping(value = "stock/bizOrderDtlBundleListWithBizOrdDtlNo", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrderDtlBundleListWithBizOrdDtlNo(OutProdWhsAdmVo outProdWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("bizOrdDtlNo로 번들링 목록 조회 : " + outProdWhsAdmVo);
		try {
			List<OutProdWhsAdmVo> OutProdWhsAdmList = outProdWhsAdmService.bizOrderDtlBundleListWithBizOrdDtlNo(outProdWhsAdmVo);
			jsonData.put("data", OutProdWhsAdmList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
}
