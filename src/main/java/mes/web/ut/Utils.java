package mes.web.ut;

import java.net.Inet4Address;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

/**
 * <b>기능</b> :
 * <p>
 * 날짜 및 시간을 시스템으로부터 연산하는 클래스입니다.
 *
 * @author Administrator
 * @since 1.0
 * @see java.util.Date
 */

public class Utils {
	
	private static String OS = System.getProperty("os.name").toLowerCase(); // OS 확인
	private static String windowsFilePath = "C:\\MES\\files\\changyoung\\"; // windows 경로
	private static String unixFilePath = "/var/MES/files/changyoung/"; // unix 경로

	private static String systemErrorMessage = "시스템 오류가 발생했습니다.";
	
	public static String getFilePath() {
		if (OS.indexOf("win") >= 0) {
			return windowsFilePath;
		} else {
			return unixFilePath;
		}
	}

	public static String getUserIdx() {
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		String sessionData = request.getSession().getAttribute("userIdx").toString();

		if (sessionData == null || "".equals(sessionData)) {
			sessionData = "9999999";
		}
		return sessionData;
	}

	/**
	 * <p>
	 * 로그인 사용자아이디 return.
	 *
	 * @param userId
	 * @return userId
	 *
	 */

	public static String getUserId() {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		String sessionUserId = request.getSession().getAttribute("userId").toString();
		if (sessionUserId == null || "".equals(sessionUserId)) {
			sessionUserId = "empty";
		}
		return sessionUserId;
	}

	/**
	 * <p>
	 * 로그인 사용자명 return.
	 *
	 * @param userNm
	 * @return userNm
	 *
	 */

	public static String getUserNm() {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		String sessionUserNm = request.getSession().getAttribute("userNm").toString();

		if (sessionUserNm == null || "".equals(sessionUserNm)) {
			sessionUserNm = "알수없음";
		}
		return sessionUserNm;
	}

	public static String getErrorMessage() {
		return systemErrorMessage;
	}

	public static String getRandomString() {
		return UUID.randomUUID().toString().replaceAll("-", "");
	}

	public static String getIp(HttpServletRequest request) {
		String ip = request.getHeader("X-Forwarded-For");
		try {
		    if (ip == null) {
		        ip = request.getHeader("Proxy-Client-IP");
		    }
		    if (ip == null) {
		        ip = request.getHeader("WL-Proxy-Client-IP");
		    }
		    if (ip == null) {
		        ip = request.getHeader("HTTP_CLIENT_IP");
		    }
		    if (ip == null) {
		        ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		    }
		    if (ip == null) {
		        ip = Inet4Address.getLocalHost().getHostAddress();
		    }
		    if (ip.equals("127.0.0.1")) {
		        ip = request.getRemoteAddr();
		    }
		} catch(Exception e) {
			e.printStackTrace();
		}
		return ip;
	}
}