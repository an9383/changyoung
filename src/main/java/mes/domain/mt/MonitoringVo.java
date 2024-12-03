package mes.domain.mt;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
@Alias("MonitoringVo")
public class MonitoringVo {

	private String bizStopYn;				//수주중지
	private String bizOrdDtlIdx;			//수주상세 idx
	private String bizOrdDtlNo;				//수주번호
	private String confirmDesign;			//디자인컨펌
	private String bizOrdDealCorpNm;		//수주고객사명
	private String bizOrdDate;				//수주일
	private String bizOrdQty;				//수주수량
	private String bizStatusNm;				//수주상태명
	private String itemNm;					//제품명
	private String matrlCd;					//자재코드
	private String paperType;				//재질명
	private String itemVersionNm;			//아이템 버전
	private String outReqDate;				
	private String workEndReqDate;
	private String workOrdQty;
	private String workEndDate;
	private String workFairQty;
	private String upTime;
	private String productionPerHour;
	
	//리드타임
	private String workOrdDate;
	private String outDate;
	private String outQty;
	private String totalDay;
	
	//불량률현황
	private String ordDate;
	private String fairQtySum;
	private String faultyQtySum;
	
	//생산진행현황
	private String workPrcssStatusJson;
	private String workOrdNo;
	private String stockUseYn;
	private String workResultIdx;
	private String inQtyCheck;
	private String prcssStatus;
	private String ordGubun;
	private String workQtyCheck;
	private String etc9;
	private String frequencyNm; 
	
	private String startDate;
	private String endDate;
	private String searchTarget;
	
	
	private String workStartTime;
	private String workEndTime;
	private String userName;
	private String cutQty;
	private String eaQty;
	private String purchaseOrdQty;
	private String extraQty;
	private String produceQtyUnitNm;
	private String equipNm;
	private String prcssNm;
	private String calOrdQty;
	
}
