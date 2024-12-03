package mes.persistence.wm;

import java.util.List;

import mes.domain.wm.WorkPlanVo;

public interface WorkPlanDAO {

	//수주 목록 조회
	public List<WorkPlanVo> purchaseOrdLst(WorkPlanVo workPlanVo) throws Exception;

	//작업지시 목록 조회
	public List<WorkPlanVo> workOrdLst(WorkPlanVo workPlanVo) throws Exception;
		
	//작업지시등록
	public void workOrdIns(WorkPlanVo workPlanVo) throws Exception;
	
	//작업지시 수정
	public void workOrdUpd(WorkPlanVo workPlanVo) throws Exception;
	
	//작업지시 삭제
	public void workOrdDel(WorkPlanVo workPlanVo) throws Exception;
	
	//생산 공정내역 목록 조회
	public List<WorkPlanVo> workOrdPrcssLst(WorkPlanVo workPlanVo) throws Exception;
	
	//생산 공정 등록
	public void workOrdPrcssIns(WorkPlanVo workPlanVo) throws Exception;
	
	//생산 공정 수정
	public void workOrdPrcssUpd(WorkPlanVo workPlanVo) throws Exception;
	
	//생산 공정 다중 수정(todayWorkYn)
	public void workOrdPrcssTodayWorkYnUpd(WorkPlanVo workPlanVo) throws Exception;
	
	//생산 공정 삭제
	public void workOrdPrcssDel(WorkPlanVo workPlanVo) throws Exception;
		
	//투입자재 내역 목록 조회
	public List<WorkPlanVo> workOrdInputMaterialLst(WorkPlanVo workPlanVo) throws Exception;
	
	//금일작업등록
	public void workOrdPrcssDailyWorkIns(WorkPlanVo workPlanVo) throws Exception;
	
	//금일작업취소
	public void workOrdPrcssDailyWorkUpd(WorkPlanVo workPlanVo) throws Exception;
	
}
