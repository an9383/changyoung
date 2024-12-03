package mes.service.sm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.sm.MenuAuthVo;
import mes.persistence.sm.MenuAuthDAO;

@Service
public class MenuAuthServiceImpl implements MenuAuthService {

	@Inject
	private MenuAuthDAO dao;
	
	// 메뉴권한관리 사용자별 목록조회
	@Override
	public List<MenuAuthVo> menuAuthLstByUserIdx(MenuAuthVo menuAuthVo) throws Exception {
		return dao.menuAuthLstByUserIdx(menuAuthVo);
	}
	
	// 메뉴권한관리 메뉴목록조회 리스트
	@Override
	public List<MenuAuthVo> menuAuthLstForMenuList(MenuAuthVo menuAuthVo) throws Exception {
		return dao.menuAuthLstForMenuList(menuAuthVo);
	}
	
	// 메뉴권한관리 등록
	@Override
	public void menuAuthIns(MenuAuthVo menuAuthVo) throws Exception {
		dao.menuAuthIns(menuAuthVo);
	}
	
	// 메뉴권한관리 수정
	@Override
	public void menuAuthUpd(MenuAuthVo menuAuthVo) throws Exception {
		dao.menuAuthUpd(menuAuthVo);
	}
	
	// 메뉴권한관리 삭제
	@Override
	public void menuAuthDel(MenuAuthVo menuAuthVo) throws Exception {
		dao.menuAuthDel(menuAuthVo);
	}
	
	// 메뉴권한관리 복사
	@Override
	public void menuAuthCopyNPaste(MenuAuthVo menuAuthVo) throws Exception {
		dao.menuAuthCopyNPaste(menuAuthVo);
	}
}
