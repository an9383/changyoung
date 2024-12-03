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

import mes.domain.stock.InMatrWhsAdmVo;
import mes.domain.stock.StockManagementVo;
import mes.domain.stock.StockPaymentAdmVo;
import mes.service.stock.InMatrWhsAdmService;
import mes.service.stock.StockPaymentAdmService;
import mes.web.ut.Utils;

@Controller
public class InMatrWhsAdmController {
	private static final Logger logger = LoggerFactory.getLogger(InMatrWhsAdmController.class);
	
	@Inject
	private InMatrWhsAdmService inMatrWhsAdmService;
	@Inject
	private StockPaymentAdmService stockPaymentAdmService;
	@Inject
	private StockManagementController stockManagementController;
	
	// 자재 입고전표 목록조회
	@RequestMapping(value = "stock/inMatrWhsAdmLst", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> inMatrWhsAdmLst(InMatrWhsAdmVo inMatrWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("자재 입고전표 목록조회");
		try {
			List<InMatrWhsAdmVo> inMatrWhsAdmVoList = inMatrWhsAdmService.inMatrWhsAdmLst(inMatrWhsAdmVo);
			jsonData.put("data", inMatrWhsAdmVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 자재 입고전표 연관변호별 목록조회
	@RequestMapping(value = "stock/inMatrWhsAdmLstByRelationNo", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> inMatrWhsAdmLstByRelationNo(InMatrWhsAdmVo inMatrWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("자재 입고전표 연관변호별 목록조회");
		try {
			List<InMatrWhsAdmVo> inMatrWhsAdmVoList = inMatrWhsAdmService.inMatrWhsAdmLstByRelationNo(inMatrWhsAdmVo);
			jsonData.put("data", inMatrWhsAdmVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 자재 입고등록
	@RequestMapping(value = "stock/inMatrWhsAdmIU", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> inMatrWhsAdmIU(@RequestParam(value="jsonArray", required=false) String jsonArray) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("자재 입고등록");
		try {
			JSONParser jsonParser = new JSONParser();
			JSONArray dataArray = (JSONArray) jsonParser.parse(jsonArray);
			
			List<StockManagementVo> stockManagementVoList = new ArrayList<>();
			
			JSONObject jsonObj = new JSONObject();
	        for(int i=0;i<dataArray.size();i++) {
	        	jsonObj.put(i, dataArray.get(i));
	    		JSONObject jsonObject = (JSONObject) jsonParser.parse(jsonObj.get(i).toString());
	    		
	    		StockManagementVo stockManagementVo = new StockManagementVo();
	    		stockManagementVo.setSmNo(jsonObject.get("inSlipNo").toString());
	    		stockManagementVo.setSmSeq(jsonObject.get("inSlipSeq").toString());
	    		stockManagementVo.setSmQty(jsonObject.get("inQty").toString());
	    		stockManagementVo.setSmDate(jsonObject.get("inDate").toString());
	    		stockManagementVo.setSmItemGubun(jsonObject.get("itemGubun").toString());
	    		stockManagementVo.setSmItemIdx(jsonObject.get("matrlIdx").toString());
	    		//정상
	    		if("01".equals(jsonObject.get("inMatrEtc1").toString())) {
	    			stockManagementVo.setSmInGubun("자재입고");	
	    		} else {
	    			//부적합
	    			stockManagementVo.setSmInGubun("부적합자재입고");
	    		}
	    		
	    		stockManagementVo.setSmType("입고");
	    		stockManagementVo.setSmType2("IM");
	    		stockManagementVo.setSmInWhsGubun(jsonObject.get("whsGubun").toString());
	    		stockManagementVo.setSmInWhsIdx(jsonObject.get("whsIdx").toString());
	    		stockManagementVo.setSmLotNo(jsonObject.get("lotNo").toString());
	    		stockManagementVo.setSmInRelationNo(jsonObject.get("purchaseOrdNo").toString());
	    		stockManagementVo.setSmDesc(jsonObject.get("inDesc").toString());
	    		stockManagementVo.setSmEtc1(jsonObject.get("inMatrEtc1").toString());
	    		stockManagementVo.setSmEtc2(jsonObject.get("inMatrEtc2").toString());
	    		stockManagementVo.setSmEtc3(jsonObject.get("inMatrEtc3").toString());
	    		stockManagementVoList.add(stockManagementVo);
	        }
	        
	        stockManagementController.MatrInputOnly(stockManagementVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 자재 입고삭제
	@RequestMapping(value = "stock/inMatrWhsAdmDel", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> inMatrWhsAdmDel(InMatrWhsAdmVo inMatrWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("자재 입고삭제");
		try {
			inMatrWhsAdmService.inMatrWhsAdmDel(inMatrWhsAdmVo); // 자재 입고 삭제
			
			StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();
			//수불 삭제 JSON배열
			JSONArray stockDel_array = new JSONArray();
			JSONObject stockData = new JSONObject();
			stockData.put("SP_SOURCE_NO", inMatrWhsAdmVo.getSpSourceNo());
			stockDel_array.add(stockData);
			stockPaymentAdmVo.setDeleteJson(stockDel_array.toJSONString());
			stockPaymentAdmService.stockPaymentAdmDel(stockPaymentAdmVo); // 자재 수불 삭제
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
}
