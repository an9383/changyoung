package mes.service.mt;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.mt.MonitoringVo;
import mes.persistence.mt.MonitoringDAO;

@Service
public class MonitoringServiceImpl implements MonitoringService {

	@Inject
	private MonitoringDAO dao;
	
	// 수주생산진행현황
	@Override
	public List<MonitoringVo> bizOrdWorkCurrentSituation(MonitoringVo monitoringVo) throws Exception {
		return dao.bizOrdWorkCurrentSituation(monitoringVo);
	}
	
	// 수주생산진행현황
	public List<MonitoringVo> bizOrdWorkPrcssCurrentSituation(MonitoringVo monitoringVo) throws Exception{
		return dao.bizOrdWorkPrcssCurrentSituation(monitoringVo);
	}
	
	// 수주출하리드타임
	@Override
	public List<MonitoringVo> bizOrdOutLeadTime(MonitoringVo monitoringVo) throws Exception {
		return dao.bizOrdOutLeadTime(monitoringVo);
	}
	
	// 불량률 현황 - 년/월별 전체 합계
	@Override
	public List<MonitoringVo> defectiveRateAdmLst(MonitoringVo monitoringVo) throws Exception {
		return dao.defectiveRateAdmLst(monitoringVo);
	}
	
	//불량률 현황 - 년도의 제품별 조회
	@Override
	public List<MonitoringVo> defectiveRateItemDtlLst(MonitoringVo monitoringVo) throws Exception {
		return dao.defectiveRateItemDtlLst(monitoringVo);
	}
	
	//생산공정진행현황
	@Override
	public List<MonitoringVo> prcssProgressStatusLst(MonitoringVo monitoringVo) throws Exception {
		return dao.prcssProgressStatusLst(monitoringVo);
	}
}
