package mes.domain.sm;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
@Alias("WorkplaceVo")
public class WorkplaceVo{
	private String idx;						//식별자
	private String mainYn;					//주사업장여부
	private String useYnCd;					//사용여부
	private String workplaceGubun;			//사업자구분
	private String workplaceCd;				//사업장코드
	private String workplaceNm;				//사업장명칭
	private String workplaceAddress;		//사업장주소
	private String postNumber;				//우편번호
	private String phoneNumber;				//전화번호
	private String workplaceNumber;			//사업자번호
	private String ceoNm;					//대표자성명
	private String businessConditions;		//업태
	private String businessItem;			//종목
	private String faxNumber;				//fax번호
	private String workplaceDesc;			//비고
	private String emailAddress;			//이메일 주소
	private String etc1;					//기타1
	private String etc2;					//기타2
	private String etc3;					//기타3
	
	private String regIdx;
	private String regDate;
	private String updIdx;
	private String updDate;
	
}
