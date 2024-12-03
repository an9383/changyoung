package mes.persistence.stock;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.stock.InMatrWhsAdmVo;

@Repository
public class InMatrWhsAdmDAOImpl implements InMatrWhsAdmDAO {

	@Inject
	private SqlSession session;

	private static final String namespace = "mes.mappers.stock.inMatrWhsAdmMapper";
	
	// 자재 입고전표 목록조회
	@Override
	public List<InMatrWhsAdmVo> inMatrWhsAdmLst(InMatrWhsAdmVo inMatrWhsAdmVo) throws Exception {
		return session.selectList(namespace+".inMatrWhsAdmLst" , inMatrWhsAdmVo);
	}
	
	// 자재 입고전표 상세조회
	@Override
	public InMatrWhsAdmVo inMatrWhsAdmSel(InMatrWhsAdmVo inMatrWhsAdmVo) throws Exception{
		return session.selectOne(namespace+".inMatrWhsAdmSel", inMatrWhsAdmVo);
	}
	
	// 자재 입고전표 등록
	@Override
	public void inMatrWhsAdmIns(InMatrWhsAdmVo inMatrWhsAdmVo) throws Exception {
		session.insert(namespace+".inMatrWhsAdmIns" ,inMatrWhsAdmVo);
	}
	
	// 자재 입고전표 수정
	@Override
	public void inMatrWhsAdmUpd(InMatrWhsAdmVo inMatrWhsAdmVo) throws Exception {
		session.update(namespace+".inMatrWhsAdmUpd" ,inMatrWhsAdmVo);
	}
	
	// 자재 입고전표 삭제
	@Override
	public void inMatrWhsAdmDel(InMatrWhsAdmVo inMatrWhsAdmVo) throws Exception {
		session.delete(namespace+".inMatrWhsAdmDel" ,inMatrWhsAdmVo);
	}
	
	// 자재 전표번호 조회
	@Override
	public String inMatrWhsAdmGetInSlipNo(InMatrWhsAdmVo inMatrWhsAdmVo) throws Exception {
		return session.selectOne(namespace+".inMatrWhsAdmGetInSlipNo" ,inMatrWhsAdmVo);
	}
	
	// 자재 LOT번호 조회
	@Override
	public String inMatrWhsAdmGetLotNo(InMatrWhsAdmVo inMatrWhsAdmVo) throws Exception {
		return session.selectOne(namespace+".inMatrWhsAdmGetLotNo" ,inMatrWhsAdmVo);
	}
	
	// ======================================================================================
	// 자재 입고전표 연관변호별 목록조회
	public List<InMatrWhsAdmVo> inMatrWhsAdmLstByRelationNo(InMatrWhsAdmVo inMatrWhsAdmVo) throws Exception {
		return session.selectList(namespace+".inMatrWhsAdmLstByRelationNo" , inMatrWhsAdmVo);
	}
}
