<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/top.jsp"%>
<%@include file="../layout/modal.jsp"%>
<%@include file="../layout/script.jsp"%>
<div id="page" onmouseup="EndDrag(this)" onmousemove="OnDrag(event)" style="grid-template-areas: 'leftcolT dragbarH rightcol'
																									'dragbarV dragbarH rightcol'
																									'leftcolB dragbarH rightcol';
																		  grid-template-rows: 1fr 4px 1fr;
																		  grid-template-columns: 1.6fr 4px 1fr;">
																	
	<div id="leftcolT">
		<div class="container-fluid" style="padding: 5px;">
			<div class="row" id="leftTopHeader" style="padding-bottom: 5px;">
				<div class="d-flex align-items-center d-flex">
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">품목</label>
					<div class="input-group w-auto h-100 me-3">
						<input type="text" class="form-control" id="searchItemNm" disabled>

						<button type="button" id="btnSearchItemDel" class="" style="background-color: transparent; border-color: transparent; position: absolute; top: 0; right: 0; margin: 5px 23px; margin-left: 0px; border: none;">
							<i class="fa-solid fa-xmark"></i>
						</button>
						<input type="hidden" id="searchItemIdx">

						<button type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary" id="btnSearchItem">
							<i class="fa-solid fa-magnifying-glass"></i>
						</button>
					</div>
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">창고</label>
					<div class="input-group w-auto h-100 me-3">
						<input type="text" class="form-control" id="searchLcNm" style="min-width:100px;max-width:100px;" disabled>
						<input type="hidden" id="searchLcIdx">
						<button type="button" id="btnSearchLcDel"
							style="background-color: transparent; border-color: transparent; position: absolute; top: 0; right: 0; margin: 5px 23px; margin-left: 0px; border: none;">
							<i class="fa-solid fa-xmark"></i>
						</button>
						<button type="button" style="padding: 1px 4px; margin-left: 0px;"
							class="btn btn-primary" id="btnSearchLc">
							<i class="fa-solid fa-magnifying-glass"></i>
						</button>
					</div>
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">거래처</label>
					<div class="input-group w-auto h-100 me-3">
						<input type="text" class="form-control" id="searchDealCorpNm" disabled> 
						<input type="hidden" id="searchDealCorpIdx">
						<button type="button" id="btnSearchDealCorpDel"	style="background-color: transparent; border-color: transparent; position: absolute; top: 0; right: 0; margin: 5px 23px; margin-left: 0px; border: none;">
							<i class="fa-solid fa-xmark"></i>
						</button>
						<button type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary" id="btnSearchDealCorp">
							<i class="fa-solid fa-magnifying-glass"></i>
						</button>
					</div>
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">품목구분</label>
					<select class="form-select w-auto h-100 me-3" id="searchItemGubun">
						<option value="" selected>전체</option>
						<option value="item">제품</option>
						<option value="matrl">자재</option>
					</select> 
					<input type="text" class="form-control w-auto h-100 me-1" id="searchAllSpa" placeholder="통합검색" >
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end" >
					<div class="btn-group" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnSearch">
							<i class="fa-regular fa-clipboard"></i>
						</button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnCopy">
							<i class="fa-regular fa-copy"></i>
						</button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnCancel">
							<i class="fa-solid fa-xmark"></i>
						</button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnOpen">
							<i class="fa-solid fa-caret-left"></i>
						</button>
					</div>
				</div>
			</div>
			<div class="row">
				<table class="table table-bordered p-0 m-0" id="stockPaymentAdmTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle"><input class="form-check-input" type="checkbox" id="stockAllCheckBox" style="margin: 0px; width: 25px; height: 25px;"></th>
							<th class="text-center">구분</th>
							<th class="text-center">명칭</th>
							<th class="text-center">출고창고</th>
							<th class="text-center">현재고</th>
							<th class="text-center">®</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
	<div id="dragbarV" onmousedown="StartDrag('V')" ondblclick="minimum(this)"></div>
	<div id="leftcolB">
		<div class="container-fluid" style="padding: 5px;">
			<div class="row" id="rightBottomHeader" style="padding-bottom: 5px;">
				<div class="d-flex align-items-center d-flex">
					<input type="text" class="form-control w-auto h-100 me-1" id="searchAllSpm" placeholder="통합검색" >
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end" >
					<div class="btn-group" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnMoveSave" disabled>
							<i class="fa-regular fa-floppy-disk"></i>
						</button>
						<button type="button" class="btn btn-outline-danger w-auto" style="font-size: 17px !important;" id="btnMoveDel" disabled>
							<i class="fa-solid fa-trash-can"></i>
						</button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnMoveCancel" disabled>
							<i class="fa-solid fa-xmark"></i>
						</button>
					</div>
				</div>
			</div>
			<div class="row">
				<table class="table table-bordered p-0 m-0" id="stockPaymentMoveTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle"><input class="form-check-input" type="checkbox" id="itemPurchaseInAllCheckBox" style="margin: 0px; width: 25px; height: 25px;"></th>
							<th class="text-center">구분</th>
							<th class="text-center">명칭</th>
							<th class="text-center">출고창고</th>
							<th class="text-center">입고창고</th>
							<th class="text-center">이동일자</th>
							<th class="text-center">이동량</th>
							<th class="text-center">®</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
	
	<div id="dragbarH" onmousedown="StartDrag('H')"></div>

	<div id="rightcol">	
		<div class="container-fluid h-100" style="padding: 5px;">
			<div class="row" id="leftHeader" style="padding-bottom: 5px;">
				<div class="d-flex align-items-center d-flex">
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">이동일자</label>
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
					
					<input type="text" class="form-control w-auto h-100 me-1" id="searchAllMht" placeholder="통합검색">
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end">
					<div class="btn-group" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnMoveSearch"><i class="fa-regular fa-clipboard"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnClose">
							<i class="fa-solid fa-caret-right"></i>
						</button>
					</div>
				</div>
			</div>
			<div class="row">
				<table class="table table-bordered p-0 m-0" id="moveHistoryTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle">구분</th>
							<th class="text-center align-middle">명칭</th>
							<th class="text-center align-middle">이동일자</th>
							<th class="text-center align-middle">출고창고</th>
							<th class="text-center align-middle">입고창고</th>
							<th class="text-center align-middle">이동량</th>
							<th class="text-center align-middle">®</th>
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
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>

