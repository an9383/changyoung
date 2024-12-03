package mes.domain.pm;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
@Alias("PurchaseOrderVo")
public class PurchaseOrderVo {
	
	private String selectGubun;
	private String plusMinus;
	private String idx;
	private String extraStock;
	private String mergeIdx;
	private String matrlIdx;
	private String bizOrdDtlIdx;
	private String bizStatusNm;
	private String bizDealCorpNm;
	private String workOrdPrcssIdx;
	private String locationIdx;
	private String locationNm;
	private String bizOrdDtlNo;
	private String bizOrdNo;
	private String purchaseOrdNo;
	private String purchaseDealCorpNm;
	private String cutQty;
	private String eaQty;
	private String extraQty;
	private String extraPackQty;
	private String cutSize;
	private String purchaseOrdQty;
	private String purchaseOrdQtySum;
	private String purchaseOrdDate;
	private String ordDate;
	private String purchaseInDueDate;
	private String dealCorpIdx;
	private String stockUseYn;
	private String confirmYn;
	private String printYn;
	private String purchaseNote;
	private String purchaseDesc;
	private String purchasePrintNo;
	private String regIdx;
	private String regDate;
	private String updIdx;
	private String updDate;
	
	private String ordQty;
	private String itemGubun;
	private String spNm;
	private String matrlCd;
	private String matrlNm;
	private String amountAvg;
	private String matrlSize;
	private String matrlSizeNm;
	private String lawGubun;
	private String lawGubunNm;
	private String itemNm;
	private String sizeX;
	private String sizeY;
	private String paperType;
	private String paperTypeNm;
	private String dealCorpNm;
	private String inQty;
	private String inDate;
	private String inDesc;
	private String inQtySum;
	private String addCutting;
	
	private String startDate;
	private String endDate;
	
	private String rowNumber;
	private String purchaseOrdIdx;
	private String stockQty;
	private String purchaseQty;
	private String needQty;
	private String spQty;
	private String asQty;
	private String printDate;
	private String purchaseOrdQtyCnt;
	private String searchInMatrlTarget;
	
	private String purchaseOrdIdxList;
	private String returnIdx;
	
	private String frequencyNm;
	private String searchTarget;
	private String stockUseNotSearch;
	private String workEndReqDate;
	private String updateJson;
	private String purchaseOrdIdxJson;
	private String groupData;
	private String successYn;
	private String resultYn;
	private String resMessage;
	private String dayGubun;
	private String searchDayGubun;
	private String etc2;
	private String etc1Nm;
	
	//입고원장/출고원장
	private String poGubun;
	private String customerNm;
	private String inMatrEtc1;
	private String inMatrEtc2;
	private String inMatrEtc3;
	private String inBuying;
	private String inBuying2;
	
	//매입통계
	private String calSum;	//가용재고
	private String stock;	//현재고
	private String m1;	 	//1월
	private String m2;	 	//2월
	private String m3;	 	//3월
	private String m4;	 	//4월
	private String m5;	 	//5월
	private String m6;	 	//6월
	private String m7;	 	//7월
	private String m8;	 	//8월
	private String m9;	 	//9월
	private String m10;	 	//10월
	private String m11;	 	//11월
	private String m12;	 	//12월
	private String date;	//기준일자

	
}
