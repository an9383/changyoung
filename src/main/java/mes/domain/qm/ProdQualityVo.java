package mes.domain.qm;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
@Alias("ProdQualityVo")
public class ProdQualityVo{
	
	//식별자
	private String idx;						//식별자	
	private String prcssIdx;
	private String itemIdx;					//제품식별자
	private String dealCorpidx;				//고객사 식별자
	private String workOrdResultIdx;		//공정별 생산실적 식별자
	private String bizOrdDtlIdx;			//수주상세 식별자
	private String itemVersionIdx;			//제품버전식별자
	
	private String rowGubun;
	private String testGubun;
	private String bundleJson;
	
	//품질검사
	private String qualityJudgmentCd;		//품질 판정여부 코드
	private String confirmCd;				//승인 여부 코드
	private String judgmentUserIdx;			//판정자
	private String judUserName;
	private String judgmentDate;			//판정일자
	private String confirmUserIdx;			//승인자
	private String conUserName; 
	private String confirmDate;				//승인일자
	private String passQty;
	private String judgmentUserNm;
	private String confirmUserNm;
	private String qualityDesc;
	private String quailtyPassQty;
	private String outQty;
	private String qualityJudgmentNm;

	//제품
	private String itemVersion;
	private String itemSize;
	private String cutQty;
	private String eaQty;
	private String bundleUnit;
	private String bundleMethodNm;
	private String packMethodNm;
	private String itemColor;
	private String coatingMethod;
	private String moldingMethod;
	private String paperType;
	private String sizeX;
	private String sizeY;
	private String customerItemCd;
	private String etc1Nm;
	
	//수주
	private String bizStatusCd;
	private String bizStatusCdNm;
	private String bizOrdDtlNo;		
	private String dealCorpNm;
	private String bizOrdDealCorpNm;
	private String bizOrdDealCorpInitial;
	private String itemNm;
	private String itemVersionNm;
	private String bizOrdQty;
	private String stockUseQty;
	private String stockReUseQty;
	private String bizOutReqDate;
	private String bundleCount;
	
	//생산
	private String ordEndDate;
	private String outReqDate;
	private String workEndReqDate;
	private String workOrdQty;
	private String addCutting;
	private String workOrdDate;
	private String fairQty;
	private String workFairQty;
	private String workFaultyQty;
	private String workDate;
	private String prcssNm;
	private String workTotalQty;
	private String workUserNm;
	private String workQtyCheck;
	
	//공통
	private String printYn;
	private String workOrdResultIdxString; 
	private String bizOrdDtlIdxString; 
	private String updateList;
	private String insertConfimList;
	private String searchTarget;
	private String searchTargetConfirm;
	private String saveType;
	private String pageGubun;
	private String insertList;
	private String deleteList;
	private String startDate;
	private String endDate;
	private String regIdx;
	private String regUserNm; //등록자명
	private String regDate;
	private String updIdx;
	private String updDate;
	private String resultYn;
	private String resultCd;
	private String resultQty;
	private String etc7;
	private String statementStandard;
	private String workMethodJson;
	private String outDate;
}
 