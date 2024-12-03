<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
pageContext.setAttribute("newLineChar", "\n");
%>

<%@include file="../layout/top.jsp"%>
<%@include file="../layout/modal.jsp"%>
<%@include file="../layout/script.jsp"%>
<div id="page" onmouseup="EndDrag(this)" onmousemove="OnDrag(event)" style="grid-template-areas: 'leftcol'; grid-template-rows: 1fr; grid-template-columns: 1fr;">
	<div id="leftcol">
		<div class="container-fluid h-100" style="padding: 5px;">
			<div class="row" id="leftHeader" style="padding-bottom: 5px;">
				<div class="d-flex align-items-center d-flex">
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">조회일시</label>
					<input type="date" class="form-control w-auto h-100 me-1" id="startDate"> 
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
					<select class="form-select w-auto h-100 me-3" id="searchTarget">
						<option value="">전체</option>
						<option value="Y" selected>보유품목</option>
					</select> 
					<input class="form-check-input me-1" type="checkbox" id="notStockSearch" style="height: 100%; margin-top: 0px; width: 30px;" checked>
					<label class="form-label d-flex align-items-center header-label m-0 me-3 h-100">현재고 0 항목 제외</label>
					<input type="text" class="form-control w-auto h-100 me-1 d-none"
						id="searchAll" placeholder="통합검색">
						
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">범례</label>
					<label class="form-label d-flex align-items-center header-label m-0 me-3 h-100" style="background-color: #ffb4b4;">폐기(불량품)창고</label>

					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">품목</label>
					<div class="input-group w-auto h-100 me-3">
						<input type="text" class="form-control" id="searchItemNmNotVersion" disabled>

						<button type="button" class="btnInputDel" style="background-color: transparent; border-color: transparent; position: absolute; top: 0; right: 0; margin: 5px 23px; margin-left: 0px; border: none;">
							<i class="fa-solid fa-xmark"></i>
						</button>
						<input type="hidden" id="searchItemIdxNotVersion">

						<button type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary" id="btnSearchItemNotVersion">
							<i class="fa-solid fa-magnifying-glass"></i>
						</button>
					</div>
						
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end">
					<div class="btn-group" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnNew">
							<i class="fa-solid fa-plus"></i>
						</button>
						<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnSearch">
							<i class="fa-regular fa-clipboard"></i>
						</button>
					</div>
				</div>
			</div>
			<div class="row">
				<table class="table table-bordered p-0 m-0"	id="stockPaymentAdmTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle" style="max-width:50px;">재고생성일</th>
							<th class="text-center align-middle" style="max-width:80px;">수주상세번호</th>
							<th class="text-center align-middle" style="max-width:140px;">고객사</th>
							<th class="text-center align-middle" style="min-width:150px;">품목명</th>
							<th class="text-center align-middle">자재코드</th>
							<th class="text-center align-middle">버전번호</th>
							<th class="text-center align-middle" style="max-width:80px;">수량</th>
							<th class="text-center align-middle" style="max-width:100px;">창고명</th>
							<th class="text-center align-middle" style="max-width:100px;">창고이동</th>
							<th class="text-center align-middle" style="max-width:100px;">폐기등록</th>
							<th class="text-center align-middle" style="max-width:100px;">재고조정</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>
<!-- 품명조회 모달 -->
<div class="modal fade" id="itemNmModal" tabindex="-1"	aria-hidden="true">
	<div class="modal-dialog" style="max-width: 55vw;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">품목 조회</h5>
				<div class="btn-group" role="group" aria-label="Small button group">
					<button type="button" class="btn btn-outline-light w-auto"
						style="font-size: 20px !important;" id="btnItemNmModalPaste">
						<i class="fa-regular fa-paste"></i>
					</button>
					<button type="button" class="btn btn-outline-light w-auto"
						style="font-size: 20px !important;" data-bs-dismiss="modal"
						aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>
			</div>
			<div class="modal-body">
				<!-- <div class="row" style="padding-bottom: 5px;">
					<div class="d-flex align-items-center d-flex">
						<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">품목구분</label>
						<select class="form-select w-auto h-100 me-3" id="itemNmGubun">
							<option value="" selected>전체</option>
							<option value="item">제품</option>
							<option value="matrl">자재</option>
						</select>
					</div>
					<div class="me-lg-auto"></div>
					<div class="d-flex align-items-center justify-content-end">
						<div class="btn-group" role="group" aria-label="Small button group">
							<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnItemNmSearch">
								<i class="fa-regular fa-clipboard"></i>
							</button>
						</div>
					</div>
				</div> -->

				<table class="table table-bordered p-0 m-0" id="itemNmModalTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle">구분</th>
							<th class="text-center align-middle">품명</th>
							<th class="text-center align-middle">버전번호</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>

<!-- 재고이동 모달 -->
<div class="modal fade" id="stockMoveModal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog" style="max-width: 55vw;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">재고이동</h5>
				<div class="btn-group" role="group" aria-label="Small button group">
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnStockMoveSave">
						<i class="fa-regular fa-floppy-disk"></i>
					</button>
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" data-bs-dismiss="modal" aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>
			</div>
			<div class="modal-body">
				<div class="row" style="padding-bottom: 5px;">
					<table class="table table-bordered p-0 m-0">
						<colgroup>
							<col width="20%">
							<col width="30%">
							<col width="20%">
							<col width="30%">
						</colgroup>
						<tbody>
							<tr>
								<th class="text-center align-middle">출고창고</th>
								<td class="text-center align-middle" id="outLocationNm"></td>
								<th class="text-center align-middle">입고창고</th>
								<td class="text-center align-middle">
									<select class="form-select h-100 me-3" style="width:100%;" id="inLocationSelect">
									</select>
								</td>
							</tr>
							<tr>
								<th class="text-center align-middle">이동일자</th>
								<td class="text-center align-middle">
									<input type="date" max="9999-12-31" class="form-control h-100 me-1" id="moveDate" style="width:100%;"> 
								</td>
								<th class="text-center align-middle">이동량</th>
								<td class="text-center align-middle">
									<input type="text" id="moveQty" class="form-control text-end me-1" value="0" onkeyup="numberFormat(this,'int')">
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 재고폐기 모달 -->
<div class="modal fade" id="stockAddModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
	<div class="modal-dialog" style="max-width: 60vw;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="stockAddModalTitle">재고폐기 등록</h5>
				<div class="btn-group" role="group" aria-label="Small button group">
					<button type="button" class="btn btn-outline-light w-auto" id="btnDisposalPrint" >폐기 지시서 출력</button>
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnStockAddModalSave">
						<i class="fa-regular fa-floppy-disk"></i>
					</button>
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" data-bs-dismiss="modal" aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>
			</div>
			<div class="modal-body">
				<div class="row" style="padding: 5px;">
					<table class="table table-bordered p-0 m-0">
						<colgroup>
							<col width="20%">
							<col width="30%">
							<col width="20%">
							<col width="30%">
						</colgroup>
						<tr>
							<th class="text-center align-middle">고객사</th>
							<td class="text-center align-middle" id="stockModalCustomer"></td>
							<th class="text-center align-middle">제품명</th>
							<td class="text-center align-middle" id="stockModalitemNm"></td>
						</tr>
						<tr>
							<th class="text-center align-middle">자재코드</th>
							<td class="text-center align-middle" id="stockModalCustomerItemCd"></td>
							<th class="text-center align-middle">버전번호</th>
							<td class="text-center align-middle" id="stockModalVersionNum"></td>
						</tr>
						<tr>
							<th class="text-center align-middle">사이즈</th>
							<td class="text-center align-middle" id="stockModalSize"></td>
							<th class="text-center align-middle">현재고량</th>
							<td class="text-end align-middle" id="stockModalStockQty"></td>
						</tr>
						<tr>
							<th class="text-center align-middle">폐기코드</th>
							<td class="text-center align-middle">
								<select class="form-select" id="disposalCd">
								</select>
							</td>
							<th class="text-center align-middle">폐기량</th>
							<td class="text-center align-middle">
								<input type="text" style="text-align: right;" class="form-control" id="disposalQty" onkeyup="numberFormat(this,'int')">
							</td>
						</tr>
						<tr>
							<th rowspan="2" class="text-center align-middle">폐기사유</th>
							<td rowspan="2" colspan="3" class="text-center align-middle">
								<textarea class="form-control" style="resize: none; height: 100%;" id="disposalReason"></textarea>
							</td>
						</tr>
						<tr>
						</tr>
						<tr>
							<th class="text-center align-middle">파일첨부</th>
							<td class="text-center align-middle">
								<div style="display: flex; flex-wrap: 1 1 auto;">
									<input type="text" class="form-control" id="disposalFileNm" disabled>
									<button type="button" style="padding: 1px 4px; margin-left: 5px; white-space: nowrap;" class="btn btn-warning input-sub-search" id="btnDisposalFile">업로드
									</button>
									<input class="form-control" style="display: none;" type="file" id="disposalFile">
								</div>
							</td>
							<th class="text-center align-middle">폐기일자</th>
							<td class="text-center align-middle">
								<input type="date" class="form-control" id="disposalDate">
							</td>
						</tr>
						<tr>
							<th class="text-center align-middle">비고사항</th>
							<td colspan="3" class="text-center align-middle">
								<input type="text" class="form-control" id="disposalDesc">
							</td>
						</tr>
					</table>

				</div>
			</div>
		</div>
	</div>
