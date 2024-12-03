package mes.service.sm;

import java.util.List;

import mes.domain.sm.SystemAccessLogVo;

public interface SystemAccessLogService {
	
	// 시스템 접속기록 목록조회
	public List<SystemAccessLogVo> systemAccessLogLst(SystemAccessLogVo systemAccessLogVo) throws Exception;
	
	// 시스템 접속기록 등록
	public void systemAccessLogIns(SystemAccessLogVo systemAccessLogVo) throws Exception;
}
