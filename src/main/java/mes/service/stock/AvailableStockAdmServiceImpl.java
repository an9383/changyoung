package mes.service.stock;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Repository;

import mes.domain.bs.BizOrderVo;
import mes.domain.stock.AvailableStockAdmVo;
import mes.persistence.stock.AvailableStockAdmDAO;

@Repository
public class AvailableStockAdmServiceImpl implements AvailableStockAdmService {

	@Inject
	private AvailableStockAdmDAO dao;
	
	// 가용재고 등록
	@Override
	public void availableStockAdmIns(AvailableStockAdmVo availableStockAdmVo) throws Exception {
		dao.availableStockAdmIns(availableStockAdmVo);
	}
	
	// 가용재고 계산을 위한 발주 목록 조회
	@Override
	public List<AvailableStockAdmVo> availableStockPurchaseLst(AvailableStockAdmVo availableStockAdmVo) throws Exception {
		return dao.availableStockPurchaseLst(availableStockAdmVo);
	}
	
}