<!-- 화면설정 script -->
<script>
	let isDragging = false;
	let isDraggingV = false; // 세로 드래그 여부
	let isDraggingH = false; // 가로 드레그 여부
	
	function SetCursor(cursor) {
		let page = document.getElementById("page");
		page.style.cursor = cursor;
	}
	
	function StartDrag(type) {
		//if(type == 'VT') { isDraggingVT = true; SetCursor("n-resize");}
		//if(type == 'VB') { isDraggingVB = true; SetCursor("n-resize");}
		if(type == 'V') { isDraggingV = true; SetCursor("n-resize");}
		if(type == 'H') { isDraggingH = true; SetCursor("ew-resize");}
	}
	
	function EndDrag(e) {
		if(isDraggingV || isDraggingH) {
			dataTableDrawAll(); // dataTable 전체 reload
			//isDraggingVT = false;
			//isDraggingVB = false;
			isDraggingV = false;
			isDraggingH = false;
			SetCursor("auto");
		}
	}
	
	function OnDrag(event) {
		if (isDraggingH) { // 좌우 스크롤
			let page = document.getElementById("page");
			let leftcol = document.getElementById("rightcol"); // 우측
			let leftcolT = document.getElementById("leftcolT"); // 좌측 상단
			//let rightcolM = document.getElementById("rightcolM"); // 좌측 중단
			let leftcolB = document.getElementById("leftcolB"); // 좌측 하단
			let dragbarWidth = 4;
			let leftcolMinWidth = 700; // leftcol 최소사이즈
			$('#leftHeader').children().each(function(index, item) {
				leftcolMinWidth += $(item).width();
			});
			let rightcolMinWidth = 500; // rightcol 최소사이즈
	
			let rightColWidth = page.clientWidth - parseInt(Math.max(rightcolMinWidth + 20, event.clientX));
			
			let cols = [
				parseInt(Math.max(rightcolMinWidth, page.clientWidth - dragbarWidth - parseInt(Math.max(rightColWidth, rightcolMinWidth)))),
				dragbarWidth,
				parseInt(Math.max(rightColWidth, rightcolMinWidth))
			];
	
			let newColDefn = cols.map(c => c.toString() + "px").join(" ");
			//console.log(newColDefn);
	
			page.style.gridTemplateColumns = newColDefn;
	
			event.preventDefault();
		} else if (isDraggingV) { // leftcolT와 leftcolB 사이
			let dragbarWidth = 4;

			let page_height = parseInt($('#page').height()); 			// 전체 높이
			let leftcolT_height = parseInt($('#leftcolT').height());	// 우측 상단
			let leftcolB_height = parseInt($('#leftcolB').height());	// 우측 하단

			let leftcolT_min_height = 100;	// 우측 상단 최소높이
			let leftcolB_min_height = 34;	// 우측 하단 최소높이

			let cursorY = event.clientY;	// 현재 cursor y좌표(위에서부터 얼마나 떨어졌는지)
			//console.log(cursorY);
			//console.log(page_height - leftcolB_height - dragbarWidth);
			
			let cols = [
				Math.min(Math.max(leftcolT_min_height, cursorY), page_height - leftcolB_min_height - dragbarWidth),
				dragbarWidth,
				page_height - dragbarWidth - Math.min(Math.max(leftcolT_min_height, cursorY), page_height - leftcolB_min_height - dragbarWidth),
			];
			
			//console.log(cols);
	
			let newColDefn = cols.map(c => c.toString() + "px").join(" ");

			$('#page').css('grid-template-rows',newColDefn);
	
			event.preventDefault();
		}
	}

	function minimum(node) {
		let id = $(node).attr('id');

		if(id == 'dragbarV') {
			let dragbarWidth = 4;

			let page_height = parseInt($('#page').height()); 			// 전체 높이
			let leftcolT_height = parseInt($('#leftcolT').height());	// 우측 상단
			let leftcolB_height = parseInt($('#leftcolB').height());	// 우측 하단

			let leftcolT_min_height = 100;	// 우측 상단 최소높이
			let leftcolB_min_height = 34;	// 우측 하단 최소높이

			let dragbarV_height = 4;

			let cols = [];

			//최소화기능만 적용
			cols = [
				page_height - leftcolB_min_height - dragbarWidth,
				dragbarWidth,
				leftcolB_min_height
			];
			
			let newColDefn = cols.map(c => c.toString() + "px").join(" ");
			
			$('#page').css('grid-template-rows',newColDefn);
		} else if(id == 'dragbarVB') {
			let dragbarWidth = 4;

			let page_height = parseInt($('#page').height()); 			// 전체 높이
			let leftcolT_height = parseInt($('#leftcolT').height());	// 우측 상단
			let rightcolM_height = parseInt($('#rightcolM').height());	// 우측 중단
			let leftcolB_height = parseInt($('#leftcolB').height());	// 우측 하단

			let leftcolT_min_height = 100;	// 우측 상단 최소높이
			let rightcolM_min_height = 34;	// 우측 중단 최소높이
			let leftcolB_min_height = 34;	// 우측 하단 최소높이

			let dragbarV_height = 4;

			let cols = [];

			cols = [
				leftcolT_height,
				dragbarWidth,
				page_height - leftcolT_height - leftcolB_min_height - dragbarWidth*2,
				dragbarWidth,
				leftcolB_min_height
			];
			
			/* if(leftcolB_height == leftcolB_min_height) { // 원위치
				cols = [
					leftcolT_height,
					dragbarWidth,
					rightcolM_min_height,
					dragbarWidth,
					page_height - leftcolT_height - rightcolM_min_height - dragbarWidth*2
				];
			} else { // 최소화
				cols = [
					leftcolT_height,
					dragbarWidth,
					page_height - leftcolT_height - leftcolB_min_height - dragbarWidth*2,
					dragbarWidth,
					leftcolB_min_height
				];
			} */
			
			
			let newColDefn = cols.map(c => c.toString() + "px").join(" ");
			
			$('#page').css('grid-template-rows',newColDefn);
		}
		
		dataTableDrawAll(); // dataTable 전체 reload */
	}
	
	$('#btnOpen').on('click',function() { // right-box 열기버튼 클릭
		if($('#rightcol').hasClass('d-none')){
			$('#page').css('grid-template-columns', '1.6fr 4px 1fr');
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
			$('#page').css('grid-template-columns', '1.6fr 4px 1fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcol').removeClass('d-none');
		} else {
			$('#page').css('grid-template-columns', '1.6fr 4px 0fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcol').addClass('d-none');
		}
		dataTableDrawAll(); // dataTable 전체 reload
	});
