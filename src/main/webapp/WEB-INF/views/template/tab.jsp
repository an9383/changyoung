<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/top.jsp"%>
<%@include file="../layout/script.jsp"%>
<%@include file="../layout/header.jsp"%>
<%@include file="../layout/aside.jsp"%>
<%@include file="../layout/body-top.jsp"%>

<div class="container-fluid p-1">
	<div class="row" style="background-color: #ffffff; height: calc(100vh - 55px);">
		<div class="col-md-12">
			<div class="nav nav-tabs" id="nav-tab">
				<button class="nav-link active" id="tab1Nav" data-bs-toggle="tab" data-bs-target="#tab1">
					<span>레이아웃1</span>
					<span><i class="fa-regular fa-x" onclick="closeTab(this,'tab1');"></i></span>
				</button>
				<button class="nav-link" id="tab2Nav" data-bs-toggle="tab" data-bs-target="#tab2">
					<span>레이아웃2</span>
					<span><i class="fa-regular fa-x" onclick="closeTab(this,'tab2');"></i></span>
				</button>
		  	</div>
			<div class="tab-content" id="nav-tabContent">
				<div class="tab-pane fade show active" id="tab1">
					<iframe class="w-100" style="height: calc(100vh - 90px);"
							src="/bm/bmsc0010"></iframe>
				</div>
				<div class="tab-pane fade" id="tab2">
					<iframe class="w-100" style="height: calc(100vh - 90px);"
							src="/dashboard/main"></iframe>
				</div>
			</div>
		</div>
	</div>
</div>
<script>

	function closeTab(node, id) {
		console.log(node);
		$(node).parent().parent().remove();
		$('#'+id).remove();
	}

</script>
</body>
</html>
