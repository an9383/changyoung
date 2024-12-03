package mes.domain.bm;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
@Alias("PrcssInfoVo")
public class PrcssInfoVo{
	
	private String idx; 				//식별자
	private String prcssIdx; 			//공정식별자
	private String userIdx;				//사용자식별자
	private String prcssCd; 			//공정코드
	private String prcssNm; 			//공정명
	private String qtyUnit; 			//수량단위
	private String produceQtyUnit;		//생산지시단위
	private String qtyUnitNm;
	private String produceQtyUnitNm;
	private String cutYn;				//추가재단여부
	private String initial; 			//이니셜
	private String prcssDesc; 			//비고
	private String stockOption;			//수불 옵션
	private String prcssGroupCd;		//공정그룹코드
	private String firstPrcssYn;		//첫공정여부
	private String woodenUseYn;			//목형사용여부
	private String crUseYn;				//CR코팅판사용여부
	private String uvUseYn;				//UV코팅판사용여부
	private String resultPageNm;		//실적화면명
	
	//사용자정보
	private String userName;			//이름
	private String userId;				//ID
	private String userDepartmentNm; 	//부서 
	private String userJobNm; 			//담당업무
	private String userPositionNm;		//직위
	private String userStateNm;			//근무상태
	private String userTeamNm; 			//소속팀
	
	//설비
	private String equipIdx;			//설비식별자
	private String equipCd;				//설비코드
	private String equipNm;				//설비명
	
	//작업방식
	private String workYn;				//사용여부
	private String workCd;				//작업방식코드
	private String workNm;				//작업방식명
	private String workMethodJson;		//작업방식 JSON
	
	//검사항목
	private String inspectionList;	 	//점검항목
	
	
	//공통
	private String insertJson; 			//저장쿼리 만들어주기	
	private String updateList;
	private String progressOrder;		
	private String prcssOrder;
	private String regIdx;				//등록자
	private String regDate;				//등록일시
	private String updIdx;				//수정자
	private String updDate;				//수정일시
	private String resultYn;
	private String resultMessage;	
	
}
