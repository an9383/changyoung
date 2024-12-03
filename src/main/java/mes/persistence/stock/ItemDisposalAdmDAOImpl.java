package mes.persistence.stock;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.stock.ItemDisposalAdmVo;

@Repository
public class ItemDisposalAdmDAOImpl implements ItemDisposalAdmDAO {

	@Inject
	private SqlSession session;

	private static final String namespace = "mes.mappers.stock.itemDisposalAdmMapper";
	
	//제품 재고폐기 조회
	@Override
	public List<ItemDisposalAdmVo> itemDisposalAdmLst(ItemDisposalAdmVo itemDisposalAdmVo) throws Exception {
		return session.selectList(namespace+".itemDisposalAdmLst" , itemDisposalAdmVo);
	}
	
	//제품 재고폐기 등록
	@Override
	public void itemDisposalAdmIns(ItemDisposalAdmVo itemDisposalAdmVo) throws Exception {
		session.insert(namespace+".itemDisposalAdmIns" ,itemDisposalAdmVo);
	}
	
	//제품 재고폐기 수정
	@Override
	public void itemDisposalAdmUpd(ItemDisposalAdmVo itemDisposalAdmVo) throws Exception {
		session.update(namespace+".itemDisposalAdmUpd" ,itemDisposalAdmVo);
	}
	
	//제품 재고폐기 수정
	@Override
	public void itemDisposalAdmCheckYnUpd(ItemDisposalAdmVo itemDisposalAdmVo) throws Exception {
		session.update(namespace+".itemDisposalAdmCheckYnUpd" ,itemDisposalAdmVo);
	}
	
	//제품 재고폐기 삭제
	@Override
	public void itemDisposalAdmDel(ItemDisposalAdmVo itemDisposalAdmVo) throws Exception {
		session.update(namespace+".itemDisposalAdmDel" ,itemDisposalAdmVo);
	}
}
