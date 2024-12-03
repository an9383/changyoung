package mes.service.stock;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Repository;

import mes.domain.stock.OutMatrWhsAdmVo;
import mes.persistence.stock.OutMatrWhsAdmDAO;

@Repository
public class OutMatrWhsAdmServiceImpl implements OutMatrWhsAdmService {

	@Inject
	private OutMatrWhsAdmDAO dao;
	
	// 자재 출고전표 등록
	@Override
	public void outMatrWhsAdmIns(OutMatrWhsAdmVo outMatrWhsAdmVo) throws Exception {
		dao.outMatrWhsAdmIns(outMatrWhsAdmVo);
	}
	
	// 자재 출고전표 수정
	@Override
	public void outMatrWhsAdmUpd(OutMatrWhsAdmVo outMatrWhsAdmVo) throws Exception {
		dao.outMatrWhsAdmUpd(outMatrWhsAdmVo);
	}
	
	// 자재 출고전표 삭제
	@Override
	public void outMatrWhsAdmDel(OutMatrWhsAdmVo outMatrWhsAdmVo) throws Exception {
		dao.outMatrWhsAdmDel(outMatrWhsAdmVo);
	}
	
	// 자재 전표번호 릴레이션번호로 조회
	@Override
	public List<OutMatrWhsAdmVo> getOutSlipNoByRelationNo(OutMatrWhsAdmVo outMatrWhsAdmVo) throws Exception {
		return dao.getOutSlipNoByRelationNo(outMatrWhsAdmVo);
	}
	
	// 자재 전표번호 채번
	@Override
	public String getOutSlipNo(OutMatrWhsAdmVo outMatrWhsAdmVo) throws Exception {
		return dao.getOutSlipNo(outMatrWhsAdmVo);
	}
}
