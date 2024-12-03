package mes.persistence.sm;

import org.springframework.beans.factory.annotation.Autowired; import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.sm.BatchProcVo;

@Repository
public class BatchProcDAOImpl implements BatchProcDAO {

	@Autowired @Resource(name="sqlSession")
	private SqlSession session;
	
	private static String namespace="mes.mappers.sm.batchProcMapper";
	
	//일별 부품 재고정보 생성
	@Override
	public void batchTmData(BatchProcVo batchProcVo) throws Exception {
		session.update(namespace+".batchTmData", batchProcVo);
	}

	//배치 수행 결과 생성
	@Override
	public void batchProcLog(BatchProcVo batchProcVo) throws Exception {
		session.insert(namespace+".batchProcLog", batchProcVo);
	}
	

}
