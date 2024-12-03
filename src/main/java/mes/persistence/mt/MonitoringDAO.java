package mes.persistence.mt;

import java.util.List;

import mes.domain.mt.MonitoringVo;

public interface MonitoringDAO {

	// 수주생산진행현황
	public List<MonitoringVo> bizOrdWorkCurrentSituation(MonitoringVo monitoringVo) throws Exception;
	
	// 수주생산진행현황
	public List<MonitoringVo> bizOrdWorkPrcssCurrentSituation(MonitoringVo monitoringVo) throws Exception;

	// 수주출하리드타임
	public List<MonitoringVo> bizOrdOutLeadTime(MonitoringVo monitoringVo) throws Exception;

	//불량률 현황 - 년/월별 전체 합계
	public List<MonitoringVo> defectiveRateAdmLst(MonitoringVo monitoringVo) throws Exception;
	
	//불량률 현황 - 년도의 제품별 조회
	public List<MonitoringVo> defectiveRateItemDtlLst(MonitoringVo monitoringVo) throws Exception;
	
	//생산공정진행현황
	public List<MonitoringVo> prcssProgressStatusLst(MonitoringVo monitoringVo) throws Exception;
}
