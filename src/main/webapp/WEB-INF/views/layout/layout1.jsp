<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/top.jsp"%>
<%@include file="../layout/script.jsp"%>
<div style="height: 100vh;background-color: #eeeeee;">
	<div class="container-fluid p-0">
		<div class="l1-wrapper wrapper">
			<div class="l1-left-box box" style="height: 100vh; margin: 0px; width: 70vw;">
				<div class="l1-left-header row">
					<div class="d-flex align-items-center d-flex">
						<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">조회일자</label>
						<input type="date" class="form-control w-auto h-100" id="startDate">
						<label class="form-label m-1">~</label>
						<input type="date" class="form-control w-auto h-100 me-3" id="endDate">
						<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">사용여부</label>
						<select class="form-select w-auto h-100 me-3" style="min-width: 70px;">
							<option value="" selected>전체</option>
							<option value="Y">사용</option>
							<option value="N">미사용</option>
						</select>
						<input type="text" class="form-control w-auto h-100 me-1" id="searchAll" placeholder="통합검색" >
					</div>
					<div class="me-lg-auto"></div>
					<div class="d-flex align-items-center justify-content-end">
						<button type="button" class="btn btn-primary w-auto me-1" id="btnSearch">조회</button>
						<button type="button" class="btn btn-outline-dark w-auto ms-1 px-2" id="btnOpen">
							<i class="fa-solid fa-caret-left"></i>
						</button>
					</div>
				</div>
				<div class="row">
					<table class="table table-bordered p-0 m-0" id="layout1Table">
						<thead class="table-light">
							<tr>
								<th class="text-center">설비명</th>
								<th class="text-center">작업자</th>
								<th class="text-center">차수</th>
								<th class="text-center">외주여부</th>
								<th class="text-center">투입량</th>
								<th class="text-center">생산량</th>
								<th class="text-center">양품수량</th>
								<th class="text-center">불량수량</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
			<div class="l1-handler handler"></div><!-- 드래그 영역 -->
			<div class="l1-right-box box" style="height: 100vh; margin: 0px;">
				<div class="container-fluid p-0">
					<div class="l1-right-header row">
						<div class="d-flex align-items-center justify-content-end w-100">
							<button type="button" class="btn btn-primary w-auto me-1" >신규</button>
							<button type="button" class="btn btn-primary w-auto me-1" id="btnSave">저장</button>
							<button type="button" class="btn btn-primary w-auto me-1">수정</button>
							<button type="button" class="btn btn-danger w-auto me-1">삭제</button>
							<button type="button" class="btn btn-outline-dark w-auto ms-1 px-2" id="btnClose">
								<i class="fa-solid fa-caret-right"></i>
							</button>
						</div>
					</div>
					<div class="row">
						<div style="width: 100%;">
						  	<div class="nav nav-tabs" id="nav-tab">
								<button class="nav-link active" id="tab1Nav" data-bs-toggle="tab" data-bs-target="#tab1">기본정보</button>
								<button class="nav-link" id="tab2Nav" data-bs-toggle="tab" data-bs-target="#tab2">관련정보</button>
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
												<th class="text-center"><span style="color:#ff0000;">*</span>TextBox</th>
												<td>
													<input type="text" class="form-control">
												</td>
												<th class="text-center">SelectBox</th>
												<td>
													<select class="form-select">
														<option selected>Open this select menu</option>
														<option value="1">One</option>
														<option value="2">Two</option>
														<option value="3">Three</option>
													</select>
												</td>
											</tr>
											<tr>
												<th class="text-center">CheckBox</th>
												<td colspan='3'>
													<div class="form-check form-check-inline">
														<input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
														<label class="form-check-label" for="flexCheckDefault">
															checkbox1
														</label>
													</div>
													<div class="form-check form-check-inline">
														<input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
														<label class="form-check-label" for="flexCheckDefault">
															checkbox2
														</label>
													</div>
												</td>
											</tr>
											<tr>
												<th class="text-center">RadioBox</th>
												<td colspan='3'>
													<div class="form-check form-check-inline">
														<input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault1">
														<label class="form-check-label" for="flexRadioDefault1">
															radio
														</label>
													</div>
													<div class="form-check form-check-inline">
														<input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault2" checked>
														<label class="form-check-label" for="flexRadioDefault2">
															checked radio
														</label>
													</div>
												</td>
											</tr>
											<tr>
												<th class="text-center">Switch CheckBox</th>
												<td>
													<div class="form-check form-switch">
														<input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckDefault">
														<label class="form-check-label" for="flexSwitchCheckDefault">switch checkbox</label>
													</div>
												</td>
												<th class="text-center">설비명</th>
												<td></td>
											</tr>
										</table>
									</div>
								</div>
								<div class="tab-pane fade" id="tab2">...</div>
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
	// handler 사용여부
	let handlerUseState = true;
	function setHandlerState(state) {
		if(state) {
			$('.l1-handler').css('cursor','ew-resize');
			handlerUseState = true;
		} else {
			$('.l1-handler').css('cursor','default');
			handlerUseState = false;
		}
	}

	let isHandlerDragging = false;
	document.addEventListener('mousedown', function(e) {
		// .handler를 잡고있는지 확인
		if(e.target === handler) {
			isHandlerDragging = true;
		}
	});

	document.addEventListener('mousemove', function(e) {
		// .handler를 잡고있을 경우에만 동작
		if(!isHandlerDragging) {
			return false;
		}
		// handler 사용여부
		if(!handlerUseState) {
			return false;
		}

		let containerOffsetLeft = wrapper.offsetLeft;
		
		let pointerRelativeXpos = e.clientX - containerOffsetLeft;

		let screenWidth = document.documentElement.clientWidth;

		// boxA가 최소사이즈가 되었을 경우
		if(Math.max(boxAminWidth, pointerRelativeXpos - 8) == boxAminWidth) {
			dataTableDrawAll(); // dataTable 전체 reload
			return false;
		}
		
		// boxA가 최대사이즈가 되었을 경우
		if(Math.max(boxAminWidth, pointerRelativeXpos - 8) >= screenWidth-boxBminWidth) {
			dataTableDrawAll(); // dataTable 전체 reload
			return false;
		}
		
		boxA.style.width = (Math.max(boxAminWidth, pointerRelativeXpos - 8)) + 'px';
		boxA.style.flexGrow = 0;
	});

	document.addEventListener('mouseup', function(e) {
		// Turn off dragging flag when user mouse is up
		isHandlerDragging = false;
		if(e.target === handler) {
			dataTableDrawAll(); // dataTable 전체 reload
		}
	});

	
	
	$('#bmsc0010').parent().parent().prev().trigger('click'); // sideBar 메뉴 오픈
	let handler = document.querySelector('.handler'); // handler 영역
	let wrapper = handler.closest('.wrapper'); // 컨트롤할 전체 영역
	let boxA = wrapper.querySelector('.box'); // 컨트롤할 box 영역
	isHandlerDragging = false; // handler를 잡고있는지 확인
	setHandlerState(true); // handler 사용여부
	let boxAminWidth = 20; // left-box 최소크기
	$('.l1-left-header').children().each(function(index, item) {
		boxAminWidth += $(item).width();
	});
	let boxBminWidth = 500;
	$('#btnOpen').on('click',function() { // right-box 열기버튼 클릭
		$('.l1-left-box').removeClass('w-100');
		$('.l1-right-box').removeClass('d-none');
		dataTableDrawAll(); // dataTable 전체 reload
	});
	$('#btnClose').on('click',function() { // right-box 닫기버튼 클릭
		$('.l1-left-box').addClass('w-100');
		$('.l1-right-box').addClass('d-none');
		dataTableDrawAll(); // dataTable 전체 reload
	});
