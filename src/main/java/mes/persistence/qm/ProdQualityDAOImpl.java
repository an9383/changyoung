package mes.persistence.qm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.qm.ProdQualityVo;

@Repository
public class ProdQualityDAOImpl implements ProdQualityDAO {

	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.qm.prodQualityMapper";

	//제품검사 목록 조회
	@Override
	public List<ProdQualityVo> prodQualityAdmLst(ProdQualityVo prodQualityVo) throws Exception {
		return session.selectList(namespace+".prodQualityAdmLst", prodQualityVo);
	}
	
	//제품검사 현황 조회
	@Override
	public List<ProdQualityVo> prodQualityProgressLst(ProdQualityVo prodQualityVo) throws Exception {
		return session.selectList(namespace+".prodQualityProgressLst", prodQualityVo);
	}
	
	//제품검사 판정 완료 목록 조회
	@Override
	public List<ProdQualityVo> prodQualityJudgmentEndLstByWorkOrdResultIdx(ProdQualityVo prodQualityVo) throws Exception {
		return session.selectList(namespace+".prodQualityJudgmentEndLstByWorkOrdResultIdx", prodQualityVo);
	}
	
	//제품검사 합격 및 승인 목록 조회
	@Override
	public List<ProdQualityVo> prodQualityPassLst(ProdQualityVo prodQualityVo) throws Exception {
		return session.selectList(namespace+".prodQualityPassLst", prodQualityVo);
	}
	
	//제품검사 수량,판정,승인자 등록
	@Override
	public void prodQualityAdmIns(ProdQualityVo prodQualityVo) throws Exception {
		session.insert(namespace+".prodQualityAdmIns", prodQualityVo);
	}
	
	//제품검사 수량,판정,승인자 등록 - 공정실적등록(생산)에서  처리되는 품질검사( 자동 검사 처리 )
	@Override
	public void prodQualityAdmInsByWork(ProdQualityVo prodQualityVo) throws Exception {
		session.insert(namespace+".prodQualityAdmInsByWork", prodQualityVo);
	}
	
	//제품검사 수량,판정,승인자 수정
	@Override
	public void prodQualityAdmUpd(ProdQualityVo prodQualityVo) throws Exception {
		session.update(namespace+".prodQualityAdmUpd", prodQualityVo);
	}
	
	//제품검사 판정 삭제
	@Override
	public void prodQualityAdmDel(ProdQualityVo prodQualityVo) throws Exception {
		session.delete(namespace+".prodQualityAdmDel", prodQualityVo);
	}
	
	//제품검사 승인 처리
	@Override
	public void prodQualityAdmConfirmUpd(ProdQualityVo prodQualityVo) throws Exception {
		session.update(namespace+".prodQualityAdmConfirmUpd", prodQualityVo);
	}
	
	//검사성적서 출력
	@Override
	public void prodQualityPaperUpd(ProdQualityVo prodQualityVo) throws Exception {
		session.update(namespace+".prodQualityPaperUpd", prodQualityVo);
	}
	
	//제품검사 - 공정불량내역
	@Override
	public List<ProdQualityVo> workFaultyLst(ProdQualityVo prodQualityVo) throws Exception {
		return session.selectList(namespace+".workFaultyLst", prodQualityVo);
	}
}
