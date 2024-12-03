<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/top.jsp" %>
<%@include file="../layout/script.jsp"%>
<body style="height: 100vh;">
	<div class="text-center" style="align-items: center;
									display: flex;
									padding-top: 3vh;
									padding-bottom: 3vh;
									height: 100%;
									width: 400px;
									margin: auto;
									background-color: rgba(255,255,255,0.3);">
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-md-12 p-0">
					<img src="<c:url value='/resources/assets/images/error_img/error.png'/>" style="width: 50%;">
				</div>
			</div>
			<div class="row">
				<div class="col-md-12 text-center">
					500 error
				</div>
			</div>
		</div>
	</div>
</body>
</html>
