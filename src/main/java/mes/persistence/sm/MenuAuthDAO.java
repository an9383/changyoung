package mes.persistence.sm;

import java.util.List;

import mes.domain.sm.MenuAuthVo;

public interface MenuAuthDAO {

	// 메뉴권한관리 사용자별 목록조회
	public List<MenuAuthVo> menuAuthLstByUserIdx(MenuAuthVo menuAuthVo) throws Exception;
	
	// 메뉴권한관리 메뉴목록조회 리스트
	public List<MenuAuthVo> menuAuthLstForMenuList(MenuAuthVo menuAuthVo) throws Exception;
	
	// 메뉴권한관리 등록
	public void menuAuthIns(MenuAuthVo menuAuthVo) throws Exception;
	
	// 메뉴권한관리 수정
	public void menuAuthUpd(MenuAuthVo menuAuthVo) throws Exception;
	
	// 메뉴권한관리 삭제
	public void menuAuthDel(MenuAuthVo menuAuthVo) throws Exception;
	
	// 메뉴권한관리 복사
	public void menuAuthCopyNPaste(MenuAuthVo menuAuthVo) throws Exception;
}
