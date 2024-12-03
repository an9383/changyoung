package mes.service.stock;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Repository;

import mes.domain.stock.StockAdjustAdmVo;
import mes.persistence.stock.StockAdjustAdmDAO;

@Repository
public class StockAdjustAdmServiceImpl implements StockAdjustAdmService {

	@Inject
	private StockAdjustAdmDAO dao;
	
	// 초기/재고조정 등록
	@Override
	public void stockAdjustAdmIns(StockAdjustAdmVo stockAdjustAdmVo) throws Exception {
		dao.stockAdjustAdmIns(stockAdjustAdmVo);
	}
	
	// 초기/재고조정 수정
	@Override
	public void stockAdjustAdmUpd(StockAdjustAdmVo stockAdjustAdmVo) throws Exception {
		dao.stockAdjustAdmUpd(stockAdjustAdmVo);
	}
	
	// 초기/재고조정 삭제
	@Override
	public void stockAdjustAdmDel(StockAdjustAdmVo stockAdjustAdmVo) throws Exception {
		dao.stockAdjustAdmDel(stockAdjustAdmVo);
	}
	
	// 초기/재고조정 전표번호 조회
	@Override
	public String getSaNo(StockAdjustAdmVo stockAdjustAdmVo) throws Exception {
		return dao.getSaNo(stockAdjustAdmVo);
	}
	
	// 초기/재고조정 목록 조회
	@Override
	public List<StockAdjustAdmVo> stockAdjustAdmListBySaNo(StockAdjustAdmVo stockAdjustAdmVo) throws Exception {
		return dao.stockAdjustAdmListBySaNo(stockAdjustAdmVo);
	}
	
	// 초기/재고조정 목록 조회
	@Override
	public List<StockAdjustAdmVo> stockAdjustAdmListGroupBySaNo(StockAdjustAdmVo stockAdjustAdmVo) throws Exception {
		return dao.stockAdjustAdmListGroupBySaNo(stockAdjustAdmVo);
	}
}
