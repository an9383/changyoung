package mes.service.bm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.bm.ItemInfoAdmVo;
import mes.domain.bm.ItemInfoVo;
import mes.persistence.bm.ItemInfoAdmDAO;
@Service
public class ItemInfoAdmServiceImpl implements ItemInfoAdmService {

	@Inject
	private ItemInfoAdmDAO dao;

	//품목정보관리 제품,자재 목록조회
	@Override
	public List<ItemInfoAdmVo> itemInfoListAll(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		return dao.itemInfoListAll(itemInfoAdmVo);
	}
	
	//품목정보관리 제품조회(제품코드등록 메인LST)
	@Override
	public List<ItemInfoVo> itemInfoLst(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		return dao.itemInfoLst(itemInfoAdmVo);
	}
	
	//목록상세조회
	@Override
	public ItemInfoAdmVo itemInfoSel(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		return dao.itemInfoSel(itemInfoAdmVo);
	}
		
	//품목정보관리 등록
	@Override
	public String itemInfoInsert(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		return dao.itemInfoInsert(itemInfoAdmVo);
	}
	
	//품목정보관리 복사
	@Override
	public String itemInfoCopy(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		return dao.itemInfoCopy(itemInfoAdmVo);
	}
	
	//품목정보관리 수정
	@Override
	public void itemInfoUpdate(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		dao.itemInfoUpdate(itemInfoAdmVo);
	}
	
	//삭제
	@Override
	public void itemInfoDelete(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		dao.itemInfoDelete(itemInfoAdmVo);
	}
	
	//품번 중복확인
	@Override
	public ItemInfoAdmVo itemInfoDupCheck(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		return dao.itemInfoDupCheck(itemInfoAdmVo);
	}
	
	//제품명 중복확인
	@Override
	public List<ItemInfoAdmVo> itemNmDupCheck(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		return dao.itemNmDupCheck(itemInfoAdmVo);
	}
	
	//품목정보관리 버전이력
	@Override
	public List<ItemInfoAdmVo> itemVersionListAll(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		return dao.itemVersionListAll(itemInfoAdmVo);
	}
	
	//품목정보관리 제품수행이력 목록조회
	@Override
	public List<ItemInfoAdmVo> itemPerformanceHistoryLst(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		return dao.itemPerformanceHistoryLst(itemInfoAdmVo);
	}
	
	//품목정보관리 버전 등록
	@Override
	public void itemVersionInsert(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		dao.itemVersionInsert(itemInfoAdmVo);
	}
	
	//품목정보관리 버전 수정
	@Override
	public void itemVersionUpdate(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		dao.itemVersionUpdate(itemInfoAdmVo);
	}
	
	//버전삭제
	@Override
	public void itemVersionDelete(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		dao.itemVersionDelete(itemInfoAdmVo);
	}
	
	//품목정보관리 파일 목록조회
	@Override
	public List<ItemInfoAdmVo> itemFileListAll(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		return dao.itemFileListAll(itemInfoAdmVo);
	}
	
	//품목정보관리 파일등록
	@Override
	public void itemFileInsert(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		dao.itemFileInsert(itemInfoAdmVo);
	}
	
	//파일삭제
	@Override
	public void itemFileDelete(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		dao.itemFileDelete(itemInfoAdmVo);
	}
		
	//제품코드조회 목록조회
	@Override
	public List<ItemInfoAdmVo> itemInfoDtlListAll(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		return dao.itemInfoDtlListAll(itemInfoAdmVo);
	}
	
	//제품코드, 자재 조회 목록
	@Override
	public List<ItemInfoAdmVo> itemInfoAndMatrlListAll(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		return dao.itemInfoAndMatrlListAll(itemInfoAdmVo);
	}
	
	//상품코드, 자재 조회 목록
	@Override
	public List<ItemInfoAdmVo> goodsInfoAndMatrlLstAll(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		return dao.goodsInfoAndMatrlLstAll(itemInfoAdmVo);
	}
	
	//투입자재 목록조회
	@Override
	public List<ItemInfoAdmVo> itemBomList(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		return dao.itemBomList(itemInfoAdmVo);
	}
	
	//투입자재 목록조회
	@Override
	public List<ItemInfoAdmVo> itemBomListByItemIdxJson(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		return dao.itemBomListByItemIdxJson(itemInfoAdmVo);
	}
	
	//투입자재 등록
	@Override
	public void itemBomInsert(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		dao.itemBomInsert(itemInfoAdmVo);
	}
	
	//투입자재 삭제
	@Override
	public void itemBomDelete(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		dao.itemBomDelete(itemInfoAdmVo);
	}
	
	//공정 목록조회
	@Override
	public List<ItemInfoAdmVo> itemPrcssList(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		return dao.itemPrcssList(itemInfoAdmVo);
	}
	
	//공정 등록
	@Override
	public void itemPrcssInsert(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		dao.itemPrcssInsert(itemInfoAdmVo);
	}
	
	//공정 삭제
	@Override
	public void itemPrcssDelete(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		dao.itemPrcssDelete(itemInfoAdmVo);
	}
	
	//품목정보관리 번들링 목록조회
	@Override
	public List<ItemInfoAdmVo> bundleInfoList(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		return dao.bundleInfoList(itemInfoAdmVo);
	}
	
	//품목정보관리 번들링 목록조회
	@Override
	public List<ItemInfoAdmVo> bundleInfoListByWorkOrdPrcssIdx(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		return dao.bundleInfoListByWorkOrdPrcssIdx(itemInfoAdmVo);
	}
	
	//품목정보관리 번들링 등록
	@Override
	public void bundleInfoInsert(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		dao.bundleInfoInsert(itemInfoAdmVo);
	}
	
	//품목정보관리 번들링 삭제
	@Override
	public void bundleInfoDelete(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		dao.bundleInfoDelete(itemInfoAdmVo);
	}
}

	