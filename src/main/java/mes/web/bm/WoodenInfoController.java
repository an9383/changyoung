package mes.web.bm;

import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.GregorianCalendar;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import mes.domain.bm.WoodenInfoVo;
import mes.service.bm.WoodenInfoService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
@RequestMapping("/")
public class WoodenInfoController {
	
	@Inject
	private WoodenInfoService woodenInfoService;
	
	private static final Logger logger = LoggerFactory.getLogger(WoodenInfoController.class);
	
	// bmsc0040
	@RequestMapping(value = "/bm/bmsc0040", method = RequestMethod.GET)
	public ModelAndView bmsc0040(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /bm/bmsc0040");
		mav.setViewName("/bm/bmsc0040");
		return mav;
	}
	
	// =========================== 목형정보관리 기본정보 ==========================================
	// 목형정보관리 기본정보 목록조회
	@RequestMapping(value = "bm/woodenInfoAdmLst", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> woodenInfoAdmLst(WoodenInfoVo woodenInfoVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("목형정보관리 기본정보 목록조회");
		try {
			List<WoodenInfoVo> woodenInfoVoList = woodenInfoService.woodenInfoAdmLst(woodenInfoVo);
			jsonData.put("data", woodenInfoVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 목형정보관리 목록조회 - 사이즈 코팅 성형방식 일치하는 목록 
	@RequestMapping(value = "bm/woodenInfoAdmLstWithSizeCoatingMolding", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> woodenInfoAdmLstWithSizeCoatingMolding(WoodenInfoVo woodenInfoVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("목형정보관리 목록조회 - 사이즈 코팅 성형방식 일치하는 목록");
		try {
			List<WoodenInfoVo> woodenInfoVoList = woodenInfoService.woodenInfoAdmLstWithSizeCoatingMolding(woodenInfoVo);
			//Optional resultWood = woodenInfoVoList.stream().filter(x -> x.getExpendGubun().equals("01")).findFirst();
			//Optional resultResin = woodenInfoVoList.stream().filter(x -> x.getExpendGubun().equals("02") || x.getExpendGubun().equals("03") || x.getExpendGubun().equals("04")
			//															|| x.getExpendGubun().equals("05") || x.getExpendGubun().equals("06") || x.getExpendGubun().equals("07") ).findFirst();
			/* 힘들게 만들었더니 안쓴데요 흑흑..
			//목형번호가 없다면 
			if( !resultWood.isPresent() ) {
				woodenInfoVo.setWdCd("임시코드");
				woodenInfoVo.setWdGubun("02");
				woodenInfoVo.setExpendGubun("01"); //01->목형 02->수지판
				woodenInfoVo.setInputDate(DateUtil.getCurrentDateTime().replaceAll("-","").substring(0, 8));
				woodenInfoVo.setBaseHitQty("0");
				woodenInfoVo.setInitHitQty("0");
				woodenInfoVo.setUseHitQty("0");
				woodenInfoVo.setCalHitQty("0");
				woodenInfoVo.setRemainHitQty("0");				
				woodenInfoVo.setUseYn("Y");
				woodenInfoVo.setRegIdx(Utils.getUserIdx());
				woodenInfoVo.setRegDate(DateUtil.getCurrentDateTime());
				String wdIdx = woodenInfoService.woodenInfoAdmIns(woodenInfoVo); // 기본정보 등록

				woodenInfoVo.setWdIdx(wdIdx);
				woodenInfoVo.setRegIdx(Utils.getUserIdx());
				woodenInfoVo.setRegDate(DateUtil.getCurrentDateTime());
				woodenInfoService.woodenInfoLogIns(woodenInfoVo); // 사용이력 등록
			}
			//수지판번호가 없다면
			if( !resultResin.isPresent() ) {
				woodenInfoVo.setExpendGubun("02"); //01->목형 02->수지판+
				woodenInfoVo.setWdCd("임시코드");
				woodenInfoVo.setWdGubun("02");
				woodenInfoVo.setInputDate(DateUtil.getCurrentDateTime().replaceAll("-","").substring(0, 8));
				woodenInfoVo.setBaseHitQty("0");
				woodenInfoVo.setInitHitQty("0");
				woodenInfoVo.setUseHitQty("0");
				woodenInfoVo.setCalHitQty("0");
				woodenInfoVo.setRemainHitQty("0");				
				woodenInfoVo.setUseYn("Y");
				woodenInfoVo.setRegIdx(Utils.getUserIdx());
				woodenInfoVo.setRegDate(DateUtil.getCurrentDateTime());
				String wdIdx = woodenInfoService.woodenInfoAdmIns(woodenInfoVo); // 기본정보 등록
				
				woodenInfoVo.setWdIdx(wdIdx);
				woodenInfoService.woodenInfoLogIns(woodenInfoVo); // 사용이력 등록
			}
			*/
			//woodenInfoVoList = woodenInfoService.woodenInfoAdmLstWithSizeCoatingMolding(woodenInfoVo);
			jsonData.put("data", woodenInfoVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 목형정보관리 기본정보 상세조회
	@RequestMapping(value = "bm/woodenInfoAdmSel", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> woodenInfoAdmSel(WoodenInfoVo woodenInfoVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("목형정보관리 기본정보 상세조회");
		try {
			woodenInfoVo = woodenInfoService.woodenInfoAdmSel(woodenInfoVo);
			jsonData.put("data", woodenInfoVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 목형정보관리 기본정보 등록
	@RequestMapping(value = "bm/woodenInfoAdmIns", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> woodenInfoAdmIns(WoodenInfoVo woodenInfoVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("목형정보관리 기본정보 등록");
		try {
			if(woodenInfoService.woodenInfoAdmIdDupCheck(woodenInfoVo) == null) { // 중복되는 목형코드가 존재하지 않을 경우
				woodenInfoVo.setRegIdx(Utils.getUserIdx());
				woodenInfoVo.setRegDate(DateUtil.getCurrentDateTime());
				String wdIdx = woodenInfoService.woodenInfoAdmIns(woodenInfoVo); // 기본정보 등록
				
				woodenInfoVo.setWdIdx(wdIdx);
				woodenInfoVo.setRegIdx(Utils.getUserIdx());
				woodenInfoVo.setRegDate(DateUtil.getCurrentDateTime());
				woodenInfoService.woodenInfoLogIns(woodenInfoVo); // 사용이력 등록
				jsonData.put("result", "ok");
			} else { // 중복되는 목형코드가 존재할 경우
				jsonData.put("result", "fail");
				jsonData.put("message", "중복되는 코드가 존재합니다.");
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 목형정보관리 기본정보 수정
	@RequestMapping(value = "bm/woodenInfoAdmUpd", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> woodenInfoAdmUpd(WoodenInfoVo woodenInfoVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("목형정보관리 기본정보 수정");
		try {
			WoodenInfoVo woodenInfoBeforeVo = woodenInfoService.woodenInfoAdmSel(woodenInfoVo);
			WoodenInfoVo woodenInfoAfterVo = woodenInfoVo;
			String wdIdx = woodenInfoVo.getIdx();
			if(woodenInfoService.woodenInfoAdmIdDupCheck(woodenInfoVo) == null && !woodenInfoVo.getWdCd().equals("임시코드")) { // 중복되는 목형코드가 존재하지 않을 경우
				woodenInfoVo.setUpdIdx(Utils.getUserIdx());
				woodenInfoVo.setUpdDate(DateUtil.getCurrentDateTime());
				woodenInfoService.woodenInfoAdmUpd(woodenInfoVo);
				
				if(!woodenInfoBeforeVo.getWdGubun().equals(woodenInfoAfterVo.getWdGubun())) { // 구분코드가 변경되었을 경우
					woodenInfoVo.setWdIdx(wdIdx);
					woodenInfoVo.setRegIdx(Utils.getUserIdx());
					woodenInfoVo.setRegDate(DateUtil.getCurrentDateTime());
					woodenInfoService.woodenInfoLogIns(woodenInfoVo); // 사용이력 등록
				}
				jsonData.put("result", "ok");
			} else if(woodenInfoVo.getWdCd().equals("임시코드")){
				jsonData.put("result", "fail");
				jsonData.put("message", "임시코드로는 수정이 불가능합니다.");
				
			} else { // 중복되는 목형코드가 존재할 경우
				jsonData.put("result", "fail");
				jsonData.put("message", "중복되는 코드가 존재합니다.");
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 목형정보관리 기본정보 삭제
	@RequestMapping(value = "bm/woodenInfoAdmDel", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> woodenInfoAdmDel(WoodenInfoVo woodenInfoVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("목형정보관리 기본정보 삭제");
		try {
			woodenInfoService.woodenInfoAdmDel(woodenInfoVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// =========================== 목형정보관리 사용이력 ==========================================
	// 목형정보관리 사용이력 목록조회
	@RequestMapping(value = "bm/woodenInfoLogLst", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> woodenInfoLogLst(WoodenInfoVo woodenInfoVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("목형정보관리 사용이력 목록조회");
		try {
			List<WoodenInfoVo> woodenInfoVoList = woodenInfoService.woodenInfoLogLst(woodenInfoVo);
			jsonData.put("data", woodenInfoVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 목형정보관리 사용이력 삭제
	@RequestMapping(value = "bm/woodenInfoLogDel", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> woodenInfoLogDel(WoodenInfoVo woodenInfoVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("목형정보관리 사용이력 삭제");
		try {
			woodenInfoService.woodenInfoLogDel(woodenInfoVo); // 사용이력 삭제
			
			List<WoodenInfoVo> woodenInfoVoList = woodenInfoService.woodenInfoLogLst(woodenInfoVo); // 사용이력 목록조회
			String idx = woodenInfoVo.getWdIdx();
			String wdGubun = woodenInfoVoList.get(woodenInfoVoList.size()-1).getWdGubun(); // 가장 마지막 사용이력의 구분코드
			
			woodenInfoVo.setIdx(idx);
			woodenInfoVo.setWdGubun(wdGubun);
			woodenInfoVo.setUpdIdx(Utils.getUserIdx());
			woodenInfoVo.setUpdDate(DateUtil.getCurrentDateTime());
			woodenInfoService.woodenInfoAdmUpd(woodenInfoVo); // 기본정보 수정
			
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
}
