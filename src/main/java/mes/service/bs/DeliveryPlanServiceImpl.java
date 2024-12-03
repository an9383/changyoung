package mes.service.bs;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.bs.DeliveryPlanVo;
import mes.persistence.bs.DeliveryPlanDAO;

@Service
public class DeliveryPlanServiceImpl implements DeliveryPlanService {

	@Inject
	private DeliveryPlanDAO dao;
	
	//납품계획 목록조회
	@Override
	public List<DeliveryPlanVo> deliveryPlanAdmLst(DeliveryPlanVo deliveryPlanVo) throws Exception {
		return dao.deliveryPlanAdmLst(deliveryPlanVo);
	}
	
	//납품계획 등록
	@Override
	public void deliveryPlanAdmIns(DeliveryPlanVo deliveryPlanVo) throws Exception {
		dao.deliveryPlanAdmIns(deliveryPlanVo);
	}
	
	//납품계획 수정
	@Override
	public void deliveryPlanAdmUpd(DeliveryPlanVo deliveryPlanVo) throws Exception {
		dao.deliveryPlanAdmUpd(deliveryPlanVo);
	}
	
	//납품계획 삭제
	@Override
	public void deliveryPlanAdmDel(DeliveryPlanVo deliveryPlanVo) throws Exception {
		dao.deliveryPlanAdmDel(deliveryPlanVo);
	}
}
