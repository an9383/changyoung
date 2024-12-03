package mes.domain.bm;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
@Alias("ItemPrcssRoutingVo")
public class ItemPrcssRoutingVo {
	
	private String idx;
	private String routingNo;
	private String prcssOrder;
	private String prcssInfoIdx;
	private String prcssCd;
	private String prcssNm;
	private String qtyUnit;
	private String qtyUnitNm;
	private String prcssOrderFlow;
	private String etc1;
	private String etc2;
	private String etc3;
	private String routingDesc;
	private String regIdx;
	private String regDate;
	private String updIdx;
	private String updDate;
	private String insertList;
	private String setView;
	private String delGubun;
	private String equipIdx;	//설비정보
	private String equipNm;		//설비명
	
	private String resultYn;
	private String resultMessage;
}
