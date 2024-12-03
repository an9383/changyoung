package mes.persistence.em;

import java.util.List;

import mes.domain.em.EquipInfoVo;

public interface EquipInfoDAO {

	//설비코드 목록조회
	public List<EquipInfoVo> equipInfoListAll(EquipInfoVo equipInfoVo) throws Exception;
	
	//설비 담당자 목록조회
	public List<EquipInfoVo> equipUserInfoLst(EquipInfoVo equipInfoVo) throws Exception;
	
	//설비 담당자 등록
	public void equipUserDelIns(EquipInfoVo equipInfoVo) throws Exception;
	
	//공정설비 목록조회
	public List<EquipInfoVo> prcssEquipInfoListAll(EquipInfoVo equipInfoVo) throws Exception;
	
	//설비코드 상세조회
	public EquipInfoVo equipInfoSel(EquipInfoVo equipInfoVo) throws Exception;
	
	//설비코드 등록
	public void equipInfoInsert(EquipInfoVo equipInfoVo) throws Exception;
	
	//설비코드 수정
	public void equipInfoUpdate(EquipInfoVo equipInfoVo) throws Exception;
	
	//설비코드 순번 수정
	public void equipInfoOrdUpdate(EquipInfoVo equipInfoVo) throws Exception;
	
	//설비코드 삭제
	public void equipInfoDelete(EquipInfoVo equipInfoVo) throws Exception;

	//설비코드 중복확인
	public EquipInfoVo equipInfoDupCheck(EquipInfoVo equipInfoVo) throws Exception;
	
	//관련자료 목록조회
	public List<EquipInfoVo> equipAttachDataList(EquipInfoVo equipInfoVo) throws Exception;
		
	//관련자료 등록
	public void equipAttachDataInsert(EquipInfoVo equipInfoVo) throws Exception;
	
	//관련자료 삭제
	public void equipAttachDataDelete(EquipInfoVo equipInfoVo) throws Exception;
}
