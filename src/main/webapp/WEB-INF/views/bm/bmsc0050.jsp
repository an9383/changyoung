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
																		  grid-template-columns: 4fr 4px 3fr;">
	<div id="leftcol">
		<div class="container-fluid h-100" style="padding: 5px;">
			<div class="row" id="leftHeader" style="padding-bottom: 5px;">
				<div class="d-flex align-items-center d-flex">
					<%-- <label class="form-label d-flex align-items-center header-label m-0 me-1 h-100"><spring:message code="userStateCd" text="default text" /></label>
					<select class="form-select w-auto h-100 me-3" id="SearchUserStateCd"></select> --%>
					<input type="text" class="form-control w-auto h-100 me-1" id="searchAll" placeholder="통합검색" >
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end">
					<div class="btn-group" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnPrcssOrdSave" disabled><i class="fa-regular fa-floppy-disk"></i></button>
						<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnSearch"><i class="fa-regular fa-clipboard"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnOpen"><i class="fa-solid fa-caret-left"></i></button>
					</div>
				</div>
			</div>
			<div class="row">
				<table class="table table-bordered p-0 m-0" id="prcssTable">
					<thead class="table-light">
						<tr>
							<th class="text-center">No</th>
							<th class="text-center">공정코드</th>
							<th class="text-center">공정명</th>
							<th class="text-center">수량단위</th>
							<th class="text-center">이니셜</th>
							<th class="text-center">비고</th>
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
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end w-100">
					<div class="btn-group" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnNew"><i class="fa-solid fa-plus"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnSave" disabled><i class="fa-regular fa-floppy-disk"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnEdit" disabled><i class="fa-regular fa-pen-to-square"></i></button>
						<button type="button" class="btn btn-outline-danger w-auto" style="font-size: 17px !important;" id="btnDel" disabled><i class="fa-solid fa-trash-can"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnCancel" disabled><i class="fa-solid fa-xmark"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnClose"><i class="fa-solid fa-caret-right"></i></button>
					</div>
				</div>
			</div>
			<div class="row">
				<div style="width: 100%;">
				  	<div class="nav nav-tabs" id="nav-tab">
						<button class="nav-link active" id="tab1Nav" data-bs-toggle="tab" data-bs-target="#tab1"><spring:message code="baseInfo" text="default text" /></button>
						<button class="nav-link" id="tab2Nav" data-bs-toggle="tab" data-bs-target="#tab2">공정작업자</button>
						<button class="nav-link" id="tab3Nav" data-bs-toggle="tab" data-bs-target="#tab3">설비</button>
						<button class="nav-link" id="tab4Nav" data-bs-toggle="tab" data-bs-target="#tab4">작업방식</button>
						<button class="nav-link" id="tab5Nav" data-bs-toggle="tab" data-bs-target="#tab5">검사항목</button>
				  	</div>
					<div class="tab-content" id="nav-tabContent">
						<!-- 탭1 기본정보 -->
						<div class="tab-pane fade show active" id="tab1">
							<div class="row" style="padding: 5px;">
								<table class="table table-bordered p-0 m-0">
									<colgroup>
										<col width="15%">
										<col width="35%">
										<col width="15%">
										<col width="35%">
									</colgroup>
									<tr>
										<th class="text-center align-middle"><span style="color: #ff0000;">*</span>공정코드</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="prcssCd" disabled>
										</td>
										<th class="text-center align-middle"><span style="color: #ff0000;">*</span>공정명</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="prcssNm" disabled>
										</td>
									</tr>
									<tr>										
										<th class="text-center align-middle">수량단위</th>
										<td class="text-center align-middle">
											<select class="form-select inputGroup" id="qtyUnit" disabled>
											</select>
										</td>
										<th class="text-center align-middle">이니셜</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="initial" disabled>
										</td>
									</tr>
									<tr>										
										<th class="text-center align-middle">생산지시단위</th>
										<td class="text-center align-middle">
											<select class="form-select inputGroup" id="produceQtyUnit" disabled>
											</select>
										</td>
										<th class="text-center align-middle">수불구분</th>
										<td class="text-center align-middle">
											<select class="form-select inputGroup" id="stockOption" disabled>
												<!-- <option value="" selected>선택</option>
												<option value="Y">적용</option>
												<option value="N">미적용</option> -->
											</select>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle">공정 그룹</th>
										<td class="text-center align-middle">
											<select class="form-select inputGroup" id="prcssGroupCd"></select>
											<!-- <select class="form-select inputGroup" id="prcssGroupCd" disabled>
											</select> -->
										</td>
										
										<th class="text-center align-middle">첫 공정</th>
										<td class="text-center align-middle">
											<input type="checkbox" class="inputGroup" id="firstPrcssYn" style="width:50px;height:50px;" disabled>											
										</td>
									</tr>
									<tr>										
										<th class="text-center align-middle">추가재단여부</th>
										<td class="text-center align-middle">
											<select class="form-select inputGroup" id="cutYn" disabled>
												<option value="" selected>선택</option>
												<option value="Y">적용</option>
												<option value="N">미적용</option>
											</select>
										</td>
										<th class="text-center align-middle">목형사용여부</th>
										<td class="text-center align-middle">
											<select class="form-select inputGroup" id="woodenUseYn" disabled>
												<option value="" selected>선택</option>
												<option value="Y">사용</option>
												<option value="N">미사용</option>
											</select>
										</td>
									</tr>
									<tr>										
										<th class="text-center align-middle">CR코팅판사용여부</th>
										<td class="text-center align-middle">
											<select class="form-select inputGroup" id="crUseYn" disabled>
												<option value="" selected>선택</option>
												<option value="Y">사용</option>
												<option value="N">미사용</option>
											</select>
										</td>
										<th class="text-center align-middle">UV코팅판사용여부</th>
										<td class="text-center align-middle">
											<select class="form-select inputGroup" id="uvUseYn" disabled>
												<option value="" selected>선택</option>
												<option value="Y">사용</option>
												<option value="N">미사용</option>
											</select>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle">비고</th>
										<td colspan="3" class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="prcssDesc" disabled>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle">실적화면</th>
										<td colspan="3" class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="resultPageNm" disabled>
										</td>
									</tr>
								</table>
							</div>
						</div>
						<!-- 탭1 기본정보 끝 -->
						<!-- 탭2 공정작업자 -->
						<div class="tab-pane fade" id="tab2">
							<div class="row" style="padding: 5px;">
								<div class="d-flex align-items-center justify-content-end w-100" style="margin-bottom:5px;">
									<input type="text" class="form-control w-auto h-100 me-1" id="searchAllPwt" placeholder="통합검색" >
									<div class="btn-group" role="group" aria-label="Small button group">
										<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnPrcssWorkerSave" disabled>
											<i class="fa-regular fa-floppy-disk"></i>
										</button>								
									</div>	
								</div>
								<table class="table table-bordered p-0 m-0">
									<colgroup>
										<col width="20%">
										<col width="30%">
										<col width="20%">
										<col width="30%">
									</colgroup>										
										<table class="table table-bordered p-0 m-0" id="prcssWorkerTable">
											<thead class="table-light">
												<tr>
													<th class="text-center">
														<input type="checkbox" id="btnAllCheck" style="width:20px; height:20px;">
													</th>
													<th class="text-center">아이디</th>
													<th class="text-center">성명</th>
													<th class="text-center">소속팀</th>		
													<th class="text-center">부서</th>														
													<th class="text-center">담당업무</th>									
												</tr>
											</thead>
										</table>
								</table>
							</div>
						</div>
						<!-- 탭2 공정작업자 끝 -->
						<!-- 탭3 설비 -->
						<div class="tab-pane fade" id="tab3">
							<div class="row" style="padding: 5px;">
								<div class="d-flex align-items-center justify-content-end w-100" style="margin-bottom:5px;">
									<input type="text" class="form-control w-auto h-100 me-1" id="searchAllEt" placeholder="통합검색" >
									<div class="btn-group" role="group" aria-label="Small button group">
										<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnPrcssEquipSave" disabled>
											<i class="fa-regular fa-floppy-disk"></i>
										</button>								
									</div>	
								</div>
								<table class="table table-bordered p-0 m-0">
									<colgroup>
										<col width="20%">
										<col width="40%">
										<col width="40%">
									</colgroup>										
									<table class="table table-bordered p-0 m-0" id="equipTable">
										<thead class="table-light">
											<tr>
												<th class="text-center">
													<input type="checkbox" id="btnEquipAllCheck" style="width:20px; height:20px;">
												</th>
												<th class="text-center">설비코드</th>
												<th class="text-center">설비명</th>
											</tr>
										</thead>
									</table>
								</table>
							</div>
						</div>
						<!-- 탭3 설비 끝 -->
						<!-- 탭4 작업방식 -->
						<div class="tab-pane fade" id="tab4">
							<div class="row" style="padding: 5px;">
								<div class="d-flex align-items-center justify-content-end w-100" style="margin-bottom:5px;">
									<div class="btn-group" role="group" aria-label="Small button group">
										<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnPrcssWorkMethodNew" disabled>
											<i class="fa-solid fa-plus"></i>
										</button>
										<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnPrcssWorkMethodSave" disabled>
											<i class="fa-regular fa-floppy-disk"></i>
										</button>							
										<!-- <button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnPrcssEquipEdit" disabled>
											<i class="fa-regular fa-pen-to-square"></i>
										</button> -->
										<button type="button" class="btn btn-outline-danger w-auto" style="font-size: 17px !important;" id="btnPrcssWorkMethodDel" disabled>
											<i class="fa-solid fa-trash-can"></i>
										</button>	
									</div>	
								</div>
								<table class="table table-bordered p-0 m-0">
									<colgroup>
										<col width="20%">
										<col width="30%">
										<col width="20%">
										<col width="30%">
									</colgroup>										
										<table class="table table-bordered p-0 m-0" id="prcssWorkMethodTable">
											<thead class="table-light">
												<tr>
													<th class="text-center">
														<input type="checkbox" id="btnPrcssMethodAllCheck" style="width:20px; height:20px;">
													</th>
													<th class="text-center">작업방식코드</th>
													<th class="text-center">작업방식명</th>
												</tr>
											</thead>
										</table>
								</table>
							</div>
						</div>
						<!-- 탭4 작업방식 끝 -->
						<!-- 탭5 검사항목 -->
						<div class="tab-pane fade" id="tab5">
							<div class="row" style="padding: 5px;">
								<div class="d-flex align-items-center justify-content-end w-100" style="margin-bottom:5px;">
									<div class="btn-group" role="group" aria-label="Small button group">
										<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnInspectionMethodNew" disabled>
											<i class="fa-solid fa-plus"></i>
										</button>
										<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnInspectionMethodSave" disabled>
											<i class="fa-regular fa-floppy-disk"></i>
										</button>							
										<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnInspectionMethodEdit" disabled>
											<i class="fa-regular fa-pen-to-square"></i>
										</button>
										<button type="button" class="btn btn-outline-danger w-auto" style="font-size: 17px !important;" id="btnInspectionMethodDel" disabled>
											<i class="fa-solid fa-trash-can"></i>
										</button>	
									</div>	
								</div>
								<table class="table table-bordered p-0 m-0">
									<colgroup>
										<col width="20%">
										<col width="80%">
									</colgroup>										
										<table class="table table-bordered p-0 m-0" id="prcssInspectionMethodTable">
											<thead class="table-light">
												<tr>
													<th class="text-center">No.</th>
													<th class="text-center">점검항목</th>
												</tr>
											</thead>
										</table>
								</table>
							</div>
						</div>
						<!-- 탭5 검사항목 끝 -->
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

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
	
	$('#btnOpen').on('click',function() { // right-box 열기버튼 클릭
		if($('#rightcol').hasClass('d-none')){
			$('#page').css('grid-template-columns', '4fr 4px 3fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcol').removeClass('d-none');
		} else {
			$('#page').css('grid-template-columns', '0fr 4px 3fr');
			$('#leftcol').addClass('d-none');
			$('#rightcol').removeClass('d-none');
		}
		dataTableDrawAll(); // dataTable 전체 reload
	});
	
	$('#btnClose').on('click',function() { // right-box 닫기버튼 클릭
		if($('#leftcol').hasClass('d-none')){
			$('#page').css('grid-template-columns', '4fr 4px 3fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcol').removeClass('d-none');
		} else {
			$('#page').css('grid-template-columns', '4fr 4px 0fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcol').addClass('d-none');
		}
		dataTableDrawAll(); // dataTable 전체 reload
	});
