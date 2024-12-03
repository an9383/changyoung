package mes.persistence.sm;

import java.util.List;

import mes.domain.sm.UserVo;

public interface UserDAO {

	// 사용자정보 목록조회
	public List<UserVo> userLst(UserVo userVo) throws Exception;
	
	//사용자 상세조회
	public UserVo userSel(UserVo userVo) throws Exception;
	
	// 사용자정보 등록
	public void userIns(UserVo userVo) throws Exception;
	
	// 사용자정보 수정
	public void userUpd(UserVo userVo) throws Exception;
	
	// 사용자정보 삭제
	public void userDel(UserVo userVo) throws Exception;
	
	//사용자 ID 중복확인
	public UserVo userIdDupCheck(UserVo userVo) throws Exception;
	
	//사용자 ADMIN 권한있는 사용자 인원수 확인
	public UserVo userAdminExsitCheck(UserVo userVo) throws Exception;
}
