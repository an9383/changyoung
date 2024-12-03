package mes.service.stock;

import javax.inject.Inject;

import org.springframework.stereotype.Repository;

import mes.domain.stock.StockTotalAdmVo;
import mes.persistence.stock.StockTotalAdmDAO;

@Repository
public class StockTotalAdmServiceImpl implements StockTotalAdmService {

	@Inject
	private StockTotalAdmDAO dao;
	
	// 수불집계 등록
	@Override
	public void stockTotalAdmIns(StockTotalAdmVo stockTotalAdmVo) throws Exception {
		dao.stockTotalAdmIns(stockTotalAdmVo);
	}
	
	// 수불집계 삭제
	@Override
	public void stockTotalAdmDel(StockTotalAdmVo stockTotalAdmVo) throws Exception {
		dao.stockTotalAdmDel(stockTotalAdmVo);
	}
	
	// 수불집계 전표번호 조회
	@Override
	public String getStNo(StockTotalAdmVo stockTotalAdmVo) throws Exception {
		return dao.getStNo(stockTotalAdmVo);
	}
}
