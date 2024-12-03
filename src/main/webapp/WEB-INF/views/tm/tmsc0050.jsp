<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/top.jsp"%>
<%@include file="../layout/modal.jsp"%>
<%@include file="../layout/script.jsp"%>
<div id="page" onmouseup="EndDrag(this)" onmousemove="OnDrag(event)" style="grid-template-areas: 'leftcol dragbar rightcol';
																		  grid-template-rows: 1fr;
																		  grid-template-columns: 2.5fr 4px 3.5fr;">
	<div id="leftcol">
		<div class="container-fluid h-100" style="padding: 5px;">
			<div class="row" id="leftHeader" style="padding-bottom: 5px;">
				<div class="d-flex align-items-center d-flex">
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">등록일자</label>
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
					<input type="text" class="form-control w-auto h-100 me-1" id="searchAllSat" placeholder="통합검색" >
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end">
					<div class="btn-group" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnSearch"><i class="fa-regular fa-clipboard"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnOpen"><i class="fa-solid fa-caret-left"></i></button>
					</div>
				</div>
			</div>
			<div class="row">
				<table class="table table-bordered p-0 m-0" id="stockAdmTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle">전표번호</th>
							<th class="text-center align-middle">항목수</th>
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
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">재고반영일자</label>
					<input type="month" max="9999-12" class="form-control w-auto h-100 me-3" id="stockDate">
					
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">창고</label>
					<div class="input-group w-auto h-100 me-3">
						<input type="text" class="form-control" id="searchLcNm" disabled="">
						<button type="button" class="btnInputDel" style="background-color: transparent; border-color: transparent; position: absolute; top: 0; right: 0; margin: 5px 23px; margin-left: 0px; border: none;">
							<i class="fa-solid fa-xmark"></i>
						</button>
						<input type="hidden" id="searchLcIdx">
						<button type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary" id="btnSearchLc">
							<i class="fa-solid fa-magnifying-glass"></i>
						</button>
					</div>
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">구역/위치</label>
					<div class="input-group w-auto h-100 me-3">
						<input type="text" class="form-control" id="searchLcDtlNm" disabled="">
						<button type="button" class="btnInputDel" style="background-color: transparent; border-color: transparent; position: absolute; top: 0; right: 0; margin: 5px 23px; margin-left: 0px; border: none;">
							<i class="fa-solid fa-xmark"></i>
						</button>
						<input type="hidden" id="searchLcDtlIdx">
						<button type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary" id="btnSearchLcDtl">
							<i class="fa-solid fa-magnifying-glass"></i>
						</button>
						
					</div>
					<input type="text" class="form-control w-auto h-100 me-1" id="searchAllSdt" placeholder="통합검색" >
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end">
					<div class="btn-group me-3" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto" id="btnAllPaste">
							일괄적용
						</button>			
					</div>
					<div class="btn-group" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnNew">
							<i class="fa-solid fa-plus"></i>
						</button>			
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnSave" disabled="disabled">
							<i class="fa-regular fa-floppy-disk"></i>
						</button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnEdit" disabled="">
							<i class="fa-regular fa-pen-to-square"></i>
						</button>				
						<button type="button" class="btn btn-outline-danger w-auto" style="font-size: 17px !important;" id="btnDel">
							<i class="fa-solid fa-trash-can"></i>
						</button>								
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnCancel" disabled="disabled">
							<i class="fa-solid fa-xmark"></i>
						</button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnClose"><i class="fa-solid fa-caret-right"></i></button>
					</div>
				</div>
			</div>
			<div class="row">
				<div style="width: 100%;">
				 	<table class="table table-bordered p-0 m-0" id="stockDtlTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle">시퀀스</th>
							<th class="text-center align-middle">반영유무</th>							
							<th class="text-center align-middle">재고반영일자</th>
							<th class="text-center align-middle">품목구분</th>
							<th class="text-center align-middle">품명</th>
							<th class="text-center align-middle">실사재고</th>
							<th class="text-center align-middle" style="max-width:120px;min-width:120px;">창고</th>
							<th class="text-center align-middle" style="max-width:120px;min-width:120px;">구역/위치</th>
							<th class="text-center align-middle">비고</th>
						</tr>
					</thead>
				</table>
				  
				</div>
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
				<div class="row" style="padding-bottom: 5px;">
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
				</div>

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
<!-- 품명조회 모달 끝 -->

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
			let rightcolMinWidth = 1110; // rightcol 최소사이즈
	
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
			$('#page').css('grid-template-columns', '2.3fr 4px 3.5fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcol').removeClass('d-none');
		} else {
			$('#page').css('grid-template-columns', '0fr 4px 3.5fr');
			$('#leftcol').addClass('d-none');
			$('#rightcol').removeClass('d-none');
		}
		dataTableDrawAll(); // dataTable 전체 reload
	});
	$('#btnClose').on('click',function() { // right-box 닫기버튼 클릭
		if($('#leftcol').hasClass('d-none')){
			$('#page').css('grid-template-columns', '2.3fr 4px 3.5fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcol').removeClass('d-none');
		} else {
			$('#page').css('grid-template-columns', '2.3fr 4px 0fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcol').addClass('d-none');
		}
		dataTableDrawAll(); // dataTable 전체 reload
	});
</script>

