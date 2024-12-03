package mes.persistence.bm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.bm.DealCorpAdmVo;


@Repository
public class DealCorpAdmDAOImpl implements DealCorpAdmDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.bm.dealCorpAdmMapper";
	
	// 거래처정보 목록조회
	@Override
	public List<DealCorpAdmVo> dealCorpAdmList(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		return session.selectList(namespace+".dealCorpAdmList", dealCorpAdmVo);
	}
	
	// 거래처정보(투입자재 발주처) 목록조회
	@Override
	public List<DealCorpAdmVo> matrlDealCorpAdmList(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		return session.selectList(namespace+".matrlDealCorpAdmList", dealCorpAdmVo);
	}
	
	// 거래처정보 상세조회
	@Override
	public DealCorpAdmVo dealCorpAdmSel(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		return session.selectOne(namespace+".dealCorpAdmSel", dealCorpAdmVo);
	}
	
	// 거래처정보 등록
	@Override
	public String dealCorpAdmIns(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		session.insert(namespace+".dealCorpAdmIns", dealCorpAdmVo);
		String idx = dealCorpAdmVo.getIdx();
		return idx;
	}
	
	// 거래처정보 수정
	@Override
	public void dealCorpAdmUpd(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		session.update(namespace+".dealCorpAdmUpd", dealCorpAdmVo);
	}
	
	// 거래처정보 삭제
	@Override
	public void dealCorpAdmDel(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		session.delete(namespace+".dealCorpAdmDel", dealCorpAdmVo);
	}
			
	// 거래처정보 담당자 목록조회
	@Override
	public List<DealCorpAdmVo> dealCorpManagerList(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		return session.selectList(namespace+".dealCorpManagerList", dealCorpAdmVo);
	}
	
	// 거래처정보 담당자 등록
	@Override
	public void dealCorpManagerIns(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		session.insert(namespace+".dealCorpManagerIns", dealCorpAdmVo);
	}
	
	// 거래처정보 담당자 삭제
	@Override
	public void dealCorpManagerDel(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		session.delete(namespace+".dealCorpManagerDel", dealCorpAdmVo);
	}
	
	// 거래처정보 담당자 목록조회
	@Override
	public List<DealCorpAdmVo> dealCorpFileList(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		return session.selectList(namespace+".dealCorpFileList", dealCorpAdmVo);
	}
	
	// 거래처정보 담당자 등록
	@Override
	public void dealCorpFileIns(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		session.insert(namespace+".dealCorpFileIns", dealCorpAdmVo);
	}
	
	// 거래처정보 담당자 삭제
	@Override
	public void dealCorpFileDel(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		session.delete(namespace+".dealCorpFileDel", dealCorpAdmVo);
	}
	
	// 거래처 코드 중복 체크
	@Override
	public DealCorpAdmVo dealCorpCdCheck(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		return session.selectOne(namespace+".dealCorpCdCheck", dealCorpAdmVo);
	}
}