package mes.persistence.wm;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.wm.WorkPlanVo;
import mes.domain.wm.WorkResultStatusVo;

@Repository
public class WorkResultStatusDAOImpl implements WorkResultStatusDAO {

	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.wm.workResultStatusMapper";

	//작업자별 - 일별실적현황 
	@Override
	public List<Map<String,String>> dailyWorkResultLstByWorkId(WorkResultStatusVo workResultStatusVo) throws Exception {
		return session.selectList(namespace+".dailyWorkResultLstByWorkId", workResultStatusVo);
	}
	
}
