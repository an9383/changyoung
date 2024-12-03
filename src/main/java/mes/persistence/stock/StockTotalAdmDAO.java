package mes.persistence.stock;

import mes.domain.stock.StockTotalAdmVo;

public interface StockTotalAdmDAO {
	
	// 수불집계 등록
	public void stockTotalAdmIns(StockTotalAdmVo stockTotalAdmVo) throws Exception;
	
	// 수불집계 삭제
	public void stockTotalAdmDel(StockTotalAdmVo stockTotalAdmVo) throws Exception;
	
	// 수불집계 전표번호 조회
	public String getStNo(StockTotalAdmVo stockTotalAdmVo) throws Exception;
}