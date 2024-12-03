package mes.domain.stock;

import lombok.Data;

@Data
public class InProdWhsAdmVo {
	private String inSlipNo;
	private String inSlipSeq;
	private String itemGubun;
	private String inGubun;
	private String itemCd;
	private String preInQty;
	private String inQty;
	private String remainQty;
	private String preInDate;
	private String inDate;
	private String inCorpCd;
	private String inStatus;
	private String lotNo;
	private String relationNo;
	private String faultyReason;	
	private String whsGubun;
	private String whsIdx;
	private String locIdx;
	private String inUserIdx;
	private String inDesc;
	private String regId;
	private String regIdx;
	private String regDate;
	private String updId;
	private String updDate;
	
	private String insertJson;
	private String deleteJson;
}
