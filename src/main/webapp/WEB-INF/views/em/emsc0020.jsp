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
																		  grid-template-rows: 13fr 4px 6.5fr;
																		  grid-template-columns: 2fr 4px 5fr;">
																	
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
						<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnSearch"><i class="fa-regular fa-clipboard"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnOpen"><i class="fa-solid fa-caret-left"></i></button>
					</div>
				</div>
			</div>
			<div class="row">
				<table class="table table-bordered p-0 m-0" id="equipTable">
					<thead class="table-light">
						<tr>
							<th class="text-center">설비코드</th>
							<th class="text-center">설비명</th>
							<th class="text-center">설비위치</th>
							<th class="text-center">SN</th>
							<th class="text-center">사용유무</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
	<div id="dragbarH" onmousedown="StartDrag('H')"></div>
	<div id="rightcolT">
		<div class="container-fluid h-100" style="padding: 5px;">
			<div class="row" id="rightHeader" style="padding-bottom: 5px;">
				<div class="d-flex align-items-center d-flex">
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end w-100" id ="abc">
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
			<div class="row" id="rightBody">
				<div style="width: 100%;">
					<div class="nav nav-tabs" id="nav-tab">
						<button class="nav-link active" id="tab1Nav" data-bs-toggle="tab" data-bs-target="#tab1">설비수리이력입력</button>
				  	</div>
					<div class="tab-content" id="nav-tabContent">
						<div class="tab-pane fade show active" id="tab1">
							<div class="row" style="padding: 5px;">
								<table class="table table-bordered p-0 m-0">
									<colgroup>
										<col width="11%">
										<col width="22%">
										<col width="11%">
										<col width="22%">
										<col width="11%">
										<col width="22%">
									</colgroup>
									<tr>
										<th class="text-center align-middle">설비코드</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control" id="equipCd" disabled>
										</td>
										<th class="text-center align-middle">설비명</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control" id="equipNm" disabled>
										</td>
										<th class="text-center align-middle">설치위치</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control" id="setupLocation" disabled>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle"><span style="color: #ff0000;">*</span>수리코드</th>
										<td class="text-center align-middle">
											<select class="form-select w-100 h-100 me-3 inputGroup" id="repairCd" disabled></select>
										</td>
										<th class="text-center align-middle"><span style="color: #ff0000;">*</span>수리시작일</th>
										<td class="text-center align-middle">
											<input type="date" max="9999-12-31" class="form-control inputGroup" id="repairStartDate" disabled>
										</td>
										<th class="text-center align-middle"><span style="color: #ff0000;">*</span>수리종료일</th>
										<td class="text-center align-middle">
											<input type="date" max="9999-12-31" class="form-control inputGroup" id="repairEndDate" disabled>
										</td>
									</tr>
									<tr>
										<th rowspan="3" class="text-center align-middle">수리내용</th>
										<td colspan="3" rowspan="3" class="text-center align-middle">
											<textArea rows="5" class="form-control inputGroup textarea" id="repairContent" style="max-width: 100%;max-height:100%; resize: none; min-height: 0px !important;" disabled></textArea>
										</td>
										<th class="text-center align-middle">수리비</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup text-end" id="repairCost" onkeyup="numberFormat(this,'int')" disabled>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle">부품비</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup text-end" id="partCost" onkeyup="numberFormat(this,'int')" disabled>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle">인건비</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup text-end" id="laborCost" onkeyup="numberFormat(this,'int')" disabled>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle">수리업체</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="repairCompany" disabled>
										</td>
										<th class="text-center align-middle">비고</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="repairDesc" disabled>
										</td>
										<th class="text-center align-middle">합계비</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control text-end" id="totalCost" onkeyup="numberFormat(this,'int')" disabled>
										</td>
									</tr>
								</table>
								<table class="table table-bordered p-0 m-0">
									<colgroup>
										<col width="50%">
										<col width="50%">
									</colgroup>
									<tr>
										<th class="text-center align-middle">조치 전</th>
										<th class="text-center align-middle">조치 후</th>
									</tr>
									<tr>
										<td class="text-center align-middle">
											<div class="card align-items-center p-1">
												<div class="mb-1">
													<div class="btn-group" role="group" aria-label="Small button group">
														<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnBeforeImage" disabled><i class="fa-solid fa-plus"></i></button>
														<button type="button" class="btn btn-outline-danger w-auto" style="font-size: 17px !important;" id="btnBeforeImageDel" disabled><i class="fa-solid fa-trash-can"></i></button>
													</div>
												</div>
												<img class="card-img-bottom" id="beforeImage" src=""
													 onerror="this.src='<c:url value='/resources/assets/images/temp_img/no_image_white.png?ver=1.0'/>'"
													 style="border: 1px solid #000000;height:167px;width:auto;">
												<input type="file" class="d-none" id="beforeImageFile">
											</div>
										</td>
										<td class="text-center align-middle">
											<div class="card align-items-center p-1">
												<div class="mb-1">
													<div class="btn-group" role="group" aria-label="Small button group">
														<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnAfterImage" disabled><i class="fa-solid fa-plus"></i></button>
														<button type="button" class="btn btn-outline-danger w-auto" style="font-size: 17px !important;" id="btnAfterImageDel" disabled><i class="fa-solid fa-trash-can"></i></button>
													</div>
												</div>
												<img class="card-img-bottom" id="afterImage" src=""
													 onerror="this.src='<c:url value='/resources/assets/images/temp_img/no_image_white.png?ver=1.0'/>'"
													 style="border: 1px solid #000000;height:167px;width:auto;">
												<input type="file" class="d-none" id="afterImageFile">
											</div>
										</td>
									</tr>
								</table>
							</div>
						</div>
					</div>
					
				</div>
			</div>
		</div>
	</div>
	<div id="dragbarV" onmousedown="StartDrag('V')" ondblclick="minimum(this)"></div>
	<div id="rightcolB">
		<div class="container-fluid" style="padding: 5px;">
			<div class="row">
				<div style="width: 100%;">
					<div class="nav nav-tabs" id="nav-tab2">
						<button class="nav-link active" id="tab5Nav" data-bs-toggle="tab" data-bs-target="#tab5">설비수리이력조회</button>
				  	</div>
					<div class="tab-content" id="nav-tabContent2">
						<div class="tab-pane fade show active" id="tab5">
							<div class="row" style="padding: 5px;">
								<div class="d-flex align-items-center justify-content-end w-100" style="margin-bottom:5px;">
									<input type="text" class="form-control w-auto h-100 me-1" id="searchAllErh" placeholder="통합검색" >
									<div class="btn-group" role="group" aria-label="Small button group">
										<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnSearch2"><i class="fa-regular fa-clipboard"></i></button>
									</div>									
								</div>
								<table class="table table-bordered p-0 m-0" id="equipRepairHistAdmTable">
									<%-- 
									<colgroup>
										<col width="4%">
										<col width="32%">
										<col width="32%">
										<col width="32%">
									</colgroup>
									 --%>
									<thead class="table-light">
										<tr>
											<th class="text-center">설비코드</th>
											<th class="text-center">설비명</th>
											<th class="text-center">수리시작일</th>
											<th class="text-center">수리종료일</th>
											<th class="text-center">수리내용</th>
											<th class="text-center">수리업체</th>
											<th class="text-center">합계비</th>
											<th class="text-center">비고</th>
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
		$('#page').css('grid-template-columns', '3fr 4px 5fr');
		$('#rightcol').removeClass('d-none');
		dataTableDrawAll(); // dataTable 전체 reload
	});
	$('#btnClose').on('click',function() { // right-box 닫기버튼 클릭
		$('#page').css('grid-template-columns', '1fr 4px 0fr');
		$('#rightcol').addClass('d-none');
		dataTableDrawAll(); // dataTable 전체 reload
	});
