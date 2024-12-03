package mes.web.bm;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import mes.domain.bm.ItemPrcssRoutingVo;
import mes.domain.bm.PrcssInfoVo;
import mes.service.bm.ItemPrcssRoutingService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
@RequestMapping("/")
public class ItemPrcssRoutingController {
	
	@Inject
	private ItemPrcssRoutingService itemPrcssRoutingService;
			
	private static final Logger logger = LoggerFactory.getLogger(PrcssInfoController.class);
	
	// bmsc0110
	@RequestMapping(value = "/bm/bmsc0110", method = RequestMethod.GET)
	public ModelAndView bmsc0110(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /bm/bmsc0110");
		mav.setViewName("/bm/bmsc0110");
		return mav;
	}
	
	//공정라우팅 목록조회
	@RequestMapping(value = "bm/itemPrcssRoutingListAll", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> itemPrcssRoutingListAll(ItemPrcssRoutingVo itemPrcssRoutingVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("공정라우팅 목록조회 : " + itemPrcssRoutingVo);
		try {
			List<ItemPrcssRoutingVo> itemPrcssRoutingVoList = itemPrcssRoutingService.itemPrcssRoutingListAll(itemPrcssRoutingVo);
			jsonData.put("data", itemPrcssRoutingVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//공정라우팅 상세 목록조회
	@RequestMapping(value = "bm/itemPrcssRoutingSel", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> itemPrcssRoutingSel(ItemPrcssRoutingVo itemPrcssRoutingVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("공정라우팅 상세 목록조회 : " + itemPrcssRoutingVo);
		try {
			List<ItemPrcssRoutingVo> itemPrcssRoutinglist = new ArrayList<>();
			if(itemPrcssRoutingVo.getRoutingNo()!=null) {
				itemPrcssRoutinglist = itemPrcssRoutingService.itemPrcssRoutingSel(itemPrcssRoutingVo);
			}
			
			jsonData.put("data", itemPrcssRoutinglist);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//공정라우팅 등록
	@RequestMapping(value = "bm/itemPrcssRoutingInsert", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> itemPrcssRoutingInsert(ItemPrcssRoutingVo itemPrcssRoutingVo,
																	@RequestParam(value="array", required=false) String array) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("공정라우팅 등록 : " +itemPrcssRoutingVo);
		try {
			
			itemPrcssRoutingVo.setInsertList(array);
			itemPrcssRoutingVo.setRegIdx(Utils.getUserIdx());
			itemPrcssRoutingVo.setRegDate(DateUtil.getCurrentDateTime());
			itemPrcssRoutingVo.setUpdIdx(Utils.getUserIdx());
			itemPrcssRoutingVo.setUpdDate(DateUtil.getCurrentDateTime());
			
			int checkCnt = 0;
			if(itemPrcssRoutingVo.getSetView().equals("add")) {
				checkCnt = itemPrcssRoutingService.itemPrcssRoutingNoDupCheck(itemPrcssRoutingVo);
			}
			
			if(checkCnt==0) {
				itemPrcssRoutingService.itemPrcssRoutingInsert(itemPrcssRoutingVo);
				jsonData.put("result", "ok");	
			} else {
				jsonData.put("message", "이미 등록되어있는<br>라우팅 번호 입니다.");
				jsonData.put("result", "fail");
			}

		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//공정라우팅 수정
	@RequestMapping(value = "bm/itemPrcssRoutingUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> itemPrcssRoutingUpdate(ItemPrcssRoutingVo itemPrcssRoutingVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("공정라우팅 수정");
		try {
			itemPrcssRoutingVo.setUpdIdx(Utils.getUserIdx());
			itemPrcssRoutingVo.setUpdDate(DateUtil.getCurrentDateTime());
			
			int checkCnt = itemPrcssRoutingService.itemPrcssRoutingNoDupCheck(itemPrcssRoutingVo);
			if(checkCnt == 0) {
				itemPrcssRoutingService.itemPrcssRoutingUpdate(itemPrcssRoutingVo);
				jsonData.put("result", "ok");	
			} else {
				jsonData.put("message", "이미 등록되어있는 공정코드입니다.");
				jsonData.put("result", "fail");
			}
	
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//공정라우팅 삭제
	@RequestMapping(value = "bm/itemPrcssRoutingDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> itemPrcssRoutingDelete(ItemPrcssRoutingVo itemPrcssRoutingVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("공정라우팅 삭제 : " + itemPrcssRoutingVo);
		try {
			itemPrcssRoutingService.itemPrcssRoutingDelete(itemPrcssRoutingVo);
			jsonData.put("data", itemPrcssRoutingVo);
			jsonData.put("result", "ok");	
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	
}
