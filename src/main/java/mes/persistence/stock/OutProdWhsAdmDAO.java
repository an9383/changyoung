package mes.persistence.stock;

import java.util.List;

import mes.domain.bm.ItemInfoAdmVo;
import mes.domain.stock.OutProdWhsAdmVo;

public interface OutProdWhsAdmDAO {
	
	// 수주의 출고가능한 제품 조회 
	public List<OutProdWhsAdmVo> bizOrderDtlList(OutProdWhsAdmVo outProdWhsAdmVo) throws Exception;
	
	// 수주의 출고 내역
	public List<OutProdWhsAdmVo> bizOrderProdOutLst(OutProdWhsAdmVo outProdWhsAdmVo) throws Exception;
	
	// 출고전표 조회
	public List<OutProdWhsAdmVo> getOutProdLstByOutNo(OutProdWhsAdmVo outProdWhsAdmVo) throws Exception;
	
	// 제품 출고전표 등록
	public void outProdWhsAdmIns(OutProdWhsAdmVo outProdWhsAdmVo) throws Exception;
	
	// 제품 출고전표 등록
	public void outProdWhsAdmCompulsionIns(OutProdWhsAdmVo outProdWhsAdmVo) throws Exception;
	
	// 제품 출고전표 수정
	public void outProdWhsAdmUpd(OutProdWhsAdmVo outProdWhsAdmVo) throws Exception;
	
	// 제품 출고전표 삭제
	public void outProdWhsAdmDel(OutProdWhsAdmVo outProdWhsAdmVo) throws Exception;
	
	// 제품 출고전표 삭제 
	public void outProdWhsAdmDelByRelationNo(OutProdWhsAdmVo outProdWhsAdmVo) throws Exception;

	// 제품 전표번호 조회
	public String getOutSlipNo(OutProdWhsAdmVo outProdWhsAdmVo) throws Exception;
	
	// 제품 전표번호 조회
	public List<OutProdWhsAdmVo> getOutSlipNoByRelationNo(OutProdWhsAdmVo outProdWhsAdmVo) throws Exception;
	
	//********************************** 납품계획등록 **********************************
	//납품계획등록 조회
	public List<OutProdWhsAdmVo> deliveryPlanList(OutProdWhsAdmVo outProdWhsAdmVo) throws Exception;
	
	//********************************** 원거래명세서출력 **********************************
	// 제품 출고내역 조회
	public List<OutProdWhsAdmVo> outProdDtlList(OutProdWhsAdmVo outProdWhsAdmVo) throws Exception;
	
	// 원거래명세서출력 번호 발급
	public void tradingStatementUpd(OutProdWhsAdmVo outProdWhsAdmVo) throws Exception;
	
	// 원거래명세서출력 번호 삭제
	public void tradingStatementDel(OutProdWhsAdmVo outProdWhsAdmVo) throws Exception;
	
	//bizOrdDtlNo로 번들링 목록조회
	public List<OutProdWhsAdmVo> bizOrderDtlBundleListWithBizOrdDtlNo(OutProdWhsAdmVo outProdWhsAdmVo) throws Exception;
	
}