<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/top.jsp"%>
<%@include file="../layout/modal.jsp"%>
<%@include file="../layout/script.jsp"%>
<div id="page" onmouseup="EndDrag(this)" onmousemove="OnDrag(event)" style="grid-template-areas: 	'leftcol dragbarH rightcolT'
																									'leftcol dragbarH dragbarVT'
																									'leftcol dragbarH rightcolM'
																									'leftcol dragbarH dragbarVB'
																									'leftcol dragbarH rightcolB';
																		  grid-template-rows: 4fr 4px 4fr 4px 2fr;
																		  grid-template-columns: 7fr 4px 3fr;">
	<div id="leftcol">
	<input type="file" id="fileFake" style="display: none;" value=""
			multiple>
		<div class="container-fluid h-100" style="padding: 5px;">
			<div class="row" id="leftHeader" style="padding-bottom: 5px;">
				<div class="d-flex align-items-center d-flex">
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">수주일</label>
					<input type="date" max="9999-12-31" class="form-control w-auto h-100 me-1" id="startDate">
					<label class="form-label d-flex align-items-center m-0 me-1 h-100">~</label>
					<input type="date" max="9999-12-31" class="form-control w-auto h-100 me-1" id="endDate">
					<select class="form-select w-auto h-100 me-1 monthAdjust" id="monthAdjust">
					</select>
					<div class="btn-group me-3" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto monthAdjustBtn" data-val="3">
							3개월
						</button>
						<button type="button" class="btn btn-outline-light w-auto monthAdjustBtn" data-val="6">
							6개월
						</button>
						<button type="button" class="btn btn-outline-light w-auto monthAdjustBtn" data-val="12">
							12개월
						</button>
					</div>
					
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">조회대상</label>
					<select class="form-select w-auto h-100 me-3" id="searchTarget" style="min-width: 70px;">
						<option value="">전체</option>
						<option value="N" selected>지시대상</option>
					</select>
					<input type="text" class="form-control w-auto h-100 me-1" id="searchAllPot" placeholder="통합검색" >
				</div>
				<div class="me-lg-auto"></div>
				<div class="btn-group" role="group" aria-label="Small button group">
					<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnSearch">
						<i class="fa-regular fa-clipboard"></i>
					</button>
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnSave">
						<i class="fa-regular fa-floppy-disk"></i>
					</button>
					<!-- <button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnEdit">
						<i class="fa-regular fa-pen-to-square"></i>
					</button> -->
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnCancel" disabled>
						<i class="fa-solid fa-xmark"></i>
					</button>
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnOpen">
						<i class="fa-solid fa-caret-left"></i>
					</button>
				</div>
			</div>
			
			<div class="row">
				<table class="table table-bordered p-0 m-0" id="purchaseOrderTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle"><input type="checkbox" id="btnAllCheck" style="width:20px; height:20px;"></th>
							<th class="text-center align-middle">수주상태</th>
							<th class="text-center align-middle">디자인<br>컨펌</th>
							<th class="text-center align-middle">발주<br>확정</th>
							<th class="text-center align-middle">지시상태</th>
							<!-- <th class="text-center align-middle">생산상태</th>
							<th class="text-center align-middle">지시일</th> -->
							<th class="text-center align-middle">목표요구일</th>
							<th class="text-center align-middle">출고요구일</th>
							<th class="text-center align-middle">수주상세번호</th>
							<th class="text-center align-middle">수주처</th>
							<th class="text-center align-middle" style="min-width:100px;">제품명</th>
							<th class="text-center align-middle">자재코드</th>
							<th class="text-center align-middle">버전</th>
							<th class="text-center align-middle">장*폭</th>
							<th class="text-center align-middle">수주수량</th>
							<th class="text-center align-middle">재고사용수량</th>
							<th class="text-center align-middle">지시수량</th>
							<th class="text-center align-middle">미지시수량</th>
							<th class="text-center align-middle">지시비고사항</th>
							<th class="text-center align-middle">특이사항</th>
							<th class="text-center align-middle">건별전달사항</th>
							<th class="text-center align-middle">수주비고</th>
							<th class="text-center align-middle">수지판번호</th>
							<th class="text-center align-middle">현재고</th> 
						</tr>
					</thead>
					<tfoot id="purchaseOrderTableTfoot">
						<tr>
							<th colspan="13">TOTAL</th>
							<th id="footOrdQty">수주수량</th>
							<th colspan="1"></th>
							<th id="footWorkQty">지시수량</th>
							<th id="footNotWorkQty">미지시수량</th>
							<th colspan="6"></th>
						</tr>
					</tfoot>
				</table>
			</div>
		</div>
	</div>
	<div id="dragbarH" onmousedown="StartDrag('H')"></div>	
	<div id="rightcolT" style="overflow : hidden;">
		<div class="container-fluid h-100" style="padding: 5px;">
			<div class="row" id="rightBody">
				<div style="width: 100%;">
					<div class="nav nav-tabs" id="nav-tab">
						<button class="nav-link active" id="tab1Nav" data-bs-toggle="tab" data-bs-target="#tab1">지시내역</button>
						<!-- <button class="nav-link" id="tab2Nav" data-bs-toggle="tab" data-bs-target="#tab2">세부정보</button> -->
				  	</div>
					<div class="tab-content" id="nav-tabContent">
						<div class="tab-pane fade show active" id="tab1">
							<div class="row" style="padding: 5px;">
								<div class="d-flex align-items-center justify-content-end w-100" style="margin-bottom:5px;">
									<input type="text" class="form-control w-auto h-100 me-1" id="searchAllWod" placeholder="통합검색" >
									<div class="btn-group" role="group" aria-label="Small button group">
										<button type="button" class="btn btn-outline-danger w-auto" style="font-size: 17px !important;" id="btnWorkOrdDtlDel" disabled>
											<i class="fa-solid fa-trash-can"></i>
										</button>								
										<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnWorkOrdDtlCancel" disabled>
											<i class="fa-solid fa-xmark"></i>
										</button>
										<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnClose">
											<i class="fa-solid fa-caret-right"></i>
										</button>
									</div>
								</div>
								<table class="table table-bordered p-0 m-0 " id="workOrdDtlTable">
									<thead class="table-light">
										<tr>
											<th class="text-center align-middle" style="vertical-align: middle;">지시상태</th>
											<th class="text-center align-middle" style="vertical-align: middle;">지시일</th>
											<th class="text-center align-middle" style="vertical-align: middle;">목표요구일</th>
											<th class="text-center align-middle" style="vertical-align: middle;">출고요구일</th>
											<th class="text-center align-middle" style="vertical-align: middle;">지시량</th>
											<th class="text-center align-middle" style="vertical-align: middle;">출력여부</th>
										</tr>
									</thead>
								</table>
							</div>
						</div>				
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="dragbarVT" onmousedown="StartDrag('VT')" ondblclick="minimum(this)"></div>
	<div id="rightcolM" style="overflow : hidden;">
		<div class="container-fluid" style="padding: 5px;">
			<div class="row">
				<div style="width: 100%;">
					<div class="nav nav-tabs" id="nav-tab2">
						<button class="nav-link active" id="tab3Nav" data-bs-toggle="tab" data-bs-target="#tab3">생산공정내역</button>
				  	</div>
					<div class="tab-content" id="nav-tabContent2">
						<div class="tab-pane fade show active" id="tab3">
							<div class="row" style="padding: 5px;">
								<div class="d-flex align-items-center justify-content-end w-100" style="margin-bottom:5px;">
									<input type="text" class="form-control w-auto h-100 me-1" id="searchAllWpd" placeholder="통합검색" >
									<div class="btn-group" role="group" aria-label="Small button group">
										<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnProcessNew" disabled>
											<i class="fa-solid fa-plus"></i>
										</button>											
										<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnProcessSave" disabled>
											<i class="fa-regular fa-floppy-disk"></i>
										</button>
										<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnProcessEdit" disabled>
											<i class="fa-regular fa-pen-to-square"></i>
										</button>					
										<button type="button" class="btn btn-outline-danger w-auto" style="font-size: 17px !important;" id="btnProcessDel" disabled>
											<i class="fa-solid fa-trash-can"></i>
										</button>								
										<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnProcessCancel" disabled>
											<i class="fa-solid fa-xmark"></i>
										</button>
									</div>
								</div>
								<table class="table table-bordered p-0 m-0 " id="workPrcssDtlTable">
									<thead class="table-light">
										<tr>
											<th class="text-center align-middle" style="vertical-align: middle;">순번</th>
											<th class="text-center align-middle" style="vertical-align: middle;">진행상태</th>
											<th class="text-center align-middle" style="vertical-align: middle;">공정명</th>
											<th class="text-center align-middle" style="vertical-align: middle;">작업지시단위</th>
											<th class="text-center align-middle" style="vertical-align: middle;min-width:80px;max-width:80px;width:80px;">작업지시량</th>
											<th class="text-center align-middle" style="vertical-align: middle;min-width:80px;max-width:80px;width:80px;">작업수량</th>
											<th class="text-center align-middle" style="vertical-align: middle;min-width:80px;max-width:80px;width:80px;">추가재단</th>
											<th class="text-center align-middle" style="vertical-align: middle;">작업방법</th>
										</tr>
									</thead>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="dragbarVB" onmousedown="StartDrag('VB')" ondblclick="minimum(this)"></div>
	<div id="rightcolB" style="overflow : hidden;">
		<div class="container-fluid" style="padding: 5px;">
			<div class="row">
				<div style="width: 100%;">
					<div class="nav nav-tabs" id="nav-tab2">
						<button class="nav-link active" id="tab5Nav" data-bs-toggle="tab" data-bs-target="#tab5">투입자재내역</button>
				  	</div>
					<div class="tab-content" id="nav-tabContent2">
						<div class="tab-pane fade show active" id="tab5">
							<div class="row" style="padding: 5px;">
								<div class="d-flex align-items-center d-flex">
									<input type="text" class="form-control w-auto h-100 me-1" id="searchAllImh" placeholder="통합검색" >
								</div>
								<table class="table table-bordered p-0 m-0" id="inputMaterialHistTable">
									<thead class="table-light">
										<tr>
											<th class="text-center align-middle">재질</th>
											<th class="text-center align-middle">가로*세로</th>
											<th class="text-center align-middle">절수/개수</th>
											<th class="text-center align-middle">발주량+여분</th>
											<th class="text-center align-middle">입고량</th>
										</tr>
									</thead>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 거래처 모달 -->
<div class="modal fade" id="dealCorpSelectModal" tabindex="-1" aria-hidden="true" style="z-index: 9999;">
	<div class="modal-dialog" style="max-width: 60vw;">
		<div class="modal-content" style="height: calc(100vh - 5em);">
			<div class="modal-header">
				<h5 class="modal-title">
					발주처 조회
				</h5>
				<div class="btn-group" role="group" aria-label="Small button group">
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnDealCorpSelectModalPaste">
						<i class="fa-regular fa-paste"></i>
					</button>
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" data-bs-dismiss="modal" aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>
			</div>
			<div class="modal-body">
				<div class="row" style="padding-bottom: 5px;">
					<div class="d-flex align-items-center d-flex">
						<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">자재 발주처 조회</label>
						<select class="form-select w-auto h-100 me-3" id="dealCorpSelectGubun" style="min-width: 70px;">
							<option value="matrlCorp">등록된 발주처</option>
							<option value="all">모든 발주처</option>
						</select>
					</div>
					<div class="me-lg-auto"></div>
					<div class="d-flex align-items-center justify-content-end">
						<div class="btn-group" role="group" aria-label="Small button group">
							<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnDealCorpSelectSearch"><i class="fa-regular fa-clipboard"></i></button>
						</div>
					</div>
				</div>
				<table class="table table-bordered p-0 m-0" id="dealCorpSelectModalTable">
					<thead class="table-light">
						<tr>
							<th class="text-center">거래처코드</th>
							<th class="text-center">업체명</th>
							<th class="text-center">대표자</th>
							<th class="text-center">사업자번호</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>
<!-- 거래처 모달 끝 -->

