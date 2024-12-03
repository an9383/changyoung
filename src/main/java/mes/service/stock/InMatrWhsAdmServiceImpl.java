package mes.service.stock;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Repository;

import mes.domain.stock.InMatrWhsAdmVo;
import mes.persistence.stock.InMatrWhsAdmDAO;

@Repository
public class InMatrWhsAdmServiceImpl implements InMatrWhsAdmService {

	@Inject
	private InMatrWhsAdmDAO dao;
	
	// 자재 입고전표 목록조회
	@Override
	public List<InMatrWhsAdmVo> inMatrWhsAdmLst(InMatrWhsAdmVo inMatrWhsAdmVo) throws Exception{
		return dao.inMatrWhsAdmLst(inMatrWhsAdmVo);
	}
	
	// 자재 입고전표 상세조회
	@Override
	public InMatrWhsAdmVo inMatrWhsAdmSel(InMatrWhsAdmVo inMatrWhsAdmVo) throws Exception{
		return dao.inMatrWhsAdmSel(inMatrWhsAdmVo);
	}
	
	// 자재 입고전표 등록
	@Override
	public void inMatrWhsAdmIns(InMatrWhsAdmVo inMatrWhsAdmVo) throws Exception {
		dao.inMatrWhsAdmIns(inMatrWhsAdmVo);
	}
	
	// 자재 입고전표 수정
	@Override
	public void inMatrWhsAdmUpd(InMatrWhsAdmVo inMatrWhsAdmVo) throws Exception {
		dao.inMatrWhsAdmUpd(inMatrWhsAdmVo);
	}
	
	// 자재 입고전표 삭제
	@Override
	public void inMatrWhsAdmDel(InMatrWhsAdmVo inMatrWhsAdmVo) throws Exception {
		dao.inMatrWhsAdmDel(inMatrWhsAdmVo);
	}
	
	// 자재 전표번호 조회
	@Override
	public String inMatrWhsAdmGetInSlipNo(InMatrWhsAdmVo inMatrWhsAdmVo) throws Exception {
		return dao.inMatrWhsAdmGetInSlipNo(inMatrWhsAdmVo);
	}
	
	// 자재 LOT번호 조회
	@Override
	public String inMatrWhsAdmGetLotNo(InMatrWhsAdmVo inMatrWhsAdmVo) throws Exception {
		return dao.inMatrWhsAdmGetLotNo(inMatrWhsAdmVo);
	}
	
	// ======================================================================================
	// 자재 입고전표 연관변호별 목록조회
	public List<InMatrWhsAdmVo> inMatrWhsAdmLstByRelationNo(InMatrWhsAdmVo inMatrWhsAdmVo) throws Exception {
		return dao.inMatrWhsAdmLstByRelationNo(inMatrWhsAdmVo);
	}
}
