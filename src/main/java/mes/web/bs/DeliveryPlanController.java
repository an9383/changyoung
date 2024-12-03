package mes.web.bs;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.binary.StringUtils;
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

import mes.domain.bm.ItemInfoAdmVo;
import mes.domain.bm.LocationVo;
import mes.domain.bs.BizOrderVo;
import mes.domain.bs.DeliveryPlanVo;
import mes.domain.pm.PurchaseOrderVo;
import mes.domain.sm.CommonCodeVo;
import mes.domain.stock.OutMatrWhsAdmVo;
import mes.domain.stock.OutProdWhsAdmVo;
import mes.domain.stock.StockManagementVo;
import mes.domain.stock.StockPaymentAdmVo;
import mes.domain.wm.WorkOrderVo;
import mes.domain.wm.WorkPlanVo;
import mes.service.bm.LocationService;
import mes.service.bs.BizOrderService;
import mes.service.bs.DeliveryPlanService;
import mes.service.pm.PurchaseOrderService;
import mes.service.stock.OutMatrWhsAdmService;
import mes.service.stock.OutProdWhsAdmService;
import mes.service.stock.StockPaymentAdmService;
import mes.service.wm.WorkOrderService;
import mes.service.wm.WorkPlanService;
import mes.web.stock.StockManagementController;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class DeliveryPlanController {
	
	@Inject
	private DeliveryPlanService deliveryPlanService;
	
	private static final Logger logger = LoggerFactory.getLogger(DeliveryPlanController.class);
	
	//납품계획 목록조회
	@RequestMapping(value = "bs/deliveryPlanAdmLst", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> bizOrderDtlDel(DeliveryPlanVo deliveryPlanVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("납품계획 목록조회");
		try {
			List<DeliveryPlanVo> deliveryPlanVoList = deliveryPlanService.deliveryPlanAdmLst(deliveryPlanVo);
			jsonData.put("data", deliveryPlanVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//납품계획 등록 / 수정
	@RequestMapping(value = "bs/deliveryPlanAdmIU", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> deliveryPlanAdmIU(DeliveryPlanVo deliveryPlanVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("납품계획 목록조회");
		try {
			deliveryPlanVo.setRegIdx(Utils.getUserIdx());
			deliveryPlanVo.setRegDate(DateUtil.getCurrentDateTime());
			deliveryPlanVo.setUpdIdx(Utils.getUserIdx());
			deliveryPlanVo.setUpdDate(DateUtil.getCurrentDateTime());
			
			deliveryPlanService.deliveryPlanAdmIns(deliveryPlanVo);
			deliveryPlanService.deliveryPlanAdmUpd(deliveryPlanVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//납품계획 삭제
	@RequestMapping(value = "bs/deliveryPlanAdmDel", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> deliveryPlanAdmDel(DeliveryPlanVo deliveryPlanVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("납품계획 삭제");
		try {
			deliveryPlanService.deliveryPlanAdmDel(deliveryPlanVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
}