</script>

<script>
	WM_init('new');
	WM_init('edit');
	WM_init('prcssWorkMethod');
	WM_init('inspMethod');

	// 공통코드 조회
	let qtyUnitList = getCommonCode('일반', '003'); //수량단위
	let produceQtyUnitList = getCommonCode('시스템', '018'); //생산지시단위
	let stockOptionList = getCommonCode('시스템', '024'); //수불구분
	let prcssGroupCdList = getCommonCode('시스템', '029'); //공정그룹

	selectBoxAppend(qtyUnitList, 'qtyUnit', '', '2');
	selectBoxAppend(produceQtyUnitList, 'produceQtyUnit', '', '2');
	selectBoxAppend(stockOptionList, 'stockOption', '', '2');
	//selectBoxAppend(prcssGroupCdList, 'prcssGroupCd', '', '2');
	
	let delStatus = '';

	let prcssGroupCdSelect = new Array(); 
	prcssGroupCdList.forEach((item) => {
		var prcssGroupCdData = new Object();
		prcssGroupCdData.id = item.commonCd;
		prcssGroupCdData.text = item.commonNm;
		prcssGroupCdSelect.push(prcssGroupCdData);
	});
	
	$('#prcssGroupCd').select2({
		data: prcssGroupCdSelect,
		multiple : true,
		placeholder: "그룹 선택",
	});
	$('#prcssGroupCd').attr('disabled',true);
	
	// 공정정보 목록조회
	$('#prcssTable thead tr').clone(true).addClass('filters').appendTo('#prcssTable thead'); // filter 생성
	let prcssTable = $('#prcssTable').DataTable({
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
			url : '<c:url value="/bm/prcssListAll"/>',
			type : 'GET',
			data : {
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'prcssOrder', className : 'text-center'},
			{ data: 'prcssCd', className : 'text-center'},
			{ data: 'prcssNm', className : 'text-center'},
			{ data: 'qtyUnitNm', className : 'text-center'},
			{ data: 'initial', className : 'text-center'},
			{ data: 'prcssDesc', className : 'text-center'},
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
			let theadHeight = parseFloat($('#prcssTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 79)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAll').off('keyup',function() {});
			$('#searchAll').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			});
			//progressOrder
			for(var i=0;i<data.length;i++) {
				let tr = $('#' + table_id + ' tbody').find('tr').eq(i);
				prcssTable.row(tr).data().prcssOrder = i+1;
				$(tr).find('td').eq(0).html(i+1);
			}
		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#prcssTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#prcssTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	prcssTable.on('column-reorder', function( e, settings, details ) {
		let api = prcssTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#prcssTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	//공정순서변경되었을 때
	prcssTable.on( 'row-reorder', function ( e, diff, changes ) {
		if(diff.length != 0){
			$('#btnPrcssOrdSave').attr('disabled',false);
		}
	} );

	$('#btnPrcssOrdSave').on('click',function(){
		let updateList = [];
		$('#prcssTable tbody tr').each(function(index){
			let data = prcssTable.row(index).data();
			let obj = {};
			obj.idx = data.idx;
			obj.prcssOrder = data.prcssOrder;
			obj.prcssCd = data.prcssCd;
			obj.prcssNm = data.prcssNm;
			obj.qtyUnit = data.qtyUnit;
			obj.initial = data.initial;
			obj.prcssDesc = data.prcssDesc;
			updateList.push(obj);
		});

		$.ajax({
			url: '<c:url value="/bm/prcssOrdUpdate"/>',
            type: 'POST',
            //async: false,
            data: {
            	'updateList' : 	JSON.stringify(updateList)
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					toastr.success('공정순서가 변경되었습니다.');
					$('#btnPrcssOrdSave').attr('disabled',true);
					prcssTable.ajax.reload();
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();				
			}
		});
	});
	
	// 조회 버튼 click
	$('#btnSearch').on('click', function() {
		$('#my-spinner').show();
		prcssTable.ajax.reload(function() {});

		setTimeout(function() {
			$('#my-spinner').hide();
		}, 100)
	});

	// 사용자목록 click
	let prcssIdx = '';
	$('#prcssTable tbody').on('click','tr', function() {
		let idx = prcssTable.row(this).data().idx;
		if(WMCheck('new')) { // 신규등록중일 경우
			setWM('new', 'idx', idx);
			return false;
		}
		if(WMCheck('edit')) { // 수정중일 경우
			setWM('edit', 'idx', idx);
			return false;
		}
		if(WMCheck('prcssWorkMethod')) { // 작업방식 등록중일 경우
			setWM('prcssWorkMethod', 'idx', idx);
			return false;
		}
		if(WMCheck('inspMethod')) { // 검사항목 등록중일 경우
			setWM('inspMethod', 'idx', idx);
			return false;
		}
		prcssIdx = idx;
		prcssWorkerTable.ajax.reload( function(){
			if( $('input:checkbox[name=btnCheck]').length == $('input:checkbox[name=btnCheck]:checked').length ){ //전체 체크박스 수와 체크된 박스의 수가 같을 때 -> 전체체크박스 체크 , 아닐 경우 해제
				$('#btnAllCheck').prop("checked",true);
			} else{
				$('#btnAllCheck').prop("checked",false);
			} 
		});
		equipTable.ajax.reload( function(){
			if( $('input:checkbox[name=btnEquipCheck]').length == $('input:checkbox[name=btnEquipCheck]:checked').length ){ //전체 체크박스 수와 체크된 박스의 수가 같을 때 -> 전체체크박스 체크 , 아닐 경우 해제
				$('#btnEquipAllCheck').prop("checked",true);
			} else{
				$('#btnEquipAllCheck').prop("checked",false);
			} 
		});
		prcssWorkMethodTable.ajax.reload(function(){
			if($('input:checkbox[name=btnPrcssMethodCheck]').length == 0){
				$('#btnPrcssMethodAllCheck').prop("checked",false);
			} else if( $('input:checkbox[name=btnPrcssMethodCheck]').length == $('input:checkbox[name=btnPrcssMethodCheck]:checked').length ){ //전체 체크박스 수와 체크된 박스의 수가 같을 때 -> 전체체크박스 체크 , 아닐 경우 해제
				$('#btnPrcssMethodAllCheck').prop("checked",true);
			} else{
				$('#btnPrcssMethodAllCheck').prop("checked",false);
			}
			$('input[name=workCd]').attr('disabled',true);
    		$('input[name=workNm]').attr('disabled',true);
		});
		prcssInspectionMethodTable.ajax.reload();
		$('#btnInspectionMethodNew').attr('disabled',false);
		$('#btnInspectionMethodSave').attr('disabled',true);
		$('#btnInspectionMethodEdit').attr('disabled',false);
		$('#btnInspectionMethodDel').attr('disabled',false);
		
		
		let data;
		$.ajax({
			url: '<c:url value="/bm/prcssInfoSel"/>',
            type: 'GET',
            //async: false,
            data: {
                'idx'	:	idx
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					data = res.data;


					$('.inputGroup').attr('disabled', true); // 입력항목
					$('#btnUserIdCheck').attr('disabled', true); // 중복확인 버튼
					$('#btnSignImage').attr('disabled', true); // 사진선택 버튼

					$('#btnNew').attr('disabled', false); // 신규 버튼
					$('#btnSave').attr('disabled', true); // 저장 버튼
					$('#btnEdit').attr('disabled', false); // 수정 버튼
					$('#btnDel').attr('disabled', false); // 삭제 버튼
					$('#btnCancel').attr('disabled', true); // 취소 버튼

					$('#btnPrcssWorkerSave').attr('disabled',false);//공정작업자 저장버튼
					$('#btnPrcssEquipSave').attr('disabled',false);//설비 저장버튼

					//작업방식
					$('#btnPrcssWorkMethodNew').attr('disabled',false);
					$('#btnPrcssWorkMethodSave').attr('disabled',true);
					$('#btnPrcssWorkMethodDel').attr('disabled',false);
					
					$('#prcssCd').val(data.prcssCd);
					$('#prcssNm').val(data.prcssNm);
					$('#qtyUnit').val(data.qtyUnit);
					$('#produceQtyUnit').val(data.produceQtyUnit);
					$('#initial').val(data.initial);
					$('#prcssDesc').val(data.prcssDesc);
					$('#stockOption').val(data.stockOption);
					if(!isEmptyCheck(data.prcssGroupCd)){
						let splitData =  data.prcssGroupCd.split(',');
						$('#prcssGroupCd').val(splitData).trigger('change');
					} else {
						$('#prcssGroupCd').val('').trigger('change');
					}

					if(data.firstPrcssYn == 'Y'){
						$('#firstPrcssYn').prop('checked',true);
					} else {
						$('#firstPrcssYn').prop('checked',false);
					}

					$('#cutYn').val(data.cutYn);
					$('#woodenUseYn').val(data.woodenUseYn);
					$('#crUseYn').val(data.crUseYn);
					$('#uvUseYn').val(data.uvUseYn);
					$('#resultPageNm').val(data.resultPageNm);
					
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();				
			}
		});
	});

	// 작업중 경고 모달 예 버튼 click
	$('#btnWorkingWarningModalY').on('click', function() {
		if(WMlastIdx == 'new' || WMlastIdx == 'edit') { // 등록중이거나 수정중이였을 경우
			$('#btnSave').trigger('click');
			return false;
		} else if(WMlastIdx == 'prcssWorkMethod'){
			$('#btnPrcssWorkMethodSave').trigger('click');
			return false;
		} else if(WMlastIdx == 'inspMethod'){
			$('#btnInspectionMethodSave').trigger('click');
			return false;
		}
	});

	// 작업중 경고 모달 아니요 버튼 click
	$('#btnWorkingWarningModalN').on('click', function() {
		if(WMlastIdx == 'new' || WMlastIdx == 'edit' || WMlastIdx == 'prcssWorkMethod' || WMlastIdx == 'inspMethod') { // 등록중이거나 수정중이였을 경우
			if(getWM(WMlastIdx, 'idx') != '' && getWM(WMlastIdx, 'idx') != undefined) {
				let idx = getWM(WMlastIdx, 'idx');
				WM_action_OFF(WMlastIdx);
				setWM(WMlastIdx, 'idx', '');
				prcssTable.row('#'+idx).select();
				$(prcssTable.row('#'+idx).node()).trigger('click'); // 선택했던 항목 선택처리
			} else {
				WM_action_OFF(WMlastIdx);
				if(window.location != window.parent.location) { // tab일 경우
					// 부모 탭 닫기버튼 click
					$('#tab-list', parent.document).find('.active').find('span').eq(1).find('i').trigger('click');
			    }
				
				$('.inputGroup').attr('disabled', true); // 입력항목
				$('#btnUserIdCheck').attr('disabled', true); // 중복확인 버튼
				$('#btnSignImage').attr('disabled', true); // 사진선택 버튼
				
				$('#btnNew').attr('disabled', false); // 신규 버튼
				$('#btnSave').attr('disabled', true); // 저장 버튼
				$('#btnEdit').attr('disabled', true); // 수정 버튼
				$('#btnDel').attr('disabled', true); // 삭제 버튼
				$('#btnCancel').attr('disabled', true); // 취소 버튼
			}
			
			return false;
		}
	});

	// 신규 버튼 click
	$('#btnNew').on('click', function() {
		$('#btnSave').data('saveType','insert'); // 저장 방식 -> 등록
		
		WM_action_ON('new', 'workingWarningModal');

		$('#tab1Nav').trigger('click');
		
		$('#userAdmin').attr('checked',false);
		$('#userSign').attr('checked',false);
		$('.inputGroup').val('');
		
		$('.inputGroup').attr('disabled', false); // 입력항목
		$('#btnUserIdCheck').attr('disabled', false); // 중복확인 버튼
		$('#btnSignImage').attr('disabled', false); // 사진선택 버튼
		
		$('#btnNew').attr('disabled', true); // 신규 버튼
		$('#btnSave').attr('disabled', false); // 저장 버튼
		$('#btnEdit').attr('disabled', true); // 수정 버튼
		$('#btnDel').attr('disabled', true); // 삭제 버튼
		$('#btnCancel').attr('disabled', false); // 취소 버튼
	});

	// 저장 버튼 click
	$('#btnSave').on('click', function() {
		let saveType = $(this).data('saveType');

		if($('#prcssCd').val() == '') {
			toastr.warning('공정코드를 입력해주세요.');
			$('#prcssCd').select();
			return false;
		}
		if($('#prcssNm').val() == '') {
			toastr.warning('공정명을 입력해주세요.');
			$('#prcssNm').select();
			return false;
		}

		if($('#qtyUnit').val() == ''){
			toastr.warning('수량단위를 선택해주세요.');
			$('#qtyUnit').select();
			return false;
		}

		let firstPrcssYn = $('#firstPrcssYn').prop('checked') ? 'Y' : 'N';
		
		// 등록할 경우에
		if(saveType == 'insert') {	
			$.ajax({
				url: '<c:url value="/bm/prcssInsert"/>',
	            type: 'POST',
	            //async: false,
	            data: {
		            'prcssCd'			:	function(){ return $('#prcssCd').val(); },
	                'prcssNm'			:	function(){ return $('#prcssNm').val(); },
	                'qtyUnit'			:	function(){ return $('#qtyUnit').val(); },
	                'initial'			:	function(){ return $('#initial').val(); },
	                'prcssDesc'			:	function(){ return $('#prcssDesc').val(); },
	                'produceQtyUnit' 	:	function(){ return $('#produceQtyUnit').val(); },
	                'stockOption'		:	function(){ return $('#stockOption').val(); },
	                'prcssGroupCd'		:	function(){ return $('#prcssGroupCd').val().join(','); },
	              	'firstPrcssYn'		:	function(){ return firstPrcssYn; },  
	              	'cutYn'				:	function(){ return $('#cutYn').val(); } ,
	              	'woodenUseYn'		:	function(){ return $('#woodenUseYn').val(); },
	              	'crUseYn'			:	function(){ return $('#crUseYn').val(); },
	              	'uvUseYn'			:	function(){ return $('#uvUseYn').val(); },
	              	'resultPageNm'		:	function(){ return $('#resultPageNm').val(); },  
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if (res.result == "ok") { //응답결과
						toastr.success('신규 저장되었습니다.');

						$('#btnSearch').trigger('click'); // 조회버튼 click

						WM_action_OFF('new');

						$('#userPw').val('');
						$('#userPwCheck').val('');
						
						$('.inputGroup').attr('disabled', true); // 입력항목
						$('#btnUserIdCheck').attr('disabled', true); // 중복확인 버튼
						$('#btnSignImage').attr('disabled', true); // 사진선택 버튼
						
						$('#btnNew').attr('disabled', false); // 신규 버튼
						$('#btnSave').attr('disabled', true); // 저장 버튼
						$('#btnEdit').attr('disabled', true); // 수정 버튼
						$('#btnDel').attr('disabled', true); // 삭제 버튼
						$('#btnCancel').attr('disabled', true); // 취소 버튼
					} else if(res.result == 'fail') {
						toastr.warning(res.message);
					} else {
						toastr.error(res.message);
					}
					$('#my-spinner').hide();
				}
			});
		} else { // 수정할 경우에
			let idx = prcssTable.row('.selected').data().idx;
			$.ajax({
				url: '<c:url value="/bm/prcssUpdate"/>',
	            type: 'POST',
	            //async: false,
	            data: {
	                'idx'				:	function(){ return idx; },
	                'prcssCd'			:	function(){ return $('#prcssCd').val(); },
	                'prcssNm'			:	function(){ return $('#prcssNm').val(); },
	                'qtyUnit'			:	function(){ return $('#qtyUnit').val(); },
	                'initial'			:	function(){ return $('#initial').val(); },
	                'prcssDesc'			:	function(){ return $('#prcssDesc').val(); },
	                'produceQtyUnit' 	:	function(){ return $('#produceQtyUnit').val(); },
	                'stockOption'		:	function(){ return $('#stockOption').val(); },
	                'prcssGroupCd'		:	function(){ return $('#prcssGroupCd').val().join(','); },
	              	'firstPrcssYn'		:	function(){ return firstPrcssYn; },
	              	'cutYn'				:	function(){ return $('#cutYn').val(); },
	              	'woodenUseYn'		:	function(){ return $('#woodenUseYn').val(); },
	              	'crUseYn'			:	function(){ return $('#crUseYn').val(); },
	              	'uvUseYn'			:	function(){ return $('#uvUseYn').val(); },
	              	'resultPageNm'		:	function(){ return $('#resultPageNm').val(); },  
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if (res.result == "ok") { //응답결과
						toastr.success('수정 저장되었습니다.');

						$('#btnSearch').trigger('click'); // 조회버튼 click

						WM_action_OFF('edit');

						$('#userPw').val('');
						$('#userPwCheck').val('');
						
						$('.inputGroup').attr('disabled', true); // 입력항목
						$('#btnUserIdCheck').attr('disabled', true); // 중복확인 버튼
						$('#btnSignImage').attr('disabled', true); // 사진선택 버튼
						
						$('#btnNew').attr('disabled', false); // 신규 버튼
						$('#btnSave').attr('disabled', true); // 저장 버튼
						$('#btnEdit').attr('disabled', true); // 수정 버튼
						$('#btnDel').attr('disabled', true); // 삭제 버튼
						$('#btnCancel').attr('disabled', true); // 취소 버튼

						let idx = prcssTable.row('.selected').data().idx;
						prcssTable.row('#'+idx).select();
						$(prcssTable.row('#'+idx).node()).trigger('click'); // 선택했던 항목 선택처리
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

	// 수정 버튼 click
	$('#btnEdit').on('click', function() {
		$('#btnSave').data('saveType','update'); // 저장 방식 -> 수정

		WM_action_ON('edit', 'workingWarningModal');
		
		$('.inputGroup').attr('disabled', false); // 입력항목
		$('#btnUserIdCheck').attr('disabled', false); // 중복확인 버튼
		$('#btnSignImage').attr('disabled', false); // 사진선택 버튼
		
		$('#btnNew').attr('disabled', true); // 신규 버튼
		$('#btnSave').attr('disabled', false); // 저장 버튼
		$('#btnEdit').attr('disabled', true); // 수정 버튼
		$('#btnDel').attr('disabled', true); // 삭제 버튼
		$('#btnCancel').attr('disabled', false); // 취소 버튼
	});

	// 삭제 버튼 click
	$('#btnDel').on('click', function() {
		delStatus = 'prcss';
		$('#deleteModal').modal('show');
	});

	// 삭제 경고창 삭제 버튼 click
	$('#btnDeleteModalY').on('click', function() {
		if(delStatus == 'prcss'){
			let idx = prcssTable.row('.selected').data().idx;
			$.ajax({
				url: '<c:url value="/bm/prcssDelete"/>',
	            type: 'POST',
	            //async: false,
	            data: {
	                'idx'	:	idx
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if (res.result == "ok") { //응답결과
						toastr.success('삭제되었습니다.');
						$('#btnSearch').trigger('click'); // 조회버튼 click
			
						$('#userAdmin').attr('checked',false);
						$('#userSign').attr('checked',false);
						$('.inputGroup').val('');
						
						$('.inputGroup').attr('disabled', true); // 입력항목
						$('#btnUserIdCheck').attr('disabled', true); // 중복확인 버튼
						$('#btnSignImage').attr('disabled', true); // 사진선택 버튼
			
						$('#btnNew').attr('disabled', false); // 신규 버튼
						$('#btnSave').attr('disabled', true); // 저장 버튼
						$('#btnEdit').attr('disabled', true); // 수정 버튼
						$('#btnDel').attr('disabled', true); // 삭제 버튼
						$('#btnCancel').attr('disabled', true); // 취소 버튼

					} else if(res.result == 'fail') {
						toastr.warning(res.message);
					} else {
						toastr.error(res.message);
					}
					$('#my-spinner').hide();
				}
			});
		} else if(delStatus == 'prcssWorkMethod'){
			let idx = prcssWorkMethodTable.row('.selected').data().idx;
			$.ajax({
				url: '<c:url value="/bm/prcssWorkMethodDelete"/>',
	            type: 'POST',
	            //async: false,
	            data: {
	                'idx'	:	idx
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if (res.result == "ok") { //응답결과
						toastr.success('삭제되었습니다.');
	
						prcssWorkMethodTable.row('.selected').remove().draw(false);
					} else if(res.result == 'fail') {
						toastr.warning(res.message);
					} else {
						toastr.error(res.message);
					}
					$('#my-spinner').hide();
				}
			});
		} else if(delStatus == 'inspectionMethod'){
			let idx = prcssInspectionMethodTable.row('.selected').data().idx;
			$.ajax({
				url: '<c:url value="/bm/prcssInspectionMethodDelete"/>',
	            type: 'POST',
	            //async: false,
	            data: {
	                'idx'	:	idx
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if (res.result == "ok") { //응답결과
						toastr.success('삭제되었습니다.');
						prcssInspectionMethodTable.row('.selected').remove().draw(false);
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

	// 취소 버튼 click
	$('#btnCancel').on('click', function() {
		$('#cancelModal').modal('show');
	});

	// 취소 경고창 취소 버튼 click
	$('#btnCancelModalY').on('click', function() {
		toastr.success('취소되었습니다.');

		WM_action_OFF('new');
		WM_action_OFF('edit');

		$('.inputGroup').attr('disabled', true); // 입력항목
		$('#btnUserIdCheck').attr('disabled', true); // 중복확인 버튼
		$('#btnSignImage').attr('disabled', true); // 사진선택 버튼
		
		$('#btnNew').attr('disabled', false); // 신규 버튼
		$('#btnSave').attr('disabled', true); // 저장 버튼
		$('#btnEdit').attr('disabled', true); // 수정 버튼
		$('#btnDel').attr('disabled', true); // 삭제 버튼
		$('#btnCancel').attr('disabled', true); // 취소 버튼
	});

	// ID 중복확인 버튼 click
	$('#btnUserIdCheck').on('click', function() {
		if($('#userId').val() == '') {
			toastr.warning('아이디를 입력해주세요.');
			$('#userId').select();
			return false;
		}
		let idx = '';
		let saveType = $('#btnSave').data('saveType');
		if(saveType == 'update') {
			idx = prcssTable.row('.selected').data().idx;
		}
		
		$.ajax({
			url: '<c:url value="/sm/userIdDupCheck"/>',
            type: 'POST',
            async: false,
            data: {
                'idx'		:	idx,
                'userId'	:	$('#userId').val(),
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					toastr.success('사용가능한 ID 입니다.');
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
	});

	// 입사일, 퇴사일 change
	function checkDate(node) {
		let userJoinDate = $('#userJoinDate').val();
		let userLeaveDate = $('#userLeaveDate').val();
				
		if(moment(userJoinDate).diff(moment(userLeaveDate)) > 0) {
			toastr.warning('날짜를 다시 입력해주세요.');
			$(node).val('');
			$(node).select();
			return false;
		}
	}

	// 사진선택 버튼 click
	$('#btnSignImage').on('click', function() {
		$('#signImageFile').trigger('click');
	});

	// 파일 선택
	$('#signImageFile').on('change',function() {
		let formData = new FormData();
		let fileInput = document.getElementById("signImageFile"); //id로 파일 태그를 호출
		let files = fileInput.files; //업로드한 파일들의 정보를 넣는다.
		let bases64 = getImgBase64(files[0]);
		$('#signImage').attr('src','data:image/jpeg;base64,'+bases64);
	})
	
	//공정작업자
	$('#prcssWorkerTable thead tr').clone(true).addClass('filters').appendTo('#prcssWorkerTable thead'); // filter 생성
	let prcssWorkerTable = $('#prcssWorkerTable').DataTable({
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
		/* select: {
            style: 'multi',
            toggleable: true,
            items: 'row',
            info: false
        }, */
        ajax : {
			url : '<c:url value="/bm/prcssWorkerListAll"/>',
			type : 'GET',
			data : {
				prcssIdx : function(){ return prcssIdx;}, 
			},
		},
        rowId: 'idx',
		columns : [
			{	data:'prcssIdx', className : 'text-center',
				render : function(data, type, row, meta) {
					let html = '';
					if(data != null && data != ''){
						html += '<input type="checkbox" name="btnCheck" style="width:20px; height:20px;" checked>';
					} else {
						html += '<input type="checkbox" name="btnCheck" style="width:20px; height:20px;">';
					}
					return html;
				}
			},
			{ data: 'userId', className : 'text-center'},
			{ data: 'userName', className : 'text-center'},
			{ data: 'userTeamNm', className : 'text-center'},
			
			{ data: 'userDepartmentNm', className : 'text-center'},
			{ data: 'userJobNm', className : 'text-center'},
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
			/* { extend: 'colvis',	text: 'Select Col',	}, */
		],
		order : [],
		drawCallback: function() {
			let api = this.api();
			let data = api.data();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#prcssWorkerTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 161)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAllPwt').off('keyup',function() {});
			$('#searchAllPwt').on('keyup',function() {
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
				let cell = $('#prcssWorkerTable_wrapper').find('.filters th').eq(
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
				$('#prcssWorkerTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	prcssWorkerTable.on('column-reorder', function( e, settings, details ) {
		let api = prcssWorkerTable;
		let table_id = $(api.table().node()).attr('id'); // dataTable ID
		
		api.columns().eq(0).each(function (colIdx) {
			$('#'+table_id+'_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	//공정작업자탭 클릭
	$('#tab2Nav').on('click',function(){
		$('#prcssWorkerTable_wrapper').find('tbody').find('.selected').removeClass('selected');

		setTimeout(function(){
			prcssWorkerTable.ajax.reload(function(){
				prcssWorkerTable.draw(false);
			});
		}, 100);
		
	});

	//공정작업자 저장버튼 클릭시
	$('#btnPrcssWorkerSave').on('click',function(){
		$('#my-spinner').show();
		let insertList = [];
		//체크된 항목들만 탐색
		$('input:checkbox[name=btnCheck]:checked').each(function(indxe){
			let tr = $(this).parent().parent(); //해당 tr
			let data = prcssWorkerTable.row(tr).data(); // 데이터 테이블의 해당 칸
			let obj = {};
			obj.userIdx = data.userIdx;
			obj.prcssIdx = prcssTable.row('.selected').data().idx;
			obj.regIdx = '';
			obj.regDate = '';
			insertList.push(obj);
		})

		$('#my-spinner').hide();
		
		$.ajax({		    	
	        url: '<c:url value="/bm/prcssWorkerInsert"/>',
	        type: 'POST',
            data: {
                'jsonArray'	:	JSON.stringify(insertList),
                'prcssIdx'	:	prcssTable.row('.selected').data().idx,
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
	        success: function(res){
	        	if(res.result == "ok"){
	        		$('#my-spinner').hide();
	        		toastr.success('저장 되었습니다.');       
	        		prcssWorkerTable.ajax.reload();
	        	}
	        	else{
	        		$('#my-spinner').hide();
	        		toastr.error(result.message);
	        	}
	        	
	        }
		});	 

	});

	// 설비정보 목록조회
	$('#equipTable thead tr').clone(true).addClass('filters').appendTo('#equipTable thead'); // filter 생성
	let equipTable = $('#equipTable').DataTable({
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
			url : '<c:url value="/bm/prcssEquipListAll"/>',
			type : 'GET',
			data : {
				prcssIdx : function(){ return prcssIdx;}, 
			},
		},
        rowId: 'idx',
		columns : [
			{	data:'idx', className : 'text-center',
				render : function(data, type, row, meta) {
					let html = '';
					if(data != null && data != ''){
						html += '<input type="checkbox" name="btnEquipCheck" style="width:20px; height:20px;" checked>';
					} else {
						html += '<input type="checkbox" name="btnEquipCheck" style="width:20px; height:20px;">';
					}
					return html;
				}
			},
			{ data: 'equipCd', className : 'text-center'},
			{ data: 'equipNm', className : 'text-center'},
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
			/* { extend: 'colvis',	text: 'Select Col',	}, */
		],
		order : [],
		drawCallback: function() {
			let api = this.api();
			let data = api.data();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
		
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#equipTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 161)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAllEt').off('keyup',function() {});
			$('#searchAllEt').on('keyup',function() {
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
				let cell = $('#equipTable_wrapper').find('.filters th').eq(
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
				$('#equipTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	equipTable.on('column-reorder', function( e, settings, details ) {
		let api = equipTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#equipTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	//설비탭 클릭
	$('#tab3Nav').on('click',function(){
		$('#equipTable_wrapper').find('tbody').find('.selected').removeClass('selected');

		setTimeout(function(){
			equipTable.ajax.reload(function(){
				equipTable.draw(false);
			});
		}, 100);
		
	});

	//설비 저장버튼 클릭시
	$('#btnPrcssEquipSave').on('click',function(){
		$('#my-spinner').show();
		let insertList = [];
		//체크된 항목들만 탐색
		$('input:checkbox[name=btnEquipCheck]:checked').each(function(indxe){
			let tr = $(this).parent().parent(); //해당 tr
			let data = equipTable.row(tr).data(); // 데이터 테이블의 해당 칸
			let obj = {};
			obj.equipIdx = data.equipIdx;
			obj.prcssIdx = prcssTable.row('.selected').data().idx;
			obj.regIdx = '';
			obj.regDate = '';
			insertList.push(obj);
		})

		$('#my-spinner').hide();
		
		$.ajax({		    	
	        url: '<c:url value="/bm/prcssEquipInsert"/>',
	        type: 'POST',
            data: {
                'jsonArray'	:	JSON.stringify(insertList),
                'prcssIdx'	:	prcssTable.row('.selected').data().idx,
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
	        success: function(res){
	        	if(res.result == "ok"){
	        		$('#my-spinner').hide();
	        		toastr.success('저장 되었습니다.');       
	        		equipTable.ajax.reload();
	        	}
	        	else{
	        		$('#my-spinner').hide();
	        		toastr.error(result.message);
	        	}
	        	
	        }
		});	 

	});
	
	//모든 체크박스 선택
	$('#btnAllCheck').on('click',function(){
		if($('#btnAllCheck').prop("checked")){
			$('input:checkbox[name=btnCheck]').prop("checked",true);
		}else{
			$('input:checkbox[name=btnCheck]').prop("checked",false);
		}
	});
	// 모든 체크박스 체크/해제 되도록
	$(document).on('change','input:checkbox[name=btnCheck]', function(){
		if( $('input:checkbox[name=btnCheck]').length == $('input:checkbox[name=btnCheck]:checked').length ){ //전체 체크박스 수와 체크된 박스의 수가 같을 때 -> 전체체크박스 체크 , 아닐 경우 해제
			$('#btnAllCheck').prop("checked",true);
		} else{
			$('#btnAllCheck').prop("checked",false);
		}
 	});

	//모든 체크박스 선택
	$('#btnEquipAllCheck').on('click',function(){
		if($('#btnEquipAllCheck').prop("checked")){
			$('input:checkbox[name=btnEquipCheck]').prop("checked",true);
		}else{
			$('input:checkbox[name=btnEquipCheck]').prop("checked",false);
		}
	});
	// 모든 체크박스 체크/해제 되도록
	$(document).on('change','input:checkbox[name=btnEquipCheck]', function(){
		if( $('input:checkbox[name=btnEquipCheck]').length == $('input:checkbox[name=btnEquipCheck]:checked').length ){ //전체 체크박스 수와 체크된 박스의 수가 같을 때 -> 전체체크박스 체크 , 아닐 경우 해제
			$('#btnEquipAllCheck').prop("checked",true);
		} else{
			$('#btnEquipAllCheck').prop("checked",false);
		}
 	});

	//작업방식
	//$('#prcssWorkMethodTable thead tr').clone(true).addClass('filters').appendTo('#prcssWorkMethodTable thead'); // filter 생성
	let prcssWorkMethodTable = $('#prcssWorkMethodTable').DataTable({
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
			url : '<c:url value="/bm/prcssWorkMethodListAll"/>',
			type : 'GET',
			data : {
				prcssIdx : function(){ return prcssIdx;}, 
			},
		},
        rowId: 'idx',
		columns : [
			{	data:'workYn', className : 'text-center',
				render : function(data, type, row, meta) {
					let html = '';
					if(data == 'Y'){
						html += '<input type="checkbox" name="btnPrcssMethodCheck" style="width:20px; height:20px;" checked>';
					} else {
						html += '<input type="checkbox" name="btnPrcssMethodCheck" style="width:20px; height:20px;">';
					}
					return html;
				}
			},
			{ data: 'workCd', className : 'text-center',
				render : function(data, type, row, meta) {
					let html = '';
					if(data != '' && data != null){
						html += '<input type="text" class="form-control" value="'+data+'" name="workCd" disabled>';
					} else {
						html += '<input type="text" class="form-control" value="" name="workCd">';
					}
					return html;
				}
			},
			{ data: 'workNm', className : 'text-center',
				render : function(data, type, row, meta) {
					let html = '';
					if(data != '' && data != null){
						html += '<input type="text" class="form-control" value="'+data+'" name="workNm" disabled>';
					} else {
						html += '<input type="text" class="form-control" value="" name="workNm">';
					}
					return html;
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
			/* { extend: 'colvis',	text: 'Select Col',	}, */
		],
		order : [],
		drawCallback: function() {
			let api = this.api();
			let data = api.data();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
		
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#prcssWorkMethodTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 161)+'px');
			
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
				let cell = $('#prcssWorkMethodTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#prcssWorkMethodTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	prcssWorkMethodTable.on('column-reorder', function( e, settings, details ) {
		let api = prcssWorkMethodTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#prcssWorkMethodTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	//작업방식  클릭
	$('#tab4Nav').on('click',function(){
		$('#prcssWorkMethodTable_wrapper').find('tbody').find('.selected').removeClass('selected');

		setTimeout(function(){
			prcssWorkMethodTable.ajax.reload(function(){
				prcssWorkMethodTable.draw(false);
			});
		}, 100);
		
	});

	//작업방식 추가
	$('#btnPrcssWorkMethodNew').on('click',function(){
		prcssWorkMethodTable.row.add({
			'workYn' : 'Y',
			'workCd'   : null,
			'workNm'   : null,
		}).draw(false);

		if( $('input:checkbox[name=btnPrcssMethodCheck]').length == $('input:checkbox[name=btnPrcssMethodCheck]:checked').length ){ //전체 체크박스 수와 체크된 박스의 수가 같을 때 -> 전체체크박스 체크 , 아닐 경우 해제
			$('#btnPrcssMethodAllCheck').prop("checked",true);
		} else{
			$('#btnPrcssMethodAllCheck').prop("checked",false);
		}
		$('#btnPrcssWorkMethodNew').attr('disabled',false);
		$('#btnPrcssWorkMethodSave').attr('disabled',false);
		$('#btnPrcssWorkMethodDel').attr('disabled',false);
		
		WM_action_ON('prcssWorkMethod', 'workingWarningModal');
	});

	//작업방식 저장
	$('#btnPrcssWorkMethodSave').on('click',function(){
		let status = true;
		let insertList = [];

		//추가된 데이터행이 있을 경우
		if( $('#prcssWorkMethodTable tbody tr').length - $('#prcssWorkMethodTable tbody tr').find('.dataTables_empty').length > 0 ){
			$('#prcssWorkMethodTable tbody tr').each(function(index){
				if($(this).find('input[name=workCd]').val() == undefined || $(this).find('input[name=workCd]').val() == ''
					 || $(this).find('input[name=workNm]').val() == undefined || $(this).find('input[name=workNm]').val() == ''){
					status = false;
				} else {
					let obj = {};
					obj.prcssIdx = prcssTable.row('.selected').data().idx;
					let workYn = 'N';
					if($(this).find('input[name=btnPrcssMethodCheck]').is(':checked')){
						workYn = 'Y';
					}
					obj.workYn = workYn;
					obj.workCd = $(this).find('input[name=workCd]').val();
					obj.workNm = $(this).find('input[name=workNm]').val();
					insertList.push(obj);
				}
			});
		}

		//예외처리 다 거치고 난 경우 등록
		if(status){
			$.ajax({		    	
		        url: '<c:url value="/bm/prcssWorkMethodInsert"/>',
		        type: 'POST',
	            data: {
	                'jsonArray'	:	JSON.stringify(insertList),
	                'prcssIdx'	:	prcssTable.row('.selected').data().idx,
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
		        success: function(res){
		        	if(res.result == "ok"){
		        		$('#my-spinner').hide();
		        		toastr.success('저장 되었습니다.');     
		        		WM_action_OFF('prcssWorkMethod');
		        		prcssWorkMethodTable.ajax.reload(function(){
		        			$('input[name=workCd]').attr('disabled',true);
			        		$('input[name=workNm]').attr('disabled',true);
			        	});
		        		$('#btnPrcssWorkMethodNew').attr('disabled',false);
						$('#btnPrcssWorkMethodSave').attr('disabled',true);
						$('#btnPrcssWorkMethodDel').attr('disabled',false);
		        	}
		        	else{
		        		$('#my-spinner').hide();
		        		toastr.error(result.message);
		        	}
		        	
		        }
			});	 
		} else {
			toastr.warning('작업방식코드,작업방식명을 입력해주세요.');
		}
		
	});
	
	//작업방식 삭제
	$('#btnPrcssWorkMethodDel').on('click',function(){
		if(!$('#prcssWorkMethodTable tbody tr').hasClass('selected')){
			toastr.warning('삭제할 항목을 선택해주세요.');
			return false;
		}

		let idx = prcssWorkMethodTable.row('.selected').data().idx;
		if(idx != '' && idx != undefined){
			delStatus = 'prcssWorkMethod';
			$('#deleteModal').modal('show');
		} else {
			$('#prcssWorkMethodTable').DataTable().row('.selected').remove().draw();
			if($('input:checkbox[name=btnPrcssMethodCheck]').length == 0){
				$('#btnPrcssMethodAllCheck').prop("checked",false);
			} else if( $('input:checkbox[name=btnPrcssMethodCheck]').length == $('input:checkbox[name=btnPrcssMethodCheck]:checked').length ){ //전체 체크박스 수와 체크된 박스의 수가 같을 때 -> 전체체크박스 체크 , 아닐 경우 해제
				$('#btnPrcssMethodAllCheck').prop("checked",true);
			} else{
				$('#btnPrcssMethodAllCheck').prop("checked",false);
			}
			
		}
	});
	
	//모든 체크박스 선택
	$('#btnPrcssMethodAllCheck').on('click',function(){
		if($('#btnPrcssMethodAllCheck').prop("checked")){
			$('input:checkbox[name=btnPrcssMethodCheck]').prop("checked",true);
		}else{
			$('input:checkbox[name=btnPrcssMethodCheck]').prop("checked",false);
		}
		$('#btnPrcssWorkMethodNew').attr('disabled',false);
		$('#btnPrcssWorkMethodSave').attr('disabled',false);
		$('#btnPrcssWorkMethodDel').attr('disabled',false);
	});
	
	// 모든 체크박스 체크/해제 되도록
	$(document).on('change','input:checkbox[name=btnPrcssMethodCheck]', function(){
		if( $('input:checkbox[name=btnPrcssMethodCheck]').length == $('input:checkbox[name=btnPrcssMethodCheck]:checked').length ){ //전체 체크박스 수와 체크된 박스의 수가 같을 때 -> 전체체크박스 체크 , 아닐 경우 해제
			$('#btnPrcssMethodAllCheck').prop("checked",true);
		} else{
			$('#btnPrcssMethodAllCheck').prop("checked",false);
		}
		$('#btnPrcssWorkMethodNew').attr('disabled',false);
		$('#btnPrcssWorkMethodSave').attr('disabled',false);
		$('#btnPrcssWorkMethodDel').attr('disabled',false);	
 	});

	//검사항목
	//$('#prcssInspectionMethodTable thead tr').clone(true).addClass('filters').appendTo('#prcssInspectionMethodTable thead'); // filter 생성
	let prcssInspectionMethodTable = $('#prcssInspectionMethodTable').DataTable({
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
		rowReorder: {
			enable: true,
			dataSrc: 'progressOrder',
		},
		select: {
            style: 'single',
            toggleable: false,
            items: 'row',
            info: false
        },
        ajax : {
			url : '<c:url value="/bm/prcssInspectionMethodListAll"/>',
			type : 'GET',
			data : {
				prcssIdx : function(){ return prcssIdx;}, 
			},
		},
        rowId: 'idx',
		columns : [
			{ data:'progressOrder', className : 'text-center',},
			{ data: 'inspectionList', className : 'text-center',
				render : function(data, type, row, meta) {
					let html = '';
					if(data != '' && data != null){
						html += '<input type="text" class="form-control" value="'+data+'" name="inspectionList" disabled>';
					} else {
						html += '<input type="text" class="form-control" value="" name="inspectionList">';
					}
					return html;
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
			{ "targets": '_all', "orderable": false },
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
			/* { extend: 'colvis',	text: 'Select Col',	}, */
		],
		order : [[0,'asc']],
		drawCallback: function() {
			let api = this.api();
			let data = api.data();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
		
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#prcssInspectionMethodTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 161)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			//$('#searchAll').off('keyup',function() {});
			//$('#searchAll').on('keyup',function() {
			//	$('#'+table_id+'_filter').find('input').val($(this).val());
			//	$('#'+table_id+'_filter').find('input').trigger('keyup');
			//});
			//progressOrder
			for(var i=0;i<data.length;i++) {
				let tr = $('#' + table_id + ' tbody').find('tr').eq(i);
				prcssInspectionMethodTable.row(tr).data().progressOrder = i+1;
				$(tr).find('td').eq(0).html(i+1);
			}
		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#prcssInspectionMethodTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#prcssInspectionMethodTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	prcssInspectionMethodTable.on('column-reorder', function( e, settings, details ) {
		let api = prcssInspectionMethodTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#prcssInspectionMethodTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	//검사항목  클릭
	$('#tab5Nav').on('click',function(){
		$('#prcssInspectionMethodTable_wrapper').find('tbody').find('.selected').removeClass('selected');

		setTimeout(function(){
			prcssInspectionMethodTable.ajax.reload(function(){
				prcssInspectionMethodTable.draw(false);
			});
		}, 100);
		
	});

	$('#btnInspectionMethodNew').on('click',function(){
		prcssInspectionMethodTable.row.add({
			'progressOrder' : 9999999999,
			'inspectionList'   : null,
		}).draw(false);

		$('#btnInspectionMethodNew').attr('disabled',false);
		$('#btnInspectionMethodSave').attr('disabled',false);
		$('#btnInspectionMethodEdit').attr('disabled',false);
		$('#btnInspectionMethodDel').attr('disabled',false);
		
		WM_action_ON('inspMethod', 'workingWarningModal');
	});

	//검사항목 저장
	$('#btnInspectionMethodSave').on('click',function(){
		let status = true;
		let insertList = [];

		if( $('#prcssInspectionMethodTable tbody tr').length - $('#prcssInspectionMethodTable tbody tr').find('.dataTables_empty').length > 0 ){
			$('#prcssInspectionMethodTable tbody tr').each(function(index){
				if($(this).find('input[name=inspectionList]').val() == undefined || $(this).find('input[name=inspectionList]').val() == ''){
					status = false;
				} else {
					let obj = {};
					obj.prcssIdx = prcssTable.row('.selected').data().idx;
					obj.progressOrder = prcssInspectionMethodTable.row(this).data().progressOrder;
					obj.inspectionList = $(this).find('input[name=inspectionList]').val();
					insertList.push(obj);
				}
			});
		} 

		//예외처리 다 거치고 난 경우 등록
		if(status){
			$.ajax({		    	
		        url: '<c:url value="/bm/prcssInspectionMethodInsert"/>',
		        type: 'POST',
	            data: {
	                'jsonArray'	:	JSON.stringify(insertList),
	                'prcssIdx'	:	prcssTable.row('.selected').data().idx,
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
		        success: function(res){
		        	if(res.result == "ok"){
		        		$('#my-spinner').hide();
		        		toastr.success('저장 되었습니다.');     
		        		WM_action_OFF('inspMethod');
		        		prcssInspectionMethodTable.ajax.reload(function(){
		        			$('input[name=inspectionList]').attr('disabled',true);
			        	});
		        		$('#btnInspectionMethodNew').attr('disabled',false);
		        		$('#btnInspectionMethodSave').attr('disabled',true);
		        		$('#btnInspectionMethodEdit').attr('disabled',false);
		        		$('#btnInspectionMethodDel').attr('disabled',false);
		        	}
		        	else{
		        		$('#my-spinner').hide();
		        		toastr.error(result.message);
		        	}
		        	
		        }
			});	 
		} else {
			toastr.warning('점검항목을 입력해주세요.');
		}
	});

	prcssInspectionMethodTable.on( 'row-reorder', function ( e, diff, changes ) {
		if(diff.length != 0){
			$('#btnInspectionMethodSave').attr('disabled',false);
		}
	} );

	$('#btnInspectionMethodEdit').on('click',function(){
		$('#btnInspectionMethodNew').attr('disabled',false);
		$('#btnInspectionMethodSave').attr('disabled',false);
		$('#btnInspectionMethodEdit').attr('disabled',true);
		$('#btnInspectionMethodDel').attr('disabled',false);
		$('input[name=inspectionList]').attr('disabled',false);
		WM_action_ON('inspMethod', 'workingWarningModal');
	});

	$('#btnInspectionMethodDel').on('click',function(){
		if(!$('#prcssInspectionMethodTable tbody tr').hasClass('selected')){
			toastr.warning('삭제할 항목을 선택해주세요.');
			return false;
		}

		let idx = prcssInspectionMethodTable.row('.selected').data().idx;
		if(idx != '' && idx != undefined){
			delStatus = 'inspectionMethod';
			$('#deleteModal').modal('show');
		} else {
			$('#prcssInspectionMethodTable').DataTable().row('.selected').remove().draw(false);
		}
	});
	
</script>

</body>
</html>
