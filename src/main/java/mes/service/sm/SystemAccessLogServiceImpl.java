package mes.service.sm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.sm.SystemAccessLogVo;
import mes.persistence.sm.SystemAccessLogDAO;

@Service
public class SystemAccessLogServiceImpl implements SystemAccessLogService {

	@Inject
	private SystemAccessLogDAO dao;
	
	// 시스템 접속기록 목록조회
	@Override
	public List<SystemAccessLogVo> systemAccessLogLst(SystemAccessLogVo systemAccessLogVo) throws Exception {
		return dao.systemAccessLogLst(systemAccessLogVo);
	}
	
	// 시스템 접속기록 등록
	@Override
	public void systemAccessLogIns(SystemAccessLogVo systemAccessLogVo) throws Exception {
		dao.systemAccessLogIns(systemAccessLogVo);
	}
}