<!-- 설비 모달 -->
<div class="modal fade" id="prcssEquipModal" tabindex="-1" aria-hidden="true" style="z-index: 9999;">
	<div class="modal-dialog" style="max-width: 60vw;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="prcssEquipModalTitle">
					공정 설비 조회
				</h5>
				<div class="btn-group" role="group" aria-label="Small button group">
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnPrcssEquipModalPaste">
						<i class="fa-regular fa-paste"></i>
					</button>
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" data-bs-dismiss="modal" aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>
			</div>
			<div class="modal-body">
				<div class="row" style="padding-bottom: 5px;">
					<div class="d-flex align-items-center d-flex">
						<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">설비 조회</label>
						<select class="form-select w-auto h-100 me-3" id="prcssEquipSelectGubun" style="min-width: 70px;">
							<option value="prcssEquip">등록된 설비</option>
							<option value="all">모든 설비</option>
						</select>
					</div>
					<div class="me-lg-auto"></div>
					<div class="d-flex align-items-center justify-content-end">
						<div class="btn-group" role="group" aria-label="Small button group">
							<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnPrcssEquipSearch"><i class="fa-regular fa-clipboard"></i></button>
						</div>
					</div>
				</div>
				<table class="table table-bordered p-0 m-0" id="prcssEquipModalTable">
					<thead class="table-light">
						<tr>
							<th class="text-center">설비코드</th>
							<th class="text-center">설비명</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>
<!-- 설비 모달 끝 -->

<!-- 복사 모달 -->
<div class="modal fade" id="copyModal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog" style="max-width: 95vw;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">
					복사
				</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<table class="table table-bordered p-0 m-0" id="itemInfoModalTable">
					<thead class="table-light">
						<tr>
							<th class="text-center">고객사</th>
							<th class="text-center">제품코드</th>
							<th class="text-center">제품명</th>
							<th class="text-center">칼끝규격</th>
							<th class="text-center">버전번호</th>
							<th class="text-center">고객사제품코드</th>
							<th class="text-center">별색</th>
							<th class="text-center">품목구분</th>
							<th class="text-center">사용여부</th>
							<th class="text-center">사이즈</th>
							<th class="text-center">목형관리번호</th>
							<th class="text-center">수지판</th>
							<th class="text-center">타공목형번호</th>
							<th class="text-center">현재고량</th>
							<th class="text-center">도수</th>
							<th class="text-center">묶음법</th>
							<th class="text-center">포장방법</th>
							<th class="text-center">작업인쇄기</th>
							<th class="text-center">명인원지</th>
							<th class="text-center">관리번호</th>
							<th class="text-center">검수방법</th>
							<th class="text-center">큰판작은판</th>
							<th class="text-center">묶음단위</th>
							<th class="text-center">포장단위</th>
							<th class="text-center">일자</th>
							<th class="text-center">원판수량</th>
							<th class="text-center">면방</th>
							<th class="text-center">착인여부점검</th>
							<th class="text-center">기타1</th>
						</tr>
					</thead>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="copyApply">적용</button>
				<button type="button" class="btn btn-primary" id="copyCancel">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 복사 모달 끝 -->

<!-- 화면설정 script -->
<script>
	let isDraggingVT = false; // 세로 드레그 여부
	let isDraggingVB = false; // 세로 드레그 여부
	let isDraggingH = false; // 가로 드레그 여부
	
	function SetCursor(cursor) {
		let page = document.getElementById("page");
		page.style.cursor = cursor;
	}
	
	function StartDrag(type) {
		if(type == 'VT') { isDraggingVT = true; SetCursor("n-resize");}
		if(type == 'VB') { isDraggingVB = true; SetCursor("n-resize");}
		if(type == 'H') { isDraggingH = true; SetCursor("ew-resize");}
	}
	
	function EndDrag(e) {
		if(isDraggingVT || isDraggingVB || isDraggingH) {
			dataTableDrawAll(); // dataTable 전체 reload
			isDraggingVT = false;
			isDraggingVB = false;
			isDraggingH = false;
			SetCursor("auto");
		}
	}

	function minimum(node) {
		let id = $(node).attr('id');

		if(id == 'dragbarVT') {
			let dragbarWidth = 4;

			let page_height = parseInt($('#page').height()); 			// 전체 높이
			let rightcolT_height = parseInt($('#rightcolT').height());	// 우측 상단
			let rightcolM_height = parseInt($('#rightcolM').height());	// 우측 중단
			let rightcolB_height = parseInt($('#rightcolB').height());	// 우측 하단

			let rightcolT_min_height = 100;	// 우측 상단 최소높이
			let rightcolM_min_height = 34;	// 우측 중단 최소높이
			let rightcolB_min_height = 34;	// 우측 하단 최소높이

			let dragbarV_height = 4;

			let cols = [];

			//최소화기능만 적용
			cols = [
				page_height - rightcolB_height - rightcolM_min_height - dragbarWidth*2,
				dragbarWidth,
				rightcolM_min_height,
				dragbarWidth,
				rightcolB_height
			];
		
			/* if(rightcolM_height == rightcolM_min_height) { // 원위치
				cols = [
					rightcolT_min_height,
					dragbarWidth,
					page_height - dragbarWidth*2 - rightcolB_height - rightcolT_min_height,
					dragbarWidth,
					rightcolB_height
				];
			} else { // 최소화
				cols = [
					page_height - rightcolB_height - rightcolM_min_height - dragbarWidth*2,
					dragbarWidth,
					rightcolM_min_height,
					dragbarWidth,
					rightcolB_height
				];
			} */
			
			
			let newColDefn = cols.map(c => c.toString() + "px").join(" ");
			
			$('#page').css('grid-template-rows',newColDefn);
		} else if(id == 'dragbarVB') {
			let dragbarWidth = 4;

			let page_height = parseInt($('#page').height()); 			// 전체 높이
			let rightcolT_height = parseInt($('#rightcolT').height());	// 우측 상단
			let rightcolM_height = parseInt($('#rightcolM').height());	// 우측 중단
			let rightcolB_height = parseInt($('#rightcolB').height());	// 우측 하단

			let rightcolT_min_height = 100;	// 우측 상단 최소높이
			let rightcolM_min_height = 34;	// 우측 중단 최소높이
			let rightcolB_min_height = 34;	// 우측 하단 최소높이

			let dragbarV_height = 4;

			let cols = [];

			cols = [
				rightcolT_height,
				dragbarWidth,
				page_height - rightcolT_height - rightcolB_min_height - dragbarWidth*2,
				dragbarWidth,
				rightcolB_min_height
			];
			
			/* if(rightcolB_height == rightcolB_min_height) { // 원위치
				cols = [
					rightcolT_height,
					dragbarWidth,
					rightcolM_min_height,
					dragbarWidth,
					page_height - rightcolT_height - rightcolM_min_height - dragbarWidth*2
				];
			} else { // 최소화
				cols = [
					rightcolT_height,
					dragbarWidth,
					page_height - rightcolT_height - rightcolB_min_height - dragbarWidth*2,
					dragbarWidth,
					rightcolB_min_height
				];
			} */
			
			
			let newColDefn = cols.map(c => c.toString() + "px").join(" ");
			
			$('#page').css('grid-template-rows',newColDefn);
		}

		dataTableDrawAll(); // dataTable 전체 reload
	}
	
	function OnDrag(event) {
		if (isDraggingH) { // 좌우 스크롤
			let page = document.getElementById("page");
			let leftcol = document.getElementById("leftcol"); // 좌측
			let rightcolT = document.getElementById("rightcolT"); // 우측 상단
			let rightcolM = document.getElementById("rightcolM"); // 우측 중단
			let rightcolB = document.getElementById("rightcolB"); // 우측 하단
			let dragbarWidth = 4;
			let leftcolMinWidth = 20; // leftcol 최소사이즈
			$('#leftHeader').children().each(function(index, item) {
				leftcolMinWidth += $(item).width();
			});
			let rightcolMinWidth = 500; // rightcol 최소사이즈
	
			let rightColWidth = page.clientWidth - parseInt(Math.max(leftcolMinWidth + 120, event.clientX));
			
			let cols = [
				parseInt(Math.max(leftcolMinWidth, page.clientWidth - dragbarWidth - parseInt(Math.max(rightColWidth, rightcolMinWidth)))),
				dragbarWidth,
				parseInt(Math.max(rightColWidth, rightcolMinWidth))
			];
	
			let newColDefn = cols.map(c => c.toString() + "px").join(" ");
			console.log(newColDefn);
	
			page.style.gridTemplateColumns = newColDefn;
	
			event.preventDefault();
		} else if (isDraggingVT) { // rightcolT와 rightcolM 사이
			let dragbarWidth = 4;

			let page_height = parseInt($('#page').height()); 			// 전체 높이
			let rightcolT_height = parseInt($('#rightcolT').height());	// 우측 상단
			let rightcolM_height = parseInt($('#rightcolM').height());	// 우측 중단
			let rightcolB_height = parseInt($('#rightcolB').height());	// 우측 하단

			let rightcolT_min_height = 100;	// 우측 상단 최소높이
			let rightcolM_min_height = 34;	// 우측 중단 최소높이
			let rightcolB_min_height = 34;	// 우측 하단 최소높이

			let cursorY = event.clientY;	// 현재 cursor y좌표(위에서부터 얼마나 떨어졌는지)

			console.log(page_height - rightcolB_height - rightcolM_min_height - dragbarWidth*2);
			
			let cols = [
				Math.min(Math.max(rightcolT_min_height, cursorY), page_height - rightcolB_height - rightcolM_min_height - dragbarWidth*2),
				dragbarWidth,
				page_height - rightcolB_height - dragbarWidth*2 - Math.min(Math.max(rightcolT_min_height, cursorY), page_height - rightcolB_height - rightcolM_min_height - dragbarWidth*2),
				dragbarWidth,
				rightcolB_height
			];

			console.log(cols);
	
			let newColDefn = cols.map(c => c.toString() + "px").join(" ");

			$('#page').css('grid-template-rows',newColDefn);
	
			event.preventDefault();
		} else if (isDraggingVB) { // 상하 스크롤
			let dragbarWidth = 4;

			let page_height = parseInt($('#page').height()); 			// 전체 높이
			let rightcolT_height = parseInt($('#rightcolT').height());	// 우측 상단
			let rightcolM_height = parseInt($('#rightcolM').height());	// 우측 중단
			let rightcolB_height = parseInt($('#rightcolB').height());	// 우측 하단

			let rightcolT_min_height = 100;	// 우측 상단 최소높이
			let rightcolM_min_height = 34;	// 우측 중단 최소높이
			let rightcolB_min_height = 34;	// 우측 하단 최소높이

			let cursorY = event.clientY;	// 현재 cursor y좌표(위에서부터 얼마나 떨어졌는지)
			
			let cols = [
				rightcolT_height,
				dragbarWidth,
				Math.min(Math.max(cursorY - rightcolT_height - dragbarWidth, rightcolM_min_height), page_height - rightcolT_height - dragbarWidth*2 - rightcolB_min_height),
				dragbarWidth,
				Math.max(rightcolB_min_height, page_height - rightcolT_height - dragbarWidth*2 - Math.max(cursorY - rightcolT_height - dragbarWidth, rightcolM_min_height))
			];
	
			let newColDefn = cols.map(c => c.toString() + "px").join(" ");
	
			$('#page').css('grid-template-rows',newColDefn);
	
			event.preventDefault();
		}
	}

	$('#btnOpen').on('click',function() { // right-box 열기버튼 클릭
		if($('#rightcolT').hasClass('d-none')){
			$('#page').css('grid-template-columns', '4fr 4px 2fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcolT').removeClass('d-none');
		} else {
			$('#page').css('grid-template-columns', '0fr 4px 2fr');
			$('#leftcol').addClass('d-none');
			$('#rightcolT').removeClass('d-none');
		}
		dataTableDrawAll(); // dataTable 전체 reload
	});
	$('#btnClose').on('click',function() { // right-box 닫기버튼 클릭
		if($('#leftcol').hasClass('d-none')){
			$('#page').css('grid-template-columns', '4fr 4px 2fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcolT').removeClass('d-none');
		} else {
			$('#page').css('grid-template-columns', '4fr 4px 0fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcolT').addClass('d-none');
		}
		dataTableDrawAll(); // dataTable 전체 reload
	});
