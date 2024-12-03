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
																		  grid-template-columns: 5.5fr 4px 4.5fr;">
	<div id="leftcol">
		<div class="container-fluid h-100" style="padding: 5px;">
			<div class="row" id="leftHeader" style="padding-bottom: 5px;">
				<div class="d-flex align-items-center d-flex">
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">사용여부</label>
					<select class="form-select w-auto h-100 me-3" id="searchUseYnCd" style="min-width: 70px;">
						<option value="" selected>전체</option>
						<option value="001">사용</option>
						<option value="002">미사용</option>
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
				<table class="table table-bordered p-0 m-0" id="workplaceTable">
					<colgroup>
						<col width="10%">
						<col width="35%">
						<col width="55%">
					</colgroup>	
					<thead class="table-light">
						<tr>
							<th class="text-center">주사업장여부</th>
							<th class="text-center">사업장코드</th>
							<th class="text-center">사업장명칭</th>
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
										<th class="text-center align-middle"><span style="color:#ff0000;">*</span>주사업장여부</th>
										<td class="text-start align-middle">
											<select class="form-select w-100 h-100 me-3 inputGroup" id="mainYn" disabled>
												<option value="">선택</option>
												<option value="Y">주사업장</option>
												<option value="N">일반사업장</option>
											</select>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle">사용여부</th>
										<td class="text-start align-middle">
											<select class="form-select w-100 h-100 me-3 inputGroup" id="useYnCd" disabled>
												<option value="001" selected>사용</option>
												<option value="002">미사용</option>
											</select>
										</td>
										<th class="text-center align-middle">사업자구분</th>
										<td class="text-start align-middle">
											<select class="form-select w-100 h-100 me-3 inputGroup" id="workplaceGubun" disabled>
											</select>
										</td>
									</tr>
									<tr>
									<th class="text-center align-middle"><span style="color:#ff0000;">*</span>사업장코드</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="workplaceCd" disabled>
										</td>
										<th class="text-center align-middle"><span style="color:#ff0000;">*</span>사업장명칭</th>
										<td  class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="workplaceNm" disabled>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle">사업장주소</th>
										<td colspan='3' class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="workplaceAddress" disabled>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle">우편 번호</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="postNumber" disabled>
										</td>
										<th class="text-center align-middle">전화 번호</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="phoneNumber" disabled>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle"><span style="color:#ff0000;">*</span>사업자번호</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="workplaceNumber" disabled>
										</td>
										<th class="text-center align-middle"><span style="color:#ff0000;">*</span>대표자성명</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="ceoNm" disabled>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle"><span style="color:#ff0000;">*</span>업태</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="businessConditions" disabled>
										</td>
										<th class="text-center align-middle"><span style="color:#ff0000;">*</span>종목</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="businessItem" disabled>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle">FAX 번호</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="faxNumber" disabled>
										</td>
										<th class="text-center align-middle">비고</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="workplaceDesc" disabled>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle">이메일주소</th>
										<td colspan ='3' class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="emailAddress" disabled>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle">기타1</th>
										<td colspan ='3' class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="etc1" disabled>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle">기타2</th>
										<td colspan ='3' class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="etc2" disabled>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle">기타3</th>
										<td colspan ='3' class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="etc3" disabled>
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
			$('#page').css('grid-template-columns', '5.5fr 4px 4.5fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcol').removeClass('d-none');
		} else {
			$('#page').css('grid-template-columns', '0fr 4px 4.5fr');
			$('#leftcol').addClass('d-none');
			$('#rightcol').removeClass('d-none');
		}
		dataTableDrawAll(); // dataTable 전체 reload
	});
	
	$('#btnClose').on('click',function() { // right-box 닫기버튼 클릭
		if($('#leftcol').hasClass('d-none')){
			$('#page').css('grid-template-columns', '5.5fr 4px 4.5fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcol').removeClass('d-none');
		} else {
			$('#page').css('grid-template-columns', '5.5fr 4px 0fr');
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
	let workplaceGubunList = getCommonCode('시스템', '013'); // 회사구분(개인/법인)

	selectBoxAppend(workplaceGubunList, 'workplaceGubun', '', '');
	

	// 사업장 목록조회
	$('#workplaceTable thead tr').clone(true).addClass('filters').appendTo('#workplaceTable thead'); // filter 생성
	let workplaceTable = $('#workplaceTable').DataTable({
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
			url : '<c:url value="/sm/workplaceLst"/>',
			type : 'POST',
			data : {
				'useYnCd' : function() { return $('#searchUseYnCd').val(); }
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'mainYn', className : 'text-center',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						if(data == 'Y') {
							return '주사업장';
						} else {
							return '일반';
						}
					} else {
						return '일반';
					}
				}
			},
			{ data: 'workplaceCd', className : 'text-center'},
			{ data: 'workplaceNm', className : 'text-center'},
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
			let theadHeight = parseFloat($('#workplaceTable_wrapper').find('.dataTables_scrollHead').css('height'));
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
				let cell = $('#workplaceTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#workplaceTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	workplaceTable.on('column-reorder', function( e, settings, details ) {
		let api = workplaceTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#workplaceTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
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
		workplaceTable.ajax.reload(function() {});

		setTimeout(function() {
			$('#my-spinner').hide();
		}, 100)
	});

	// 사용자목록 click
	$('#workplaceTable tbody').on('click','tr', function() {
		let idx = workplaceTable.row(this).data().idx;
		
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
			url: '<c:url value="/sm/workplaceSel"/>',
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
					data = res.data;
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});

		$('#mainYn').val(data.mainYn);
		$('#useYnCd').val(data.useYnCd);
		$('#workplaceGubun').val(data.workplaceGubun);
		$('#workplaceCd').val(data.workplaceCd);
		$('#workplaceNm').val(data.workplaceNm);
		$('#workplaceAddress').val(data.workplaceAddress);
		$('#postNumber').val(data.postNumber);
		$('#phoneNumber').val(data.phoneNumber);
		$('#workplaceNumber').val(data.workplaceNumber);
		$('#ceoNm').val(data.ceoNm);
		$('#businessConditions').val(data.businessConditions);
		$('#businessItem').val(data.businessItem);
		$('#faxNumber').val(data.faxNumber);
		$('#workplaceDesc').val(data.workplaceDesc);
		$('#emailAddress').val(data.emailAddress);
		$('#etc1').val(data.etc1);
		$('#etc2').val(data.etc2);
		$('#etc3').val(data.etc3);
		
		$('.inputGroup').attr('disabled', true); // 입력항목

		$('#btnNew').attr('disabled', false); // 신규 버튼
		$('#btnSave').attr('disabled', true); // 저장 버튼
		$('#btnEdit').attr('disabled', false); // 수정 버튼
		$('#btnDel').attr('disabled', false); // 삭제 버튼
		$('#btnCancel').attr('disabled', true); // 취소 버튼
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
				workplaceTable.row('#'+idx).select();
				$(workplaceTable.row('#'+idx).node()).trigger('click'); // 선택했던 항목 선택처리
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
		
		$('.inputGroup').attr('disabled', false); // 입력항목
		
		$('#btnNew').attr('disabled', true); // 신규 버튼
		$('#btnSave').attr('disabled', false); // 저장 버튼
		$('#btnEdit').attr('disabled', true); // 수정 버튼
		$('#btnDel').attr('disabled', true); // 삭제 버튼
		$('#btnCancel').attr('disabled', false); // 취소 버튼

		$('#useYnCd').val('001');
		$('#workplaceGubun').val('001');
	});

	// 저장 버튼 click
	$('#btnSave').on('click', function() {
		let saveType = $(this).data('saveType');

		
		if($('#mainYn').val() == '') {
			toastr.warning('주사업장여부를 선택해주세요.');
			$('#mainYn').select();
			return false;
		}
		if($('#workplaceCd').val() == '') {
			toastr.warning('사업장코드를 입력해주세요.');
			$('#workplaceCd').select();
			return false;
		}
		if($('#workplaceNm').val() == '') {
			toastr.warning('사업장명칭을 입력해주세요.');
			$('#workplaceNm').select();
			return false;
		}
		if($('#workplaceNumber').val() == '') {
			toastr.warning('사업장번호를 입력해주세요.');
			$('#workplaceNumber').select();
			return false;
		}
		if($('#ceoNm').val() == '') {
			toastr.warning('대표자성명을 입력해주세요.');
			$('#ceoNm').select();
			return false;
		}
		if($('#businessConditions').val() == '') {
			toastr.warning('업태를 입력해주세요.');
			$('#businessConditions').select();
			return false;
		}
		if($('#businessItem').val() == '') {
			toastr.warning('종목을 입력해주세요.');
			$('#businessItem').select();
			return false;
		}
		if($('#emailAddress').val() != '' ){
			let regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
			if($('#emailAddress').val().match(regExp) == null) { // 정규식에 맞지 않을 경우
				toastr.warning('이메일 형식이 잘못되었습니다.');
				$('#emailAddress').select();
				return false;
			}
		}

		// 등록할 경우에
		if(saveType == 'insert') {

			$.ajax({
				url: '<c:url value="/sm/workplaceIns"/>',
	            type: 'POST',
	            async: false,
	            data: {
		            'mainYn'					:	$('#mainYn').val(),
		            'useYnCd'					:	$('#useYnCd').val(),
	                'workplaceGubun'			:	$('#workplaceGubun').val(),
	                'workplaceCd'				:	$('#workplaceCd').val(),
	                'workplaceNm'				:	$('#workplaceNm').val(),
	                'workplaceAddress'			:	$('#workplaceAddress').val(),
	                'postNumber'				:	$('#postNumber').val(),
	                'phoneNumber'				:	$('#phoneNumber').val(),
	                'workplaceNumber'			:	$('#workplaceNumber').val(),
	                'ceoNm'						:	$('#ceoNm').val(),
	                'businessConditions'		:	$('#businessConditions').val(),
	                'businessItem'				:	$('#businessItem').val(),
	                'faxNumber'					:	$('#faxNumber').val(),
	                'workplaceDesc'				:	$('#workplaceDesc').val(),
	                'emailAddress'				:	$('#emailAddress').val(),
	                'etc1'						:	$('#etc1').val(),
	                'etc2'						:	$('#etc2').val(),
	                'etc3'						:	$('#etc3').val(),
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
			let idx = workplaceTable.row('.selected').data().idx;
			$.ajax({
				url: '<c:url value="/sm/workplaceUpd"/>',
	            type: 'POST',
	            async: false,
	            data: {
	                'idx'					:	idx,
	                'mainYn'				:	$('#mainYn').val(),
	                'useYnCd'				:	$('#useYnCd').val(),
	                'workplaceGubun'		:	$('#workplaceGubun').val(),
	                'workplaceCd'			:	$('#workplaceCd').val(),
	                'workplaceNm'			:	$('#workplaceNm').val(),
	                'workplaceAddress'		:	$('#workplaceAddress').val(),
	                'postNumber'			:	$('#postNumber').val(),
	                'phoneNumber'			:	$('#phoneNumber').val(),
	                'workplaceNumber'		:	$('#workplaceNumber').val(),
	                'ceoNm'					:	$('#ceoNm').val(),
	                'businessConditions'	:	$('#businessConditions').val(),
	                'businessItem'			:	$('#businessItem').val(),
	                'faxNumber'				:	$('#faxNumber').val(),
	                'workplaceDesc'			:	$('#workplaceDesc').val(),
	                'emailAddress'			:	$('#emailAddress').val(),
	                'etc1'					:	$('#etc1').val(),
	                'etc2'					:	$('#etc2').val(),
	                'etc3'					:	$('#etc3').val(),
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if (res.result == "ok") { //응답결과
						toastr.success('수정 저장되었습니다.');

						$('#btnSearch').trigger('click'); // 조회버튼 click

						WM_action_OFF('edit');
						
						$('.inputGroup').attr('disabled', true); // 입력항목
						
						$('#btnNew').attr('disabled', false); // 신규 버튼
						$('#btnSave').attr('disabled', true); // 저장 버튼
						$('#btnEdit').attr('disabled', true); // 수정 버튼
						$('#btnDel').attr('disabled', true); // 삭제 버튼
						$('#btnCancel').attr('disabled', true); // 취소 버튼

						let idx = workplaceTable.row('.selected').data().idx;
						workplaceTable.row('#'+idx).select();
						$(workplaceTable.row('#'+idx).node()).trigger('click'); // 선택했던 항목 선택처리
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
</script>

</body>
</html>
