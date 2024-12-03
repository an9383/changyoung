package mes.domain.sm;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
@Alias("SystemAccessLogVo")
public class SystemAccessLogVo{
	private String idx;
	private String userIdx;
	private String userNm;
	private String userId;
	private String userPositionNm;
	private String userDepartmentNm;
	private String accessMenuNm;
	private String accessUrl;
	private String accessIp;
	private String accessDate;
	
	private String startDate;
	private String endDate;
}
