package mes.persistence.sm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.sm.UserVo;

@Repository
public class UserDAOImpl implements UserDAO {

	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.sm.userMapper";
	
	// 사용자정보 목록조회
	@Override
	public List<UserVo> userLst(UserVo userVo) throws Exception {
		return session.selectList(namespace+".userLst", userVo);
	}
	
	//사용자 상세조회
	@Override
	public UserVo userSel(UserVo userVo) throws Exception {
		return session.selectOne(namespace+".userSel", userVo);
	}
	
	// 사용자정보 등록
	@Override
	public void userIns(UserVo userVo) throws Exception {
		session.insert(namespace+".userIns", userVo);
	}
	
	// 사용자정보 수정
	@Override
	public void userUpd(UserVo userVo) throws Exception {
		session.update(namespace+".userUpd", userVo);
	}
	
	// 사용자정보 삭제
	@Override
	public void userDel(UserVo userVo) throws Exception {
		session.delete(namespace+".userDel", userVo);
	}
	
	//사용자 ID 중복확인
	@Override
	public UserVo userIdDupCheck(UserVo userVo) throws Exception {
		return session.selectOne(namespace+".userIdDupCheck", userVo);
	}
	
	//사용자 ADMIN 권한있는 사용자 인원수 확인
	@Override
	public UserVo userAdminExsitCheck(UserVo userVo) throws Exception {
		return session.selectOne(namespace+".userAdminExsitCheck", userVo);
	}
}
