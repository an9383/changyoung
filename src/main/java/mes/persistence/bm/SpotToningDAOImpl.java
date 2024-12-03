package mes.persistence.bm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.bm.SpotToningVo;


@Repository
public class SpotToningDAOImpl implements SpotToningDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.bm.spotToningMapper";
	
	//조색별색정보 목록조회
	@Override
	public List<SpotToningVo> spotToningList(SpotToningVo spotToningVo) throws Exception {
		return session.selectList(namespace+".spotToningList" ,spotToningVo );
	}
	
	//조색별색정보 상세조회
	@Override
	public SpotToningVo spotToningSel(SpotToningVo spotToningVo) throws Exception {
		return session.selectOne(namespace+".spotToningSel" ,spotToningVo );
	}

	//조색별색정보 등록
	@Override
	public void spotToningInsert(SpotToningVo spotToningVo) throws Exception {
		session.insert(namespace+".spotToningInsert" ,spotToningVo );
	}
	
	//조색별색정보 수정
	@Override
	public void spotToningUpdate(SpotToningVo spotToningVo) throws Exception {
		session.update(namespace+".spotToningUpdate" ,spotToningVo );
	}
	
	//조색별색정보 순번 수정
	@Override
	public void spotToningOrderUpdate(SpotToningVo spotToningVo) throws Exception {
		session.update(namespace+".spotToningOrderUpdate" ,spotToningVo );
	}
	
	//조색별색정보 삭제
	@Override
	public void spotToningDelete(SpotToningVo spotToningVo) throws Exception {
		session.delete(namespace+".spotToningDelete" ,spotToningVo );
	}
	
	//조색별색정보 코드 중복 확인
	@Override
	public SpotToningVo colorCdDupCheck(SpotToningVo spotToningVo) throws Exception {
		return session.selectOne(namespace+".colorCdDupCheck" ,spotToningVo );
	}

}