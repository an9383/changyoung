package mes.service.wm;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.wm.WorkPlanVo;
import mes.domain.wm.WorkResultStatusVo;
import mes.persistence.wm.WorkPlanDAO;
import mes.persistence.wm.WorkResultStatusDAO;

@Service
public class WorkResultStatusServiceImpl implements WorkResultStatusService {

	@Inject
	private WorkResultStatusDAO dao;
	
	//작업자별 - 일별실적현황 
	@Override
	public List<Map<String,String>> dailyWorkResultLstByWorkId(WorkResultStatusVo workResultStatusVo) throws Exception {
		return dao.dailyWorkResultLstByWorkId(workResultStatusVo);
	}
	
}
