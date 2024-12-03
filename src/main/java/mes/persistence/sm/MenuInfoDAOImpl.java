package mes.persistence.sm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.sm.MenuInfoVo;

@Repository
public class MenuInfoDAOImpl implements MenuInfoDAO {

	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.sm.menuInfoMapper";
	
	// ====================================== 메뉴정보관리 ADM ========================================
	// 메뉴정보관리 ADM 목록조회
	@Override
	public List<MenuInfoVo> menuInfoAdmLst(MenuInfoVo menuInfoVo) throws Exception {
		return session.selectList(namespace+".menuInfoAdmLst", menuInfoVo);
	}
	
	// 메뉴정보관리 ADM 상세조회
	@Override
	public MenuInfoVo menuInfoAdmSel(MenuInfoVo menuInfoVo) throws Exception {
		return session.selectOne(namespace+".menuInfoAdmSel", menuInfoVo);
	}
	
	// 메뉴정보관리 ADM 등록
	@Override
	public void menuInfoAdmIns(MenuInfoVo menuInfoVo) throws Exception {
		session.insert(namespace+".menuInfoAdmIns", menuInfoVo);
	}
	
	// 메뉴정보관리 ADM 수정
	@Override
	public void menuInfoAdmUpd(MenuInfoVo menuInfoVo) throws Exception {
		session.update(namespace+".menuInfoAdmUpd", menuInfoVo);
	}
	
	// 메뉴정보관리 ADM 삭제
	@Override
	public void menuInfoAdmDel(MenuInfoVo menuInfoVo) throws Exception {
		session.delete(namespace+".menuInfoAdmDel", menuInfoVo);
	}
	
	// 메뉴정보관리 ADM 코드 중복확인
	@Override
	public MenuInfoVo menuInfoAdmDupCheck(MenuInfoVo menuInfoVo) throws Exception {
		return session.selectOne(namespace+".menuInfoAdmDupCheck", menuInfoVo);
	}
	
	
	// ====================================== 메뉴정보관리 DTL ========================================
	// 메뉴정보관리 DTL 목록조회
	@Override
	public List<MenuInfoVo> menuInfoDtlLst(MenuInfoVo menuInfoVo) throws Exception {
		return session.selectList(namespace+".menuInfoDtlLst", menuInfoVo);
	}
	
	// 메뉴정보관리 DTL 상세조회
	@Override
	public MenuInfoVo menuInfoDtlSel(MenuInfoVo menuInfoVo) throws Exception {
		return session.selectOne(namespace+".menuInfoDtlSel", menuInfoVo);
	}
	
	// 메뉴정보관리 DTL 등록
	@Override
	public void menuInfoDtlIns(MenuInfoVo menuInfoVo) throws Exception {
		session.insert(namespace+".menuInfoDtlIns", menuInfoVo);
	}
	
	// 메뉴정보관리 DTL 수정
	@Override
	public void menuInfoDtlUpd(MenuInfoVo menuInfoVo) throws Exception {
		session.update(namespace+".menuInfoDtlUpd", menuInfoVo);
	}
	
	// 메뉴정보관리 DTL 삭제
	@Override
	public void menuInfoDtlDel(MenuInfoVo menuInfoVo) throws Exception {
		session.delete(namespace+".menuInfoDtlDel", menuInfoVo);
	}
	
	// 메뉴정보관리 DTL 코드 중복확인
	@Override
	public MenuInfoVo menuInfoDtlDupCheck(MenuInfoVo menuInfoVo) throws Exception{
		return session.selectOne(namespace+".menuInfoDtlDupCheck", menuInfoVo);
	}
}
