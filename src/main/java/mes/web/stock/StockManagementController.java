package mes.web.stock;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import mes.domain.stock.InMatrWhsAdmVo;
import mes.domain.stock.InProdWhsAdmVo;
import mes.domain.stock.OutMatrWhsAdmVo;
import mes.domain.stock.OutProdWhsAdmVo;
import mes.domain.stock.StockAdjustAdmVo;
import mes.domain.stock.StockManagementVo;
import mes.domain.stock.StockPaymentAdmVo;
import mes.domain.stock.StockPaymentWorkAdmVo;
import mes.service.stock.InMatrWhsAdmService;
import mes.service.stock.InProdWhsAdmService;
import mes.service.stock.OutMatrWhsAdmService;
import mes.service.stock.OutProdWhsAdmService;
import mes.service.stock.StockAdjustAdmService;
import mes.service.stock.StockPaymentAdmService;
import mes.service.stock.StockPaymentWorkAdmService;
import mes.service.stock.StockTotalAdmService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class StockManagementController {
	
	@Inject
	private InMatrWhsAdmService inMatrWhsAdmService;
	@Inject
	private InProdWhsAdmService inProdWhsAdmService;
	@Inject
	private OutMatrWhsAdmService outMatrWhsAdmService;
	@Inject
	private OutProdWhsAdmService outProdWhsAdmService;
	@Inject
	private StockAdjustAdmService stockAdjustAdmService;
	@Inject
	private StockPaymentAdmService stockPaymentAdmService;
	@Inject
	private StockTotalAdmService stockTotalAdmService;
	@Inject
	private StockPaymentWorkAdmService stockPaymentWorkAdmService;
	
	private static final Logger logger = LoggerFactory.getLogger(StockManagementController.class);
	
	// 자재 ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
	
	//자재 가입고/입고
	public void MatrPreInput(List<StockManagementVo> stockManagementVo) throws Exception {
		try {
			logger.info("자재 가입고/입고 -> " + stockManagementVo.toString());
			
			InMatrWhsAdmVo inMatrWhsAdmEmptyVo = new InMatrWhsAdmVo();
			String inSlipNo = inMatrWhsAdmService.inMatrWhsAdmGetInSlipNo(inMatrWhsAdmEmptyVo); // 전표번호 채번
			
			List<InMatrWhsAdmVo> inMatrWhsAdmInputVo = new ArrayList<>(); // 등록 목록
			List<InMatrWhsAdmVo> inMatrWhsAdmUpdVo = new ArrayList<>(); // 수정 목록
			
			List<StockManagementVo> stockManagementVo2 = new ArrayList<>(); //입고등록 수불처리
			
			
			for(int i=0;i<stockManagementVo.size();i++) {
				
				InMatrWhsAdmVo inMatrWhsAdmVo = new InMatrWhsAdmVo();
				inMatrWhsAdmVo.setItemGubun("004");
				inMatrWhsAdmVo.setInGubun("001");
				inMatrWhsAdmVo.setMatrlIdx(stockManagementVo.get(i).getSmItemIdx());
				inMatrWhsAdmVo.setPreInQty(stockManagementVo.get(i).getSmQty());
				inMatrWhsAdmVo.setRemainQty(stockManagementVo.get(i).getSmQty());
				inMatrWhsAdmVo.setPreInDate(stockManagementVo.get(i).getSmDate());
				inMatrWhsAdmVo.setInStatus("S"); // S: 가입고, I:수입검사, O:승인,  A: 입고
				inMatrWhsAdmVo.setWhsGubun("001"); //자재창고
				inMatrWhsAdmVo.setWhsIdx(stockManagementVo.get(i).getSmInWhsIdx());
				inMatrWhsAdmVo.setLocIdx(stockManagementVo.get(i).getSmInLocIdx());
				inMatrWhsAdmVo.setRelationNo(stockManagementVo.get(i).getSmInRelationNo());
				
				if(stockManagementVo.get(i).getSmNo()==null || stockManagementVo.get(i).getSmNo().equals("")) {
					inMatrWhsAdmVo.setInSlipNo(inSlipNo);
					inMatrWhsAdmVo.setInSlipSeq(Integer.toString(i+1));	
					inMatrWhsAdmVo.setRegIdx(Utils.getUserIdx());
					inMatrWhsAdmInputVo.add(inMatrWhsAdmVo); // 등록 목록에 추가
					
					//입고등록 수불처리
					StockManagementVo stockManagementInputVo = new StockManagementVo();
					
					stockManagementInputVo.setSmItemGubun("004");
					stockManagementInputVo.setSmItemCd(stockManagementVo.get(i).getSmItemCd());
					stockManagementInputVo.setSmType("001");
					stockManagementInputVo.setSmType2("자재입고");
					stockManagementInputVo.setSmDate(stockManagementVo.get(i).getSmDate());
					stockManagementInputVo.setSmQty(stockManagementVo.get(i).getSmQty());
					stockManagementInputVo.setSmInWhsGubun("007");
					stockManagementInputVo.setSmInWhsIdx("36");
					stockManagementInputVo.setSmInLocIdx("131");
					stockManagementVo2.add(stockManagementInputVo);
				}else {
					inMatrWhsAdmVo.setInSlipNo(stockManagementVo.get(i).getSmNo());
					inMatrWhsAdmVo.setInSlipSeq(stockManagementVo.get(i).getSmSeq());
					inMatrWhsAdmVo.setUpdIdx(Utils.getUserIdx());
					inMatrWhsAdmUpdVo.add(inMatrWhsAdmVo); // 수정 목록에 추가
				}
				
			}
			
			// 등록 목록에 있는 항목 등록처리
			for(int i=0;i<inMatrWhsAdmInputVo.size();i++) {
				InMatrWhsAdmVo inMatrWhsAdmLotVo = new InMatrWhsAdmVo();
				inMatrWhsAdmLotVo.setMatrlIdx(inMatrWhsAdmInputVo.get(i).getMatrlIdx());
				String lotNo = inMatrWhsAdmService.inMatrWhsAdmGetLotNo(inMatrWhsAdmLotVo); // LOT번호 채번
				inMatrWhsAdmInputVo.get(i).setLotNo(lotNo);
				inMatrWhsAdmService.inMatrWhsAdmIns(inMatrWhsAdmInputVo.get(i)); // 자재 입고전표 등록
				
				//입고등록 수불처리
				stockManagementVo2.get(i).setSmLotNo(lotNo);
				stockManagementVo2.get(i).setSmSourceNo(lotNo);
			}
			
			// 수정 목록에 있는 항목 수정처리
			for(int i=0;i<inMatrWhsAdmUpdVo.size();i++) {
				inMatrWhsAdmService.inMatrWhsAdmUpd(inMatrWhsAdmUpdVo.get(i)); // 자재 입고전표 수정
			}
			
			//입고등록 수불처리
			MatrInput(stockManagementVo2);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	//자재 입고/입고
	public void MatrInput(List<StockManagementVo> stockManagementVo) throws Exception {
		try {
			logger.info("자재 입고/입고 -> " + stockManagementVo.toString());
			
			StockPaymentAdmVo stockPaymentAdmEmptyVo = new StockPaymentAdmVo();
			String spNo = stockPaymentAdmService.stockPaymentAdmGetSpNo(stockPaymentAdmEmptyVo); // 입고수불 전표번호 채번
			
			List<InMatrWhsAdmVo> inMatrWhsAdmUpdateVo = new ArrayList<>(); // 자재입고 수정목록
			List<StockPaymentAdmVo> stockPaymentAdmInputVo = new ArrayList<>(); // 입고수불 등록목록
			
			logger.info("size:"+stockManagementVo.size());
			
			for(int i=0;i<stockManagementVo.size();i++) {
				
				InMatrWhsAdmVo inMatrWhsAdmVo = new InMatrWhsAdmVo();
				inMatrWhsAdmVo.setInSlipNo(stockManagementVo.get(i).getSmNo());
				inMatrWhsAdmVo.setInSlipSeq(stockManagementVo.get(i).getSmSeq());
				inMatrWhsAdmVo.setUpdIdx(Utils.getUserIdx());
				inMatrWhsAdmVo.setInQty(stockManagementVo.get(i).getSmQty());
				inMatrWhsAdmVo.setInDate(stockManagementVo.get(i).getSmDate());
				inMatrWhsAdmVo.setInStatus("A"); // S: 가입고, I:수입검사, O:승인,  A: 입고
				inMatrWhsAdmUpdateVo.add(inMatrWhsAdmVo); // 자재입고 수정목록 추가
				
				StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();
				stockPaymentAdmVo.setSpNo(spNo);
				stockPaymentAdmVo.setSpSeq(Integer.toString(i+1));
				stockPaymentAdmVo.setSpGubun(stockManagementVo.get(i).getSmItemGubun());
				stockPaymentAdmVo.setSpIdx(stockManagementVo.get(i).getSmItemCd());
				stockPaymentAdmVo.setSpType(stockManagementVo.get(i).getSmType());
				stockPaymentAdmVo.setSpType2(stockManagementVo.get(i).getSmType2());
				stockPaymentAdmVo.setSpDate(stockManagementVo.get(i).getSmDate());
				stockPaymentAdmVo.setSpQty(stockManagementVo.get(i).getSmQty());
				stockPaymentAdmVo.setSpLotNo(stockManagementVo.get(i).getSmLotNo());
				stockPaymentAdmVo.setSpSourceNo(stockManagementVo.get(i).getSmSourceNo());
				stockPaymentAdmVo.setSpWhsGubun(stockManagementVo.get(i).getSmInWhsGubun());
				stockPaymentAdmVo.setSpWhsIdx(stockManagementVo.get(i).getSmInWhsIdx());
				stockPaymentAdmVo.setSpLocIdx(stockManagementVo.get(i).getSmInLocIdx());
				stockPaymentAdmVo.setRegIdx(Utils.getUserIdx());
				stockPaymentAdmInputVo.add(stockPaymentAdmVo); // 입고수불 등록목록 추가
			}
			
			for(int i=0;i<stockManagementVo.size();i++) {
				inMatrWhsAdmService.inMatrWhsAdmUpd(inMatrWhsAdmUpdateVo.get(i)); // 자재입고 수정
				stockPaymentAdmService.stockPaymentAdmIns(stockPaymentAdmInputVo.get(i)); // 입고수불 등록
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//자재 입고/입고 + 가입고 없이 입고만 할 경우
	public void MatrInputOnly(List<StockManagementVo> stockManagementVo) throws Exception {
		try {
			logger.info("자재 입고/입고 + 가입고 없이 입고만 할 경우 -> " + stockManagementVo.toString());
			
			InMatrWhsAdmVo inMatrWhsAdmEmptyVo = new InMatrWhsAdmVo();
			String inSlipNo = inMatrWhsAdmService.inMatrWhsAdmGetInSlipNo(inMatrWhsAdmEmptyVo); // 전표번호 채번
			
			StockPaymentAdmVo stockPaymentAdmEmptyVo = new StockPaymentAdmVo();
			String spNo = stockPaymentAdmService.stockPaymentAdmGetSpNo(stockPaymentAdmEmptyVo); // 입고수불 전표번호 채번
			
			String regDate = DateUtil.getCurrentDateTime();
			
			List<InMatrWhsAdmVo> inMatrWhsAdmInsertVo = new ArrayList<>(); // 자재입고 등록목록
			List<InMatrWhsAdmVo> inMatrWhsAdmUpdateVo = new ArrayList<>(); // 자재입고 수정목록
			List<StockPaymentAdmVo> stockPaymentAdmInputVo = new ArrayList<>(); // 입고수불 등록목록
			List<StockPaymentAdmVo> stockPaymentAdmDeleteVo = new ArrayList<>(); // 입고수불 삭제목록

			//수불 등록 JSON배열
			StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();
			JSONArray stock_array = new JSONArray();
			
			//자재 입고 등록 JSON배열
			InMatrWhsAdmVo inMatrWhsAdmVo = new InMatrWhsAdmVo();
			JSONArray inMatrl_array = new JSONArray();
			
			//수불 삭제 JSON배열
			JSONArray stockDel_array = new JSONArray();
			
			//자재 입고 수정 JSON배열
			JSONArray inMatrlUpd_array = new JSONArray();
			
			for(int i=0;i<stockManagementVo.size();i++) {
				JSONObject stockData = new JSONObject();
				JSONObject inMatrlData = new JSONObject();
				if(stockManagementVo.get(i).getSmNo()!=null && !stockManagementVo.get(i).getSmNo().equals("")) { // 수정할 경우
					inMatrlData.put("IN_SLIP_NO", stockManagementVo.get(i).getSmNo());
					inMatrlData.put("IN_SLIP_SEQ", stockManagementVo.get(i).getSmSeq());
					inMatrlData.put("ITEM_GUBUN", stockManagementVo.get(i).getSmItemGubun());
					inMatrlData.put("IN_GUBUN", stockManagementVo.get(i).getSmInGubun());
					inMatrlData.put("MATRL_IDX", stockManagementVo.get(i).getSmItemIdx());
					inMatrlData.put("IN_QTY", stockManagementVo.get(i).getSmQty());
					inMatrlData.put("IN_DATE", stockManagementVo.get(i).getSmDate());
					inMatrlData.put("IN_CORP_IDX", stockManagementVo.get(i).getSmInCorpIdx());
					inMatrlData.put("IN_STATUS", stockManagementVo.get(i).getSmStatus());
					inMatrlData.put("LOT_NO", stockManagementVo.get(i).getSmLotNo()); 
					inMatrlData.put("RELATION_NO", stockManagementVo.get(i).getSmInRelationNo());
					inMatrlData.put("WHS_GUBUN", stockManagementVo.get(i).getSmInWhsGubun());
					inMatrlData.put("WHS_IDX", stockManagementVo.get(i).getSmInWhsIdx());
					inMatrlData.put("IN_DESC", stockManagementVo.get(i).getSmDesc());
					inMatrlData.put("IN_MATR_ETC1", stockManagementVo.get(i).getSmEtc1());
					inMatrlData.put("IN_MATR_ETC2", stockManagementVo.get(i).getSmEtc2());
					inMatrlData.put("IN_MATR_ETC3", stockManagementVo.get(i).getSmEtc3());
					inMatrlUpd_array.add(inMatrlData);
					
					stockData.put("SP_NO", spNo);
					stockData.put("SP_SEQ", Integer.toString(i+1));
					stockData.put("SP_GUBUN", "002");
					stockData.put("SP_IDX", stockManagementVo.get(i).getSmItemIdx());
					stockData.put("SP_TYPE", stockManagementVo.get(i).getSmType());
					stockData.put("SP_TYPE2", stockManagementVo.get(i).getSmType2());
					stockData.put("SP_DATE", stockManagementVo.get(i).getSmDate());
					stockData.put("SP_QTY", stockManagementVo.get(i).getSmQty());
					stockData.put("SP_LOT_NO", stockManagementVo.get(i).getSmLotNo());
					stockData.put("SP_SOURCE_NO", stockManagementVo.get(i).getSmNo()+"-"+stockManagementVo.get(i).getSmSeq());
					stockData.put("SP_WHS_GUBUN", stockManagementVo.get(i).getSmInWhsGubun());
					stockData.put("SP_WHS_IDX", stockManagementVo.get(i).getSmInWhsIdx());
					stockData.put("SP_LOC_IDX", stockManagementVo.get(i).getSmInLocIdx());
					stockData.put("IN_SLIP_NO", stockManagementVo.get(i).getSmNo());
					stockData.put("IN_SLIP_SEQ", stockManagementVo.get(i).getSmSeq());
					stockDel_array.add(stockData);
					stock_array.add(stockData);
				} else { // 등록할 경우
					inMatrlData.put("IN_SLIP_NO", inSlipNo);
					inMatrlData.put("IN_SLIP_SEQ", Integer.toString(i+1));
					inMatrlData.put("ITEM_GUBUN", stockManagementVo.get(i).getSmItemGubun());
					inMatrlData.put("IN_GUBUN", stockManagementVo.get(i).getSmInGubun());
					inMatrlData.put("MATRL_IDX", stockManagementVo.get(i).getSmItemIdx());
					inMatrlData.put("IN_QTY", stockManagementVo.get(i).getSmQty());
					inMatrlData.put("IN_DATE", stockManagementVo.get(i).getSmDate());
					inMatrlData.put("IN_CORP_IDX", stockManagementVo.get(i).getSmInCorpIdx());
					inMatrlData.put("IN_STATUS", stockManagementVo.get(i).getSmStatus());
					inMatrlData.put("LOT_NO", ""); //로트 번호는 프로시저 단에서 채번해야함
					inMatrlData.put("RELATION_NO", stockManagementVo.get(i).getSmInRelationNo());
					inMatrlData.put("WHS_GUBUN", stockManagementVo.get(i).getSmInWhsGubun());
					inMatrlData.put("WHS_IDX", stockManagementVo.get(i).getSmInWhsIdx());
					inMatrlData.put("IN_DESC", stockManagementVo.get(i).getSmDesc());
					inMatrlData.put("IN_MATR_ETC1", stockManagementVo.get(i).getSmEtc1());
					inMatrlData.put("IN_MATR_ETC2", stockManagementVo.get(i).getSmEtc2());
					inMatrlData.put("IN_MATR_ETC3", stockManagementVo.get(i).getSmEtc3());
					inMatrl_array.add(inMatrlData);
					
					stockData.put("SP_NO", spNo);
					stockData.put("SP_SEQ", Integer.toString(i+1));
					stockData.put("SP_GUBUN", "002");
					stockData.put("SP_IDX", stockManagementVo.get(i).getSmItemIdx());
					stockData.put("SP_TYPE", stockManagementVo.get(i).getSmType());
					stockData.put("SP_TYPE2", stockManagementVo.get(i).getSmType2());
					stockData.put("SP_DATE", stockManagementVo.get(i).getSmDate());
					stockData.put("SP_QTY", stockManagementVo.get(i).getSmQty());
					stockData.put("SP_LOT_NO", ""); //로트 번호는 프로시저 단에서 검색해서 저장
					stockData.put("SP_SOURCE_NO", inSlipNo+"-"+Integer.toString(i+1));
					stockData.put("SP_WHS_GUBUN", stockManagementVo.get(i).getSmInWhsGubun());
					stockData.put("SP_WHS_IDX", stockManagementVo.get(i).getSmInWhsIdx());
					stockData.put("SP_LOC_IDX", stockManagementVo.get(i).getSmInLocIdx());
					stockData.put("IN_SLIP_NO", inSlipNo);
					stockData.put("IN_SLIP_SEQ", Integer.toString(i+1));
					stock_array.add(stockData);
				}
				            
			}
			
			inMatrWhsAdmVo.setUpdateJson(inMatrlUpd_array.toJSONString());
			inMatrWhsAdmVo.setUpdIdx(Utils.getUserIdx());
			inMatrWhsAdmVo.setUpdDate(regDate);
			inMatrWhsAdmService.inMatrWhsAdmUpd(inMatrWhsAdmVo); // 자재 입고전표 수정
			inMatrWhsAdmVo.setInsertJson(inMatrl_array.toJSONString());
			inMatrWhsAdmVo.setRegIdx(Utils.getUserIdx());
			inMatrWhsAdmVo.setRegDate(regDate);
			inMatrWhsAdmService.inMatrWhsAdmIns(inMatrWhsAdmVo); // 자재 입고전표 등록
			stockPaymentAdmVo.setDeleteJson(stockDel_array.toJSONString());
			stockPaymentAdmService.stockPaymentAdmDel(stockPaymentAdmVo); // 입고수불 삭제
			stockPaymentAdmVo.setInsertJson(stock_array.toJSONString());
			stockPaymentAdmVo.setRegIdx(Utils.getUserIdx());
			stockPaymentAdmVo.setRegDate(regDate);
			stockPaymentAdmService.stockPaymentAdmIns(stockPaymentAdmVo); // 입고수불 등록
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//자재 출고/출고
	public void MatrOutput(List<StockManagementVo> stockManagementVo) throws Exception {
		try {
			logger.info("자재 출고/출고 -> " + stockManagementVo.toString());
			OutMatrWhsAdmVo outMatrWhsAdmEmptyVo = new OutMatrWhsAdmVo();
			String outSlipNo = outMatrWhsAdmService.getOutSlipNo(outMatrWhsAdmEmptyVo); // 자재출고 전표번호 채번
			
			StockPaymentAdmVo stockPaymentAdmEmptyVo = new StockPaymentAdmVo();
			String spNo = stockPaymentAdmService.stockPaymentAdmGetSpNo(stockPaymentAdmEmptyVo); // 출고수불 전표번호 채번
			
			String regDate = DateUtil.getCurrentDateTime();
			
			List<OutMatrWhsAdmVo> outMatrWhsAdmInputVo = new ArrayList<>(); // 자재출고 등록목록
			List<StockPaymentAdmVo> stockPaymentAdmInputVo = new ArrayList<>(); // 출고수불 등록목록
			
			//수불 등록 JSON배열
			StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();
			JSONArray stock_array = new JSONArray();
			
			//자재 출고 등록 JSON배열
			OutMatrWhsAdmVo outMatrWhsAdmVo = new OutMatrWhsAdmVo();
			JSONArray outMatrl_array = new JSONArray();
			
			for(int i=0;i<stockManagementVo.size();i++) {
				JSONObject stockData = new JSONObject();
				JSONObject outMatrlData = new JSONObject();
				
				outMatrlData.put("OUT_SLIP_NO", outSlipNo);
				outMatrlData.put("OUT_SLIP_SEQ", Integer.toString(i+1));
				outMatrlData.put("ITEM_GUBUN", stockManagementVo.get(i).getSmItemGubun());
				outMatrlData.put("OUT_GUBUN", stockManagementVo.get(i).getSmOutGubun());
				outMatrlData.put("ITEM_CD", stockManagementVo.get(i).getSmItemCd());
				outMatrlData.put("OUT_QTY", stockManagementVo.get(i).getSmQty());
				outMatrlData.put("OUT_DATE", stockManagementVo.get(i).getSmDate());
				outMatrlData.put("OUT_CORP_CD", stockManagementVo.get(i).getSmOutCorpIdx());
				outMatrlData.put("OUT_STATUS", "B"); // A: 가출고, B: 출고
				outMatrlData.put("LOT_NO", stockManagementVo.get(i).getSmLotNo());
				outMatrlData.put("RELATION_NO", stockManagementVo.get(i).getSmOutRelationNo());
				outMatrlData.put("WHS_GUBUN", stockManagementVo.get(i).getSmInWhsGubun());
				outMatrlData.put("WHS_IDX", stockManagementVo.get(i).getSmInWhsIdx());
				outMatrlData.put("LOC_IDX", null);
				outMatrl_array.add(outMatrlData);
				
				stockData.put("SP_NO", spNo);
				stockData.put("SP_SEQ", Integer.toString(i+1));
				stockData.put("SP_GUBUN", stockManagementVo.get(i).getSmItemGubun());
				stockData.put("SP_IDX", stockManagementVo.get(i).getSmItemCd());
				stockData.put("SP_TYPE", stockManagementVo.get(i).getSmType());
				stockData.put("SP_TYPE2", stockManagementVo.get(i).getSmType2());
				stockData.put("SP_DATE", stockManagementVo.get(i).getSmDate());
				stockData.put("SP_QTY", stockManagementVo.get(i).getSmQty());
				stockData.put("SP_LOT_NO", stockManagementVo.get(i).getSmLotNo());
				stockData.put("SP_SOURCE_NO", outSlipNo + "-" + Integer.toString(i+1));
				stockData.put("SP_WHS_GUBUN", stockManagementVo.get(i).getSmOutWhsGubun());
				stockData.put("SP_WHS_IDX", stockManagementVo.get(i).getSmOutWhsIdx());
				stockData.put("SP_LOC_IDX", null);
				stock_array.add(stockData);
			}
				
			outMatrWhsAdmVo.setInsertJson(outMatrl_array.toJSONString());
			outMatrWhsAdmVo.setRegIdx(Utils.getUserIdx());
			outMatrWhsAdmVo.setRegDate(regDate);
			outMatrWhsAdmService.outMatrWhsAdmIns(outMatrWhsAdmVo); // 자재출고 등록
			stockPaymentAdmVo.setInsertJson(stock_array.toJSONString());
			stockPaymentAdmVo.setRegIdx(Utils.getUserIdx());
			stockPaymentAdmVo.setRegDate(regDate);
			stockPaymentAdmService.stockPaymentAdmIns(stockPaymentAdmVo); // 출고수불 등록
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//자재/제품 재고이동
	public void StockMove(List<StockManagementVo> stockManagementVo) throws Exception {
		try {
			logger.info("자재/제품 재고이동 -> " + stockManagementVo.toString());
			
			StockPaymentAdmVo stockPaymentAdmEmptyVo = new StockPaymentAdmVo();
			String spNo = stockPaymentAdmService.stockPaymentAdmGetSpNo(stockPaymentAdmEmptyVo); // 입출고수불 전표번호 채번
			InMatrWhsAdmVo inMatrWhsAdmEmptyVo = new InMatrWhsAdmVo();
			String inSlipNo = inMatrWhsAdmService.inMatrWhsAdmGetInSlipNo(inMatrWhsAdmEmptyVo); // 전표번호 채번
			OutMatrWhsAdmVo outMatrWhsAdmEmptyVo = new OutMatrWhsAdmVo();
			String outSlipNo = outMatrWhsAdmService.getOutSlipNo(outMatrWhsAdmEmptyVo); // 자재출고 전표번호 채번
			InProdWhsAdmVo inProdWhsAdmEmptyVo = new InProdWhsAdmVo();
			String inProdSlipNo = inProdWhsAdmService.getInSlipNo(inProdWhsAdmEmptyVo); // 입고수불 전표번호 채번
			OutProdWhsAdmVo outProdWhsAdmEmptyVo = new OutProdWhsAdmVo();
			String outProdSlipNo = outProdWhsAdmService.getOutSlipNo(outProdWhsAdmEmptyVo); // 출고수불 전표번호 채번
			
			String regDate = DateUtil.getCurrentDateTime();
			
			//수불 등록 JSON배열
			StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();
			JSONArray stock_array = new JSONArray();
			
			//자재 입고 등록 JSON배열
			InMatrWhsAdmVo inMatrWhsAdmVo = new InMatrWhsAdmVo();
			JSONArray inMatrl_array = new JSONArray();
			//자재 출고 등록 JSON배열
			OutMatrWhsAdmVo outMatrWhsAdmVo = new OutMatrWhsAdmVo();
			JSONArray outMatrl_array = new JSONArray();
			
			//제품 입고 등록 JSON배열
			InProdWhsAdmVo inProdWhsAdmVo = new InProdWhsAdmVo();
			JSONArray inProd_array = new JSONArray();
			//제품 출고 전표 JSON배열
			OutProdWhsAdmVo outProdWhsAdmVo = new OutProdWhsAdmVo();
			JSONArray outProd_array = new JSONArray();
			
			for(int i=0;i<stockManagementVo.size();i++) {
				JSONObject stockOutData = new JSONObject();
				JSONObject stockInData = new JSONObject();
				
				JSONObject inMatrlData = new JSONObject();
				JSONObject outMatrlData = new JSONObject();

				JSONObject inProdData = new JSONObject();
				JSONObject outProdData = new JSONObject();
				
				if( "001".equals(stockManagementVo.get(i).getSmItemGubun()) ) {
					outProdData.put("OUT_SLIP_NO", outProdSlipNo);
					outProdData.put("OUT_SLIP_SEQ", Integer.toString(i+1));
					outProdData.put("ITEM_GUBUN", stockManagementVo.get(i).getSmItemGubun());
					outProdData.put("OUT_GUBUN", "재고이동출고");
					outProdData.put("ITEM_IDX", stockManagementVo.get(i).getSmItemCd());
					outProdData.put("VERSION_IDX", stockManagementVo.get(i).getSmItemVersionIdx());
					outProdData.put("CAR_ASSIGNMENT", stockManagementVo.get(i).getSmCarAssignment());
					outProdData.put("OUT_QTY", stockManagementVo.get(i).getSmQty());
					outProdData.put("REMAIN_QTY", stockManagementVo.get(i).getSmQty());
					outProdData.put("OUT_DATE", stockManagementVo.get(i).getSmDate());
					outProdData.put("OutCorpIdx", stockManagementVo.get(i).getSmOutCorpIdx());
					outProdData.put("OUT_STATUS", "B");
					outProdData.put("LOT_NO", stockManagementVo.get(i).getSmLotNo());
					outProdData.put("RELATION_NO", stockManagementVo.get(i).getSmOutRelationNo());
					outProdData.put("WHS_GUBUN", stockManagementVo.get(i).getSmOutWhsGubun());
					outProdData.put("WHS_IDX", stockManagementVo.get(i).getSmOutWhsIdx());
					outProdData.put("LOC_IDX", stockManagementVo.get(i).getSmOutLocIdx());
					outProdData.put("OUT_PROD_ETC1", stockManagementVo.get(i).getSmEtc1());
					outProdData.put("OUT_PROD_ETC2", stockManagementVo.get(i).getSmEtc2());
					outProdData.put("OUT_PROD_ETC3", stockManagementVo.get(i).getSmEtc3());
					outProd_array.add(outProdData);
					
					stockOutData.put("SP_NO", spNo);
					stockOutData.put("SP_SEQ", Integer.toString(i*2+1));
					stockOutData.put("SP_GUBUN", stockManagementVo.get(i).getSmItemGubun());
					stockOutData.put("SP_IDX", stockManagementVo.get(i).getSmItemCd());
					stockOutData.put("VERSION_IDX", stockManagementVo.get(i).getSmItemVersionIdx());
					stockOutData.put("SP_TYPE", "출고");
					stockOutData.put("SP_TYPE2", "SM");
					stockOutData.put("SP_DATE", stockManagementVo.get(i).getSmDate());
					stockOutData.put("SP_QTY", stockManagementVo.get(i).getSmQty());
					stockOutData.put("SP_LOT_NO", stockManagementVo.get(i).getSmLotNo());
					stockOutData.put("SP_SOURCE_NO", outProdSlipNo + "-" + Integer.toString(i+1) );
					stockOutData.put("SP_WHS_GUBUN", stockManagementVo.get(i).getSmOutWhsGubun());
					stockOutData.put("SP_WHS_IDX", stockManagementVo.get(i).getSmOutWhsIdx());
					stockOutData.put("SP_LOC_IDX", null);
					stock_array.add(stockOutData);
					
					inProdData.put("IN_SLIP_NO", inProdSlipNo);
					inProdData.put("IN_SLIP_SEQ", Integer.toString(i+1));
					inProdData.put("ITEM_GUBUN", stockManagementVo.get(i).getSmItemGubun());
					inProdData.put("IN_GUBUN", "재고이동입고");
					inProdData.put("ITEM_CD", stockManagementVo.get(i).getSmItemCd());
					inProdData.put("VERSION_IDX", stockManagementVo.get(i).getSmItemVersionIdx());
					inProdData.put("IN_QTY", stockManagementVo.get(i).getSmQty());
					inProdData.put("IN_DATE", stockManagementVo.get(i).getSmDate());
					inProdData.put("IN_CORP_CD", stockManagementVo.get(i).getSmInCorpIdx());
					inProdData.put("IN_STATUS", "A");//가입고(S)/입고(A)/확정(O)
					inProdData.put("LOT_NO", ""); //LOT 번호는 프로시저단에서 채번해야함
					inProdData.put("RELATION_NO", stockManagementVo.get(i).getSmInRelationNo());
					inProdData.put("WHS_GUBUN", stockManagementVo.get(i).getSmInWhsGubun());
					inProdData.put("WHS_IDX", stockManagementVo.get(i).getSmInWhsIdx());
					inProdData.put("LOC_IDX", stockManagementVo.get(i).getSmInLocIdx());
					inProdData.put("IN_USER_IDX", stockManagementVo.get(i).getSmInUserIdx());
					inProdData.put("IN_DESC", stockManagementVo.get(i).getSmDesc());
					inProd_array.add(inProdData);
					
					stockInData.put("SP_NO", spNo);
					stockInData.put("SP_SEQ", Integer.toString(i*2+2));
					stockInData.put("IN_SLIP_NO", inProdSlipNo);
					stockInData.put("IN_SLIP_SEQ", Integer.toString(i+1));
					stockInData.put("SP_GUBUN", stockManagementVo.get(i).getSmItemGubun());
					stockInData.put("SP_IDX", stockManagementVo.get(i).getSmItemCd());
					stockInData.put("VERSION_IDX", stockManagementVo.get(i).getSmItemVersionIdx());
					stockInData.put("SP_TYPE", "입고");
					stockInData.put("SP_TYPE2", "SM");
					stockInData.put("SP_DATE", stockManagementVo.get(i).getSmDate());
					stockInData.put("SP_QTY", stockManagementVo.get(i).getSmQty());
					stockInData.put("SP_LOT_NO", stockManagementVo.get(i).getSmLotNo());
					stockInData.put("SP_SOURCE_NO", inProdSlipNo + "-" + Integer.toString(i+1) );
					stockInData.put("SP_WHS_GUBUN", stockManagementVo.get(i).getSmInWhsGubun());
					stockInData.put("SP_WHS_IDX", stockManagementVo.get(i).getSmInWhsIdx());
					stockInData.put("SP_LOC_IDX", null);
					stock_array.add(stockInData);
					
				} else if("002".equals(stockManagementVo.get(i).getSmItemGubun())) {
					//출고
					outMatrlData.put("OUT_SLIP_NO", outSlipNo);
					outMatrlData.put("OUT_SLIP_SEQ", Integer.toString(i+1));
					outMatrlData.put("ITEM_GUBUN", stockManagementVo.get(i).getSmItemGubun());
					outMatrlData.put("OUT_GUBUN", "재고이동출고");
					outMatrlData.put("ITEM_CD", stockManagementVo.get(i).getSmItemCd());
					outMatrlData.put("OUT_QTY", stockManagementVo.get(i).getSmQty());
					outMatrlData.put("OUT_DATE", stockManagementVo.get(i).getSmDate());
					outMatrlData.put("OUT_CORP_CD", stockManagementVo.get(i).getSmOutCorpIdx());
					outMatrlData.put("OUT_STATUS", "B"); // A: 가출고, B: 출고
					outMatrlData.put("LOT_NO", stockManagementVo.get(i).getSmLotNo());
					outMatrlData.put("RELATION_NO", stockManagementVo.get(i).getSmOutRelationNo());
					outMatrlData.put("WHS_GUBUN", stockManagementVo.get(i).getSmOutWhsGubun());
					outMatrlData.put("WHS_IDX", stockManagementVo.get(i).getSmOutWhsIdx());
					outMatrlData.put("LOC_IDX", null);
					outMatrl_array.add(outMatrlData);	
					
					stockOutData.put("SP_NO", spNo);
					stockOutData.put("SP_SEQ", Integer.toString(i*2+1));
					stockOutData.put("SP_GUBUN", stockManagementVo.get(i).getSmItemGubun());
					stockOutData.put("SP_IDX", stockManagementVo.get(i).getSmItemCd());
					stockOutData.put("SP_TYPE", "출고");
					stockOutData.put("SP_TYPE2", "SM");
					stockOutData.put("SP_DATE", stockManagementVo.get(i).getSmDate());
					stockOutData.put("SP_QTY", stockManagementVo.get(i).getSmQty());
					stockOutData.put("SP_LOT_NO", stockManagementVo.get(i).getSmLotNo());
					stockOutData.put("SP_SOURCE_NO", outSlipNo + "-" + Integer.toString(i+1) );
					stockOutData.put("SP_WHS_GUBUN", stockManagementVo.get(i).getSmOutWhsGubun());
					stockOutData.put("SP_WHS_IDX", stockManagementVo.get(i).getSmOutWhsIdx());
					stockOutData.put("SP_LOC_IDX", null);
					stock_array.add(stockOutData);
					
					//입고
					inMatrlData.put("IN_SLIP_NO", inSlipNo);
					inMatrlData.put("IN_SLIP_SEQ", Integer.toString(i+1));
					inMatrlData.put("ITEM_GUBUN", stockManagementVo.get(i).getSmItemGubun());
					inMatrlData.put("IN_GUBUN", "재고이동입고");
					inMatrlData.put("MATRL_IDX", stockManagementVo.get(i).getSmItemCd());
					inMatrlData.put("IN_QTY", stockManagementVo.get(i).getSmQty());
					inMatrlData.put("IN_DATE", stockManagementVo.get(i).getSmDate());
					inMatrlData.put("IN_CORP_IDX", stockManagementVo.get(i).getSmInCorpIdx());
					inMatrlData.put("IN_STATUS", stockManagementVo.get(i).getSmStatus());
					inMatrlData.put("LOT_NO", ""); //로트 번호는 프로시저 단에서 채번해야함
					inMatrlData.put("RELATION_NO", stockManagementVo.get(i).getSmInRelationNo());
					inMatrlData.put("WHS_GUBUN", stockManagementVo.get(i).getSmInWhsGubun());
					inMatrlData.put("WHS_IDX", stockManagementVo.get(i).getSmInWhsIdx());
					inMatrlData.put("IN_DESC", stockManagementVo.get(i).getSmDesc());
					inMatrlData.put("IN_MATR_ETC1", stockManagementVo.get(i).getSmEtc1());
					inMatrlData.put("IN_MATR_ETC2", stockManagementVo.get(i).getSmEtc2());
					inMatrlData.put("IN_MATR_ETC3", stockManagementVo.get(i).getSmEtc3());
					inMatrl_array.add(inMatrlData);
					
					stockInData.put("SP_NO", spNo);
					stockInData.put("SP_SEQ", Integer.toString(i*2+2));
					stockInData.put("IN_SLIP_NO", inSlipNo);
					stockInData.put("IN_SLIP_SEQ", Integer.toString(i+1));
					stockInData.put("SP_GUBUN", stockManagementVo.get(i).getSmItemGubun());
					stockInData.put("SP_IDX", stockManagementVo.get(i).getSmItemCd());
					stockInData.put("SP_TYPE", "입고");
					stockInData.put("SP_TYPE2", "SM");
					stockInData.put("SP_DATE", stockManagementVo.get(i).getSmDate());
					stockInData.put("SP_QTY", stockManagementVo.get(i).getSmQty());
					stockInData.put("SP_LOT_NO", stockManagementVo.get(i).getSmLotNo());
					stockInData.put("SP_SOURCE_NO", inSlipNo + "-" + Integer.toString(i+1) );
					stockInData.put("SP_WHS_GUBUN", stockManagementVo.get(i).getSmInWhsGubun());
					stockInData.put("SP_WHS_IDX", stockManagementVo.get(i).getSmInWhsIdx());
					stockInData.put("SP_LOC_IDX", null);
					stock_array.add(stockInData);
				}
				
			}
			
			inMatrWhsAdmVo.setInsertJson(inMatrl_array.toJSONString());
			inMatrWhsAdmVo.setRegIdx(Utils.getUserIdx());
			inMatrWhsAdmVo.setRegDate(regDate);
			inMatrWhsAdmService.inMatrWhsAdmIns(inMatrWhsAdmVo); // 자재 입고전표 등록
			outMatrWhsAdmVo.setInsertJson(outMatrl_array.toJSONString());
			outMatrWhsAdmVo.setRegIdx(Utils.getUserIdx());
			outMatrWhsAdmVo.setRegDate(regDate);
			outMatrWhsAdmService.outMatrWhsAdmIns(outMatrWhsAdmVo); // 자재출고 등록
			inProdWhsAdmVo.setInsertJson(inProd_array.toJSONString());
			inProdWhsAdmVo.setRegIdx(Utils.getUserIdx());
			inProdWhsAdmVo.setRegDate(regDate);
			inProdWhsAdmService.inProdWhsAdmIns(inProdWhsAdmVo); // 제품입고 등록
			outProdWhsAdmVo.setRegIdx(Utils.getUserIdx());
			outProdWhsAdmVo.setRegDate(regDate);
			outProdWhsAdmVo.setInsertJson(outProd_array.toJSONString());
			outProdWhsAdmService.outProdWhsAdmIns(outProdWhsAdmVo); // 제품 출고전표 등록
			stockPaymentAdmVo.setInsertJson(stock_array.toJSONString());
			stockPaymentAdmVo.setRegIdx(Utils.getUserIdx());
			stockPaymentAdmVo.setRegDate(regDate);
			stockPaymentAdmService.stockPaymentAdmIns(stockPaymentAdmVo); // 이동 수불 등록
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	// 자재 ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑
	// 제품 ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
	
	//제품 입고/가입고
	public void ProdPreInput(List<StockManagementVo> stockManagementVo) throws Exception {
		try {
			logger.info("제품 입고/가입고 -> " + stockManagementVo.toString());
			
			InProdWhsAdmVo inProdWhsAdmEmptyVo = new InProdWhsAdmVo();
			String inSlipNo = inProdWhsAdmService.getInSlipNo(inProdWhsAdmEmptyVo); // 입고수불 전표번호 채번
			
			List<InProdWhsAdmVo> inProdWhsAdmInputVo = new ArrayList<>(); // 제품입고 등록목록
			
			for(int i=0;i<stockManagementVo.size();i++) {
				InProdWhsAdmVo inProdWhsAdmVo = new InProdWhsAdmVo();
				inProdWhsAdmVo.setInSlipNo(inSlipNo);
				inProdWhsAdmVo.setInSlipSeq(Integer.toString(i*2+1));
				inProdWhsAdmVo.setItemGubun(stockManagementVo.get(i).getSmItemGubun());
				inProdWhsAdmVo.setInGubun(stockManagementVo.get(i).getSmInGubun());
				inProdWhsAdmVo.setItemCd(stockManagementVo.get(i).getSmItemCd());
				inProdWhsAdmVo.setPreInQty(stockManagementVo.get(i).getSmQty());
				inProdWhsAdmVo.setRemainQty(stockManagementVo.get(i).getSmQty());
				inProdWhsAdmVo.setPreInDate(stockManagementVo.get(i).getSmDate());
				inProdWhsAdmVo.setInCorpCd(stockManagementVo.get(i).getSmInCorpIdx());
				inProdWhsAdmVo.setInStatus("S"); // S: 가입고, I:완제품검사, O:승인,  A: 입고
				inProdWhsAdmVo.setRelationNo(stockManagementVo.get(i).getSmInRelationNo()); //작업지시번호
				inProdWhsAdmVo.setWhsGubun(stockManagementVo.get(i).getSmInWhsGubun());
				inProdWhsAdmVo.setWhsIdx(stockManagementVo.get(i).getSmInWhsIdx());
				inProdWhsAdmVo.setLocIdx(stockManagementVo.get(i).getSmInLocIdx());
				inProdWhsAdmVo.setRegId(Utils.getUserIdx());
				inProdWhsAdmInputVo.add(inProdWhsAdmVo); // 제품입고 등록목록 추가
			}
			
			for(int i=0;i<stockManagementVo.size();i++) {
				InProdWhsAdmVo inProdWhsAdmLotVo = new InProdWhsAdmVo();
				inProdWhsAdmLotVo.setItemCd(inProdWhsAdmInputVo.get(i).getItemCd());
				String lotNo = inProdWhsAdmService.getLotNo(inProdWhsAdmLotVo); // 입고수불 LOT번호 채번
				inProdWhsAdmInputVo.get(i).setLotNo(lotNo);
				
				inProdWhsAdmService.inProdWhsAdmIns(inProdWhsAdmInputVo.get(i)); // 제품입고 등록
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
		
	//제품 입고/입고
	public void ProdInput(List<StockManagementVo> stockManagementVo) throws Exception {
		try {
			logger.info("제품 입고/입고 -> " + stockManagementVo.toString());
			
			InProdWhsAdmVo inProdWhsAdmEmptyVo = new InProdWhsAdmVo();
			String inSlipNo = inProdWhsAdmService.getInSlipNo(inProdWhsAdmEmptyVo); // 입고수불 전표번호 채번
			
			StockPaymentAdmVo stockPaymentAdmEmptyVo = new StockPaymentAdmVo();
			String spNo = stockPaymentAdmService.stockPaymentAdmGetSpNo(stockPaymentAdmEmptyVo); // 입고수불 전표번호 채번
			
			String regDate = DateUtil.getCurrentDateTime();
			
			//수불 등록 JSON배열
			StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();
			JSONArray stock_array = new JSONArray();
			
			//제품 입고 등록 JSON배열
			InProdWhsAdmVo inProdWhsAdmVo = new InProdWhsAdmVo();
			JSONArray inProd_array = new JSONArray();

			for(int i=0;i<stockManagementVo.size();i++) {
				JSONObject stockData = new JSONObject();
				JSONObject inProdData = new JSONObject();
				
				inProdData.put("IN_SLIP_NO", inSlipNo);
				inProdData.put("IN_SLIP_SEQ", Integer.toString(i+1));
				inProdData.put("ITEM_GUBUN", stockManagementVo.get(i).getSmItemGubun());
				inProdData.put("IN_GUBUN", stockManagementVo.get(i).getSmInGubun());
				inProdData.put("ITEM_CD", stockManagementVo.get(i).getSmItemCd());
				inProdData.put("VERSION_IDX", stockManagementVo.get(i).getSmItemVersionIdx());
				inProdData.put("IN_QTY", stockManagementVo.get(i).getSmQty());
				inProdData.put("IN_DATE", stockManagementVo.get(i).getSmDate());
				inProdData.put("IN_CORP_CD", stockManagementVo.get(i).getSmInCorpIdx());
				inProdData.put("IN_STATUS", "A");//가입고(S)/입고(A)/확정(O)
				inProdData.put("LOT_NO", ""); //LOT 번호는 프로시저단에서 채번해야함
				inProdData.put("RELATION_NO", stockManagementVo.get(i).getSmInRelationNo());
				inProdData.put("WHS_GUBUN", stockManagementVo.get(i).getSmInWhsGubun());
				inProdData.put("WHS_IDX", stockManagementVo.get(i).getSmInWhsIdx());
				inProdData.put("LOC_IDX", stockManagementVo.get(i).getSmInLocIdx());
				inProdData.put("IN_USER_IDX", stockManagementVo.get(i).getSmInUserIdx());
				inProdData.put("IN_DESC", stockManagementVo.get(i).getSmDesc());
				inProd_array.add(inProdData);
								
				stockData.put("SP_NO", spNo);
				stockData.put("SP_SEQ", Integer.toString(i+1));
				stockData.put("SP_GUBUN", stockManagementVo.get(i).getSmItemGubun());
				stockData.put("SP_IDX", stockManagementVo.get(i).getSmItemCd());
				stockData.put("VERSION_IDX", stockManagementVo.get(i).getSmItemVersionIdx());
				stockData.put("SP_TYPE", "입고");
				stockData.put("SP_TYPE2", stockManagementVo.get(i).getSmType2());
				stockData.put("SP_DATE", stockManagementVo.get(i).getSmDate());
				stockData.put("SP_QTY", stockManagementVo.get(i).getSmQty());
				stockData.put("SP_LOT_NO", ""); //LOT 번호는 프로시저단에서 채번된걸 검색해서 가져와야함
				stockData.put("SP_SOURCE_NO", inSlipNo + "-" + Integer.toString(i+1));
				stockData.put("SP_WHS_GUBUN", stockManagementVo.get(i).getSmInWhsGubun());
				stockData.put("SP_WHS_IDX", stockManagementVo.get(i).getSmInWhsIdx());
				stockData.put("SP_LOC_IDX", stockManagementVo.get(i).getSmInLocIdx());
				stockData.put("IN_SLIP_NO", inSlipNo);
				stockData.put("IN_SLIP_SEQ", Integer.toString(i+1));
				stock_array.add(stockData);
				
			}	
			inProdWhsAdmVo.setInsertJson(inProd_array.toJSONString());
			inProdWhsAdmVo.setRegIdx(Utils.getUserIdx());
			inProdWhsAdmVo.setRegDate(regDate);
			inProdWhsAdmService.inProdWhsAdmIns(inProdWhsAdmVo); // 제품입고 등록
			stockPaymentAdmVo.setInsertJson(stock_array.toJSONString());
			stockPaymentAdmVo.setRegIdx(Utils.getUserIdx());
			stockPaymentAdmVo.setRegDate(regDate);
			stockPaymentAdmService.stockPaymentAdmIns(stockPaymentAdmVo); // 입고수불 등록
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
	//제품 입고 수정/입고
	public void ProdInputUpd(InProdWhsAdmVo inProdWhsAdmVo) throws Exception {
		try {
			logger.info("제품 입고/입고 -> " + inProdWhsAdmVo);
			inProdWhsAdmVo.setInStatus("B"); //가입고(S)/입고(A)
			inProdWhsAdmVo.setRegId(Utils.getUserIdx());
			inProdWhsAdmService.inProdWhsAdmUpd(inProdWhsAdmVo); // 제품입고 수정
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//제품 출고/출고
	public void ProdOutput(List<StockManagementVo> stockManagementVo) throws Exception {
		try {
			logger.info("제품 출고/출고 -> " + stockManagementVo.toString());
			
			OutProdWhsAdmVo outProdWhsAdmEmptyVo = new OutProdWhsAdmVo();
			String outSlipNo = outProdWhsAdmService.getOutSlipNo(outProdWhsAdmEmptyVo); // 출고수불 전표번호 채번
			
			StockPaymentAdmVo stockPaymentAdmEmptyVo = new StockPaymentAdmVo();
			String spNo = stockPaymentAdmService.stockPaymentAdmGetSpNo(stockPaymentAdmEmptyVo); // 출고수불 전표번호 채번
			
			String regDate = DateUtil.getCurrentDateTime();
			
			//수불 등록 JSON배열
			StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();
			JSONArray stock_array = new JSONArray();
			//제품 출고 전표 JSON배열
			OutProdWhsAdmVo outProdWhsAdmVo = new OutProdWhsAdmVo();
			JSONArray outProd_array = new JSONArray();
			
			for(int i=0;i<stockManagementVo.size();i++) {
				JSONObject outProdData = new JSONObject();
				JSONObject stockData = new JSONObject();
				
				outProdData.put("OUT_SLIP_NO", outSlipNo);
				outProdData.put("OUT_SLIP_SEQ", Integer.toString(i+1));
				outProdData.put("ITEM_GUBUN", stockManagementVo.get(i).getSmItemGubun());
				outProdData.put("OUT_GUBUN", stockManagementVo.get(i).getSmOutGubun());
				outProdData.put("ITEM_IDX", stockManagementVo.get(i).getSmItemIdx());
				outProdData.put("VERSION_IDX", stockManagementVo.get(i).getSmItemVersionIdx());
				outProdData.put("CAR_ASSIGNMENT", stockManagementVo.get(i).getSmCarAssignment());
				outProdData.put("OUT_QTY", stockManagementVo.get(i).getSmQty());
				outProdData.put("REMAIN_QTY", stockManagementVo.get(i).getSmQty());
				outProdData.put("OUT_DATE", stockManagementVo.get(i).getSmDate());
				outProdData.put("OutCorpIdx", stockManagementVo.get(i).getSmOutCorpIdx());
				outProdData.put("OUT_STATUS", stockManagementVo.get(i).getSmStatus());
				outProdData.put("LOT_NO", stockManagementVo.get(i).getSmLotNo());
				outProdData.put("RELATION_NO", stockManagementVo.get(i).getSmOutRelationNo());
				outProdData.put("WHS_GUBUN", stockManagementVo.get(i).getSmOutWhsGubun());
				outProdData.put("WHS_IDX", stockManagementVo.get(i).getSmOutWhsIdx());
				outProdData.put("LOC_IDX", stockManagementVo.get(i).getSmOutLocIdx());
				outProdData.put("OUT_DESC", stockManagementVo.get(i).getSmDesc());
				outProdData.put("OUT_PROD_ETC1", stockManagementVo.get(i).getSmEtc1());
				outProdData.put("OUT_PROD_ETC2", stockManagementVo.get(i).getSmEtc2());
				outProdData.put("OUT_PROD_ETC3", stockManagementVo.get(i).getSmEtc3());
				outProd_array.add(outProdData);
				
				stockData.put("SP_NO", spNo);
				stockData.put("SP_SEQ", Integer.toString(i+1));
				stockData.put("SP_GUBUN", "001");
				stockData.put("SP_IDX", stockManagementVo.get(i).getSmItemIdx());
				stockData.put("VERSION_IDX", stockManagementVo.get(i).getSmItemVersionIdx());
				stockData.put("SP_TYPE", stockManagementVo.get(i).getSmType());
				stockData.put("SP_TYPE2", stockManagementVo.get(i).getSmType2());
				stockData.put("SP_DATE", stockManagementVo.get(i).getSmDate());
				stockData.put("SP_QTY", stockManagementVo.get(i).getSmQty());
				stockData.put("SP_LOT_NO", stockManagementVo.get(i).getSmLotNo());
				stockData.put("SP_SOURCE_NO", outSlipNo+"-"+Integer.toString(i+1));
				stockData.put("SP_WHS_GUBUN", stockManagementVo.get(i).getSmOutWhsGubun());
				stockData.put("SP_WHS_IDX", stockManagementVo.get(i).getSmOutWhsIdx());
				stockData.put("SP_LOC_IDX", stockManagementVo.get(i).getSmOutLocIdx());
				stock_array.add(stockData);
				
			}
			outProdWhsAdmVo.setRegIdx(Utils.getUserIdx());
			outProdWhsAdmVo.setRegDate(regDate);
			outProdWhsAdmVo.setInsertJson(outProd_array.toJSONString());
			outProdWhsAdmService.outProdWhsAdmIns(outProdWhsAdmVo); // 제품 출고전표 등록
			stockPaymentAdmVo.setRegIdx(Utils.getUserIdx());
			stockPaymentAdmVo.setRegDate(regDate);
			stockPaymentAdmVo.setInsertJson(stock_array.toJSONString());
			stockPaymentAdmService.stockPaymentAdmIns(stockPaymentAdmVo); // 출고수불 등록
			
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
	//제품 출고/출고삭제
	public void ProdOutputDel(List<StockManagementVo> stockManagementVo) throws Exception {
		try {
			logger.info("제품 출고삭제/출고 -> " + stockManagementVo.toString());
			
			List<StockPaymentAdmVo> stockPaymentAdmOutputVo = new ArrayList<>(); // 제품수불 등록목록
			List<OutProdWhsAdmVo> outProdWhsAdmInputVo = new ArrayList<>(); // 제품출고 등록목록
			
			for(int i=0;i<stockManagementVo.size();i++) {
				OutProdWhsAdmVo outProdWhsAdmVo = new OutProdWhsAdmVo();
				outProdWhsAdmVo.setRelationNo(stockManagementVo.get(i).getSmOutRelationNo()); //작업지시번호
				outProdWhsAdmInputVo.add(outProdWhsAdmVo); // 제품입고 등록목록 추가
				
				StockPaymentAdmVo stockPaymentAdmOutVo = new StockPaymentAdmVo();
				stockPaymentAdmOutVo.setSpSourceNo(stockManagementVo.get(i).getSmSourceNo());
				stockPaymentAdmOutputVo.add(stockPaymentAdmOutVo); // 출고수불 등록목록
			}
			
			for(int i=0;i<stockManagementVo.size();i++) {
				outProdWhsAdmService.outProdWhsAdmDelByRelationNo(outProdWhsAdmInputVo.get(i)); // 제품입고 등록
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	
	// 제품 ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑
	// 재공품 ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
	
	//재공품 입고/공정입고
	public void ProgressProdInput(List<StockManagementVo> stockManagementVo) throws Exception {
		try {
			logger.info("재공품 입고/공정입고 -> " + stockManagementVo.toString());
			
			StockPaymentWorkAdmVo stockPaymentWorkAdmEmptyVo = new StockPaymentWorkAdmVo();
			String swNo = stockPaymentWorkAdmService.getSwNo(stockPaymentWorkAdmEmptyVo); // 재공품 입고수불 전표번호 채번
			
			List<StockPaymentWorkAdmVo> stockPaymentWorkAdmInputVo = new ArrayList<>(); // 재공품 입고수불 등록목록
			
			for(int i=0;i<stockManagementVo.size();i++) {
				StockPaymentWorkAdmVo stockPaymentWorkAdmVo = new StockPaymentWorkAdmVo();
				stockPaymentWorkAdmVo.setSwNo(swNo);
				stockPaymentWorkAdmVo.setSwSeq(Integer.toString(i+1));
				stockPaymentWorkAdmVo.setSwItemCd(stockManagementVo.get(i).getSmItemCd());
				stockPaymentWorkAdmVo.setSwPrcssCd(stockManagementVo.get(i).getSmPrcssCd());
				stockPaymentWorkAdmVo.setSwType(stockManagementVo.get(i).getSmType());
				stockPaymentWorkAdmVo.setSwType2(stockManagementVo.get(i).getSmType2());
				stockPaymentWorkAdmVo.setSwDate(stockManagementVo.get(i).getSmDate());
				stockPaymentWorkAdmVo.setSwQty(stockManagementVo.get(i).getSmQty());
				stockPaymentWorkAdmVo.setSwLotNo(stockManagementVo.get(i).getSmLotNo());
				stockPaymentWorkAdmVo.setSwSourceNo(stockManagementVo.get(i).getSmSourceNo());
				stockPaymentWorkAdmVo.setRegId(Utils.getUserIdx());
				stockPaymentWorkAdmInputVo.add(stockPaymentWorkAdmVo); // 재공품 입고수불 추가
			}
			
			for(int i=0;i<stockPaymentWorkAdmInputVo.size();i++) {
				StockPaymentWorkAdmVo stockPaymentWorkAdmLotVo = new StockPaymentWorkAdmVo();
				stockPaymentWorkAdmLotVo.setSwItemCd(stockPaymentWorkAdmInputVo.get(i).getSwItemCd());
				stockPaymentWorkAdmLotVo.setSwPrcssCd(stockPaymentWorkAdmInputVo.get(i).getSwPrcssCd());
				String lotNo = stockPaymentWorkAdmService.getLotNo(stockPaymentWorkAdmLotVo); // 재공품 입고수불 전표번호 채번
				
				stockPaymentWorkAdmInputVo.get(i).setSwLotNo(lotNo);
				
				stockPaymentWorkAdmService.stockPaymentWorkAdmIns(stockPaymentWorkAdmInputVo.get(i)); // 재공품 입고수불 등록
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//재공품 출고/공정출고
	public void ProgressProdOut(List<StockManagementVo> stockManagementVo) throws Exception {
		try {
			logger.info("재공품 출고/공정출고 -> " + stockManagementVo.toString());
			
			StockPaymentWorkAdmVo stockPaymentWorkAdmEmptyVo = new StockPaymentWorkAdmVo();
			String swNo = stockPaymentWorkAdmService.getSwNo(stockPaymentWorkAdmEmptyVo); // 재공품 출고수불 전표번호 채번
			
			List<StockPaymentWorkAdmVo> stockPaymentWorkAdmOutputVo = new ArrayList<>(); // 재공품 출고수불 등록목록
			
			for(int i=0;i<stockManagementVo.size();i++) {
				StockPaymentWorkAdmVo stockPaymentWorkAdmVo = new StockPaymentWorkAdmVo();
				stockPaymentWorkAdmVo.setSwNo(swNo);
				stockPaymentWorkAdmVo.setSwSeq(Integer.toString(i+1));
				stockPaymentWorkAdmVo.setSwItemCd(stockManagementVo.get(i).getSmItemCd());
				stockPaymentWorkAdmVo.setSwPrcssCd(stockManagementVo.get(i).getSmPrcssCd());
				stockPaymentWorkAdmVo.setSwType(stockManagementVo.get(i).getSmType());
				stockPaymentWorkAdmVo.setSwType2(stockManagementVo.get(i).getSmType2());
				stockPaymentWorkAdmVo.setSwDate(stockManagementVo.get(i).getSmDate());
				stockPaymentWorkAdmVo.setSwQty(stockManagementVo.get(i).getSmQty());
				stockPaymentWorkAdmVo.setSwLotNo(stockManagementVo.get(i).getSmLotNo());
				stockPaymentWorkAdmVo.setSwSourceNo(stockManagementVo.get(i).getSmSourceNo());
				stockPaymentWorkAdmVo.setRegId(Utils.getUserIdx());
				stockPaymentWorkAdmOutputVo.add(stockPaymentWorkAdmVo); // 재공품 출고수불 추가
			}
			
			for(int i=0;i<stockPaymentWorkAdmOutputVo.size();i++) {
				stockPaymentWorkAdmService.stockPaymentWorkAdmIns(stockPaymentWorkAdmOutputVo.get(i)); // 재공품 출고수불 등록
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//재공품 재고이동
	public void ProgressProdMove(List<StockManagementVo> stockManagementVo) throws Exception {
		try {
			logger.info("재공품 재고이동 -> " + stockManagementVo.toString());
			
			StockPaymentWorkAdmVo stockPaymentWorkAdmEmptyVo = new StockPaymentWorkAdmVo();
			String swNo = stockPaymentWorkAdmService.getSwNo(stockPaymentWorkAdmEmptyVo); // 재공품 입출고수불 전표번호 채번
			
			List<StockPaymentWorkAdmVo> stockPaymentWorkAdmOutputVo = new ArrayList<>(); // 재공품 출고수불 등록목록
			List<StockPaymentWorkAdmVo> stockPaymentWorkAdmInputVo = new ArrayList<>(); // 재공품 입고수불 등록목록
			
			for(int i=0;i<stockManagementVo.size();i++) {
				StockPaymentWorkAdmVo stockPaymentWorkAdmOutVo = new StockPaymentWorkAdmVo();
				stockPaymentWorkAdmOutVo.setSwNo(swNo);
				stockPaymentWorkAdmOutVo.setSwSeq(Integer.toString(i*2+1));
				stockPaymentWorkAdmOutVo.setSwItemCd(stockManagementVo.get(i).getSmItemCd());
				stockPaymentWorkAdmOutVo.setSwPrcssCd(stockManagementVo.get(i).getSmPrcssCd());
				stockPaymentWorkAdmOutVo.setSwType(stockManagementVo.get(i).getSmType());
				stockPaymentWorkAdmOutVo.setSwType2(stockManagementVo.get(i).getSmType2());
				stockPaymentWorkAdmOutVo.setSwDate(stockManagementVo.get(i).getSmDate());
				stockPaymentWorkAdmOutVo.setSwQty(stockManagementVo.get(i).getSmQty());
				stockPaymentWorkAdmOutVo.setSwLotNo(stockManagementVo.get(i).getSmLotNo());
				stockPaymentWorkAdmOutVo.setSwSourceNo(stockManagementVo.get(i).getSmSourceNo());
				stockPaymentWorkAdmOutVo.setRegId(Utils.getUserIdx());
				stockPaymentWorkAdmOutputVo.add(stockPaymentWorkAdmOutVo); // 재공품 출고수불 추가
				
				StockPaymentWorkAdmVo stockPaymentWorkAdmInVo = new StockPaymentWorkAdmVo();
				stockPaymentWorkAdmInVo.setSwNo(swNo);
				stockPaymentWorkAdmInVo.setSwSeq(Integer.toString(i*2+2));
				stockPaymentWorkAdmInVo.setSwItemCd(stockManagementVo.get(i).getSmItemCd());
				stockPaymentWorkAdmInVo.setSwPrcssCd(stockManagementVo.get(i).getSmPrcssCd());
				stockPaymentWorkAdmInVo.setSwType(stockManagementVo.get(i).getSmType());
				stockPaymentWorkAdmInVo.setSwType2(stockManagementVo.get(i).getSmType2());
				stockPaymentWorkAdmInVo.setSwDate(stockManagementVo.get(i).getSmDate());
				stockPaymentWorkAdmInVo.setSwQty(stockManagementVo.get(i).getSmQty());
				stockPaymentWorkAdmInVo.setSwLotNo(stockManagementVo.get(i).getSmLotNo());
				stockPaymentWorkAdmInVo.setSwSourceNo(stockManagementVo.get(i).getSmSourceNo());
				stockPaymentWorkAdmInVo.setRegId(Utils.getUserIdx());
				stockPaymentWorkAdmInputVo.add(stockPaymentWorkAdmInVo); // 재공품 입고수불 추가
			}
			
			for(int i=0;i<stockManagementVo.size();i++) {
				stockPaymentWorkAdmService.stockPaymentWorkAdmIns(stockPaymentWorkAdmOutputVo.get(i)); // 재공품 출고수불 등록
				stockPaymentWorkAdmService.stockPaymentWorkAdmIns(stockPaymentWorkAdmInputVo.get(i)); // 재공품 입고수불 등록
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	// 재공품 ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑
	// 초기재고 ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

	//초기재고/재고조정 등록
	public void adjustmentStockInput(List<StockManagementVo> stockManagementVo) throws Exception {
		try {
			logger.info("초기재고/재고조정 -> " + stockManagementVo.toString());
			
			StockAdjustAdmVo stockPaymentAdmEmptyVo = new StockAdjustAdmVo();
			String saNo = stockAdjustAdmService.getSaNo(stockPaymentAdmEmptyVo);
			
			String regDate = DateUtil.getCurrentDateTime();
			//초기재고 등록배열
			JSONArray stockIns_array = new JSONArray();
			StockAdjustAdmVo stockAdjustAdmVo = new StockAdjustAdmVo();
			for(int i=0;i<stockManagementVo.size();i++) {
				JSONObject stockAdjustData = new JSONObject();
				stockAdjustData.put("SA_NO", saNo);
				stockAdjustData.put("SA_SEQ", Integer.toString(i+1));
				stockAdjustData.put("SA_GUBUN", stockManagementVo.get(i).getSmItemGubun());
				stockAdjustData.put("SA_CD", stockManagementVo.get(i).getSmItemCd());
				stockAdjustData.put("VERSION_IDX", stockManagementVo.get(i).getSmItemVersionIdx());
				stockAdjustData.put("SA_CMPT_QTY", stockManagementVo.get(i).getSmCmptQty());
				stockAdjustData.put("SA_REAL_QTY", stockManagementVo.get(i).getSmRealQty());
				stockAdjustData.put("SA_DIFF_QTY", stockManagementVo.get(i).getSmDiffQty());
				stockAdjustData.put("SA_LOT_NO", "");//재고반영후생성
				stockAdjustData.put("SA_APPD_DATE", stockManagementVo.get(i).getSmAppdDate());
				stockAdjustData.put("SA_APPD_YN", "N");
				stockAdjustData.put("SA_TYPE", stockManagementVo.get(i).getSmType());
				stockAdjustData.put("SA_WHS_GUBUN", stockManagementVo.get(i).getSmInWhsGubun());
				stockAdjustData.put("SA_WHS_IDX", stockManagementVo.get(i).getSmInWhsIdx());
				stockAdjustData.put("SA_LOC_IDX", stockManagementVo.get(i).getSmInLocIdx());
				stockAdjustData.put("SA_DESC", stockManagementVo.get(i).getSmDesc());
				stockAdjustData.put("SA_ETC1", "");
				stockAdjustData.put("SA_ETC2", "");
				stockAdjustData.put("SA_ETC3", "");
				
				stockIns_array.add(stockAdjustData);
			}
			
			stockAdjustAdmVo.setInsertJson(stockIns_array.toJSONString());
			stockAdjustAdmVo.setRegIdx(Utils.getUserIdx());
			stockAdjustAdmVo.setRegDate(regDate);
			stockAdjustAdmService.stockAdjustAdmIns(stockAdjustAdmVo);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//초기재고/재고조정 등록 및 반영
	public void adjustmentStockInputAndApply(List<StockManagementVo> stockManagementVo) throws Exception {
		try {
			logger.info("초기재고/재고조정 -> " + stockManagementVo.toString());
			
			StockAdjustAdmVo stockPaymentAdmEmptyVo = new StockAdjustAdmVo();
			String saNo = stockAdjustAdmService.getSaNo(stockPaymentAdmEmptyVo);
			
			String regDate = DateUtil.getCurrentDateTime();
			
			StockPaymentAdmVo stockPaymentInAdmVo = new StockPaymentAdmVo();	//입고수불
			String spNo = stockPaymentAdmService.stockPaymentAdmGetSpNo(stockPaymentInAdmVo); // 입고수불 전표번호 채번
			
			//초기재고 등록배열
			JSONArray stockIns_array = new JSONArray();
			StockAdjustAdmVo stockAdjustAdmVo = new StockAdjustAdmVo();
			JSONArray stock_array = new JSONArray();
			for(int i=0;i<stockManagementVo.size();i++) {
				JSONObject stockAdjustData = new JSONObject();
				stockAdjustData.put("SA_NO", saNo);
				stockAdjustData.put("SA_SEQ", Integer.toString(i+1));
				stockAdjustData.put("SA_GUBUN", stockManagementVo.get(i).getSmItemGubun());
				stockAdjustData.put("SA_CD", stockManagementVo.get(i).getSmItemCd());
				stockAdjustData.put("VERSION_IDX", stockManagementVo.get(i).getSmItemVersionIdx());
				stockAdjustData.put("SA_CMPT_QTY", stockManagementVo.get(i).getSmCmptQty());
				stockAdjustData.put("SA_REAL_QTY", stockManagementVo.get(i).getSmRealQty());
				stockAdjustData.put("SA_DIFF_QTY", stockManagementVo.get(i).getSmDiffQty());
				stockAdjustData.put("SA_LOT_NO", "");//재고반영후생성
				stockAdjustData.put("SA_APPD_DATE", stockManagementVo.get(i).getSmAppdDate());
				stockAdjustData.put("SA_APPD_YN", "Y");
				stockAdjustData.put("SA_TYPE", stockManagementVo.get(i).getSmType());
				stockAdjustData.put("SA_WHS_GUBUN", stockManagementVo.get(i).getSmInWhsGubun());
				stockAdjustData.put("SA_WHS_IDX", stockManagementVo.get(i).getSmInWhsIdx());
				stockAdjustData.put("SA_LOC_IDX", stockManagementVo.get(i).getSmInLocIdx());
				stockAdjustData.put("SA_DESC", stockManagementVo.get(i).getSmDesc());
				stockAdjustData.put("SA_ETC1", "");
				stockAdjustData.put("SA_ETC2", "");
				stockAdjustData.put("SA_ETC3", "");
				
				stockIns_array.add(stockAdjustData);
				
				StockPaymentAdmVo stockPaymentAdmInVo = new StockPaymentAdmVo();
				JSONObject stockData = new JSONObject();
				stockData.put("SP_NO", spNo);
				stockData.put("SP_SEQ", Integer.toString(i+1));
				stockData.put("SP_GUBUN", stockManagementVo.get(i).getSmItemGubun());
				stockData.put("SP_IDX", stockManagementVo.get(i).getSmItemCd());
				stockData.put("VERSION_IDX", stockManagementVo.get(i).getSmItemVersionIdx());
				stockData.put("SP_DATE", stockManagementVo.get(i).getSmAppdDate());
				//초기재고 인경우
				if("A".equals(stockManagementVo.get(i).getSmType())) {
					stockPaymentAdmInVo.setSpType("조정입고");
					stockPaymentAdmInVo.setSpQty(stockManagementVo.get(i).getSmRealQty());
					if("001".equals(stockManagementVo.get(i).getSmItemGubun())) {
						//제품인경우
						stockPaymentAdmInVo.setSpType2("ISAP");//제품조정입고
					} else if("002".equals(stockManagementVo.get(i).getSmItemGubun())){
						//자재인경우
						stockPaymentAdmInVo.setSpType2("ISAM");//자재조정입고
					}
				} else if("B".equals(stockManagementVo.get(i).getSmType())){
					//재고조정인경우
					if(Integer.parseInt(stockManagementVo.get(i).getSmDiffQty()) < 0) {
						stockPaymentAdmInVo.setSpType("조정입고");
						stockPaymentAdmInVo.setSpQty(Integer.toString(Integer.parseInt(stockManagementVo.get(i).getSmDiffQty()) * -1));
						if("001".equals(stockManagementVo.get(i).getSmItemGubun())) {
							//제품인경우
							stockPaymentAdmInVo.setSpType2("ISAP");//제품조정입고
						} else if("002".equals(stockManagementVo.get(i).getSmItemGubun())){
							//자재인경우
							stockPaymentAdmInVo.setSpType2("ISAM");//자재조정입고
						}
					} else {
						stockPaymentAdmInVo.setSpType("조정출고");
						stockPaymentAdmInVo.setSpQty(stockManagementVo.get(i).getSmDiffQty());
						if("001".equals(stockManagementVo.get(i).getSmItemGubun())) {
							//제품인경우
							
							stockPaymentAdmInVo.setSpType2("OSAP");//제품조정출고
						} else if("002".equals(stockManagementVo.get(i).getSmItemGubun())){
							//자재인경우
							stockPaymentAdmInVo.setSpType2("OSAM");//자재조정출고
						}
					}
				}
				stockData.put("SP_TYPE", stockPaymentAdmInVo.getSpType());
				stockData.put("SP_QTY", stockPaymentAdmInVo.getSpQty());
				stockData.put("SP_TYPE2", stockPaymentAdmInVo.getSpType2());
				stockData.put("SP_LOT_NO", stockManagementVo.get(i).getSmLotNo());
				stockData.put("SP_SOURCE_NO", saNo + "-" + Integer.toString(i+1));
				stockData.put("SP_WHS_GUBUN", stockManagementVo.get(i).getSmInWhsGubun());
				stockData.put("SP_WHS_IDX", stockManagementVo.get(i).getSmInWhsIdx());
				stockData.put("SP_LOC_IDX", stockManagementVo.get(i).getSmInLocIdx());
				stockData.put("SP_DESC", stockManagementVo.get(i).getSmDesc());
				stock_array.add(stockData);
				
				
			}
			
			stockAdjustAdmVo.setInsertJson(stockIns_array.toJSONString());
			stockAdjustAdmVo.setRegIdx(Utils.getUserIdx());
			stockAdjustAdmVo.setRegDate(regDate);
			stockAdjustAdmService.stockAdjustAdmIns(stockAdjustAdmVo);
			StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();
			stockPaymentAdmVo.setInsertJson(stock_array.toJSONString());
			stockPaymentAdmVo.setRegIdx(Utils.getUserIdx());
			stockPaymentAdmVo.setRegDate(regDate);
			stockPaymentAdmService.stockPaymentAdmIns(stockPaymentAdmVo); // 수불 등록
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//초기재고/재고조정 - 재고반영
	public void adjustmentStockApply(List<StockManagementVo> stockManagementVo) throws Exception {
		try {
			logger.info("초기재고/재고조정 재고반영 -> " + stockManagementVo.toString());
			
			StockPaymentAdmVo stockPaymentAdmEmptyVo = new StockPaymentAdmVo();	//입고수불
			String spNo = stockPaymentAdmService.stockPaymentAdmGetSpNo(stockPaymentAdmEmptyVo); // 입고수불 전표번호 채번
			
			String regDate = DateUtil.getCurrentDateTime();
			String updDate = regDate;
			
			StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();
			JSONArray stock_array = new JSONArray();
			List<StockAdjustAdmVo> stockAdjustAdmUpdateVo = new ArrayList<>(); //재고반영
			List<StockPaymentAdmVo> stockPaymentAdmInputVo = new ArrayList<>(); //재고반영
			
			for(int i=0;i<stockManagementVo.size();i++) {
				StockAdjustAdmVo stockAdjustAdmVo = new StockAdjustAdmVo();
				stockAdjustAdmVo.setSaNo(stockManagementVo.get(i).getSmNo());
				stockAdjustAdmVo.setSaSeq(stockManagementVo.get(i).getSmSeq());
				stockAdjustAdmVo.setSaLotNo(stockManagementVo.get(i).getSmLotNo()); 
				stockAdjustAdmVo.setSaAppdYn(stockManagementVo.get(i).getSmAppdYn());
				stockAdjustAdmVo.setSaCmptQty(stockManagementVo.get(i).getSmCmptQty());
				stockAdjustAdmVo.setSaRealQty(stockManagementVo.get(i).getSmRealQty());
				stockAdjustAdmVo.setSaDiffQty(stockManagementVo.get(i).getSmDiffQty());
				stockAdjustAdmVo.setSaAppdDate(stockManagementVo.get(i).getSmAppdDate());
				stockAdjustAdmVo.setSaWhsIdx(stockManagementVo.get(i).getSmInWhsIdx());
				stockAdjustAdmVo.setSaLocIdx(stockManagementVo.get(i).getSmInLocIdx());
				stockAdjustAdmVo.setSaDesc(stockManagementVo.get(i).getSmDesc());
				stockAdjustAdmVo.setUpdIdx(Utils.getUserIdx());
				stockAdjustAdmVo.setUpdDate(updDate);
				stockAdjustAdmUpdateVo.add(stockAdjustAdmVo); 
				
				
				StockPaymentAdmVo stockPaymentAdmInVo = new StockPaymentAdmVo();
				stockPaymentAdmInVo.setSpNo(spNo);
				stockPaymentAdmInVo.setSpSeq(Integer.toString(i+1));
				stockPaymentAdmInVo.setSpGubun(stockManagementVo.get(i).getSmItemGubun());
				stockPaymentAdmInVo.setSpIdx(stockManagementVo.get(i).getSmItemCd());
				stockPaymentAdmInVo.setSpItemVerIdx(stockManagementVo.get(i).getSmItemVersionIdx());
				stockPaymentAdmInVo.setSpDate(stockManagementVo.get(i).getSmAppdDate());
				//초기재고 인경우
				if("A".equals(stockManagementVo.get(i).getSmType())) {
					stockPaymentAdmInVo.setSpType("조정입고");
					stockPaymentAdmInVo.setSpQty(stockManagementVo.get(i).getSmRealQty());
					if("001".equals(stockManagementVo.get(i).getSmItemGubun())) {
						//제품인경우
						stockPaymentAdmInVo.setSpType2("ISAP");//제품조정입고
					} else if("002".equals(stockManagementVo.get(i).getSmItemGubun())){
						//자재인경우
						stockPaymentAdmInVo.setSpType2("ISAM");//자재조정입고
					}
				} else if("B".equals(stockManagementVo.get(i).getSmType())){
					//재고조정인경우
					if(Integer.parseInt(stockManagementVo.get(i).getSmDiffQty()) < 0) {
						stockPaymentAdmInVo.setSpType("조정입고");
						stockPaymentAdmInVo.setSpQty(Integer.toString(Integer.parseInt(stockManagementVo.get(i).getSmDiffQty()) * -1));
						if("001".equals(stockManagementVo.get(i).getSmItemGubun())) {
							//제품인경우
							stockPaymentAdmInVo.setSpType2("ISAP");//제품조정입고
						} else if("002".equals(stockManagementVo.get(i).getSmItemGubun())){
							//자재인경우
							stockPaymentAdmInVo.setSpType2("ISAM");//자재조정입고
						}
					} else {
						stockPaymentAdmInVo.setSpType("조정출고");
						stockPaymentAdmInVo.setSpQty(stockManagementVo.get(i).getSmDiffQty());
						if("001".equals(stockManagementVo.get(i).getSmItemGubun())) {
							//제품인경우
							
							stockPaymentAdmInVo.setSpType2("OSAP");//제품조정출고
						} else if("002".equals(stockManagementVo.get(i).getSmItemGubun())){
							//자재인경우
							stockPaymentAdmInVo.setSpType2("OSAM");//자재조정출고
						}
					}
				}
				stockPaymentAdmInVo.setSpLotNo(stockManagementVo.get(i).getSmLotNo());
				stockPaymentAdmInVo.setSpSourceNo(stockAdjustAdmVo.getSaNo()+"-"+stockAdjustAdmVo.getSaSeq());
				stockPaymentAdmInVo.setSpWhsGubun(stockManagementVo.get(i).getSmInWhsGubun());
				stockPaymentAdmInVo.setSpWhsIdx(stockManagementVo.get(i).getSmInWhsIdx());
				stockPaymentAdmInVo.setSpLocIdx(stockManagementVo.get(i).getSmInLocIdx());
				stockPaymentAdmInVo.setSpDesc(stockManagementVo.get(i).getSmDesc());
				stockPaymentAdmInVo.setRegIdx(Utils.getUserIdx());
				stockPaymentAdmInVo.setRegDate(regDate);
				stockPaymentAdmInputVo.add(stockPaymentAdmInVo); // 입고수불 등록목록
			}
			
			for(int i=0;i<stockManagementVo.size();i++) {
				stockAdjustAdmService.stockAdjustAdmUpd(stockAdjustAdmUpdateVo.get(i));	//재고조정 수정
				if("Y".equals(stockAdjustAdmUpdateVo.get(i).getResultYn())) {
					//해당 재고조정을 업데이트했을 경우 수불 등록
					JSONObject stockData = new JSONObject();
					stockData.put("SP_NO", stockPaymentAdmInputVo.get(i).getSpNo());
					stockData.put("SP_SEQ", stockPaymentAdmInputVo.get(i).getSpSeq());
					stockData.put("SP_GUBUN", stockPaymentAdmInputVo.get(i).getSpGubun());
					stockData.put("SP_IDX", stockPaymentAdmInputVo.get(i).getSpIdx());
					stockData.put("VERSION_IDX", stockPaymentAdmInputVo.get(i).getSpItemVerIdx());
					stockData.put("SP_DATE", stockPaymentAdmInputVo.get(i).getSpDate());
					stockData.put("SP_TYPE", stockPaymentAdmInputVo.get(i).getSpType());
					stockData.put("SP_QTY", stockPaymentAdmInputVo.get(i).getSpQty());
					stockData.put("SP_TYPE2", stockPaymentAdmInputVo.get(i).getSpType2());
					stockData.put("SP_LOT_NO", stockPaymentAdmInputVo.get(i).getSpLotNo());
					stockData.put("SP_SOURCE_NO", stockPaymentAdmInputVo.get(i).getSpSourceNo());
					stockData.put("SP_WHS_GUBUN", stockPaymentAdmInputVo.get(i).getSpWhsGubun());
					stockData.put("SP_WHS_IDX", stockPaymentAdmInputVo.get(i).getSpWhsIdx());
					stockData.put("SP_LOC_IDX", stockPaymentAdmInputVo.get(i).getSpLocIdx());
					stockData.put("SP_DESC", stockPaymentAdmInputVo.get(i).getSpDesc());
					stock_array.add(stockData);
				}
			}
			stockPaymentAdmVo.setInsertJson(stock_array.toJSONString());
			stockPaymentAdmVo.setRegIdx(Utils.getUserIdx());
			stockPaymentAdmVo.setRegDate(regDate);
			stockPaymentAdmService.stockPaymentAdmIns(stockPaymentAdmVo); // 수불 등록
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//초기재고/재고조정 - 재고반영 취소
	public void adjustmentStockCancle(List<StockManagementVo> stockManagementVo) throws Exception {
		try {
			logger.info("초기재고/재고조정 재고반영 취소 -> " + stockManagementVo.toString());
			
			String updDate = DateUtil.getCurrentDateTime();
			
			List<StockAdjustAdmVo> stockAdjustAdmUpdateVo = new ArrayList<>(); //재고반영
			List<StockPaymentAdmVo> stockPaymentAdmDeleteVo = new ArrayList<>(); //재고반영
			
			StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();
			JSONArray stock_array = new JSONArray();
			
			for(int i=0;i<stockManagementVo.size();i++) {
				StockAdjustAdmVo stockAdjustAdmVo = new StockAdjustAdmVo();
				stockAdjustAdmVo.setSaNo(stockManagementVo.get(i).getSmNo());
				stockAdjustAdmVo.setSaSeq(stockManagementVo.get(i).getSmSeq());
				stockAdjustAdmVo.setSaLotNo(""); 
				stockAdjustAdmVo.setSaAppdYn("N");
				stockAdjustAdmVo.setUpdIdx(Utils.getUserIdx());
				stockAdjustAdmVo.setSaCmptQty(stockManagementVo.get(i).getSmCmptQty());
				stockAdjustAdmVo.setSaRealQty(stockManagementVo.get(i).getSmRealQty());
				stockAdjustAdmVo.setSaDiffQty(stockManagementVo.get(i).getSmDiffQty());
				stockAdjustAdmVo.setSaAppdDate(stockManagementVo.get(i).getSmAppdDate());
				stockAdjustAdmVo.setSaWhsIdx(stockManagementVo.get(i).getSmInWhsIdx());
				stockAdjustAdmVo.setSaLocIdx(stockManagementVo.get(i).getSmInLocIdx());
				stockAdjustAdmVo.setSaDesc(stockManagementVo.get(i).getSmDesc());
				stockAdjustAdmVo.setUpdIdx(Utils.getUserIdx());
				stockAdjustAdmVo.setUpdDate(updDate);
				stockAdjustAdmUpdateVo.add(stockAdjustAdmVo); 
				
				
				JSONObject stockData = new JSONObject();
				stockData.put("SP_SOURCE_NO", stockAdjustAdmVo.getSaNo()+"-"+stockAdjustAdmVo.getSaSeq());
				stock_array.add(stockData);
			}
			
			for(int i=0;i<stockManagementVo.size();i++) {
				stockAdjustAdmService.stockAdjustAdmUpd(stockAdjustAdmUpdateVo.get(i));	//재고조정 수정
			}
			
			stockPaymentAdmVo.setDeleteJson(stock_array.toJSONString());
			stockPaymentAdmService.stockPaymentAdmDel(stockPaymentAdmVo); // 수불 삭제
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
}
