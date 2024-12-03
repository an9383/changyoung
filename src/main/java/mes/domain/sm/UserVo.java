package mes.domain.sm;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
@Alias("UserVo")
public class UserVo{
	private String idx;
	private String userName;
	private String userId;
	private String userPw;
	private String userChangePw;
	private String userEmail;
	private String userTeam;
	private String userDepartmentCd;
	private String userJobCd;
	private String userPositionCd;
	private String userStateCd;
	private String userJoinDate;
	private String userLeaveDate;
	private String userAdmin;
	private String userSign;
	private String userSignImage;
	private String etc1;
	private String etc2;
	private String etc3;
	private String regIdx;
	private String regDate;
	private String updIdx;
	private String updDate;
	
	private String userDepartmentNm;
	private String userJobNm;
	private String userPositionNm;
	private String userStateNm;
	private String userTeamNm;
}