package mes.domain.wm;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
@Alias("WorkOrderVo")
public class WorkOrderVo{
	
	//식별자
	private String idx;
	private String boaIdx; 				//수주 ADM 테이블 식별자
	private String bodIdx; 				//수주 DTL 테이블 식별자
	private String itemIdx; 			//제품식별자
	private String dealCorpIdx; 		//수주처(고객사) 식별자
	private String workOrdIdx;  		//작업지시 식별자
	private String workOrdPrcssIdx; 	//작업지시의 공정내역 식별자
	private String prcssIdx;			//공정 식별자
	private String prcssWorkerIdx;		//공정 작업자 식별자
	private String bizOrdDtlIdx;		//수주 테이블 식별자
	private String bundleBizOrdDtlIdx;	//번들링되어진 해당수주dtl의 식별자
	private String equipIdx;			//설비 식별자
	private String workOrdResultIdx;	//생산실적 식별자
	private String resultIdx;			//프로시저에서 반환된 식별자값
	private String locationIdx;			//창고식별자
	private String bizOrdDtlIdxString;
	private String woprIdx;
	private String bundleResultIdx;
	
	//수주
	private String bizDealCorpNm;
	private String ordGubun;			//수주구분
	private String bizStopYn;			//수주중지여부
	private String bizStatusCd;			//수주상태
	private String bizOrdNo;			//수주번호
	private String bizOrdDtlNo; 		//수주상세번호
	private String dealCorpNm;  		//수주처 명
	private String itemNm;				//제품명
	private String printingYnCheck;		//착인여부
	private String customerItemCd; 		//고객사 자재코드
	private String itemVersionIdx;		//제품버전식별자
	private String itemVersion;			//제품버전
	private String ordQty;				//수주수량, 작지에선 지시량
	private String workQty; 			//지시수량
	private String ordNote;				//수주특이사항
	private String ordIssue;			//수주전달사항
	private String ordDesc;				//수주비고사항+
	private String woodenWdCd;			//목형관리번호 코드
	private String resinBoardWdCd;		//수지판 코드
	private String bizOrdQty;			//수주수량
	private String bizOrdIssue; 		//수주특이사항
	private String bizOrdNote; 			//수주전달사항
	private String bizOrdGubun;			//수주구분
	private String bizOrdGubunNm;		//수주구분명
	private String outReqDate;			//수주 출고요청일
	private String workEndReqDate;		//생산완료요구일
	private String bizOrdWorkEndReqDate;//수주 목표요구일(생산완료요구일)
	private String confirmDesign;		//디자인컨펌
	private String purchaseBatch;
	private String stockUseQty;
	private String woodenCareCd;
	
	//발주
	private String purchaseOrdNo;
	
	//작업지시
	private String workOrdPrintYn;
	private String workOrdNo;			//작업지시번호
	private String ordStatus; 			//지시상태
	private String ordDate;				//지시일
	private String ordEndDate;			//완료요청일
	private String printYn; 			//출력여부
	private String workOrdQty;			//지시수량
	private String workOrdDesc;			//작지 지시비고
	private String workDate;			//작업일자
	private String workStartTime; 		//작지 시작시간
	private String workEndTime;			//작지 종료시간
	private String workTime;
	private String fairQty;				//작지 작업량(양품수량)
	private String faultyQty;			//작지 불량수량	
	private String workAddCuttingQty;	//작지 추가재단량
	private String faultyReason;		//작지 불량사유
	private String prcssDesc;			//현장비고(공정비고)
	private String beforeFairQty; 		//전 공정 실적
	private String beforeFaultyQty;
	private String afterFairQty;
	private String afterFaultyQty;
	private String disposalQty;
	private String beforePrcssDesc;		//전 공정 비고
	private String allWorkOrdQty;		//전체 작업지시수량(작지의 수량)
	private String beforeQtyUnitNm;
	private String calOrdQty;
	private String matrlInfoJson;		//자재JSON
	private String comCodeJson;		//공통코드JSON
	private String workQtyCheck;
	private String bizPrcssJson;	//수주공정JSON
	
