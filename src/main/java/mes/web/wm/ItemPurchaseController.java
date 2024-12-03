package mes.web.wm;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.binary.StringUtils;
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

import mes.domain.bm.ItemInfoAdmVo;
import mes.domain.bm.LocationVo;
import mes.domain.sm.CommonCodeVo;
import mes.domain.stock.InProdWhsAdmVo;
import mes.domain.stock.OutMatrWhsAdmVo;
import mes.domain.stock.StockManagementVo;
import mes.domain.stock.StockPaymentAdmVo;
import mes.domain.wm.ItemPurchaseVo;
import mes.domain.wm.WorkOrderVo;
import mes.domain.wm.WorkPlanVo;
import mes.service.bm.ItemInfoAdmService;
import mes.service.bm.LocationService;
import mes.service.stock.InProdWhsAdmService;
import mes.service.stock.OutMatrWhsAdmService;
import mes.service.stock.StockPaymentAdmService;
import mes.service.wm.ItemPurchaseService;
import mes.service.wm.WorkOrderService;
import mes.web.stock.StockManagementController;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
@RequestMapping("/")
public class ItemPurchaseController {
	
	@Inject
	private ItemPurchaseService itemPurchaseService;
	@Inject
	private ItemInfoAdmService itemInfoAdmService;
	@Inject
	private OutMatrWhsAdmService outMatrWhsAdmService;
	@Inject
	private StockManagementController stockManagementController;
	@Inject
	private StockPaymentAdmService stockPaymentAdmService;
	@Inject
	private WorkOrderService workOrderService;
	@Inject
	private LocationService locationService;
	@Inject
	private InProdWhsAdmService inProdWhsAdmService;
	
	private static final Logger logger = LoggerFactory.getLogger(ItemPurchaseController.class);
	
	// wmsc0070
	@RequestMapping(value = "/wm/wmsc0070", method = RequestMethod.GET)
	public ModelAndView wmsc0070(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /wm/wmsc0070");
		mav.setViewName("/wm/wmsc0070");
		return mav;
	}

