package mes.persistence.stock;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.stock.InProdWhsAdmVo;

@Repository
public class InProdWhsAdmDAOImpl implements InProdWhsAdmDAO {

	@Inject
	private SqlSession session;

	private static final String namespace = "mes.mappers.stock.inProdWhsAdmMapper";
	
	// 제품 입고전표 등록
	@Override
	public void inProdWhsAdmIns(InProdWhsAdmVo inProdWhsAdmVo) throws Exception {
		session.insert(namespace+".inProdWhsAdmIns" ,inProdWhsAdmVo);
	}
	
	// 제품 입고전표 등록
	@Override
	public void inProdWhsAdmCompulsionIns(InProdWhsAdmVo inProdWhsAdmVo) throws Exception {
		session.insert(namespace+".inProdWhsAdmCompulsionIns" ,inProdWhsAdmVo);
	}
	
	// 제품 입고전표 수정
	@Override
	public void inProdWhsAdmUpd(InProdWhsAdmVo inProdWhsAdmVo) throws Exception {
		session.update(namespace+".inProdWhsAdmUpd" ,inProdWhsAdmVo);
	}
	
	// 제품 입고전표 삭제
	@Override
	public void inProdWhsAdmDel(InProdWhsAdmVo inProdWhsAdmVo) throws Exception {
		session.delete(namespace+".inProdWhsAdmDel" ,inProdWhsAdmVo);
	}
	
	// 제품 전표번호 조회
	@Override
	public InProdWhsAdmVo getInSlipNoByRelationNo(InProdWhsAdmVo inProdWhsAdmVo) throws Exception {
		return session.selectOne(namespace+".getInSlipNoByRelationNo" ,inProdWhsAdmVo);
	}
	
	// 제품 전표번호 조회
	@Override
	public String getInSlipNo(InProdWhsAdmVo inProdWhsAdmVo) throws Exception {
		return session.selectOne(namespace+".getInSlipNo" ,inProdWhsAdmVo);
	}
	
	// 제품 LOT번호 조회
	@Override
	public String getLotNo(InProdWhsAdmVo inProdWhsAdmVo) throws Exception {
		return session.selectOne(namespace+".getLotNo" ,inProdWhsAdmVo);
	}
}
