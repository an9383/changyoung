package mes.interceptor;

import java.net.Inet4Address;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.util.Arrays;
import java.util.Enumeration;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import mes.domain.sm.SystemAccessLogVo;
import mes.service.sm.SystemAccessLogService;
import mes.web.auth.Constants;
import mes.web.auth.LoginController;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

public class LoginInterceptor extends HandlerInterceptorAdapter {
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Inject
	private SystemAccessLogService systemAccessLogService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
		try {
			logger.info("Interceptor preHandle...............");
			
			String requestURI = request.getRequestURI();
			String ajax = request.getHeader("x-requested-with");
			HttpSession session = request.getSession(true);
			if (session.getAttribute(Constants.USER_IDX) != null) { // 세션이 있을 경우
				if(ajax == null) { // ajax 요청이 아닐경우
					String[] menuPathList = (String[]) session.getAttribute(Constants.MENU_PATH_LIST);
					Arrays.sort(menuPathList);
					if(Arrays.binarySearch(menuPathList,  requestURI) > 0	||
						requestURI.equals("/dashboard/main")				||
						requestURI.equals("/")								||
						requestURI.equals("")) {
						SystemAccessLogVo systemAccessLogVo = new SystemAccessLogVo();
						systemAccessLogVo.setUserIdx(session.getAttribute(Constants.USER_IDX).toString());
						systemAccessLogVo.setUserId(session.getAttribute(Constants.USER_ID).toString());
						systemAccessLogVo.setUserNm(session.getAttribute(Constants.USER_NM).toString());
						systemAccessLogVo.setUserPositionNm(session.getAttribute(Constants.USER_POSITION_NM).toString());
						systemAccessLogVo.setUserDepartmentNm(session.getAttribute(Constants.USER_DEPARTMENT_NM).toString());
						systemAccessLogVo.setAccessUrl(requestURI);
						systemAccessLogVo.setAccessIp(Utils.getIp(request));
						systemAccessLogVo.setAccessDate(DateUtil.getCurrentDateTime());
						systemAccessLogService.systemAccessLogIns(systemAccessLogVo); // 시스템 접속기록
						
						return true;
					} else {
						response.sendRedirect(request.getContextPath() + "/error/menuAuth");
						return false;
					}
				} else { // ajax 요청일 경우
					return true;
				}
				
				//if("XMLHttpRequest".equals(request.getHeader("x-requested-with"))) { // ajax 요청을 받았을 경우
				//	return true;
				//} else {
				//	if(requestURI.equals("/dashboard/main")) { // 에외 권한
				//		return true;
				//	} else {
				//		boolean menuAuthState = false;
				//		List<MenuAuthVo> menuAuthVoList = (List<MenuAuthVo>) session.getAttribute(Constants.MENU_AUTH);
				//		for(int i=0;i<menuAuthVoList.size();i++) {
				//			String menuFullId = "/" + menuAuthVoList.get(i).getMenuId() + "/" + menuAuthVoList.get(i).getMenuIdDtl();
				//			if(requestURI.equals(menuFullId)) { // 에외 권한
				//				menuAuthState = true;
				//				break;
				//			}
				//		}
				//		
				//		if(menuAuthState) {
				//			return true;
				//		} else {
				//			response.sendRedirect(request.getContextPath() + "/dashboard/main");
				//			return false;
				//		}
				//	}
				//}
				
			} else { // 세션이 없을 경우
				if("XMLHttpRequest".equals(request.getHeader("x-requested-with"))) { // ajax 요청을 받았을 경우
					
				}
				response.sendRedirect(request.getContextPath() + "/auth/login");
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		super.postHandle(request, response, handler, modelAndView);
	}
	
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
		super.afterCompletion(request, response, handler, ex);
	}

	@Override
	public void afterConcurrentHandlingStarted(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		super.afterConcurrentHandlingStarted(request, response, handler);
	}

}