<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/top.jsp"%>
<%@include file="../layout/modal.jsp"%>
<%@include file="../layout/script.jsp"%>
<div id="page" onmouseup="EndDrag(this)" onmousemove="OnDrag(event)" style="grid-template-areas: 'leftcol dragbarH rightcolT'
																									'leftcol dragbarH dragbarV'
																									'leftcol dragbarH rightcolB';
																		  grid-template-rows: 1fr 4px 1fr;
																		  grid-template-columns: 1.3fr 4px 1fr;">
																	
	<div id="leftcol">	
		<div class="container-fluid h-100" style="padding: 5px;">
			<div class="row" id="leftHeader" style="padding-bottom: 5px;">
				<div class="d-flex align-items-center d-flex">
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">발주일자</label>
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
						<option value="N" selected>미입고</option>
					</select>
					<input type="text" class="form-control w-auto h-100 me-1" id="searchAllPgt" placeholder="통합검색">
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end">
					<div class="btn-group" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnSearch"><i class="fa-regular fa-clipboard"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnOpen">
							<i class="fa-solid fa-caret-left"></i>
						</button>
					</div>
				</div>
			</div>
			<div class="row">
				<table class="table table-bordered p-0 m-0" id="purchaseGroupTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle">발주번호</th>
							<th class="text-center align-middle">발주일자</th>
							<th class="text-center align-middle">발주량</th>
							<th class="text-center align-middle">입고량</th>
							<th class="text-center align-middle">미입고잔량</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
	<div id="dragbarH" onmousedown="StartDrag('H')"></div>
	<div id="rightcolT">
		<div class="container-fluid h-100" style="padding: 5px;">
			<div class="nav nav-tabs" id="nav-tab">
				<button class="nav-link active" id="tab1Nav" data-bs-toggle="tab" data-bs-target="#tab1">발주</button>
				<button class="nav-link " id="tab2Nav" data-bs-toggle="tab" data-bs-target="#tab2">입고</button>
			</div>
			
			<div class="tab-content" id="nav-tabContent">
				<div class="tab-pane fade show active" id="tab1" style="padding: 5px;">
					<div class="row" style="padding-bottom: 5px;">
						<div class="d-flex align-items-center d-flex">
							<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">발주일자</label>
							<input type="date" max="9999-12-31" class="form-control w-auto h-100 me-1" id="purchaseDate">
							<input type="text" class="form-control w-auto h-100 me-1" id="searchAllPat" placeholder="통합검색" >
						</div>
						<div class="me-lg-auto"></div>
						<div id="tab1ButtonHeader" class="d-flex align-items-center justify-content-end">
							<div class="btn-group" role="group" aria-label="Small button group">
								<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnPurchaseAddNew"><i class="fa-solid fa-plus"></i></button>
								<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnPurchaseAddSave" disabled><i class="fa-regular fa-floppy-disk"></i></button>
								<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnPurchaseAddEdit" disabled><i class="fa-regular fa-pen-to-square"></i></button>
								<button type="button" class="btn btn-outline-danger w-auto" style="font-size: 17px !important;" id="btnPurchaseAddDel"><i class="fa-solid fa-trash-can"></i></button>
								<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnPurchaseAddCancel" disabled><i class="fa-solid fa-xmark"></i></button>
								<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnClose">
									<i class="fa-solid fa-caret-right"></i>
								</button>
							</div>
						</div>
					</div>
					<div class="row">
					<table class="table table-bordered p-0 m-0" id="purchaseAddTable">
						<thead class="table-light">
							<tr>
								<th class="text-center align-middle"><input class="form-check-input" type="checkbox" id="purchaseAdmAllCheckBox" style="margin: 0px; width: 25px; height: 25px;"></th>
								<th class="text-center align-middle">발주일자</th>
								<th class="text-center align-middle">상품명</th>
								<th class="text-center align-middle">발주수량</th>
								<th class="text-center align-middle">발주처</th>
								<th class="text-center align-middle">수주상세번호</th>
								<th class="text-center align-middle" style="max-width:79px;min-width:79px;">발주담당자</th>
								<th class="text-center align-middle">발주비고</th>
							</tr>
						</thead>
					</table>
					</div>
				</div>
				
				<div class="tab-pane fade" id="tab2">
					<div class="row" style="padding: 5px;">
						<div id="tab2ButtonHeader" class="d-flex align-items-center justify-content-end w-100" style="margin-bottom: 5px;">
							<input type="text" class="form-control w-auto h-100 me-1" id="searchAllIis" placeholder="통합검색" >
							<div class="btn-group" role="group" aria-label="Small button group">
								<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnInItemSave" disabled><i class="fa-regular fa-floppy-disk"></i></button>
								<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnInItemsEdit" disabled><i class="fa-regular fa-pen-to-square"></i></button>
								<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnInItemCancel" disabled><i class="fa-solid fa-xmark"></i></button>
							</div>
						</div>
						
						<table class="table table-bordered p-0 m-0" id="inItemSaveTable">
							<thead class="table-light">
								<tr>
									<th class="text-center align-middle"><input class="form-check-input" type="checkbox" id="purchaseInAllCheckBox" style="margin: 0px; width: 25px; height: 25px;"></th>
									<th class="text-center align-middle">상품명</th>
									<th class="text-center align-middle">입고일자</th>
									<th class="text-center align-middle">입고수량</th>
									<th class="text-center align-middle">잔량</th>
									<th class="text-center align-middle" style="max-width:79px;min-width:79px;">입고담당자</th>
									<th class="text-center align-middle">입고비고</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>		
			</div>
			
			
		</div>
	</div>
	<div id="dragbarV" onmousedown="StartDrag('V')" ondblclick="minimum(this)"></div>
	<div id="rightcolB">
		<div class="container-fluid" style="padding: 5px;">
			<div class="row" id="rightBottomHeader" style="padding-bottom: 5px;">
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end w-100" >
					<input type="text" class="form-control w-auto h-100 me-1" id="searchAllIpi" placeholder="통합검색" >
					<div class="btn-group" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-danger w-auto" style="font-size: 17px !important;" id="btnItemPurchaseInDel" disabled><i class="fa-solid fa-trash-can"></i></button>
					</div>
				</div>
			</div>
			<div class="row">
				<table class="table table-bordered p-0 m-0" id="itemPurchaseInTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle"><input class="form-check-input" type="checkbox" id="itemPurchaseInAllCheckBox" style="margin: 0px; width: 25px; height: 25px;"></th>
							<th class="text-center">입고번호</th>
							<th class="text-center">입고 상품명</th>
							<th class="text-center">입고수량</th>
							<th class="text-center">입고일자</th>
							<th class="text-center">입고담당자</th>
							<th class="text-center">입고비고</th>
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
			let leftcol = document.getElementById("leftcol"); // 좌측
			let rightcolT = document.getElementById("rightcolT"); // 우측 상단
			//let rightcolM = document.getElementById("rightcolM"); // 우측 중단
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
			//console.log(newColDefn);
	
			page.style.gridTemplateColumns = newColDefn;
	
			event.preventDefault();
		} else if (isDraggingV) { // rightcolT와 rightcolB 사이
			let dragbarWidth = 4;

			let page_height = parseInt($('#page').height()); 			// 전체 높이
			let rightcolT_height = parseInt($('#rightcolT').height());	// 우측 상단
			let rightcolB_height = parseInt($('#rightcolB').height());	// 우측 하단

			let rightcolT_min_height = 100;	// 우측 상단 최소높이
			let rightcolB_min_height = 34;	// 우측 하단 최소높이

			let cursorY = event.clientY;	// 현재 cursor y좌표(위에서부터 얼마나 떨어졌는지)
			//console.log(cursorY);
			//console.log(page_height - rightcolB_height - dragbarWidth);
			
			let cols = [
				Math.min(Math.max(rightcolT_min_height, cursorY), page_height - rightcolB_min_height - dragbarWidth),
				dragbarWidth,
				page_height - dragbarWidth - Math.min(Math.max(rightcolT_min_height, cursorY), page_height - rightcolB_min_height - dragbarWidth),
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
			let rightcolT_height = parseInt($('#rightcolT').height());	// 우측 상단
			let rightcolB_height = parseInt($('#rightcolB').height());	// 우측 하단

			let rightcolT_min_height = 100;	// 우측 상단 최소높이
			let rightcolB_min_height = 34;	// 우측 하단 최소높이

			let dragbarV_height = 4;

			let cols = [];

			//최소화기능만 적용
			cols = [
				page_height - rightcolB_min_height - dragbarWidth,
				dragbarWidth,
				rightcolB_min_height
			];
			
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
		
		dataTableDrawAll(); // dataTable 전체 reload */
	}
	
	$('#btnOpen').on('click',function() { // right-box 열기버튼 클릭
		if($('#rightcolT').hasClass('d-none')){
			$('#page').css('grid-template-columns', '1.1fr 4px 1fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcolT').removeClass('d-none');
		} else {
			$('#page').css('grid-template-columns', '0fr 4px 1fr');
			$('#leftcol').addClass('d-none');
			$('#rightcolT').removeClass('d-none');
		}
		dataTableDrawAll(); // dataTable 전체 reload
	});
	$('#btnClose').on('click',function() { // right-box 닫기버튼 클릭
		if($('#leftcol').hasClass('d-none')){
			$('#page').css('grid-template-columns', '1.1fr 4px 1fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcolT').removeClass('d-none');
		} else {
			$('#page').css('grid-template-columns', '1.1fr 4px 0fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcolT').addClass('d-none');
		}
		dataTableDrawAll(); // dataTable 전체 reload
	});
</script>

<script>
	WM_init('PURCHASE_ADM_NEW');
	WM_init('PURCHASE_DTL_EDIT');
	WM_init('INITEM_SAVE');

	let monthAdjustList = getCommonCode('시스템', '026'); //날짜조정
	monthAdjustList = _.sortBy(monthAdjustList, v=>parseInt(v.commonCd));
	selectBoxAppend(monthAdjustList, 'monthAdjust', '', '2'); //날짜조정
	
	// 공통코드 조회
	let dealGubunList = getCommonCode('시스템', '011'); // 거래구분
	let dealStatusList = getCommonCode('시스템', '015'); // 거래상태
	let pageLengthCnt = parseInt(getCommonCode('시스템', '025')[0].commonCd); //페이징수량
	let itemGubunList = getCommonCode('일반', '001'); // 제품구분
	let useYnCdList = getCommonCode('시스템', '055'); // 사용여부
	
	selectBoxAppend(dealGubunList, 'modalDealGubun', '', '1'); //거래구분
	selectBoxAppend(dealStatusList, 'modalDealCorpStatus', '', '1'); //거래상태
	selectBoxAppend(itemGubunList, 'modalItemGubunBox', '002', '1'); //제품구분
	selectBoxAppend(useYnCdList, 'modalUseYnCdBox', 'Y', '1'); //사용여부

	let selectPeriod = parseInt(getCommonCode('시스템', '040')[0].commonCd); //기본조회기간 일
	$('#startDate').val(moment().subtract('d',selectPeriod).format('YYYY-MM-DD'));
	$('#endDate').val(moment().format('YYYY-MM-DD'));
	$('#purchaseDate').val(moment().format('YYYY-MM-DD'));
	
	//변수모음
	let sessionUserNm = "${userNm}";//세션에서 가져온 유저이름
	let sessionUserIdx = "${userIdx}";//세션에서 가져온 유저식별자
	let purcharseNo = '';

	$('#btnSearch').on('click',function(){
		allTableReload();
		purchaseAddTable.ajax.reload();	
		//열 움직이는 기능 잠금
		purchaseAddTable.colReorder.enable();
		//필터 잠금
		$('#purchaseAddTable_wrapper').find('.filters th').each(function(index, item) {
			$(item).find('input').attr('disabled', false); // 검색 필터 disabled
		});
		inItemSaveTable.ajax.reload();
		//열 움직이는 기능 잠금
		inItemSaveTable.colReorder.enable();
		//필터 잠금
		$('#inItemSaveTable_wrapper').find('.filters th').each(function(index, item) {
			$(item).find('input').attr('disabled', false); // 검색 필터 disabled
		});
		itemPurchaseInTable.ajax.reload();
		//열 움직이는 기능 잠금
		itemPurchaseInTable.colReorder.enable();
		//필터 잠금
		$('#itemPurchaseInTable_wrapper').find('.filters th').each(function(index, item) {
			$(item).find('input').attr('disabled', false); // 검색 필터 disabled
		});
		//발주탭
		$('#btnPurchaseAddNew').attr('disabled',false);
		$('#btnPurchaseAddSave').attr('disabled',true);
		$('#btnPurchaseAddEdit').attr('disabled',true);
		$('#btnPurchaseAddDel').attr('disabled',false);
		$('#btnPurchaseAddCancel').attr('disabled',true);

		//입고탭
		$('#btnInItemSave').attr('disabled',true);
		$('#btnInItemsEdit').attr('disabled',false);
		$('#btnInItemCancel').attr('disabled',true);

		//입고상세내역탭
		$('#btnItemPurchaseInDel').attr('disabled',false);
	});
	
	/****************************** 테이블 모음집   ******************************/
	// 발주정보 발주번호 그룹 테이블
	$('#purchaseGroupTable thead tr').clone(true).addClass('filters').appendTo('#purchaseGroupTable thead'); // filter 생성
	let purchaseGroupTable = $('#purchaseGroupTable').DataTable({
		dom : "<'row'<'col-md-12 col-md-6'l><'col-md-12 col-md-6'f>>"
				+ "<'row'<'col-md-12'tr>>"
				+ "<'row pt-1'<'d-flex align-items-center d-flex'Bp><'me-lg-auto'><'d-flex align-items-center justify-content-end'i>>",
		language: lang_kor,
		info: true,
		ordering: false,
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
			url : '<c:url value="/wm/itemPurchaseOrdLstGroupByPurchaseNo"/>',
			type : 'POST',
			data : {
				'startDate'	:	function(){ return $('#startDate').val().replaceAll('-',''); },
				'endDate'	:	function(){ return $('#endDate').val().replaceAll('-',''); },
				'searchTarget'	:	function(){ return $('#searchTarget').val(); },
			},
		},
        rowId: 'purchaseOrdNo',
		columns : [
			{ data: 'purchaseOrdNo', className : 'text-center align-middle',name:'purchaseOrdNo',
				render : function(data, type, row, meta) {
					if(data != '' && data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ data: 'purchaseDate', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != '' && data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data).format('YYYY-MM-DD')+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ data: 'sumPurchaseQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if(data != '' && data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
					} else {
						return '0';
					}
				}
			},
			{ data: 'sumInQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if(data != '' && data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
					} else {
						return '0';
					}
				}	
			},
			{ data: 'sumPurchaseQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if(data != '' && data != null){
						let sumPurchaseQty = row['sumPurchaseQty'] != '' && row['sumPurchaseQty'] != null ? parseFloat(row['sumPurchaseQty']) : 0;
						let sumInQty = row['sumInQty'] != '' && row['sumInQty'] != null ? parseFloat(row['sumInQty']) : 0; 
						let value = addCommas(sumPurchaseQty - sumInQty);
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+value+'</div>';
					} else {
						return '0';
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
		rowsGroup: [
			'purchaseOrdNo:name'
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
			
			let htmlHeight = parseFloat($('#leftcol').css('height'));
			let headHeight = parseFloat($('#leftHeader').css('height'));
			let theadHeight = parseFloat($('#purchaseGroupTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - headHeight - theadHeight - 45)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAllPgt').off('keyup',function() {});
			$('#searchAllPgt').on('keyup',function() {
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
				let cell = $('#purchaseGroupTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#purchaseGroupTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	purchaseGroupTable.on('column-reorder', function( e, settings, details ) {
		let api = purchaseGroupTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#purchaseGroupTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	$('#purchaseGroupTable tbody').on('click','tr', function() {
		let idx = purchaseGroupTable.row(this).data().purchaseOrdNo;
		purcharseNo = purchaseGroupTable.row(this).data().purchaseOrdNo;
		if(WMCheck('PURCHASE_ADM_NEW')) { // 발주등록중일 경우
			setWM('PURCHASE_ADM_NEW', 'idx', idx);
			return false;
		} 
		if(WMCheck('PURCHASE_DTL_EDIT')) { // 발주수정중일 경우
			setWM('PURCHASE_DTL_EDIT', 'idx', idx);
			return false;
		} 
		if(WMCheck('INITEM_SAVE')) { // 입고등록중일 경우
			setWM('INITEM_SAVE', 'idx', idx);
			return false;
		} 
		
		purchaseAddTable.ajax.reload();	
		//열 움직이는 기능 잠금
		purchaseAddTable.colReorder.enable();
		//필터 잠금
		$('#purchaseAddTable_wrapper').find('.filters th').each(function(index, item) {
			$(item).find('input').attr('disabled', false); // 검색 필터 disabled
		});
		inItemSaveTable.ajax.reload();
		//열 움직이는 기능 잠금
		inItemSaveTable.colReorder.enable();
		//필터 잠금
		$('#inItemSaveTable_wrapper').find('.filters th').each(function(index, item) {
			$(item).find('input').attr('disabled', false); // 검색 필터 disabled
		});
		itemPurchaseInTable.ajax.reload();
		//열 움직이는 기능 잠금
		itemPurchaseInTable.colReorder.enable();
		//필터 잠금
		$('#itemPurchaseInTable_wrapper').find('.filters th').each(function(index, item) {
			$(item).find('input').attr('disabled', false); // 검색 필터 disabled
		});
		//발주탭
		$('#btnPurchaseAddNew').attr('disabled',false);
		$('#btnPurchaseAddSave').attr('disabled',true);
		$('#btnPurchaseAddEdit').attr('disabled',false);
		$('#btnPurchaseAddDel').attr('disabled',false);
		$('#btnPurchaseAddCancel').attr('disabled',true);

		//입고탭
		$('#btnInItemSave').attr('disabled',true);
		$('#btnInItemsEdit').attr('disabled',false);
		$('#btnInItemCancel').attr('disabled',true);

		//입고상세내역탭
		$('#btnItemPurchaseInDel').attr('disabled',false);
	});

	// 발주 등록/상세조회되는  테이블
	$('#purchaseAddTable thead tr').clone(true).addClass('filters').appendTo('#purchaseAddTable thead'); // filter 생성
	let purchaseAddTable = $('#purchaseAddTable').DataTable({
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
		//responsive: true,
		colReorder: true,
		select: {
            style: 'single',
            toggleable: false,
            items: 'row',
            info: false
        },
        ajax : {
			url : '<c:url value="/wm/itemPurchaseOrdLstByPurchaseNo"/>',
			type : 'POST',
			data : {
				'purchaseOrdNo'	:	function(){return purcharseNo;},
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'rowGubun', className : 'text-center align-middle', //체크박스
				render : function(data, type, row, meta) {
					if(row['rowGubun'] == 'new'){
						let html = '';
						html += '<input type="checkbox" name="btnPurchaseCheck" style="width: 25px; height: 25px;">';
						return html; 
					} else {
						if(parseFloat(row['sumInQty']) > 0){
							let html = '';
							html += '<input type="checkbox" name="btnPurchaseCheckNot" style="width: 25px; height: 25px;" disabled>';
							return html; 
						} else {
							let html = '';
							html += '<input type="checkbox" name="btnPurchaseCheck" style="width: 25px; height: 25px;">';
							return html; 
						}
					}
				}
			},
			{ data: 'purchaseDate', className : 'text-center align-middle', name:'purchaseDate', //발주일자
				render : function(data, type, row, meta) {
					if(row['rowGubun'] == 'new'){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data).format('YYYY-MM-DD')+'</div>';
					} else {
						if(data != null && data != ''){
							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data).format('YYYY-MM-DD')+'</div>';
						} else {
							let html = '';
							html += '<input type="date" max="9999-12-31" class="form-control" name="purchaseDate" value="'+moment().format('YYYY-MM-DD')+'">';
							return html; 
						}
					}
				}
			},
			{ data: 'itemNm', className : 'text-center align-middle', //상품명
				render : function(data, type, row, meta) {
					if(data != '' && data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ data: 'purchaseQty', className : 'text-end align-middle', name:'purchaseQty', //발주수량
				render : function(data, type, row, meta) {
					if(row['rowGubun'] == 'new'){
						let html = '';
						html += '<input type="text" class="form-control text-end" name="purchaseQty" value="0" onkeyup="numberFormat(this,\'int\')">';
						return html;
					} else {
						if(data != '' && data != null){
							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseInt(data))+'</div>';
						} else {
							return '0';
						}
					}
				}
			},
			{ data: 'purchaseCorpIdx', className : 'text-center align-middle',name:'purchaseCorp', //발주처
				render : function(data, type, row, meta) {
					if(row['rowGubun'] == 'new'){
						let html = '';
						html += '<div style="display: flex; flex-wrap: 1 1 auto;min-width:150px;" class="input-group">';
						html += '	<input type="text" class="form-control inputGroup" name="purchaseCorpNm" value="'+row['purchaseCorpNm']+'" disabled="disabled">';
						html += '	<button type="button" class="inputGroup btnInputDel" style="background-color: transparent; border-color: transparent; position: absolute; top: 0; right: 0; margin: 1px 23px; margin-left: 0px; border: none;">';
						html += '		<i class="fa-solid fa-xmark"></i>';
						html += '	</button>';
						html += '	<input type="hidden" name="purchaseCorpIdx" value="'+row['purchaseCorpIdx']+'">';
						html += '	<button data-table="purchaseAddTable" type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary input-sub-search inputGroup" name="customerModalBtn">';
						html += '		<i class="fa-solid fa-magnifying-glass"></i>';
						html += '	</button>';
						html += '</div>';
						return html;
					} else {
						if(data != '' && data != null){
							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+row['purchaseCorpNm']+'</div>';
						} else {
							return '-';
						}
					}
				}
			},
			{ data: 'bizOrdDtlNo', className : 'text-center align-middle', name:'bizOrdDtlNo', //수주상세번호
				render : function(data, type, row, meta) {
					if(row['rowGubun'] == 'new'){
						let html = '';
						html += '<input type="text" class="form-control" name="bizOrdDtlNo">';
						return html;
					} else {
						if(data != '' && data != null){
							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						} else {
							return '';
						}
					}
				}
			},
			{ data: 'purchaseUserIdx', className : 'text-center align-middle', name:'purchaseUser', //발주담당자
				render : function(data, type, row, meta) {
					if(row['rowGubun'] == 'new'){
						let html = '';
						html += '<div class="input-group" style="min-width: 105px;max-width: 105px;">';
						html += '	<input type="text" class="form-control" name="purchaseUserNm" value="'+row['purchaseUserNm']+'" disabled>';
						html += '	<button type="button" class="btnInputDel" style="background-color: transparent;';
						html += '		border-color: transparent; position: absolute;';
						html += '		top: 0; right:0;';
						html += '		margin: 1px 23px; margin-left: 0px;';
						html += '		border: none;';
						html += '		">';
						html += '		<i class="fa-solid fa-xmark"></i>';
						html += '	</button>';
						html += '	<input type="hidden" name="purchaseUserIdx" value="'+row['purchaseUserIdx']+'">';
						html += '	<button data-table="purchaseAddTable" type="button" style="padding: 1px 4px; margin-left: 0px;" name="btnUserModalShow" class="btn btn-primary btnUserModalShow">';
						html += '		<i class="fa-solid fa-magnifying-glass"></i>';
						html += '	</button>';
						html += '</div>';
						return html;
					} else {
						if(data != '' && data != null){
							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+row['purchaseUserNm']+'</div>';
						} else {
							return '-';
						}
					}
				}
			},
			{ data: 'purchaseDesc', className : 'text-center align-middle', name:'purchaseDesc', //발주비고
				render : function(data, type, row, meta) {
					if(row['rowGubun'] == 'new'){
						let html = '';
						html += '<input type="text" style="min-width:200px;" class="form-control" name="purchaseDesc">'
						return html;
					} else {
						if(data != '' && data != null){
							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						} else {
							return '';
						}
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
			
			let htmlHeight = parseFloat($('#rightcolT').css('height'));
			let tabHeadHeight = parseFloat($('#nav-tab').css('height'));
			let buttonHeadHeight = parseFloat($('#tab1ButtonHeader').css('height'));
			let theadHeight = parseFloat($('#purchaseAddTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - tabHeadHeight - buttonHeadHeight - 93)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAllPat').off('keyup',function() {});
			$('#searchAllPat').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			});

			let data = api.data();
			let node = api.rows().nodes();
			if(data.length > 0){
				$(node).each(function(index, item) {
					let selectData = purchaseAddTable.row(item).data();
					if( parseFloat(selectData.sumInQty) > 0 ) {
						$(purchaseAddTable.row(item).node()).addClass('notEdit');
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
				let cell = $('#purchaseAddTable_wrapper').find('.filters th').eq(
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
				$('#purchaseAddTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});

				purchaseAddTable.columns.adjust();
			});
		},
	});
	// dataTable colReorder event
	purchaseAddTable.on('column-reorder', function( e, settings, details ) {
		let api = purchaseAddTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#purchaseAddTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	// 입고 목록조회
	$('#itemPurchaseInTable thead tr').clone(true).addClass('filters').appendTo('#itemPurchaseInTable thead'); // filter 생성
	let itemPurchaseInTable = $('#itemPurchaseInTable').DataTable({
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
			url : '<c:url value="/wm/inItemLstByPurchaseNo"/>',
			type : 'POST',
			data : {
				'purchaseOrdNo'	:	function(){ return purcharseNo; }, 
			},
		},
        rowId: 'idx',
		columns : [
			{ className : 'text-center align-middle', //체크박스
				render : function(data, type, row, meta) {
					let html = '';
					html += '<input type="checkbox" name="btnItemPurchaseInCheck" style="width: 25px; height: 25px;">';
					return html; 
				}
			},
			{ data: 'inSlipNo', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data + '-' + row['inSlipSeq'] +'</div>';
				}
			},
			{ data: 'itemNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
				}
			},
			{ data: 'inQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseInt(data))+'</div>';
					} else {
						return ''; 
					}
				}
			},
			{ data: 'inDate', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data).format('YYYY-MM-DD')+'</div>';
					} else {
						return ''; 
					}
				}
			},
			{ data: 'inUserName', className : 'text-center align-middle'},
			{ data: 'inDesc', className : 'text-center align-middle',

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
			
			let htmlHeight = parseFloat($('#rightcolB').css('height'));
			let headHeight = parseFloat($('#rightBottomHeader').css('height'));
			let theadHeight = parseFloat($('#itemPurchaseInTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - headHeight - theadHeight - 13)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAllIpi').off('keyup',function() {});
			$('#searchAllIpi').on('keyup',function() {
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
				let cell = $('#itemPurchaseInTable_wrapper').find('.filters th').eq(
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
				$('#itemPurchaseInTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
			itemPurchaseInTable.columns.adjust();
		},
	});
	// dataTable colReorder event
	itemPurchaseInTable.on('column-reorder', function( e, settings, details ) {
		let api = itemPurchaseInTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#itemPurchaseInTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	//오른쪽 상단 입고탭
	$('#inItemSaveTable thead tr').clone(true).addClass('filters').appendTo('#inItemSaveTable thead'); // filter 생성
	let inItemSaveTable = $('#inItemSaveTable').DataTable({
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
			url : '<c:url value="/wm/itemPurchaseOrdLstByPurchaseNo"/>',
			type : 'POST',
			data : {
				'purchaseOrdNo'	:	function(){return purcharseNo;},
			},
		},
        rowId: 'idx',
		columns : [
			{ className : 'text-center align-middle', //체크박스
				render : function(data, type, row, meta) {
					let html = '';
					html += '<input type="checkbox" name="btnInItemCheck" style="width: 25px; height: 25px;">';
					return html; 
				}
			},
			{ data: 'itemNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != '' && data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			}, //상품코드/상품명
			{ data: 'purchaseDate', className : 'text-center align-middle', name:'inDate',
				render : function(data, type, row, meta) {
					return moment().format('YYYY-MM-DD');
				}	
			},//입고일자
			{ data: 'purchaseQty', className : 'text-end align-middle', name:'inQty',
				render : function(data, type, row, meta) {
					if(data != '' && data != null){
						let purchaseQty = row['purchaseQty'] != '' && row['purchaseQty'] != null ? parseFloat(row['purchaseQty']) : 0;
						let sumInQty = row['sumInQty'] != '' && row['sumInQty'] != null ? parseFloat(row['sumInQty']) : 0; 
						let value = addCommas(purchaseQty - sumInQty);
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+value+'</div>';
					} else {
						return '0';
					}
				}	
			},//입고수량
			{ data: 'purchaseQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if(data != '' && data != null){
						let purchaseQty = row['purchaseQty'] != '' && row['purchaseQty'] != null ? parseFloat(row['purchaseQty']) : 0;
						let sumInQty = row['sumInQty'] != '' && row['sumInQty'] != null ? parseFloat(row['sumInQty']) : 0; 
						let value = addCommas(purchaseQty - sumInQty);
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+value+'</div>';
					} else {
						return '0';
					}
				}	
			},//잔량
			{ className : 'text-center align-middle', name:'inUser',
				render : function(data, type, row, meta) {
					return '-';
				}	
			},//담당자
			{ className : 'text-center align-middle', name:'inDesc',
				render : function(data, type, row, meta) {
					return '-';
				}	
			},//비고

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
			
			let htmlHeight = parseFloat($('#rightcolT').css('height'));
			let tabHeadHeight = parseFloat($('#nav-tab').css('height'));
			let buttonHeadHeight = parseFloat($('#tab2ButtonHeader').css('height'));
			let theadHeight = parseFloat($('#inItemSaveTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - tabHeadHeight - buttonHeadHeight - theadHeight - 26)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAllIis').off('keyup',function() {});
			$('#searchAllIis').on('keyup',function() {
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
				let cell = $('#inItemSaveTable_wrapper').find('.filters th').eq(
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
				$('#inItemSaveTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});

				inItemSaveTable.columns.adjust();
			});
		},
	});
	// dataTable colReorder event
	inItemSaveTable.on('column-reorder', function( e, settings, details ) {
		let api = inItemSaveTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#inItemSaveTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

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

	$('#itemCodeModal').on('shown.bs.modal', function() {
		itemCodeModalTable.ajax.reload(function() {
			itemCodeModalTable.columns.adjust();
		});
	});
	
	/****************************** 테이블 모음집  끝 ******************************/

	/****************************** 탭 클릭   ******************************/
	//발주탭
	$('#tab1Nav').on('click',function(){
		purchaseAddTable.ajax.reload(function(){
			purchaseAddTable.columns.adjust();
		});
	});

	//입고탭
	$('#tab2Nav').on('click',function(){
		inItemSaveTable.ajax.reload(function(){
			inItemSaveTable.columns.adjust();
		});
	});
	/****************************** 탭 클릭 끝  ******************************/
	
	/****************************** 발주 등록 탭 ******************************/
	//추가
	$('#btnPurchaseAddNew').on('click',function(){
		itemCodeModalTable.rows('.selected').deselect();
		itemCodeModalTable.select.style('multi');
		itemCodeModalTable.select.toggleable(true);
		$('#itemCodeModal').modal('show');
	});

	//상품 붙여넣기
	$('#btnItemCodeModalPaste').on('click',function(){
		if(!$('#itemCodeModalTable tbody tr').hasClass('selected')){
			toastr.warning('붙여넣을 행을 선택해주세요.');
			return false;
		}

		purcharseNo = '';
		purchaseGroupTable.rows('.selected').deselect();
		
		purchaseAddTable.clear().draw();
		
		$('#my-spinner').show();
		let dataList = itemCodeModalTable.rows('.selected').data().toArray();
		let addList = [];
		for(var i=0;i<dataList.length;i++) {
			let obj = {};
			obj.itemNm = dataList[i].itemNm;//상품명
			obj.itemCdAndNm = dataList[i].itemCd + " / " + dataList[i].itemNm;//상품코드/상품명
			obj.purchaseDate = $('#purchaseDate').val();//발주일자
			obj.purchaseQty = 0;//발주수량
			obj.purchaseCorpIdx = dataList[i].customerIdx; //발주처식별자
			obj.purchaseCorpNm = dataList[i].customerNm; //발주처명
			obj.bizOrdDtlNo = ''; //수주상세번호 
			obj.purchaseUserIdx = sessionUserIdx;
			obj.purchaseUserNm = sessionUserNm;
			obj.purchaseDesc = ''; //발주비고
			obj.rowGubun = 'new'; //행 구분 신규
			obj.itemIdx = dataList[i].idx;
			obj.itemVerIdx = dataList[i].itemVerIdx;
			
			addList.push(obj);
		}
		purchaseAddTable.rows.add(addList).draw(false).columns.adjust();
		//열 움직이는 기능 잠금
		purchaseAddTable.colReorder.disable();
		//필터 잠금
		$('#purchaseAddTable_wrapper').find('.filters th').each(function(index, item) {
			$(item).find('input').attr('disabled', true); // 검색 필터 disabled
		});
		
		$('#my-spinner').hide();
		
		$('#itemCodeModal').modal('hide');
		toastr.success('추가되었습니다.');
		
		WM_action_ON('PURCHASE_ADM_NEW', 'workingWarningModal');

		$('#btnPurchaseAddNew').attr('disabled',false);
		$('#btnPurchaseAddSave').attr('disabled',false);
		$('#btnPurchaseAddEdit').attr('disabled',true);
		$('#btnPurchaseAddDel').attr('disabled',false);
		$('#btnPurchaseAddCancel').attr('disabled',false);
		
	});

	//수정
	$('#btnPurchaseAddEdit').on('click',function(){
		$('#btnPurchaseAddNew').attr('disabled',true);
		$('#btnPurchaseAddSave').attr('disabled',false);
		$('#btnPurchaseAddEdit').attr('disabled',true);
		$('#btnPurchaseAddDel').attr('disabled',false);
		$('#btnPurchaseAddCancel').attr('disabled',false);
		
		WM_action_ON('PURCHASE_DTL_EDIT', 'workingWarningModal');
		
		$('#purchaseAddTable_wrapper').find('.filters th').each(function(index, item) {
			$(item).find('input').attr('disabled', true); // 검색 필터 disabled
		});
		//열 움직이는 기능 잠금
		purchaseAddTable.colReorder.disable();

		$('#purchaseAddTable tbody').find('tr').each(function(index_tr, tr) {
			if(!$(tr).hasClass('notEdit')){
				$(tr).find('td').each(function(index_td, td) {
					if(index_td == purchaseAddTable.column('purchaseDate:name').index()) { //발주일자
						//let value = purchaseAddTable.row(tr).data().purchaseDate;
						//value = moment(value).format('YYYY-MM-DD');
						//$(td).html('<input type="date" max="9999-12-31" name="purchaseDate" class="form-control text-center" value="'+value+'">');
					} else if(index_td == purchaseAddTable.column('purchaseQty:name').index()) { //발주수량
						let value = purchaseAddTable.row(tr).data().purchaseQty;
						value = addCommas(parseFloat(value));
						$(td).html('<input type="text" name="purchaseQty" class="form-control text-end" onkeyup="numberFormat(this, \'int\')" value="'+value+'">');
					} else if(index_td == purchaseAddTable.column('purchaseCorp:name').index()) { //발주수량
						let purchaseCorpIdx = purchaseAddTable.row(tr).data().purchaseCorpIdx;
						let purchaseCorpNm = purchaseAddTable.row(tr).data().purchaseCorpNm;
						let html = '';
						html += '<div style="display: flex; flex-wrap: 1 1 auto;min-width:150px;" class="input-group">';
						html += '	<input type="text" class="form-control inputGroup" name="purchaseCorpNm" value="'+purchaseCorpNm+'" disabled="disabled">';
						html += '	<button type="button" class="inputGroup btnInputDel" style="background-color: transparent; border-color: transparent; position: absolute; top: 0; right: 0; margin: 1px 23px; margin-left: 0px; border: none;">';
						html += '		<i class="fa-solid fa-xmark"></i>';
						html += '	</button>';
						html += '	<input type="hidden" name="purchaseCorpIdx" value="'+purchaseCorpIdx+'">';
						html += '	<button data-table="purchaseAddTable" type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary input-sub-search inputGroup" name="customerModalBtn">';
						html += '		<i class="fa-solid fa-magnifying-glass"></i>';
						html += '	</button>';
						html += '</div>';
						$(td).html(html);
					} else if(index_td == purchaseAddTable.column('bizOrdDtlNo:name').index()) { //수주상세번호
						let bizOrdDtlNo = purchaseAddTable.row(tr).data().bizOrdDtlNo;
						$(td).html('<input type="text" class="form-control" name="bizOrdDtlNo" value="'+bizOrdDtlNo+'">');
					} else if(index_td == purchaseAddTable.column('purchaseUser:name').index()) { //발주담당자
						let purchaseUserIdx = purchaseAddTable.row(tr).data().purchaseUserIdx;
						let purchaseUserNm = purchaseAddTable.row(tr).data().purchaseUserNm;
						let html = '';
						html += '<div class="input-group" style="min-width: 105px;max-width: 105px;">';
						html += '	<input type="text" class="form-control" name="purchaseUserNm" value="'+purchaseUserNm+'" disabled>';
						html += '	<button type="button" class="btnInputDel" style="background-color: transparent;';
						html += '		border-color: transparent; position: absolute;';
						html += '		top: 0; right:0;';
						html += '		margin: 1px 23px; margin-left: 0px;';
						html += '		border: none;';
						html += '		">';
						html += '		<i class="fa-solid fa-xmark"></i>';
						html += '	</button>';
						html += '	<input type="hidden" name="purchaseUserIdx" value="'+purchaseUserIdx+'">';
						html += '	<button data-table="purchaseAddTable" type="button" style="padding: 1px 4px; margin-left: 0px;" name="btnUserModalShow" class="btn btn-primary btnUserModalShow">';
						html += '		<i class="fa-solid fa-magnifying-glass"></i>';
						html += '	</button>';
						html += '</div>';
						$(td).html(html);
					} else if(index_td == purchaseAddTable.column('purchaseDesc:name').index()) { //발주비고
						let purchaseDesc = purchaseAddTable.row(tr).data().purchaseDesc;
						$(td).html('<input type="text" style="min-width:200px;" class="form-control" name="purchaseDesc" value="'+purchaseDesc+'">');
					}  
				})
			}
		});

		purchaseAddTable.columns.adjust().draw();
	});

	//저장
	$('#btnPurchaseAddSave').on('click',function(){
		if(getWM('PURCHASE_ADM_NEW','state')){ //신규 등록중 이었을 경우
			$('#my-spinner').show();	
			purchaseAdmIns();
		} else if(getWM('PURCHASE_DTL_EDIT','state')){ //수정중일경우
			$('#my-spinner').show();	
			purchaseDtlUpd();
		}
	});

	//삭제
	$('#btnPurchaseAddDel').on('click',function(){
		if( $('input:checkbox[name=btnPurchaseCheck]:checked').length == 0){
			toastr.warning('삭제할 항목을 체크해주세요.');
			return false;
		}

		$('#deleteModal').modal('show');
		$('#deleteModal').data('deleteType','Purchase');
	});
	
	function purchaseAdmIns(){
		let array = [];
		let state = true;
		
		$('#purchaseAddTable tbody').find('tr').each(function(index, item) {
			let td = $(item).find('td');
			let data = purchaseAddTable.row($(item)).data();
			let node = purchaseAddTable.row($(item)).node();

			//발주처
			let purchaseCorpCol = purchaseAddTable.column('purchaseCorp:name').index();
			let purchaseCorpIdx = $(td).eq(purchaseCorpCol).find('input[name=purchaseCorpIdx]').val();

			//발주일자
			let purchaseDateCol = purchaseAddTable.column('purchaseDate:name').index();
			//let purchaseDate = $(td).eq(purchaseDateCol).find('input[name=purchaseDate]').val();
			let purchaseDate = $(td).eq(purchaseDateCol).find('div').text();
			
			//발주수량
			let purchaseQtyCol = purchaseAddTable.column('purchaseQty:name').index();
			let purchaseQty = $(td).eq(purchaseQtyCol).find('input[name=purchaseQty]').val();

			//수주상세번호(키인)
			let bizOrdDtlNoCol = purchaseAddTable.column('bizOrdDtlNo:name').index();
			let bizOrdDtlNo = $(td).eq(bizOrdDtlNoCol).find('input[name=bizOrdDtlNo]').val();

			//발주담당자
			let purchaseUserCol = purchaseAddTable.column('purchaseUser:name').index();
			let purchaseUserIdx = $(td).eq(purchaseUserCol).find('input[name=purchaseUserIdx]').val();

			//발주비고
			let purchaseDescCol = purchaseAddTable.column('purchaseDesc:name').index();
			let purchaseDesc = $(td).eq(purchaseDescCol).find('input[name=purchaseDesc]').val();
			
			if(purchaseDate == '' || purchaseDate == null){
				$(td).eq(purchaseDateCol).find('input[name=purchaseDate]').focus();
				toastr.warning('발주일자를 선택해주세요.');
				state = false;
				return false;
			}

			if(purchaseQty == '0' || purchaseQty == ''){
				$(td).eq(purchaseQtyCol).find('input[name=purchaseQty]').focus();
				toastr.warning('발주수량을 입력해주세요.');
				state = false;
				return false;
			}

			if(purchaseCorpIdx == '0' || purchaseCorpIdx == null || purchaseCorpIdx == 'null' || purchaseCorpIdx == '' || purchaseCorpIdx == undefined){
				$(td).eq(purchaseCorpCol).find('input[name=customerModalBtn]').focus();
				toastr.warning('발주처를 선택해주세요.');
				state = false;
				return false;
			}

			if(purchaseUserIdx == '0' || purchaseUserIdx == null || purchaseUserIdx == 'null' || purchaseUserIdx == '' || purchaseUserIdx == undefined){
				$(td).eq(purchaseCorpCol).find('button[name=btnUserModalShow]').focus();
				toastr.warning('발주담당자를 선택해주세요.');
				state = false;
				return false;
			}
			
			let obj = new Object();
			obj.ITEM_IDX = data.itemIdx; 							//상품식별자
			obj.ITEM_VER_IDX = data.itemVerIdx;						//버전식별자
			obj.PURCHASE_CORP_IDX = purchaseCorpIdx;				//발주처식별자
			obj.PURCHASE_GUBUN = 'A';	 							//발주구분 (상품발주 - A)
			obj.PURCHASE_ORD_NO = ''; 								//발주번호 채번 예정
			obj.PURCHASE_DATE = purchaseDate.replaceAll('-',''); 	//발주일자
			obj.PURCHASE_QTY = removeCommas(purchaseQty);			//발주수량
			obj.BIZ_ORD_DTL_NO = bizOrdDtlNo.trim();				//수주상세번호
			obj.PURCHASE_USER_IDX = purchaseUserIdx;				//발주담당자
			obj.PURCHASE_DESC = purchaseDesc;						//발주비고
			array.push(obj);
		});

		if(state){
			$.ajax({
				url: '<c:url value="/wm/itemPurchaseIns"/>',
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
						allTableReload();

						//열 움직이는 기능 잠금
						purchaseAddTable.colReorder.enable();
						//필터 잠금
						$('#purchaseAddTable_wrapper').find('.filters th').each(function(index, item) {
							$(item).find('input').attr('disabled', false); // 검색 필터 disabled
						});

						WM_action_OFF('PURCHASE_ADM_NEW');

						$('#btnPurchaseAddNew').attr('disabled',false);
						$('#btnPurchaseAddSave').attr('disabled',true);
						$('#btnPurchaseAddEdit').attr('disabled',true);
						$('#btnPurchaseAddDel').attr('disabled',false);
						$('#btnPurchaseAddCancel').attr('disabled',true);
						
					} else if(res.result == 'fail') {
						toastr.warning(res.message);
					} else {
						toastr.error(res.message);
					}
					$('#my-spinner').hide();
				}
			});
		} else{
			$('#my-spinner').hide();
		}
		
	}

	function purchaseDtlUpd(){
		let array = [];
		let state = true;
		
		$('#purchaseAddTable tbody').find('tr').each(function(index, item) {
			if(!$(item).hasClass('notEdit')){
				let td = $(item).find('td');
				let data = purchaseAddTable.row($(item)).data();
				let node = purchaseAddTable.row($(item)).node();
	
				//발주처
				let purchaseCorpCol = purchaseAddTable.column('purchaseCorp:name').index();
				let purchaseCorpIdx = $(td).eq(purchaseCorpCol).find('input[name=purchaseCorpIdx]').val();
	
				//발주일자
				let purchaseDateCol = purchaseAddTable.column('purchaseDate:name').index();
				//let purchaseDate = $(td).eq(purchaseDateCol).find('input[name=purchaseDate]').val();
				let purchaseDate = $(td).eq(purchaseDateCol).find('div').text();
							
				//발주수량
				let purchaseQtyCol = purchaseAddTable.column('purchaseQty:name').index();
				let purchaseQty = $(td).eq(purchaseQtyCol).find('input[name=purchaseQty]').val();
	
				//수주상세번호(키인)
				let bizOrdDtlNoCol = purchaseAddTable.column('bizOrdDtlNo:name').index();
				let bizOrdDtlNo = $(td).eq(bizOrdDtlNoCol).find('input[name=bizOrdDtlNo]').val();
	
				//발주담당자
				let purchaseUserCol = purchaseAddTable.column('purchaseUser:name').index();
				let purchaseUserIdx = $(td).eq(purchaseUserCol).find('input[name=purchaseUserIdx]').val();
	
				//발주비고
				let purchaseDescCol = purchaseAddTable.column('purchaseDesc:name').index();
				let purchaseDesc = $(td).eq(purchaseDescCol).find('input[name=purchaseDesc]').val();
				
				if(purchaseDate == '' || purchaseDate == null){
					$(td).eq(purchaseDateCol).find('input[name=purchaseDate]').focus();
					toastr.warning('발주일자를 선택해주세요.');
					state = false;
					return false;
				}
	
				if(purchaseQty == '0' || purchaseQty == ''){
					$(td).eq(purchaseQtyCol).find('input[name=purchaseQty]').focus();
					toastr.warning('발주수량을 입력해주세요.');
					state = false;
					return false;
				}
	
				if(purchaseCorpIdx == '0' || purchaseCorpIdx == null || purchaseCorpIdx == 'null' || purchaseCorpIdx == '' || purchaseCorpIdx == undefined){
					$(td).eq(purchaseCorpCol).find('input[name=customerModalBtn]').focus();
					toastr.warning('발주처를 선택해주세요.');
					state = false;
					return false;
				}
	
				if(purchaseUserIdx == '0' || purchaseUserIdx == null || purchaseUserIdx == 'null' || purchaseUserIdx == '' || purchaseUserIdx == undefined){
					$(td).eq(purchaseCorpCol).find('input[name=btnUserModalShow]').focus();
					toastr.warning('발주담당자를 선택해주세요.');
					state = false;
					return false;
				}
				
				let obj = new Object();
				obj.IDX = data.idx;										//식별자
				obj.ITEM_IDX = data.itemIdx; 							//상품식별자
				obj.ITEM_VER_IDX = data.itemVerIdx;						//버전식별자
				obj.PURCHASE_CORP_IDX = purchaseCorpIdx;				//발주처식별자
				obj.PURCHASE_GUBUN = 'A';	 							//발주구분 (상품발주 - A)
				obj.PURCHASE_ORD_NO = data.purchaseOrdNo;	 			//발주번호 채번 예정
				obj.PURCHASE_DATE = purchaseDate.replaceAll('-',''); 	//발주일자
				obj.PURCHASE_QTY = parseInt(removeCommas(purchaseQty));	//발주수량
				obj.BIZ_ORD_DTL_NO = bizOrdDtlNo.trim();				//수주상세번호
				obj.PURCHASE_USER_IDX = purchaseUserIdx;				//발주담당자
				obj.PURCHASE_DESC = purchaseDesc;						//발주비고
				array.push(obj);
			}
		});
		//원본데이터
		let tableData = [];
		for(var i=0;i<purchaseAddTable.data().count();i++) {
			let obj = {};
			let data = purchaseAddTable.row(i).data();
			if( parseFloat(data.sumInQty) == 0 ){
				obj.IDX = data.idx;										
				obj.ITEM_IDX = data.itemIdx; 			
				obj.ITEM_VER_IDX = data.itemVerIdx;				
				obj.PURCHASE_CORP_IDX = data.purchaseCorpIdx;			
				obj.PURCHASE_GUBUN = data.purchaseGubun;	 
				obj.PURCHASE_ORD_NO = data.purchaseOrdNo; 								
				obj.PURCHASE_DATE = data.purchaseDate; 	
				obj.PURCHASE_QTY = parseInt(data.purchaseQty);			
				obj.BIZ_ORD_DTL_NO = data.bizOrdDtlNo;				
				obj.PURCHASE_USER_IDX = data.purchaseUserIdx;				
				obj.PURCHASE_DESC = data.purchaseDesc;						
				tableData.push(obj);
			}
		}
		array = _.differenceWith(array, tableData, _.isEqual);
		
		if(state){
			$.ajax({
				url: '<c:url value="/wm/itemPurchaseUpd"/>',
	            type: 'POST',
	            data: {
	            	'updateJson'	:	JSON.stringify(array),
	            	'purchaseOrdNo'	:	function(){return purcharseNo;},
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if (res.result == "ok") { //응답결과
						toastr.success('수정되었습니다.');
						allTableReload();

						//열 움직이는 기능 잠금
						purchaseAddTable.colReorder.enable();
						//필터 잠금
						$('#purchaseAddTable_wrapper').find('.filters th').each(function(index, item) {
							$(item).find('input').attr('disabled', false); // 검색 필터 disabled
						});

						WM_action_OFF('PURCHASE_DTL_EDIT');

						$('#btnPurchaseAddNew').attr('disabled',false);
						$('#btnPurchaseAddSave').attr('disabled',true);
						$('#btnPurchaseAddEdit').attr('disabled',true);
						$('#btnPurchaseAddDel').attr('disabled',false);
						$('#btnPurchaseAddCancel').attr('disabled',true);
						
					} else if(res.result == 'fail') {
						toastr.warning(res.message);
						allTableReload();

						//열 움직이는 기능 잠금
						purchaseAddTable.colReorder.enable();
						//필터 잠금
						$('#purchaseAddTable_wrapper').find('.filters th').each(function(index, item) {
							$(item).find('input').attr('disabled', false); // 검색 필터 disabled
						});

						WM_action_OFF('PURCHASE_DTL_EDIT');

						$('#btnPurchaseAddNew').attr('disabled',false);
						$('#btnPurchaseAddSave').attr('disabled',true);
						$('#btnPurchaseAddEdit').attr('disabled',true);
						$('#btnPurchaseAddDel').attr('disabled',false);
						$('#btnPurchaseAddCancel').attr('disabled',true);
					} else {
						toastr.error(res.message);
					}
					$('#my-spinner').hide();
				}
			});
		} else{
			$('#my-spinner').hide();
		}
		
		
	}

	//모든 체크박스 선택
	$(document).on('change','#purchaseAdmAllCheckBox', function(){
		if($('#purchaseAdmAllCheckBox').prop("checked")){
			$('input:checkbox[name=btnPurchaseCheck]').prop("checked",true);
		}else{
			$('input:checkbox[name=btnPurchaseCheck]').prop("checked",false);
		}
	});
	// 모든 체크박스 체크/해제 되도록
	$(document).on('change','input:checkbox[name=btnPurchaseCheck]', function(){
		if( $('input:checkbox[name=btnPurchaseCheck]').length == $('input:checkbox[name=btnPurchaseCheck]:checked').length ){ //전체 체크박스 수와 체크된 박스의 수가 같을 때 -> 전체체크박스 체크 , 아닐 경우 해제
			$('#purchaseAdmAllCheckBox').prop("checked",true);
		} else{
			$('#purchaseAdmAllCheckBox').prop("checked",false);
		}
 	});
	
	/****************************** 발주 등록 탭 끝  ******************************/
	
	/****************************** 입고 등록 탭  ******************************/
	$('#btnInItemsEdit').on('click',function(){
		$('#btnInItemSave').attr('disabled',false);	
		$('#btnInItemsEdit').attr('disabled',true);	
		$('#btnInItemCancel').attr('disabled',false);	

		WM_action_ON('INITEM_SAVE', 'workingWarningModal');
		
		$('#inItemSaveTable_wrapper').find('.filters th').each(function(index, item) {
			$(item).find('input').attr('disabled', true); // 검색 필터 disabled
		});
		//열 움직이는 기능 잠금
		inItemSaveTable.colReorder.disable();

		$('#inItemSaveTable tbody').find('tr').each(function(index_tr, tr) {
			$(tr).find('td').each(function(index_td, td) {
				if(index_td == inItemSaveTable.column('inDate:name').index()) { //입고일자
					$(td).html('<input type="date" max="9999-12-31" name="inDate" class="form-control text-center" value="'+moment().format('YYYY-MM-DD')+'">');
				} else if(index_td == inItemSaveTable.column('inQty:name').index()) { //입고수량
					let purchaseQty = inItemSaveTable.row(tr).data().purchaseQty != '' && inItemSaveTable.row(tr).data().purchaseQty != null ? inItemSaveTable.row(tr).data().purchaseQty : 0;
					let sumInQty = inItemSaveTable.row(tr).data().sumInQty != '' && inItemSaveTable.row(tr).data().sumInQty != null ? inItemSaveTable.row(tr).data().sumInQty : 0; 
					let value = addCommas(parseFloat(purchaseQty) - parseFloat(sumInQty));
					$(td).html('<input type="text" name="inQty" class="form-control text-end" onkeyup="numberFormat(this, \'int\')" value="'+value+'">');
				} else if(index_td == inItemSaveTable.column('inUser:name').index()) { //입고담당자
					let html = '';
					html += '<div class="input-group" style="min-width: 105px;max-width: 105px;">';
					html += '	<input type="text" class="form-control" name="inUserNm" value="'+sessionUserNm+'" disabled>';
					html += '	<button type="button" class="btnInputDel" style="background-color: transparent;';
					html += '		border-color: transparent; position: absolute;';
					html += '		top: 0; right:0;';
					html += '		margin: 1px 23px; margin-left: 0px;';
					html += '		border: none;';
					html += '		">';
					html += '		<i class="fa-solid fa-xmark"></i>';
					html += '	</button>';
					html += '	<input type="hidden" name="inUserIdx" value="'+sessionUserIdx+'">';
					html += '	<button data-table="inItemSaveTable" type="button" style="padding: 1px 4px; margin-left: 0px;" name="btnUserModalShow" class="btn btn-primary btnUserModalShow">';
					html += '		<i class="fa-solid fa-magnifying-glass"></i>';
					html += '	</button>';
					html += '</div>';
					$(td).html(html);
					
				} else if(index_td == inItemSaveTable.column('inDesc:name').index()) { //입고비고
					$(td).html('<input type="text" style="min-width:200px;" class="form-control" name="inDesc" value="">');
				}
			});
		});

		inItemSaveTable.columns.adjust().draw();
	});

	$('#btnInItemSave').on('click',function(){
		let array = [];
		let status = true;
		
		if( $('input:checkbox[name=btnInItemCheck]:checked').length == 0){
			toastr.warning('입고할 항목을 체크해주세요.');
			return false;
		}

	 	$('input:checkbox[name=btnInItemCheck]:checked').each(function(index, item){
			let td = $(item).parent().parent().find('td');
			let node = inItemSaveTable.row($(item).parent().parent()).node();
			let data = inItemSaveTable.row($(item).parent().parent()).data();

			//입고일자
			let inDateCol = inItemSaveTable.column('inDate:name').index();
			let inDate = $(td).eq(inDateCol).find('input[name=inDate]').val();
			
			//입고수량
			let inQtyCol = inItemSaveTable.column('inQty:name').index();
			let inQty = $(td).eq(inQtyCol).find('input[name=inQty]').val();
			
			//입고담당자
			let inUserCol = inItemSaveTable.column('inUser:name').index();
			let inUserIdx = $(td).eq(inUserCol).find('input[name=inUserIdx]').val();
			
			//입고비고
			let inDescCol = inItemSaveTable.column('inDesc:name').index();
			let inDesc = $(td).eq(inDescCol).find('input[name=inDesc]').val();

			if(inDate == '' || inDate == null){
				$(td).eq(inDateCol).find('input[name=inDate]').focus();
				toastr.warning('입고일자를 선택해주세요.');
				state = false;
				return false;
			}

			if(inQty == '0' || inQty == ''){
				$(td).eq(inQtyCol).find('input[name=inQty]').focus();
				toastr.warning('입고수량을 입력해주세요.');
				state = false;
				return false;
			}

			if(inUserIdx == '0' || inUserIdx == null || inUserIdx == 'null' || inUserIdx == '' || inUserIdx == undefined){
				$(td).eq(inUserCol).find('button[name=btnUserModalShow]').focus();
				toastr.warning('입고담당자를 선택해주세요.');
				state = false;
				return false;
			}
			
			let obj = new Object();
			obj.IDX = data.idx;
			obj.ITEM_IDX = data.itemIdx;
			obj.ITEM_VER_IDX = data.itemVerIdx;
			obj.IN_DATE = inDate.replaceAll('-','');
			obj.IN_QTY = removeCommas(inQty);
			obj.IN_USER_IDX = inUserIdx;
			obj.IN_DESC = inDesc;
			array.push(obj);
		 });

		 if(status){
			 $.ajax({
					url: '<c:url value="/wm/itemPurchaseInSave"/>',
		            type: 'POST',
		            data: {
		                'insertJson'	:	JSON.stringify(array)
		            },
		            beforeSend: function() {
		            	$('#my-spinner').show();
		            },
					success : function(res) {
						if (res.result == "ok") { //응답결과
							toastr.success('입고되었습니다.');
							$('#btnSearch').trigger('click');
							WM_action_OFF('INITEM_SAVE');
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
	//모든 체크박스 선택
	$(document).on('change','#purchaseInAllCheckBox', function(){
		if($('#purchaseInAllCheckBox').prop("checked")){
			$('input:checkbox[name=btnInItemCheck]').prop("checked",true);
		}else{
			$('input:checkbox[name=btnInItemCheck]').prop("checked",false);
		}
	});
	// 모든 체크박스 체크/해제 되도록
	$(document).on('change','input:checkbox[name=btnInItemCheck]', function(){
		if( $('input:checkbox[name=btnInItemCheck]').length == $('input:checkbox[name=btnInItemCheck]:checked').length ){ //전체 체크박스 수와 체크된 박스의 수가 같을 때 -> 전체체크박스 체크 , 아닐 경우 해제
			$('#purchaseInAllCheckBox').prop("checked",true);
		} else{
			$('#purchaseInAllCheckBox').prop("checked",false);
		}
 	});
	/****************************** 입고 등록 탭 끝  ******************************/
	/****************************** 입고 목록 탭  ******************************/
	//입고 삭제
	$('#btnItemPurchaseInDel').on('click',function(){
		if( $('input:checkbox[name=btnItemPurchaseInCheck]:checked').length == 0){
			toastr.warning('삭제할 항목을 체크해주세요.');
			return false;
		}

		$('#deleteModal').modal('show');
		$('#deleteModal').data('deleteType','ItemIn');
	});
	//모든 체크박스 선택
	$(document).on('change','#itemPurchaseInAllCheckBox', function(){
		if($('#itemPurchaseInAllCheckBox').prop("checked")){
			$('input:checkbox[name=btnItemPurchaseInCheck]').prop("checked",true);
		}else{
			$('input:checkbox[name=btnItemPurchaseInCheck]').prop("checked",false);
		}
	});
	// 모든 체크박스 체크/해제 되도록
	$(document).on('change','input:checkbox[name=btnItemPurchaseInCheck]', function(){
		if( $('input:checkbox[name=btnItemPurchaseInCheck]').length == $('input:checkbox[name=btnItemPurchaseInCheck]:checked').length ){ //전체 체크박스 수와 체크된 박스의 수가 같을 때 -> 전체체크박스 체크 , 아닐 경우 해제
			$('#itemPurchaseInAllCheckBox').prop("checked",true);
		} else{
			$('#itemPurchaseInAllCheckBox').prop("checked",false);
		}
 	});
	/****************************** 입고 목록 탭 끝  ******************************/
	
	/****************************** 사용자 모달  ******************************/
	//사용자모달버튼
	$(document).on('click', 'button[name=btnUserModalShow]', function() {
		$('#userModal').data('table',$(this).data('table'));
		$('#userModal').modal('show');
	});
	$('#userModal').on('shown.bs.modal', function() {
		userModalTable.ajax.reload(function() {});
	});

	// 사용자정보 목록조회
	$('#userModalTable thead tr').clone(true).addClass('filters').appendTo('#userModalTable thead'); // filter 생성
	let userModalTable = $('#userModalTable').DataTable({
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
			url : '<c:url value="/sm/userLst"/>',
			type : 'POST',
			data : {
				userStateCd: function() { return $('#SearchUserStateCd').val(); }
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'userId', className : 'text-center'},
			{ data: 'userName', className : 'text-center'},
			{ data: 'userDepartmentNm', className : 'text-center'},
			{ data: 'userPositionNm', className : 'text-center'},
			{ data: 'userJobCd', className : 'text-center'},
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
			let theadHeight = parseFloat($('#userModalTable_wrapper').find('.dataTables_scrollHead').css('height'));
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
				let cell = $('#userModalTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#userModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	userModalTable.on('column-reorder', function( e, settings, details ) {
		let api = userModalTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#userModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	// 사용자목록 적용 버튼 click
	$('#btnUserModalPaste').on('click', function(){
		if(!$('#userModalTable tbody tr').hasClass('selected')){
			toastr.warning('붙여넣을 행을 선택해주세요.');
			return false;
		}
		let table = $('#'+$('#userModal').data('table')).dataTable().api();
		let node = table.row('.selected').node();
		let data = table.row('.selected').data();
		let selectNodeModalData = userModalTable.row('.selected').data();
		if($('#userModal').data('table') == 'purchaseAddTable'){
			$(node).find('td').eq(table.column('purchaseUser:name').index()).find('input[name=purchaseUserIdx]').val(selectNodeModalData.idx);	//사용자 식별자
			$(node).find('td').eq(table.column('purchaseUser:name').index()).find('input[name=purchaseUserNm]').val(selectNodeModalData.userName);		//사용자 이름
		} else if($('#userModal').data('table') == 'inItemSaveTable'){
			$(node).find('td').eq(table.column('inUser:name').index()).find('input[name=inUserIdx]').val(selectNodeModalData.idx);	//사용자 식별자
			$(node).find('td').eq(table.column('inUser:name').index()).find('input[name=inUserNm]').val(selectNodeModalData.userName);		//사용자 이름
		}
		$('#userModal').modal('hide');
	});

	$('#userModalTable tbody').on('dblclick','tr',function(){
		let table = $('#'+$('#userModal').data('table')).dataTable().api();
		let node = table.row('.selected').node();
		let data = table.row('.selected').data();
		let selectNodeModalData = userModalTable.row(this).data();
		if($('#userModal').data('table') == 'purchaseAddTable'){
			$(node).find('td').eq(table.column('purchaseUser:name').index()).find('input[name=purchaseUserIdx]').val(selectNodeModalData.idx);	//사용자 식별자
			$(node).find('td').eq(table.column('purchaseUser:name').index()).find('input[name=purchaseUserNm]').val(selectNodeModalData.userName);		//사용자 이름
		} else if($('#userModal').data('table') == 'inItemSaveTable'){
			$(node).find('td').eq(table.column('inUser:name').index()).find('input[name=inUserIdx]').val(selectNodeModalData.idx);	//사용자 식별자
			$(node).find('td').eq(table.column('inUser:name').index()).find('input[name=inUserNm]').val(selectNodeModalData.userName);		//사용자 이름
		}
		$('#userModal').modal('hide');
	});
	
	/****************************** 사용자 모달 끝  ******************************/
	/****************************** 발주처 모달  ******************************/
	$(document).on('click', 'button[name=customerModalBtn]', function() {
		$('#dealCorpModal').data('table',$(this).data('table'));
		$('#dealCorpModal').modal('show');
	});
	$('#dealCorpModal').on('shown.bs.modal', function() {
		dealCorpModalTable.ajax.reload(function() {});
	});

	// 거래처관리 목록조회
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

	$('#btnDealCorpModalSearch').on('click',function(){
		$('#my-spinner').show();
		dealCorpModalTable.rows('.selected').deselect();
		dealCorpModalTable.ajax.reload(function() {
			$('#my-spinner').hide();
		});
	});

	$('#btnDealCorpModalPaste').on('click',function(){
		if(!$('#dealCorpModalTable tbody tr').hasClass('selected')){
			toastr.warning('붙여넣을 행을 선택해주세요.');
			return false;
		}
		let table = $('#'+$('#dealCorpModal').data('table')).dataTable().api();
		let node = table.row('.selected').node();
		let data = table.row('.selected').data();
		let selectNodeModalData = dealCorpModalTable.row('.selected').data();
		$(node).find('td').eq(table.column('purchaseCorp:name').index()).find('input[name=purchaseCorpIdx]').val(selectNodeModalData.idx);	//발주처 식별자
		$(node).find('td').eq(table.column('purchaseCorp:name').index()).find('input[name=purchaseCorpNm]').val(selectNodeModalData.dealCorpNm);		//발주처 이름
		$('#dealCorpModal').modal('hide');
	});

	$('#dealCorpModalTable tbody').on('dblclick','tr',function(){
		let table = $('#'+$('#dealCorpModal').data('table')).dataTable().api();
		let node = table.row('.selected').node();
		let data = table.row('.selected').data();
		let selectNodeModalData = dealCorpModalTable.row(this).data();
		$(node).find('td').eq(table.column('purchaseCorp:name').index()).find('input[name=purchaseCorpIdx]').val(selectNodeModalData.idx);	//발주처 식별자
		$(node).find('td').eq(table.column('purchaseCorp:name').index()).find('input[name=purchaseCorpNm]').val(selectNodeModalData.dealCorpNm);		//발주처 이름
		$('#dealCorpModal').modal('hide');
	});
	
	/****************************** 발주처 모달 끝  ******************************/
	
	/****************************** 정의 함수   ******************************/
	function allTableReload(){
		//왼쪽 발주번호 그룹탭
		purcharseNo = '';
		purchaseGroupTable.rows('.selected').deselect();
		purchaseGroupTable.ajax.reload();

		//오른쪽 발주등록/수정 탭
		purchaseAddTable.rows('.selected').deselect();
		purchaseAddTable.ajax.reload();

		//오른쪽 입고 탭
		inItemSaveTable.rows('.selected').deselect();
		inItemSaveTable.ajax.reload();

		//오른쪽 하단 입고내역 탭
		itemPurchaseInTable.rows('.selected').deselect();
		itemPurchaseInTable.ajax.reload();

		//버튼들
		$('#btnPurchaseAddNew').attr('disabled',false);
		$('#btnPurchaseAddSave').attr('disabled',true);
		$('#btnPurchaseAddEdit').attr('disabled',true);
		$('#btnPurchaseAddDel').attr('disabled',false);
		$('#btnPurchaseAddCancel').attr('disabled',true);
	}
	//발주일자 변경될 때
	$('#purchaseDate').on('change',function(){
		//신규 등록중 이었을 경우 || 수정중이었을 경우
		if(getWM('PURCHASE_ADM_NEW','state') || getWM('PURCHASE_DTL_EDIT','state')){ 
			$('#purchaseAddTable tbody').find('tr').each(function(index_tr, tr) {
				$(tr).find('td').each(function(index_td, td) {
					if(index_td == purchaseAddTable.column('purchaseDate:name').index()) { //발주일자
						purchaseAddTable.row(tr).data().purchaseDate = $('#purchaseDate').val();
						$(td).html('<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+$('#purchaseDate').val()+'</div>');
					}
				});
			});
		
		} else {
			toastr.warning('변경 대상이 없습니다.<br>등록, 수정 상태에서 변경해주세요.');
		}
	});
	
	/****************************** 정의 함수 끝  ******************************/
	/****************************** 공통   ******************************/
	// 작업중 경고 모달 예 버튼 click
	$('#btnWorkingWarningModalY').on('click', function() {
		if(WMlastIdx == 'PURCHASE_ADM_NEW' || WMlastIdx == 'PURCHASE_DTL_EDIT') {
			$('#btnPurchaseAddSave').trigger('click');
			return false;
		} else if(WMlastIdx == 'INITEM_SAVE'){
			$('#btnInItemSave').trigger('click');
			return false;
		} 
		
	});
	// 작업중 경고 모달 아니요 버튼 click
	$('#btnWorkingWarningModalN').on('click', function() {
		if(WMlastIdx == 'PURCHASE_ADM_NEW' || WMlastIdx == 'PURCHASE_DTL_EDIT' || WMlastIdx == 'INITEM_SAVE') { // 등록중이거나 수정중이였을 경우
			if(getWM(WMlastIdx, 'idx') != '' && getWM(WMlastIdx, 'idx') != undefined) {
				let idx = getWM(WMlastIdx, 'idx');
				WM_action_OFF(WMlastIdx);
				setWM(WMlastIdx, 'idx', '');
				purchaseGroupTable.row('#'+idx).select();
				$(purchaseGroupTable.row('#'+idx).node()).trigger('click'); // 선택했던 항목 선택처리
			} else {
				WM_action_OFF(WMlastIdx);
				if(window.location != window.parent.location) { // tab일 경우
					// 부모 탭 닫기버튼 click
					$('#tab-list', parent.document).find('.active').find('span').eq(1).find('i').trigger('click');
			    }
				$('#btnNew').attr('disabled', false); // 신규 버튼
				$('#btnSave').attr('disabled', true); // 저장 버튼
				$('#btnEdit').attr('disabled', true); // 수정 버튼
				$('#btnDel').attr('disabled', true); // 삭제 버튼
				$('#btnCancel').attr('disabled', true); // 취소 버튼
			}
		}
	});
	
	//삭제모달 Y클릭
	$('#btnDeleteModalY').on('click',function(){
		let deleteType = $('#deleteModal').data('deleteType');
		if(deleteType == 'Purchase'){
			let deleteList = [];
			//체크된 항목들만 탐색
			$('input:checkbox[name=btnPurchaseCheck]:checked').each(function(indxe){
				let tr = $(this).parent().parent(); //해당 tr
				let data = purchaseAddTable.row(tr).data(); // 데이터 테이블의 해당 칸
				let obj = {};
				obj.IDX = data.idx;
				deleteList.push(obj);
			})
			
			$.ajax({
				url: '<c:url value="/wm/itemPurchaseDel"/>',
	            type: 'POST',
	            data: {
		            'deleteJson'	: JSON.stringify(deleteList),
		            'purchaseOrdNo'	:	function(){return purcharseNo;},
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if (res.result == "ok") { //응답결과
						toastr.success('삭제되었습니다.');
						$('#btnSearch').trigger('click');
					} else if(res.result == 'fail') {
						toastr.warning(res.message);
						
					} else {
						toastr.error(res.message);
					}
					$('#my-spinner').hide();
				}
			});
		} else if(deleteType == 'ItemIn'){
			let deleteList = [];
			//체크된 항목들만 탐색
			$('input:checkbox[name=btnItemPurchaseInCheck]:checked').each(function(indxe){
				let tr = $(this).parent().parent(); //해당 tr
				let data = itemPurchaseInTable.row(tr).data(); // 데이터 테이블의 해당 칸
				let obj = {};
				obj.RELATION_NO = data.relationNo;
				obj.IN_SLIP_NO = data.inSlipNo;
				obj.IN_SLIP_SEQ = data.inSlipSeq;
				deleteList.push(obj);
			})
			
			$.ajax({
				url: '<c:url value="/wm/itemPurchaseInProdDel"/>',
	            type: 'POST',
	            data: {
		            'deleteJson'	: JSON.stringify(deleteList)
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if (res.result == "ok") { //응답결과
						toastr.success('삭제되었습니다.');
						$('#btnSearch').trigger('click');
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

	//취소
	$('#btnPurchaseAddCancel, #btnInItemCancel').on('click',function(){
		$('#cancelModal').data('type',$(this).attr('id'))
		$('#cancelModal').modal('show');
	});
	
	$('#btnCancelModalY').on('click',function(){
		let type = $('#cancelModal').data('type');

		if(type == 'btnPurchaseAddCancel'){
			WM_action_OFF('PURCHASE_ADM_NEW');
			WM_action_OFF('PURCHASE_DTL_EDIT');
			purchaseAddTable.ajax.reload();
			//열 움직이는 기능 잠금
			purchaseAddTable.colReorder.enable();
			//필터 잠금
			$('#purchaseAddTable_wrapper').find('.filters th').each(function(index, item) {
				$(item).find('input').attr('disabled', false); // 검색 필터 disabled
			});

			WM_action_OFF('PURCHASE_ADM_NEW');

			$('#btnPurchaseAddNew').attr('disabled',false);
			$('#btnPurchaseAddSave').attr('disabled',true);
			$('#btnPurchaseAddEdit').attr('disabled',true);
			$('#btnPurchaseAddDel').attr('disabled',false);
			$('#btnPurchaseAddCancel').attr('disabled',true);
		} else if(type == 'btnInItemCancel'){
			WM_action_OFF('INITEM_SAVE');

			inItemSaveTable.ajax.reload();
			//열 움직이는 기능 잠금
			inItemSaveTable.colReorder.enable();
			//필터 잠금
			$('#inItemSaveTable_wrapper').find('.filters th').each(function(index, item) {
				$(item).find('input').attr('disabled', false); // 검색 필터 disabled
			});

			$('#btnInItemSave').attr('disabled',true);
			$('#btnInItemsEdit').attr('disabled',false);
			$('#btnInItemCancel').attr('disabled',true);
		}
		
		

	
	});
	
	/****************************** 공통 끝  ******************************/
	
	
</script>
</body>
</html>
