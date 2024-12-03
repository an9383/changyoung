package mes.domain.sm;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
@Alias("CommonCodeVo")
public class CommonCodeVo{
	private String idx;
	private String commonType;
	private String commonCodeAdmIdx;
	private String commonCd;
	private String commonNm;
	private String useYn;
	private String attr;
	private String commonDesc;
	private String etc1;
	private String etc2;
	private String etc3;
	private String regIdx;
	private String regDate;
	private String updIdx;
	private String updDate;
}
