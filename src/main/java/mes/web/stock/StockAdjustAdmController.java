package mes.web.stock;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import mes.domain.sm.CommonCodeVo;
import mes.domain.stock.StockAdjustAdmVo;
import mes.domain.stock.StockManagementVo;
import mes.domain.stock.StockPaymentAdmVo;
import mes.service.stock.StockAdjustAdmService;
import mes.service.stock.StockPaymentAdmService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class StockAdjustAdmController {
	private static final Logger logger = LoggerFactory.getLogger(StockAdjustAdmController.class);
	
	@Inject
	private StockAdjustAdmService stockAdjustAdmService;
	@Inject
	private StockManagementController stockManagementController;
	
	// 초기재고 목록 조회
	@RequestMapping(value = "stock/stockAdjustAdmListBySaNo", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> stockAdjustAdmListBySaNo(StockAdjustAdmVo stockAdjustAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("초기재고 목록조회");
		try {
			List<StockAdjustAdmVo> stockAdjustAdmVoList = stockAdjustAdmService.stockAdjustAdmListBySaNo(stockAdjustAdmVo);
			jsonData.put("data", stockAdjustAdmVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 초기재고 목록 조회
	@RequestMapping(value = "stock/stockAdjustAdmListGroupBySaNo", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> stockAdjustAdmListGroupBySaNo(StockAdjustAdmVo stockAdjustAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("초기재고 목록조회");
		try {
			List<StockAdjustAdmVo> stockAdjustAdmVoList = stockAdjustAdmService.stockAdjustAdmListGroupBySaNo(stockAdjustAdmVo);
			jsonData.put("data", stockAdjustAdmVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 초기재고/재고조정 등록
	@RequestMapping(value = "stock/stockAdjustAdmIns", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> stockAdjustAdmIns(StockAdjustAdmVo stockAdjustAdmVo,
																@RequestParam(value="jsonArray", required=false) String jsonArray) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("초기재고/재고조정 등록");
		try {
			JSONParser jsonParser = new JSONParser();
			JSONArray dataArray = (JSONArray) jsonParser.parse(jsonArray);
			JSONObject jsonObj = new JSONObject();
			
			List<StockManagementVo> stockManagementVoList = new ArrayList<>();
	        for(int i=0;i<dataArray.size();i++) {
	        	jsonObj.put(i, dataArray.get(i));
	    		JSONObject jsonObject = (JSONObject) jsonParser.parse(jsonObj.get(i).toString());
	    		
	    		StockManagementVo stockManagementVo = new StockManagementVo();
	    		stockManagementVo.setSmType(jsonObject.get("saType").toString());
	    		stockManagementVo.setSmItemGubun(jsonObject.get("saGubun").toString());
	    		stockManagementVo.setSmItemCd(jsonObject.get("saCd").toString());
	    		stockManagementVo.setSmItemVersionIdx(jsonObject.get("itemVerIdx").toString());
	    		stockManagementVo.setSmCmptQty(jsonObject.get("saCmptQty").toString());
	    		stockManagementVo.setSmRealQty(jsonObject.get("saRealQty").toString());
	    		stockManagementVo.setSmDiffQty(jsonObject.get("saDiffQty").toString());
	    		stockManagementVo.setSmAppdDate(jsonObject.get("saAppdDate").toString());
	    		stockManagementVo.setSmInWhsGubun("");//창고구분 없음
	    		stockManagementVo.setSmInWhsIdx(jsonObject.get("saWhsIdx").toString());
	    		stockManagementVo.setSmInLocIdx(jsonObject.get("saLocIdx").toString());
	    		stockManagementVo.setSmDesc(jsonObject.get("saDesc").toString());
	    		stockManagementVoList.add(stockManagementVo);
	        }
	        stockManagementController.adjustmentStockInput(stockManagementVoList);
	        jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 초기재고/재고조정 등록 및 반영
	@RequestMapping(value = "stock/adjustmentStockInputAndApply", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> adjustmentStockInputAndApply(StockAdjustAdmVo stockAdjustAdmVo,
																@RequestParam(value="jsonArray", required=false) String jsonArray) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("초기재고/재고조정 등록 및 반영");
		try {
			JSONParser jsonParser = new JSONParser();
			JSONArray dataArray = (JSONArray) jsonParser.parse(jsonArray);
			JSONObject jsonObj = new JSONObject();
			
			List<StockManagementVo> stockManagementVoList = new ArrayList<>();
	        for(int i=0;i<dataArray.size();i++) {
	        	jsonObj.put(i, dataArray.get(i));
	    		JSONObject jsonObject = (JSONObject) jsonParser.parse(jsonObj.get(i).toString());
	    		
	    		StockManagementVo stockManagementVo = new StockManagementVo();
	    		stockManagementVo.setSmType(jsonObject.get("saType").toString());
	    		stockManagementVo.setSmItemGubun(jsonObject.get("saGubun").toString());
	    		stockManagementVo.setSmItemCd(jsonObject.get("saCd").toString());
	    		stockManagementVo.setSmItemVersionIdx(jsonObject.get("itemVerIdx").toString());
	    		stockManagementVo.setSmCmptQty(jsonObject.get("saCmptQty").toString());
	    		stockManagementVo.setSmRealQty(jsonObject.get("saRealQty").toString());
	    		stockManagementVo.setSmDiffQty(jsonObject.get("saDiffQty").toString());
	    		stockManagementVo.setSmAppdDate(jsonObject.get("saAppdDate").toString());
	    		stockManagementVo.setSmInWhsGubun("");//창고구분 없음
	    		stockManagementVo.setSmInWhsIdx(jsonObject.get("saWhsIdx").toString());
	    		stockManagementVo.setSmInLocIdx(jsonObject.get("saLocIdx").toString());
	    		stockManagementVo.setSmDesc(jsonObject.get("saDesc").toString());
	    		stockManagementVoList.add(stockManagementVo);
	        }
	        stockManagementController.adjustmentStockInputAndApply(stockManagementVoList);
	        jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 초기재고/재고조정 수정
	@RequestMapping(value = "stock/stockAdjustAdmUpd", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> stockAdjustAdmUpd(StockAdjustAdmVo stockAdjustAdmVo,
																@RequestParam(value="jsonArray", required=false) String jsonArray) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("초기재고/재고조정 수정");
		try {
			JSONParser jsonParser = new JSONParser();
			JSONArray dataArray = (JSONArray) jsonParser.parse(jsonArray);
			JSONObject jsonObj = new JSONObject();
			
			//재고반영 리스트
			List<StockManagementVo> stockManagementVoApplyList = new ArrayList<>();
			//재고반영 취소 리스트
			List<StockManagementVo> stockManagementVoCancelList = new ArrayList<>();
	        for(int i=0;i<dataArray.size();i++) {
	        	jsonObj.put(i, dataArray.get(i));
	    		JSONObject jsonObject = (JSONObject) jsonParser.parse(jsonObj.get(i).toString());
	    		
	    		StockManagementVo stockManagementVo = new StockManagementVo();
	    		stockManagementVo.setSmType(jsonObject.get("saType").toString());
	    		stockManagementVo.setSmNo(jsonObject.get("saNo").toString());
	    		stockManagementVo.setSmSeq(jsonObject.get("saSeq").toString());
	    		stockManagementVo.setSmAppdYn(jsonObject.get("saAppdYn").toString());
	    		
	    		stockManagementVo.setSmItemGubun(jsonObject.get("saGubun").toString());
	    		stockManagementVo.setSmItemCd(jsonObject.get("saCd").toString());
	    		stockManagementVo.setSmItemVersionIdx(jsonObject.get("itemVerIdx").toString());
	    		stockManagementVo.setSmCmptQty(jsonObject.get("saCmptQty").toString());
	    		stockManagementVo.setSmRealQty(jsonObject.get("saRealQty").toString());
	    		stockManagementVo.setSmDiffQty(jsonObject.get("saDiffQty").toString());
	    		stockManagementVo.setSmAppdDate(jsonObject.get("saAppdDate").toString());
	    		stockManagementVo.setSmInWhsGubun("");//창고구분 없음
	    		stockManagementVo.setSmInWhsIdx(jsonObject.get("saWhsIdx").toString());
	    		stockManagementVo.setSmInLocIdx(jsonObject.get("saLocIdx").toString());
	    		stockManagementVo.setSmDesc(jsonObject.get("saDesc").toString());
	    		
	    		if("Y".equals(jsonObject.get("saAppdYn").toString())) {
	    			stockManagementVoApplyList.add(stockManagementVo);
	    		} else if("N".equals(jsonObject.get("saAppdYn").toString())){
	    			stockManagementVoCancelList.add(stockManagementVo);
	    		}
	        }
	        //재고반영
	        stockManagementController.adjustmentStockApply(stockManagementVoApplyList);
	        //재고반영취소
	        stockManagementController.adjustmentStockCancle(stockManagementVoCancelList);
	        
	        jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 초기재고/재고조정 삭제
	@RequestMapping(value = "stock/stockAdjustAdmDel", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> stockAdjustAdmDel(StockAdjustAdmVo stockAdjustAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("초기재고/재고조정 삭제");
		try {
			stockAdjustAdmService.stockAdjustAdmDel(stockAdjustAdmVo);
			if("Y".equals(stockAdjustAdmVo.getResultYn())) {
				jsonData.put("result", "ok");
			} else {
				jsonData.put("result", "fail");
				jsonData.put("message", stockAdjustAdmVo.getResMessage());
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
}
