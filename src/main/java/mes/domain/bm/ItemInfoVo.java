package mes.domain.bm;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
@Alias("ItemInfoVo")
public class ItemInfoVo{
	
	private String idx;
	private String customerItemCd;
	private String customerNm;
	private String itemNm;
	private String itemVersion;
	private String useYnCd;
	private String uuid;
	private String ext;
	private String fileNm;
}
