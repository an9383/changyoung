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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import mes.domain.bm.SpotToningVo;
import mes.service.bm.SpotToningService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
@RequestMapping("/")
public class SpotToningController {
	
	@Inject
	private SpotToningService spotToningService;
	
	private static final Logger logger = LoggerFactory.getLogger(SpotToningController.class);
	
	// bmsc0060
	@RequestMapping(value = "/bm/bmsc0100", method = RequestMethod.GET)
	public ModelAndView bmsc0060(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /bm/bmsc0100");
		mav.setViewName("/bm/bmsc0100");
		return mav;
	}
	
	//조색별색관리 목록조회
	@RequestMapping(value = "bm/spotToningList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> spotToningList(SpotToningVo spotToningVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("조색별색관리 목록조회 : " + spotToningVo);
		try {
			List<SpotToningVo> spotToningVoList = spotToningService.spotToningList(spotToningVo);
			jsonData.put("data", spotToningVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//조색별색관리 상세조회
	@RequestMapping(value = "bm/spotToningSel", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> spotToningSel(SpotToningVo spotToningVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("조색별색관리 상세조회 : " + spotToningVo);
		try {
			SpotToningVo selectVo = spotToningService.spotToningSel(spotToningVo);
			jsonData.put("data", selectVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//조색별색관리 등록
	@RequestMapping(value = "bm/spotToningInsert", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> spotToningInsert(SpotToningVo spotToningVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("조색별색관리 등록");
		try {
			SpotToningVo checkVo = new SpotToningVo();
			checkVo = null;
			
			spotToningVo.setRegIdx(Utils.getUserIdx());
			spotToningVo.setRegDate(DateUtil.getCurrentDateTime());
			
			checkVo = spotToningService.colorCdDupCheck(spotToningVo);
			if(checkVo == null) {
				spotToningService.spotToningInsert(spotToningVo);
				jsonData.put("result", "ok");	
			} else {
				jsonData.put("message", "이미 등록되어있는 색상코드입니다.");
				jsonData.put("result", "fail");
			}

		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//조색별색관리 수정
	@RequestMapping(value = "bm/spotToningUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> spotToningUpdate(SpotToningVo spotToningVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("조색별색관리 수정");
		try {
			SpotToningVo checkVo = new SpotToningVo();
			checkVo = null;
			
			spotToningVo.setUpdIdx(Utils.getUserIdx());
			spotToningVo.setUpdDate(DateUtil.getCurrentDateTime());
			
			checkVo = spotToningService.colorCdDupCheck(spotToningVo);
			if(checkVo == null && !"자동채번".equals(spotToningVo.getColorCode())) {
				spotToningService.spotToningUpdate(spotToningVo);
				jsonData.put("result", "ok");	
			} else if("자동채번".equals(spotToningVo.getColorCode())){
				jsonData.put("message", "수정의 경우 자동채번 기능을 사용할 수 없습니다.");
				jsonData.put("result", "fail");
			} else {
				jsonData.put("message", "이미 등록되어있는 색상코드입니다.");
				jsonData.put("result", "fail");
			}

		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//조색별색관리 순번 수정
	@RequestMapping(value = "bm/spotToningOrderUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> spotToningOrderUpdate(SpotToningVo spotToningVo,
																@RequestParam(value="updateList") String updateList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("조색별색관리 순번 수정");
		try {
			spotToningVo.setUpdateList(updateList);
			spotToningVo.setUpdIdx(Utils.getUserIdx());
			spotToningVo.setUpdDate(DateUtil.getCurrentDateTime());
			spotToningService.spotToningOrderUpdate(spotToningVo);
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//조색별색관리 삭제
	@RequestMapping(value = "bm/spotToningDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> spotToningDelete(SpotToningVo spotToningVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("조색별색관리 삭제");
		try {
			spotToningService.spotToningDelete(spotToningVo);
			jsonData.put("data", spotToningVo);
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	//창고정보 목록조회
	/*@RequestMapping(value = "bm/locationAdmList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> prcssListAll(LocationVo locationVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("창고정보 목록조회 : " + locationVo);
		try {
			List<LocationVo> prcssInfoVoList = locationService.locationAdmList(locationVo);
			jsonData.put("data", prcssInfoVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 창고정보 ADM 등록/수정
	@RequestMapping(value = "bm/locationAdmIU", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> locationAdmIU(@RequestParam(value="jsonArray", required=false) String jsonArray) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("공통코드관리 ADM DTL/수정");
		try {
			JSONParser jsonParser = new JSONParser();
			JSONArray dataArray = (JSONArray) jsonParser.parse(jsonArray);
			
			List<LocationVo> locationVoList = new ArrayList<>();
			String duplicationCheckIdxList = ""; // 중복체크하기 위한 IDX 목록
			
			JSONObject jsonObj = new JSONObject();
	        for(int i=0;i<dataArray.size();i++) {
	        	jsonObj.put(i, dataArray.get(i));
	    		JSONObject jsonObject = (JSONObject) jsonParser.parse(jsonObj.get(i).toString());
	    		
	    		LocationVo locationVo = new LocationVo();
	    		locationVo.setIdx(jsonObject.get("idx").toString());
	    		locationVo.setLcCd(jsonObject.get("lcCd").toString());
	    		locationVo.setLcNm(jsonObject.get("lcNm").toString());
	    		locationVo.setLcTypeOutput(jsonObject.get("lcTypeOutput").toString());
	    		locationVo.setLcTypeInput(jsonObject.get("lcTypeInput").toString());
	    		locationVo.setLcTypeReturn(jsonObject.get("lcTypeReturn").toString());
	    		
	    		locationVo.setLcTypeQc(jsonObject.get("lcTypeQc").toString());
	    		locationVo.setLcTypeOutsourcing(jsonObject.get("lcTypeOutsourcing").toString());
	    		locationVo.setLcOutsourcing(jsonObject.get("lcOutsourcing").toString());
	    		locationVo.setLcQualityGubun(jsonObject.get("lcQualityGubun").toString());
	    		locationVo.setItemGubun(jsonObject.get("itemGubun").toString());
	    		
	    		locationVo.setUseYn(jsonObject.get("useYn").toString());
	    		locationVo.setLcEndDate(jsonObject.get("lcEndDate").toString());
	    		locationVo.setLcNote(jsonObject.get("lcNote").toString());
	    		locationVo.setRegIdx(Utils.getUserIdx());
	    		locationVo.setRegDate(DateUtil.getCurrentDateTime());
	    		locationVo.setUpdIdx(Utils.getUserIdx());
	    		locationVo.setUpdDate(DateUtil.getCurrentDateTime());
	    		
	    		locationVoList.add(locationVo);
	    		duplicationCheckIdxList += jsonObject.get("idx").toString() + ",";
	        }
	        
	        for(int i=0;i<locationVoList.size();i++) { // 중복확인 작업
	        	LocationVo locationCheckVo = new LocationVo();
	        	locationCheckVo.setIdx(duplicationCheckIdxList);
	        	locationCheckVo.setLcCd(locationVoList.get(i).getLcCd());
	        	if(locationService.lcCdDupCheck(locationCheckVo) != null) {
	        		jsonData.put("result", "fail");
	        		jsonData.put("idx", locationVoList.get(i).getIdx());
	        		jsonData.put("message", "이미 존재하는 코드입니다.");
	        		return jsonData;
	        	}
	        }
	        
	        for(int i=0;i<locationVoList.size();i++) {
	        	if(locationVoList.get(i).getIdx().equals("")) { // 등록
	        		locationService.locationAdmInsert(locationVoList.get(i));
	        	} else { // 수정
	        		locationService.locationAdmUpdate(locationVoList.get(i));
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
	
	//창고정보 등록
	@RequestMapping(value = "bm/locationAdmInsert", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> locationAdmInsert(LocationVo locationVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("창고정보 등록");
		try {
			LocationVo checkVo = new LocationVo();
			checkVo = null;
			
			locationVo.setRegIdx(Utils.getUserIdx());
			locationVo.setRegDate(DateUtil.getCurrentDateTime());
			
			checkVo = locationService.lcCdDupCheck(locationVo);
			if(checkVo == null) {
				locationService.locationAdmInsert(locationVo);
				jsonData.put("result", "ok");	
			} else {
				jsonData.put("message", "이미 등록되어있는 창고코드입니다.");
				jsonData.put("result", "fail");
			}

		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//창고정보 수정
	@RequestMapping(value = "bm/locationAdmUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> prcssUpdate(LocationVo locationVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("창고정보 수정");
		try {
			LocationVo checkVo = new LocationVo();
			checkVo = null;
			
			locationVo.setUpdIdx(Utils.getUserIdx());
			locationVo.setUpdDate(DateUtil.getCurrentDateTime());
			
			checkVo = locationService.lcCdDupCheck(locationVo);
			if(checkVo == null) {
				locationService.locationAdmUpdate(locationVo);
				jsonData.put("result", "ok");	
			} else {
				jsonData.put("message", "이미 등록되어있는 창고코드입니다.");
				jsonData.put("result", "fail");
			}
	
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//창고정보 상세 목록조회
	@RequestMapping(value = "bm/locationDtlList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> locationDtlList(LocationVo locationVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("창고정보 상세 목록조회 : " + locationVo);
		try {
			List<LocationVo> prcssInfoVoList = locationService.locationDtlList(locationVo);
			jsonData.put("data", prcssInfoVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 창고정보 ADM 등록/수정
	@RequestMapping(value = "bm/locationDtlIU", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> locationDtlIU(@RequestParam(value="jsonArray", required=false) String jsonArray) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("공통코드관리 ADM DTL/수정");
		try {
			JSONParser jsonParser = new JSONParser();
			JSONArray dataArray = (JSONArray) jsonParser.parse(jsonArray);
			
			List<LocationVo> locationVoList = new ArrayList<>();
			String duplicationCheckIdxList = ""; // 중복체크하기 위한 IDX 목록
			
			JSONObject jsonObj = new JSONObject();
	        for(int i=0;i<dataArray.size();i++) {
	        	jsonObj.put(i, dataArray.get(i));
	    		JSONObject jsonObject = (JSONObject) jsonParser.parse(jsonObj.get(i).toString());
	    		
	    		LocationVo locationVo = new LocationVo();
	    		locationVo.setIdx(jsonObject.get("idx").toString());
	    		locationVo.setLcAdmIdx(jsonObject.get("lcAdmIdx").toString());
	    		locationVo.setLcDtlNm(jsonObject.get("lcDtlNm").toString());
	    		locationVo.setLcDtlX(jsonObject.get("lcDtlX").toString());
	    		locationVo.setLcDtlY(jsonObject.get("lcDtlY").toString());
	    		locationVo.setUseYn(jsonObject.get("useYn").toString());
	    		locationVo.setLcDtlDesc(jsonObject.get("lcDtlDesc").toString());
	    		locationVo.setRegIdx(Utils.getUserIdx());
	    		locationVo.setRegDate(DateUtil.getCurrentDateTime());
	    		locationVo.setUpdIdx(Utils.getUserIdx());
	    		locationVo.setUpdDate(DateUtil.getCurrentDateTime());
	    		
	    		locationVoList.add(locationVo);
	    		duplicationCheckIdxList += jsonObject.get("idx").toString() + ",";
	        }
	        for(int i=0;i<locationVoList.size();i++) {
	        	if(locationVoList.get(i).getIdx().equals("")) { // 등록
	        		locationService.locationDtlInsert(locationVoList.get(i));
	        	} else { // 수정
	        		locationService.locationDtlUpdate(locationVoList.get(i));
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
	
	//창고정보 상세 등록
	@RequestMapping(value = "bm/locationDtlInsert", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> locationDtlInsert(LocationVo locationVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("창고정보 상세 등록");
		try {
			locationVo.setRegIdx(Utils.getUserIdx());
			locationVo.setRegDate(DateUtil.getCurrentDateTime());
			locationService.locationDtlInsert(locationVo);
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//창고정보 상세 수정
	@RequestMapping(value = "bm/locationDtlUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> locationDtlUpdate(LocationVo locationVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("창고정보 상세 수정");
		try {
			locationVo.setUpdIdx(Utils.getUserIdx());
			locationVo.setUpdDate(DateUtil.getCurrentDateTime());
			locationService.locationDtlUpdate(locationVo);
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//창고정보 상세 삭제
	@RequestMapping(value = "bm/locationDtlDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> locationDtlDelete(LocationVo locationVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("창고정보 상세 삭제 : " + locationVo);
		try {
			locationService.locationDtlDelete(locationVo);
			jsonData.put("data", locationVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}*/
}
