package mes.domain.stock;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
@Alias("ItemDisposalAdmVo")
public class ItemDisposalAdmVo {
	private String idx;
	private String itemIdx;
	private String mangerIdx;
	private String mangerNm;
	private String produceMangerIdx;
	private String produceMangerNm;
	private String itemNm;
	private String itemSize;
	private String itemVersion;
	private String itemVerIdx;
	private String customerItemCd;
	private String customerNm;
	private String disposalCd;
	private String disposalNm;
	private String disposalQty;
	private String disposalReason;
	private String fileUuid;
	private String fileNm;
	private String fileExt;
	private String disposalDate;
	private String disposalDesc;
	private String workYn;
	private String finalCheckYn;
	private String updateJson;
	private String spQty;
	private String regIdx;
	private String regDate;
	private String updIdx;
	private String updDate;
	private String paperType;
	private String itemColor;
	private String coatingMethod;
	private String moldingMethod;
	private String lastProdDate;
	
	private String startDate;
	private String endDate;
	private String resIdx;
	private String resultYn;
	private String resMessage;
}
