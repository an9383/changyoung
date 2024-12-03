package mes.domain.sm;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
@Alias("MenuAuthVo")
public class MenuAuthVo{
	private String idx;
	private String userIdx;
	private String menuIdx;
	private String favoriteYn;
	private String createAuth;
	private String readAuth;
	private String updateAuth;
	private String deleteAuth;
	private String etc1;
	private String etc2;
	private String etc3;
	private String regIdx;
	private String regDate;
	private String updIdx;
	private String updDate;
	
	private String insertList;
	private String menuNm;
	private String menuNmDtl;
	private String menuId;
	private String menuIdDtl;
	private String menuOrder;
	private String menuOrderDtl;
	private String menuPath;
	
	private String copyIdx;
	private String pasteIdx;
}
