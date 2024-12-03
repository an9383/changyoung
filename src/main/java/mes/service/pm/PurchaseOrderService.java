package mes.service.pm;

import java.util.List;

import mes.domain.bs.BizOrderVo;
import mes.domain.pm.PurchaseOrderVo;

public interface PurchaseOrderService {
	
	// =========================== 발주관리 메인 ==========================================
	// 발주관리 메인 목록조회
	public List<PurchaseOrderVo> purchaseOrderAdmLst(PurchaseOrderVo purchaseOrderVo) throws Exception;
	
	// 발주관리 발주서번호별 목록조회
	public List<PurchaseOrderVo> purchaseOrderAdmLstByPurchasePrintNo(PurchaseOrderVo purchaseOrderVo) throws Exception;
	
	// 발주관리 수주상세식별자별 목록조회
	public List<PurchaseOrderVo> purchaseOrderAdmLstByBizDtlIdx(PurchaseOrderVo purchaseOrderVo) throws Exception;
	
	// 발주관리 발주서번호별 입고 상세 목록조회
	public List<PurchaseOrderVo> purchaseOrderDtlLstByPurchasePrintNo(PurchaseOrderVo purchaseOrderVo) throws Exception;

	// 발주관리 수주별 목록조회
	public List<PurchaseOrderVo> purchaseOrderAdmLstByBizDtl(PurchaseOrderVo purchaseOrderVo) throws Exception;
	
	// 발주관리 공정별 목록조회
	public List<PurchaseOrderVo> purchaseOrderAdmLstByWorkOrdPrcss(PurchaseOrderVo purchaseOrderVo) throws Exception;

	// 발주관리 개별발주 목록조회
	public List<PurchaseOrderVo> purchaseOrderAdmLstBySingle(PurchaseOrderVo purchaseOrderVo) throws Exception;
	
	// 발주관리 메인 상세조회
	public PurchaseOrderVo purchaseOrderAdmSel(PurchaseOrderVo purchaseOrderVo) throws Exception;
	
	// 발주관리 메인 등록
	public String purchaseOrderAdmIns(PurchaseOrderVo purchaseOrderVo) throws Exception;
	
	// 발주관리 메인 수정
	public void purchaseOrderAdmUpd(PurchaseOrderVo purchaseOrderVo) throws Exception;
	
	// 발주관리 메인 수정/삭제 체크
	public PurchaseOrderVo purchaseOrderAdmUpdCheckByBizOrdDtlIdx(PurchaseOrderVo purchaseOrderVo) throws Exception;

	// 발주관리 메인 수정/삭제 체크
	public PurchaseOrderVo purchaseOrderAdmUpdCheckByBizOrdDtlIdxJson(PurchaseOrderVo purchaseOrderVo) throws Exception;

	// 발주관리 입고예정일 수정
	public void purchaseOrderInDueDateAdmUpd(PurchaseOrderVo purchaseOrderVo) throws Exception;

	// 발주관리 주문수량 수정
	public void purchaseOrderQtyAdmUpd(PurchaseOrderVo purchaseOrderVo) throws Exception;
	
	// 발주관리 메인 삭제
	public void purchaseOrderAdmDel(PurchaseOrderVo purchaseOrderVo) throws Exception;
	
	// 발주관리 발주서 출력번호 및 출력여부 수정
	public void purchasePaperUpd(PurchaseOrderVo purchaseOrderVo) throws Exception;
	
	// 발주관리 발주서 출력번호 삭제 및 출력여부 수정
	public void purchasePaperDel(PurchaseOrderVo purchaseOrderVo) throws Exception;

	// =========================== 발주관리 입고등록페이지 ==========================================
	// 발주 목록조회
	public List<PurchaseOrderVo> purchaseOrderAdmLstSumInQty(PurchaseOrderVo purchaseOrderVo) throws Exception;
	
	// =========================== 발주관리 필요량 계산 ==========================================
	// 발주 재질별 필요량 계산 목록조회
	public List<PurchaseOrderVo> purchaseOrderAdmLstWithNeedQty(PurchaseOrderVo purchaseOrderVo) throws Exception;
	
	// 발주 재질별 가용재고량 목록 조회
	public List<PurchaseOrderVo> purchaseOrderAdmLstWithAsQty(PurchaseOrderVo purchaseOrderVo) throws Exception;
		
	// =========================== 입고원장 페이지 ==========================================
	// 입고원장 목록조회
	public List<PurchaseOrderVo> inOrginLst(PurchaseOrderVo purchaseOrderVo) throws Exception;
}
