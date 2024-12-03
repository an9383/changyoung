package mes.domain.sm;

import lombok.Data;

@Data
public class BatchProcVo {

	private String batchId;
	private String batchNm;
	private String batchGubun;
	private String batchStartTime;
	private String batchEndTime;
	private String successYn;
	private String batchDesc;
	private String createdBy;
	private String createdAt;
	private String updatedBy;
	private String updatedAt;
	
}
