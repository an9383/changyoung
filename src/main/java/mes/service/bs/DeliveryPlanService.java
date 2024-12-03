package mes.service.bs;

import java.util.List;

import mes.domain.bs.DeliveryPlanVo;

public interface DeliveryPlanService {
	
	//납품계획 목록조회
	public List<DeliveryPlanVo> deliveryPlanAdmLst(DeliveryPlanVo deliveryPlanVo) throws Exception;
	
	//납품계획 등록 
	public void deliveryPlanAdmIns(DeliveryPlanVo deliveryPlanVo) throws Exception;
	
	//납품계획 수정
	public void deliveryPlanAdmUpd(DeliveryPlanVo deliveryPlanVo) throws Exception;
	
	//납품계획 삭제 
	public void deliveryPlanAdmDel(DeliveryPlanVo deliveryPlanVo) throws Exception;
}
