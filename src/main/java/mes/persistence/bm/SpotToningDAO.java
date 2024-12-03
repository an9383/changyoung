package mes.persistence.bm;

import java.util.List;

import mes.domain.bm.SpotToningVo;

public interface SpotToningDAO {
	
	//조색별색정보 목록조회
	public List<SpotToningVo> spotToningList(SpotToningVo spotToningVo) throws Exception;
	
	//조색별색정보 상세조회
	public SpotToningVo spotToningSel(SpotToningVo spotToningVo) throws Exception;

	//조색별색정보 등록
	public void spotToningInsert(SpotToningVo spotToningVo) throws Exception;
	
	//조색별색정보 수정
	public void spotToningUpdate(SpotToningVo spotToningVo) throws Exception;
	
	//조색별색정보 순번 수정
	public void spotToningOrderUpdate(SpotToningVo spotToningVo) throws Exception;
	
	//조색별색정보 삭제
	public void spotToningDelete(SpotToningVo spotToningVo) throws Exception;
	
	//조색별색정보 코드 중복 확인
	public SpotToningVo colorCdDupCheck(SpotToningVo spotToningVo) throws Exception;

	
}
