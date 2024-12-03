package mes.web.sm;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.mindrot.jbcrypt.BCrypt;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import mes.domain.sm.SystemAccessLogVo;
import mes.domain.sm.UserVo;
import mes.service.sm.SystemAccessLogService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class SystemAccessLogController {
	
	@Inject
	private SystemAccessLogService systemAccessLogService;
	
	private static final Logger logger = LoggerFactory.getLogger(SystemAccessLogController.class);
	
	// 시스템 접속기록 페이지
	@RequestMapping(value = "/sm/smsc0060", method = RequestMethod.GET)
	public ModelAndView smsc0060(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : 시스템 접속기록 /sm/smsc0060");
		mav.setViewName("/sm/smsc0060");
		return mav;
	}
	
	// 시스템 접속기록 목록조회
	@RequestMapping(value = "sm/systemAccessLogLst", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> systemAccessLogLst(SystemAccessLogVo systemAccessLogVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("시스템 접속기록 목록조회");
		try {
			List<SystemAccessLogVo> SystemAccessLogVoList = systemAccessLogService.systemAccessLogLst(systemAccessLogVo);
			jsonData.put("data", SystemAccessLogVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
}
