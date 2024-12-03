package mes.persistence.sm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.sm.WorkplaceVo;

@Repository
public class WorkplaceDAOImpl implements WorkplaceDAO {

	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.sm.workplaceMapper";
	
	//사업장정보 목록조회
	@Override
	public List<WorkplaceVo> workplaceLst(WorkplaceVo workplaceVo) throws Exception {
		return session.selectList(namespace+".workplaceLst", workplaceVo);
	}
	
	//사업장 상세조회
	@Override
	public WorkplaceVo workplaceSel(WorkplaceVo workplaceVo) throws Exception {
		return session.selectOne(namespace+".workplaceSel", workplaceVo);
	}
	
	//사업장정보 등록
	@Override
	public void workplaceIns(WorkplaceVo workplaceVo) throws Exception {
		session.insert(namespace+".workplaceIns", workplaceVo);
	}
	
	//사업장정보 수정
	@Override
	public void workplaceUpd(WorkplaceVo workplaceVo) throws Exception {
		session.update(namespace+".workplaceUpd", workplaceVo);
	}
	
	//사업장 코드 중복확인
	@Override
	public WorkplaceVo workplaceIdDupCheck(WorkplaceVo workplaceVo) throws Exception {
		return session.selectOne(namespace+".workplaceIdDupCheck", workplaceVo);
	}
	
}
