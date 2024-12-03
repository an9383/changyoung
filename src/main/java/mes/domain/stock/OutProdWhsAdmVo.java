package mes.domain.stock;

import lombok.Data;

@Data
public class OutProdWhsAdmVo {

	private String outNoString;
	private String outSlipNo;
	private String outSlipSeq;
	private String outSlipIdx;
	private String itemGubun;
	private String outGubun;
	private String itemCd;
	private String carAssignment;
	private String carAssignmentNm;
	private String preOutQty;
	private String outQty;
	private String remainQty;
	private String preOutDate;
	private String outDate;
	private String outCorpIdx;
	private String outStatus;
	private String lotNo;
	private String relationNo;
	private String whsGubun;
	private String whsIdx;
	private String locIdx;
	private String workOutDesc;
	private String outDesc;
	private String spQty;
	private String regIdx;
	private String regDate;
	private String updIdx;
	private String updDate;
	private String groupData;
	private String workQtyCheck;
	
	//리스트 조회에 필요한 vo
	private String bizStatusCd;
	private String bizStatusCdNm;
	private String rowNumber;
	private String itemVersionIdx;
	private String itemVersion;
	private String ordDate;
	private String bizOrdDtlNo;
	private String bizDealCorpNm;
	private String bizOrdQty;
	private String stockReUseQty;
	private String itemNm;
	private String paperType;
	private String versionNm;
	private String customerItemCd;
	private String versionNum;
	private String ordDtlDesc;
	private String purchaseBatch;
	private String workEndReqDate;
	private String outReqDate;
	private String ordQty;
	private String fairQty;
	private String dealCorpIdx;
	private String dealCorpNm;
	private String dealCorpAddress;
	private String companyNumber;
	private String rePresentative;
	private String addressAdm;
	private String workplaceIdx;
	private String workPlaceNm;
	private String bizOrdAdmIdx;
	private String itemIdx;
	private String outProdEtc1;
	private String outProdDealCorpNm;
	private String outProdDealCorpInitial;
	private String outProdDealCorpIdx;
	private String outProdEtc2;
	private String outProdEtc3;
	private String outProdEtc4;
	private String outProdEtc5;
	private String searchTarget;
	private String startDate;
	private String endDate;
	private String workMethodJson;
	private String dealCorpJson;
	private String qualityJudgmentNm;
	private String ordIssue;
	private String packUnit;
	private String packMethodNm;
	private String etc9;
	private String etc7;
	private String statementStandard;
	
	private String bizOrdDtlIdx;
	private String bizOrdOutReqDate;
	
	private String insertJson;
	private String updateJson;
	private String deleteJson;
	private String bundlingJson;
	private String resultYn;
	private String resMessage;
	private String printYn;
	private String bundleCount;
	
}
