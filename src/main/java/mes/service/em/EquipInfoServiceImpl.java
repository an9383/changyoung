package mes.service.em;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.em.EquipInfoVo;
import mes.persistence.em.EquipInfoDAO;
@Service
public class EquipInfoServiceImpl implements EquipInfoService {

	@Inject
	private EquipInfoDAO dao;

	//설비코드 목록조회
	@Override
	public List<EquipInfoVo> equipInfoListAll(EquipInfoVo equipInfoVo) throws Exception {
		return dao.equipInfoListAll(equipInfoVo);
	}
	
	//설비 담당자 목록조회
	@Override
	public List<EquipInfoVo> equipUserInfoLst(EquipInfoVo equipInfoVo) throws Exception {
		return dao.equipUserInfoLst(equipInfoVo);
	}

	//설비 담당자 등록
	@Override
	public void equipUserDelIns(EquipInfoVo equipInfoVo) throws Exception {
		dao.equipUserDelIns(equipInfoVo);
	}
	
	//공정설비 목록조회
	@Override
	public List<EquipInfoVo> prcssEquipInfoListAll(EquipInfoVo equipInfoVo) throws Exception {
		return dao.prcssEquipInfoListAll(equipInfoVo);
	}
		
	//설비코드 상세조회
	@Override
	public EquipInfoVo equipInfoSel(EquipInfoVo equipInfoVo) throws Exception {
		return dao.equipInfoSel(equipInfoVo);
	}
		
	//설비코드 등록
	@Override
	public void equipInfoInsert(EquipInfoVo equipInfoVo) throws Exception {
		dao.equipInfoInsert(equipInfoVo);
	}
	
	//설비코드 수정
	@Override
	public void equipInfoUpdate(EquipInfoVo equipInfoVo) throws Exception {
		dao.equipInfoUpdate(equipInfoVo);
	}
	
	//설비코드 순번 수정
	@Override
	public void equipInfoOrdUpdate(EquipInfoVo equipInfoVo) throws Exception {
		dao.equipInfoOrdUpdate(equipInfoVo);
	}
	
	//설비코드 삭제
	@Override
	public void equipInfoDelete(EquipInfoVo equipInfoVo) throws Exception {
		dao.equipInfoDelete(equipInfoVo);
	}
	
	//설비코드 중복확인
	@Override
	public EquipInfoVo equipInfoDupCheck(EquipInfoVo equipInfoVo) throws Exception {
		return dao.equipInfoDupCheck(equipInfoVo);
	}
	
	//관련자료 목록조회
	@Override
	public List<EquipInfoVo> equipAttachDataList(EquipInfoVo equipInfoVo) throws Exception {
		return dao.equipAttachDataList(equipInfoVo);
	}
	
	//관련자료 등록
	@Override
	public void equipAttachDataInsert(EquipInfoVo equipInfoVo) throws Exception {
		dao.equipAttachDataInsert(equipInfoVo);
	}
	
	//관련자료 삭제
	@Override
	public void equipAttachDataDelete(EquipInfoVo equipInfoVo) throws Exception {
		dao.equipAttachDataDelete(equipInfoVo);
	}
}

	