	//발주목록 조회
	@RequestMapping(value = "wm/itemPurchaseOrdLstGroupByPurchaseNo", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> itemPurchaseOrdLstGroupByPurchaseNo(ItemPurchaseVo itemPurchaseVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("발주목록 조회");
		try {
			List<ItemPurchaseVo> itemPurchaseVoList = itemPurchaseService.itemPurchaseOrdLstGroupByPurchaseNo(itemPurchaseVo);
			jsonData.put("data", itemPurchaseVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//발주목록 조회  - 발주번호 기준
	@RequestMapping(value = "wm/itemPurchaseOrdLstByPurchaseNo", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> itemPurchaseOrdLstByPurchaseNo(ItemPurchaseVo itemPurchaseVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("발주목록 조회");
		try {
			List<ItemPurchaseVo> itemPurchaseVoList = itemPurchaseService.itemPurchaseOrdLstByPurchaseNo(itemPurchaseVo);
			jsonData.put("data", itemPurchaseVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//입고목록 조회  - 발주번호 기준
	@RequestMapping(value = "wm/inItemLstByPurchaseNo", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> inItemLstByPurchaseNo(ItemPurchaseVo itemPurchaseVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("입고목록 조회  - 발주번호 기준");
		try {
			List<ItemPurchaseVo> itemPurchaseVoList = itemPurchaseService.inItemLstByPurchaseNo(itemPurchaseVo);
			jsonData.put("data", itemPurchaseVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//제품발주 등록
	@RequestMapping(value = "wm/itemPurchaseIns", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> itemPurchaseIns(ItemPurchaseVo itemPurchaseVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품발주 등록");
		try {
			//자재 출고처리 가능한 창고 조회
			WorkOrderVo workOrderVo = new WorkOrderVo();
			WorkOrderVo matrlLocationVo = workOrderService.workOrdOutMatrlLocationList(workOrderVo);
			if(matrlLocationVo == null) {
				jsonData.put("message", "자재 출고 가능한 창고가 <br>없습니다.");
				jsonData.put("result", "fail");
			} else {
				itemPurchaseVo.setRegIdx(Utils.getUserIdx());
				itemPurchaseVo.setRegDate(DateUtil.getCurrentDateTime());
				itemPurchaseService.itemPurchaseIns(itemPurchaseVo);
				//마지막에 삽입된 idx를 기준으로 찾은 발주번호 -> 위에서 삽입된 목록조회
				itemPurchaseVo.setPurchaseOrdNo(itemPurchaseVo.getReturnPurchaseOrdNo());
				List<ItemPurchaseVo> itemPurchaseVoList = itemPurchaseService.itemPurchaseOrdLstByPurchaseNo(itemPurchaseVo);
				
				//파싱
				String insertJson = itemPurchaseVo.getInsertJson();
				JSONParser jsonParser = new JSONParser();
				JSONArray dataArray = (JSONArray) jsonParser.parse(insertJson);
				JSONObject jsonObj = new JSONObject();
				
				//상품식별자 배열
				JSONArray itemIdx_array = new JSONArray();
		        for(int i=0;i<dataArray.size();i++) {
		        	jsonObj.put(i, dataArray.get(i));
		    		JSONObject jsonObject = (JSONObject) jsonParser.parse(jsonObj.get(i).toString());
		    		JSONObject itemIdx = new JSONObject();
		    		itemIdx.put("ITEM_IDX", jsonObject.get("ITEM_IDX").toString());
		    		itemIdx_array.add(itemIdx);
		        }
		        
				ItemInfoAdmVo itemInfoAdmVo = new ItemInfoAdmVo();
				itemInfoAdmVo.setItemIdxJson(itemIdx_array.toJSONString());
				List<ItemInfoAdmVo> ItemInfoAdmVoList = itemInfoAdmService.itemBomListByItemIdxJson(itemInfoAdmVo);
				
				// 자재출고 처리 목록
				List<StockManagementVo> stockManagementVoList = new ArrayList<>();
				//해당 투입자재가 있는 경우
				if( ItemInfoAdmVoList.size() > 0 ) {
					StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();
					JSONArray stockDel_array = new JSONArray();
					for( int i = 0 ; i < ItemInfoAdmVoList.size() ; i++ ) {
						StockManagementVo stockManagementVo = new StockManagementVo();
						//수불일자-> 발주일자인데 발주일자는 하나로 통일이라 하나만 담아주면됨, 나중에 편하려고 for문으로 해당 발주일 찾아서 담았음
						String smDate = ""; //수불발생일
						String smQty = "";	//수불수량
						String smSourceNo = ""; //원천번호
						JSONObject jsonPurchaseObj = new JSONObject();
						for(int j=0;j<dataArray.size();j++) {
							jsonPurchaseObj.put(j, dataArray.get(j));
							JSONObject jsonObject = (JSONObject) jsonParser.parse(jsonPurchaseObj.get(j).toString());
							//해당 배열에서 상품식별자 똑같은거 찾아서 발주일, 발주수량 / 상품발주 등록된 항목에서 해당 상품찾아서 해당 상품식별자테이블의 식별자
							if( jsonObject.get("ITEM_IDX").toString().equals(ItemInfoAdmVoList.get(i).getItemIdx()) ) {
								smDate = jsonObject.get("PURCHASE_DATE").toString();
								smQty = jsonObject.get("PURCHASE_QTY").toString();
								List<ItemPurchaseVo> filterList = itemPurchaseVoList.stream()
																				  .filter(v -> StringUtils.equals(jsonObject.get("ITEM_IDX").toString(), v.getItemIdx()))
																				  .collect(Collectors.toList());
								smSourceNo = filterList.get(0).getIdx();
								break;
							}
						}
						
						stockManagementVo.setSmItemGubun("002"); //001:제품 , 002:자재
						stockManagementVo.setSmItemCd(ItemInfoAdmVoList.get(i).getMatrlIdx()); //품목(자재) 식별자
						stockManagementVo.setSmType("출고"); //수불구분
			    		stockManagementVo.setSmType2("OOM"); //업무구분
			    		stockManagementVo.setSmDate(smDate); //수불일자
			    		stockManagementVo.setSmQty( smQty ); // 수불수량
			    		stockManagementVo.setSmLotNo(""); //LOT번호 -> 채번이라서 빈값넘겨줌
			    		stockManagementVo.setSmSourceNo(smSourceNo); //원천번호 -> 상품발주관리 테이블의 식별자
			    		stockManagementVo.setSmOutWhsGubun(""); //창고구분 -> 없음 빈값 
			    		stockManagementVo.setSmOutWhsIdx(matrlLocationVo.getLocationIdx()); //창고식별자
			    		stockManagementVo.setSmInWhsIdx(matrlLocationVo.getLocationIdx()); //창고식별자  
			    		stockManagementVo.setSmOutLocIdx(""); //위치식별자 -> 안씀 빈값
			    		
			    		stockManagementVo.setSmOutGubun("외주출고"); //출고구분
			    		stockManagementVo.setSmOutCorpIdx(""); //출고처 -> 없음
			    		stockManagementVo.setSmOutRelationNo(smSourceNo); //연관번호 -> 상품발주관리 테이블의 식별자
						stockManagementVoList.add(stockManagementVo);	
						
						//자재출고 전표(OUT_SLIP_NO) 조회 -> RELATION_NO로 조회해서 전표 찾은 후에 -> 이미 출고 시킨 자재라면  -> 자재출고전표 지우고 출고수불 지우고 등록
						OutMatrWhsAdmVo outMatrWhsAdmVo = new OutMatrWhsAdmVo();
						outMatrWhsAdmVo.setRelationNo(smSourceNo);
						outMatrWhsAdmVo.setOutGubun("외주출고");
						List<OutMatrWhsAdmVo> outMatrWhsAdmListVo = outMatrWhsAdmService.getOutSlipNoByRelationNo(outMatrWhsAdmVo);
						
						//해당 전표가 존재한다면 지우고 하도록
						if(outMatrWhsAdmListVo.size() > 0) {
							for(int j = 0; j < outMatrWhsAdmListVo.size(); j++) {
								outMatrWhsAdmVo.setOutSlipNo(outMatrWhsAdmListVo.get(j).getOutSlipNo());
								outMatrWhsAdmVo.setOutSlipSeq(outMatrWhsAdmListVo.get(j).getOutSlipSeq());
								outMatrWhsAdmService.outMatrWhsAdmDel(outMatrWhsAdmVo); //자재출고 전표 삭제
								//수불 삭제 JSON배열
								JSONObject stockData = new JSONObject();
								stockData.put("SP_SOURCE_NO", outMatrWhsAdmListVo.get(j).getOutSlipNo() + "-" + outMatrWhsAdmListVo.get(j).getOutSlipSeq());
								stockDel_array.add(stockData);
							}
							
						}
						
					}
					stockPaymentAdmVo.setDeleteJson(stockDel_array.toJSONString());
					stockPaymentAdmService.stockPaymentAdmDel(stockPaymentAdmVo); // 출고수불 삭제		
					//자재출고처리
					stockManagementController.MatrOutput(stockManagementVoList);
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
	
	//제품발주 수정
	@RequestMapping(value = "wm/itemPurchaseUpd", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> itemPurchaseUpd(ItemPurchaseVo itemPurchaseVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품발주 수정");
		try {
			boolean result = true;
			//자재 출고처리 가능한 창고 조회
			WorkOrderVo workOrderVo = new WorkOrderVo();
			WorkOrderVo matrlLocationVo = workOrderService.workOrdOutMatrlLocationList(workOrderVo);
			if(matrlLocationVo == null) {
				jsonData.put("message", "자재 출고 가능한 창고가 <br>없습니다.");
				jsonData.put("result", "fail");
			} else {
				//해당발주번호 상세내역
				List<ItemPurchaseVo> itemPurchaseVoList = itemPurchaseService.itemPurchaseOrdLstByPurchaseNo(itemPurchaseVo);
	
				//파싱
				String updateJson = itemPurchaseVo.getUpdateJson();
				JSONParser jsonParser = new JSONParser();
				JSONArray dataArray = (JSONArray) jsonParser.parse(updateJson);
				JSONObject jsonObj = new JSONObject();
				//실제업데이트 배열
				JSONArray update_array = new JSONArray();
				//상품식별자 배열
				JSONArray itemIdx_array = new JSONArray();
		        for(int i=0;i<dataArray.size();i++) {
		        	jsonObj.put(i, dataArray.get(i));
		    		JSONObject jsonObject = (JSONObject) jsonParser.parse(jsonObj.get(i).toString());
		    		JSONObject itemIdx = new JSONObject();
		    		itemIdx.put("ITEM_IDX", jsonObject.get("ITEM_IDX").toString());
		    		itemIdx_array.add(itemIdx);
		        }
				ItemInfoAdmVo itemInfoAdmVo = new ItemInfoAdmVo();
				itemInfoAdmVo.setItemIdxJson(itemIdx_array.toJSONString());
				List<ItemInfoAdmVo> ItemInfoAdmVoList = itemInfoAdmService.itemBomListByItemIdxJson(itemInfoAdmVo);
				
				//수불
				StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();
				JSONArray stockDel_array = new JSONArray();
				// 자재출고 처리 목록
				List<StockManagementVo> stockManagementVoList = new ArrayList<>();
				for(int i=0;i<dataArray.size();i++) {
		        	jsonObj.put(i, dataArray.get(i));
		    		JSONObject jsonObject = (JSONObject) jsonParser.parse(jsonObj.get(i).toString());
		    		
		    		ItemPurchaseVo filterVo = itemPurchaseVoList.stream()
														 	    .filter(v -> StringUtils.equals(jsonObject.get("ITEM_IDX").toString(), v.getItemIdx()))
															    .findAny()
															    .orElse(null);
		    		if(Float.parseFloat(filterVo.getSumInQty()) == 0) {
		    			JSONObject updateObj = new JSONObject();
			    		updateObj.put("IDX", jsonObject.get("IDX").toString());
			    		updateObj.put("ITEM_IDX", jsonObject.get("ITEM_IDX").toString());
			    		updateObj.put("PURCHASE_CORP_IDX", jsonObject.get("PURCHASE_CORP_IDX").toString());
			    		updateObj.put("PURCHASE_GUBUN", jsonObject.get("PURCHASE_GUBUN").toString());
			    		updateObj.put("PURCHASE_ORD_NO", jsonObject.get("PURCHASE_ORD_NO").toString());
			    		updateObj.put("PURCHASE_DATE", jsonObject.get("PURCHASE_DATE").toString());
			    		updateObj.put("PURCHASE_QTY", jsonObject.get("PURCHASE_QTY").toString());
			    		updateObj.put("BIZ_ORD_DTL_NO", jsonObject.get("BIZ_ORD_DTL_NO").toString());
			    		updateObj.put("PURCHASE_USER_IDX", jsonObject.get("PURCHASE_USER_IDX").toString());
			    		updateObj.put("PURCHASE_DESC", jsonObject.get("PURCHASE_DESC").toString());
			    		update_array.add(updateObj);	
			    		
			    		StockManagementVo stockManagementVo = new StockManagementVo();
			    		stockManagementVo.setSmItemGubun("002"); //001:제품 , 002:자재
						stockManagementVo.setSmItemCd(ItemInfoAdmVoList.get(i).getMatrlIdx()); //품목(자재) 식별자
						stockManagementVo.setSmType("출고"); //수불구분
			    		stockManagementVo.setSmType2("OOM"); //업무구분
			    		stockManagementVo.setSmDate(jsonObject.get("PURCHASE_DATE").toString()); //수불일자
			    		stockManagementVo.setSmQty( jsonObject.get("PURCHASE_QTY").toString() ); // 수불수량
			    		stockManagementVo.setSmLotNo(""); //LOT번호 -> 채번이라서 빈값넘겨줌
			    		stockManagementVo.setSmSourceNo(jsonObject.get("IDX").toString()); //원천번호 -> 상품발주관리 테이블의 식별자
			    		stockManagementVo.setSmOutWhsGubun(""); //창고구분 -> 없음 빈값 
			    		stockManagementVo.setSmOutWhsIdx(matrlLocationVo.getLocationIdx()); //창고식별자
			    		stockManagementVo.setSmInWhsIdx(matrlLocationVo.getLocationIdx()); //창고식별자  
			    		stockManagementVo.setSmOutLocIdx(""); //위치식별자 -> 안씀 빈값
			    		
			    		stockManagementVo.setSmOutGubun("외주출고"); //출고구분
			    		stockManagementVo.setSmOutCorpIdx(""); //출고처 -> 없음
			    		stockManagementVo.setSmOutRelationNo(jsonObject.get("IDX").toString()); //연관번호 -> 상품발주관리 테이블의 식별자
						stockManagementVoList.add(stockManagementVo);	
						
						//자재출고 전표(OUT_SLIP_NO) 조회 -> RELATION_NO로 조회해서 전표 찾은 후에 -> 이미 출고 시킨 자재라면  -> 자재출고전표 지우고 출고수불 지우고 등록
						OutMatrWhsAdmVo outMatrWhsAdmVo = new OutMatrWhsAdmVo();
						outMatrWhsAdmVo.setRelationNo(jsonObject.get("IDX").toString());
						outMatrWhsAdmVo.setOutGubun("외주출고");
						List<OutMatrWhsAdmVo> outMatrWhsAdmListVo = outMatrWhsAdmService.getOutSlipNoByRelationNo(outMatrWhsAdmVo);
						
						//해당 전표가 존재한다면 지우고 하도록
						if(outMatrWhsAdmListVo.size() > 0) {
							for(int j = 0; j < outMatrWhsAdmListVo.size(); j++) {
								outMatrWhsAdmVo.setOutSlipNo(outMatrWhsAdmListVo.get(j).getOutSlipNo());
								outMatrWhsAdmVo.setOutSlipSeq(outMatrWhsAdmListVo.get(j).getOutSlipSeq());
								outMatrWhsAdmService.outMatrWhsAdmDel(outMatrWhsAdmVo); //자재출고 전표 삭제
								//수불 삭제 JSON배열
								JSONObject stockData = new JSONObject();
								stockData.put("SP_SOURCE_NO", outMatrWhsAdmListVo.get(j).getOutSlipNo() + "-" + outMatrWhsAdmListVo.get(j).getOutSlipSeq());
								stockDel_array.add(stockData);
							}
						}
		    		} else {
		    			 result = false;
		    		}
		        }
				stockPaymentAdmVo.setDeleteJson(stockDel_array.toJSONString());
				stockPaymentAdmService.stockPaymentAdmDel(stockPaymentAdmVo); // 출고수불 삭제		
				//자재출고처리
				stockManagementController.MatrOutput(stockManagementVoList);
				
				itemPurchaseVo.setUpdateJson(update_array.toJSONString());
				itemPurchaseVo.setUpdIdx(Utils.getUserIdx());
				itemPurchaseVo.setUpdDate(DateUtil.getCurrentDateTime());
				itemPurchaseService.itemPurchaseUpd(itemPurchaseVo);
				if(result) {
					jsonData.put("result", "ok");
				} else {
					jsonData.put("result", "fail");
					jsonData.put("message", "입고된 항목을 제외하고<br>수정되었습니다.");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//제품발주 삭제처리
	@RequestMapping(value = "wm/itemPurchaseDel", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> itemPurchaseDel(ItemPurchaseVo itemPurchaseVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품발주 삭제처리");
		try {
			boolean result = true;
			//해당발주번호 상세내역
			List<ItemPurchaseVo> itemPurchaseVoList = itemPurchaseService.itemPurchaseOrdLstByPurchaseNo(itemPurchaseVo);
			//파싱
			String deleteJson = itemPurchaseVo.getDeleteJson();
			JSONParser jsonParser = new JSONParser();
			JSONArray dataArray = (JSONArray) jsonParser.parse(deleteJson);
			JSONObject jsonObj = new JSONObject();
			//실제 삭제 배열
			JSONArray delete_array = new JSONArray();
			//수불
			StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();
			JSONArray stockDel_array = new JSONArray();
			for(int i=0;i<dataArray.size();i++) {
	        	jsonObj.put(i, dataArray.get(i));
	    		JSONObject jsonObject = (JSONObject) jsonParser.parse(jsonObj.get(i).toString());
	    		
	    		ItemPurchaseVo filterVo = itemPurchaseVoList.stream()
													 	    .filter(v -> StringUtils.equals(jsonObject.get("IDX").toString(), v.getIdx()))
														    .findAny()
														    .orElse(null);
	    		if(Float.parseFloat(filterVo.getSumInQty()) == 0) {
	    			//실제 삭제처리
	    			JSONObject deleteObj = new JSONObject();
	    			deleteObj.put("IDX", jsonObject.get("IDX").toString());
	    			delete_array.add(deleteObj);
	    			
	    			//자재출고 전표(OUT_SLIP_NO) 조회 -> RELATION_NO로 조회해서 전표 찾은 후에 -> 이미 출고 시킨 자재라면  -> 자재출고전표 지우고 출고수불 지우고 등록
					OutMatrWhsAdmVo outMatrWhsAdmVo = new OutMatrWhsAdmVo();
					outMatrWhsAdmVo.setRelationNo(jsonObject.get("IDX").toString());
					outMatrWhsAdmVo.setOutGubun("외주출고");
					List<OutMatrWhsAdmVo> outMatrWhsAdmListVo = outMatrWhsAdmService.getOutSlipNoByRelationNo(outMatrWhsAdmVo);
					
					//해당 전표가 존재한다면 지우고 하도록
					if(outMatrWhsAdmListVo.size() > 0) {
						for(int j = 0; j < outMatrWhsAdmListVo.size(); j++) {
							outMatrWhsAdmVo.setOutSlipNo(outMatrWhsAdmListVo.get(j).getOutSlipNo());
							outMatrWhsAdmVo.setOutSlipSeq(outMatrWhsAdmListVo.get(j).getOutSlipSeq());
							outMatrWhsAdmService.outMatrWhsAdmDel(outMatrWhsAdmVo); //자재출고 전표 삭제
							//수불 삭제 JSON배열
							JSONObject stockData = new JSONObject();
							stockData.put("SP_SOURCE_NO", outMatrWhsAdmListVo.get(j).getOutSlipNo() + "-" + outMatrWhsAdmListVo.get(j).getOutSlipSeq());
							stockDel_array.add(stockData);
						}
						
					}
	    		} else {
	    			result = false;
	    		}
			}
			stockPaymentAdmVo.setDeleteJson(stockDel_array.toJSONString());
			stockPaymentAdmService.stockPaymentAdmDel(stockPaymentAdmVo); // 출고수불 삭제		
			itemPurchaseService.itemPurchaseDel(itemPurchaseVo);
			if(result) {
				jsonData.put("result", "ok");
			} else {
				jsonData.put("result", "fail");
				jsonData.put("message", "입고된 항목을 제외하고<br>삭제되었습니다.");
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}

	//제품입고목록삭제
	@RequestMapping(value = "wm/itemPurchaseInProdDel", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> itemPurchaseInProdDel(ItemPurchaseVo itemPurchaseVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품입고목록삭제");
		try {
			//파싱
			String deleteJson = itemPurchaseVo.getDeleteJson();
			JSONParser jsonParser = new JSONParser();
			JSONArray dataArray = (JSONArray) jsonParser.parse(deleteJson);
			JSONObject jsonObj = new JSONObject();
			
			

			JSONArray inProdDel_array = new JSONArray();
			
			//수불
			StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();
			JSONArray stockDel_array = new JSONArray();
			
			for(int i=0;i<dataArray.size();i++) {
	        	jsonObj.put(i, dataArray.get(i));
	    		JSONObject jsonObject = (JSONObject) jsonParser.parse(jsonObj.get(i).toString());
	    		
	    		//제품입고전표 삭제 배열
				JSONObject inProdData = new JSONObject();
				inProdData.put("IN_SLIP_NO", jsonObject.get("IN_SLIP_NO").toString() );
				inProdData.put("IN_SLIP_SEQ", jsonObject.get("IN_SLIP_SEQ").toString());
				inProdDel_array.add(inProdData);
				//수불 삭제 JSON배열
				JSONObject stockData = new JSONObject();
				stockData.put("SP_SOURCE_NO", jsonObject.get("IN_SLIP_NO").toString() + "-" + jsonObject.get("IN_SLIP_SEQ").toString());
				stockDel_array.add(stockData);
				
			}

    		InProdWhsAdmVo inProdWhsAdmVo = new InProdWhsAdmVo();
    		inProdWhsAdmVo.setDeleteJson(inProdDel_array.toJSONString());
    		inProdWhsAdmService.inProdWhsAdmDel(inProdWhsAdmVo); //제품입고 전표 삭제
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
	
	//제품발주 입고처리
	@RequestMapping(value = "wm/itemPurchaseInSave", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> itemPurchaseInSave(ItemPurchaseVo itemPurchaseVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품발주 입고처리");
		try {
			//제품 입고 가능한 창고
			LocationVo locationVo = new LocationVo();
			LocationVo locationInVo = locationService.possibleOutItemLocationList(locationVo);
			if(locationInVo == null) {
				jsonData.put("message", "제품 입고 가능한 창고가 <br>없습니다.");
				jsonData.put("result", "fail");
			} else {
				//파싱
				String insertJson = itemPurchaseVo.getInsertJson();
				JSONParser jsonParser = new JSONParser();
				JSONArray dataArray = (JSONArray) jsonParser.parse(insertJson);
				JSONObject jsonObj = new JSONObject();
				// 제품 입고 처리 목록
				List<StockManagementVo> stockManagementVoInList = new ArrayList<>();
		        for(int i=0;i<dataArray.size();i++) {
		        	jsonObj.put(i, dataArray.get(i));
		    		JSONObject jsonObject = (JSONObject) jsonParser.parse(jsonObj.get(i).toString());
		    			
		    		StockManagementVo stockManagementInVo = new StockManagementVo();
					stockManagementInVo.setSmItemGubun("001"); //001:제품 , 002:자재
					stockManagementInVo.setSmItemCd(jsonObject.get("ITEM_IDX").toString()); //품목(제품) 식별자
					stockManagementInVo.setSmItemVersionIdx(jsonObject.get("ITEM_VER_IDX").toString()); //품목(제품) 식별자
					stockManagementInVo.setSmType("입고"); //수불구분
					stockManagementInVo.setSmType2("IOP"); //업무구분
					stockManagementInVo.setSmDate(jsonObject.get("IN_DATE").toString()); //수불일자
					stockManagementInVo.setSmQty(jsonObject.get("IN_QTY").toString()); // 수불수량
					stockManagementInVo.setSmLotNo(""); //LOT번호 -> 채번이라서 빈값넘겨줌
					stockManagementInVo.setSmSourceNo(jsonObject.get("IDX").toString()); //원천번호 -> ㅇ상품발주테이블식별자
					stockManagementInVo.setSmInWhsGubun(""); //창고구분 -> 없음 빈값 
					stockManagementInVo.setSmOutWhsIdx(locationInVo.getIdx()); //창고식별자 
					stockManagementInVo.setSmInWhsIdx(locationInVo.getIdx()); //창고식별자  
					stockManagementInVo.setSmInUserIdx(jsonObject.get("IN_USER_IDX").toString()); //입고담당자식별자
					stockManagementInVo.setSmDesc(jsonObject.get("IN_DESC").toString()); //입고비고
		    		
					stockManagementInVo.setSmInGubun("외주입고"); //입고구분
					stockManagementInVo.setSmInCorpIdx(""); //입고처
					stockManagementInVo.setSmInRelationNo(jsonObject.get("IDX").toString()); //원천번호 -> 상품발주테이블식별자
		    		stockManagementVoInList.add(stockManagementInVo);
		        }
	    		//제품입고처리
				stockManagementController.ProdInput(stockManagementVoInList);
				jsonData.put("result", "ok");
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
}
