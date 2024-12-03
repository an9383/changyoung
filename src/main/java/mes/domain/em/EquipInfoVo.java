package mes.domain.em;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
@Alias("EquipInfoVo")
public class EquipInfoVo{
	
	// 공통
	private String idx;
	private String prcssIdx;
	private String progressOrder;
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
	
	//공정
	private String prcssEquipSelectGubun;
	private String prcssCd;
	private String prcssNm;
	
	//담당자
	private String userIdx;
	private String userName;
	private String userId;
	private String userDepartmentNm;
	private String userJobNm;
	private String userPositionNm;
	private String userStateNm;
	private String userTeamNm;
	
	//관련자료
	private String equipIdx;		//설비 식별자
	private String uuid;			//UUID
	private String fileNm;			//파일이름
	private String ext;			//파일확장자
	private String fileContents; 	//내용
	private String fileString;		//파일 등록시 json
	
	//공통
	private String updateList;
	private String insertJson;
	
}
