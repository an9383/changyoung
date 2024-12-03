package mes.persistence.sm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.sm.CommonCodeVo;
import mes.domain.sm.UserVo;

@Repository
public class CommonCodeDAOImpl implements CommonCodeDAO {

	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.sm.commonCodeMapper";
	
	// ====================================== 공통코드관리 ADM ========================================
	// 공통코드관리 ADM 목록조회
	@Override
	public List<CommonCodeVo> commonCodeAdmLst(CommonCodeVo commonCodeVo) throws Exception {
		return session.selectList(namespace+".commonCodeAdmLst", commonCodeVo);
	}
	
	// 공통코드관리 ADM 상세조회
	@Override
	public CommonCodeVo commonCodeAdmSel(CommonCodeVo commonCodeVo) throws Exception {
		return session.selectOne(namespace+".commonCodeAdmSel", commonCodeVo);
	}
	
	// 공통코드관리 ADM 등록
	@Override
	public void commonCodeAdmIns(CommonCodeVo commonCodeVo) throws Exception {
		session.insert(namespace+".commonCodeAdmIns", commonCodeVo);
	}
	
	// 공통코드관리 ADM 수정
	@Override
	public void commonCodeAdmUpd(CommonCodeVo commonCodeVo) throws Exception {
		session.update(namespace+".commonCodeAdmUpd", commonCodeVo);
	}
	
	// 공통코드관리 ADM 삭제
	@Override
	public void commonCodeAdmDel(CommonCodeVo commonCodeVo) throws Exception {
		session.delete(namespace+".commonCodeAdmDel", commonCodeVo);
	}
	
	// 공통코드관리 ADM 코드 중복확인
	@Override
	public CommonCodeVo commonCodeAdmDupCheck(CommonCodeVo commonCodeVo) throws Exception {
		return session.selectOne(namespace+".commonCodeAdmDupCheck", commonCodeVo);
	}
	
	
	// ====================================== 공통코드관리 DTL ========================================
	// 공통코드관리 DTL 목록조회
	@Override
	public List<CommonCodeVo> commonCodeDtlLst(CommonCodeVo commonCodeVo) throws Exception {
		return session.selectList(namespace+".commonCodeDtlLst", commonCodeVo);
	}
	
	// 공통코드관리 DTL 공통코드별 목록조회
	@Override
	public List<CommonCodeVo> commonCodeDtlLstByCommonCd(CommonCodeVo commonCodeVo) throws Exception {
		return session.selectList(namespace+".commonCodeDtlLstByCommonCd", commonCodeVo);
	}
	
	// 공통코드관리 DTL 공통코드별 목록조회
	@Override
	public List<CommonCodeVo> commonCodeDtlLstByCommonCdString(CommonCodeVo commonCodeVo) throws Exception {
		return session.selectList(namespace+".commonCodeDtlLstByCommonCdString", commonCodeVo);
	}
	
	// 공통코드관리 DTL 상세조회
	@Override
	public CommonCodeVo commonCodeDtlSel(CommonCodeVo commonCodeVo) throws Exception {
		return session.selectOne(namespace+".commonCodeDtlSel", commonCodeVo);
	}
	
	// 공통코드관리 DTL 등록
	@Override
	public void commonCodeDtlIns(CommonCodeVo commonCodeVo) throws Exception {
		session.insert(namespace+".commonCodeDtlIns", commonCodeVo);
	}
	
	// 공통코드관리 DTL 수정
	@Override
	public void commonCodeDtlUpd(CommonCodeVo commonCodeVo) throws Exception {
		session.update(namespace+".commonCodeDtlUpd", commonCodeVo);
	}
	
	// 공통코드관리 DTL 삭제
	@Override
	public void commonCodeDtlDel(CommonCodeVo commonCodeVo) throws Exception {
		session.delete(namespace+".commonCodeDtlDel", commonCodeVo);
	}
	
	// 공통코드관리 DTL 코드 중복확인
	@Override
	public CommonCodeVo commonCodeDtlDupCheck(CommonCodeVo commonCodeVo) throws Exception{
		return session.selectOne(namespace+".commonCodeDtlDupCheck", commonCodeVo);
	}
}
