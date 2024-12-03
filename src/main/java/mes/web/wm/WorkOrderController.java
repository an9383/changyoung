package mes.web.wm;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
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

import com.fasterxml.jackson.databind.ObjectMapper;

import mes.domain.bm.ItemInfoAdmVo;
import mes.domain.bm.LocationVo;
import mes.domain.bm.WoodenInfoVo;
import mes.domain.bs.BizOrderVo;
import mes.domain.pm.PurchaseOrderVo;
import mes.domain.qm.ProdQualityVo;
import mes.domain.sm.CommonCodeVo;
import mes.domain.stock.InProdWhsAdmVo;
import mes.domain.stock.OutMatrWhsAdmVo;
import mes.domain.stock.OutProdWhsAdmVo;
import mes.domain.stock.StockManagementVo;
import mes.domain.stock.StockPaymentAdmVo;
import mes.domain.wm.ItemPurchaseVo;
import mes.domain.wm.WorkOrderVo;
import mes.service.bm.ItemInfoAdmService;
import mes.service.bm.LocationService;
import mes.service.bm.WoodenInfoService;
import mes.service.bs.BizOrderService;
import mes.service.pm.PurchaseOrderService;
import mes.service.qm.ProdQualityService;
import mes.service.sm.CommonCodeService;
import mes.service.stock.InProdWhsAdmService;
import mes.service.stock.OutMatrWhsAdmService;
import mes.service.stock.OutProdWhsAdmService;
import mes.service.stock.StockPaymentAdmService;
import mes.service.wm.WorkOrderService;
import mes.web.stock.StockManagementController;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
@RequestMapping("/")
public class WorkOrderController {

	@Inject
	private ItemInfoAdmService itemInfoAdmService;
	@Inject
	private WoodenInfoService woodenInfoService;
	@Inject
	private LocationService locationService;
	@Inject
	private WorkOrderService workOrderService;
	@Inject
	private PurchaseOrderService purchaseOrderService;
	@Inject
	private StockManagementController stockManagementController;
	@Inject
	private OutMatrWhsAdmService outMatrWhsAdmService;
	@Inject
	private OutProdWhsAdmService outProdWhsAdmService;
	@Inject
	private StockPaymentAdmService stockPaymentAdmService;
	@Inject
	private InProdWhsAdmService inProdWhsAdmService;
	@Inject
	private BizOrderService bizOrderService;
	@Inject
	private CommonCodeService commonCodeService;
	@Inject
	private ProdQualityService prodQualityService;

	private static final Logger logger = LoggerFactory.getLogger(WorkOrderController.class);

	// wmsc0020
	@RequestMapping(value = "/wm/wmsc0020", method = RequestMethod.GET)
	public ModelAndView wmsc0020(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /wm/wmsc0020");
		mav.setViewName("/wm/wmsc0020");
		return mav;
	}

	// wmsc0030
	@RequestMapping(value = "/wm/wmsc0030", method = RequestMethod.GET)
	public ModelAndView wmsc0030(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /wm/wmsc0030");
		mav.setViewName("/wm/wmsc0030");
		return mav;
	}

	// wmsc0040
	@RequestMapping(value = "/wm/wmsc0040", method = RequestMethod.GET)
	public ModelAndView wmsc0040(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /wm/wmsc0040");
		mav.setViewName("/wm/wmsc0040");
		return mav;
	}

	// wmsc0050
	@RequestMapping(value = "/wm/wmsc0050", method = RequestMethod.GET)
	public ModelAndView wmsc0050(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /wm/wmsc0050");
		mav.setViewName("/wm/wmsc0050");
		return mav;
	}

	// wmsc0060
	@RequestMapping(value = "/wm/wmsc0060", method = RequestMethod.GET)
	public ModelAndView wmsc0060(ModelAndView mav, HttpServletRequest request) {
		logger.info("page : /wm/wmsc0060");
		mav.setViewName("/wm/wmsc0060");
		return mav;
	}

