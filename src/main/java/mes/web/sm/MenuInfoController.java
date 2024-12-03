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

import mes.domain.sm.MenuInfoVo;
import mes.domain.sm.MenuInfoVo;
import mes.service.sm.MenuInfoService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class MenuInfoController {
	
	private static final Logger logger = LoggerFactory.getLogger(MenuInfoController.class);
	
	@Inject
	private MenuInfoService menuInfoService;
	
	// 메뉴정보관리 페이지
	@RequestMapping(value = "/sm/smsc0040", method = RequestMethod.GET)
	public ModelAndView smsc0040(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : 메뉴정보관리 /sm/smsc0040");
		mav.setViewName("/sm/smsc0040");
		return mav;
	}
	
	// 메뉴정보관리 ADM 목록조회
	@RequestMapping(value = "sm/menuInfoAdmLst", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> menuInfoAdmLst(MenuInfoVo menuInfoVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("메뉴정보관리 ADM 목록조회");
		try {
			List<MenuInfoVo> menuInfoVoList = menuInfoService.menuInfoAdmLst(menuInfoVo);
			jsonData.put("data", menuInfoVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 메뉴정보관리 ADM 등록/수정
	@RequestMapping(value = "sm/menuInfoAdmIU", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> menuInfoAdmIU(@RequestParam(value="jsonArray", required=false) String jsonArray) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("메뉴정보관리 ADM 등록/수정");
		try {
			JSONParser jsonParser = new JSONParser();
			JSONArray dataArray = (JSONArray) jsonParser.parse(jsonArray);
			
			List<MenuInfoVo> menuInfoAddVoList = new ArrayList<>();
			String duplicationCheckIdxList = ""; // 중복체크하기 위한 IDX 목록
			
			JSONObject jsonObj = new JSONObject();
	        for(int i=0;i<dataArray.size();i++) {
	        	jsonObj.put(i, dataArray.get(i));
	    		JSONObject jsonObject = (JSONObject) jsonParser.parse(jsonObj.get(i).toString());
	    		
	    		MenuInfoVo menuInfoAddVo = new MenuInfoVo();
	    		menuInfoAddVo.setIdx(jsonObject.get("idx").toString());
	    		menuInfoAddVo.setMenuId(jsonObject.get("menuId").toString());
	    		menuInfoAddVo.setMenuNm(jsonObject.get("menuNm").toString());
	    		menuInfoAddVo.setMenuOrder(jsonObject.get("menuOrder").toString());
	    		menuInfoAddVo.setUseYn(jsonObject.get("useYn").toString());
	    		menuInfoAddVo.setUpdIdx(Utils.getUserIdx());
	    		menuInfoAddVo.setUpdDate(DateUtil.getCurrentDateTime());
	    		menuInfoAddVo.setRegIdx(Utils.getUserIdx());
	    		menuInfoAddVo.setRegDate(DateUtil.getCurrentDateTime());
	    		
	    		menuInfoAddVoList.add(menuInfoAddVo);
	    		
	    		duplicationCheckIdxList += jsonObject.get("idx").toString() + ",";
	        }
	        
	        for(int i=0;i<menuInfoAddVoList.size();i++) { // 중복확인 작업
	        	MenuInfoVo menuInfoDupCheckVo = new MenuInfoVo();
	        	menuInfoDupCheckVo.setIdx(duplicationCheckIdxList);
	        	menuInfoDupCheckVo.setMenuId(menuInfoAddVoList.get(i).getMenuId());
	        	if(menuInfoService.menuInfoAdmDupCheck(menuInfoDupCheckVo) != null) {
	        		jsonData.put("result", "fail");
	        		jsonData.put("idx", menuInfoAddVoList.get(i).getIdx());
	        		jsonData.put("message", "이미 존재하는 코드입니다.");
	        		return jsonData;
	        	}
	        }
	        
	        for(int i=0;i<menuInfoAddVoList.size();i++) {
	        	if(menuInfoAddVoList.get(i).getIdx().equals("")) { // 등록
	        		menuInfoService.menuInfoAdmIns(menuInfoAddVoList.get(i));
	        	} else { // 수정
	        		menuInfoService.menuInfoAdmUpd(menuInfoAddVoList.get(i));
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
	
	// 메뉴정보관리 ADM 삭제
	@RequestMapping(value = "sm/menuInfoAdmDel", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> menuInfoAdmDel(MenuInfoVo menuInfoVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("메뉴정보관리 ADM 삭제");
		try {
			menuInfoService.menuInfoAdmDel(menuInfoVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 메뉴정보관리 DTL 목록조회
	@RequestMapping(value = "sm/menuInfoDtlLst", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> menuInfoDtlLst(MenuInfoVo menuInfoVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("메뉴정보관리 DTL 목록조회");
		try {
			List<MenuInfoVo> menuInfoVoList = menuInfoService.menuInfoDtlLst(menuInfoVo);
			jsonData.put("data", menuInfoVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 메뉴정보관리 DTL 등록/수정
	@RequestMapping(value = "sm/menuInfoDtlIU", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> menuInfoDTLIU(@RequestParam(value="jsonArray", required=false) String jsonArray) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("메뉴정보관리 ADM DTL/수정");
		try {
			JSONParser jsonParser = new JSONParser();
			JSONArray dataArray = (JSONArray) jsonParser.parse(jsonArray);
			
			List<MenuInfoVo> menuInfoAddVoList = new ArrayList<>();
			String duplicationCheckIdxList = ""; // 중복체크하기 위한 IDX 목록
			
			JSONObject jsonObj = new JSONObject();
	        for(int i=0;i<dataArray.size();i++) {
	        	jsonObj.put(i, dataArray.get(i));
	    		JSONObject jsonObject = (JSONObject) jsonParser.parse(jsonObj.get(i).toString());
	    		
	    		MenuInfoVo menuInfoAddVo = new MenuInfoVo();
	    		menuInfoAddVo.setIdx(jsonObject.get("idx").toString());
	    		menuInfoAddVo.setMenuInfoAdmIdx(jsonObject.get("menuInfoAdmIdx").toString());
	    		menuInfoAddVo.setMenuId(jsonObject.get("menuId").toString());
	    		menuInfoAddVo.setMenuNm(jsonObject.get("menuNm").toString());
	    		menuInfoAddVo.setMenuOrder(jsonObject.get("menuOrder").toString());
	    		menuInfoAddVo.setMenuPath(jsonObject.get("menuPath").toString());
	    		menuInfoAddVo.setUseYn(jsonObject.get("useYn").toString());
	    		menuInfoAddVo.setEtc1(jsonObject.get("etc1").toString());
	    		menuInfoAddVo.setEtc2(jsonObject.get("etc2").toString());
	    		menuInfoAddVo.setEtc3(jsonObject.get("etc3").toString());
	    		menuInfoAddVo.setUpdIdx(Utils.getUserIdx());
	    		menuInfoAddVo.setUpdDate(DateUtil.getCurrentDateTime());
	    		menuInfoAddVo.setRegIdx(Utils.getUserIdx());
	    		menuInfoAddVo.setRegDate(DateUtil.getCurrentDateTime());
	    		
	    		menuInfoAddVoList.add(menuInfoAddVo);
	    		
	    		duplicationCheckIdxList += jsonObject.get("idx").toString() + ",";
	        }
	        
	        for(int i=0;i<menuInfoAddVoList.size();i++) { // 중복확인 작업
	        	MenuInfoVo menuInfoDupCheckVo = new MenuInfoVo();
	        	menuInfoDupCheckVo.setIdx(duplicationCheckIdxList);
	        	menuInfoDupCheckVo.setMenuInfoAdmIdx(menuInfoAddVoList.get(i).getMenuInfoAdmIdx());
	        	menuInfoDupCheckVo.setMenuId(menuInfoAddVoList.get(i).getMenuId());
	        	if(menuInfoService.menuInfoDtlDupCheck(menuInfoDupCheckVo) != null) {
	        		jsonData.put("result", "fail");
	        		jsonData.put("idx", menuInfoAddVoList.get(i).getIdx());
	        		jsonData.put("message", "이미 존재하는 코드입니다.");
	        		return jsonData;
	        	}
	        }
	        
	        for(int i=0;i<menuInfoAddVoList.size();i++) {
	        	if(menuInfoAddVoList.get(i).getIdx().equals("")) { // 등록
	        		menuInfoService.menuInfoDtlIns(menuInfoAddVoList.get(i));
	        	} else { // 수정
	        		menuInfoService.menuInfoDtlUpd(menuInfoAddVoList.get(i));
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
	
	// 메뉴정보관리 DTL 삭제
	@RequestMapping(value = "sm/menuInfoDtlDel", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> menuInfoDtlDel(MenuInfoVo menuInfoVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("메뉴정보관리 DTL 삭제");
		try {
			menuInfoService.menuInfoDtlDel(menuInfoVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
}
