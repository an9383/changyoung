package mes.service.qm;

import java.util.List;

import mes.domain.qm.ProdQualityVo;

public interface ProdQualityService {
	
	//제품검사 목록 조회
	public List<ProdQualityVo> prodQualityAdmLst(ProdQualityVo prodQualityVo) throws Exception;
	
	//제품검사 현황 조회
	public List<ProdQualityVo> prodQualityProgressLst(ProdQualityVo prodQualityVo) throws Exception;
	
	//제품검사 판정 완료 목록 조회
	public List<ProdQualityVo> prodQualityJudgmentEndLstByWorkOrdResultIdx(ProdQualityVo prodQualityVo) throws Exception;
	
	//제품검사 합격 및 승인 목록 조회
	public List<ProdQualityVo> prodQualityPassLst(ProdQualityVo prodQualityVo) throws Exception;
	
	//제품검사 수량,판정,승인자 등록
	public void prodQualityAdmIns(ProdQualityVo prodQualityVo) throws Exception;
	
	//제품검사 수량,판정,승인자 등록 - 공정실적등록(생산)에서  처리되는 품질검사( 자동 검사 처리 )
	public void prodQualityAdmInsByWork(ProdQualityVo prodQualityVo) throws Exception;
	
	//제품검사 수량,판정,승인자 수정
	public void prodQualityAdmUpd(ProdQualityVo prodQualityVo) throws Exception;

	//제품검사 판정 삭제
	public void prodQualityAdmDel(ProdQualityVo prodQualityVo) throws Exception;
	
	//제품검사 승인 처리
	public void prodQualityAdmConfirmUpd(ProdQualityVo prodQualityVo) throws Exception;
	
	//검사성적서 출력
	public void prodQualityPaperUpd(ProdQualityVo prodQualityVo) throws Exception;
	
	//제품검사 - 공정불량내역
	public List<ProdQualityVo> workFaultyLst(ProdQualityVo prodQualityVo) throws Exception;
}
