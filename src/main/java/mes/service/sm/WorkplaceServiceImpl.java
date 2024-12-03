package mes.service.sm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.sm.WorkplaceVo;
import mes.persistence.sm.WorkplaceDAO;

@Service
public class WorkplaceServiceImpl implements WorkplaceService {

	@Inject
	private WorkplaceDAO dao;
	
	//사업장정보 목록조회
	@Override
	public List<WorkplaceVo> workplaceLst(WorkplaceVo workplaceVo) throws Exception {
		return dao.workplaceLst(workplaceVo);
	}
	
	//사업장 상세조회
	@Override
	public WorkplaceVo workplaceSel(WorkplaceVo workplaceVo) throws Exception {
		return dao.workplaceSel(workplaceVo);
	}
	
	//사업장정보 등록
	@Override
	public void workplaceIns(WorkplaceVo workplaceVo) throws Exception {
		dao.workplaceIns(workplaceVo);
	}
	
	//사업장정보 수정
	@Override
	public void workplaceUpd(WorkplaceVo workplaceVo) throws Exception {
		dao.workplaceUpd(workplaceVo);
	}
	
	//사업장 코드 중복확인
	@Override
	public WorkplaceVo workplaceIdDupCheck(WorkplaceVo workplaceVo) throws Exception {
		return dao.workplaceIdDupCheck(workplaceVo);
	}
	
}
