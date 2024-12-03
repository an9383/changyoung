<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<header>
	<div class="container-fluid" style="height: 45px;
										background-color: #ffffff;
										border-bottom: 1px solid #777777;
										padding: 0px 5px;">
		<div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
	      	<button type="button" class="btn p-0" id="btnToggleSideNav" style="background-color: #ffffff; color: #000000; border: 1px solid #ffffff;">
				<i class="fa-solid fa-list" style="font-size: 25px;"></i>
			</button>
	        <div class="d-flex align-items-center mb-2 mb-lg-0 text-dark text-decoration-none">
	        	<img class="bi mx-2" src="<c:url value='/resources/assets/images/header_logo.png?ver=3'/>" style="height: 35px; margin: 5px;">
	        </div>
	        <div class="me-lg-auto"></div>
	        <ol class="breadcrumb col-12 col-lg-auto align-items-end mb-2 justify-content-center mb-md-0" style="margin-right: 5px;">
				<li class="breadcrumb-item" id="headerSubName" style="font-size: 13px;"></li>
				<li class="breadcrumb-item" id="headerMainName" style="font-size: 15px; font-weight:900;"></li>
			</ol>
			<div class="btn-group me-2 d-none">
				<button type="button" class="btn btn-secondary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
					언어선택
				</button>
				<ul class="dropdown-menu">
					<li><a class="dropdown-item" href="?lang=ko">한글</a></li>
					<li><a class="dropdown-item" href="?lang=en">English</a></li>
				</ul>
			</div>
			<div class="dropdown text-end">
				<a href="#" class="d-block link-dark text-decoration-none" data-bs-toggle="dropdown" aria-expanded="false">
					<i class="fa-solid fa-gear" style="font-size: 25px;"></i>
				</a>
				<ul class="dropdown-menu text-small">
					<li><a class="dropdown-item" href="#" onClick="window.location.reload()">새로고침</a></li>
					<li><hr class="dropdown-divider"></li>
					<!-- <li><a class="dropdown-item" href="#" id="btnUserInfo">사용자 정보</a></li>
					<li><hr class="dropdown-divider"></li>
					<li><a class="dropdown-item" href="#" id="btnUserPwChange">비밀번호 변경</a></li>
					<li><hr class="dropdown-divider"></li> -->
					<li><a class="dropdown-item" href="#" id="btnLogout">로그아웃</a></li>
				</ul>
			</div>
		</div>
    </div>
</header>
<!-- 사용자정보 -->
<%-- <div class="modal fade" id="userInfoModal" tabindex="-1" aria-hidden="true" style="z-index: 9999;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">
					사용자정보
				</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<table class="table table-bordered p-0 m-0">
					<colgroup>
						<col width="20%">
						<col width="30%">
						<col width="20%">
						<col width="30%">
					</colgroup>
					<tr>
						<th class="text-center align-middle">성명</th>
						<td class="text-center align-middle" id="userInfoName">
						</td>
						<th class="text-center align-middle">아이디</th>
						<td class="text-center align-middle" id="userInfoId">
						</td>
					</tr>
					<tr>
						<th class="text-center align-middle">부서</th>
						<td class="text-center align-middle" id="userInfoDepartmentNm">
						</td>
						<th class="text-center align-middle">직위</th>
						<td class="text-center align-middle" id="userInfoPositionNm">
						</td>
					</tr>
					<tr>
						<th class="text-center align-middle">소속팀</th>
						<td class="text-center align-middle" id="userInfoTeamNm">
						</td>
						<th class="text-center align-middle">담당업무</th>
						<td class="text-center align-middle" id="userInfoJobNm">
						</td>
					</tr>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal" style="width: 70px;">
					닫기
				</button>
			</div>
		</div>
	</div>
