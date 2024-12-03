package mes.domain.bm;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
@Alias("LocationVo")
public class LocationVo{
	
	// 공통
	private String idx;
	private String useYn;
	private String regIdx;
	private String regDate;
	private String updIdx;
	private String updDate;
	
	// ADM
	private String lcCd;
	private String lcNm;
	private String lcTypeOutput;
	private String lcTypeInput;
	private String lcTypeReturn;
	private String lcTypeQc;
	private String lcTypeOutsourcing;
	private String lcOutsourcing;
	private String lcOutsourcingNm;
	private String lcQualityGubun;
	private String lcQualityGubunNm;
	private String itemGubun;
	private String itemGubunNm;
	private String lcEndDate;
	private String lcNote;
	
	//DTL
	private String lcAdmIdx;
	private String lcDtlNm;
	private String lcDtlX;
	private String lcDtlY;
	private String lcDtlZ;
	private String lcDtlDesc;
	
}
