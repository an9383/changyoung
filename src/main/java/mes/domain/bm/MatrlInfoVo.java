package mes.domain.bm;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
@Alias("MatrlInfoVo")
public class MatrlInfoVo{
	
	private String idx; 				//식별자
	private String matrlIdx;			//식별자
	private String dealCorpIdx;
	private String itemGubun; 			//품목구분
	private String itemGubunNm; 		//품목구분이름
	private String matrlCd; 			//자재코드
	private String matrlNm; 			//자재명
	private String flute; 				//골
	private String fluteType; 			//골형
	private String wallType; 			//단종
	private String lawGubun; 			//종횡구분
	private String lawGubunNm; 			//종횡구분
	private String paperType; 			//지종
	private String paperTypeNm;			//지종
	private String amountAvg; 			//평량
	private String matrlSize;			//사이즈
	private String matrlSizeNm;			//사이즈-공통코드명
	private String sizeX; 				//사이즈가로
	private String sizeY; 				//사이즈세로
	private String extraStock; 			//적정재고
	private String matrlNote; 			//참고사항
	private String useYn; 				//사용여부
	private String cutSize;
	private String etc1;
	private String etc2;
	private String etc2Nm;
	private String etc3;
	private String etc4;
	private String etc5;
	private String etc6;
	private String etc7;
	private String etc8;
	private String asQty;				//가용재고
	
	//발주처
	private String dealCorpNm; 			//발주처명
	private String mainDealCorp;		//주발주처
	
	private String pageGubun; 			//페이지구분(원단, 마니라 등등...);
	private String insertJson;
	
	private String updateList;
	private String progressOrder;		
	private String regIdx;				//등록자
	private String regDate;				//등록일시
	private String updIdx;				//수정자
	private String updDate;				//수정일시
	
	private String purchaseOrdQty;		//수주수량
	private String startDate;
	private String endDate;
	private String baseDate;
	private String matrlSelectGubun;
	private String itemIdx;
	
	private String cutQty;
	private String eaQty;
	private String extraQty;
	
	private String spQty;
	private String resIdx;
	private String resYn;
	private String resMes;
}
