package mes.persistence.stock;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.stock.StockPaymentWorkAdmVo;

@Repository
public class StockPaymentWorkAdmDAOImpl implements StockPaymentWorkAdmDAO {

	@Inject
	private SqlSession session;

	private static final String namespace = "mes.mappers.stock.stockPaymentWorkAdmMapper";
	
	// 재공품 수불관리 등록
	@Override
	public void stockPaymentWorkAdmIns(StockPaymentWorkAdmVo stockPaymentWorkAdmVo) throws Exception {
		session.insert(namespace+".stockPaymentWorkAdmIns" ,stockPaymentWorkAdmVo);
	}
	
	// 재공품 수불관리 삭제
	@Override
	public void stockPaymentWorkAdmDel(StockPaymentWorkAdmVo stockPaymentWorkAdmVo) throws Exception {
		session.delete(namespace+".stockPaymentWorkAdmDel" ,stockPaymentWorkAdmVo);
	}
	
	// 재공품 수불관리 전표번호 조회
	@Override
	public String getSwNo(StockPaymentWorkAdmVo stockPaymentWorkAdmVo) throws Exception {
		return session.selectOne(namespace+".getSwNo" ,stockPaymentWorkAdmVo);
	}
	
	// 재공품 수불관리 LOT번호 조회
	@Override
	public String getLotNo(StockPaymentWorkAdmVo stockPaymentWorkAdmVo) throws Exception {
		return session.selectOne(namespace+".getLotNo" ,stockPaymentWorkAdmVo);
	}
}
