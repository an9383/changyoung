package mes.domain.stock;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
@Alias("AvailableStockAdmVo")
public class AvailableStockAdmVo {
	private String asIdx;
	private String endDate;
	private String asGubun;
	private String asQty;
	private String asTime;
	private String regIdx;
	private String regDate;
	
	//가용재고 계산
	private String idx;
	private String bizOrdDtlNo;
	private String stockQty;
	private String inQty;
	private String confirmYn;
	private String ordDate;
	
	private String jsonArray;
	private String startDate;
}
