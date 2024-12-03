package mes.persistence.bm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.bm.PrcssInfoVo;


@Repository
public class PrcssInfoDAOImpl implements PrcssInfoDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.bm.prcssInfoMapper";
	
	//공정정보 목록조회
	@Override
	public List<PrcssInfoVo> prcssListAll(PrcssInfoVo prcssInfoVo) throws Exception{
		return session.selectList(namespace+".prcssListAll" ,prcssInfoVo );
	}
	
	//공정정보 상세조회
	@Override
	public PrcssInfoVo prcssInfoSel(PrcssInfoVo prcssInfoVo) throws Exception {
		return session.selectOne(namespace+".prcssInfoSel", prcssInfoVo);
	}
		
	//공정정보 등록
	@Override
	public void prcssInsert(PrcssInfoVo prcssInfoVo) throws Exception {
		session.insert(namespace+".prcssInsert", prcssInfoVo);
	}
	
	//공정정보 순서 수정
	@Override
	public void prcssOrdUpdate(PrcssInfoVo prcssInfoVo) throws Exception {
		session.update(namespace+".prcssOrdUpdate", prcssInfoVo);
	}
	
	//공정정보 수정
	@Override
	public void prcssUpdate(PrcssInfoVo prcssInfoVo) throws Exception {
		session.update(namespace+".prcssUpdate", prcssInfoVo);
	}	
	
	//삭제
	@Override
	public void prcssDelete(PrcssInfoVo prcssInfoVo) throws Exception {
		session.delete(namespace+".prcssDelete", prcssInfoVo);
	}
	
	//공정코드 중복확인
	@Override
	public PrcssInfoVo prcssCdDupCheck(PrcssInfoVo prcssInfoVo) throws Exception {
		return session.selectOne(namespace+".prcssCdDupCheck", prcssInfoVo);
	}

	//공정작업자 목록조회
	@Override
	public List<PrcssInfoVo> prcssWorkerListAll(PrcssInfoVo prcssInfoVo) throws Exception{
		return session.selectList(namespace+".prcssWorkerListAll" ,prcssInfoVo );
	}
	
	//공정 작업자 삭제
	@Override
	public void prcssWorkerDelete(PrcssInfoVo prcssInfoVo) throws Exception {
		session.delete(namespace+".prcssWorkerDelete", prcssInfoVo);
	}
	
	//공정작업자 등록
	@Override
	public void prcssWorkerInsert(PrcssInfoVo prcssInfoVo) throws Exception{
		session.insert(namespace+".prcssWorkerInsert" ,prcssInfoVo );
	}
	
	//설비 목록조회
	@Override
	public List<PrcssInfoVo> prcssEquipListAll(PrcssInfoVo prcssInfoVo) throws Exception{
		return session.selectList(namespace+".prcssEquipListAll" ,prcssInfoVo );
	}
	
	//설비 삭제
	@Override
	public void prcssEquipDelete(PrcssInfoVo prcssInfoVo) throws Exception {
		session.delete(namespace+".prcssEquipDelete", prcssInfoVo);
	}
	
	//설비 등록
	@Override
	public void prcssEquipInsert(PrcssInfoVo prcssInfoVo) throws Exception{
		session.insert(namespace+".prcssEquipInsert" ,prcssInfoVo );
	}
	
	//작업방식 목록조회
	@Override
	public List<PrcssInfoVo> prcssWorkMethodListAll(PrcssInfoVo prcssInfoVo) throws Exception{
		return session.selectList(namespace+".prcssWorkMethodListAll" ,prcssInfoVo );
	}
	
	//작업방식 삭제
	@Override
	public void prcssWorkMethodDelete(PrcssInfoVo prcssInfoVo) throws Exception {
		session.delete(namespace+".prcssWorkMethodDelete", prcssInfoVo);
	}
	
	//작업방식 등록
	@Override
	public void prcssWorkMethodInsert(PrcssInfoVo prcssInfoVo) throws Exception{
		session.insert(namespace+".prcssWorkMethodInsert" ,prcssInfoVo );
	}
	
	//점검항목 목록조회
	@Override
	public List<PrcssInfoVo> prcssInspectionMethodListAll(PrcssInfoVo prcssInfoVo) throws Exception{
		return session.selectList(namespace+".prcssInspectionMethodListAll" ,prcssInfoVo );
	}
	
	//점검항목 등록
	@Override
	public void prcssInspectionMethodInsert(PrcssInfoVo prcssInfoVo) throws Exception{
		session.insert(namespace+".prcssInspectionMethodInsert" ,prcssInfoVo );
	}
	
	//점검항목 삭제
	@Override
	public void prcssInspectionMethodDelete(PrcssInfoVo prcssInfoVo) throws Exception {
		session.delete(namespace+".prcssInspectionMethodDelete", prcssInfoVo);
	}
}