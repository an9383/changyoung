package mes.service.sm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.sm.MenuInfoVo;
import mes.persistence.sm.MenuInfoDAO;

@Service
public class MenuInfoServiceImpl implements MenuInfoService {

	@Inject
	private MenuInfoDAO dao;
	
	// ====================================== 메뉴정보관리 ADM ========================================
	// 메뉴정보관리 ADM 목록조회
	@Override
	public List<MenuInfoVo> menuInfoAdmLst(MenuInfoVo menuInfoVo) throws Exception {
		return dao.menuInfoAdmLst(menuInfoVo);
	}
	
	// 메뉴정보관리 ADM 상세조회
	@Override
	public MenuInfoVo menuInfoAdmSel(MenuInfoVo menuInfoVo) throws Exception {
		return dao.menuInfoAdmSel(menuInfoVo);
	}
	
	// 메뉴정보관리 ADM 등록
	@Override
	public void menuInfoAdmIns(MenuInfoVo menuInfoVo) throws Exception {
		dao.menuInfoAdmIns(menuInfoVo);
	}
	
	// 메뉴정보관리 ADM 수정
	@Override
	public void menuInfoAdmUpd(MenuInfoVo menuInfoVo) throws Exception {
		dao.menuInfoAdmUpd(menuInfoVo);
	}
	
	// 메뉴정보관리 ADM 삭제
	@Override
	public void menuInfoAdmDel(MenuInfoVo menuInfoVo) throws Exception {
		dao.menuInfoAdmDel(menuInfoVo);
	}
	
	// 메뉴정보관리 ADM 코드 중복확인
	@Override
	public MenuInfoVo menuInfoAdmDupCheck(MenuInfoVo menuInfoVo) throws Exception {
		return dao.menuInfoAdmDupCheck(menuInfoVo);
	}
	
	
	// ====================================== 메뉴정보관리 DTL ========================================
	// 메뉴정보관리 DTL 목록조회
	@Override
	public List<MenuInfoVo> menuInfoDtlLst(MenuInfoVo menuInfoVo) throws Exception {
		return dao.menuInfoDtlLst(menuInfoVo);
	}
	
	// 메뉴정보관리 DTL 상세조회
	@Override
	public MenuInfoVo menuInfoDtlSel(MenuInfoVo menuInfoVo) throws Exception {
		return dao.menuInfoDtlSel(menuInfoVo);
	}
	
	// 메뉴정보관리 DTL 등록
	@Override
	public void menuInfoDtlIns(MenuInfoVo menuInfoVo) throws Exception {
		dao.menuInfoDtlIns(menuInfoVo);
	}
	
	// 메뉴정보관리 DTL 수정
	@Override
	public void menuInfoDtlUpd(MenuInfoVo menuInfoVo) throws Exception {
		dao.menuInfoDtlUpd(menuInfoVo);
	}
	
	// 메뉴정보관리 DTL 삭제
	@Override
	public void menuInfoDtlDel(MenuInfoVo menuInfoVo) throws Exception {
		dao.menuInfoDtlDel(menuInfoVo);
	}
	
	// 메뉴정보관리 DTL 코드 중복확인
	@Override
	public MenuInfoVo menuInfoDtlDupCheck(MenuInfoVo menuInfoVo) throws Exception{
		return dao.menuInfoDtlDupCheck(menuInfoVo);
	}
	
}
