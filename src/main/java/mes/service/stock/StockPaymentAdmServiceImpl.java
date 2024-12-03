package mes.service.stock;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Repository;

import mes.domain.stock.StockPaymentAdmVo;
import mes.persistence.stock.StockPaymentAdmDAO;

@Repository
public class StockPaymentAdmServiceImpl implements StockPaymentAdmService {

	@Inject
	private StockPaymentAdmDAO dao;
	
	// 수불관리 조회
	@Override
	public StockPaymentAdmVo stockPaymentAdmSelBySpSourceNo(StockPaymentAdmVo stockPaymentAdmVo) throws Exception {
		return dao.stockPaymentAdmSelBySpSourceNo(stockPaymentAdmVo);
	}
	
	//수불관리 - 재고이동가능여부체크
	@Override
	public StockPaymentAdmVo stockMoveYnCheckByBizOrdDtlIdx(StockPaymentAdmVo stockPaymentAdmVo) throws Exception {
		return dao.stockMoveYnCheckByBizOrdDtlIdx(stockPaymentAdmVo);
	}
	
	// 수불리스트 조회
	@Override
	public List<StockPaymentAdmVo> stockLstBySpSourceNo(StockPaymentAdmVo stockPaymentAdmVo) throws Exception {
		return dao.stockLstBySpSourceNo(stockPaymentAdmVo);
	}
	
	// 수불관리 등록
	@Override
	public void stockPaymentAdmIns(StockPaymentAdmVo stockPaymentAdmVo) throws Exception {
		dao.stockPaymentAdmIns(stockPaymentAdmVo);
	}
	
	// 수불관리 등록 ( 채번 없이 강제로 데이터만 등록 )
	@Override
	public void stockPaymentAdmCompulsionIns(StockPaymentAdmVo stockPaymentAdmVo) throws Exception {
		dao.stockPaymentAdmCompulsionIns(stockPaymentAdmVo);
	}
	
	// 수불관리 삭제
	@Override
	public void stockPaymentAdmDel(StockPaymentAdmVo stockPaymentAdmVo) throws Exception {
		dao.stockPaymentAdmDel(stockPaymentAdmVo);
	}
	
	// 수불관리 전표번호 조회
	@Override
	public String stockPaymentAdmGetSpNo(StockPaymentAdmVo stockPaymentAdmVo) throws Exception {
		return dao.stockPaymentAdmGetSpNo(stockPaymentAdmVo);
	}
	
	// ================================== 현재고현황 =======================================
	// 현재고현황 목록조회
	@Override
	public List<StockPaymentAdmVo> stockPaymentAdmStatusLst(StockPaymentAdmVo stockPaymentAdmVo) throws Exception {
		return dao.stockPaymentAdmStatusLst(stockPaymentAdmVo);
	}

	// 현재고현황 목록조회 - 제품
	@Override
	public List<StockPaymentAdmVo> stockPaymentAdmItemLst(StockPaymentAdmVo stockPaymentAdmVo) throws Exception {
		return dao.stockPaymentAdmItemLst(stockPaymentAdmVo);
	}
	
	// 현재고현황 목록조회 - 자재
	@Override
	public List<StockPaymentAdmVo> stockPaymentAdmMatrlLst(StockPaymentAdmVo stockPaymentAdmVo) throws Exception {
		return dao.stockPaymentAdmMatrlLst(stockPaymentAdmVo);
	}
	
	// 재고이동 목록조회
	@Override
	public List<StockPaymentAdmVo> stockPaymentMoveLst(StockPaymentAdmVo stockPaymentAdmVo) throws Exception {
		return dao.stockPaymentMoveLst(stockPaymentAdmVo);
	}
	
	// 수불원장 목록조회
	@Override
	public List<StockPaymentAdmVo> stockPaymentAdmOriginalLst(StockPaymentAdmVo stockPaymentAdmVo) throws Exception {
		return dao.stockPaymentAdmOriginalLst(stockPaymentAdmVo);
	}
	
	// ================================== 불용재고현황 =======================================
	// 불용재고현황 목록조회
	@Override
	public List<StockPaymentAdmVo> obsoleteStockLst(StockPaymentAdmVo stockPaymentAdmVo) throws Exception {
		return dao.obsoleteStockLst(stockPaymentAdmVo);
	}
	
}
