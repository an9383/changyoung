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
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnProgressSave" disabled><i class="fa-regular fa-floppy-disk"></i></button>
						<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnSearch"><i class="fa-regular fa-clipboard"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnOpen"><i class="fa-solid fa-caret-left"></i></button>
					</div>
				</div>
			</div>
			<div class="row">
				<table class="table table-bordered p-0 m-0" id="spotToningTable">
					<thead class="table-light">
						<tr>
							<th class="text-center">No</th>
							<th class="text-center">색상코드</th>
							<th class="text-center">색상구분</th>
							<th class="text-center">색상번호</th>
							<th class="text-center">조색값</th>
							<th class="text-center">대상품목</th>
							<th class="text-center">대상지종</th>
							<th class="text-center">사용여부</th>
							<th class="text-center">등록자</th>
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
										<th class="text-center align-middle"><span style="color: #ff0000;">*</span>색상구분</th>
										<td class="text-center align-middle">
											<select class="form-select inputGroup" id="colorGubun" disabled>		
											</select>
										</td>
										<th class="text-center align-middle"><span style="color: #ff0000;">*</span>색상코드</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="colorCode" disabled>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle"><span style="color: #ff0000;">*</span>색상번호</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="colorNumber" disabled>
										</td>
										<th class="text-center align-middle">사용여부</th>
										<td class="text-center align-middle">
											<select class="form-select inputGroup" id="useYn" disabled>		
												<option value="Y" selected>사용</option>
												<option value="N">미사용</option>
											</select>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle">조색값</th>
										<td class="text-center align-middle" colspan="3">
											<input type="text" class="form-control inputGroup" id="toningValue" disabled>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle">대상품목</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="spotNote" disabled>
										</td>
										<th class="text-center align-middle">대상지종</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="spotDesc" disabled>
										</td>
									</tr>
								</table>
							</div>
						</div>
						<!-- 탭1 기본정보 끝 -->
						
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
	
	// 공통코드 조회
	let colorGubunList = getCommonCode('일반', '035'); //조색비율

	selectBoxAppend(colorGubunList, 'colorGubun', '', '2');

	// 자재정보 목록조회
	$('#spotToningTable thead tr').clone(true).addClass('filters').appendTo('#spotToningTable thead'); // filter 생성
	let spotToningTable = $('#spotToningTable').DataTable({
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
			url : '<c:url value="/bm/spotToningList"/>',
			type : 'POST',
			data : {
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'progressOrder', className : 'text-center',
				render : function(data, type, row, meta) {
					return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
				}	
			},
			{ data: 'colorCode', className : 'text-center',//색상코드
				render : function(data, type, row, meta) {
					return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
				}	
			},	
			{ data: 'colorGubunNm', className : 'text-center',//색상구분
				render : function(data, type, row, meta) {
					return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
				}
			},	
			{ data: 'colorNumber', className : 'text-center',//색상번호
				render : function(data, type, row, meta) {
					return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
				}
			},	
			{ data: 'toningValue', className : 'text-center',//조색값
				render : function(data, type, row, meta) {
					return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
				}
			},	
			{ data: 'spotNote', className : 'text-center',//대상품목
				render : function(data, type, row, meta) {
					return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
				}
			},	
			{ data: 'spotDesc', className : 'text-center',//대상지종
				render : function(data, type, row, meta) {
					return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
				}
			},	
			{ data: 'useYn', className : 'text-center',//사용여부
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
			{ data: 'regNm', className : 'text-center',//등록자
				render : function(data, type, row, meta) {
					return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
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
			let data = api.data();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#spotToningTable_wrapper').find('.dataTables_scrollHead').css('height'));
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
				spotToningTable.row(tr).data().progressOrder = i+1;
				$(tr).find('td').eq(0).html(i+1);
			}
		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#spotToningTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#spotToningTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	spotToningTable.on('column-reorder', function( e, settings, details ) {
		let api = spotToningTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#spotToningTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
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
		spotToningTable.ajax.reload(function() {});

		setTimeout(function() {
			$('#my-spinner').hide();
		}, 100)
	});

	// 조색테이블 click
	$('#spotToningTable tbody').on('click','tr', function() {
		let idx = spotToningTable.row(this).data().idx;
		if(WMCheck('new')) { // 신규등록중일 경우
			setWM('new', 'idx', idx);
			return false;
		}
		if(WMCheck('edit')) { // 수정중일 경우
			setWM('edit', 'idx', idx);
			return false;
		}
		let data;
		$.ajax({
			url: '<c:url value="/bm/spotToningSel"/>',
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
					data = res.data;

					$('.inputGroup').attr('disabled', true); // 입력항목

					$('#btnNew').attr('disabled', false); // 신규 버튼
					$('#btnSave').attr('disabled', true); // 저장 버튼
					$('#btnEdit').attr('disabled', false); // 수정 버튼
					$('#btnDel').attr('disabled', false); // 삭제 버튼
					$('#btnCancel').attr('disabled', true); // 취소 버튼
					
					
					$('#colorGubun').val(data.colorGubun);
					$('#colorCode').val(data.colorCode);
					$('#colorNumber').val(data.colorNumber);
					$('#useYn').val(data.useYn);
					$('#toningValue').val(data.toningValue);
					$('#spotNote').val(data.spotNote);
					$('#spotDesc').val(data.spotDesc);
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
		} else if(WMlastIdx == 'dealNew'){
			$('#btnDealCorpSave').trigger('click');
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
				spotToningTable.row('#'+idx).select();
				$(spotToningTable.row('#'+idx).node()).trigger('click'); // 선택했던 항목 선택처리
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
		$('.inputGroup').val('');
		WM_action_ON('new', 'workingWarningModal');

		$('.inputGroup').attr('disabled', false); // 입력항목
		
		$('#btnNew').attr('disabled', true); // 신규 버튼
		$('#btnSave').attr('disabled', false); // 저장 버튼
		$('#btnEdit').attr('disabled', true); // 수정 버튼
		$('#btnDel').attr('disabled', true); // 삭제 버튼
		$('#btnCancel').attr('disabled', false); // 취소 버튼

		$('#useYn').val('Y');
		$('#colorCode').val('자동채번');
	});

	// 저장 버튼 click
	$('#btnSave').on('click', function() {
		let saveType = $(this).data('saveType');

		if($('#colorGubun').val() == '') {
			toastr.warning('색상구분을 선택해주세요.');
			$('#colorGubun').focus();
			return false;
		}

		if($('#colorCode').val() == '') {
			toastr.warning('색상코드를 입력해주세요.');
			$('#colorCode').focus();
			return false;
		}

		if($('#colorNumber').val() == '') {
			toastr.warning('색상번호를 입력해주세요.');
			$('#colorNumber').focus();
			return false;
		}
		// 등록할 경우에
		if(saveType == 'insert') {	
			$.ajax({
				url: '<c:url value="/bm/spotToningInsert"/>',
	            type: 'POST',
	            //async: false,
	            data: {
		            'colorGubun'			:	$('#colorGubun').val(),
		            'colorCode'				:	$('#colorCode').val(),
		            'colorNumber'			:	$('#colorNumber').val(),
		            'useYn'					:	$('#useYn').val(),
		            'toningValue'			:	$('#toningValue').val(),
		            'spotNote'				:	$('#spotNote').val(),
		            'spotDesc'				:	$('#spotDesc').val(),
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if (res.result == "ok") { //응답결과
						toastr.success('신규 저장되었습니다.');

						$('#btnSearch').trigger('click'); // 조회버튼 click

						WM_action_OFF('new');
						
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
			let idx = spotToningTable.row('.selected').data().idx;
			$.ajax({
				url: '<c:url value="/bm/spotToningUpdate"/>',
	            type: 'POST',
	            //async: false,
	            data: {
	                'idx'				:	idx,
		            'colorGubun'			:	$('#colorGubun').val(),
		            'colorCode'				:	$('#colorCode').val(),
		            'colorNumber'			:	$('#colorNumber').val(),
		            'useYn'					:	$('#useYn').val(),
		            'toningValue'			:	$('#toningValue').val(),
		            'spotNote'				:	$('#spotNote').val(),
		            'spotDesc'				:	$('#spotDesc').val(),
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if (res.result == "ok") { //응답결과
						toastr.success('수정 저장되었습니다.');

						$('#btnSearch').trigger('click'); // 조회버튼 click

						WM_action_OFF('edit');
						
						$('#btnNew').attr('disabled', false); // 신규 버튼
						$('#btnSave').attr('disabled', true); // 저장 버튼
						$('#btnEdit').attr('disabled', true); // 수정 버튼
						$('#btnDel').attr('disabled', true); // 삭제 버튼
						$('#btnCancel').attr('disabled', true); // 취소 버튼

						let idx = spotToningTable.row('.selected').data().idx;
						spotToningTable.row('#'+idx).select();
						$(spotToningTable.row('#'+idx).node()).trigger('click'); // 선택했던 항목 선택처리
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

	//순서변경되었을 때
	spotToningTable.on( 'row-reorder', function ( e, diff, changes ) {
		if(diff.length != 0){
			$('#btnProgressSave').attr('disabled',false);
		}
	} );
	
	//순번 저장
	$('#btnProgressSave').on('click',function(){
		let updateList = [];
		$('#spotToningTable tbody tr').each(function(index){
			let data = spotToningTable.row(index).data();
			let obj = {};
			obj.idx = data.idx;
			obj.progressOrder = data.progressOrder;
			updateList.push(obj);
		});
		console.log(updateList);
		$.ajax({
			url: '<c:url value="/bm/spotToningOrderUpdate"/>',
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
					toastr.success('순서가 변경되었습니다.');
					$('#btnProgressSave').attr('disabled',true);
					spotToningTable.ajax.reload();
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();				
			}
		});
	});

	// 삭제 버튼 click
	$('#btnDel').on('click', function() {
		if(!$('#spotToningTable tbody tr').hasClass('selected')){
			toastr.warning('삭제할 행을 선택해주세요.');
			return false;
		}
		
		$('#deleteModal').modal('show');
	});

	// 삭제 경고창 삭제 버튼 click
	$('#btnDeleteModalY').on('click', function() {
		let idx = spotToningTable.row('.selected').data().idx;
		$.ajax({
			url: '<c:url value="/bm/spotToningDelete"/>',
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

	

</script>

</body>
</html>
