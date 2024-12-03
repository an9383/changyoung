package mes.web.sm;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import mes.domain.sm.CommonCodeVo;
import mes.service.sm.CommonCodeService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class CommonCodeController {
	
	@Inject
	private CommonCodeService commonCodeService;
	
	private static final Logger logger = LoggerFactory.getLogger(CommonCodeController.class);
	
	// 공통코드관리(시스템) 페이지
	@RequestMapping(value = "/sm/smsc0030", method = RequestMethod.GET)
	public ModelAndView smsc0030(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : 공통코드관리(시스템) /sm/smsc0030");
		mav.setViewName("/sm/smsc0030");
		return mav;
	}
	
	// 공통코드관리 ADM 목록조회
	@RequestMapping(value = "sm/commonCodeAdmLst", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> commonCodeAdmLst(CommonCodeVo commonCodeVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("공통코드관리 ADM 목록조회");
		try {
			List<CommonCodeVo> commonCodeVoList = commonCodeService.commonCodeAdmLst(commonCodeVo);
			jsonData.put("data", commonCodeVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 공통코드관리 ADM 등록/수정
	@RequestMapping(value = "sm/commonCodeAdmIU", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> commonCodeAdmIU(@RequestParam(value="jsonArray", required=false) String jsonArray) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("공통코드관리 ADM 등록/수정");
		try {
			JSONParser jsonParser = new JSONParser();
			JSONArray dataArray = (JSONArray) jsonParser.parse(jsonArray);
			
			List<CommonCodeVo> commonCodeAddVoList = new ArrayList<>();
			String duplicationCheckIdxList = ""; // 중복체크하기 위한 IDX 목록
			
			JSONObject jsonObj = new JSONObject();
	        for(int i=0;i<dataArray.size();i++) {
	        	jsonObj.put(i, dataArray.get(i));
	    		JSONObject jsonObject = (JSONObject) jsonParser.parse(jsonObj.get(i).toString());
	    		
	    		CommonCodeVo commonCodeAddVo = new CommonCodeVo();
	    		commonCodeAddVo.setIdx(jsonObject.get("idx").toString());
	    		commonCodeAddVo.setCommonType(jsonObject.get("commonType").toString());
	    		commonCodeAddVo.setCommonCd(jsonObject.get("commonCd").toString());
	    		commonCodeAddVo.setCommonNm(jsonObject.get("commonNm").toString());
	    		commonCodeAddVo.setUseYn(jsonObject.get("useYn").toString());
	    		commonCodeAddVo.setAttr(jsonObject.get("attr").toString());
	    		commonCodeAddVo.setCommonDesc(jsonObject.get("commonDesc").toString());
	    		commonCodeAddVo.setUpdIdx(Utils.getUserIdx());
	    		commonCodeAddVo.setUpdDate(DateUtil.getCurrentDateTime());
	    		commonCodeAddVo.setRegIdx(Utils.getUserIdx());
	    		commonCodeAddVo.setRegDate(DateUtil.getCurrentDateTime());
	    		
	    		commonCodeAddVoList.add(commonCodeAddVo);
	    		
	    		duplicationCheckIdxList += jsonObject.get("idx").toString() + ",";
	        }
	        
	        for(int i=0;i<commonCodeAddVoList.size();i++) { // 중복확인 작업
	        	CommonCodeVo commonCodeDupCheckVo = new CommonCodeVo();
	        	commonCodeDupCheckVo.setIdx(duplicationCheckIdxList);
	        	commonCodeDupCheckVo.setCommonType(commonCodeAddVoList.get(i).getCommonType());
	        	commonCodeDupCheckVo.setCommonCd(commonCodeAddVoList.get(i).getCommonCd());
	        	if(commonCodeService.commonCodeAdmDupCheck(commonCodeDupCheckVo) != null) {
	        		jsonData.put("result", "fail");
	        		jsonData.put("idx", commonCodeAddVoList.get(i).getIdx());
	        		jsonData.put("message", "이미 존재하는 코드입니다.");
	        		return jsonData;
	        	}
	        }
	        
	        for(int i=0;i<commonCodeAddVoList.size();i++) {
	        	if(commonCodeAddVoList.get(i).getIdx().equals("")) { // 등록
	        		commonCodeService.commonCodeAdmIns(commonCodeAddVoList.get(i));
	        	} else { // 수정
	        		commonCodeService.commonCodeAdmUpd(commonCodeAddVoList.get(i));
	        	}
	        }
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 공통코드관리 ADM 삭제
	@RequestMapping(value = "sm/commonCodeAdmDel", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> commonCodeAdmDel(CommonCodeVo commonCodeVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("공통코드관리 ADM 삭제");
		try {
			commonCodeService.commonCodeAdmDel(commonCodeVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 공통코드관리 DTL 목록조회
	@RequestMapping(value = "sm/commonCodeDtlLst", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> commonCodeDtlLst(CommonCodeVo commonCodeVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("공통코드관리 DTL 목록조회");
		try {
			List<CommonCodeVo> commonCodeVoList = commonCodeService.commonCodeDtlLst(commonCodeVo);
			jsonData.put("data", commonCodeVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 공통코드관리 DTL 등록/수정
	@RequestMapping(value = "sm/commonCodeDtlIU", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> commonCodeDTLIU(@RequestParam(value="jsonArray", required=false) String jsonArray) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("공통코드관리 ADM DTL/수정");
		try {
			JSONParser jsonParser = new JSONParser();
			JSONArray dataArray = (JSONArray) jsonParser.parse(jsonArray);
			
			List<CommonCodeVo> commonCodeAddVoList = new ArrayList<>();
			String duplicationCheckIdxList = ""; // 중복체크하기 위한 IDX 목록
			
			JSONObject jsonObj = new JSONObject();
	        for(int i=0;i<dataArray.size();i++) {
	        	jsonObj.put(i, dataArray.get(i));
	    		JSONObject jsonObject = (JSONObject) jsonParser.parse(jsonObj.get(i).toString());
	    		
	    		CommonCodeVo commonCodeAddVo = new CommonCodeVo();
	    		commonCodeAddVo.setIdx(jsonObject.get("idx").toString());
	    		commonCodeAddVo.setCommonCodeAdmIdx(jsonObject.get("commonCodeAdmIdx").toString());
	    		commonCodeAddVo.setCommonType(jsonObject.get("commonType").toString());
	    		commonCodeAddVo.setCommonCd(jsonObject.get("commonCd").toString());
	    		commonCodeAddVo.setCommonNm(jsonObject.get("commonNm").toString());
	    		commonCodeAddVo.setUseYn(jsonObject.get("useYn").toString());
	    		commonCodeAddVo.setAttr(jsonObject.get("attr").toString());
	    		commonCodeAddVo.setEtc1(jsonObject.get("etc1").toString());
	    		commonCodeAddVo.setEtc2(jsonObject.get("etc2").toString());
	    		commonCodeAddVo.setEtc3(jsonObject.get("etc3").toString());
	    		commonCodeAddVo.setCommonDesc(jsonObject.get("commonDesc").toString());
	    		commonCodeAddVo.setUpdIdx(Utils.getUserIdx());
	    		commonCodeAddVo.setUpdDate(DateUtil.getCurrentDateTime());
	    		commonCodeAddVo.setRegIdx(Utils.getUserIdx());
	    		commonCodeAddVo.setRegDate(DateUtil.getCurrentDateTime());
	    		
	    		commonCodeAddVoList.add(commonCodeAddVo);
	    		
	    		duplicationCheckIdxList += jsonObject.get("idx").toString() + ",";
	        }
	        
	        for(int i=0;i<commonCodeAddVoList.size();i++) { // 중복확인 작업
	        	CommonCodeVo commonCodeDupCheckVo = new CommonCodeVo();
	        	commonCodeDupCheckVo.setIdx(duplicationCheckIdxList);
	        	commonCodeDupCheckVo.setCommonType(commonCodeAddVoList.get(i).getCommonType());
	        	commonCodeDupCheckVo.setCommonCodeAdmIdx(commonCodeAddVoList.get(i).getCommonCodeAdmIdx());
	        	commonCodeDupCheckVo.setCommonCd(commonCodeAddVoList.get(i).getCommonCd());
	        	if(commonCodeService.commonCodeDtlDupCheck(commonCodeDupCheckVo) != null) {
	        		jsonData.put("result", "fail");
	        		jsonData.put("idx", commonCodeAddVoList.get(i).getIdx());
	        		jsonData.put("message", "이미 존재하는 코드입니다.");
	        		return jsonData;
	        	}
	        }
	        
	        for(int i=0;i<commonCodeAddVoList.size();i++) {
	        	if(commonCodeAddVoList.get(i).getIdx().equals("")) { // 등록
	        		commonCodeService.commonCodeDtlIns(commonCodeAddVoList.get(i));
	        	} else { // 수정
	        		commonCodeService.commonCodeDtlUpd(commonCodeAddVoList.get(i));
	        	}
	        }
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 공통코드관리 DTL 삭제
	@RequestMapping(value = "sm/commonCodeDtlDel", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> commonCodeDtlDel(CommonCodeVo commonCodeVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("공통코드관리 DTL 삭제");
		try {
			commonCodeService.commonCodeDtlDel(commonCodeVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 공통코드관리 DTL 공통코드별 목록조회
	@RequestMapping(value = "sm/commonCodeDtlLstByCommonCd", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> commonCodeDtlLstByCommonCd(CommonCodeVo commonCodeVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("공통코드관리 DTL 공통코드별 목록조회");
		try {
			List<CommonCodeVo> commonCodeVoList = commonCodeService.commonCodeDtlLstByCommonCd(commonCodeVo);
			logger.info(commonCodeVoList.toString());
			jsonData.put("data", commonCodeVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 공통코드관리 DTL 공통코드별 목록조회
	@RequestMapping(value = "sm/commonCodeDtlLstByCommonCdString", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> commonCodeDtlLstByCommonCdString(CommonCodeVo commonCodeVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("공통코드관리 DTL 공통코드별 목록조회");
		try {
			List<CommonCodeVo> commonCodeVoList = commonCodeService.commonCodeDtlLstByCommonCdString(commonCodeVo);
			logger.info(commonCodeVoList.toString());
			jsonData.put("data", commonCodeVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
}
