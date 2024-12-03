<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/top.jsp" %>
<body class="d-none" style="height: 100vh;
							background-image: linear-gradient(rgba(255, 255, 255, 0.3), rgba(255, 255, 255, 0.3)), url(<c:url value='/resources/assets/images/login_background.png?ver=2'/>);
							background-size: auto;
							background-position: 50%;
							background-repeat: no-repeat;">
	<div id="my-spinner">
		<div>
			<span> <img src="<c:url value='/resources/assets/images/spinner.gif'/>">
			</span>
		</div>
	</div>
	<div class="text-center" style="align-items: center;
									display: flex;
									height: 100%;
									width: 400px;
									margin: auto;">
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-md-12 p-0">
					<img src="<c:url value='/resources/assets/images/hygino_logo_slim.png?ver=2'/>" style="width: 50%;">
				</div>
			</div>
			<div class="row">
				<div style="padding-left: 25%; padding-right: 1%; flex: 0 0 auto; width: 58%">
					<input type="text" id="userId" class="form-control" placeholder="ID" style="max-width:100%;
																									background-color: transparent;
																									border: 2px solid #eeeeee;
																									font-size: 0.9em;
																									margin-bottom: 3%;">
					<input type="password" id="userPw" class="form-control" placeholder="PW" style="max-width:100%;
																											background-color: transparent;
																											border: 2px solid #eeeeee;
																											font-size: 0.9em;">
				</div>
				<div class="p-0" style="flex: 0 0 auto; width: 42%">
					<button type="button" class="btn btn-light"  id="btnLogin" style="height: 100%;
																						width: 40%;
																						text-align: left;
																						display: block;
																						box-shadow: 3px 3px 5px 0px #555555;">Login</button>
				</div>
			</div>
		</div>
	</div>
	
    <%@include file="../layout/script.jsp" %>
    <script>
    	console.log(window.location != window.parent.location);
	    if(window.location != window.parent.location) { // tab일 경우엔 error 페이지 전송
	    	$(location).attr('href', '<c:url value="/error/tabError"/>');
	    } else {
		    $('body').removeClass('d-none');
		}
	    
    	// 아이디, 비밀번호 엔터
    	$('#userId, #userPw').on('keypress',function(e) {
        	if(e.which == 13) {
            	$('#btnLogin').trigger('click');
            }
        });
		// 로그인 버튼 click
		$('#btnLogin').on('click',function() {
			const userId = $('#userId').val();
			const userPw = $('#userPw').val();

			if(userId == "") {
				toastr.warning('아이디를 입력해주세요.');
				$('#userId').focus();
				return false;
			}
			if(userPw == "") {
				toastr.warning('비밀번호를 입력해주세요.');
				$('#userPw').focus();
				return false;
			}
			$.ajax({
				url: '<c:url value="/auth/login"/>',
	            type: 'POST',
	            data: {
	            	'userId'	:	userId,
	            	'userPw'	:	userPw,
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if (res.result == "ok") { //응답결과
						$(location).attr('href', '<c:url value="/dashboard/main"/>');
					} else if(res.result == 'fail') {
						toastr.warning(res.message);
					} else {
						toastr.error(res.message);
					}
					$('#my-spinner').hide();
				}
			});
		})
    </script>
</body>
</html>
