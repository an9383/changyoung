package mes.service.sm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.sm.CommonCodeVo;
import mes.persistence.sm.CommonCodeDAO;

@Service
public class CommonCodeServiceImpl implements CommonCodeService {

	@Inject
	private CommonCodeDAO dao;
	
	// ====================================== 공통코드관리 ADM ========================================
	// 공통코드관리 ADM 목록조회
	@Override
	public List<CommonCodeVo> commonCodeAdmLst(CommonCodeVo commonCodeVo) throws Exception {
		return dao.commonCodeAdmLst(commonCodeVo);
	}
	
	// 공통코드관리 ADM 상세조회
	@Override
	public CommonCodeVo commonCodeAdmSel(CommonCodeVo commonCodeVo) throws Exception {
		return dao.commonCodeAdmSel(commonCodeVo);
	}
	
	// 공통코드관리 ADM 등록
	@Override
	public void commonCodeAdmIns(CommonCodeVo commonCodeVo) throws Exception {
		dao.commonCodeAdmIns(commonCodeVo);
	}
	
	// 공통코드관리 ADM 수정
	@Override
	public void commonCodeAdmUpd(CommonCodeVo commonCodeVo) throws Exception {
		dao.commonCodeAdmUpd(commonCodeVo);
	}
	
	// 공통코드관리 ADM 삭제
	@Override
	public void commonCodeAdmDel(CommonCodeVo commonCodeVo) throws Exception {
		dao.commonCodeAdmDel(commonCodeVo);
	}
	
	// 공통코드관리 ADM 코드 중복확인
	@Override
	public CommonCodeVo commonCodeAdmDupCheck(CommonCodeVo commonCodeVo) throws Exception {
		return dao.commonCodeAdmDupCheck(commonCodeVo);
	}
	
	
	// ====================================== 공통코드관리 DTL ========================================
	// 공통코드관리 DTL 목록조회
	@Override
	public List<CommonCodeVo> commonCodeDtlLst(CommonCodeVo commonCodeVo) throws Exception {
		return dao.commonCodeDtlLst(commonCodeVo);
	}
	
	// 공통코드관리 DTL 공통코드별 목록조회
	@Override
	public List<CommonCodeVo> commonCodeDtlLstByCommonCd(CommonCodeVo commonCodeVo) throws Exception {
		return dao.commonCodeDtlLstByCommonCd(commonCodeVo);
	}
	
	// 공통코드관리 DTL 공통코드별 목록조회
	@Override
	public List<CommonCodeVo> commonCodeDtlLstByCommonCdString(CommonCodeVo commonCodeVo) throws Exception {
		return dao.commonCodeDtlLstByCommonCdString(commonCodeVo);
	}
	
	// 공통코드관리 DTL 상세조회
	@Override
	public CommonCodeVo commonCodeDtlSel(CommonCodeVo commonCodeVo) throws Exception {
		return dao.commonCodeDtlSel(commonCodeVo);
	}
	
	// 공통코드관리 DTL 등록
	@Override
	public void commonCodeDtlIns(CommonCodeVo commonCodeVo) throws Exception {
		dao.commonCodeDtlIns(commonCodeVo);
	}
	
	// 공통코드관리 DTL 수정
	@Override
	public void commonCodeDtlUpd(CommonCodeVo commonCodeVo) throws Exception {
		dao.commonCodeDtlUpd(commonCodeVo);
	}
	
	// 공통코드관리 DTL 삭제
	@Override
	public void commonCodeDtlDel(CommonCodeVo commonCodeVo) throws Exception {
		dao.commonCodeDtlDel(commonCodeVo);
	}
	
	// 공통코드관리 DTL 코드 중복확인
	@Override
	public CommonCodeVo commonCodeDtlDupCheck(CommonCodeVo commonCodeVo) throws Exception{
		return dao.commonCodeDtlDupCheck(commonCodeVo);
	}
	
}
