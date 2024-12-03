package mes.persistence.stock;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.stock.OutMatrWhsAdmVo;

@Repository
public class OutMatrWhsAdmDAOImpl implements OutMatrWhsAdmDAO {

	@Inject
	private SqlSession session;

	private static final String namespace = "mes.mappers.stock.outMatrWhsAdmMapper";
	
	// 자재 출고전표 등록
	@Override
	public void outMatrWhsAdmIns(OutMatrWhsAdmVo outMatrWhsAdmVo) throws Exception {
		session.insert(namespace+".outMatrWhsAdmIns" ,outMatrWhsAdmVo);
	}
	
	// 자재 출고전표 수정
	@Override
	public void outMatrWhsAdmUpd(OutMatrWhsAdmVo outMatrWhsAdmVo) throws Exception {
		session.update(namespace+".outMatrWhsAdmUpd" ,outMatrWhsAdmVo);
	}
	
	// 자재 출고전표 삭제
	@Override
	public void outMatrWhsAdmDel(OutMatrWhsAdmVo outMatrWhsAdmVo) throws Exception {
		session.delete(namespace+".outMatrWhsAdmDel" ,outMatrWhsAdmVo);
	}
	
	// 자재 전표번호 릴레이션번호로 조회
	@Override
	public List<OutMatrWhsAdmVo> getOutSlipNoByRelationNo(OutMatrWhsAdmVo outMatrWhsAdmVo) throws Exception {
		return session.selectList(namespace+".getOutSlipNoByRelationNo" ,outMatrWhsAdmVo);
	}
	
	// 자재 전표번호 채번
	@Override
	public String getOutSlipNo(OutMatrWhsAdmVo outMatrWhsAdmVo) throws Exception {
		return session.selectOne(namespace+".getOutSlipNo" ,outMatrWhsAdmVo);
	}
}
