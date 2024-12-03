package mes.domain.wm;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
@Alias("WorkPlanVo")
public class WorkPlanVo{
	
	//식별자
	private String idx;
	private String boaIdx; 				//수주 ADM 테이블 식별자
	private String bodIdx; 				//수주 DTL 테이블 식별자
	private String itemIdx; 			//제품식별자
	private String dealCorpIdx; 		//수주처(고객사) 식별자
	private String workOrdIdx;  		//작업지시 식별자
	private String prcssIdx;			//공정 식별자
	
	//수주
	private String bizStatusCd;			//수주상태
	private String bizOrdNo;			//수주번호
	private String bizOrdDtlNo; 		//수주상세번호
	private String dealCorpNm;  		//수주처 명
	private String itemNm;				//제품명
	private String customerItemCd; 		//고객사 자재코드
	private String itemVersion;			//제품버전
	private String ordQty;				//수주수량, 작지에선 지시량
	private String stockUseQty;
	private String workQty; 			//지시수량
	private String ordNote;				//수주특이사항
	private String ordIssue;			//수주전달사항
	private String ordDesc;				//수주비고사항
	private String woodenWdCd;			//목형관리번호 코드
	private String resinBoardWdCd;		//수지판 코드
	private String workEndDate;
	private String outReqDate;
	private String confirmDesign;
	
	//작업지시
	private String ordStatus; 			//지시상태
	private String ordDate;				//지시일
	private String ordEndDate;			//완료요청일
	private String printYn; 			//출력여부
	private String fairQty;				//생산수량 ( 양품수량 )
	
	//생산 공정
	private String prcssOrder;  		//공정순서
	private String progressStatus;  	//진행상태
	private String outsrcGubun; 		//외주구분
	private String prcssNm;				//공정명
	private String workMethodJson;		//작업방법 JSON
	private String workMethod;			//작업방법
	private String produceQtyUnit;
	private String produceQtyUnitNm;
	private String descCheckYn;
	private String groundPrintYn;
	private String ctcpPrintYn;

	//발주
	private String purchaseChkYn;		//해당 수주의 모든발주 확정여부
	
	//자재
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
	private String addCutting;		//추가재단
	private String paperType;
	
	//금일작업지시
	private String workOrdPrcssIdx; //작업지시IDX
	private String dwCharger;		//귀속작업자
	private String dwDate;			//작업일
	private String dwStatus;		//상태 (O,X)
	
	//공통
	private String searchTarget;
	private String insertList;
	private String updateJson;
	private String startDate;
	private String endDate;
	private String regIdx;
	private String regDate;
	private String updIdx;
	private String updDate;
	private String resultYn; 	//삭제 성공 반환값
	private String resMessage;
	private String todayWorkYn;
}
