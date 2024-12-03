package mes.service.stock;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Repository;

import mes.domain.stock.ItemDisposalAdmVo;
import mes.persistence.stock.ItemDisposalAdmDAO;

@Repository
public class ItemDisposalAdmServiceImpl implements ItemDisposalAdmService {

	@Inject
	private ItemDisposalAdmDAO dao;
	
	//제품 재고폐기 조회
	@Override
	public List<ItemDisposalAdmVo> itemDisposalAdmLst(ItemDisposalAdmVo itemDisposalAdmVo) throws Exception {
		return dao.itemDisposalAdmLst(itemDisposalAdmVo);
	}
	
	//제품 재고폐기 등록
	@Override
	public void itemDisposalAdmIns(ItemDisposalAdmVo itemDisposalAdmVo) throws Exception {
		dao.itemDisposalAdmIns(itemDisposalAdmVo);
	}
	
	//제품 재고폐기 수정
	@Override
	public void itemDisposalAdmUpd(ItemDisposalAdmVo itemDisposalAdmVo) throws Exception {
		dao.itemDisposalAdmUpd(itemDisposalAdmVo);
	}
	
	//제품 재고폐기 수정
	@Override
	public void itemDisposalAdmCheckYnUpd(ItemDisposalAdmVo itemDisposalAdmVo) throws Exception {
		dao.itemDisposalAdmCheckYnUpd(itemDisposalAdmVo);
	}

	//제품 재고폐기 삭제
	@Override
	public void itemDisposalAdmDel(ItemDisposalAdmVo itemDisposalAdmVo) throws Exception {
		dao.itemDisposalAdmDel(itemDisposalAdmVo);
	}
	
}
