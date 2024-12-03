package mes.web.sm;

import java.util.Date;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import mes.domain.sm.BatchProcVo;
import mes.service.sm.BatchProcService;
import mes.web.auth.Constants;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

public class BatchProcController {

	@Inject
	private BatchProcService batchProcService;	
	
	private static final Logger logger = LoggerFactory.getLogger(BatchProcController.class);

	public String batchTmData() throws Exception {
		
		logger.info("batchScheduler batchTmData ==================> " + DateUtil.getDay("yyyy-mm-dd hh:mm:ss:ms", 0));
		Date date = new Date();

		BatchProcVo batchProcVo = new BatchProcVo();
		batchProcVo.setBatchId(Constants.BATCH_ID_01);
		batchProcVo.setBatchNm(Constants.BATCH_ID_01_NM);
		batchProcVo.setBatchGubun(Constants.BATCH_ID_01_NM);
		batchProcVo.setBatchStartTime(DateUtil.getDay("yyyy-mm-dd hh:mm:ss:ms", 0));
		batchProcVo.setSuccessYn(Constants.BATCH_FAIL);
		
		try {
			batchProcService.batchTmData(batchProcVo);
			batchProcVo.setSuccessYn(Constants.BATCH_SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			batchProcVo.setBatchEndTime(DateUtil.getDay("yyyy-mm-dd hh:mm:ss:ms", 0));
			batchProcService.batchProcLog(batchProcVo);
		}

		return "bs/bssc0010";
	}
}
