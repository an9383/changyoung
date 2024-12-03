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

import mes.domain.bm.DealCorpAdmVo;
import mes.domain.sm.WorkplaceVo;
import mes.service.sm.WorkplaceService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class WorkplaceController {
	
	@Inject
	private WorkplaceService workplaceService;
	
	private static final Logger logger = LoggerFactory.getLogger(WorkplaceController.class);
	
	// 사업장관리 페이지
	@RequestMapping(value = "/sm/smsc0010", method = RequestMethod.GET)
	public ModelAndView smsc0020(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : 사업관리 /sm/smsc0010");
		mav.setViewName("/sm/smsc0010");
		return mav;
	}
	
	// 사업장정보 목록조회
	@RequestMapping(value = "sm/workplaceLst", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workplaceLst(WorkplaceVo workplaceVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("사업장정보 목록조회");
		try {
			List<WorkplaceVo> workplaceVoList = workplaceService.workplaceLst(workplaceVo);
			jsonData.put("data", workplaceVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 사업장정보 상세조회
	@RequestMapping(value = "sm/workplaceSel", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workplaceSel(WorkplaceVo workplaceVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("사업장정보 상세조회");
		try {
			workplaceVo = workplaceService.workplaceSel(workplaceVo);
			jsonData.put("data", workplaceVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 사업장정보 등록
	@RequestMapping(value = "sm/workplaceIns", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workplaceIns(WorkplaceVo workplaceVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("사업장정보 등록");
		try {
			WorkplaceVo checkVo = new WorkplaceVo();
			checkVo = null;
			checkVo = workplaceService.workplaceIdDupCheck(workplaceVo);
			if( checkVo == null) {
				workplaceVo.setRegIdx(Utils.getUserIdx());
				workplaceVo.setRegDate(DateUtil.getCurrentDateTime());
				workplaceService.workplaceIns(workplaceVo);
				jsonData.put("result", "ok");
			} else {
				jsonData.put("message", "이미 등록되어있는 사업장코드입니다.");
				jsonData.put("result", "fail");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 사업장정보 수정
	@RequestMapping(value = "sm/workplaceUpd", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workplaceUpd(WorkplaceVo workplaceVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("사업장정보 수정");
		try {
			WorkplaceVo checkVo = new WorkplaceVo();
			checkVo = null;
			checkVo = workplaceService.workplaceIdDupCheck(workplaceVo);
			if( checkVo == null) {
				workplaceVo.setUpdIdx(Utils.getUserIdx());
				workplaceVo.setUpdDate(DateUtil.getCurrentDateTime());
				workplaceService.workplaceUpd(workplaceVo);
				jsonData.put("result", "ok");
			} else {
				jsonData.put("message", "이미 등록되어있는 사업장코드입니다.");
				jsonData.put("result", "fail");
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
}
