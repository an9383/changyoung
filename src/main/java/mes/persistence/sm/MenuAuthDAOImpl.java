package mes.persistence.sm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.sm.MenuAuthVo;

@Repository
public class MenuAuthDAOImpl implements MenuAuthDAO {

	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.sm.menuAuthMapper";
	
	// 메뉴권한관리 사용자별 목록조회
	@Override
	public List<MenuAuthVo> menuAuthLstByUserIdx(MenuAuthVo menuAuthVo) throws Exception {
		return session.selectList(namespace+".menuAuthLstByUserIdx", menuAuthVo);
	}
	
	// 메뉴권한관리 메뉴목록조회 리스트
	@Override
	public List<MenuAuthVo> menuAuthLstForMenuList(MenuAuthVo menuAuthVo) throws Exception {
		return session.selectList(namespace+".menuAuthLstForMenuList", menuAuthVo);
	}
	
	// 메뉴권한관리 등록
	@Override
	public void menuAuthIns(MenuAuthVo menuAuthVo) throws Exception {
		session.insert(namespace+".menuAuthIns", menuAuthVo);
	}
	
	// 메뉴권한관리 수정
	@Override
	public void menuAuthUpd(MenuAuthVo menuAuthVo) throws Exception {
		session.update(namespace+".menuAuthUpd", menuAuthVo);
	}
	
	// 메뉴권한관리 삭제
	@Override
	public void menuAuthDel(MenuAuthVo menuAuthVo) throws Exception {
		session.delete(namespace+".menuAuthDel", menuAuthVo);
	}
	
	// 메뉴권한관리 복사
	@Override
	public void menuAuthCopyNPaste(MenuAuthVo menuAuthVo) throws Exception {
		session.insert(namespace+".menuAuthCopyNPaste", menuAuthVo);
	}
}
