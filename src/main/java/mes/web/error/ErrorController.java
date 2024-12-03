package mes.web.error;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ErrorController {
	
	private static final Logger logger = LoggerFactory.getLogger(ErrorController.class);
	
	// 404 error 페이지
	@RequestMapping(value = "/error/404", method = RequestMethod.GET)
	public ModelAndView error404(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /error/404");
		mav.setViewName("/error/404");
		return mav;
	}
	
	// 405 error 페이지
	@RequestMapping(value = "/error/405", method = RequestMethod.GET)
	public ModelAndView error405(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /error/405");
		mav.setViewName("/error/405");
		return mav;
	}
	
	// 500 error 페이지
	@RequestMapping(value = "/error/500", method = RequestMethod.GET)
	public ModelAndView error500(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /error/500");
		mav.setViewName("/error/500");
		return mav;
	}
	
	// 권한없음 error 페이지
	@RequestMapping(value = "/error/menuAuth", method = RequestMethod.GET)
	public ModelAndView menuAuth(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /error/menuAuth");
		mav.setViewName("/error/menuAuth");
		return mav;
	}
}
