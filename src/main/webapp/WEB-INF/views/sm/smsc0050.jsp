<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/top.jsp"%>
<%@include file="../layout/modal.jsp"%>
<%@include file="../layout/script.jsp"%>
<div id="page" onmouseup="EndDrag(this)" onmousemove="OnDrag(event)" style="grid-template-areas: 'leftcol dragbar rightcol';
																		  grid-template-rows: 1fr;
																		  grid-template-columns: 5fr 4px 7fr;">
	<div id="leftcol">
		<div class="container-fluid h-100" style="padding: 5px;">
			<div class="row" id="leftHeader" style="padding-bottom: 5px;">
				<div class="d-flex align-items-center d-flex">
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">근무상태</label>
					<select class="form-select w-auto h-100 me-3" id="SearchUserStateCd"></select>
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
				<table class="table table-bordered p-0 m-0" id="userTable">
					<thead class="table-light">
						<tr>
							<th class="text-center">아이디</th>
							<th class="text-center">성명</th>
							<th class="text-center">부서</th>
							<th class="text-center">직위</th>
							<th class="text-center">담당</th>
							<th class="text-center">근무상태</th>
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
					<input type="text" class="form-control w-auto h-100 me-1" id="searchAllDtl" placeholder="통합검색" >
					<div class="btn-group" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto" id="btnCopy" style="font-size: 20px !important;" disabled><i class="fa-regular fa-copy"></i></button>
					</div>
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end">
					<div class="btn-group" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnSave" disabled><i class="fa-regular fa-floppy-disk"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnEdit" disabled><i class="fa-regular fa-pen-to-square"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnCancel" disabled><i class="fa-solid fa-xmark"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnClose"><i class="fa-solid fa-caret-right"></i></button>
					</div>
				</div>
			</div>
			<div class="row">
				<table class="table table-bordered p-0 m-0" id="menuAuthTable">
					<thead class="table-light">
						<tr>
							<th class="text-center" style="padding: 0px;">
								<input class="form-check-input" type="checkbox" id="checkAll" style="margin: 0px; width: 25px; height: 25px;" disabled>
							</th>
							<th class="text-center">메뉴명</th>
							<th class="text-center">상세메뉴명</th>
							<th class="text-center">메뉴ID</th>
							<th class="text-center">상세메뉴ID</th>
							<th class="text-center">즐겨찾기</th>
							<th class="text-center">등록 권한</th>
							<th class="text-center">조회 권한</th>
							<th class="text-center">수정 권한</th>
							<th class="text-center">삭제 권한</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>
<!-- modal ======================================================================================== -->
<!-- 복사 모달 -->
<div class="modal fade" id="copyModal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog" style="max-width: 60vw;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">
					붙여넣을 사용자 선택
				</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="row" style="padding-bottom: 5px;">
					<div class="d-flex align-items-center d-flex">
						<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">근무상태</label>
						<select class="form-select w-auto h-100 me-3" id="SearchUserStateCd2"></select>
					</div>
					<div class="me-lg-auto"></div>
					<div class="d-flex align-items-center justify-content-end">
						<button type="button" class="btn btn-primary w-auto me-1" id="btnSearch2">조회</button>
					</div>
				</div>
				<div class="row">
					<table class="table table-bordered p-0 m-0" id="userPasteTable">
						<colgroup>
							<col width="20%">
							<col width="15%">
							<col width="20%">
							<col width="15%">
							<col width="20%">
						</colgroup>
						<thead class="table-light">
							<tr>
								<th class="text-center"><spring:message code="userId" text="default text" /></th>
								<th class="text-center"><spring:message code="userName" text="default text" /></th>
								<th class="text-center"><spring:message code="userDepartmentCd" text="default text" /></th>
								<th class="text-center"><spring:message code="userJobCd" text="default text" /></th>
								<th class="text-center"><spring:message code="userPositionCd" text="default text" /></th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="btnCopyModalPaste" data-bs-dismiss="modal">
					붙여넣기
				</button>
			</div>
		</div>
	</div>
</div>
<!-- ======================================================================================== modal -->

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
			$('#page').css('grid-template-columns', '5fr 4px 7fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcol').removeClass('d-none');
		} else {
			$('#page').css('grid-template-columns', '0fr 4px 7fr');
			$('#leftcol').addClass('d-none');
			$('#rightcol').removeClass('d-none');
		}
		dataTableDrawAll(); // dataTable 전체 reload
	});
	
	$('#btnClose').on('click',function() { // right-box 닫기버튼 클릭
		if($('#leftcol').hasClass('d-none')){
			$('#page').css('grid-template-columns', '5fr 4px 7fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcol').removeClass('d-none');
		} else {
			$('#page').css('grid-template-columns', '5fr 4px 0fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcol').addClass('d-none');
		}
		dataTableDrawAll(); // dataTable 전체 reload
	});
	
