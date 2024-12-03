package mes.service.bm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.bm.SpotToningVo;
import mes.persistence.bm.SpotToningDAO;
@Service
public class SpotToningServiceImpl implements SpotToningService {

	@Inject
	private SpotToningDAO dao;
	
	//조색별색정보 목록조회
	@Override
	public List<SpotToningVo> spotToningList(SpotToningVo spotToningVo) throws Exception {
		return dao.spotToningList(spotToningVo);
	}

	//조색별색정보 목록조회
	@Override
	public SpotToningVo spotToningSel(SpotToningVo spotToningVo) throws Exception {
		return dao.spotToningSel(spotToningVo);
	}

	//조색별색정보 등록
	@Override
	public void spotToningInsert(SpotToningVo spotToningVo) throws Exception {
		dao.spotToningInsert(spotToningVo);
	}
	
	//조색별색정보 수정
	@Override
	public void spotToningUpdate(SpotToningVo spotToningVo) throws Exception {
		dao.spotToningUpdate(spotToningVo);
	}
	
	//조색별색정보 순번 수정
	@Override
	public void spotToningOrderUpdate(SpotToningVo spotToningVo) throws Exception {
		dao.spotToningOrderUpdate(spotToningVo);
	}
	
	//조색별색정보 삭제
	@Override
	public void spotToningDelete(SpotToningVo spotToningVo) throws Exception {
		dao.spotToningDelete(spotToningVo);
	}
	
	//조색별색정보 코드 중복 확인
	@Override
	public SpotToningVo colorCdDupCheck(SpotToningVo spotToningVo) throws Exception {
		return dao.colorCdDupCheck(spotToningVo);
	}

}

	