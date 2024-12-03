package mes.persistence.bm;

import java.util.List;

import mes.domain.bm.LocationVo;

public interface LocationDAO {
	
	//창고정보 목록조회
	public List<LocationVo> locationAdmList(LocationVo locationVo) throws Exception;
	
	// 입고 수불 처리 가능한 창고조회
	public List<LocationVo> possibleInLocationList(LocationVo locationVo) throws Exception;
	
	// 폐기 수불 처리 가능한 창고조회
	public LocationVo possibleDisposalLocationList(LocationVo locationVo) throws Exception;
	
	// 제품 출고 수불 처리 가능한 창고조회
	public LocationVo possibleOutItemLocationList(LocationVo locationVo) throws Exception;

	// 제품 입고 수불 처리 가능한 창고조회
	public LocationVo possibleInItemLocationList(LocationVo locationVo) throws Exception;
	
	// 제품 출고,입고 수불 처리 가능한 창고조회
	public LocationVo possibleInOutItemLocationSel(LocationVo locationVo) throws Exception;
	
	// 자재 출고 수불 처리 가능한 창고조회
	public LocationVo possibleOutmMatrlLocationList(LocationVo locationVo) throws Exception;

	// 자재 입고 수불 처리 가능한 창고조회
	public LocationVo possibleInMatrlLocationList(LocationVo locationVo) throws Exception;
	
	// 제품 수불 처리 가능한 번들링창고조회
	public LocationVo bundleLocationSel(LocationVo locationVo) throws Exception;
	
	//창고정보 등록
	public void locationAdmInsert(LocationVo locationVo) throws Exception;
	
	//창고정보 수정
	public void locationAdmUpdate(LocationVo locationVo) throws Exception;
	
	//창고 코드 중복 확인
	public LocationVo lcCdDupCheck(LocationVo locationVo) throws Exception;

	//창고정보 상세 목록조회
	public List<LocationVo> locationDtlList(LocationVo locationVo) throws Exception;

	//창고정보 상세 등록
	public void locationDtlInsert(LocationVo locationVo) throws Exception;
	
	//창고정보 상세 수정
	public void locationDtlUpdate(LocationVo locationVo) throws Exception;
	
	//창고정보 상세 삭제
	public void locationDtlDelete(LocationVo locationVo) throws Exception;
	
}
