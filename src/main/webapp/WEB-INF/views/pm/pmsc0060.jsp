<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
pageContext.setAttribute("newLineChar", "\n");
%>

<%@include file="../layout/top.jsp"%>
<%@include file="../layout/modal.jsp"%>
<%@include file="../layout/script.jsp"%>
<div id="page" onmouseup="EndDrag()" onmousemove="OnDrag(event)" style="grid-template-areas: 'leftcol dragbar rightcol';
																		grid-template-rows: 1fr;
																		grid-template-columns: 1.1fr 4px 1fr;">
	<div id="leftcol">
		<div class="container-fluid h-100" style="padding: 5px;">
			<div class="row" id="leftHeader" style="padding-bottom: 5px;">
				<div class="d-flex align-items-center d-flex">
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">수주등록일</label>
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

				</div>
				<div class="me-lg-auto"></div>
				<div class="btn-group me-3" role="group" aria-label="Small button group">
					<button type="button" class="btn btn-outline-light w-auto d-none" id="btnEnd">마감</button>
				</div>
				<div class="d-flex align-items-center justify-content-end">
					<div class="btn-group" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnSearch">
							<i class="fa-regular fa-clipboard"></i>
						</button>
						<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnAdd">
							<i class="fa-solid fa-cart-plus"></i>
						</button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnOpen">
							<i class="fa-solid fa-caret-left"></i>
						</button>
					</div>
				</div>
			</div>
			<div class="row" id="leftSecondHeader" style="padding-bottom: 5px;">
				<div class="d-flex align-items-center d-flex">
					
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100" style="min-height:30px;">조회대상</label>
					<select class="form-select w-auto h-100 me-3" id="searchTarget" style="min-width: 70px;">
						<option value="">전체</option>
						<option value="Y">발주대기</option>
						<option value="N" selected>미입고</option>
					</select> 
					<input class="form-check-input me-1" type="checkbox" id="stockUseNotSearch" style="height: 100%; margin-top: 0px; width: 30px;" checked>
					<label class="form-label d-flex align-items-center header-label m-0 me-3 h-100">재고사용제외</label>

					<!-- <label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">범례</label>
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100 bg-danger bg-gradient">미달재고</label> -->
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">범례</label>
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100 fw-bolder" style="background-color: #f6d0d4">가용재고 &lt; 0</label>
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100 fw-bolder" style="background-color: #D9D2E9">가용재고 &lt;= 적정재고</label>
					<input type="text" class="form-control w-auto h-100 me-1" id="searchAll" placeholder="통합검색">
				</div>
				<div class="me-lg-auto"></div>
				<div class="btn-group me-3" role="group" aria-label="Small button group">
				</div>
				<div class="d-flex align-items-center justify-content-end">
					
				</div>
			</div>
			<div class="row">
				<table class="table table-bordered p-0 m-0" id="matrlTable">
					<thead class="table-light">
						<tr>
							<!-- <th class="text-center align-middle">재질</th>
							<th class="text-center align-middle">수주상세번호</th>
							<th class="text-center align-middle">수주상태</th>
							<th class="text-center align-middle">수주일</th>
							<th class="text-center align-middle">수주고객사</th>
							<th class="text-center align-middle" style="min-width:200px;">제품명</th>
							<th class="text-center align-middle">목표일</th>
							<th class="text-center align-middle" style="min-width:80px;">적정재고</th>
							<th class="text-center align-middle" style="min-width:80px;">발주량</th>
							<th class="text-center align-middle" style="min-width:80px;">입고량</th>
							<th class="text-center align-middle">입고일</th>
							<th class="text-center align-middle">개별발주</th>
							<th class="text-center align-middle">재고사용</th>
							<th class="text-center align-middle">발주확정</th> -->
							
							<th class="text-center align-middle">수주상태</th>
							<th class="text-center align-middle">수주상세번호</th>
							<th class="text-center align-middle">고객사</th>
							<th class="text-center align-middle" style="min-width:200px;">제품명</th>
							<th class="text-center align-middle" style="min-width:200px;">재질</th>
							<th class="text-center align-middle">수주일</th>
							<th class="text-center align-middle">목표일</th>
							<th class="text-center align-middle">입고일</th>
							<th class="text-center align-middle" style="min-width:80px;">발주량</th>
							<th class="text-center align-middle" style="min-width:80px;">입고량</th>
							<th class="text-center align-middle">재고사용</th>
							<th class="text-center align-middle">발주확정</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
	<div id="dragbar" onmousedown="StartDrag()"></div>
	<div id="rightcol">
		<div class="container-fluid h-100" style="padding: 5px;">
			<div class="row" id="rightHeader" style="padding-bottom: 5px;">
				<div class="d-flex align-items-center d-flex">
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">발주일자</label>
					<input type="date" max="9999-12-31" class="form-control w-auto h-100 me-1" id="startDate2"> 
					<label class="form-label d-flex align-items-center m-0 me-1 h-100">~</label>
					<input type="date" max="9999-12-31" class="form-control w-auto h-100 me-1" id="endDate2"> 
					<select class="form-select w-auto h-100 me-1 monthAdjust" id="monthAdjust2">
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

				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end">
					<div class="btn-group" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnSearchDtl">
							<i class="fa-regular fa-clipboard"></i>
						</button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnSave" disabled>
							<i class="fa-regular fa-floppy-disk"></i>
						</button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnEdit">
							<i class="fa-regular fa-pen-to-square"></i>
						</button>
						<button type="button" class="btn btn-outline-danger w-auto" style="font-size: 17px !important;" id="btnDel">
							<i class="fa-solid fa-trash-can"></i>
						</button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnCancel" disabled>
							<i class="fa-solid fa-xmark"></i>
						</button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnClose">
							<i class="fa-solid fa-caret-right"></i>
						</button>
					</div>
				</div>
			</div>
			<div class="row" id="rightSecondHeader" style="padding-bottom: 5px;">
				<div class="d-flex align-items-center d-flex">
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100" style="min-height:30px;">입고대상</label>
					<select class="form-select w-auto h-100 me-3" id="searchInMatrlTarget" style="min-width: 70px;">
						<option value="">전체</option>
						<option value="Y">입고완료</option>
						<option value="N" selected>입고대상</option>
					</select>
					<input type="text" class="form-control w-auto h-100 me-1" id="searchAllPoa" placeholder="통합검색">
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end">
				</div>
			</div>
			<div class="row">
				<table class="table table-bordered p-0 m-0" id="purchaseOrderAdmTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle">확정여부</th>
							<!-- <th class="text-center align-middle">진행상태</th> -->
							<th class="text-center align-middle">출력<br>여부</th>
							<th class="text-center align-middle">발주번호</th>
							<th class="text-center align-middle">발주일자</th>
							<th class="text-center align-middle">입고예정일</th>
							<th class="text-center align-middle">재질</th>
							<th class="text-center align-middle">발주처</th>
							<th class="text-center align-middle" style="min-width:60px;">발주량</th>
							<!-- <th class="text-center align-middle">이론량Ⓡ</th>
							<th class="text-center align-middle">발주량Ⓡ</th>
							<th class="text-center align-middle">절수</th>
							<th class="text-center align-middle">개수</th>
							<th class="text-center align-middle">여분</th>
							<th class="text-center align-middle">이론통수</th>
							<th class="text-center align-middle">재단규격</th>
							<th class="text-center align-middle">참고사항</th>
							<th class="text-center align-middle">비고</th> -->
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>
<!-- 거래처 모달 -->
<div class="modal fade" id="dealCorpSelectModal" tabindex="-1" aria-hidden="true" style="z-index: 9999;">
	<div class="modal-dialog" style="max-width: 60vw;">
		<div class="modal-content" style="height: calc(100vh - 5em);">
			<div class="modal-header">
				<h5 class="modal-title">발주처 조회</h5>
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
							<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnDealCorpSelectSearch">
								<i class="fa-regular fa-clipboard"></i>
							</button>
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

<!-- 마감 경고 -->
<div class="modal fade" id="endModal" tabindex="-1" aria-hidden="true" style="z-index: 9999;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">
					<i class="fa-solid fa-triangle-exclamation text-danger"></i>
					<%-- <spring:message code="modal.warning" text="default text" /> --%>
					가용재고 마감
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
					<tbody>
						<tr>
							<th class="text-center align-middle">마감시작일</th>
							<td class="text-center align-middle">
								<input type="date" max="9999-12-31" class="form-control" id="asStockStartDate">
							</td>
							<th class="text-center align-middle">마감종료일</th>
							<td class="text-center align-middle">
								<input type="date" max="9999-12-31" class="form-control" id="asStockEndDate">
							</td>
						</tr>
					</tbody>
				</table>
			
				가용재고 마감 시 이전 데이터가 있을경우 삭제 후<br> 현시점 가용재고로 마감데이터가 생성됩니다.<br>
				<label class="" style="color: red;">마감시작일부터 마감종료일까지의 마감수량이 변경되며<br>데이터 생성으로 인해 시간이 걸릴 수 있습니다.</label>
				<br>
				계속하시겠습니까?
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" id="btnEndModalY"  style="width: 70px;">
					마감
				</button>
				<button type="button" class="btn btn-secondary" id="btnEndModalN" data-bs-dismiss="modal" style="width: 70px;">
					취소
				</button>
			</div>
		</div>
	</div>
</div>
<!-- 마감 경고 모달 끝 -->

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
			let rightcolMinWidth = 880; // rightcol 최소사이즈
	
			let rightColWidth = isDragging ? page.clientWidth - parseInt(Math.max(leftcolMinWidth + 20, event.clientX)) : rightcol.clientWidth;

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
	
	$('#btnOpen').on('click',function() { // right-box 열기버튼 클릭
		if($('#rightcol').hasClass('d-none')){
			$('#page').css('grid-template-columns', '1.1fr 4px 1fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcol').removeClass('d-none');
		} else {
			$('#page').css('grid-template-columns', '0fr 4px 1fr');
			$('#leftcol').addClass('d-none');
			$('#rightcol').removeClass('d-none');
		}
		dataTableDrawAll(); // dataTable 전체 reload
	});
	$('#btnClose').on('click',function() { // right-box 닫기버튼 클릭
		if($('#leftcol').hasClass('d-none')){
			$('#page').css('grid-template-columns', '1.1fr 4px 1fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcol').removeClass('d-none');
		} else {
			$('#page').css('grid-template-columns', '1.1fr 4px 0fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcol').addClass('d-none');
		}
		dataTableDrawAll(); // dataTable 전체 reload
	});
</script>

