package mes.web.error;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class TabErrorController {
	
	private static final Logger logger = LoggerFactory.getLogger(TabErrorController.class);
	
	// 메인 탭 에러 페이지
	@RequestMapping(value = "/error/tabError", method = RequestMethod.GET)
	public ModelAndView tabError(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /error/tabError");
		mav.setViewName("/error/tabError");
		return mav;
	}
}
