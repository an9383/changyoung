package mes.persistence.wm;

import java.util.List;
import java.util.Map;

import mes.domain.wm.WorkOrderVo;
import mes.domain.wm.WorkResultStatusVo;

public interface WorkResultStatusDAO {

	//작업자별 - 일별실적현황 
	public List<Map<String,String>> dailyWorkResultLstByWorkId(WorkResultStatusVo workResultStatusVo) throws Exception;
	
}
