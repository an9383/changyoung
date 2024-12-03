package mes.service.bm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.bm.MatrlInfoVo;
import mes.persistence.bm.MatrlInfoDAO;
@Service
public class MatrlInfoServiceImpl implements MatrlInfoService {

	@Inject
	private MatrlInfoDAO dao;

	//품목정보관리 제품,자재 목록조회
	@Override
	public List<MatrlInfoVo> matrlInfoListAll(MatrlInfoVo matrlInfoVo) throws Exception {
		return dao.matrlInfoListAll(matrlInfoVo);
	}
	
	//재질 중복체크
	@Override
	public List<MatrlInfoVo> paperTypeDupCheck(MatrlInfoVo matrlInfoVo) throws Exception {
		return dao.paperTypeDupCheck(matrlInfoVo);
	}
		
	//목록상세조회
	@Override
	public MatrlInfoVo matrlInfoSel(MatrlInfoVo matrlInfoVo) throws Exception {
		return dao.matrlInfoSel(matrlInfoVo);
	}
		
	//품목정보관리 등록
	@Override
	public void matrlInfoInsert(MatrlInfoVo matrlInfoVo) throws Exception {
		dao.matrlInfoInsert(matrlInfoVo);
	}
	
	//품목정보관리 수정
	@Override
	public void matrlInfoUpdate(MatrlInfoVo matrlInfoVo) throws Exception {
		dao.matrlInfoUpdate(matrlInfoVo);
	}
	
	//품목정보관리 자재 다중 수정
	@Override
	public void matrlInfoMultiUpdate(MatrlInfoVo matrlInfoVo) throws Exception {
		dao.matrlInfoMultiUpdate(matrlInfoVo);
	}
	
	//품목정보관리 자재 순번 수정
	@Override
	public void matrlInfoOrdUpdate(MatrlInfoVo matrlInfoVo) throws Exception {
		dao.matrlInfoOrdUpdate(matrlInfoVo);
	}
	
	//삭제
	@Override
	public void matrlInfoDelete(MatrlInfoVo matrlInfoVo) throws Exception {
		dao.matrlInfoDelete(matrlInfoVo);
	}
	
	//품번 중복확인
	@Override
	public MatrlInfoVo matrlInfoDupCheck(MatrlInfoVo matrlInfoVo) throws Exception {
		return dao.matrlInfoDupCheck(matrlInfoVo);
	}
	
	// ================================= 수주별발주 =====================================
	// 자재목록조회 BOM포함/미포함
	@Override
	public List<MatrlInfoVo> matrlInfoLstByItemBom(MatrlInfoVo matrlInfoVo) throws Exception {
		return dao.matrlInfoLstByItemBom(matrlInfoVo);
	}
	
	// ================================= 개별발주 =====================================
	// 수주수량 포함 자재목록조회
	@Override
	public List<MatrlInfoVo> matrlInfoLstWithBiz(MatrlInfoVo matrlInfoVo) throws Exception {
		return dao.matrlInfoLstWithBiz(matrlInfoVo);
	}
}

	