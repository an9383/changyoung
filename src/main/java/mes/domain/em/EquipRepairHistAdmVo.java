package mes.domain.em;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
@Alias("EquipRepairHistAdmVo")
public class EquipRepairHistAdmVo{

	//수리 이력
	private String idx;				//설비 수리 idx
	private String equipIdx;        //설비 idx
	private String repairCd;        //수리코드
	private String repairNm;        //수리 이름
	private String repairStartDate; //수리시작일
	private String repairEndDate;   //수리종료일
	private String repairContent;   //수리내용
	private String repairCompany;   //수리업체
	private String repairDesc;      //수리비고
	private String repairCost;      //수리비
	private String partCost;        //부품비
	private String laborCost;       //인건비
	private String beforeImageFile; //조치 전 이미지 파일
	private String afterImageFile;	//조치 후 이미지 파일
	private String useYn;
	private String regIdx;
	private String regDate;
	private String updIdx;
	private String updDate;

	//설비
	private String equipCd;			//설비코드
	private String equipNm;			//설비명
	private String serialNo;		//시리얼 번호
	private String makerNm;			//제조사
	private String buyDate;			//구입일자
	private String buyPrice;		//구입금액
	private String setupLocation;	//설치위치
	private String equipDesc;		//비고

	private String startDate;
	private String endDate;
	
	private String rowNumber;
}