</div>
<!-- 재고폐기 모달 끝 -->
<!-- 폐기지시서 모달 -->
<div class="modal fade" id="disposalReportModal" tabindex="-1" aria-hidden="true" style="z-index: 9999;">
	<div class="modal-dialog" style="max-width: 60vw;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" >폐기지시서 모달</h5>
			</div>
			<div class="modal-body">
				<div class="row" style="padding-bottom: 5px;">
					<table id="disposalReportTable" class="table table-bordered m-0 d-none" style="border:1px solid #ffffff;">
						<colgroup id="trDisposalAppendTarget">
							<col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%">
							<col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%">
							<col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%">
							<col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%">
							<col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%">
						</colgroup>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 폐기지시서 모달 끝 -->

<!-- 실자재고조정 모달 -->
<div class="modal fade" id="stockAdjustModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
	<div class="modal-dialog" style="max-width: 60vw;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="stockAddModalTitle">재고조정</h5>
				<div class="btn-group" role="group" aria-label="Small button group">
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnStockAdjustModalSave">
						<i class="fa-regular fa-floppy-disk"></i>
					</button>
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" data-bs-dismiss="modal" aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>
			</div>
			<div class="modal-body">
				<div class="row" style="padding: 5px;">
					<table class="table table-bordered p-0 m-0">
						<colgroup>
							<col width="20%">
							<col width="30%">
							<col width="20%">
							<col width="30%">
						</colgroup>
						<tr>
							<th class="text-center align-middle">품목명</th>
							<td class="text-center align-middle" colspan="3" id="stockAdjustItemNm"></td>
						</tr>
						<tr>
							<th class="text-center align-middle">버전번호</th>
							<td class="text-center align-middle" id="stockAdjustItemVersion"></td>
							<th class="text-center align-middle">창고명</th>
							<td class="text-center align-middle" id="stockAdjustLocationNm"></td>
						</tr>
						<tr>
							<th class="text-center align-middle">조정 전 수량</th>
							<td class="text-end align-middle" id="stockAdjustBeforeQty"></td>
							<th class="text-center align-middle">조정 후 수량</th>
							<td class="text-center align-middle">
								<input type="text" class="text-end form-control" id="stockAdjustAfterQty" onkeyup="numberFormat(this,'int')">
							</td>
						</tr>
					</table>

				</div>
			</div>
		</div>
	</div>
</div>
<!-- 실자재고조정 모달 끝 -->
<!-- 초기재고 모달 -->
<div class="modal fade" id="stockInitModal" style="z-index: 1050;" tabindex="-1" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
	<div class="modal-dialog" style="max-width: 60vw;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">초기재고</h5>
				<div class="btn-group" role="group" aria-label="Small button group">
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnStockInitModalSave">
						<i class="fa-regular fa-floppy-disk"></i>
					</button>
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" data-bs-dismiss="modal" aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>
			</div>
			<div class="modal-body">
				<div class="row" style="padding: 5px;">
					<table class="table table-bordered p-0 m-0">
						<colgroup>
							<col width="20%">
							<col width="30%">
							<col width="20%">
							<col width="30%">
						</colgroup>
						<tr>
							<th class="text-center align-middle">품목명</th>
							<td class="text-center align-middle" colspan="3">
								<div class="input-group w-auto h-100 me-3">
									<input type="text" class="form-control" id="stockInitItemNm" disabled>			
									<button type="button" id="stockInitItemDel" class="btnInputDel" style="background-color: transparent; border-color: transparent; position: absolute; top: -4px; right: 0; margin: 5px 23px; margin-left: 0px; border: none;">
										<i class="fa-solid fa-xmark"></i>
									</button>
									<input type="hidden" id="stockInitItemIdx">			
									<button type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary" id="btnSearchItem">
										<i class="fa-solid fa-magnifying-glass"></i>
									</button>
								</div>
							</td>
						</tr>
						<tr>
							<th class="text-center align-middle">버전번호</th>
							<td class="text-center align-middle" id="stockInitItemVersion"></td>
							<th class="text-center align-middle">자재코드</th>
							<td class="text-center align-middle" id="stockInitItemCustomerItemCd"></td>
							
						</tr>
						<tr>
							<th class="text-center align-middle">창고명</th>
							<td class="text-center align-middle" id="stockInitLocationNm">
								<select class="form-select h-100 me-3" style="width:100%;" id="stockInitLocationSelect">
								</select>
							</td>
							<th class="text-center align-middle">초기재고 수량</th>
							<td class="text-center align-middle">
								<input type="text" class="text-end form-control" id="stockInitQty" onkeyup="numberFormat(this,'int')">
							</td>
						</tr>
					</table>

				</div>
			</div>
		</div>
	</div>
</div>
<!-- 초기재고 모달 끝 -->


<!-- 화면설정 script -->
<script>
	let isDragging = false;
	
	function SetCursor(cursor) {
		let page = document.getElementById("page");
		page.style.cursor = cursor;
	}
	
	function StartDrag() {
		isDragging = true;
		SetCursor("ew-resize");
	}
	
	function EndDrag(e) {
		if(isDragging) {
			dataTableDrawAll(); // dataTable 전체 reload
			isDragging = false;
			SetCursor("auto");
		}
	}
	
	function OnDrag(event) {
		if (isDragging) {
			let page = document.getElementById("page");
			let leftcol = document.getElementById("leftcol");
			let rightcol = document.getElementById("rightcol");
			let dragbarWidth = 4;
			let leftcolMinWidth = 20; // leftcol 최소사이즈
			$('#leftHeader').children().each(function(index, item) {
				leftcolMinWidth += $(item).width();
			});
			let rightcolMinWidth = 500; // rightcol 최소사이즈
	
			let rightColWidth = isDragging ? page.clientWidth - parseInt(Math.max(leftcolMinWidth + 20, event.clientX)) : rightcol.clientWidth;

			console.log(Math.max(rightColWidth, rightcolMinWidth));
			let cols = [
				parseInt(Math.max(leftcolMinWidth, page.clientWidth - dragbarWidth - parseInt(Math.max(rightColWidth, rightcolMinWidth)))),
				dragbarWidth,
				parseInt(Math.max(rightColWidth, rightcolMinWidth))
			];
	
			let newColDefn = cols.map(c => c.toString() + "px").join(" ");
	
			page.style.gridTemplateColumns = newColDefn;
	
			event.preventDefault()
		}
	}
</script>