<script>
	WM_init('ADM');
	WM_init('DTL_NEW');
	WM_init('DTL_EDIT');

	let monthAdjustList = getCommonCode('시스템', '026'); //날짜조정
	monthAdjustList = _.sortBy(monthAdjustList, v=>parseInt(v.commonCd));
	selectBoxAppend(monthAdjustList, 'monthAdjust', '', '2'); //날짜조정
	
	// 공통코드 조회
	let locationModalItemGubunList = getCommonCode('일반', '022'); // 품목구분
	selectBoxAppend(locationModalItemGubunList, 'locationModalItemGubun', '', '1');

	let selectPeriod = parseInt(getCommonCode('시스템', '040')[0].commonCd); //기본조회기간 일
	//등록일자
	$('#startDate').val(moment().subtract('d',selectPeriod).format('YYYY-MM-DD'));
	$('#endDate').val(moment().format('YYYY-MM-DD'));

	//재고반영일자
	$('#stockDate').val(moment().format('YYYY-MM'));
	
	//변수 선언 모음
	let saAppdYnColIdx = 1;
	let saNo = '';
	let lcAdmIdxVal = '';

	// 작업중 경고 모달 예 버튼 click
	$('#btnWorkingWarningModalY').on('click', function() {
		if(WMlastIdx == 'DTL_NEW' || WMlastIdx == 'DTL_EDIT') { // 등록중이거나 수정중이였을 경우
			$('#btnSave').trigger('click');
			return false;
		}
	});
	// 작업중 경고 모달 아니요 버튼 click
	$('#btnWorkingWarningModalN').on('click', function() {
		if(WMlastIdx == 'DTL_NEW' || WMlastIdx == 'DTL_EDIT') { // 등록중이거나 수정중이였을 경우
			if(getWM(WMlastIdx, 'idx') != '' && getWM(WMlastIdx, 'idx') != undefined) {
				let idx = getWM(WMlastIdx, 'idx');
				WM_action_OFF(WMlastIdx);
				setWM(WMlastIdx, 'idx', '');
				stockAdmTable.row('#'+idx).select();
				$(stockAdmTable.row('#'+idx).node()).trigger('click'); // 선택했던 항목 선택처리
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
	
	//재고반영목록 ADM
	$('#stockAdmTable thead tr').clone(true).addClass('filters').appendTo('#stockAdmTable thead'); // filter 생성
	let stockAdmTable = $('#stockAdmTable').DataTable({
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
			url : '<c:url value="/stock/stockAdjustAdmListGroupBySaNo"/>',
			type : 'POST',
			data : {
				'startDate'	:	function(){ return $('#startDate').val().replaceAll('-','');},
				'endDate' 	:	function(){ return $('#endDate').val().replaceAll('-','');},
				'saType'	:	function(){ return 'A';},
			},
		},
        rowId: 'saNo',
		columns : [
			{ data: 'saNo', className : 'text-center align-middle'},
			{ data: 'saSeqCount', className : 'text-center align-middle'},			
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
			let theadHeight = parseFloat($('#stockAdmTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 79)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAllSat').off('keyup',function() {});
			$('#searchAllSat').on('keyup',function() {
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
				let cell = $('#stockAdmTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#stockAdmTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	stockAdmTable.on('column-reorder', function( e, settings, details ) {
		let api = stockAdmTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#stockAdmTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	// 재고반영목록 DTL
	$('#stockDtlTable thead tr').clone(true).addClass('filters').appendTo('#stockDtlTable thead'); // filter 생성
	let stockDtlTable = $('#stockDtlTable').DataTable({
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
			url : '<c:url value="/stock/stockAdjustAdmListBySaNo"/>',
			type : 'POST',
			data : {
				'saNo'	:	function(){ return saNo; },
			},
		},
        rowId: 'saSeq',
		columns : [
			//시퀀스
			{ data: 'saSeq', className : 'text-center align-middle',name:'saSeq',
				render : function(data, type, row, meta) {
					if(data != '' && data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},
			//반영유무
			{ data: 'saAppdYn', className : 'text-center align-middle',name:'saAppdYn',
				render : function(data, type, row, meta) {
					if(data != '' && data != null){
						let html = '';
						if(data == 'Y'){
							html += '<input disabled type="checkbox" name="btnStockAppdCheck" style="width: 20px; height: 20px;"checked>';
						} else if(data == 'N'){
							html += '<input disabled type="checkbox" name="btnStockAppdCheck" style="width: 20px; height: 20px;">';
						}
						return html; 
					} else {
						let html = '';
						html += '<input disabled type="checkbox" name="btnStockAppdCheck" style="width: 20px; height: 20px;">';
						return html; 
					}
				}
			},
			//재고반영일자
			{ data: 'saAppdDate', className : 'text-center align-middle',name:'saAppdDate',
				render : function(data, type, row, meta) {
					if(row['rowGubun'] == 'new'){
						let html = '';
						html += '<input type="month" max="9999-12" class="form-control" name="saAppdDate" value="'+moment(data).format('YYYY-MM')+'">';
						return html; 
					} else {
						if(data != '' && data != null){
							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data.substr(0,6),'YYYYMM').format('YYYY-MM')+'</div>';
						} else {
							let html = '';
							html += '<input type="month" max="9999-12" class="form-control" name="saAppdDate">';
							return html; 
						}
					}
				}
			},
			//품목구분		
			{ data: 'saGubun', className : 'text-center align-middle',name:'saGubun',
				render : function(data, type, row, meta) {
					if(data != '' && data != null){
						let returnVal = '';
						if(data == '001'){
							returnVal = '제품';
						} else if(data == '002'){
							returnVal = '자재';
						} else{
							returnVal = '';
						}
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+returnVal+'</div>';
					} else {
						return '';
					}
				}
			},
			//품명
			{ data: 'saNm', className : 'text-center align-middle',name:'saNm',
				render : function(data, type, row, meta) {
					if(data != '' && data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},
			//실사재고
			{ data: 'saRealQty', className : 'text-end align-middle',name:'saRealQty',
				render : function(data, type, row, meta) {
					if(row['rowGubun'] == 'new'){
						let html = '';
						html += '<input type="text" class="form-control text-end" name="saRealQty" value="0" onkeyup="numberFormat(this,\'int\')">';
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
			//창고
			{ data: 'lcNm', className : 'text-center align-middle',name:'lcNm',
				render : function(data, type, row, meta) {
					if(row['rowGubun'] == 'new'){
						let html = '';
							html += '<div class="input-group" style="min-width: 120px;max-width: 120px;">';
							html += '	<input type="text" class="form-control" value="'+row['lcNm']+'" name="lcNm" disabled>';
							html += '	<button type="button" class="btnInputDel" style="background-color: transparent;';
							html += '		border-color: transparent; position: absolute;';
							html += '		top: 0; right:0;';
							html += '		margin: 1px 23px; margin-left: 0px;';
							html += '		border: none;';
							html += '		">';
							html += '		<i class="fa-solid fa-xmark"></i>';
							html += '	</button>';
							html += '	<input type="hidden" name="lcIdx" value="'+row['lcIdx']+'">';
							html += '	<button data-table="stockDtlTable" data-itemgubun="'+row['saGubun']+'" type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary btnLocationModalShow">';
							html += '		<i class="fa-solid fa-magnifying-glass"></i>';
							html += '	</button>';
							html += '</div>';
							html += '<span class="d-none"></span>';
						return html;
					} else {
						if(data != '' && data != null){
							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						} else {
							return '-';
						}
					}
				}
			},
			//구역/위치		
			{ data: 'lcDtlNm', className : 'text-center align-middle',name:'lcDtlNm',
				render : function(data, type, row, meta) {
					if(row['rowGubun'] == 'new'){
						let html = '';
							html += '<div class="input-group" style="min-width: 120px;max-width: 120px;">';
							html += '	<input type="text" class="form-control" value="'+row['lcDtlNm']+'" name="lcDtlNm" disabled>';
							html += '	<button type="button" class="btnInputDel" style="background-color: transparent;';
							html += '		border-color: transparent; position: absolute;';
							html += '		top: 0; right:0;';
							html += '		margin: 1px 23px; margin-left: 0px;';
							html += '		border: none;';
							html += '		">';
							html += '		<i class="fa-solid fa-xmark"></i>';
							html += '	</button>';
							html += '	<input type="hidden" name="lcDtlIdx" value="'+row['lcDtlIdx']+'">';
							html += '	<button data-table="stockDtlTable" data-itemgubun="'+row['saGubun']+'" type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary btnLocationDtlModalShow">';
							html += '		<i class="fa-solid fa-magnifying-glass"></i>';
							html += '	</button>';
							html += '</div>';
							html += '<span class="d-none"></span>';
						return html;
					} else {
						if(data != '' && data != null && data != '--'){
							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						} else {
							return '-';
						}
					}
				}
			},
			//비고
			{ data: 'saDesc', className : 'text-center align-middle',name:'saDesc',
				render : function(data, type, row, meta) {
					if(row['rowGubun'] == 'new'){
						let html = '';
						html += '<input type="text" style="min-width:200px;" class="form-control" name="saDesc">';
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
		order : [[0,'asc']],
		drawCallback: function() {
			let api = this.api();
			let data = api.data();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#stockDtlTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 79)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAllSdt').off('keyup',function() {});
			$('#searchAllSdt').on('keyup',function() {
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
				let cell = $('#stockDtlTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				if(colIdx != 1){
					$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
					$(cell).css('padding','2px');
				} else {
					$(cell).html('<input type="checkbox" id="btnAllCheck" style="width: 20px; height: 20px;">');
					$(cell).css('padding','2px');
				}

				let cursorPosition = '';
				saAppdYnColIdx = stockDtlTable.column('saAppdYn:name').index();
				// On every keypress in this input
				$('#stockDtlTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					if(colIdx != saAppdYnColIdx){
						api.column(colIdx).search(this.value, false, false, true).draw();
					}
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	stockDtlTable.on('column-reorder', function( e, settings, details ) {
		let api = stockDtlTable;
		saAppdYnColIdx = stockDtlTable.column('saAppdYn:name').index();
		api.columns().eq(0).each(function (colIdx) {
			$('#stockDtlTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				if(colIdx != saAppdYnColIdx){
					api.column(colIdx).search(this.value, false, false, true).draw();
				}
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	$('#stockAdmTable tbody').on('click', 'tr', function(){
		saNo = stockAdmTable.row(this).data().saNo;
		if(WMCheck('DTL_NEW')) { // 등록중일 경우
			setWM('DTL_NEW', 'idx', saNo);
			return false;
		} 
		if(WMCheck('DTL_EDIT')) { // 수정중일 경우
			setWM('DTL_EDIT', 'idx', saNo);
			return false;
		} 
		//필터 잠금
		$('#stockDtlTable_wrapper').find('.filters th').each(function(index, item) {
			$(item).find('input').attr('disabled', false); // 검색 필터 disabled
		});
		//필터 잠금
		$('#stockDtlTable_wrapper').find('.filters th').eq(saAppdYnColIdx).find('input').attr('disabled', true); // 검색 필터 disabled
		
		$('#btnNew').attr('disabled', false); // 신규 버튼
		$('#btnSave').attr('disabled', true); // 저장 버튼
		$('#btnEdit').attr('disabled', false); // 수정 버튼
		$('#btnDel').attr('disabled', false); // 삭제 버튼
		$('#btnCancel').attr('disabled', true); // 취소 버튼
		stockDtlTable.ajax.reload(function(){
			let data = stockDtlTable.data().toArray();
			if(data.length == _.filter(data,v=>v.saAppdYn=='Y').length){
				$('#btnAllCheck').prop("checked",true);
			} else {
				$('#btnAllCheck').prop("checked",false);
			}
		});
 		
	});

	$('#btnNew').on('click',function(){
		$('#itemNmGubun').val('item');
		itemNmModalTable.rows('.selected').deselect();
		$('#itemNmModal').modal('show');
		setTimeout(function() {
			itemNmModalTable.ajax.reload(function() {itemNmModalTable.draw(false);});
		}, 200);
	});

	$('#btnEdit').on('click',function(){

		$('#stockDtlTable tbody').find('tr').each(function(index_tr, tr) {
			let data = stockDtlTable.row(tr).data();
			if(data.saAppdYn == 'N'){
			$(tr).find('td').each(function(index_td, td) {
				if(index_td == stockDtlTable.column('saAppdDate:name').index()){//재고반영일자
					let saAppdDate = stockDtlTable.row(tr).data().saAppdDate;
					$(td).html('<input type="month" max="9999-12" class="form-control" name="saAppdDate" value="'+moment(saAppdDate.substr(0,6),'YYYYMM').format('YYYY-MM')+'">');
				} else if(index_td == stockDtlTable.column('saRealQty:name').index()) { //실사재고
					let value = stockDtlTable.row(tr).data().saRealQty != null && stockDtlTable.row(tr).data().saRealQty != '' ? stockDtlTable.row(tr).data().saRealQty : 0;
					value = addCommas(parseInt(value));
					$(td).html('<input type="text" class="form-control text-end" name="saRealQty" value="'+value+'" onkeyup="numberFormat(this,\'int\')">');
				} else if(index_td == stockDtlTable.column('lcNm:name').index()) { //창고
					let lcNm = stockDtlTable.row(tr).data().lcNm;
					let lcIdx = stockDtlTable.row(tr).data().lcIdx;
					let saGubun = stockDtlTable.row(tr).data().saGubun;
					let html = '';
					html += '<div class="input-group" style="min-width: 120px;max-width: 120px;">';
					html += '	<input type="text" class="form-control" value="'+lcNm+'" name="lcNm" disabled>';
					html += '	<button type="button" class="btnInputDel" style="background-color: transparent;';
					html += '		border-color: transparent; position: absolute;';
					html += '		top: 0; right:0;';
					html += '		margin: 1px 23px; margin-left: 0px;';
					html += '		border: none;';
					html += '		">';
					html += '		<i class="fa-solid fa-xmark"></i>';
					html += '	</button>';
					html += '	<input type="hidden" name="lcIdx" value="'+lcIdx+'">';
					html += '	<button data-table="stockDtlTable" data-itemgubun="'+saGubun+'" type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary btnLocationModalShow">';
					html += '		<i class="fa-solid fa-magnifying-glass"></i>';
					html += '	</button>';
					html += '</div>';
					html += '<span class="d-none"></span>';
					$(td).html(html);
				} else if(index_td == stockDtlTable.column('lcDtlNm:name').index()) { //창고
					let lcDtlNm = stockDtlTable.row(tr).data().lcDtlNm;
					if(lcDtlNm == '--'){
						lcDtlNm = '';
					}
					let lcDtlIdx = stockDtlTable.row(tr).data().lcDtlIdx;
					let saGubun = stockDtlTable.row(tr).data().saGubun;
					let html = '';
					html += '<div class="input-group" style="min-width: 120px;max-width: 120px;">';
					html += '	<input type="text" class="form-control" value="'+lcDtlNm+'" name="lcDtlNm" disabled>';
					html += '	<button type="button" class="btnInputDel" style="background-color: transparent;';
					html += '		border-color: transparent; position: absolute;';
					html += '		top: 0; right:0;';
					html += '		margin: 1px 23px; margin-left: 0px;';
					html += '		border: none;';
					html += '		">';
					html += '		<i class="fa-solid fa-xmark"></i>';
					html += '	</button>';
					html += '	<input type="hidden" name="lcDtlIdx" value="'+lcDtlIdx+'">';
					html += '	<button data-table="stockDtlTable" data-itemgubun="'+saGubun+'" type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary btnLocationDtlModalShow">';
					html += '		<i class="fa-solid fa-magnifying-glass"></i>';
					html += '	</button>';
					html += '</div>';
					html += '<span class="d-none"></span>';
					$(td).html(html);
				} else if(index_td == stockDtlTable.column('saDesc:name').index()){
					let saDesc = stockDtlTable.row(tr).data().saDesc;
					let html = '';
					html += '<input type="text" style="min-width:200px;" class="form-control" name="saDesc" value="'+saDesc+'">';
					$(td).html(html);
				} 
			});
			}
			/* if(data.saAppdYn == 'Y'){
				$('#stockDtlTable tbody tr').find('input[name=btnStockAppdCheck]').attr('disabled',false);
				$('#stockDtlTable tbody tr').find('input[name=saAppdDate]').attr('disabled',true);
				$('#stockDtlTable tbody tr').find('input[name=saRealQty]').attr('disabled',true);
				$('#stockDtlTable tbody tr').find('.btnInputDel').attr('disabled',true);
				$('#stockDtlTable tbody tr').find('.btnLocationModalShow').attr('disabled',true);
				$('#stockDtlTable tbody tr').find('.btnLocationDtlModalShow').attr('disabled',true);
				$('#stockDtlTable tbody tr').find('input[name=saDesc]').attr('disabled',true);
			} else {
				$('#stockDtlTable tbody tr').find('input[name=btnStockAppdCheck]').attr('disabled',false);
				$('#stockDtlTable tbody tr').find('input[name=saAppdDate]').attr('disabled',false);
			} */
			
		});
		stockDtlTable.columns.adjust().draw(false);
		$('#stockDtlTable tbody tr').find('input[name=btnStockAppdCheck]').attr('disabled',false);
		$('#stockDtlTable tbody tr').find('input[name=saAppdDate]').attr('disabled',false);
		
		//열 움직이는 기능 잠금
		stockDtlTable.colReorder.disable();
		//필터 잠금
		$('#stockDtlTable_wrapper').find('.filters th').each(function(index, item) {
			$(item).find('input').attr('disabled', true); // 검색 필터 disabled
		});
		//필터 잠금
		$('#stockDtlTable_wrapper').find('.filters th').eq(saAppdYnColIdx).find('input').attr('disabled', false); // 검색 필터 disabled
		
		WM_action_ON('DTL_EDIT', 'workingWarningModal');

		$('#btnNew').attr('disabled',false);
		$('#btnSave').attr('disabled',false);
		$('#btnEdit').attr('disabled',true);
		$('#btnDel').attr('disabled',false);
		$('#btnCancel').attr('disabled',false);
	});
	
	$('#btnItemNmSearch').on('click',function(){
		itemNmModalTable.ajax.reload(function() {itemNmModalTable.draw(false);});
	});

	$('#btnItemNmModalPaste').on('click',function(){

		if(!$('#itemNmModalTable tbody tr').hasClass('selected')){
			toastr.warning('붙여넣을 행을 선택해주세요.');
			return false;
		}

		if($('#stockAdmTable tbody tr').hasClass('selected')){
			saNo = '';
			stockAdmTable.rows('.selected').deselect();
			stockDtlTable.clear().draw(false);
		}

		$('#my-spinner').show();
		let dataList = itemNmModalTable.rows('.selected').data().toArray();
		let addList = [];
		for(var i=0;i<dataList.length;i++) {
			let obj = {};
			obj.saSeq = '자동채번';
			obj.saAppdYn = 'N';
			obj.saAppdDate = $('#stockDate').val();
			obj.saGubun = dataList[i].itemMatrlGubun == 'item' ? '001' : '002';
			obj.saNm = dataList[i].itemNm;
			obj.saCmptQty = dataList[i].spQty != null && dataList[i].spQty != '' ? parseInt(dataList[i].spQty) : 0;
			obj.saRealQty = 0; //실사재고 입력받는거라 0값
			obj.saDiffQty = null;
			obj.lcIdx = null;
			obj.lcNm = '';
			obj.lcDtlIdx = null;
			obj.lcDtlNm = '';
			obj.saDesc = null;
			obj.itemVerIdx = dataList[i].itemVerIdx;

			
			obj.rowGubun = 'new'; //행 구분 신규
			obj.itemMatrlIdx = dataList[i].idx;
			
			addList.push(obj);
		}
		stockDtlTable.rows.add(addList).draw(false).columns.adjust();

		$('#stockDtlTable tbody tr').find('input[name=saAppdDate]').attr('disabled',false);
		//열 움직이는 기능 잠금
		stockDtlTable.colReorder.disable();
		//필터 잠금
		$('#stockDtlTable_wrapper').find('.filters th').each(function(index, item) {
			$(item).find('input').attr('disabled', true); // 검색 필터 disabled
		});
		WM_action_ON('DTL_NEW', 'workingWarningModal');
		WM_action_OFF('DTL_EDIT');
		$('#my-spinner').hide();
		toastr.success('추가되었습니다.');
		$('#btnAllCheck').prop("checked",false);
		$('#btnNew').attr('disabled',false);
		$('#btnSave').attr('disabled',false);
		$('#btnEdit').attr('disabled',true);
		$('#btnDel').attr('disabled',false);
		$('#btnCancel').attr('disabled',false);
		
		$('#itemNmModal').modal('hide');
		
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
            style: 'multi',
            toggleable: true,
            items: 'row',
            info: false
        },
        ajax : {
			url : '<c:url value="/bm/itemInfoAndMatrlListAll"/>',
			type : 'POST',
			data : {
				itemMatrlGubun : function(){return $('#itemNmGubun').val();},
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

	// ---------------------------------------------------------------- 창고목록조회 -------------------------------------------------------------
	// 창고조회버튼 click
	$(document).on('click', '.btnLocationModalShow', function() {
		// 품목구분 001 제품 002 자재
		let itemGubun = $(this).data('itemgubun');
		if(itemGubun == '002'){
			itemGubun = '003';
		}
		$('#locationModalItemGubun').val(itemGubun);

		locationModalTable.rows('.selected').deselect();
		$('#locationModal').data('gubun','table');
		$('#locationModal').modal('show');
	});
	
	$('#btnSearchLc').on('click', function() {
		$('#locationModalItemGubun').val('');
		locationModalTable.rows('.selected').deselect();
		$('#locationModal').data('gubun','search');
		$('#locationModal').modal('show');
	});
	
	$('#locationModal').on('shown.bs.modal', function() {
		locationModalTable.ajax.reload(function() {});
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
		
		if( $('#locationModal').data('gubun') == 'search' ){
			$('#searchLcNm').val(data.lcNm);
			$('#searchLcIdx').val(data.idx);
		} else if( $('#locationModal').data('gubun') == 'table' ){
			let node = stockDtlTable.row('.selected').node();
			let tableData = stockDtlTable.row('.selected').data();

			//창고 식별자
			$(node).find('td').eq(stockDtlTable.column('lcNm:name').index()).find('input[type=hidden]').val(data.idx);
			//창고명	
			$(node).find('td').eq(stockDtlTable.column('lcNm:name').index()).find('input[type=text]').val(data.lcNm);
		}
		
		
		$('#locationModal').modal('hide');
	});

	$('#locationModalTable tbody').on('dblclick','tr',function(){
		let data = locationModalTable.row(this).data();
		
		if( $('#locationModal').data('gubun') == 'search' ){
			$('#searchLcNm').val(data.lcNm);
			$('#searchLcIdx').val(data.idx);
		} else if( $('#locationModal').data('gubun') == 'table' ){
			let node = stockDtlTable.row('.selected').node();
			let tableData = stockDtlTable.row('.selected').data();

			//창고 식별자
			$(node).find('td').eq(stockDtlTable.column('lcNm:name').index()).find('input[type=hidden]').val(data.idx);
			//창고명	
			$(node).find('td').eq(stockDtlTable.column('lcNm:name').index()).find('input[type=text]').val(data.lcNm);
		}
		
		
		$('#locationModal').modal('hide');
	});
	
	/* 창고 상세 */
	$(document).on('click','.btnLocationDtlModalShow',function(){
		let tr = $(this).parent().parent().parent();
		let td = $(tr).find('td');

		let data = stockDtlTable.row(tr).data();
		let node = stockDtlTable.row(tr).node();

		//창고
		let lcNmCol = stockDtlTable.column('lcNm:name').index();
		let lcIdx = $(td).eq(lcNmCol).find('input[type=hidden]').val();
		
		if(lcIdx == '' || lcIdx == null || lcIdx == 'null' || lcIdx == undefined){
			$(td).eq(lcNmCol).find('.btnLocationModalShow').focus();
			toastr.warning('창고를 선택해주세요.');
			return false;
		}
		
		lcAdmIdxVal = lcIdx;
		
		$('#my-spinner').show();
		locationDtlModalTable.rows('.selected').deselect();
		$('#locationDtlModal').data('gubun','table');
		locationDtlModalTable.ajax.reload(function() { 
			$('#my-spinner').hide();
			$('#locationDtlModal').modal('show');
		});
	});
	
	$('#btnSearchLcDtl').on('click',function(){
		lcAdmIdxVal = $('#searchLcIdx').val();
		if(lcAdmIdxVal == '' || lcAdmIdxVal == null || lcAdmIdxVal == 'null' || lcAdmIdxVal == undefined){
			$('#btnSearchLc').focus();
			toastr.warning('창고를 선택해주세요.');
			return false;
		}
		$('#my-spinner').show();
		
		locationDtlModalTable.rows('.selected').deselect();
		$('#locationDtlModal').data('gubun','search');
		locationDtlModalTable.ajax.reload(function() { 
			$('#my-spinner').hide();
			$('#locationDtlModal').modal('show');
		});
	});

	$('#locationDtlModal').on('shown.bs.modal', function() {
		locationDtlModalTable.draw(false).columns.adjust();
	});

	//붙여넣기
	$('#btnLocationDtlModalPaste').on('click',function(){
		if(!$('#locationDtlModal tbody tr').hasClass('selected')){
			toastr.warning('붙여넣을 행을 선택해주세요.');
			return false;
		}
		
		let data = locationDtlModalTable.row('.selected').data();

		if( $('#locationDtlModal').data('gubun') == 'search' ){
			$('#searchLcDtlNm').val(data.lcDtlNm + "-" + data.lcDtlX + "-" + data.lcDtlY);
			$('#searchLcDtlIdx').val(data.idx);
		} else if( $('#locationDtlModal').data('gubun') == 'table' ){
			let node = stockDtlTable.row('.selected').node();
			let tableData = stockDtlTable.row('.selected').data();

			//창고 식별자
			$(node).find('td').eq(stockDtlTable.column('lcDtlNm:name').index()).find('input[type=hidden]').val(data.idx);
			//창고명	
			$(node).find('td').eq(stockDtlTable.column('lcDtlNm:name').index()).find('input[type=text]').val(data.lcDtlNm + "-" + data.lcDtlX + "-" + data.lcDtlY);
		}
		$('#locationDtlModal').modal('hide');
	});

	$('#locationDtlModalTable tbody').on('dblclick','tr',function(){
		let data = locationDtlModalTable.row(this).data();

		if( $('#locationDtlModal').data('gubun') == 'search' ){
			$('#searchLcDtlNm').val(data.lcDtlNm + "-" + data.lcDtlX + "-" + data.lcDtlY);
			$('#searchLcDtlIdx').val(data.idx);
		} else if( $('#locationDtlModal').data('gubun') == 'table' ){
			let node = stockDtlTable.row('.selected').node();
			let tableData = stockDtlTable.row('.selected').data();

			//창고 식별자
			$(node).find('td').eq(stockDtlTable.column('lcDtlNm:name').index()).find('input[type=hidden]').val(data.idx);
			//창고명	
			$(node).find('td').eq(stockDtlTable.column('lcDtlNm:name').index()).find('input[type=text]').val(data.lcDtlNm + "-" + data.lcDtlX + "-" + data.lcDtlY);
		}
		$('#locationDtlModal').modal('hide');
	});
	
	// 창고 구역/위치 목록조회
	$('#locationDtlModalTable thead tr').clone(true).addClass('filters').appendTo('#locationDtlModalTable thead'); // filter 생성
	let locationDtlModalTable = $('#locationDtlModalTable').DataTable({
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
			url : '<c:url value="/bm/locationDtlList"/>',
			type : 'GET',
			data : {
				lcAdmIdx	:	function() { return lcAdmIdxVal; },
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'lcCd', className : 'text-center', name: 'lcCd',
				render: function(data, type, row, meta) {
					return data;
				}
			},
			{ data: 'lcNm', className : 'text-center', name: 'lcNm',
				render: function(data, type, row, meta) {
					return data;
				}
			},
			{ data: 'lcDtlNm', className : 'text-center', name: 'lcDtlNm',
				render: function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						return data;
					} else {
						return '<input type="text" class="form-control"><span class="d-none">'+data+'</span>';
					}
				}
			},
			{ data: 'lcDtlX', className : 'text-center', name: 'lcDtlX',
				render: function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						return data;
					} else {
						return '<input type="text" class="form-control"><span class="d-none">'+data+'</span>';
					}
				}
			},
			{ data: 'lcDtlY', className : 'text-center', name: 'lcDtlY',
				render: function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						return data;
					} else {
						return '<input type="text" class="form-control"><span class="d-none">'+data+'</span>';
					}
				}
			},
			{ data: 'useYn', className : 'text-center', name: 'useYn',
				render: function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						if(data == 'Y') {
							return '사용';
						} else {
							return '미사용';
						}
					} else {
						return '<select class="form-select"><option value="Y" selected>사용</option><option value="N">미사용</option></select><span class="d-none">'+data+'</span>';
					}
				}
			},
			{ data: 'lcDtlDesc', className : 'text-center', name: 'lcDtlDesc',
				render: function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						return data;
					} else {
						return '<input type="text" class="form-control"><span class="d-none">'+data+'</span>';
					}
				}
			},
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
			let theadHeight = parseFloat($('#locationDtlModalTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#locationDtlModalTable_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 230)+'px');
			
			$('#locationDtlModalTable_filter').addClass('d-none');
			// 통합검색
			$('#searchAllAdm').off('keyup',function() {});
			$('#searchAllAdm').on('keyup',function() {
				$('#locationDtlModalTable_filter').find('input').val($(this).val());
				$('#locationDtlModalTable_filter').find('input').trigger('keyup');
			});
		},
		initComplete: function () {
			let api = this.api();
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#locationDtlModalTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title.replaceAll('*','') + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#locationDtlModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	locationDtlModalTable.on('column-reorder', function( e, settings, details ) {
		let api = locationDtlModalTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#locationDtlModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	//일괄적용 기능
	$('#btnAllPaste').on('click',function(){
		if(getWM('DTL_NEW','state')){ //신규 등록중 이었을 경우		
			//재고반영일자
			$('#stockDtlTable tbody tr').find('input[name=saAppdDate]').val($('#stockDate').val());
			//창고
			$('#stockDtlTable tbody tr').find('input[name=lcNm]').val($('#searchLcNm').val());
			$('#stockDtlTable tbody tr').find('input[name=lcIdx]').val($('#searchLcIdx').val());
			//구역
			$('#stockDtlTable tbody tr').find('input[name=lcDtlNm]').val($('#searchLcDtlNm').val());
			$('#stockDtlTable tbody tr').find('input[name=lcDtlIdx]').val($('#searchLcDtlIdx').val());
		} else if(getWM('DTL_EDIT','state')){
			//재고반영일자
			$('#stockDtlTable tbody tr').find('input[name=saAppdDate]').val($('#stockDate').val());
			//창고
			$('#stockDtlTable tbody tr').find('input[name=lcNm]').val($('#searchLcNm').val());
			$('#stockDtlTable tbody tr').find('input[name=lcIdx]').val($('#searchLcIdx').val());
			//구역
			$('#stockDtlTable tbody tr').find('input[name=lcDtlNm]').val($('#searchLcDtlNm').val());
			$('#stockDtlTable tbody tr').find('input[name=lcDtlIdx]').val($('#searchLcDtlIdx').val());
		} else {
			toastr.warning('일괄 적용 가능한 대상이 없습니다.');
		}
	});		


	//모든 체크박스 선택
	$(document).on('change','#btnAllCheck', function(){
		if($('#btnAllCheck').prop("checked")){
			$('input:checkbox[name=btnStockAppdCheck]').prop("checked",true);
		}else{
			$('input:checkbox[name=btnStockAppdCheck]').prop("checked",false);
		}
	});
	// 모든 체크박스 체크/해제 되도록
	$(document).on('change','input:checkbox[name=btnStockAppdCheck]', function(){
		if( $('input:checkbox[name=btnStockAppdCheck]').length == $('input:checkbox[name=btnStockAppdCheck]:checked').length ){ //전체 체크박스 수와 체크된 박스의 수가 같을 때 -> 전체체크박스 체크 , 아닐 경우 해제
			$('#btnAllCheck').prop("checked",true);
		} else{
			$('#btnAllCheck').prop("checked",false);
		}
 	});
 	
	//저장처리
	$('#btnSave').on('click',function(){
		if(getWM('DTL_NEW','state')){ //신규 등록중 이었을 경우
			$('#my-spinner').show();	
			stockAdjustAdmIns();
			//$('#my-spinner').hide();
		} else if(getWM('DTL_EDIT','state')){ //수정중일경우
			$('#my-spinner').show();	
			stockAdjustAdmUpd();
			//$('#my-spinner').hide();
		}
		
	});

	function stockAdjustAdmIns(){
		let array = [];
		let state = true;
		
		$('#stockDtlTable tbody').find('tr').each(function(index, item) {
			let td = $(item).find('td');
			let data = stockDtlTable.row($(item)).data();
			let node = stockDtlTable.row($(item)).node();

			//재고반영일
			let saAppdDateCol = stockDtlTable.column('saAppdDate:name').index();
			let saAppdDate = $(td).eq(saAppdDateCol).find('input[name=saAppdDate]').val();
			
			//실사재고
			let saRealQtyCol = stockDtlTable.column('saRealQty:name').index();
			let saRealQty = parseInt(removeCommas($(td).eq(saRealQtyCol).find('input[name=saRealQty]').val()));
		
			//창고
			let lcNmCol = stockDtlTable.column('lcNm:name').index();
			let lcIdx = $(td).eq(lcNmCol).find('input[name=lcIdx]').val();
			//구역
			let lcDtlNmCol = stockDtlTable.column('lcDtlNm:name').index();
			let lcDtlIdx = $(td).eq(lcDtlNmCol).find('input[name=lcDtlIdx]').val();
			//비고
			let saDescCol = stockDtlTable.column('saDesc:name').index();
			let saDesc = $(td).eq(saDescCol).find('input[name=saDesc]').val();

			if(lcIdx == '' || lcIdx == null || lcIdx == 'null' || lcIdx == undefined){
				toastr.warning('창고를 선택해주세요.');
				$(td).eq(lcNmCol).find('.btnLocationModalShow').focus();
				state = false;
				return false;
			}

			if(lcDtlIdx == '' || lcDtlIdx == null || lcDtlIdx == 'null' || lcDtlIdx == undefined){
				lcDtlIdx = 0;
			}
				
			let obj = new Object();
			obj.saType = 'A';
			obj.saGubun = data.saGubun;
			obj.saCd = data.itemMatrlIdx;
			obj.itemVerIdx = data.itemVerIdx;
			obj.saCmptQty = 0;
			obj.saRealQty = saRealQty;
			obj.saDiffQty = 0;
			obj.saAppdDate = saAppdDate.replaceAll('-','')+'01';
			obj.saWhsIdx = lcIdx;
			obj.saLocIdx = lcDtlIdx;
			obj.saDesc = saDesc;
			array.push(obj);
		});

		if(state){
			$.ajax({
				url: '<c:url value="/stock/stockAdjustAdmIns"/>',
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
						saNo = '';
						stockAdmTable.rows('.selected').deselect();
						stockDtlTable.rows('.selected').deselect();
						$('#btnAllCheck').prop("checked",false);
						stockAdmTable.ajax.reload();
						stockDtlTable.ajax.reload();

						//열 움직이는 기능 잠금
						stockDtlTable.colReorder.enable();
						//필터 잠금
						$('#stockDtlTable_wrapper').find('.filters th').each(function(index, item) {
							$(item).find('input').attr('disabled', false); // 검색 필터 disabled
						});

						WM_action_OFF('DTL_NEW');

						$('#btnNew').attr('disabled',false);
						$('#btnSave').attr('disabled',true);
						$('#btnEdit').attr('disabled',true);
						$('#btnDel').attr('disabled',false);
						$('#btnCancel').attr('disabled',true);
						
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

	function stockAdjustAdmUpd(){
		let array = [];
		let state = true;
		
		$('#stockDtlTable tbody').find('tr').each(function(index, item) {
			let td = $(item).find('td');
			let data = stockDtlTable.row($(item)).data();
			let node = stockDtlTable.row($(item)).node();

			//반영유무
			let saAppdYnCol = stockDtlTable.column('saAppdYn:name').index();
			let	saAppdYn = $(td).eq(saAppdYnCol).find('input[name=btnStockAppdCheck]').prop('checked');

			let obj = new Object();
			obj.saType = 'A';
			obj.saNo = data.saNo;
			obj.saSeq = data.saSeq;
			obj.saAppdYn = saAppdYn ? 'Y' : 'N';
			obj.saGubun = data.saGubun;
			obj.saCd = data.saCd;
			obj.itemVerIdx= data.itemVerIdx;
			if(data.saAppdYn == 'Y'){
				obj.saCmptQty = parseInt(data.saCmptQty);
				obj.saRealQty = parseInt(data.saRealQty);
				obj.saDiffQty = parseInt(data.saDiffQty);
				obj.saAppdDate = data.saAppdDate;
				obj.saWhsIdx = data.lcIdx;
				obj.saLocIdx = data.lcDtlIdx;
				obj.saDesc = data.saDesc;
			} else if(data.saAppdYn == 'N'){
				//재고반영일
				let saAppdDateCol = stockDtlTable.column('saAppdDate:name').index();
				let saAppdDate = $(td).eq(saAppdDateCol).find('input[name=saAppdDate]').val();
				//실사재고
				let saRealQtyCol = stockDtlTable.column('saRealQty:name').index();
				let saRealQty = parseInt(removeCommas($(td).eq(saRealQtyCol).find('input[name=saRealQty]').val()));
				//창고
				let lcNmCol = stockDtlTable.column('lcNm:name').index();
				let lcIdx = $(td).eq(lcNmCol).find('input[name=lcIdx]').val();
				//구역
				let lcDtlNmCol = stockDtlTable.column('lcDtlNm:name').index();
				let lcDtlIdx = $(td).eq(lcDtlNmCol).find('input[name=lcDtlIdx]').val();
				//비고
				let saDescCol = stockDtlTable.column('saDesc:name').index();
				let saDesc = $(td).eq(saDescCol).find('input[name=saDesc]').val();
				
				if(lcIdx == '' || lcIdx == null || lcIdx == 'null' || lcIdx == undefined){
					toastr.warning('창고를 선택해주세요.');
					$(td).eq(lcNmCol).find('.btnLocationModalShow').focus();
					state = false;
					return false;
				}

				if(lcDtlIdx == '' || lcDtlIdx == null || lcDtlIdx == 'null' || lcDtlIdx == undefined){
					lcDtlIdx = 0;
				}
				obj.saCmptQty = 0;
				obj.saRealQty = saRealQty;
				obj.saDiffQty = 0;
				obj.saAppdDate = saAppdDate.replaceAll('-','')+'01';
				obj.saWhsIdx = lcIdx;
				obj.saLocIdx = lcDtlIdx;
				obj.saDesc = saDesc;
			}
			array.push(obj);
		});

		//원본데이터
		let tableData = [];
		for(var i=0;i<stockDtlTable.data().count();i++) {
			let obj = {};

			let data = stockDtlTable.row(i).data();
			obj.saType = 'A';
			obj.saNo = data.saNo;
			obj.saSeq = data.saSeq;
			obj.saAppdYn = data.saAppdYn;
			obj.saGubun = data.saGubun;
			obj.saCd = data.saCd;
			obj.itemVerIdx= data.itemVerIdx;
			obj.saCmptQty = parseInt(data.saCmptQty);
			obj.saRealQty = parseInt(data.saRealQty);
			obj.saDiffQty = parseInt(data.saDiffQty);
			obj.saAppdDate = data.saAppdDate;
			obj.saWhsIdx = data.lcIdx;
			obj.saLocIdx = data.lcDtlIdx;
			obj.saDesc = data.saDesc;
			
			tableData.push(obj);
		}
		array = _.differenceWith(array, tableData, _.isEqual);
		if(state){
			$.ajax({
				url: '<c:url value="/stock/stockAdjustAdmUpd"/>',
	            type: 'POST',
	            data: {
	            	'jsonArray'	:	JSON.stringify(array)
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if (res.result == "ok") { //응답결과
						toastr.success('수정되었습니다.');
						saNo = '';
						stockAdmTable.rows('.selected').deselect();
						stockDtlTable.rows('.selected').deselect();
						
						stockAdmTable.ajax.reload();
						stockDtlTable.ajax.reload();
						$('#btnAllCheck').prop("checked",false);
						//열 움직이는 기능 잠금
						stockDtlTable.colReorder.enable();
						//필터 잠금
						$('#stockDtlTable_wrapper').find('.filters th').each(function(index, item) {
							$(item).find('input').attr('disabled', false); // 검색 필터 disabled
						});

						WM_action_OFF('DTL_EDIT');

						$('#btnNew').attr('disabled',false);
						$('#btnSave').attr('disabled',true);
						$('#btnEdit').attr('disabled',true);
						$('#btnDel').attr('disabled',false);
						$('#btnCancel').attr('disabled',true);
						
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
	}

	//삭제처리
	$('#btnDel').on('click',function(){
		if($('#stockDtlTable tbody').find('tr.selected').length == 0) {
			toastr.warning('삭제할 항목을 선택해주세요.');
			return false;
		}

		let saAppdYn = stockDtlTable.row('.selected').data().saAppdYn;
		let saNo = stockDtlTable.row('.selected').data().saNo;
		if(isEmptyCheck(saNo)){
			stockDtlTable.row('.selected').remove().draw(false);
		} else {
			if(saAppdYn == 'Y'){
				toastr.warning('반영된 항목은 삭제할 수 없습니다.');
				return false;
			}
	
			$('#deleteModal').modal('show');
			$('#deleteModal').data('deleteType','DTL');
		}
	});

	$('#btnDeleteModalY').on('click',function(){
		let deleteType = $('#deleteModal').data('deleteType');
		if(deleteType == 'DTL'){
			let saSeq = stockDtlTable.row('.selected').data().saSeq;
			$.ajax({
				url: '<c:url value="/stock/stockAdjustAdmDel"/>',
	            type: 'POST',
	            data: {
		            'saNo'	:	function(){ return saNo; },
	                'saSeq'	:	function(){ return saSeq; },
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if (res.result == "ok") { //응답결과
						toastr.success('삭제되었습니다.');
						$('#stockDtlTable').DataTable().row('.selected').remove().draw(false);
						
						if(stockDtlTable.data().length == 0){
							stockAdmTable.ajax.reload(function(){
								let data = stockAdmTable.data();
								if( _.some(stockAdmTable.data().toArray(), v=> v.saNo == saNo) ){
									stockAdmTable.row('#'+saNo).select();
									$(stockAdmTable.row('#'+saNo).node()).trigger('click');
								} else {
									saNo = '';
									stockDtlTable.clear().draw(false);
								}
							});
						} else {
							if( $('input:checkbox[name=btnStockAppdCheck]').length == $('input:checkbox[name=btnStockAppdCheck]:checked').length ){ //전체 체크박스 수와 체크된 박스의 수가 같을 때 -> 전체체크박스 체크 , 아닐 경우 해제
								$('#btnAllCheck').prop("checked",true);
							} else{
								$('#btnAllCheck').prop("checked",false);
							}
						}
					} else if(res.result == 'fail') {
						toastr.warning(res.message);
						stockAdmTable.rows('.selected').deselect();
						stockDtlTable.rows('.selected').deselect();
						$('#btnAllCheck').prop("checked",false);
						stockAdmTable.ajax.reload(function(){
							let data = stockAdmTable.data();
							if( _.some(stockAdmTable.data().toArray(), v=> v.saNo == saNo) ){
								stockAdmTable.row('#'+saNo).select();
								$(stockAdmTable.row('#'+saNo).node()).trigger('click');
							} else {
								saNo = '';
								stockDtlTable.clear().draw(false);
							}
						});
					} else {
						toastr.error(res.message);
					}
					$('#my-spinner').hide();
				}
			});
		}
	});	
	
	//취소처리
	$('#btnCancel').on('click', function() {
		$('#cancelModal').modal('show');
	});

	$('#btnCancelModalY').on('click',function(){
		WM_action_OFF('ADM');
		WM_action_OFF('DTL_NEW');
		WM_action_OFF('DTL_EDIT');

		stockDtlTable.rows('.selected').deselect();
		$('#btnAllCheck').prop("checked",false);
		stockDtlTable.ajax.reload();

		//열 움직이는 기능 잠금
		stockDtlTable.colReorder.enable();
		//필터 잠금
		$('#stockDtlTable_wrapper').find('.filters th').each(function(index, item) {
			$(item).find('input').attr('disabled', false); // 검색 필터 disabled
		});
		//필터 잠금
		$('#stockDtlTable_wrapper').find('.filters th').eq(saAppdYnColIdx).find('input').attr('disabled', true); // 검색 필터 disabled
		
		$('#btnNew').attr('disabled', false); // 신규 버튼
		$('#btnSave').attr('disabled', true); // 저장 버튼
		$('#btnEdit').attr('disabled', true); // 수정 버튼
		$('#btnDel').attr('disabled', false); // 삭제 버튼
		$('#btnCancel').attr('disabled', true); // 취소 버튼
	});

	$('#btnSearch').on('click',function(){
		WM_action_OFF('ADM');
		WM_action_OFF('DTL_NEW');
		WM_action_OFF('DTL_EDIT');

		saNo = '';
		stockAdmTable.rows('.selected').deselect();
		stockDtlTable.rows('.selected').deselect();
		$('#btnAllCheck').prop("checked",false);
		stockAdmTable.ajax.reload();
		stockDtlTable.ajax.reload();
		//열 움직이는 기능 잠금
		stockDtlTable.colReorder.enable();
		//필터 잠금
		$('#stockDtlTable_wrapper').find('.filters th').each(function(index, item) {
			$(item).find('input').attr('disabled', false); // 검색 필터 disabled
		});
		
		$('#btnNew').attr('disabled', false); // 신규 버튼
		$('#btnSave').attr('disabled', true); // 저장 버튼
		$('#btnEdit').attr('disabled', true); // 수정 버튼
		$('#btnDel').attr('disabled', false); // 삭제 버튼
		$('#btnCancel').attr('disabled', true); // 취소 버튼
	});
	
</script>

</body>
</html>
