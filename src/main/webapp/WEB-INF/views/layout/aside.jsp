<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<aside>
	<div id="sideBackground" style="position: fixed;
								    width: 0px;
								    height: 100vh;
								    top: 0;
								    margin-top: 45px;
								    z-index: 900;
								    background-color: rgba(0, 0, 0, 0.1);">
		<div class="flex-shrink-0 bg-white nonScrollTable" id="sideNav" style="height: calc(100vh - 45px);
																				width: 300px;
																				z-index: 1000;
																				position: absolute;
																				display: none;
																				overflow: auto;
																				border: 1px solid #dee2e6;
																				background-color: rgba(254,254,254,0.93) !important;">
			<ul class="list-unstyled ps-0" id="favoriteMenuList" style="padding-top: 1rem;
																		background-color: #eeeeee;">
				<li class="mb-1">
					<div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-center">
						<%-- <div class="d-flex align-items-center mb-2 mb-lg-0 text-dark text-decoration-none">
							<img class="bi mx-2" src="<c:url value='/resources/assets/images/header_logo.png'/>"
								style="height: 40px;
										margin: 5px;
									    width: 40px;
									    border: 1px solid #000000;
									    border-radius: 20px;
									    box-shadow: 0 3px 6px rgba(0,0,0,.16),0 3px 6px rgba(0,0,0,.23)!important;">
						</div> --%>
						<div class="d-flex align-items-center mb-2 mb-lg-0" style="	line-height: 18px;
																				    color: #555555;
																				    font-size: 14px;
																				    font-weight: bold;">
							<div>
								<c:out value="${userNm}" />&nbsp;<c:out value="${userPositionNm}" />&nbsp;/&nbsp;<c:out value="${userDepartmentNm}" />
							</div>
						</div>
					</div>
				</li>
				<li class="border-top my-3"></li>
			</ul>
			<ul class="list-unstyled ps-0" id="favoriteMenuList" style="margin-top: 1rem;">
				<li class="mb-1">
					<button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 w-100 fw-bolder"
							data-bs-toggle="collapse" data-bs-target="#favorite-list" aria-expanded="true" style="font-size: 15px !important;">
						즐겨찾기
					</button>
					<div class="collapse show" id="favorite-list">
						<ul class="btn-toggle-nav list-unstyled fw-normal pb-1">
							<c:forEach var="menuAuth" items="${menuAuth}" varStatus="status">
								<c:if test="${menuAuth.favoriteYn == 'Y'}">
									<li id="<c:out value="${menuAuth.menuId}" />-<c:out value="${menuAuth.menuIdDtl}" />"
										data-id="<c:out value="${menuAuth.menuId}" />-<c:out value="${menuAuth.menuIdDtl}" />"
										data-title="<c:out value="${menuAuth.menuNm}" />"
										data-name="<c:out value="${menuAuth.menuNmDtl}" />"
										data-path="<c:out value="${menuAuth.menuPath}" />"
										data-idx="<c:out value="${menuAuth.idx}" />" >
										<a href="#" class="link-dark d-inline-flex text-decoration-none rounded" style="width: calc(100% - 3rem);">
											<c:out value="${menuAuth.menuNmDtl}" />
										</a>
										<div class="d-inline">
											<input type="checkbox"
													class="custom-toggle-star favorite"
													id="<c:out value="${menuAuth.menuId}" />-<c:out value="${menuAuth.menuIdDtl}" />-favM"
													data-type="favorite" checked>
											<label for="<c:out value="${menuAuth.menuId}" />-<c:out value="${menuAuth.menuIdDtl}" />-favM"></label>
										</div>
									</li>
								</c:if>
							</c:forEach>
						</ul>
					</div>
				</li>
				<li class="border-top my-3"></li>
			</ul>
			<ul class="list-unstyled ps-0" id="allMenuList">
				<li class="mb-1">
					<c:forEach var="menuAuthAdm" items="${menuAuth}" varStatus="status">
						<c:if test="${menuAuthAdm.idx == '0'}">
							<button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 w-100 fw-bolder collapsed"
									data-bs-toggle="collapse" data-bs-target="#<c:out value="${menuAuthAdm.menuId}" />-collapse" aria-expanded="false" style="font-size: 15px !important;">
									<c:out value="${menuAuthAdm.menuNm}" />
							</button>
							<div class="collapse" id="<c:out value="${menuAuthAdm.menuId}" />-collapse">
								<ul class="btn-toggle-nav list-unstyled fw-normal pb-1">
									<c:forEach var="menuAuthDtl" items="${menuAuth}" varStatus="statusDtl">
										<c:if test="${menuAuthDtl.idx != '0' && menuAuthDtl.menuId == menuAuthAdm.menuId}">
											<li id="<c:out value="${menuAuthDtl.menuId}" />-<c:out value="${menuAuthDtl.menuIdDtl}" />"
												data-id="<c:out value="${menuAuthDtl.menuId}" />-<c:out value="${menuAuthDtl.menuIdDtl}" />"
												data-title="<c:out value="${menuAuthDtl.menuNm}" />"
												data-name="<c:out value="${menuAuthDtl.menuNmDtl}" />"
												data-path="<c:out value="${menuAuthDtl.menuPath}" />"
												data-idx="<c:out value="${menuAuthDtl.idx}" />" >
												<a href="#" class="link-dark d-inline-flex text-decoration-none rounded" style="width: calc(100% - 3rem);">
													<c:out value="${menuAuthDtl.menuNmDtl}" />
												</a>
												<div class="d-inline">
													<input type="checkbox" class="custom-toggle-star favorite"
															id="<c:out value="${menuAuthDtl.menuId}" />-<c:out value="${menuAuthDtl.menuIdDtl}" />-favS"
															data-type="all"
															<c:if test="${menuAuthDtl.favoriteYn == 'Y'}">
																checked
															</c:if>>
													<label for="<c:out value="${menuAuthDtl.menuId}" />-<c:out value="${menuAuthDtl.menuIdDtl}" />-favS"></label>
												</div>
											</li>
										</c:if>
									</c:forEach>
								</ul>
							</div>
						</c:if>
					</c:forEach>
				</li>
			</ul>
		 </div>
	</div>