	//생산 공정
	private String prcssGroupCd;		//공정그룹
	private String prcssOrder;  		//공정순서
	private String firstPrcssYn;		//첫공정여부
	private String woodenUseYn;			//목형사용여부
	private String crUseYn;				//CR코팅판 사용여부
	private String uvUseYn; 			//UV코팅판 사용여부
	private String cutYn;				//추가재단여부
	private String progressStatus;  	//진행상태
	private String outsrcGubun; 		//외주구분
	private String prcssCd;				//공정코드
	private String prcssNm;				//공정명
	private String workMethodJson;		//작업방법 JSON
	private String workOrdPrcssJson;
	private String workMethod;			//작업방법
	private String qtyUnitNm;			//수량단위명
	private String addCutting;			//추가재단
	private String prcssNextIdx;		//다음공정식별자
	private String produceQtyUnitNm;	//생산지시단위
	private String prevPrcssFairQty; 	//전공정 생산(양품)수량
	private String resultPageNm;		//실적화면명
	private String inputQtyJson;		//투입수량JSON
	private String descCheckYn;			//전공정 특이사항 유무체크
	private String groundPrintYn;		//접지라벨 출력유무
	private String ctcpPrintYn;			//CTCP라벨 출력유무
	private String equipNm;				//설비명
	private String beforePrcssCnt;		//전공정 중 완료 안된 항목갯수
	
	//자재
	private String paperType;
	private String matrlCd;			//자재코드
	private String matrlNm;			//자재명
	private String sizeX;			//가로
	private String sizeY;			//세로
	private String cutQty;			//절수
	private String eaQty;			//개수
	private String extraQty;		//여유분
	private String extraPackQty;		//여유분
	private String purchaseOrdQty;  //주문수량(발주수량)
	private String inQty; 			//입고량
	
	//파일
	private String ext;				//ext
	private String uuid;			//uuid
	private String fileNm;			//fileNm
	
	//제품
	private String resinBoardNm;
	private String woodenCareNm;
	private String etc1Nm;
	private String itemColor;		//색상
	private String knifeTipSize; 	//칼끝규격
	private String itemSize;		//사이즈
	private String frequency;		//도수
	private String coatingMethod;	//코팅방법
	private String holeWoodenCd;	//타공목형번호
	private String etc2Cd;			//후가공판번호
	private String etc3;
	private String etc4;
	private String etc5;
	private String etc6;
	private String etc7;
	private String etc8;
	private String etc9;
	private String moldingMethod;
	private String moldingContents;
	private String pressMethod;
	private String bundleMethodNm;
	private String bundleUnit;
	private String packUnit;
	private String packMethodNm;
	private String relayNotice;
	private String specialNotice;
	private String inspectMethodNm;

	//출고
	private String outDate;
	private String outQty;
	
	//품질
	private String qualityIdx;			//품질 식별자
	private String qualityJudgmentCd;	//품질 판정 여부 코드
	private String confirmCd; 			//승인 여부 코드
	private String passQty;
	
	private String productionOutWorkQty;
	private String productionOutDisQty;
	
	//수불
	private String stockGubun;
	private String spNo;
	private String spSeq;
	private String spGubun;
	private String spIdx;
	private String spType;
	private String spType2;
	private String spDate;
	private String spQty;
	private String spLotNo;
	private String spSourceNo;
	private String spWhsGubun;
	private String spWhsIdx;
	private String spLocIdx;
	private String spDesc;
	private String spEtc1;
	private String spEtc2;
	private String spEtc3;
	//제품입고,출고 테이블
	private String inOutSlipNo;
	private String inOutSlipSeq;
	private String itemGubun;
	private String inOutGubun;
	private String itemCd;
	private String versionIdx;
	private String preInOutQty;
	private String inOutQty;
	private String remainQty;
	private String preInOutDate;
	private String inOutDate;
	private String inOutCorpCd;
	private String inOutStatus;
	private String lotNo;
	private String relationNo;
	private String whsGubun;
	private String whsIdx;
	private String locIdx;
	private String inUserIdx;      
	private String inDesc; 
	private String outDesc;
	private String outProdEtc1;
	private String outProdEtc2;
	private String outProdEtc3;
	private String outProdEtc4;
	private String outProdEtc5;
	private String carAssignment;
	
	//공통
	private String selectList;
	private String stockOption;
	private String stockQty;
	private String inputQty;
	private String searchTarget;
	private String saveType;
	private String pageGubun;
	private String insertList;
	private String updAndInsList;
	private String iuGubun;
	private String startDate;
	private String endDate;
	private String regIdx;
	private String regUserNm; //등록자명
	private String regDate;
	private String updIdx;
	private String updDate;
	private String resultYn;
	private String resultCnt;
	private String loginUserIdx;
	private String versionNum;
	private String frequencyNm;
	private String todayWorkYn;
	private String nextExtraQty;	//공정실적등록_여분컬럼
	
}
