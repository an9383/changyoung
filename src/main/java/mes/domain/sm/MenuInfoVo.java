package mes.domain.sm;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
@Alias("MenuInfoVo")
public class MenuInfoVo{
	private String idx;
	private String menuInfoAdmIdx;
	private String menuId;
	private String menuNm;
	private String menuOrder;
	private String menuPath;
	private String useYn;
	private String etc1;
	private String etc2;
	private String etc3;
	private String regIdx;
	private String regDate;
	private String updIdx;
	private String updDate;
	
	private String menuNmAdm;
}