</script>

<script>
	WM_init('MOVE');

	let monthAdjustList = getCommonCode('시스템', '026'); //날짜조정
	monthAdjustList = _.sortBy(monthAdjustList, v=>parseInt(v.commonCd));
	selectBoxAppend(monthAdjustList, 'monthAdjust', '', '2'); //날짜조정
	
	// 공통코드 조회
	let dealGubunList = getCommonCode('시스템', '011'); // 거래구분
	let dealStatusList = getCommonCode('시스템', '015'); // 거래상태
	let locationModalItemGubunList = getCommonCode('일반', '022'); // 품목구분
	selectBoxAppend(dealGubunList, 'modalDealGubun', '', '1'); //거래구분
	selectBoxAppend(dealStatusList, 'modalDealCorpStatus', '', '1'); //거래상태
	selectBoxAppend(locationModalItemGubunList, 'locationModalItemGubun', '', '1');
	
	let selectPeriod = parseInt(getCommonCode('시스템', '040')[0].commonCd); //기본조회기간 일
	$('#startDate').val(moment().subtract('d',selectPeriod).format('YYYY-MM-DD'));
	$('#endDate').val(moment().format('YYYY-MM-DD'));
	
	//변수모음
	let sessionUserNm = "${userNm}";//세션에서 가져온 유저이름
	let sessionUserIdx = "${userIdx}";//세션에서 가져온 유저식별자

	$(document).ready(function(){
		stockPaymentMoveTable.columns.adjust();
	});
	
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

	//모든 체크박스 선택
	$(document).on('change','#stockAllCheckBox', function(){
		if($('#stockAllCheckBox').prop("checked")){
			$('input:checkbox[name=stockApplyCheck]').prop("checked",true);
		}else{
			$('input:checkbox[name=stockApplyCheck]').prop("checked",false);
		}
	});
	// 모든 체크박스 체크/해제 되도록
	$(document).on('change','input:checkbox[name=stockApplyCheck]', function(){
		if( $('input:checkbox[name=stockApplyCheck]').length == $('input:checkbox[name=stockApplyCheck]:checked').length ){ //전체 체크박스 수와 체크된 박스의 수가 같을 때 -> 전체체크박스 체크 , 아닐 경우 해제
			$('#stockAllCheckBox').prop("checked",true);
		} else{
			$('#stockAllCheckBox').prop("checked",false);
		}
 	});

	//모든 체크박스 선택
	$(document).on('change','#itemPurchaseInAllCheckBox', function(){
		if($('#itemPurchaseInAllCheckBox').prop("checked")){
			$('input:checkbox[name=stockMoveApplyCheck]').prop("checked",true);
		}else{
			$('input:checkbox[name=stockMoveApplyCheck]').prop("checked",false);
		}
	});
	// 모든 체크박스 체크/해제 되도록
	$(document).on('change','input:checkbox[name=stockMoveApplyCheck]', function(){
		if( $('input:checkbox[name=stockMoveApplyCheck]').length == $('input:checkbox[name=stockMoveApplyCheck]:checked').length ){ //전체 체크박스 수와 체크된 박스의 수가 같을 때 -> 전체체크박스 체크 , 아닐 경우 해제
			$('#itemPurchaseInAllCheckBox').prop("checked",true);
		} else{
			$('#itemPurchaseInAllCheckBox').prop("checked",false);
		}
 	});

	$('#btnCancel').on('click',function(){
		$('input:checkbox[name=stockApplyCheck]').prop("checked",false);
		$('#stockAllCheckBox').prop("checked",false);
	});

	$('#btnMoveCancel').on('click',function(){
		$('input:checkbox[name=stockMoveApplyCheck]').prop("checked",false);
		$('#itemPurchaseInAllCheckBox').prop("checked",false);
	});

	$('#btnMoveDel').on('click',function(){
		if( $('input:checkbox[name=stockMoveApplyCheck]:checked').length == 0){
			toastr.warning('삭제할 항목을 체크해주세요.');
			return false;
		}
		stockPaymentMoveTable.rows($('input:checkbox[name=stockMoveApplyCheck]:checked').parent().parent()).remove().draw(false);
		if( $('input:checkbox[name=stockMoveApplyCheck]').length == $('input:checkbox[name=stockMoveApplyCheck]:checked').length ){ //전체 체크박스 수와 체크된 박스의 수가 같을 때 -> 전체체크박스 체크 , 아닐 경우 해제
			$('#itemPurchaseInAllCheckBox').prop("checked",true);
		} else{
			$('#itemPurchaseInAllCheckBox').prop("checked",false);
		}
		if(stockPaymentMoveTable.data().length == 0){
			$('#btnMoveSave').attr('disabled',true);
			$('#btnMoveDel').attr('disabled',true);
			$('#btnMoveCancel').attr('disabled',true);
			$('#itemPurchaseInAllCheckBox').prop("checked",false);
		}
	});
	
	// 입고 목록조회
	$('#stockPaymentAdmTable thead tr').clone(true).addClass('filters').appendTo('#stockPaymentAdmTable thead'); // filter 생성
	let stockPaymentAdmTable = $('#stockPaymentAdmTable').DataTable({
		dom : "<'row'<'col-md-12 col-md-6'l><'col-md-12 col-md-6'f>>"
				+ "<'row'<'col-md-12'tr>>",
				//+ "<'row pt-1'<'d-flex align-items-center d-flex'><'me-lg-auto'><'d-flex align-items-center justify-content-end'>>",
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
        	url : '<c:url value="/stock/stockPaymentAdmStatusLst"/>',
			type : 'POST',
			data : {
				startDate		: function() { return '19000101'; },
				endDate			: function() { return '99991231'; },
				lcIdx			: function() { return $('#searchLcIdx').val(); },
				itemIdx			: function() { return $('#searchItemIdx').val(); },
				itemGubun		: function() { return $('#searchItemGubun').val(); },
				dealCorpIdx		: function() { return $('#searchDealCorpIdx').val(); },
				searchTarget	: function() { return 'Y'; },
				notStockSearch	: function() { return 'Y'; },
			},
		},
        rowId: 'idx',
		columns : [
			{ className : 'text-center align-middle', //체크박스
				render : function(data, type, row, meta) {
					let html = '';
					html += '<input type="checkbox" name="stockApplyCheck" style="width: 25px; height: 25px;">';
					return html; 
				}
			},
			{ data: 'spGubun', className : 'text-center align-middle', //구분
				render : function(data, type, row, meta) {
					if(data == '001'){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">제품</div>';
					} else if(data == '002'){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">자재</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'spCd', className : 'text-center align-middle', //명칭
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'lcNm', className : 'text-center align-middle', //출고창고
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'spGubun', className : 'text-end align-middle',//현재고
				render : function(data, type, row, meta) {
					let prev = parseInt(row['prev']==null?'0':row['prev']);
					let input = parseInt(row['input']==null?'0':row['input']);
					let output = parseInt(row['output']==null?'0':row['output']);
					let inputM = parseInt(row['inputM']==null?'0':row['inputM']);
					let outputM = parseInt(row['outputM']==null?'0':row['outputM']);

					let result = prev + input + inputM - output - outputM;
					return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseInt(result))+'</div>';
				}
			},
			{ data: 'spGubun', className : 'text-end align-middle',//현재고 R
				render : function(data, type, row, meta) {
					let prev = parseInt(row['prev']==null?'0':row['prev']);
					let input = parseInt(row['input']==null?'0':row['input']);
					let output = parseInt(row['output']==null?'0':row['output']);
					let inputM = parseInt(row['inputM']==null?'0':row['inputM']);
					let outputM = parseInt(row['outputM']==null?'0':row['outputM']);

					let result = prev + input + inputM - output - outputM;
					result = parseInt(result/500) + 'R' + parseInt(result%500);
					if(row['spGubun'] == '001'){
						result = '-';
					} 
					return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+result+'</div>';
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
			{ extend: 'colvis',	text: 'Select Col',	},
		],
		order : [],
		drawCallback: function() {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			try{
				stockPaymentAdmTable.columns.adjust();
			}
			catch{
			
			}
			let htmlHeight = parseFloat($('#leftcolT').css('height'));
			let headHeight = parseFloat($('#leftTopHeader').css('height'));
			let theadHeight = parseFloat($('#stockPaymentAdmTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - headHeight - 77)+'px');
			 
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAllSpa').off('keyup',function() {});
			$('#searchAllSpa').on('keyup',function() {
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
				let cell = $('#stockPaymentAdmTable_wrapper').find('.filters th').eq(
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
				$('#stockPaymentAdmTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
			stockPaymentAdmTable.columns.adjust();
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

	//이동테이블
	$('#stockPaymentMoveTable thead tr').clone(true).addClass('filters').appendTo('#stockPaymentMoveTable thead'); // filter 생성
	let stockPaymentMoveTable = $('#stockPaymentMoveTable').DataTable({
		dom : "<'row'<'col-md-12 col-md-6'l><'col-md-12 col-md-6'f>>"
				+ "<'row'<'col-md-12'tr>>",
				//+ "<'row pt-1'<'d-flex align-items-center d-flex'><'me-lg-auto'><'d-flex align-items-center justify-content-end'>>",
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
        /* ajax : {
        	url : '<c:url value="/stock/stockPaymentAdmStatusLst"/>',
			type : 'POST',
			data : {
				startDate		: function() { return '19000101'; },
				endDate			: function() { return '99991231'; },
				lcIdx			: function() { return $('#searchLcIdx').val(); },
				itemIdx			: function() { return $('#searchItemIdx').val(); },
				itemGubun		: function() { return $('#searchItemGubun').val(); },
				dealCorpIdx		: function() { return $('#searchDealCorpIdx').val(); },
				searchTarget	: function() { return 'Y'; },
				notStockSearch	: function() { return 'Y'; },
			},
		}, */
        rowId: 'idx',
		columns : [
			{ className : 'text-center align-middle', //체크박스
				render : function(data, type, row, meta) {
					let html = '';
					html += '<input type="checkbox" name="stockMoveApplyCheck" style="width: 25px; height: 25px;">';
					return html; 
				}
			},
			{ data: 'spGubun', className : 'text-center align-middle', //구분
				render : function(data, type, row, meta) {
					if(data == '001'){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">제품</div>';
					} else if(data == '003'){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">자재</div>';
					} else {
						return '-';
					}
				}
			},
			{ data: 'spCd', className : 'text-center align-middle', //명칭
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'lcNm', className : 'text-center align-middle', //출고창고
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'spWhsIdx', className : 'text-center align-middle',name:'spWhsIdx', //입고창고
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						let filterList;
						filterList = _.filter(locationList, v=> v.gubun == row['spGubun']);
						let html = '';
						if(filterList != undefined){
							html += '<select class="form-select" name="inLocation">';
							filterList.forEach(function(item) {
								if(item.id == data){
									html += '<option value="'+item.id+'" selected>'+item.text+'</option>';
								} else {
									html += '<option value="'+item.id+'">'+item.text+'</option>';
								}
							});
							html += '</select>';
						}
						return html;
					} else {
						return '';
					}
				}
			},
			{ data: 'moveDate', className : 'text-end align-middle',name:'moveDate',//이동일자
				render : function(data, type, row, meta) {
					return '<input type="date" class="form-control" name="moveDate" value="'+moment(data).format('YYYY-MM-DD')+'">';
				}
			},
			{ data: 'spGubun', className : 'text-end align-middle',name:'moveQty',//이동량
				render : function(data, type, row, meta) {
					return '<input type="text" class="form-control text-end" name="moveQty" value="0" onkeyup="numberFormat(this,\'int\')">';
				}
			},
			{ data: 'spGubun', className : 'text-end align-middle',name:'moveQtyR',//이동량 R
				render : function(data, type, row, meta) {
					let result = '0R0';
					if(row['spGubun'] == '001'){
						result = '-';
					} 
					return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+result+'</div>';
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
			{ extend: 'colvis',	text: 'Select Col',	},
		],
		order : [],
		drawCallback: function() {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('#leftcolB').css('height'));
			let headHeight = parseFloat($('#rightBottomHeader').css('height'));
			let theadHeight = parseFloat($('#stockPaymentMoveTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - headHeight - 78)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAllSpm').off('keyup',function() {});
			$('#searchAllSpm').on('keyup',function() {
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
				let cell = $('#stockPaymentMoveTable_wrapper').find('.filters th').eq(
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
				$('#stockPaymentMoveTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	stockPaymentMoveTable.on('column-reorder', function( e, settings, details ) {
		let api = stockPaymentMoveTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#stockPaymentMoveTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	// 이동 내역 목록
	$('#moveHistoryTable thead tr').clone(true).addClass('filters').appendTo('#moveHistoryTable thead'); // filter 생성
	let moveHistoryTable = $('#moveHistoryTable').DataTable({
		dom : "<'row'<'col-md-12 col-md-6'l><'col-md-12 col-md-6'f>>"
				+ "<'row'<'col-md-12'tr>>",
				//+ "<'row pt-1'<'d-flex align-items-center d-flex'><'me-lg-auto'><'d-flex align-items-center justify-content-end'>>",
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
        	url : '<c:url value="/stock/stockPaymentMoveLst"/>',
			type : 'POST',
			data : {
				startDate		: function() { return $('#startDate').val().replaceAll('-',''); },
				endDate			: function() { return $('#endDate').val().replaceAll('-',''); },
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'spGubun', className : 'text-center align-middle', //구분
				render : function(data, type, row, meta) {
					if(data == '001'){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">제품</div>';
					} else if(data == '002'){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">자재</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'spCd', className : 'text-center align-middle', //명칭
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'spDate', className : 'text-center align-middle', //이동일자
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data).format('YYYY-MM-DD')+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'outLcNm', className : 'text-center align-middle', //출고창고
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'inLcNm', className : 'text-center align-middle', //입고창고
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'spQty', className : 'text-end align-middle',//이동량
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseInt(data))+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'spQty', className : 'text-end align-middle',//이동량 R
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						let result;
						result = parseInt(data/500) + 'R' + parseInt(data%500);
						if(row['spGubun'] == '001'){
							result = '-';
						} 
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+result+'</div>';
					} else {
						return '';
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
			
			let htmlHeight = parseFloat($('#rightcol').css('height'));
			let headHeight = parseFloat($('#leftHeader').css('height'));
			let theadHeight = parseFloat($('#moveHistoryTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - headHeight - theadHeight - 10)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAllMht').off('keyup',function() {});
			$('#searchAllMht').on('keyup',function() {
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
				let cell = $('#moveHistoryTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();
				
				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#moveHistoryTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
			moveHistoryTable.columns.adjust();
		},
	});
	// dataTable colReorder event
	moveHistoryTable.on('column-reorder', function( e, settings, details ) {
		let api = moveHistoryTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#moveHistoryTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	$('#btnMoveSearch').on('click',function(){
		moveHistoryTable.ajax.reload();
	});
	
	$('#btnSearch').on('click',function(){
		stockPaymentMoveTable.clear().draw();
		$('#itemPurchaseInAllCheckBox').prop("checked",false);
		stockPaymentAdmTable.ajax.reload();
		$('#stockAllCheckBox').prop("checked",false);
		moveHistoryTable.ajax.reload();
		$('#btnMoveSave').attr('disabled',true);
		$('#btnMoveDel').attr('disabled',true);
		$('#btnMoveCancel').attr('disabled',true);
	});

	//해당 품목 적용
	$('#btnCopy').on('click',function(){
		if( $('input:checkbox[name=stockApplyCheck]:checked').length == 0){
			toastr.warning('적용할 항목을 체크해주세요.');
			return false;
		}
		let array = [];
		$('input:checkbox[name=stockApplyCheck]:checked').each(function(index, item){
			let td = $(item).parent().parent().find('td');
			let node = stockPaymentAdmTable.row($(item).parent().parent()).node();
			let data = stockPaymentAdmTable.row($(item).parent().parent()).data();

			let obj = new Object();
			if(data.spGubun == '002'){//자재인경우
				obj.spGubun = '003'; //품목구분의 자재코드값
			} else {
				obj.spGubun = data.spGubun;
			}
			obj.spIdx = data.spIdx;
			obj.versionIdx = data.versionIdx;
			obj.spCd = data.spCd;
			obj.outSpWhsIdx = data.spWhsIdx;
			obj.spWhsIdx = data.spWhsIdx;
			obj.lcNm = data.lcNm;
			obj.moveDate = moment().format('YYYY-MM-DD');
			array.push(obj);
		 });
		//stockPaymentMoveTable.clear().draw();

		let status = true;
		let possibleLocationList = _.unionBy(locationList.map(v=>v.gubun)).filter( x => _.unionBy(array.map(v=>v.spGubun)).includes(x));
		//해당 품목의 입고가능 창고가 있는지 체크
		if( possibleLocationList.length == 0 ){
				status = false;
		}
		
		if(status){
			stockPaymentMoveTable.rows.add(array).draw(false).columns.adjust();
			toastr.success('추가되었습니다.');
			$('#itemPurchaseInAllCheckBox').prop("checked",false);
			WM_action_ON('MOVE', 'workingWarningModal');
			$('#btnMoveSave').attr('disabled',false);
			$('#btnMoveDel').attr('disabled',false);
			$('#btnMoveCancel').attr('disabled',false);
		} else {
			toastr.warning('입고 창고가 존재하지 않습니다.<br>확인 후 시도해주세요.');
		}
	});

	//저장처리
	$('#btnMoveSave').on('click',function(){
		let array = [];
		let state = true;
		$('#my-spinner').show();
		$('#stockPaymentMoveTable tbody').find('tr').each(function(index, item) {
			let td = $(item).find('td');
			let data = stockPaymentMoveTable.row($(item)).data();
			let node = stockPaymentMoveTable.row($(item)).node();

			//입고창고
			let spWhsIdxCol = stockPaymentMoveTable.column('spWhsIdx:name').index();
			let spWhsIdx = $(td).eq(spWhsIdxCol).find('select[name=inLocation]').val();

			//이동일자
			let moveDateCol = stockPaymentMoveTable.column('moveDate:name').index();
			let moveDate = $(td).eq(moveDateCol).find('input[name=moveDate]').val();
			
			//이동량
			let moveQtyCol = stockPaymentMoveTable.column('moveQty:name').index();
			let moveQty = removeCommas($(td).eq(moveQtyCol).find('input[name=moveQty]').val());

			
			if(spWhsIdx == '' || spWhsIdx == null){
				$(td).eq(spWhsIdxCol).find('select[name=inLocation]').focus();
				toastr.warning('입고창고를 선택해주세요.');
				state = false;
				return false;
			}

			if(moveDate == '' || moveDate == null){
				$(td).eq(moveDateCol).find('input[name=moveDate]').focus();
				toastr.warning('이동일자를 선택해주세요.');
				state = false;
				return false;
			}

			if(moveQty == '0' || moveQty == ''){
				$(td).eq(moveQtyCol).find('input[name=moveQty]').focus();
				toastr.warning('이동량을 입력해주세요.');
				state = false;
				return false;
			}
			
			let obj = new Object();
			obj.SP_IDX = data.spIdx;
			obj.VERSION_IDX = data.versionIdx;
			if(data.spGubun == '003'){//자재인경우
				obj.SP_GUBUN = '002'; //수불의 자재값
			} else {
				obj.SP_GUBUN = data.spGubun;
			}	
			obj.OUT_SP_WHS_IDX = data.outSpWhsIdx;
			obj.IN_SP_WHS_IDX = spWhsIdx;
			obj.SP_QTY = moveQty;
			obj.SP_DATE = moveDate.replaceAll('-','');
			array.push(obj);
		});

		if(state){
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
						
						WM_action_OFF('MOVE');
						moveHistoryTable.ajax.reload();
						stockPaymentMoveTable.clear().draw();
						$('#itemPurchaseInAllCheckBox').prop("checked",false);
						stockPaymentAdmTable.ajax.reload();
						$('#stockAllCheckBox').prop("checked",false);

						$('#btnMoveSave').attr('disabled',true);
						$('#btnMoveDel').attr('disabled',true);
						$('#btnMoveCancel').attr('disabled',true);
					} else if(res.result == 'fail') {
						toastr.warning(res.message);
					} else {
						toastr.error(res.message);
					}
					$('#my-spinner').hide();
				}
			});
		} else {
			$('#my-spinner').hide();
		}
		
	});
	
	/********************************** 이밑으로는 모달들임 **********************************/

	// ---------------------------------------------------------------- 창고목록조회 -------------------------------------------------------------
	// 창고조회버튼 click
	$('#btnSearchLc').on('click', function() {
		$('#locationModal').data('type','Search');
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
		let type = $('#locationModal').data('type');
		if(type == 'Search'){
			$('#searchLcNm').val(data.lcNm);
			$('#searchLcIdx').val(data.idx);
		}	
		
		$('#locationModal').modal('hide');
	});

	$('#locationModalTable tbody').on('dblclick','tr',function(){
		let data = locationModalTable.row(this).data();
		let type = $('#locationModal').data('type');
		if(type == 'Search'){
			$('#searchLcNm').val(data.lcNm);
			$('#searchLcIdx').val(data.idx);
		}	
		
		$('#locationModal').modal('hide');
	});
	
	// ---------------------------------------------------------------- 품목목록조회 -------------------------------------------------------------
	// 품목추가 버튼 click
	$('#btnSearchItem').on('click', function() {
		$('#itemNmModal').data('type','Search');
		$('#itemNmModal').modal('show');
	});
	$('#itemNmModal').on('shown.bs.modal', function() {
		itemNmModalTable.ajax.reload(function() {itemNmModalTable.draw(false);});
	});
	
	$('#btnItemNmSearch').on('click',function(){
		itemNmModalTable.ajax.reload(function() {itemNmModalTable.draw(false);});
	});

	$('#btnItemNmModalPaste').on('click',function(){
		if(!$('#itemNmModalTable tbody tr').hasClass('selected')){
			toastr.warning('붙여넣을 행을 선택해주세요.');
			return false;
		}
		let type = $('#itemNmModal').data('type');
		let data = itemNmModalTable.row('.selected').data();
		if(type == 'Search'){
			$('#searchItemNm').val(data.itemNm);
			$('#searchItemIdx').val(data.idx);
			$('#searchItemGubun').val(data.itemMatrlGubun);
		}
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
			url : '<c:url value="/bm/itemInfoAndMatrlListAll"/>',
			type : 'POST',
			data : {
				itemMatrlGubun : function(){return $('#searchItemGubun').val();},
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
		let type = $('#itemNmModal').data('type');
		let data = itemNmModalTable.row(this).data();
		if(type == 'Search'){
			$('#searchItemNm').val(data.itemNm);
			$('#searchItemIdx').val(data.idx);
			$('#searchItemGubun').val(data.itemMatrlGubun);
		}
		$('#itemNmModal').modal('hide');
	});

	// ---------------------------------------------------------------- 거래처목록조회 -------------------------------------------------------------
	// 거래처조회 버튼 click
	$('#btnSearchDealCorp').on('click', function() {
		$('#dealCorpModal').data('type','Search');
		$('#dealCorpModal').modal('show');
	});
	$('#dealCorpModal').on('shown.bs.modal', function() {
		dealCorpModalTable.ajax.reload(function() {});
	});

	// 거래처조회 x 버튼 click
	$('#btnSearchDealCorpDel').on('click', function() {
		$('#searchDealCorpNm').val('');
		$('#searchDealCorpIdx').val('');
	});

	// 거래처 목록조회
	$('#dealCorpModalTable thead tr').clone(true).addClass('filters').appendTo('#dealCorpModalTable thead'); // filter 생성
	let dealCorpModalTable = $('#dealCorpModalTable').DataTable({
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
			let theadHeight = parseFloat($('#dealCorpModalTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#dealCorpModalTable_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 230)+'px');
			
			$('#dealCorpModalTable_filter').addClass('d-none');
			// 통합검색
			$('#searchAllAdm').off('keyup',function() {});
			$('#searchAllAdm').on('keyup',function() {
				$('#dealCorpModalTable_filter').find('input').val($(this).val());
				$('#dealCorpModalTable_filter').find('input').trigger('keyup');
			});
		},
		initComplete: function () {
			let api = this.api();
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#dealCorpModalTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title.replaceAll('*','') + '" />');
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

	// 거래처 모달 조회 버튼 click
	$('#btnDealCorpModalSearch').on('click', function() {
		$('#my-spinner').show();
		dealCorpModalTable.ajax.reload(function() {});
		
		setTimeout(function() {
			$('#my-spinner').hide();
		}, 100)
	});

	// 거래처 모달 붙여넣기 버튼 click
	$('#btnDealCorpModalPaste').on('click', function() {
		if(!$('#dealCorpModalTable tbody tr').hasClass('selected')){
			toastr.warning('붙여넣을 행을 선택해주세요.');
			return false;
		}
		let type = $('#dealCorpModal').data('type');
		let data = dealCorpModalTable.row('.selected').data();
		if(type == 'Search'){
			$('#searchDealCorpNm').val(data.dealCorpNm);
			$('#searchDealCorpIdx').val(data.idx);
		}
		$('#dealCorpModal').modal('hide');
	});

	$('#dealCorpModalTable tbody').on('dblclick','tr',function(){
		let type = $('#dealCorpModal').data('type');
		let data = dealCorpModalTable.row(this).data();
		if(type == 'Search'){
			$('#searchDealCorpNm').val(data.dealCorpNm);
			$('#searchDealCorpIdx').val(data.idx);
		}
		$('#dealCorpModal').modal('hide');
	});
	
	// 수량 계산
	$(document).on('keyup','input[name=moveQty]', function(e) {
		let tr = $(e.target).parent().parent();
		let td = $(tr).find('td');
		let data = stockPaymentMoveTable.row(tr).data();
		let node = stockPaymentMoveTable.row(tr).node();
		//이동량
		let moveQtyCol = stockPaymentMoveTable.column('moveQty:name').index();
		let moveQty = removeCommas($(td).eq(moveQtyCol).find('input[name=moveQty]').val());
		let moveQtyR = '0R0';
		if(moveQty > 0){
			moveQtyR = parseInt(moveQty/500) + 'R' + parseInt(moveQty%500);
		} else {
			moveQtyR = parseInt((-1*moveQty)/500) + 'R' + parseInt((-1*moveQty)%500);
		}
		
		let moveQtyRCol = stockPaymentMoveTable.column('moveQtyR:name').index();
		if(data.spGubun =='003'){
			$(td).eq(moveQtyRCol).find('div').text(moveQtyR);
		}
		
	});
	
</script>
</body>
</html>
