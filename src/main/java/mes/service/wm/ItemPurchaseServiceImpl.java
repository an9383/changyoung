package mes.service.wm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.wm.ItemPurchaseVo;
import mes.persistence.wm.ItemPurchaseDAO;

@Service
public class ItemPurchaseServiceImpl implements ItemPurchaseService {

	@Inject
	private ItemPurchaseDAO dao;
	
	//발주목록 조회
	@Override
	public List<ItemPurchaseVo> itemPurchaseOrdLstGroupByPurchaseNo(ItemPurchaseVo itemPurchaseVo) throws Exception {
		return dao.itemPurchaseOrdLstGroupByPurchaseNo(itemPurchaseVo);
	}
	
	//발주목록 조회  - 발주번호 기준
	@Override
	public List<ItemPurchaseVo> itemPurchaseOrdLstByPurchaseNo(ItemPurchaseVo itemPurchaseVo) throws Exception {
		return dao.itemPurchaseOrdLstByPurchaseNo(itemPurchaseVo);
	}
	
	//입고목록 조회  - 발주번호 기준
	@Override
	public List<ItemPurchaseVo> inItemLstByPurchaseNo(ItemPurchaseVo itemPurchaseVo) throws Exception {
		return dao.inItemLstByPurchaseNo(itemPurchaseVo);
	}
	
	//상품발주 등록
	@Override
	public void itemPurchaseIns(ItemPurchaseVo itemPurchaseVo) throws Exception {
		dao.itemPurchaseIns(itemPurchaseVo);
	}
	
	//상품발주 수정
	@Override
	public void itemPurchaseUpd(ItemPurchaseVo itemPurchaseVo) throws Exception {
		dao.itemPurchaseUpd(itemPurchaseVo);
	}

	//상품발주 삭제
	@Override
	public void itemPurchaseDel(ItemPurchaseVo itemPurchaseVo) throws Exception {
		dao.itemPurchaseDel(itemPurchaseVo);
	}
}
