package mes.persistence.bm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.bm.ItemPrcssRoutingVo;

@Repository
public class ItemPrcssRoutingDAOImpl implements ItemPrcssRoutingDAO {

	@Inject
	private SqlSession session;

	private static String namespace = "mes.mappers.bm.itemPrcssRoutingMapper";
	
	//공정라우팅 목록조회
	public List<ItemPrcssRoutingVo> itemPrcssRoutingListAll(ItemPrcssRoutingVo itemPrcssRoutingVo) throws Exception{
		return session.selectList(namespace+".itemPrcssRoutingListAll" , itemPrcssRoutingVo);
	}

	//공정라우팅 상세조회
	public List<ItemPrcssRoutingVo> itemPrcssRoutingSel(ItemPrcssRoutingVo itemPrcssRoutingVo) throws Exception{
		return session.selectList(namespace+".itemPrcssRoutingSel" , itemPrcssRoutingVo);
	}
		
	//공정라우팅 등록
	public void itemPrcssRoutingInsert(ItemPrcssRoutingVo itemPrcssRoutingVo) throws Exception{
		session.insert(namespace+".itemPrcssRoutingInsert" , itemPrcssRoutingVo);
	}
	
	//공정라우팅 수정
	public void itemPrcssRoutingUpdate(ItemPrcssRoutingVo itemPrcssRoutingVo) throws Exception{
		session.update(namespace+".itemPrcssRoutingUpdate" , itemPrcssRoutingVo);
	}
	
	//공정라우팅 삭제
	public void itemPrcssRoutingDelete(ItemPrcssRoutingVo itemPrcssRoutingVo) throws Exception{
		session.delete(namespace+".itemPrcssRoutingDelete" , itemPrcssRoutingVo);
	}
	
	//공정라우팅번호 중복확인
	public int itemPrcssRoutingNoDupCheck(ItemPrcssRoutingVo itemPrcssRoutingVo) throws Exception{
		return session.selectOne(namespace+".itemPrcssRoutingNoDupCheck" , itemPrcssRoutingVo);
	}
}
