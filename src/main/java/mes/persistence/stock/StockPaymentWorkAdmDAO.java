package mes.persistence.stock;

import mes.domain.stock.InMatrWhsAdmVo;
import mes.domain.stock.StockPaymentWorkAdmVo;

public interface StockPaymentWorkAdmDAO {
	
	// 재공품 수불관리 등록
	public void stockPaymentWorkAdmIns(StockPaymentWorkAdmVo stockPaymentWorkAdmVo) throws Exception;
	
	// 재공품 수불관리 삭제
	public void stockPaymentWorkAdmDel(StockPaymentWorkAdmVo stockPaymentWorkAdmVo) throws Exception;
	
	// 재공품 수불관리 전표번호 조회
	public String getSwNo(StockPaymentWorkAdmVo stockPaymentWorkAdmVo) throws Exception;
	
	// 재공품 수불관리 LOT번호 조회
	public String getLotNo(StockPaymentWorkAdmVo stockPaymentWorkAdmVo) throws Exception;
}