</script>

<script>
	WM_init('new');
	WM_init('edit');
	WM_init('dealNew');
	WM_init('attachDataNew');
	// 공통코드 조회
	let repairCdList  = getCommonCode('일반', '029'); //수리코드
	selectBoxAppend(repairCdList, 'repairCd', '', '2');

	let equipIdxVal = '';
	let tableChoice = 0;
	
	$('input[name="dealGubun"]').attr('disabled', true);
	
	
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
		/*
		colReorder: false,
		rowReorder: {
			enable: true,
			dataSrc: 'progressOrder',
		},
		*/
		select: {
            style: 'single',
            toggleable: false,
            items: 'row',
            info: false
        },
        ajax : {
			url : '<c:url value="/em/equipInfoListAll"/>',
			type : 'GET',
			data : {
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'equipCd', className : 'text-center'},
			{ data: 'equipNm', className : 'text-center'},
			{ data: 'setupLocation', className : 'text-center'},
			{ data: 'serialNo', className : 'text-center'},
			{ data: 'useYn', className : 'text-center',
				render : function(data, type, row, meta) {
					let status = '-';
					if(data == 'Y'){
						status = '사용';
					} else if(data == 'N') {
						status = '미사용';
					}
					return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+status+'</div>';
				}	
			},
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
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#equipTable_wrapper').find('.dataTables_scrollHead').css('height'));
			let	topHeight = parseFloat($('#rightcolT').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 79)+'px');
			
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
				let cell = $('#equipTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

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
	/*
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

	//설비 순서 변경되었을 때 
	equipTable.on( 'row-reorder', function ( e, diff, changes ) {
		if(diff.length != 0){
			$('#btnEquipOrdSave').attr('disabled',false);
		}
	});
	*/

	// 설비수리이력 목록조회
	$('#equipRepairHistAdmTable thead tr').clone(true).addClass('filters').appendTo('#equipRepairHistAdmTable thead'); // filter 생성
	let equipRepairHistAdmTable = $('#equipRepairHistAdmTable').DataTable({
		dom : "<'row'<'col-md-12 col-md-6'l><'col-md-12 col-md-6'f>>"
				+ "<'row'<'col-md-12'tr>>"
				+ "<'row pt-1'<'d-flex align-items-center d-flex'Bp><'me-lg-auto'><'d-flex align-items-center justify-content-end'i>>",
		language: lang_kor,
		info: false,
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
		/*
		colReorder: false,
		rowReorder: {
			enable: true,
			dataSrc: 'progressOrder',
		},
		select: {
            style: 'single',
            toggleable: true,
            items: 'row',
            info: false
        },
        */
        ajax : {
			url : '<c:url value="/em/equipRepairHistAdmListAll"/>',
			type : 'GET',
			data : {
				equipIdx : function() {return equipIdxVal;},
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'equipCd', className : 'text-center'},
			{ data: 'equipNm', className : 'text-center'},
			{ data: 'repairStartDate', className : 'text-center',
				render : function(data, type, row, meta) {
					return moment(data).format('YYYY-MM-DD');
				}	
			},
			{ data: 'repairEndDate', className : 'text-center',
				render : function(data, type, row, meta) {
					return moment(data).format('YYYY-MM-DD');
				}
			},
			{ data: 'repairContent', className : 'text-center',
				render : function(data, type, row, meta) {
					return data.replaceAll(/\n/g,'<br>');
				}
			},
			{ data: 'repairCompany', className : 'text-center'},
			{ className : 'text-center',
				render : function(data, type, row, meta) {
					return parseInt(row['repairCost']) + parseInt(row['partCost']) + parseInt(row['laborCost']);
				}
			},
			{ data: 'repairDesc', className : 'text-center'},
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
			/* 
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
			 */
		],
		order : [[0,'asc']],
		drawCallback: function() {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let rightcolT_height = parseFloat($('#rightcolT').height());
			let theadHeight = parseFloat($('#equipRepairHistAdmTable_wrapper').find('.dataTables_scrollHead').css('height'));
			let	topHeight = parseFloat($('#rightcolB').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - rightcolT_height - theadHeight - 99)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAllErh').off('keyup',function() {});
			$('#searchAllErh').on('keyup',function() {
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
				let cell = $('#equipRepairHistAdmTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#equipRepairHistAdmTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	equipRepairHistAdmTable.on('column-reorder', function( e, settings, details ) {
		let api = equipTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#equipRepairHistAdmTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	//설비 순서 변경되었을 때 
// 	equipRepairHistAdmTable.on( 'row-reorder', function ( e, diff, changes ) {
// 		if(diff.length != 0){
// 			$('#btnEquipOrdSave').attr('disabled',false);
// 		}
// 	});
	
	
	
	$('#equipTable tbody').on('click','tr', function() {
		tableChoice = 1;
		if(WMCheck('new')) { // 신규등록중일 경우
			setWM('new', 'idx', equipTable.row(this).data().idx);
			return false;
		}
		if(WMCheck('edit')) { // 수정중일 경우
			setWM('edit', 'idx', equipTable.row(this).data().idx);
			return false;
		}
		equipIdxVal = equipTable.row(this).data().idx;
		$('.inputGroup').val('');
		$('.inputGroup').attr('disabled', true); // 입력항목
		
		$('#btnNew').attr('disabled', false); // 신규 버튼
		$('#btnSave').attr('disabled', true); // 저장 버튼
		$('#btnEdit').attr('disabled', true); // 수정 버튼
		$('#btnDel').attr('disabled', true); // 삭제 버튼
		$('#btnCancel').attr('disabled', true); // 취소 버튼
		// 사진 초기화
		$('#beforeImage').attr('src',''); 
		$('#beforeImageFile').val('');
		$('#afterImage').attr('src',''); 
		$('#afterImageFile').val(''); 
		// 사진선택 버튼
		$('#btnBeforeImage').attr('disabled', true);
		$('#btnAfterImage').attr('disabled', true);

		// 사진삭제 버튼 
		$('#btnBeforeImageDel').attr('disabled', true);
		$('#btnAfterImageDel').attr('disabled', true);
		
		$('#equipRepairHistAdmTable').DataTable().ajax.reload( function () {
			if( $('#equipRepairHistAdmTable').DataTable().rows().count()>0 ){
				// 선택했던 항목 선택처리
				$(equipRepairHistAdmTable.row('0').node()).trigger('click');
				
				//$('#equipRepairHistAdmTable tbody tr').eq(0).addClass('selected'); 
			} else {
				$('.inputGroup').val('');
				$('#beforeImage').attr('src',''); 
				$('#beforeImageFile').val('');
				$('#afterImage').attr('src',''); 
				$('#afterImageFile').val('');
				$('#totalCost').val('');
			}
		});
		//설비 데이터 표시
		$('#equipCd').val(equipTable.row(this).data().equipCd);
		$('#equipNm').val(equipTable.row(this).data().equipNm);
		$('#setupLocation').val(equipTable.row(this).data().setupLocation);
	});

	$('#equipRepairHistAdmTable tbody').on('click','tr', function() {
		tableChoice = 2;
		if(WMCheck('new')) { // 신규등록중일 경우
			setWM('new', 'idx', equipRepairHistAdmTable.row(this).data().idx);
			return false;
		}
		if(WMCheck('edit')) { // 수정중일 경우
			setWM('edit', 'idx', equipRepairHistAdmTable.row(this).data().idx);
			return false;
		}
		$('#equipRepairHistAdmTable').DataTable().$('tr.selected').removeClass('selected');
		let idx = equipRepairHistAdmTable.row(this).data().idx;
		$(this).addClass('selected');
		let data;
		$.ajax({
			url: '<c:url value="/em/equipRepairHistAdmSel"/>',
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

					$('#btnNew').attr('disabled', false); // 신규 버튼
					$('#btnSave').attr('disabled', true); // 저장 버튼
					$('#btnEdit').attr('disabled', false); // 수정 버튼
					$('#btnDel').attr('disabled', false); // 삭제 버튼
					$('#btnCancel').attr('disabled', true); // 취소 버튼
					
					console.log(data)
					//$('#equipCd').val(data.equipCd);
					//$('#equipNm').val(data.equipNm);
					//$('#setupLocation').val(data.setupLocation);
					$('#repairCd').val(data.repairCd);
					$('#repairStartDate').val(moment(data.repairStartDate).format('YYYY-MM-DD'));
					$('#repairEndDate').val(moment(data.repairEndDate).format('YYYY-MM-DD'));
					$('#repairCost').val(addCommas(data.repairCost));
					$('#partCost').val(addCommas(data.partCost));
					$('#laborCost').val(addCommas(data.laborCost));					
					$('#totalCost').val(addCommas(parseInt(data.repairCost) + parseInt(data.partCost) + parseInt(data.laborCost)));
					$('#repairCompany').val(data.repairCompany);
					$('#repairDesc').val(data.repairDesc);
					$('#repairContent').val(data.repairContent);

					$('#beforeImage').attr('src','data:image/jpeg;base64'+data.beforeImageFile);
					$('#afterImage').attr('src','data:image/jpeg;base64'+data.afterImageFile);
					
					if( $('#totalCost').val() == 'NaN' ){
						$('#totalCost').val('0');
					}
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
		equipTable.ajax.reload(function() {});
		setTimeout(function() {
			$('#my-spinner').hide();
		}, 100)
	});

	// 조회 버튼 click
	$('#btnSearch2').on('click', function() {
		$('#my-spinner').show();
		equipRepairHistAdmTable.ajax.reload(function() {});
		setTimeout(function() {
			$('#my-spinner').hide();
		}, 100)
	});

	// 작업중 경고 모달 예 버튼 click
	$('#btnWorkingWarningModalY').on('click', function() {
		if(WMlastIdx == 'new' || WMlastIdx == 'edit') { // 등록중이거나 수정중이였을 경우
			$('#btnSave').trigger('click');
			return false;
		}
	});

	// 작업중 경고 모달 아니요 버튼 click
	$('#btnWorkingWarningModalN').on('click', function() {
		if(WMlastIdx == 'new' || WMlastIdx == 'edit') { // 등록중이거나 수정중이였을 경우
			if(getWM(WMlastIdx, 'idx') != '' && getWM(WMlastIdx, 'idx') != undefined) {
				let idx = getWM(WMlastIdx, 'idx');
				WM_action_OFF(WMlastIdx);
				setWM(WMlastIdx, 'idx', '');
				console.log('tableChoice : ' + tableChoice)
				if(tableChoice==1) {
					console.log("idx : " + idx)
					equipTable.row('#'+idx).select();
					$(equipTable.row('#'+idx).node()).trigger('click'); // 선택했던 항목 선택처리
				} else {
					equipRepairHistAdmTable.row('#'+idx).select();
					$(equipRepairHistAdmTable.row('#'+idx).node()).trigger('click'); // 선택했던 항목 선택처리
				}
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

				// 사진선택 버튼
				$('#btnBeforeImage').attr('disabled', true);
				$('#btnAfterImage').attr('disabled', true);

				// 사진삭제 버튼 
				$('#btnBeforeImageDel').attr('disabled', true);
				$('#btnAfterImageDel').attr('disabled', true);
			}
			
			return false;
		}
	});

	// 신규 버튼 click
	$('#btnNew').on('click', function() {

		if(equipIdxVal=='') {
			toastr.warning('설비를 선택해 주세요.');
			return false;
		}
		
		$('#btnSave').data('saveType','insert'); // 저장 방식 -> 등록
		
		WM_action_ON('new', 'workingWarningModal');

		$('.inputGroup').val('');

		$('.inputGroup').attr('disabled', false); // 입력항목
		
		$('#btnNew').attr('disabled', true); // 신규 버튼
		$('#btnSave').attr('disabled', false); // 저장 버튼
		$('#btnEdit').attr('disabled', true); // 수정 버튼
		$('#btnDel').attr('disabled', true); // 삭제 버튼
		$('#btnCancel').attr('disabled', false); // 취소 버튼
		// 사진 초기화
		$('#beforeImage').attr('src',''); 
		$('#beforeImageFile').val('');
		$('#afterImage').attr('src',''); 
		$('#afterImageFile').val(''); 

		// 사진선택 버튼
		$('#btnBeforeImage').attr('disabled', false);
		$('#btnAfterImage').attr('disabled', false);

		// 사진삭제 버튼 
		$('#btnBeforeImageDel').attr('disabled', false);
		$('#btnAfterImageDel').attr('disabled', false);
		
		//비용 초기화
		$('#repairCost').val('0');
		$('#partCost').val('0');
		$('#laborCost').val('0');
		$('#totalCost').val('0');
		$('#repairStartDate').val(moment().format('YYYY-MM-DD'));
		$('#repairEndDate').val(moment().format('YYYY-MM-DD'))

		$('#equipRepairHistAdmTable tbody tr').removeClass('selected');
	});

	// 사진선택 버튼 click
	$('#btnBeforeImage').on('click', function() {
		$('#beforeImageFile').trigger('click');
	});
	$('#btnAfterImage').on('click', function() {
		$('#afterImageFile').trigger('click');
	});

	// 사진삭제 버튼 click
	$('#btnBeforeImageDel').on('click', function() {
		$('#beforeImage').attr('src','');
		$('#beforeImageFile').val('');
	});
	$('#btnAfterImageDel').on('click', function() {
		$('#afterImage').attr('src','');
		$('#afterImageFile').val('');
	});

	// 파일 선택
	$('#beforeImageFile').on('change',function(e) {
		let formData = new FormData();
		let fileInput = document.getElementById("beforeImageFile"); //id로 파일 태그를 호출
		let files = fileInput.files; //업로드한 파일들의 정보를 넣는다.
		let fileType = files[0].type;
		if(fileType.split('/')[0] != 'image') {
			toastr.warning('사진파일을 선택해주세요.');
			return false;
		}
		let bases64 = getImgBase64(files[0]);
		$('#beforeImage').attr('src','data:image/jpeg;base64,'+bases64);
	})
	
	$('#afterImageFile').on('change',function(e) {
		let formData = new FormData();
		let fileInput = document.getElementById("afterImageFile"); //id로 파일 태그를 호출
		let files = fileInput.files; //업로드한 파일들의 정보를 넣는다.
		let fileType = files[0].type;
		if(fileType.split('/')[0] != 'image') {
			toastr.warning('사진파일을 선택해주세요.');
			return false;
		}
		let bases64 = getImgBase64(files[0]);
		$('#afterImage').attr('src','data:image/jpeg;base64,'+bases64);
	})

	// 저장 버튼 click
	$('#btnSave').on('click', function() {
		let saveType = $(this).data('saveType');

		if($('#repairCd').val() == '') {
			toastr.warning('수리코드를 입력해주세요.');
			$('#repairCd').focus();
			return false;
		}

		if($('#repairStartDate').val() == '') {
			toastr.warning('수리시작일을 입력해주세요.');
			$('#repairStartDate').focus();
			return false;
		}

		if($('#repairEndDate').val() == '') {
			toastr.warning('수리종료일을 입력해주세요.');
			$('#repairEndDate').focus();
			return false;
		}

		let beforeImageFile = '';
		beforeImageFile = $('#beforeImage').attr('src');
		beforeImageFile = beforeImageFile.replaceAll('data:image/jpeg;base64','');

		let afterImageFile = '';
		afterImageFile = $('#afterImage').attr('src');
		afterImageFile = afterImageFile.replaceAll('data:image/jpeg;base64','');

		
		// 등록할 경우에
		if(saveType == 'insert') {	
			$.ajax({
				url: '<c:url value="/em/equipRepairHistAdmInsert"/>',
	            type: 'POST',
	            //async: false,
	            data: {
	            	'equipIdx'			:	equipIdxVal,
		            'repairCd'			:	$('#repairCd').val(),
		            'repairStartDate'	:	(moment($('#repairStartDate').val()).format('YYYYMMDD')),
		            'repairEndDate'		:	(moment($('#repairEndDate').val()).format('YYYYMMDD')),
		            'repairContent'		:	$('#repairContent').val(),
		            'repairCompany'		:	$('#repairCompany').val(),
		            'repairCost'		:	$('#repairCost').val().replaceAll(',',''),
		            'partCost'			:	$('#partCost').val().replaceAll(',',''),
		            'laborCost'			:	$('#laborCost').val().replaceAll(',',''),
		            'repairDesc'		:	$('#repairDesc').val(),
		            'beforeImageFile'	:	beforeImageFile,
		            'afterImageFile'	:	afterImageFile,
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if (res.result == "ok") { //응답결과
						toastr.success('신규 저장되었습니다.');

						$('#btnSearch2').trigger('click'); // 조회버튼 click

						WM_action_OFF('new');
						// 사진선택 버튼
						$('#btnBeforeImage').attr('disabled', true);
						$('#btnAfterImage').attr('disabled', true);

						// 사진삭제 버튼 
						$('#btnBeforeImageDel').attr('disabled', true);
						$('#btnAfterImageDel').attr('disabled', true); 
						
						$('.inputGroup').attr('disabled', true); // 입력항목
						
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
			let idx = equipRepairHistAdmTable.row('.selected').data().idx;
			$.ajax({
				url: '<c:url value="/em/equipRepairHistAdmUpdate"/>',
	            type: 'POST',
	            //async: false,
	            data: {
		            'idx'				:	function(){ return idx; },
		            'equipIdx'			:	equipIdxVal,
		            'repairCd'			:	$('#repairCd').val(),
		            'repairStartDate'	:	(moment($('#repairStartDate').val()).format('YYYYMMDD')),
		            'repairEndDate'		:	(moment($('#repairEndDate').val()).format('YYYYMMDD')),
		            'repairContent'		:	$('#repairContent').val(),
		            'repairCompany'		:	$('#repairCompany').val(),
		            'repairCost'		:	$('#repairCost').val().replaceAll(',',''),
		            'partCost'			:	$('#partCost').val().replaceAll(',',''),
		            'laborCost'			:	$('#laborCost').val().replaceAll(',',''),
		            'repairDesc'		:	$('#repairDesc').val(),
		            'beforeImageFile'	:	beforeImageFile,
		            'afterImageFile'	:	afterImageFile,
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if (res.result == "ok") { //응답결과
						toastr.success('수정 저장되었습니다.');

						$('#btnSearch2').trigger('click'); // 조회버튼 click

						WM_action_OFF('edit');

						// 사진선택 버튼
						$('#btnBeforeImage').attr('disabled', true);
						$('#btnAfterImage').attr('disabled', true);

						// 사진삭제 버튼 
						$('#btnBeforeImageDel').attr('disabled', true);
						$('#btnAfterImageDel').attr('disabled', true);
						
						$('.inputGroup').attr('disabled', true); // 입력항목
						
						$('#btnNew').attr('disabled', false); // 신규 버튼
						$('#btnSave').attr('disabled', true); // 저장 버튼
						$('#btnEdit').attr('disabled', true); // 수정 버튼
						$('#btnDel').attr('disabled', true); // 삭제 버튼
						$('#btnCancel').attr('disabled', true); // 취소 버튼

						let idx = equipRepairHistAdmTable.row('.selected').data().idx;
						equipRepairHistAdmTable.row('#'+idx).select();
						$(equipRepairHistAdmTable.row('#'+idx).node()).trigger('click'); // 선택했던 항목 선택처리
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
		
		$('#btnNew').attr('disabled', true); // 신규 버튼
		$('#btnSave').attr('disabled', false); // 저장 버튼
		$('#btnEdit').attr('disabled', true); // 수정 버튼
		$('#btnDel').attr('disabled', true); // 삭제 버튼
		$('#btnCancel').attr('disabled', false); // 취소 버튼

		// 사진선택 버튼
		$('#btnBeforeImage').attr('disabled', false);
		$('#btnAfterImage').attr('disabled', false);

		// 사진삭제 버튼 
		$('#btnBeforeImageDel').attr('disabled', false);
		$('#btnAfterImageDel').attr('disabled', false);
	});

	// 삭제 버튼 click
	$('#btnDel').on('click', function() {
		$('#deleteModal').modal('show');
	});

	// 삭제 경고창 삭제 버튼 click
	$('#btnDeleteModalY').on('click', function() {
		let idx = equipRepairHistAdmTable.row('.selected').data().idx;
		$.ajax({
			url: '<c:url value="/em/equipRepairHistAdmDelete"/>',
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
					$('#btnEdit').attr('disabled', true); // 수정 버튼
					$('#btnDel').attr('disabled', true); // 삭제 버튼
					equipRepairHistAdmTable.ajax.reload();
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
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
		
		$('#btnNew').attr('disabled', false); // 신규 버튼
		$('#btnSave').attr('disabled', true); // 저장 버튼
		$('#btnEdit').attr('disabled', true); // 수정 버튼
		$('#btnDel').attr('disabled', true); // 삭제 버튼
		$('#btnCancel').attr('disabled', true); // 취소 버튼

		//재조회
		let idx = equipRepairHistAdmTable.row('.selected').data().idx;
		let data;
		$.ajax({
			url: '<c:url value="/em/equipRepairHistAdmSel"/>',
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

					$('#btnNew').attr('disabled', false); // 신규 버튼
					$('#btnSave').attr('disabled', true); // 저장 버튼
					$('#btnEdit').attr('disabled', false); // 수정 버튼
					$('#btnDel').attr('disabled', false); // 삭제 버튼
					$('#btnCancel').attr('disabled', true); // 취소 버튼

					// 사진선택 버튼
					$('#btnBeforeImage').attr('disabled', true);
					$('#btnAfterImage').attr('disabled', true);

					// 사진삭제 버튼 
					$('#btnBeforeImageDel').attr('disabled', true);
					$('#btnAfterImageDel').attr('disabled', true);
					
					console.log(data)
					//$('#equipCd').val(data.equipCd);
					//$('#equipNm').val(data.equipNm);
					//$('#setupLocation').val(data.setupLocation);
					$('#repairCd').val(data.repairCd);
					$('#repairStartDate').val(moment(data.repairStartDate).format('YYYY-MM-DD'));
					$('#repairEndDate').val(moment(data.repairEndDate).format('YYYY-MM-DD'));
					$('#repairCost').val(addCommas(data.repairCost));
					$('#partCost').val(addCommas(data.partCost));
					$('#laborCost').val(addCommas(data.laborCost));					
					$('#totalCost').val(addCommas(parseInt(data.repairCost) + parseInt(data.partCost) + parseInt(data.laborCost)));
					$('#repairCompany').val(data.repairCompany);
					$('#repairDesc').val(data.repairDesc);
					$('#repairContent').val(data.repairContent);

					$('#beforeImage').attr('src','data:image/jpeg;base64'+data.beforeImageFile);
					$('#afterImage').attr('src','data:image/jpeg;base64'+data.afterImageFile);
					
					if( $('#totalCost').val() == 'NaN' ){
						$('#totalCost').val('0');
					}
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();				
			}
		});
		
	});


	$(document).on('keyup',"#repairCost, #partCost, #laborCost",function(evt) {  //인원입력시 콤마 추가
		let repairCostData= $('#repairCost').val().replace(/,/g, '');
		let partCostData= $('#partCost').val().replace(/,/g, '');
		let laborCostData= $('#laborCost').val().replace(/,/g, '');

		var totalCostData = parseInt(repairCostData) + parseInt(partCostData) + parseInt(laborCostData);
		$('#totalCost').val(addCommas(totalCostData));

    });
	
</script>
</body>
</html>
