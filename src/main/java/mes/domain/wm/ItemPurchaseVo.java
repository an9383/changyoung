package mes.domain.wm;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
@Alias("ItemPurchaseVo")
public class ItemPurchaseVo{
	
	private String idx;
	private String itemIdx;
	private String itemNm;
	private String itemCdAndNm;
	private String purchaseCorpIdx;
	private String purchaseCorpNm;
	private String purchaseOrdNo;
	private String purchaseDate;
	private String purchaseQty;
	private String bizOrdDtlNo;
	private String purchaseUserIdx;
	private String purchaseUserNm;
	private String purchaseDesc;
	private String purchaseGubun;
	private String regIdx;
	private String regDate;
	private String updIdx;
	private String updDate;
	
	private String inSlipNo;
	private String inSlipSeq;
	private String relationNo;
	private String inQty;
	private String inDate;
	private String inUserIdx;
	private String inUserName;
	private String inDesc;
	
	private String sumPurchaseQty;
	private String sumInQty;
	private String startDate;
	private String endDate;
	private String rowGubun;
	private String searchTarget;
	private String insertJson;
	private String updateJson;
	private String deleteJson;
	private String returnPurchaseOrdNo;
}
