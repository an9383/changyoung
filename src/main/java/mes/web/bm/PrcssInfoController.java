package mes.web.bm;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import mes.domain.bm.PrcssInfoVo;
import mes.service.bm.PrcssInfoService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
@RequestMapping("/")
public class PrcssInfoController {
	
	@Inject
	private PrcssInfoService prcssInfoService;
			
	private static final Logger logger = LoggerFactory.getLogger(PrcssInfoController.class);
	
	// bmsc0050
	@RequestMapping(value = "/bm/bmsc0050", method = RequestMethod.GET)
	public ModelAndView bmsc0050(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /bm/bmsc0050");
		mav.setViewName("/bm/bmsc0050");
		return mav;
	}
	
	//공정정보 목록조회
	@RequestMapping(value = "bm/prcssListAll", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> prcssListAll(PrcssInfoVo prcssInfoVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("공정정보 목록조회 : " + prcssInfoVo);
		try {
			List<PrcssInfoVo> prcssInfoVoList = prcssInfoService.prcssListAll(prcssInfoVo);
			jsonData.put("data", prcssInfoVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//공정정보 상세 목록조회
	@RequestMapping(value = "bm/prcssInfoSel", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> prcssInfoSel(PrcssInfoVo prcssInfoVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("공정정보 상세 목록조회 : " + prcssInfoVo);
		try {
			prcssInfoVo = prcssInfoService.prcssInfoSel(prcssInfoVo);
			jsonData.put("data", prcssInfoVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//공정정보 등록
	@RequestMapping(value = "bm/prcssInsert", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> prcssInsert(PrcssInfoVo prcssInfoVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("공정정보 등록");
		try {
			PrcssInfoVo checkVo = new PrcssInfoVo();
			checkVo = null;
			
			prcssInfoVo.setRegIdx(Utils.getUserIdx());
			prcssInfoVo.setRegDate(DateUtil.getCurrentDateTime());
			
			checkVo = prcssInfoService.prcssCdDupCheck(prcssInfoVo);
			if(checkVo == null) {
				prcssInfoService.prcssInsert(prcssInfoVo);
				jsonData.put("result", "ok");	
			} else {
				jsonData.put("message", "이미 등록되어있는 공정코드입니다.");
				jsonData.put("result", "fail");
			}

		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//공정정보 순서 수정
	@RequestMapping(value = "bm/prcssOrdUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> prcssOrdUpdate(PrcssInfoVo prcssInfoVo,
																@RequestParam(value="updateList") String updateList ) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("공정정보 순서 수정");
		try {
			prcssInfoVo.setUpdateList(updateList);
			prcssInfoVo.setUpdIdx(Utils.getUserIdx());
			prcssInfoVo.setUpdDate(DateUtil.getCurrentDateTime());
					
			prcssInfoService.prcssOrdUpdate(prcssInfoVo);	
			
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//공정정보 수정
	@RequestMapping(value = "bm/prcssUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> prcssUpdate(PrcssInfoVo prcssInfoVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("공정정보 수정");
		try {
			PrcssInfoVo checkVo = new PrcssInfoVo();
			checkVo = null;
			
			prcssInfoVo.setUpdIdx(Utils.getUserIdx());
			prcssInfoVo.setUpdDate(DateUtil.getCurrentDateTime());
			
			checkVo = prcssInfoService.prcssCdDupCheck(prcssInfoVo);
			if(checkVo == null) {
				prcssInfoService.prcssUpdate(prcssInfoVo);
				jsonData.put("result", "ok");	
			} else {
				jsonData.put("message", "이미 등록되어있는 공정코드입니다.");
				jsonData.put("result", "fail");
			}
	
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//공정정보 삭제
	@RequestMapping(value = "bm/prcssDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> prcssDelete(PrcssInfoVo prcssInfoVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("공정정보 삭제 : " + prcssInfoVo);
		try {
			prcssInfoService.prcssDelete(prcssInfoVo);
			jsonData.put("data", prcssInfoVo);
			
			if( "Y".equals(prcssInfoVo.getResultYn()) ) {
				jsonData.put("result", "ok");				
			} else {
				jsonData.put("result", "fail");
				jsonData.put("message", prcssInfoVo.getResultMessage());
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//공정작업자 목록조회
	@RequestMapping(value = "bm/prcssWorkerListAll", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> prcssWorkerListAll(PrcssInfoVo prcssInfoVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("공정정보 목록조회 : " + prcssInfoVo);
		try {
			List<PrcssInfoVo> prcssInfoVoList = prcssInfoService.prcssWorkerListAll(prcssInfoVo);
			jsonData.put("data", prcssInfoVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//공정작업자 저장
	@RequestMapping(value = "/bm/prcssWorkerInsert", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> prcssWorkerInsert(@RequestParam(value="jsonArray", required=false) String jsonArray,
																@RequestParam(value="prcssIdx", required=false) String prcssIdx) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("공정작업자 저장");
		try {
			PrcssInfoVo prcssInfoVo = new PrcssInfoVo();
			prcssInfoVo.setPrcssIdx(prcssIdx);
			prcssInfoVo.setInsertJson(jsonArray);	
			prcssInfoVo.setRegIdx(Utils.getUserIdx());
			prcssInfoVo.setRegDate(DateUtil.getCurrentDateTime());
			prcssInfoService.prcssWorkerDelete(prcssInfoVo);  	//공정작업자 삭제			
			prcssInfoService.prcssWorkerInsert(prcssInfoVo); //공정작업자 등록
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("공정작업자 저장 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
		
	}
	
	//설비 목록조회
	@RequestMapping(value = "bm/prcssEquipListAll", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> prcssEquipListAll(PrcssInfoVo prcssInfoVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("설비 목록조회 : " + prcssInfoVo);
		try {
			List<PrcssInfoVo> prcssInfoVoList = prcssInfoService.prcssEquipListAll(prcssInfoVo);
			jsonData.put("data", prcssInfoVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//설비 저장
	@RequestMapping(value = "/bm/prcssEquipInsert", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> prcssEquipInsert(@RequestParam(value="jsonArray", required=false) String jsonArray,
																@RequestParam(value="prcssIdx", required=false) String prcssIdx) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("설비 저장");
		try {
			PrcssInfoVo prcssInfoVo = new PrcssInfoVo();
			prcssInfoVo.setPrcssIdx(prcssIdx);
			prcssInfoVo.setInsertJson(jsonArray);	
			prcssInfoVo.setRegIdx(Utils.getUserIdx());
			prcssInfoVo.setRegDate(DateUtil.getCurrentDateTime());
			prcssInfoService.prcssEquipDelete(prcssInfoVo);  	//설비 삭제			
			prcssInfoService.prcssEquipInsert(prcssInfoVo); //설비 등록
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("설비 저장 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		return jsonData;
	}
	
	//작업방식 목록조회
	@RequestMapping(value = "bm/prcssWorkMethodListAll", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> prcssWorkMethodListAll(PrcssInfoVo prcssInfoVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("작업방식 목록조회 : " + prcssInfoVo);
		try {
			List<PrcssInfoVo> prcssInfoVoList = prcssInfoService.prcssWorkMethodListAll(prcssInfoVo);
			jsonData.put("data", prcssInfoVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//작업방식 저장
	@RequestMapping(value = "/bm/prcssWorkMethodInsert", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> prcssWorkMethodInsert(@RequestParam(value="jsonArray", required=false) String jsonArray,
																@RequestParam(value="prcssIdx", required=false) String prcssIdx) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("작업방식 저장");
		try {
			PrcssInfoVo prcssInfoVo = new PrcssInfoVo();
			prcssInfoVo.setPrcssIdx(prcssIdx);
			prcssInfoVo.setInsertJson(jsonArray);	
			prcssInfoVo.setRegIdx(Utils.getUserIdx());
			prcssInfoVo.setRegDate(DateUtil.getCurrentDateTime());
			prcssInfoService.prcssWorkMethodDelete(prcssInfoVo);  	//작업방식 삭제			
			prcssInfoService.prcssWorkMethodInsert(prcssInfoVo); //작업방식 등록
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("작업방식 저장 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		return jsonData;
	}
	
	//작업방식 삭제
	@RequestMapping(value = "bm/prcssWorkMethodDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> prcssWorkMethodDelete(PrcssInfoVo prcssInfoVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("작업방식 삭제 : " + prcssInfoVo);
		try {
			prcssInfoService.prcssWorkMethodDelete(prcssInfoVo);
			jsonData.put("data", prcssInfoVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//점검항목 목록조회
	@RequestMapping(value = "bm/prcssInspectionMethodListAll", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> prcssInspectionMethodListAll(PrcssInfoVo prcssInfoVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("점검항목 목록조회 : " + prcssInfoVo);
		try {
			List<PrcssInfoVo> prcssInfoVoList = prcssInfoService.prcssInspectionMethodListAll(prcssInfoVo);
			jsonData.put("data", prcssInfoVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//점검항목 저장
	@RequestMapping(value = "/bm/prcssInspectionMethodInsert", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> prcssInspectionMethodInsert(@RequestParam(value="jsonArray", required=false) String jsonArray,
																@RequestParam(value="prcssIdx", required=false) String prcssIdx) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("점검항목 저장");
		try {
			PrcssInfoVo prcssInfoVo = new PrcssInfoVo();
			prcssInfoVo.setPrcssIdx(prcssIdx);
			prcssInfoVo.setInsertJson(jsonArray);	
			prcssInfoVo.setRegIdx(Utils.getUserIdx());
			prcssInfoVo.setRegDate(DateUtil.getCurrentDateTime());		
			prcssInfoService.prcssInspectionMethodInsert(prcssInfoVo); //작업방식 등록
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("점검항목 저장 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		return jsonData;
	}
	
	//점검항목 삭제
	@RequestMapping(value = "bm/prcssInspectionMethodDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> prcssInspectionMethodDelete(PrcssInfoVo prcssInfoVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("점검항목 삭제 : " + prcssInfoVo);
		try {
			prcssInfoService.prcssInspectionMethodDelete(prcssInfoVo);
			jsonData.put("data", prcssInfoVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
}
