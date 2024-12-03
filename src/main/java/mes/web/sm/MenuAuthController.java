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

import mes.domain.sm.MenuAuthVo;
import mes.domain.sm.MenuInfoVo;
import mes.service.sm.MenuAuthService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class MenuAuthController {
	
	private static final Logger logger = LoggerFactory.getLogger(MenuAuthController.class);
	
	@Inject
	private MenuAuthService menuAuthService;
	
	// 메뉴권한관리 페이지
	@RequestMapping(value = "/sm/smsc0050", method = RequestMethod.GET)
	public ModelAndView smsc0050(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : 메뉴정보관리 /sm/smsc0050");
		mav.setViewName("/sm/smsc0050");
		return mav;
	}
	
	// 메뉴권한관리 사용자별 목록조회
	@RequestMapping(value = "sm/menuAuthLstByUserIdx", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> menuAuthLstByUserIdx(MenuAuthVo menuAuthVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("메뉴정보관리 사용자별 목록조회");
		try {
			List<MenuAuthVo> menuAuthVoList = menuAuthService.menuAuthLstByUserIdx(menuAuthVo);
			jsonData.put("data", menuAuthVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 메뉴권한관리 등록/삭제
	@RequestMapping(value = "sm/menuAuthIns", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> menuAuthIns(@RequestParam(value="jsonArray", required=false) String jsonArray,
														@RequestParam(value="userIdx", required=false) String userIdx) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("메뉴권한관리 등록/삭제");
		try {
			MenuAuthVo menuAuthVo = new MenuAuthVo();
			menuAuthVo.setUserIdx(userIdx);
			menuAuthVo.setInsertList(jsonArray);
			menuAuthVo.setRegIdx(Utils.getUserIdx());
			menuAuthVo.setRegDate(DateUtil.getCurrentDateTime());
			menuAuthService.menuAuthDel(menuAuthVo);
			menuAuthService.menuAuthIns(menuAuthVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 메뉴권한관리 수정
	@RequestMapping(value = "sm/menuAuthUpd", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> menuAuthUpd(MenuAuthVo menuAuthVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("메뉴권한관리 수정");
		try {
			menuAuthVo.setUpdIdx(Utils.getUserIdx());
			menuAuthVo.setUpdDate(DateUtil.getCurrentDateTime());
			menuAuthService.menuAuthUpd(menuAuthVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 메뉴권한관리 복사
	@RequestMapping(value = "sm/menuAuthCopyNPaste", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> menuAuthCopyNPaste(MenuAuthVo menuAuthVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("메뉴권한관리 복사");
		try {
			menuAuthVo.setRegIdx(Utils.getUserIdx());
			menuAuthVo.setRegDate(DateUtil.getCurrentDateTime());
			menuAuthService.menuAuthCopyNPaste(menuAuthVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
}
