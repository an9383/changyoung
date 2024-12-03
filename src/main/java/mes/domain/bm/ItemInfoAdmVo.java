package mes.domain.bm;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
@Alias("ItemInfoAdmVo")
public class ItemInfoAdmVo{
	
	private String idx; 				//식별자
	private String itemIdx; 			//품목 식별자
	private String itemAdmIdx; 			//품목 식별자
	private String itemDtlIdx; 			//품목 식별자
	private String matrlIdx;
	private String equipIdx;
	private String customerIdx;			//고객사 식별자
	private String itemGubunCd;			//품목구분
	private String itemGubunNm;			//품목구분 이름
	private String useYnCd;				//사용여부
	private String customerCd;			//고객사 코드
	private String customerNm;			//고객사 이름
	private String itemCd;
	private String itemNm;
	private String itemSize;
	private String knifeTipSize;
	private String woodenCareCd;
	private String woodenCareNm;
	private String holeWoodenCd;
	private String versionNum;
	private String stock;
	private String versionStock;
	private String itemColor;
	private String frequency;
	private String frequencyNm;
	private String customerItemCd;
	private String specialNotice;
	private String relayNotice;
	private String coatingMethod;
	private String moldingMethod;
	private String moldingContents;
	private String pressMethod;
	private String bundleMethod;
	private String bundleMethodNm;
	private String bundleUnit;
	private String packMethod;
	private String packMethodNm;
	private String packUnit;
	private String workPrinter;
	private String detailDate;
	private String masterPaper;
	private String roundPlateCnt;
	private String careCd;
	private String plane;
	private String inspectMethod;
	private String inspectMethodNm;
	private String printingYnCheck;
	private String printingYnCheckNm;
	private String plateSize;
	private String etc1;
	private String etc1Nm;
	private String etc2;
	private String etc2Cd;
	private String etc3;
	private String etc4;
	private String etc5;
	private String etc6;
	private String etc7;
	private String etc8;
	private String etc8Nm;
	private String etc9;
	private String etc10;
	private String itemGubun;
	private String cmyk;
	private String versionFileString; //json형태로 변경
	private String versionCheck;
	private String cutSize;
	private String lastProdDate;
	private String lastWorkDate;
	
	private String cutQty;
	private String eaQty;
	private String dealCorpIdx;
	private String bomDesc;
	private String matrlCd;
	private String matrlNm;
	private String paperType;
	private String paperTypeNm;
	private String matrlSize;
	private String matrlSizeNm;
	private String sizeX;
	private String sizeY;
	private String dealCorpNm;
	private String matrlNote;
	
	private String insertList;
	private String insertIdx;
	private String itemVerIdx;
	private String itemVersion;
	private String fileString; //json형태로 변경
	private String uuid;
	private String fileNm;
	private String ext;
	private String fileSplitNm;
	private String download;
	
	private String prcssIdx;
	private String prcssCnt;
	private String prcssCd;
	private String prcssNm;
	private String outsrcGubun;
	private String workMethod;
	private String workMethodDtl;
	private String outsrcIdx;
	private String outsrcCd;
	private String outsrcNm;
	private String note;
	private String qtyUnit;
	private String qtyUnitNm;
	private String prcssDesc;
	private String lawGubun;
	private String lawGubunNm;
	private String amountAvg;
	private String extraQty;
	
	private String equipNm;
	
	private String selectType;
	private String resinBoard; //수지판
	private String resinBoardNm;
	private String bizOrdDtlIdx;
	private String infoType; //기준정보의 공정정보일경우 -> itemInfo , 수주에서 등록한 공정정보일 경우 -> bizInfo값을 가짐
	private String purchaseOrdYn;
	
	//작업지시
	private String workOrdPrcssIdx;
	private String progressStatus; //작지 공정 상태
	private String workOrdQty;
	private String produceQtyUnit;
	private String produceQtyUnitNm;
	private String productionOutWorkQty;
	private String productionOutDisQty;
	private String workOrdCnt;
	//번들링
	private String inputQty;		//투입수량
	private String bizOrdDtlNo;		//수주상세번호
	private String bundleDesc;		//비고
	
	private String spQty;
	private String itemMatrlGubun;
	private String workMethodJson;
	private String itemIdxJson;
	private String pageGubun; 			//페이지구분 production : 제품 , material : 자재
	private String progressOrder;
	private String prcssOrder;
	private String regIdx;
	private String regDate;
	private String updIdx;
	private String updDate;
	private String versionJson;
	
	private String resultYn;
	private String resMessage;
	
	//품목정보관리 제품수행이력
	private String ordDate;
	private String bizOrdNo;
	private String ordQty;
	private String outDate;
	private String outQty;
	private String passQty;
	private String ordIssue;

}
