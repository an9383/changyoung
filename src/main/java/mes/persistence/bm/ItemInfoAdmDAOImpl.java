package mes.persistence.bm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.bm.ItemInfoAdmVo;
import mes.domain.bm.ItemInfoVo;


@Repository
public class ItemInfoAdmDAOImpl implements ItemInfoAdmDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.bm.itemInfoAdmMapper";
	
	//품목정보관리 제품, 자재 목록조회
	@Override
	public List<ItemInfoAdmVo> itemInfoListAll(ItemInfoAdmVo itemInfoAdmVo) throws Exception{
		return session.selectList(namespace+".itemInfoListAll" ,itemInfoAdmVo );
	}
	
	//품목정보관리 제품조회(제품코드등록 메인LST)
	@Override
	public List<ItemInfoVo> itemInfoLst(ItemInfoAdmVo itemInfoAdmVo) throws Exception{
		return session.selectList(namespace+".itemInfoLst" ,itemInfoAdmVo );
	}
	
	//목록상세조회
	@Override
	public ItemInfoAdmVo itemInfoSel(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		return session.selectOne(namespace+".itemInfoSel", itemInfoAdmVo);
	}
		
	//품목정보관리 등록
	@Override
	public String itemInfoInsert(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		session.insert(namespace+".itemInfoInsert", itemInfoAdmVo);
		String idx = itemInfoAdmVo.getIdx();
		return idx;
	}
	
	//품목정보관리 복사
	@Override
	public String itemInfoCopy(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		session.insert(namespace+".itemInfoCopy", itemInfoAdmVo);
		String idx = itemInfoAdmVo.getIdx();
		return idx;
	}
	
	//품목정보관리 수정
	@Override
	public void itemInfoUpdate(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		session.update(namespace+".itemInfoUpdate", itemInfoAdmVo);
	}	
	
	//삭제
	@Override
	public void itemInfoDelete(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		session.delete(namespace+".itemInfoDelete", itemInfoAdmVo);
	}
	
	//품번 중복확인
	@Override
	public ItemInfoAdmVo itemInfoDupCheck(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		return session.selectOne(namespace+".itemInfoDupCheck", itemInfoAdmVo);
	}
	
	//제품명 중복확인
	@Override
	public List<ItemInfoAdmVo> itemNmDupCheck(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		return session.selectList(namespace+".itemNmDupCheck", itemInfoAdmVo);
	}
	
	//품목정보관리 버전이력
	@Override
	public List<ItemInfoAdmVo> itemVersionListAll(ItemInfoAdmVo itemInfoAdmVo) throws Exception{
		return session.selectList(namespace+".itemVersionListAll" ,itemInfoAdmVo );
	}
	
	//품목정보관리 제품수행이력 목록조회
	@Override
	public List<ItemInfoAdmVo> itemPerformanceHistoryLst(ItemInfoAdmVo itemInfoAdmVo) throws Exception{
		return session.selectList(namespace + ".itemPerformanceHistoryLst", itemInfoAdmVo);
	}
	
	//품목정보관리 버전 등록
	@Override
	public void itemVersionInsert(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		session.insert(namespace+".itemVersionInsert", itemInfoAdmVo);
	}
	
	//품목정보관리 버전 수정
	@Override
	public void itemVersionUpdate(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		session.update(namespace + ".itemVersionUpdate", itemInfoAdmVo);
	}
	
	//버전삭제
	@Override
	public void itemVersionDelete(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		session.delete(namespace+".itemVersionDelete", itemInfoAdmVo);
	}
	
	//품목정보관리 파일 목록조회
	@Override
	public List<ItemInfoAdmVo> itemFileListAll(ItemInfoAdmVo itemInfoAdmVo) throws Exception{
		return session.selectList(namespace+".itemFileListAll" ,itemInfoAdmVo );
	}
	
	//품목정보관리 파일 등록
	@Override
	public void itemFileInsert(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		session.insert(namespace+".itemFileInsert", itemInfoAdmVo);
	}
	
	//파일 삭제
	@Override
	public void itemFileDelete(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		session.delete(namespace+".itemFileDelete", itemInfoAdmVo);
	}
	
	//제품코드조회 목록
	@Override
	public List<ItemInfoAdmVo> itemInfoDtlListAll(ItemInfoAdmVo itemInfoAdmVo) throws Exception{
		return session.selectList(namespace+".itemInfoDtlListAll" ,itemInfoAdmVo );
	}
	
	//제품코드, 자재 조회 목록
	@Override
	public List<ItemInfoAdmVo> itemInfoAndMatrlListAll(ItemInfoAdmVo itemInfoAdmVo) throws Exception{
		return session.selectList(namespace+".itemInfoAndMatrlListAll" ,itemInfoAdmVo );
	}
	
	//상품코드, 자재 조회 목록
	@Override
	public List<ItemInfoAdmVo> goodsInfoAndMatrlLstAll(ItemInfoAdmVo itemInfoAdmVo) throws Exception{
		return session.selectList(namespace+".goodsInfoAndMatrlLstAll" ,itemInfoAdmVo );
	}
	
	//투입자재 목록
	@Override
	public List<ItemInfoAdmVo> itemBomList(ItemInfoAdmVo itemInfoAdmVo) throws Exception{
		return session.selectList(namespace+".itemBomList" ,itemInfoAdmVo );
	}
	
	//투입자재 목록
	@Override
	public List<ItemInfoAdmVo> itemBomListByItemIdxJson(ItemInfoAdmVo itemInfoAdmVo) throws Exception{
		return session.selectList(namespace+".itemBomListByItemIdxJson" ,itemInfoAdmVo );
	}
	
	//투입자재 등록
	@Override
	public void itemBomInsert(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		session.insert(namespace+".itemBomInsert", itemInfoAdmVo);
	}
	
	//투입자재 삭제
	@Override
	public void itemBomDelete(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		session.delete(namespace+".itemBomDelete", itemInfoAdmVo);
	}
		
	//공정 목록
	@Override
	public List<ItemInfoAdmVo> itemPrcssList(ItemInfoAdmVo itemInfoAdmVo) throws Exception{
		return session.selectList(namespace+".itemPrcssList" ,itemInfoAdmVo );
	}
	
	//공정 등록
	@Override
	public void itemPrcssInsert(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		session.insert(namespace+".itemPrcssInsert", itemInfoAdmVo);
	}
	
	//공정 삭제
	@Override
	public void itemPrcssDelete(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		session.delete(namespace+".itemPrcssDelete", itemInfoAdmVo);
	}
	
	//품목정보관리 번들링 목록조회
	@Override
	public List<ItemInfoAdmVo> bundleInfoList(ItemInfoAdmVo itemInfoAdmVo) throws Exception{
		return session.selectList(namespace+".bundleInfoList" ,itemInfoAdmVo );
	}
	
	//품목정보관리 번들링 목록조회
	@Override
	public List<ItemInfoAdmVo> bundleInfoListByWorkOrdPrcssIdx(ItemInfoAdmVo itemInfoAdmVo) throws Exception{
		return session.selectList(namespace+".bundleInfoListByWorkOrdPrcssIdx" ,itemInfoAdmVo );
	}
	
	//품목정보관리 번들링 등록
	@Override
	public void bundleInfoInsert(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		session.insert(namespace+".bundleInfoInsert", itemInfoAdmVo);
	}
	
	//품목정보관리 번들링 삭제
	@Override
	public void bundleInfoDelete(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		session.delete(namespace+".bundleInfoDelete", itemInfoAdmVo);
	}
	
}