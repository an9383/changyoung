package mes.domain.stock;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
@Alias("OutMatrWhsAdmVo")
public class OutMatrWhsAdmVo {
	private String outSlipNo;
	private String outSlipSeq;
	private String itemGubun;
	private String outGubun;
	private String itemCd;
	private String preOutQty;
	private String outQty;
	private String remainQty;
	private String preOutDate;
	private String outDate;
	private String outCorpCd;
	private String outStatus;
	private String lotNo;
	private String relationNo;
	private String whsGubun;
	private String whsIdx;
	private String locIdx;
	private String outDesc;
	private String regId;
	private String regIdx;
	private String regDate;
	private String updId;
	private String updDate;
	
	private String insertJson;
}
