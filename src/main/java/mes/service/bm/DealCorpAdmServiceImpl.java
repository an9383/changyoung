package mes.service.bm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.bm.DealCorpAdmVo;
import mes.persistence.bm.DealCorpAdmDAO;

@Service
public class DealCorpAdmServiceImpl implements DealCorpAdmService {

	@Inject
	private DealCorpAdmDAO dao;

	// 거래처정보 목록조회
	@Override
	public List<DealCorpAdmVo> dealCorpAdmList(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		return dao.dealCorpAdmList(dealCorpAdmVo);
	}
	
	// 거래처정보(투입자재 발주처) 목록조회
	@Override
	public List<DealCorpAdmVo> matrlDealCorpAdmList(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		return dao.matrlDealCorpAdmList(dealCorpAdmVo);
	}
	
	// 거래처정보 상세조회
	@Override
	public DealCorpAdmVo dealCorpAdmSel(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		return dao.dealCorpAdmSel(dealCorpAdmVo);
	}
	
	// 거래처정보 등록
	@Override
	public String dealCorpAdmIns(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		return dao.dealCorpAdmIns(dealCorpAdmVo);
	}
	
	// 거래처정보 수정
	@Override
	public void dealCorpAdmUpd(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		dao.dealCorpAdmUpd(dealCorpAdmVo);
	}
	
	// 거래처정보 삭제
	@Override
	public void dealCorpAdmDel(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		dao.dealCorpAdmDel(dealCorpAdmVo);
	}
	
	// 거래처정보 담당자 목록조회
	@Override
	public List<DealCorpAdmVo> dealCorpManagerList(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		return dao.dealCorpManagerList(dealCorpAdmVo);
	}
	
	// 거래처정보 담당자 등록
	@Override
	public void dealCorpManagerIns(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		dao.dealCorpManagerIns(dealCorpAdmVo);
	}
	
	// 거래처정보 담당자 삭제
	@Override
	public void dealCorpManagerDel(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		dao.dealCorpManagerDel(dealCorpAdmVo);
	}
	
	// 거래처정보 담당자 목록조회
	@Override
	public List<DealCorpAdmVo> dealCorpFileList(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		return dao.dealCorpFileList(dealCorpAdmVo);
	}
	
	// 거래처정보 담당자 등록
	@Override
	public void dealCorpFileIns(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		dao.dealCorpFileIns(dealCorpAdmVo);
	}
	
	// 거래처정보 담당자 삭제
	@Override
	public void dealCorpFileDel(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		dao.dealCorpFileDel(dealCorpAdmVo);
	}
	
	// 거래처 코드 중복 체크
	@Override
	public DealCorpAdmVo dealCorpCdCheck(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		return dao.dealCorpCdCheck(dealCorpAdmVo);
	}
}

	