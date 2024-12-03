package mes.domain.bm;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
@Alias("SpotToningVo")
public class SpotToningVo{
	
	// 공통
	private String idx;
	private String progressOrder;
	private String useYn;
	private String updateList;
	private String regNm;
	private String regIdx;
	private String regDate;
	private String updIdx;
	private String updDate;
	
	//별색조색관리
	private String colorCode;		//색상코드
	private String colorGubun;		//색상구분
	private String colorGubunNm;	//색상구분명
	private String colorNumber;		//색상번호
	private String toningValue;		//조색값
	private String spotNote;		//참고사항
	private String spotDesc;		//비고
	
}