	// 작업지시서 상세 조회
	@RequestMapping(value = "wm/workOrdDtlLstWithPrcssByOrdDate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrdDtlLstWithPrcssByOrdDate(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("작업지시서 상세 조회");
		try {
			List<WorkOrderVo> workOrderVoList = workOrderService.workOrdDtlLstWithPrcssByOrdDate(workOrderVo);
			jsonData.put("data", workOrderVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}

	// 작업지시서 상세 조회
	@RequestMapping(value = "wm/workOrdDtlLstWithPrcssByBizDtlIdx", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrdDtlLstWithPrcssByBizDtlIdx(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("작업지시서 상세 조회");
		try {
			List<WorkOrderVo> workOrderVoList = workOrderService.workOrdDtlLstWithPrcssByBizDtlIdx(workOrderVo);
			jsonData.put("data", workOrderVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}

	// 작업지시서 목록(공정별) 조회
	@RequestMapping(value = "wm/workOrdLstWithPrcssByOrdDate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrdLstWithPrcssByOrdDate(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("작업지시서 목록(공정별) 조회");
		try {
			workOrderVo.setLoginUserIdx(Utils.getUserIdx());
			List<WorkOrderVo> workOrderVoList = workOrderService.workOrdLstWithPrcssByOrdDate(workOrderVo);
			jsonData.put("data", workOrderVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}

	// 작업지시서 목록(공정별) 조회-작지기준
	@RequestMapping(value = "wm/workOrdLstWithPrcssByWorkOrd", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrdLstWithPrcssByWorkOrd(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("작업지시서 목록(공정별) 조회-작지기준");
		try {
			List<WorkOrderVo> workOrderVoList = workOrderService.workOrdLstWithPrcssByWorkOrd(workOrderVo);
			jsonData.put("data", workOrderVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}

	// 작업지시서 목록(공정별) 조회-수주상세식별자기준
	@RequestMapping(value = "wm/workOrdLstWithPrcssByBizOrdDtlIdx", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrdLstWithPrcssByBizOrdDtlIdx(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("작업지시서 목록(공정별) 조회-수주상세식별자기준");
		try {
			List<WorkOrderVo> workOrderVoList = workOrderService.workOrdLstWithPrcssByBizOrdDtlIdx(workOrderVo);
			jsonData.put("data", workOrderVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}

	// 작업지시서 목록(생산진행현황) 조회
	@RequestMapping(value = "wm/workOrdPrcssStatusLst", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrdPrcssStatusLst(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("작업지시서 목록(생산진행현황) 조회");
		try {
			List<WorkOrderVo> workOrderVoList = workOrderService.workOrdPrcssStatusLst(workOrderVo);
			jsonData.put("data", workOrderVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}

	// 작업지시서 목록(기간별생산현황) 조회
	@RequestMapping(value = "wm/workOrdPrcssStatusLstOrderByDealCorp", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrdPrcssStatusLstOrderByDealCorp(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("작업지시서 목록(기간별생산현황) 조회");
		try {
			List<WorkOrderVo> workOrderVoList = workOrderService.workOrdPrcssStatusLstOrderByDealCorp(workOrderVo);
			jsonData.put("data", workOrderVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}

	// 작업지시서 목록(기간별생산현황,지시일 오름차순) 조회
	@RequestMapping(value = "wm/workOrdPrcssStatusLstOrderByworkOrdDate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrdPrcssStatusLstOrderByworkOrdDate(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("작업지시서 목록(기간별생산현황,지시일 오름차순) 조회");
		try {
			List<WorkOrderVo> workOrderVoList = workOrderService.workOrdPrcssStatusLstOrderByworkOrdDate(workOrderVo);
			jsonData.put("data", workOrderVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}

	// 작업지시서 목록(공정별) 현공정 정보 조회
	@RequestMapping(value = "wm/workOrdSelWithPrcss", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrdSelWithPrcss(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("작업지시서 목록(공정별) 현공정 정보 조회");
		try {
			workOrderVo = workOrderService.workOrdSelWithPrcss(workOrderVo);

			jsonData.put("data", workOrderVo);
			jsonData.put("result", "ok");

		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}

	// 작업지시서 목록(공정별) 현공정 작업대기 업데이트
	@RequestMapping(value = "wm/workOrdPrcssWait", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrdPrcssWait(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("작업지시서 목록(공정별) 작업대기 업데이트");
		try {

			WorkOrderVo checkVo = new WorkOrderVo();
			checkVo = workOrderService.workOrdSelWithPrcss(workOrderVo);
			if (!"Y".equals(checkVo.getBizStopYn())) {
				// 수주 진행일때만 진행취소 가능하도록
				if ("02".equals(checkVo.getBizStatusCd())) {
					// 실적이 없을 경우 진행취소
					List<WorkOrderVo> workOrderResultList = workOrderService.workOrdResultListByPrcss(workOrderVo);
					if (workOrderResultList.size() == 0) {
						workOrderVo.setUpdIdx(Utils.getUserIdx());
						workOrderVo.setUpdDate(DateUtil.getCurrentDateTime());
						workOrderVo.setWorkTime(""); //시작시간 빈값으로 변경
						workOrderService.workOrdPrcssWait(workOrderVo);
						jsonData.put("data", workOrderVo);
						jsonData.put("result", "ok");
					} else {
						jsonData.put("message", "생산 실적을 삭제 후 시도해주세요.");
						jsonData.put("result", "fail");
					}
				} else {
					jsonData.put("message", "수주 진행일 경우에만<br>진행취소 할 수 있습니다.");
					jsonData.put("result", "fail");
				}
			} else {
				jsonData.put("message", "수주 중지되어<br>진행취소 할 수 없습니다.");
				jsonData.put("result", "fail");
			}

		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}

	// 작업지시서 인쇄
	@RequestMapping(value = "wm/workOrdPaperPrint", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrdPaperPrint(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("작업지시서 인쇄");
		try {
			workOrderVo.setUpdIdx(Utils.getUserIdx());
			workOrderVo.setUpdDate(DateUtil.getCurrentDateTime());
			workOrderService.workOrdPaperPrint(workOrderVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}

	// 작업지시 공정 강제 완료 처리
	@RequestMapping(value = "wm/workOrdForcedPrcssEnd", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrdForcedPrcssEnd(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("작업지시 공정 강제 완료 처리");
		try {
			BizOrderVo bizOrderVo = new BizOrderVo();
			bizOrderVo.setIdx(workOrderVo.getBizOrdDtlIdx());
			bizOrderVo = bizOrderService.bizOrderDtlSel(bizOrderVo);

			if (!"Y".equals(bizOrderVo.getBizStopYn())) {
				if ("02".equals(bizOrderVo.getBizStatusCd())) {
					workOrderVo.setUpdIdx(Utils.getUserIdx());
					workOrderVo.setUpdDate(DateUtil.getCurrentDateTime());
					workOrderService.workOrdForcedPrcssEnd(workOrderVo);
					jsonData.put("data", workOrderVo);
					jsonData.put("result", "ok");
				} else {
					jsonData.put("message", "수주 진행인 경우에만<br>강제완료 할 수 있습니다.");
					jsonData.put("result", "fail");
				}
			} else {
				jsonData.put("message", "수주 중지되어<br>강제완료 할 수 없습니다.");
				jsonData.put("result", "fail");
			}

		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}

	// 작업지시서 목록(공정별) 현공정 작업시작
	@RequestMapping(value = "wm/workOrdPrcssStart", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrdPrcssStart(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("작업지시서 목록(공정별) 현공정 작업시작");
		try {
			String fstr = DateUtil.getToday("yyyymmddhhmm").substring(0,8);
			String sstr = DateUtil.getToday("yyyymmddhhmm").substring(8,12);
			
			// 전공정상태체크
			WorkOrderVo checkVo = new WorkOrderVo();
			checkVo = workOrderService.checkWorkOrdPrcssFinish(workOrderVo);
			// 조회된 항목이 null 인경우 -> 첫 공정인 상태
			if (checkVo != null) {
				// 전 공정에 묶인 수주가 중지가 아닌 경우
				if (!"Y".equals(checkVo.getBizStopYn())) {
					// 수주진행상태일때
					if ("02".equals(checkVo.getBizStatusCd())) {
						// 현공정정보
						workOrderVo = workOrderService.workOrdSelWithPrcss(workOrderVo);
						// 공정 체크시 WC = 완료인 경우 / 또는 현공정이 첫공정인 경우 예외
						if ("WC".equals(checkVo.getProgressStatus()) || "Y".equals(workOrderVo.getFirstPrcssYn())) {
							if ("Y".equals(checkVo.getFirstPrcssYn())
									&& (int) Double.parseDouble(checkVo.getBeforePrcssCnt()) == 0) {
								// 전 공정정보가 첫공정이었을 경우 -> 이전공정들이 모두 완료되야 진행가능
								// 현 공정정보가 대기인 경우
								if ("PI".equals(workOrderVo.getProgressStatus())) {
									if ("Y".equals(workOrderVo.getDescCheckYn())
											|| "".equals(workOrderVo.getBeforePrcssDesc())
											|| workOrderVo.getBeforePrcssDesc() == null) {
										workOrderVo.setUpdIdx(Utils.getUserIdx());
										workOrderVo.setUpdDate(DateUtil.getCurrentDateTime());
										workOrderVo.setWorkTime(fstr+" "+sstr);
										logger.info("startTime:"+workOrderVo);
										workOrderService.workOrdPrcssStart(workOrderVo);
										jsonData.put("data", workOrderVo);
										jsonData.put("result", "ok");
									} else {
										jsonData.put("message", "전체공정 특이사항을<br>확인 후 작업해주세요.");
										jsonData.put("result", "fail");
									}
								} else if ("WI".equals(workOrderVo.getProgressStatus())) { // 현 공정정보가 진행인 경우
									jsonData.put("message", "이미 공정이 진행 중입니다.");
									jsonData.put("result", "fail");
								} else if ("WC".equals(workOrderVo.getProgressStatus())) { // 현 공정정보가 완료인 경우
									jsonData.put("message", "이미 작업완료된 공정입니다.");
									jsonData.put("result", "fail");
								}
							} else if (!"Y".equals(checkVo.getFirstPrcssYn())) {
								// 전 공정정보가 첫공정이 아니었을 경우 -> 전 공정만 완료되면 진행 가능

								// 현 공정정보가 대기인 경우
								if ("PI".equals(workOrderVo.getProgressStatus())) {
									if ("Y".equals(workOrderVo.getDescCheckYn())
											|| "".equals(workOrderVo.getBeforePrcssDesc())
											|| workOrderVo.getBeforePrcssDesc() == null) {
										workOrderVo.setUpdIdx(Utils.getUserIdx());
										workOrderVo.setUpdDate(DateUtil.getCurrentDateTime());
										workOrderVo.setWorkTime(fstr+" "+sstr);
										workOrderService.workOrdPrcssStart(workOrderVo);
										jsonData.put("data", workOrderVo);
										jsonData.put("result", "ok");
									} else {
										jsonData.put("message", "전체공정 특이사항을<br>확인 후 작업해주세요.");
										jsonData.put("result", "fail");
									}
								} else if ("WI".equals(workOrderVo.getProgressStatus())) { // 현 공정정보가 진행인 경우
									jsonData.put("message", "이미 공정이 진행 중입니다.");
									jsonData.put("result", "fail");
								} else if ("WC".equals(workOrderVo.getProgressStatus())) { // 현 공정정보가 완료인 경우
									jsonData.put("message", "이미 작업완료된 공정입니다.");
									jsonData.put("result", "fail");
								}
							} else {
								// 전 공정정보가 첫공정이었고 이전공정들이 완료 안된 경우
								jsonData.put("message", "이전 공정들 중 작업이<br>완료되지 않은 공정이 있습니다.");
								jsonData.put("result", "fail");
							}

						} else if ("WI".equals(checkVo.getProgressStatus())) { // 전 공정체크시 WI = 진행인 경우
							jsonData.put("message", "전 공정이 진행 중입니다.<br>전 공정명 : " + checkVo.getPrcssNm() + "");
							jsonData.put("result", "fail");
						} else if ("PI".equals(checkVo.getProgressStatus())) { // 전 공정체크시 Pi = 대기인 경우
							jsonData.put("message", "전 공정이 진행되지 않았습니다.<br>전 공정명 : " + checkVo.getPrcssNm() + "");
							jsonData.put("result", "fail");
						}
					} else {
						jsonData.put("message", "수주 진행이 아닌 공정입니다.");
						jsonData.put("result", "fail");
					}
				} else {
					jsonData.put("message", "수주 중지된 공정입니다.");
					jsonData.put("result", "fail");
				}
			} else {
				// 첫공정
				workOrderVo = workOrderService.workOrdSelWithPrcss(workOrderVo);
				// 현 공정에 묶인 수주가 중지가 아닌 경우
				if (!"Y".equals(workOrderVo.getBizStopYn())) {
					// 수주진행상태일때
					if ("02".equals(workOrderVo.getBizStatusCd())) {
						// 현 공정정보가 대기인 경우
						if ("PI".equals(workOrderVo.getProgressStatus())) {
							workOrderVo.setUpdIdx(Utils.getUserIdx());
							workOrderVo.setUpdDate(DateUtil.getCurrentDateTime());
							workOrderService.workOrdPrcssStart(workOrderVo);
							jsonData.put("data", workOrderVo);
							jsonData.put("result", "ok");
						} else if ("WI".equals(workOrderVo.getProgressStatus())) { // 현 공정정보가 진행인 경우
							jsonData.put("message", "이미 공정이 진행 중입니다.");
							jsonData.put("result", "fail");
						} else if ("WC".equals(workOrderVo.getProgressStatus())) { // 현 공정정보가 완료인 경우
							jsonData.put("message", "이미 작업완료된 공정입니다.");
							jsonData.put("result", "fail");
						}
					} else {
						jsonData.put("message", "수주 진행이 아닌 공정입니다.");
						jsonData.put("result", "fail");
					}
				} else {
					jsonData.put("message", "수주 중지된 공정입니다.");
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

	// 작업지시서 목록(공정별) 현공정 작업완료
	@RequestMapping(value = "wm/workOrdPrcssEnd", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrdPrcssEnd(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("작업지시서 목록(공정별) 현공정 작업완료");
		try {
			String fstr = DateUtil.getToday("yyyymmddhhmm").substring(0,8);
			String sstr = DateUtil.getToday("yyyymmddhhmm").substring(8,12);
			
			WorkOrderVo checkVo = workOrderService.workOrdSelWithPrcss(workOrderVo);
			if (!"Y".equals(checkVo.getBizStopYn())) {
				// 수주진행상태일때
				if ("02".equals(checkVo.getBizStatusCd())) {
					List<WorkOrderVo> workOrderResultList = workOrderService.workOrdResultListByPrcss(workOrderVo);
					// 현 공정정보가 대기인 경우
					if ("PI".equals(checkVo.getProgressStatus())) {
						jsonData.put("message", "작업 대기상태인 공정입니다.");
						jsonData.put("result", "fail");
					} else if ("WI".equals(checkVo.getProgressStatus())) { // 현 공정정보가 진행인 경우
						// 실적이 등록 안된 경우
						if (workOrderResultList.size() == 0) {
							jsonData.put("message", "생산 실적을 등록해주세요.");
							jsonData.put("result", "fail");
						} else {
							// 제품 품질창고(QC) 가능한 창고 조회
							WorkOrderVo prodLocationVo = workOrderService.workInProdLocationList(workOrderVo);
							//제품 입고 가능한 창고
							LocationVo locationVo = new LocationVo();
							LocationVo locationInVo = locationService.possibleOutItemLocationList(locationVo);
							if( locationInVo == null ) {
								jsonData.put("message", "제품 입고 가능한 창고가 <br>없습니다.");
								jsonData.put("result", "fail");
							} else if (prodLocationVo == null) {
								jsonData.put("message", "QC 입고 가능한 창고가 <br>없습니다.");
								jsonData.put("result", "fail");
							} else {
								CommonCodeVo commonCodeVo = new CommonCodeVo();
								commonCodeVo.setCommonType("시스템"); // 품질검사유무
								commonCodeVo.setCommonCd("061");
								List<CommonCodeVo> commonCodeVoList = commonCodeService.commonCodeDtlLstByCommonCd(commonCodeVo);
								
								CommonCodeVo result = commonCodeVoList.stream().filter(x -> x.getCommonNm().equals("자동적합기능")).findAny().get();
								
								String comCode = result.getCommonCd();
								
								// if("Y".equals(checkVo.getDescCheckYn()) ||
								// "".equals(checkVo.getBeforePrcssDesc()) || checkVo.getBeforePrcssDesc() ==
								// null ) {
								// 나중에 여기서 공정검사가 끝났는지도 체크할것
								workOrderVo.setRegIdx(Utils.getUserIdx());
								workOrderVo.setRegDate(DateUtil.getCurrentDateTime());
								workOrderVo.setUpdIdx(Utils.getUserIdx());
								workOrderVo.setUpdDate(DateUtil.getCurrentDateTime());
								workOrderVo.setWorkTime(fstr+" "+sstr);
								workOrderService.workOrdPrcssEnd(workOrderVo);
								
								
								// 마지막 공정일 경우 완제품 수불 발생
								if (checkVo.getPrcssNextIdx() == null) {
									// A -> 자동, M -> 수동 // 품질검사 
									if("A".equals(comCode)) {
										//품질검사 처리
										
										//수불 처리
										
										// 제품입고전표 삭제 배열
										JSONArray inProdDel_array = new JSONArray();
										// 수불 삭제 JSON배열
										JSONArray stockDel_array = new JSONArray();
										List<StockManagementVo> stockManagementVoByQcList = new ArrayList<>();
										
										InProdWhsAdmVo inProdWhsAdmVo = new InProdWhsAdmVo();
										StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();
										
										//제품 입고 처리 목록
										List<StockManagementVo> stockManagementVoList = new ArrayList<>();
										Date today = new Date(); // 오늘 날짜
										SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
										// 문자열을 Date 객체로 파싱
										String strToday = sdf.format(today);
										
										for (int i = 0; i < workOrderResultList.size(); i++) {
											StockManagementVo stockManagementVo = new StockManagementVo();
											stockManagementVo.setSmItemGubun("001"); // 001:제품 , 002:자재
											stockManagementVo.setSmItemCd(checkVo.getItemIdx()); // 품목(제품) 식별자
											stockManagementVo.setSmItemVersionIdx(checkVo.getItemVersionIdx()); // 품목(제품)버전 식별자
											stockManagementVo.setSmType("입고"); // 수불구분
											stockManagementVo.setSmType2("IPP"); // 업무구분
											stockManagementVo.setSmDate(strToday); // 수불일자
											String smQty = Double.toString( (int) Double.parseDouble( workOrderResultList.get(i).getFairQty() ) + Double.parseDouble( workOrderResultList.get(i).getStockUseQty() ) );
											stockManagementVo.setSmQty(smQty); // 수불수량
											stockManagementVo.setSmLotNo(""); // LOT번호 -> 채번이라서 빈값넘겨줌
											stockManagementVo.setSmSourceNo(workOrderResultList.get(i).getIdx()); // 원천번호 -> 생산실적의 식별자
											// stockManagementVo.setSmOutWhsGubun(""); //창고구분 -> 없음 빈값
											stockManagementVo.setSmInWhsGubun(""); // 창고구분 -> 없음 빈값
											stockManagementVo.setSmOutWhsIdx(prodLocationVo.getLocationIdx()); // 창고식별자
											stockManagementVo.setSmInWhsIdx(prodLocationVo.getLocationIdx()); // 창고식별자
											// stockManagementVo.setSmOutLocIdx(""); //위치식별자 -> 안씀 빈값
											// stockManagementVo.setSmInLocIdx(""); //위치식별자 -> 안씀 빈값

											stockManagementVo.setSmInGubun("생산"); // 입고구분
											stockManagementVo.setSmInCorpIdx(""); // 입고처
											stockManagementVo.setSmInRelationNo(workOrderResultList.get(i).getIdx()); // 연관번호->생산실적의 식별자
											stockManagementVoList.add(stockManagementVo);

											// 제품입고 전표 조회 -> 이미 입고 시킨 제품이라면 -> 제품입고전표 지우고 입고수불 지우고 등록											
											inProdWhsAdmVo.setRelationNo(workOrderResultList.get(i).getIdx());
											inProdWhsAdmVo.setInGubun("생산");
											inProdWhsAdmVo = inProdWhsAdmService.getInSlipNoByRelationNo(inProdWhsAdmVo);											

											// 해당 전표가 존재한다면 지우고 하도록
											if (inProdWhsAdmVo != null) {
												
												JSONObject inProdData = new JSONObject();
												inProdData.put("IN_SLIP_NO", inProdWhsAdmVo.getInSlipNo());
												inProdData.put("IN_SLIP_SEQ", inProdWhsAdmVo.getInSlipSeq());
												inProdDel_array.add(inProdData);
												
												
												JSONObject stockData = new JSONObject();
												stockData.put("SP_SOURCE_NO", inProdWhsAdmVo.getInSlipNo() + "-" + inProdWhsAdmVo.getInSlipSeq());
												stockDel_array.add(stockData);
												
											}
											
											//제품검사처리(INSERT)
											ProdQualityVo prodQualityVo = new ProdQualityVo();
											//인서트시키기위한 json 만들기
											ObjectMapper objectMapper = new ObjectMapper();
											HashMap<String, String> hashMap = new HashMap<>();
											hashMap.put("workOrdResultIdx", workOrderResultList.get(i).getIdx());
											hashMap.put("bizOrdDtlIdx", workOrderResultList.get(i).getBizOrdDtlIdx());
											hashMap.put("qualityJudgmentCd", "02"); //품질 합격 처리
											hashMap.put("judgmentUserIdx", Utils.getUserIdx()); 
											hashMap.put("judgmentDate", strToday); 
											hashMap.put("confirmUserIdx", Utils.getUserIdx()); 
											hashMap.put("confirmDate", strToday); 
											hashMap.put("passQty", smQty);											
											String jsonString = objectMapper.writeValueAsString(hashMap);
											prodQualityVo.setInsertList(jsonString);
											prodQualityVo.setRegIdx(Utils.getUserIdx());
											prodQualityVo.setRegDate(DateUtil.getCurrentDateTime());
											prodQualityService.prodQualityAdmInsByWork(prodQualityVo);
											
											//제품 qc창고에서 출고
											StockManagementVo stockManagementVoByQc = new StockManagementVo();
											stockManagementVoByQc.setSmItemGubun("001");
								    		stockManagementVoByQc.setSmOutGubun("품질");
								    		stockManagementVoByQc.setSmItemIdx(checkVo.getItemIdx());
								    		stockManagementVoByQc.setSmItemVersionIdx(checkVo.getItemVersionIdx());
								    		stockManagementVoByQc.setSmCarAssignment(null);
								    		//stockManagementVoByQc.setSmItemCd(jsonObject.get("itemCd").toString());
								    		stockManagementVoByQc.setSmQty(smQty);
								    		stockManagementVoByQc.setSmDate(strToday);
								    		stockManagementVoByQc.setSmOutCorpIdx(null);
								    		stockManagementVoByQc.setSmStatus("B"); //출고
								    		stockManagementVoByQc.setSmLotNo("");
								    		stockManagementVoByQc.setSmOutRelationNo(prodQualityVo.getResultCd()); 
								    		stockManagementVoByQc.setSmOutWhsGubun("");
								    		stockManagementVoByQc.setSmOutWhsIdx(prodLocationVo.getLocationIdx());
								    		stockManagementVoByQc.setSmOutLocIdx(null);
								    		stockManagementVoByQc.setSmEtc1(null);
								    		stockManagementVoByQc.setSmEtc2(null);
								    		stockManagementVoByQc.setSmEtc3(null);
								    		
								    		stockManagementVoByQc.setSmType("출고");
								    		stockManagementVoByQc.setSmType2("OQP");
								    		stockManagementVoByQc.setSmInWhsGubun("");
								    		stockManagementVoByQc.setSmInWhsIdx(prodLocationVo.getLocationIdx()); 
								    		stockManagementVoByQc.setSmLotNo("");
								    		stockManagementVoByQc.setSmInRelationNo(prodQualityVo.getResultCd());
								    		stockManagementVoByQc.setSmDesc("");
								    		stockManagementVoByQc.setSmEtc1("");
								    		stockManagementVoByQc.setSmEtc2("");
								    		stockManagementVoByQc.setSmEtc3("");
								    		stockManagementVoByQcList.add(stockManagementVoByQc);
								    		
								    		// 제품 입고 처리 목록
											List<StockManagementVo> stockManagementVoInList = new ArrayList<>();
											
											StockManagementVo stockManagementInVo = new StockManagementVo();
											stockManagementInVo.setSmItemGubun("001"); //001:제품 , 002:자재
											stockManagementInVo.setSmItemCd(checkVo.getItemIdx()); //품목(제품) 식별자
											stockManagementInVo.setSmItemVersionIdx(checkVo.getItemVersionIdx()); //품목(제품 버전) 식별자
											stockManagementInVo.setSmType("입고"); //수불구분
											stockManagementInVo.setSmType2("IQP"); //업무구분
											stockManagementInVo.setSmDate(strToday); //수불일자
											stockManagementInVo.setSmQty( smQty ); // 수불수량
											stockManagementInVo.setSmLotNo(""); //LOT번호 -> 채번이라서 빈값넘겨줌
											stockManagementInVo.setSmSourceNo(prodQualityVo.getResultCd()); //원천번호 -> 검사식별자
											stockManagementInVo.setSmInWhsGubun(""); //창고구분 -> 없음 빈값 
											stockManagementInVo.setSmOutWhsIdx(locationInVo.getIdx()); //창고식별자 
											stockManagementInVo.setSmInWhsIdx(locationInVo.getIdx()); //창고식별자  
								    		
											stockManagementInVo.setSmInGubun("품질적합"); //입고구분
											stockManagementInVo.setSmInCorpIdx(""); //입고처
											stockManagementInVo.setSmInRelationNo(prodQualityVo.getResultCd()); //원천번호 -> 검사식별자
											stockManagementVoList.add(stockManagementInVo);

										}
										inProdWhsAdmVo = new InProdWhsAdmVo();
										inProdWhsAdmVo.setDeleteJson(inProdDel_array.toJSONString());
										inProdWhsAdmService.inProdWhsAdmDel(inProdWhsAdmVo); // 제품입고 전표 삭제
										stockPaymentAdmVo = new StockPaymentAdmVo();
										stockPaymentAdmVo.setDeleteJson(stockDel_array.toJSONString());
										stockPaymentAdmService.stockPaymentAdmDel(stockPaymentAdmVo); // 제품 입고수불 삭제
										// 제품입고처리
										stockManagementController.ProdInput(stockManagementVoList);
										// 제품출고처리 ( 품질  -> 제품 )
										stockManagementController.ProdOutput(stockManagementVoByQcList);
										
										//출고 대기 처리
										BizOrderVo bizOrderVo = new BizOrderVo();
										bizOrderVo.setIdx(checkVo.getBizOrdDtlIdx());
										bizOrderVo.setBizStatusCd("06");
										bizOrderVo.setUpdIdx(Utils.getUserIdx());
										bizOrderVo.setUpdDate(DateUtil.getCurrentDateTime());
										bizOrderService.bizOrderDtlStatusUpd(bizOrderVo);
									} else {
										// 제품 입고 처리 목록
										List<StockManagementVo> stockManagementVoList = new ArrayList<>();
										Date today = new Date(); // 오늘 날짜
										SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
										// 문자열을 Date 객체로 파싱
										String strToday = sdf.format(today);
										for (int i = 0; i < workOrderResultList.size(); i++) {
											StockManagementVo stockManagementVo = new StockManagementVo();
											stockManagementVo.setSmItemGubun("001"); // 001:제품 , 002:자재
											stockManagementVo.setSmItemCd(checkVo.getItemIdx()); // 품목(제품) 식별자
											stockManagementVo.setSmItemVersionIdx(checkVo.getItemVersionIdx()); // 품목(제품)버전 식별자
											stockManagementVo.setSmType("입고"); // 수불구분
											stockManagementVo.setSmType2("IPP"); // 업무구분
											stockManagementVo.setSmDate(strToday); // 수불일자
											stockManagementVo.setSmQty(workOrderResultList.get(i).getFairQty()); // 수불수량
											stockManagementVo.setSmLotNo(""); // LOT번호 -> 채번이라서 빈값넘겨줌
											stockManagementVo.setSmSourceNo(workOrderResultList.get(i).getIdx()); // 원천번호 -> 생산실적의 식별자
											// stockManagementVo.setSmOutWhsGubun(""); //창고구분 -> 없음 빈값
											stockManagementVo.setSmInWhsGubun(""); // 창고구분 -> 없음 빈값
											stockManagementVo.setSmOutWhsIdx(prodLocationVo.getLocationIdx()); // 창고식별자
											stockManagementVo.setSmInWhsIdx(prodLocationVo.getLocationIdx()); // 창고식별자
											// stockManagementVo.setSmOutLocIdx(""); //위치식별자 -> 안씀 빈값
											// stockManagementVo.setSmInLocIdx(""); //위치식별자 -> 안씀 빈값

											stockManagementVo.setSmInGubun("생산"); // 입고구분
											stockManagementVo.setSmInCorpIdx(""); // 입고처
											stockManagementVo.setSmInRelationNo(workOrderResultList.get(i).getIdx()); // 연관번호->생산실적의 식별자
											stockManagementVoList.add(stockManagementVo);

											// 제품입고 전표 조회 -> 이미 입고 시킨 제품이라면 -> 제품입고전표 지우고 입고수불 지우고 등록
											InProdWhsAdmVo inProdWhsAdmVo = new InProdWhsAdmVo();
											inProdWhsAdmVo.setRelationNo(workOrderResultList.get(i).getIdx());
											inProdWhsAdmVo.setInGubun("생산");
											inProdWhsAdmVo = inProdWhsAdmService.getInSlipNoByRelationNo(inProdWhsAdmVo);
											StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();

											// 해당 전표가 존재한다면 지우고 하도록
											if (inProdWhsAdmVo != null) {
												// 제품입고전표 삭제 배열
												JSONArray inProdDel_array = new JSONArray();
												JSONObject inProdData = new JSONObject();
												inProdData.put("IN_SLIP_NO", inProdWhsAdmVo.getInSlipNo());
												inProdData.put("IN_SLIP_SEQ", inProdWhsAdmVo.getInSlipSeq());
												inProdDel_array.add(inProdData);
												inProdWhsAdmVo.setDeleteJson(inProdDel_array.toJSONString());

												inProdWhsAdmService.inProdWhsAdmDel(inProdWhsAdmVo); // 제품입고 전표 삭제

												// 수불 삭제 JSON배열
												JSONArray stockDel_array = new JSONArray();
												JSONObject stockData = new JSONObject();
												stockData.put("SP_SOURCE_NO", inProdWhsAdmVo.getInSlipNo() + "-" + inProdWhsAdmVo.getInSlipSeq());
												stockDel_array.add(stockData);
												stockPaymentAdmVo.setDeleteJson(stockDel_array.toJSONString());
												stockPaymentAdmService.stockPaymentAdmDel(stockPaymentAdmVo); // 제품 입고수불 삭제
											}

											// 품질 판정 테이블 미판정으로 INSERT
											// workOrderVo.setWorkOrdResultIdx(workOrderResultList.get(i).getIdx());
											// workOrderService.workOrdPrcssResultQualityInsert(workOrderVo);

										}
										// 제품입고처리
										stockManagementController.ProdInput(stockManagementVoList);

										BizOrderVo bizOrderVo = new BizOrderVo();
										bizOrderVo.setIdx(checkVo.getBizOrdDtlIdx());
										bizOrderVo.setBizStatusCd("04");
										bizOrderVo.setUpdIdx(Utils.getUserIdx());
										bizOrderVo.setUpdDate(DateUtil.getCurrentDateTime());
										// 수주 완료 처리
										bizOrderService.bizOrderDtlStatusUpd(bizOrderVo);
									}
								}
								jsonData.put("data", checkVo);
								jsonData.put("result", "ok");
								
								
								// } else {
								// jsonData.put("message", "전체공정 특이사항을<br>확인 후 작업해주세요,.");
								// jsonData.put("result", "fail");
								//
								// }
							}
						}
					} else if ("WC".equals(checkVo.getProgressStatus())) { // 현 공정정보가 완료인 경우
						jsonData.put("message", "이미 작업완료된 공정입니다.");
						jsonData.put("result", "fail");
					}
				} else {
					jsonData.put("message", "수주 진행이 아닌 공정입니다.");
					jsonData.put("result", "fail");
				}
			} else {
				jsonData.put("message", "수주 중지된 공정입니다.");
				jsonData.put("result", "fail");
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}

	// 작업지시서 목록(공정별) 현공정 작업 실적 등록
	@RequestMapping(value = "wm/workOrdPrcssResultSave", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrdPrcssResultSave(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("작업지시서 목록(공정별) 현공정 작업 실적 등록" + workOrderVo);
		try {			
			WorkOrderVo checkVo = new WorkOrderVo();
			checkVo = workOrderService.workOrdSelWithPrcss(workOrderVo);
			
			boolean canWorkYn = false;
			String userIdx = Utils.getUserIdx();
			
			//공정의 작업자들 중 접속한 사용자의 식별자가 있을 경우 -> 등록 수정 삭제 가능 
			//								없을 경우 -> 불가능
			List<WorkOrderVo> workerLst = workOrderService.prcssWorkerLstByPrcssIdx(checkVo);
			List<WorkOrderVo> workerFilterLst = workerLst.stream().filter(v -> userIdx.equals(v.getPrcssWorkerIdx()) ).collect(Collectors.toList());
			
			//필터 리스트의 사이즈가 0보다 큰경우 -> 권한이있음 등록가능
			if( workerFilterLst.size() > 0 ) {
				//공정의 작업지시의 수주가 중지가 아닐 때
				if(!"Y".equals(checkVo.getBizStopYn())) {
					//수주진행상태일때
					if("02".equals(checkVo.getBizStatusCd())) {
						//현 공정정보가 대기인 경우
						if( "PI".equals(checkVo.getProgressStatus()) ) {
							jsonData.put("message", "공정이 대기상태입니다.<br>작업 시작 후 다시 시도해주세요.");
							jsonData.put("result", "fail");		
						} else if( "WI".equals(checkVo.getProgressStatus()) ) { //현 공정정보가 진행인 경우

							if("Y".equals(checkVo.getDescCheckYn()) || "".equals(checkVo.getBeforePrcssDesc()) || checkVo.getBeforePrcssDesc() == null) {
								Date today = new Date();	// 오늘 날짜
								SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
								// 문자열을 Date 객체로 파싱
								String strToday = sdf.format(today);
								
								workOrderVo.setRegIdx(Utils.getUserIdx());
								workOrderVo.setRegDate(DateUtil.getCurrentDateTime());
								workOrderVo.setUpdIdx(Utils.getUserIdx());
								workOrderVo.setUpdDate(DateUtil.getCurrentDateTime());
								
								//생산 실적 조회
								List<WorkOrderVo> workOrderVoList = workOrderService.workOrdResultListByPrcss(workOrderVo);
								
								//투입 자재 
								PurchaseOrderVo purchaseOrderVo = new PurchaseOrderVo();
								purchaseOrderVo.setWorkOrdPrcssIdx(workOrderVo.getWorkOrdPrcssIdx());
								List<PurchaseOrderVo> purchaseOrderVoList = purchaseOrderService.purchaseOrderAdmLstByWorkOrdPrcss(purchaseOrderVo);
								//품목구분이 원지(001)인 항목만 수불정리 및 예외처리 하도록 변경됨
								//↑↑↑↑ 취소됨
								//purchaseOrderVoList = purchaseOrderVoList.stream()
								//								 		 .filter(v -> StringUtils.equals("001", v.getItemGubun()))
								//										 .collect(Collectors.toList());
																
								//자재 출고처리 가능한 창고 조회
								WorkOrderVo matrlLocationVo = workOrderService.workOrdOutMatrlLocationList(workOrderVo);
								
								//제품 품질창고(QC) 가능한 창고 조회
								//WorkOrderVo prodLocationVo = workOrderService.workInProdLocationList(workOrderVo);
								
								int checkWorkQtySum = 0;
								boolean check = true;
								for(int i = 0; i<purchaseOrderVoList.size(); i++) {
									//자재 현재고 체크시 i=0 첫번째 자재일 경우 작업량+추가재단량+불량해서 합산해서 적용
									// 그외에는 작업량+추가재단량만해서 적용
									// 그외는 여분포함통수만큼 수불발생으로 변경 2023.05.25
									
									//수불발생공정(원지재단)일 경우 -> 기존체크로직
									//else if(추가재단 여부 Y)인 경우 -> 추가재단 / 절수로 체크해야함
									PurchaseOrderVo purchaseMatrlVo = purchaseOrderVoList.get(i);
									if( "Y".equals(checkVo.getStockOption()) ) {
										if( i == 0) {
											checkWorkQtySum = Integer.parseInt(workOrderVo.getFairQty()) + Integer.parseInt(workOrderVo.getWorkAddCuttingQty()) + Integer.parseInt(workOrderVo.getFaultyQty());
										} else {
											int ordQty = 0;						//발주수량
											int cutQty = 0, eaQty = 0;			//절수개수
											int extraQty = 0, extraPackQty = 0;	//여분 
											
											ordQty = (int)Double.parseDouble(purchaseMatrlVo.getPurchaseOrdQty());
											cutQty = (int)Double.parseDouble(purchaseMatrlVo.getCutQty());
											eaQty = (int)Double.parseDouble(purchaseMatrlVo.getEaQty());
											extraQty = (int)Double.parseDouble(purchaseMatrlVo.getExtraQty());
											extraPackQty = (int)Double.parseDouble(purchaseMatrlVo.getExtraPackQty());
											
											int printPressQty = (int) (Math.ceil(ordQty/(cutQty*eaQty)) * cutQty);
											int printPressAndExtraQty = printPressQty + extraQty + (extraPackQty*cutQty) ;	//여분포함통수
											
											checkWorkQtySum = printPressAndExtraQty;
										}
									} else if( "Y".equals(checkVo.getCutYn()) ) {
										if( i == 0) {
											checkWorkQtySum = Integer.parseInt(workOrderVo.getWorkAddCuttingQty());
										} /*else {
											int ordQty = 0;						//발주수량
											int cutQty = 0, eaQty = 0;			//절수개수
											int extraQty = 0, extraPackQty = 0;	//여분 
											
											ordQty = (int)Double.parseDouble(purchaseMatrlVo.getPurchaseOrdQty());
											cutQty = (int)Double.parseDouble(purchaseMatrlVo.getCutQty());
											eaQty = (int)Double.parseDouble(purchaseMatrlVo.getEaQty());
											extraQty = (int)Double.parseDouble(purchaseMatrlVo.getExtraQty());
											extraPackQty = (int)Double.parseDouble(purchaseMatrlVo.getExtraPackQty());
											
											int printPressQty = (int) (Math.ceil(ordQty/(cutQty*eaQty)) * cutQty);
											int printPressAndExtraQty = printPressQty + extraQty + (extraPackQty*cutQty) ;	//여분포함통수
											
											checkWorkQtySum = printPressAndExtraQty;
										}*/
									}
									
									int checkSmQty = (int) Math.ceil(checkWorkQtySum / Float.parseFloat(purchaseOrderVoList.get(i).getCutQty()));
									if(checkSmQty > (int)Double.parseDouble(purchaseOrderVoList.get(i).getSpQty())) {
										check = false;
										break;
									}
									
									//수불구분이 Y일경우
									if( "Y".equals(checkVo.getStockOption()) ) {
										
									} else if( "Y".equals(checkVo.getCutYn()) ) {
										//추가재단구분인 경우에는 첫번째 자재만 확인하고 break걸면됨
										if( i == 0) {
											break;
										} 
									}
								}
								
								if(matrlLocationVo == null) {
									jsonData.put("message", "자재 출고 가능한 창고가 <br>없습니다.");
									jsonData.put("result", "fail");
								} else if(purchaseOrderVoList.size() == 0) {
									jsonData.put("message", "투입된 자재가 있는지<br>확인 후 작업해주세요.");
									jsonData.put("result", "fail");
								} else if(!check && ( "Y".equals(checkVo.getStockOption()) || "Y".equals(checkVo.getCutYn()) ) ){
									jsonData.put("message", "현재고보다 투입수량이 큰 항목이<br>있습니다.");
									jsonData.put("result", "fail");
								} else {
									if(workOrderVoList.size() == 0 || "insert".equals(workOrderVo.getSaveType()) ) {
										//실적등록
										workOrderService.workOrdPrcssResultSave(workOrderVo);
										//등록한 실적의 idx로 수불 발생하기위해서 set
										workOrderVo.setWorkOrdResultIdx(workOrderVo.getResultIdx());
									} else if(workOrderVoList.size() > 0 || "update".equals(workOrderVo.getSaveType())){
										//실적수정
										workOrderService.workOrdPrcssResultUpd(workOrderVo);
										//등록한 실적의 idx로 수불 발생하기위해서 set할 필요 X -> 업데이트 하기위해 workOrdResultIdx에 값 담아서 컨트롤러 넘어옴
									}
									//원지재단 수불발생 대상 -> 수불 발생 Y일경우 발생, 추가재단량 포함해서 수불 발생
									//밑에 else if는 원지재단공정이 아닌경우 => 추가재단여부만 체크해서 추가재단량만큼만 수불이 발생하도록
									if( "Y".equals(checkVo.getStockOption()) ) {
										// 자재출고 처리 목록
										List<StockManagementVo> stockManagementVoList = new ArrayList<>();
										for(int i = 0; i < purchaseOrderVoList.size(); i++) {
											StockManagementVo stockManagementVo = new StockManagementVo();
											
											stockManagementVo.setSmItemGubun("002"); //001:제품 , 002:자재
											stockManagementVo.setSmItemCd(purchaseOrderVoList.get(i).getMatrlIdx()); //품목(자재) 식별자
											stockManagementVo.setSmType("출고"); //수불구분
								    		stockManagementVo.setSmType2("OPM"); //업무구분
								    		stockManagementVo.setSmDate(strToday); //수불일자
								    		//생산 실적 * 절수 해서 통 단위로 수불 발생해야함
								    		//i=0 첫번째 자재일 경우 작업량+추가재단량+불량해서 합산해서 적용
											// 그외에는 작업량+추가재단량만해서 적용
											// 그외는 여분포함통수만큼 수불발생으로 변경 2023.05.25
								    		int workQtySum = 0;
								    		int smQty = 0;
								    		PurchaseOrderVo purchaseMatrlVo = purchaseOrderVoList.get(i);
								    		if( i == 0 ) {
								    			workQtySum = Integer.parseInt(workOrderVo.getFairQty()) + Integer.parseInt(workOrderVo.getWorkAddCuttingQty()) + Integer.parseInt(workOrderVo.getFaultyQty());
								    			smQty = (int) Math.ceil(workQtySum / Float.parseFloat(purchaseOrderVoList.get(i).getCutQty()));
								    		} else {
								    			int ordQty = 0;						//발주수량
												int cutQty = 0, eaQty = 0;			//절수개수
												int extraQty = 0, extraPackQty = 0;	//여분 
												
												ordQty = (int)Double.parseDouble(purchaseMatrlVo.getPurchaseOrdQty());
												cutQty = (int)Double.parseDouble(purchaseMatrlVo.getCutQty());
												eaQty = (int)Double.parseDouble(purchaseMatrlVo.getEaQty());
												extraQty = (int)Double.parseDouble(purchaseMatrlVo.getExtraQty());
												extraPackQty = (int)Double.parseDouble(purchaseMatrlVo.getExtraPackQty());
												
												int printPressQty = (int) (Math.ceil((double)ordQty/(cutQty*eaQty)) * cutQty);
												int printPressAndExtraQty = printPressQty + extraQty + (extraPackQty*cutQty) ;	//여분포함통수
												smQty = printPressAndExtraQty;
								    		}
								    		
								    		stockManagementVo.setSmQty( Integer.toString(smQty) ); // 수불수량
								    		stockManagementVo.setSmLotNo(""); //LOT번호 -> 채번이라서 빈값넘겨줌
								    		stockManagementVo.setSmSourceNo(workOrderVo.getWorkOrdResultIdx()); //원천번호 -> 생산실적의 식별자
								    		stockManagementVo.setSmOutWhsGubun(""); //창고구분 -> 없음 빈값 
								    		stockManagementVo.setSmOutWhsIdx(matrlLocationVo.getLocationIdx()); //창고식별자
								    		stockManagementVo.setSmInWhsIdx(matrlLocationVo.getLocationIdx()); //창고식별자  
								    		stockManagementVo.setSmOutLocIdx(""); //위치식별자 -> 안씀 빈값
								    		
								    		stockManagementVo.setSmOutGubun("생산투입"); //출고구분
								    		stockManagementVo.setSmOutCorpIdx(""); //출고처 -> 없음
								    		stockManagementVo.setSmOutRelationNo(workOrderVo.getWorkOrdResultIdx()); //연관번호 -> 생산실적의 식별자
											stockManagementVoList.add(stockManagementVo);	
											
											//자재출고 전표(OUT_SLIP_NO) 조회 -> RELATION_NO로 조회해서 전표 찾은 후에 -> 이미 출고 시킨 자재라면  -> 자재출고전표 지우고 출고수불 지우고 등록
											OutMatrWhsAdmVo outMatrWhsAdmVo = new OutMatrWhsAdmVo();
											outMatrWhsAdmVo.setRelationNo(workOrderVo.getWorkOrdResultIdx());
											outMatrWhsAdmVo.setOutGubun("생산투입");
											List<OutMatrWhsAdmVo> outMatrWhsAdmListVo = outMatrWhsAdmService.getOutSlipNoByRelationNo(outMatrWhsAdmVo);
											StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();
											
											//해당 전표가 존재한다면 지우고 하도록
											if(outMatrWhsAdmListVo.size() > 0) {
												//수불 삭제 JSON배열
												JSONArray stockDel_array = new JSONArray();
												for(int j = 0; j < outMatrWhsAdmListVo.size(); j++) {
													outMatrWhsAdmVo.setOutSlipNo(outMatrWhsAdmListVo.get(j).getOutSlipNo());
													outMatrWhsAdmVo.setOutSlipSeq(outMatrWhsAdmListVo.get(j).getOutSlipSeq());
													
													outMatrWhsAdmService.outMatrWhsAdmDel(outMatrWhsAdmVo); //자재출고 전표 삭제
													JSONObject stockData = new JSONObject();
													stockData.put("SP_SOURCE_NO", outMatrWhsAdmListVo.get(j).getOutSlipNo() + "-" + outMatrWhsAdmListVo.get(j).getOutSlipSeq());
													stockDel_array.add(stockData);	
												}
												stockPaymentAdmVo.setDeleteJson(stockDel_array.toJSONString());
												stockPaymentAdmService.stockPaymentAdmDel(stockPaymentAdmVo); // 출고수불 삭제
											}
										}
										//자재출고처리
										stockManagementController.MatrOutput(stockManagementVoList);
									} else if( "Y".equals(checkVo.getCutYn()) && Integer.parseInt(workOrderVo.getWorkAddCuttingQty()) > 0) {
										// 추가재단량이 있고, 추가재단여부가 Y인경우 수불발생
										// 자재출고 처리 목록
										List<StockManagementVo> stockManagementVoList = new ArrayList<>();
										//for(int i = 0; i < purchaseOrderVoList.size(); i++) {
										//추가재단은 1번째 자재에 한해서만 수불발생하게끔 변경됨
										for(int i = 0; i < 1; i++) {
											StockManagementVo stockManagementVo = new StockManagementVo();
											
											stockManagementVo.setSmItemGubun("002"); //001:제품 , 002:자재
											stockManagementVo.setSmItemCd(purchaseOrderVoList.get(i).getMatrlIdx()); //품목(자재) 식별자
											stockManagementVo.setSmType("출고"); //수불구분
								    		stockManagementVo.setSmType2("OPM"); //업무구분
								    		stockManagementVo.setSmDate(strToday); //수불일자
								    		//i=0 첫번째 자재일 경우 추가재단량 적용
											// 그외는 여분포함통수만큼 수불발생
								    		int workQtySum = 0;
								    		int smQty = 0;
								    		PurchaseOrderVo purchaseMatrlVo = purchaseOrderVoList.get(i);
								    		if( i == 0 ) {
								    			workQtySum = Integer.parseInt(workOrderVo.getWorkAddCuttingQty());
								    			smQty = (int) Math.ceil(workQtySum / Float.parseFloat(purchaseOrderVoList.get(i).getCutQty()));
								    		} /*else {
								    			int ordQty = 0;						//발주수량
												int cutQty = 0, eaQty = 0;			//절수개수
												int extraQty = 0, extraPackQty = 0;	//여분 
												
												ordQty = (int)Double.parseDouble(purchaseMatrlVo.getPurchaseOrdQty());
												cutQty = (int)Double.parseDouble(purchaseMatrlVo.getCutQty());
												eaQty = (int)Double.parseDouble(purchaseMatrlVo.getEaQty());
												extraQty = (int)Double.parseDouble(purchaseMatrlVo.getExtraQty());
												extraPackQty = (int)Double.parseDouble(purchaseMatrlVo.getExtraPackQty());
												
												int printPressQty = (int) (Math.ceil((double)ordQty/(cutQty*eaQty)) * cutQty);
												int printPressAndExtraQty = printPressQty + extraQty + (extraPackQty*cutQty) ;	//여분포함통수
												smQty = printPressAndExtraQty;
								    		}*/
								    		
								    		stockManagementVo.setSmQty( Integer.toString(smQty) ); // 수불수량
								    		stockManagementVo.setSmLotNo(""); //LOT번호 -> 채번이라서 빈값넘겨줌
								    		stockManagementVo.setSmSourceNo(workOrderVo.getWorkOrdResultIdx()); //원천번호 -> 생산실적의 식별자
								    		stockManagementVo.setSmOutWhsGubun(""); //창고구분 -> 없음 빈값 
								    		stockManagementVo.setSmOutWhsIdx(matrlLocationVo.getLocationIdx()); //창고식별자
								    		stockManagementVo.setSmInWhsIdx(matrlLocationVo.getLocationIdx()); //창고식별자  
								    		stockManagementVo.setSmOutLocIdx(""); //위치식별자 -> 안씀 빈값
								    		
								    		stockManagementVo.setSmOutGubun("생산투입"); //출고구분
								    		stockManagementVo.setSmOutCorpIdx(""); //출고처 -> 없음
								    		stockManagementVo.setSmOutRelationNo(workOrderVo.getWorkOrdResultIdx()); //연관번호 -> 생산실적의 식별자
											stockManagementVoList.add(stockManagementVo);	
											
											//자재출고 전표(OUT_SLIP_NO) 조회 -> RELATION_NO로 조회해서 전표 찾은 후에 -> 이미 출고 시킨 자재라면  -> 자재출고전표 지우고 출고수불 지우고 등록
											OutMatrWhsAdmVo outMatrWhsAdmVo = new OutMatrWhsAdmVo();
											outMatrWhsAdmVo.setRelationNo(workOrderVo.getWorkOrdResultIdx());
											outMatrWhsAdmVo.setOutGubun("생산투입");
											List<OutMatrWhsAdmVo> outMatrWhsAdmListVo = outMatrWhsAdmService.getOutSlipNoByRelationNo(outMatrWhsAdmVo);
											StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();
											
											//해당 전표가 존재한다면 지우고 하도록
											if(outMatrWhsAdmListVo.size() > 0) {
												//수불 삭제 JSON배열
												JSONArray stockDel_array = new JSONArray();
												for(int j = 0; j < outMatrWhsAdmListVo.size(); j++) {
													outMatrWhsAdmVo.setOutSlipNo(outMatrWhsAdmListVo.get(j).getOutSlipNo());
													outMatrWhsAdmVo.setOutSlipSeq(outMatrWhsAdmListVo.get(j).getOutSlipSeq());
													
													outMatrWhsAdmService.outMatrWhsAdmDel(outMatrWhsAdmVo); //자재출고 전표 삭제
													JSONObject stockData = new JSONObject();
													stockData.put("SP_SOURCE_NO", outMatrWhsAdmListVo.get(j).getOutSlipNo() + "-" + outMatrWhsAdmListVo.get(j).getOutSlipSeq());
													stockDel_array.add(stockData);	
												}
												stockPaymentAdmVo.setDeleteJson(stockDel_array.toJSONString());
												stockPaymentAdmService.stockPaymentAdmDel(stockPaymentAdmVo); // 출고수불 삭제
											}
										}
										//자재출고처리
										stockManagementController.MatrOutput(stockManagementVoList);
										
									}
									
									//해당공정의 목형사용여부가 Y인경우 목형사용이력을 남겨줘야함 -> 단, 실적이 수정되는 경우(실적이 있는 경우 지우고 등록하도록 프로시저단에 구현해놈)
									if("Y".equals(checkVo.getWoodenUseYn())) { //목형
										WoodenInfoVo woodenInfoVo = new WoodenInfoVo(); 
										
										int workQtySum = Integer.parseInt(workOrderVo.getFairQty()) + Integer.parseInt(workOrderVo.getWorkAddCuttingQty()) + Integer.parseInt(workOrderVo.getFaultyQty());

										woodenInfoVo.setWdIdx(checkVo.getWoodenCareCd());
										woodenInfoVo.setWorkOrdResultIdx(workOrderVo.getWorkOrdResultIdx());
										woodenInfoVo.setUseQty( String.valueOf(workQtySum) );
										woodenInfoVo.setRegIdx(Utils.getUserIdx());
										woodenInfoVo.setRegDate(DateUtil.getCurrentDateTime());
										
										woodenInfoService.prcssUseWoodenLogIns(woodenInfoVo);
									} 
									if("Y".equals(checkVo.getCrUseYn())) { //CR코팅판
										WoodenInfoVo woodenInfoVo = new WoodenInfoVo(); 
										
										int workQtySum = Integer.parseInt(workOrderVo.getFairQty()) + Integer.parseInt(workOrderVo.getWorkAddCuttingQty()) + Integer.parseInt(workOrderVo.getFaultyQty());

										woodenInfoVo.setWdIdx(checkVo.getResinBoardWdCd());
										woodenInfoVo.setWorkOrdResultIdx(workOrderVo.getWorkOrdResultIdx());
										woodenInfoVo.setUseQty( String.valueOf(workQtySum) );
										woodenInfoVo.setRegIdx(Utils.getUserIdx());
										woodenInfoVo.setRegDate(DateUtil.getCurrentDateTime());
										
										woodenInfoService.prcssUseWoodenLogIns(woodenInfoVo);
									}
									if("Y".equals(checkVo.getUvUseYn())) { //UV코팅판
										WoodenInfoVo woodenInfoVo = new WoodenInfoVo(); 
										
										int workQtySum = Integer.parseInt(workOrderVo.getFairQty()) + Integer.parseInt(workOrderVo.getWorkAddCuttingQty()) + Integer.parseInt(workOrderVo.getFaultyQty());

										woodenInfoVo.setWdIdx(checkVo.getEtc2Cd());
										woodenInfoVo.setWorkOrdResultIdx(workOrderVo.getWorkOrdResultIdx());
										woodenInfoVo.setUseQty( String.valueOf(workQtySum) );
										woodenInfoVo.setRegIdx(Utils.getUserIdx());
										woodenInfoVo.setRegDate(DateUtil.getCurrentDateTime());
										
										woodenInfoService.prcssUseWoodenLogIns(woodenInfoVo);
									}
									
									

									jsonData.put("result", "ok");	
								}
							} else {
								jsonData.put("message", "전체공정 특이사항을<br>확인 후 작업해주세요,.");
								jsonData.put("result", "fail");
							}
							
						} else if( "WC".equals(checkVo.getProgressStatus()) ) { //현 공정정보가 완료인 경우
							jsonData.put("message", "이미 작업완료된 공정입니다.");
							jsonData.put("result", "fail");
						}
					} else {
						jsonData.put("message", "수주 진행이 아닌 공정입니다.");
						jsonData.put("result", "fail");
					}
				} else {
					jsonData.put("message", "수주 중지된 공정입니다.");
					jsonData.put("result", "fail");
				}
			} else {
				jsonData.put("message", "등록 권한이<br>없는 공정입니다.");
				jsonData.put("result", "fail");
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}

	// 작업지시서 목록(공정별) 현공정 작업 실적,번들링 등록
	@RequestMapping(value = "wm/workOrdPrcssResultSaveBundle", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrdPrcssResultSaveBundle(WorkOrderVo workOrderVo,
			@RequestParam(value = "inputQtyJson", required = false) String jsonArray) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("작업지시서 목록(공정별) 현공정 작업 실적, 번들링 등록" + workOrderVo);
		try {
			WorkOrderVo checkVo = new WorkOrderVo();
			checkVo = workOrderService.workOrdSelWithPrcss(workOrderVo);
			
			boolean canWorkYn = false;
			String userIdx = Utils.getUserIdx();
			
			//공정의 작업자들 중 접속한 사용자의 식별자가 있을 경우 -> 등록 수정 삭제 가능 
			//								없을 경우 -> 불가능
			List<WorkOrderVo> workerLst = workOrderService.prcssWorkerLstByPrcssIdx(checkVo);
			List<WorkOrderVo> workerFilterLst = workerLst.stream().filter(v -> userIdx.equals(v.getPrcssWorkerIdx()) ).collect(Collectors.toList());
			
			//필터 리스트의 사이즈가 0보다 큰경우 -> 권한이있음 등록가능
			if( workerFilterLst.size() > 0 ) {
				// 공정의 작업지시의 수주가 중지가 아닐 때
				if (!"Y".equals(checkVo.getBizStopYn())) {
					// 수주진행상태일때
					if ("02".equals(checkVo.getBizStatusCd())) {
						// 현 공정정보가 대기인 경우
						if ("PI".equals(checkVo.getProgressStatus())) {
							jsonData.put("message", "공정이 대기상태입니다.<br>작업 시작 후 다시 시도해주세요.");
							jsonData.put("result", "fail");
						} else if ("WI".equals(checkVo.getProgressStatus())) { // 현 공정정보가 진행인 경우
							// if("Y".equals(checkVo.getDescCheckYn()) ||
							// "".equals(checkVo.getBeforePrcssDesc()) || checkVo.getBeforePrcssDesc() ==
							// null) {
							Date today = new Date(); // 오늘 날짜
							SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
							// 문자열을 Date 객체로 파싱
							String strToday = sdf.format(today);

							workOrderVo.setRegIdx(Utils.getUserIdx());
							workOrderVo.setRegDate(DateUtil.getCurrentDateTime());
							workOrderVo.setUpdIdx(Utils.getUserIdx());
							workOrderVo.setUpdDate(DateUtil.getCurrentDateTime());

							// 생산 실적 조회
							List<WorkOrderVo> workOrderVoList = workOrderService.workOrdResultListByPrcss(workOrderVo);

							// 투입 자재
							// PurchaseOrderVo purchaseOrderVo = new PurchaseOrderVo();
							// purchaseOrderVo.setWorkOrdPrcssIdx(workOrderVo.getWorkOrdPrcssIdx());
							// List<PurchaseOrderVo> purchaseOrderVoList =
							// purchaseOrderService.purchaseOrderAdmLstByWorkOrdPrcss(purchaseOrderVo);

							// 번들링 목록
							ItemInfoAdmVo itemInfoAdmVo = new ItemInfoAdmVo();
							itemInfoAdmVo.setItemIdx(checkVo.getItemIdx());
							// List<ItemInfoAdmVo> itemInfoAdmVoList =
							// itemInfoAdmService.bundleInfoList(itemInfoAdmVo);
							workOrderVo.setBizOrdDtlIdx(checkVo.getBizOrdDtlIdx());
							workOrderVo.setWorkOrdPrcssIdx(checkVo.getWorkOrdPrcssIdx());
							List<WorkOrderVo> workOrderBundleList = workOrderService.workOrdBundleList(workOrderVo);

							// 번들링 수불처리(제품 입출고) 가능한 창고 조회
							LocationVo bundleLocationVo = new LocationVo();
							bundleLocationVo = locationService.possibleInOutItemLocationSel(bundleLocationVo);

							// 제품 폐기 입고가능한 창고
							LocationVo locationDisposalVo = new LocationVo();
							locationDisposalVo = locationService.possibleDisposalLocationList(locationDisposalVo);

							// 자재 출고처리 가능한 창고 조회
							// WorkOrderVo matrlLocationVo =
							// workOrderService.workOrdOutMatrlLocationList(workOrderVo);

							// 제품 품질창고(QC) 가능한 창고 조회
							// WorkOrderVo prodLocationVo =
							// workOrderService.workInProdLocationList(workOrderVo);

							JSONParser jsonParser = new JSONParser();
							JSONArray dataArray = (JSONArray) jsonParser.parse(jsonArray);
							JSONObject jsonObj = new JSONObject();
							boolean check = true;
							// 일치하는 값, 투입수량대비 현재고 체크 로직
							for (int j = 0; j < dataArray.size(); j++) {
								jsonObj.put(j, dataArray.get(j));
								JSONObject jsonObject = (JSONObject) jsonParser.parse(jsonObj.get(j).toString());

								WorkOrderVo filterVo = workOrderBundleList.stream()
																			.filter(v -> StringUtils.equals(jsonObject.get("itemIdx").toString(), v.getItemIdx()))
																			.findAny().orElse(null);
								if ((int) Double.parseDouble(filterVo.getStockQty()) < (int) Double.parseDouble(jsonObject.get("inputQty").toString())) {
									check = false;
									break;
								}

							}
							// 실적 등록/수정인지 구분자
							String IUGubun = "";
							if (locationDisposalVo == null) {
								jsonData.put("message", "제품 폐기 입고 가능한 창고가 <br>없습니다.");
								jsonData.put("result", "fail");
							} else if (bundleLocationVo == null) {
								jsonData.put("message", "제품 입출고 가능한 창고가 <br>없습니다.");
								jsonData.put("result", "fail");
							} else if (workOrderBundleList.size() == 0) {
								jsonData.put("message", "번들링 투입된 제품이 있는지<br>확인 후 작업해주세요.");
								jsonData.put("result", "fail");
							} else if (!check && "Y".equals(checkVo.getStockOption())) {
								jsonData.put("message", "현재고보다 투입수량이 큰 항목이<br>있습니다.");
								jsonData.put("result", "fail");
							} else {

								if (workOrderVoList.size() == 0 || "insert".equals(workOrderVo.getSaveType())) {
									IUGubun = "insert";
									// 실적등록
									workOrderService.workOrdPrcssResultSave(workOrderVo);
									// 등록한 실적의 idx로 수불 발생하기위해서 set
									workOrderVo.setWorkOrdResultIdx(workOrderVo.getResultIdx());
								} else if (workOrderVoList.size() > 0 || "update".equals(workOrderVo.getSaveType())) {
									IUGubun = "update";
									// 실적수정
									workOrderService.workOrdPrcssResultUpd(workOrderVo);
									// 등록한 실적의 idx로 수불 발생하기위해서 set할 필요 X -> 업데이트 하기위해 workOrdResultIdx에 값 담아서 컨트롤러
									// 넘어옴
								}

								// 수불 발생 Y일경우 발생
								if ("Y".equals(checkVo.getStockOption())) {

									// 번들링목록에있는 수주상세식별자
									String bunleBizOrdDtlIdxString = "";
									// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!여기부터는 해당 번들링에 묶인 수주들의 실적들에 대한 처리

									// 해당 수주의 마지막 공정 실적들 가지고 오기
									for (int i = 0; i < workOrderBundleList.size(); i++) {
										bunleBizOrdDtlIdxString = bunleBizOrdDtlIdxString.concat(workOrderBundleList.get(i).getBundleBizOrdDtlIdx()).concat(",");
									}
									if (bunleBizOrdDtlIdxString.length() > 0) {
										bunleBizOrdDtlIdxString = bunleBizOrdDtlIdxString.substring(0, bunleBizOrdDtlIdxString.length() - 1);
									}
									workOrderVo.setBizOrdDtlIdxString(bunleBizOrdDtlIdxString);
									// 이 밑에 번들링에 포함된 수주의 공정들의 실적리스트에는 수주상세idx, 실적idx, 작업량, 불량이 들어있다.
									List<WorkOrderVo> workOrderBundleResultList = workOrderService.bundleEndPrcssWorkResultList(workOrderVo);
									// 이 밑 업데이트리스트는 실적업데이트 대상인 JSONArray
									JSONArray workOrderBundleResultUpdate_array = new JSONArray();

									// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!여기부터는 해당 번들링에 대한 수불 처리
									// 제품출고(생산투입) 처리 목록
									List<StockManagementVo> stockManagementVoList = new ArrayList<>();
									// 제품출고(폐기출고) 처리 목록
									List<StockManagementVo> stockManagementVoDisposalList = new ArrayList<>();
									for (int i = 0; i < workOrderBundleList.size(); i++) {

										StockManagementVo stockManagementVo = new StockManagementVo();
										StockManagementVo stockManagementVoDisposal = new StockManagementVo();

										int inputQty = 0;
										// 일치하는 값가져오기
										for (int j = 0; j < dataArray.size(); j++) {
											jsonObj.put(j, dataArray.get(j));
											JSONObject jsonObject = (JSONObject) jsonParser.parse(jsonObj.get(j).toString());

											if (jsonObject.get("itemIdx").toString().equals(workOrderBundleList.get(i).getItemIdx())) {
												inputQty = Integer.parseInt(jsonObject.get("inputQty").toString());
												break;
											}

										}
										// 수불수량 = 투입수량 * (양품수량)
										// int smQty = (int) (inputQty * (Float.parseFloat(workOrderVo.getFairQty()) +
										// Float.parseFloat(workOrderVo.getFaultyQty())));
										// 제품생산출고수량은 작업량+불량임
										int smQty = Integer.parseInt(workOrderVo.getFairQty()) + Integer.parseInt(workOrderVo.getFaultyQty());
										// 폐기수량은 투입수량 - (작업량+불량) 임
										int smDisposalQty = inputQty - smQty;

										// 번들링 수주에 묶인 실적들에서 해당 수주dtlidx로 찾기
										WorkOrderVo filterTargetVo = workOrderBundleList.get(i);
										WorkOrderVo filterVo = workOrderBundleResultList.stream()
																						.filter(v -> StringUtils.equals(filterTargetVo.getBundleBizOrdDtlIdx(), v.getBizOrdDtlIdx()))
																						.findAny().orElse(null);
										// 해당 실적에서 작업량은 불량수량만큼 - , 불량수량은 + 하고 hist테이블에 기존값 저장
										// 해당 실적에서 발생했던 수불들 수량 변경
										if (filterVo != null) {
											JSONObject resultUpdateData = new JSONObject();
											resultUpdateData.put("BUNDLE_RESULT_IDX", workOrderVo.getWorkOrdResultIdx());
											resultUpdateData.put("BIZ_ORD_DTL_NO", filterVo.getBizOrdDtlNo());
											resultUpdateData.put("WOPR_IDX", filterVo.getWorkOrdResultIdx());
											resultUpdateData.put("BEFORE_FAIR_QTY", filterVo.getFairQty());
											resultUpdateData.put("BEFORE_FAULTY_QTY", filterVo.getFaultyQty());
											String afterFairQty = Integer.toString((int) Double.parseDouble(filterVo.getFairQty()) - smDisposalQty);
											String afterFaultyQty = Integer.toString((int) Double.parseDouble(filterVo.getFaultyQty()) + smDisposalQty);
											resultUpdateData.put("AFTER_FAIR_QTY", afterFairQty);
											resultUpdateData.put("AFTER_FAULTY_QTY", afterFaultyQty);
											resultUpdateData.put("DISPOSAL_QTY", Integer.toString(smDisposalQty));

											workOrderBundleResultUpdate_array.add(resultUpdateData);
										}

										stockManagementVo.setSmItemGubun("001");
										stockManagementVo.setSmOutGubun("제품생산출고");
										stockManagementVo.setSmItemIdx(workOrderBundleList.get(i).getItemIdx());
										stockManagementVo.setSmItemVersionIdx(workOrderBundleList.get(i).getItemVersionIdx());
										stockManagementVo.setSmCarAssignment("");
										stockManagementVo.setSmItemCd(workOrderBundleList.get(i).getItemIdx());

										stockManagementVo.setSmQty(Integer.toString(smQty));
										stockManagementVo.setSmDate(strToday);
										stockManagementVo.setSmOutCorpIdx("");
										stockManagementVo.setSmStatus("B");
										stockManagementVo.setSmLotNo("");
										stockManagementVo.setSmOutRelationNo(workOrderVo.getWorkOrdResultIdx());
										stockManagementVo.setSmOutWhsGubun("");
										stockManagementVo.setSmOutWhsIdx(bundleLocationVo.getIdx());
										stockManagementVo.setSmOutLocIdx(null);
										stockManagementVo.setSmEtc1("");
										stockManagementVo.setSmEtc2("");
										stockManagementVo.setSmEtc3("");

										stockManagementVo.setSmType("출고");
										stockManagementVo.setSmType2("OPP");
										stockManagementVo.setSmInWhsGubun("");
										stockManagementVo.setSmInWhsIdx(bundleLocationVo.getIdx());
										stockManagementVo.setSmLotNo("");
										stockManagementVo.setSmInRelationNo(workOrderVo.getWorkOrdResultIdx());
										stockManagementVo.setSmDesc("");
										stockManagementVo.setSmEtc1("");
										stockManagementVo.setSmEtc2("");
										stockManagementVo.setSmEtc3("");
										stockManagementVoList.add(stockManagementVo);

										// 폐기목록
										stockManagementVoDisposal.setSmItemGubun("001");
										stockManagementVoDisposal.setSmOutGubun("제품폐기출고");
										stockManagementVoDisposal.setSmItemIdx(workOrderBundleList.get(i).getItemIdx());
										stockManagementVoDisposal.setSmItemVersionIdx(workOrderBundleList.get(i).getItemVersionIdx());
										stockManagementVoDisposal.setSmCarAssignment("");
										stockManagementVoDisposal.setSmItemCd(workOrderBundleList.get(i).getItemIdx());

										stockManagementVoDisposal.setSmQty(Integer.toString(smDisposalQty));
										stockManagementVoDisposal.setSmDate(strToday);
										stockManagementVoDisposal.setSmOutCorpIdx("");
										stockManagementVoDisposal.setSmStatus("B");
										stockManagementVoDisposal.setSmLotNo("");
										stockManagementVoDisposal.setSmOutRelationNo(workOrderVo.getWorkOrdResultIdx());
										stockManagementVoDisposal.setSmOutWhsGubun("");
										stockManagementVoDisposal.setSmOutWhsIdx(bundleLocationVo.getIdx());
										stockManagementVoDisposal.setSmOutLocIdx(null);
										stockManagementVoDisposal.setSmEtc1("");
										stockManagementVoDisposal.setSmEtc2("");
										stockManagementVoDisposal.setSmEtc3("");

										stockManagementVoDisposal.setSmType("출고");
										stockManagementVoDisposal.setSmType2("ODP");
										stockManagementVoDisposal.setSmInWhsGubun("");
										stockManagementVoDisposal.setSmInWhsIdx(bundleLocationVo.getIdx());
										stockManagementVoDisposal.setSmLotNo("");
										stockManagementVoDisposal.setSmInRelationNo(workOrderVo.getWorkOrdResultIdx());
										stockManagementVoDisposal.setSmDesc("");
										stockManagementVoDisposal.setSmEtc1("");
										stockManagementVoDisposal.setSmEtc2("");
										stockManagementVoDisposal.setSmEtc3("");
										if (smDisposalQty > 0) {
											stockManagementVoDisposalList.add(stockManagementVoDisposal);
										}
									}

									// 번들링 수주목록의 실적들 업데이트 & hist 기록
									workOrderVo.setUpdAndInsList(workOrderBundleResultUpdate_array.toJSONString());
									workOrderVo.setIuGubun(IUGubun);
									workOrderService.workResultUpdAndHistIns(workOrderVo);

									workOrderVo.setBizOrdDtlIdxString(bunleBizOrdDtlIdxString);
									// 이 밑에 번들링에 포함된 수주의 공정들의 실적리스트에는 수정된 수주상세idx, 실적idx, 작업량, 불량이 들어있다.
									List<WorkOrderVo> workOrderBundleUpdateResultList = workOrderService.bundleEndPrcssWorkResultList(workOrderVo);
									// 번들링 수주목록의 실적들의 수불 발생 기록
									workOrderVo.setSelectList(workOrderBundleResultUpdate_array.toJSONString());
									List<WorkOrderVo> bundleBizOrdStockList = workOrderService.bundleBizOrdStockList(workOrderVo);
									// 제품입,출고 전표 삭제 JSON 배열
									JSONArray bundleInProdDel_array = new JSONArray();
									JSONArray bundleOutProdDel_array = new JSONArray();
									// 수불 삭제 JSON배열
									JSONArray bundleStockDel_array = new JSONArray();
									for (int i = 0; i < bundleBizOrdStockList.size(); i++) {
										JSONObject inOutProdData = new JSONObject();
										JSONObject stockDelData = new JSONObject();
										String spQty = "";
										WorkOrderVo filterTargetVo = bundleBizOrdStockList.get(i);
										if ("품질적합".equals(bundleBizOrdStockList.get(i).getInOutGubun())
												|| "품질폐기".equals(bundleBizOrdStockList.get(i).getInOutGubun())
												|| "품질".equals(bundleBizOrdStockList.get(i).getInOutGubun())) {
											// 품질일경우 수주상세번호로 조회
											WorkOrderVo filterVo = workOrderBundleUpdateResultList.stream()
													.filter(v -> StringUtils.equals(filterTargetVo.getRelationNo(),
															v.getBizOrdDtlNo()))
													.findAny().orElse(null);
											spQty = filterVo.getFairQty();
										} else if ("생산".equals(bundleBizOrdStockList.get(i).getInOutGubun())) {
											// 생산일경우 실적의 IDX로 조회
											WorkOrderVo filterVo = workOrderBundleUpdateResultList.stream()
													.filter(v -> StringUtils.equals(filterTargetVo.getRelationNo(),
															v.getWorkOrdResultIdx()))
													.findAny().orElse(null);
											spQty = filterVo.getFairQty();
										}

										if ("IN".equals(bundleBizOrdStockList.get(i).getStockGubun())) {
											// 입고
											inOutProdData.put("IN_SLIP_NO", bundleBizOrdStockList.get(i).getInOutSlipNo());
											inOutProdData.put("IN_SLIP_SEQ", bundleBizOrdStockList.get(i).getInOutSlipSeq());
											inOutProdData.put("ITEM_GUBUN", bundleBizOrdStockList.get(i).getItemGubun());
											inOutProdData.put("IN_GUBUN", bundleBizOrdStockList.get(i).getInOutGubun());
											inOutProdData.put("ITEM_CD", bundleBizOrdStockList.get(i).getItemCd());
											inOutProdData.put("VERSION_IDX", bundleBizOrdStockList.get(i).getItemVersionIdx());
											inOutProdData.put("PRE_IN_QTY", bundleBizOrdStockList.get(i).getPreInOutQty());
											inOutProdData.put("IN_QTY", spQty);
											inOutProdData.put("REMAIN_QTY", bundleBizOrdStockList.get(i).getRemainQty());
											inOutProdData.put("PRE_IN_DATE", bundleBizOrdStockList.get(i).getPreInOutDate());
											inOutProdData.put("IN_DATE", bundleBizOrdStockList.get(i).getInOutDate());
											inOutProdData.put("IN_CORP_CD", bundleBizOrdStockList.get(i).getInOutCorpCd());
											inOutProdData.put("IN_STATUS", bundleBizOrdStockList.get(i).getInOutStatus());
											inOutProdData.put("LOT_NO", bundleBizOrdStockList.get(i).getLotNo());
											inOutProdData.put("RELATION_NO", bundleBizOrdStockList.get(i).getRelationNo());
											inOutProdData.put("WHS_GUBUN", bundleBizOrdStockList.get(i).getWhsGubun());
											inOutProdData.put("WHS_IDX", bundleBizOrdStockList.get(i).getWhsIdx());
											inOutProdData.put("LOC_IDX", bundleBizOrdStockList.get(i).getLocIdx());
											inOutProdData.put("IN_USER_IDX", bundleBizOrdStockList.get(i).getInUserIdx());
											inOutProdData.put("IN_DESC", bundleBizOrdStockList.get(i).getInDesc());
											bundleInProdDel_array.add(inOutProdData);

											stockDelData.put("SP_NO", bundleBizOrdStockList.get(i).getSpNo());
											stockDelData.put("SP_SEQ", bundleBizOrdStockList.get(i).getSpSeq());
											stockDelData.put("SP_GUBUN", bundleBizOrdStockList.get(i).getSpGubun());
											stockDelData.put("VERSION_IDX", bundleBizOrdStockList.get(i).getSpIdx());
											stockDelData.put("SP_IDX", bundleBizOrdStockList.get(i).getItemVersionIdx());
											stockDelData.put("SP_TYPE", bundleBizOrdStockList.get(i).getSpType());
											stockDelData.put("SP_TYPE2", bundleBizOrdStockList.get(i).getSpType2());
											stockDelData.put("SP_DATE", bundleBizOrdStockList.get(i).getSpDate());
											stockDelData.put("SP_QTY", spQty);
											stockDelData.put("SP_LOT_NO", bundleBizOrdStockList.get(i).getSpLotNo());
											stockDelData.put("SP_SOURCE_NO", bundleBizOrdStockList.get(i).getInOutSlipNo() + "-" + bundleBizOrdStockList.get(i).getInOutSlipSeq());
											stockDelData.put("SP_WHS_GUBUN", bundleBizOrdStockList.get(i).getSpWhsGubun());
											stockDelData.put("SP_WHS_IDX", bundleBizOrdStockList.get(i).getSpWhsIdx());
											stockDelData.put("SP_LOC_IDX", bundleBizOrdStockList.get(i).getSpLocIdx());
											stockDelData.put("SP_DESC", bundleBizOrdStockList.get(i).getSpDesc());
											stockDelData.put("SP_ETC1", bundleBizOrdStockList.get(i).getSpEtc1());
											stockDelData.put("SP_ETC2", bundleBizOrdStockList.get(i).getSpEtc2());
											stockDelData.put("SP_ETC2", bundleBizOrdStockList.get(i).getSpEtc3());
											bundleStockDel_array.add(stockDelData);
										} else if ("OUT".equals(bundleBizOrdStockList.get(i).getStockGubun())) {
											// 출고
											inOutProdData.put("OUT_SLIP_NO", bundleBizOrdStockList.get(i).getInOutSlipNo());
											inOutProdData.put("OUT_SLIP_SEQ", bundleBizOrdStockList.get(i).getInOutSlipSeq());
											inOutProdData.put("ITEM_GUBUN", bundleBizOrdStockList.get(i).getItemGubun());
											inOutProdData.put("OUT_GUBUN", bundleBizOrdStockList.get(i).getInOutGubun());
											inOutProdData.put("ITEM_IDX", bundleBizOrdStockList.get(i).getItemCd());
											inOutProdData.put("VERSION_IDX", bundleBizOrdStockList.get(i).getItemVersionIdx());
											inOutProdData.put("CAR_ASSIGNMENT", bundleBizOrdStockList.get(i).getCarAssignment());
											inOutProdData.put("PRE_OUT_QTY", bundleBizOrdStockList.get(i).getPreInOutQty());
											inOutProdData.put("OUT_QTY", bundleBizOrdStockList.get(i).getInOutQty());
											inOutProdData.put("REMAIN_QTY", bundleBizOrdStockList.get(i).getRemainQty());
											inOutProdData.put("PRE_OUT_DATE", bundleBizOrdStockList.get(i).getPreInOutDate());
											inOutProdData.put("OUT_DATE", bundleBizOrdStockList.get(i).getInOutDate());
											inOutProdData.put("OUT_CORP_IDX", bundleBizOrdStockList.get(i).getInOutCorpCd());
											inOutProdData.put("OUT_STATUS", bundleBizOrdStockList.get(i).getInOutStatus());
											inOutProdData.put("LOT_NO", bundleBizOrdStockList.get(i).getLotNo());
											inOutProdData.put("RELATION_NO", bundleBizOrdStockList.get(i).getRelationNo());
											inOutProdData.put("WHS_GUBUN", bundleBizOrdStockList.get(i).getWhsGubun());
											inOutProdData.put("WHS_IDX", bundleBizOrdStockList.get(i).getWhsIdx());
											inOutProdData.put("LOC_IDX", bundleBizOrdStockList.get(i).getLocIdx());
											inOutProdData.put("OUT_DESC", bundleBizOrdStockList.get(i).getOutDesc());
											inOutProdData.put("OUT_PROD_ETC1", bundleBizOrdStockList.get(i).getOutProdEtc1());
											inOutProdData.put("OUT_PROD_ETC2", bundleBizOrdStockList.get(i).getOutProdEtc2());
											inOutProdData.put("OUT_PROD_ETC3", bundleBizOrdStockList.get(i).getOutProdEtc3());
											inOutProdData.put("OUT_PROD_ETC4", bundleBizOrdStockList.get(i).getOutProdEtc4());
											inOutProdData.put("OUT_PROD_ETC5", bundleBizOrdStockList.get(i).getOutProdEtc5());
											bundleOutProdDel_array.add(inOutProdData);

											stockDelData.put("SP_NO", bundleBizOrdStockList.get(i).getSpNo());
											stockDelData.put("SP_SEQ", bundleBizOrdStockList.get(i).getSpSeq());
											stockDelData.put("SP_GUBUN", bundleBizOrdStockList.get(i).getSpGubun());
											stockDelData.put("SP_IDX", bundleBizOrdStockList.get(i).getSpIdx());
											stockDelData.put("VERSION_IDX", bundleBizOrdStockList.get(i).getItemVersionIdx());
											stockDelData.put("SP_TYPE", bundleBizOrdStockList.get(i).getSpType());
											stockDelData.put("SP_TYPE2", bundleBizOrdStockList.get(i).getSpType2());
											stockDelData.put("SP_DATE", bundleBizOrdStockList.get(i).getSpDate());
											stockDelData.put("SP_QTY", spQty);
											stockDelData.put("SP_LOT_NO", bundleBizOrdStockList.get(i).getSpLotNo());
											stockDelData.put("SP_SOURCE_NO", bundleBizOrdStockList.get(i).getInOutSlipNo() + "-" + bundleBizOrdStockList.get(i).getInOutSlipSeq());
											stockDelData.put("SP_WHS_GUBUN", bundleBizOrdStockList.get(i).getSpWhsGubun());
											stockDelData.put("SP_WHS_IDX", bundleBizOrdStockList.get(i).getSpWhsIdx());
											stockDelData.put("SP_LOC_IDX", bundleBizOrdStockList.get(i).getSpLocIdx());
											stockDelData.put("SP_DESC", bundleBizOrdStockList.get(i).getSpDesc());
											stockDelData.put("SP_ETC1", bundleBizOrdStockList.get(i).getSpEtc1());
											stockDelData.put("SP_ETC2", bundleBizOrdStockList.get(i).getSpEtc2());
											stockDelData.put("SP_ETC2", bundleBizOrdStockList.get(i).getSpEtc3());
											bundleStockDel_array.add(stockDelData);
										}
									}

									// 제품입고 전표 삭제 JSON 배열
									JSONArray outProdDel_array = new JSONArray();
									// 수불 삭제 JSON배열
									JSONArray stockDel_array = new JSONArray();

									// 제품 출고 수불 삭제처리
									OutProdWhsAdmVo outProdWhsAdmVo = new OutProdWhsAdmVo();
									outProdWhsAdmVo.setRelationNo(workOrderVo.getWorkOrdResultIdx());
									outProdWhsAdmVo.setOutGubun("제품생산출고");
									List<OutProdWhsAdmVo> outProdWhsAdmList = new ArrayList<>();
									outProdWhsAdmList = outProdWhsAdmService.getOutSlipNoByRelationNo(outProdWhsAdmVo);
									StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();

									// 제품 폐기 수불 삭제처리
									OutProdWhsAdmVo outProdWhsAdmDisposalVo = new OutProdWhsAdmVo();
									outProdWhsAdmDisposalVo.setRelationNo(workOrderVo.getWorkOrdResultIdx());
									outProdWhsAdmDisposalVo.setOutGubun("제품폐기출고");
									List<OutProdWhsAdmVo> outProdWhsAdmDisposalList = new ArrayList<>();
									outProdWhsAdmDisposalList = outProdWhsAdmService
											.getOutSlipNoByRelationNo(outProdWhsAdmDisposalVo);
									StockPaymentAdmVo stockPaymentAdmDisposalVo = new StockPaymentAdmVo();

									// 해당 전표(제품출고)가 존재한다면 지우고 하도록
									if (outProdWhsAdmList.size() != 0) {
										for (int j = 0; j < outProdWhsAdmList.size(); j++) {
											JSONObject outProdData = new JSONObject();
											JSONObject stockDelData = new JSONObject();

											outProdData.put("OUT_SLIP_NO", outProdWhsAdmList.get(j).getOutSlipNo());
											outProdData.put("OUT_SLIP_SEQ", outProdWhsAdmList.get(j).getOutSlipSeq());
											outProdDel_array.add(outProdData);

											stockDelData.put("SP_SOURCE_NO", outProdWhsAdmList.get(j).getOutSlipNo() + "-"
													+ outProdWhsAdmList.get(j).getOutSlipSeq());
											stockDel_array.add(stockDelData);
										}
									}

									// 해당 전표(제품폐기출고)가 존재한다면 지우고 하도록
									if (outProdWhsAdmDisposalList.size() != 0) {
										for (int j = 0; j < outProdWhsAdmDisposalList.size(); j++) {
											JSONObject outProdData = new JSONObject();
											JSONObject stockDelData = new JSONObject();

											outProdData.put("OUT_SLIP_NO", outProdWhsAdmDisposalList.get(j).getOutSlipNo());
											outProdData.put("OUT_SLIP_SEQ", outProdWhsAdmDisposalList.get(j).getOutSlipSeq());
											outProdDel_array.add(outProdData);

											stockDelData.put("SP_SOURCE_NO", outProdWhsAdmDisposalList.get(j).getOutSlipNo() + "-" + outProdWhsAdmDisposalList.get(j).getOutSlipSeq());
											stockDel_array.add(stockDelData);
										}
									}

									// 번들링 수불도 같이 지우도록 merge
									outProdDel_array.addAll(bundleOutProdDel_array);
									stockDel_array.addAll(bundleStockDel_array);

									InProdWhsAdmVo inProdWhsAdmVo = new InProdWhsAdmVo();
									inProdWhsAdmVo.setDeleteJson(bundleInProdDel_array.toJSONString());
									inProdWhsAdmService.inProdWhsAdmDel(inProdWhsAdmVo); // 제품입고 전표 삭제
									outProdWhsAdmDisposalVo.setDeleteJson(outProdDel_array.toJSONString());
									outProdWhsAdmService.outProdWhsAdmDel(outProdWhsAdmDisposalVo); // 제품출고 전표 삭제
									stockPaymentAdmVo.setDeleteJson(stockDel_array.toJSONString());
									stockPaymentAdmService.stockPaymentAdmDel(stockPaymentAdmVo); // 제품 입,출고수불 삭제

									// 번들링 제품 입출고, 수불 등록
									inProdWhsAdmVo.setRegIdx(Utils.getUserIdx());
									inProdWhsAdmVo.setRegDate(DateUtil.getCurrentDateTime());
									inProdWhsAdmVo.setInsertJson(bundleInProdDel_array.toJSONString());

									outProdWhsAdmDisposalVo.setRegIdx(Utils.getUserIdx());
									outProdWhsAdmDisposalVo.setRegDate(DateUtil.getCurrentDateTime());
									outProdWhsAdmDisposalVo.setInsertJson(bundleOutProdDel_array.toJSONString());

									stockPaymentAdmVo.setRegIdx(Utils.getUserIdx());
									stockPaymentAdmVo.setRegDate(DateUtil.getCurrentDateTime());
									stockPaymentAdmVo.setInsertJson(bundleStockDel_array.toJSONString());

									inProdWhsAdmService.inProdWhsAdmCompulsionIns(inProdWhsAdmVo); // 번들링 제품입고 전표 등록
									outProdWhsAdmService.outProdWhsAdmCompulsionIns(outProdWhsAdmDisposalVo); // 번들링 제품출고 전표
																												// 등록
									stockPaymentAdmService.stockPaymentAdmCompulsionIns(stockPaymentAdmVo); // 번들링 제품 입,출고수불
																											// 등록

									// 제품출고처리
									stockManagementController.ProdOutput(stockManagementVoList);
									// 제품폐기처리
									stockManagementController.ProdOutput(stockManagementVoDisposalList);
								}

								jsonData.put("result", "ok");
							}
							// } else {
							// jsonData.put("message", "전체공정 특이사항을<br>확인 후 작업해주세요,.");
							// jsonData.put("result", "fail");
							// }
						} else if ("WC".equals(checkVo.getProgressStatus())) { // 현 공정정보가 완료인 경우
							jsonData.put("message", "이미 작업완료된 공정입니다.");
							jsonData.put("result", "fail");
						}
					} else {
						jsonData.put("message", "수주 진행이 아닌 공정입니다.");
						jsonData.put("result", "fail");
					}
				} else {
					jsonData.put("message", "수주 중지된 공정입니다.");
					jsonData.put("result", "fail");
				}
			} else {
				jsonData.put("message", "등록 권한이<br>없는 공정입니다.");
				jsonData.put("result", "fail");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}

	// 작업지시서 목록(공정별) 현공정 작업 실적 삭제
	@RequestMapping(value = "wm/workOrdPrcssResultDel", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrdPrcssResultDel(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("작업지시서 목록(공정별) 현공정 작업 실적 삭제" + workOrderVo);
		try {
			WorkOrderVo checkVo = new WorkOrderVo();
			checkVo.setWorkOrdIdx(workOrderVo.getWorkOrdIdx());
			checkVo.setWorkOrdPrcssIdx(workOrderVo.getWorkOrdPrcssIdx());
			checkVo = workOrderService.workOrdNextPrcssSel(workOrderVo);	
			// 다음 공정이 있을경우
			if (checkVo != null) {
				// 수주 중지 여부
				if (!"Y".equals(checkVo.getBizStopYn())) {
					if ("02".equals(checkVo.getBizStatusCd()) || "04".equals(checkVo.getBizStatusCd())) {
						// 다음 공정정보가 대기인 경우
						if ("PI".equals(checkVo.getProgressStatus())) {
							checkVo = workOrderService.workOrdSelWithPrcss(workOrderVo);
							boolean canWorkYn = false;
							String userIdx = Utils.getUserIdx();
							
							//공정의 작업자들 중 접속한 사용자의 식별자가 있을 경우 -> 등록 수정 삭제 가능 
							//								없을 경우 -> 불가능
							List<WorkOrderVo> workerLst = workOrderService.prcssWorkerLstByPrcssIdx(checkVo);
							List<WorkOrderVo> workerFilterLst = workerLst.stream().filter(v -> userIdx.equals(v.getPrcssWorkerIdx()) ).collect(Collectors.toList());
							
							//필터 리스트의 사이즈가 0보다 큰경우 -> 권한이있음 등록가능
							if( workerFilterLst.size() > 0 ) {
								workOrderService.workOrdPrcssResultDel(workOrderVo);
								if ("Y".equals(workOrderVo.getResultYn())) {
									// 다음공정식별자가 null인 경우 -> 다음공정이 없음 -> 마지막공정이므로 완제품 수불 발생
									if (checkVo.getPrcssNextIdx() == null) {
										// 제품입고 전표 조회 -> 이미 입고 시킨 제품이라면 -> 제품입고전표 지우고 입고수불 지우고 등록
										InProdWhsAdmVo inProdWhsAdmVo = new InProdWhsAdmVo();
										inProdWhsAdmVo.setRelationNo(workOrderVo.getIdx());
										inProdWhsAdmVo.setInGubun("생산");
										inProdWhsAdmVo = inProdWhsAdmService.getInSlipNoByRelationNo(inProdWhsAdmVo);
										StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();

										// 해당 전표가 존재한다면 지우고 하도록
										if (inProdWhsAdmVo != null) {
											// 제품입고전표 삭제 배열
											JSONArray inProdDel_array = new JSONArray();
											JSONObject inProdData = new JSONObject();
											inProdData.put("IN_SLIP_NO", inProdWhsAdmVo.getInSlipNo());
											inProdData.put("IN_SLIP_SEQ", inProdWhsAdmVo.getInSlipSeq());
											inProdDel_array.add(inProdData);
											inProdWhsAdmVo.setDeleteJson(inProdDel_array.toJSONString());

											inProdWhsAdmService.inProdWhsAdmDel(inProdWhsAdmVo); // 제품입고 전표 삭제
											// 수불 삭제 JSON배열
											JSONArray stockDel_array = new JSONArray();
											JSONObject stockData = new JSONObject();
											stockData.put("SP_SOURCE_NO", inProdWhsAdmVo.getInSlipNo() + "-" + inProdWhsAdmVo.getInSlipSeq());
											stockDel_array.add(stockData);
											stockPaymentAdmVo.setDeleteJson(stockDel_array.toJSONString());
											stockPaymentAdmService.stockPaymentAdmDel(stockPaymentAdmVo); // 제품 입고수불 삭제
										}

									}

									// 원지재단 수불발생 대상 -> 수불 발생 Y일경우 발생, 추가재단 여부 Y인경우
									if ("Y".equals(checkVo.getStockOption()) || "Y".equals(checkVo.getCutYn())) {
										// 자재출고 전표(OUT_SLIP_NO) 조회 -> RELATION_NO로 조회해서 전표 찾은 후에 -> 이미 출고 시킨 자재라면 ->
										// 자재출고전표 지우고 출고수불 지우기
										OutMatrWhsAdmVo outMatrWhsAdmVo = new OutMatrWhsAdmVo();
										outMatrWhsAdmVo.setRelationNo(workOrderVo.getIdx());
										outMatrWhsAdmVo.setOutGubun("생산투입");
										List<OutMatrWhsAdmVo> outMatrWhsAdmListVo = outMatrWhsAdmService .getOutSlipNoByRelationNo(outMatrWhsAdmVo);
										StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();

										// 해당 전표가 존재한다면 지우고 하도록
										if (outMatrWhsAdmListVo.size() > 0) {
											// 수불 삭제 JSON배열
											JSONArray stockDel_array = new JSONArray();
											for (int i = 0; i < outMatrWhsAdmListVo.size(); i++) {
												outMatrWhsAdmVo.setOutSlipNo(outMatrWhsAdmListVo.get(i).getOutSlipNo());
												outMatrWhsAdmVo.setOutSlipSeq(outMatrWhsAdmListVo.get(i).getOutSlipSeq());

												outMatrWhsAdmService.outMatrWhsAdmDel(outMatrWhsAdmVo); // 자재출고 전표 삭제
												JSONObject stockData = new JSONObject();
												stockData.put("SP_SOURCE_NO", outMatrWhsAdmListVo.get(i).getOutSlipNo() + "-" + outMatrWhsAdmListVo.get(i).getOutSlipSeq());
												stockDel_array.add(stockData);
											}
											stockPaymentAdmVo.setDeleteJson(stockDel_array.toJSONString());
											stockPaymentAdmService.stockPaymentAdmDel(stockPaymentAdmVo); // 출고수불 삭제
										}
									}

									// 마지막 공정일 경우 완제품 수불 발생
									if (checkVo.getPrcssNextIdx() == null) {
										// 제품입고 전표 조회 -> 이미 입고 시킨 제품이라면 -> 제품입고전표 지우고 입고수불 지우기
										InProdWhsAdmVo inProdWhsAdmVo = new InProdWhsAdmVo();
										inProdWhsAdmVo.setRelationNo(workOrderVo.getIdx());
										inProdWhsAdmVo.setInGubun("생산");
										inProdWhsAdmVo = inProdWhsAdmService.getInSlipNoByRelationNo(inProdWhsAdmVo);
										StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();

										// 해당 전표가 존재한다면 지우고 하도록
										if (inProdWhsAdmVo != null) {
											// 제품입고전표 삭제 배열
											JSONArray inProdDel_array = new JSONArray();
											JSONObject inProdData = new JSONObject();
											inProdData.put("IN_SLIP_NO", inProdWhsAdmVo.getInSlipNo());
											inProdData.put("IN_SLIP_SEQ", inProdWhsAdmVo.getInSlipSeq());
											inProdDel_array.add(inProdData);
											inProdWhsAdmVo.setDeleteJson(inProdDel_array.toJSONString());

											inProdWhsAdmService.inProdWhsAdmDel(inProdWhsAdmVo); // 제품입고 전표 삭제
											// 수불 삭제 JSON배열
											JSONArray stockDel_array = new JSONArray();
											JSONObject stockData = new JSONObject();
											stockData.put("SP_SOURCE_NO", inProdWhsAdmVo.getInSlipNo() + "-" + inProdWhsAdmVo.getInSlipSeq());
											stockDel_array.add(stockData);
											stockPaymentAdmVo.setDeleteJson(stockDel_array.toJSONString());
											stockPaymentAdmService.stockPaymentAdmDel(stockPaymentAdmVo); // 제품 입고수불 삭제
										}
									}

									jsonData.put("result", "ok");
								} else {
									jsonData.put("message", "다음 공정이 진행되어<br>실적 삭제가 불가능합니다.");
									jsonData.put("result", "fail");
								}
							} else {
								jsonData.put("message", "삭제 권한이<br>없는 공정입니다.");
								jsonData.put("result", "fail");
							}
						} else {
							// 다음 공정정보가 대기가 아닐 경우 삭제 불가능
							jsonData.put("message", "다음 공정이 진행되어<br>실적 삭제가 불가능합니다.");
							jsonData.put("result", "fail");
						}
					} else {
						jsonData.put("message", "수주 진행, 완료일 때<br>삭제가 가능합니다.");
						jsonData.put("result", "fail");
					}
				} else {
					jsonData.put("message", "수주 중지되어<br>실적 삭제가 불가능합니다.");
					jsonData.put("result", "fail");
				}
			} else {
				// 다음공정이 없는 경우(마지막 공정)
				checkVo = workOrderService.workOrdSelWithPrcss(workOrderVo);
				boolean canWorkYn = false;
				String userIdx = Utils.getUserIdx();
				
				//공정의 작업자들 중 접속한 사용자의 식별자가 있을 경우 -> 등록 수정 삭제 가능 
				//								없을 경우 -> 불가능
				List<WorkOrderVo> workerLst = workOrderService.prcssWorkerLstByPrcssIdx(checkVo);
				List<WorkOrderVo> workerFilterLst = workerLst.stream().filter(v -> userIdx.equals(v.getPrcssWorkerIdx()) ).collect(Collectors.toList());
				
				//필터 리스트의 사이즈가 0보다 큰경우 -> 권한이있음 등록가능
				if( workerFilterLst.size() > 0 ) {
					// 수주 중지
					if (!"Y".equals(checkVo.getBizStopYn())) {
						if ("02".equals(checkVo.getBizStatusCd()) || "04".equals(checkVo.getBizStatusCd())) {
							// 품질검사가 모두 미승인 경우
							WorkOrderVo workOrderQualityVo = workOrderService.workOrdPrcssResultQualityCheckByWorkOrdPrcssIdx(workOrderVo);
							// 품질검사 승인인것을 검색했을 때 수량이 0인경우 -> 모두 미승인상태
							if (Integer.parseInt(workOrderQualityVo.getResultCnt()) == 0) {
								workOrderService.workOrdPrcssResultDel(workOrderVo);
								if ("Y".equals(workOrderVo.getResultYn())) {
									// 다음공정식별자가 null인 경우 -> 다음공정이 없음 -> 마지막공정이므로 완제품 수불 발생
									if (checkVo.getPrcssNextIdx() == null) {
										// 제품입고 전표 조회 -> 이미 입고 시킨 제품이라면 -> 제품입고전표 지우고 입고수불 지우고 등록
										InProdWhsAdmVo inProdWhsAdmVo = new InProdWhsAdmVo();
										inProdWhsAdmVo.setRelationNo(workOrderVo.getIdx());
										inProdWhsAdmVo.setInGubun("생산");
										inProdWhsAdmVo = inProdWhsAdmService.getInSlipNoByRelationNo(inProdWhsAdmVo);
										StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();

										// 해당 전표가 존재한다면 지우고 하도록
										if (inProdWhsAdmVo != null) {
											// 제품입고전표 삭제 배열
											JSONArray inProdDel_array = new JSONArray();
											JSONObject inProdData = new JSONObject();
											inProdData.put("IN_SLIP_NO", inProdWhsAdmVo.getInSlipNo());
											inProdData.put("IN_SLIP_SEQ", inProdWhsAdmVo.getInSlipSeq());
											inProdDel_array.add(inProdData);
											inProdWhsAdmVo.setDeleteJson(inProdDel_array.toJSONString());

											inProdWhsAdmService.inProdWhsAdmDel(inProdWhsAdmVo); // 제품입고 전표 삭제
											// 수불 삭제 JSON배열
											JSONArray stockDel_array = new JSONArray();
											JSONObject stockData = new JSONObject();
											stockData.put("SP_SOURCE_NO", inProdWhsAdmVo.getInSlipNo() + "-" + inProdWhsAdmVo.getInSlipSeq());
											stockDel_array.add(stockData);
											stockPaymentAdmVo.setDeleteJson(stockDel_array.toJSONString());
											stockPaymentAdmService.stockPaymentAdmDel(stockPaymentAdmVo); // 제품 입고수불 삭제
										}
										// 마지막 공정을 삭제할경우 수주 진행으로 바꿔줘야함
										BizOrderVo bizOrderVo = new BizOrderVo();
										bizOrderVo.setIdx(checkVo.getBizOrdDtlIdx());
										bizOrderVo.setBizStatusCd("02");
										bizOrderVo.setUpdIdx(Utils.getUserIdx());
										bizOrderVo.setUpdDate(DateUtil.getCurrentDateTime());
										// 수주 진행 처리
										bizOrderService.bizOrderDtlStatusUpd(bizOrderVo);

									}

									// 원지재단 수불발생 대상 -> 수불 발생 Y일경우 발생, 추가재단 여부 Y인경우
									if ("Y".equals(checkVo.getStockOption()) || "Y".equals(checkVo.getCutYn())) {
										// 자재출고 전표(OUT_SLIP_NO) 조회 -> RELATION_NO로 조회해서 전표 찾은 후에 -> 이미 출고 시킨 자재라면 ->
										// 자재출고전표 지우고 출고수불 지우기
										OutMatrWhsAdmVo outMatrWhsAdmVo = new OutMatrWhsAdmVo();
										outMatrWhsAdmVo.setRelationNo(workOrderVo.getIdx());
										outMatrWhsAdmVo.setOutGubun("생산투입");
										List<OutMatrWhsAdmVo> outMatrWhsAdmListVo = outMatrWhsAdmService.getOutSlipNoByRelationNo(outMatrWhsAdmVo);
										StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();

										// 해당 전표가 존재한다면 지우고 하도록
										if (outMatrWhsAdmListVo.size() > 0) {
											// 수불 삭제 JSON배열
											JSONArray stockDel_array = new JSONArray();
											for (int i = 0; i < outMatrWhsAdmListVo.size(); i++) {
												outMatrWhsAdmVo.setOutSlipNo(outMatrWhsAdmListVo.get(i).getOutSlipNo());
												outMatrWhsAdmVo.setOutSlipSeq(outMatrWhsAdmListVo.get(i).getOutSlipSeq());

												outMatrWhsAdmService.outMatrWhsAdmDel(outMatrWhsAdmVo); // 자재출고 전표 삭제
												JSONObject stockData = new JSONObject();
												stockData.put("SP_SOURCE_NO", outMatrWhsAdmListVo.get(i).getOutSlipNo() + "-" + outMatrWhsAdmListVo.get(i).getOutSlipSeq());
												stockDel_array.add(stockData);
											}
											stockPaymentAdmVo.setDeleteJson(stockDel_array.toJSONString());
											stockPaymentAdmService.stockPaymentAdmDel(stockPaymentAdmVo); // 출고수불 삭제
										}
									}
									jsonData.put("result", "ok");
								} else {
									jsonData.put("message", "품질 검사된 공정의 실적입니다.<br>삭제할 수 없습니다.");
									jsonData.put("result", "fail");
								}
							} else {
								jsonData.put("message", "품질 검사된 공정의 실적입니다.<br>삭제할 수 없습니다.");
								jsonData.put("result", "fail");
							}
						} else {
							jsonData.put("message", "수주 진행, 완료일 때<br>삭제가 가능합니다.");
							jsonData.put("result", "fail");
						}
					} else {
						jsonData.put("message", "수주 중지되어<br>실적 삭제가 불가능합니다.");
						jsonData.put("result", "fail");
					}
				} else {
					jsonData.put("message", "삭제 권한이<br>없는 공정입니다.");
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

	// 작업지시서 목록(공정별) 현공정 작업 실적,번들링 삭제
	@RequestMapping(value = "wm/workOrdPrcssResultDelBundle", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrdPrcssResultDelBundle(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("작업지시서 목록(공정별) 현공정 작업 실적,번들링 삭제" + workOrderVo);
		try {
			WorkOrderVo checkVo = new WorkOrderVo();
			checkVo.setWorkOrdIdx(workOrderVo.getWorkOrdIdx());
			checkVo.setWorkOrdPrcssIdx(workOrderVo.getWorkOrdPrcssIdx());
			checkVo = workOrderService.workOrdNextPrcssSel(workOrderVo);
			// 다음 공정이 있을경우
			if (checkVo != null) {
				if (!"Y".equals(checkVo.getBizStopYn())) {
					if ("02".equals(checkVo.getBizStatusCd()) || "04".equals(checkVo.getBizStatusCd())) {
						// 다음 공정정보가 대기인 경우
						if ("PI".equals(checkVo.getProgressStatus())) {
							checkVo = workOrderService.workOrdSelWithPrcss(workOrderVo);

							boolean canWorkYn = false;
							String userIdx = Utils.getUserIdx();
							
							//공정의 작업자들 중 접속한 사용자의 식별자가 있을 경우 -> 등록 수정 삭제 가능 
							//								없을 경우 -> 불가능
							List<WorkOrderVo> workerLst = workOrderService.prcssWorkerLstByPrcssIdx(checkVo);
							List<WorkOrderVo> workerFilterLst = workerLst.stream().filter(v -> userIdx.equals(v.getPrcssWorkerIdx()) ).collect(Collectors.toList());
							//필터 리스트의 사이즈가 0보다 큰경우 -> 권한이있음 등록가능
							if( workerFilterLst.size() > 0 ) {
								// 다음공정식별자가 null인 경우 -> 다음공정이 없음 -> 마지막공정이므로 완제품 수불 발생
								if (checkVo.getPrcssNextIdx() == null) {
									// 제품입고 전표 조회 -> 이미 입고 시킨 제품이라면 -> 제품입고전표 지우고 입고수불 지우고 등록
									InProdWhsAdmVo inProdWhsAdmVo = new InProdWhsAdmVo();
									inProdWhsAdmVo.setRelationNo(workOrderVo.getIdx());
									inProdWhsAdmVo.setInGubun("생산");
									inProdWhsAdmVo = inProdWhsAdmService.getInSlipNoByRelationNo(inProdWhsAdmVo);
									StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();

									// 해당 전표가 존재한다면 지우고 하도록
									if (inProdWhsAdmVo != null) {
										// 제품입고전표 삭제 배열
										JSONArray inProdDel_array = new JSONArray();
										JSONObject inProdData = new JSONObject();
										inProdData.put("IN_SLIP_NO", inProdWhsAdmVo.getInSlipNo());
										inProdData.put("IN_SLIP_SEQ", inProdWhsAdmVo.getInSlipSeq());
										inProdDel_array.add(inProdData);
										inProdWhsAdmVo.setDeleteJson(inProdDel_array.toJSONString());

										inProdWhsAdmService.inProdWhsAdmDel(inProdWhsAdmVo); // 제품입고 전표 삭제
										// 수불 삭제 JSON배열
										JSONArray stockDel_array = new JSONArray();
										JSONObject stockData = new JSONObject();
										stockData.put("SP_SOURCE_NO", inProdWhsAdmVo.getInSlipNo() + "-" + inProdWhsAdmVo.getInSlipSeq());
										stockDel_array.add(stockData);
										stockPaymentAdmVo.setDeleteJson(stockDel_array.toJSONString());
										stockPaymentAdmService.stockPaymentAdmDel(stockPaymentAdmVo); // 제품 입고수불 삭제
									}
								}

								// 수불 발생 Y일경우 발생 
								if ("Y".equals(checkVo.getStockOption())) {
									// 제품 출고 수불 삭제처리
									OutProdWhsAdmVo outProdWhsAdmVo = new OutProdWhsAdmVo();
									outProdWhsAdmVo.setRelationNo(workOrderVo.getIdx());
									outProdWhsAdmVo.setOutGubun("제품생산출고");
									List<OutProdWhsAdmVo> outProdWhsAdmList = new ArrayList<>();
									outProdWhsAdmList = outProdWhsAdmService.getOutSlipNoByRelationNo(outProdWhsAdmVo);
									StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();

									// 제품 폐기 수불 삭제처리
									OutProdWhsAdmVo outProdWhsAdmDisposalVo = new OutProdWhsAdmVo();
									outProdWhsAdmDisposalVo.setRelationNo(workOrderVo.getIdx());
									outProdWhsAdmDisposalVo.setOutGubun("제품폐기출고");
									List<OutProdWhsAdmVo> outProdWhsAdmDisposalList = new ArrayList<>();
									outProdWhsAdmDisposalList = outProdWhsAdmService.getOutSlipNoByRelationNo(outProdWhsAdmDisposalVo);
									StockPaymentAdmVo stockPaymentAdmDisposalVo = new StockPaymentAdmVo();

									// 제품입고 전표 삭제 JSON 배열
									JSONArray outProdDel_array = new JSONArray();
									// 수불 삭제 JSON배열
									JSONArray stockDel_array = new JSONArray();

									// 해당 전표(제품폐기출고)가 존재한다면 지우고 하도록
									if (outProdWhsAdmDisposalList.size() != 0) {
										for (int j = 0; j < outProdWhsAdmDisposalList.size(); j++) {
											JSONObject outProdData = new JSONObject();
											JSONObject stockDelData = new JSONObject();
											outProdData.put("OUT_SLIP_NO", outProdWhsAdmDisposalList.get(j).getOutSlipNo());
											outProdData.put("OUT_SLIP_SEQ", outProdWhsAdmDisposalList.get(j).getOutSlipSeq());
											outProdDel_array.add(outProdData);

											stockDelData.put("SP_SOURCE_NO", outProdWhsAdmDisposalList.get(j).getOutSlipNo() + "-" + outProdWhsAdmDisposalList.get(j).getOutSlipSeq());
											stockDel_array.add(stockDelData);
										}
									}

									// 해당 전표가 존재한다면 지우고 하도록
									if (outProdWhsAdmList.size() != 0) {
										for (int j = 0; j < outProdWhsAdmList.size(); j++) {
											JSONObject outProdData = new JSONObject();
											JSONObject stockDelData = new JSONObject();
											outProdData.put("OUT_SLIP_NO", outProdWhsAdmList.get(j).getOutSlipNo());
											outProdData.put("OUT_SLIP_SEQ", outProdWhsAdmList.get(j).getOutSlipSeq());
											outProdDel_array.add(outProdData);

											stockDelData.put("SP_SOURCE_NO", outProdWhsAdmList.get(j).getOutSlipNo() + "-"
													+ outProdWhsAdmList.get(j).getOutSlipSeq());
											stockDel_array.add(stockDelData);

										}
									}
									outProdWhsAdmVo.setDeleteJson(outProdDel_array.toJSONString());
									outProdWhsAdmService.outProdWhsAdmDel(outProdWhsAdmVo); // 제품입고 전표 삭제
									stockPaymentAdmVo.setDeleteJson(stockDel_array.toJSONString());
									stockPaymentAdmService.stockPaymentAdmDel(stockPaymentAdmVo); // 제품 입고수불 삭제
								}

								// 마지막 공정일 경우 완제품 수불 발생
								if (checkVo.getPrcssNextIdx() == null) {
									// 제품입고 전표 조회 -> 이미 입고 시킨 제품이라면 -> 제품입고전표 지우고 입고수불 지우기
									InProdWhsAdmVo inProdWhsAdmVo = new InProdWhsAdmVo();
									inProdWhsAdmVo.setRelationNo(workOrderVo.getIdx());
									inProdWhsAdmVo.setInGubun("생산");
									inProdWhsAdmVo = inProdWhsAdmService.getInSlipNoByRelationNo(inProdWhsAdmVo);
									StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();

									// 해당 전표가 존재한다면 지우고 하도록
									if (inProdWhsAdmVo != null) {
										// 제품입고전표 삭제 배열
										JSONArray inProdDel_array = new JSONArray();
										JSONObject inProdData = new JSONObject();
										inProdData.put("IN_SLIP_NO", inProdWhsAdmVo.getInSlipNo());
										inProdData.put("IN_SLIP_SEQ", inProdWhsAdmVo.getInSlipSeq());
										inProdDel_array.add(inProdData);
										inProdWhsAdmVo.setDeleteJson(inProdDel_array.toJSONString());

										inProdWhsAdmService.inProdWhsAdmDel(inProdWhsAdmVo); // 제품입고 전표 삭제
										// 수불 삭제 JSON배열
										JSONArray stockDel_array = new JSONArray();
										JSONObject stockData = new JSONObject();
										stockData.put("SP_SOURCE_NO", inProdWhsAdmVo.getInSlipNo() + "-" + inProdWhsAdmVo.getInSlipSeq());
										stockDel_array.add(stockData);
										stockPaymentAdmVo.setDeleteJson(stockDel_array.toJSONString());
										stockPaymentAdmService.stockPaymentAdmDel(stockPaymentAdmVo); // 제품 입고수불 삭제
									}
								}

								workOrderService.workOrdPrcssResultDel(workOrderVo);
								if ("Y".equals(workOrderVo.getResultYn())) {
									jsonData.put("result", "ok");
								} else {
									jsonData.put("message", "다음 공정이 진행되어<br>실적 삭제가 불가능합니다.");
									jsonData.put("result", "fail");
								}
							} else {
								jsonData.put("message", "삭제 권한이<br>없는 공정입니다.");
								jsonData.put("result", "fail");
							}
						} else {
							// 다음 공정정보가 대기가 아닐 경우 삭제 불가능
							jsonData.put("message", "다음 공정이 진행되어<br>실적 삭제가 불가능합니다.");
							jsonData.put("result", "fail");
						}
					} else {
						jsonData.put("message", "수주 진행, 완료일 때<br>실적 삭제가 가능합니다.");
						jsonData.put("result", "fail");
					}
				} else {
					jsonData.put("message", "수주 중지되어<br>실적 삭제가 불가능합니다.");
					jsonData.put("result", "fail");
				}
			} else {
				// 다음공정이 없는 경우
				checkVo = workOrderService.workOrdSelWithPrcss(workOrderVo);
				boolean canWorkYn = false;
				String userIdx = Utils.getUserIdx();
				
				//공정의 작업자들 중 접속한 사용자의 식별자가 있을 경우 -> 등록 수정 삭제 가능 
				//								없을 경우 -> 불가능
				List<WorkOrderVo> workerLst = workOrderService.prcssWorkerLstByPrcssIdx(checkVo);
				List<WorkOrderVo> workerFilterLst = workerLst.stream().filter(v -> userIdx.equals(v.getPrcssWorkerIdx()) ).collect(Collectors.toList());
				
				//필터 리스트의 사이즈가 0보다 큰경우 -> 권한이있음 등록가능
				if( workerFilterLst.size() > 0 ) {
					if (!"Y".equals(checkVo.getBizStopYn())) {
						if ("02".equals(checkVo.getBizStatusCd()) || "04".equals(checkVo.getBizStatusCd())) {
							// 품질검사가 모두 미승인 경우
							WorkOrderVo workOrderQualityVo = workOrderService.workOrdPrcssResultQualityCheckByWorkOrdPrcssIdx(workOrderVo);
							// 품질검사 승인인것을 검색했을 때 수량이 0인경우 -> 모두 미승인상태
							if (Integer.parseInt(workOrderQualityVo.getResultCnt()) == 0) {
								// 다음공정식별자가 null인 경우 -> 다음공정이 없음 -> 마지막공정이므로 완제품 수불 발생
								if (checkVo.getPrcssNextIdx() == null) {
									// 제품입고 전표 조회 -> 이미 입고 시킨 제품이라면 -> 제품입고전표 지우고 입고수불 지우고 등록
									InProdWhsAdmVo inProdWhsAdmVo = new InProdWhsAdmVo();
									inProdWhsAdmVo.setRelationNo(workOrderVo.getIdx());
									inProdWhsAdmVo.setInGubun("생산");
									inProdWhsAdmVo = inProdWhsAdmService.getInSlipNoByRelationNo(inProdWhsAdmVo);
									StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();

									// 해당 전표가 존재한다면 지우고 하도록
									if (inProdWhsAdmVo != null) {
										// 제품입고전표 삭제 배열
										JSONArray inProdDel_array = new JSONArray();
										JSONObject inProdData = new JSONObject();
										inProdData.put("IN_SLIP_NO", inProdWhsAdmVo.getInSlipNo());
										inProdData.put("IN_SLIP_SEQ", inProdWhsAdmVo.getInSlipSeq());
										inProdDel_array.add(inProdData);
										inProdWhsAdmVo.setDeleteJson(inProdDel_array.toJSONString());

										inProdWhsAdmService.inProdWhsAdmDel(inProdWhsAdmVo); // 제품입고 전표 삭제
										// 수불 삭제 JSON배열
										JSONArray stockDel_array = new JSONArray();
										JSONObject stockData = new JSONObject();
										stockData.put("SP_SOURCE_NO", inProdWhsAdmVo.getInSlipNo() + "-" + inProdWhsAdmVo.getInSlipSeq());
										stockDel_array.add(stockData);
										stockPaymentAdmVo.setDeleteJson(stockDel_array.toJSONString());
										stockPaymentAdmService.stockPaymentAdmDel(stockPaymentAdmVo); // 제품 입고수불 삭제
									}
									// 마지막 공정을 삭제할경우 수주 진행으로 바꿔줘야함
									BizOrderVo bizOrderVo = new BizOrderVo();
									bizOrderVo.setIdx(checkVo.getBizOrdDtlIdx());
									bizOrderVo.setBizStatusCd("02");
									bizOrderVo.setUpdIdx(Utils.getUserIdx());
									bizOrderVo.setUpdDate(DateUtil.getCurrentDateTime());
									// 수주 진행 처리
									bizOrderService.bizOrderDtlStatusUpd(bizOrderVo);
								}

								// 수불 발생 Y일경우 발생
								if ("Y".equals(checkVo.getStockOption())) {
									// 제품 출고 수불 삭제처리
									OutProdWhsAdmVo outProdWhsAdmVo = new OutProdWhsAdmVo();
									outProdWhsAdmVo.setRelationNo(workOrderVo.getIdx());
									outProdWhsAdmVo.setOutGubun("제품생산출고");
									List<OutProdWhsAdmVo> outProdWhsAdmList = new ArrayList<>();
									outProdWhsAdmList = outProdWhsAdmService.getOutSlipNoByRelationNo(outProdWhsAdmVo);
									StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();

									// 제품 폐기 수불 삭제처리
									OutProdWhsAdmVo outProdWhsAdmDisposalVo = new OutProdWhsAdmVo();
									outProdWhsAdmDisposalVo.setRelationNo(workOrderVo.getIdx());
									outProdWhsAdmDisposalVo.setOutGubun("제품폐기출고");
									List<OutProdWhsAdmVo> outProdWhsAdmDisposalList = new ArrayList<>();
									outProdWhsAdmDisposalList = outProdWhsAdmService.getOutSlipNoByRelationNo(outProdWhsAdmDisposalVo);
									StockPaymentAdmVo stockPaymentAdmDisposalVo = new StockPaymentAdmVo();

									// 제품입고 전표 삭제 JSON 배열
									JSONArray outProdDel_array = new JSONArray();
									// 수불 삭제 JSON배열
									JSONArray stockDel_array = new JSONArray();
									// 해당 전표(제품폐기출고)가 존재한다면 지우고 하도록
									if (outProdWhsAdmDisposalList.size() != 0) {
										for (int j = 0; j < outProdWhsAdmDisposalList.size(); j++) {
											JSONObject outProdData = new JSONObject();
											JSONObject stockDelData = new JSONObject();
											outProdData.put("OUT_SLIP_NO", outProdWhsAdmDisposalList.get(j).getOutSlipNo());
											outProdData.put("OUT_SLIP_SEQ", outProdWhsAdmDisposalList.get(j).getOutSlipSeq());
											outProdDel_array.add(outProdData);

											stockDelData.put("SP_SOURCE_NO", outProdWhsAdmDisposalList.get(j).getOutSlipNo() + "-" + outProdWhsAdmDisposalList.get(j).getOutSlipSeq());
											stockDel_array.add(stockDelData);
										}
									}
									// 해당 전표가 존재한다면 지우고 하도록
									if (outProdWhsAdmList.size() != 0) {
										for (int j = 0; j < outProdWhsAdmList.size(); j++) {
											JSONObject outProdData = new JSONObject();
											JSONObject stockDelData = new JSONObject();

											outProdData.put("OUT_SLIP_NO", outProdWhsAdmList.get(j).getOutSlipNo());
											outProdData.put("OUT_SLIP_SEQ", outProdWhsAdmList.get(j).getOutSlipSeq());
											outProdDel_array.add(outProdData);

											stockDelData.put("SP_SOURCE_NO", outProdWhsAdmList.get(j).getOutSlipNo() + "-" + outProdWhsAdmList.get(j).getOutSlipSeq());
											stockDel_array.add(stockDelData);
										}
									}

									// 해당 번들링의 실적들 + 번들링에 묶인 수주들의 수불 원복처리
									// 해당 번들링실적 IDX로 hist조회해서 원복처리
									List<WorkOrderVo> bundleHistList = workOrderService
											.bundleWorkResultHistSel(workOrderVo);
									JSONArray workOrderBundleResultUpdate_array = new JSONArray();
									// 번들링목록에있는 수주상세식별자
									String bunleBizOrdDtlIdxString = "";
									for (int i = 0; i < bundleHistList.size(); i++) {
										JSONObject resultUpdateData = new JSONObject();
										bunleBizOrdDtlIdxString = bunleBizOrdDtlIdxString.concat(bundleHistList.get(i).getBizOrdDtlIdx()).concat(",");
										resultUpdateData.put("BUNDLE_RESULT_IDX",bundleHistList.get(i).getBundleResultIdx());
										resultUpdateData.put("BIZ_ORD_DTL_NO", bundleHistList.get(i).getBizOrdDtlNo());
										resultUpdateData.put("WOPR_IDX", bundleHistList.get(i).getWoprIdx());
										resultUpdateData.put("BEFORE_FAIR_QTY", bundleHistList.get(i).getBeforeFairQty());
										resultUpdateData.put("BEFORE_FAULTY_QTY",bundleHistList.get(i).getBeforeFaultyQty());
										resultUpdateData.put("AFTER_FAIR_QTY", bundleHistList.get(i).getBeforeFairQty());
										resultUpdateData.put("AFTER_FAULTY_QTY",bundleHistList.get(i).getBeforeFaultyQty());
										resultUpdateData.put("DISPOSAL_QTY", "0");
										// after수량에 before수량, 폐기수량 0으로해서 실적 원복처리
										workOrderBundleResultUpdate_array.add(resultUpdateData);
									}
									if (bunleBizOrdDtlIdxString.length() > 0) {
										bunleBizOrdDtlIdxString = bunleBizOrdDtlIdxString.substring(0,
												bunleBizOrdDtlIdxString.length() - 1);
									}
									// 번들링 수주목록의 실적들 업데이트 & hist 기록
									workOrderVo.setUpdAndInsList(workOrderBundleResultUpdate_array.toJSONString());
									workOrderVo.setIuGubun("update");
									workOrderVo.setRegIdx(Utils.getUserIdx());
									workOrderVo.setRegDate(DateUtil.getCurrentDateTime());
									workOrderVo.setUpdIdx(Utils.getUserIdx());
									workOrderVo.setUpdDate(DateUtil.getCurrentDateTime());
									workOrderService.workResultUpdAndHistIns(workOrderVo);
									workOrderVo.setBizOrdDtlIdxString(bunleBizOrdDtlIdxString);
									// 이 밑에 번들링에 포함된 수주의 공정들의 실적리스트에는 수정된 수주상세idx, 실적idx, 작업량, 불량이 들어있다.
									List<WorkOrderVo> workOrderBundleUpdateResultList = workOrderService.bundleEndPrcssWorkResultList(workOrderVo);
									// 번들링 수주목록의 실적들의 수불 발생 기록
									workOrderVo.setSelectList(workOrderBundleResultUpdate_array.toJSONString());
									List<WorkOrderVo> bundleBizOrdStockList = workOrderService.bundleBizOrdStockList(workOrderVo);
									// 제품입,출고 전표 삭제 JSON 배열
									JSONArray bundleInProdDel_array = new JSONArray();
									JSONArray bundleOutProdDel_array = new JSONArray();
									// 수불 삭제 JSON배열
									JSONArray bundleStockDel_array = new JSONArray();
									for (int i = 0; i < bundleBizOrdStockList.size(); i++) {
										JSONObject inOutProdData = new JSONObject();
										JSONObject stockDelData = new JSONObject();
										String spQty = "";
										WorkOrderVo filterTargetVo = bundleBizOrdStockList.get(i);
										if ("품질적합".equals(bundleBizOrdStockList.get(i).getInOutGubun())
												|| "품질폐기".equals(bundleBizOrdStockList.get(i).getInOutGubun())
												|| "품질".equals(bundleBizOrdStockList.get(i).getInOutGubun())) {
											// 품질일경우 수주상세번호로 조회
											WorkOrderVo filterVo = workOrderBundleUpdateResultList.stream()
																								.filter(v -> StringUtils.equals(filterTargetVo.getRelationNo(),v.getBizOrdDtlNo()))
																								.findAny().orElse(null);
											spQty = filterVo.getFairQty();
										} else if ("생산".equals(bundleBizOrdStockList.get(i).getInOutGubun())) {
											// 생산일경우 실적의 IDX로 조회
											WorkOrderVo filterVo = workOrderBundleUpdateResultList.stream()
																								.filter(v -> StringUtils.equals(filterTargetVo.getRelationNo(), v.getWorkOrdResultIdx()))
																								.findAny().orElse(null);
											spQty = filterVo.getFairQty();
										}

										if ("IN".equals(bundleBizOrdStockList.get(i).getStockGubun())) {
											// 입고
											inOutProdData.put("IN_SLIP_NO", bundleBizOrdStockList.get(i).getInOutSlipNo());
											inOutProdData.put("IN_SLIP_SEQ", bundleBizOrdStockList.get(i).getInOutSlipSeq());
											inOutProdData.put("ITEM_GUBUN", bundleBizOrdStockList.get(i).getItemGubun());
											inOutProdData.put("IN_GUBUN", bundleBizOrdStockList.get(i).getInOutGubun());
											inOutProdData.put("ITEM_CD", bundleBizOrdStockList.get(i).getItemCd());
											inOutProdData.put("PRE_IN_QTY", bundleBizOrdStockList.get(i).getPreInOutQty());
											inOutProdData.put("IN_QTY", spQty);
											inOutProdData.put("REMAIN_QTY", bundleBizOrdStockList.get(i).getRemainQty());
											inOutProdData.put("PRE_IN_DATE", bundleBizOrdStockList.get(i).getPreInOutDate());
											inOutProdData.put("IN_DATE", bundleBizOrdStockList.get(i).getInOutDate());
											inOutProdData.put("IN_CORP_CD", bundleBizOrdStockList.get(i).getInOutCorpCd());
											inOutProdData.put("IN_STATUS", bundleBizOrdStockList.get(i).getInOutStatus());
											inOutProdData.put("LOT_NO", bundleBizOrdStockList.get(i).getLotNo());
											inOutProdData.put("RELATION_NO", bundleBizOrdStockList.get(i).getRelationNo());
											inOutProdData.put("WHS_GUBUN", bundleBizOrdStockList.get(i).getWhsGubun());
											inOutProdData.put("WHS_IDX", bundleBizOrdStockList.get(i).getWhsIdx());
											inOutProdData.put("LOC_IDX", bundleBizOrdStockList.get(i).getLocIdx());
											inOutProdData.put("IN_USER_IDX", bundleBizOrdStockList.get(i).getInUserIdx());
											inOutProdData.put("IN_DESC", bundleBizOrdStockList.get(i).getInDesc());
											bundleInProdDel_array.add(inOutProdData);

											stockDelData.put("SP_NO", bundleBizOrdStockList.get(i).getSpNo());
											stockDelData.put("SP_SEQ", bundleBizOrdStockList.get(i).getSpSeq());
											stockDelData.put("SP_GUBUN", bundleBizOrdStockList.get(i).getSpGubun());
											stockDelData.put("SP_IDX", bundleBizOrdStockList.get(i).getSpIdx());
											stockDelData.put("SP_TYPE", bundleBizOrdStockList.get(i).getSpType());
											stockDelData.put("SP_TYPE2", bundleBizOrdStockList.get(i).getSpType2());
											stockDelData.put("SP_DATE", bundleBizOrdStockList.get(i).getSpDate());
											stockDelData.put("SP_QTY", spQty);
											stockDelData.put("SP_LOT_NO", bundleBizOrdStockList.get(i).getSpLotNo());
											stockDelData.put("SP_SOURCE_NO", bundleBizOrdStockList.get(i).getInOutSlipNo() + "-" + bundleBizOrdStockList.get(i).getInOutSlipSeq());
											stockDelData.put("SP_WHS_GUBUN", bundleBizOrdStockList.get(i).getSpWhsGubun());
											stockDelData.put("SP_WHS_IDX", bundleBizOrdStockList.get(i).getSpWhsIdx());
											stockDelData.put("SP_LOC_IDX", bundleBizOrdStockList.get(i).getSpLocIdx());
											stockDelData.put("SP_DESC", bundleBizOrdStockList.get(i).getSpDesc());
											stockDelData.put("SP_ETC1", bundleBizOrdStockList.get(i).getSpEtc1());
											stockDelData.put("SP_ETC2", bundleBizOrdStockList.get(i).getSpEtc2());
											stockDelData.put("SP_ETC2", bundleBizOrdStockList.get(i).getSpEtc3());
											bundleStockDel_array.add(stockDelData);
										} else if ("OUT".equals(bundleBizOrdStockList.get(i).getStockGubun())) {
											// 출고
											inOutProdData.put("OUT_SLIP_NO", bundleBizOrdStockList.get(i).getInOutSlipNo());
											inOutProdData.put("OUT_SLIP_SEQ", bundleBizOrdStockList.get(i).getInOutSlipSeq());
											inOutProdData.put("ITEM_GUBUN", bundleBizOrdStockList.get(i).getItemGubun());
											inOutProdData.put("OUT_GUBUN", bundleBizOrdStockList.get(i).getInOutGubun());
											inOutProdData.put("ITEM_IDX", bundleBizOrdStockList.get(i).getItemCd());
											inOutProdData.put("CAR_ASSIGNMENT", bundleBizOrdStockList.get(i).getCarAssignment());
											inOutProdData.put("PRE_OUT_QTY", bundleBizOrdStockList.get(i).getPreInOutQty());
											inOutProdData.put("OUT_QTY", bundleBizOrdStockList.get(i).getInOutQty());
											inOutProdData.put("REMAIN_QTY", bundleBizOrdStockList.get(i).getRemainQty());
											inOutProdData.put("PRE_OUT_DATE", bundleBizOrdStockList.get(i).getPreInOutDate());
											inOutProdData.put("OUT_DATE", bundleBizOrdStockList.get(i).getInOutDate());
											inOutProdData.put("OUT_CORP_IDX", bundleBizOrdStockList.get(i).getInOutCorpCd());
											inOutProdData.put("OUT_STATUS", bundleBizOrdStockList.get(i).getInOutStatus());
											inOutProdData.put("LOT_NO", bundleBizOrdStockList.get(i).getLotNo());
											inOutProdData.put("RELATION_NO", bundleBizOrdStockList.get(i).getRelationNo());
											inOutProdData.put("WHS_GUBUN", bundleBizOrdStockList.get(i).getWhsGubun());
											inOutProdData.put("WHS_IDX", bundleBizOrdStockList.get(i).getWhsIdx());
											inOutProdData.put("LOC_IDX", bundleBizOrdStockList.get(i).getLocIdx());
											inOutProdData.put("OUT_DESC", bundleBizOrdStockList.get(i).getOutDesc());
											inOutProdData.put("OUT_PROD_ETC1", bundleBizOrdStockList.get(i).getOutProdEtc1());
											inOutProdData.put("OUT_PROD_ETC2", bundleBizOrdStockList.get(i).getOutProdEtc2());
											inOutProdData.put("OUT_PROD_ETC3", bundleBizOrdStockList.get(i).getOutProdEtc3());
											inOutProdData.put("OUT_PROD_ETC4", bundleBizOrdStockList.get(i).getOutProdEtc4());
											inOutProdData.put("OUT_PROD_ETC5", bundleBizOrdStockList.get(i).getOutProdEtc5());
											bundleOutProdDel_array.add(inOutProdData);

											stockDelData.put("SP_NO", bundleBizOrdStockList.get(i).getSpNo());
											stockDelData.put("SP_SEQ", bundleBizOrdStockList.get(i).getSpSeq());
											stockDelData.put("SP_GUBUN", bundleBizOrdStockList.get(i).getSpGubun());
											stockDelData.put("SP_IDX", bundleBizOrdStockList.get(i).getSpIdx());
											stockDelData.put("SP_TYPE", bundleBizOrdStockList.get(i).getSpType());
											stockDelData.put("SP_TYPE2", bundleBizOrdStockList.get(i).getSpType2());
											stockDelData.put("SP_DATE", bundleBizOrdStockList.get(i).getSpDate());
											stockDelData.put("SP_QTY", spQty);
											stockDelData.put("SP_LOT_NO", bundleBizOrdStockList.get(i).getSpLotNo());
											stockDelData.put("SP_SOURCE_NO", bundleBizOrdStockList.get(i).getInOutSlipNo() + "-" + bundleBizOrdStockList.get(i).getInOutSlipSeq());
											stockDelData.put("SP_WHS_GUBUN", bundleBizOrdStockList.get(i).getSpWhsGubun());
											stockDelData.put("SP_WHS_IDX", bundleBizOrdStockList.get(i).getSpWhsIdx());
											stockDelData.put("SP_LOC_IDX", bundleBizOrdStockList.get(i).getSpLocIdx());
											stockDelData.put("SP_DESC", bundleBizOrdStockList.get(i).getSpDesc());
											stockDelData.put("SP_ETC1", bundleBizOrdStockList.get(i).getSpEtc1());
											stockDelData.put("SP_ETC2", bundleBizOrdStockList.get(i).getSpEtc2());
											stockDelData.put("SP_ETC2", bundleBizOrdStockList.get(i).getSpEtc3());
											bundleStockDel_array.add(stockDelData);
										}
									}
									// 번들링 수불도 같이 지우도록 merge
									outProdDel_array.addAll(bundleOutProdDel_array);
									stockDel_array.addAll(bundleStockDel_array);

									InProdWhsAdmVo inProdWhsAdmVo = new InProdWhsAdmVo();
									inProdWhsAdmVo.setDeleteJson(bundleInProdDel_array.toJSONString());
									inProdWhsAdmService.inProdWhsAdmDel(inProdWhsAdmVo); // 제품입고 전표 삭제
									outProdWhsAdmVo.setDeleteJson(outProdDel_array.toJSONString());
									outProdWhsAdmService.outProdWhsAdmDel(outProdWhsAdmVo); // 제품입고 전표 삭제
									stockPaymentAdmVo.setDeleteJson(stockDel_array.toJSONString());
									stockPaymentAdmService.stockPaymentAdmDel(stockPaymentAdmVo); // 제품 입고수불 삭제

									// 번들링 제품 입출고, 수불 등록
									inProdWhsAdmVo.setRegIdx(Utils.getUserIdx());
									inProdWhsAdmVo.setRegDate(DateUtil.getCurrentDateTime());
									inProdWhsAdmVo.setInsertJson(bundleInProdDel_array.toJSONString());

									outProdWhsAdmDisposalVo.setRegIdx(Utils.getUserIdx());
									outProdWhsAdmDisposalVo.setRegDate(DateUtil.getCurrentDateTime());
									outProdWhsAdmDisposalVo.setInsertJson(bundleOutProdDel_array.toJSONString());

									stockPaymentAdmVo.setRegIdx(Utils.getUserIdx());
									stockPaymentAdmVo.setRegDate(DateUtil.getCurrentDateTime());
									stockPaymentAdmVo.setInsertJson(bundleStockDel_array.toJSONString());

									inProdWhsAdmService.inProdWhsAdmCompulsionIns(inProdWhsAdmVo); // 번들링 제품입고 전표 등록
									outProdWhsAdmService.outProdWhsAdmCompulsionIns(outProdWhsAdmDisposalVo); // 번들링 제품출고 전표
																												// 등록
									stockPaymentAdmService.stockPaymentAdmCompulsionIns(stockPaymentAdmVo); // 번들링 제품 입,출고수불
																											// 등록
								}
								workOrderService.workOrdPrcssResultDel(workOrderVo);
								//N이 나올 수 없기에 시스템 오류로 코드값 반환해서 다른 개발자가 찾을 수 있도록 구성됨
								if ("Y".equals(workOrderVo.getResultYn())) {
									jsonData.put("result", "ok");
								} else {
									jsonData.put("message", "시스템에 오류가 발생했습니다.<br>오류 코드 : bundle-001");
									jsonData.put("result", "fail");
								}
							} else {
								jsonData.put("message", "품질 검사된 공정의 실적입니다.<br>삭제할 수 없습니다.");
								jsonData.put("result", "fail");
							}
						} else {
							jsonData.put("message", "수주 진행, 완료일 때<br>실적 삭제가 가능합니다.");
							jsonData.put("result", "fail");
						}
					} else {
						jsonData.put("message", "수주 중지되어<br>실적 삭제가 불가능합니다.");
						jsonData.put("result", "fail");
					}
				} else {
					jsonData.put("message", "삭제 권한이<br>없는 공정입니다.");
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

	// 작업지시서 목록(공정별) - 전공정 작업 완료 체크
	@RequestMapping(value = "wm/checkWorkOrdPrcssFinish", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> checkWorkOrdPrcssFinish(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("작업지시서 목록(공정별) - 전공정 작업 완료 체크 조회");
		try {
			WorkOrderVo checkVo = new WorkOrderVo();

			checkVo = workOrderService.checkWorkOrdPrcssFinish(workOrderVo);
			// 조회된 항목이 null 인경우 -> 첫 공정인 상태
			if (checkVo != null) {
				// 20230509 - 전공정 상태 상관없이 실적창 열 수 있게 해달라고함
				// 현재 공정정보
				workOrderVo = workOrderService.workOrdSelWithPrcss(workOrderVo);

				jsonData.put("data", workOrderVo);
				jsonData.put("result", "ok");
				// 공정 체크시 WC = 완료인 경우
				/*
				 * if( "WC".equals(checkVo.getProgressStatus()) ) { //현재 공정정보 workOrderVo =
				 * workOrderService.workOrdSelWithPrcss(workOrderVo);
				 * 
				 * jsonData.put("data", workOrderVo); jsonData.put("result", "ok"); } else if(
				 * "WI".equals(checkVo.getProgressStatus()) ){ //전 공정체크시 WI = 진행인 경우
				 * jsonData.put("message",
				 * "전 공정이 진행 중입니다.<br>전 공정명 : "+checkVo.getPrcssNm()+""); jsonData.put("result",
				 * "fail"); } else if( "PI".equals(checkVo.getProgressStatus()) ) { //전 공정체크시 Pi
				 * = 대기인 경우 jsonData.put("message",
				 * "전 공정이 진행되지 않았습니다.<br>전 공정명 : "+checkVo.getPrcssNm()+"");
				 * jsonData.put("result", "fail"); }
				 */
			} else {
				workOrderVo = workOrderService.workOrdSelWithPrcss(workOrderVo);
				jsonData.put("data", workOrderVo);
				jsonData.put("result", "ok");
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}

	// 작업지시서 목록(공정별) - 다음공정 조회
	@RequestMapping(value = "wm/workOrdNextPrcssSel", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrdNextPrcssSel(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("작업지시서 목록(공정별) - 다음공정 조회");
		try {
			workOrderVo = workOrderService.workOrdNextPrcssSel(workOrderVo);
			jsonData.put("data", workOrderVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}

	// **********************************생산실적**********************************
	// 생산실적 목록(공정별) 조회
	@RequestMapping(value = "wm/workOrdResultListByPrcss", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrdResultListByPrcss(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산실적 목록(공정별) 조회");
		try {
			List<WorkOrderVo> workOrderVoList = workOrderService.workOrdResultListByPrcss(workOrderVo);
			jsonData.put("data", workOrderVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}

	// 생산실적 목록(작지별) 조회
	@RequestMapping(value = "wm/workOrdResultListByWorkOrdIdx", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrdResultListByWorkOrdIdx(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산실적 목록(작지별) 조회");
		try {
			List<WorkOrderVo> workOrderVoList = workOrderService.workOrdResultListByWorkOrdIdx(workOrderVo);
			jsonData.put("data", workOrderVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}

	// 번들링 정보 조회
	@RequestMapping(value = "wm/workOrdBundleList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrdBundleList(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("번들링 정보 조회");
		try {
			List<WorkOrderVo> workOrderVoList = workOrderService.workOrdBundleList(workOrderVo);
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
