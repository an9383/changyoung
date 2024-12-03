package mes.persistence.stock;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.bm.ItemInfoAdmVo;
import mes.domain.stock.OutProdWhsAdmVo;

@Repository
public class OutProdWhsAdmDAOImpl implements OutProdWhsAdmDAO {

	@Inject
	private SqlSession session;

	private static final String namespace = "mes.mappers.stock.outProdWhsAdmMapper";
	
	// 수주의 출고가능한 제품 조회 
	@Override
	public List<OutProdWhsAdmVo> bizOrderDtlList(OutProdWhsAdmVo outProdWhsAdmVo) throws Exception {
		return session.selectList(namespace+".bizOrderDtlList" ,outProdWhsAdmVo);
	}
	
	// 수주의 출고 내역
	@Override
	public List<OutProdWhsAdmVo> bizOrderProdOutLst(OutProdWhsAdmVo outProdWhsAdmVo) throws Exception {
		return session.selectList(namespace+".bizOrderProdOutLst" ,outProdWhsAdmVo);
	}
	
	// 출고전표 조회
	@Override
	public List<OutProdWhsAdmVo> getOutProdLstByOutNo(OutProdWhsAdmVo outProdWhsAdmVo) throws Exception {
		return session.selectList(namespace+".getOutProdLstByOutNo" ,outProdWhsAdmVo);
	}
	
	// 제품 출고전표 등록
	@Override
	public void outProdWhsAdmIns(OutProdWhsAdmVo outProdWhsAdmVo) throws Exception {
		session.insert(namespace+".outProdWhsAdmIns" ,outProdWhsAdmVo);
	}
	
	// 제품 출고전표 등록
	@Override
	public void outProdWhsAdmCompulsionIns(OutProdWhsAdmVo outProdWhsAdmVo) throws Exception {
		session.insert(namespace+".outProdWhsAdmCompulsionIns" ,outProdWhsAdmVo);
	}
	
	// 제품 출고전표 수정
	@Override
	public void outProdWhsAdmUpd(OutProdWhsAdmVo outProdWhsAdmVo) throws Exception {
		session.update(namespace+".outProdWhsAdmUpd" ,outProdWhsAdmVo);
	}
	
	// 제품 출고전표 삭제
	@Override
	public void outProdWhsAdmDel(OutProdWhsAdmVo outProdWhsAdmVo) throws Exception {
		session.delete(namespace+".outProdWhsAdmDel" ,outProdWhsAdmVo);
	}
	
	// 제품 출고전표 삭제 
	@Override
	public void outProdWhsAdmDelByRelationNo(OutProdWhsAdmVo outProdWhsAdmVo) throws Exception{
		session.delete(namespace+".outProdWhsAdmDelByRelationNo" ,outProdWhsAdmVo );
	}
	
	// 제품 전표번호 조회
	@Override
	public String getOutSlipNo(OutProdWhsAdmVo outProdWhsAdmVo) throws Exception {
		return session.selectOne(namespace+".getOutSlipNo" ,outProdWhsAdmVo);
	}
	
	// 제품 전표번호 조회
	@Override
	public List<OutProdWhsAdmVo> getOutSlipNoByRelationNo(OutProdWhsAdmVo outProdWhsAdmVo) throws Exception {
		return session.selectList(namespace+".getOutSlipNoByRelationNo" ,outProdWhsAdmVo);
	}
	//********************************** 납품계획등록 **********************************
	//납품계획등록 조회
	@Override
	public List<OutProdWhsAdmVo> deliveryPlanList(OutProdWhsAdmVo outProdWhsAdmVo) throws Exception {
		return session.selectList(namespace+".deliveryPlanList" ,outProdWhsAdmVo);
	}
	
	//********************************** 원거래명세서출력 **********************************
	// 제품 출고내역 조회
	@Override
	public List<OutProdWhsAdmVo> outProdDtlList(OutProdWhsAdmVo outProdWhsAdmVo) throws Exception {
		return session.selectList(namespace+".outProdDtlList" ,outProdWhsAdmVo);
	}
	
	// 원거래명세서출력 번호 발급
	@Override
	public void tradingStatementUpd(OutProdWhsAdmVo outProdWhsAdmVo) throws Exception {
		session.update(namespace+".tradingStatementUpd" ,outProdWhsAdmVo);
	}
	
	// 원거래명세서출력 번호 삭제
	@Override
	public void tradingStatementDel(OutProdWhsAdmVo outProdWhsAdmVo) throws Exception {
		session.delete(namespace+".tradingStatementDel" ,outProdWhsAdmVo);
	}
	
	
	//bizOrdDtlNo로 번들링 목록조회
	@Override
	public List<OutProdWhsAdmVo> bizOrderDtlBundleListWithBizOrdDtlNo(OutProdWhsAdmVo outProdWhsAdmVo) throws Exception{
		return session.selectList(namespace+".bizOrderDtlBundleListWithBizOrdDtlNo", outProdWhsAdmVo);
	}
}
