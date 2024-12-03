package mes.persistence.wm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.wm.ItemPurchaseVo;

@Repository
public class ItemPurchaseDAOImpl implements ItemPurchaseDAO {

	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.wm.itemPurchaseMapper";

	//발주목록 조회
	@Override
	public List<ItemPurchaseVo> itemPurchaseOrdLstGroupByPurchaseNo(ItemPurchaseVo itemPurchaseVo) throws Exception {
		return session.selectList(namespace+".itemPurchaseOrdLstGroupByPurchaseNo", itemPurchaseVo);
	}
	
	//발주목록 조회  - 발주번호 기준
	@Override
	public List<ItemPurchaseVo> itemPurchaseOrdLstByPurchaseNo(ItemPurchaseVo itemPurchaseVo) throws Exception {
		return session.selectList(namespace+".itemPurchaseOrdLstByPurchaseNo", itemPurchaseVo);
	}
	
	//입고목록 조회  - 발주번호 기준
	@Override
	public List<ItemPurchaseVo> inItemLstByPurchaseNo(ItemPurchaseVo itemPurchaseVo) throws Exception {
		return session.selectList(namespace+".inItemLstByPurchaseNo", itemPurchaseVo);
	}

	//상품발주 등록
	@Override
	public void itemPurchaseIns(ItemPurchaseVo itemPurchaseVo) throws Exception {
		session.insert(namespace+".itemPurchaseIns", itemPurchaseVo);
	}

	//상품발주 수정
	@Override
	public void itemPurchaseUpd(ItemPurchaseVo itemPurchaseVo) throws Exception {
		session.update(namespace+".itemPurchaseUpd", itemPurchaseVo);
	}
	
	//상품발주 삭제
	@Override
	public void itemPurchaseDel(ItemPurchaseVo itemPurchaseVo) throws Exception {
		session.update(namespace+".itemPurchaseDel", itemPurchaseVo);
	}
}
