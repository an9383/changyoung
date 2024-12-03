package mes.persistence.bm;

import java.util.List;

import mes.domain.bm.WoodenInfoVo;

public interface WoodenInfoDAO {

	// =========================== 목형정보관리 기본정보 ==========================================
	// 목형정보관리 기본정보 목록조회
	public List<WoodenInfoVo> woodenInfoAdmLst(WoodenInfoVo woodenInfoVo) throws Exception;
	
	// 목형정보관리 목록조회 - 사이즈 코팅 성형방식 일치하는 목록 
	public List<WoodenInfoVo> woodenInfoAdmLstWithSizeCoatingMolding(WoodenInfoVo woodenInfoVo) throws Exception;
	
	// 목형정보관리 기본정보 상세조회
	public WoodenInfoVo woodenInfoAdmSel(WoodenInfoVo woodenInfoVo) throws Exception;
	
	// 목형정보관리 기본정보 등록
	public String woodenInfoAdmIns(WoodenInfoVo woodenInfoVo) throws Exception;
	
	// 목형정보관리 기본정보 수정
	public void woodenInfoAdmUpd(WoodenInfoVo woodenInfoVo) throws Exception;
	
	// 목형정보관리 기본정보 삭제
	public void woodenInfoAdmDel(WoodenInfoVo woodenInfoVo) throws Exception;
	
	// 목형정보관리 기본정보 목형코드 중복확인
	public WoodenInfoVo woodenInfoAdmIdDupCheck(WoodenInfoVo woodenInfoVo) throws Exception;
	
	// =========================== 목형정보관리 사용이력 ==========================================
	// 목형정보관리 사용이력 목록조회
	public List<WoodenInfoVo> woodenInfoLogLst(WoodenInfoVo woodenInfoVo) throws Exception;
	
	// 목형정보관리 사용이력 상세조회
	public WoodenInfoVo woodenInfoLogSel(WoodenInfoVo woodenInfoVo) throws Exception;
	
	// 목형정보관리 사용이력 등록
	public void woodenInfoLogIns(WoodenInfoVo woodenInfoVo) throws Exception;
	
	// 목형정보관리 사용이력 등록
	public void prcssUseWoodenLogIns(WoodenInfoVo woodenInfoVo) throws Exception;
	
	// 목형정보관리 사용이력 수정
	public void woodenInfoLogUpd(WoodenInfoVo woodenInfoVo) throws Exception;
	
	// 목형정보관리 사용이력 삭제
	public void woodenInfoLogDel(WoodenInfoVo woodenInfoVo) throws Exception;
}
