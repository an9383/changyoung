package mes.web.tm;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import mes.domain.sm.CommonCodeVo;
import mes.domain.stock.OutMatrWhsAdmVo;
import mes.domain.stock.OutProdWhsAdmVo;
import mes.domain.stock.StockManagementVo;
import mes.domain.stock.StockPaymentAdmVo;
import mes.service.bm.ItemInfoAdmService;
import mes.service.stock.StockPaymentAdmService;
import mes.web.stock.StockManagementController;
import mes.web.ut.Utils;

@Controller
public class StockStatusController {
	
	private static final Logger logger = LoggerFactory.getLogger(StockStatusController.class);
	
	// tmsc0010 페이지
	@RequestMapping(value = "/tm/tmsc0010", method = RequestMethod.GET)
	public ModelAndView tmsc0010(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /tm/tmsc0010");
		mav.setViewName("/tm/tmsc0010");
		return mav;
	}
	
	// tmsc0020 페이지
	@RequestMapping(value = "/tm/tmsc0020", method = RequestMethod.GET)
	public ModelAndView tmsc0020(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /tm/tmsc0020");
		mav.setViewName("/tm/tmsc0020");
		return mav;
	}
	
	// tmsc0030 페이지
	@RequestMapping(value = "/tm/tmsc0030", method = RequestMethod.GET)
	public ModelAndView tmsc0030(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /tm/tmsc0030");
		mav.setViewName("/tm/tmsc0030");
		return mav;
	}
	
	// tmsc0040 페이지
	@RequestMapping(value = "/tm/tmsc0040", method = RequestMethod.GET)
	public ModelAndView tmsc0040(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /tm/tmsc0040");
		mav.setViewName("/tm/tmsc0040");
		return mav;
	}
	
	// tmsc0050 페이지
	@RequestMapping(value = "/tm/tmsc0050", method = RequestMethod.GET)
	public ModelAndView tmsc0050(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /tm/tmsc0050");
		mav.setViewName("/tm/tmsc0050");
		return mav;
	}
	
	// tmsc0060 페이지
	@RequestMapping(value = "/tm/tmsc0060", method = RequestMethod.GET)
	public ModelAndView tmsc0060(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /tm/tmsc0060");
		mav.setViewName("/tm/tmsc0060");
		return mav;
	}
	
	// tmsc0070 페이지
	@RequestMapping(value = "/tm/tmsc0070", method = RequestMethod.GET)
	public ModelAndView tmsc0070(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /tm/tmsc0070");
		mav.setViewName("/tm/tmsc0070");
		return mav;
	}
	
	// tmsc0080 페이지
	@RequestMapping(value = "/tm/tmsc0080", method = RequestMethod.GET)
	public ModelAndView tmsc0080(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /tm/tmsc0080");
		mav.setViewName("/tm/tmsc0080");
		return mav;
	}
	
	// tmsc0090 페이지
	@RequestMapping(value = "/tm/tmsc0090", method = RequestMethod.GET)
	public ModelAndView tmsc0090(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /tm/tmsc0090");
		mav.setViewName("/tm/tmsc0090");
		return mav;
	}
	
	@Inject
	private StockManagementController stockManagementController;
	@Inject
	private StockPaymentAdmService stockPaymentAdmService;
	
	//재고이동처리
	@RequestMapping(value = "stock/stockMoveIns", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> stockMoveIns(StockPaymentAdmVo stockPaymentAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("재고이동처리");
		try {
			//파싱
			String insertJson = stockPaymentAdmVo.getInsertJson();
			JSONParser jsonParser = new JSONParser();
			JSONArray dataArray = (JSONArray) jsonParser.parse(insertJson);
			JSONObject jsonObj = new JSONObject();
			
			// 자재출고 처리 목록
			List<StockManagementVo> stockManagementVoList = new ArrayList<>();
			for(int i = 0; i < dataArray.size(); i++) {
				StockManagementVo stockManagementVo = new StockManagementVo();
				jsonObj.put(i, dataArray.get(i));
	    		JSONObject jsonObject = (JSONObject) jsonParser.parse(jsonObj.get(i).toString());
	    		
				stockManagementVo.setSmItemGubun(jsonObject.get("SP_GUBUN").toString()); //001:제품 , 002:자재
				stockManagementVo.setSmItemCd(jsonObject.get("SP_IDX").toString()); //품목(자재) 식별자
				stockManagementVo.setSmItemVersionIdx(jsonObject.get("VERSION_IDX").toString()); //품목(자재) 식별자
	    		stockManagementVo.setSmDate(jsonObject.get("SP_DATE").toString()); //수불일자
	    		stockManagementVo.setSmQty(jsonObject.get("SP_QTY").toString()); // 수불수량
	    		stockManagementVo.setSmLotNo(""); //LOT번호 -> 채번이라서 빈값넘겨줌
	    		stockManagementVo.setSmSourceNo(""); //원천번호 없음 재고이동이라
	    		stockManagementVo.setSmOutWhsGubun(""); //창고구분 -> 없음 빈값 
	    		stockManagementVo.setSmInWhsGubun(""); //창고구분 -> 없음 빈값 
	    		stockManagementVo.setSmOutRelationNo(jsonObject.get("RELATION_NO").toString()); //연관번호(수주상세식별자)
	    		stockManagementVo.setSmInRelationNo(jsonObject.get("RELATION_NO").toString()); //연관번호(수주상세식별자)
	    		stockManagementVo.setSmOutWhsIdx(jsonObject.get("OUT_SP_WHS_IDX").toString()); //출고창고식별자
	    		stockManagementVo.setSmInWhsIdx(jsonObject.get("IN_SP_WHS_IDX").toString()); //입고창고식별자  
	    		stockManagementVo.setSmOutLocIdx(""); //위치식별자 -> 안씀 빈값
	    		stockManagementVo.setSmInLocIdx(""); //위치식별자 -> 안씀 빈값
				stockManagementVoList.add(stockManagementVo);	
				
			}
			//자재출고처리
			stockManagementController.StockMove(stockManagementVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//재고이동 체크 
	@RequestMapping(value = "stock/stockMoveYnCheckByBizOrdDtlIdx", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> stockMoveYnCheckByBizOrdDtlIdx(StockPaymentAdmVo stockPaymentAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("재고이동 체크 ");
		try {
			stockPaymentAdmService.stockMoveYnCheckByBizOrdDtlIdx(stockPaymentAdmVo);
			if("Y".equals(stockPaymentAdmVo.getResultYn())) {
				jsonData.put("result", "ok");
			} else {
				jsonData.put("message", stockPaymentAdmVo.getResultMes());
				jsonData.put("result", "fail");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
		
}
