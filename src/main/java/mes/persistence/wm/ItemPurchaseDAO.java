package mes.persistence.wm;

import java.util.List;

import mes.domain.wm.ItemPurchaseVo;

public interface ItemPurchaseDAO {

	//발주목록 조회
	public List<ItemPurchaseVo> itemPurchaseOrdLstGroupByPurchaseNo(ItemPurchaseVo itemPurchaseVo) throws Exception;
	
	//발주목록 조회  - 발주번호 기준
	public List<ItemPurchaseVo> itemPurchaseOrdLstByPurchaseNo(ItemPurchaseVo itemPurchaseVo) throws Exception;
	
	//입고목록 조회  - 발주번호 기준
	public List<ItemPurchaseVo> inItemLstByPurchaseNo(ItemPurchaseVo itemPurchaseVo) throws Exception;
	
	//상품발주 등록
	public void itemPurchaseIns(ItemPurchaseVo itemPurchaseVo) throws Exception;
	
	//상품발주 수정
	public void itemPurchaseUpd(ItemPurchaseVo itemPurchaseVo) throws Exception;
	
	//상품발주 삭제
	public void itemPurchaseDel(ItemPurchaseVo itemPurchaseVo) throws Exception;
	
}
