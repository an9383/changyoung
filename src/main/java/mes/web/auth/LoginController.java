package mes.web.auth;

import java.net.Inet4Address;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import mes.domain.sm.MenuAuthVo;
import mes.domain.sm.SystemAccessLogVo;
import mes.domain.sm.UserVo;
import mes.service.sm.MenuAuthService;
import mes.service.sm.SystemAccessLogService;
import mes.service.sm.UserService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
@RequestMapping("/")
public class LoginController {
	
	@Inject
	private UserService userService;
	@Inject
	private MenuAuthService menuAuthService;
	@Inject
	private SystemAccessLogService systemAccessLogService;
	
	
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

	// 세션 검사
	public static boolean isValidSession(HttpServletRequest request) {
		if (request.getSession().getAttribute(Constants.USER_IDX) != null) { // 세션이 있을 경우
			return true;
		} else { // 세션이 없을 경우
			return false;
		}
	}
	
	// 로그인 화면
	@RequestMapping(value = "/auth/login", method = RequestMethod.GET)
	public ModelAndView login(ModelAndView mav, HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("로그인 화면 이동");
		try {
			if(isValidSession(request)) { // 세션이 있을 경우
				logger.info("세션 O");
				mav.setViewName("redirect:/dashboard/main");
			} else { // 세션이 없을 경우
				logger.info("세션 X");
				mav.setViewName("/auth/login");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	// 로그인 처리
	@RequestMapping(value = "/auth/login", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> loginAjaxPOST(HttpServletRequest request, HttpServletResponse response, UserVo userVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("로그인 처리");
		try {
			UserVo userReadVo = userService.userSel(userVo); // 조회한 사용자정보
			if(userReadVo != null) { // 존재하는 사용자일 경우
				if(BCrypt.checkpw(userVo.getUserPw(), userReadVo.getUserPw())) { // 암호가 일치할 경우
					
					// 정규식 확인 -> (문자, 특수문자, 숫자 3가지 포함 8~50자리 입력)
					String pattern = "^(?=.*\\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).{8,20}$"; // 정규식 패턴

			        Pattern p = Pattern.compile(pattern);
			        Matcher m = p.matcher(userVo.getUserPw());
			       // if (m.matches()) {
						MenuAuthVo menuAuthVo = new MenuAuthVo();
						menuAuthVo.setUserIdx(userReadVo.getIdx());
						List<MenuAuthVo> menuAuthVoList = menuAuthService.menuAuthLstForMenuList(menuAuthVo);
						String[] menuPathList = new String[menuAuthVoList.size()];
						
						for(int i=0;i<menuAuthVoList.size();i++) {
							menuPathList[i] = "/" + menuAuthVoList.get(i).getMenuPath();
						}
						
						HttpSession session = request.getSession(true);
						session.setAttribute(Constants.USER_IDX, userReadVo.getIdx());
						session.setAttribute(Constants.USER_NM, userReadVo.getUserName());
						session.setAttribute(Constants.USER_ID, userReadVo.getUserId());
						session.setAttribute(Constants.USER_POSITION_NM, userReadVo.getUserPositionNm());
						session.setAttribute(Constants.USER_DEPARTMENT_NM, userReadVo.getUserDepartmentNm());
						session.setAttribute(Constants.MENU_AUTH, menuAuthVoList);
						session.setAttribute(Constants.MENU_PATH_LIST, menuPathList);
						
						SystemAccessLogVo systemAccessLogVo = new SystemAccessLogVo();
						systemAccessLogVo.setUserIdx(userReadVo.getIdx());
						systemAccessLogVo.setUserId(userReadVo.getUserId());
						systemAccessLogVo.setUserNm(userReadVo.getUserName());
						systemAccessLogVo.setUserPositionNm(userReadVo.getUserPositionNm());
						systemAccessLogVo.setUserDepartmentNm(userReadVo.getUserDepartmentNm());
						systemAccessLogVo.setAccessUrl("/auth/login");
						systemAccessLogVo.setAccessIp(Utils.getIp(request));
						systemAccessLogVo.setAccessDate(DateUtil.getCurrentDateTime());
						systemAccessLogService.systemAccessLogIns(systemAccessLogVo); // 시스템 접속기록
						
						jsonData.put("result", "ok");
			        //} else {
			        //	jsonData.put("result", "fail");
					//	jsonData.put("message", "비밀번호는 문자, 특수문자, 숫자 3가지 포함 8~20자리 입력해야합니다.");
			        //}
				} else {
					jsonData.put("result", "fail");
					jsonData.put("message", "아이디/비밀번호를 확인해주세요.");
				}
			} else { // 존재하지 않는 사용자일 경우
				jsonData.put("result", "fail");
				jsonData.put("message", "아이디/비밀번호를 확인해주세요.");
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}	
		return jsonData;
	}
	
	//로그아웃 처리
	@RequestMapping(value = "/auth/logout", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> logout(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("로그아웃 처리");
		try {
			try {
				if (session.getAttribute(Constants.USER_IDX) != null) { // 세션이 있을 경우
					SystemAccessLogVo systemAccessLogVo = new SystemAccessLogVo();
					systemAccessLogVo.setUserIdx(session.getAttribute(Constants.USER_IDX).toString());
					systemAccessLogVo.setUserId(session.getAttribute(Constants.USER_ID).toString());
					systemAccessLogVo.setUserNm(session.getAttribute(Constants.USER_NM).toString());
					systemAccessLogVo.setUserPositionNm(session.getAttribute(Constants.USER_POSITION_NM).toString());
					systemAccessLogVo.setUserDepartmentNm(session.getAttribute(Constants.USER_DEPARTMENT_NM).toString());
					systemAccessLogVo.setAccessUrl("/auth/logout");
					systemAccessLogVo.setAccessIp(Utils.getIp(request));
					systemAccessLogVo.setAccessDate(DateUtil.getCurrentDateTime());
					systemAccessLogService.systemAccessLogIns(systemAccessLogVo); // 시스템 접속기록
					session.invalidate(); // 세션 정보 초기화
				}
			} catch(Exception e) {
				logger.info("로그아웃 처리-세션없음");
			}
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			//jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
}
