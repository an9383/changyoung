package mes.persistence.bm;

import java.util.List;

import mes.domain.bm.ItemInfoAdmVo;
import mes.domain.bm.ItemInfoVo;

public interface ItemInfoAdmDAO {

	//품목정보관리 제품, 자재 목록조회
	public List<ItemInfoAdmVo> itemInfoListAll(ItemInfoAdmVo itemInfoAdmVo) throws Exception;
	
	//품목정보관리 제품조회(제품코드등록 메인LST)
	public List<ItemInfoVo> itemInfoLst(ItemInfoAdmVo itemInfoAdmVo) throws Exception;

	//제품 목록상세조회
	public ItemInfoAdmVo itemInfoSel(ItemInfoAdmVo itemInfoAdmVo) throws Exception;
	
	//품목정보관리 등록
	public String itemInfoInsert(ItemInfoAdmVo itemInfoAdmVo) throws Exception;
	
	//품목정보관리 복사
	public String itemInfoCopy(ItemInfoAdmVo itemInfoAdmVo) throws Exception;
	
	//품목정보관리 수정
	public void itemInfoUpdate(ItemInfoAdmVo itemInfoAdmVo) throws Exception;
	
	//삭제
	public void itemInfoDelete(ItemInfoAdmVo itemInfoAdmVo) throws Exception;

	//품번 중복확인
	public ItemInfoAdmVo itemInfoDupCheck(ItemInfoAdmVo itemInfoAdmVo) throws Exception;
	
	//제품명 중복확인
	public List<ItemInfoAdmVo> itemNmDupCheck(ItemInfoAdmVo itemInfoAdmVo) throws Exception;
	
	//품목정보관리 버전이력
	public List<ItemInfoAdmVo> itemVersionListAll(ItemInfoAdmVo itemInfoAdmVo) throws Exception;
	
	//품목정보관리 제품수행이력 목록조회
	public List<ItemInfoAdmVo> itemPerformanceHistoryLst(ItemInfoAdmVo itemInfoAdmVo) throws Exception;
	
	//품목정보관리 버전 등록
	public void itemVersionInsert(ItemInfoAdmVo itemInfoAdmVo) throws Exception;
	
	//품목정보관리 버전 수정
	public void itemVersionUpdate(ItemInfoAdmVo itemInfoAdmVo) throws Exception;
	
	//버전삭제
	public void itemVersionDelete(ItemInfoAdmVo itemInfoAdmVo) throws Exception;
	
	//품목정보관리 파일 목록조회
	public List<ItemInfoAdmVo> itemFileListAll(ItemInfoAdmVo itemInfoAdmVo) throws Exception;
		
	//품목정보관리 파일 등록
	public void itemFileInsert(ItemInfoAdmVo itemInfoAdmVo) throws Exception;
	
	//품목정보관리 파일 삭제
	public void itemFileDelete(ItemInfoAdmVo itemInfoAdmVo) throws Exception;
	
	//제품코드조회 목록
	public List<ItemInfoAdmVo> itemInfoDtlListAll(ItemInfoAdmVo itemInfoAdmVo) throws Exception;
	
	//제품코드, 자재 조회 목록
	public List<ItemInfoAdmVo> itemInfoAndMatrlListAll(ItemInfoAdmVo itemInfoAdmVo) throws Exception;
	
	//상품코드, 자재 조회 목록
	public List<ItemInfoAdmVo> goodsInfoAndMatrlLstAll(ItemInfoAdmVo itemInfoAdmVo) throws Exception;
	
	//투입자재 목록
	public List<ItemInfoAdmVo> itemBomList(ItemInfoAdmVo itemInfoAdmVo) throws Exception;
	
	//투입자재 목록
	public List<ItemInfoAdmVo> itemBomListByItemIdxJson(ItemInfoAdmVo itemInfoAdmVo) throws Exception;
	
	//투입자재 등록
	public void itemBomInsert(ItemInfoAdmVo itemInfoAdmVo) throws Exception;
	
	//투입자재 삭제
	public void itemBomDelete(ItemInfoAdmVo itemInfoAdmVo) throws Exception;
	
	//공정 목록
	public List<ItemInfoAdmVo> itemPrcssList(ItemInfoAdmVo itemInfoAdmVo) throws Exception;
	
	//공정 등록
	public void itemPrcssInsert(ItemInfoAdmVo itemInfoAdmVo) throws Exception;
	
	//공정 삭제
	public void itemPrcssDelete(ItemInfoAdmVo itemInfoAdmVo) throws Exception;
	
	//수지판,목형 목록 - 사이즈 코팅방법 성형방법 일치하는 목록
	//public List<ItemInfoAdmVo> itemPrcssList(ItemInfoAdmVo itemInfoAdmVo) throws Exception;
	
	//품목정보관리 번들링 목록조회
	public List<ItemInfoAdmVo> bundleInfoList(ItemInfoAdmVo itemInfoAdmVo) throws Exception;
	
	//품목정보관리 번들링 목록조회
	public List<ItemInfoAdmVo> bundleInfoListByWorkOrdPrcssIdx(ItemInfoAdmVo itemInfoAdmVo) throws Exception;
		
	//품목정보관리 번들링 등록
	public void bundleInfoInsert(ItemInfoAdmVo itemInfoAdmVo) throws Exception;

	//품목정보관리 번들링 삭제
	public void bundleInfoDelete(ItemInfoAdmVo itemInfoAdmVo) throws Exception;
	
}
