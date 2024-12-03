package mes.service.bm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.bm.WoodenInfoVo;
import mes.persistence.bm.WoodenInfoDAO;

@Service
public class WoodenInfoServiceImpl implements WoodenInfoService {

	@Inject
	private WoodenInfoDAO dao;
	
	// =========================== 목형정보관리 기본정보 ==========================================
	// 목형정보관리 기본정보 목록조회
	@Override
	public List<WoodenInfoVo> woodenInfoAdmLst(WoodenInfoVo woodenInfoVo) throws Exception {
		return dao.woodenInfoAdmLst(woodenInfoVo);
	}
	
	// 목형정보관리 목록조회 - 사이즈 코팅 성형방식 일치하는 목록 
	@Override
	public List<WoodenInfoVo> woodenInfoAdmLstWithSizeCoatingMolding(WoodenInfoVo woodenInfoVo) throws Exception {
		return dao.woodenInfoAdmLstWithSizeCoatingMolding(woodenInfoVo);
	}
	
	// 목형정보관리 기본정보 상세조회
	@Override
	public WoodenInfoVo woodenInfoAdmSel(WoodenInfoVo woodenInfoVo) throws Exception {
		return dao.woodenInfoAdmSel(woodenInfoVo);
	}
	
	// 목형정보관리 기본정보 등록
	@Override
	public String woodenInfoAdmIns(WoodenInfoVo woodenInfoVo) throws Exception {
		return dao.woodenInfoAdmIns(woodenInfoVo);
	}
	
	// 목형정보관리 기본정보 수정
	@Override
	public void woodenInfoAdmUpd(WoodenInfoVo woodenInfoVo) throws Exception {
		dao.woodenInfoAdmUpd(woodenInfoVo);
	}
		
	// 목형정보관리 기본정보 삭제
	@Override
	public void woodenInfoAdmDel(WoodenInfoVo woodenInfoVo) throws Exception {
		dao.woodenInfoAdmDel(woodenInfoVo);
	}
	
	// 목형정보관리 기본정보 목형코드 중복확인
	@Override
	public WoodenInfoVo woodenInfoAdmIdDupCheck(WoodenInfoVo woodenInfoVo) throws Exception {
		return dao.woodenInfoAdmIdDupCheck(woodenInfoVo);
	}
	
	// =========================== 목형정보관리 사용이력 ==========================================
	// 목형정보관리 사용이력 목록조회
	@Override
	public List<WoodenInfoVo> woodenInfoLogLst(WoodenInfoVo woodenInfoVo) throws Exception {
		return dao.woodenInfoLogLst(woodenInfoVo);
	}
	
	// 목형정보관리 사용이력 상세조회
	@Override
	public WoodenInfoVo woodenInfoLogSel(WoodenInfoVo woodenInfoVo) throws Exception {
		return dao.woodenInfoLogSel(woodenInfoVo);
	}
	
	// 목형정보관리 사용이력 등록
	@Override
	public void woodenInfoLogIns(WoodenInfoVo woodenInfoVo) throws Exception {
		dao.woodenInfoLogIns(woodenInfoVo);
	}
	
	// 목형정보관리 사용이력 등록
	@Override
	public void prcssUseWoodenLogIns(WoodenInfoVo woodenInfoVo) throws Exception {
		dao.prcssUseWoodenLogIns(woodenInfoVo);
	}
	
	// 목형정보관리 사용이력 수정
	@Override
	public void woodenInfoLogUpd(WoodenInfoVo woodenInfoVo) throws Exception {
		dao.woodenInfoLogUpd(woodenInfoVo);
	}
		
	// 목형정보관리 사용이력 삭제
	@Override
	public void woodenInfoLogDel(WoodenInfoVo woodenInfoVo) throws Exception {
		dao.woodenInfoLogDel(woodenInfoVo);
	}
}
