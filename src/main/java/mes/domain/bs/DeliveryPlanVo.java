package mes.domain.bs;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
@Alias("DeliveryPlanVo")
public class DeliveryPlanVo {
	private String idx;
	private String itemIdx;
	private String bizDealCorpidx;
	private String bizOrdDtlIdx;
	private String deliveryPlanDate;	//
	private String realOutDate;
	private String regUserIdx;
	private String regUserNm;
	private String deliveryPlanDesc;
	
	
	private String bizDealCorpNm; //수주처
	private String bizOrdDtlNo;	//수주상세번호
	private String itemNm;
	private String bizOrdQty;
	private String endReqDate;
	private String outReqDate;
	private String qualityPassQty;
	private String regIdx;
	private String regDate;
	private String updIdx;
	private String updDate; 
	
	private String insertJson;
	private String updateJson;
	private String deleteJson;
	private String workOrdPrcssJson;
	private String startDate;
	private String endDate;
	
}