</script>

<script>
	$('#startDate').val(moment().format('YYYY-MM-01'));
	$('#endDate').val(moment().format('YYYY-MM-DD'));

	

	// 1번 레이아웃 dataTable
	$('#layout1Table thead tr').clone(true).addClass('filters').appendTo('#layout1Table thead'); // filter 생성
	let layout1Table = $('#layout1Table').DataTable({
		dom : "<'row'<'col-md-12 col-md-6'l><'col-md-12 col-md-6'f>>"
				+ "<'row'<'col-md-12'tr>>"
				+ "<'row pt-1'<'col-md-8'Bp><'col-md-4 text-end'i>>",
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
			url : '<c:url value="/bm/dealCorpAdmListAll"/>',
			type : 'POST',
			data : {
			},
		},
        rowId: '',
		columns : [
			{ data: 'dealCorpNm', className : 'text-center'},
			{ data: 'dealCorpCd', className : 'text-center'},
			{ data: 'presidentNm', className : 'text-center'},
			{ data: 'corpNo', className : 'text-center'},
			{ data: 'corpNo', className : 'text-center'},
			{ data: 'corpNo', className : 'text-center'},
			{ data: 'corpNo', className : 'text-center'},
			{ data: 'corpNo', className : 'text-center'},
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
			{ extend: 'excel',	text: 'Excel',	charset: 'UTF-8', bom: true },
			{ extend: 'pdf',	text: 'PDF',	},
			{ extend: 'print',	text: '인쇄',		charset: 'UTF-8', bom: true },
			{ extend: 'colvis',	text: '열 선택',	},
		],
		order : [],
		drawCallback: function() {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#layout1Table_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 75)+'px');
			
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
				let cell = $('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup change').on('change', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('change');
				});
			});
		},
	});
	// dataTable colReorder event
	layout1Table.on('column-reorder', function( e, settings, details ) {
		let api = layout1Table;
		api.columns().eq(0).each(function (colIdx) {
			$('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup change').on('change', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('change');
			});
		});
	});

	// 조회 버튼 click
	$('#btnSearch').on('click', function() {
		layout1Table.ajax.reload(function() {});
	});

	// 저장 버튼 click
	$('#btnSave').on('click', function() {
		let node = $(this);
		$(node).prepend('<span class="spinner-border spinner-border-sm me-1" role="status" aria-hidden="true"></span>');
		setTimeout(function() {
			$(node).html('저장');
			toastr.success('저장되었습니다.');
		}, 1000);
	});
	
</script>

</body>
</html>
