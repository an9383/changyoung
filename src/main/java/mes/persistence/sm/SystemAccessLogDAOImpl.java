package mes.persistence.sm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.sm.SystemAccessLogVo;

@Repository
public class SystemAccessLogDAOImpl implements SystemAccessLogDAO {

	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.sm.systemAccessLogMapper";
	
	// 시스템 접속기록 목록조회
	@Override
	public List<SystemAccessLogVo> systemAccessLogLst(SystemAccessLogVo systemAccessLogVo) throws Exception {
		return session.selectList(namespace+".systemAccessLogLst", systemAccessLogVo);
	}
	
	// 시스템 접속기록 등록
	@Override
	public void systemAccessLogIns(SystemAccessLogVo systemAccessLogVo) throws Exception {
		session.insert(namespace+".systemAccessLogIns", systemAccessLogVo);
	}
}
