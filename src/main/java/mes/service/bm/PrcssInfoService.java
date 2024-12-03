package mes.service.bm;

import java.util.List;

import mes.domain.bm.PrcssInfoVo;

public interface PrcssInfoService {
	
	//공정정보 목록조회
	public List<PrcssInfoVo> prcssListAll(PrcssInfoVo prcssInfoVo) throws Exception;

	//공정정보 상세조회
	public PrcssInfoVo prcssInfoSel(PrcssInfoVo prcssInfoVo) throws Exception;
		
	//공정정보 등록
	public void prcssInsert(PrcssInfoVo prcssInfoVo) throws Exception;
	
	//공정정보 순서 수정
	public void prcssOrdUpdate(PrcssInfoVo prcssInfoVo) throws Exception;
	
	//공정정보 수정
	public void prcssUpdate(PrcssInfoVo prcssInfoVo) throws Exception;
	
	//삭제
	public void prcssDelete(PrcssInfoVo prcssInfoVo) throws Exception;

	//공정코드 중복확인
	public PrcssInfoVo prcssCdDupCheck(PrcssInfoVo prcssInfoVo) throws Exception;

	//공정작업자 목록조회
	public List<PrcssInfoVo> prcssWorkerListAll(PrcssInfoVo prcssInfoVo) throws Exception;
	
	//공정작업자 삭제
	public void prcssWorkerDelete(PrcssInfoVo prcssInfoVo) throws Exception;
	
	//공정작업자 등록
	public void prcssWorkerInsert(PrcssInfoVo prcssInfoVo) throws Exception;
	
	//설비 목록조회
	public List<PrcssInfoVo> prcssEquipListAll(PrcssInfoVo prcssInfoVo) throws Exception;
		
	//설비 삭제
	public void prcssEquipDelete(PrcssInfoVo prcssInfoVo) throws Exception;
	
	//설비 등록
	public void prcssEquipInsert(PrcssInfoVo prcssInfoVo) throws Exception;
	
	//작업방식 목록조회
	public List<PrcssInfoVo> prcssWorkMethodListAll(PrcssInfoVo prcssInfoVo) throws Exception;
		
	//작업방식 삭제
	public void prcssWorkMethodDelete(PrcssInfoVo prcssInfoVo) throws Exception;
	
	//작업방식 등록
	public void prcssWorkMethodInsert(PrcssInfoVo prcssInfoVo) throws Exception;
	
	//점검항목 목록조회
	public List<PrcssInfoVo> prcssInspectionMethodListAll(PrcssInfoVo prcssInfoVo) throws Exception;

	//점검항목 등록
	public void prcssInspectionMethodInsert(PrcssInfoVo prcssInfoVo) throws Exception;
	
	//점검항목 삭제
	public void prcssInspectionMethodDelete(PrcssInfoVo prcssInfoVo) throws Exception;
	
}
