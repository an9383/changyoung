package mes.persistence.sm;

import java.util.List;

import mes.domain.sm.WorkplaceVo;

public interface WorkplaceDAO {

	//사업장정보 목록조회
	public List<WorkplaceVo> workplaceLst(WorkplaceVo workplaceVo) throws Exception;
	
	//사업장 상세조회
	public WorkplaceVo workplaceSel(WorkplaceVo workplaceVo) throws Exception;
	
	//사업장정보 등록
	public void workplaceIns(WorkplaceVo workplaceVo) throws Exception;
	
	//사업장정보 수정
	public void workplaceUpd(WorkplaceVo workplaceVo) throws Exception;
	
	//사업장 코드 중복확인
	public WorkplaceVo workplaceIdDupCheck(WorkplaceVo workplaceVo) throws Exception;
	
}
