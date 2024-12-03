package mes.persistence.em;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.em.EquipInfoVo;


@Repository
public class EquipInfoDAOImpl implements EquipInfoDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.em.equipInfoMapper";
	
	//설비코드 목록조회
	@Override
	public List<EquipInfoVo> equipInfoListAll(EquipInfoVo equipInfoVo) throws Exception{
		return session.selectList(namespace+".equipInfoListAll" ,equipInfoVo );
	}
	
	//설비 담당자 목록조회
	@Override
	public List<EquipInfoVo> equipUserInfoLst(EquipInfoVo equipInfoVo) throws Exception{
		return session.selectList(namespace+".equipUserInfoLst" ,equipInfoVo );
	}
	
	//설비 담당자 등록
	@Override
	public void equipUserDelIns(EquipInfoVo equipInfoVo) throws Exception {
		session.insert(namespace+".equipUserDelIns", equipInfoVo);
	}
	
	//공정설비 목록조회
	@Override
	public List<EquipInfoVo> prcssEquipInfoListAll(EquipInfoVo equipInfoVo) throws Exception{
		return session.selectList(namespace+".prcssEquipInfoListAll" ,equipInfoVo );
	}
	
	//설비코드 상세조회
	@Override
	public EquipInfoVo equipInfoSel(EquipInfoVo equipInfoVo) throws Exception {
		return session.selectOne(namespace+".equipInfoSel", equipInfoVo);
	}
		
	//설비코드 등록
	@Override
	public void equipInfoInsert(EquipInfoVo equipInfoVo) throws Exception {
		session.insert(namespace+".equipInfoInsert", equipInfoVo);
	}
	
	//설비코드 수정
	@Override
	public void equipInfoUpdate(EquipInfoVo equipInfoVo) throws Exception {
		session.update(namespace+".equipInfoUpdate", equipInfoVo);
	}	
	
	//설비코드 순번 수정
	@Override
	public void equipInfoOrdUpdate(EquipInfoVo equipInfoVo) throws Exception {
		session.update(namespace+".equipInfoOrdUpdate", equipInfoVo);
	}	
	
	//설비코드 삭제
	@Override
	public void equipInfoDelete(EquipInfoVo equipInfoVo) throws Exception {
		session.delete(namespace+".equipInfoDelete", equipInfoVo);
	}
	
	//설비코드 중복확인
	@Override
	public EquipInfoVo equipInfoDupCheck(EquipInfoVo equipInfoVo) throws Exception {
		return session.selectOne(namespace+".equipInfoDupCheck", equipInfoVo);
	}
	
	//관련자료 목록조회
	@Override
	public List<EquipInfoVo> equipAttachDataList(EquipInfoVo equipInfoVo) throws Exception{
		return session.selectList(namespace+".equipAttachDataList" ,equipInfoVo );
	}
	
	//관련자료 등록
	@Override
	public void equipAttachDataInsert(EquipInfoVo equipInfoVo) throws Exception {
		session.insert(namespace+".equipAttachDataInsert", equipInfoVo);
	}
	
	//관련자료 삭제
	@Override
	public void equipAttachDataDelete(EquipInfoVo equipInfoVo) throws Exception {
		session.delete(namespace+".equipAttachDataDelete", equipInfoVo);
	}
		
}