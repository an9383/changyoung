package mes.domain.bm;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
@Alias("DealCorpAdmVo")
public class DealCorpAdmVo{
	
	//거래처정보 ADM
	private String idx;					//식별자
	private String workPlaceIdx;		//사업장 식별자
	private String workPlaceNm;			//사업장명
	private String dealGubun;			//거래구분
	private String dealGubunNm;			//거래구분명
	private String dealCorpCd;			//거래처코드
	private String dealCorpNm;			//거래처명
	private String representative;		//대표자
	private String companyNumber;		//사업자번호
	private String masterItem;			//대표품목
	private String initial;				//이니셜
	private String postNumber;			//우편번호
	private String addressAdm;			//주소
	private String addressDtl;			//상세주소
	private String outDealCorpIdx;		//납품처식별자
	private String outDealCorpNm;		//납품처 거래처명
	private String dealCorpAddress;		//납품처 주소
	private String importantLevel;		//중요도
	private String companyGubun;		//회사구분
	private String phoneNumber;			//전화번호
	private String faxNumber;			//팩스번호
	private String salesManager;		//영업담당
	private String salesManagerNm;		//영업담당이름
	private String paymentInfo;			//결제정보
	private String dealCorpStatus;		//거래 상태
	private String statementStandard;	//명세서수량기준
	private String dealCorpDesc;		//비고
	private String regIdx;				//등록자
	private String regDate;				//등록일
	private String updIdx;				//수정자
	private String updDate;				//수정일
	private int insertIdx;			//등록 후 반환되는 idx값
	
	//거래처 정보 MANAGER
	private String admIdx;				//adm 식별자
	private String chargeDepartment;	//담당 부서
	private String chargeName;			//담당자명
	private String chargePhoneNumber;	//담당자 연락처
	private String chargeEmail;			//이메일
	
	//투입자재 발주처 조회 구분
	private String dealCorpSelectGubun;	//발주처 조회조건
	private String matrlIdx;			//자재식별자
	
	//거래처 정보 FILE
	private String uuid;				// UUID
	private String fileName;			//파일명
	private String fileExt;				//확장자
	private String uploadDate;			//업로드 일자
	private String uploadName;			//파일 등록자
	private String insertYn;			//등록 여부
	private String regName;				//등록자명
	
}
