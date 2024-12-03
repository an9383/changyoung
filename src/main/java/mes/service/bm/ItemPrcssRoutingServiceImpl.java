package mes.service.bm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.bm.ItemPrcssRoutingVo;
import mes.persistence.bm.ItemPrcssRoutingDAO;

@Service
public class ItemPrcssRoutingServiceImpl implements ItemPrcssRoutingService {

	@Inject
	private ItemPrcssRoutingDAO dao;
	
	//공정라우팅 목록조회
	@Override
	public List<ItemPrcssRoutingVo> itemPrcssRoutingListAll(ItemPrcssRoutingVo itemPrcssRoutingVo) throws Exception{
		return dao.itemPrcssRoutingListAll(itemPrcssRoutingVo);
	}

	//공정라우팅 상세조회
	@Override
	public List<ItemPrcssRoutingVo> itemPrcssRoutingSel(ItemPrcssRoutingVo itemPrcssRoutingVo) throws Exception{
		return dao.itemPrcssRoutingSel(itemPrcssRoutingVo);
	}
		
	//공정라우팅 등록
	@Override
	public void itemPrcssRoutingInsert(ItemPrcssRoutingVo itemPrcssRoutingVo) throws Exception{
		dao.itemPrcssRoutingInsert(itemPrcssRoutingVo);
	}
	
	//공정라우팅 수정
	@Override
	public void itemPrcssRoutingUpdate(ItemPrcssRoutingVo itemPrcssRoutingVo) throws Exception{
		dao.itemPrcssRoutingUpdate(itemPrcssRoutingVo);
	}
	
	//공정라우팅 삭제
	@Override
	public void itemPrcssRoutingDelete(ItemPrcssRoutingVo itemPrcssRoutingVo) throws Exception{
		dao.itemPrcssRoutingDelete(itemPrcssRoutingVo);
	}
	
	//공정라우팅번호 중복확인
	@Override
	public int itemPrcssRoutingNoDupCheck(ItemPrcssRoutingVo itemPrcssRoutingVo) throws Exception{
		return dao.itemPrcssRoutingNoDupCheck(itemPrcssRoutingVo);
	}
}
