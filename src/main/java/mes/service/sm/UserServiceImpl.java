package mes.service.sm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.sm.UserVo;
import mes.persistence.sm.UserDAO;

@Service
public class UserServiceImpl implements UserService {

	@Inject
	private UserDAO dao;
	
	// 사용자정보 목록조회
	@Override
	public List<UserVo> userLst(UserVo userVo) throws Exception {
		return dao.userLst(userVo);
	}
	
	//사용자 상세조회
	@Override
	public UserVo userSel(UserVo userVo) throws Exception {
		return dao.userSel(userVo);
	}
	
	// 사용자정보 등록
	@Override
	public void userIns(UserVo userVo) throws Exception {
		dao.userIns(userVo);
	}
	
	// 사용자정보 수정
	@Override
	public void userUpd(UserVo userVo) throws Exception {
		dao.userUpd(userVo);
	}
	
	// 사용자정보 삭제
	@Override
	public void userDel(UserVo userVo) throws Exception {
		dao.userDel(userVo);
	}
	
	//사용자 ID 중복확인
	@Override
	public UserVo userIdDupCheck(UserVo userVo) throws Exception {
		return dao.userIdDupCheck(userVo);
	}
	
	//사용자 ADMIN 권한있는 사용자 인원수 확인
	@Override
	public UserVo userAdminExsitCheck(UserVo userVo) throws Exception {
		return dao.userAdminExsitCheck(userVo);
	}
}
