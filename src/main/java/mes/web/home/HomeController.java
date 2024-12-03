package mes.web.home;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import mes.domain.sm.MenuAuthVo;
import mes.service.sm.MenuAuthService;
import mes.web.auth.Constants;
import mes.web.ut.Utils;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Inject
	private MenuAuthService menuAuthService;
	
	// home
	@RequestMapping(value = {"/",""}, method = RequestMethod.GET)
	public ModelAndView root(ModelAndView mav, HttpServletRequest request) throws Exception {
		logger.info("page : /");
		mav.setViewName("redirect:/dashboard/main");
		return mav;
	}
	
	// home
	@RequestMapping(value = "/dashboard/main", method = RequestMethod.GET)
	public ModelAndView main(ModelAndView mav, HttpServletRequest request) throws Exception {
		logger.info("page : /dashboard/main");
		
		MenuAuthVo menuAuthVo = new MenuAuthVo();
		menuAuthVo.setUserIdx(Utils.getUserIdx());
		List<MenuAuthVo> menuAuthVoList = menuAuthService.menuAuthLstForMenuList(menuAuthVo);
		
		String[] menuPathList = new String[menuAuthVoList.size()];
		
		for(int i=0;i<menuAuthVoList.size();i++) {
			menuPathList[i] = "/" + menuAuthVoList.get(i).getMenuPath();
		}
		
		HttpSession session = request.getSession(true);
		session.setAttribute(Constants.MENU_AUTH, menuAuthVoList);
		session.setAttribute(Constants.MENU_PATH_LIST, menuPathList);
		
		mav.setViewName("/dashboard/main");
		return mav;
	}
	
	// 우편번호 찾기
	@RequestMapping(value = "/popup/jusoPopup", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView jusoPopup(ModelAndView mav, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		try {
			mav.setViewName("/layout/jusoPopup");
		}
		catch (NullPointerException e) {
			// e.printStackTrace();
		}
		return mav;
	}
}
