package mes.web.bm;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.mindrot.jbcrypt.BCrypt;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import mes.domain.bm.DealCorpAdmVo;
import mes.service.bm.DealCorpAdmService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
@RequestMapping("/")
public class DealCorpAdmController {
	
	@Inject
	private DealCorpAdmService dealCorpAdmService;
	
	
	private static final Logger logger = LoggerFactory.getLogger(DealCorpAdmController.class);
	
	// bmsc0010
	@RequestMapping(value = "/bm/bmsc0010", method = RequestMethod.GET)
	public ModelAndView bmsc0010(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /bm/bmsc0010");
		mav.setViewName("/bm/bmsc0010");
		return mav;
	}
	
	// 거래처정보관리 페이지
	@RequestMapping(value = "/bm/bmsc0020", method = RequestMethod.GET)
	public ModelAndView bmsc0020(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /bm/bmsc0020");
		mav.setViewName("/bm/bmsc0020");
		mav.addObject("userName", Utils.getUserNm());
		return mav;
	}
	
	// 거래처정보 목록조회
	@RequestMapping(value = "bm/dealCorpAdmList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> dealCorpAdmList(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("거래처정보 목록조회");
		try {
			List<DealCorpAdmVo> dealCorpAdmList = dealCorpAdmService.dealCorpAdmList(dealCorpAdmVo);
			jsonData.put("data", dealCorpAdmList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 거래처정보(투입자재 발주처) 목록조회
	@RequestMapping(value = "bm/matrlDealCorpAdmList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> matrlDealCorpAdmList(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("거래처정보(투입자재 발주처) 목록조회");
		try {
			List<DealCorpAdmVo> dealCorpAdmList = dealCorpAdmService.matrlDealCorpAdmList(dealCorpAdmVo);
			jsonData.put("data", dealCorpAdmList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 거래처정보 상세조회
	@RequestMapping(value = "bm/dealCorpAdmSel", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> dealCorpAdmSel(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("거래처정보 상세조회");
		try {
			dealCorpAdmVo = dealCorpAdmService.dealCorpAdmSel(dealCorpAdmVo);
			logger.info("12" + dealCorpAdmVo.getSalesManagerNm());
			jsonData.put("data", dealCorpAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 거래처정보 등록
	@RequestMapping(value = "bm/dealCorpAdmIns", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> dealCorpAdmIns(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("거래처정보 등록" + dealCorpAdmVo);
		try {
			dealCorpAdmVo.setRegIdx(Utils.getUserIdx());
			dealCorpAdmVo.setRegDate(DateUtil.getCurrentDateTime());
//			if(dealCorpAdmService.dealCorpCdCheck(dealCorpAdmVo) == null) { 거래처코드 자동채번 기능으로 인해 중복 체크 기능 불필요 - 2023.10.06
				String admIdx = dealCorpAdmService.dealCorpAdmIns(dealCorpAdmVo);
				logger.info("admIdx : " + admIdx);	
				jsonData.put("idx", admIdx);
				jsonData.put("result", "ok");
//			} else {
//				jsonData.put("result", "fail");
//				jsonData.put("message", "중복되는 거래처 코드가 존재합니다.");
//			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 거래처정보 수정
	@RequestMapping(value = "bm/dealCorpAdmUpd", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> dealCorpAdmUpd(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("거래처정보 수정");
		try {
			dealCorpAdmVo.setUpdIdx(Utils.getUserIdx());
			dealCorpAdmVo.setUpdDate(DateUtil.getCurrentDateTime());
			if(dealCorpAdmService.dealCorpCdCheck(dealCorpAdmVo) == null) {
				dealCorpAdmService.dealCorpAdmUpd(dealCorpAdmVo);
				dealCorpAdmVo.setAdmIdx(dealCorpAdmVo.getIdx());
				dealCorpAdmService.dealCorpManagerDel(dealCorpAdmVo);
				jsonData.put("result", "ok");
			} else {
				jsonData.put("result", "fail");
				jsonData.put("message", "중복되는 거래처 코드가 존재합니다.");
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 거래처정보 삭제
	@RequestMapping(value = "bm/dealCorpAdmDel", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> userDel(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("거래처정보 삭제");
		try {
			dealCorpAdmService.dealCorpAdmDel(dealCorpAdmVo);
			dealCorpAdmVo.setAdmIdx(dealCorpAdmVo.getIdx());
			dealCorpAdmVo.setIdx(null);
			dealCorpAdmService.dealCorpManagerDel(dealCorpAdmVo);
			dealCorpAdmService.dealCorpFileDel(dealCorpAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 거래처정보 담당자 목록 조회
	@RequestMapping(value = "bm/dealCorpManagerList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> dealCorpManagerList(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("거래처정보 담당자 목록조회");
		try {
			List<DealCorpAdmVo> dealCorpAdmList = dealCorpAdmService.dealCorpManagerList(dealCorpAdmVo);
			jsonData.put("data", dealCorpAdmList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 거래처정보 담당자 등록
	@RequestMapping(value = "bm/dealCorpManagerIns", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> dealCorpManagerIns(@RequestBody List<Map<String, Object>> dealCorpManagerList) throws Exception {
		Map<String, Object>	jsonData = new HashMap<String, Object>();
		try {
			DealCorpAdmVo dealCorpAdmVo = new DealCorpAdmVo();				
			logger.info("data : " + dealCorpManagerList.size());
			logger.info("data : " + dealCorpManagerList);
			for(Map<String, Object> m : dealCorpManagerList) {
				dealCorpAdmVo.setAdmIdx(dealCorpManagerList.get(0).get("admIdx").toString());
				dealCorpAdmVo.setChargeDepartment(m.get("chargeDepartment").toString());
				dealCorpAdmVo.setChargeName(m.get("chargeName").toString());
				dealCorpAdmVo.setChargePhoneNumber(m.get("chargePhoneNumber").toString());
				dealCorpAdmVo.setChargeEmail(m.get("chargeEmail").toString());
				dealCorpAdmVo.setRegIdx(Utils.getUserIdx());
				dealCorpAdmVo.setRegDate(DateUtil.getCurrentDateTime());
				 dealCorpAdmService.dealCorpManagerIns(dealCorpAdmVo);
			}
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 거래처정보 관련파일 목록조회
	@RequestMapping(value = "bm/dealCorpFileList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> dealCorpFileList(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("거래처정보 목록조회");
		try {
			List<DealCorpAdmVo> dealCorpFileList = dealCorpAdmService.dealCorpFileList(dealCorpAdmVo);
			jsonData.put("data", dealCorpFileList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 거래처정보 관련파일 등록
	@RequestMapping(value = "bm/dealCorpFileIns", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> dealCorpFileIns(@RequestBody List<Map<String, Object>> dealCorpFileList) throws Exception {
		Map<String, Object>	jsonData = new HashMap<String, Object>();
		try {
			DealCorpAdmVo dealCorpAdmVo = new DealCorpAdmVo();				
			int managerIdx = 1;
			logger.info("data : " + dealCorpFileList.size());
			logger.info("data : " + dealCorpFileList);
			for(Map<String, Object> m : dealCorpFileList) {
				dealCorpAdmVo.setAdmIdx(dealCorpFileList.get(0).get("admIdx").toString());
				dealCorpAdmVo.setUuid(m.get("uuid").toString());
				dealCorpAdmVo.setFileName(m.get("fileName").toString());
				dealCorpAdmVo.setFileExt(m.get("fileExt").toString());
				dealCorpAdmVo.setRegIdx(Utils.getUserIdx());
				dealCorpAdmVo.setRegDate(DateUtil.getCurrentDateTime());
				 dealCorpAdmService.dealCorpFileIns(dealCorpAdmVo);
				 managerIdx++;
			}
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 거래처정보 관련파일 삭제
	@RequestMapping(value = "bm/dealCorpFileDel", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> dealCorpFileDel(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("거래처정보 삭제");
		try {
			dealCorpAdmService.dealCorpFileDel(dealCorpAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
}
