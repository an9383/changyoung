package mes.web.bs;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

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
import mes.domain.bm.LocationVo;
import mes.domain.bs.BizOrderVo;
import mes.domain.pm.PurchaseOrderVo;
import mes.domain.sm.CommonCodeVo;
import mes.domain.stock.InProdWhsAdmVo;
import mes.domain.stock.OutMatrWhsAdmVo;
import mes.domain.stock.OutProdWhsAdmVo;
import mes.domain.stock.StockManagementVo;
import mes.domain.stock.StockPaymentAdmVo;
import mes.domain.wm.WorkOrderVo;
import mes.domain.wm.WorkPlanVo;
import mes.service.bm.LocationService;
import mes.service.bs.BizOrderService;
import mes.service.pm.PurchaseOrderService;
import mes.service.stock.InProdWhsAdmService;
import mes.service.stock.OutMatrWhsAdmService;
import mes.service.stock.OutProdWhsAdmService;
import mes.service.stock.StockPaymentAdmService;
import mes.service.wm.WorkOrderService;
import mes.service.wm.WorkPlanService;
import mes.web.stock.StockManagementController;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class BizOrderController {
	
	@Inject
	private BizOrderService bizOrderService;
	
	@Inject
	private PurchaseOrderService purchaseOrderService;
	
	@Inject
	private WorkPlanService workPlanService;
	
	@Inject
	private WorkOrderService workOrderService;
	
	@Inject
	private OutMatrWhsAdmService outMatrWhsAdmService;
	
	@Inject
	private InProdWhsAdmService inProdWhsAdmService;
	
	@Inject
	private OutProdWhsAdmService outProdWhsAdmService;
	
	@Inject
	private StockPaymentAdmService stockPaymentAdmService;
	
	@Inject
	private LocationService locationService;
	
	@Inject
	private StockManagementController stockManagementController;
	
	private static final Logger logger = LoggerFactory.getLogger(BizOrderController.class);
	
	// bssc0010 페이지
	@RequestMapping(value = "/bs/bssc0010", method = RequestMethod.GET)
	public ModelAndView bssc0010(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /bs/bssc0010");
		mav.setViewName("/bs/bssc0010");
		return mav;
	}
	
	// bssc0020 페이지
	@RequestMapping(value = "/bs/bssc0020", method = RequestMethod.GET)
	public ModelAndView bssc0020(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /bs/bssc0020");
		mav.setViewName("/bs/bssc0020");
		return mav;
	}
	
	// bssc0030 페이지
	@RequestMapping(value = "/bs/bssc0030", method = RequestMethod.GET)
	public ModelAndView bssc0030(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /bs/bssc0030");
		mav.setViewName("/bs/bssc0030");
		return mav;
	}
	
	// bssc0040 페이지
	@RequestMapping(value = "/bs/bssc0040", method = RequestMethod.GET)
	public ModelAndView bssc0040(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /bs/bssc0040");
		mav.setViewName("/bs/bssc0040");
		return mav;
	}
	
	// bssc0050 페이지
	@RequestMapping(value = "/bs/bssc0050", method = RequestMethod.GET)
	public ModelAndView bssc0050(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /bs/bssc0050");
		mav.setViewName("/bs/bssc0050");
		return mav;
	}
	
	// bssc0060 페이지
	@RequestMapping(value = "/bs/bssc0060", method = RequestMethod.GET)
	public ModelAndView bssc0060(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /bs/bssc0060");
		mav.setViewName("/bs/bssc0060");
		return mav;
	}
	
	// bssc0070 페이지
	@RequestMapping(value = "/bs/bssc0070", method = RequestMethod.GET)
	public ModelAndView bssc0070(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /bs/bssc0070");
		mav.setViewName("/bs/bssc0070");
		return mav;
	}
	
	// bssc0080 페이지
	@RequestMapping(value = "/bs/bssc0080", method = RequestMethod.GET)
	public ModelAndView bssc0080(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /bs/bssc0080");
		mav.setViewName("/bs/bssc0080");
		return mav;
	}
	
	// bssc0090 페이지
	@RequestMapping(value = "/bs/bssc0090", method = RequestMethod.GET)
	public ModelAndView bssc0090(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /bs/bssc0090");
		mav.setViewName("/bs/bssc0090");
		return mav;
	}
	
	// =========================== 수주관리 메인 ==========================================
	// 수주관리 메인 목록조회
	@RequestMapping(value = "bs/bizOrderAdmLst", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrderAdmLst(BizOrderVo bizOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주관리 메인 목록조회");
		try {
			List<BizOrderVo> bizOrderVoList = bizOrderService.bizOrderAdmLst(bizOrderVo);
			jsonData.put("data", bizOrderVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 수주관리 메인 목록조회-GROUP BY 고객사
	@RequestMapping(value = "bs/bizOrderAdmLstGroupByDealCorp", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrderAdmLstGroupByDealCorp(BizOrderVo bizOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주관리 메인 목록조회-GROUP BY 고객사");
		try {
			List<BizOrderVo> bizOrderVoList = bizOrderService.bizOrderAdmLstGroupByDealCorp(bizOrderVo);
			jsonData.put("data", bizOrderVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 수주관리 메인 목록조회-GROUP BY 자재
	@RequestMapping(value = "bs/bizOrderDtlLstGroupByMatrl", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrderDtlLstGroupByMatrl(BizOrderVo bizOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주관리 메인 목록조회-GROUP BY 자재");
		try {
			List<BizOrderVo> bizOrderVoList = bizOrderService.bizOrderDtlLstGroupByMatrl(bizOrderVo);
			jsonData.put("data", bizOrderVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 수주관리 메인 상세조회
	@RequestMapping(value = "bs/bizOrderAdmSel", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrderAdmSel(BizOrderVo bizOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주관리 메인 상세조회");
		try {
			bizOrderVo = bizOrderService.bizOrderAdmSel(bizOrderVo);
			jsonData.put("data", bizOrderVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 수주관리 메인 등록/수정
	@RequestMapping(value = "bs/bizOrderAdmIU", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrderAdmIU(BizOrderVo bizOrderVo, @RequestParam(value="jsonArray", required=false) String jsonArray) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주관리 메인 등록/수정");
		try {
			boolean spQtycheck = true;
			
			JSONParser jsonParser = new JSONParser();
			JSONArray dataArray = (JSONArray) jsonParser.parse(jsonArray);

			//등록,수정할 수주DTL의 재고사용량 합산리스트
			List<BizOrderVo> stockUseQtySumList = new ArrayList<>();
			JSONObject jsonStockObj = new JSONObject();
	        for(int i=0;i<dataArray.size();i++) {
	        	jsonStockObj.put(i, dataArray.get(i));
	    		JSONObject jsonObject = (JSONObject) jsonParser.parse(jsonStockObj.get(i).toString());
	    		
	    		BizOrderVo bizOrderDtlVo = new BizOrderVo();	
	    		//디자인컨펌된 경우 재고사용량에 대해 체크할필요 X
	    		if(!"Y".equals(jsonObject.get("confirmDesign").toString())) {
		    		bizOrderDtlVo.setItemIdx(jsonObject.get("itemIdx").toString());
		    		bizOrderDtlVo.setStockUseQty(jsonObject.get("stockUseQty").toString());
		    		bizOrderDtlVo.setStockReUseQty(jsonObject.get("stockReUseQty").toString());
		    		
		    		stockUseQtySumList.add(bizOrderDtlVo);
	    		}
	    		
	        }
			//itemIdx를 기준으로 sum
	        Map<Object, Integer> itemIdxGroupSumLst = stockUseQtySumList.stream()
	        															.collect(Collectors.toMap( v->v.getItemIdx() , v-> Integer.parseInt(v.getStockUseQty()) + Integer.parseInt(v.getStockReUseQty()), Integer::sum ));
	        List<Object> itemIdxLst = new ArrayList<>(itemIdxGroupSumLst.keySet());
	        // 문자열로 연결하는 StringBuilder 객체 생성
	        StringBuilder sb = new StringBuilder();
	        for (Object key : itemIdxLst) {
	            // StringBuilder에 값을 추가
	            sb.append(key.toString()).append(",");
	        }
	        // 마지막 , 제거
	        if (itemIdxLst.size() > 0) {
	            sb.setLength(sb.length() - 1);
	        }
	        // 최종 문자열 출력
	        String itemIdxString = sb.toString();
	        // 해당 itemIdx의 현재고량 조회
	        bizOrderVo.setStringItemIdx(itemIdxString);
	        List<BizOrderVo> spQtyLst = bizOrderService.bizOrderSpQtySel(bizOrderVo);
	        
	        for(int i = 0; i<itemIdxLst.size(); i++) {
	        	String itemIdx = String.valueOf(itemIdxLst.get(i));
	        	int stockUseQty = itemIdxGroupSumLst.get(itemIdx);
	        	int spQty = 0;
	        	
	        	BizOrderVo filterVo = spQtyLst.stream()
								 	    .filter(v -> StringUtils.equals(itemIdx, v.getItemIdx()))
									    .findAny()
									    .orElse(null);
	        	if(filterVo != null) {
	        		spQty = (int)Double.parseDouble(filterVo.getSpQty());
	        	}
	        	
	        	//재고사용수량이 더 클 경우 -> -재고되서 등록불가능
	        	if( stockUseQty > spQty ) {
	        		jsonData.put("message", "현재고가 부족한 항목이 있어<br>등록/수정 할 수 없습니다.");
					jsonData.put("result", "fail");
					spQtycheck = false;
	        		break;
	        	}
	        	
	        }
	        
	        if(spQtycheck) {
	        	//제품 품질창고(QC) 가능한 창고 조회
				WorkOrderVo qcLocationVo = new WorkOrderVo();
				qcLocationVo = workOrderService.workInProdLocationList(qcLocationVo);
				//제품 입출고 가능한 창고 조회
				LocationVo itemLocationVo = new LocationVo();
				itemLocationVo = locationService.possibleInOutItemLocationSel(itemLocationVo);
				
				if(qcLocationVo == null) {
					jsonData.put("message", "QC 가능한 창고가 <br>없습니다.");
					jsonData.put("result", "fail");
				} else if(itemLocationVo == null) {
					jsonData.put("message", "제품 입출고 가능한 창고가 <br>없습니다.");
					jsonData.put("result", "fail");
				} else {
					logger.info(bizOrderVo.toString());
					// 수주관리 메인 등록/수정 ================================================================
					String idx = ""; // 수주관리 메인 IDX
					bizOrderVo.setRegIdx(Utils.getUserIdx());
					bizOrderVo.setRegDate(DateUtil.getCurrentDateTime());
					bizOrderVo.setUpdIdx(Utils.getUserIdx());
					bizOrderVo.setUpdDate(DateUtil.getCurrentDateTime());
					if(bizOrderVo.getBizOrdNo().equals("")) { // 수주관리 메인이 등록되어있지 않을 경우
						idx = bizOrderService.bizOrderAdmIns(bizOrderVo); // 등록
					} else {
						bizOrderService.bizOrderAdmUpd(bizOrderVo); // 수정
						idx = bizOrderVo.getBizOrdAdmIdx();
					}
					
					// 수주관리 상세 등록/수정 ================================================================
					List<BizOrderVo> bizOrderDtlVoAddList = new ArrayList<>();
					
					Date today = new Date();	// 오늘 날짜
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
					// 문자열을 Date 객체로 파싱
					String strToday = sdf.format(today);
					
					//출고목록(완제품)
					List<StockManagementVo> prodOutList = new ArrayList<>();
					//입고목록(QC창고)
					List<StockManagementVo> prodInList = new ArrayList<>();
					
					JSONObject jsonObj = new JSONObject();
			        for(int i=0;i<dataArray.size();i++) {
			        	jsonObj.put(i, dataArray.get(i));
			    		JSONObject jsonObject = (JSONObject) jsonParser.parse(jsonObj.get(i).toString());
			    		
			    		BizOrderVo bizOrderDtlVo = new BizOrderVo();
			    		bizOrderDtlVo.setIdx(jsonObject.get("idx").toString());
			    		bizOrderDtlVo.setWorkplaceIdx(jsonObject.get("workplaceIdx").toString());
			    		bizOrderDtlVo.setBizOrdAdmIdx(idx);
			    		bizOrderDtlVo.setOrdGubun(jsonObject.get("ordGubun").toString());
			    		bizOrderDtlVo.setBizOrdDtlNo(jsonObject.get("bizOrdDtlNo").toString());
			    		//bizOrderDtlVo.setBizStatusCd(jsonObject.get("bizStatusCd").toString());
			    		if( Integer.parseInt(jsonObject.get("stockUseQty").toString()) > 0 || Integer.parseInt(jsonObject.get("stockReUseQty").toString()) > 0 ) {
			    			bizOrderDtlVo.setStockUseYn("Y");
			    		} else {
			    			bizOrderDtlVo.setStockUseYn("N");
			    		}
			    		bizOrderDtlVo.setOrdQty(jsonObject.get("ordQty").toString());
			    		bizOrderDtlVo.setStockUseQty(jsonObject.get("stockUseQty").toString());
			    		bizOrderDtlVo.setStockReUseQty(jsonObject.get("stockReUseQty").toString());
			    		bizOrderDtlVo.setPurchaseBatch(jsonObject.get("purchaseBatch").toString());
			    		bizOrderDtlVo.setItemIdx(jsonObject.get("itemIdx").toString());
			    		bizOrderDtlVo.setItemVerIdx(jsonObject.get("itemVerIdx").toString());
			    		bizOrderDtlVo.setOrdNote(jsonObject.get("ordNote").toString());
			    		bizOrderDtlVo.setOrdIssue(jsonObject.get("ordIssue").toString());
			    		bizOrderDtlVo.setWorkEndReqDate(jsonObject.get("workEndReqDate").toString());
			    		bizOrderDtlVo.setOrdDate(bizOrderVo.getOrdDate());
			    		bizOrderDtlVo.setOutReqDate(jsonObject.get("outReqDate").toString());
			    		bizOrderDtlVo.setConfirmOrder(jsonObject.get("confirmOrder").toString());
			    		bizOrderDtlVo.setConfirmDesign(jsonObject.get("confirmDesign").toString());
			    		bizOrderDtlVo.setOrdDtlDesc(jsonObject.get("ordDtlDesc").toString());
			    		bizOrderDtlVo.setUpdIdx(Utils.getUserIdx());
			    		bizOrderDtlVo.setUpdDate(DateUtil.getCurrentDateTime());
			    		bizOrderDtlVo.setRegIdx(Utils.getUserIdx());
						bizOrderDtlVo.setRegDate(DateUtil.getCurrentDateTime());
						bizOrderDtlVoAddList.add(bizOrderDtlVo);
						
			        }
			        //제품입고전표 삭제 배열
					JSONArray inProdDel_array = new JSONArray();
					//제품출고 전표 삭제 JSON 배열
					JSONArray outProdDel_array = new JSONArray();
					//수불 삭제 JSON배열
					JSONArray stockDel_array = new JSONArray();
					StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();
					OutProdWhsAdmVo outProdWhsAdmVo = new OutProdWhsAdmVo();
					InProdWhsAdmVo inProdWhsAdmVo = new InProdWhsAdmVo();
			        for(int i=0;i<bizOrderDtlVoAddList.size();i++) {
			        	if(bizOrderDtlVoAddList.get(i).getIdx() == null || bizOrderDtlVoAddList.get(i).getIdx().equals("")) { // 등록
			        		bizOrderDtlVoAddList.get(i).setBizStatusCd("01"); //01 -> 시스템 , 수주 등록상태
			        		bizOrderService.bizOrderDtlIns(bizOrderDtlVoAddList.get(i));
			        		//재고사용인경우 완제품->품질창고로 재고이동됨
			        		//이었는데 재고사용수량이 0보다 큰경우 재고이동처리
							/*if( Integer.parseInt(bizOrderDtlVoAddList.get(i).getStockUseQty()) > 0 || Integer.parseInt(bizOrderDtlVoAddList.get(i).getStockReUseQty()) > 0) {
								StockManagementVo stockManagementVo = new StockManagementVo();
								stockManagementVo.setSmItemGubun("001");
					    		stockManagementVo.setSmOutGubun("수주재고사용");
					    		stockManagementVo.setSmItemIdx(bizOrderDtlVoAddList.get(i).getItemIdx());
					    		stockManagementVo.setSmCarAssignment(null);
					    		//stockManagementVo.setSmItemCd(jsonObject.get("itemCd").toString());
					    		String smQty = Integer.toString(Integer.parseInt(bizOrderDtlVoAddList.get(i).getStockUseQty()) + Integer.parseInt(bizOrderDtlVoAddList.get(i).getStockReUseQty()));
					    		stockManagementVo.setSmQty( smQty );
					    		stockManagementVo.setSmDate(strToday);
					    		stockManagementVo.setSmOutCorpIdx(null);
					    		stockManagementVo.setSmStatus("B"); //출고
					    		stockManagementVo.setSmLotNo("");
					    		stockManagementVo.setSmOutRelationNo(bizOrderDtlVoAddList.get(i).getResIdx()); 
					    		stockManagementVo.setSmOutWhsGubun("");
					    		stockManagementVo.setSmOutWhsIdx(itemLocationVo.getIdx());
					    		stockManagementVo.setSmOutLocIdx(null);
					    		stockManagementVo.setSmEtc1(null);
					    		stockManagementVo.setSmEtc2(null);
					    		stockManagementVo.setSmEtc3(null);
					    		stockManagementVo.setSmType("출고");
					    		stockManagementVo.setSmType2("BSPO");
					    		stockManagementVo.setSmInWhsGubun("");
					    		stockManagementVo.setSmInWhsIdx(itemLocationVo.getIdx()); 
					    		stockManagementVo.setSmLotNo("");
					    		stockManagementVo.setSmInRelationNo(bizOrderDtlVoAddList.get(i).getResIdx());
					    		stockManagementVo.setSmDesc("");
					    		stockManagementVo.setSmEtc1("");
					    		stockManagementVo.setSmEtc2("");
					    		stockManagementVo.setSmEtc3("");
					    		prodOutList.add(stockManagementVo);
					    		
					    		StockManagementVo stockManagementInVo = new StockManagementVo();
								stockManagementInVo.setSmItemGubun("001"); //001:제품 , 002:자재
								stockManagementInVo.setSmItemCd(bizOrderDtlVoAddList.get(i).getItemIdx()); //품목(제품) 식별자
								stockManagementInVo.setSmType("입고"); //수불구분
								stockManagementInVo.setSmType2("BSPI"); //업무구분
								stockManagementInVo.setSmDate(strToday); //수불일자
								stockManagementInVo.setSmQty(smQty); // 수불수량
								stockManagementInVo.setSmLotNo(""); //LOT번호 -> 채번이라서 빈값넘겨줌
								stockManagementInVo.setSmSourceNo(bizOrderDtlVoAddList.get(i).getResIdx()); //원천번호 -> 수주상세식별자
								stockManagementInVo.setSmInWhsGubun(""); //창고구분 -> 없음 빈값 
								stockManagementInVo.setSmOutWhsIdx(qcLocationVo.getLocationIdx()); //창고식별자 
								stockManagementInVo.setSmInWhsIdx(qcLocationVo.getLocationIdx()); //창고식별자  
					    		
								stockManagementInVo.setSmInGubun("수주재고사용"); //입고구분
								stockManagementInVo.setSmInCorpIdx(""); //입고처
								stockManagementInVo.setSmInRelationNo(bizOrderDtlVoAddList.get(i).getResIdx()); //원천번호 -> 수주상세식별자
								prodInList.add(stockManagementInVo);
							}*/
			        	} else { // 수정
			        		//수정시 구분 업데이트 안하기위해서 예외로 null
			        		bizOrderDtlVoAddList.get(i).setConfirmOrder(null);
			        		bizOrderDtlVoAddList.get(i).setConfirmDesign(null);
			        		bizOrderService.bizOrderDtlUpd(bizOrderDtlVoAddList.get(i));
			        		
			        		/*if("Y".equals(bizOrderDtlVoAddList.get(i).getStockUseYn()) && "Y".equals(bizOrderDtlVoAddList.get(i).getResultYn())) {
				        		//재고이동된 수불들 지우고 다시 만들어줌
								//제품출고수불
					    		OutProdWhsAdmVo outProdWhsAdmDisposalVo = new OutProdWhsAdmVo();
					    		outProdWhsAdmDisposalVo.setRelationNo(bizOrderDtlVoAddList.get(i).getResIdx());
					    		outProdWhsAdmDisposalVo.setOutGubun("수주재고사용");
					    		List<OutProdWhsAdmVo> outProdList = new ArrayList<>();
					    		outProdList = outProdWhsAdmService.getOutSlipNoByRelationNo(outProdWhsAdmDisposalVo);
					    		//제품입고수불
					    		InProdWhsAdmVo inProdDelVo = new InProdWhsAdmVo();
					    		inProdDelVo.setRelationNo(bizOrderDtlVoAddList.get(i).getResIdx());
					    		inProdDelVo.setInGubun("수주재고사용");
					    		inProdDelVo = inProdWhsAdmService.getInSlipNoByRelationNo(inProdDelVo);
								
								//해당 전표(제품폐기출고)가 존재한다면 지우고 하도록
								if(outProdList.size() != 0) {
									for(int j=0;j<outProdList.size();j++) {
										JSONObject outProdData = new JSONObject();
										JSONObject stockDelData = new JSONObject();
										outProdData.put("OUT_SLIP_NO", outProdList.get(j).getOutSlipNo());
										outProdData.put("OUT_SLIP_SEQ", outProdList.get(j).getOutSlipSeq());
										outProdDel_array.add(outProdData);
										
								        stockDelData.put("SP_SOURCE_NO", outProdList.get(j).getOutSlipNo() + "-" + outProdList.get(j).getOutSlipSeq());
								        stockDel_array.add(stockDelData);
									}
								}
								//해당 전표가 존재한다면 지우고 하도록
								if(inProdDelVo != null) {
									
									JSONObject inProdData = new JSONObject();
									inProdData.put("IN_SLIP_NO", inProdDelVo.getInSlipNo() );
									inProdData.put("IN_SLIP_SEQ", inProdDelVo.getInSlipSeq());
									inProdDel_array.add(inProdData);
									
									//수불 삭제 JSON배열
									JSONObject stockData = new JSONObject();
									stockData.put("SP_SOURCE_NO", inProdDelVo.getInSlipNo() + "-" + inProdDelVo.getInSlipSeq());
									stockDel_array.add(stockData);
									
								}
								String smQty = Integer.toString(Integer.parseInt(bizOrderDtlVoAddList.get(i).getStockUseQty()) + Integer.parseInt(bizOrderDtlVoAddList.get(i).getStockReUseQty()));
					    		
								StockManagementVo stockManagementVo = new StockManagementVo();
								stockManagementVo.setSmItemGubun("001");
					    		stockManagementVo.setSmOutGubun("수주재고사용");
					    		stockManagementVo.setSmItemIdx(bizOrderDtlVoAddList.get(i).getItemIdx());
					    		stockManagementVo.setSmCarAssignment(null);
					    		//stockManagementVo.setSmItemCd(jsonObject.get("itemCd").toString());
					    		stockManagementVo.setSmQty(smQty);
					    		stockManagementVo.setSmDate(strToday);
					    		stockManagementVo.setSmOutCorpIdx(null);
					    		stockManagementVo.setSmStatus("B"); //출고
					    		stockManagementVo.setSmLotNo("");
					    		stockManagementVo.setSmOutRelationNo(bizOrderDtlVoAddList.get(i).getResIdx()); 
					    		stockManagementVo.setSmOutWhsGubun("");
					    		stockManagementVo.setSmOutWhsIdx(itemLocationVo.getIdx());
					    		stockManagementVo.setSmOutLocIdx(null);
					    		stockManagementVo.setSmEtc1(null);
					    		stockManagementVo.setSmEtc2(null);
					    		stockManagementVo.setSmEtc3(null);
					    		stockManagementVo.setSmType("출고");
					    		stockManagementVo.setSmType2("BSPO");
					    		stockManagementVo.setSmInWhsGubun("");
					    		stockManagementVo.setSmInWhsIdx(itemLocationVo.getIdx()); 
					    		stockManagementVo.setSmLotNo("");
					    		stockManagementVo.setSmInRelationNo(bizOrderDtlVoAddList.get(i).getResIdx());
					    		stockManagementVo.setSmDesc("");
					    		stockManagementVo.setSmEtc1("");
					    		stockManagementVo.setSmEtc2("");
					    		stockManagementVo.setSmEtc3("");
					    		prodOutList.add(stockManagementVo);
					    		
					    		StockManagementVo stockManagementInVo = new StockManagementVo();
								stockManagementInVo.setSmItemGubun("001"); //001:제품 , 002:자재
								stockManagementInVo.setSmItemCd(bizOrderDtlVoAddList.get(i).getItemIdx()); //품목(제품) 식별자
								stockManagementInVo.setSmType("입고"); //수불구분
								stockManagementInVo.setSmType2("BSPI"); //업무구분
								stockManagementInVo.setSmDate(strToday); //수불일자
								stockManagementInVo.setSmQty(smQty); // 수불수량
								stockManagementInVo.setSmLotNo(""); //LOT번호 -> 채번이라서 빈값넘겨줌
								stockManagementInVo.setSmSourceNo(bizOrderDtlVoAddList.get(i).getResIdx()); //원천번호 -> 수주상세식별자
								stockManagementInVo.setSmInWhsGubun(""); //창고구분 -> 없음 빈값 
								stockManagementInVo.setSmOutWhsIdx(qcLocationVo.getLocationIdx()); //창고식별자 
								stockManagementInVo.setSmInWhsIdx(qcLocationVo.getLocationIdx()); //창고식별자  
					    		
								stockManagementInVo.setSmInGubun("수주재고사용"); //입고구분
								stockManagementInVo.setSmInCorpIdx(""); //입고처
								stockManagementInVo.setSmInRelationNo(bizOrderDtlVoAddList.get(i).getResIdx()); //원천번호 -> 수주상세식별자
								prodInList.add(stockManagementInVo);
			        		} else if("N".equals(bizOrderDtlVoAddList.get(i).getStockUseYn())){
			        			//재고사용이 아닐경우 해당 수불 발생했던거 삭제처리
			        			//제품출고수불
					    		OutProdWhsAdmVo outProdWhsAdmDisposalVo = new OutProdWhsAdmVo();
					    		outProdWhsAdmDisposalVo.setRelationNo(bizOrderDtlVoAddList.get(i).getResIdx());
					    		outProdWhsAdmDisposalVo.setOutGubun("수주재고사용");
					    		List<OutProdWhsAdmVo> outProdList = new ArrayList<>();
					    		outProdList = outProdWhsAdmService.getOutSlipNoByRelationNo(outProdWhsAdmDisposalVo);
					    		//제품입고수불
					    		InProdWhsAdmVo inProdDelVo = new InProdWhsAdmVo();
					    		inProdDelVo.setRelationNo(bizOrderDtlVoAddList.get(i).getResIdx());
					    		inProdDelVo.setInGubun("수주재고사용");
					    		inProdDelVo = inProdWhsAdmService.getInSlipNoByRelationNo(inProdDelVo);
								
								//해당 전표(제품폐기출고)가 존재한다면 지우고 하도록
								if(outProdList.size() != 0) {
									for(int j=0;j<outProdList.size();j++) {
										JSONObject outProdData = new JSONObject();
										JSONObject stockDelData = new JSONObject();
										outProdData.put("OUT_SLIP_NO", outProdList.get(j).getOutSlipNo());
										outProdData.put("OUT_SLIP_SEQ", outProdList.get(j).getOutSlipSeq());
										outProdDel_array.add(outProdData);
										
								        stockDelData.put("SP_SOURCE_NO", outProdList.get(j).getOutSlipNo() + "-" + outProdList.get(j).getOutSlipSeq());
								        stockDel_array.add(stockDelData);
									}
								}
								//해당 전표가 존재한다면 지우고 하도록
								if(inProdDelVo != null) {
									
									JSONObject inProdData = new JSONObject();
									inProdData.put("IN_SLIP_NO", inProdDelVo.getInSlipNo() );
									inProdData.put("IN_SLIP_SEQ", inProdDelVo.getInSlipSeq());
									inProdDel_array.add(inProdData);
									
									//수불 삭제 JSON배열
									JSONObject stockData = new JSONObject();
									stockData.put("SP_SOURCE_NO", inProdDelVo.getInSlipNo() + "-" + inProdDelVo.getInSlipSeq());
									stockDel_array.add(stockData);
									
								}
			        		}*/
			        	}
			        		
			        }
			        //inProdWhsAdmVo.setDeleteJson(inProdDel_array.toJSONString());
					//inProdWhsAdmService.inProdWhsAdmDel(inProdWhsAdmVo); //제품입고 전표 삭제
					//outProdWhsAdmVo.setDeleteJson(outProdDel_array.toJSONString());
					//outProdWhsAdmService.outProdWhsAdmDel(outProdWhsAdmVo); //제품출고 전표 삭제
					//stockPaymentAdmVo.setDeleteJson(stockDel_array.toJSONString());
					//stockPaymentAdmService.stockPaymentAdmDel(stockPaymentAdmVo); // 제품 입,출고수불 삭제
			        //stockManagementController.ProdOutput(prodOutList);
			        //stockManagementController.ProdInput(prodInList);
			        
			        //수주에 묶인 dtl들의 번들링 정보들 업데이트
			        bizOrderVo.setBizOrdAdmIdx(idx);
			        bizOrderService.bizOrderAdmBundleUpd(bizOrderVo);
			        
					jsonData.put("result", "ok");
					jsonData.put("idx", idx);
				}
	        }
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 수주관리 수주중지
	@RequestMapping(value = "bs/bizOrderDtlStop", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrderDtlStop(BizOrderVo bizOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주관리 수주중지");
		try {
			bizOrderVo.setUpdIdx(Utils.getUserIdx());
			bizOrderVo.setUpdDate(DateUtil.getCurrentDateTime());
			bizOrderService.bizOrderDtlStop(bizOrderVo);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 수주관리 메인 삭제
	@RequestMapping(value = "bs/bizOrderAdmDel", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrderAdmDel(BizOrderVo bizOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주관리 메인 삭제");
		try {
			bizOrderService.bizOrderAdmDel(bizOrderVo);
			if("Y".equals(bizOrderVo.getResultYn())){
				jsonData.put("result", "ok");
			} else {
				jsonData.put("result", "fail");
				jsonData.put("message", bizOrderVo.getResMessage());
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	
	
	// =========================== 수주관리 상세 ==========================================
	// 수주관리 상세 목록조회
	@RequestMapping(value = "bs/bizOrderDtlLst", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrderDtlLst(BizOrderVo bizOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주관리 상세 목록조회");
		try {
			List<BizOrderVo> bizOrderVoList = bizOrderService.bizOrderDtlLst(bizOrderVo);
			jsonData.put("data", bizOrderVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 수주관리 상세 상세조회
	@RequestMapping(value = "bs/bizOrderDtlSel", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrderDtlSel(BizOrderVo bizOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주관리 상세 상세조회");
		try {
			bizOrderVo = bizOrderService.bizOrderDtlSel(bizOrderVo);
			jsonData.put("data", bizOrderVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 수주관리 상세 수정 - 관리내역서출력
	@RequestMapping(value = "bs/bizOrderDtlUpdByEditHistoryPrint", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrderDtlUpdByEditHistoryPrint(BizOrderVo bizOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주관리 상세 수정 - 관리내역서출력");
		try {
			bizOrderVo.setUpdIdx(Utils.getUserIdx());
			bizOrderVo.setUpdDate(DateUtil.getCurrentDateTime());
			bizOrderService.bizOrderDtlUpdByEditHistoryPrint(bizOrderVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 수주관리 상세 수정 - 번들링출력
	@RequestMapping(value = "bs/bizOrderDtlUpdByBundlePrint", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrderDtlUpdByBundlePrint(BizOrderVo bizOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주관리 상세 수정 - 번들링출력");
		try {
			bizOrderVo.setUpdIdx(Utils.getUserIdx());
			bizOrderVo.setUpdDate(DateUtil.getCurrentDateTime());
			bizOrderService.bizOrderDtlUpdByBundlePrint(bizOrderVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 수주관리 상세 수정 - 팀별일정조정표
	@RequestMapping(value = "bs/bizOrderDtlUpdByTeamSchedule", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrderDtlUpdByTeamSchedule(BizOrderVo bizOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주관리 상세 수정 - 팀별일정조정표");
		try {
			bizOrderVo.setUpdIdx(Utils.getUserIdx());
			bizOrderVo.setUpdDate(DateUtil.getCurrentDateTime());
			bizOrderService.bizOrderDtlUpdByTeamSchedule(bizOrderVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 수주관리 상세 수정
	@RequestMapping(value = "bs/bizOrderDtlUpd", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrderDtlUpd(BizOrderVo bizOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주관리 상세 수정");
		try {
			BizOrderVo bizOrderCheckVo = bizOrderService.bizOrderDtlSel(bizOrderVo);
			/*if(bizOrderVo.getConfirmOrder() != null) { // 수주확정을 할 경우
				if(bizOrderVo.getConfirmOrder().equals("Y")) { // 수주확정 Y 처리일 경우
					bizOrderVo.setUpdIdx(Utils.getUserIdx());
					bizOrderVo.setUpdDate(DateUtil.getCurrentDateTime());
					bizOrderService.bizOrderDtlUpd(bizOrderVo);
					if("Y".equals(bizOrderVo.getResultYn())) {
						jsonData.put("result", "ok");		
					} else {
						jsonData.put("result", "fail");		
						jsonData.put("message", bizOrderVo.getResMessage());	
						
					}
				} else { // 수주확정 N 처리일 경우 -> 디자인컨펌도 N 처리 
							// 디자인 컨펌도 N 처리였는데 이젠 수주확정만 N처리되도록 변경 2022.11.30
					//bizOrderVo.setConfirmDesign("N");
					//수주별발주의 확정여부 체크 후 N일 경우 진행
					bizOrderVo.setUpdIdx(Utils.getUserIdx());
					bizOrderVo.setUpdDate(DateUtil.getCurrentDateTime());
					PurchaseOrderVo purchaseOrderVo = new PurchaseOrderVo();
					purchaseOrderVo.setBizOrdDtlIdx(bizOrderVo.getIdx());
					List<PurchaseOrderVo> purchaseOrderVoList = purchaseOrderService.purchaseOrderAdmLstByBizDtlIdx(purchaseOrderVo);
					
					//리스트 사이즈가 0 -> 수주별발주 나간 항목이 없는 것
					if(purchaseOrderVoList.size() == 0) {
						bizOrderService.bizOrderDtlUpd(bizOrderVo);
						if("Y".equals(bizOrderVo.getResultYn())) {
							jsonData.put("result", "ok");		
						} else {
							jsonData.put("result", "fail");		
							jsonData.put("message", bizOrderVo.getResMessage());	
							
						}
					} else {
						//수주별발주 1개만 쓰니까 0번째의 확정여부들고오면됨
						if("Y".equals(purchaseOrderVoList.get(0).getConfirmYn())) {
							jsonData.put("result", "fail");
							jsonData.put("message", "수주별발주가 확정되었습니다.<br>확인 후 시도해주세요.");
						} else {
							bizOrderService.bizOrderDtlUpd(bizOrderVo);
							if("Y".equals(bizOrderVo.getResultYn())) {
								jsonData.put("result", "ok");		
							} else {
								jsonData.put("result", "fail");		
								jsonData.put("message", bizOrderVo.getResMessage());	
								
							}
						}
					}
				}
			} else */if(bizOrderVo.getConfirmDesign() != null) { // 디자인컨펌을 할 경우 -> 디자인컨펌이  수주확정처럼 변경되어서 위에조건 필요없어짐
				if(bizOrderVo.getConfirmDesign().equals("Y")) { // 디자인컨펌 Y 처리일 경우
					boolean spQtycheck = true;
					int stockUseQty = (int)Double.parseDouble(bizOrderCheckVo.getStockUseQty());
					// 해당 itemIdx의 현재고량 조회
			        bizOrderVo.setStringItemIdx(bizOrderCheckVo.getItemIdx());
			        List<BizOrderVo> spQtyLst = bizOrderService.bizOrderSpQtySel(bizOrderVo);
			        int spQty = 0;
			        BizOrderVo filterVo = spQtyLst.stream()
										 	    .filter(v -> StringUtils.equals(bizOrderCheckVo.getItemIdx(), v.getItemIdx()))
											    .findAny()
											    .orElse(null);
					if(filterVo != null) {
						spQty = (int)Double.parseDouble(filterVo.getSpQty());
					}
					//재고사용수량이 더 클 경우 -> -재고되서 등록불가능
		        	if( stockUseQty > spQty && stockUseQty > 0) {
		        		jsonData.put("message", "현재고 부족으로 인해<br>재고사용 할 수 없습니다.");
						jsonData.put("result", "fail");
						spQtycheck = false;
		        	}
		        	//재고사용수량이 있을경우 재고사용여부 Y처리
		        	if(stockUseQty > 0) {
		        		bizOrderVo.setStockUseYn("Y");
		        	}
		        	//재고사용수량 >= 수주수량일경우 출고대기상태로 변환 & 수주비고란에 재고출고자동으로 입력해달라함
		        	if( stockUseQty >= (int)Double.parseDouble(bizOrderCheckVo.getOrdQty()) ) {
		        		bizOrderVo.setBizStatusCd("06");
		        		bizOrderVo.setOrdIssue("재고 출고");
		        	}
		        	
		        	if(spQtycheck) {
			        	//제품 품질창고(QC) 가능한 창고 조회
						WorkOrderVo qcLocationVo = new WorkOrderVo();
						qcLocationVo = workOrderService.workInProdLocationList(qcLocationVo);
						//제품 입출고 가능한 창고 조회
						LocationVo itemLocationVo = new LocationVo();
						itemLocationVo = locationService.possibleInOutItemLocationSel(itemLocationVo);
						
						if(qcLocationVo == null) {
							jsonData.put("message", "QC 가능한 창고가 <br>없습니다.");
							jsonData.put("result", "fail");
						} else if(itemLocationVo == null) {
							jsonData.put("message", "제품 입출고 가능한 창고가 <br>없습니다.");
							jsonData.put("result", "fail");
						} else {
							//디자인컨펌 Y일 경우 수주확정도 Y처리되도록 변경됨
							bizOrderVo.setConfirmOrder("Y");			
		
							bizOrderVo.setUpdIdx(Utils.getUserIdx());
							bizOrderVo.setUpdDate(DateUtil.getCurrentDateTime());
							bizOrderService.bizOrderDtlUpd(bizOrderVo);
							
							//출고목록(완제품)
							List<StockManagementVo> prodOutList = new ArrayList<>();
							//입고목록(QC창고)
							List<StockManagementVo> prodInList = new ArrayList<>();
							// 오늘 날짜
							Date today = new Date();	
							SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
							// 문자열을 Date 객체로 파싱
							String strToday = sdf.format(today);
							
							if("Y".equals(bizOrderVo.getResultYn())) {
								//재고사용인경우 완제품->품질창고로 재고이동됨
								if("Y".equals(bizOrderVo.getStockUseYn())) {
									StockManagementVo stockManagementVo = new StockManagementVo();
									stockManagementVo.setSmItemGubun("001");
						    		stockManagementVo.setSmOutGubun("수주재고사용");
						    		stockManagementVo.setSmItemIdx(bizOrderCheckVo.getItemIdx());
						    		stockManagementVo.setSmItemVersionIdx(bizOrderCheckVo.getItemVerIdx());
						    		stockManagementVo.setSmCarAssignment(null);
						    		//stockManagementVo.setSmItemCd(jsonObject.get("itemCd").toString());
						    		stockManagementVo.setSmQty(bizOrderCheckVo.getStockUseQty());
						    		stockManagementVo.setSmDate(strToday);
						    		stockManagementVo.setSmOutCorpIdx(null);
						    		stockManagementVo.setSmStatus("B"); //출고
						    		stockManagementVo.setSmLotNo("");
						    		stockManagementVo.setSmOutRelationNo(bizOrderCheckVo.getIdx()); 
						    		stockManagementVo.setSmOutWhsGubun("");
						    		stockManagementVo.setSmOutWhsIdx(itemLocationVo.getIdx());
						    		stockManagementVo.setSmOutLocIdx(null);
						    		stockManagementVo.setSmEtc1(null);
						    		stockManagementVo.setSmEtc2(null);
						    		stockManagementVo.setSmEtc3(null);
						    		stockManagementVo.setSmType("출고");
						    		stockManagementVo.setSmType2("BSPO");
						    		stockManagementVo.setSmInWhsGubun("");
						    		stockManagementVo.setSmInWhsIdx(itemLocationVo.getIdx()); 
						    		stockManagementVo.setSmLotNo("");
						    		stockManagementVo.setSmInRelationNo(bizOrderCheckVo.getIdx());
						    		stockManagementVo.setSmDesc("");
						    		stockManagementVo.setSmEtc1("");
						    		stockManagementVo.setSmEtc2("");
						    		stockManagementVo.setSmEtc3("");
						    		prodOutList.add(stockManagementVo);
						    		
						    		StockManagementVo stockManagementInVo = new StockManagementVo();
									stockManagementInVo.setSmItemGubun("001"); //001:제품 , 002:자재
									stockManagementInVo.setSmItemCd(bizOrderCheckVo.getItemIdx()); //품목(제품) 식별자
									stockManagementInVo.setSmItemVersionIdx(bizOrderCheckVo.getItemVerIdx()); //품목(제품) 식별자
									stockManagementInVo.setSmType("입고"); //수불구분
									stockManagementInVo.setSmType2("BSPI"); //업무구분
									stockManagementInVo.setSmDate(strToday); //수불일자
									stockManagementInVo.setSmQty(bizOrderCheckVo.getStockUseQty()); // 수불수량
									stockManagementInVo.setSmLotNo(""); //LOT번호 -> 채번이라서 빈값넘겨줌
									stockManagementInVo.setSmSourceNo(bizOrderCheckVo.getIdx()); //원천번호 -> 수주상세식별자
									stockManagementInVo.setSmInWhsGubun(""); //창고구분 -> 없음 빈값 
									stockManagementInVo.setSmOutWhsIdx(qcLocationVo.getLocationIdx()); //창고식별자 
									stockManagementInVo.setSmInWhsIdx(qcLocationVo.getLocationIdx()); //창고식별자  
						    		
									stockManagementInVo.setSmInGubun("수주재고사용"); //입고구분
									stockManagementInVo.setSmInCorpIdx(""); //입고처
									stockManagementInVo.setSmInRelationNo(bizOrderCheckVo.getIdx()); //원천번호 -> 수주상세식별자
									prodInList.add(stockManagementInVo);
									
									stockManagementController.ProdOutput(prodOutList);
							        stockManagementController.ProdInput(prodInList);
								}
								
								//공정실적여부가 N(미등록인 경우) 품질창고로 제품입고됨
								if("N".equals(bizOrderVo.getResEtc9())) {
									StockManagementVo stockManagementInVo = new StockManagementVo();
									stockManagementInVo.setSmItemGubun("001"); //001:제품 , 002:자재
									stockManagementInVo.setSmItemCd(bizOrderCheckVo.getItemIdx()); //품목(제품) 식별자
									stockManagementInVo.setSmItemVersionIdx(bizOrderCheckVo.getItemVerIdx()); //품목(제품) 식별자
									stockManagementInVo.setSmType("입고"); //수불구분
									stockManagementInVo.setSmType2("NRPI"); //업무구분
									stockManagementInVo.setSmDate(strToday); //수불일자
									stockManagementInVo.setSmQty(bizOrderCheckVo.getOrdQty()); // 수불수량
									stockManagementInVo.setSmLotNo(""); //LOT번호 -> 채번이라서 빈값넘겨줌
									stockManagementInVo.setSmSourceNo(bizOrderCheckVo.getIdx()); //원천번호 -> 수주상세식별자
									stockManagementInVo.setSmInWhsGubun(""); //창고구분 -> 없음 빈값 
									stockManagementInVo.setSmOutWhsIdx(qcLocationVo.getLocationIdx()); //창고식별자 
									stockManagementInVo.setSmInWhsIdx(qcLocationVo.getLocationIdx()); //창고식별자  
						    		
									stockManagementInVo.setSmInGubun("실적 미등록 제품입고"); //입고구분
									stockManagementInVo.setSmInCorpIdx(""); //입고처
									stockManagementInVo.setSmInRelationNo(bizOrderCheckVo.getIdx()); //원천번호 -> 수주상세식별자
									prodInList.add(stockManagementInVo);
									stockManagementController.ProdInput(prodInList);
								}
								
								jsonData.put("result", "ok");		
							} else {
								jsonData.put("result", "fail");		
								jsonData.put("message", bizOrderVo.getResMessage());	
								
							}
						}
		        	}
					
				} else { // 디자인컨펌 N 처리일 경우
					bizOrderVo.setUpdIdx(Utils.getUserIdx());
					bizOrderVo.setUpdDate(DateUtil.getCurrentDateTime());
					//수주별발주의 확정여부 체크 후 N일 경우 진행
					PurchaseOrderVo purchaseOrderVo = new PurchaseOrderVo();
					purchaseOrderVo.setBizOrdDtlIdx(bizOrderVo.getIdx());
					List<PurchaseOrderVo> purchaseOrderVoList = purchaseOrderService.purchaseOrderAdmLstByBizDtlIdx(purchaseOrderVo);
					
					//리스트 사이즈가 0 -> 수주별발주 나간 항목이 없는 것
					if(purchaseOrderVoList.size() == 0) {
						bizOrderService.bizOrderDtlUpd(bizOrderVo);
						if("Y".equals(bizOrderVo.getResultYn())) {
							//재고사용을 풀 경우 재고이동된 항목 삭제	
							//제품출고수불
				    		OutProdWhsAdmVo outProdWhsAdmDisposalVo = new OutProdWhsAdmVo();
				    		outProdWhsAdmDisposalVo.setRelationNo(bizOrderCheckVo.getIdx());
				    		outProdWhsAdmDisposalVo.setOutGubun("수주재고사용");
				    		List<OutProdWhsAdmVo> outProdList = new ArrayList<>();
				    		outProdList = outProdWhsAdmService.getOutSlipNoByRelationNo(outProdWhsAdmDisposalVo);
				    		//제품입고수불
							InProdWhsAdmVo inProdWhsAdmVo = new InProdWhsAdmVo();
							inProdWhsAdmVo.setRelationNo(bizOrderCheckVo.getIdx());
							inProdWhsAdmVo.setInGubun("수주재고사용");
							inProdWhsAdmVo = inProdWhsAdmService.getInSlipNoByRelationNo(inProdWhsAdmVo);
							
							//제품입고 전표 삭제 JSON 배열
							JSONArray outProdDel_array = new JSONArray();
							//수불 삭제 JSON배열
							JSONArray stockDel_array = new JSONArray();
							StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();
							OutProdWhsAdmVo outProdWhsAdmVo = new OutProdWhsAdmVo();
							//해당 전표(제품폐기출고)가 존재한다면 지우고 하도록
							if(outProdList.size() != 0) {
								for(int j=0;j<outProdList.size();j++) {
									JSONObject outProdData = new JSONObject();
									JSONObject stockDelData = new JSONObject();
									outProdData.put("OUT_SLIP_NO", outProdList.get(j).getOutSlipNo());
									outProdData.put("OUT_SLIP_SEQ", outProdList.get(j).getOutSlipSeq());
									outProdDel_array.add(outProdData);
									
							        stockDelData.put("SP_SOURCE_NO", outProdList.get(j).getOutSlipNo() + "-" + outProdList.get(j).getOutSlipSeq());
							        stockDel_array.add(stockDelData);
								}
							}
							//해당 전표가 존재한다면 지우고 하도록
							if(inProdWhsAdmVo != null) {
								//제품입고전표 삭제 배열
								JSONArray inProdDel_array = new JSONArray();
								JSONObject inProdData = new JSONObject();
								inProdData.put("IN_SLIP_NO", inProdWhsAdmVo.getInSlipNo() );
								inProdData.put("IN_SLIP_SEQ", inProdWhsAdmVo.getInSlipSeq());
								inProdDel_array.add(inProdData);
								inProdWhsAdmVo.setDeleteJson(inProdDel_array.toJSONString());
								
								inProdWhsAdmService.inProdWhsAdmDel(inProdWhsAdmVo); //제품입고 전표 삭제
								//수불 삭제 JSON배열
								JSONObject stockData = new JSONObject();
								stockData.put("SP_SOURCE_NO", inProdWhsAdmVo.getInSlipNo() + "-" + inProdWhsAdmVo.getInSlipSeq());
								stockDel_array.add(stockData);
								
							}
							//실적 미등록으로 제품입고된 것 삭제처리
							inProdWhsAdmVo.setInGubun("실적 미등록 제품입고");
							inProdWhsAdmVo = inProdWhsAdmService.getInSlipNoByRelationNo(inProdWhsAdmVo);
							//해당 전표가 존재한다면 지우고 하도록
							if(inProdWhsAdmVo != null) {
								//제품입고전표 삭제 배열
								JSONArray inProdDel_array = new JSONArray();
								JSONObject inProdData = new JSONObject();
								inProdData.put("IN_SLIP_NO", inProdWhsAdmVo.getInSlipNo() );
								inProdData.put("IN_SLIP_SEQ", inProdWhsAdmVo.getInSlipSeq());
								inProdDel_array.add(inProdData);
								inProdWhsAdmVo.setDeleteJson(inProdDel_array.toJSONString());
								
								inProdWhsAdmService.inProdWhsAdmDel(inProdWhsAdmVo); //제품입고 전표 삭제
								//수불 삭제 JSON배열
								JSONObject stockData = new JSONObject();
								stockData.put("SP_SOURCE_NO", inProdWhsAdmVo.getInSlipNo() + "-" + inProdWhsAdmVo.getInSlipSeq());
								stockDel_array.add(stockData);
								
							}
							
							outProdWhsAdmVo.setDeleteJson(outProdDel_array.toJSONString());
							outProdWhsAdmService.outProdWhsAdmDel(outProdWhsAdmVo); //제품출고 전표 삭제
							stockPaymentAdmVo.setDeleteJson(stockDel_array.toJSONString());
							stockPaymentAdmService.stockPaymentAdmDel(stockPaymentAdmVo); // 제품 입,출고수불 삭제
							jsonData.put("result", "ok");		
						} else {
							jsonData.put("result", "fail");		
							jsonData.put("message", bizOrderVo.getResMessage());	
							
						}
					} else {
						//수주별발주 1개만 쓰니까 0번째의 확정여부들고오면됨
						if("Y".equals(purchaseOrderVoList.get(0).getConfirmYn())) {
							jsonData.put("result", "fail");
							jsonData.put("message", "수주별발주가 확정되었습니다.<br>확인 후 시도해주세요.");
						} else {
							bizOrderService.bizOrderDtlUpd(bizOrderVo);
							if("Y".equals(bizOrderVo.getResultYn())) {
								//재고사용을 풀 경우 재고이동된 항목 삭제	
								//제품출고수불
					    		OutProdWhsAdmVo outProdWhsAdmDisposalVo = new OutProdWhsAdmVo();
					    		outProdWhsAdmDisposalVo.setRelationNo(bizOrderCheckVo.getIdx());
					    		outProdWhsAdmDisposalVo.setOutGubun("수주재고사용");
					    		List<OutProdWhsAdmVo> outProdList = new ArrayList<>();
					    		outProdList = outProdWhsAdmService.getOutSlipNoByRelationNo(outProdWhsAdmDisposalVo);
					    		//제품입고수불
								InProdWhsAdmVo inProdWhsAdmVo = new InProdWhsAdmVo();
								inProdWhsAdmVo.setRelationNo(bizOrderCheckVo.getIdx());
								inProdWhsAdmVo.setInGubun("수주재고사용");
								inProdWhsAdmVo = inProdWhsAdmService.getInSlipNoByRelationNo(inProdWhsAdmVo);
								
								//제품입고 전표 삭제 JSON 배열
								JSONArray outProdDel_array = new JSONArray();
								//수불 삭제 JSON배열
								JSONArray stockDel_array = new JSONArray();
								StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();
								OutProdWhsAdmVo outProdWhsAdmVo = new OutProdWhsAdmVo();
								//해당 전표(제품폐기출고)가 존재한다면 지우고 하도록
								if(outProdList.size() != 0) {
									for(int j=0;j<outProdList.size();j++) {
										JSONObject outProdData = new JSONObject();
										JSONObject stockDelData = new JSONObject();
										outProdData.put("OUT_SLIP_NO", outProdList.get(j).getOutSlipNo());
										outProdData.put("OUT_SLIP_SEQ", outProdList.get(j).getOutSlipSeq());
										outProdDel_array.add(outProdData);
										
								        stockDelData.put("SP_SOURCE_NO", outProdList.get(j).getOutSlipNo() + "-" + outProdList.get(j).getOutSlipSeq());
								        stockDel_array.add(stockDelData);
									}
								}
								//해당 전표가 존재한다면 지우고 하도록
								if(inProdWhsAdmVo != null) {
									//제품입고전표 삭제 배열
									JSONArray inProdDel_array = new JSONArray();
									JSONObject inProdData = new JSONObject();
									inProdData.put("IN_SLIP_NO", inProdWhsAdmVo.getInSlipNo() );
									inProdData.put("IN_SLIP_SEQ", inProdWhsAdmVo.getInSlipSeq());
									inProdDel_array.add(inProdData);
									inProdWhsAdmVo.setDeleteJson(inProdDel_array.toJSONString());
									
									inProdWhsAdmService.inProdWhsAdmDel(inProdWhsAdmVo); //제품입고 전표 삭제
									//수불 삭제 JSON배열
									JSONObject stockData = new JSONObject();
									stockData.put("SP_SOURCE_NO", inProdWhsAdmVo.getInSlipNo() + "-" + inProdWhsAdmVo.getInSlipSeq());
									stockDel_array.add(stockData);
									
								}
								outProdWhsAdmVo.setDeleteJson(outProdDel_array.toJSONString());
								outProdWhsAdmService.outProdWhsAdmDel(outProdWhsAdmVo); //제품출고 전표 삭제
								stockPaymentAdmVo.setDeleteJson(stockDel_array.toJSONString());
								stockPaymentAdmService.stockPaymentAdmDel(stockPaymentAdmVo); // 제품 입,출고수불 삭제
								jsonData.put("result", "ok");		
							} else {
								jsonData.put("result", "fail");		
								jsonData.put("message", bizOrderVo.getResMessage());	
								
							}
						}
					}
					
				}
			} else {
				bizOrderVo.setUpdIdx(Utils.getUserIdx());
				bizOrderVo.setUpdDate(DateUtil.getCurrentDateTime());
				bizOrderService.bizOrderDtlUpd(bizOrderVo);
				if("Y".equals(bizOrderVo.getResultYn())) {
					jsonData.put("result", "ok");		
				} else {
					jsonData.put("result", "fail");		
					jsonData.put("message", bizOrderVo.getResMessage());	
					
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 수주관리 상세 수정
	@RequestMapping(value = "bs/bizOrderDtlStockYnUpd", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrderDtlStockYnUpd(BizOrderVo bizOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주관리 상세 수정");
		try {
			boolean spQtycheck = true;
			BizOrderVo bizOrderCheckVo = bizOrderService.bizOrderDtlSel(bizOrderVo);
			
			int stockUseQty = (int)Double.parseDouble(bizOrderCheckVo.getStockUseQty());
			// 해당 itemIdx의 현재고량 조회
	        bizOrderVo.setStringItemIdx(bizOrderCheckVo.getItemIdx());
	        List<BizOrderVo> spQtyLst = bizOrderService.bizOrderSpQtySel(bizOrderVo);
	        int spQty = 0;
	        BizOrderVo filterVo = spQtyLst.stream()
								 	    .filter(v -> StringUtils.equals(bizOrderCheckVo.getItemIdx(), v.getItemIdx()))
									    .findAny()
									    .orElse(null);
			if(filterVo != null) {
				spQty = (int)Double.parseDouble(filterVo.getSpQty());
			}
			//재고사용수량이 더 클 경우 -> -재고되서 등록불가능
        	if( stockUseQty > spQty ) {
        		jsonData.put("message", "현재고 부족으로 인해<br>재고사용 할 수 없습니다.");
				jsonData.put("result", "fail");
				spQtycheck = false;
        	}
	        if(spQtycheck) {
	        	//제품 품질창고(QC) 가능한 창고 조회
				WorkOrderVo qcLocationVo = new WorkOrderVo();
				qcLocationVo = workOrderService.workInProdLocationList(qcLocationVo);
				//제품 입출고 가능한 창고 조회
				LocationVo itemLocationVo = new LocationVo();
				itemLocationVo = locationService.possibleInOutItemLocationSel(itemLocationVo);
				
				if(qcLocationVo == null) {
					jsonData.put("message", "QC 가능한 창고가 <br>없습니다.");
					jsonData.put("result", "fail");
				} else if(itemLocationVo == null) {
					jsonData.put("message", "제품 입출고 가능한 창고가 <br>없습니다.");
					jsonData.put("result", "fail");
				} else {
					bizOrderVo.setUpdIdx(Utils.getUserIdx());
					bizOrderVo.setUpdDate(DateUtil.getCurrentDateTime());
		
					bizOrderService.bizOrderDtlStockYnUpd(bizOrderVo);
					//출고목록(완제품)
					List<StockManagementVo> prodOutList = new ArrayList<>();
					//입고목록(QC창고)
					List<StockManagementVo> prodInList = new ArrayList<>();
					// 오늘 날짜
					Date today = new Date();	
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
					// 문자열을 Date 객체로 파싱
					String strToday = sdf.format(today);
					
					if("Y".equals(bizOrderVo.getResultYn())) {
						if("Y".equals(bizOrderVo.getStockUseYn())) {
							//재고사용인경우 완제품->품질창고로 재고이동됨
							StockManagementVo stockManagementVo = new StockManagementVo();
							stockManagementVo.setSmItemGubun("001");
				    		stockManagementVo.setSmOutGubun("수주재고사용");
				    		stockManagementVo.setSmItemIdx(bizOrderCheckVo.getItemIdx());
				    		stockManagementVo.setSmItemVersionIdx(bizOrderCheckVo.getItemVerIdx());
				    		stockManagementVo.setSmCarAssignment(null);
				    		//stockManagementVo.setSmItemCd(jsonObject.get("itemCd").toString());
				    		stockManagementVo.setSmQty(bizOrderCheckVo.getStockUseQty());
				    		stockManagementVo.setSmDate(strToday);
				    		stockManagementVo.setSmOutCorpIdx(null);
				    		stockManagementVo.setSmStatus("B"); //출고
				    		stockManagementVo.setSmLotNo("");
				    		stockManagementVo.setSmOutRelationNo(bizOrderCheckVo.getIdx()); 
				    		stockManagementVo.setSmOutWhsGubun("");
				    		stockManagementVo.setSmOutWhsIdx(itemLocationVo.getIdx());
				    		stockManagementVo.setSmOutLocIdx(null);
				    		stockManagementVo.setSmEtc1(null);
				    		stockManagementVo.setSmEtc2(null);
				    		stockManagementVo.setSmEtc3(null);
				    		stockManagementVo.setSmType("출고");
				    		stockManagementVo.setSmType2("BSPO");
				    		stockManagementVo.setSmInWhsGubun("");
				    		stockManagementVo.setSmInWhsIdx(itemLocationVo.getIdx()); 
				    		stockManagementVo.setSmLotNo("");
				    		stockManagementVo.setSmInRelationNo(bizOrderCheckVo.getIdx());
				    		stockManagementVo.setSmDesc("");
				    		stockManagementVo.setSmEtc1("");
				    		stockManagementVo.setSmEtc2("");
				    		stockManagementVo.setSmEtc3("");
				    		prodOutList.add(stockManagementVo);
				    		
				    		StockManagementVo stockManagementInVo = new StockManagementVo();
							stockManagementInVo.setSmItemGubun("001"); //001:제품 , 002:자재
							stockManagementInVo.setSmItemCd(bizOrderCheckVo.getItemIdx()); //품목(제품) 식별자
							stockManagementInVo.setSmItemVersionIdx(bizOrderCheckVo.getItemVerIdx()); //품목(제품) 식별자
							stockManagementInVo.setSmType("입고"); //수불구분
							stockManagementInVo.setSmType2("BSPI"); //업무구분
							stockManagementInVo.setSmDate(strToday); //수불일자
							stockManagementInVo.setSmQty(bizOrderCheckVo.getStockUseQty()); // 수불수량
							stockManagementInVo.setSmLotNo(""); //LOT번호 -> 채번이라서 빈값넘겨줌
							stockManagementInVo.setSmSourceNo(bizOrderCheckVo.getIdx()); //원천번호 -> 수주상세식별자
							stockManagementInVo.setSmInWhsGubun(""); //창고구분 -> 없음 빈값 
							stockManagementInVo.setSmOutWhsIdx(qcLocationVo.getLocationIdx()); //창고식별자 
							stockManagementInVo.setSmInWhsIdx(qcLocationVo.getLocationIdx()); //창고식별자  
				    		
							stockManagementInVo.setSmInGubun("수주재고사용"); //입고구분
							stockManagementInVo.setSmInCorpIdx(""); //입고처
							stockManagementInVo.setSmInRelationNo(bizOrderCheckVo.getIdx()); //원천번호 -> 수주상세식별자
							prodInList.add(stockManagementInVo);
							
							stockManagementController.ProdOutput(prodOutList);
					        stockManagementController.ProdInput(prodInList);
						} else {
							//재고사용을 풀 경우 재고이동된 항목 삭제	
							//제품출고수불
				    		OutProdWhsAdmVo outProdWhsAdmDisposalVo = new OutProdWhsAdmVo();
				    		outProdWhsAdmDisposalVo.setRelationNo(bizOrderCheckVo.getIdx());
				    		outProdWhsAdmDisposalVo.setOutGubun("수주재고사용");
				    		List<OutProdWhsAdmVo> outProdList = new ArrayList<>();
				    		outProdList = outProdWhsAdmService.getOutSlipNoByRelationNo(outProdWhsAdmDisposalVo);
				    		//제품입고수불
							InProdWhsAdmVo inProdWhsAdmVo = new InProdWhsAdmVo();
							inProdWhsAdmVo.setRelationNo(bizOrderCheckVo.getIdx());
							inProdWhsAdmVo.setInGubun("수주재고사용");
							inProdWhsAdmVo = inProdWhsAdmService.getInSlipNoByRelationNo(inProdWhsAdmVo);
							
							//제품입고 전표 삭제 JSON 배열
							JSONArray outProdDel_array = new JSONArray();
							//수불 삭제 JSON배열
							JSONArray stockDel_array = new JSONArray();
							StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();
							OutProdWhsAdmVo outProdWhsAdmVo = new OutProdWhsAdmVo();
							//해당 전표(제품폐기출고)가 존재한다면 지우고 하도록
							if(outProdList.size() != 0) {
								for(int j=0;j<outProdList.size();j++) {
									JSONObject outProdData = new JSONObject();
									JSONObject stockDelData = new JSONObject();
									outProdData.put("OUT_SLIP_NO", outProdList.get(j).getOutSlipNo());
									outProdData.put("OUT_SLIP_SEQ", outProdList.get(j).getOutSlipSeq());
									outProdDel_array.add(outProdData);
									
							        stockDelData.put("SP_SOURCE_NO", outProdList.get(j).getOutSlipNo() + "-" + outProdList.get(j).getOutSlipSeq());
							        stockDel_array.add(stockDelData);
								}
							}
							//해당 전표가 존재한다면 지우고 하도록
							if(inProdWhsAdmVo != null) {
								//제품입고전표 삭제 배열
								JSONArray inProdDel_array = new JSONArray();
								JSONObject inProdData = new JSONObject();
								inProdData.put("IN_SLIP_NO", inProdWhsAdmVo.getInSlipNo() );
								inProdData.put("IN_SLIP_SEQ", inProdWhsAdmVo.getInSlipSeq());
								inProdDel_array.add(inProdData);
								inProdWhsAdmVo.setDeleteJson(inProdDel_array.toJSONString());
								
								inProdWhsAdmService.inProdWhsAdmDel(inProdWhsAdmVo); //제품입고 전표 삭제
								//수불 삭제 JSON배열
								JSONObject stockData = new JSONObject();
								stockData.put("SP_SOURCE_NO", inProdWhsAdmVo.getInSlipNo() + "-" + inProdWhsAdmVo.getInSlipSeq());
								stockDel_array.add(stockData);
								
							}
							outProdWhsAdmVo.setDeleteJson(outProdDel_array.toJSONString());
							outProdWhsAdmService.outProdWhsAdmDel(outProdWhsAdmVo); //제품출고 전표 삭제
							stockPaymentAdmVo.setDeleteJson(stockDel_array.toJSONString());
							stockPaymentAdmService.stockPaymentAdmDel(stockPaymentAdmVo); // 제품 입,출고수불 삭제
							
						}
						jsonData.put("result", "ok");		
					} else {
						jsonData.put("result", "fail");		
						jsonData.put("message", bizOrderVo.getResMessage());	
						
					}
				}
	        }
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 수주관리 상세 삭제
	@RequestMapping(value = "bs/bizOrderDtlDel", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrderDtlDel(BizOrderVo bizOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주관리 상세 삭제");
		try {
			bizOrderService.bizOrderDtlDel(bizOrderVo);
			if("Y".equals(bizOrderVo.getResultYn())){
				jsonData.put("result", "ok");
			} else {
				jsonData.put("result", "fail");
				jsonData.put("message", bizOrderVo.getResMessage());
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 수주관리 상세 취소
	@RequestMapping(value = "bs/bizOrderDtlCancel", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrderDtlCancel(BizOrderVo bizOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주관리 상세 취소");
		try {
			bizOrderVo.setUpdIdx(Utils.getUserIdx());
			bizOrderVo.setUpdDate(DateUtil.getCurrentDateTime());
			//수불발생
			bizOrderVo.setIdx(bizOrderVo.getBizOrdDtlIdx());
			BizOrderVo bizOrderCheckVo = bizOrderService.bizOrderDtlSel(bizOrderVo);
			
			//폐기창고
			LocationVo locationDisposalVo = new LocationVo();
			locationDisposalVo = locationService.possibleDisposalLocationList(locationDisposalVo);
			
			//제품 품질창고(QC) 가능한 창고 조회
			WorkOrderVo qcLocationVo = new WorkOrderVo();
			qcLocationVo = workOrderService.workInProdLocationList(qcLocationVo);
			
			//제품 입출고 가능한 창고 조회
			LocationVo bundleLocationVo = new LocationVo();
			bundleLocationVo = locationService.possibleInOutItemLocationSel(bundleLocationVo);
			
			if(qcLocationVo == null) {
				jsonData.put("message", "QC 가능한 창고가 <br>없습니다.");
				jsonData.put("result", "fail");
			} else if(locationDisposalVo == null) {
				jsonData.put("message", "폐기 가능한 창고가 <br>없습니다.");
				jsonData.put("result", "fail");
			}else {
				//현재 수주의 상태가 03(수주취소)가 아닐 경우 수불발생
				if(bizOrderCheckVo.getBizStatusCd() != "03") {
					Date today = new Date();	// 오늘 날짜
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
					// 문자열을 Date 객체로 파싱
					String strToday = sdf.format(today);
					//해당 수주의 작업지시 목록
					WorkOrderVo workOrderVo = new WorkOrderVo();
					WorkPlanVo workPlanVo = new WorkPlanVo();
					workPlanVo.setBodIdx(bizOrderVo.getBizOrdDtlIdx());
					List<WorkPlanVo> workOrdList = workPlanService.workOrdLst(workPlanVo);
					bizOrderService.bizOrderDtlCancel(bizOrderVo);
					if("Y".equals(bizOrderVo.getResultYn())) {
						for( int i = 0 ; i < workOrdList.size() ; i++ ) {
							logger.info("수주에 묶인 작지식별자 : "+workOrdList.get(i).getIdx());
							workOrderVo.setWorkOrdIdx(workOrdList.get(i).getIdx());
							
							//작업지시에 물린 맨마지막 공정
							WorkOrderVo workOrdLastPrcssVo = workOrderService.workOrdLastPrcssSel(workOrderVo);
							if (workOrdLastPrcssVo == null) {
							    // workOrdLastPrcssVo가 null인 경우 빈 값으로 초기화
							    workOrdLastPrcssVo = new WorkOrderVo();
							    workOrdLastPrcssVo.setProgressStatus("");
							}
							//마지막 공정이 완료일 경우 품질상태 찾아서 -> 수불 발생시켜줘야함
							//마지막 공정이 완료가 아닐 경우엔 수불이 발생한게 아니라서 따로 수불 발생시킬 필요가 없다고 하심 20230118 
							if("WC".equals(workOrdLastPrcssVo.getProgressStatus())) {
								//해당 생산실적 리스트 
								workOrderVo.setWorkOrdPrcssIdx(workOrdLastPrcssVo.getWorkOrdPrcssIdx());
								List<WorkOrderVo> workOrdPrcssResultList = workOrderService.workOrdResultListByPrcss(workOrderVo);
								//실적만큼 for
								for(int j=0;j<workOrdPrcssResultList.size();j++) {
									workOrderVo.setWorkOrdResultIdx(workOrdPrcssResultList.get(j).getIdx());
									//품질 조회
									WorkOrderVo workOrdLastPrcssqualityVo = workOrderService.workOrdPrcssResultQualitySelByWorkOrdPrcssIdx(workOrderVo);
									if(workOrdLastPrcssqualityVo != null) {
										if(!"01".equals(workOrdLastPrcssqualityVo.getConfirmCd())) {
											//승인상태가 아닌경우 -> 품질창고
											//수불처리
											List<StockManagementVo> stockManagementVoList = new ArrayList<>();
											List<StockManagementVo> stockManagementVoDisInList = new ArrayList<>();
											StockManagementVo stockManagementVo = new StockManagementVo();
											//출고처리 리스트
								    		stockManagementVo.setSmItemGubun("001");
								    		stockManagementVo.setSmOutGubun("제품폐기출고");
								    		stockManagementVo.setSmItemIdx(bizOrderCheckVo.getItemIdx());
								    		stockManagementVo.setSmItemVersionIdx(bizOrderCheckVo.getItemVerIdx());
								    		stockManagementVo.setSmCarAssignment("");
								    		stockManagementVo.setSmItemCd(bizOrderCheckVo.getItemIdx());
								    		stockManagementVo.setSmQty(workOrdPrcssResultList.get(j).getFairQty());
								    		stockManagementVo.setSmDate(strToday);
								    		stockManagementVo.setSmOutCorpIdx("");
								    		stockManagementVo.setSmStatus("B");
								    		stockManagementVo.setSmLotNo("");
								    		stockManagementVo.setSmOutRelationNo(workOrdPrcssResultList.get(j).getIdx());
								    		stockManagementVo.setSmOutWhsGubun("");
								    		stockManagementVo.setSmOutWhsIdx(qcLocationVo.getLocationIdx());
								    		stockManagementVo.setSmOutLocIdx(null);
								    		stockManagementVo.setSmEtc1("");
								    		stockManagementVo.setSmEtc2("");
								    		stockManagementVo.setSmEtc3("");
								    		
								    		stockManagementVo.setSmType("출고");
								    		stockManagementVo.setSmType2("ODP"); //제품폐기출고
								    		stockManagementVo.setSmInWhsGubun("");
								    		//stockManagementVo.setSmOutWhsIdx(qcLocationVo.getIdx());
								    		//stockManagementVo.setSmInWhsIdx(qcLocationVo.getIdx());
								    		stockManagementVo.setSmLotNo("");
								    		stockManagementVo.setSmInRelationNo(workOrdPrcssResultList.get(j).getIdx());
								    		stockManagementVo.setSmDesc("");
								    		stockManagementVo.setSmEtc1("");
								    		stockManagementVo.setSmEtc2("");
								    		stockManagementVo.setSmEtc3("");
								    		stockManagementVoList.add(stockManagementVo);
								    		
								    		//품질창고 출고처리
								    		stockManagementController.ProdOutput(stockManagementVoList);
								    		
								    		//폐기창고 입고처리리스트
								    		stockManagementVo.setSmItemGubun("001"); //001:제품 , 002:자재
								    		stockManagementVo.setSmItemCd(bizOrderCheckVo.getItemIdx()); //품목(제품) 식별자
								    		stockManagementVo.setSmItemVersionIdx(bizOrderCheckVo.getItemVerIdx()); //품목(제품) 식별자
								    		stockManagementVo.setSmType("입고"); //수불구분
								    		stockManagementVo.setSmType2("IDP"); //업무구분
											stockManagementVo.setSmDate(strToday); //수불일자
											stockManagementVo.setSmQty(workOrdPrcssResultList.get(j).getFairQty()); // 수불수량
											stockManagementVo.setSmLotNo(""); //LOT번호 -> 채번이라서 빈값넘겨줌
											stockManagementVo.setSmSourceNo(workOrdPrcssResultList.get(j).getIdx()); //원천번호 -> 실적식별자
											stockManagementVo.setSmInWhsGubun(""); //창고구분 -> 없음 빈값 
											stockManagementVo.setSmOutWhsIdx(locationDisposalVo.getIdx()); //창고식별자 
											stockManagementVo.setSmInWhsIdx(locationDisposalVo.getIdx()); //창고식별자  
											stockManagementVo.setSmInGubun("제품폐기입고"); //입고구분
											stockManagementVo.setSmInCorpIdx(""); //입고처
											stockManagementVo.setSmInRelationNo(workOrdPrcssResultList.get(j).getIdx()); //원천번호 -> 실적식별자
								    		stockManagementVoDisInList.add(stockManagementVo);
											
											//폐기창고 입고처리
								    		stockManagementController.ProdInput(stockManagementVoDisInList);
										} else {
											//승인상태인 경우 -> 품질에서 출고되고 완제품이든 부적합이든 입고된상태
											if("02".equals(workOrdLastPrcssqualityVo.getQualityJudgmentCd())) {
												//합격인경우 -> 완제품 창고, 완제품창고 출고 폐기창고 입고
												//수불처리
												List<StockManagementVo> stockManagementVoList = new ArrayList<>();
												List<StockManagementVo> stockManagementVoDisInList = new ArrayList<>();
												StockManagementVo stockManagementVo = new StockManagementVo();
									    		//출고처리 리스트
									    		stockManagementVo.setSmItemGubun("001");
									    		stockManagementVo.setSmOutGubun("제품폐기출고");
									    		stockManagementVo.setSmItemIdx(bizOrderCheckVo.getItemIdx());
									    		stockManagementVo.setSmItemVersionIdx(bizOrderCheckVo.getItemVerIdx());
									    		stockManagementVo.setSmCarAssignment("");
									    		stockManagementVo.setSmItemCd(bizOrderCheckVo.getItemIdx());
									    		stockManagementVo.setSmQty(workOrdLastPrcssqualityVo.getPassQty());
									    		stockManagementVo.setSmDate(strToday);
									    		stockManagementVo.setSmOutCorpIdx("");
									    		stockManagementVo.setSmStatus("B");
									    		stockManagementVo.setSmLotNo("");
									    		stockManagementVo.setSmOutRelationNo(workOrdPrcssResultList.get(j).getIdx());
									    		stockManagementVo.setSmOutWhsGubun("");
									    		stockManagementVo.setSmOutWhsIdx(bundleLocationVo.getIdx());
									    		stockManagementVo.setSmOutLocIdx(null);
									    		stockManagementVo.setSmEtc1("");
									    		stockManagementVo.setSmEtc2("");
									    		stockManagementVo.setSmEtc3("");
									    		
									    		stockManagementVo.setSmType("출고");
									    		stockManagementVo.setSmType2("ODP"); //제품폐기출고
									    		stockManagementVo.setSmInWhsGubun("");
									    		//stockManagementVo.setSmOutWhsIdx(qcLocationVo.getIdx());
									    		//stockManagementVo.setSmInWhsIdx(qcLocationVo.getIdx());
									    		stockManagementVo.setSmLotNo("");
									    		stockManagementVo.setSmInRelationNo(workOrdPrcssResultList.get(j).getIdx());
									    		stockManagementVo.setSmDesc("");
									    		stockManagementVo.setSmEtc1("");
									    		stockManagementVo.setSmEtc2("");
									    		stockManagementVo.setSmEtc3("");
									    		stockManagementVoList.add(stockManagementVo);
									    		
									    		//품질창고 출고처리
									    		stockManagementController.ProdOutput(stockManagementVoList);
									    		
									    		//폐기창고 입고처리리스트
									    		stockManagementVo.setSmItemGubun("001"); //001:제품 , 002:자재
									    		stockManagementVo.setSmItemCd(bizOrderCheckVo.getItemIdx()); //품목(제품) 식별자
									    		stockManagementVo.setSmItemVersionIdx(bizOrderCheckVo.getItemVerIdx()); //품목(제품) 식별자
									    		stockManagementVo.setSmType("입고"); //수불구분
									    		stockManagementVo.setSmType2("IDP"); //업무구분
												stockManagementVo.setSmDate(strToday); //수불일자
												stockManagementVo.setSmQty(workOrdLastPrcssqualityVo.getPassQty()); // 수불수량
												stockManagementVo.setSmLotNo(""); //LOT번호 -> 채번이라서 빈값넘겨줌
												stockManagementVo.setSmSourceNo(workOrdPrcssResultList.get(j).getIdx()); //원천번호 -> 실적식별자
												stockManagementVo.setSmInWhsGubun(""); //창고구분 -> 없음 빈값 
												stockManagementVo.setSmOutWhsIdx(locationDisposalVo.getIdx()); //창고식별자 
												stockManagementVo.setSmInWhsIdx(locationDisposalVo.getIdx()); //창고식별자  
												stockManagementVo.setSmInGubun("제품폐기입고"); //입고구분
												stockManagementVo.setSmInCorpIdx(""); //입고처
												stockManagementVo.setSmInRelationNo(workOrdPrcssResultList.get(j).getIdx()); //원천번호 -> 실적식별자
									    		stockManagementVoDisInList.add(stockManagementVo);
												
												//폐기창고 입고처리
									    		stockManagementController.ProdInput(stockManagementVoDisInList);

									    		
											} else {
												//부적합인경우 -> 폐기창고에 있으니까 굳이 수불발생할필요 X
												
											}
										}
										
									} else {
										//검사 안한상태 -> 품질창고
										//20230118 -> 검사
										//수불처리
										List<StockManagementVo> stockManagementVoList = new ArrayList<>();
										List<StockManagementVo> stockManagementVoDisInList = new ArrayList<>();
										StockManagementVo stockManagementVo = new StockManagementVo();
										//출고처리 리스트
							    		stockManagementVo.setSmItemGubun("001");
							    		stockManagementVo.setSmOutGubun("제품폐기출고");
							    		stockManagementVo.setSmItemIdx(bizOrderCheckVo.getItemIdx());
							    		stockManagementVo.setSmItemVersionIdx(bizOrderCheckVo.getItemVerIdx());
							    		stockManagementVo.setSmCarAssignment("");
							    		stockManagementVo.setSmItemCd(bizOrderCheckVo.getItemIdx());
							    		stockManagementVo.setSmQty(workOrdPrcssResultList.get(j).getFairQty());
							    		stockManagementVo.setSmDate(strToday);
							    		stockManagementVo.setSmOutCorpIdx("");
							    		stockManagementVo.setSmStatus("B");
							    		stockManagementVo.setSmLotNo("");
							    		stockManagementVo.setSmOutRelationNo(workOrdPrcssResultList.get(j).getIdx());
							    		stockManagementVo.setSmOutWhsGubun("");
							    		stockManagementVo.setSmOutWhsIdx(qcLocationVo.getLocationIdx());
							    		stockManagementVo.setSmOutLocIdx(null);
							    		stockManagementVo.setSmEtc1("");
							    		stockManagementVo.setSmEtc2("");
							    		stockManagementVo.setSmEtc3("");
							    		
							    		stockManagementVo.setSmType("출고");
							    		stockManagementVo.setSmType2("ODP"); //제품폐기출고
							    		stockManagementVo.setSmInWhsGubun("");
							    		//stockManagementVo.setSmOutWhsIdx(qcLocationVo.getIdx());
							    		//stockManagementVo.setSmInWhsIdx(qcLocationVo.getIdx());
							    		stockManagementVo.setSmLotNo("");
							    		stockManagementVo.setSmInRelationNo(workOrdPrcssResultList.get(j).getIdx());
							    		stockManagementVo.setSmDesc("");
							    		stockManagementVo.setSmEtc1("");
							    		stockManagementVo.setSmEtc2("");
							    		stockManagementVo.setSmEtc3("");
							    		stockManagementVoList.add(stockManagementVo);
							    		
							    		//품질창고 출고처리
							    		stockManagementController.ProdOutput(stockManagementVoList);
							    		
							    		//폐기창고 입고처리리스트
							    		stockManagementVo.setSmItemGubun("001"); //001:제품 , 002:자재
							    		stockManagementVo.setSmItemCd(bizOrderCheckVo.getItemIdx()); //품목(제품) 식별자
							    		stockManagementVo.setSmItemVersionIdx(bizOrderCheckVo.getItemVerIdx()); //품목(제품) 식별자
							    		stockManagementVo.setSmType("입고"); //수불구분
							    		stockManagementVo.setSmType2("IDP"); //업무구분
										stockManagementVo.setSmDate(strToday); //수불일자
										stockManagementVo.setSmQty(workOrdPrcssResultList.get(j).getFairQty()); // 수불수량
										stockManagementVo.setSmLotNo(""); //LOT번호 -> 채번이라서 빈값넘겨줌
										stockManagementVo.setSmSourceNo(workOrdPrcssResultList.get(j).getIdx()); //원천번호 -> 실적식별자
										stockManagementVo.setSmInWhsGubun(""); //창고구분 -> 없음 빈값 
										stockManagementVo.setSmOutWhsIdx(locationDisposalVo.getIdx()); //창고식별자 
										stockManagementVo.setSmInWhsIdx(locationDisposalVo.getIdx()); //창고식별자  
										stockManagementVo.setSmInGubun("제품폐기입고"); //입고구분
										stockManagementVo.setSmInCorpIdx(""); //입고처
										stockManagementVo.setSmInRelationNo(workOrdPrcssResultList.get(j).getIdx()); //원천번호 -> 실적식별자
							    		stockManagementVoDisInList.add(stockManagementVo);
										
										//폐기창고 입고처리
							    		stockManagementController.ProdInput(stockManagementVoDisInList);
									}
								}
							}
							
							
							//↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑
							//이위로는 마지막 공정거쳐서 나온 제품수불에대한 처리
							//이밑으로는 수불발생했었던 공정들에 대한 수불처리
							//↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
							
							//나중에 수불발생 공정이 2번이상 나올 경우를 생각해서 리스트로 만듬
							
							
							//작지에 물린 공정
							List<WorkOrderVo> workOrdPrcssList = workOrderService.workOrdLstWithPrcssByWorkOrd(workOrderVo);
							//공정의 정보 수불 공정 필터링
							List<WorkOrderVo> workOrdPrcssFilterList = workOrdPrcssList.stream()
																		.filter(v -> StringUtils.equals("Y", v.getStockOption()))
																		.collect(Collectors.toList());
							// 대기가 아닐 경우 해당 실적 가져와서 수불 구분만 바꿔서 똑같이 만들어주기로 함
							for(int q = 0; q < workOrdPrcssFilterList.size() ; q++) {
								//대기가 아니며 마지막 공정이 완료가 아닐 경우(마지막 공정이 완료인 경우 자재 수불을 해줄필요가없기떄문)
								if( !"PI".equals(workOrdPrcssFilterList.get(q).getProgressStatus()) && !"WC".equals(workOrdLastPrcssVo.getProgressStatus())) {
									//해당 생산실적 리스트 
									workOrderVo.setWorkOrdPrcssIdx(workOrdPrcssFilterList.get(q).getWorkOrdPrcssIdx());
									List<WorkOrderVo> workOrdPrcssResultList = workOrderService.workOrdResultListByPrcss(workOrderVo);
									for(int j = 0 ; j < workOrdPrcssResultList.size(); j++) {
										//실적 idx를 들고 자재출고 전표 찾은담에  slipno,seq합쳐서 spSourceNo 연관번호로 찾은 후에 출고수불이랑 출고전표만들어주기
										StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();
										
										//번들링일 경우 수불이 다르게 발생해야함 이었는데 마지막 공정 수불 처리 떄매 추가되면서 의미없어짐
										if("workOrderPrcssBundleModal".equals(workOrdPrcssFilterList.get(q).getResultPageNm())) {
											//공정이 진행중 인경우 해당 실적으로 제품 폐기처리 수불
											/*if("WI".equals(workOrdPrcssFilterList.get(q).getProgressStatus())) {
												//제품 폐기창고 입고 처리
									    		List<StockManagementVo> stockManagementVoDisInList = new ArrayList<>();
									    		StockManagementVo stockManagementVo = new StockManagementVo();
									    		stockManagementVo.setSmNo("");
									    		stockManagementVo.setSmSeq("");
									    		stockManagementVo.setSmQty(workOrdPrcssResultList.get(j).getFairQty());
									    		stockManagementVo.setSmDate(strToday);
									    		stockManagementVo.setSmItemGubun("001");
									    		stockManagementVo.setSmItemIdx(bizOrderCheckVo.getItemIdx());
									    		stockManagementVo.setSmItemCd(bizOrderCheckVo.getItemIdx());
									    		stockManagementVo.setSmInGubun("생산폐기");//입고구분
									    		stockManagementVo.setSmType("입고");
									    		stockManagementVo.setSmType2("IDP");
									    		stockManagementVo.setSmInWhsGubun("");
									    		stockManagementVo.setSmInWhsIdx(locationDisposalVo.getIdx()); 
									    		stockManagementVo.setSmLotNo("");
									    		stockManagementVo.setSmInRelationNo(workOrdPrcssResultList.get(j).getIdx());
									    		stockManagementVo.setSmDesc("");
									    		stockManagementVo.setSmEtc1("");
									    		stockManagementVo.setSmEtc2("");
									    		stockManagementVo.setSmEtc3("");
									    		stockManagementVoDisInList.add(stockManagementVo);
									    		stockManagementController.ProdInput(stockManagementVoDisInList);
											}*/
								    		
										} else {
											// slipno,seq 찾아오는 부분
											OutMatrWhsAdmVo outMatrWhsAdmVo = new OutMatrWhsAdmVo();
											outMatrWhsAdmVo.setRelationNo(workOrdPrcssResultList.get(j).getIdx());
											outMatrWhsAdmVo.setOutGubun("생산투입");
											List<OutMatrWhsAdmVo> outMatrWhsAdmListVo = outMatrWhsAdmService.getOutSlipNoByRelationNo(outMatrWhsAdmVo);
											if(outMatrWhsAdmListVo.size() > 0) {
												for( int k = 0; k < outMatrWhsAdmListVo.size(); k++) {
													stockPaymentAdmVo.setSpSourceNo(outMatrWhsAdmListVo.get(k).getOutSlipNo() + "-" + outMatrWhsAdmListVo.get(k).getOutSlipSeq());
													
													// 해당 수불 찾아오는 부분
													stockPaymentAdmVo = stockPaymentAdmService.stockPaymentAdmSelBySpSourceNo(stockPaymentAdmVo);
													
													//자재 반입입고 처리
													//해당 수불 발생했던 것과 동일하게 반입입고 수불 발생
													List<StockManagementVo> stockManagementVoList = new ArrayList<>();
													StockManagementVo stockManagementVo = new StockManagementVo();
										    		stockManagementVo.setSmNo("");
										    		stockManagementVo.setSmSeq("");
										    		stockManagementVo.setSmQty(stockPaymentAdmVo.getSpQty());
										    		stockManagementVo.setSmDate(strToday);
										    		stockManagementVo.setSmItemGubun(stockPaymentAdmVo.getSpGubun());
										    		stockManagementVo.setSmItemIdx(stockPaymentAdmVo.getSpIdx());
										    		stockManagementVo.setSmInGubun("생산반입");//입고구분
										    		stockManagementVo.setSmType("입고");
										    		stockManagementVo.setSmType2("RIPM");
										    		stockManagementVo.setSmInWhsGubun("");
										    		stockManagementVo.setSmInWhsIdx(stockPaymentAdmVo.getSpWhsIdx()); 
										    		stockManagementVo.setSmLotNo("");
										    		stockManagementVo.setSmInRelationNo(workOrdPrcssResultList.get(j).getIdx());
										    		stockManagementVo.setSmDesc("");
										    		stockManagementVo.setSmEtc1("");
										    		stockManagementVo.setSmEtc2("");
										    		stockManagementVo.setSmEtc3("");
										    		stockManagementVoList.add(stockManagementVo);
										    		stockManagementController.MatrInputOnly(stockManagementVoList);
										    		
										    		//자재 폐기출고 처리
										    		List<StockManagementVo> stockManagementVoDisOutList = new ArrayList<>();
										    		stockManagementVo.setSmItemGubun(stockPaymentAdmVo.getSpGubun()); //001:제품 , 002:자재
													stockManagementVo.setSmItemCd(stockPaymentAdmVo.getSpIdx()); //품목(자재) 식별자
													stockManagementVo.setSmType("출고"); //수불구분
										    		stockManagementVo.setSmType2("OPDM"); //업무구분
										    		stockManagementVo.setSmDate(strToday); //수불일자
										    		stockManagementVo.setSmQty(stockPaymentAdmVo.getSpQty()); // 수불수량
										    		stockManagementVo.setSmLotNo(""); //LOT번호 -> 채번이라서 빈값넘겨줌
										    		stockManagementVo.setSmSourceNo(workOrdPrcssResultList.get(j).getIdx()); //원천번호 -> 생산실적의 식별자
										    		stockManagementVo.setSmOutWhsGubun(""); //창고구분 -> 없음 빈값 
										    		stockManagementVo.setSmOutWhsIdx(stockPaymentAdmVo.getSpWhsIdx()); //창고식별자
										    		stockManagementVo.setSmInWhsIdx(stockPaymentAdmVo.getSpWhsIdx()); //창고식별자  
										    		stockManagementVo.setSmOutLocIdx(""); //위치식별자 -> 안씀 빈값
										    		
										    		stockManagementVo.setSmOutGubun("생산폐기"); //출고구분
										    		stockManagementVo.setSmOutCorpIdx(""); //출고처 -> 없음
										    		stockManagementVo.setSmOutRelationNo(workOrdPrcssResultList.get(j).getIdx()); //연관번호 -> 생산실적의 식별자
										    		stockManagementVoDisOutList.add(stockManagementVo);	
										    		stockManagementController.MatrOutput(stockManagementVoDisOutList);
										    		
										    		//자재 폐기창고 입고 처리
										    		List<StockManagementVo> stockManagementVoDisInList = new ArrayList<>();
										    		stockManagementVo.setSmNo("");
										    		stockManagementVo.setSmSeq("");
										    		stockManagementVo.setSmQty(stockPaymentAdmVo.getSpQty());
										    		stockManagementVo.setSmDate(strToday);
										    		stockManagementVo.setSmItemGubun(stockPaymentAdmVo.getSpGubun());
										    		stockManagementVo.setSmItemIdx(stockPaymentAdmVo.getSpIdx());
										    		stockManagementVo.setSmInGubun("생산폐기");//입고구분
										    		stockManagementVo.setSmType("입고");
										    		stockManagementVo.setSmType2("IDM");
										    		stockManagementVo.setSmInWhsGubun("");
										    		stockManagementVo.setSmInWhsIdx(locationDisposalVo.getIdx()); 
										    		stockManagementVo.setSmLotNo("");
										    		stockManagementVo.setSmInRelationNo(workOrdPrcssResultList.get(j).getIdx());
										    		stockManagementVo.setSmDesc("");
										    		stockManagementVo.setSmEtc1("");
										    		stockManagementVo.setSmEtc2("");
										    		stockManagementVo.setSmEtc3("");
										    		stockManagementVoDisInList.add(stockManagementVo);
										    		stockManagementController.MatrInputOnly(stockManagementVoDisInList);
												}
											}
											
										}
									}
								}
							}
						}
						
						jsonData.put("result", "ok");	
					} else {
						jsonData.put("result", "fail");
						jsonData.put("message", bizOrderVo.getResMessage());
					}
				}
				
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 수주관리 상세 PO완료처리
	@RequestMapping(value = "bs/bizOrderDtlPoEnd", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrderDtlPoEnd(BizOrderVo bizOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주관리 상세 PO완료처리");
		try {
			bizOrderVo.setUpdIdx(Utils.getUserIdx());
			bizOrderVo.setUpdDate(DateUtil.getCurrentDateTime());
			bizOrderService.bizOrderDtlPoEnd(bizOrderVo);
			if("Y".equals(bizOrderVo.getResultYn())){
				jsonData.put("result", "ok");
			} else {
				jsonData.put("result", "fail");
				jsonData.put("message", bizOrderVo.getResMessage());
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 수주관리 상세 PO완료처리
	@RequestMapping(value = "bs/bizOrderDtlPoEndByBizOrdDtlIdxString", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrderDtlPoEndByBizOrdDtlIdxString(BizOrderVo bizOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주관리 상세 PO완료처리");
		try {
			bizOrderVo.setUpdIdx(Utils.getUserIdx());
			bizOrderVo.setUpdDate(DateUtil.getCurrentDateTime());
			bizOrderService.bizOrderDtlPoEndByBizOrdDtlIdxString(bizOrderVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	
	// 수주관리 상세 버전 최신화(업데이트)
	@RequestMapping(value = "bs/bizOrderDtlItemVersionUpd", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrderDtlItemVersionUpd(BizOrderVo bizOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주관리 상세 버전 최신화(업데이트)");
		try {
			bizOrderVo.setUpdIdx(Utils.getUserIdx());
			bizOrderVo.setUpdDate(DateUtil.getCurrentDateTime());
			bizOrderService.bizOrderDtlItemVersionUpd(bizOrderVo);
			if("Y".equals(bizOrderVo.getResultYn())){
				jsonData.put("result", "ok");
			} else {
				jsonData.put("result", "fail");
				jsonData.put("message", bizOrderVo.getResMessage());
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	// =========================== 수주현황 ==========================================
	// 수주관리 전체 목록조회(수주별발주미포함)
	@RequestMapping(value = "bs/bizOrderStatusLst", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrderStatusLst(BizOrderVo bizOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주관리 전체 목록조회(수주별발주미포함)");
		try {
			List<BizOrderVo> bizOrderVoList = bizOrderService.bizOrderStatusLst(bizOrderVo);
			jsonData.put("data", bizOrderVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 수주관리 전체 목록조회(수주별발주포함)
	@RequestMapping(value = "bs/bizOrderStatusLstWithPO", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrderStatusLstWithPO(BizOrderVo bizOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주관리 전체 목록조회(수주별발주포함)");
		try {
			List<BizOrderVo> bizOrderVoList = bizOrderService.bizOrderStatusLstWithPO(bizOrderVo);
			jsonData.put("data", bizOrderVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// =========================== 공정정보 ==========================================
	//수주관리 제품공정 목록조회
	@RequestMapping(value = "bs/bizOrderItemPrcssList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> bizOrderItemPrcssList(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
	
		logger.info("수주관리 제품공정 목록조회 : " + itemInfoAdmVo);
		try {
			List<ItemInfoAdmVo> ItemInfoAdmVoList = bizOrderService.bizOrderItemPrcssList(itemInfoAdmVo);
			jsonData.put("data", ItemInfoAdmVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//수주관리 작지공정 목록
	@RequestMapping(value = "bs/bizOrderWorkOrderPrcssList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrderWorkOrderPrcssList(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
	
		logger.info("수주관리 작지공정 목록조회 : " + itemInfoAdmVo);
		try {
			List<ItemInfoAdmVo> ItemInfoAdmVoList = bizOrderService.bizOrderWorkOrderPrcssList(itemInfoAdmVo);
			jsonData.put("data", ItemInfoAdmVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//수주관리 제품공정 작업계획확정 전 작업지시 체크
	@RequestMapping(value = "bs/bizOrderWorkOrderCheckList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrderWorkOrderCheckList(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
	
		logger.info("수주관리 제품공정 작업계획확정 전 작업지시 체크 : " + itemInfoAdmVo);
		try {
			List<ItemInfoAdmVo> ItemInfoAdmVoList = bizOrderService.bizOrderWorkOrderCheckList(itemInfoAdmVo);
			jsonData.put("data", ItemInfoAdmVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//수주관리 제품공정 작업계획확정
	@RequestMapping(value = "bs/bizOrderWorkOrderInsert", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrderWorkOrderInsert(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주관리 제품공정 작업계획확정");
		try {
			itemInfoAdmVo.setRegIdx(Utils.getUserIdx());
			itemInfoAdmVo.setRegDate(DateUtil.getCurrentDateTime());
			bizOrderService.bizOrderWorkOrderInsert(itemInfoAdmVo);
			if("Y".equals(itemInfoAdmVo.getResultYn())) {
				jsonData.put("result", "ok");
			} else {
				jsonData.put("result", "fail");
				jsonData.put("message", itemInfoAdmVo.getResMessage());
				
			}
		
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//수주관리 제품공정 작업계획취소
	@RequestMapping(value = "bs/bizOrderWorkOrderDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrderWorkOrderDelete(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주관리 제품공정 작업계획취소");
		try {
			bizOrderService.bizOrderWorkOrderDelete(itemInfoAdmVo);
			if("Y".equals(itemInfoAdmVo.getResultYn())) {
				jsonData.put("result", "ok");
			} else {
				jsonData.put("result", "fail");
				jsonData.put("message", itemInfoAdmVo.getResMessage());
				
			}
		
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//수주관리 제품공정 복사
	@RequestMapping(value = "bs/bizOrderItemPrcssCopy", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrderItemPrcssCopy(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주관리 제품공정 복사");
		try {
			itemInfoAdmVo.setRegIdx(Utils.getUserIdx());
			itemInfoAdmVo.setRegDate(DateUtil.getCurrentDateTime());
			bizOrderService.bizOrderItemPrcssCopy(itemInfoAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//수주관리 제품공정 등록
	@RequestMapping(value = "bs/bizOrderItemPrcssInsert", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrderItemPrcssInsert(ItemInfoAdmVo itemInfoAdmVo,
															@RequestParam(value="insertList", required=false) String insertList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주관리 제품공정 등록");
		try {
			itemInfoAdmVo.setInsertList(insertList);
			itemInfoAdmVo.setRegIdx(Utils.getUserIdx());
			itemInfoAdmVo.setRegDate(DateUtil.getCurrentDateTime());
			bizOrderService.bizOrderItemPrcssInsert(itemInfoAdmVo);
			if("Y".equals(itemInfoAdmVo.getResultYn())) {
				jsonData.put("result", "ok");
			} else {
				jsonData.put("result", "fail");
				jsonData.put("message", itemInfoAdmVo.getResMessage());
			}
		
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//수주관리 제품공정 삭제
	@RequestMapping(value = "bs/bizOrderItemPrcssDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrderItemPrcssDelete(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주관리 제품공정 삭제");
		try {
			bizOrderService.bizOrderItemPrcssDelete(itemInfoAdmVo);
			if("Y".equals(itemInfoAdmVo.getResultYn())) {
				jsonData.put("result", "ok");
			} else {
				jsonData.put("result", "fail");
				jsonData.put("message", itemInfoAdmVo.getResMessage());
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// =========================== 투입자재정보 ==========================================
	//수주관리 제품투입자재 목록조회
	@RequestMapping(value = "bs/bizOrderItemBomList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> bizOrderItemBomList(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
	
		logger.info("수주관리 제품투입자재 목록조회 : " + itemInfoAdmVo);
		try {
			List<ItemInfoAdmVo> ItemInfoAdmVoList = bizOrderService.bizOrderItemBomList(itemInfoAdmVo);
			jsonData.put("data", ItemInfoAdmVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//수주관리 제품투입자재 등록
	@RequestMapping(value = "bs/bizOrderItemBomInsert", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrderItemBomInsert(ItemInfoAdmVo itemInfoAdmVo,
															@RequestParam(value="insertList", required=false) String insertList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주관리 제품투입자재 등록");
		try {
			itemInfoAdmVo.setInsertList(insertList);
			itemInfoAdmVo.setRegIdx(Utils.getUserIdx());
			itemInfoAdmVo.setRegDate(DateUtil.getCurrentDateTime());
			bizOrderService.bizOrderItemBomInsert(itemInfoAdmVo);
			jsonData.put("result", "ok");
		
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//수주관리 제품투입자재 복사
	@RequestMapping(value = "bs/bizOrderItemBomCopy", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrderItemBomCopy(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주관리 제품투입자재 복사");
		try {
			itemInfoAdmVo.setRegIdx(Utils.getUserIdx());
			itemInfoAdmVo.setRegDate(DateUtil.getCurrentDateTime());
			bizOrderService.bizOrderItemBomCopy(itemInfoAdmVo);
			if("Y".equals(itemInfoAdmVo.getResultYn())){
				jsonData.put("result", "ok");
			} else {
				jsonData.put("result", "fail");
				jsonData.put("message", itemInfoAdmVo.getResMessage());
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//수주관리 제품투입자재 삭제
	@RequestMapping(value = "bs/bizOrderItemBomDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrderItemBomDelete(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주관리 제품투입자재 삭제");
		try {
			bizOrderService.bizOrderItemBomDelete(itemInfoAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// =========================== 번들링 ==========================================
	//수주관리 번들링 목록조회
	@RequestMapping(value = "bs/bizOrderDtlBundleList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrderDtlBundleList(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주관리 번들링 목록조회 : " + itemInfoAdmVo);
		try {
			List<ItemInfoAdmVo> ItemInfoAdmVoList = bizOrderService.bizOrderDtlBundleList(itemInfoAdmVo);
			jsonData.put("data", ItemInfoAdmVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//수주관리 번들링 등록
	@RequestMapping(value = "bs/bizOrderDtlBundleIns", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrderDtlBundleIns(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주관리 번들링 등록");
		try {
			itemInfoAdmVo.setRegIdx(Utils.getUserIdx());
			itemInfoAdmVo.setRegDate(DateUtil.getCurrentDateTime());
			itemInfoAdmVo.setUpdIdx(Utils.getUserIdx());
			itemInfoAdmVo.setUpdDate(DateUtil.getCurrentDateTime());
			bizOrderService.bizOrderDtlBundleIns(itemInfoAdmVo);
			if("Y".equals(itemInfoAdmVo.getResultYn())) {
				jsonData.put("result", "ok");
			} else {
				jsonData.put("result", "fail");
				jsonData.put("message", itemInfoAdmVo.getResMessage());
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//수주관리 번들링 복사
	@RequestMapping(value = "bs/bizOrderDtlBundleCopy", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrderDtlBundleCopy(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주관리 번들링 복사");
		try {
			itemInfoAdmVo.setRegIdx(Utils.getUserIdx());
			itemInfoAdmVo.setRegDate(DateUtil.getCurrentDateTime());
			bizOrderService.bizOrderDtlBundleCopy(itemInfoAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//수주관리 번들링 삭제
	@RequestMapping(value = "bs/bizOrderDtlBundleDel", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrderDtlBundleDel(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주관리 번들링 삭제");
		try {
			bizOrderService.bizOrderDtlBundleDel(itemInfoAdmVo);
			if("Y".equals(itemInfoAdmVo.getResultYn())) {
				jsonData.put("result", "ok");
			} else {
				jsonData.put("result", "fail");
				jsonData.put("message", itemInfoAdmVo.getResMessage());
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// =========================== 수주관리 메인 ==========================================
	// 수주관리 수주집계표 수주기간별 수주처 목록조회
	@RequestMapping(value = "bs/bizOrderAdmLstAsDealCorp", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrderAdmLstAsDealCorp(BizOrderVo bizOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주관리 수주집계표 수주기간별 수주처 목록조회");
		try {
			List<BizOrderVo> bizOrderVoList = bizOrderService.bizOrderAdmLstAsDealCorp(bizOrderVo);
			jsonData.put("data", bizOrderVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 수주관리 수주집계표 수주처별 목록조회
	@RequestMapping(value = "bs/bizOrderDtlLstByDealCorp", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrderDtlLstByDealCorp(BizOrderVo bizOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주관리 수주집계표 수주처별 목록조회");
		try {
			List<BizOrderVo> bizOrderVoList = bizOrderService.bizOrderDtlLstByDealCorp(bizOrderVo);
			jsonData.put("data", bizOrderVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	
	// 번들링 구성품 목록
	@RequestMapping(value = "bs/bizItemBundleList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> bizItemBundleList(BizOrderVo bizOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("번들링 구성품 목록");
		try {
			List<BizOrderVo> bizOrderVoList = bizOrderService.bizItemBundleList(bizOrderVo);
			jsonData.put("data", bizOrderVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// FSC 제품 목록조회
	@RequestMapping(value = "bs/fscItemList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> fscItemList(BizOrderVo bizOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("FSC 제품 목록조회");
		try {
			List<BizOrderVo> list = bizOrderService.fscItemList(bizOrderVo);
			jsonData.put("data", list);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
}
