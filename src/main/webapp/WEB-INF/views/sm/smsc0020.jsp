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
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100"><spring:message code="userStateCd" text="default text" /></label>
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
							<th class="text-center"><spring:message code="userId" text="default text" /></th>
							<th class="text-center"><spring:message code="userName" text="default text" /></th>
							<th class="text-center"><spring:message code="userDepartmentCd" text="default text" /></th>
							<th class="text-center"><spring:message code="userJobCd" text="default text" /></th>
							<th class="text-center"><spring:message code="userPositionCd" text="default text" /></th>
							<th class="text-center"><spring:message code="userStateCd" text="default text" /></th>
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
										<th class="text-center align-middle"><spring:message code="accessManage" text="default text" /></th>
										<td colspan='3' class="text-start align-middle">
											<div class="form-check form-switch form-check-inline">
												<input class="form-check-input inputGroup" type="checkbox" role="switch" id="userAdmin" disabled>
												<label class="form-check-label" for="userAdmin"><spring:message code="userAdmin" text="default text" /></label>
											</div>
											<div class="form-check form-switch form-check-inline">
												<input class="form-check-input inputGroup" type="checkbox" role="switch" id="userSign" disabled>
												<label class="form-check-label" for="userSign"><spring:message code="userSign" text="default text" /></label>
											</div>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle"><span style="color:#ff0000;">*</span><spring:message code="userId" text="default text" /></th>
										<td colspan='2' class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="userId" autocomplete="new-password" disabled>
										</td>
										<td class="text-start align-middle">
											<button type="button" class="btn btn-warning w-auto me-1" id="btnUserIdCheck" disabled><spring:message code="duplicateCheck" text="default text" /></button>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle"><span style="color:#ff0000;">*</span><spring:message code="userPw" text="default text" /></th>
										<td colspan='2' class="text-center align-middle">
											<input type="password" class="form-control inputGroup" id="userPw" autocomplete="new-password" disabled>
										</td>
										<td class="text-center align-middle">
											<span style="color: #ff0000;">비밀번호는 4자리 이상 입력해야합니다.</span>
											<!-- <span style="color: #ff0000;">비밀번호는 문자, 특수문자, 숫자 3가지 포함 8~20자리 입력해야합니다.</span> -->
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle"><span style="color:#ff0000;">*</span><spring:message code="userPwCheck" text="default text" /></th>
										<td colspan='2' class="text-center align-middle">
											<input type="password" class="form-control inputGroup" id="userPwCheck" disabled>
										</td>
										<td></td>
									</tr>
									<tr>
										<th class="text-center align-middle"><span style="color:#ff0000;">*</span><spring:message code="userName" text="default text" /></th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="userName" disabled>
										</td>
										<th class="text-center align-middle"></th>
										<td class="text-center align-middle"></td>
									</tr>
									<tr>
										<th class="text-center align-middle"><span style="color:#ff0000;">*</span><spring:message code="userEmail" text="default text" /></th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="userEmail" disabled>
										</td>
										<th class="text-center align-middle">소속팀</th>
										<td class="text-center align-middle">
											<select class="form-select inputGroup" id="userTeam" disabled></select>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle"><span style="color:#ff0000;">*</span><spring:message code="userStateCd" text="default text" /></th>
										<td class="text-center align-middle">
											<select class="form-select inputGroup" id="userStateCd" disabled></select>
										</td>
										<th class="text-center align-middle"><span style="color:#ff0000;">*</span><spring:message code="userDepartmentCd" text="default text" /></th>
										<td class="text-center align-middle">
											<select class="form-select inputGroup" id="userDepartmentCd" disabled></select>
										</td>
									</tr>
									<tr>
										<th class="text-center"></span><spring:message code="userPositionCd" text="default text" /></th>
										<td class="text-center align-middle">
											<select class="form-select inputGroup" id="userJobCd" disabled></select>
										</td>
										<th class="text-center"></span><span style="color:#ff0000;">*</span><spring:message code="userJobCd" text="default text" /></th>
										<td class="text-center align-middle">
											<select class="form-select inputGroup" id="userPositionCd" disabled></select>
										</td>
									</tr>
									<tr>
										<th class="text-center"><spring:message code="userJoinDate" text="default text" /></th>
										<td class="text-center align-middle">
											<input type="date" max="9999-12-31" class="form-control inputGroup" onchange="checkDate(this);" id="userJoinDate" disabled>
										</td>
										<th class="text-center"><spring:message code="userLeaveDate" text="default text" /></th>
										<td class="text-center align-middle">
											<input type="date" max="9999-12-31" class="form-control inputGroup" onchange="checkDate(this);" id="userLeaveDate" disabled>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle">서명사진</th>
										<td class="text-center align-middle">
											<div class="card align-items-center p-1">
												<div class="mb-1">
													<div class="btn-group" role="group" aria-label="Small button group">
														<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnSignImage" disabled><i class="fa-solid fa-plus"></i></button>
														<button type="button" class="btn btn-outline-danger w-auto" style="font-size: 17px !important;" id="btnSignImageDel" disabled><i class="fa-solid fa-trash-can"></i></button>
													</div>
												</div>
												<img class="card-img-bottom" id="signImage" src=""
													 onerror="this.src='<c:url value='/resources/assets/images/temp_img/no_image_white.png?ver=1.0'/>'"
													 style="border: 1px solid #000000;">
												<input type="file" class="d-none" id="signImageFile">
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
	let userStateCdList = getCommonCode('시스템', '001'); // 근무상태
	let userDepartmentCdList = getCommonCode('시스템', '002'); // 부서
	let userJobCdList = getCommonCode('시스템', '003'); // 담당업무
	let userPositionCdList = getCommonCode('시스템', '004'); // 직위
	let userTeamCdList = getCommonCode('시스템', '016'); // 소속팀

	selectBoxAppend(userStateCdList, 'SearchUserStateCd', '', '1');
	selectBoxAppend(userStateCdList, 'userStateCd', '', '2');
	selectBoxAppend(userDepartmentCdList, 'userDepartmentCd', '', '2');
	selectBoxAppend(userJobCdList, 'userJobCd', '', '2');
	selectBoxAppend(userPositionCdList, 'userPositionCd', '', '2');
	selectBoxAppend(userTeamCdList, 'userTeam', '', '2');
	

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
			$('#userTable_wrapper').find.eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
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
		userTable.ajax.reload(function() {});

		setTimeout(function() {
			$('#my-spinner').hide();
		}, 100)
	});

	// 사용자목록 click
	$('#userTable tbody').on('click','tr', function() {
		let idx = userTable.row(this).data().idx;
		
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
			url: '<c:url value="/sm/userSel"/>',
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

		
		$('#userAdmin').prop('checked',data.userAdmin=='Y'?true:false);
		$('#userSign').prop('checked',data.userSign=='Y'?true:false);
		$('#userId').val(data.userId);
		$('#userPw').val('');
		$('#userName').val(data.userName);
		$('#userEmail').val(data.userEmail);
		$('#userTeam').val(data.userTeam);
		$('#userStateCd').val(data.userStateCd);
		$('#userDepartmentCd').val(data.userDepartmentCd);
		$('#userJobCd').val(data.userJobCd);
		$('#userPositionCd').val(data.userPositionCd);
		$('#userJoinDate').val(moment(data.userJoinDate,'YYYYMMDD').format('YYYY-MM-DD'));
		$('#userLeaveDate').val(moment(data.userLeaveDate,'YYYYMMDD').format('YYYY-MM-DD'));
		$('#signImage').attr('src','data:image/jpeg;base64'+data.userSignImage);

		$('.inputGroup').attr('disabled', true); // 입력항목
		$('#btnUserIdCheck').attr('disabled', true); // 중복확인 버튼
		$('#btnSignImage').attr('disabled', true); // 사진선택 버튼
		$('#btnSignImageDel').attr('disabled', true); // 사진삭제 버튼
		

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
				userTable.row('#'+idx).select();
				$(userTable.row('#'+idx).node()).trigger('click'); // 선택했던 항목 선택처리
			} else {
				WM_action_OFF(WMlastIdx);
				if(window.location != window.parent.location) { // tab일 경우
					// 부모 탭 닫기버튼 click
					$('#tab-list', parent.document).find('.active').find('span').eq(1).find('i').trigger('click');
			    }
				
				$('.inputGroup').attr('disabled', true); // 입력항목
				$('#btnUserIdCheck').attr('disabled', true); // 중복확인 버튼
				$('#btnSignImage').attr('disabled', true); // 사진선택 버튼
				$('#btnSignImageDel').attr('disabled', true); // 사진삭제 버튼
				
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

		$('#userAdmin').attr('checked',false);
		$('#userSign').attr('checked',false);
		$('.inputGroup').val('');
		$('#userAdmin').prop('checked', false); // ADMIN 초기화
		$('#userSign').prop('checked', false); // 서명 초기화
		$('#signImage').attr('src',''); // 사진 초기화
		$('#signImageFile').val(''); // 사진 초기화
		
		$('.inputGroup').attr('disabled', false); // 입력항목
		$('#btnUserIdCheck').attr('disabled', false); // 중복확인 버튼
		$('#btnSignImage').attr('disabled', false); // 사진선택 버튼
		$('#btnSignImageDel').attr('disabled', false); // 사진삭제 버튼
		
		$('#btnNew').attr('disabled', true); // 신규 버튼
		$('#btnSave').attr('disabled', false); // 저장 버튼
		$('#btnEdit').attr('disabled', true); // 수정 버튼
		$('#btnDel').attr('disabled', true); // 삭제 버튼
		$('#btnCancel').attr('disabled', false); // 취소 버튼
	});

	// 저장 버튼 click
	$('#btnSave').on('click', function() {
		let saveType = $(this).data('saveType');
		

		if($('#userId').val() == '') {
			toastr.warning('아이디를 입력해주세요.');
			$('#userId').select();
			return false;
		}
		if($('#userName').val() == '') {
			toastr.warning('성명을 입력해주세요.');
			$('#userName').select();
			return false;
		}
		
		if($('#userEmail').val() == '') {
			toastr.warning('이메일을 입력해주세요.');
			$('#userEmail').select();
			return false;
		} else { // 정규식 확인
			let regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
			if($('#userEmail').val().match(regExp) == null) { // 정규식에 맞지 않을 경우
				toastr.warning('이메일 형식이 잘못되었습니다.');
				$('#userEmail').select();
				return false;
			}
		}
		if($('#userStateCd').val() == '') {
			toastr.warning('근무상태를 선택해주세요.');
			$('#userStateCd').focus();
			return false;
		}
		
		if($('#userDepartmentCd').val() == '') {
			toastr.warning('부서를 선택해주세요.');
			$('#userDepartmentCd').focus();
			return false;
		}

		if($('#userPositionCd').val() == '') {
			toastr.warning('직위를 선택해주세요.');
			$('#userPositionCd').focus();
			return false;
		}
		
		// 등록할 경우에
		if(saveType == 'insert') {
			if($('#userPw').val() == '') {
				toastr.warning('비밀번호를 입력해주세요.');
				$('#userPw').select();
				return false;
			} else { // 비밀번호 4자리 이상 입력
				if($('#userPw').val().length < 4) {
					toastr.warning('비밀번호를 4자리이상 입력해주세요.');
					$('#userPw').select();
					return false;
				} /*
				// 정규식 확인 -> (문자, 특수문자, 숫자 3가지 포함 8~50자리 입력)
				let regExp = /^.*(?=^.{8,20}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
				if($('#userPw').val().match(regExp) == null) { // 정규식에 맞지 않을 경우
					toastr.warning('비밀번호는 문자, 특수문자, 숫자 3가지 포함 8~20자리 입력해야합니다.');
					$('#userPw').select();
					return false;
				}*/
			}
			if($('#userPwCheck').val() == '') {
				toastr.warning('비밀번호확인을 입력해주세요.');
				$('#userPwCheck').select();
				return false;
			}
			if($('#userPw').val() != $('#userPwCheck').val()) {
				toastr.warning('비밀번호가 일치하지않습니다.<br>비밀번호를 확인해주세요.');
				$('#userPwCheck').select();
				return false;
			}

			$.ajax({
				url: '<c:url value="/sm/userIns"/>',
	            type: 'POST',
	            data: {
	                'userAdmin'			:	($('#userAdmin').is(':checked')?'Y':'N'),
	                'userSign'			:	($('#userSign').is(':checked')?'Y':'N'),
	                'userId'			:	$('#userId').val(),
	                'userPw'			:	$('#userPw').val(),
	                'userName'			:	$('#userName').val(),
	                'userEmail'			:	$('#userEmail').val(),
	                'userTeam'			:	$('#userTeam').val(),
	                'userStateCd'		:	$('#userStateCd').val(),
	                'userDepartmentCd'	:	$('#userDepartmentCd').val(),
	                'userJobCd'			:	$('#userJobCd').val(),
	                'userPositionCd'	:	$('#userPositionCd').val(),
	                'userJoinDate'		:	($('#userJoinDate').val()==''?'':moment($('#userJoinDate').val()).format('YYYYMMDD')),
	                'userLeaveDate'		:	($('#userLeaveDate').val()==''?'':moment($('#userLeaveDate').val()).format('YYYYMMDD')),
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
						$('#btnSignImageDel').attr('disabled', true); // 사진삭제 버튼
						
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
			if($('#userPw').val() != '') { // 비밀번호 4자리 이상 입력
				if($('#userPw').val().length < 4) {
					toastr.warning('비밀번호를 4자리이상 입력해주세요.');
					$('#userPw').select();
					return false;
				}
				// 정규식 확인 -> (문자, 특수문자, 숫자 3가지 포함 8~50자리 입력)
				/*let regExp = /^.*(?=^.{8,20}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
				if($('#userPw').val().match(regExp) == null) { // 정규식에 맞지 않을 경우
					toastr.warning('비밀번호는 문자, 특수문자, 숫자 3가지 포함 8~20자리 입력해야합니다.');
					$('#userPw').select();
					return false;
				}*/	
				if($('#userPwCheck').val() == '') {
					toastr.warning('비밀번호확인을 입력해주세요.');
					$('#userPwCheck').select();
					return false;
				}
				if($('#userPw').val() != $('#userPwCheck').val()) {
					toastr.warning('비밀번호가 일치하지않습니다.<br>비밀번호를 확인해주세요.');
					$('#userPwCheck').select();
					return false;
				}
			}
			
			let idx = userTable.row('.selected').data().idx;
			let signImage = '';
			signImage = $('#signImage').attr('src');
			signImage = signImage.replaceAll('data:image/jpeg;base64','');
			
			$.ajax({
				url: '<c:url value="/sm/userUpd"/>',
	            type: 'POST',
	            data: {
	                'idx'				:	idx,
	                'userAdmin'			:	($('#userAdmin').is(':checked')?'Y':'N'),
	                'userSign'			:	($('#userSign').is(':checked')?'Y':'N'),
	                'userId'			:	$('#userId').val(),
	                'userPw'			:	$('#userPw').val(),
	                'userName'			:	$('#userName').val(),
	                'userEmail'			:	$('#userEmail').val(),
	                'userTeam'			:	$('#userTeam').val(),
	                'userStateCd'		:	$('#userStateCd').val(),
	                'userDepartmentCd'	:	$('#userDepartmentCd').val(),
	                'userJobCd'			:	$('#userJobCd').val(),
	                'userPositionCd'	:	$('#userPositionCd').val(),
	                'userJoinDate'		:	($('#userJoinDate').val()==''?'':moment($('#userJoinDate').val()).format('YYYYMMDD')),
	                'userLeaveDate'		:	($('#userLeaveDate').val()==''?'':moment($('#userLeaveDate').val()).format('YYYYMMDD')),
	                'userSignImage'		:	signImage,
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
						$('#btnSignImageDel').attr('disabled', true); // 사진삭제 버튼
						
						$('#btnNew').attr('disabled', false); // 신규 버튼
						$('#btnSave').attr('disabled', true); // 저장 버튼
						$('#btnEdit').attr('disabled', true); // 수정 버튼
						$('#btnDel').attr('disabled', true); // 삭제 버튼
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
		}
	});

	// 수정 버튼 click
	$('#btnEdit').on('click', function() {
		$('#btnSave').data('saveType','update'); // 저장 방식 -> 수정

		WM_action_ON('edit', 'workingWarningModal');
		
		$('.inputGroup').attr('disabled', false); // 입력항목
		$('#btnUserIdCheck').attr('disabled', false); // 중복확인 버튼
		$('#btnSignImage').attr('disabled', false); // 사진선택 버튼
		$('#btnSignImageDel').attr('disabled', false); // 사진삭제 버튼
		
		$('#btnNew').attr('disabled', true); // 신규 버튼
		$('#btnSave').attr('disabled', false); // 저장 버튼
		$('#btnEdit').attr('disabled', true); // 수정 버튼
		$('#btnDel').attr('disabled', true); // 삭제 버튼
		$('#btnCancel').attr('disabled', false); // 취소 버튼
	});

	// 삭제 버튼 click
	$('#btnDel').on('click', function() {
		$('#deleteModal').modal('show');
	});

	// 삭제 경고창 삭제 버튼 click
	$('#btnDeleteModalY').on('click', function() {
		let idx = userTable.row('.selected').data().idx;
		$.ajax({
			url: '<c:url value="/sm/userDel"/>',
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

					$('#userAdmin').attr('checked',false);
					$('#userSign').attr('checked',false);
					$('.inputGroup').val('');
					$('#userAdmin').prop('checked', false); // ADMIN 초기화
					$('#userSign').prop('checked', false); // 서명 초기화
					$('#signImage').attr('src',''); // 사진 초기화
					$('#signImageFile').val(''); // 사진 초기화
					
					$('.inputGroup').attr('disabled', true); // 입력항목
					$('#btnUserIdCheck').attr('disabled', true); // 중복확인 버튼
					$('#btnSignImage').attr('disabled', true); // 사진선택 버튼
					$('#btnSignImageDel').attr('disabled', true); // 사진삭제 버튼

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
		$('#btnSignImageDel').attr('disabled', true); // 사진삭제 버튼
		
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
			idx = userTable.row('.selected').data().idx;
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

	// 사진삭제 버튼 click
	$('#btnSignImageDel').on('click', function() {
		$('#signImage').attr('src','');
		$('#signImageFile').val('');
	});

	// 파일 선택
	$('#signImageFile').on('change',function(e) {
		let formData = new FormData();
		let fileInput = document.getElementById("signImageFile"); //id로 파일 태그를 호출
		let files = fileInput.files; //업로드한 파일들의 정보를 넣는다.
		let fileType = files[0].type;
		if(fileType.split('/')[0] != 'image') {
			toastr.warning('사진파일을 선택해주세요.');
			return false;
		}
		
		let bases64 = getImgBase64(files[0]);
		$('#signImage').attr('src','data:image/jpeg;base64,'+bases64);
	})
</script>

</body>
</html>
