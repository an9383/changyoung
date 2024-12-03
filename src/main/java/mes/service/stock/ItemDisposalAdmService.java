package mes.service.stock;

import java.util.List;

import mes.domain.stock.ItemDisposalAdmVo;

public interface ItemDisposalAdmService {
	
	//제품 재고폐기 조회
	public List<ItemDisposalAdmVo> itemDisposalAdmLst(ItemDisposalAdmVo itemDisposalAdmVo) throws Exception;
	
	//제품 재고폐기 등록
	public void itemDisposalAdmIns(ItemDisposalAdmVo itemDisposalAdmVo) throws Exception;
	
	//제품 재고폐기 수정
	public void itemDisposalAdmUpd(ItemDisposalAdmVo itemDisposalAdmVo) throws Exception;
	
	//제품 재고폐기 수정
	public void itemDisposalAdmCheckYnUpd(ItemDisposalAdmVo itemDisposalAdmVo) throws Exception;
	
	//제품 재고폐기 삭제
	public void itemDisposalAdmDel(ItemDisposalAdmVo itemDisposalAdmVo) throws Exception;
}