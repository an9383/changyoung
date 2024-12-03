package mes.persistence.stock;

import java.util.List;

import mes.domain.stock.AvailableStockAdmVo;

public interface AvailableStockAdmDAO {

	// 가용재고 등록
	public void availableStockAdmIns(AvailableStockAdmVo availableStockAdmVo) throws Exception;
	
	// 가용재고 계산을 위한 발주 목록 조회
	public List<AvailableStockAdmVo> availableStockPurchaseLst(AvailableStockAdmVo availableStockAdmVo) throws Exception;
	
}