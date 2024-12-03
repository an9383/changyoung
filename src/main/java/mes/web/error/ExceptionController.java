package mes.web.error;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;

@ControllerAdvice
public class ExceptionController {
	private static final Logger logger = LoggerFactory.getLogger(ExceptionController.class);
	
	@ExceptionHandler(Exception.class)
	public String errorCode404(Exception ex) {
		logger.error("Exception : {}", ex.getMessage());
		return "/error/404";
	}
	
	//@ExceptionHandler(Exception.class)
	//@ResponseStatus(value = HttpStatus.METHOD_NOT_ALLOWED)
	//public String errorCode405(Exception ex, Model model) {
	//	logger.error("Exception : {}", ex.getMessage());
	//	return "/error/405";
	//}
	//
	//@ExceptionHandler(Exception.class)
	//@ResponseStatus(value = HttpStatus.INTERNAL_SERVER_ERROR)
	//public String errorCode500(Exception ex, Model model) {
	//	logger.error("Exception : {}", ex.getMessage());
	//	return "/error/500";
	//}
}