<script>
	let monthAdjustList = getCommonCode('시스템', '026'); //날짜조정
	monthAdjustList = _.sortBy(monthAdjustList, v=>parseInt(v.commonCd));
	selectBoxAppend(monthAdjustList, 'monthAdjust', '', '2'); //날짜조정

	//공통코드 조회
	let dealGubunList = getCommonCode('시스템', '011'); // 거래구분
	let dealStatusList = getCommonCode('시스템', '015'); // 거래상태
	let locationModalItemGubunList = getCommonCode('일반', '022'); // 품목구분
	let disposalList = getCommonCode('일반', '038'); //폐기구분

	
	selectBoxAppend(dealGubunList, 'modalDealGubun', '', '1'); //거래구분
	selectBoxAppend(dealStatusList, 'modalDealCorpStatus', '', '1'); //거래상태
	selectBoxAppend(locationModalItemGubunList, 'locationModalItemGubun', '', '1');
	selectBoxAppend(disposalList, 'disposalCd', '', '2'); //폐기구분

	let selectPeriod = parseInt(getCommonCode('시스템', '040')[0].commonCd); //기본조회기간 일
	$('#startDate').val(moment().subtract('d',selectPeriod).format('YYYY-MM-DD'));
	$('#endDate').val(moment().format('YYYY-MM-DD'));

	let locationList = new Array();	//창고 리스트

	//창고리스트 생성
	$.ajax({
		url: '<c:url value="/bm/possibleInLocationList"/>',
        type: 'POST',
        async: false,
        data: {},
		success : function(res) {
			let data = res.data;
			data.forEach((item) => {
				var locationData = new Object();
				locationData.id = item.idx;
				locationData.text = item.lcNm;
				locationData.gubun = item.itemGubun;
				locationList.push(locationData);
			});
		}
	});

	const sessionUserNm = "${userNm}";//세션에서 가져온 유저이름
	
	$('#stockPaymentAdmTable thead tr').clone(true).addClass('filters').appendTo('#stockPaymentAdmTable thead'); // filter 생성
	let stockPaymentAdmTable = $('#stockPaymentAdmTable').DataTable({
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
			url : '<c:url value="/stock/stockPaymentAdmItemLst"/>',
			type : 'POST',
			data : {
				startDate		: function() { return moment($('#startDate').val()).format('YYYYMMDD'); },
				endDate			: function() { return moment($('#endDate').val()).format('YYYYMMDD'); },
				searchTarget	: function() { return $('#searchTarget').val(); },
				notStockSearch	: function() { return $('#notStockSearch').prop('checked') ? 'Y' : 'N'; },
				itemIdx			: function() { return $('#searchItemIdxNotVersion').val(); },
			},
		},
        rowId: '',
		columns : [
			{ data: 'lastProdJson', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						let parseData = JSON.parse(data);
						return moment(parseData[0].JUDGMENT_DATE).format('YYYY-MM-DD');
					} else {
						return '-';
					}
				}
			}, //재고생성일
			{ data: 'lastProdJson', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						let parseData = JSON.parse(data);
						return parseData[0].BIZ_ORD_DTL_NO;
					} else {
						return '재고조정';
					}
				}
			}, //수주상세번호
			{ data: 'dealCorpNm', className : 'text-center align-middle'},//고객사
			{ data: 'spCd', className : 'text-center align-middle'},//품목명
			{ data: 'customerItemCd', className : 'text-center align-middle'},//자재코드
			{ data: 'itemVersion', className : 'text-center align-middle'},//버전번호
			{ data: 'spQty', className : 'text-end align-middle',
				render: function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+ addCommas(parseFloat(data))+'</div>';
					} else {
						return '0';
					}
				}
			},//수량
			{ data: 'lcNm', className : 'text-center align-middle',
				render: function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">' + data + '</div>';
					} else {
						return '0';
					}
				}
			},//창고명
			{ className : 'text-center align-middle',
				render: function(data, type, row, meta) {
					let html = '';	
					//if( parseInt(row['spQty']) > 0 ){
						html += '<div class="btn-group" role="group" aria-label="Small button group">';
						html += '<button type="button" class="btn btn-outline-light w-auto locationStockMove" style="font-size: 15px !important;">창고이동</button>';
						html += '</div>';
					//} else {
					//	html += '<div class="btn-group" role="group" aria-label="Small button group">';
					//	html += '<button disabled type="button" class="btn btn-outline-light w-auto" style="font-size: 15px !important;">창고이동</button>';
					//	html += '</div>';
					//}
					return html;
				}
			},//창고이동
			{ className : 'text-center align-middle',
				render: function(data, type, row, meta) {
					let html = '';
					//if( parseInt(row['spQty']) > 0 ){
						html += '<div class="btn-group" role="group" aria-label="Small button group">';
						html += '<button type="button" class="btn btn-outline-light w-auto disposalNew" style="font-size: 15px !important;">폐기등록</button>';
						html += '</div>';
					//} else {
					//	html += '<div class="btn-group" role="group" aria-label="Small button group">';
					//	html += '<button disabled type="button" class="btn btn-outline-light w-auto" style="font-size: 15px !important;">폐기등록</button>';
					//	html += '</div>';
					//}
					return html;
				}
			},//폐기등록
			{ className : 'text-center align-middle',
				render: function(data, type, row, meta) {
					let html = '';
					//if( parseInt(row['spQty']) > 0 ){
						html += '<div class="btn-group" role="group" aria-label="Small button group">';
						html += '<button type="button" class="btn btn-outline-light w-auto stockAdjust" style="font-size: 15px !important;">재고조정</button>';
						html += '</div>';
					//} else {
					//	html += '<div class="btn-group" role="group" aria-label="Small button group">';
					//	html += '<button disabled type="button" class="btn btn-outline-light w-auto" style="font-size: 15px !important;">재고조정</button>';
					//	html += '</div>';
					//}
					return html;
				}
			},//재고조정
			
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
			let theadHeight = parseFloat($('#stockPaymentAdmTable_wrapper').find('.dataTables_scrollHead').css('height'));
			//let tfootHeight = parseFloat($('#stockPaymentAdmTableTfoot').css('height'));
			
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 78)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAll').off('keyup',function() {});
			$('#searchAll').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			});
			if(data.length > 0){
				$(api.nodes()).find('tbody tr').each(function(index, item) {
					//폐기창고(불량품)
					if( stockPaymentAdmTable.row(item).data().lcQualityGubun == '02') {
						$(stockPaymentAdmTable.row(item).node()).css('background-color','#ffb4b4');
					}
				});
			}
			
		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#stockPaymentAdmTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#stockPaymentAdmTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	stockPaymentAdmTable.on('column-reorder', function( e, settings, details ) {
		let api = stockPaymentAdmTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#stockPaymentAdmTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	// 조회 버튼 click
	$('#btnSearch').on('click', function() {
		$('#my-spinner').show();
		stockPaymentAdmTable.ajax.reload(function() {});

		setTimeout(function() {
			$('#my-spinner').hide();
		}, 100)
	});

	// ---------------------------------------------------------------- 창고목록조회 -------------------------------------------------------------
	// 창고조회버튼 click
	$('#btnSearchLc').on('click', function() {
		$('#locationModal').modal('show');
	});
	$('#locationModal').on('shown.bs.modal', function() {
		locationModalTable.ajax.reload(function() {});
	});

	// 창고조회 x 버튼 click
	$('#btnSearchLcDel').on('click', function() {
		$('#searchLcNm').val('');
		$('#searchLcIdx').val('');
	});

	// 창고관리 목록조회
	$('#locationModalTable thead tr').clone(true).addClass('filters').appendTo('#locationModalTable thead'); // filter 생성
	let locationModalTable = $('#locationModalTable').DataTable({
		dom : "<'row'<'col-md-12 col-md-6'l><'col-md-12 col-md-6'f>>"
				+ "<'row'<'col-md-12'tr>>"
				+ "<'row pt-1'<'d-flex align-items-center d-flex'Bp><'me-lg-auto'><'d-flex align-items-center justify-content-end'i>>",
		language: lang_kor,
		info: true,
		ordering: true,
		processing: false,
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
			url : '<c:url value="/bm/locationAdmList"/>',
			type : 'GET',
			data : {
				itemGubun	:	function() { return $('#locationModalItemGubun').val();}
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'lcCd', className : 'text-center align-middle'},
			{ data: 'lcNm', className : 'text-center align-middle'},
			{ data: 'lcTypeOutput', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data == 'Y') {
						return '<i class="fa-solid fa-check mt-1 text-success"></i>';
					} else {
						return '<i class="fa-solid fa-x mt-1 text-danger"></i>';
					}
				}
			},
			{ data: 'lcTypeInput', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data == 'Y') {
						return '<i class="fa-solid fa-check mt-1 text-success"></i>';
					} else {
						return '<i class="fa-solid fa-x mt-1 text-danger"></i>';
					}
				}
			},
			{ data: 'lcTypeReturn', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data == 'Y') {
						return '<i class="fa-solid fa-check mt-1 text-success"></i>';
					} else {
						return '<i class="fa-solid fa-x mt-1 text-danger"></i>';
					}
				}
			},
			{ data: 'lcTypeQc', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data == 'Y') {
						return '<i class="fa-solid fa-check mt-1 text-success"></i>';
					} else {
						return '<i class="fa-solid fa-x mt-1 text-danger"></i>';
					}
				}
			},
			{ data: 'lcTypeOutsourcing', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data == 'Y') {
						return '<i class="fa-solid fa-check mt-1 text-success"></i>';
					} else {
						return '<i class="fa-solid fa-x mt-1 text-danger"></i>';
					}
				}
			},
			{ data: 'itemGubunNm', className : 'text-center align-middle'},
		],
		columnDefs : [
			{
				targets: '_all',
				render: function(data) {
					return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
				}
			}
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
			
			let htmlHeight = parseFloat($('html').css('height'));
			//let middlecolT_height = parseFloat($('#middlecolT').css('height'));
			let theadHeight = parseFloat($('#locationModalTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#locationModalTable_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 230)+'px');
			
			$('#locationModalTable_filter').addClass('d-none');
			// 통합검색
			$('#searchAllAdm').off('keyup',function() {});
			$('#searchAllAdm').on('keyup',function() {
				$('#locationModalTable_filter').find('input').val($(this).val());
				$('#locationModalTable_filter').find('input').trigger('keyup');
			});
		},
		initComplete: function () {
			let api = this.api();
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#locationModalTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title.replaceAll('*','') + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#locationModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	locationModalTable.on('column-reorder', function( e, settings, details ) {
		let api = locationModalTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#locationModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	// 창고 모달 조회 버튼 click
	$('#btnLocationSearch').on('click', function() {
		$('#my-spinner').show();
		locationModalTable.ajax.reload(function() {});
		
		setTimeout(function() {
			$('#my-spinner').hide();
		}, 100)
	});

	// 창고 모달 붙여넣기 버튼 click
	$('#btnLocationModalPaste').on('click', function() {
		if(!$('#locationModalTable tbody tr').hasClass('selected')){
			toastr.warning('붙여넣을 행을 선택해주세요.');
			return false;
		}
		let data = locationModalTable.row('.selected').data();
		$('#searchLcNm').val(data.lcNm);
		$('#searchLcIdx').val(data.idx);
		$('#locationModal').modal('hide');
	});

	$('#locationModalTable tbody').on('dblclick','tr',function(){
		let data = locationModalTable.row(this).data();
		$('#searchLcNm').val(data.lcNm);
		$('#searchLcIdx').val(data.idx);
		$('#locationModal').modal('hide');
	});

	// 품목추가 버튼 click
	$('#btnSearchItem').on('click', function() {
		$('#itemNmModal').modal('show');
		setTimeout(function() {
			itemNmModalTable.ajax.reload(function() {itemNmModalTable.draw(false);});
		}, 200);
	});

	$('#btnItemNmSearch').on('click',function(){
		itemNmModalTable.ajax.reload(function() {itemNmModalTable.draw(false);});
	});

	$('#btnItemNmModalPaste').on('click',function(){

		if(!$('#itemNmModalTable tbody tr').hasClass('selected')){
			toastr.warning('붙여넣을 행을 선택해주세요.');
			return false;
		}

		let data = itemNmModalTable.row('.selected').data();
		$('#stockInitItemNm').val(data.itemNm);
		$('#stockInitItemIdx').val(data.idx);
		$('#stockInitItemVersion').text(data.itemVersion);
		$('#stockInitItemVersion').data('versionIdx',data.itemVerIdx);
		$('#stockInitItemCustomerItemCd').text(data.customerItemCd);
		//$('#searchItemGubun').val(data.itemMatrlGubun);
		$('#itemNmModal').modal('hide');
		
	});

	$('#btnSearchItemDel').on('click',function(){
		$('#searchItemNm').val('');
		$('#searchItemIdx').val('');
		$('#searchItemGubun').val('');
	});

	$('#searchItemGubun').on('change',function(){
		$('#searchItemNm').val('');
		$('#searchItemIdx').val('');
	});
	
	//제품정보 목록(모달)조회
	$('#itemNmModalTable thead tr').clone(true).addClass('filters').appendTo('#itemNmModalTable thead'); // filter 생성
	let itemNmModalTable = $('#itemNmModalTable').DataTable({
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
            style: 'single',
            toggleable: false,
            items: 'row',
            info: false
        },
        ajax : {
			url : '/bm/itemInfoAndMatrlListAll',
			type : 'POST',
			data : {
				//itemMatrlGubun : function(){return $('#searchItemGubun').val();},
				//기존 페이지 구분이 있었는데 사라지고 제품만 나오게끔 변경됨
				itemMatrlGubun : function(){return 'item';},
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'itemMatrlGubun', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						let text = '';
						if(data == 'item'){
							text = '제품';
						} else {
							text = '자재';
						}
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+text+'</div>';
					} else {
						return "-";
					}
				}	
			},	//구분
			{ data: 'itemNm', className : 'text-center align-middle'}, 		//제품명
			{ data: 'itemVersion', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(row['itemMatrlGubun'] == 'item'){
						if(data != null && data != ''){
								return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						} else {
							return "";
						}
					}
					else {
						return '자재';	
					}
				}	
			}, 	//버전명
		],
		columnDefs : [
			{
				targets: '_all',
				render: function(data) {
					return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
				}
			}
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
			let theadHeight = parseFloat($('#itemNmModalTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 250)+'px');
			
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
				let cell = $('#itemNmModalTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#itemNmModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	itemNmModalTable.on('column-reorder', function( e, settings, details ) {
		let api = itemNmModalTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#itemNmModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	$('#itemNmModalTable tbody').on('dblclick','tr',function(){
		let data = itemNmModalTable.row(this).data();
		$('#stockInitItemNm').val(data.itemNm);
		$('#stockInitItemIdx').val(data.idx);
		$('#stockInitItemVersion').text(data.itemVersion);
		$('#stockInitItemVersion').data('versionIdx',data.itemVerIdx);
		$('#stockInitItemCustomerItemCd').text(data.customerItemCd);

		$('#itemNmModal').modal('hide');
	});
	

	//재고이동 기능
	$(document).on('click', '.locationStockMove', function(){
		let clickObject = $(this);
		let tr = $(clickObject).parent().parent().parent();
		let node = stockPaymentAdmTable.row(tr).node();
		let data = stockPaymentAdmTable.row(tr).data();

		let jsonData = data.lastProdJson;
		if( !isEmptyCheck(jsonData) ){
			jsonData = JSON.parse(jsonData);
			$('#stockMoveModal').data('bizOrdDtlIdx',jsonData[0].BIZ_ORD_DTL_IDX);
		} else {
			$('#stockMoveModal').data('bizOrdDtlIdx','');
		} 
		
		let spGubun = '';
		if(data.spGubun == '002'){
			spGubun = '003';
		} else {
			spGubun = data.spGubun;
		}
		

		$('#inLocationSelect').empty();
		let possibleLocationList = _.filter(locationList, v=> v.gubun == spGubun);
		
		possibleLocationList.forEach(function(item) {
			let option = $('<option value="'+item.id+'">'+item.text+'</option>');
			$('#inLocationSelect').append(option);
		});
		
		$('#outLocationNm').text(data.lcNm);
		$('#moveDate').val(moment().format('YYYY-MM-DD'));
		$('#moveQty').val('0');
		$('#stockMoveModal').data('lcTypeQc',data.lcTypeQc);
		$('#stockMoveModal').data('versionIdx', data.versionIdx);
		$('#stockMoveModal').data('spIdx', data.spIdx);
		$('#stockMoveModal').data('outLocIdx', data.spWhsIdx);
		$('#stockMoveModal').modal('show');
	});

	$('#btnStockMoveSave').on('click',function(){		
		//QC(품질)창고 일경우엔 체크로직 적용 아닐 경우 재고 이동하도록
		if($('#stockMoveModal').data('lcTypeQc') == 'N') {
			let array = [];
			let state = true;
			$('#my-spinner').show();
			//품목 식별자
			let spIdx = $('#stockMoveModal').data('spIdx');
			//품목 버전식별자
			let versionIdx = $('#stockMoveModal').data('versionIdx');
			//출고창고
			let outLocIdx = $('#stockMoveModal').data('outLocIdx');
			//입고창고
			let spWhsIdx = $('#inLocationSelect').val();
			//이동일자
			let moveDate = $('#moveDate').val().replaceAll('-','');
			//이동량
			let moveQty = removeCommas($('#moveQty').val());
			//연관번호
			let relationNo = $('#stockMoveModal').data('bizOrdDtlIdx');

			if(spWhsIdx == '' || spWhsIdx == null){
				$('#inLocationSelect').focus();
				toastr.warning('입고창고를 선택해주세요.');
				$('#my-spinner').hide();
				return false;
			}

			if(moveDate == '' || moveDate == null){
				$('#moveDate').focus();
				toastr.warning('이동일자를 선택해주세요.');
				$('#my-spinner').hide();
				return false;
			}

			if(moveQty == '0' || moveQty == ''){
				$('#moveQty').focus();
				toastr.warning('이동량을 입력해주세요.');
				$('#my-spinner').hide();
				return false;
			}
			
			let obj = new Object();
			obj.SP_IDX = spIdx;
			obj.VERSION_IDX = versionIdx;
			obj.SP_GUBUN = '001'; //수불의 제품값
			obj.OUT_SP_WHS_IDX = outLocIdx;
			obj.IN_SP_WHS_IDX = spWhsIdx;
			obj.SP_QTY = moveQty;
			obj.SP_DATE = moveDate.replaceAll('-','');
			obj.RELATION_NO = relationNo;
			array.push(obj);

			$.ajax({
				url: '<c:url value="/stock/stockMoveIns"/>',
	            type: 'POST',
	            data: {
	            	'insertJson'	:	JSON.stringify(array)
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if (res.result == "ok") { //응답결과
						toastr.success('등록되었습니다.');
						$('#stockMoveModal').modal('hide');
						stockPaymentAdmTable.row('.selected').deselect();
						stockPaymentAdmTable.ajax.reload(function(){}, false);
					} else if(res.result == 'fail') {
						toastr.warning(res.message);
					} else {
						toastr.error(res.message);
					}
					$('#my-spinner').hide();
				}
			});
		} else {
			$.ajax({
				url: '<c:url value="/stock/stockMoveYnCheckByBizOrdDtlIdx"/>',
	            type: 'POST',
	            data: {
	            	'relationNo'	:	function(){ return $('#stockMoveModal').data('bizOrdDtlIdx'); },
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if (res.result == "ok") { //응답결과
						let array = [];
						let state = true;
						$('#my-spinner').show();
						//품목 식별자
						let spIdx = $('#stockMoveModal').data('spIdx');
						//품목 버전식별자
						let versionIdx = $('#stockMoveModal').data('versionIdx');
						//출고창고
						let outLocIdx = $('#stockMoveModal').data('outLocIdx');
						//입고창고
						let spWhsIdx = $('#inLocationSelect').val();
						//이동일자
						let moveDate = $('#moveDate').val().replaceAll('-','');
						//이동량
						let moveQty = removeCommas($('#moveQty').val());
						//연관번호
						let relationNo = $('#stockMoveModal').data('bizOrdDtlIdx');

						if(spWhsIdx == '' || spWhsIdx == null){
							$('#inLocationSelect').focus();
							toastr.warning('입고창고를 선택해주세요.');
							$('#my-spinner').hide();
							return false;
						}

						if(moveDate == '' || moveDate == null){
							$('#moveDate').focus();
							toastr.warning('이동일자를 선택해주세요.');
							$('#my-spinner').hide();
							return false;
						}

						if(moveQty == '0' || moveQty == ''){
							$('#moveQty').focus();
							toastr.warning('이동량을 입력해주세요.');
							$('#my-spinner').hide();
							return false;
						}
						
						let obj = new Object();
						obj.SP_IDX = spIdx;
						obj.VERSION_IDX = versionIdx;
						obj.SP_GUBUN = '001'; //수불의 제품값
						obj.OUT_SP_WHS_IDX = outLocIdx;
						obj.IN_SP_WHS_IDX = spWhsIdx;
						obj.SP_QTY = moveQty;
						obj.SP_DATE = moveDate.replaceAll('-','');

						obj.RELATION_NO = relationNo;
						array.push(obj);

						$.ajax({
							url: '<c:url value="/stock/stockMoveIns"/>',
				            type: 'POST',
				            data: {
				            	'insertJson'	:	JSON.stringify(array)
				            },
				            beforeSend: function() {
				            	$('#my-spinner').show();
				            },
							success : function(res) {
								if (res.result == "ok") { //응답결과
									toastr.success('등록되었습니다.');
									$('#stockMoveModal').modal('hide');
									stockPaymentAdmTable.row('.selected').deselect();
									stockPaymentAdmTable.ajax.reload(function(){}, false);
								} else if(res.result == 'fail') {
									toastr.warning(res.message);
								} else {
									toastr.error(res.message);
								}
								$('#my-spinner').hide();
							}
						});
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

	//폐기 모달
	$(document).on('click', '.disposalNew', function(){
		let clickObject = $(this);
		let tr = $(clickObject).parent().parent().parent();
		let node = stockPaymentAdmTable.row(tr).node();
		let data = stockPaymentAdmTable.row(tr).data();
					
		$('#stockModalCustomer').text(data.dealCorpNm);
		$('#stockModalitemNm').text(data.spCd);
		$('#stockModalCustomerItemCd').text(data.customerItemCd);
		$('#stockModalVersionNum').text(data.itemVersion);
		$('#stockModalSize').text(data.itemSize);
		$('#stockModalStockQty').text(parseInt(data.spQty));
		$('#disposalDate').val(moment().format('YYYY-MM-DD'));
	
		$('#disposalCd').val('01');
		$('#disposalQty').val('0');
		$('#disposalDesc').val('');
		$('#disposalFile').val('');
		$('#disposalFileNm').val('');
		$('#disposalReason').val('');
		$('#disposalDesc').val('');
		
		$('#stockAddModal').modal('show');
	});

	//재고폐기 저장
	$('#btnStockAddModalSave').on('click',function(){
		if( $('#disposalCd').val() == '' ){
			toastr.warning('폐기코드를 선택해주세요.');
			$('#disposalCd').focus();
			return false;
		}
		if( $('#disposalQty').val() == '' || $('#disposalQty').val() == '0' ){
			toastr.warning('폐기량을 입력해주세요.');
			$('#disposalQty').focus();
			return false;
		}
		let formData3 = new FormData();
		let fileInput = document.getElementById('disposalFile');
		let uuid = '';
		let fileFullNm = '';
		let ext = '';
		//업로드된 파일이 있을 경우
		if(fileInput.files.length>0){ 
			let files = fileInput.files; //업로드한 파일들의 정보를 넣는다.
			uuid = uuid_v4();	
			formData3.append('file',files[0]);
			formData3.append('uuid',uuid);
			formData3.append('ext',files[0].name.split('.').at(-1));

			let fileArr = files[0].name.split('.');
			fileFullNm = _.slice(fileArr, 0, -1).join('.');
			ext = files[0].name.split('.').at(-1);
		}
		
		$.ajax({
			url: '<c:url value="/stock/itemDisposalAdmIns"/>',
            type: 'POST',
            data: {
            	'itemIdx'             : function(){ return stockPaymentAdmTable.row('.selected').data().spIdx;},
            	'mangerIdx'           : function(){ return $('#disposalManagerIdx').val();},
            	'produceMangerIdx'    : function(){ return $('#produceManagerIdx').val();},
            	'itemVerIdx'		  : function(){ return stockPaymentAdmTable.row('.selected').data().versionIdx;},
            	'customerItemCd'	  : function(){ return stockPaymentAdmTable.row('.selected').data().customerItemCd;},
            	'disposalCd'          : function(){ return $('#disposalCd').val();},
             	'disposalQty'         : function(){ return $('#disposalQty').val().replaceAll(',','');},
            	'disposalReason'      : function(){ return $('#disposalReason').val();},
            	'fileUuid'            : function(){ return uuid;},
            	'fileNm'              : function(){ return fileFullNm;},
            	'fileExt'             : function(){ return ext;},
            	'disposalDate'        : function(){ return $('#disposalDate').val().replaceAll('-','');},
            	'disposalDesc'        : function(){ return $('#disposalDesc').val();}
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					let data = res.data;
					toastr.success('폐기 등록되었습니다.');

					if( fileInput.files.length>0){
						fileUpload(formData3);
					}
					stockPaymentAdmTable.row('.selected').deselect();
					stockPaymentAdmTable.ajax.reload(function(){}, false);
					$('#stockAddModal').modal('hide');
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
	});
	
	//재고폐기파일추가
	$('#btnDisposalFile').on('click',function(){
		$('#disposalFile').val('');
		$('#disposalFile').trigger('click');
	});

	$('#disposalFile').on('change',function(){
		let fileInput = document.getElementById('disposalFile');
		if(fileInput.files.length>0){ 
			let files = fileInput.files; //업로드한 파일들의 정보를 넣는다.
			$('#disposalFileNm').val(files[0].name);
		}
	});

	//재고조정
	$(document).on('click', '.stockAdjust', function(){
		let clickObject = $(this);
		let tr = $(clickObject).parent().parent().parent();
		let node = stockPaymentAdmTable.row(tr).node();
		let data = stockPaymentAdmTable.row(tr).data();

		$('#stockAdjustItemNm').text(data.spCd);
		$('#stockAdjustItemVersion').text(data.itemVersion);
		$('#stockAdjustLocationNm').text(data.lcNm);
		$('#stockAdjustBeforeQty').text(addCommas(parseInt(data.spQty)));
		$('#stockAdjustAfterQty').val('0');


		$('#stockAdjustModal').data('spIdx', data.spIdx);
		$('#stockAdjustModal').data('versionIdx', data.versionIdx);
		$('#stockAdjustModal').data('spQty', parseInt(data.spQty));
		$('#stockAdjustModal').data('spWhsIdx', data.spWhsIdx);
		$('#stockAdjustModal').modal('show');
	});

	$('#btnStockAdjustModalSave').on('click',function(){
		let spIdx = $('#stockAdjustModal').data('spIdx');
		let versionIdx = $('#stockAdjustModal').data('versionIdx');
		let beforeQty = parseInt($('#stockAdjustModal').data('spQty'));
		let afterQty = parseInt(removeCommas($('#stockAdjustAfterQty').val()));
		let spWhsIdx = $('#stockAdjustModal').data('spWhsIdx');
		
		
		let array = [];
		let obj = new Object();
		obj.saType = 'B';
		obj.saGubun = '001'; //재고현황표로 변경되면서 제품만 보이게됨
		obj.saCd = spIdx;
		obj.itemVerIdx = versionIdx;
		obj.saCmptQty = beforeQty; //전산재고
		obj.saRealQty = afterQty; //실사재고
		obj.saDiffQty = beforeQty - afterQty; //차이수량
		obj.saAppdDate = moment().format('YYYYMMDD');
		obj.saWhsIdx = spWhsIdx;
		obj.saLocIdx = 0;
		obj.saDesc = '';
		array.push(obj);

		$.ajax({
			url: '<c:url value="/stock/adjustmentStockInputAndApply"/>',
            type: 'POST',
            data: {
            	'jsonArray'	:	JSON.stringify(array)
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					toastr.success('조정되었습니다.');

					stockPaymentAdmTable.row('.selected').deselect();
					stockPaymentAdmTable.ajax.reload(function(){}, false);
					$('#stockAdjustModal').modal('hide');					
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
		
			
	});

	//초기재고 등록
	$('#btnNew').on('click',function(){
		$('#stockInitLocationSelect').empty();
		//제품입고가능창고만 보여지게끔
		let possibleLocationList = _.filter(locationList, v=> v.gubun == '001');
		possibleLocationList.forEach(function(item) {
			let option = $('<option value="'+item.id+'">'+item.text+'</option>');
			$('#stockInitLocationSelect').append(option);
		});
		$('#stockInitItemNm').val('');
		$('#stockInitItemIdx').val('');
		$('#stockInitItemVersion').data('versionIdx','');
		$('#stockInitItemVersion').text('');
		$('#stockInitItemCustomerItemCd').text('');
		$('#stockInitQty').val('0');
		$('#stockInitModal').modal('show');
	});

	//모달이벤트들 모달위에 모달 보이게끔 - 급하게 만들어달라해서 임시방편 시간나면 고쳐주세요..........ㅠㅠ
	$('#stockInitModal').on('show.bs.modal',function(){
		$('#stockInitModal').css('z-index','1051');
	});
	
	$('#itemNmModal').on('show.bs.modal',function(){
		$('#stockInitModal').css('z-index','1050');
	});
	
	$('#itemNmModal').on('hide.bs.modal',function(){
		$('#stockInitModal').css('z-index','1051');
	});

	$('#stockInitItemDel').on('click',function(){
		$('#stockInitItemVersion').data('versionIdx','');
		$('#stockInitItemVersion').text('');
		$('#stockInitItemCustomerItemCd').text('');
	});

	$('#btnStockInitModalSave').on('click',function(){
		let array = [];

		let initQty = parseInt(removeCommas($('#stockInitQty').val()));
		let lcIdx = $('#stockInitLocationSelect').val();

		if(lcIdx == 0 || lcIdx  == ''){
			toastr.warning('입고창고를 선택해주세요.');
			$('#stockInitLocationSelect').focus();
			return false;
		}
		
		if(initQty == 0 || initQty == ''){
			toastr.warning('초기재고 수량을<br>입력해주세요.');
			$('#stockInitQty').focus();
			return false;
		}
		
		let obj = new Object();
		obj.saType = 'A';
		obj.saGubun = '001'; //제품이라 하드코딩
		obj.saCd = $('#stockInitItemIdx').val();
		obj.itemVerIdx = $('#stockInitItemVersion').data('versionIdx');
		obj.saCmptQty = 0;
		obj.saRealQty = initQty;
		obj.saDiffQty = 0;
		obj.saAppdDate = moment().format('YYYYMMDD');
		obj.saWhsIdx = lcIdx;
		obj.saLocIdx = '0';
		obj.saDesc = '';
		array.push(obj);

		$.ajax({
			url: '<c:url value="/stock/adjustmentStockInputAndApply"/>',
            type: 'POST',
            data: {
            	'jsonArray'	:	JSON.stringify(array)
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					toastr.success('등록되었습니다.');

					stockPaymentAdmTable.row('.selected').deselect();
					stockPaymentAdmTable.ajax.reload(function(){}, false);
					$('#stockInitModal').modal('hide');					
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
	});

	let pageLengthCnt = parseInt(getCommonCode('시스템', '025')[0].commonCd); //페이징수량
	let itemGubunList = getCommonCode('일반', '001'); // 제품구분
	let useYnCdList = getCommonCode('시스템', '055'); // 사용여부
	
	selectBoxAppend(itemGubunList, 'modalItemGubunBox', '', '1'); //제품구분
	selectBoxAppend(useYnCdList, 'modalUseYnCdBox', 'Y', '1'); //사용여부
	//제품정보 목록(모달)조회
	$('#itemCodeModalTable thead tr').clone(true).addClass('filters').appendTo('#itemCodeModalTable thead'); // filter 생성
	let itemCodeModalTable = $('#itemCodeModalTable').DataTable({
		dom : "<'row'<'col-md-12 col-md-6'l><'col-md-12 col-md-6'f>>"
				+ "<'row'<'col-md-12'tr>>"
				+ "<'row pt-1'<'d-flex align-items-center d-flex col-sm'B><'me-lg-auto div-align-center col-sm'p><'d-flex align-items-center justify-content-end col-sm'i>>",
		language: lang_kor,
		info: true,
		ordering: true,
		processing: true,
		paging: true,
		lengthChange: false,
		searching: true,
		autoWidth: false,
		orderCellsTop: true,
        fixedHeader: false,
        scrollY: '100vh',
        scrollX: true,
		pageLength: pageLengthCnt,
		colReorder: true,
		select: {
            style: 'single',
            toggleable: false,
            items: 'row',
            info: false
        },
        ajax : {
			url : '<c:url value="/bm/itemInfoDtlListAll"/>',
			type : 'GET',
			data : {
				useYnCd		: function(){ return $('#modalUseYnCdBox').val(); }, //사용여부
				itemGubun	: function(){ return $('#modalItemGubunBox').val(); }, //품목구분
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'customerNm', className : 'text-center align-middle'},	//고객사
			{ data: 'itemNm', className : 'text-center align-middle'}, 		//제품명
			{ //건별전달사항
				data: 'relayNotice', className : 'text-start align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space:pre-line;width:330px;">'+data+'</div>';
						
					} else {
						return "";
					}
				}	
			},
			{ data: 'knifeTipSize', className : 'text-center align-middle'}, //칼끝규격
			{ //자재코드
				data: 'customerItemCd', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						
					} else {
						return "";
					}
				}
			},
			{ data: 'versionNum', className : 'text-center align-middle'}, //버전번호
			{ //재질
				data: 'paperType', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						
					} else {
						return "";
					}
				}
			},
			{ //절수
				data: 'cutQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
						
					} else {
						return "";
					}
				}
			},
			{ //개수
				data: 'eaQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
						
					} else {
						return "";
					}
				}
			},
			{ data: 'itemColor', className : 'text-center align-middle'}, //COLOR		
			{ //도수
				data: 'frequencyNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						
					} else {
						return "";
					}
				}
			},
			{ data: 'itemSize', className : 'text-center align-middle'}, //사이즈
			{ data: 'coatingMethod', className : 'text-center align-middle'}, //코팅방법
			{ //특이사항
				data: 'specialNotice', className : 'text-start align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space:pre-line;width:330px;">'+data+'</div>';
						
					} else {
						return "";
					}
				}
			},
			{ data: 'moldingMethod', className : 'text-center align-middle'}, //성형방식
			{ data: 'moldingContents', className : 'text-center align-middle'}, //성형내용
			{ //묶음법
				data: 'bundleMethodNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						
					} else {
						return "";
					}
				}
			},
			{ data: 'bundleUnit', className : 'text-center align-middle'}, //묶음단위
			{//포장박스
				data: 'packMethodNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return "";
					}
				}
			},
			{ data: 'packUnit', className : 'text-center align-middle'}, //포장단위
			{ //호기
				data: 'etc1Nm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						
					} else {
						return "";
					}
				}
			},
			{ //목형번호
				data: 'woodenCareNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						
					} else {
						return "";
					}
				}
			},
			{ data: 'holeWoodenCd', className : 'text-center align-middle'}, //타공목형번호
			{ //수지판번호
				data: 'resinBoardNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						
					} else {
						return "";
					}
				}
			},
			{ //현재고량
				data: 'stock', className : 'text-end  align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseInt(data))+'</div>';
						
					} else {
						return "";
					}
				}
			},
			{ //검수방법
				data: 'inspectMethodNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						
					} else {
						return "";
					}
				}
			},
			{//착인여부
				data: 'printingYnCheckNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						
					} else {
						return "";
					}
				}
			},
			{ //사용여부
				data: 'useYnCd', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data == 'Y'){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">사용</div>';
					} else if (data == 'N'){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">미사용</div>';
					} else {
						return "";
					}
				}
			},
			{ //등록일자
				data: 'detailDate', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data,'YYYY-MM-DD').format('YYYY-MM-DD')+'</div>';
						
					} else {
						return "";
					}
				}
			},
			{ //후가공판번호
				data: 'etc2Cd', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						
					} else {
						return "";
					}
				}
			},		
			{ data: 'etc3', className : 'text-center align-middle'}, //부분UV	
			{ data: 'etc4', className : 'text-center align-middle'}, //FOIL	
			{ data: 'etc6', className : 'text-center align-middle'}, //형압
			{ data: 'etc7', className : 'text-center align-middle'}, //FSC 유무
			{ data: 'etc8', className : 'text-center align-middle'}, //납품처
			{ data: 'etc9', className : 'text-center align-middle'}, //공정실적여부
			{ data: 'etc10', className : 'text-center align-middle'}, //기타1
			{ data: 'etc5', className : 'text-center align-middle'}, //기타2
			{ data: 'pressMethod', className : 'text-center align-middle'},	//기타3
		],
		columnDefs : [
			{
				targets: '_all',
				render: function(data) {
					return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
				}
			}
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
			let theadHeight = parseFloat($('#itemCodeModalTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 250)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#modalItemCodeSearchAll').off('keyup',function() {});
			$('#modalItemCodeSearchAll').on('keyup',function() {
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
				let cell = $('#itemCodeModalTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#itemCodeModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	itemCodeModalTable.on('column-reorder', function( e, settings, details ) {
		let api = itemCodeModalTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#itemCodeModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});
	
	$('#btnItemCodeModalSearch').on('click',function(){
		itemCodeModalTable.ajax.reload(function() {});
	});

	$('#btnSearchItemNotVersion').on('click',function(){
		itemCodeModalTable.ajax.reload(function() {itemCodeModalTable.draw(false);});
		$('#itemCodeModal').modal('show');
	});

	$('#btnItemCodeModalPaste').on('click',function(){
		if( !$('#itemCodeModalTable tbody tr').hasClass('selected') ){
			toastr.warning('붙여넣을 행을 선택해주세요.');
			return false;
		}

		let data = itemCodeModalTable.row('.selected').data();
		$('#searchItemNmNotVersion').val(data.itemNm);
		$('#searchItemIdxNotVersion').val(data.idx);
		$('#itemCodeModal').modal('hide');
	});

	$('#itemCodeModalTable tbody').on('dblclick','tr',function(){
		let data = itemCodeModalTable.row(this).data();
		$('#searchItemNmNotVersion').val(data.itemNm);
		$('#searchItemIdxNotVersion').val(data.idx);
		$('#itemCodeModal').modal('hide');
	});
	
	
</script>
<!-- 출력물 -->
<script>
	//초기 셋팅
	$(document).ready(function() {
		//폐기지시서
		$('#trDisposalAppendTarget').after(makeDisposalReport());
		cssChange('disposalReportTable');
		$('#disposalReportTable').removeClass('d-none');
		$('#my-spinner').hide();
		
	});	

	//폐기지시서 출력
	$('#btnDisposalPrint').on('click',function(){
	
		//견본첨부파일 이미지변환
		let fileInput = document.getElementById('disposalFile'); 
		if(fileInput.files.length>0){
			let files = fileInput.files; //업로드한 파일들의 정보를 넣는다.
	
			for(let i = 0; i < document.querySelector('#disposalFile').files.length; i++){
				let bases64 = getImgBase64(files[i]);
				$('#disposalReportTable [name=disposalImage]').attr('src','data:image/jpeg;base64,'+bases64);
				$('#disposalReportTable [name=disposalImage]').css('display','');
			}
		} else {
			$('#disposalReportTable [name=disposalImage]').attr('src','');
		}
		
		$('#disposalReportTable td[name=printDate]').text(moment().format('YYYY/MM/DD'));
	
		let data = stockPaymentAdmTable.row('.selected').data();
		$('#disposalReportTable [name=customerNm]').text(data.dealCorpNm);
		$('#disposalReportTable [name=itemNm]').text(data.spCd);
		$('#disposalReportTable [name=paperType]').text(data.paperType);
		$('#disposalReportTable [name=itemColor]').text(data.itemColor);
		$('#disposalReportTable [name=itemSize]').text(data.itemSize);
		$('#disposalReportTable [name=coatingMethod]').text(data.coatingMethod);
		$('#disposalReportTable [name=moldingMethod]').text(data.moldingMethod);
		$('#disposalReportTable [name=customerItemCd]').text(data.customerItemCd);
		$('#disposalReportTable [name=itemVersion]').text(data.itemVersion);
		$('#disposalReportTable [name=disposalQty]').text(addCommas(parseInt(removeCommas($('#disposalQty').val()))));
	
		$('#disposalReportTable [name=disposalReason]').text($('#disposalReason').val());
		if( !isEmptyCheck(data.lastProdJson) ) {
			let jsonParseData = JSON.parse(data.lastProdJson);
			$('#disposalReportTable [name=lastProdDate]').text(moment(jsonParseData[0].JUDGMENT_DATE).format('YYYY/MM/DD'));
		} else {
			$('#disposalReportTable [name=lastProdDate]').text('');
	
		}
		//$('#disposalReportTable [name=disposalDate]').text(moment($('#disposalDate').val()).format('YYYY년 MM월 DD일'));
		$('#disposalReportTable [name=mangerNm]').text($('#disposalManagerNm').val());
		$('#disposalReportTable [name=produceMangerNm]').text($('#produceManagerNm').val());
		
		$('#disposalReportTable').print({
			globalStyles: true,
			mediaPrint: true
		});
	});

	function cssChange(tableId){
		$('#'+tableId).find('td').css('font-weight', '900');
		$('#'+tableId).find('td').css('border', '1px solid black');
		$('#'+tableId).find('td').css('padding', '0.1rem');
		$('#'+tableId).find('td').css('color', '#000000');

		$('#'+tableId).find('.fw900').css('font-weight', '900');
		$('#'+tableId).find('.fw-bold').css('font-weight', 'bold');
		$('#'+tableId).find('.bd2px').css('border', '2px solid black');


		$('#'+tableId).find('.text-bottom-black-line').css('text-decoration', 'underline');
		$('#'+tableId).find('.text-bottom-black-line').css('text-decoration-color', '#9E9E9E');
		$('#'+tableId).find('.text-bottom-black-line').css('text-decoration-thickness', '1px');
		
		$('#'+tableId).find('.bg-gray').css('background-color', '#C9C9C9');
		
		$('#'+tableId).find('.theadFirstCol').css('border-top', '0px');
		//$('#'+tableId).find('.theadFirstCol').css('border-left', '2px');
		$('#'+tableId).find('.theadNotFisrtCol').css('border-top', '0px');
		$('#'+tableId).find('.theadNotFisrtCol').css('border-left', '0px');
		
		$('#'+tableId).find('.tbodyFirstCol').css('border-top', '0px');
		//$('#'+tableId).find('.tbodyFirstCol').css('border-left', '2px');
		$('#'+tableId).find('.tbodyNotFirstCol').css('border-top', '0px');
		$('#'+tableId).find('.tbodyNotFirstCol').css('border-left', '0px');

		//$('#'+tableId).find('.bd-doblue').css('border', '5px double');
		
		$('#'+tableId).find('.fc-red').css('color', '#ff0000');
		$('#'+tableId).find('.fc-blue').css('color', '#0070C0');
		$('#'+tableId).find('.fc-gray').css('color', '#d3d3d3');
		$('#'+tableId).find('.fs-8').css('font-size', '8px');
		$('#'+tableId).find('.fs-10').css('font-size', '10px');
		$('#'+tableId).find('.fs-11').css('font-size', '11px');
		$('#'+tableId).find('.fs-12').css('font-size', '12px');
		$('#'+tableId).find('.fs-13').css('font-size', '13px');
		$('#'+tableId).find('.fs-15').css('font-size', '15px');
		$('#'+tableId).find('.fs-20').css('font-size', '20px');
		$('#'+tableId).find('.fs-25').css('font-size', '25px');
		$('#'+tableId).find('.fs-30').css('font-size', '30px');
		$('#'+tableId).find('.fs-50').css('font-size', '50px');
		$('#'+tableId).find('.fc-red').css('color', '#ff0000');
		$('#'+tableId).find('.bt-2').css('border-top', '2px solid black');
		$('#'+tableId).find('.bd-n').css('border', '0px solid #ffffff');
		$('#'+tableId).find('.bt-n').css('border-top', '0px solid #ffffff');
		$('#'+tableId).find('.br-n').css('border-right', '0px solid #ffffff');
		$('#'+tableId).find('.bb-n').css('border-bottom', '0px solid #ffffff');
		$('#'+tableId).find('.bl-n').css('border-left', '0px solid #ffffff');
		$('#'+tableId).find('.h-5').css('height', '5px');
		$('#'+tableId).find('.h-10').css('height', '10px');
		$('#'+tableId).find('.h-20').css('height', '20px');
		$('#'+tableId).find('.h-25').css('height', '25px');
		$('#'+tableId).find('.h-30').css('height', '30px');
		$('#'+tableId).find('.h-40').css('height', '40px');
		$('#'+tableId).find('.h-55').css('height', '55px');
		$('#'+tableId).find('.h-70').css('height', '70px');
		$('#'+tableId).find('.h-75').css('height', '75px');
		$('#'+tableId).find('.h-90').css('height', '90px');
		$('#'+tableId).find('.h-100').css('height', '100px');
		$('#'+tableId).find('.h-270').css('height', '270px');
		$('#'+tableId).find('.maxh-5').css('max-height', '5px');
		$('#'+tableId).find('.maxh-10').css('max-height', '10px');
		$('#'+tableId).find('.maxh-20').css('max-height', '20px');
		$('#'+tableId).find('.maxh-25').css('max-height', '25px');
		$('#'+tableId).find('.maxh-30').css('max-height', '30px');
		$('#'+tableId).find('.maxh-40').css('max-height', '40px');
		$('#'+tableId).find('.maxh-55').css('max-height', '55px');
		$('#'+tableId).find('.maxh-70').css('max-height', '70px');
		$('#'+tableId).find('.maxh-75').css('max-height', '75px');
		$('#'+tableId).find('.maxh-100').css('max-height', '100px');
		$('#'+tableId).find('.maxh-270').css('max-height', '270px');
		

		// 인쇄할 때 css 적용하려면 important 붙여줘야함.
		for(var i=0;i<$('#'+tableId).find('td').length;i++) {
			let tdStyle = $('#'+tableId).find('td').eq(i).attr('style') == undefined?'':$('#'+tableId).find('td').eq(i).attr('style');
			$('#'+tableId).find('td').eq(i).attr('style',tdStyle.replaceAll(';',' !important;'));
		}
	}

	function makeDisposalReport(){
		let html = '';
		
		html += '<tr style="page-break-before: always!important;">';
		html += '		<td class="bd-n h-25" colspan="30">';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="28" class="fs-25 fw900 bd-n align-middle text-center bt-n bl-n br-n">재고 폐기 지시서</td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';
		
		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="8" class="text-center max-h55 h-55 bd-n align-middle bt-n bl-n br-n" style="border-width: 0px 0px 2px !important; border-style: solid !important; border-color: rgb(255, 255, 255) rgb(255, 255, 255) black !important; border-image: initial !important; padding: 0.1rem !important; color: rgb(0, 0, 0) !important; height: 55px !important;"><img src="/resources/assets/images/header_logo.png" style="width:100%;height:100%;"></td>';
		html += '	<td colspan="13" class="bd-n"></td>';
		html += '	<td colspan="3" class="fs-15 bt-n bl-n br-n text-start align-bottom">DATE : </td>';
		html += '	<td colspan="4" class="fs-15 bt-n bl-n br-n text-start align-bottom" name="printDate"></td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';
		
		html += '<tr>';
		html += '	<td class="bd-n h-20" colspan="30">';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="5" class="fs-15 bd-n text-start align-middle text-bottom-black-line">1. 거 래 처 : </td>';
		html += '	<td colspan="23" class="fs-15 bd-n text-start align-middle text-bottom-black-line" name="customerNm"></td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td class="bd-n h-20" colspan="30">';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="5" class="fs-15 bd-n text-start align-middle text-bottom-black-line">2. 제 품 명 : </td>';
		html += '	<td colspan="23" class="fs-15 bd-n text-start align-middle text-bottom-black-line" name="itemNm"></td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td class="bd-n h-20" colspan="30">';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="5" class="fs-15 bd-n text-start align-middle text-bottom-black-line">3. 구성정보 </td>';
		html += '	<td colspan="23" class="fs-15 bd-n text-start align-middle"></td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="8" class="fs-15 text-center align-middle bb-n">지질</td>';
		html += '	<td colspan="7" class="fs-15 text-center align-middle bb-n">칼라</td>';
		html += '	<td colspan="4" class="fs-15 text-center align-middle bb-n">규격</td>';
		html += '	<td colspan="4" class="fs-15 text-center align-middle bb-n">코팅</td>';
		html += '	<td colspan="5" class="fs-15 text-center align-middle bb-n">성형방법</td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="8" class="fs-15 h-20 text-center align-middle" name="paperType"></td>';
		html += '	<td colspan="7" class="fs-15 text-center align-middle" name="itemColor"></td>';
		html += '	<td colspan="4" class="fs-15 text-center align-middle" name="itemSize"></td>';
		html += '	<td colspan="4" class="fs-15 text-center align-middle" name="coatingMethod"></td>';
		html += '	<td colspan="5" class="fs-15 text-center align-middle" name="moldingMethod"></td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td class="bd-n h-20" colspan="30">';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="5" class="fs-15 bd-n text-start align-middle text-bottom-black-line">4. 세부내용 </td>';
		html += '	<td colspan="23" class="fs-15 bd-n text-start align-middle"></td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="15" class="fs-15 text-center align-middle bb-n">구분</td>';
		html += '	<td colspan="3" class="fs-15 text-center align-middle bb-n">점검여부</td>';
		html += '	<td colspan="5" class="fs-15 text-center align-middle bb-n">점검자</td>';
		html += '	<td colspan="5" class="fs-15 text-center align-middle bb-n">확인자</td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="5" class="fs-15 text-center align-middle bb-n">자재번호</td>';
		html += '	<td colspan="10" class="fs-15 text-center align-middle bb-n" name="customerItemCd"></td>';
		html += '	<td colspan="3" class="fs-15 text-center align-middle bb-n">□</td>';
		html += '	<td colspan="5" class="fc-gray fs-15 text-center align-middle bb-n">서 명</td>';
		html += '	<td colspan="5" class="fc-gray fs-15 text-center align-middle bb-n">서 명</td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="5" class="fs-15 text-center align-middle bb-n">버전번호</td>';
		html += '	<td colspan="10" class="fs-15 text-center align-middle bb-n" name="itemVersion"></td>';
		html += '	<td colspan="3" class="fs-15 text-center align-middle bb-n">□</td>';
		html += '	<td colspan="5" class="fc-gray fs-15 text-center align-middle bb-n">서 명</td>';
		html += '	<td colspan="5" class="fc-gray fs-15 text-center align-middle bb-n">서 명</td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="5" class="fs-15 text-center align-middle bb-n">생성일자</td>';
		html += '	<td colspan="10" class="fs-15 text-center align-middle bb-n" name="lastProdDate"></td>';
		html += '	<td colspan="3" class="fs-15 text-center align-middle bb-n">□</td>';
		html += '	<td colspan="5" class="fc-gray fs-15 text-center align-middle bb-n">서 명</td>';
		html += '	<td colspan="5" class="fc-gray fs-15 text-center align-middle bb-n">서 명</td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="5" class="fs-15 text-center align-middle ">재고량</td>';
		html += '	<td colspan="10" class="fs-15 text-center align-middle" name="disposalQty"></td>';
		html += '	<td colspan="3" class="fs-15 text-center align-middle ">□</td>';
		html += '	<td colspan="5" class="fc-gray fs-15 text-center align-middle ">서 명</td>';
		html += '	<td colspan="5" class="fc-gray fs-15 text-center align-middle ">서 명</td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';
		
		html += '<tr>';
		html += '	<td class="bd-n h-20" colspan="30">';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="5" class="fs-15 bd-n text-start align-middle text-bottom-black-line">5. 폐기사유 </td>';
		html += '	<td colspan="23" class="fs-15 bd-n text-start align-middle"></td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="28" class="fs-15 bd-n text-start align-middle"> ';
		html += '	<textarea rows="2" name="disposalReason" class="form-control text-start p-0"'; 
		html += '		style="background-color: #f2f2f2;resize: none; overflow: hidden;font-size:15px!important;';
		html += '		border: none !important; width:100%;"></textarea>'; 
		html += '	</td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td class="bd-n h-20" colspan="30">';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="5" class="fs-15 bd-n text-start align-middle text-bottom-black-line">6. 견본첨부</td>';
		html += '	<td colspan="23" class="fs-15 bd-n text-start align-middle"></td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td class="bd-n h-270 maxh-270" colspan="30"><img name="disposalImage" onerror="this.style.display=\'none\'" style="object-fit: contain; height: 100%; width: 100%;" src=""> </td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="5" class="fs-15 bd-n text-start align-middle text-bottom-black-line">7. 폐기일자 :</td>';
		html += '	<td colspan="23" class="fs-15 bd-n text-start align-middle text-bottom-black-line" name="disposalDate">';
		html += '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;년&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;월&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;일</td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';


		html += '<tr>';
		html += '	<td class="bd-n h-20" colspan="30">';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="2" class="fs-15 text-center">담당</td>';
		html += '	<td colspan="4" class="fs-15 text-center">' + sessionUserNm + '</td>';
		html += '	<td colspan="5" class="fs-15 text-center">제조관리 책임자</td>';
		html += '	<td colspan="5" class="fs-15 text-center" name="mangerNm"></td>';
		html += '	<td colspan="6" class="fs-15 text-center">QA</td>';
		html += '	<td colspan="6" class="fs-15 text-center" name="produceMangerNm"></td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td class="bd-n h-10" colspan="30">';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="28" class="fs-15 bd-n text-start">문서번호 : 재고폐기지시서 230701-02 </td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';  
		
		return html;
	}
	
	
</script>

</body>
</html>
