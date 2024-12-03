package mes.domain.stock;

import lombok.Data;

@Data
public class StockTotalAdmVo {
	private String stNo;
	private String stSeq;
	private String stYear;
	private String stMon;
	private String stGubun;
	private String stCd;
	private String stLotNo;
	private String stWhsGubun;
	private String stWhsIdx;
	private String stLocIdx;
	private String stTmQty;
	private String stInQty;
	private String stOutQty;
	private String stInAdjQty;
	private String stOutAdjQty;
	private String stRealQty;
	private String stDesc;
	private String stEtc1;
	private String stEtc2;
	private String stEtc3;
	private String regId;
	private String regDate;
}
