package mes.persistence.bm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.bm.WoodenInfoVo;

@Repository
public class WoodenInfoDAOImpl implements WoodenInfoDAO {

	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.bm.woodenInfoMapper";
	
	// =========================== 목형정보관리 기본정보 ==========================================
	// 목형정보관리 기본정보 목록조회
	@Override
	public List<WoodenInfoVo> woodenInfoAdmLst(WoodenInfoVo woodenInfoVo) throws Exception {
		return session.selectList(namespace+".woodenInfoAdmLst", woodenInfoVo);
	}
	
	// 목형정보관리 목록조회 - 사이즈 코팅 성형방식 일치하는 목록 
	@Override
	public List<WoodenInfoVo> woodenInfoAdmLstWithSizeCoatingMolding(WoodenInfoVo woodenInfoVo) throws Exception {
		return session.selectList(namespace+".woodenInfoAdmLstWithSizeCoatingMolding", woodenInfoVo);
	}
	
	
	// 목형정보관리 기본정보 상세조회
	@Override
	public WoodenInfoVo woodenInfoAdmSel(WoodenInfoVo woodenInfoVo) throws Exception {
		return session.selectOne(namespace+".woodenInfoAdmSel", woodenInfoVo);
	}
	
	// 목형정보관리 기본정보 등록
	@Override
	public String woodenInfoAdmIns(WoodenInfoVo woodenInfoVo) throws Exception {
		session.insert(namespace+".woodenInfoAdmIns", woodenInfoVo);
		String idx = woodenInfoVo.getIdx();
		return idx;
	}
	
	// 목형정보관리 기본정보 수정
	@Override
	public void woodenInfoAdmUpd(WoodenInfoVo woodenInfoVo) throws Exception {
		session.update(namespace+".woodenInfoAdmUpd", woodenInfoVo);
	}
	
	// 목형정보관리 기본정보 삭제
	@Override
	public void woodenInfoAdmDel(WoodenInfoVo woodenInfoVo) throws Exception {
		session.delete(namespace+".woodenInfoAdmDel", woodenInfoVo);
	}
	
	// 목형정보관리 기본정보 목형코드 중복확인
	@Override
	public WoodenInfoVo woodenInfoAdmIdDupCheck(WoodenInfoVo woodenInfoVo) throws Exception {
		return session.selectOne(namespace+".woodenInfoAdmIdDupCheck", woodenInfoVo);
	}
	
	// =========================== 목형정보관리 사용이력 ==========================================
	// 목형정보관리 사용이력 목록조회
	@Override
	public List<WoodenInfoVo> woodenInfoLogLst(WoodenInfoVo woodenInfoVo) throws Exception {
		return session.selectList(namespace+".woodenInfoLogLst", woodenInfoVo);
	}
	
	// 목형정보관리 사용이력 상세조회
	@Override
	public WoodenInfoVo woodenInfoLogSel(WoodenInfoVo woodenInfoVo) throws Exception {
		return session.selectOne(namespace+".woodenInfoLogSel", woodenInfoVo);
	}
	
	// 목형정보관리 사용이력 등록
	@Override
	public void woodenInfoLogIns(WoodenInfoVo woodenInfoVo) throws Exception {
		session.insert(namespace+".woodenInfoLogIns", woodenInfoVo);
	}
	
	// 목형정보관리 사용이력 등록
	@Override
	public void prcssUseWoodenLogIns(WoodenInfoVo woodenInfoVo) throws Exception {
		session.insert(namespace+".prcssUseWoodenLogIns", woodenInfoVo);
	}
	
	// 목형정보관리 사용이력 수정
	@Override
	public void woodenInfoLogUpd(WoodenInfoVo woodenInfoVo) throws Exception {
		session.update(namespace+".woodenInfoLogUpd", woodenInfoVo);
	}
	
	// 목형정보관리 사용이력 삭제
	@Override
	public void woodenInfoLogDel(WoodenInfoVo woodenInfoVo) throws Exception {
		session.delete(namespace+".woodenInfoLogDel", woodenInfoVo);
	}
}
