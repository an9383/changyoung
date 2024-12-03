package mes.web.wm;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.binary.StringUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.mindrot.jbcrypt.BCrypt;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import mes.domain.bm.ItemInfoAdmVo;
import mes.domain.bm.LocationVo;
import mes.domain.bm.WoodenInfoVo;
import mes.domain.bs.BizOrderVo;
import mes.domain.pm.PurchaseOrderVo;
import mes.domain.sm.CommonCodeVo;
import mes.domain.stock.InProdWhsAdmVo;
import mes.domain.stock.OutMatrWhsAdmVo;
import mes.domain.stock.OutProdWhsAdmVo;
import mes.domain.stock.StockManagementVo;
import mes.domain.stock.StockPaymentAdmVo;
import mes.domain.wm.ItemPurchaseVo;
import mes.domain.wm.WorkOrderVo;
import mes.domain.wm.WorkResultStatusVo;
import mes.service.bm.ItemInfoAdmService;
import mes.service.bm.LocationService;
import mes.service.bm.WoodenInfoService;
import mes.service.bs.BizOrderService;
import mes.service.pm.PurchaseOrderService;
import mes.service.sm.CommonCodeService;
import mes.service.stock.InProdWhsAdmService;
import mes.service.stock.OutMatrWhsAdmService;
import mes.service.stock.OutProdWhsAdmService;
import mes.service.stock.StockPaymentAdmService;
import mes.service.wm.WorkOrderService;
import mes.service.wm.WorkResultStatusService;
import mes.web.stock.StockManagementController;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
@RequestMapping("/")
public class WorkResultStatusController {

	@Inject
	private WorkResultStatusService workResultStatusService;
	@Inject
	private CommonCodeService commonCodeService;

	private static final Logger logger = LoggerFactory.getLogger(WorkResultStatusController.class);

	// wmsc0080
	@RequestMapping(value = "/wm/wmsc0080", method = RequestMethod.GET)
	public ModelAndView wmsc0080(ModelAndView mav, HttpServletRequest request) throws Exception {
		logger.info("page : /wm/wmsc0080");
		
		CommonCodeVo commonCodeVo = new CommonCodeVo();
		commonCodeVo.setCommonType("시스템");
		commonCodeVo.setCommonCd("057");;
		List<CommonCodeVo> workList = commonCodeService.commonCodeDtlLstByCommonCd(commonCodeVo);
		Comparator<CommonCodeVo> etc2Comparator = Comparator.comparingInt(vo -> Integer.parseInt(vo.getEtc2()));
		// 오름차순으로 정렬
        Collections.sort(workList, etc2Comparator);
		mav.addObject("workList", workList);
		mav.setViewName("/wm/wmsc0080");
		return mav;
	}
	
	//작업자별 - 일별실적현황 
	@RequestMapping(value = "wm/dailyWorkResultLstByWorkId", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> dailyWorkResultLstByWorkId(WorkResultStatusVo workResultStatusVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("작업자별 - 일별실적현황");
		try {
			List<Map<String,String>> workOrderVoList = workResultStatusService.dailyWorkResultLstByWorkId(workResultStatusVo);
			jsonData.put("data", workOrderVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
}
