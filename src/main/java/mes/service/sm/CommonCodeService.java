package mes.service.sm;

import java.util.List;

import mes.domain.sm.CommonCodeVo;

public interface CommonCodeService {
	
	// ====================================== 공통코드관리 ADM ========================================
	// 공통코드관리 ADM 목록조회
	public List<CommonCodeVo> commonCodeAdmLst(CommonCodeVo commonCodeVo) throws Exception;
	
	// 공통코드관리 ADM 상세조회
	public CommonCodeVo commonCodeAdmSel(CommonCodeVo commonCodeVo) throws Exception;
	
	// 공통코드관리 ADM 등록
	public void commonCodeAdmIns(CommonCodeVo commonCodeVo) throws Exception;
	
	// 공통코드관리 ADM 수정
	public void commonCodeAdmUpd(CommonCodeVo commonCodeVo) throws Exception;
	
	// 공통코드관리 ADM 삭제
	public void commonCodeAdmDel(CommonCodeVo commonCodeVo) throws Exception;
	
	// 공통코드관리 ADM 코드 중복확인
	public CommonCodeVo commonCodeAdmDupCheck(CommonCodeVo commonCodeVo) throws Exception;
	
	
	// ====================================== 공통코드관리 DTL ========================================
	// 공통코드관리 DTL 목록조회
	public List<CommonCodeVo> commonCodeDtlLst(CommonCodeVo commonCodeVo) throws Exception;
	
	// 공통코드관리 DTL 공통코드별 목록조회
	public List<CommonCodeVo> commonCodeDtlLstByCommonCd(CommonCodeVo commonCodeVo) throws Exception;
	
	// 공통코드관리 DTL 공통코드별 목록조회
	public List<CommonCodeVo> commonCodeDtlLstByCommonCdString(CommonCodeVo commonCodeVo) throws Exception;
	
	// 공통코드관리 DTL 상세조회
	public CommonCodeVo commonCodeDtlSel(CommonCodeVo commonCodeVo) throws Exception;
	
	// 공통코드관리 DTL 등록
	public void commonCodeDtlIns(CommonCodeVo commonCodeVo) throws Exception;
	
	// 공통코드관리 DTL 수정
	public void commonCodeDtlUpd(CommonCodeVo commonCodeVo) throws Exception;
	
	// 공통코드관리 DTL 삭제
	public void commonCodeDtlDel(CommonCodeVo commonCodeVo) throws Exception;
	
	// 공통코드관리 DTL 코드 중복확인
	public CommonCodeVo commonCodeDtlDupCheck(CommonCodeVo commonCodeVo) throws Exception;
}
