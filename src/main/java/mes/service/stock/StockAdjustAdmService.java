package mes.service.stock;

import java.util.List;

import mes.domain.stock.StockAdjustAdmVo;

public interface StockAdjustAdmService {
	
	// 초기/재고조정 등록
	public void stockAdjustAdmIns(StockAdjustAdmVo stockAdjustAdmVo) throws Exception;
	
	// 초기/재고조정 수정
	public void stockAdjustAdmUpd(StockAdjustAdmVo stockAdjustAdmVo) throws Exception;
	
	// 초기/재고조정 삭제
	public void stockAdjustAdmDel(StockAdjustAdmVo stockAdjustAdmVo) throws Exception;
	
	// 초기/재고조정 전표번호 조회
	public String getSaNo(StockAdjustAdmVo stockAdjustAdmVo) throws Exception;
	
	// 초기/재고조정 목록 조회
	public List<StockAdjustAdmVo> stockAdjustAdmListBySaNo(StockAdjustAdmVo stockAdjustAdmVo) throws Exception;
	
	// 초기/재고조정 목록 조회
	public List<StockAdjustAdmVo> stockAdjustAdmListGroupBySaNo(StockAdjustAdmVo stockAdjustAdmVo) throws Exception;
}