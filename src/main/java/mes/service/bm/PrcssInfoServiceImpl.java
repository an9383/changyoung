package mes.service.bm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.bm.PrcssInfoVo;
import mes.persistence.bm.PrcssInfoDAO;
@Service
public class PrcssInfoServiceImpl implements PrcssInfoService {

	@Inject
	private PrcssInfoDAO dao;

	//공정정보 목록조회
	@Override
	public List<PrcssInfoVo> prcssListAll(PrcssInfoVo prcssInfoVo) throws Exception {
		return dao.prcssListAll(prcssInfoVo);
	}
		
	//공정정보 상세조회
	@Override
	public PrcssInfoVo prcssInfoSel(PrcssInfoVo prcssInfoVo) throws Exception {
		return dao.prcssInfoSel(prcssInfoVo);
	}
		
	//공정정보 등록
	@Override
	public void prcssInsert(PrcssInfoVo prcssInfoVo) throws Exception {
		dao.prcssInsert(prcssInfoVo);
	}
	
	//공정정보 순서 수정
	@Override
	public void prcssOrdUpdate(PrcssInfoVo prcssInfoVo) throws Exception {
		dao.prcssOrdUpdate(prcssInfoVo);
	}
	
	//공정정보 수정
	@Override
	public void prcssUpdate(PrcssInfoVo prcssInfoVo) throws Exception {
		dao.prcssUpdate(prcssInfoVo);
	}
	
	//삭제
	@Override
	public void prcssDelete(PrcssInfoVo prcssInfoVo) throws Exception {
		dao.prcssDelete(prcssInfoVo);
	}
	
	//공정코드 중복확인
	@Override
	public PrcssInfoVo prcssCdDupCheck(PrcssInfoVo prcssInfoVo) throws Exception {
		return dao.prcssCdDupCheck(prcssInfoVo);
	}
		
	//공정작업자 목록조회
	@Override
	public List<PrcssInfoVo> prcssWorkerListAll(PrcssInfoVo prcssInfoVo) throws Exception {
		return dao.prcssWorkerListAll(prcssInfoVo);
	}
	
	//공정작업자 삭제
	@Override
	public void prcssWorkerDelete(PrcssInfoVo prcssInfoVo) throws Exception {
		dao.prcssWorkerDelete(prcssInfoVo);
	}
	
	//공정작업자 등록
	@Override
	public void prcssWorkerInsert(PrcssInfoVo prcssInfoVo) throws Exception {
		dao.prcssWorkerInsert(prcssInfoVo);
	}
	
	//설비 목록조회
	@Override
	public List<PrcssInfoVo> prcssEquipListAll(PrcssInfoVo prcssInfoVo) throws Exception {
		return dao.prcssEquipListAll(prcssInfoVo);
	}
	
	//설비 삭제
	@Override
	public void prcssEquipDelete(PrcssInfoVo prcssInfoVo) throws Exception {
		dao.prcssEquipDelete(prcssInfoVo);
	}
	
	//설비 등록
	@Override
	public void prcssEquipInsert(PrcssInfoVo prcssInfoVo) throws Exception {
		dao.prcssEquipInsert(prcssInfoVo);
	}
	
	//작업방식 목록조회
	@Override
	public List<PrcssInfoVo> prcssWorkMethodListAll(PrcssInfoVo prcssInfoVo) throws Exception {
		return dao.prcssWorkMethodListAll(prcssInfoVo);
	}
	
	//작업방식 삭제
	@Override
	public void prcssWorkMethodDelete(PrcssInfoVo prcssInfoVo) throws Exception {
		dao.prcssWorkMethodDelete(prcssInfoVo);
	}
	
	//작업방식 등록
	@Override
	public void prcssWorkMethodInsert(PrcssInfoVo prcssInfoVo) throws Exception {
		dao.prcssWorkMethodInsert(prcssInfoVo);
	}
	
	//점검항목 목록조회
	@Override
	public List<PrcssInfoVo> prcssInspectionMethodListAll(PrcssInfoVo prcssInfoVo) throws Exception {
		return dao.prcssInspectionMethodListAll(prcssInfoVo);
	}
	
	//점검항목 등록
	@Override
	public void prcssInspectionMethodInsert(PrcssInfoVo prcssInfoVo) throws Exception {
		dao.prcssInspectionMethodInsert(prcssInfoVo);
	}
	
	//점검항목 삭제
	@Override
	public void prcssInspectionMethodDelete(PrcssInfoVo prcssInfoVo) throws Exception {
		dao.prcssInspectionMethodDelete(prcssInfoVo);
	}
}

	