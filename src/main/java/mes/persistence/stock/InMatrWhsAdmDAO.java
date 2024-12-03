package mes.persistence.stock;

import java.util.List;

import mes.domain.stock.InMatrWhsAdmVo;

public interface InMatrWhsAdmDAO {
	
	// 자재 입고전표 목록조회
	public List<InMatrWhsAdmVo> inMatrWhsAdmLst(InMatrWhsAdmVo inMatrWhsAdmVo) throws Exception;
	
	// 자재 입고전표 상세조회
	public InMatrWhsAdmVo inMatrWhsAdmSel(InMatrWhsAdmVo inMatrWhsAdmVo) throws Exception;
	
	// 자재 입고전표 등록
	public void inMatrWhsAdmIns(InMatrWhsAdmVo inMatrWhsAdmVo) throws Exception;
	
	// 자재 입고전표 수정
	public void inMatrWhsAdmUpd(InMatrWhsAdmVo inMatrWhsAdmVo) throws Exception;
	
	// 자재 입고전표 삭제
	public void inMatrWhsAdmDel(InMatrWhsAdmVo inMatrWhsAdmVo) throws Exception;
	
	// 자재 전표번호 조회
	public String inMatrWhsAdmGetInSlipNo(InMatrWhsAdmVo inMatrWhsAdmVo) throws Exception;
	
	// 자재 LOT번호 조회
	public String inMatrWhsAdmGetLotNo(InMatrWhsAdmVo inMatrWhsAdmVo) throws Exception;
	
	// ======================================================================================
	// 자재 입고전표 연관변호별 목록조회
	public List<InMatrWhsAdmVo> inMatrWhsAdmLstByRelationNo(InMatrWhsAdmVo inMatrWhsAdmVo) throws Exception;
}