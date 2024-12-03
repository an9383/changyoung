package mes.domain.stock;

import lombok.Data;

@Data
public class StockPaymentWorkAdmVo {
	private String swNo;
	private String swSeq;
	private String swItemCd;
	private String swPrcssCd;
	private String swType;
	private String swType2;
	private String swDate;
	private String swQty;
	private String swLotNo;
	private String swSourceNo;
	private String swDesc;
	private String swEtc1;
	private String swEtc2;
	private String swEtc3;
	private String regId;
	private String regDate;
}
