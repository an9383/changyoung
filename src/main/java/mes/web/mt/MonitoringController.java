package mes.web.mt;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import mes.domain.mt.MonitoringVo;
import mes.domain.sm.CommonCodeVo;
import mes.service.mt.MonitoringService;
import mes.service.sm.MenuAuthService;
import mes.web.ut.Utils;

@Controller
public class MonitoringController {
	
	private static final Logger logger = LoggerFactory.getLogger(MonitoringController.class);
	
	@Inject
	private MonitoringService monitoringService;
	
	// mtsc0010 페이지
	@RequestMapping(value = "/mt/mtsc0010", method = RequestMethod.GET)
	public ModelAndView mtsc0010(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /mt/mtsc0010");
		mav.setViewName("/mt/mtsc0010");
		return mav;
	}
	
	// mtsc0020 페이지
	@RequestMapping(value = "/mt/mtsc0020", method = RequestMethod.GET)
	public ModelAndView mtsc0020(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /mt/mtsc0020");
		mav.setViewName("/mt/mtsc0020");
		return mav;
	}
	
	// mtsc0030 페이지
	@RequestMapping(value = "/mt/mtsc0030", method = RequestMethod.GET)
	public ModelAndView mtsc0030(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /mt/mtsc0030");
		mav.setViewName("/mt/mtsc0030");
		return mav;
	}
	
	// mtsc0040 페이지
	@RequestMapping(value = "/mt/mtsc0040", method = RequestMethod.GET)
	public ModelAndView mtsc0040(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /mt/mtsc0040");
		mav.setViewName("/mt/mtsc0040");
		return mav;
	}
	
	// mtsc0040 페이지
	@RequestMapping(value = "/mt/mtsc0050", method = RequestMethod.GET)
	public ModelAndView mtsc0050(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /mt/mtsc0050");
		mav.setViewName("/mt/mtsc0050");
		return mav;
	}
	
	// 수주생산진행현황
	@RequestMapping(value = "mt/bizOrdWorkCurrentSituation", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrdWorkCurrentSituation(MonitoringVo monitoringVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주생산진행현황");
		try {
			List<MonitoringVo> monitoringVoist = monitoringService.bizOrdWorkCurrentSituation(monitoringVo);
			jsonData.put("data", monitoringVoist);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 수주생산진행현황
	@RequestMapping(value = "mt/bizOrdWorkPrcssCurrentSituation", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrdWorkPrcssCurrentSituation(MonitoringVo monitoringVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주생산진행현황");
		try {
			List<MonitoringVo> monitoringVoist = monitoringService.bizOrdWorkPrcssCurrentSituation(monitoringVo);
			jsonData.put("data", monitoringVoist);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	
	// 수주출하리드타임
	@RequestMapping(value = "mt/bizOrdOutLeadTime", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrdOutLeadTime(MonitoringVo monitoringVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주출하리드타임");
		try {
			List<MonitoringVo> monitoringVoist = monitoringService.bizOrdOutLeadTime(monitoringVo);
			jsonData.put("data", monitoringVoist);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}

	// 불량률 현황 - 년/월별 전체 합계
	@RequestMapping(value = "mt/defectiveRateAdmLst", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> defectiveRateAdmLst(MonitoringVo monitoringVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("불량률 현황 - 년/월별 전체 합계");
		try {
			List<MonitoringVo> monitoringVoist = monitoringService.defectiveRateAdmLst(monitoringVo);
			jsonData.put("data", monitoringVoist);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//불량률 현황 - 년도의 제품별 조회
	@RequestMapping(value = "mt/defectiveRateItemDtlLst", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> defectiveRateItemDtlLst(MonitoringVo monitoringVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("불량률 현황 - 년도의 제품별 조회");
		try {
			List<MonitoringVo> monitoringVoist = monitoringService.defectiveRateItemDtlLst(monitoringVo);
			jsonData.put("data", monitoringVoist);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}

	//생산공정진행현황
	@RequestMapping(value = "mt/prcssProgressStatusLst", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> prcssProgressStatusLst(MonitoringVo monitoringVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산공정진행현황 조회");
		try {
			List<MonitoringVo> monitoringVoist = monitoringService.prcssProgressStatusLst(monitoringVo);
			jsonData.put("data", monitoringVoist);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}


}
