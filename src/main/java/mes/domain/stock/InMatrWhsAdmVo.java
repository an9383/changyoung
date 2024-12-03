package mes.domain.stock;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
@Alias("InMatrWhsAdmVo")
public class InMatrWhsAdmVo {
	private String inSlipNo;
	private String inSlipSeq;
	private String itemGubun;
	private String inGubun;
	private String matrlIdx;
	private String preInQty;
	private String inQty;
	private String remainQty;
	private String preInDate;
	private String inDate;
	private String inCorpIdx;
	private String inStatus;
	private String lotNo;
	private String barcodeNo;
	private String relationNo;
	private String whsGubun;
	private String whsIdx;
	private String locIdx;
	private String inDesc;
	private String inMatrEtc1;
	private String inMatrEtc2;
	private String inMatrEtc3;
	private String regIdx;
	private String regDate;
	private String updIdx;
	private String updDate;
	
	private String startDate;
	private String endDate;
	
	private String dealCorpNm;
	private String matrlCd;
	private String matrlNm;
	private String paperType;
	private String paperTypeNm;
	private String cutSize;
	private String cutQty;
	private String eaQty;
	private String purchaseOrdNo;
	private String purchaseOrdDate;
	private String purchaseInDueDate;
	private String purchaseNote;
	private String lcNm;
	private String sizeX;
	private String sizeY;
	
	private String spSourceNo;
	
	private String inMatrEtc1Nm;
	private String inMatrEtc2Nm;
	private String inMatrEtc3Nm;
	private String purchasePrintNo;
	
	private String insertJson;
	private String updateJson;
}
