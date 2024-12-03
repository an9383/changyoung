package mes.service.wm;

import java.util.List;
import java.util.Map;

import mes.domain.wm.WorkPlanVo;
import mes.domain.wm.WorkResultStatusVo;

public interface WorkResultStatusService {
	
	//작업자별 - 일별실적현황 
	public List<Map<String,String>> dailyWorkResultLstByWorkId(WorkResultStatusVo workResultStatusVo) throws Exception;
	
}