</div>
<!-- 비밀번호 변경 -->
<div class="modal fade" id="usePwChangeModal" tabindex="-1" aria-hidden="true" style="z-index: 9999;">
	<div class="modal-dialog" style="max-width: 35vw;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">
					비밀번호 변경
				</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<table class="table table-bordered p-0 m-0">
					<colgroup>
						<col width="20%">
						<col width="40%">
						<col width="40%">
					</colgroup>
					<tr>
						<th class="text-center align-middle">현재 비밀번호</th>
						<td class="text-center align-middle">
							<input type="password" class="form-control inputGroup" id="userCurrentPw" autocomplete="new-password">
						</td>
						<th rowspan="3" class="text-center align-middle"><span style="color: #ff0000;">비밀번호는 문자, 특수문자, 숫자 3가지 포함 8~20자리 입력해야합니다.</span></th>
					</tr>
					<tr>
						<th class="text-center align-middle">변경 비밀번호</th>
						<td class="text-center align-middle">
							<input type="password" class="form-control inputGroup" id="userChangePw" autocomplete="new-password">
						</td>
					</tr>
					<tr>
						<th class="text-center align-middle">변경 비밀번호 확인</th>
						<td class="text-center align-middle">
							<input type="password" class="form-control inputGroup" id="userChangePwCheck" autocomplete="new-password">
						</td>
					</tr>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="userPwChange" style="width: 70px;">
					저장
				</button>
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal" style="width: 70px;">
					닫기
				</button>
			</div>
		</div>
	</div>
</div> --%>

<script>
	//sideNav 버튼 click
	/*$('#btnToggleSideNav').on('click',function() {
		if($('#sideNav').css('display') == 'none') {
			$('#sideBackground').css('width','100vw');
			$('#sideNav').show(300);
		} else {
			$('#sideBackground').css('width','0px');
			$('#sideNav').hide(300);
		}
	});*/ 

	$('#btnToggleSideNav').on('mouseenter',function(){
		if($('#sideNav').css('display') == 'none') {
			$('#sideBackground').css('width','100vw');
			$('#sideNav').show(300);
		} else {
		}
	});

	//사용자정보
	/* $('#btnUserInfo').on('click',function(){
		$.ajax({
			url: '<c:url value="/sm/userSel"/>',
            type: 'POST',
            //async: false,
            data: {
                'idx'	:	"${userIdx}"
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					data = res.data;
					$('#userInfoName').text(data.userName);
					$('#userInfoId').text(data.userId);
					$('#userInfoDepartmentNm').text(data.userDepartmentNm);
					$('#userInfoPositionNm').text(data.userPositionNm);
					$('#userInfoTeamNm').text(data.userTeamNm);
					$('#userInfoJobNm').text(data.userJobNm);
					
					$('#userInfoModal').modal('show');
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
	});

	//비밀번호 변경
	$('#btnUserPwChange').on('click',function(){
		$('#usePwChangeModal').modal('show');
	});
	//비밀번호 변경저장
	$('#userPwChange').on('click',function(){
		let currentPw = $('#userCurrentPw').val();
		let changPw = $('#userChangePw').val();
		let changPwCheck = $('#userChangePwCheck').val();
		
		if(currentPw == ''){
			toastr.warning('현재 비밀번호를 입력해주세요.');
			$('#userCurrentPw').focus();
			return false;
		}
		
		if(changPw == ''){
			toastr.warning('변경 비밀번호를 입력해주세요.');
			$('#userChangePw').focus();
			return false;
		}

		if(changPwCheck == ''){
			toastr.warning('변경 비밀번호 확인을 입력해주세요.');
			$('#userChangePwCheck').focus();
			return false;
		}
		
		if(currentPw != '') { 
			// 정규식 확인 -> (문자, 특수문자, 숫자 3가지 포함 8~50자리 입력)
			let regExp = /^.*(?=^.{8,20}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
			if($('#userChangePw').val().match(regExp) == null) { // 정규식에 맞지 않을 경우
				toastr.warning('비밀번호는 문자, 특수문자, 숫자<br>3가지 포함 8~20자리 입력해야합니다.');
				$('#userChangePw').select();
				return false;
			}

			if(changPw != changPwCheck) {
				toastr.warning('변경할 비밀번호가<br>일치하지않습니다.');
				$('#userPwCheck').select();
				return false;
			}
		}

		$.ajax({
			url: '<c:url value="/sm/userPwUpd"/>',
            type: 'POST',
            //async: false,
            data: {
                'idx'			:	"${userIdx}",
                'userPw'		:	function(){ return currentPw; },
                'userChangePw'	:	function(){ return changPwCheck; },
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					toastr.success('비밀번호 변경되었습니다.');
					$('#usePwChangeModal').modal('hide');
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
		
	}); */
	
	// 로그아웃 버튼 click
	$('#btnLogout').on('click',function() {
		$.ajax({
			url: '<c:url value="/auth/logout"/>',
            type: 'POST',
            data: {},
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					location.href = "/auth/login";
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
	});
</script>