package mes.service.stock;

import javax.inject.Inject;

import org.springframework.stereotype.Repository;

import mes.domain.stock.InProdWhsAdmVo;
import mes.persistence.stock.InProdWhsAdmDAO;

@Repository
public class InProdWhsAdmServiceImpl implements InProdWhsAdmService {

	@Inject
	private InProdWhsAdmDAO dao;
	
	// 제품 입고전표 등록
	@Override
	public void inProdWhsAdmIns(InProdWhsAdmVo inProdWhsAdmVo) throws Exception {
		dao.inProdWhsAdmIns(inProdWhsAdmVo);
	}
	
	// 제품 입고전표 등록
	@Override
	public void inProdWhsAdmCompulsionIns(InProdWhsAdmVo inProdWhsAdmVo) throws Exception {
		dao.inProdWhsAdmCompulsionIns(inProdWhsAdmVo);
	}
	
	// 제품 입고전표 수정
	@Override
	public void inProdWhsAdmUpd(InProdWhsAdmVo inProdWhsAdmVo) throws Exception {
		dao.inProdWhsAdmUpd(inProdWhsAdmVo);
	}
	
	// 제품 입고전표 삭제
	@Override
	public void inProdWhsAdmDel(InProdWhsAdmVo inProdWhsAdmVo) throws Exception {
		dao.inProdWhsAdmDel(inProdWhsAdmVo);
	}
	
	// 제품 전표번호 조회
	@Override
	public InProdWhsAdmVo getInSlipNoByRelationNo(InProdWhsAdmVo inProdWhsAdmVo) throws Exception {
		return dao.getInSlipNoByRelationNo(inProdWhsAdmVo);
	}
	
	// 제품 전표번호 조회
	@Override
	public String getInSlipNo(InProdWhsAdmVo inProdWhsAdmVo) throws Exception {
		return dao.getInSlipNo(inProdWhsAdmVo);
	}
	
	// 제품 LOT번호 조회
	@Override
	public String getLotNo(InProdWhsAdmVo inProdWhsAdmVo) throws Exception {
		return dao.getLotNo(inProdWhsAdmVo);
	}
}
