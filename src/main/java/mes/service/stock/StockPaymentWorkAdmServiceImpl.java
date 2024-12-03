package mes.service.stock;

import javax.inject.Inject;

import org.springframework.stereotype.Repository;

import mes.domain.stock.StockPaymentWorkAdmVo;
import mes.persistence.stock.StockPaymentWorkAdmDAO;

@Repository
public class StockPaymentWorkAdmServiceImpl implements StockPaymentWorkAdmService {

	@Inject
	private StockPaymentWorkAdmDAO dao;
	
	// 재공품 수불관리 등록
	@Override
	public void stockPaymentWorkAdmIns(StockPaymentWorkAdmVo stockPaymentWorkAdmVo) throws Exception {
		dao.stockPaymentWorkAdmIns(stockPaymentWorkAdmVo);
	}
	
	// 재공품 수불관리 삭제
	@Override
	public void stockPaymentWorkAdmDel(StockPaymentWorkAdmVo stockPaymentWorkAdmVo) throws Exception {
		dao.stockPaymentWorkAdmDel(stockPaymentWorkAdmVo);
	}
	
	// 재공품 수불관리 전표번호 조회
	@Override
	public String getSwNo(StockPaymentWorkAdmVo stockPaymentWorkAdmVo) throws Exception {
		return dao.getSwNo(stockPaymentWorkAdmVo);
	}
	
	// 재공품 수불관리 LOT번호 조회
	@Override
	public String getLotNo(StockPaymentWorkAdmVo stockPaymentWorkAdmVo) throws Exception {
		return dao.getLotNo(stockPaymentWorkAdmVo);
	}
}