<script>
	WM_init('ADM');

	let monthAdjustList = getCommonCode('시스템', '026'); //날짜조정
	monthAdjustList = _.sortBy(monthAdjustList, v=>parseInt(v.commonCd));
	selectBoxAppend(monthAdjustList, 'monthAdjust', '', '2'); //날짜조정
	selectBoxAppend(monthAdjustList, 'monthAdjust2', '', '2'); //날짜조정
	
	let dealGubunList = getCommonCode('시스템', '011'); // 거래구분
	let dealCorpStatusList = getCommonCode('시스템', '015'); // 거래상태
	selectBoxAppend(dealGubunList, 'modalDealGubun', '', '1'); //거래구분
	selectBoxAppend(dealCorpStatusList, 'modalDealCorpStatus', '', '1'); //거래상태

	let selectPeriod = parseInt(getCommonCode('시스템', '040')[0].commonCd); //기본조회기간 일
	// 수주등록일
	$('#startDate').val(moment().subtract('d',selectPeriod).format('YYYY-MM-DD'));
	$('#endDate').val(moment().format('YYYY-MM-DD'));

	// 발주일자
	$('#startDate2').val(moment().subtract('d',selectPeriod).format('YYYY-MM-DD'));
	$('#endDate2').val(moment().format('YYYY-MM-DD'));

	//어펜드된 tr만들때 사용되는 데이터 리스트(가용재고 tr)
	let appenTrDataList = [];
	function appenTrDataListReload(){
		$.ajax({
			url: '<c:url value="/bm/matrlInfoListAll"/>',
	        type: 'GET',
	      	//url: '<c:url value="/pm/purchaseOrderAdmLstWithAsQty"/>',
	        //type: 'POST',	        
	        async: false,
	        data : {
			},
	        beforeSend: function() {
	        	$('#my-spinner').show();
	        },
			success : function(res) {
				if(res.result == 'ok'){
					appenTrDataList = [];
					appenTrDataList = res.data;		
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
		
	}
	appenTrDataListReload();
	
	// 자재정보 목록조회
	$('#matrlTable thead tr').clone(true).addClass('filters').appendTo('#matrlTable thead'); // filter 생성
	let matrlTable = $('#matrlTable').DataTable({
		dom : "<'row'<'col-md-12 col-md-6'l><'col-md-12 col-md-6'f>>"
				+ "<'row'<'col-md-12'tr>>"
				+ "<'row pt-1'<'d-flex align-items-center d-flex'Bp><'me-lg-auto'><'d-flex align-items-center justify-content-end'i>>",
		language: lang_kor,
		info: true,
		ordering: true,
		processing: true,
//		paging: true,
 		paging: false,
		lengthChange: false,
		searching: true,
		autoWidth: false,
		orderCellsTop: true,
        fixedHeader: false,
        scrollY: '100vh',
        scrollX: true,
//		pageLength: 15,
 		pageLength: 100000000,
		colReorder: false,
		select: {
            style: 'multi',
            selector : 'tr:not(.notSelect)',
            toggleable: true,
            items: 'row',
            info: false
        },
        ajax : {
			url : '<c:url value="/pm/purchaseOrderAdmLstWithNeedQty"/>',
			type : 'POST',
			data : {
				startDate	: function() { return moment($('#startDate').val(),'YYYY-MM-DD').format('YYYYMMDD'); },
				endDate		: function() { return moment($('#endDate').val(),'YYYY-MM-DD').format('YYYYMMDD'); },
				searchTarget : function() { return $('#searchTarget').val(); },
				stockUseNotSearch : function(){ return $('#stockUseNotSearch').prop('checked') ? 'Y' : 'N'; }, 
			},
		},
        rowId: 'rowNumber',
		columns : [
			{ data : 'bizStatusNm', className : 'text-center align-middle',//수주상태
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ data: 'bizOrdDtlNo', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						if(data.indexOf('D개별발주') != 0) {
							return data;
						} else {
							return data.slice(1,-1).split('_')[0];
						}
					} else {
						if(row['endDate'] != null && row['endDate'] != ''){
							return moment(row['endDate']).format('YYYY-MM-DD');
						} else {
							return '-';
						}
					}
				}	
			},
			{ data : 'bizDealCorpNm', className : 'text-center align-middle',//수주고객사
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ data : 'itemNm', className : 'text-center align-middle',//제품명
				render: function(data) {
					if(data != null && data != ''){
						//return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						return data;
					} else {
						return '-';
					}
				}
			},
			{ data: 'paperType', className : 'text-center align-middle', name: 'rowspan' },
			{ data : 'ordDate', className : 'text-center align-middle',//수주일자 OR 개별발주일경우 개별발주일
				render: function(data, type, row, meta) {
					if(data != null && data != ''){
						//if(row['bizOrdDtlNo'].indexOf('D개별발주') != 0){
							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data).format('YYYY-MM-DD')+'</div>';
						//} else {
						//	return '-';
						//}
					} else {
						return '-';
					}
				}
			},
			{ data : 'workEndReqDate', className : 'text-center align-middle',//목표일
				render: function(data, type, row, meta) {
					if(data != null && data != ''){
						if(row['bizOrdDtlNo'].indexOf('D개별발주') != 0){
							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data).format('YYYY-MM-DD')+'</div>';
						} else {
							return '-';
						}
					} else {
						return '-';
					}
				}
			},
			{ data : 'inDate', className : 'text-center align-middle',//입고일
				render: function(data, type, row, meta) {
					//if(row['bizOrdDtlNo'].indexOf('D개별발주') != 0){
						if(data != null && data != '') {
							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data).format('YYYY-MM-DD')+'</div>';
						} else {
							return '-';
						}						
					//} else {
					//	return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">개별발주</div>';
					//}
				}
			},
			{ data: 'purchaseQty', className : 'text-end align-middle', //발주량
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						if(row['purchaseOrdIdx'] != 0 && row['purchaseOrdIdx'] != ''){
							let returnValue = parseInt(data/500) + "R" + parseInt(data%500);

							let html = '';
							html += '<div class="row">';
							html += '<div class="text-end align-middle" style="white-space:nowrap;width:50%;">'+returnValue+'</div>';
							html += '<div class="text-end align-middle" style="white-space:nowrap;width:50%;">'+addCommas(parseInt(data))+'</div>';
							html += '</div>';
							return html;
						}
					} else {
						return '0';
					}
				}	
			},
			{ data: 'inQty', className : 'text-end align-middle', //입고량
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						if(row['purchaseOrdIdx'] != 0 && row['purchaseOrdIdx'] != ''){

							let returnValue = parseInt(data/500) + "R" + parseInt(data%500);
							let html = '';
							html += '<div class="row">';
							html += '<div class="text-end align-middle" style="white-space:nowrap;width:50%;">'+returnValue+'</div>';
							html += '<div class="text-end align-middle" style="white-space:nowrap;width:50%;">'+addCommas(parseInt(data))+'</div>';
							html += '</div>';
							return html;
							
							/* if(row['bizOrdDtlNo'].indexOf('D개별발주') != 0){
								
							} else {
								return '';
							} */
						} else {
							return '';
						}
					} else {
						return '0';
					}
				}	
			},			
			{ data: 'stockUseYn', className : 'text-center align-middle py-0',//재고사용
				render : function(data, type, row, meta) {
					if(data != '' && data != null) {
						if(data == 'Y') {
							let html = '';
								html += '<input type="checkbox" class="bootstrapToggle confirmToggle p-0" data-toggle="toggle"';
								html += '		data-type="stockUse" data-idx="'+row['purchaseOrdIdx']+'"';
								html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
								html += '		data-size="mini"';
								html += '		checked>';
							return html;
						} else {
							let html = '';
								html += '<input type="checkbox" class="bootstrapToggle confirmToggle p-0" data-toggle="toggle"';
								html += '		data-type="stockUse" data-idx="'+row['purchaseOrdIdx']+'"';
								html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
								html += '		data-size="mini"';
								html += '		>';
							return html;
						}
					} else {
						return '';
					}
				}	
			},
			{ data: 'confirmYn', className : 'text-center align-middle py-0',//발주확정
				render : function(data, type, row, meta) {
					if(data != '' && data != null) {
						if(data == 'Y') {
							let html = '';
								html += '<input type="checkbox" class="bootstrapToggle confirmToggle p-0" data-toggle="toggle"';
								html += '		data-type="confirmOrder" data-idx="'+row['purchaseOrdIdx']+'"';
								html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
								html += '		data-size="mini" onclick="event.cancelBubble=true"';
								html += '		checked>';
							return html;
						} else {
							let html = '';
								html += '<input type="checkbox" class="bootstrapToggle confirmToggle p-0" data-toggle="toggle"';
								html += '		data-type="confirmOrder" data-idx="'+row['purchaseOrdIdx']+'"';
								html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
								html += '		data-size="mini" onclick="event.cancelBubble=true"';
								html += '		>';
							return html;
						}
					} else {
						return '';
					}
				}	
			},
		],
		/* rowsGroup: [
			'rowspan:name'
	 	], */
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
			{ extend: 'colvisGroup',	className: 'd-none',	hide: '.colvisHide'},
			{ extend: 'colvis',	text: 'Select Col',	},
		],
		order : [],
		drawCallback: function() {
			let api = this.api();
			let data = api.data();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let headerHeight = parseFloat($('#leftHeader').css('height')) + parseFloat($('#leftSecondHeader').css('height'))
			let theadHeight = parseFloat($('#matrlTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - headerHeight - 43)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAll').off('keyup',function() {});
			$('#searchAll').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			});
			
			let node = api.rows().nodes();
			if(data.length > 0){
				$(node).each(function(index, item) {
					let rowData = matrlTable.row(item).data()
					if( rowData.confirmYn == 'Y' || ( rowData.mergeIdx != '' && rowData.mergeIdx != null && rowData.mergeIdx != '0' ) ) {
						matrlTable.row(item).deselect();
						$(matrlTable.row(item).node()).addClass('notSelect');
					}
				});
			}
			
			
			// 집계표 생성
			//let dataArray = api.data().toArray();
			let dataArray = _.cloneDeep(appenTrDataList);
			let showDataList = api.data().toArray();
			const searchTargetVal = $('#searchTarget').val();
			//발주대기인 경우 -> 발주는 안나갔지만 -인 품목의 행이 보여야함
			if(dataArray.length != 0 && ( showDataList.length != 0 || searchTargetVal == 'Y' ) ) {
				let matrlIdxUniq = _.uniqBy(showDataList, 'idx'); //화면에 보이는(발주나갔던 내역들) 자재별로 uniq한 리스트
				let matrlIdxUniqArray =_.map(matrlIdxUniq,'idx');
				//발주 나갔던 품목들의 대한 처리
				for(var i=0;i<matrlIdxUniq.length;i++) {
					let matrlIdx = matrlIdxUniq[i].idx;
					let matrlIdxList = _.filter(dataArray, (v => v.idx == matrlIdx));
					let showDataFilstList = _.filter(showDataList, (v => v.idx == matrlIdx));
					
					let firstRowNumber = _.minBy(showDataFilstList, (v => parseInt(v.rowNumber))).rowNumber;
					let lastRowNumber = _.maxBy(showDataFilstList, (v => parseInt(v.rowNumber))).rowNumber;
					
					let matrlFirstData = _.filter(matrlIdxList, (v => v.rowNumber == firstRowNumber));
					let matrlLastData = _.filter(matrlIdxList, (v => v.rowNumber == lastRowNumber));

					/*let matrlLastSum = parseInt(matrlLastData[0].stockQty) + 
									(matrlLastData[0].confirmYn=='Y'?parseInt(matrlLastData[0].purchaseQty):parseInt(matrlLastData[0].purchaseQty)*(-1));*/
					let matrlLastSum = 0;
									
					//가용재고량
					//let yesterdayStockQty = parseInt(matrlIdxList[0].asQty != null && matrlIdxList[0].asQty != '' ? matrlIdxList[0].asQty : 0);
					//dataArray<- 자체가 자재별로 유니크하게 들어옴 => [0]번째의 가용재고량 보면됨
					let todayStockQty = 0 
					if(matrlIdxList.length > 0){
						todayStockQty = showDataFilstList[0].asQty;
					};
					//번호가 있을때 j=1 -> 리스트의 첫번째에는  맨 꼭대기 행을 만들어주기위한 값이 들어있음
					//↑↑↑↑↑ 이거 상관없어짐 
					//↓↓↓↓↓ 가용재고 마감해서 산출하는 방식 안쓰기로함
					/* for(var j=0; j<matrlIdxList.length;j++){
						matrlLastSum += matrlIdxList[j].bizOrdDtlNo.includes('D') ? 
									(matrlIdxList[j].confirmYn=='Y'? parseInt(matrlIdxList[j].stockQty) : 0) :  
										matrlIdxList[j].confirmYn=='Y'? 0 : parseInt(matrlIdxList[j].purchaseQty)*(-1);

						//가용재고량 계산식
						//수주별발주이면서 발주확정 안된 경우 -> 재고 - 
						//수주별발주 계산식 변경 ( 2023.03.03 )
						//일단 수주별발주이면 - 처리 , 입고량이 있는 경우 + 처리
						
						//개별발주이면서 발주확정된 경우 -> 재고 +
						if(matrlIdxList[j].bizOrdDtlNo.includes('D')){
							//개별발주인경우
							if(matrlIdxList[j].confirmYn=='Y'){
								todayStockQty += parseInt(matrlIdxList[j].stockQty);
							}
						} else {
							//수주별발주 인경우
							//if(matrlIdxList[j].confirmYn=='Y'){
							//	todayStockQty -= parseInt(matrlIdxList[j].stockQty);
							//} else {
							//	todayStockQty -= parseInt(matrlIdxList[j].purchaseQty);
							//}
							todayStockQty -= parseInt(matrlIdxList[j].stockQty);
							if(matrlIdxList[j].inQty > 0){
								todayStockQty += parseInt(matrlIdxList[j].inQty);
							}
						}
							
					} */
					let todayStockQtyR;
					if(todayStockQty < 0){
						todayStockQtyR = "-" + parseInt((-1*todayStockQty)/500) + "R" + parseInt((-1*todayStockQty)%500);
					} else {
						todayStockQtyR = parseInt(todayStockQty/500) + "R" + parseInt(todayStockQty%500);
					}
					let matrlLastSumR;
					if(matrlLastSum > 0){
						matrlLastSumR = parseInt(matrlLastSum/500) + "R" + parseInt(matrlLastSum%500);
					} else if ( matrlLastSum < 0 ){
						matrlLastSumR = "-" + parseInt((matrlLastSum*-1)/500) + "R" + parseInt((matrlLastSum*-1)%500);
					} else {
						matrlLastSumR = "0R0"
					}
					let extraStock = 0; 
					if(matrlIdxList.length > 0){
						extraStock = matrlIdxList[0].extraStock != null && matrlIdxList[0].extraStock != '' ? matrlIdxList[0].extraStock : 0;
					};
					
					let extraStockR = parseInt(extraStock/500) + "R" + parseInt(extraStock%500);

					//발주량
					let purchaseQtySum = _.sumBy(matrlIdxList, (v=>parseFloat(v.purchaseQty)) );
					let purchaseQtySumR = purchaseQtySum == 0 ? "0R0" :  parseInt(purchaseQtySum/500) + "R" + parseInt(purchaseQtySum%500);
					
					//입고량
					let inQtySum = _.sumBy(matrlIdxList, (v=>parseFloat(v.inQty)) );
					let inQtySumR = inQtySum == 0 ? "0R0" :  parseInt(inQtySum/500) + "R" + parseInt(inQtySum%500);

					let matrlHtml = '';
					
					let asQtyHtml = '';
					asQtyHtml += '<div class="row">';
					asQtyHtml += '<div class="text-end align-middle" style="white-space:nowrap;width:50%;">'+todayStockQtyR+'</div>';
					asQtyHtml += '<div class="text-end align-middle" style="white-space:nowrap;width:50%;">'+addCommas(parseInt(todayStockQty))+'</div>';
					asQtyHtml += '</div>';

					let extraQtyHtml = '';
					extraQtyHtml += '<div class="row">';
					extraQtyHtml += '<div class="text-end align-middle" style="white-space:nowrap;width:50%;">'+extraStockR+'</div>';
					extraQtyHtml += '<div class="text-end align-middle" style="white-space:nowrap;width:50%;">'+addCommas(parseInt(extraStock))+'</div>';
					extraQtyHtml += '</div>';

					/* let purchaseQtyHtml = '';
					purchaseQtyHtml += '<div class="row">';
					purchaseQtyHtml += '<div class="text-end align-middle" style="white-space:nowrap;width:50%;">'+purchaseQtySumR+'</div>';
					purchaseQtyHtml += '<div class="text-end align-middle" style="white-space:nowrap;width:50%;">'+addCommas(parseInt(purchaseQtySum))+'</div>';
					purchaseQtyHtml += '</div>'; */

					/* let inQtyHtml = '';
					inQtyHtml += '<div class="row">';
					inQtyHtml += '<div class="text-end align-middle" style="white-space:nowrap;width:50%;">'+inQtySumR+'</div>';
					inQtyHtml += '<div class="text-end align-middle" style="white-space:nowrap;width:50%;">'+addCommas(parseInt(inQtySum))+'</div>';
					inQtyHtml += '</div>'; */

					/* let trObj = {};
					trObj.
					matrlIdxUniq[i]. */
					
					if( todayStockQty < 0 ) {
						//가용재고 마이너스 품목 - 핑크색
						matrlHtml += '<tr class="bg-danger bg-gradient bg-opacity-25 matrlSelect" data-idx="'+matrlIdxUniq[i].idx+'">';
					} else if( todayStockQty < extraStock ) {
						//적정재고 보다 이하로 떨어진 경 - 보라색
						matrlHtml += '<tr style="background-color: #D9D2E9;" class="matrlSelect" data-idx="'+matrlIdxUniq[i].idx+'">';
					} else {
						matrlHtml += '<tr class="bg-success bg-gradient bg-opacity-10 matrlSelect" data-idx="'+matrlIdxUniq[i].idx+'">';
					}
					if(matrlIdxList.length > 0){
						matrlHtml += '	<td class="text-center">'+matrlIdxList[0].paperType+'</td>';
					} else {
						matrlHtml += '	<td class="text-center"></td>';
					}

					matrlHtml += '	<td class="text-center align-middle" colspan="2"></td>';
					matrlHtml += '	<td class="text-center align-middle" colspan="5">가용재고</td>';
					matrlHtml += '	<td class="text-end align-middle">'+asQtyHtml+'</td>'; //가용재고
					//matrlHtml += '	<td class="text-end align-middle">'+purchaseQtyHtml+'</td>';//발주량
					//matrlHtml += '	<td class="text-end align-middle">'+inQtyHtml+'</td>';//입고량
					matrlHtml += '	<td class="text-center" colspan="3"></td>';
					matrlHtml += '</tr>';
					
					let matrlFirstNode = api.row('#'+firstRowNumber).node();
					
					let matrlLastNode = api.row('#'+lastRowNumber).node();
					$(matrlLastNode).after(matrlHtml);
				}

				//발주는 안나갔지만 가용재고가 - 인 품목이 보여야 하는 경우 
				if(searchTargetVal == 'Y'){
					let asQtyMinusMatrlList = _.filter(dataArray, (v => parseInt(v.asQty) < 0 ) );
					asQtyMinusMatrlList = _.filter(asQtyMinusMatrlList, v=> !matrlIdxUniqArray.includes(v.idx)  );

					for( var i = 0; i < asQtyMinusMatrlList.length; i++ ){
						let matrlIdx = asQtyMinusMatrlList[i].idx;
						let showDataFilstList = _.filter(dataArray, (v => v.idx == matrlIdx));
						
						let todayStockQty = showDataFilstList[0].asQty;

						let todayStockQtyR;
						if(todayStockQty < 0){
							todayStockQtyR = "-" + parseInt((-1*todayStockQty)/500) + "R" + parseInt((-1*todayStockQty)%500);
						} else {
							todayStockQtyR = parseInt(todayStockQty/500) + "R" + parseInt(todayStockQty%500);
						}
						let asQtyHtml = '';
						asQtyHtml += '<div class="row">';
						asQtyHtml += '<div class="text-end align-middle" style="white-space:nowrap;width:50%;">'+todayStockQtyR+'</div>';
						asQtyHtml += '<div class="text-end align-middle" style="white-space:nowrap;width:50%;">'+addCommas(parseInt(todayStockQty))+'</div>';
						asQtyHtml += '</div>';

						let matrlHtml = '';
						if( todayStockQty < 0 ) {
							//가용재고 마이너스 품목 - 핑크색
							matrlHtml += '<tr class="bg-danger bg-gradient bg-opacity-25 matrlSelect" data-idx="'+asQtyMinusMatrlList[i].idx+'">';
						} else if( todayStockQty < extraStock ) {
							//적정재고 보다 이하로 떨어진 경 - 보라색
							matrlHtml += '<tr style="background-color: #D9D2E9;" class="matrlSelect" data-idx="'+asQtyMinusMatrlList[i].idx+'">';
						} else {
							matrlHtml += '<tr class="bg-success bg-gradient bg-opacity-10 matrlSelect" data-idx="'+asQtyMinusMatrlList[i].idx+'">';
						}
						matrlHtml += '	<td class="text-center">'+asQtyMinusMatrlList[i].paperType+'</td>';

						matrlHtml += '	<td class="text-center align-middle" colspan="2"></td>';
						matrlHtml += '	<td class="text-center align-middle" colspan="5">가용재고</td>';
						matrlHtml += '	<td class="text-end align-middle">'+asQtyHtml+'</td>'; //가용재고
						//matrlHtml += '	<td class="text-end align-middle">'+purchaseQtyHtml+'</td>';//발주량
						//matrlHtml += '	<td class="text-end align-middle">'+inQtyHtml+'</td>';//입고량
						matrlHtml += '	<td class="text-center" colspan="3"></td>';
						matrlHtml += '</tr>';

						let appendObj =  api.rows().nodes();

						//그냥 어디에 append되도 상관없다하심 -> 맨마지막에 추가
						$(appendObj[appendObj.length - 1]).after(matrlHtml);
						
					}
					
				}
			}

			
			
			try {
				matrlTable.columns.adjust();
			} catch(e){
				//console.log('테이블 생성전');
			}
			$('.bootstrapToggle').bootstrapToggle();
		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#matrlTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#matrlTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
			//$('#matrlTable_wrapper').find('.dataTables_scrollBody').css('overflow-y','scroll');
		},
	});
	// dataTable colReorder event
	matrlTable.on('column-reorder', function( e, settings, details ) {
		let api = matrlTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#matrlTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	// 원자재목록 조회 버튼 click
	$('#btnSearch').on('click', function() {
		$('#my-spinner').show();
		setTimeout(function(){
			appenTrDataListReload();
			matrlTable.rows().deselect();
			matrlTable.ajax.reload(function(){
				matrlTable.draw(false).columns.adjust();
			},false);
			purchaseOrderAdmTable.clear();
			purchaseOrderAdmTable.ajax.reload(function() {
				$('#purchaseOrderAdmTable_wrapper').find('.filters th').each(function(index, item) {
					$(item).find('input').attr('disabled', false);// 검색 필터 enable
				});
			});
			$('#btnNew').attr('disabled', false); // 신규 버튼
			$('#btnSave').attr('disabled', true); // 저장 버튼
			$('#btnEdit').attr('disabled', false); // 수정 버튼
			$('#btnDel').attr('disabled', false); // 삭제 버튼
			$('#btnCancel').attr('disabled', true); // 취소 버튼
			WM_action_OFF('ADM');
			setTimeout(function() {
				$('#my-spinner').hide();
			}, 100)
		},10);
		
	});


	$(document).on('click', '.matrlSelect', function(){
		console.log('table 클릭')
		if($(this).hasClass('selected')){
			$(this).removeClass('selected');
		} else {
			$(this).addClass('selected');
		}
	});
	
	// 원자재목록 추가 버튼 click
	$('#btnAdd').on('click', function() {
		if( !(matrlTable.rows('.selected').count() != 0 
				|| matrlTable.row('.selected').data() != undefined
				|| $('#matrlTable').find('.matrlSelect.selected').length != 0) ) {
			toastr.warning('추가할 원단을 선택해주세요.');
			return false;
		}
		$('#my-spinner').show();

		setTimeout(function(){
			let dataArray = [];
			$.ajax({
				url: '<c:url value="/pm/purchaseOrderAdmLstWithNeedQty"/>',
		        type: 'POST',
		        async: false,
		        data : {
					startDate	: function() { return moment($('#startDate').val(),'YYYY-MM-DD').format('YYYYMMDD'); },
					endDate		: function() { return moment($('#endDate').val(),'YYYY-MM-DD').format('YYYYMMDD'); },
					searchTarget : function() { return ''; },
					stockUseNotSearch : function(){ return 'N'; }, 
				},
		        beforeSend: function() {
		        	$('#my-spinner').show();
		        },
				success : function(res) {
					if(res.result == 'ok'){
						dataArray = res.data;		
						
					} else if(res.result == 'fail') {
						toastr.warning(res.message);
					} else {
						toastr.error(res.message);
					}
				}
			});
			
			WM_action_ON('ADM','workingWarningModal');
			
			purchaseOrderAdmTable.colReorder.disable();
		
			let dataList = matrlTable.rows('.selected').data().toArray();

			$(matrlTable.rows('.selected').nodes()).addClass('notSelect');
			$(matrlTable.rows('.selected').nodes()).addClass('bg-danger bg-gradient bg-opacity-25');		
			matrlTable.rows('.selected').deselect();

			
			let col_filter_text = [];
			$('#purchaseOrderAdmTable_wrapper').find('.filters th').each(function(index, item) {
				$(item).find('input').attr('disabled', true); // 검색 필터 disabled
				col_filter_text.push($(item).find('input').val());
			});
		
			let addList = [];
			// 재질별로 uniq한 목록
			let dataList_uniqPaperType = _.uniqBy(dataList, function(v) { return v.idx;});

			//원래 데이터 테이블에 있는 항목 클릭에대한 리스트 처리
			for(var i=0;i<dataList_uniqPaperType.length;i++) {
				let row = dataList_uniqPaperType[i];
				let obj = {};
				obj.idx = '';
				obj.matrlIdx = row.idx;
				obj.matrlCd = row.matrlCd;
				obj.matrlNm = row.matrlNm;
				obj.paperType = row.paperType;
				obj.confirmYn = 'N';
				obj.printYn = 'N';
				obj.purchaseOrdNo = '자동채번';
				
				obj.purchaseOrdDate = moment().format('YYYY-MM-DD');
				obj.purchaseInDueDate = moment().format('YYYY-MM-DD');
				if(row.dealCorpIdx > 0 && row.dealCorpNm != null){
					obj.dealCorpIdx = row.dealCorpIdx;
					obj.dealCorpNm = row.dealCorpNm;
				} else {
					obj.dealCorpIdx = '';
					obj.dealCorpNm = '';
				}
				obj.cutQty = '1';
				obj.eaQty = '1';
				obj.extraQty = '0';
				obj.cutSize = '';
				obj.purchaseNote = '';
				obj.purchaseDesc = '';
				let purchaseOrdIdxList = _.filter(dataList, function(v) { return v.idx == row.idx && v.bizOrdDtlNo.indexOf('개별발주') == -1 && v.bizOrdDtlNo != '';});
				let array = [];
				let purchaseOrdQty = 0;
				for(var i=0;i<purchaseOrdIdxList.length;i++) {
					array.push(purchaseOrdIdxList[i].purchaseOrdIdx);
					purchaseOrdQty += parseInt(purchaseOrdIdxList[i].purchaseQty);
				}
				obj.purchaseOrdQty = purchaseOrdQty;
				obj.purchaseOrdIdxList = array;
				obj.etc2 = row.etc2;
				addList.push(obj);
			}
			//데이터테이블에 append된(가용재고계산합계란) 항목 리스트 처리
			for(var i=0; i<$('#matrlTable').find('.matrlSelect.selected').length; i++){
				let tr = $('#matrlTable').find('.matrlSelect.selected')[i];
				let matrlIdx = $(tr).data('idx');
				//0번째꺼 가져와도 차피 해당 자재의 식별자 같은 정보들 긁어오려고한거라 상관없음 
				let row = _.filter(dataArray, v=>v.idx == $(tr).data('idx'))[0];
				let obj = {};
				obj.idx = '';
				obj.matrlIdx = row.idx;
				obj.matrlCd = row.matrlCd;
				obj.matrlNm = row.matrlNm;
				obj.paperType = row.paperType;
				obj.confirmYn = 'N';
				obj.printYn = 'N';
				obj.purchaseOrdNo = '자동채번';
				
				obj.purchaseOrdDate = moment().format('YYYY-MM-DD');
				obj.purchaseInDueDate = moment().format('YYYY-MM-DD');
				if(row.dealCorpIdx > 0 && row.dealCorpNm != null){
					obj.dealCorpIdx = row.dealCorpIdx;
					obj.dealCorpNm = row.dealCorpNm;
				} else {
					obj.dealCorpIdx = '';
					obj.dealCorpNm = '';
				}
				obj.cutQty = '1';
				obj.eaQty = '1';
				obj.extraQty = '0';
				obj.cutSize = '';
				obj.purchaseNote = '';
				obj.purchaseDesc = '';
				obj.purchaseOrdQty = 0;
				obj.purchaseOrdIdxList = [];
				obj.etc2 = row.etc2;
				addList.push(obj);
				
			}
			$('#matrlTable').find('.matrlSelect.selected').removeClass('selected');
			purchaseOrderAdmTable.rows.add(addList).draw(false);
		
			$('#btnSave').attr('disabled', false); // 저장 버튼
			$('#btnDel').attr('disabled', false); // 삭제 버튼
			$('#btnCancel').attr('disabled', false); // 취소 버튼

			$('#my-spinner').hide();
		},10);
		
	});
	
	// 발주관리 개별발주 목록조회
	$('#purchaseOrderAdmTable thead tr').clone(true).addClass('filters').appendTo('#purchaseOrderAdmTable thead'); // filter 생성
	let purchaseOrderAdmTable = $('#purchaseOrderAdmTable').DataTable({
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
			url : '<c:url value="/pm/purchaseOrderAdmLstBySingle"/>',
			type : 'POST',
			data : {
				startDate : function() { return moment($('#startDate2').val()).format('YYYYMMDD'); },
				endDate : function() { return moment($('#endDate2').val()).format('YYYYMMDD'); },
				searchInMatrlTarget	 : function() { return $('#searchInMatrlTarget').val(); },
			},
		},
	    rowId: 'idx',
		columns : [
			{ data: 'confirmYn', className : 'text-center align-middle', name: 'confirmYn',
				render : function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						if(data == 'Y') {
							let html = '';
								html += '<input type="checkbox" class="bootstrapToggle confirmToggle p-0" data-toggle="toggle"';
								html += '		data-type="confirmOrder" data-idx="'+row['idx']+'"';
								html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
								html += '		data-size="mini"';
								html += '		checked>';
							return html;
						} else {
							let html = '';
								html += '<input type="checkbox" class="bootstrapToggle confirmToggle p-0" data-toggle="toggle"';
								html += '		data-type="confirmOrder" data-idx="'+row['idx']+'"';
								html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
								html += '		data-size="mini"';
								html += '		>';
							return html;
						}
					} else {
						let html = '';
							html += '<input type="checkbox" class="bootstrapToggle confirmToggle p-0" data-toggle="toggle"';
							html += '		data-type="confirmOrder" data-idx=""';
							html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
							html += '		data-size="mini"';
							html += '		disabled>';
						return html;
					}
				}
			},
			/* { className : 'text-center align-middle', name: 'purchaseOrdStatus',
				render : function(data, type, row, meta) {
					return '-';
				}
			}, */
			{ data: 'printYn', className : 'text-center align-middle', name: 'printYn',
				render : function(data, type, row, meta) {
					if(data == 'Y') {
						return '<i class="fa-solid fa-check mt-1 text-success"></i>';
					} else {
						return '<i class="fa-solid fa-x mt-1 text-danger"></i>';
					}
				}
			},
			{ data: 'purchaseOrdNo', className : 'text-center align-middle', name: 'purchaseOrdNo',
				render : function(data, type, row, meta) {
					if(data != '' && data != null) {
						return data;
					} else {
						return '자동채번';
					}
				}
			},
			{ data: 'purchaseOrdDate', className : 'text-center align-middle editNode', name: 'purchaseOrdDate',
				render : function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						if(data != '' && data != null) {
							return moment(data,'YYYYMMDD').format('YYYY-MM-DD');
						} else {
							return '';
						}
					} else { // 등록되어있지 않는 값
						let html = '';
							html += '<input type="date" max="9999-12-31" class="form-control text-center" value="'+moment().format('YYYY-MM-DD')+'">';
							html += '<span class="d-none">'+data+'</span>';
						return html;
					}
				}
			},
			{ data: 'purchaseInDueDate', className : 'text-center align-middle editNode', name: 'purchaseInDueDate',
				render : function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						if(data != '' && data != null) {
							return moment(data,'YYYYMMDD').format('YYYY-MM-DD');
						} else {
							return '';
						}
					} else {
						let html = '';
							html += '<input type="date" max="9999-12-31" class="form-control text-center" value="'+moment().format('YYYY-MM-DD')+'">';
							html += '<span class="d-none">'+data+'</span>';
						return html;
					}
				}
			},
			{ data: 'paperType', className : 'text-center align-middle', name: 'paperType'},
			{ data: 'dealCorpNm', className : 'text-end align-middle editNode', name: 'dealCorpNm',
				render : function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						let html = '';
							html += '<div class="input-group" style="min-width: 120px;">';
							html += '	<input type="text" class="form-control" value="'+data+'" disabled>';
							html += '	<button type="button" class="btnInputDel" style="background-color: transparent;';
							html += '		border-color: transparent; position: absolute;';
							html += '		top: 0; right:0;';
							html += '		margin: 1px 23px; margin-left: 0px;';
							html += '		border: none;';
							html += '		" disabled>';
							html += '		<i class="fa-solid fa-xmark"></i>';
							html += '	</button>';
							html += '	<input type="hidden" value="'+row['dealCorpIdx']+'">';
							html += '	<button type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary dealCorpModalBtn"';
							html += '	 data-matrlidx="'+row['matrlIdx']+'" disabled>';
							html += '		<i class="fa-solid fa-magnifying-glass"></i>';
							html += '	</button>';
							html += '</div>';
							html += '<span class="d-none">'+data+'</span>';
						return html;
					} else { // 등록되어있지 않는 값
						let html = '';
							html += '<div class="input-group" style="min-width: 120px;">';
							html += '	<input type="text" class="form-control" value="'+data+'" disabled>';
							html += '	<button type="button" class="btnInputDel" style="background-color: transparent;';
							html += '		border-color: transparent; position: absolute;';
							html += '		top: 0; right:0;';
							html += '		margin: 1px 23px; margin-left: 0px;';
							html += '		border: none;';
							html += '		">';
							html += '		<i class="fa-solid fa-xmark"></i>';
							html += '	</button>';
							html += '	<input type="hidden" value="'+row['dealCorpIdx']+'">';
							html += '	<button type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary dealCorpModalBtn"';
							html += '	 data-matrlidx="'+row['matrlIdx']+'">';
							html += '		<i class="fa-solid fa-magnifying-glass"></i>';
							html += '	</button>';
							html += '</div>';
							html += '<span class="d-none">'+data+'</span>';
						return html;
					}
					
				}
			},
			{ data: 'purchaseOrdQty', className : 'text-end align-middle editNode', name: 'purchaseOrdQty',
				render : function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						if(data != '' && data != null) {
							let returnValue = parseInt(data/500) + "R" + parseInt(data%500);
							
							let html = '';
							html += '<div class="row">';
							html += '<div class="text-end align-middle" style="white-space:nowrap;width:50%;">'+returnValue+'</div>';
							html += '<div class="text-end align-middle" style="white-space:nowrap;width:50%;">'+addCommas(parseInt(data))+'</div>';
							html += '</div>';
							
							return html;
						} else {
							return '';
						}
					} else {
						let html = '';
							html += '<input type="text" class="form-control text-end calValue" onkeyup="numberFormat(this, \'int\')" value="'+addCommas(parseInt(data))+'">';
							html += '<span class="d-none">'+data+'</span>';
						return html;
					}
				}
			},
			/* { className : 'text-end align-middle', name: 'purchaseQty', // 발주량 R
				render : function(data, type, row, meta) {
					//if(row['etc2'] == '02'){
						//매입단위가 "통"인 경우 수주수량 == 발주수량임
					//	let ordQty = parseInt(row['purchaseOrdQty']); // 주문수량(제품)
					//	let R = parseInt(ordQty / 500); // R로 환산
					//	let purchaseQty = R + "R" + (ordQty % 500);
						
					//	return purchaseQty;
					//} else {
						//매입단위가 "연" OR 매입단위 등록안한 경우 -> 계산식 적용해야함
						let ordQty = parseInt(row['purchaseOrdQty']); // 주문수량(제품)
						let cutQty = parseInt(row['cutQty']); // 절수
						let eaQty = parseInt(row['eaQty']); // 개수
						let extraQty = parseInt(row['extraQty']); // 여유분
		
						if(cutQty == 0 || eaQty == 0) {
							return '0';
						} else {
							let cuttingSize = Math.ceil(ordQty/(cutQty*eaQty));
							let R = parseInt(cuttingSize / 500); // R로 환산
							let purchaseQty = R + "R" + (cuttingSize % 500);
							
							return purchaseQty;
						}
					//}
				}
			},
			{ className : 'text-end align-middle', name: 'finalPurchaseQty', // 최종발주량
				render : function(data, type, row, meta) {
					let ordQty = parseInt(row['purchaseOrdQty']); // 주문수량(제품)
					let cutQty = parseInt(row['cutQty']); // 절수
					let eaQty = parseInt(row['eaQty']); // 개수
					let extraQty = parseInt(row['extraQty']); // 여유분
					
					if(cutQty == 0 || eaQty == 0) {
						return '0';
					} else {
						//let printPressQty = Math.ceil(ordQty/eaQty);
						let printPressQty = Math.ceil(ordQty/(cutQty*eaQty)) * cutQty;
						let pressQty = Math.ceil((printPressQty + extraQty)/cutQty);
						
						let R = parseInt(pressQty / 500); // R로 환산
						let finalPurchaseQty = R + "R" + (pressQty % 500);
						
						return finalPurchaseQty;
					}
				}
			},
			{ data: 'cutQty', className : 'text-end align-middle editNode', name: 'cutQty',
				render : function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						return addCommas(parseInt(data));
					} else {
						let html = '';
							html += '<input type="text" class="form-control text-end calValue" onkeyup="numberFormat(this, \'int\')" value="'+data+'">';
							html += '<span class="d-none">'+data+'</span>';
						return html;
					}
				}
			},
			{ data: 'eaQty', className : 'text-end align-middle editNode', name: 'eaQty',
				render : function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						return addCommas(parseInt(data));
					} else {
						let html = '';
							html += '<input type="text" class="form-control text-end calValue" onkeyup="numberFormat(this, \'int\')" value="'+data+'">';
							html += '<span class="d-none">'+data+'</span>';
						return html;
					}
				}
			},
			{ data: 'extraQty', className : 'text-end align-middle calValue editNode', name: 'extraQty',
				render : function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						return addCommas(parseInt(data));
					} else {
						let html = '';
							html += '<input type="text" class="form-control text-end" onkeyup="numberFormat(this, \'int\')" value="0">';
							html += '<span class="d-none">'+data+'</span>';
						return html;
					}
				}
			},
			{ className : 'text-end align-middle', name: 'printPressQty', // 정매인쇄통수
				render : function(data, type, row, meta) {
					let ordQty = parseInt(row['purchaseOrdQty']); // 주문수량(제품)
					let cutQty = parseInt(row['cutQty']); // 절수
					let eaQty = parseInt(row['eaQty']); // 개수
					let extraQty = parseInt(row['extraQty']); // 여유분
	
					if(cutQty == 0 || eaQty == 0) {
						return '0';
					} else {
						//let printPressQty = Math.ceil(ordQty/eaQty);
						let printPressQty = Math.ceil(ordQty/(cutQty*eaQty)) * cutQty;
						return addCommas(printPressQty);
					}
				}
			},
			/* { data: 'cutSize', className : 'text-center align-middle editNode', name: 'cutSize',
				render : function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						if(data != '' && data != null) {
							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						} else {
							return '';
						}
					} else {
						let html = '';
							html += '<input type="text" class="form-control text-center">';
							html += '<span class="d-none">'+data+'</span>';
						return html;
					}
				}
			},
			{ data: 'purchaseNote', className : 'text-center align-middle editNode', name: 'purchaseNote',
				render : function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						if(data != '' && data != null) {
							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						} else {
							return '';
						}
					} else {
						let html = '';
							html += '<input type="text" class="form-control text-start" style="min-width: 200px;">';
							html += '<span class="d-none">'+data+'</span>';
						return html;
					}
				}
			}, */
			/*{ data: 'purchaseDesc', className : 'text-center align-middle editNode', name: 'purchaseDesc',
				render : function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						if(data != '' && data != null) {
							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						} else {
							return '';
						}
					} else {
						let html = '';
							html += '<input type="text" class="form-control text-start" style="min-width: 100px;">';
							html += '<span class="d-none">'+data+'</span>';
						return html;
					}
				}
			}, */
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
		],
		order : [],
		drawCallback: function() {
			let api = this.api();
			
			let htmlHeight = parseFloat($('html').css('height'));
			let headerHeight = parseFloat($('#rightHeader').css('height')) + parseFloat($('#rightSecondHeader').css('height'))
			let theadHeight = parseFloat($('#purchaseOrderAdmTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#purchaseOrderAdmTable_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - headerHeight - 43)+'px');
			
			$('#purchaseOrderAdmTable_filter').addClass('d-none');
			// 통합검색
			$('#searchAllPoa').off('keyup',function() {});
			$('#searchAllPoa').on('keyup',function() {
				$('#purchaseOrderAdmTable_filter').find('input').val($(this).val());
				$('#purchaseOrderAdmTable_filter').find('input').trigger('keyup');
			});
	
			$('.bootstrapToggle').bootstrapToggle();
			let data = api.data();
			let node = api.rows().nodes();
			if(data.length > 0){
				$(node).each(function(index, item) {
					if( purchaseOrderAdmTable.row(item).data().printYn == 'Y') {
						$(purchaseOrderAdmTable.row(item).node()).find('.bootstrapToggle').bootstrapToggle('disable');
						$(purchaseOrderAdmTable.row(item).node()).addClass('notEdit');
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
				let cell = $('#purchaseOrderAdmTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);
	
				let title = $(cell).text();
	
				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');
	
				let cursorPosition = '';
				
				// On every keypress in this input
				$('#purchaseOrderAdmTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
			
			api.button(3).trigger();
			purchaseOrderAdmTable.draw();
		},
	});
	// dataTable colReorder event
	purchaseOrderAdmTable.on('column-reorder', function( e, settings, details ) {
		let api = purchaseOrderAdmTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#purchaseOrderAdmTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	
		$('.bootstrapToggle').bootstrapToggle();
	});

	// 발주확정
	$(document).off('change','.confirmToggle', function(){	});
	$(document).on('change','.confirmToggle', function() {
		event.stopPropagation();	//상위 엘리먼트들로부터의 이벤트 전파를 중단한다.
		let thisRow = $(this).parents('tr');
		let idx = $(this).data('idx');
		let type = $(this).data('type');
		let check = $(this).prop('checked');
		let cofirmData = null;
		let stockData = null;
		
		//재고사용여부선택한경우
		if(type == 'stockUse'){
			if(check){
				stockData = 'Y';
				cofirmData = 'Y';
			} else {
				stockData = 'N';
				//cofirmData = 'N';
			}
		} else if(type == 'confirmOrder'){
			//발주확정여부 선택한 경우
			if(check){
				cofirmData = 'Y';
			} else {
				stockData = 'N';
				cofirmData = 'N';
			}
		}
		
		$.ajax({
			url: '<c:url value="/pm/purchaseOrderAdmUpd"/>',
			type: 'POST',
			async: false,
			data: {
				'idx'			:	idx,
				'confirmYn'		:	cofirmData,
				'stockUseYn'	:	stockData,
			},
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					appenTrDataListReload();
					
					if(check) {
						toastr.success('처리되었습니다.');
					} else {
						toastr.success('취소처리되었습니다.');
					}
					WM_action_OFF('ADM');
					//matrlTable.rows().deselect();
					console.log('start');
					matrlTable.ajax.reload(function(){
						matrlTable.draw(false).columns.adjust();
						},false);
					console.log('end');
					purchaseOrderAdmTable.ajax.reload(function() {
						$('#purchaseOrderAdmTable_wrapper').find('.filters th').each(function(index, item) {
							$(item).find('input').attr('disabled', false);// 검색 필터 enable
						});
					});
				} else if(res.result == 'fail') {
					appenTrDataListReload();
					toastr.warning(res.message);
					WM_action_OFF('ADM');
					matrlTable.rows().deselect();
					matrlTable.ajax.reload(function(){
						matrlTable.draw(false).columns.adjust();
						},false);
					purchaseOrderAdmTable.ajax.reload(function() {
						$('#purchaseOrderAdmTable_wrapper').find('.filters th').each(function(index, item) {
							$(item).find('input').attr('disabled', false);// 검색 필터 enable
						});
					});
				} else {
					toastr.error(res.message);
				}
				$('#btnNew').attr('disabled', false); // 신규 버튼
				$('#btnSave').attr('disabled', true); // 저장 버튼
				$('#btnEdit').attr('disabled', false); // 수정 버튼
				$('#btnDel').attr('disabled', false); // 삭제 버튼
				$('#btnCancel').attr('disabled', true); // 취소 버튼
				$('#my-spinner').hide();
			}
		});
	});

	// 개별발주목록 조회 버튼 click
	$('#btnSearchDtl').on('click', function() {
		$('#my-spinner').show();
		setTimeout(function(){
			appenTrDataListReload();
			
			matrlTable.rows().deselect();
			matrlTable.ajax.reload(function(){
				matrlTable.draw(false).columns.adjust();
			},false);
			purchaseOrderAdmTable.clear();
			purchaseOrderAdmTable.ajax.reload(function() {
				$('#purchaseOrderAdmTable_wrapper').find('.filters th').each(function(index, item) {
					$(item).find('input').attr('disabled', false);// 검색 필터 enable
				});
			});
			$('#btnNew').attr('disabled', false); // 신규 버튼
			$('#btnSave').attr('disabled', true); // 저장 버튼
			$('#btnEdit').attr('disabled', false); // 수정 버튼
			$('#btnDel').attr('disabled', false); // 삭제 버튼
			$('#btnCancel').attr('disabled', true); // 취소 버튼
			WM_action_OFF('ADM');
			setTimeout(function() {
				$('#my-spinner').hide();
			}, 100)
		},10);
		
	});
	
	// 작업중 경고 모달 예 버튼 click
	$('#btnWorkingWarningModalY').on('click', function() {
		if(WMlastIdx == 'ADM') { // 개별발주 수정중이나 신규등록중이였을 경우
			$('#btnSave').trigger('click');
			return false;
		}
	});
	
	// 작업중 경고 모달 아니요 버튼 click
	$('#btnWorkingWarningModalN').on('click', function() {
		if(WMlastIdx == 'ADM') { // 개별발주 수정중이나 신규등록중이였을 경우
			if(window.location != window.parent.location) { // tab일 경우
				// 부모 탭 닫기버튼 click
				$('#tab-list', parent.document).find('.active').find('span').eq(1).find('i').trigger('click');
		    }
		}
	});
	
	
	
	//발주처 돋보기버튼
	/* $(document).on('click','.dealCorpModalBtn',function(){
		matrlIdxVal = $(this).data('matrlidx'); //자재 식별자
		if(matrlIdxVal == '' || matrlIdxVal == null || matrlIdxVal == "null"){
			matrlIdxVal = 0;
		} 
		$('#dealCorpSelectGubun').val('matrlCorp');
		dealCorpSelectGubun = $('#dealCorpSelectGubun').val();
		$('#dealCorpSelectModal').modal('show');
		setTimeout(function() {
			dealCorpSelectModalTable.ajax.reload(function() {});
		}, 200);	
	}); */
	
	
	
	// 수량 계산
	$(document).on('keyup', '.editNode input', function(e) {
		let tr = $(e.target).parent().parent();
		let td = $(tr).find('td');

		let data = purchaseOrderAdmTable.row(td).data();
		/*if(data.etc2 == '02'){
			let ordQty = $(td).eq(purchaseOrderAdmTable.column('purchaseOrdQty:name').index()).find('input').val();
			ordQty = parseInt(ordQty.replaceAll(/,/g,'')); // 주문수량(제품)

			let R = parseInt(ordQty/500) + 'R' + (ordQty % 500);
			
			$(td).eq(purchaseOrderAdmTable.column('purchaseQty:name').index()).html(R);
			$(td).eq(purchaseOrderAdmTable.column('finalPurchaseQty:name').index()).html(R);
		} else {*/
			let ordQty = $(td).eq(purchaseOrderAdmTable.column('purchaseOrdQty:name').index()).find('input').val();
			let cutQty = $(td).eq(purchaseOrderAdmTable.column('cutQty:name').index()).find('input').val();
			let eaQty = $(td).eq(purchaseOrderAdmTable.column('eaQty:name').index()).find('input').val();
			let extraQty = $(td).eq(purchaseOrderAdmTable.column('extraQty:name').index()).find('input').val();
		
			ordQty = parseInt(ordQty.replaceAll(/,/g,'')); // 주문수량(제품)
			cutQty = parseInt(cutQty.replaceAll(/,/g,'')); // 절수
			eaQty = parseInt(eaQty.replaceAll(/,/g,'')); // 개수
			extraQty = parseInt(extraQty.replaceAll(/,/g,'')); // 여유분
		
			let cuttingSize = Math.ceil(ordQty/(cutQty*eaQty)); // cuttingSize
			//let printPressQty = Math.ceil(ordQty/eaQty); // 정매인쇄통수
			let printPressQty = Math.ceil(ordQty/(cutQty*eaQty)) * cutQty;
			let pressQty = Math.ceil((printPressQty + extraQty)/cutQty); // 통수
			let R = parseInt(cuttingSize / 500); // R로 환산
			let purchaseQty = R + "R" + (cuttingSize % 500); // 발주량 R
			let finalPurchaseQty = R + "R" + (pressQty % 500); // 최종발주량
		
			if(cutQty != 0 && eaQty != 0) {
				$(td).eq(purchaseOrderAdmTable.column('cuttingSize:name').index()).html(addCommas(parseInt(cuttingSize)));
				$(td).eq(purchaseOrderAdmTable.column('printPressQty:name').index()).html(addCommas(parseInt(printPressQty)));
				$(td).eq(purchaseOrderAdmTable.column('pressQty:name').index()).html(addCommas(parseInt(pressQty)));
				$(td).eq(purchaseOrderAdmTable.column('purchaseQty:name').index()).html(purchaseQty);
				$(td).eq(purchaseOrderAdmTable.column('finalPurchaseQty:name').index()).html(finalPurchaseQty);
			}
		//}
	}); 
	
	// 자재 붙여넣기 버튼 click
	$('#btnMatrlModalPaste').on('click', function() {
		
	});
	
	// 개별발주 저장 버튼 click
	$('#btnSave').on('click', function() {
		let array = [];
		let state = true;
		$('#purchaseOrderAdmTable tbody').find('tr').each(function(index, item) {
			if($(item).find('td').find('input').length > 3) {
				let td = $(item).find('td');
				let idx = purchaseOrderAdmTable.row($(item)).data().idx;
				let purchaseOrdNo = purchaseOrderAdmTable.row($(item)).data().purchaseOrdNo;
				let purchaseOrdIdxList = purchaseOrderAdmTable.row($(item)).data().purchaseOrdIdxList;
				
				let purchaseOrdQty = $(td).eq(purchaseOrderAdmTable.column('purchaseOrdQty:name').index()).find('input').val().replaceAll(/,/g,'');
				let purchaseOrdDate = $(td).eq(purchaseOrderAdmTable.column('purchaseOrdDate:name').index()).find('input').val();
				let purchaseInDueDate = $(td).eq(purchaseOrderAdmTable.column('purchaseInDueDate:name').index()).find('input').val();
				let dealCorpIdx = $(td).eq(purchaseOrderAdmTable.column('dealCorpNm:name').index()).find('input[type=hidden]').val();
				let cutQty = $(td).eq(purchaseOrderAdmTable.column('cutQty:name').index()).find('input').val();
				let eaQty = $(td).eq(purchaseOrderAdmTable.column('eaQty:name').index()).find('input').val();
				let extraQty = $(td).eq(purchaseOrderAdmTable.column('extraQty:name').index()).find('input').val();
				let cutSize = $(td).eq(purchaseOrderAdmTable.column('cutSize:name').index()).find('input').val();
				let purchaseNote = $(td).eq(purchaseOrderAdmTable.column('purchaseNote:name').index()).find('input').val();
				let purchaseDesc = $(td).eq(purchaseOrderAdmTable.column('purchaseDesc:name').index()).find('input').val();
				
	
				let ordQty = parseInt(purchaseOrdQty); // 주문수량(제품)
				let cutQtyInt = parseInt(cutQty); // 절수
				let eaQtyInt = parseInt(eaQty); // 개수
				let extraQtyInt = parseInt(extraQty); // 여유분
				
				//let printPressQty = Math.ceil(ordQty/eaQtyInt);
				let printPressQty = Math.ceil(ordQty/(cutQtyInt*eaQtyInt)) * cutQtyInt;
				let pressQty = Math.ceil((printPressQty + extraQtyInt)/cutQtyInt);
				
				let R = parseInt(pressQty / 500); // R로 환산
				let finalPressQty = R + "R" + (pressQty % 500);
				
	
				if(purchaseOrdDate == '') {
					toastr.warning('발주일을 선택해주세요.');
					$(td).eq(purchaseOrderAdmTable.column('purchaseOrdDate:name').index()).find('input').focus();
					state = false;
					return false;
				}
				if(purchaseInDueDate == '') {
					toastr.warning('입고예정일을 입력해주세요.');
					$(td).eq(purchaseOrderAdmTable.column('purchaseInDueDate:name').index()).find('input').focus();
					state = false;
					return false;
				}
				if(dealCorpIdx == '') {
					toastr.warning('발주처를 선택해주세요.');
					$(td).eq(purchaseOrderAdmTable.column('dealCorpNm:name').index()).find('button').focus();
					state = false;
					return false;
				}
				if(purchaseOrdQty == '' || purchaseOrdQty == '0') {
					toastr.warning('주문수량을 입력해주세요.');
					$(td).eq(purchaseOrderAdmTable.column('purchaseOrdQty:name').index()).find('input').focus();
					state = false;
					return false;
				}
				if(parseInt(purchaseOrdQty) < parseInt(purchaseOrderAdmTable.row($(item)).data().purchaseOrdQty)) {
					toastr.warning('포함한 수주발주 수량의 합보다 많이입력해야합니다.<br>수주발주 수량의 합 : '+addCommas(purchaseOrderAdmTable.row($(item)).data().purchaseOrdQty));
					$(td).eq(purchaseOrderAdmTable.column('purchaseOrdQty:name').index()).find('input').focus();
					state = false;
					return false;
				}
				if(cutQty == '' || cutQty == '0') {
					toastr.warning('절수를 입력해주세요.');
					$(td).eq(purchaseOrderAdmTable.column('cutQty:name').index()).find('input').focus();
					state = false;
					return false;
				}
				if(eaQty == '' || eaQty == '0') {
					toastr.warning('개수를 입력해주세요.');
					$(td).eq(purchaseOrderAdmTable.column('eaQty:name').index()).find('input').focus();
					state = false;
					return false;
				}
	
				let obj = new Object();
				obj.idx = idx;
				obj.bizOrdDtlIdx = '';
				obj.purchaseOrdDate = moment(purchaseOrdDate).format('YYYYMMDD');
				obj.purchaseInDueDate = moment(purchaseInDueDate).format('YYYYMMDD');
				obj.dealCorpIdx = dealCorpIdx;
				/*obj.cutQty = cutQty;
				obj.eaQty = eaQty;
				obj.extraQty = extraQty;*/ //원래 키인하는 형식이었으나 컬럼없애므로 1,1,0 고정
				obj.cutQty = '1';
				obj.eaQty = '1';
				obj.extraQty = '0';
				obj.extraPackQty = '0';
				/*obj.cutSize = cutSize;
				obj.purchaseNote = purchaseNote;
				obj.purchaseDesc = purchaseDesc;*/
				obj.cutSize = '';
				obj.purchaseNote = '';
				obj.purchaseDesc = '';
				obj.purchaseOrdIdxList = purchaseOrdIdxList == null || purchaseOrdIdxList == '' ? '' : purchaseOrdIdxList;
				
				obj.purchaseOrdNo = purchaseOrderAdmTable.row($(item)).data().purchaseOrdNo;
				obj.confirmYn = purchaseOrderAdmTable.row($(item)).data().confirmYn;
				obj.matrlIdx = purchaseOrderAdmTable.row($(item)).data().matrlIdx;
				obj.matrlCd = purchaseOrderAdmTable.row($(item)).data().matrlCd;
				obj.matrlNm = purchaseOrderAdmTable.row($(item)).data().matrlNm;
				obj.paperType = purchaseOrderAdmTable.row($(item)).data().paperType;
				obj.printYn = purchaseOrderAdmTable.row($(item)).data().printYn;
				obj.purchaseOrdQty = purchaseOrdQty;
				obj.purchaseNote = '';
				obj.regDate = purchaseOrderAdmTable.row($(item)).data().regDate;
				obj.regIdx = purchaseOrderAdmTable.row($(item)).data().regIdx;
				obj.updDate = purchaseOrderAdmTable.row($(item)).data().updDate;
				obj.updIdx = purchaseOrderAdmTable.row($(item)).data().updIdx;
			    
			    array.push(obj);
		    }
		});
	
		if(!state) {
			return false;
		}
	
		array = _.differenceWith(array, purchaseOrderAdmTable.data().toArray(), _.isEqual);
	
	
		$.ajax({
			url: '<c:url value="/pm/purchaseOrderAdmIU"/>',
	        type: 'POST',
	        data: {
	            'jsonArray'	:	JSON.stringify(array)
	        },
	        beforeSend: function() {
	        	$('#my-spinner').show();
	        },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					appenTrDataListReload();
					toastr.success('저장되었습니다.');
	    
					WM_action_OFF('ADM');

					matrlTable.rows().deselect();
	    
					purchaseOrderAdmTable.clear().draw(false);
					purchaseOrderAdmTable.ajax.reload(function() {
						$('#purchaseOrderAdmTable_wrapper').find('.filters th').each(function(index, item) {
							$(item).find('input').attr('disabled', false);// 검색 필터 enable
						});
					});
	    
					purchaseOrderAdmTable.colReorder.enable();
					matrlTable.ajax.reload(function(){
						matrlTable.draw(false).columns.adjust();
					},false);
	    
					$('#btnNew').attr('disabled', false); // 신규 버튼
					$('#btnSave').attr('disabled', true); // 저장 버튼
					$('#btnEdit').attr('disabled', false); // 수정 버튼
					$('#btnDel').attr('disabled', false); // 삭제 버튼
					$('#btnCancel').attr('disabled', true); // 취소 버튼
				} else if(res.result == 'fail') {
					appenTrDataListReload();
					toastr.warning(res.message);
					WM_action_OFF('ADM');

					matrlTable.rows().deselect();
	    
					purchaseOrderAdmTable.clear().draw(false);
					purchaseOrderAdmTable.ajax.reload(function() {
						$('#purchaseOrderAdmTable_wrapper').find('.filters th').each(function(index, item) {
							$(item).find('input').attr('disabled', false);// 검색 필터 enable
						});
					});
	    
					purchaseOrderAdmTable.colReorder.enable();
					matrlTable.ajax.reload(function(){
						matrlTable.draw(false).columns.adjust();
					},false);
	    
					$('#btnNew').attr('disabled', false); // 신규 버튼
					$('#btnSave').attr('disabled', true); // 저장 버튼
					$('#btnEdit').attr('disabled', false); // 수정 버튼
					$('#btnDel').attr('disabled', false); // 삭제 버튼
					$('#btnCancel').attr('disabled', true); // 취소 버튼
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
	});
	
	// 개별발주 수정 버튼 click
	$('#btnEdit').on('click', function() {
		WM_action_ON('ADM','workingWarningModal');
		
		$('#purchaseOrderAdmTable_wrapper').find('.filters th').each(function(index, item) {
			$(item).find('input').attr('disabled', true); // 검색 필터 disabled
		});

		
		$('#purchaseOrderAdmTable tbody').find('tr').each(function(index_tr, tr) {
			if(!$(tr).hasClass('notEdit')){
				$(tr).find('td').each(function(index_td, td) {
					if($(td).hasClass('editNode') && $(td).find('input').length != 1) {
						if(index_td == purchaseOrderAdmTable.column('purchaseOrdDate:name').index()) {
							let value = purchaseOrderAdmTable.row(tr).data().purchaseOrdDate;
							value = moment(value).format('YYYY-MM-DD');
							$(td).html('<input type="date" max="9999-12-31" class="form-control text-center" value="'+value+'">');
						} else if(index_td == purchaseOrderAdmTable.column('purchaseInDueDate:name').index()) {
							let value = purchaseOrderAdmTable.row(tr).data().purchaseInDueDate;
							value = moment(value).format('YYYY-MM-DD');
							$(td).html('<input type="date" max="9999-12-31" class="form-control text-center" value="'+value+'">');
						} else if(index_td == purchaseOrderAdmTable.column('dealCorpNm:name').index()) {
							$(td).find('button').attr('disabled',false);
						} else {
							let tr = $(td).parent();
							let value = $(td).text();
							let data = purchaseOrderAdmTable.row(tr).data();
							if(/*index_td == purchaseOrderAdmTable.column('cutQty:name').index() ||
							   index_td == purchaseOrderAdmTable.column('eaQty:name').index() ||
							   index_td == purchaseOrderAdmTable.column('extraQty:name').index()*/
								index_td == purchaseOrderAdmTable.column('purchaseOrdQty:name').index()
									   ) {
								value = addCommas(parseInt(data.purchaseOrdQty));
								$(td).html('<input type="text" class="form-control text-end" onkeyup="numberFormat(this, \'int\')" value="'+value+'">');
							} else {
								$(td).html('<input type="text" class="form-control text-end" value="'+value+'" style="min-width: 100px;">');
							}
						}
					}
				})
			}
		});
		$('#purchaseOrderAdmTable tbody').find('.bootstrapToggle').bootstrapToggle('disable');
		purchaseOrderAdmTable.colReorder.disable();
		purchaseOrderAdmTable.draw(false);

		
		$('#btnNew').attr('disabled', false); // DTL 신규 버튼
		$('#btnSave').attr('disabled', false); // DTL 저장 버튼
		$('#btnEdit').attr('disabled', true); // DTL 수정 버튼
		$('#btnDel').attr('disabled', false); // DTL 삭제 버튼
		$('#btnCancel').attr('disabled', false); // DTL 취소 버튼
	});
	
	// 개별발주 삭제 버튼 click
	$('#btnDel').on('click', function() {
		if($('#purchaseOrderAdmTable tbody').find('tr.selected').length == 0) {
			toastr.warning('삭제할 항목을 선택해주세요.');
			return false;
		}
	
		let data = purchaseOrderAdmTable.row('.selected').data();
	
		if(data.idx != '') {
			$('#deleteModal').modal('show');
			$('#deleteModal').data('deleteType','ADM');
		} else {
			purchaseOrderAdmTable.row('.selected').remove().draw(false);
		}
	});
	
	// 삭제 경고창 삭제 버튼 click
	$('#btnDeleteModalY').on('click', function() {
		let deleteType = $('#deleteModal').data('deleteType');
		if(deleteType == 'ADM') {
			let idx = purchaseOrderAdmTable.row('.selected').data().idx;
			$.ajax({
				url: '<c:url value="/pm/purchaseOrderAdmDel"/>',
	            type: 'POST',
	            data: {
	                'idx'	:	idx
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if (res.result == "ok") { //응답결과
						appenTrDataListReload();
						toastr.success('삭제되었습니다.');

						matrlTable.ajax.reload(function(){
							matrlTable.draw(false).columns.adjust();
						},false);
						purchaseOrderAdmTable.clear().draw(false);
						purchaseOrderAdmTable.ajax.reload();
						purchaseOrderAdmTable.row('.selected').remove().draw(false);
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
	
	// 개별발주 취소 버튼 click
	$('#btnCancel').on('click', function() {
		$('#cancelModal').modal('show');
		$('#cancelModal').data('cancelType', 'ADM');
	});
	
	// 취소 경고창 취소 버튼 click
	$('#btnCancelModalY').on('click', function() {
		let cancelType = $('#cancelModal').data('cancelType');
	
		if(cancelType == 'ADM') {
			appenTrDataListReload();
			toastr.success('취소되었습니다.');
			WM_action_OFF('ADM');
	
			$('#btnSearch').trigger('click'); // 조회 버튼 click
			matrlTable.rows().deselect();
			matrlTable.ajax.reload(function(){
				matrlTable.draw(false).columns.adjust();
			},false);
			purchaseOrderAdmTable.ajax.reload();
			purchaseOrderAdmTable.colReorder.enable();
	
			$('#purchaseOrderAdmTable_wrapper').find('.filters th').each(function(index, item) {
				$(item).find('input').attr('disabled', false); // 검색 필터 disabled
			});
			
			$('#btnNew').attr('disabled', false); // 신규 버튼
			$('#btnSave').attr('disabled', true); // 저장 버튼
			$('#btnEdit').attr('disabled', false); // 수정 버튼
			$('#btnDel').attr('disabled', false); // 삭제 버튼
			$('#btnCancel').attr('disabled', true); // 취소 버튼
		}
	});
	
	
	
	
	
	//발주처(자재투입) 목록 조회
	/* let matrlIdxVal = '';
	let dealCorpSelectGubun = 'matrlCorp';
	$('#dealCorpSelectModalTable thead tr').clone(true).addClass('filters').appendTo('#dealCorpSelectModalTable thead'); // filter 생성
	let dealCorpSelectModalTable = $('#dealCorpSelectModalTable').DataTable({
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
			url : '<c:url value="/bm/matrlDealCorpAdmList"/>',
			type : 'POST',
			data : {
				matrlIdx 		   : function() { return matrlIdxVal},
				dealCorpSelectGubun: function() { return dealCorpSelectGubun; }
			},
		},
	    rowId: 'idx',
		columns : [
			{ data: 'dealCorpCd', className : 'text-center'},
			{ data: 'dealCorpNm', className : 'text-center'},
			{ data: 'representative', className : 'text-center'},
			{ data: 'companyNumber', className : 'text-center'},
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
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#dealCorpSelectModalTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 234)+'px');
			
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
				let cell = $('#dealCorpSelectModalTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);
	
				let title = $(cell).text();
	
				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');
	
				let cursorPosition = '';
				
				// On every keypress in this input
				$('#dealCorpSelectModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	
	// dataTable colReorder event
	dealCorpSelectModalTable.on('column-reorder', function( e, settings, details ) {
		let api = dealCorpSelectModalTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#dealCorpSelectModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});
	
	// 개별발주 발주처 조회
	$('#btnDealCorpSelectSearch').on('click',function(){
		dealCorpSelectGubun = $('#dealCorpSelectGubun').val();
		dealCorpSelectModalTable.ajax.reload();
	});
	
	// 개별발주 발주처 붙여넣기
	$('#btnDealCorpSelectModalPaste').on('click',function(){
		if(!$('#dealCorpSelectModalTable tbody tr').hasClass('selected')){
			toastr.warning('붙여넣을 행을 선택해주세요.');
			return false;
		}
		let node = purchaseOrderAdmTable.row('.selected').node();
		let data = purchaseOrderAdmTable.row('.selected').data();
		let selectNodeModalData = dealCorpSelectModalTable.row('.selected').data();
		$(node).find('td').eq(purchaseOrderAdmTable.column('dealCorpNm:name').index()).find('input[type=hidden]').val(selectNodeModalData.idx);			//발주처 식별자
		$(node).find('td').eq(purchaseOrderAdmTable.column('dealCorpNm:name').index()).find('input[type=text]').val(selectNodeModalData.dealCorpNm);		//발주처 이름
		$('#dealCorpSelectModal').modal('hide');
	}); */

	// 거래처정보 목록 조회
	$('#dealCorpModalTable thead tr').clone(true).addClass('filters').appendTo('#dealCorpModalTable thead'); // filter 생성
	let dealCorpModalTable = $('#dealCorpModalTable').DataTable({
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
			url : '<c:url value="/bm/dealCorpAdmList"/>',
			type : 'POST',
			data : {
				dealGubun : function(){ return $('#modalDealGubun').val();},
				dealCorpStatus: function() { return $('#modalDealCorpStatus').val(); }
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'dealGubunNm', className : 'text-center'},
			{ data: 'dealCorpCd', className : 'text-center'},
			{ data: 'initial', className : 'text-center'},
			{ data: 'dealCorpNm', className : 'text-center'},
			{ data: 'representative', className : 'text-center'},
			{ data: 'companyNumber', className : 'text-center'},
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
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#dealCorpModalTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 223)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			//$('#searchAll').off('keyup',function() {});
			//$('#searchAll').on('keyup',function() {
			//	$('#'+table_id+'_filter').find('input').val($(this).val());
			//	$('#'+table_id+'_filter').find('input').trigger('keyup');
			//});
		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#dealCorpModalTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#dealCorpModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	dealCorpModalTable.on('column-reorder', function( e, settings, details ) {
		let api = dealCorpModalTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#dealCorpModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});
	$('#btnDealCorpModalSearch').on('click',function(){
		dealCorpModalTable.ajax.reload(function() {});
	});
	
	//발주처 돋보기버튼
	$(document).on('click','.dealCorpModalBtn',function(){
		matrlIdxVal = $(this).data('matrlidx'); //자재 식별자
		if(matrlIdxVal == '' || matrlIdxVal == null || matrlIdxVal == "null"){
			matrlIdxVal = 0;
		} 
		$('#dealCorpModal').modal('show');
		setTimeout(function() {
			dealCorpModalTable.ajax.reload(function() {});
		}, 200);	
	});

	// 발주처 조회
	$('#btnDealCorpSelectSearch').on('click',function(){
		dealCorpModalTable.ajax.reload();
	});

	// 발주처 붙여넣기
	$('#btnDealCorpModalPaste').on('click',function(){
		if(!$('#dealCorpModalTable tbody tr').hasClass('selected')){
			toastr.warning('붙여넣을 행을 선택해주세요.');
			return false;
		}
		let node = purchaseOrderAdmTable.row('.selected').node();
		let data = purchaseOrderAdmTable.row('.selected').data();
		let selectNodeModalData = dealCorpModalTable.row('.selected').data();
		$(node).find('td').eq(purchaseOrderAdmTable.column('dealCorpNm:name').index()).find('input[type=hidden]').val(selectNodeModalData.idx);			//발주처 식별자
		$(node).find('td').eq(purchaseOrderAdmTable.column('dealCorpNm:name').index()).find('input[type=text]').val(selectNodeModalData.dealCorpNm);		//발주처 이름
		$('#dealCorpModal').modal('hide');
	});

	$('#dealCorpModalTable tbody').on('dblclick','tr',function(){
		let node = purchaseOrderAdmTable.row('.selected').node();
		let data = purchaseOrderAdmTable.row('.selected').data();
		let selectNodeModalData = dealCorpModalTable.row(this).data();
		$(node).find('td').eq(purchaseOrderAdmTable.column('dealCorpNm:name').index()).find('input[type=hidden]').val(selectNodeModalData.idx);			//발주처 식별자
		$(node).find('td').eq(purchaseOrderAdmTable.column('dealCorpNm:name').index()).find('input[type=text]').val(selectNodeModalData.dealCorpNm);		//발주처 이름
		$('#dealCorpModal').modal('hide');
	});
	
	$('#btnEnd').on('click',function(){
		$('#asStockStartDate').val(moment().subtract('w',1).format('YYYY-MM-DD'));
		$('#asStockEndDate').val(moment().format('YYYY-MM-DD'));
		$('#endModal').modal('show');
	});

	$('#btnEndModalY').on('click',function(){
		let startDate = $('#asStockStartDate').val().replaceAll('-','');
		let endDate = $('#asStockEndDate').val().replaceAll('-','');
		
		if( endDate < startDate ){
			toastr.warning('시작일이 종료일보다 큽니다.<br>확인 후 시도해주세요.');
			return false;
		} 

		let diffDays = moment.duration(moment(endDate).diff(startDate)).asDays();
		
		$('#my-spinner').show();

		setTimeout(function(){
			
/* 			let array = []; //마감처리용 배열
			let dataArray = [];
			$.ajax({
				url: '<c:url value="/pm/purchaseOrderAdmLstWithNeedQty"/>',
		        type: 'POST',
		        async: false,
		        data : {
					startDate	: function() { return moment($('#startDate').val(),'YYYY-MM-DD').format('YYYYMMDD'); },
					endDate		: function() { return moment($('#endDate').val(),'YYYY-MM-DD').format('YYYYMMDD'); },
					searchTarget : function() { return ''; },
					stockUseNotSearch : function(){ return 'N'; }, 
				},
		        beforeSend: function() {
		        	$('#my-spinner').show();
		        },
				success : function(res) {
					if(res.result == 'ok'){
						dataArray = res.data;		
						
					} else if(res.result == 'fail') {
						toastr.warning(res.message);
					} else {
						toastr.error(res.message);
					}
				}
			});
			
			if(dataArray.length != 0) {
				for(var k=0; k<=diffDays; k++){
					let endDateVal = moment(startDate).add('d',k).format('YYYYMMDD');

					let matrlIdxUniq = _.uniqBy(dataArray, 'idx'); // 자재별로 uniq한 리스트
					for(var i=0;i<matrlIdxUniq.length;i++) {
						
						
						let matrlIdx = matrlIdxUniq[i].idx;
						let matrlIdxList = _.filter(dataArray, (v => v.idx == matrlIdx));

						//가용재고량
						let yesterdayStockQty = parseInt(matrlIdxList[0].asQty != null && matrlIdxList[0].asQty != '' ? matrlIdxList[0].asQty : 0);
						let todayStockQty = yesterdayStockQty;
						//번호가 있을때 j=1 -> 리스트의 첫번째에는  맨 꼭대기 행을 만들어주기위한 값이 들어있음
						//↑↑↑↑↑ 이거 상관없어짐 
						for(var j=0; j<matrlIdxList.length;j++){
							//가용재고량 계산식
							//수주별발주이면서 발주확정 안된 경우 -> 재고 - 
							//수주별발주 계산식 변경 ( 2023.03.03 )
							//일단 수주별발주이면 - 처리 , 입고량이 있는 경우 + 처리
							
							//개별발주이면서 발주확정된 경우 -> 재고 +
							if(matrlIdxList[j].bizOrdDtlNo.includes('D')){
								//개별발주인경우
								if(matrlIdxList[j].confirmYn=='Y'){
									todayStockQty += parseInt(matrlIdxList[j].stockQty);
								}
							} else {
								//수주별발주 인경우
								//if(matrlIdxList[j].confirmYn=='Y'){
								//	todayStockQty -= parseInt(matrlIdxList[j].stockQty);
								//} else {
								//	todayStockQty -= parseInt(matrlIdxList[j].purchaseQty);
								//}
								todayStockQty -= parseInt(matrlIdxList[j].stockQty);
								if(matrlIdxList[j].inQty > 0){
									todayStockQty += parseInt(matrlIdxList[j].inQty);
								}
							}
						}
						let obj = new Object();
						obj.matrlIdx = matrlIdx;
						obj.todayStockQty = todayStockQty;
						obj.endDate = endDateVal;
						obj.asGubun = '001'; //수동마감 , 자동일경우 002임
						array.push(obj);
					}
				}
				
			}
 */			
			$.ajax({
				url: '<c:url value="/stock/availableStockAdmIns"/>',
		        type: 'POST',
		        data: {
			        'startDate'	: function(){ return startDate; },
			        'endDate'	: function(){ return endDate; },
		            //'jsonArray'	:	JSON.stringify(array)
		        },
		        beforeSend: function() {
		        	$('#my-spinner').show();
		        },
				success : function(res) {
					if (res.result == "ok") { //응답결과
						appenTrDataListReload();
						toastr.success('저장되었습니다.');
						matrlTable.ajax.reload(function(){
							matrlTable.columns.adjust().draw(false);
						},false);
						purchaseOrderAdmTable.ajax.reload();
					} else if(res.result == 'fail') {
						toastr.warning(res.message);
					} else {
						toastr.error(res.message);
					}
					$('#my-spinner').hide();
					$('#endModal').modal('hide');
				}
			});
			
		},10);
		
	});

	$('#stockUseNotSearch').on('change',function(){
		$('#my-spinner').show();
		appenTrDataListReload();
		matrlTable.rows().deselect();
		matrlTable.ajax.reload(function(){
			matrlTable.draw(false).columns.adjust();
		},false);
		purchaseOrderAdmTable.clear();
		purchaseOrderAdmTable.ajax.reload(function() {
			$('#purchaseOrderAdmTable_wrapper').find('.filters th').each(function(index, item) {
				$(item).find('input').attr('disabled', false);// 검색 필터 enable
			});
		});
		$('#btnNew').attr('disabled', false); // 신규 버튼
		$('#btnSave').attr('disabled', true); // 저장 버튼
		$('#btnEdit').attr('disabled', false); // 수정 버튼
		$('#btnDel').attr('disabled', false); // 삭제 버튼
		$('#btnCancel').attr('disabled', true); // 취소 버튼
		WM_action_OFF('ADM');
		setTimeout(function() {
			$('#my-spinner').hide();
		}, 100)
	});

	/* $('#btnEndModalN').on('click',function(){
		$.ajax({
			url: '<c:url value="/test/test"/>',
	        type: 'POST',
	        data : {
		        'startDate' : $('#asStockStartDate').val().replaceAll('-',''),
	        	'endDate' 	: $('#asStockEndDate').val().replaceAll('-',''),
			},
		});
	}); */
</script>

</body>
</html>
