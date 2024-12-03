package mes.service.stock;

import java.util.List;

import mes.domain.stock.OutMatrWhsAdmVo;

public interface OutMatrWhsAdmService {
	
	// 자재 출고전표 등록
	public void outMatrWhsAdmIns(OutMatrWhsAdmVo outMatrWhsAdmVo) throws Exception;
	
	// 자재 출고전표 수정
	public void outMatrWhsAdmUpd(OutMatrWhsAdmVo outMatrWhsAdmVo) throws Exception;
	
	// 자재 출고전표 삭제
	public void outMatrWhsAdmDel(OutMatrWhsAdmVo outMatrWhsAdmVo) throws Exception;
	
	// 자재 전표번호 릴레이션번호로 조회
	public List<OutMatrWhsAdmVo> getOutSlipNoByRelationNo(OutMatrWhsAdmVo outMatrWhsAdmVo) throws Exception;
	
	// 자재 전표번호 채번
	public String getOutSlipNo(OutMatrWhsAdmVo outMatrWhsAdmVo) throws Exception;
}