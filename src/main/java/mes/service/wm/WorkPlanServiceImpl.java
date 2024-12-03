package mes.service.wm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.wm.WorkPlanVo;
import mes.persistence.wm.WorkPlanDAO;

@Service
public class WorkPlanServiceImpl implements WorkPlanService {

	@Inject
	private WorkPlanDAO dao;
	
	//수주 목록 조회
	@Override
	public List<WorkPlanVo> purchaseOrdLst(WorkPlanVo workPlanVo) throws Exception {
		return dao.purchaseOrdLst(workPlanVo);
	}
	
	//작업지시 목록 조회
	@Override
	public List<WorkPlanVo> workOrdLst(WorkPlanVo workPlanVo) throws Exception {
		return dao.workOrdLst(workPlanVo);
	}
	
	//작업지시등록
	@Override
	public void workOrdIns(WorkPlanVo workPlanVo) throws Exception {
		dao.workOrdIns(workPlanVo);
	}
	
	//작업지시수정
	@Override
	public void workOrdUpd(WorkPlanVo workPlanVo) throws Exception {
		dao.workOrdUpd(workPlanVo);
	}
	
	//작업지시삭제
	@Override
	public void workOrdDel(WorkPlanVo workPlanVo) throws Exception {
		dao.workOrdDel(workPlanVo);
	}
	
	//생산 공정내역 목록 조회
	@Override
	public List<WorkPlanVo> workOrdPrcssLst(WorkPlanVo workPlanVo) throws Exception {
		return dao.workOrdPrcssLst(workPlanVo);
	}
	
	//생산 공정 등록
	@Override
	public void workOrdPrcssIns(WorkPlanVo workPlanVo) throws Exception {
		dao.workOrdPrcssIns(workPlanVo);
	}
	
	//생산 공정 수정
	@Override
	public void workOrdPrcssUpd(WorkPlanVo workPlanVo) throws Exception {
		dao.workOrdPrcssUpd(workPlanVo);
	}
	
	//생산 공정 다중 수정(todayWorkYn)
	@Override
	public void workOrdPrcssTodayWorkYnUpd(WorkPlanVo workPlanVo) throws Exception {
		dao.workOrdPrcssTodayWorkYnUpd(workPlanVo);
	}
	
	//생산 공정 삭제
	@Override
	public void workOrdPrcssDel(WorkPlanVo workPlanVo) throws Exception {
		dao.workOrdPrcssDel(workPlanVo);
	}
	
	//투입자재 내역 목록 조회
	@Override
	public List<WorkPlanVo> workOrdInputMaterialLst(WorkPlanVo workPlanVo) throws Exception {
		return dao.workOrdInputMaterialLst(workPlanVo);
	}
	
	//금일작업등록
	@Override
	public void workOrdPrcssDailyWorkIns(WorkPlanVo workPlanVo) throws Exception{
		dao.workOrdPrcssDailyWorkIns(workPlanVo);
	}
	
	//금일작업취소
	@Override
	public void workOrdPrcssDailyWorkUpd(WorkPlanVo workPlanVo) throws Exception{
		dao.workOrdPrcssDailyWorkUpd(workPlanVo);
	}
}
