package mes.persistence.bm;

import java.util.List;

import mes.domain.bm.DealCorpAdmVo;

public interface DealCorpAdmDAO {

	// 거래처정보 목록조회
	public List<DealCorpAdmVo> dealCorpAdmList(DealCorpAdmVo dealCorpAdmVo) throws Exception;
	
	// 거래처정보(투입자재 발주처) 목록조회
	public List<DealCorpAdmVo> matrlDealCorpAdmList(DealCorpAdmVo dealCorpAdmVo) throws Exception;
	
	// 거래처정보 상세조회
	public DealCorpAdmVo dealCorpAdmSel(DealCorpAdmVo dealCorpAdmVo) throws Exception;
	
	// 거래처정보 등록
	public String dealCorpAdmIns(DealCorpAdmVo dealCorpAdmVo) throws Exception;
	
	// 거래처정보 수정
	public void dealCorpAdmUpd(DealCorpAdmVo dealCorpAdmVo) throws Exception;
	
	// 거래처정보 삭제
	public void dealCorpAdmDel(DealCorpAdmVo dealCorpAdmVo) throws Exception;
	
	// 거래처정보 담당자 목록조회
	public List<DealCorpAdmVo> dealCorpManagerList(DealCorpAdmVo dealCorpAdmVo) throws Exception;
	
	// 거래처정보 담당자 등록
	public void dealCorpManagerIns(DealCorpAdmVo dealCorpAdmVo) throws Exception;
	
	// 거래처정보 담당자 삭제
	public void dealCorpManagerDel(DealCorpAdmVo dealCorpAdmVo) throws Exception;
	
	// 거래처정보 관련파일 목록조회
	public List<DealCorpAdmVo> dealCorpFileList(DealCorpAdmVo dealCorpAdmVo) throws Exception;
	
	// 거래처정보 관련파일 등록
	public void dealCorpFileIns(DealCorpAdmVo dealCorpAdmVo) throws Exception;
	
	// 거래처정보 관련파일 삭제
	public void dealCorpFileDel(DealCorpAdmVo dealCorpAdmVo) throws Exception;
	
	// 거래처 코드 중복 체크
	public DealCorpAdmVo dealCorpCdCheck(DealCorpAdmVo dealCorpAdmVo) throws Exception;
}
