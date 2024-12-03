package mes.web.wm;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.mindrot.jbcrypt.BCrypt;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import mes.domain.wm.WorkPlanVo;
import mes.service.wm.WorkPlanService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
@RequestMapping("/")
public class WorkPlanController {
	
	@Inject
	private WorkPlanService workPlanService;
	
	
	private static final Logger logger = LoggerFactory.getLogger(WorkPlanController.class);
	
	// wmsc0010
	@RequestMapping(value = "/wm/wmsc0010", method = RequestMethod.GET)
	public ModelAndView wmsc0010(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /wm/wmsc0010");
		mav.setViewName("/wm/wmsc0010");
		return mav;
	}
	
	//수주 목록 조회
	@RequestMapping(value = "wm/purchaseOrdLst", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> purchaseOrdLst(WorkPlanVo workPlanVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주 목록 조회");
		try {
			List<WorkPlanVo> workPlanVoList = workPlanService.purchaseOrdLst(workPlanVo);
			jsonData.put("data", workPlanVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//작업지시 목록 조회
	@RequestMapping(value = "wm/workOrdLst", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrdLst(WorkPlanVo workPlanVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("작업지시 목록 조회");
		try {
			List<WorkPlanVo> workPlanVoList = workPlanService.workOrdLst(workPlanVo);
			jsonData.put("data", workPlanVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//작업지시 등록
	@RequestMapping(value = "wm/workOrdIns", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrdIns(WorkPlanVo workPlanVo,
														@RequestParam(value="insertList", required=false) String insertList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("작업지시 등록");
		try {
			workPlanVo.setInsertList(insertList);
			workPlanVo.setRegIdx(Utils.getUserIdx());
			workPlanVo.setRegDate(DateUtil.getCurrentDateTime());
			workPlanService.workOrdIns(workPlanVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//작업지시 수정
	@RequestMapping(value = "wm/workOrdUpd", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrdUpd(WorkPlanVo workPlanVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("작업지시 수정");
		try {
			workPlanVo.setUpdIdx(Utils.getUserIdx());
			workPlanVo.setUpdDate(DateUtil.getCurrentDateTime());
			workPlanService.workOrdUpd(workPlanVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//작업지시 삭제
	@RequestMapping(value = "wm/workOrdDel", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrdDel(WorkPlanVo workPlanVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("작업지시 삭제");
		try {
			//*********나중에 생산 실적 나오면 생산실적이 있는지 확인하고 삭제하는 로직 적용 하기 ***************************
			workPlanService.workOrdDel(workPlanVo);
			if("Y".equals(workPlanVo.getResultYn())) {
				jsonData.put("result", "ok");
			} else {
				jsonData.put("result", "fail");
				jsonData.put("message", workPlanVo.getResMessage());
			}
			jsonData.put("data", workPlanVo);
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//생산 공정내역 목록 조회
	@RequestMapping(value = "wm/workOrdPrcssLst", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrdPrcssLst(WorkPlanVo workPlanVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산 공정내역 목록 조회");
		try {
			List<WorkPlanVo> workPlanVoList = workPlanService.workOrdPrcssLst(workPlanVo);
			jsonData.put("data", workPlanVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//생산 공정 등록
	@RequestMapping(value = "wm/workOrdPrcssIns", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrdPrcssIns(WorkPlanVo workPlanVo,
														@RequestParam(value="insertList", required=false) String insertList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산 공정 등록");
		try {
			workPlanVo.setInsertList(insertList);
			workPlanVo.setRegIdx(Utils.getUserIdx());
			workPlanVo.setRegDate(DateUtil.getCurrentDateTime());
			workPlanVo.setUpdIdx(Utils.getUserIdx());
			workPlanVo.setUpdDate(DateUtil.getCurrentDateTime());
			workPlanService.workOrdPrcssIns(workPlanVo);
			if("Y".equals(workPlanVo.getResultYn())) {
				jsonData.put("result", "ok");
			} else {
				jsonData.put("result", "fail");
				jsonData.put("message", workPlanVo.getResMessage());
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//생산 공정 수정
	@RequestMapping(value = "wm/workOrdPrcssUpd", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrdPrcssUpd(WorkPlanVo workPlanVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산 공정 수정");
		try {
			workPlanVo.setUpdIdx(Utils.getUserIdx());
			workPlanVo.setUpdDate(DateUtil.getCurrentDateTime());
			workPlanService.workOrdPrcssUpd(workPlanVo);
			jsonData.put("result", "ok");
			jsonData.put("data", workPlanVo);
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//생산 공정 다중 수정(todayWorkYn)
	@RequestMapping(value = "wm/workOrdPrcssTodayWorkYnUpd", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrdPrcssTodayWorkYnUpd(WorkPlanVo workPlanVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산 공정 다중 수정(todayWorkYn)");
		try {
			workPlanVo.setUpdIdx(Utils.getUserIdx());
			workPlanVo.setUpdDate(DateUtil.getCurrentDateTime());
			
			if(workPlanVo.getTodayWorkYn().equals("Y")) {
				WorkPlanVo addVo = new WorkPlanVo();
				addVo.setDwCharger(Utils.getUserIdx());
				addVo.setDwDate(workPlanVo.getDwDate());
				addVo.setDwStatus("O");
				addVo.setRegIdx(Utils.getUserIdx());
				addVo.setRegDate(DateUtil.getCurrentDateTime());
				addVo.setIdx(workPlanVo.getIdx());
				workPlanService.workOrdPrcssDailyWorkIns(addVo);
				
			} else {
				WorkPlanVo updVo = new WorkPlanVo();
				updVo.setDwCharger(Utils.getUserIdx());
				updVo.setDwStatus("X");
				updVo.setDwDate(workPlanVo.getDwDate());
				updVo.setUpdIdx(Utils.getUserIdx());
				updVo.setUpdDate(DateUtil.getCurrentDateTime());
				updVo.setIdx(workPlanVo.getIdx());
				workPlanService.workOrdPrcssDailyWorkUpd(updVo);

			}
			workPlanService.workOrdPrcssTodayWorkYnUpd(workPlanVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//생산 공정 삭제
	@RequestMapping(value = "wm/workOrdPrcssDel", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrdPrcssDel(WorkPlanVo workPlanVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산 공정 삭제");
		try {
			workPlanService.workOrdPrcssDel(workPlanVo);
			if("Y".equals(workPlanVo.getResultYn())) {
				jsonData.put("result", "ok");
			} else {
				jsonData.put("result", "fail");
				jsonData.put("message", workPlanVo.getResMessage());
			}
			jsonData.put("data", workPlanVo);
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//투입자재 내역 목록 조회
	@RequestMapping(value = "wm/workOrdInputMaterialLst", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrdInputMaterialLst(WorkPlanVo workPlanVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("투입자재 내역 목록 조회");
		try {
			List<WorkPlanVo> workPlanVoList = workPlanService.workOrdInputMaterialLst(workPlanVo);
			jsonData.put("data", workPlanVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
}
