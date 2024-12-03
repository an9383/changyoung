package mes.persistence.wm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.wm.WorkPlanVo;

@Repository
public class WorkPlanDAOImpl implements WorkPlanDAO {

	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.wm.workPlanMapper";

	//수주 목록 조회
	@Override
	public List<WorkPlanVo> purchaseOrdLst(WorkPlanVo workPlanVo) throws Exception {
		return session.selectList(namespace+".purchaseOrdLst", workPlanVo);
	}
	
	//작업지시 목록 조회
	@Override
	public List<WorkPlanVo> workOrdLst(WorkPlanVo workPlanVo) throws Exception {
		return session.selectList(namespace+".workOrdLst", workPlanVo);
	}
	
	//작업지시 등록
	@Override
	public void workOrdIns(WorkPlanVo workPlanVo) throws Exception {
		session.insert(namespace+".workOrdIns", workPlanVo);
	}
	
	//작업지시 수정
	@Override
	public void workOrdUpd(WorkPlanVo workPlanVo) throws Exception {
		session.update(namespace+".workOrdUpd", workPlanVo);
	}
	
	//작업지시 삭제
	@Override
	public void workOrdDel(WorkPlanVo workPlanVo) throws Exception {
		session.delete(namespace+".workOrdDel", workPlanVo);
	}
	
	//생산 공정내역 목록 조회
	@Override
	public List<WorkPlanVo> workOrdPrcssLst(WorkPlanVo workPlanVo) throws Exception {
		return session.selectList(namespace+".workOrdPrcssLst", workPlanVo);
	}
	
	//생산공정 등록
	@Override
	public void workOrdPrcssIns(WorkPlanVo workPlanVo) throws Exception {
		session.insert(namespace+".workOrdPrcssIns", workPlanVo);
	}
	
	//생산공정 수정
	@Override
	public void workOrdPrcssUpd(WorkPlanVo workPlanVo) throws Exception {
		session.update(namespace+".workOrdPrcssUpd", workPlanVo);
	}
	
	//생산 공정 다중 수정(todayWorkYn)
	@Override
	public void workOrdPrcssTodayWorkYnUpd(WorkPlanVo workPlanVo) throws Exception {
		session.update(namespace + ".workOrdPrcssTodayWorkYnUpd", workPlanVo);
	}
	
	//생산공정 삭제
	@Override
	public void workOrdPrcssDel(WorkPlanVo workPlanVo) throws Exception {
		session.delete(namespace+".workOrdPrcssDel", workPlanVo);
	}
	
	//투입 자재내역 목록 조회
	@Override
	public List<WorkPlanVo> workOrdInputMaterialLst(WorkPlanVo workPlanVo) throws Exception {
		return session.selectList(namespace+".workOrdInputMaterialLst", workPlanVo);
	}
	
	//금일작업등록
	@Override
	public void workOrdPrcssDailyWorkIns(WorkPlanVo workPlanVo) throws Exception{
		session.insert(namespace+".workOrdPrcssDailyWorkIns", workPlanVo);
	}
	
	//금일작업취소
	@Override
	public void workOrdPrcssDailyWorkUpd(WorkPlanVo workPlanVo) throws Exception{
		session.update(namespace+".workOrdPrcssDailyWorkUpd", workPlanVo);
	}
	
}
