package mes.service.bm;

import java.util.List;

import mes.domain.bm.ItemPrcssRoutingVo;

public interface ItemPrcssRoutingService {
	
	//공정라우팅 목록조회
	public List<ItemPrcssRoutingVo> itemPrcssRoutingListAll(ItemPrcssRoutingVo itemPrcssRoutingVo) throws Exception;

	//공정라우팅 상세조회
	public List<ItemPrcssRoutingVo> itemPrcssRoutingSel(ItemPrcssRoutingVo itemPrcssRoutingVo) throws Exception;
		
	//공정라우팅 등록
	public void itemPrcssRoutingInsert(ItemPrcssRoutingVo itemPrcssRoutingVo) throws Exception;
	
	//공정라우팅 수정
	public void itemPrcssRoutingUpdate(ItemPrcssRoutingVo itemPrcssRoutingVo) throws Exception;
	
	//공정라우팅 삭제
	public void itemPrcssRoutingDelete(ItemPrcssRoutingVo itemPrcssRoutingVo) throws Exception;
	
	//공정라우팅번호 중복확인
	public int itemPrcssRoutingNoDupCheck(ItemPrcssRoutingVo itemPrcssRoutingVo) throws Exception;
}
