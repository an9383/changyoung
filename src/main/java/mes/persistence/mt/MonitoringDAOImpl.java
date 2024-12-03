package mes.persistence.mt;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.mt.MonitoringVo;

@Repository
public class MonitoringDAOImpl implements MonitoringDAO {

	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.mt.monitoringMapper";
	
	// 수주생산진행현황
	@Override
	public List<MonitoringVo> bizOrdWorkCurrentSituation(MonitoringVo monitoringVo) throws Exception {
		return session.selectList(namespace+".bizOrdWorkCurrentSituation", monitoringVo);
	}
	
	// 수주생산진행현황
	public List<MonitoringVo> bizOrdWorkPrcssCurrentSituation(MonitoringVo monitoringVo) throws Exception{
		return session.selectList(namespace+".bizOrdWorkPrcssCurrentSituation" , monitoringVo);
	}
	
	// 수주출하리드타임
	@Override
	public List<MonitoringVo> bizOrdOutLeadTime(MonitoringVo monitoringVo) throws Exception {
		return session.selectList(namespace+".bizOrdOutLeadTime", monitoringVo);
	}
	
	//불량률 현황 - 년/월별 전체 합계
	@Override
	public List<MonitoringVo> defectiveRateAdmLst(MonitoringVo monitoringVo) throws Exception {
		return session.selectList(namespace+".defectiveRateAdmLst", monitoringVo);
	}
	
	//불량률 현황 - 년도의 제품별 조회
	@Override
	public List<MonitoringVo> defectiveRateItemDtlLst(MonitoringVo monitoringVo) throws Exception {
		return session.selectList(namespace+".defectiveRateItemDtlLst", monitoringVo);
	}
	
	//생산공정진행현황
	@Override
	public List<MonitoringVo> prcssProgressStatusLst(MonitoringVo monitoringVo) throws Exception {
		return session.selectList(namespace+".prcssProgressStatusLst", monitoringVo);
	}
}
