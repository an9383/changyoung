package mes.persistence.bm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.bm.LocationVo;
import mes.domain.bm.PrcssInfoVo;


@Repository
public class LocationDAOImpl implements LocationDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.bm.locationMapper";
	
	//창고정보 목록조회
	@Override
	public List<LocationVo> locationAdmList(LocationVo locationVo) throws Exception {
		return session.selectList(namespace+".locationAdmList" ,locationVo );
	}
	
	// 입고 수불 처리 가능한 창고조회
	@Override
	public List<LocationVo> possibleInLocationList(LocationVo locationVo) throws Exception {
		return session.selectList(namespace+".possibleInLocationList" ,locationVo );
	}
	
	// 폐기 수불 처리 가능한 창고조회
	@Override
	public LocationVo possibleDisposalLocationList(LocationVo locationVo) throws Exception {
		return session.selectOne(namespace+".possibleDisposalLocationList" ,locationVo );
	}
	
	// 제품 출고 수불 처리 가능한 창고조회
	@Override
	public LocationVo possibleOutItemLocationList(LocationVo locationVo) throws Exception {
		return session.selectOne(namespace+".possibleOutItemLocationList" ,locationVo );
	}
	
	// 제품 입고 수불 처리 가능한 창고조회
	@Override
	public LocationVo possibleInItemLocationList(LocationVo locationVo) throws Exception {
		return session.selectOne(namespace+".possibleInItemLocationList" ,locationVo );
	}
	
	// 제품 출고,입고 수불 처리 가능한 창고조회
	@Override
	public LocationVo possibleInOutItemLocationSel(LocationVo locationVo) throws Exception {
		return session.selectOne(namespace+".possibleInOutItemLocationSel" ,locationVo );
	}
	
	// 자재 출고 수불 처리 가능한 창고조회
	@Override
	public LocationVo possibleOutmMatrlLocationList(LocationVo locationVo) throws Exception {
		return session.selectOne(namespace+".possibleOutmMatrlLocationList" ,locationVo );
	}
	
	// 자재 입고 수불 처리 가능한 창고조회
	@Override
	public LocationVo possibleInMatrlLocationList(LocationVo locationVo) throws Exception {
		return session.selectOne(namespace+".possibleInMatrlLocationList" ,locationVo );
	}
	
	// 제품 수불 처리 가능한 번들링창고조회
	@Override
	public LocationVo bundleLocationSel(LocationVo locationVo) throws Exception {
		return session.selectOne(namespace+".bundleLocationSel" ,locationVo );
	}
	
	//창고정보 등록
	@Override
	public void locationAdmInsert(LocationVo locationVo) throws Exception {
		session.insert(namespace+".locationAdmInsert" ,locationVo );
	}
	
	//창고정보 수정
	@Override
	public void locationAdmUpdate(LocationVo locationVo) throws Exception {
		session.update(namespace+".locationAdmUpdate" ,locationVo );
	}
	
	//창고 코드 중복 확인
	@Override
	public LocationVo lcCdDupCheck(LocationVo locationVo) throws Exception {
		return session.selectOne(namespace+".lcCdDupCheck" ,locationVo );
	}

	//창고정보 상세 목록조회
	@Override
	public List<LocationVo> locationDtlList(LocationVo locationVo) throws Exception {
		return session.selectList(namespace+".locationDtlList" ,locationVo );
	}

	//창고정보 상세 등록
	@Override
	public void locationDtlInsert(LocationVo locationVo) throws Exception {
		session.insert(namespace+".locationDtlInsert" ,locationVo );
	}
	
	//창고정보 상세 수정
	@Override
	public void locationDtlUpdate(LocationVo locationVo) throws Exception {
		session.update(namespace+".locationDtlUpdate" ,locationVo );
	}
	
	//창고정보 상세 삭제
	@Override
	public void locationDtlDelete(LocationVo locationVo) throws Exception {
		session.delete(namespace+".locationDtlDelete" ,locationVo );
	}
	
}