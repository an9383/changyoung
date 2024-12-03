package mes.persistence.bm;

import java.util.List;

import mes.domain.bm.MatrlInfoVo;

public interface MatrlInfoDAO {

	//자재목록조회
	public List<MatrlInfoVo> matrlInfoListAll(MatrlInfoVo matrlInfoVo) throws Exception;
	
	//재질 중복체크
	public List<MatrlInfoVo> paperTypeDupCheck(MatrlInfoVo matrlInfoVo) throws Exception;
	
	//자재 상세조회
	public MatrlInfoVo matrlInfoSel(MatrlInfoVo matrlInfoVo) throws Exception;
	
	//자재 등록
	public void matrlInfoInsert(MatrlInfoVo matrlInfoVo) throws Exception;
	
	//자재 수정
	public void matrlInfoUpdate(MatrlInfoVo matrlInfoVo) throws Exception;
	
	//자재 다중 수정
	public void matrlInfoMultiUpdate(MatrlInfoVo matrlInfoVo) throws Exception;
	
	//자재 순번 수정
	public void matrlInfoOrdUpdate(MatrlInfoVo matrlInfoVo) throws Exception;
	
	//자재 삭제
	public void matrlInfoDelete(MatrlInfoVo matrlInfoVo) throws Exception;

	//자재코드 중복확인
	public MatrlInfoVo matrlInfoDupCheck(MatrlInfoVo matrlInfoVo) throws Exception;
	
	// ================================= 수주별발주 =====================================
	// 자재목록조회 BOM포함/미포함
	public List<MatrlInfoVo> matrlInfoLstByItemBom(MatrlInfoVo matrlInfoVo) throws Exception;
	
	// ================================= 개별발주 =====================================
	// 수주수량 포함 자재목록조회
	public List<MatrlInfoVo> matrlInfoLstWithBiz(MatrlInfoVo matrlInfoVo) throws Exception;
	
}
