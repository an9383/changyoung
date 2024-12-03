package mes.web.em;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import mes.domain.bm.ItemInfoAdmVo;
import mes.domain.em.EquipInfoVo;
import mes.service.em.EquipInfoService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
@RequestMapping("/")
public class EquipInfoController {
	
	@Inject
	private EquipInfoService equipInfoService;
	
	private static final Logger logger = LoggerFactory.getLogger(EquipInfoController.class);
	
	// emsc0010
	@RequestMapping(value = "/em/emsc0010", method = RequestMethod.GET)
	public ModelAndView emsc0010(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /em/emsc0010");
		mav.setViewName("/em/emsc0010");
		return mav;
	}
	
	// 설비코드 목록조회
	@RequestMapping(value = "em/equipInfoListAll", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> equipInfoListAll(EquipInfoVo equipInfoVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("설비코드 목록조회 : " + equipInfoVo);
		try {
			List<EquipInfoVo> EquipInfoVoList = equipInfoService.equipInfoListAll(equipInfoVo);
			jsonData.put("data", EquipInfoVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//설비 담당자 목록조회
	@RequestMapping(value = "em/equipUserInfoLst", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> equipUserInfoLst(EquipInfoVo equipInfoVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("설비 담당자 목록조회 : " + equipInfoVo);
		try {
			List<EquipInfoVo> EquipInfoVoList = equipInfoService.equipUserInfoLst(equipInfoVo);
			jsonData.put("data", EquipInfoVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//설비 담당자 등록
	@RequestMapping(value = "em/equipUserDelIns", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> equipUserDelIns(EquipInfoVo equipInfoVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("설비 담당자 등록 : " + equipInfoVo);
		try {
			equipInfoVo.setRegIdx(Utils.getUserIdx());
			equipInfoVo.setRegDate(DateUtil.getCurrentDateTime());
			equipInfoService.equipUserDelIns(equipInfoVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 공정설비 목록조회
	@RequestMapping(value = "em/prcssEquipInfoListAll", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> prcssEquipInfoListAll(EquipInfoVo equipInfoVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("공정설비 목록조회 : " + equipInfoVo);
		try {
			List<EquipInfoVo> EquipInfoVoList = equipInfoService.prcssEquipInfoListAll(equipInfoVo);
			jsonData.put("data", EquipInfoVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 설비코드 상세목록조회
	@RequestMapping(value = "em/equipInfoSel", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> equipInfoSel(EquipInfoVo equipInfoVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
	
		logger.info("설비코드 상세목록조회 : " + equipInfoVo);
		try {
			equipInfoVo = equipInfoService.equipInfoSel(equipInfoVo);
			jsonData.put("data", equipInfoVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 설비코드 등록
	@RequestMapping(value = "em/equipInfoInsert", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> equipInfoInsert(EquipInfoVo equipInfoVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("설비코드 등록");
		try {
			
			EquipInfoVo checkVo = new EquipInfoVo();
			checkVo = null;
			equipInfoVo.setRegIdx(Utils.getUserIdx());
			equipInfoVo.setRegDate(DateUtil.getCurrentDateTime());

			checkVo = equipInfoService.equipInfoDupCheck(equipInfoVo); //설비코드 중복체크
			
			if(checkVo == null) {
				equipInfoService.equipInfoInsert(equipInfoVo);
				jsonData.put("result", "ok");
			} else {
				jsonData.put("message", "이미 등록되어있는 설비코드입니다.");
				jsonData.put("result", "fail");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 설비코드 수정
	@RequestMapping(value = "em/equipInfoUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> equipInfoUpdate(EquipInfoVo equipInfoVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("설비코드 수정");
		try {
			EquipInfoVo checkVo = new EquipInfoVo();
			checkVo = null;
			equipInfoVo.setRegIdx(Utils.getUserIdx());
			equipInfoVo.setRegDate(DateUtil.getCurrentDateTime());
			equipInfoVo.setUpdIdx(Utils.getUserIdx());
			equipInfoVo.setUpdDate(DateUtil.getCurrentDateTime());
			
			checkVo = equipInfoService.equipInfoDupCheck(equipInfoVo); //설비코드 중복체크
			
			if(checkVo == null) {
				equipInfoService.equipInfoUpdate(equipInfoVo);
				jsonData.put("result", "ok");
			} else {
				jsonData.put("message", "이미 등록되어있는 설비코드입니다.");
				jsonData.put("result", "fail");
			}
	
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 설비코드  순번 수정
	@RequestMapping(value = "em/equipInfoOrdUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> equipInfoOrdUpdate(EquipInfoVo equipInfoVo,
																@RequestParam(value="updateList") String updateList ) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("설비코드 순번 수정");
		try {
			equipInfoVo.setUpdIdx(Utils.getUserIdx());
			equipInfoVo.setUpdDate(DateUtil.getCurrentDateTime());
			equipInfoVo.setUpdateList(updateList);
			equipInfoService.equipInfoOrdUpdate(equipInfoVo); //설비코드 중복체크
			
			jsonData.put("result", "ok");
	
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 설비코드 삭제
	@RequestMapping(value = "em/equipInfoDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> equipInfoDelete(EquipInfoVo equipInfoVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("설비코드 삭제");
		try {
			equipInfoService.equipInfoDelete(equipInfoVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}

	// 관련자료 목록조회
	@RequestMapping(value = "em/equipAttachDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> equipAttachDataList(EquipInfoVo equipInfoVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("관련자료 목록조회 : " + equipInfoVo);
		try {
			List<EquipInfoVo> EquipInfoVoList = equipInfoService.equipAttachDataList(equipInfoVo);
			jsonData.put("data", EquipInfoVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//설비정보관리 관련자료 등록
	@RequestMapping(value = "em/equipAttachDataInsert", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> equipAttachDataInsert(EquipInfoVo equipInfoVo,
														@RequestParam(value="fileString", required=false) String jsonArray) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("설비정보관리 관련자료 등록");
		try {
			JSONParser jsonParser = new JSONParser();
			JSONArray dataArray = (JSONArray) jsonParser.parse(jsonArray);
			JSONObject jsonObj = new JSONObject();
			
			equipInfoVo.setRegIdx(Utils.getUserIdx());
			equipInfoVo.setRegDate(DateUtil.getCurrentDateTime());
			//파일 업로드 DB 생성
			for(int i=0;i<dataArray.size();i++) {
				jsonObj.put(i, dataArray.get(i));
	    		JSONObject jsonObject = (JSONObject) jsonParser.parse(jsonObj.get(i).toString());
	    		equipInfoVo.setUuid(jsonObject.get("uuid").toString());
				equipInfoVo.setFileNm(jsonObject.get("fileNm").toString());
				equipInfoVo.setExt(jsonObject.get("ext").toString());
				equipInfoVo.setFileContents(jsonObject.get("fileContents").toString());
				equipInfoService.equipAttachDataInsert(equipInfoVo);
			}
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}

	//관련자료 삭제
	@RequestMapping(value = "em/equipAttachDataDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> equipAttachDataDelete(EquipInfoVo equipInfoVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("관련자료 삭제");
		try {
			equipInfoService.equipAttachDataDelete(equipInfoVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}

}

