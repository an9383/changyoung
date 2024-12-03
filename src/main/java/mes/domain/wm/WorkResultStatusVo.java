package mes.domain.wm;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
@Alias("WorkResultStatusVo")
public class WorkResultStatusVo{
	
	private String workDate;//작업일자
	private String startDate;
	private String endDate;
}
