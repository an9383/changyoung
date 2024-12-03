package mes.persistence.stock;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.stock.StockTotalAdmVo;

@Repository
public class StockTotalAdmDAOImpl implements StockTotalAdmDAO {

	@Inject
	private SqlSession session;

	private static final String namespace = "mes.mappers.stock.stockTotalAdmMapper";
	
	// 수불집계 등록
	@Override
	public void stockTotalAdmIns(StockTotalAdmVo stockTotalAdmVo) throws Exception {
		session.insert(namespace+".stockTotalAdmIns" ,stockTotalAdmVo);
	}
	
	// 수불집계 삭제
	@Override
	public void stockTotalAdmDel(StockTotalAdmVo stockTotalAdmVo) throws Exception {
		session.delete(namespace+".stockTotalAdmDel" ,stockTotalAdmVo);
	}
	
	// 수불집계 전표번호 조회
	@Override
	public String getStNo(StockTotalAdmVo stockTotalAdmVo) throws Exception {
		return session.selectOne(namespace+".getStNo" ,stockTotalAdmVo);
	}
}
