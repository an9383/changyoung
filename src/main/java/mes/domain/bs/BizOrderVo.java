package mes.domain.bs;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
@Alias("BizOrderVo")
public class BizOrderVo {
	private String progressOrder;
	private String idx;
	private String mergeIdx;
	private String bizOrdDtlIdx;
	private String bizOrdDtlIdxString;
	private String purchaseIdx;	
	private String bizOrdNo;
	private String dealCorpIdx;
	private String ordDate;
	private String outReqDate;
	private String ordGubun;
	private String ordDesc;
	private String workOrdCnt;
	private String workplaceIdx;
	private String bizOrdAdmIdx;
	private String bizOrdDtlNo;
	private String bizStatusCd;
	private String stockUseYn;
	private String versionStock;
	private String ordQty;
	private String stockUseQty;
	private String stockReUseQty;
	private String purchaseBatch;
	private String itemIdx;
	private String stringItemIdx;
	private String workEndReqDate;
	private String bizStopYn;
	private String confirmOrder;
	private String confirmDesign;
	private String ordNote;
	private String ordIssue;
	private String ordDtlDesc;
	private String newEditHistPrintYn;
	private String bundlePrintYn;
	private String bundleCnt;
	private String purchaseUuid;
	private String purchaseFileName;
	private String purchaseExt;
	private String workPrintYn;
	private String regIdx;
	private String regDate;
	private String updIdx;
	private String updDate;
	
	private String rowNumber;
	private String startDate;
	private String endDate;
	private String ordGubunNm;
	private String dealCorpCd;
	private String dealCorpNm;
	private String itemCd;
	private String customerItemCd;
	private String itemNm;
	private String itemSize;
	private String knifeTipSize;
	private String woodenCareCd;
	private String holeWoodenCd;
	private String itemColor;
	private String frequency;
	private String specialNotice;
	private String relayNotice;
	private String coatingMethod;
	private String moldingMethod;
	private String bundleMethod;
	private String bundleUnit; 
	private String packMethod;
	private String packUnit;
	private String workPrinter;
	private String detailDate;
	private String masterPaper;
	private String roundPlateCnt;
	private String careCd;
	private String plane;
	private String inspectMethod;
	private String printingYnCheck;
	private String plateSize;
	private String etc1;
	private String itemGubun;
	private String cmyk;
	private String resinBoard;
	
	private String woodenCareNm;
	private String bundleMethodNm;
	private String packMethodNm;
	private String inspectMethodNm;
	private String printingYnCheckNm;
	private String itemGubunNm;
	private String itemVerIdx;
	private String itemVersion;
	private String ext;
	private String fileNm;
	private String uuid;
	private String regIdxNm;
	private String resinBoardNm;
	
	private String matrlCd;
	private String matrlNm;
	private String paperType;
	private String paperTypeNm;
	private String purchaseOrdNo;
	private String cutQty;
	private String eaQty;
	private String extraQty;
	private String extraPackQty;
	private String cutSize;
	private String purchaseOrdQty;
	private String purchaseOrdDate;
	private String purchaseInDueDate;
	private String confirmYn;
	private String printYn;
	private String purchaseNote;
	private String purchaseDesc;
	
	private String spQty;
	private String outQty;
	private String purchaseTarget;
	private String workOrdPrcssJson;
	private String sizeX;
	private String sizeY;
	private String extraStock;
	private String purchaseQty;
	private String searchTarget;
	private String searchInMatrlTarget;
	
	private String inQty;
	private String inDate;
	private String updateJson;
	private String resultYn;
	private String resMessage;
	private String resIdx;
	private String resEtc9;
	
	private String bizOrdDtlCnt;
	private String conFirmCnt;
	private String purOrdCnt;
	private String prodOutCnt;
	private String stockOutCnt;
	private String workMethodJson;
	
	private String etc2;
	private String dealCorpNm2; 
	private String printPressQty; //정매
	private String printPressAndExtraQty; //여분
	private String finalPurchaseQty; //구매연수
}
