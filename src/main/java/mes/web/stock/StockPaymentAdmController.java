package mes.web.stock;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import mes.domain.stock.StockPaymentAdmVo;
import mes.service.stock.StockPaymentAdmService;
import mes.web.ut.Utils;

@Controller
public class StockPaymentAdmController {
	private static final Logger logger = LoggerFactory.getLogger(StockPaymentAdmController.class);
	
	@Inject
	private StockPaymentAdmService stockPaymentAdmService;
	
	// 현재고현황 목록조회
	@RequestMapping(value = "stock/stockPaymentAdmStatusLst", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> stockPaymentAdmStatusLst(StockPaymentAdmVo stockPaymentAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("현재고현황 목록조회");
		try {
			List<StockPaymentAdmVo> stockPaymentAdmVoList = stockPaymentAdmService.stockPaymentAdmStatusLst(stockPaymentAdmVo);
			jsonData.put("data", stockPaymentAdmVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 현재고현황 목록조회 - 제품
	@RequestMapping(value = "stock/stockPaymentAdmItemLst", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> stockPaymentAdmItemLst(StockPaymentAdmVo stockPaymentAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("현재고현황 목록조회 - 제품");
		try {
			List<StockPaymentAdmVo> stockPaymentAdmVoList = stockPaymentAdmService.stockPaymentAdmItemLst(stockPaymentAdmVo);
			jsonData.put("data", stockPaymentAdmVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 현재고현황 목록조회 - 자재
	@RequestMapping(value = "stock/stockPaymentAdmMatrlLst", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> stockPaymentAdmMatrlLst(StockPaymentAdmVo stockPaymentAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("현재고현황 목록조회 - 자재");
		try {
			List<StockPaymentAdmVo> stockPaymentAdmVoList = stockPaymentAdmService.stockPaymentAdmMatrlLst(stockPaymentAdmVo);
			jsonData.put("data", stockPaymentAdmVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 재고이동 목록조회
	@RequestMapping(value = "stock/stockPaymentMoveLst", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> stockPaymentMoveLst(StockPaymentAdmVo stockPaymentAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("재고이동 목록조회");
		try {
			List<StockPaymentAdmVo> stockPaymentAdmVoList = stockPaymentAdmService.stockPaymentMoveLst(stockPaymentAdmVo);
			jsonData.put("data", stockPaymentAdmVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 재고이력-자재 조회
	@RequestMapping(value = "stock/stockPaymentAdmOriginalLst2", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> stockPaymentAdmOriginalLst2(StockPaymentAdmVo stockPaymentAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수불원장 목록조회");
		try {
			List<StockPaymentAdmVo> stockPaymentAdmVoList = new ArrayList<StockPaymentAdmVo>();
			if(stockPaymentAdmVo.getItemIdx()!=null && !stockPaymentAdmVo.getItemIdx().equals("")) {
				stockPaymentAdmVoList = stockPaymentAdmService.stockPaymentAdmOriginalLst(stockPaymentAdmVo);
			}
			
			jsonData.put("data", stockPaymentAdmVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
		
		
	// 수불원장 목록조회
	@RequestMapping(value = "stock/stockPaymentAdmOriginalLst", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> stockPaymentAdmOriginalLst(StockPaymentAdmVo stockPaymentAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수불원장 목록조회");
		try {
			List<StockPaymentAdmVo> stockPaymentAdmVoList = stockPaymentAdmService.stockPaymentAdmOriginalLst(stockPaymentAdmVo);
			jsonData.put("data", stockPaymentAdmVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	// 불용재고현황 목록조회
	@RequestMapping(value = "stock/obsoleteStockLst", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> obsoleteStockLst(StockPaymentAdmVo stockPaymentAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("불용재고현황 목록조회");
		try {
			List<StockPaymentAdmVo> stockPaymentAdmVoList = stockPaymentAdmService.obsoleteStockLst(stockPaymentAdmVo);
			jsonData.put("data", stockPaymentAdmVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
}
