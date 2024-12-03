package mes.persistence.sm;

import java.util.List;

import mes.domain.sm.MenuInfoVo;

public interface MenuInfoDAO {

	// ====================================== 메뉴정보관리 ADM ========================================
	// 메뉴정보관리 ADM 목록조회
	public List<MenuInfoVo> menuInfoAdmLst(MenuInfoVo menuInfoVo) throws Exception;
	
	// 메뉴정보관리 ADM 상세조회
	public MenuInfoVo menuInfoAdmSel(MenuInfoVo menuInfoVo) throws Exception;
	
	// 메뉴정보관리 ADM 등록
	public void menuInfoAdmIns(MenuInfoVo menuInfoVo) throws Exception;
	
	// 메뉴정보관리 ADM 수정
	public void menuInfoAdmUpd(MenuInfoVo menuInfoVo) throws Exception;
	
	// 메뉴정보관리 ADM 삭제
	public void menuInfoAdmDel(MenuInfoVo menuInfoVo) throws Exception;
	
	// 메뉴정보관리 ADM 코드 중복확인
	public MenuInfoVo menuInfoAdmDupCheck(MenuInfoVo menuInfoVo) throws Exception;
	
	
	// ====================================== 메뉴정보관리 DTL ========================================
	// 메뉴정보관리 DTL 목록조회
	public List<MenuInfoVo> menuInfoDtlLst(MenuInfoVo menuInfoVo) throws Exception;
	
	// 메뉴정보관리 DTL 상세조회
	public MenuInfoVo menuInfoDtlSel(MenuInfoVo menuInfoVo) throws Exception;
	
	// 메뉴정보관리 DTL 등록
	public void menuInfoDtlIns(MenuInfoVo menuInfoVo) throws Exception;
	
	// 메뉴정보관리 DTL 수정
	public void menuInfoDtlUpd(MenuInfoVo menuInfoVo) throws Exception;
	
	// 메뉴정보관리 DTL 삭제
	public void menuInfoDtlDel(MenuInfoVo menuInfoVo) throws Exception;
	
	// 메뉴정보관리 DTL 코드 중복확인
	public MenuInfoVo menuInfoDtlDupCheck(MenuInfoVo menuInfoVo) throws Exception;
	
}