</aside>
<script>
	$('#sideBackground').on('click', function(e) {
		if($(e.target).get(0) == $('#sideBackground').get(0)) {
			$('#sideBackground').css('width','0px');
			$('#sideNav').hide(300);
		}
	});

	// 즐겨찾기버튼 click
	$(document).on('click', '.favorite', function() {
		let node = $(this);
		let type = $(node).data('type');
		
		let parent = $(node).parent().parent();
		let parentHtml = $(parent).html();

		let id = $(node).attr('id');
		let menuId = id.split('-')[0]; // ex) sm
		let menuIdDtl = id.split('-')[1]; // ex) smsc0010
		let menuNm = $(parent).data('title');
		let menuNmDtl = $(parent).data('name');
		let idx = $(parent).data('idx');
		if(type == 'favorite') { // 즐겨찾기 목록에 있을 경우
			menuAuthUpd(idx, 'N'); // 메뉴권한 수정
			$(parent).remove();

			$('#allMenuList').find('li #'+menuId+'-collapse ul #'+menuId+'-'+menuIdDtl+' div input').prop('checked',false);
		} else { // 전체메뉴 목록에 있을 경우
			if($(node).prop('checked')) { // 즐겨찾기 추가
				menuAuthUpd(idx, 'Y'); // 메뉴권한 수정
				
				let html = '';
					html += '<li id="'+menuId+'-'+menuIdDtl+'"';
					html += '	data-id="'+menuId+'-'+menuIdDtl+'"';
					html += '	data-title="'+menuNm+'"';
					html += '	data-name="'+menuNmDtl+'" >';
					html += '	<a href="#" class="link-dark d-inline-flex text-decoration-none rounded" style="width: calc(100% - 3rem);">';
					html += '		'+menuNmDtl+'</a>';
					html += '	<div class="d-inline">';
					html += '		<input type="checkbox"';
					html += '				class="custom-toggle-star favorite"';
					html += '				id="'+menuId+'-'+menuIdDtl+'-favM"';
					html += '				data-type="favorite" checked>';
					html += '		<label for="'+menuId+'-'+menuIdDtl+'-favM"></label>';
					html += '	</div>';
					html += '</li>';
				$('#favorite-list ul').append(html);
			} else { // 즐겨찾기 해제
				menuAuthUpd(idx, 'N'); // 메뉴권한 수정
				
				$('#favorite-list ul').find('#'+menuId+'-'+menuIdDtl).remove();
				$(node).prop('checked', false);
			}
		}
	});
	
	// 메뉴권한 수정
	function menuAuthUpd(menuAuthIdx, favoriteYn) {
		$.ajax({
			url: '<c:url value="/sm/menuAuthUpd"/>',
            type: 'POST',
            data: {
                'idx'			:	menuAuthIdx,
                'favoriteYn'	:	favoriteYn,
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if (res.result == "ok") { //응답결과
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
	}
</script>