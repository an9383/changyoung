package mes.web.bm;

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

import mes.domain.bm.MatrlInfoVo;
import mes.domain.bm.PrcssInfoVo;
import mes.domain.bm.MatrlInfoVo;
import mes.domain.bm.MatrlInfoVo;
import mes.domain.bm.MatrlInfoVo;
import mes.service.bm.MatrlInfoService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
@RequestMapping("/")
public class MatrlInfoController {
	
	@Inject
	private MatrlInfoService matrlInfoService;
	
	private static final Logger logger = LoggerFactory.getLogger(MatrlInfoController.class);
	
	// bmsc0090
	@RequestMapping(value = "/bm/bmsc0090", method = RequestMethod.GET)
	public ModelAndView bmsc0090(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /bm/bmsc0090");
		mav.setViewName("/bm/bmsc0090");
		return mav;
	}
	
	//자재 목록조회
	@RequestMapping(value = "bm/matrlInfoListAll", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> matrlInfoListAll(MatrlInfoVo matrlInfoVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();

		logger.info("자재 목록조회 : " + matrlInfoVo);
		try {
			List<MatrlInfoVo> MatrlInfoVoList = matrlInfoService.matrlInfoListAll(matrlInfoVo);
			jsonData.put("data", MatrlInfoVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}

	//재질 중복체크
	@RequestMapping(value = "bm/paperTypeDupCheck", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> paperTypeDupCheck(MatrlInfoVo matrlInfoVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("재질 중복체크 : " + matrlInfoVo);
		try {
			List<MatrlInfoVo> MatrlInfoVoList = matrlInfoService.paperTypeDupCheck(matrlInfoVo);
			if(MatrlInfoVoList.size() == 0 ) {
				jsonData.put("result", "ok");
			} else {
				jsonData.put("result", "fail");	
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}

	// 자재 상세목록조회
	@RequestMapping(value = "bm/matrlInfoSel", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> matrlInfoSel(MatrlInfoVo matrlInfoVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
	
		logger.info("자재 상세목록조회 : " + matrlInfoVo);
		try {
			matrlInfoVo = matrlInfoService.matrlInfoSel(matrlInfoVo);
			jsonData.put("data", matrlInfoVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}	
	
	//자재 등록
	@RequestMapping(value = "bm/matrlInfoInsert", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> matrlInfoInsert(MatrlInfoVo matrlInfoVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("자재 등록");
		try {
			MatrlInfoVo checkVo = new MatrlInfoVo();
			checkVo = null;
			matrlInfoVo.setRegIdx(Utils.getUserIdx());
			matrlInfoVo.setRegDate(DateUtil.getCurrentDateTime());
			// 매핑된 제품코드가 자동채번일 경우 -> 등록 , 아닐 경우 중복체크 후 등록 
			if("자동채번".equals(matrlInfoVo.getMatrlCd())) {
				matrlInfoService.matrlInfoInsert(matrlInfoVo);
				jsonData.put("result", "ok");
				jsonData.put("idx", matrlInfoVo.getResIdx());
			} else {
				checkVo = matrlInfoService.matrlInfoDupCheck(matrlInfoVo); //제품코드 중복체크
				if(checkVo == null) {
					matrlInfoService.matrlInfoInsert(matrlInfoVo);
					jsonData.put("idx", matrlInfoVo.getResIdx());
					jsonData.put("result", "ok");
				} else {
					jsonData.put("message", "이미 등록되어있는 코드입니다.");
					jsonData.put("result", "fail");
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//자재 수정
	@RequestMapping(value = "bm/matrlInfoUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> matrlInfoUpdate(MatrlInfoVo matrlInfoVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("자재 수정");
		try {
			MatrlInfoVo checkVo = new MatrlInfoVo();
			checkVo = null;
			matrlInfoVo.setUpdIdx(Utils.getUserIdx());
			matrlInfoVo.setUpdDate(DateUtil.getCurrentDateTime());
			// 매핑된 제품코드가 자동채번일 경우 -> 예외처리 , 아닐 경우 중복체크 후 수정
			if("자동채번".equals(matrlInfoVo.getMatrlCd())) {
				jsonData.put("message", "수정의 경우 자동채번 기능을 사용할 수 없습니다.");
				jsonData.put("result", "fail");
			} else {
				checkVo = matrlInfoService.matrlInfoDupCheck(matrlInfoVo); //제품코드 중복체크
				if(checkVo == null) {
					matrlInfoService.matrlInfoUpdate(matrlInfoVo);
					jsonData.put("result", "ok");
				} else {
					jsonData.put("message", "이미 등록되어있는 코드입니다.");
					jsonData.put("result", "fail");
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//자재 다중 수정
	@RequestMapping(value = "bm/matrlInfoMultiUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> matrlInfoMultiUpdate(MatrlInfoVo matrlInfoVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("자재 다중 수정");
		try {
			matrlInfoVo.setUpdIdx(Utils.getUserIdx());
			matrlInfoVo.setUpdDate(DateUtil.getCurrentDateTime());
			matrlInfoService.matrlInfoMultiUpdate(matrlInfoVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//자재 순번 수정
	@RequestMapping(value = "bm/matrlInfoOrdUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> matrlInfoOrdUpdate(MatrlInfoVo matrlInfoVo,
											@RequestParam(value="updateList") String updateList ) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("자재 순번 수정");
		try {
			matrlInfoVo.setUpdateList(updateList);
			matrlInfoVo.setUpdIdx(Utils.getUserIdx());
			matrlInfoVo.setUpdDate(DateUtil.getCurrentDateTime());
			matrlInfoService.matrlInfoOrdUpdate(matrlInfoVo);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 자재 삭제
	@RequestMapping(value = "bm/matrlInfoDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> matrlInfoDelete(MatrlInfoVo matrlInfoVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("자재 삭제");
		try {
			matrlInfoService.matrlInfoDelete(matrlInfoVo);
			if("Y".equals(matrlInfoVo.getResYn())) {
				jsonData.put("result", "ok");	
			} else {				
				jsonData.put("result", "fail");
				jsonData.put("message", matrlInfoVo.getResMes());
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// ================================= 수주별발주 =====================================
	// 자재목록조회 BOM포함/미포함
	@RequestMapping(value = "bm/matrlInfoLstByItemBom", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> matrlInfoLstByItemBom(MatrlInfoVo matrlInfoVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();

		logger.info("자재목록조회 BOM포함/미포함 : " + matrlInfoVo);
		try {
			List<MatrlInfoVo> MatrlInfoVoList = matrlInfoService.matrlInfoLstByItemBom(matrlInfoVo);
			jsonData.put("data", MatrlInfoVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// ================================= 개별발주 =====================================
	// 수주수량 포함 자재목록조회
	@RequestMapping(value = "bm/matrlInfoLstWithBiz", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> matrlInfoLstWithBiz(MatrlInfoVo matrlInfoVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();

		logger.info("수주수량 포함 자재목록조회 : " + matrlInfoVo);
		try {
			List<MatrlInfoVo> MatrlInfoVoList = matrlInfoService.matrlInfoLstWithBiz(matrlInfoVo);
			jsonData.put("data", MatrlInfoVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
}
