package mes.persistence.bm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.bm.MatrlInfoVo;


@Repository
public class MatrlInfoDAOImpl implements MatrlInfoDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.bm.matrlInfoMapper";
	
	//자재 목록조회
	@Override
	public List<MatrlInfoVo> matrlInfoListAll(MatrlInfoVo matrlInfoVo) throws Exception {
		return session.selectList(namespace+".matrlInfoListAll" ,matrlInfoVo );
	}
	
	//재질 중복체크
	@Override
	public List<MatrlInfoVo> paperTypeDupCheck(MatrlInfoVo matrlInfoVo) throws Exception {
		return session.selectList(namespace+".paperTypeDupCheck" ,matrlInfoVo );
	}
	
	//자재 상세조회
	@Override
	public MatrlInfoVo matrlInfoSel(MatrlInfoVo matrlInfoVo) throws Exception {
		return session.selectOne(namespace+".matrlInfoSel", matrlInfoVo);
	}
		
	//자재 등록
	@Override
	public void matrlInfoInsert(MatrlInfoVo matrlInfoVo) throws Exception {
		session.insert(namespace+".matrlInfoInsert", matrlInfoVo);
	}
	
	//자재 수정
	@Override
	public void matrlInfoUpdate(MatrlInfoVo matrlInfoVo) throws Exception {
		session.update(namespace+".matrlInfoUpdate", matrlInfoVo);
	}	
	
	//자재 다중 수정
	@Override
	public void matrlInfoMultiUpdate(MatrlInfoVo matrlInfoVo) throws Exception {
		session.update(namespace+".matrlInfoMultiUpdate", matrlInfoVo);
	}	
	
	//자재 순번 수정
	@Override
	public void matrlInfoOrdUpdate(MatrlInfoVo matrlInfoVo) throws Exception {
		session.update(namespace+".matrlInfoOrdUpdate", matrlInfoVo);
	}	
	
	//자재 삭제
	@Override
	public void matrlInfoDelete(MatrlInfoVo matrlInfoVo) throws Exception {
		session.delete(namespace+".matrlInfoDelete", matrlInfoVo);
	}
	
	//자재코드 중복확인
	@Override
	public MatrlInfoVo matrlInfoDupCheck(MatrlInfoVo matrlInfoVo) throws Exception {
		return session.selectOne(namespace+".matrlInfoDupCheck", matrlInfoVo);
	}
	
	// ================================= 수주별발주 =====================================
	// 자재목록조회 BOM포함/미포함
	@Override
	public List<MatrlInfoVo> matrlInfoLstByItemBom(MatrlInfoVo matrlInfoVo) throws Exception {
		return session.selectList(namespace+".matrlInfoLstByItemBom" ,matrlInfoVo );
	}
	
	// ================================= 개별발주 =====================================
	// 수주수량 포함 자재목록조회
	@Override
	public List<MatrlInfoVo> matrlInfoLstWithBiz(MatrlInfoVo matrlInfoVo) throws Exception {
		return session.selectList(namespace+".matrlInfoLstWithBiz" ,matrlInfoVo );
	}
}