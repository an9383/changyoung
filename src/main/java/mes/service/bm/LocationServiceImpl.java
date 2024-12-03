package mes.service.bm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.bm.LocationVo;
import mes.persistence.bm.LocationDAO;
@Service
public class LocationServiceImpl implements LocationService {

	@Inject
	private LocationDAO dao;
	
	//창고정보 목록조회
	@Override
	public List<LocationVo> locationAdmList(LocationVo locationVo) throws Exception {
		return dao.locationAdmList(locationVo);
	}

	// 입고 수불 처리 가능한 창고조회
	@Override
	public List<LocationVo> possibleInLocationList(LocationVo locationVo) throws Exception {
		return dao.possibleInLocationList(locationVo);
	}
	
	// 폐기 수불 처리 가능한 창고조회
	@Override
	public LocationVo possibleDisposalLocationList(LocationVo locationVo) throws Exception {
		return dao.possibleDisposalLocationList(locationVo);
	}
	
	// 제품 출고 수불 처리 가능한 창고조회
	@Override
	public LocationVo possibleOutItemLocationList(LocationVo locationVo) throws Exception {
		return dao.possibleOutItemLocationList(locationVo);
	}
	
	// 제품 입고 수불 처리 가능한 창고조회
	@Override
	public LocationVo possibleInItemLocationList(LocationVo locationVo) throws Exception {
		return dao.possibleInItemLocationList(locationVo);
	}
	
	// 제품 출고,입고 수불 처리 가능한 창고조회
	@Override
	public LocationVo possibleInOutItemLocationSel(LocationVo locationVo) throws Exception {
		return dao.possibleInOutItemLocationSel(locationVo);
	}
	
	// 자재출출고 수불 처리 가능한 창고조회
	@Override
	public LocationVo possibleOutmMatrlLocationList(LocationVo locationVo) throws Exception {
		return dao.possibleOutmMatrlLocationList(locationVo);
	}
	
	// 자재 입고 수불 처리 가능한 창고조회
	@Override
	public LocationVo possibleInMatrlLocationList(LocationVo locationVo) throws Exception {
		return dao.possibleInMatrlLocationList(locationVo);
	}
	
	// 제품 수불 처리 가능한 번들링창고조회
	@Override
	public LocationVo bundleLocationSel(LocationVo locationVo) throws Exception {
		return dao.bundleLocationSel(locationVo);
	}
	
	//창고정보 등록
	@Override
	public void locationAdmInsert(LocationVo locationVo) throws Exception {
		dao.locationAdmInsert(locationVo);
	}
	
	//창고정보 수정
	@Override
	public void locationAdmUpdate(LocationVo locationVo) throws Exception {
		dao.locationAdmUpdate(locationVo);
	}
	
	//창고 코드 중복 확인
	@Override
	public LocationVo lcCdDupCheck(LocationVo locationVo) throws Exception {
		return dao.lcCdDupCheck(locationVo);
	}

	//창고정보 상세 목록조회
	@Override
	public List<LocationVo> locationDtlList(LocationVo locationVo) throws Exception {
		return dao.locationDtlList(locationVo);
	}

	//창고정보 상세 등록
	@Override
	public void locationDtlInsert(LocationVo locationVo) throws Exception {
		dao.locationDtlInsert(locationVo);
	}
	
	//창고정보 상세 수정
	@Override
	public void locationDtlUpdate(LocationVo locationVo) throws Exception {
		dao.locationDtlUpdate(locationVo);
	}
	
	//창고정보 상세 삭제
	@Override
	public void locationDtlDelete(LocationVo locationVo) throws Exception {
		dao.locationDtlDelete(locationVo);
	}
}

	