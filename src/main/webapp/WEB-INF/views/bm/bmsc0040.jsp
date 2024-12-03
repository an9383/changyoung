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
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">사용여부</label>
					<select class="form-select w-auto h-100 me-3" id="searchUseYn">
						<option value="" selected>전체</option>
						<option value="Y">사용</option>
						<option value="N">미사용</option>
					</select>
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
				<table class="table table-bordered p-0 m-0" id="woodenInfoAdmTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle">소모품구분</th>
							<th class="text-center align-middle">구분코드</th>
							<th class="text-center align-middle">코드</th>
							<th class="text-center align-middle">사이즈</th>
							<th class="text-center align-middle">사용여부</th>
							<th class="text-center align-middle">코팅방법</th>
							<th class="text-center align-middle">후가공</th>
							<th class="text-center align-middle">후가공호기</th>
							<th class="text-center align-middle">성형방식</th>
							<th class="text-center align-middle">성형내용</th>
							<th class="text-center align-middle">묶음법</th>
							<th class="text-center align-middle">묶음단위</th>
							<th class="text-center align-middle">포장단위</th>
							<th class="text-center align-middle">포장박스</th>
							<th class="text-center align-middle">사용종료예정일</th>
							<th class="text-center align-middle">입고일</th>
							<th class="text-center align-middle">호기</th>
							<th class="text-center align-middle">기본통수</th>
							<th class="text-center align-middle">기존통수</th>
							<th class="text-center align-middle">사용통수</th>
							<th class="text-center align-middle">잔여통수</th>
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
						<button class="nav-link active" id="tab1Nav" data-bs-toggle="tab" data-bs-target="#tab1">기본정보</button>
						<button class="nav-link" id="tab2Nav" data-bs-toggle="tab" data-bs-target="#tab2">사용이력</button>
				  	</div>
					<div class="tab-content" id="nav-tabContent">
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
										<th class="text-center align-middle"><span style="color:#ff0000;">*</span>소모품구분</th>
										<td class="text-center align-middle">
											<select class="form-select w-100 h-100 me-3 inputGroup" id="expendGubun" disabled></select>
										</td>
										<th class="text-center align-middle"><span style="color:#ff0000;">*</span>구분코드</th>
										<td class="text-center align-middle">
											<select class="form-select w-100 h-100 me-3 inputGroup" id="wdGubun" disabled></select>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle"><span style="color:#ff0000;">*</span>코드</th>
										<td class="text-center align-middle" colspan='3' >
											<input type="text" class="form-control inputGroup" id="wdCd" disabled>
										</td>
									</tr>
									<!-- <tr>
										<th class="text-center align-middle"><span style="color:#ff0000;">*</span>명칭</th>
										<td class="text-center align-middle" colspan='3' >
											<input type="text" class="form-control inputGroup" id="wdNm" disabled>
										</td>
									</tr> -->
									<tr>
										<th class="text-center align-middle" style="background-color: rgb(192, 229, 249) !important;">사이즈</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="wdSize" disabled>
										</td>
										<th class="text-center align-middle" style="background-color: rgb(255, 248, 207) !important;">코팅방법</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="coating" disabled>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle" style="background-color: rgb(192, 229, 249) !important;">성형방식</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="moldingContents" disabled>
										</td>
										<th class="text-center align-middle" style="background-color: rgb(255, 248, 207) !important;">호기</th>
										<td class="text-center align-middle">
											<select class="form-select inputGroup" id="wdUnit" disabled></select>
									</tr>
									<tr>
										<th class="text-center align-middle" style="background-color: rgb(192, 229, 249) !important;">성형내용</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="moldingContentsReal" disabled>
										</td>
										<th class="text-center align-middle">후가공</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="afterProcessing" disabled>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle" style="background-color: rgb(192, 229, 249) !important;">묶음법</th>
										<td class="text-center align-middle">
											<select class="form-select inputGroup" id="bundleMethod" disabled></select>
										</td>
										<th class="text-center align-middle" style="background-color: rgb(192, 229, 249) !important;">묶음단위</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="bundleUnit" disabled>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle" style="background-color: rgb(192, 229, 249) !important;">포장단위</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="packUnit" disabled>
										</td>
										<th class="text-center align-middle" style="background-color: rgb(192, 229, 249) !important;">포장박스</th>
										<td class="text-center align-middle">
											<select class="form-select inputGroup" id="packMethod" disabled></select>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle"><span style="color:#ff0000;">*</span>사용여부</th>
										<td class="text-center align-middle">
											<select class="form-select w-100 h-100 me-3 inputGroup" id="useYn" disabled>
												<option value="Y" selected>사용</option>
												<option value="N">미사용</option>
											</select>
										</td>
										<th class="text-center align-middle">후가공호기</th>
										<td class="text-center align-middle">
											<select class="form-select inputGroup" id="afterProcessingWdUnit" disabled></select>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle"><span style="color:#ff0000;">*</span>기본통수</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control text-end inputGroup" id="baseHitQty" onkeyup="numberFormat(this, 'int')" disabled>
										</td>
										<th class="text-center align-middle"><span style="color:#ff0000;">*</span>기존통수</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control text-end inputGroup" id="initHitQty" onkeyup="numberFormat(this, 'int')" disabled>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle">사용통수</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control text-end" id="useHitQty" disabled>
										</td>
										<th class="text-center align-middle">잔여통수</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control text-end" id="remainHitQty" disabled>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle">사용종료예정일</th>
										<td class="text-center align-middle">
											<input type="date" max="9999-12-31" class="form-control inputGroup" id="exEndDate" disabled>
										</td>
										<th class="text-center align-middle"><span style="color:#ff0000;">*</span>입고일</th>
										<td class="text-center align-middle">
											<input type="date" max="9999-12-31" class="form-control inputGroup" id="inputDate" disabled>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle">위치</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="location" disabled>
										</td>
										<th class="text-center align-middle">비고</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="wdDesc" disabled>
										</td>
									</tr>
									
								</table>
							</div>
						</div>
						<div class="tab-pane fade" id="tab2">
							<div class="row" style="padding: 5px;">
								<div class="d-flex align-items-center justify-content-end w-100 my-1">
									<input type="text" class="form-control w-auto h-100 me-1" id="searchAllWil" placeholder="통합검색" >
								</div>
								<table class="table table-bordered p-0 m-0" id="woodenInfoLogTable">
									<thead class="table-light">
										<tr>
											<th class="text-center align-middle">수주번호</th>
											<th class="text-center align-middle">사용통수</th>
											<th class="text-center align-middle">등록자</th>
											<th class="text-center align-middle">등록일자</th>
											<!-- <th class="text-center align-middle">구분코드</th>
											<th class="text-center align-middle">기본통수</th>
											<th class="text-center align-middle">등록시 누적통수</th>
											<th class="text-center align-middle">비고</th>
											<th class="text-center align-middle">등록자</th>
											<th class="text-center align-middle">등록일자</th>
											<th class="text-center align-middle">관리</th> -->
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

	let idxVal = '';

	// 공통코드 조회
	let expendGubunList = getCommonCode('일반', '025'); // 소모품구분
	let wdGubunList = getCommonCode('일반', '010'); // 목형구분
	let wdUnitList = getCommonCode('일반', '037'); // 호기
	let packMethodList = getCommonCode('일반', '013'); // 포장방법
	let bundleList = getCommonCode('일반', '005'); // 묶음법
	
	selectBoxAppend(expendGubunList, 'expendGubun', '', '1');
	selectBoxAppend(wdGubunList, 'wdGubun', '', '1');
	selectBoxAppend(wdUnitList, 'wdUnit', '', '2');
	selectBoxAppend(wdUnitList, 'afterProcessingWdUnit', '', '2');
	selectBoxAppend(packMethodList, 'packMethod', '', '2'); //포장방법
	selectBoxAppend(bundleList, 'bundleMethod', '', '2'); //묶음법

	// 목형정보관리 기본정보 목록조회
	$('#woodenInfoAdmTable thead tr').clone(true).addClass('filters').appendTo('#woodenInfoAdmTable thead'); // filter 생성
	let woodenInfoAdmTable = $('#woodenInfoAdmTable').DataTable({
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
		pageLength: -1,
		colReorder: true,
		select: {
            style: 'single',
            toggleable: false,
            items: 'row',
            info: false
        },
        ajax : {
			url : '<c:url value="/bm/woodenInfoAdmLst"/>',
			type : 'POST',
			data : {
				useYn: function() { return $('#searchUseYn').val(); }
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'expendGubunNm', className : 'text-center align-middle'},
			{ data: 'wdGubunNm', className : 'text-center align-middle'},
			{ data: 'wdCd', className : 'text-center align-middle'},
			{ data: 'wdSize', className : 'text-center align-middle'},//사이즈
			{ data: 'useYn', className : 'text-center align-middle',//사용여부
				render : function(data, type, row, meta) {
					if(data == 'Y') {
						return '사용';
					} else {
						return '미사용';
					}
				}
			},
			{ data: 'coating', className : 'text-center align-middle'},//코팅방법
			{ data: 'afterProcessing', className : 'text-center align-middle'},//후가공
			{ data: 'afterProcessingWdUnitNm', className : 'text-center align-middle'},//후가공호기
			{ data: 'moldingContents', className : 'text-center align-middle'},//성형방식
			{ data: 'moldingContentsReal', className : 'text-center align-middle'},//성형내용
			{ data: 'bundleMethodNm', className : 'text-center align-middle'},//묶음법
			{ data: 'bundleUnit', className : 'text-center align-middle'},//묶음단위 
			{ data: 'packUnit', className : 'text-center align-middle'},//포장단위
			{ data: 'packMethodNm', className : 'text-center align-middle'},//포장박스
			{ data: 'exEndDate', className : 'text-center align-middle',//사용종료예정일
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return '<div style="white-space:nowrap;">'+moment(data).format('YYYY-MM-DD')+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ data: 'inputDate', className : 'text-center align-middle',//입고일
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return '<div style="white-space:nowrap;">'+moment(data).format('YYYY-MM-DD')+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ data: 'wdUnitNm', className : 'text-center align-middle'},//호기
			{ data: 'baseHitQty', className : 'text-center align-middle',//기본통수
				render : function(data){
					if(data!=null){
						return addCommas(parseInt(data));
					}
				}
			},
			{ data: 'initHitQty', className : 'text-center align-middle',//기존통수
				render : function(data){
					if(data!=null){
						return addCommas(parseInt(data));
					}
				}
			},
			{ data: 'useHitQty', className : 'text-center align-middle',//사용통수
				render : function(data){
					if(data!=null){
						return addCommas(parseInt(data));
					}
				}
			},
			{ className : 'text-center align-middle',//잔여통수
				render : function(data, type, row, meta){
					if(row['baseHitQty']!=null&&row['initHitQty']!=null&&row['useHitQty']!=null){
						return addCommas(parseInt(row['baseHitQty'])-parseInt(row['initHitQty'])-parseInt(row['useHitQty']));
					} else {
						return '0';
					}
				}
			},
			
		],
		columnDefs : [
			{
				targets: [0,1,2,3,4,5,6,7,8,9,10],
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
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
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#woodenInfoAdmTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 79)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAll').off('keyup',function() {});
			$('#searchAll').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			});

			let node = api.rows().nodes();

			if(api.data().length>0){
				$(node).each(function(index, item){
					let data = woodenInfoAdmTable.row(item).data();
					if(data.baseHitQty!=null&&data.initHitQty!=null&&data.useHitQty!=null){
						if(parseInt(data.baseHitQty)-parseInt(data.initHitQty)-parseInt(data.useHitQty)<0){
							$(this).css('background-color', '#ffb4b4')
						}
					}
				})
			}
		},
		initComplete: function () {
			let api = this.api();
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#woodenInfoAdmTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#woodenInfoAdmTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	woodenInfoAdmTable.on('column-reorder', function( e, settings, details ) {
		let api = woodenInfoAdmTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#woodenInfoAdmTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
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
		woodenInfoAdmTable.ajax.reload(function() {});
		

		setTimeout(function() {
			$('#my-spinner').hide();
		}, 100)
	});

	// 목형목록 click
	$('#woodenInfoAdmTable tbody').on('click','tr', function() {
		let idx = woodenInfoAdmTable.row(this).data().idx;
		
		if(WMCheck('new')) { // 신규등록중일 경우
			setWM('new', 'idx', idx);
			return false;
		}
		if(WMCheck('edit')) { // 수정중일 경우
			setWM('edit', 'idx', idx);
			return false;
		}

		idxVal = idx;
		
		let data = woodenInfoAdmSel(idx);

		$('#expendGubun').val(data.expendGubun);
		$('#wdGubun').val(data.wdGubun);
		$('#wdCd').val(data.wdCd);
		//$('#wdNm').val(data.wdNm);
		$('#wdSize').val(data.wdSize);
		$('#useYn').val(data.useYn);
		$('#coating').val(data.coating);
		$('#moldingContents').val(data.moldingContents);
		$('#exEndDate').val(moment(data.exEndDate,'YYYYMMDD').format('YYYY-MM-DD'));
		$('#inputDate').val(moment(data.inputDate,'YYYYMMDD').format('YYYY-MM-DD'));
		$('#location').val(data.location);
		$('#wdDesc').val(data.wdDesc);
		$('#moldingContentsReal').val(data.moldingContentsReal);
		$('#afterProcessing').val(data.afterProcessing);
		$('#afterProcessingWdUnit').val(data.afterProcessingWdUnit);
		$('#bundleMethod').val(data.bundleMethod);
		$('#bundleUnit').val(data.bundleUnit);
		$('#packUnit').val(data.packUnit);
		$('#packMethod').val(data.packMethod);
		

		
		let baseHitQty = parseInt(data.baseHitQty); // 기본통수
		let initHitQty = parseInt(data.initHitQty); // 기존통수
		let useHitQty = 0; // 사용통수
		let remainHitQty = baseHitQty - initHitQty - useHitQty; // 잔여통수
		$('#baseHitQty').val(addCommas(baseHitQty));
		$('#initHitQty').val(addCommas(initHitQty));
		$('#useHitQty').val(addCommas(useHitQty));
		$('#remainHitQty').val(addCommas(remainHitQty));

		$('#wdUnit').val(data.wdUnit);
		
		$('.inputGroup').attr('disabled', true); // 입력항목

		$('#btnNew').attr('disabled', false); // 신규 버튼
		$('#btnSave').attr('disabled', true); // 저장 버튼
		$('#btnEdit').attr('disabled', false); // 수정 버튼
		$('#btnDel').attr('disabled', false); // 삭제 버튼
		$('#btnCancel').attr('disabled', true); // 취소 버튼

		woodenInfoLogTable.ajax.reload(function() {});
	});

	// 작업중 경고 모달 예 버튼 click
	$('#btnWorkingWarningModalY').on('click', function() {
		if(WMlastIdx == 'new' || WMlastIdx == 'edit') { // 등록중이거나 수정중이였을 경우
			$('#btnSave').trigger('click');
			if(WMlastIdx == 'new' || WMlastIdx == 'edit') { // 등록중이거나 수정중이였을 경우
				if(getWM(WMlastIdx, 'idx') != '' && getWM(WMlastIdx, 'idx') != undefined) {
					let idx = getWM(WMlastIdx, 'idx');
					WM_action_OFF(WMlastIdx);
					setWM(WMlastIdx, 'idx', '');
					woodenInfoAdmTable.row('#'+idx).select();
					$(woodenInfoAdmTable.row('#'+idx).node()).trigger('click'); // 선택했던 항목 선택처리
				}
			}
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
				woodenInfoAdmTable.row('#'+idx).select();
				$(woodenInfoAdmTable.row('#'+idx).node()).trigger('click'); // 선택했던 항목 선택처리
			} else {
				WM_action_OFF(WMlastIdx);
				if(window.location != window.parent.location) { // tab일 경우
					// 부모 탭 닫기버튼 click
					$('#tab-list', parent.document).find('.active').find('span').eq(1).find('i').trigger('click');
			    }
				
				$('.inputGroup').attr('disabled', true); // 입력항목
				
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

		$('.inputGroup').val('');
		$('#wdGubun').val('02'); // 구분코드
		$('#useYn').val('Y'); // 사용여부
		$('#inputDate').val(moment().format('YYYY-MM-DD')); // 입고일
		$('#initHitQty').val('0'); // 기존통수
		$('#useHitQty').val('0'); // 사용통수
		$('#remainHitQty').val('0'); // 잔여통수
		
		$('.inputGroup').attr('disabled', false); // 입력항목
		
		$('#btnNew').attr('disabled', true); // 신규 버튼
		$('#btnSave').attr('disabled', false); // 저장 버튼
		$('#btnEdit').attr('disabled', true); // 수정 버튼
		$('#btnDel').attr('disabled', true); // 삭제 버튼
		$('#btnCancel').attr('disabled', false); // 취소 버튼

		woodenInfoLogTable.clear().draw();
	});

	// 저장 버튼 click
	$('#btnSave').on('click', function() {
		let saveType = $(this).data('saveType');

		if($('#expendGubun').val() == '') {
			toastr.warning('소모품구분을 선택해주세요.');
			$('#expendGubun').focus();
			return false;
		}
		if($('#wdGubun').val() == '') {
			toastr.warning('구분코드를 선택해주세요.');
			$('#wdGubun').focus();
			return false;
		}
		if($('#wdCd').val() == '') {
			toastr.warning('목형코드를 입력해주세요.');
			$('#wdCd').select();
			return false;
		}
		/* if($('#wdNm').val() == '') {
			toastr.warning('목형명을 입력해주세요.');
			$('#wdNm').select();
			return false;
		} */
		/* if($('#wdSize').val() == '') {
			toastr.warning('목형사이즈를 입력해주세요.');
			$('#wdSize').select();
			return false;
		} */
		if($('#inputDate').val() == '') {
			toastr.warning('입고일자를 선택해주세요.');
			$('#inputDate').select();
			return false;
		}
		if($('#baseHitQty').val() == '') {
			toastr.warning('기본통수를 입력해주세요.');
			$('#baseHitQty').select();
			return false;
		}
		if($('#initHitQty').val() == '') {
			toastr.warning('기존통수를 입력해주세요.');
			$('#initHitQty').select();
			return false;
		}

		let data = woodenInfoAdmSel(idxVal);

		let baseHitQty = parseInt($('#baseHitQty').val().replaceAll(/,/g,''));
		let initHitQty = parseInt($('#initHitQty').val().replaceAll(/,/g,''));
		//신규일 경우 검색해온 데이터가 없기에 사용 통수를 0으로 세팅
		let useHitQty = data != null ? parseInt(data.useHitQty) : 0;//parseInt(data.useHitQty);
		let calHitQty = initHitQty + useHitQty;
		let remainHitQty = baseHitQty - calHitQty;

		let url = '';
		if(saveType == 'insert') {
			url = '/bm/woodenInfoAdmIns';
		} else if(saveType == 'update'){
			url = '/bm/woodenInfoAdmUpd';
		}
		$.ajax({
			url: url,
            type: 'POST',
            data: {
            	'idx'					:	idxVal,
            	'expendGubun'			:	$('#expendGubun').val(),
            	'wdGubun'				:	$('#wdGubun').val(),
            	'wdCd'					:	$('#wdCd').val(),
            	'wdSize'				:	$('#wdSize').val(),
            	'useYn'					:	$('#useYn').val(),
            	'coating'				:	$('#coating').val(),
            	'moldingContents'		:	$('#moldingContents').val(),
            	'exEndDate'				:	($('#exEndDate').val()==''?'':moment($('#exEndDate').val()).format('YYYYMMDD')),
            	'location'				:	$('#location').val(),
            	'inputDate'				:	($('#inputDate').val()==''?'':moment($('#inputDate').val()).format('YYYYMMDD')),
            	'baseHitQty'			:	baseHitQty,
            	'initHitQty'			:	initHitQty,
            	'useHitQty'				:	useHitQty,
            	'calHitQty'				:	calHitQty,
            	'remainHitQty'			:	remainHitQty,
            	'wdDesc'				:	$('#wdDesc').val(),
            	'wdUnit'				:	$('#wdUnit').val(),
            	'moldingContentsReal'	:	$('#moldingContentsReal').val(),
            	'afterProcessing'		:	$('#afterProcessing').val(),
            	'afterProcessingWdUnit' :	$('#afterProcessingWdUnit').val(),
            	'bundleMethod'			:	$('#bundleMethod').val(),
            	'bundleUnit'			:	$('#bundleUnit').val(),
            	'packUnit'				:	$('#packUnit').val(),
            	'packMethod'			:	$('#packMethod').val(),			
            	
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					if(saveType == 'insert') {
						toastr.success('신규 저장되었습니다.');
						WM_action_OFF('new');
					} else if(saveType == 'update'){
						toastr.success('수정 저장되었습니다.');
						WM_action_OFF('edit');
					}

					$('#btnSearch').trigger('click'); // 조회버튼 click
					
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
	});

	// 삭제 버튼 click
	$('#btnDel').on('click', function() {
		if(!$('#woodenInfoAdmTable tbody tr').hasClass('selected')){
			toastr.warning('삭제할 행을 선택해주세요.');
			return false;
		}
		
		$('#deleteModal').modal('show').data('type','adm');
	});

	// 삭제 경고창 삭제 버튼 click
	$('#btnDeleteModalY').on('click', function() {
		let type = $('#deleteModal').data('type');
		if(type == 'adm') {
			let idx = woodenInfoAdmTable.row('.selected').data().idx;
			$.ajax({
				url: '<c:url value="/bm/woodenInfoAdmDel"/>',
	            type: 'POST',
	            async: false,
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
						
						$('.inputGroup').val('');
						
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
		} else if(type == 'log'){
			let idx = woodenInfoLogTable.row('.selected').data().idx;
			let wdIdx = idxVal;
			$.ajax({
				url: '<c:url value="/bm/woodenInfoLogDel"/>',
	            type: 'POST',
	            async: false,
	            data: {
	                'idx'		:	idx,
	                'wdIdx'		:	wdIdx
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if (res.result == "ok") { //응답결과
						toastr.success('삭제되었습니다.');

						$('#btnSearch').trigger('click'); // 조회버튼 click

						$(woodenInfoAdmTable.row('.selected').node()).trigger('click');

						woodenInfoLogTable.ajax.reload(function() {});
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
		
		$('#btnNew').attr('disabled', false); // 신규 버튼
		$('#btnSave').attr('disabled', true); // 저장 버튼
		$('#btnEdit').attr('disabled', true); // 수정 버튼
		$('#btnDel').attr('disabled', true); // 삭제 버튼
		$('#btnCancel').attr('disabled', true); // 취소 버튼
	});





	// 목형정보관리 사용이력 목록조회
	$('#woodenInfoLogTable thead tr').clone(true).addClass('filters').appendTo('#woodenInfoLogTable thead'); // filter 생성
	let woodenInfoLogTable = $('#woodenInfoLogTable').DataTable({
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
			url : '<c:url value="/bm/woodenInfoLogLst"/>',
			type : 'POST',
			data : {
				wdIdx: function() { return idxVal; }
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'bizOrdDtlNo', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return data;
					} else {
						return '';
					}
				}
			},
			{ data: 'useQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					return addCommas(parseInt(data));
				}
			},
			{ data: 'regIdxNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return data;
					} else {
						return '';
					}
				}
			},
			{ data: 'regDate', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return moment(data).format('YYYY-MM-DD');
					} else {
						return '';
					}
				}
			},
			/* { data: 'wdGubunNm', className : 'text-center align-middle'},
			{ data: 'baseHitQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					return addCommas(parseInt(data));
				}
			},
			{ data: 'calHitQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					return addCommas(parseInt(data));
				}
			},
			{ data: 'wdDesc', className : 'text-center align-middle'},
			{ data: 'regIdxNm', className : 'text-center align-middle'},
			{ data: 'regDate', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					return moment(data).format('YYYY-MM-DD');
				}
			},
			{ className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(meta.row != 0) {
						return '<button type="button" class="btn btn-outline-danger w-auto btnLogDel"><i class="fa-solid fa-trash-can"></i></button>';
					} else {
						return '<button type="button" class="btn btn-outline-danger w-auto btnLogDel" disabled><i class="fa-solid fa-trash-can"></i></button>';
					}
				}
			}, */
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
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#woodenInfoLogTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#woodenInfoLogTable_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 124)+'px');
			
			$('#woodenInfoLogTable_filter').addClass('d-none');
			// 통합검색
			$('#searchAllWil').off('keyup',function() {});
			$('#searchAllWil').on('keyup',function() {
				$('#woodenInfoLogTable_filter').find('input').val($(this).val());
				$('#woodenInfoLogTable_filter').find('input').trigger('keyup');
			});

			// 삭제버튼 click
			$('.btnLogDel').off('click');
			$('.btnLogDel').on('click', function() {
				$('#deleteModal').modal('show').data('type','log');
			});
		},
		initComplete: function () {
			let api = this.api();
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#woodenInfoLogTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	woodenInfoLogTable.on('column-reorder', function( e, settings, details ) {
		let api = woodenInfoLogTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#woodenInfoLogTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	// 사용이력 탭을 열었을 경우
	$('#tab2Nav').on('click', function() {
		setTimeout(function() {
			woodenInfoLogTable.ajax.reload(function() {
				woodenInfoLogTable.draw(false);
			});
		}, 100);
	});




















	// 목형정보관리 기본정보 상세조회
	function woodenInfoAdmSel(idx) {
		let result = '';
		$.ajax({
			url: '<c:url value="/bm/woodenInfoAdmSel"/>',
            type: 'POST',
            async: false,
            data: {
                'idx'	:	idx
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					result = res.data;
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
		return result;
	}
</script>

</body>
</html>
