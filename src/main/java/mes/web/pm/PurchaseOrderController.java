package mes.web.pm;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import mes.domain.pm.PurchaseOrderVo;
import mes.service.pm.PurchaseOrderService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class PurchaseOrderController {
	
	@Inject
	private PurchaseOrderService purchaseOrderService;
	
	private static final Logger logger = LoggerFactory.getLogger(PurchaseOrderController.class);
	
	// pmsc0010 페이지
	@RequestMapping(value = "/pm/pmsc0010", method = RequestMethod.GET)
	public ModelAndView pmsc0010(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /pm/pmsc0010");
		mav.setViewName("/pm/pmsc0010");
		return mav;
	}
	
	// pmsc0020 페이지
	@RequestMapping(value = "/pm/pmsc0020", method = RequestMethod.GET)
	public ModelAndView pmsc0020(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /pm/pmsc0020");
		mav.setViewName("/pm/pmsc0020");
		return mav;
	}
	
	// pmsc0030 페이지
	@RequestMapping(value = "/pm/pmsc0030", method = RequestMethod.GET)
	public ModelAndView pmsc0030(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /pm/pmsc0030");
		mav.setViewName("/pm/pmsc0030");
		return mav;
	}
	
	// pmsc0040 페이지
	@RequestMapping(value = "/pm/pmsc0040", method = RequestMethod.GET)
	public ModelAndView pmsc0040(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /pm/pmsc0040");
		mav.setViewName("/pm/pmsc0040");
		return mav;
	}
	
	// pmsc0050 페이지
	@RequestMapping(value = "/pm/pmsc0050", method = RequestMethod.GET)
	public ModelAndView pmsc0050(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /pm/pmsc0050");
		mav.setViewName("/pm/pmsc0050");
		return mav;
	}
	
	// pmsc0060 페이지
	@RequestMapping(value = "/pm/pmsc0060", method = RequestMethod.GET)
	public ModelAndView pmsc0060(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /pm/pmsc0060");
		mav.setViewName("/pm/pmsc0060");
		return mav;
	}
	
	// pmsc0070 페이지
	@RequestMapping(value = "/pm/pmsc0070", method = RequestMethod.GET)
	public ModelAndView pmsc0070(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /pm/pmsc0070");
		mav.setViewName("/pm/pmsc0070");
		return mav;
	}
	
	// pmsc0080 페이지
	@RequestMapping(value = "/pm/pmsc0080", method = RequestMethod.GET)
	public ModelAndView pmsc0080(ModelAndView mav, HttpServletRequest request, Model model) {
		logger.info("page : /pm/pmsc0080");
		mav.setViewName("/pm/pmsc0080");
			
		List<String> list = new ArrayList<String>();
		
		for(int i=0; i>-12; i--) {
			
			Calendar cal = Calendar.getInstance();
			String format = "yyyy-MM-dd";
			SimpleDateFormat sdf = new SimpleDateFormat(format);
			cal.add(cal.MONTH, i);
			String date = sdf.format(cal.getTime()).substring(5,7);
			logger.info(i*-1+"달전:"+date);
			
			list.add(i*-1,"m"+(!date.equals("10")?date.replace("0", ""):date));
		//[08, 07, 06, 05, 04, 03, 02, 01, 12, 11, 10, 09]
		}
		
		logger.info("list:"+list);
		model.addAttribute("dayList", list);
		
		return mav;
	}

	
	// =========================== 발주관리 메인 ==========================================
	// 발주관리 메인 목록조회
	@RequestMapping(value = "pm/purchaseOrderAdmLst", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrderAdmLst(PurchaseOrderVo purchaseOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("발주관리 메인 목록조회");
		try {
			List<PurchaseOrderVo> purchaseOrderVoList = purchaseOrderService.purchaseOrderAdmLst(purchaseOrderVo);
			jsonData.put("data", purchaseOrderVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 발주관리 발주서번호별 목록조회
	@RequestMapping(value = "pm/purchaseOrderAdmLstByPurchasePrintNo", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> purchaseOrderAdmLstByPurchasePrintNo(PurchaseOrderVo purchaseOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("발주관리 발주서번호별 목록조회");
		try {
			List<PurchaseOrderVo> purchaseOrderVoList = purchaseOrderService.purchaseOrderAdmLstByPurchasePrintNo(purchaseOrderVo);
			jsonData.put("data", purchaseOrderVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 발주관리 수주상세식별자별 목록조회
	@RequestMapping(value = "pm/purchaseOrderAdmLstByBizDtlIdx", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> purchaseOrderAdmLstByBizDtlIdx(PurchaseOrderVo purchaseOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("발주관리 수주상세식별자별 목록조회");
		try {
			List<PurchaseOrderVo> purchaseOrderVoList = purchaseOrderService.purchaseOrderAdmLstByBizDtlIdx(purchaseOrderVo);
			jsonData.put("data", purchaseOrderVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 발주관리 발주서번호별 입고 상세 목록조회
	@RequestMapping(value = "pm/purchaseOrderDtlLstByPurchasePrintNo", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> purchaseOrderDtlLstByPurchasePrintNo(PurchaseOrderVo purchaseOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("발주관리 발주서번호별 입고 상세 목록조회");
		try {
			List<PurchaseOrderVo> purchaseOrderVoList = purchaseOrderService.purchaseOrderDtlLstByPurchasePrintNo(purchaseOrderVo);
			jsonData.put("data", purchaseOrderVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 발주관리 수주별 목록조회
	@RequestMapping(value = "pm/purchaseOrderAdmLstByBizDtl", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> purchaseOrderAdmLstByBizDtl(PurchaseOrderVo purchaseOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("발주관리 메인 목록조회");
		try {
			List<PurchaseOrderVo> purchaseOrderVoList = purchaseOrderService.purchaseOrderAdmLstByBizDtl(purchaseOrderVo);
			jsonData.put("data", purchaseOrderVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 발주관리 공정별 목록조회
	@RequestMapping(value = "pm/purchaseOrderAdmLstByWorkOrdPrcss", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> purchaseOrderAdmLstByWorkOrdPrcss(PurchaseOrderVo purchaseOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("발주관리 공정별 목록조회");
		try {
			List<PurchaseOrderVo> purchaseOrderVoList = purchaseOrderService.purchaseOrderAdmLstByWorkOrdPrcss(purchaseOrderVo);
			jsonData.put("data", purchaseOrderVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 발주관리 개별발주 목록조회
	@RequestMapping(value = "pm/purchaseOrderAdmLstBySingle", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> purchaseOrderAdmLstBySingle(PurchaseOrderVo purchaseOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("발주관리 개별발주 목록조회");
		try {
			List<PurchaseOrderVo> purchaseOrderVoList = purchaseOrderService.purchaseOrderAdmLstBySingle(purchaseOrderVo);
			jsonData.put("data", purchaseOrderVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 발주관리 메인 상세조회
	@RequestMapping(value = "pm/purchaseOrderAdmSel", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> purchaseOrderAdmSel(PurchaseOrderVo purchaseOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("발주관리 메인 상세조회");
		try {
			purchaseOrderVo = purchaseOrderService.purchaseOrderAdmSel(purchaseOrderVo);
			jsonData.put("data", purchaseOrderVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 발주관리 메인 등록/수정
	@RequestMapping(value = "pm/purchaseOrderAdmIU", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> purchaseOrderAdmIU(@RequestParam(value="jsonArray", required=false) String jsonArray) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("발주관리 메인 등록/수정");
		try {
			JSONParser jsonParser = new JSONParser();
			JSONArray dataArray = (JSONArray) jsonParser.parse(jsonArray);
			
			List<PurchaseOrderVo> purchaseOrderVoList = new ArrayList<>();
			
			JSONObject jsonObj = new JSONObject();
	        for(int i=0;i<dataArray.size();i++) {
	        	jsonObj.put(i, dataArray.get(i));
	    		JSONObject jsonObject = (JSONObject) jsonParser.parse(jsonObj.get(i).toString());
	    		
	    		PurchaseOrderVo purchaseOrderVo = new PurchaseOrderVo();
	    		purchaseOrderVo.setIdx(jsonObject.get("idx").toString());
	    		purchaseOrderVo.setMatrlIdx(jsonObject.get("matrlIdx").toString());
	    		purchaseOrderVo.setBizOrdDtlIdx(jsonObject.get("bizOrdDtlIdx").toString());
	    		purchaseOrderVo.setPurchaseOrdNo(jsonObject.get("purchaseOrdNo").toString());
	    		purchaseOrderVo.setCutQty(jsonObject.get("cutQty").toString());
	    		purchaseOrderVo.setEaQty(jsonObject.get("eaQty").toString());
	    		purchaseOrderVo.setExtraQty(jsonObject.get("extraQty").toString());
	    		purchaseOrderVo.setExtraPackQty(jsonObject.get("extraPackQty").toString());
	    		purchaseOrderVo.setPurchaseOrdQty(jsonObject.get("purchaseOrdQty").toString());
	    		purchaseOrderVo.setPurchaseOrdDate(jsonObject.get("purchaseOrdDate").toString());
	    		purchaseOrderVo.setPurchaseInDueDate(jsonObject.get("purchaseInDueDate").toString());
	    		purchaseOrderVo.setDealCorpIdx(jsonObject.get("dealCorpIdx").toString());
	    		purchaseOrderVo.setConfirmYn(jsonObject.get("confirmYn").toString());
	    		purchaseOrderVo.setPrintYn(jsonObject.get("printYn").toString());
	    		purchaseOrderVo.setPurchaseNote("");
	    		purchaseOrderVo.setPurchaseDesc(jsonObject.get("purchaseDesc").toString());
	    		purchaseOrderVo.setPurchaseOrdIdxList(jsonObject.get("purchaseOrdIdxList").toString());
	    		purchaseOrderVo.setUpdIdx(Utils.getUserIdx());
	    		purchaseOrderVo.setUpdDate(DateUtil.getCurrentDateTime());
	    		purchaseOrderVo.setRegIdx(Utils.getUserIdx());
	    		purchaseOrderVo.setRegDate(DateUtil.getCurrentDateTime());
	    		
	    		purchaseOrderVoList.add(purchaseOrderVo);
	        }
	        
	        boolean Check = true;
	        String resMessage = ""; 
	        for(int i=0;i<purchaseOrderVoList.size();i++) {
	        	if(purchaseOrderVoList.get(i).getIdx().equals("")) { // 등록
	        		
	        		//합친 발주들의 리스트
	        		String purchaseOrdIdxList = purchaseOrderVoList.get(i).getPurchaseOrdIdxList();
	        		logger.info("purchaseOrdIdxList : "+purchaseOrdIdxList);
	        		purchaseOrdIdxList = purchaseOrdIdxList.replaceAll("\\[", "").replaceAll("\\]", "").replaceAll("\"", "");
	        		logger.info("purchaseOrdIdxList : "+purchaseOrdIdxList);
	        		String[] array = purchaseOrdIdxList.split(",");
	        		
	        		JSONArray jsonarr = new JSONArray();
	        		
	        		for(int j=0;j<array.length;j++) {
	        			JSONObject data = new JSONObject();
	        			data.put("idx", array[j]);
	        			jsonarr.add(data);
	        		}
	        		logger.info("jsonarr : "+jsonarr);
	        		PurchaseOrderVo purchaseOrderCheckVo = new PurchaseOrderVo();
	        		purchaseOrderCheckVo.setPurchaseOrdIdxJson(jsonarr.toString());
	        		purchaseOrderService.purchaseOrderAdmUpdCheckByBizOrdDtlIdxJson(purchaseOrderCheckVo);
	        		
	        		if("Y".equals(purchaseOrderCheckVo.getResultYn())) {
		        		String idx = purchaseOrderService.purchaseOrderAdmIns(purchaseOrderVoList.get(i));
		        		logger.info("idx : "+idx);        		
		        				        		
		        		for(int j=0;j<array.length;j++) {
		        			PurchaseOrderVo purchaseOrderUpdateVo = new PurchaseOrderVo();
		        			purchaseOrderUpdateVo.setIdx(array[j]);
		        			purchaseOrderUpdateVo.setMergeIdx(idx);
		        			purchaseOrderUpdateVo.setUpdIdx(Utils.getUserIdx());
		        			purchaseOrderUpdateVo.setUpdDate(DateUtil.getCurrentDateTime());
		        			purchaseOrderService.purchaseOrderAdmUpd(purchaseOrderUpdateVo);
		        		}
	        		} else {
	        			Check = false;
	        			resMessage = purchaseOrderCheckVo.getResMessage();
	        		}
	        	} else { // 수정
	        		purchaseOrderService.purchaseOrderAdmUpd(purchaseOrderVoList.get(i));
	        	}
	        }
	        if(Check) {
	        	jsonData.put("result", "ok");
	        } else {
	        	jsonData.put("result", "fail");
	        	jsonData.put("message", resMessage);
	        }
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 발주관리 메인 수정
	@RequestMapping(value = "pm/purchaseOrderAdmUpd", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> purchaseOrderAdmUpd(PurchaseOrderVo purchaseOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("발주관리 메인 수정");
		try {
			purchaseOrderVo.setUpdIdx(Utils.getUserIdx());
			purchaseOrderVo.setUpdDate(DateUtil.getCurrentDateTime());
			purchaseOrderService.purchaseOrderAdmUpd(purchaseOrderVo);
			if("Y".equals(purchaseOrderVo.getSuccessYn())){
				jsonData.put("result", "ok");
			} else {
				jsonData.put("message", purchaseOrderVo.getResMessage());
				jsonData.put("result", "fail");
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 발주관리 메인 수정/삭제 체크
	@RequestMapping(value = "pm/purchaseOrderAdmUpdCheckByBizOrdDtlIdx", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> purchaseOrderAdmUpdCheckByBizOrdDtlIdx(PurchaseOrderVo purchaseOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("발주관리 메인 수정/삭제 체크");
		try {
			PurchaseOrderVo returnVo = new PurchaseOrderVo();
			purchaseOrderService.purchaseOrderAdmUpdCheckByBizOrdDtlIdx(purchaseOrderVo);
			if("Y".equals(purchaseOrderVo.getResultYn())){
				jsonData.put("result", "ok");
			} else {
				jsonData.put("message", purchaseOrderVo.getResMessage());
				jsonData.put("result", "fail");
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 발주관리 입고예정일 수정
	@RequestMapping(value = "pm/purchaseOrderInDueDateAdmUpd", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> purchaseOrderInDueDateAdmUpd(PurchaseOrderVo purchaseOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("발주관리 입고예정일 수정");
		try {
			purchaseOrderVo.setUpdIdx(Utils.getUserIdx());
			purchaseOrderVo.setUpdDate(DateUtil.getCurrentDateTime());
			purchaseOrderService.purchaseOrderInDueDateAdmUpd(purchaseOrderVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 발주관리 메인 삭제
	@RequestMapping(value = "pm/purchaseOrderAdmDel", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> purchaseOrderAdmDel(PurchaseOrderVo purchaseOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("발주관리 메인 삭제");
		try {
			purchaseOrderVo.setUpdIdx(Utils.getUserIdx());
			purchaseOrderVo.setUpdDate(DateUtil.getCurrentDateTime());
			purchaseOrderService.purchaseOrderAdmDel(purchaseOrderVo);
			if("Y".equals(purchaseOrderVo.getSuccessYn())) {
				jsonData.put("result", "ok");
			} else {
				jsonData.put("result", "fail");
				jsonData.put("message", purchaseOrderVo.getResMessage());
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 발주관리 발주서 출력번호 및 출력여부 수정
	@RequestMapping(value = "pm/purchasePaperUpd", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> purchasePaperUpd(PurchaseOrderVo purchaseOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("발주관리 발주서 출력번호 및 출력여부 수정");
		try {
			purchaseOrderService.purchasePaperUpd(purchaseOrderVo);
			if("Y".equals(purchaseOrderVo.getResultYn())) {
				jsonData.put("result", "ok");			
			} else {
				jsonData.put("result", "fail");
				jsonData.put("message", purchaseOrderVo.getResMessage());
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 발주관리 발주서 출력번호 삭제 및 출력여부 수정
	@RequestMapping(value = "pm/purchasePaperDel", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> purchasePaperDel(PurchaseOrderVo purchaseOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("발주관리 발주서 출력번호 삭제 및 출력여부 수정");
		try {
			purchaseOrderService.purchasePaperDel(purchaseOrderVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// =========================== 발주관리 입고등록페이지 ==========================================
	// 발주 목록조회
	@RequestMapping(value = "pm/purchaseOrderAdmLstSumInQty", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> purchaseOrderAdmLstSumInQty(PurchaseOrderVo purchaseOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("발주 목록조회");
		try {
			List<PurchaseOrderVo> purchaseOrderVoList = purchaseOrderService.purchaseOrderAdmLstSumInQty(purchaseOrderVo);
			jsonData.put("data", purchaseOrderVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// =========================== 발주관리 필요량 계산 ==========================================
	// 발주 재질별 필요량 계산 목록조회
	@RequestMapping(value = "pm/purchaseOrderAdmLstWithNeedQty", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> purchaseOrderAdmLstWithNeedQty(PurchaseOrderVo purchaseOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("발주 재질별 필요량 계산 목록조회");
		try {
			List<PurchaseOrderVo> purchaseOrderVoList = purchaseOrderService.purchaseOrderAdmLstWithNeedQty(purchaseOrderVo);
			/*List<PurchaseOrderVo> purchaseOrderList = purchaseOrderVoList.stream()
														.filter(v->StringUtils.equals("SELECT", v.getSelectGubun()))
														.collect(Collectors.toList());
			List<PurchaseOrderVo> purchaseOrderAllList = purchaseOrderVoList.stream()
														.filter(v->StringUtils.equals("ALL_SELECT", v.getSelectGubun()))
														.collect(Collectors.toList());*/
			jsonData.put("data", purchaseOrderVoList);
			//jsonData.put("allData", purchaseOrderAllList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 발주 재질별 가용재고량 목록 조회
	@RequestMapping(value = "pm/purchaseOrderAdmLstWithAsQty", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> purchaseOrderAdmLstWithAsQty(PurchaseOrderVo purchaseOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("발주 재질별 가용재고량 목록 조회");
		try {
			List<PurchaseOrderVo> purchaseOrderVoList = purchaseOrderService.purchaseOrderAdmLstWithAsQty(purchaseOrderVo);
			jsonData.put("data", purchaseOrderVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//발주관리 메인 발주수량 수정
	@RequestMapping(value = "pm/purchaseOrderQtyAdmUpd", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> purchaseOrderQtyAdmUpd(@RequestParam(value="jsonArray", required=false) String jsonArray) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("발주관리 메인 발주수량 수정");
		try {
			JSONParser jsonParser = new JSONParser();
			JSONArray dataArray = (JSONArray) jsonParser.parse(jsonArray);
			List<PurchaseOrderVo> purchaseOrderVoList = new ArrayList<>();
			JSONObject jsonObj = new JSONObject();
	        for(int i=0;i<dataArray.size();i++) {
	        	jsonObj.put(i, dataArray.get(i));
	    		JSONObject jsonObject = (JSONObject) jsonParser.parse(jsonObj.get(i).toString());
	    		
	    		PurchaseOrderVo purchaseOrderVo = new PurchaseOrderVo();
	    		/*String plusMinus = Float.parseFloat(jsonObject.get("beforeordQty").toString()) <= Float.parseFloat(jsonObject.get("purchaseOrdQty").toString()) 
	    				? "plus" : "minus"; 
	    		float targetQty = Float.parseFloat(jsonObject.get("beforeordQty").toString()) >= Float.parseFloat(jsonObject.get("purchaseOrdQty").toString()) 
	    				? Float.parseFloat(jsonObject.get("beforeordQty").toString()) - Float.parseFloat(jsonObject.get("purchaseOrdQty").toString()) : Float.parseFloat(jsonObject.get("purchaseOrdQty").toString()) - Float.parseFloat(jsonObject.get("beforeordQty").toString());
	    		float purchaseOrdQty = targetQty * Float.parseFloat(jsonObject.get("cutQty").toString()) * Float.parseFloat(jsonObject.get("eaQty").toString());
	    				
   				purchaseOrderVo.setPlusMinus(plusMinus);*/
	    		purchaseOrderVo.setIdx(jsonObject.get("idx").toString());
	    	    purchaseOrderVo.setPurchaseOrdQty(jsonObject.get("purchaseOrdQty").toString());
	    		purchaseOrderVo.setUpdIdx(Utils.getUserIdx());
	    		purchaseOrderVo.setUpdDate(DateUtil.getCurrentDateTime());
	    		
	    		purchaseOrderVoList.add(purchaseOrderVo);
	        }
	        
	        for(int i=0;i<purchaseOrderVoList.size();i++) {
        		purchaseOrderService.purchaseOrderQtyAdmUpd(purchaseOrderVoList.get(i));
	        }
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// =========================== 입고원장 페이지 ==========================================
	// 입고원장 목록조회
	@RequestMapping(value = "pm/inOrginLst", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> inOrginLst(PurchaseOrderVo purchaseOrderVo,Model model) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("입고원장 목록조회");
		try {
			List<PurchaseOrderVo> purchaseOrderVoList = purchaseOrderService.inOrginLst(purchaseOrderVo);
			
			List<String> list = new ArrayList<String>();
			
			LocalDate date = LocalDate.of(2023, 06, 10);
			
			for(int i=0; i<12; i++) {
				LocalDate oneMonthBefore = date.minusMonths(i);
				DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM");
				String formattedDate = oneMonthBefore.format(formatter);
				
				
				logger.info(i+"달전:"+formattedDate);
				
				list.add("m"+(!formattedDate.equals("10")?formattedDate.replace("0", ""):formattedDate));
			//[08, 07, 06, 05, 04, 03, 02, 01, 12, 11, 10, 09]
			}
			
			logger.info("list:"+list);
			model.addAttribute("dayList", list);
			jsonData.put("data", purchaseOrderVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
}
