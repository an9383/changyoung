package mes.persistence.bs;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.bs.DeliveryPlanVo;

@Repository
public class DeliveryPlanDAOImpl implements DeliveryPlanDAO {

	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.bs.deliveryPlanMapper";
	
	//납품계획 목록조회
	@Override
	public List<DeliveryPlanVo> deliveryPlanAdmLst(DeliveryPlanVo deliveryPlanVo) throws Exception {
		return session.selectList(namespace+".deliveryPlanAdmLst", deliveryPlanVo);
	}
	
	//납품계획 등록 
	@Override
	public void deliveryPlanAdmIns(DeliveryPlanVo deliveryPlanVo) throws Exception {
		session.insert(namespace+".deliveryPlanAdmIns", deliveryPlanVo);
	}

	//납품계획 수정
	@Override
	public void deliveryPlanAdmUpd(DeliveryPlanVo deliveryPlanVo) throws Exception {
		session.update(namespace+".deliveryPlanAdmUpd", deliveryPlanVo);
	}

	//납품계획 삭제
	@Override
	public void deliveryPlanAdmDel(DeliveryPlanVo deliveryPlanVo) throws Exception {
		session.delete(namespace+".deliveryPlanAdmDel", deliveryPlanVo);
	}
}
