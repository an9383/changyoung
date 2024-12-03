package mes.domain.stock;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
@Alias("StockAdjustAdmVo")
public class StockAdjustAdmVo {
	private String saNo;
	private String saSeq;
	private String saSeqCount;
	private String saGubun;
	private String saCd;
	private String saNm;
	private String saCmptQty;
	private String saRealQty;
	private String saDiffQty;
	private String saLotNo;
	private String saAppdDate;
	private String saAppdYn;
	private String saType;
	private String saWhsGubun;
	private String saWhsIdx;
	private String lcIdx;
	private String lcNm;
	private String saLocIdx;
	private String lcDtlIdx;
	private String lcDtlNm;
	private String saDesc;
	private String saEtc1;
	private String saEtc2;
	private String saEtc3;
	private String regIdx;
	private String regDate;
	private String updIdx;
	private String updDate;
	private String resultYn;
	private String resMessage;
	private String startDate;
	private String endDate;
	private String itemVerIdx;
	
	private String insertJson;
}