</script>

<script>
	WM_init('edit');

	let userIdxVal = '';
	
	let userStateCdList = getCommonCode('시스템', '001'); // 근무상태
	
	selectBoxAppend(userStateCdList, 'SearchUserStateCd', '', '2');
	selectBoxAppend(userStateCdList, 'SearchUserStateCd2', '', '2');

	// 사용자정보 목록조회
	$('#userTable thead tr').clone(true).addClass('filters').appendTo('#userTable thead'); // filter 생성
	let userTable = $('#userTable').DataTable({
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
			{ data: 'userJobNm', className : 'text-center'},
			{ data: 'userStateNm', className : 'text-center'},
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
			let theadHeight = parseFloat($('#userTable_wrapper').find('.dataTables_scrollHead').css('height'));
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
				let cell = $('#userTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#userTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	userTable.on('column-reorder', function( e, settings, details ) {
		let api = userTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#userTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	// 사용자목록 click
	$('#userTable tbody').on('click','tr',function() {
		let data = userTable.row(this).data();
		userIdxVal = data.idx;

		menuAuthTable.ajax.reload();

		
		$('#btnCopy').attr('disabled', false); // 복사 버튼
		$('#btnSave').attr('disabled', true); // 저장 버튼
		$('#btnEdit').attr('disabled', false); // 수정 버튼
		$('#btnCancel').attr('disabled', true); // 취소 버튼
	});

	// 조회 버튼 click
	$('#btnSearch').on('click', function() {
		$('#my-spinner').show();
		userTable.ajax.reload(function() {});

		setTimeout(function() {
			$('#my-spinner').hide();
		}, 100)
	});

	


	// 메뉴권한관리 목록조회
	$('#menuAuthTable thead tr').clone(true).addClass('filters').appendTo('#menuAuthTable thead'); // filter 생성
	let menuAuthTable = $('#menuAuthTable').DataTable({
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
		colReorder: false,
		select: false,
        ajax : {
			url : '<c:url value="/sm/menuAuthLstByUserIdx"/>',
			type : 'POST',
			data : {
				userIdx	: function() { return userIdxVal; }
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'idx', className : 'text-center align-middle',
				render: function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						return '<input class="form-check-input" type="checkbox" name="menuAuthCheck" style="margin: 0px; width: 25px; height: 25px;" disabled checked>';
					} else {
						return '<input class="form-check-input" type="checkbox" name="menuAuthCheck" style="margin: 0px; width: 25px; height: 25px;" disabled>';
					}
				}, orderable: false
			},
			{ data: 'menuNm', className : 'text-center align-middle'},
			{ data: 'menuNmDtl', className : 'text-center align-middle'},
			{ data: 'menuId', className : 'text-center align-middle'},
			{ data: 'menuIdDtl', className : 'text-center align-middle'},
			{ data: 'favoriteYn', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data == 'Y') {
						let html = '';
						html += '<input type="checkbox" class="bootstrapToggle favoriteYnToggle" data-toggle="toggle"';
						html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
						html += '		data-size="small"';
						html += '		disabled checked>';
						return html;
					} else {
						let html = '';
						html += '<input type="checkbox" class="bootstrapToggle favoriteYnToggle" data-toggle="toggle"';
						html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
						html += '		data-size="small"';
						html += '		disabled>';
						return html;
					}
				}
			},
			{ data: 'createAuth', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data == 'Y') {
						let html = '';
						html += '<input type="checkbox" class="bootstrapToggle createAuthToggle" data-toggle="toggle"';
						html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
						html += '		data-size="small"';
						html += '		disabled checked>';
						return html;
					} else {
						let html = '';
						html += '<input type="checkbox" class="bootstrapToggle createAuthToggle" data-toggle="toggle"';
						html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
						html += '		data-size="small"';
						html += '		disabled>';
						return html;
					}
				}
			},
			{ data: 'readAuth', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data == 'Y') {
						let html = '';
						html += '<input type="checkbox" class="bootstrapToggle readAuthToggle" data-toggle="toggle"';
						html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
						html += '		data-size="small"';
						html += '		disabled checked>';
						return html;
					} else {
						let html = '';
						html += '<input type="checkbox" class="bootstrapToggle readAuthToggle" data-toggle="toggle"';
						html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
						html += '		data-size="small"';
						html += '		disabled>';
						return html;
					}
				}
			},
			{ data: 'updateAuth', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data == 'Y') {
						let html = '';
						html += '<input type="checkbox" class="bootstrapToggle updateAuthToggle" data-toggle="toggle"';
						html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
						html += '		data-size="small"';
						html += '		disabled checked>';
						return html;
					} else {
						let html = '';
						html += '<input type="checkbox" class="bootstrapToggle updateAuthToggle" data-toggle="toggle"';
						html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
						html += '		data-size="small"';
						html += '		disabled>';
						return html;
					}
				}
			},
			{ data: 'deleteAuth', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data == 'Y') {
						let html = '';
						html += '<input type="checkbox" class="bootstrapToggle deleteAuthToggle" data-toggle="toggle"';
						html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
						html += '		data-size="small"';
						html += '		disabled checked>';
						return html;
					} else {
						let html = '';
						html += '<input type="checkbox" class="bootstrapToggle deleteAuthToggle" data-toggle="toggle"';
						html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
						html += '		data-size="small"';
						html += '		disabled>';
						return html;
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
			/* { extend: 'colvis',	text: 'Select Col',	}, */
		],
		order : [],
		drawCallback: function() {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#menuAuthTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 80)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAllDtl').off('keyup',function() {});
			$('#searchAllDtl').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			});

			$('.bootstrapToggle').bootstrapToggle();

			//모든 체크박스 선택
			$('#checkAll').off('click');
			$('#checkAll').on('click',function(){
				if($('#checkAll').prop("checked")){
					$('input:checkbox[name=menuAuthCheck]').prop("checked",true);
					$('.createAuthToggle').bootstrapToggle('on');
					$('.readAuthToggle').bootstrapToggle('on');
					$('.updateAuthToggle').bootstrapToggle('on');
					$('.deleteAuthToggle').bootstrapToggle('on');
				} else{
					$('input:checkbox[name=menuAuthCheck]').prop("checked",false);
					$('.createAuthToggle').bootstrapToggle('off');
					$('.readAuthToggle').bootstrapToggle('off');
					$('.updateAuthToggle').bootstrapToggle('off');
					$('.deleteAuthToggle').bootstrapToggle('off');
				}
			});

			// 메뉴권한 체크했을 경우
			$('input:checkbox[name=menuAuthCheck]').off('click');
			$('input:checkbox[name=menuAuthCheck]').on('click', function() {
				let node = $(this);
				let tr = $(node).parent().parent();
				if($(node).prop("checked")) {
					$(tr).find('td').eq(6).find('input').bootstrapToggle('on');
					$(tr).find('td').eq(7).find('input').bootstrapToggle('on');
					$(tr).find('td').eq(8).find('input').bootstrapToggle('on');
					$(tr).find('td').eq(9).find('input').bootstrapToggle('on');
				} else {
					$(tr).find('td').eq(6).find('input').bootstrapToggle('off');
					$(tr).find('td').eq(7).find('input').bootstrapToggle('off');
					$(tr).find('td').eq(8).find('input').bootstrapToggle('off');
					$(tr).find('td').eq(9).find('input').bootstrapToggle('off');
				}
			})
		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#menuAuthTable_wrapper').find('.filters th').eq(
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
				$('#menuAuthTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	menuAuthTable.on('column-reorder', function( e, settings, details ) {
		let api = menuAuthTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#menuAuthTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	// 저장 버튼 click
	$('#btnSave').on('click', function() {
		let insertList = [];
		$('input:checkbox[name=menuAuthCheck]').each(function(index, item) {
			let node = $(item);
			if($(node).prop("checked")) { // 체크 되었을 경우
				let tr = $(node).parent().parent();
				let data = menuAuthTable.row(tr).data();
				let favoriteYn = $(tr).find('td').eq(5).find('input').prop('checked')?'Y':'N';
				let createAuth = $(tr).find('td').eq(6).find('input').prop('checked')?'Y':'N';
				let readAuth = $(tr).find('td').eq(7).find('input').prop('checked')?'Y':'N';
				let updateAuth = $(tr).find('td').eq(8).find('input').prop('checked')?'Y':'N';
				let deleteAuth = $(tr).find('td').eq(9).find('input').prop('checked')?'Y':'N';
				
				let obj = {};
				obj.userIdx = userIdxVal;
				obj.menuIdx = data.menuIdx;
				obj.favoriteYn = favoriteYn;
				obj.createAuth = createAuth;
				obj.readAuth = readAuth;
				obj.updateAuth = updateAuth;
				obj.deleteAuth = deleteAuth;
				obj.etc1 = '';
				obj.etc2 = '';
				obj.etc3 = '';
				obj.regIdx = '';
				obj.regDate = '';
				insertList.push(obj);
			}
		});

		$.ajax({
			url: '<c:url value="/sm/menuAuthIns"/>',
            type: 'POST',
            data: {
                'jsonArray'	:	JSON.stringify(insertList),
                'userIdx'	:	userIdxVal,
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					toastr.success('수정 저장되었습니다.');

					$('#btnSearch').trigger('click'); // 조회버튼 click

					WM_action_OFF('edit');

					menuAuthTable.ajax.reload(function() {
						$('#checkAll').attr('disabled', true).prop('checked',false);
					});

					$('#btnCopy').attr('disabled', false); // 복사 버튼
					$('#btnSave').attr('disabled', true); // 저장 버튼
					$('#btnEdit').attr('disabled', false); // 수정 버튼
					$('#btnCancel').attr('disabled', true); // 취소 버튼

					let idx = userTable.row('.selected').data().idx;
					userTable.row('#'+idx).select();
					$(userTable.row('#'+idx).node()).trigger('click'); // 선택했던 항목 선택처리
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
		$('#checkAll').attr('disabled', false);
		$('input:checkbox[name=menuAuthCheck]').attr('disabled', false);
		
		$('.favoriteYnToggle').attr('disabled', false);
		$('.createAuthToggle').attr('disabled', false);
		$('.readAuthToggle').attr('disabled', false);
		$('.updateAuthToggle').attr('disabled', false);
		$('.deleteAuthToggle').attr('disabled', false);

		$('#btnCopy').attr('disabled', true); // 복사 버튼
		$('#btnSave').attr('disabled', false); // 저장 버튼
		$('#btnEdit').attr('disabled', true); // 수정 버튼
		$('#btnCancel').attr('disabled', false); // 취소 버튼
	});

	// 취소 버튼 click
	$('#btnCancel').on('click', function() {
		$('#cancelModal').modal('show');
	});

	// 취소 경고창 취소 버튼 click
	$('#btnCancelModalY').on('click', function() {
		toastr.success('취소되었습니다.');
		
		WM_action_OFF('edit');

		menuAuthTable.ajax.reload(function() {
			$('#checkAll').attr('disabled', true).prop('checked',false);
		});

		$('#btnCopy').attr('disabled', false); // 복사 버튼
		$('#btnSave').attr('disabled', true); // 저장 버튼
		$('#btnEdit').attr('disabled', false); // 수정 버튼
		$('#btnCancel').attr('disabled', true); // 취소 버튼
	});



	// 사용자정보 목록조회
	$('#userPasteTable thead tr').clone(true).addClass('filters').appendTo('#userPasteTable thead'); // filter 생성
	let userPasteTable = $('#userPasteTable').DataTable({
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
			url : '<c:url value="/sm/userLst"/>',
			type : 'POST',
			data : {
				userStateCd: function() { return $('#SearchUserStateCd2').val(); }
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'userId', className : 'text-center'},
			{ data: 'userName', className : 'text-center'},
			{ data: 'userDepartmentNm', className : 'text-center'},
			{ data: 'userPositionNm', className : 'text-center'},
			{ data: 'userJobNm', className : 'text-center'},
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
			let theadHeight = parseFloat($('#userPasteTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 300)+'px');
			
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
				let cell = $('#userPasteTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#userPasteTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	userPasteTable.on('column-reorder', function( e, settings, details ) {
		let api = userPasteTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#userPasteTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	// 조회 버튼 click
	$('#btnSearch2').on('click', function() {
		$('#my-spinner').show();
		userPasteTable.ajax.reload(function() {});

		setTimeout(function() {
			$('#my-spinner').hide();
		}, 100)
	});

	// 복사 버튼 click
	$('#btnCopy').on('click', function() {
		$('#copyModal').modal('show');
		setTimeout(function() {
			userPasteTable.ajax.reload(function() {});
		}, 200);
	});

	// 붙여넣기 버튼 click
	$('#btnCopyModalPaste').on('click', function() {
		let copyIdx = userIdxVal;
		let pasteIdx = '';

		let selectedIndex = userPasteTable.rows('.selected').toArray()[0];
		for(let i=0;i<selectedIndex.length;i++) {
			pasteIdx += userPasteTable.row(selectedIndex[i]).data().idx + ",";
		}
		
		$.ajax({
			url: '<c:url value="/sm/menuAuthCopyNPaste"/>',
            type: 'POST',
            data: {
                'copyIdx'	:	copyIdx,
                'pasteIdx'	:	pasteIdx,
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					toastr.success('권한을 붙여넣었습니다.');
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
	})
</script>

</body>
</html>