</script>

<script>
	WM_init('new');
	WM_init('edit');
	WM_init('prcssNew');

	let monthAdjustList = getCommonCode('시스템', '026'); //날짜조정
	monthAdjustList = _.sortBy(monthAdjustList, v=>parseInt(v.commonCd));
	selectBoxAppend(monthAdjustList, 'monthAdjust', '', '2'); //날짜조정
	
	// 공통코드 조회
	let ordStatusList = getCommonCode('시스템', '022'); // 수주상태
	let itemGubunList = getCommonCode('일반', '001'); // 제품구분
	let woodenList = getCommonCode('일반', '004'); // 목형번호
	let bundleList = getCommonCode('일반', '005'); // 묶음코드
	let printingYnCheckList = getCommonCode('일반', '008'); // 착인여부점검
	let inspectMethodList = getCommonCode('일반', '009'); // 검수방법
	let packMethodList = getCommonCode('일반', '013'); // 포장방법
	let outsrcGubunList = getCommonCode('일반', '024'); // 외주구분
	//let wdGubunList = getCommonCode('일반', '025'); // 소모품구분
	
	selectBoxAppend(itemGubunList, 'itemGubun', '', '2'); //포장방법
	selectBoxAppend(woodenList, 'woodenCareCd', '', '2'); //목형관리번호
	selectBoxAppend(bundleList, 'bundleMethod', '', '2'); //묶음법
	selectBoxAppend(printingYnCheckList, 'printingYnCheck', '', '2'); //착인여부점검
	selectBoxAppend(inspectMethodList, 'inspectMethod', '', '2'); //검수방법
	selectBoxAppend(packMethodList, 'packMethod', '', '2'); //포장방법
	
	let sessionUserNm = "${userNm}";//세션에서 가져온 유저이름
	let delStatus = '';

	let selectPeriod = parseInt(getCommonCode('시스템', '040')[0].commonCd); //기본조회기간 일
	let startDate = moment().subtract('d',selectPeriod).format('YYYY-MM-DD').replaceAll('-','');
	let endDate = moment().format('YYYY-MM-DD');
	
	$('#startDate').val(moment().subtract('d',selectPeriod).format('YYYY-MM-DD'));
	$('#endDate').val(moment().format('YYYY-MM-DD'));
	
	//날짜
	let today = new Date();   
	let year = today.getFullYear(); // 년도
	let month = ( '0' + (today.getMonth() + 1) ).slice(-2) ;  // 월
	let date = ('0' + today.getDate()).slice(-2);  // 날짜
	let todayVal = year + '-' + month + '-' + date; // 오늘날짜 YYYY-MM-DD형태
	$('#priceDate').val(moment().format('YYYY-MM-DD'));
	
	// 작업중 경고 모달 예 버튼 click
	$('#btnWorkingWarningModalY').on('click', function() {
		if(WMlastIdx == 'prcssNew'){ //공정 등록중이었을 때
			$('#btnProcessSave').trigger('click');
			return false;
		} 
	});

	// 작업중 경고 모달 아니요 버튼 click
	$('#btnWorkingWarningModalN').on('click', function() {
		if(WMlastIdx == 'prcssNew'){ //공정 등록중이었을 때 
			if(getWM(WMlastIdx, 'idx') != '' && getWM(WMlastIdx, 'idx') != undefined) {
				let idx = getWM(WMlastIdx, 'idx');
				let tableGubun = getWM(WMlastIdx, 'tableGubun');
				WM_action_OFF('prcssNew');
				setWM(WMlastIdx, 'idx', '');
				tableGubun.row('#'+idx).select();
				$(tableGubun.row('#'+idx).node()).trigger('click'); // 선택했던 항목 선택처리
			} else {
				WM_action_OFF('prcssNew');
				if(window.location != window.parent.location) { // tab일 경우
					// 부모 탭 닫기버튼 click
					$('#tab-list', parent.document).find('.active').find('span').eq(1).find('i').trigger('click');
			    }				
				$('.inputGroup').attr('disabled', true); // 입력항목
				//지시내역
				$('#btnWorkOrdDtlDel').attr('disabled',true);				
				//생산공정내역
				$('#btnProcessNew').attr('disabled',true);
				$('#btnProcessSave').attr('disabled',true);
				$('#btnProcessEdit').attr('disabled',true);
				$('#btnProcessDel').attr('disabled',true);
				$('#btnProcessCancel').attr('disabled',true);
							
				
			}
		}
	});

	// 삭제 경고창 삭제 버튼 click
	$('#btnDeleteModalY').on('click', function() {
		let deleteType = $('#deleteModal').data('deleteType');
		//지시내역삭제
		if(deleteType == 'workOrdDtl'){
			let idx = workOrdDtlTable.row('.selected').data().idx;
			$.ajax({
				url: '<c:url value="/wm/workOrdDel"/>',
	            type: 'POST',
	            data: {
	                'workOrdIdx'	:	function(){ return idx; }
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if(res.result == 'ok'){
						toastr.success('삭제되었습니다.');
						//수주목록에서 미지시수량 새로고침하고 선택한 행 다시 선택되게
						let idx = purchaseOrderTable.row('.selected').data().bodIdx;
						purchaseOrderTable.rows('.selected').deselect();
						purchaseOrderTable.ajax.reload(function(){
							purchaseOrderTable.row('#'+idx).select();
							$(purchaseOrderTable.row('#'+idx).node()).trigger('click'); // 선택했던 항목 선택처리
						});
					} else if(res.result == 'fail') {
						toastr.warning(res.message);
					} else {
						toastr.error(res.message);
					}
					$('#my-spinner').hide();
				}
			});
		} else if(deleteType == 'workPrcssDtl'){//생산 공정내역
			let idx = workPrcssDtlTable.row('.selected').data().idx;
			$.ajax({
				url: '<c:url value="/wm/workOrdPrcssDel"/>',
	            type: 'POST',
	            data: {
	                'idx'	:	function(){ return idx; }
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if(res.result == 'ok'){
						if(res.data.resultYn == 'Y'){
							toastr.success('삭제되었습니다.');
							workPrcssDtlTable.row('.selected').remove().draw(false);
						} else {
							toastr.warning('진행이 된 공정은 삭제가 불가능합니다.');
							workPrcssDtlTable.ajax.reload(function(){
								/* $('#workPrcssDtlTable tbody tr').each(function(index){
									let node = workPrcssDtlTable.row(index).node();
									if(workPrcssDtlTable.row(index).data() != undefined && workPrcssDtlTable.row(index).data() != ''){
										let multipleNode = $(node).find('td').eq(7).find('select[name=workMethodMultiSelect]');
										$(multipleNode).select2({
								    		data: JSON.parse(workPrcssDtlTable.row(index).data().workMethodJson),
								    		multiple : true,
								    		placeholder: "작업방법 선택",
								    	});
										$(node).find('td').eq(7).find('span').eq(0).css('width','100%');
								    	$(node).find('td').eq(7).find('.select2-search__field').css('width','100%');
								    	$(node).find('td').eq(7).find('.select2-selection__rendered').attr('style','display:flex; align-content:flex-start; flex-direction:column; flex-wrap:wrap; overflow:auto;');
								    	
										if( workPrcssDtlTable.row(index).data().workMethod != null && workPrcssDtlTable.row(index).data().workMethod != ''){
											let splitData =  workPrcssDtlTable.row(index).data().workMethod.split(',');
											$(node).find('td').eq(7).find('select[name=workMethodMultiSelect]').val(splitData).trigger('change')
										}
										
										$(node).find('td').eq(7).find('select[name=workMethodMultiSelect]').attr('disabled',true);
									}

									$(node).find('td').find('input[name=ordQty]').attr('disabled',true);
									$(node).find('td').find('input[name=addCutting]').attr('disabled',true);
									$(node).find('td').find('select[name=outsrcGubun]').attr('disabled',true);
									$(node).find('td').find('select[name=workMethodMultiSelect]').attr('disabled',true);
									
								}); */
				
								$('#my-spinner').hide();
								setTimeout(function() {
									workPrcssDtlTable.draw(false);
								},100);
							});
						}
						
					} else if(res.result == 'fail') {
						toastr.warning(res.message);
					} else {
						toastr.error(res.message);
					}
					$('#my-spinner').hide();
				}
			});
		}
	});

	//취소버튼 모음집
	$('#btnProcessCancel').on('click', function() {
		//CancelIdx = 'prcssNew';
		$('#deleteModal').data('cancelType','prcssNew');
		$('#cancelModal').modal('show');
	});
	
	// 취소 경고창 취소 버튼 click
	$('#btnCancelModalY').on('click', function() {
		toastr.success('취소되었습니다.');
		let cancelType = $('#deleteModal').data('cancelType');
		if(cancelType == 'prcssNew'){
			WM_action_OFF('prcssNew');
			workPrcssDtlTable.ajax.reload(function(){
				$('select[name=outsrcGubun]').attr('disabled',true);
				/* $('#workPrcssDtlTable tbody tr').each(function(index){
					let node = workPrcssDtlTable.row(index).node();
					if(workPrcssDtlTable.row(index).data() != undefined && workPrcssDtlTable.row(index).data() != ''){
						let prcssIdx = workPrcssDtlTable.row(index).data().prcssIdx;
						let multipleNode = $(node).find('td').eq(7).find('select[name=workMethodMultiSelect]');
						$(multipleNode).select2({
				    		data: JSON.parse(workPrcssDtlTable.row(index).data().workMethodJson),
				    		multiple : true,
				    		placeholder: "작업방법 선택",
				    	});
						$(node).find('td').eq(7).find('span').eq(0).css('width','100%');
				    	$(node).find('td').eq(7).find('.select2-search__field').css('width','100%');
				    	$(node).find('td').eq(7).find('.select2-selection__rendered').attr('style','display:flex; align-content:flex-start; flex-direction:column; flex-wrap:wrap; overflow:auto;');
						if( workPrcssDtlTable.row(index).data().workMethod != null && workPrcssDtlTable.row(index).data().workMethod != ''){
							let splitData =  workPrcssDtlTable.row(index).data().workMethod.split(',');
							$(node).find('td').eq(7).find('select[name=workMethodMultiSelect]').val(splitData).trigger('change')
						}
						$(node).find('td').eq(7).find('select[name=workMethodMultiSelect]').attr('disabled',true);
					}
				});*/
				$('#my-spinner').hide();
				setTimeout(function() {
					workPrcssDtlTable.draw(false);
				},100);
			});
			$('#btnProcessNew').attr('disabled', false);
			$('#btnProcessSave').attr('disabled', true);
			$('#btnProcessEdit').attr('disabled', false);
			$('#btnProcessDel').attr('disabled', false);
			$('#btnProcessCancel').attr('disabled', true);
		} 
	});




	
	/**************************************************************수주목록**************************************************************/
	// 수주 목록조회
	$('#purchaseOrderTable thead tr').clone(true).addClass('filters').appendTo('#purchaseOrderTable thead'); // filter 생성
	let purchaseOrderTable = $('#purchaseOrderTable').DataTable({
		dom : "<'row'<'col-md-12 col-md-6'l><'col-md-12 col-md-6'f>>"
				+ "<'row'<'col-md-12'tr>>"
				+ "<'row pt-1'<'d-flex align-items-center d-flex'Bp><'me-lg-auto'><'d-flex align-items-center justify-content-end'i>>",
		language: lang_kor,
		info: true,
		ordering: true,
		processing: true,
		paging: false,
		lengthChange: false,
		searching: true,
		autoWidth: false,
		orderCellsTop: true,
        fixedHeader: false,
        scrollY: '100vh',
        scrollX: true,
		pageLength: 100000000,
		colReorder: false,
		select: {
            style: 'single',
            toggleable: false,
            items: 'row',
            info: false
        },
        ajax : {
			url : '<c:url value="/wm/purchaseOrdLst"/>',
			type : 'POST',
			data : {
				'searchTarget' : function(){ return $('#searchTarget').val();},
				'startDate' : function(){return startDate;},
				'endDate'	: function(){return endDate;}
			},
		}, 
        rowId: 'bodIdx',
		columns : [
			{ className : 'text-center  align-middle',
				render: function(data, type, row, meta) {
					let ordQty = row['ordQty'] != null && row['ordQty'] != '' ? row['ordQty'] : 0;
					let workQty = row['workQty'] != null && row['workQty'] != '' ? row['workQty'] : 0;
					if(row['confirmDesign'] == 'Y' && row['purchaseChkYn'] == 'Y' && row['bizStatusCd'] == '02' ) {
						if(parseFloat(ordQty)-parseFloat(workQty) > 0){
							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;"><input type="checkbox" name="btnCheck" style="width:20px; height:20px;"></div>';
						} else {
							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;"><input disabled type="checkbox" name="btnCheckNot" style="width:20px; height:20px;"></div>';
						}
					} else {
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;"><input disabled type="checkbox" name="btnCheckNot" style="width:20px; height:20px;"></div>';
					}
				}
			},
			{ data: 'bizStatusCd', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return _.filter(ordStatusList,v=>v.commonCd == data)[0].commonNm;
					} else {
						return '수주등록';
					}
				}
			},//수주상태
			{ data:'confirmDesign', className : 'text-center  align-middle',
				render: function(data, type, row, meta) {
					if(data == 'Y') {
						return '<i class="fa-solid fa-check mt-1 text-success"></i>';
					} else {
						return '<i class="fa-solid fa-x mt-1 text-danger"></i>';
					}
				}
			},//디자인컨펌
			{ data:'purchaseChkYn', className : 'text-center  align-middle',
				render: function(data, type, row, meta) {
					if(data == 'Y') {
						return '<i class="fa-solid fa-check mt-1 text-success"></i>';
					} else {
						return '<i class="fa-solid fa-x mt-1 text-danger"></i>';
					}
				}
			},//모든발주확정
			{ className : 'text-center align-middle',
				render: function(data, type, row, meta) {
					//수주수량과 지시수량이 존재하는 경우
					if( (row['ordQty'] != null && row['ordQty'] != '') && (row['workQty'] != null && row['workQty'] != '') ){
						if( parseFloat(row['ordQty']) - parseFloat(row['workQty']) > 0 ){
							return '일부지시';
						} else {
							return '지시완료';
						}
					} else {
						return '-';
					}
				}
			},//지시상태
			/* { className : 'text-center align-middle',
				render: function(data, type, row, meta) {
					return '-';
				}
			},//생산상태
			{  className : 'text-center align-middle', name : 'workOrdDateCol',
				render: function(data, type, row, meta) {
					let html = '';
					html += '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">';
					html += '<input type="date" max="9999-12-31" class="form-control" name="workOrdDate" value="'+moment().format('YYYY-MM-DD')+'">'
					html += '</div>';
					return html;
				}
			},//지시일 */
			{ data: 'workEndDate', className : 'text-center align-middle', name : 'workEndDateCol',
				render: function(data, type, row, meta) {
					let html = '';
					html += '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">';
					//html += '<input type="date" max="9999-12-31" class="form-control" name="workEndDate" value="'+moment(data).format('YYYY-MM-DD')+'">'
					html += moment(data).format('YYYY-MM-DD');
					html += '</div>';
					return html;
				}
			},//목표요청일
			{ data: 'outReqDate', className : 'text-center align-middle', name : 'outReqDateCol',
				render: function(data, type, row, meta) {
					let html = '';
					html += '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">';
					//html += '<input type="date" max="9999-12-31" class="form-control" name="outReqDate" value="'+moment(data).format('YYYY-MM-DD')+'">'
					html += moment(data).format('YYYY-MM-DD');
					html += '</div>';
					return html;
				}
			},//출고요구일
			{ data : 'bizOrdDtlNo', className : 'text-center align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},//수주상세번호
			{ data : 'dealCorpNm', className : 'text-center align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},//수주처
			{ data : 'itemNm', className : 'text-center align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="min-width:100px;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},//제품명
			{ data : 'customerItemCd', className : 'text-center align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},//자재코드
			{ data : 'itemVersion', className : 'text-center align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},//버전
			{ className : 'text-center align-middle',
				render: function(data, type, row, meta) {
					if((row['sizeX'] == null || row['sizeX'] == '') && (row['sizeY'] != null && row['sizeY'] != '')){
						return '0*' + addCommas(parseFloat(row['sizeY']));
					} else if((row['sizeX'] != null && row['sizeX'] != '') && (row['sizeY'] == null || row['sizeY'] == '')) {
						return addCommas(parseFloat(row['sizeX'])) + '*0';
					} else if((row['sizeX'] != null && row['sizeX'] != '') && (row['sizeY'] != null && row['sizeY'] != '')){
						return addCommas(parseFloat(row['sizeX'])) + '*' + addCommas(parseFloat(row['sizeY']));
					} else {
						return '0*0';
					}
				}
			},//장폭
			{ data : 'ordQty', className : 'text-end align-middle', name:'ordQtyCol',
				render: function(data, type, row, meta) {
					if(data != null && data != ''){
 						return addCommas(parseFloat(data));
					} else {
						return '-';
					}
				}
			},//수주수량		
			{ data : 'stockUseQty', className : 'text-end align-middle', name:'stockUseQty',
				render: function(data, type, row, meta) {
					if(data != null && data != ''){
 						return addCommas(parseFloat(data));
					} else {
						return '-';
					}
				}
			},//수주수량		
			{ data : 'workQty', className : 'text-end align-middle', name : 'workQtyCol',
				render: function(data, type, row, meta) {
					let html = '';
					let workQty = parseFloat(row['workQty'] != null && row['workQty'] != ''? row['workQty'] : 0);
					let ordQty = isEmptyCheck(row['ordQty']) ? 0 : parseFloat(row['ordQty']);
					let stockUseQty = isEmptyCheck(row['stockUseQty']) ? 0 : parseFloat(row['stockUseQty']);
					html += '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">';
					//if(data != null && data != ''){
						html += '<input type="text" name="workQty" class="form-control text-end" onkeyup="numberFormat(this, \'int\')" value="'+addCommas(parseFloat(ordQty - stockUseQty - workQty))+'">';	
					//} else {
					//	html += '<input type="text" name="workQty" class="form-control text-end" onkeyup="numberFormat(this, \'int\')" value="0">';
					//}
					html += '</div>';
					return html;
				}
			},//지시수량
			{ className : 'text-end align-middle', name : 'notWorkQtyCol',
				render: function(data, type, row, meta) {
					let workQty = parseFloat(row['workQty'] != null && row['workQty'] != ''? row['workQty'] : 0);
					let ordQty = isEmptyCheck(row['ordQty']) ? 0 : parseFloat(row['ordQty']);
					let stockUseQty = isEmptyCheck(row['stockUseQty']) ? 0 : parseFloat(row['stockUseQty']);

					let notWorkQty = ordQty - stockUseQty - workQty;
					return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(notWorkQty)+'</div>';
					
				}
			},//미지시수량
			{ className : 'text-center align-middle', name : 'workDescCol',
				render: function(data, type, row, meta) {
					return '<input type="text" name="workDesc" class="form-control">';
				}
			},//지시비고사항
			{ data : 'ordNote', className : 'text-start align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space:pre-line;width:330px;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},//수주특이사항
			{ data : 'ordIssue', className : 'text-start align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space:pre-line;width:330px;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},//수주전달사항
			{ data : 'ordDesc', className : 'text-start align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},//수주비고
			{ data : 'resinBoardWdCd', className : 'text-center align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},//수지판번호코드
			{ className : 'text-center align-middle',
				render: function(data, type, row, meta) {
					return '-';
				}
			},//현재고
		],
		columnDefs : [
			/*{
				targets: '_all',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					}
				}
			},*/
			{ "targets": [0], "orderable": false },
		],
		buttons : [
			{ extend: 'excel',	text: 'Excel',	charset: 'UTF-8', bom: true ,
				exportOptions: {
	                modifier: {
	                   selected:null
	                },	                
	            },
	        },
			{ extend: 'pdf',	text: 'PDF',	},
			{ extend: 'print',	text: 'Print',		charset: 'UTF-8', bom: true },
			{ extend: 'colvisGroup',	className: 'd-none',	hide: '.colvisHide'},
			/* { extend: 'colvis',	text: 'Select Col',	}, */
		],
		order : [],
		drawCallback: function() {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			$('#purchaseOrderTable tfoot').remove();
			$('#footOrdQty').html(addCommas(api.column( $('#purchaseOrderTable').DataTable().column('ordQtyCol:name').index(), {page:'all'} ).data().sum()));
			$('#footWorkQty').html(addCommas(api.column( $('#purchaseOrderTable').DataTable().column('ordQtyCol:name').index(), {page:'all'} ).data().sum() - api.column( $('#purchaseOrderTable').DataTable().column('stockUseQty:name').index(), {page:'all'} ).data().sum() - api.column( $('#purchaseOrderTable').DataTable().column('workQtyCol:name').index(), {page:'all'} ).data().sum()));
			$('#footNotWorkQty').html(addCommas(api.column( $('#purchaseOrderTable').DataTable().column('ordQtyCol:name').index(), {page:'all'} ).data().sum() - api.column( $('#purchaseOrderTable').DataTable().column('stockUseQty:name').index(), {page:'all'} ).data().sum() - api.column( $('#purchaseOrderTable').DataTable().column('workQtyCol:name').index(), {page:'all'} ).data().sum()));
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#purchaseOrderTable_wrapper').find('.dataTables_scrollHead').css('height'));
			let tfootHeight = parseFloat($('#purchaseOrderTableTfoot').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - tfootHeight - 79)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAllPot').off('keyup',function() {});
			$('#searchAllPot').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			});

		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#purchaseOrderTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();
				if(colIdx > 0){
					$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
					$(cell).css('padding','2px');
				} else {
					$(cell).html('');
					$(cell).css('padding','2px');
				}
				let cursorPosition = '';
				
				// On every keypress in this input
				$('#purchaseOrderTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
			api.button(3).trigger();
			purchaseOrderTable.draw(false);
		},
	});
	// dataTable colReorder event
	purchaseOrderTable.on('column-reorder', function( e, settings, details ) {
		let api = purchaseOrderTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#purchaseOrderTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	let bodIdx = '';
	let itemIdx = '';
	$('#purchaseOrderTable tbody').on('click','tr', function() {
		let boaIdx = purchaseOrderTable.row(this).data().boaIdx;
		bodIdx = purchaseOrderTable.row(this).data().bodIdx;
		
		if(WMCheck('prcssNew')) { // 공정등록일 경우
			setWM('prcssNew', 'idx', bodIdx);
			setWM('prcssNew', 'tableGubun', purchaseOrderTable);
			return false;
		}
		workOrdDtlTable.rows('.selected').deselect();

		//지시내역
		$('#btnWorkOrdDtlDel').attr('disabled',false);

		//생산공정내역
		$('#btnProcessNew').attr('disabled',true);
		$('#btnProcessSave').attr('disabled',true);
		$('#btnProcessEdit').attr('disabled',true);
		$('#btnProcessDel').attr('disabled',true);
		$('#btnProcessCancel').attr('disabled',true);
		
		//투입자재내역은 없지
		
		itemIdx = purchaseOrderTable.row(this).data().itemIdx;
		
		workOrdDtlTable.ajax.reload(function(){
			workOrdDtlTable.row(0).select();
			if( workOrdDtlTable.data().length != 0){
				let idx = workOrdDtlTable.row('.selected').data().idx;
				$(workOrdDtlTable.row('#'+idx).node()).trigger('click');
			}
		});		
		workPrcssDtlTable.clear().draw();
		inputMaterialHistTable.ajax.reload();
	});
	
	// 모든 체크박스 체크/해제 되도록
	$(document).on('change','input:checkbox[name=btnCheck]', function(){
		if( $('input:checkbox[name=btnCheck]').length == $('input:checkbox[name=btnCheck]:checked').length ){ //전체 체크박스 수와 체크된 박스의 수가 같을 때 -> 전체체크박스 체크 , 아닐 경우 해제
			$('#btnAllCheck').prop('checked',true);
		} else{
			$('#btnAllCheck').prop('checked',false);
		}
 	});

	//모든 체크박스 선택
	$('#btnAllCheck').on('click',function(){
		if($('#btnAllCheck').prop("checked")){
			$('input:checkbox[name=btnCheck]').prop('checked',true);
		}else{
			$('input:checkbox[name=btnCheck]').prop('checked',false);
		}
	});
	
	$('#btnSearch').on('click',function(){
		startDate = $('#startDate').val().replaceAll('-','');
		endDate = $('#endDate').val().replaceAll('-','');
		purchaseOrderTable.rows('.selected').deselect();
		workOrdDtlTable.clear().draw();
		workPrcssDtlTable.clear().draw();
		inputMaterialHistTable.clear().draw();
		$('#btnWorkOrdDtlDel').attr('disabled',true);
		$('#btnWorkOrdDtlCancel').attr('disabled',true);
		$('#btnProcessNew').attr('disabled',true);
		$('#btnProcessSave').attr('disabled',true);
		$('#btnProcessEdit').attr('disabled',true);
		$('#btnProcessDel').attr('disabled',true);
		$('#btnProcessCancel').attr('disabled',true);
		purchaseOrderTable.ajax.reload(function(){
			$('#btnAllCheck').prop('checked',false);
		});
	});


	//작업지시 등록
	$('#btnSave').on('click',function(){
		//체크한 수주목록이 있을 때 등록 시작
		if($('input:checkbox[name=btnCheck]:checked').length > 0){
			let insertList = [];
			let status = true;
			let toastrMessage = '';
			$('#my-spinner').show();
			//필수입력값 체크+값 담아주기
			$('input:checkbox[name=btnCheck]:checked').each(function(index){
				let tr = $(this).parent().parent().parent(); //해당 tr
				let node = purchaseOrderTable.row(tr).node(); //해당 row의 node
				let tableData = purchaseOrderTable.row(tr).data(); //해당 row의 data
				let ordQty = tableData.ordQty != null && tableData.ordQty != '' ? parseFloat(tableData.ordQty) : 0;
				let workQty = tableData.workQty != null && tableData.workQty != '' ? parseFloat(tableData.workQty) : 0;
				let unOrdQty = ordQty - workQty;
				 
				//col 값들
				//let workOrdDateCol = purchaseOrderTable.column('workOrdDateCol:name').index(); 	//지시일
				//let outReqDateCol = purchaseOrderTable.column('outReqDateCol:name').index();	//출고요구일
				//let workEndDateCol = purchaseOrderTable.column('workEndDateCol:name').index();	//완료요청일
				let workQtyCol = purchaseOrderTable.column('workQtyCol:name').index();			//지시수량
				let workDescCol = purchaseOrderTable.column('workDescCol:name').index();		//지시비고
				
				//해당 col의 값
				//let outReqDateVal = $(node).find('td').eq(outReqDateCol).find('input[name=outReqDate]').val();
				let workOrdDateVal = moment().format('YYYY-MM-DD');//$(node).find('td').eq(workOrdDateCol).find('input[name=workOrdDate]').val();
				//let workEndDateVal = $(node).find('td').eq(workEndDateCol).find('input[name=workEndDate]').val();
				let workQtyVal = $(node).find('td').eq(workQtyCol).find('input[name=workQty]').val();
				let workDescVal = $(node).find('td').eq(workDescCol).find('input[name=workDesc]').val();

				//입력값
				if(status){
					if(workOrdDateVal == '' || workOrdDateVal == null){
						$(node).find('td').eq(workOrdDateCol).find('input[name=workOrdDate]').focus();
						toastrMessage = '지시일을 선택하지 않은 수주가 있습니다.';
						status = false;
					//} else if(workEndDateVal == '' || workEndDateVal == null){
					//	$(node).find('td').eq(workEndDateCol).find('input[name=workEndDate]').focus();
					//	toastrMessage = '완료요청일을 선택하지 않은 수주가 있습니다.';
					//	status = false;
					} else if(workQtyVal == '' || workQtyVal == null || workQtyVal == 0){
						$(node).find('td').eq(workQtyCol).find('input[name=workQty]').focus();
						toastrMessage = '지시수량을 입력하지 않은 수주가 있습니다.';
						status = false;
					}/* else if(outReqDateVal == '' || outReqDateVal == null){
						$(node).find('td').eq(outReqDateCol).find('input[name=outReqDate]').focus();
						toastrMessage = '지시일을 선택하지 않은 수주가 있습니다.';
						status = false;
					}  else if(parseFloat(workQtyVal) > unOrdQty){
						$(node).find('td').eq(workQtyCol).find('input[name=workQty]').focus();
						toastrMessage = '지시수량이 미지시수량을 넘은 수주가 있습니다.';
						status = false;
					} */
					
				}
				//값 담아주기
				let data = purchaseOrderTable.row(tr).data(); // 데이터 테이블의 해당 칸
				let obj = {};
				obj.indexOrd = index+1;
				obj.itemIdx = data.itemIdx;
				obj.bizOrdDtlIdx = data.bodIdx;
				obj.ordStatus = '';
				//obj.outReqDate = outReqDateVal.replaceAll('-','');
				obj.outReqDate = '';
				obj.ordDate = workOrdDateVal.replaceAll('-','');
				//obj.ordEndDate = workEndDateVal.replaceAll('-','');
				obj.ordEndDate = '';
				obj.printYn = 'N';
				obj.ordQty = workQtyVal.replaceAll(',','');
				obj.ordDesc = workDescVal;
				insertList.push(obj);	
			})
			$('#my-spinner').hide();
			//등록진행
			if(status){
				$.ajax({
					url: '<c:url value="/wm/workOrdIns"/>',
		            type: 'POST',
		            data: {
		                'insertList' : 	JSON.stringify(insertList),
		            },
		            beforeSend: function() {
		            	$('#my-spinner').show();
		            },
					success : function(res) {
						if (res.result == "ok") { //응답결과
							toastr.success('작업지시 등록되었습니다.<br>제품의 도수를 입력하지 않은 경우<br>등록되지않습니다.');
							purchaseOrderTable.rows('.selected').deselect();
							purchaseOrderTable.ajax.reload(function(){
								$('#btnAllCheck').prop('checked',false);
								workOrdDtlTable.clear().draw();
								workPrcssDtlTable.clear().draw();
								inputMaterialHistTable.clear().draw();
							});
						} else if(res.result == 'fail') {
							toastr.warning(res.message);
						} else {
							toastr.error(res.message);
						}
						$('#my-spinner').hide();
					}
				});
			} else {
				toastr.warning(toastrMessage);
			}	
			
		} else {
			//체크한 수주 목록이 없을 때
			toastr.warning('작업 지시할 수주를 체크해주세요.');
		}
		
	});



	/**************************************************************지시내역**************************************************************/	
	// 지시상세 목록조회
	$('#workOrdDtlTable thead tr').clone(true).addClass('filters').appendTo('#workOrdDtlTable thead'); // filter 생성
	let workOrdDtlTable = $('#workOrdDtlTable').DataTable({
		dom : "<'row'<'col-md-12 col-md-6'l><'col-md-12 col-md-6'f>>"
				+ "<'row'<'col-md-12'tr>>"
				+ "<'row pt-1'<'d-flex align-items-center d-flex'><'me-lg-auto'><'d-flex align-items-center justify-content-end'>>",
		language: lang_kor,
		info: true,
		ordering: true,
		processing: true,
		paging: false,
		lengthChange: false,
		searching: true,
		autoWidth: false,
		orderCellsTop: true,
        fixedHeader: false,
        scrollY: '100vh',
        scrollX: true,
		pageLength: 100000000,
		colReorder: true,
		select: {
            style: 'single',
            toggleable: false,
            items: 'row',
            info: false
        },
        ajax : {
			url : '<c:url value="/wm/workOrdLst"/>',
			type : 'POST',
			data : {
				'bodIdx' : function(){return bodIdx;},
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'ordStatus', className : 'text-center',
				render: function(data, type, row, meta) {
					return '-';
				}
			},
			{ data: 'ordDate', className : 'text-center',
				render: function(data, type, row, meta) {
					if(data != null && data != ''){
 						return moment(data).format('YYYY-MM-DD');
					} else {
						return '-';
					}
				}
			},
			{ data: 'ordEndDate', className : 'text-center',
				render: function(data, type, row, meta) {
					if(data != null && data != ''){
 						return moment(data).format('YYYY-MM-DD');
					} else {
						return '-';
					}
				}
			},
			{ data: 'outReqDate', className : 'text-center',
				render: function(data, type, row, meta) {
					if(data != null && data != ''){
 						return moment(data).format('YYYY-MM-DD');
					} else {
						return '-';
					}
				}
			},
			{ data: 'ordQty', className : 'text-end',
				render: function(data, type, row, meta) {
					if(data != null && data != ''){
 						return addCommas(parseFloat(data));
					} else {
						return '-';
					}
				}
			},
			{ data: 'printYn', className : 'text-center',
				render: function(data, type, row, meta) {
					if(data == 'Y') {
						return '<i class="fa-solid fa-check mt-1 text-success"></i>';
					} else {
						return '<i class="fa-solid fa-x mt-1 text-danger"></i>';
					}
				}
			},
		],
		columnDefs : [
			//{
			//	targets: [0],
			//	render: function(data) {
			//		return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
			//	}
			//}
		],
		buttons : [
			/* { extend: 'excel',	text: 'Excel',	charset: 'UTF-8', bom: true ,
				exportOptions: {
	                modifier: {
	                   selected:null
	                },	                
	            },
	        },
			{ extend: 'pdf',	text: 'PDF',	},
			{ extend: 'print',	text: 'Print',		charset: 'UTF-8', bom: true },
			{ extend: 'colvis',	text: 'Select Col',	}, */
		],
		order : [],
		drawCallback: function() {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#workOrdDtlTable_wrapper').find('.dataTables_scrollHead').css('height'));
			let	topHeight = parseFloat($('#rightcolT').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(topHeight - theadHeight - 95)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAllWod').off('keyup',function() {});
			$('#searchAllWod').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			});
		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#workOrdDtlTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#workOrdDtlTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	workOrdDtlTable.on('column-reorder', function( e, settings, details ) {
		let api = workOrdDtlTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#workOrdDtlTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	let workOrdIdx = '';
	$('#workOrdDtlTable tbody').on('click','tr', function() {
		let idx = workOrdDtlTable.row(this).data().idx;
		if(WMCheck('prcssNew')) { // 공정등록일 경우
			setWM('prcssNew', 'idx', idx);
			setWM('prcssNew', 'tableGubun', workOrdDtlTable);
			return false;
		}
		workOrdIdx = workOrdDtlTable.row(this).data().idx;
		//생산공정내역
		$('#btnProcessNew').attr('disabled',false);
		$('#btnProcessSave').attr('disabled',true);
		$('#btnProcessEdit').attr('disabled',false);
		$('#btnProcessDel').attr('disabled',false);
		$('#btnProcessCancel').attr('disabled',true);
		
		workPrcssDtlTable.ajax.reload(function(){
			$('#my-spinner').show();
			/* $('#workPrcssDtlTable tbody tr').each(function(index){
				let node = workPrcssDtlTable.row(index).node();
				if(workPrcssDtlTable.row(index).data() != undefined && workPrcssDtlTable.row(index).data() != ''){
					//let prcssIdx = workPrcssDtlTable.row(index).data().prcssIdx;
					let multipleNode = $(node).find('td').eq(7).find('select[name=workMethodMultiSelect]');
					
					$(multipleNode).select2({
			    		data: JSON.parse(workPrcssDtlTable.row(index).data().workMethodJson),
			    		multiple : true,
			    		placeholder: "작업방법 선택",
			    	});
			    	
					$(node).find('td').eq(7).find('span').eq(0).css('width','100%');
			    	$(node).find('td').eq(7).find('.select2-search__field').css('width','100%');
			    	$(node).find('td').eq(7).find('.select2-selection__rendered').attr('style','display:flex; align-content:flex-start; flex-direction:column; flex-wrap:wrap; overflow:auto;');
			    	
					if( workPrcssDtlTable.row(index).data().workMethod != null && workPrcssDtlTable.row(index).data().workMethod != ''){
						let splitData =  workPrcssDtlTable.row(index).data().workMethod.split(',');
						$(node).find('td').eq(7).find('select[name=workMethodMultiSelect]').val(splitData).trigger('change')
					}
					
					$(node).find('td').eq(7).find('select[name=workMethodMultiSelect]').attr('disabled',true);
				}
			}); */

			$('#my-spinner').hide();
			setTimeout(function() {
				workPrcssDtlTable.draw(false);
			},100);

		});		
	});

	//지시내역삭제
	$('#btnWorkOrdDtlDel').on('click',function(){
		if(!$('#workOrdDtlTable tbody tr').hasClass('selected')){
			toastr.warning('삭제할 행을 선택해주세요.');
			return false;
		}
		$('#deleteModal').data('deleteType','workOrdDtl');
		$('#deleteModal').modal('show');
		
	});


	/**************************************************************생산공정**************************************************************/
	// 생산공정내역 목록조회
	$('#workPrcssDtlTable thead tr').clone(true).addClass('filters').appendTo('#workPrcssDtlTable thead'); // filter 생성
	let workPrcssDtlTable = $('#workPrcssDtlTable').DataTable({
		dom : "<'row'<'col-md-12 col-md-6'l><'col-md-12 col-md-6'f>>"
				+ "<'row'<'col-md-12'tr>>"
				+ "<'row pt-1'<'d-flex align-items-center d-flex'><'me-lg-auto'><'d-flex align-items-center justify-content-end'>>",
		language: lang_kor,
		info: true,
		ordering: true,
		processing: true,
		paging: false,
		lengthChange: false,
		searching: true,
		autoWidth: false,
		orderCellsTop: true,
        fixedHeader: false,
        scrollY: '100vh',
        scrollX: true,
		pageLength: 100000000,
		colReorder: false,
		rowReorder: {
			enable: true,
			dataSrc: 'prcssOrder',
		},
		select: {
            style: 'single',
            toggleable: false,
            items: 'row',
            info: false
        },
        ajax : {
			url : '<c:url value="/wm/workOrdPrcssLst"/>',
			type : 'POST',
			data : {
				'workOrdIdx' : function(){return workOrdIdx;},
			},
		}, 
        rowId: 'idx',
		columns : [
			{ data: 'prcssOrder', className : 'text-center'},
			{ data: 'progressStatus', className : 'text-center',name:'progressStatus',
				render: function(data, type, row, meta) {
					if(data == 'PI'){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;font-weight:900;">대기</div>';
					} else if(data == 'WI'){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;font-weight:900;color:blue;">진행</div>';
					} else if(data == 'WC'){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;font-weight:900;color:green;">완료</div>';
					} else {
						return '-';
					}
				}
			},//진행상태
			{ data : 'prcssNm', className : 'text-center',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},//공정명
			{ data : 'produceQtyUnitNm', className : 'text-center',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},//작업단위
			{ data : 'ordQty', className : 'text-end',
				render: function(data) {
					if(data != null && data != ''){
						return '<input type="text" name="ordQty" style="min-width:80px;width:80px;"class="form-control text-end" onkeyup="numberFormat(this, \'int\')" value="'+addCommas(parseFloat(data))+'" disabled>';
					} else {
						return '<input type="text" name="ordQty" style="min-width:80px;width:80px;"class="form-control text-end" onkeyup="numberFormat(this, \'int\')" value="0" disabled>';
					}
				}
			},//지시수량
			{ data: 'fairQty', className : 'text-end',
				render: function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
					} else {
						return '0';
					}
				}
			},//작업수량
			{ data: 'addCutting', className : 'text-end',
				render: function(data) {
					if(data != null && data != ''){
						return '<input type="text" name="addCutting" style="min-width:80px;width:80px;"class="form-control text-end" onkeyup="numberFormat(this, \'int\')" value="'+addCommas(parseFloat(data))+'" disabled>';
					} else {
						return '<input type="text" name="addCutting" style="min-width:80px;width:80px;"class="form-control text-end" onkeyup="numberFormat(this, \'int\')" value="0">';
					}
				}
			},//추가재단
			{ data: 'workMethod', className : 'text-center',
				render: function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">' + data + '</div>';
					} else {
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;"></div>';
					}
				}
			},//작업방법
		],
		columnDefs : [
// 			{ "targets": '_all', "orderable": false },
			//{
			//	targets: [0],
			//	render: function(data) {
			//		return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
			//	}
			//}
		],
		buttons : [
			/* { extend: 'excel',	text: 'Excel',	charset: 'UTF-8', bom: true ,
				exportOptions: {
	                modifier: {
	                   selected:null
	                },	                
	            },
	        },
			{ extend: 'pdf',	text: 'PDF',	},
			{ extend: 'print',	text: 'Print',		charset: 'UTF-8', bom: true },
			{ extend: 'colvis',	text: 'Select Col',	}, */
		],
		order : [[0,'asc']],
		drawCallback: function() {
			let api = this.api();
			let data = api.data();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#workPrcssDtlTable_wrapper').find('.dataTables_scrollHead').css('height'));
			let	topHeight = parseFloat($('#rightcolM').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(topHeight - theadHeight - 95)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAllWpd').off('keyup',function() {});
			$('#searchAllWpd').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			});
			for(var i=0;i<data.length;i++) {
				let tr = $('#' + table_id + ' tbody').find('tr').eq(i);
				workPrcssDtlTable.row(tr).data().prcssOrder = i+1;
				$(tr).find('td').eq(0).html(i+1);
			}
			$('#'+table_id+' tbody tr').attr('style',"vertical-align: middle;");
		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#workPrcssDtlTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#workPrcssDtlTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	workPrcssDtlTable.on('column-reorder', function( e, settings, details ) {
		let api = workPrcssDtlTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#workPrcssDtlTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	//공정내역 등록하기
	$('#btnProcessNew').on('click',function(){
		_promise_().then(()=>{
			$('#my-spinner').show();
		}).then(()=>{
			setTimeout(function(){
				$.ajax({
					url : '<c:url value="/wm/workOrdPrcssLst"/>',
					type : 'POST',
					async : false,
					data : {
						'workOrdIdx' : function(){return workOrdIdx;},
					},
					beforeSend: function() {
			        	$('#my-spinner').show();
			        },
			        success : function(res) {
						if (res.result == "ok") { //응답결과
							let data = res.data;				
							let filterList = _.filter(data,v=> v.progressStatus == 'WC' || v.progressStatus == 'WI')
							if(data.length == filterList.length){
								toastr.warning('마지막 공정이 진행/완료된 경우<br>추가할 수 없습니다.');
							} else {
								prcssModalTable.select.style('multi');
						   		//선택되어있는 행들 취소 시키고 선택(등록되어있는 행) 시키기			
								prcssModalTable.rows('.selected').deselect();
						   		$('#prcssModal').modal('show');   	
								setTimeout(function() {
									prcssModalTable.ajax.reload(function() {
										//선택(등록되어있는 행)
										/* for( let i = 0; i < processInfoTable.data().length; i++){
											//인덱스 구해서 선택시키기
											prcssModalTable.row($('#prcssModalTable tbody').find('#'+processInfoTable.row(i).data().prcssIdx).index()).select();
										} */
									});
								}, 200);
						   		//WM_action_ON('prcssNew', 'workingWarningModal');
						   		
								$('#btnProcessNew').attr('disabled',false);
								$('#btnProcessSave').attr('disabled',false);
								$('#btnProcessEdit').attr('disabled',true);
								$('#btnProcessDel').attr('disabled',false);
								$('#btnProcessCancel').attr('disabled',false);
							}
						} else if(res.result == 'fail') {
							toastr.warning(res.message);
						} else {
							toastr.error(res.message);
						}
						$('#my-spinner').hide();
					}
				});
				},100);
			
		});
		
		
	});

	$('#btnPrcssModalPaste').on('click',function(){
		let status = true;
		let ngPrcssCd = '';
		
		if(!$('#prcssModalTable tbody tr').hasClass('selected')){
			toastr.warning('붙여넣을 행을 선택해주세요.');
			return false;
		}
		_promise_().then(()=>{
			$('#my-spinner').show();
		}).then(()=>{
			setTimeout(function(){
				let purchaseData ;
				
				//해당 수주의 제품에 걸려있는 도수값, 여분포함통수 , 개수 가져오는 ajax
				$.ajax({
					url: '<c:url value="/pm/purchaseOrderAdmLstByBizDtlIdx"/>',
			        type: 'POST',
			        async: false,
			        data: {
			            'bizOrdDtlIdx'	: function(){ return bodIdx; },
			        },
			        beforeSend: function() {
			        	$('#my-spinner').show();
			        },
					success : function(res) {
						if (res.result == "ok") { //응답결과
							purchaseData = res.data[0];
						} else if(res.result == 'fail') {
							toastr.warning(res.message);
						} else {
							toastr.error(res.message);
						}
					}
				});
				
				
				//처음으로 공정선택할 때 다중 행
				if(prcssModalTable.select.style() == 'multi'){
					let selectedIndex = prcssModalTable.rows('.selected').toArray()[0];
					if( status ){
						//모달창에서 선택되어있는 공정 IDX들( 붙여넣을 항목 )
						let prcssIdxArray = getPrcssIdx(prcssModalTable.rows('.selected').data().toArray(),"idx");
						let i = 0;
						let j = 0;
						let rowDeleteCnt = 0;
						let prcssTableLen = $('#workPrcssDtlTable tbody tr').length - $('#workPrcssDtlTable tbody tr').find('.dataTables_empty').length;
						//필터된 array(삽입 해야할 항목)
						for(i = 0; i < prcssIdxArray.length; i++){
							//모달 행 위치
							let modalRow = getPrcssIdx(prcssModalTable.data().toArray(),"idx").indexOf(prcssIdxArray[i]); 
							
							//추가될 row = 테이블 행 갯수 - 데이터가 없는 경우 나오는 행
							let rowLvl = $('#workPrcssDtlTable tbody tr').length - $('#workPrcssDtlTable tbody tr').find('.dataTables_empty').length;

							let modalData = prcssModalTable.row(modalRow).data();

							let workOrdQty = parseFloat(workOrdDtlTable.row('.selected').data().ordQty);
							let ordQty = 0;
							//CTP인경우 -> 제품에 걸려있는 도수값 
							if(modalData.prcssNm == 'CTP'){
								ordQty = purchaseData.frequencyNm;
							} else {
								//생산지시단위가 통, R 인경우 여분포함통수
								if(modalData.produceQtyUnitNm == '통' || modalData.produceQtyUnitNm == 'R'){
									//ordQty = parseFloat(Math.ceil( workOrdQty / purchaseData.eaQty * purchaseData.cutQty )*purchaseData.cutQty ) + parseFloat(purchaseData.extraQty) + parseFloat(purchaseData.extraPackQty*purchaseData.cutQty);
									ordQty = parseFloat(Math.ceil( workOrdQty / (purchaseData.eaQty * purchaseData.cutQty) )*purchaseData.cutQty) + parseFloat(purchaseData.extraQty) + parseFloat(purchaseData.extraPackQty*purchaseData.cutQty);
									
								} else {
									//생산지시단위가 매인 경우 여분포함통수 * 개수
									//ordQty = (parseFloat(Math.ceil( workOrdQty / purchaseData.eaQty * purchaseData.cutQty))*purchaseData.cutQty + parseFloat(purchaseData.extraQty)) + (parseFloat(purchaseData.extraPackQty) * parseFloat(purchaseData.cutQty));

									ordQty = (parseFloat(Math.ceil( workOrdQty / (purchaseData.eaQty * purchaseData.cutQty) )*purchaseData.cutQty) + parseFloat(purchaseData.extraQty) + parseFloat(purchaseData.extraPackQty*purchaseData.cutQty)) * purchaseData.eaQty;
								}
							}
							
							$('#workPrcssDtlTable').DataTable().row.add({
								'prcssOrder'			: 999999999,
								'progressStatus'		: '',
								'prcssNm'				: modalData.prcssNm,
								'produceQtyUnitNm'		: modalData.produceQtyUnitNm,
								'ordQty'				: ordQty,
								'outsrcGubun'			: null,
								'workMethod'			: null,
							}).draw(false);

							workPrcssDtlTable.row(rowLvl).data().produceQtyUnit = modalData.produceQtyUnit;
							workPrcssDtlTable.row(rowLvl).data().prcssIdx = modalData.idx;
							workPrcssDtlTable.row(rowLvl).data().prcssNm = modalData.prcssNm;
							let node = workPrcssDtlTable.row(rowLvl).node();
							/* let multipleNode = $(node).find('td').eq(7).find('select[name=workMethodMultiSelect]');
					    	$(multipleNode).select2({
					    		data: JSON.parse(modalData.workMethodJson),
					    		multiple : true,
					    		placeholder: "작업방법 선택",
					    	});
					    	$(node).find('td').eq(7).find('span').eq(0).css('width','100%');
					    	$(node).find('td').eq(7).find('.select2-search__field').css('width','100%');
					    	$(node).find('td').eq(7).find('.select2-selection__rendered').attr('style','display:flex; align-content:flex-start; flex-direction:column; flex-wrap:wrap; overflow:auto;');
					    	$(node).find('td').find('select[name=outsrcGubun]').attr('disabled',false);
							$(node).find('td').find('select[name=workMethodMultiSelect]').attr('disabled',false);
							$(node).find('td').find('input[name=ordQty]').attr('disabled',false);
							$(node).find('td').find('input[name=addCutting]').attr('disabled',false); */
								
						} 
						workPrcssDtlTable.draw(false);
						
						//$('#prcssModal').modal('hide'); 
						toastr.success('공정이 추가되었습니다.');
						WM_action_ON('prcssNew', 'workingWarningModal');
					} else {				
						toastr.warning('이미 추가된 공정이 있습니다.<br>추가된 공정 코드 : '+ngPrcssCd);
					}

					
				} else if(prcssModalTable.select.style() == 'single'){ //단일 행 선택해서 수정일 경우
					//중복체크
					$('#workPrcssDtlTable tbody tr').each(function(index){
						if(workPrcssDtlTable.row(index).data() != undefined ){
							if(workPrcssDtlTable.row(index).data().prcssIdx == prcssModalTable.row('.selected').data().idx){
								ngPrcssCd += prcssModalTable.row('.selected').data().prcssCd;
								status = false;
							}
						}
					});
					if( status ){
						workPrcssDtlTable.row('.selected').data().prcssIdx = prcssModalTable.row('.selected').data().idx;
						//단위
						workPrcssDtlTable.row('.selected').data().qtyNuit = prcssModalTable.row('.selected').data().qtyNuit;
						workPrcssDtlTable.row('.selected').data().qtyUnitNm = prcssModalTable.row('.selected').data().qtyUnitNm;
						//비고
						workPrcssDtlTable.row('.selected').data().prcssDesc = prcssModalTable.row('.selected').data().prcssDesc;
					
						$('#workPrcssDtlTable tbody').find('.selected').find('td').eq(1).html('<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+prcssModalTable.row('.selected').data().prcssCd+'</div>');
						$('#workPrcssDtlTable tbody').find('.selected').find('td').eq(8).html('<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+prcssModalTable.row('.selected').data().qtyUnitNm+'</div>');
						$('#workPrcssDtlTable tbody').find('.selected').find('td').eq(9).html('<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+prcssModalTable.row('.selected').data().prcssDesc+'</div>');
						//공정명 html
						let html1='';
						html1 += '<div style="display: flex; flex-wrap: 1 1 auto;">';
						html1 += '<input type="text" class="form-control inputGroup" id="prcssNm" style="max-width: 100%;" disabled="disabled" value="'+prcssModalTable.row('.selected').data().prcssNm+'">';
						html1 += '<input type="hidden" id="prcssIdx">';
						html1 += '</div>';			
						$('#workPrcssDtlTable tbody').find('.selected').find('td').eq(2).html(html1);
						workPrcssDtlTable.draw(false);
						$('#prcssModal').modal('hide');  
						WM_action_ON('prcssNew', 'workingWarningModal');
					} else {
						toastr.warning('이미 추가된 공정이 있습니다.<br>추가된 공정 코드 : '+ngPrcssCd);
					}
				}
				$('#my-spinner').hide();
			},10);
		});

		
	});

	//공정저장
	$('#btnProcessSave').on('click',function(){
		let insertList = [];
		$('#my-spinner').show();
		if($('#workPrcssDtlTable tbody tr').length - $('#workPrcssDtlTable tbody tr').find('.dataTables_empty').length == 0){
			
		} else {		
			$('#workPrcssDtlTable tbody tr').each(function(index){
				let obj = {};
				let node = workPrcssDtlTable.row(index).node();
				obj.workOrdIdx = workOrdDtlTable.row('.selected').data().idx;
				obj.idx = workPrcssDtlTable.row(index).data().idx;
				obj.prcssOrder = workPrcssDtlTable.row(index).data().prcssOrder;
				obj.prcssIdx = workPrcssDtlTable.row(index).data().prcssIdx;
				obj.progreeStatus = 'PI';
				//외주구분 안쓴다해서 그냥 기본 사내인 01로 넣어주기
				obj.outsrcGubun =  '01';//$(node).find('td').eq(3).find('select').val();
				obj.ordQty = $(node).find('td').eq(4).find('input[name=ordQty]').val().replaceAll(',','');
				obj.produceQtyUnit = workPrcssDtlTable.row(index).data().produceQtyUnit;
				obj.addCutting = $(node).find('td').eq(6).find('input[name=addCutting]').val().replaceAll(',','');
				obj.workMethod = $(node).find('td').eq(7).find('select[name=workMethodMultiSelect]').val();
				insertList.push(obj);
			});
		}
		$('#my-spinner').hide();
		$.ajax({
			url: '<c:url value="/wm/workOrdPrcssIns"/>',
		        type: 'POST',
		        //async: false,
		        data: {
		            'insertList' : 	JSON.stringify(insertList),
		            'workOrdIdx'	: function(){ return workOrdIdx; },
		        },
		        beforeSend: function() {
		        	$('#my-spinner').show();
		        },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					let data = res.data;
					toastr.success('신규 저장되었습니다.');
					WM_action_OFF('prcssNew');
					$('#btnProcessNew').attr('disabled',false);
					$('#btnProcessSave').attr('disabled',true);
					$('#btnProcessEdit').attr('disabled',false);
					$('#btnProcessDel').attr('disabled',false);
					$('#btnProcessCancel').attr('disabled',true);						
					workPrcssDtlTable.ajax.reload(function(){
						$('button[name=customerModalBtn]').attr('disabled',true);
						$('button[name=equipModalBtn]').attr('disabled',true);
						$('input[name=ordQty]').attr('disabled',true);
						/* $('#workPrcssDtlTable tbody tr').each(function(index){
							let node = workPrcssDtlTable.row(index).node();
							if(workPrcssDtlTable.row(index).data() != undefined && workPrcssDtlTable.row(index).data() != ''){
								let multipleNode = $(node).find('td').eq(7).find('select[name=workMethodMultiSelect]');
								$(multipleNode).select2({
						    		data: JSON.parse(workPrcssDtlTable.row(index).data().workMethodJson),
						    		multiple : true,
						    		placeholder: "작업방법 선택",
						    	});
								$(node).find('td').eq(7).find('span').eq(0).css('width','100%');
						    	$(node).find('td').eq(7).find('.select2-search__field').css('width','100%');
						    	$(node).find('td').eq(7).find('.select2-selection__rendered').attr('style','display:flex; align-content:flex-start; flex-direction:column; flex-wrap:wrap; overflow:auto;');
						    	
								if( workPrcssDtlTable.row(index).data().workMethod != null && workPrcssDtlTable.row(index).data().workMethod != ''){
									let splitData =  workPrcssDtlTable.row(index).data().workMethod.split(',');
									$(node).find('td').eq(7).find('select[name=workMethodMultiSelect]').val(splitData).trigger('change')
								}
								
								$(node).find('td').eq(7).find('select[name=workMethodMultiSelect]').attr('disabled',true);
							}
						}); */
	
						$('#my-spinner').hide();
						setTimeout(function() {
							workPrcssDtlTable.draw(false);
						},100);
					});
					
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
		
	});

	//공정 수정
	$('#btnProcessEdit').on('click',function(){
		// 멀티셀렉트 disabled 해제 하고나서 테이블 헤더 보정
		_promise_().then(()=>{
			$('#btnProcessNew').attr('disabled',false);
			$('#btnProcessSave').attr('disabled',false);
			$('#btnProcessEdit').attr('disabled',true);
			$('#btnProcessDel').attr('disabled',false);
			$('#btnProcessCancel').attr('disabled',false);
			$('#workPrcssDtlTable tbody tr').each(async function(index){
				let node = workPrcssDtlTable.row(index).node();
				if(workPrcssDtlTable.row(index).data().progressStatus == 'PI'){
					$(node).find('td').find('input[name=ordQty]').attr('disabled',false);
					$(node).find('td').find('input[name=addCutting]').attr('disabled',false);
					$(node).find('td').find('select[name=outsrcGubun]').attr('disabled',false);
					$(node).find('td').find('select[name=workMethodMultiSelect]').attr('disabled',false);
				} else {
					$(node).find('td').find('input[name=ordQty]').attr('disabled',true);
					$(node).find('td').find('input[name=addCutting]').attr('disabled',true);
					$(node).find('td').find('select[name=outsrcGubun]').attr('disabled',true);
					$(node).find('td').find('select[name=workMethodMultiSelect]').attr('disabled',true);
				}
			});
			WM_action_ON('prcssNew', 'workingWarningModal');
		}).then(()=>{
			workPrcssDtlTable.draw(false);
		});
	});

	//공정삭제
	$('#btnProcessDel').on('click',function(){
		if(!$('#workPrcssDtlTable tbody tr').hasClass('selected')){
			toastr.warning('삭제할 항목을 선택해주세요.');
			return false;
		}

		let idx = workPrcssDtlTable.row('.selected').data().idx;
		if(idx != '' && idx != undefined){
			$('#deleteModal').data('deleteType','workPrcssDtl');
			$('#deleteModal').modal('show');
		} else {
			workPrcssDtlTable.row('.selected').remove().draw(false);
		}
	});
		
	//공정순서변경되었을 때
	/*workPrcssDtlTable.on( 'row-reorder', function ( e, diff, changes ) {
		if(diff.length != 0){
			$('#btnProcessSave').attr('disabled',false);
			WM_action_ON('prcssNew', 'workingWarningModal');
		}
	} );*/
	workPrcssDtlTable.on( 'row-reordered', function ( e, diff, changes ) {
		_promise_().then(()=>{
			$('#my-spinner').show();
		}).then(()=>{
			setTimeout( function() {
				let status = true;			
				WM_action_ON('prcssNew', 'workingWarningModal');
				$.ajax({
					url : '<c:url value="/wm/workOrdPrcssLst"/>',
					type : 'POST',
					async : false,
					data : {
						'workOrdIdx' : function(){return workOrdIdx;},
					},
					beforeSend: function() {
			        	$('#my-spinner').show();
			        },
			        success : function(res) {
						if (res.result == "ok") { //응답결과
							let data = res.data;				
							for(let i = 0; i < data.length && status; i++){
								if(data[i].idx != $('#workPrcssDtlTable tbody tr').eq(i).attr('id')){ //ajax통한 데이터랑 실제 테이블에 그려진 데이터랑 다를 경우 -> 수정됨
									if(data[i].progressStatus != 'PI'){
										status = false;
									}
								}
							}
						} else if(res.result == 'fail') {
							toastr.warning(res.message);
						} else {
							toastr.error(res.message);
						}
						$('#my-spinner').hide();
					}
				});
		
				if(status){
					$('#btnProcessSave').attr('disabled',false);
				} else {
					toastr.warning('대기중인 공정만 수정할 수 있습니다.');
					$('#btnProcessNew').attr('disabled',false);
					$('#btnProcessSave').attr('disabled',false);
					$('#btnProcessEdit').attr('disabled',true);
					$('#btnProcessDel').attr('disabled',false);
					$('#btnProcessCancel').attr('disabled',false);
					workPrcssDtlTable.ajax.reload(function(){
						/* $('#workPrcssDtlTable tbody tr').each(function(index){
							let node = workPrcssDtlTable.row(index).node();
							if(workPrcssDtlTable.row(index).data() != undefined && workPrcssDtlTable.row(index).data() != ''){
								let multipleNode = $(node).find('td').eq(7).find('select[name=workMethodMultiSelect]');
								$(multipleNode).select2({
						    		data: JSON.parse(workPrcssDtlTable.row(index).data().workMethodJson),
						    		multiple : true,
						    		placeholder: "작업방법 선택",
						    	});
								$(node).find('td').eq(7).find('span').eq(0).css('width','100%');
						    	$(node).find('td').eq(7).find('.select2-search__field').css('width','100%');
						    	$(node).find('td').eq(7).find('.select2-selection__rendered').attr('style','display:flex; align-content:flex-start; flex-direction:column; flex-wrap:wrap; overflow:auto;');
						    	
								if( workPrcssDtlTable.row(index).data().workMethod != null && workPrcssDtlTable.row(index).data().workMethod != ''){
									let splitData =  workPrcssDtlTable.row(index).data().workMethod.split(',');
									$(node).find('td').eq(7).find('select[name=workMethodMultiSelect]').val(splitData).trigger('change')
								}
								
								$(node).find('td').eq(7).find('select[name=workMethodMultiSelect]').attr('disabled',true);
							}
							if(workPrcssDtlTable.row(index).data().progressStatus == 'PI'){
								$(node).find('td').find('input[name=ordQty]').attr('disabled',false);
								$(node).find('td').find('input[name=addCutting]').attr('disabled',false);
								$(node).find('td').find('select[name=outsrcGubun]').attr('disabled',false);
								$(node).find('td').find('select[name=workMethodMultiSelect]').attr('disabled',false);
							} else {
								$(node).find('td').find('input[name=ordQty]').attr('disabled',true);
								$(node).find('td').find('input[name=addCutting]').attr('disabled',true);
								$(node).find('td').find('select[name=outsrcGubun]').attr('disabled',true);
								$(node).find('td').find('select[name=workMethodMultiSelect]').attr('disabled',true);
							}
							
						}); */
		
						$('#my-spinner').hide();
						setTimeout(function() {
							workPrcssDtlTable.draw(false);
						},100);
					} );
				}
			},100);
		});
	});
	
	
	//멀티셀렉트 값 바뀌면 테이블 헤더 보정
	$(document).on('change','select[name=workMethodMultiSelect]',function(){
		workPrcssDtlTable.draw(false);
	});

	//객체(json)에서 키(field)로 값 찾기
	function getPrcssIdx(input, field) {
	    let output = [];
	    for (let i=0; i < input.length ; ++i)
	        output.push(input[i][field]);
	    return output;
	}

	/**************************************************************투입자재**************************************************************/
	// 투입자재내역 목록조회
	$('#inputMaterialHistTable thead tr').clone(true).addClass('filters').appendTo('#inputMaterialHistTable thead'); // filter 생성
	let inputMaterialHistTable = $('#inputMaterialHistTable').DataTable({
		dom : "<'row'<'col-md-12 col-md-6'l><'col-md-12 col-md-6'f>>"
				+ "<'row'<'col-md-12'tr>>"
				+ "<'row pt-1'<'d-flex align-items-center d-flex'><'me-lg-auto'><'d-flex align-items-center justify-content-end'>>",
		language: lang_kor,
		info: true,
		ordering: true,
		processing: true,
		paging: false,
		lengthChange: false,
		searching: true,
		autoWidth: false,
		orderCellsTop: true,
        fixedHeader: false,
        scrollY: '100vh',
        scrollX: true,
		pageLength: 100000000,
		colReorder: true,
		select: {
            style: 'single',
            toggleable: false,
            items: 'row',
            info: false
        },
        ajax : {
			url : '<c:url value="/wm/workOrdInputMaterialLst"/>',
			type : 'POST',
			data : {
				'itemIdx' : function(){ return itemIdx; },
				'bodIdx'  : function(){ return bodIdx; },
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'paperType', className : 'text-center align-middle'},
			{ className : 'text-center align-middle',
				render: function(data, type, row, meta) {
					if((row['sizeX'] == null || row['sizeX'] == '') && (row['sizeY'] != null && row['sizeY'] != '')){
						return '0*' + addCommas(parseFloat(row['sizeY']));
					} else if((row['sizeX'] != null && row['sizeX'] != '') && (row['sizeY'] == null || row['sizeY'] == '')) {
						return addCommas(parseFloat(row['sizeX'])) + '*0';
					} else if((row['sizeX'] != null && row['sizeX'] != '') && (row['sizeY'] != null && row['sizeY'] != '')){
						return addCommas(parseFloat(row['sizeX'])) + '*' + addCommas(parseFloat(row['sizeY']));
					} else {
						return '0*0';
					}
				}
			},//장 * 폭
			{ className : 'text-center align-middle',
				render: function(data, type, row, meta) {
					return addCommas(parseFloat(row['cutQty'])) + '절/' + addCommas(parseFloat(row['eaQty'])) + '개';
				}
			},// 절수/개수
			{  className : 'text-center align-middle',
				render: function(data, type, row, meta) {
					let ordQty = parseInt(row['purchaseOrdQty']); // 주문수량(제품)
					let cutQty = parseInt(row['cutQty']); // 절수
					let eaQty = parseInt(row['eaQty']); // 개수
					let extraQty = parseInt(row['extraQty']); // 여유분
					
					if(row['purchaseOrdQty'] == 'notPurchase'){//발주를 하지않은 경우
						return '-';
					} else if(cutQty == 0 || eaQty == 0) {
						return '0';
					} else {
						//let printPressQty = Math.ceil(ordQty/eaQty);
						let printPressQty = Math.ceil(ordQty/(cutQty*eaQty)) * cutQty;
						let pressQty = Math.ceil((printPressQty + extraQty)/cutQty);
						
						let R = parseInt(pressQty / 500); // R로 환산
						let finalPurchaseQty = R + "R" + (pressQty % 500);
						
						return finalPurchaseQty;
					}
					//return addCommas(parseFloat(row['purchaseOrdQty'])) + '+' + addCommas(parseFloat(row['extraQty']));
				}
			},//발주량+여분
			{  data: 'inQty', className : 'text-end align-middle',
				render: function(data, type, row, meta) {
					if(row['purchaseOrdQty'] == 'notPurchase'){//발주를 하지않은 경우
						return '-';
					} else if(data != null && data != ''){
						return addCommas(parseFloat(data));
					} else {
						return '0';
					}
				}
			},//입고량
		],
		columnDefs : [
			//{
			//	targets: [0],
			//	render: function(data) {
			//		return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
			//	}
			//}
		],
		buttons : [
			/* { extend: 'excel',	text: 'Excel',	charset: 'UTF-8', bom: true ,
				exportOptions: {
	                modifier: {
	                   selected:null
	                },	                
	            },
	        },
			{ extend: 'pdf',	text: 'PDF',	},
			{ extend: 'print',	text: 'Print',		charset: 'UTF-8', bom: true },
			{ extend: 'colvis',	text: 'Select Col',	}, */
		],
		order : [],
		drawCallback: function() {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#inputMaterialHistTable_wrapper').find('.dataTables_scrollHead').css('height'));
			let	topHeight = parseFloat($('#rightcolB').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(topHeight - theadHeight - 56)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAllImh').off('keyup',function() {});
			$('#searchAllImh').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			});
		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#inputMaterialHistTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#inputMaterialHistTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	inputMaterialHistTable.on('column-reorder', function( e, settings, details ) {
		let api = inputMaterialHistTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#inputMaterialHistTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	/************************************************************** 모달들 **************************************************************/
	//공정정보모달 조회
	$('#prcssModalTable thead tr').clone(true).addClass('filters').appendTo('#prcssModalTable thead'); // filter 생성
	let prcssModalTable = $('#prcssModalTable').DataTable({
		dom : "<'row'<'col-md-12 col-md-6'l><'col-md-12 col-md-6'f>>"
				+ "<'row'<'col-md-12'tr>>"
				+ "<'row pt-1'<'d-flex align-items-center d-flex'Bp><'me-lg-auto'><'d-flex align-items-center justify-content-end'i>>",
		language: lang_kor,
		info: true,
		ordering: true,
		processing: true,
		paging: false,
		lengthChange: false,
		searching: true,
		autoWidth: false,
		orderCellsTop: true,
        fixedHeader: false,
        scrollY: '100vh',
        scrollX: true,
		pageLength: 100000000,
		colReorder: true,
		select: {
            style: 'multi',
            toggleable: true,
            items: 'row',
            info: false
        },
        ajax : {
			url : '<c:url value="/bm/prcssListAll"/>',
			type : 'GET',
			data : {
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'prcssCd', className : 'text-center'},
			{ data: 'prcssNm', className : 'text-center'},
			{ data: 'qtyUnitNm', className : 'text-center'},
			{ data: 'initial', className : 'text-center'},
			{ data: 'prcssDesc', className : 'text-center'},
		],
		columnDefs : [
			//{
			//	targets: [0],
			//	render: function(data) {
			//		return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
			//	}
			//}
		],
		buttons : [
			{ extend: 'excel',	text: 'Excel',	charset: 'UTF-8', bom: true ,
				exportOptions: {
	                modifier: {
	                   selected:null
	                },	                
	            },
	        },
			{ extend: 'pdf',	text: 'PDF',	},
			{ extend: 'print',	text: 'Print',		charset: 'UTF-8', bom: true },
			{ extend: 'colvis',	text: 'Select Col',	},
		],
		order : [],
		drawCallback: function() {
			let api = this.api();
			let data = api.data();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#prcssModalTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 197)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAll').off('keyup',function() {});
			$('#searchAll').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			});
		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#prcssModalTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#prcssModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	prcssModalTable.on('column-reorder', function( e, settings, details ) {
		let api = prcssModalTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#prcssModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	$(document).on('keyup','input[name=workQty]',function(){
		let tr = $(this).parent().parent().parent(); //해당 tr
		let node = purchaseOrderTable.row(tr).node(); //해당 row의 node
		let tableData = purchaseOrderTable.row(tr).data(); //해당 row의 data
		let ordQty = tableData.ordQty != null && tableData.ordQty != '' ? parseFloat(tableData.ordQty) : 0;
		let workQty = tableData.workQty != null && tableData.workQty != '' ? parseFloat(tableData.workQty) : 0;
		let stockUseQty = isEmptyCheck(tableData.stockUseQty) ? 0 : parseFloat(tableData.stockUseQty);
		
		let unOrdQty = ordQty - workQty - stockUseQty;
		let workQtyCol = purchaseOrderTable.column('workQtyCol:name').index();			//지시수량
		
		if(parseFloat(removeCommas($(this).val())) > unOrdQty){
			$(node).find('td').eq(workQtyCol).find('input[name=workQty]').focus();
			$(node).find('td').eq(workQtyCol).find('input[name=workQty]').val(addCommas(unOrdQty));
			toastr.warning('지시수량이 미지시수량을 넘을 수 없습니다.');
			
		}
	});	

</script>
</body>
</html>