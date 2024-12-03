package mes.persistence.stock;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.bs.BizOrderVo;
import mes.domain.stock.AvailableStockAdmVo;

@Repository
public class AvailableStockAdmDAOImpl implements AvailableStockAdmDAO {

	@Inject
	private SqlSession session;

	private static final String namespace = "mes.mappers.stock.availableStockAdmMapper";
	
	
	// 가용재고 등록
	@Override
	public void availableStockAdmIns(AvailableStockAdmVo availableStockAdmVo) throws Exception {
		session.insert(namespace+".availableStockAdmIns" ,availableStockAdmVo);
	}
	
	// 가용재고 계산을 위한 발주 목록 조회
	@Override
	public List<AvailableStockAdmVo> availableStockPurchaseLst(AvailableStockAdmVo availableStockAdmVo) throws Exception {
		return session.selectList(namespace+".availableStockPurchaseLst", availableStockAdmVo);
	}
}
