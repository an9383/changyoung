package mes.web.bm;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.mindrot.jbcrypt.BCrypt;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import mes.domain.bm.ItemInfoAdmVo;
import mes.domain.bm.ItemInfoVo;
import mes.service.bm.ItemInfoAdmService;
import mes.domain.bm.WoodenInfoVo;
import mes.service.bm.WoodenInfoService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
@RequestMapping("/")
public class ItemInfoAdmController {
	
	@Inject
	private ItemInfoAdmService itemInfoAdmService;
	@Inject
	private WoodenInfoService woodenInfoService;
	
	
	private static final Logger logger = LoggerFactory.getLogger(ItemInfoAdmController.class);
	
	// bmsc0030
	@RequestMapping(value = "/bm/bmsc0030", method = RequestMethod.GET)
	public ModelAndView bmsc0030(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /bm/bmsc0030");
		mav.setViewName("/bm/bmsc0030");
		return mav;
	}
		
	// bmsc0070
	@RequestMapping(value = "/bm/bmsc0070", method = RequestMethod.GET)
	public ModelAndView bmsc0070(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /bm/bmsc0070");
		mav.setViewName("/bm/bmsc0070");
		return mav;
	}
	
	// 품목정보관리 목록조회
	@RequestMapping(value = "bm/itemInfoListAll", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> itemInfoListAll(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();

		logger.info("품목정보관리 목록조회 : " + itemInfoAdmVo);
		try {
			List<ItemInfoAdmVo> ItemInfoAdmVoList = itemInfoAdmService.itemInfoListAll(itemInfoAdmVo);
			jsonData.put("data", ItemInfoAdmVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//품목정보관리 제품조회(제품코드등록 메인LST)
	@RequestMapping(value = "bm/itemInfoLst", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> itemInfoLst(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();

		logger.info("품목정보관리 제품조회(제품코드등록 메인LST) : " + itemInfoAdmVo);
		try {
			List<ItemInfoVo> ItemInfoAdmVoList = itemInfoAdmService.itemInfoLst(itemInfoAdmVo);
			jsonData.put("data", ItemInfoAdmVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 품목정보관리 상세목록조회
	@RequestMapping(value = "bm/itemInfoSel", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> itemInfoSel(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
	
		logger.info("품목정보관리 상세목록조회 : " + itemInfoAdmVo);
		try {
			itemInfoAdmVo = itemInfoAdmService.itemInfoSel(itemInfoAdmVo);
			jsonData.put("data", itemInfoAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 품목정보관리 등록
	@RequestMapping(value = "bm/itemInfoInsert", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> itemInfoInsert(ItemInfoAdmVo itemInfoAdmVo,
															@RequestParam(value="versionFileString", required=false) String jsonArray) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("품목정보관리 등록");
		try {
			JSONParser jsonParser = new JSONParser();
			JSONArray dataArray = (JSONArray) jsonParser.parse(jsonArray);
			JSONObject jsonObj = new JSONObject();
			
			ItemInfoAdmVo checkVo = new ItemInfoAdmVo();
			checkVo = null;
			itemInfoAdmVo.setRegIdx(Utils.getUserIdx());
			itemInfoAdmVo.setRegDate(DateUtil.getCurrentDateTime());
			// 매핑된 제품코드가 자동채번일 경우 -> 등록 , 아닐 경우 중복체크 후 등록 
			if("자동채번".equals(itemInfoAdmVo.getItemCd())) {
				//파일 업로드 DB 생성
				if(!"".equals(itemInfoAdmVo.getVersionFileString()) && dataArray.size() > 0) {		
					jsonObj.put(0, dataArray.get(0));
		    		JSONObject jsonObject = (JSONObject) jsonParser.parse(jsonObj.get(0).toString());
					itemInfoAdmVo.setUuid(jsonObject.get("uuid").toString());
					itemInfoAdmVo.setFileNm(jsonObject.get("fileNm").toString());
					itemInfoAdmVo.setExt(jsonObject.get("ext").toString());
				}
				String idx = itemInfoAdmService.itemInfoInsert(itemInfoAdmVo);
				jsonData.put("idx", idx);
				jsonData.put("result", "ok");
			} else {
				checkVo = itemInfoAdmService.itemInfoDupCheck(itemInfoAdmVo); //제품코드 중복체크
				if(checkVo == null) {
					itemInfoAdmService.itemInfoInsert(itemInfoAdmVo);
					String idx = itemInfoAdmService.itemInfoInsert(itemInfoAdmVo);
					jsonData.put("idx", idx);
					jsonData.put("result", "ok");
				} else {
					jsonData.put("message", "이미 등록되어있는 품번입니다.");
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
	
	// 품목정보관리 복사
	@RequestMapping(value = "bm/itemInfoCopy", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> itemInfoCopy(ItemInfoAdmVo itemInfoAdmVo,
															@RequestParam(value="versionFileString", required=false) String jsonArray) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("품목정보관리 복사");
		try {
			JSONParser jsonParser = new JSONParser();
			JSONArray dataArray = (JSONArray) jsonParser.parse(jsonArray);
			JSONObject jsonObj = new JSONObject();
			

			itemInfoAdmVo.setRegIdx(Utils.getUserIdx());
			itemInfoAdmVo.setRegDate(DateUtil.getCurrentDateTime());
	
			//파일 업로드 DB 생성
			if(!"".equals(itemInfoAdmVo.getVersionFileString()) && dataArray.size() > 0) {		
				jsonObj.put(0, dataArray.get(0));
			   	JSONObject jsonObject = (JSONObject) jsonParser.parse(jsonObj.get(0).toString());
				itemInfoAdmVo.setUuid(jsonObject.get("uuid").toString());
				itemInfoAdmVo.setFileNm(jsonObject.get("fileNm").toString());
				itemInfoAdmVo.setExt(jsonObject.get("ext").toString());
			}
			String idx = itemInfoAdmService.itemInfoCopy(itemInfoAdmVo);
			jsonData.put("idx", idx);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 품목정보관리 수정
	@RequestMapping(value = "bm/itemInfoUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> itemInfoUpdate(ItemInfoAdmVo itemInfoAdmVo,
															@RequestParam(value="versionFileString", required=false) String jsonArray) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("품목정보관리 수정");
		try {
			JSONParser jsonParser = new JSONParser();
			JSONArray dataArray = (JSONArray) jsonParser.parse(jsonArray);
			JSONObject jsonObj = new JSONObject();
			
			ItemInfoAdmVo checkVo = new ItemInfoAdmVo();
			checkVo = null;
			itemInfoAdmVo.setRegIdx(Utils.getUserIdx());
			itemInfoAdmVo.setRegDate(DateUtil.getCurrentDateTime());
			itemInfoAdmVo.setUpdIdx(Utils.getUserIdx());
			itemInfoAdmVo.setUpdDate(DateUtil.getCurrentDateTime());
			
			checkVo = itemInfoAdmService.itemInfoDupCheck(itemInfoAdmVo); //품번 중복체크
			
			if(checkVo == null && !"자동채번".equals(itemInfoAdmVo.getItemCd())) {
				if(!"".equals(itemInfoAdmVo.getVersionFileString()) && dataArray.size() > 0) {
					//파일 업로드 DB 생성
					jsonObj.put(0, dataArray.get(0));
		    		JSONObject jsonObject = (JSONObject) jsonParser.parse(jsonObj.get(0).toString());
					itemInfoAdmVo.setUuid(jsonObject.get("uuid").toString());
					itemInfoAdmVo.setFileNm(jsonObject.get("fileNm").toString());
					itemInfoAdmVo.setExt(jsonObject.get("ext").toString());
				}
				itemInfoAdmService.itemInfoUpdate(itemInfoAdmVo);
				jsonData.put("result", "ok");
			} else if("자동채번".equals(itemInfoAdmVo.getItemCd())){
				jsonData.put("message", "수정의 경우 자동채번 기능을 사용할 수 없습니다.");
				jsonData.put("result", "fail");
			} else {
				jsonData.put("message", "이미 등록되어있는 품번입니다.");
				jsonData.put("result", "fail");
			}
	
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 품목정보관리 삭제
	@RequestMapping(value = "bm/itemInfoDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> itemInfoDelete(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("품목정보관리 삭제");
		try {
			itemInfoAdmService.itemInfoDelete(itemInfoAdmVo);
			if("Y".equals(itemInfoAdmVo.getResultYn())){
				jsonData.put("result", "ok");	
			} else {
				jsonData.put("result", "fail");
				jsonData.put("message", itemInfoAdmVo.getResMessage());
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 제품명 중복확인
	@RequestMapping(value = "bm/itemNmDupCheck", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> itemNmDupCheck(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품명 중복확인 : " + itemInfoAdmVo);
		try {
			List<ItemInfoAdmVo> checkVo = itemInfoAdmService.itemNmDupCheck(itemInfoAdmVo);
			//jsonData.put("data", ItemInfoAdmVoList);
			if(checkVo.size() == 0 ) {
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
	
	// 품목정보관리 이력 목록조회
	@RequestMapping(value = "bm/itemVersionListAll", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> itemVersionListAll(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();

		logger.info("품목정보관리 이력 목록조회 : " + itemInfoAdmVo);
		try {
			List<ItemInfoAdmVo> ItemInfoAdmVoList = itemInfoAdmService.itemVersionListAll(itemInfoAdmVo);
			jsonData.put("data", ItemInfoAdmVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 품목정보관리 제품수행이력 목록조회
	@RequestMapping(value = "bm/itemPerformanceHistoryLst", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> itemPerformanceHistoryLst(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		
		logger.info("품목정보관리 제품수행이력 목록조회 : " + itemInfoAdmVo);
		try {
			List<ItemInfoAdmVo> ItemInfoAdmVoList = itemInfoAdmService.itemPerformanceHistoryLst(itemInfoAdmVo);
			jsonData.put("data", ItemInfoAdmVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 품목정보관리 버전 등록
	@RequestMapping(value = "bm/itemVersionInsert", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> itemVersionInsert(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("품목정보관리 버전 등록");
		try {
			itemInfoAdmVo.setRegIdx(Utils.getUserIdx());
			itemInfoAdmVo.setRegDate(DateUtil.getCurrentDateTime());

			itemInfoAdmService.itemVersionInsert(itemInfoAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 품목정보관리 버전 수정
	@RequestMapping(value = "bm/itemVersionUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> itemVersionUpdate(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("품목정보관리 버전 수정");
		try {
			itemInfoAdmService.itemVersionUpdate(itemInfoAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}

	// 품목정보관리 버전 삭제
	@RequestMapping(value = "bm/itemVersionDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> itemVersionDelete(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("품목정보관리 버전 삭제");
		try {
			itemInfoAdmService.itemVersionDelete(itemInfoAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 품목정보관리 파일 목록조회
	@RequestMapping(value = "bm/itemFileListAll", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> itemFileListAll(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
	
		logger.info("품목정보관리 파일 목록조회 : " + itemInfoAdmVo);
		try {
			List<ItemInfoAdmVo> ItemInfoAdmVoList = itemInfoAdmService.itemFileListAll(itemInfoAdmVo);
			jsonData.put("data", ItemInfoAdmVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 품목정보관리 파일 등록
	@RequestMapping(value = "bm/itemFileInsert", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> itemFileInsert(ItemInfoAdmVo itemInfoAdmVo,
														@RequestParam(value="fileString", required=false) String jsonArray) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("품목정보관리 파일 등록");
		try {
			JSONParser jsonParser = new JSONParser();
			JSONArray dataArray = (JSONArray) jsonParser.parse(jsonArray);
			JSONObject jsonObj = new JSONObject();
			
			itemInfoAdmVo.setRegIdx(Utils.getUserIdx());
			itemInfoAdmVo.setRegDate(DateUtil.getCurrentDateTime());
			//파일 업로드 DB 생성
			for(int i=0;i<dataArray.size();i++) {
				jsonObj.put(i, dataArray.get(i));
	    		JSONObject jsonObject = (JSONObject) jsonParser.parse(jsonObj.get(i).toString());
	    		itemInfoAdmVo.setUuid(jsonObject.get("uuid").toString());
				itemInfoAdmVo.setFileNm(jsonObject.get("fileNm").toString());
				itemInfoAdmVo.setExt(jsonObject.get("ext").toString());
				itemInfoAdmService.itemFileInsert(itemInfoAdmVo);
			}
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 품목정보관리 파일 삭제
	@RequestMapping(value = "bm/itemFileDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> itemFileDelete(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("품목정보관리 파일 삭제");
		try {
			itemInfoAdmService.itemFileDelete(itemInfoAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 제품코드조회 목록조회
	@RequestMapping(value = "bm/itemInfoDtlListAll", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> itemInfoDtlListAll(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
	
		logger.info("제품코드조회 목록조회 : " + itemInfoAdmVo);
		try {
			List<ItemInfoAdmVo> ItemInfoAdmVoList = itemInfoAdmService.itemInfoDtlListAll(itemInfoAdmVo);
			jsonData.put("data", ItemInfoAdmVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//제품코드, 자재 조회 목록
	@RequestMapping(value = "bm/itemInfoAndMatrlListAll", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> itemInfoAndMatrlListAll(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
	
		logger.info("제품코드, 자재 조회 목록 : " + itemInfoAdmVo);
		try {
			List<ItemInfoAdmVo> ItemInfoAdmVoList = itemInfoAdmService.itemInfoAndMatrlListAll(itemInfoAdmVo);
			jsonData.put("data", ItemInfoAdmVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//상품코드, 자재 조회 목록
	@RequestMapping(value = "bm/goodsInfoAndMatrlLstAll", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> goodsInfoAndMatrlLstAll(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
	
		logger.info("상품코드, 자재 조회 목록 : " + itemInfoAdmVo);
		try {
			List<ItemInfoAdmVo> ItemInfoAdmVoList = itemInfoAdmService.goodsInfoAndMatrlLstAll(itemInfoAdmVo);
			jsonData.put("data", ItemInfoAdmVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 투입자재 목록조회
	@RequestMapping(value = "bm/itemBomList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> itemBomList(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
	
		logger.info("투입자재 목록조회 : " + itemInfoAdmVo);
		try {
			List<ItemInfoAdmVo> ItemInfoAdmVoList = itemInfoAdmService.itemBomList(itemInfoAdmVo);
			jsonData.put("data", ItemInfoAdmVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//투입자재 등록
	@RequestMapping(value = "bm/itemBomInsert", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> itemBomInsert(ItemInfoAdmVo itemInfoAdmVo,
															@RequestParam(value="insertList", required=false) String insertList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("투입자재 등록");
		try {
			itemInfoAdmVo.setInsertList(insertList);
			itemInfoAdmVo.setRegIdx(Utils.getUserIdx());
			itemInfoAdmVo.setRegDate(DateUtil.getCurrentDateTime());
			itemInfoAdmService.itemBomInsert(itemInfoAdmVo);
			jsonData.put("result", "ok");
		
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//투입자재 삭제
	@RequestMapping(value = "bm/itemBomDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> itemBomDelete(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("투입자재 삭제");
		try {
			itemInfoAdmService.itemBomDelete(itemInfoAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 공정 목록조회
	@RequestMapping(value = "bm/itemPrcssList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> itemPrcssList(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
	
		logger.info("공정 목록조회 : " + itemInfoAdmVo);
		try {
			List<ItemInfoAdmVo> ItemInfoAdmVoList = itemInfoAdmService.itemPrcssList(itemInfoAdmVo);
			jsonData.put("data", ItemInfoAdmVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//공정 등록
	@RequestMapping(value = "bm/itemPrcssInsert", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> itemPrcssInsert(ItemInfoAdmVo itemInfoAdmVo,
															@RequestParam(value="insertList", required=false) String insertList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("공정 등록");
		try {
			itemInfoAdmVo.setInsertList(insertList);
			itemInfoAdmVo.setRegIdx(Utils.getUserIdx());
			itemInfoAdmVo.setRegDate(DateUtil.getCurrentDateTime());
			itemInfoAdmService.itemPrcssInsert(itemInfoAdmVo);
			jsonData.put("result", "ok");
		
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//공정 삭제
	@RequestMapping(value = "bm/itemPrcssDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> itemPrcssDelete(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("공정 삭제");
		try {
			itemInfoAdmService.itemPrcssDelete(itemInfoAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//품목정보관리 번들링 목록조회
	@RequestMapping(value = "bm/bundleInfoList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bundleInfoList(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();

		logger.info("품목정보관리 번들링 목록조회 : " + itemInfoAdmVo);
		try {
			List<ItemInfoAdmVo> ItemInfoAdmVoList = itemInfoAdmService.bundleInfoList(itemInfoAdmVo);
			jsonData.put("data", ItemInfoAdmVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//품목정보관리 번들링 목록조회
	@RequestMapping(value = "bm/bundleInfoListByWorkOrdPrcssIdx", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bundleInfoListByWorkOrdPrcssIdx(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("품목정보관리 번들링 목록조회 : " + itemInfoAdmVo);
		try {
			List<ItemInfoAdmVo> ItemInfoAdmVoList = itemInfoAdmService.bundleInfoListByWorkOrdPrcssIdx(itemInfoAdmVo);
			jsonData.put("data", ItemInfoAdmVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//품목정보관리 번들링 등록
	@RequestMapping(value = "bm/bundleInfoInsert", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bundleInfoInsert(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("품목정보관리 번들링 등록");
		try {
			itemInfoAdmVo.setRegIdx(Utils.getUserIdx());
			itemInfoAdmVo.setRegDate(DateUtil.getCurrentDateTime());
			itemInfoAdmVo.setUpdIdx(Utils.getUserIdx());
			itemInfoAdmVo.setUpdDate(DateUtil.getCurrentDateTime());
			itemInfoAdmService.bundleInfoInsert(itemInfoAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//품목정보관리 번들링 삭제
	@RequestMapping(value = "bm/bundleInfoDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bundleInfoDelete(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("품목정보관리 번들링 삭제");
		try {
			itemInfoAdmService.bundleInfoDelete(itemInfoAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
}
