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
																		
	<input type="file" id="fileFake" style="display: none;" value="" multiple>																
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
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnEquipOrdSave" disabled><i class="fa-regular fa-floppy-disk"></i></button>
						<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnSearch"><i class="fa-regular fa-clipboard"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnOpen"><i class="fa-solid fa-caret-left"></i></button>
					</div>
				</div>
			</div>
			<div class="row">
				<table class="table table-bordered p-0 m-0" id="equipTable">
					<thead class="table-light">
						<tr>
							<th class="text-center">No</th>
							<th class="text-center">설비코드</th>
							<th class="text-center">설비명</th>
							<th class="text-center">사용유무</th>
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
						<button class="nav-link" id="tab2Nav" data-bs-toggle="tab" data-bs-target="#tab2">관련자료</button>
						<button class="nav-link" id="tab3Nav" data-bs-toggle="tab" data-bs-target="#tab3">담당자</button>
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
										<th class="text-center align-middle"><span style="color: #ff0000;">*</span>설비코드</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="equipCd" disabled>
										</td>
										<th class="text-center align-middle"><span style="color: #ff0000;">*</span>설비명</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="equipNm" disabled>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle">SN</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="serialNo" disabled>
										</td>
										<th class="text-center align-middle">제조사</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="makerNm" disabled>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle">구입일자</th>
										<td class="text-center align-middle">
											<input type="date" max="9999-12-31" class="form-control inputGroup" id="buyDate" disabled>
										</td>
										<th class="text-center align-middle">구입금액</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="buyPrice" style="text-align:right;" onkeyup="numberFormat(this,'int')" disabled>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle">설치위치</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="setupLocation" disabled>
										</td>
										<th class="text-center align-middle">비고</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="equipDesc" disabled>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle">사용여부</th>
										<td class="text-center align-middle">
											<select class="form-select inputGroup" id="useYn" disabled>
												<option value="Y" selected>사용</option>
												<option value="N">미사용</option>
											</select>
										</td>
									</tr>
								</table>
							</div>
						</div>
						<!-- 탭1 기본정보 끝 -->
						<!-- 탭2 관련자료-->
						<div class="tab-pane fade" id="tab2">
							<div class="row" style="padding: 5px;">
								<div class="row" style="width:100%;">
									<div class="d-flex align-items-center justify-content-end w-100" style="margin-bottom:5px;">
										<input type="text" class="form-control w-auto h-100 me-1" id="searchAllAdt" placeholder="통합검색" >
										<div class="btn-group" role="group" aria-label="Small button group">
											<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnAttachDataNew" disabled>
												<i class="fa-solid fa-plus"></i>
											</button>											
											<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnAttachDataSave" disabled>
												<i class="fa-regular fa-floppy-disk"></i>
											</button>								
											<button type="button" class="btn btn-outline-danger w-auto" style="font-size: 17px !important;" id="btnAttachDataDel" disabled>
												<i class="fa-solid fa-trash-can"></i>
											</button>								
											<button type="button" class="d-none btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnAttachDataCancel" disabled>
												<i class="fa-solid fa-xmark"></i>
											</button>
										</div>									
									</div>
									<table class="table table-bordered p-0 m-0" id="attachDataTable">
										<thead class="table-light">
											<tr>
												<th class="text-center">순번</th>
												<th class="text-center">내용</th>
												<th class="text-center">첨부파일</th>										
											</tr>
										</thead>
									</table>
								</div>	
							</div>
						</div> 
						<div class="tab-pane fade" id="tab3">
							<div class="row" style="padding: 5px;">
								<div class="d-flex align-items-center justify-content-end w-100" style="margin-bottom:5px;">
									<input type="text" class="form-control w-auto h-100 me-1" id="searchAllEut" placeholder="통합검색" >
									<div class="btn-group" role="group" aria-label="Small button group">
										<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnEquipUserSave" disabled>
											<i class="fa-regular fa-floppy-disk"></i>
										</button>								
									</div>	
								</div>
								<table class="table table-bordered p-0 m-0" id="equipUserTable">
									<colgroup>
										<col width="20%">
										<col width="30%">
										<col width="20%">
										<col width="30%">
									</colgroup>	
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
							</div>
						</div> 
						<!-- 탭2 관련자료 끝 -->
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
		$('#page').css('grid-template-columns', '4fr 4px 3fr');
		$('#rightcol').removeClass('d-none');
		dataTableDrawAll(); // dataTable 전체 reload
	});
	$('#btnClose').on('click',function() { // right-box 닫기버튼 클릭
		$('#page').css('grid-template-columns', '1fr');
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
	/* let itemGubunList = getCommonCode('일반', '002'); //품목구분
	
	selectBoxAppend(itemGubunList, 'itemGubun', '', '2'); */

	let delStatus = '';
	
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
		colReorder: false,
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
			url : '<c:url value="/em/equipInfoListAll"/>',
			type : 'GET',
			data : {
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'progressOrder', className : 'text-center'},
			{ data: 'equipCd', className : 'text-center'},
			{ data: 'equipNm', className : 'text-center'},
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
			let data = api.data();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#equipTable_wrapper').find('.dataTables_scrollHead').css('height'));
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
				equipTable.row(tr).data().progressOrder = i+1;
				$(tr).find('td').eq(0).html(i+1);
			}
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

	$('#btnEquipOrdSave').on('click',function(){
		let updateList = [];
		$('#equipTable tbody tr').each(function(index){
			let data = equipTable.row(index).data();
			let obj = {};
			obj.idx = data.idx;
			obj.progressOrder = data.progressOrder;
			updateList.push(obj);
		});

		$.ajax({
			url: '<c:url value="/em/equipInfoOrdUpdate"/>',
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
					toastr.success('설비순서가 변경되었습니다.');
					$('#btnEquipOrdSave').attr('disabled',true);
					equipTable.ajax.reload();
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();				
			}
		});
	});
	
	let equipIdx = 0;
	$('#equipTable tbody').on('click','tr', function() {
		let idx = equipTable.row(this).data().idx;
		if(WMCheck('new')) { // 신규등록중일 경우
			setWM('new', 'idx', idx);
			return false;
		}
		if(WMCheck('edit')) { // 수정중일 경우
			setWM('edit', 'idx', idx);
			return false;
		}
		if(WMCheck('attachDataNew')) { // 관련자료 등록중일 경우
			setWM('attachDataNew', 'idx', idx);
			return false;
		}
		formData = new FormData();
		equipIdx = idx;
		attachDataTable.ajax.reload();
		equipUserTable.ajax.reload();
		let data;
		$.ajax({
			url: '<c:url value="/em/equipInfoSel"/>',
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

					$('#btnAttachDataNew').attr('disabled', false); //관련자료 추가 버튼
					$('#btnAttachDataSave').attr('disabled', true); //관련자료 저장 버튼
					$('#btnAttachDataDel').attr('disabled', true); //관련자료 삭제 버튼
					$('#btnAttachDataCancel').attr('disabled', true); //관련자료 취소 버튼

					$('#btnEquipUserSave').attr('disabled',false);
					$('#equipCd').val(data.equipCd);
					$('#equipNm').val(data.equipNm);
					$('#serialNo').val(data.serialNo);
					$('#makerNm').val(data.makerNm);
					$('#buyDate').val(moment(data.buyDate,'YYYYMMDD').format('YYYY-MM-DD'));
					$('#setupLocation').val(data.setupLocation);
					$('#equipDesc').val(data.equipDesc);
					$('#buyPrice').val(addCommas(parseFloat(data.buyPrice)));
					if( $('#buyPrice').val() == 'NaN' ){
						$('#buyPrice').val('0');
					}
					$('#useYn').val(data.useYn);
					
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

	// 작업중 경고 모달 예 버튼 click
	$('#btnWorkingWarningModalY').on('click', function() {
		if(WMlastIdx == 'new' || WMlastIdx == 'edit') { // 등록중이거나 수정중이였을 경우
			$('#btnSave').trigger('click');
			return false;
		} else if(WMlastIdx == 'dealNew'){
			$('#btnDealCorpSave').trigger('click');
			return false;
		} else if(WMlastIdx == 'attachDataNew'){
			$('#btnAttachDataSave').trigger('click');
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
				equipTable.row('#'+idx).select();
				$(equipTable.row('#'+idx).node()).trigger('click'); // 선택했던 항목 선택처리
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
		} else if(WMlastIdx == 'attachDataNew') { // 관련자료 등록중
			if(getWM(WMlastIdx, 'idx') != '' && getWM(WMlastIdx, 'idx') != undefined) {
				let idx = getWM(WMlastIdx, 'idx');
				WM_action_OFF(WMlastIdx);
				setWM(WMlastIdx, 'idx', '');
				equipTable.row('#'+idx).select();
				$(equipTable.row('#'+idx).node()).trigger('click'); // 선택했던 항목 선택처리
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

		$('#btnAttachDataNew').attr('disabled', true); //관련자료 추가 버튼
		$('#btnAttachDataSave').attr('disabled', true); //관련자료 저장 버튼
		$('#btnAttachDataDel').attr('disabled', true); //관련자료 삭제 버튼
		$('#btnAttachDataCancel').attr('disabled', true); //관련자료 취소 버튼
		attachDataTable.clear().draw();
		
		$('#useYn').val('Y');
		$('#buyDate').val(moment().format('YYYY-MM-DD'));
		$('#buyPrice').val('0');
	});

	// 저장 버튼 click
	$('#btnSave').on('click', function() {
		let saveType = $(this).data('saveType');

		if($('#equipCd').val() == '') {
			toastr.warning('설비코드를 입력해주세요.');
			$('#equipCd').focus();
			return false;
		}

		if($('#equipNm').val() == '') {
			toastr.warning('설비명을 입력해주세요.');
			$('#equipNm').select();
			return false;
		}

		if($('#buyPrice').val() == '') {
			$('#buyPrice').val('0');
		}
		
		// 등록할 경우에
		if(saveType == 'insert') {	
			$.ajax({
				url: '<c:url value="/em/equipInfoInsert"/>',
	            type: 'POST',
	            //async: false,
	            data: {
		            'equipCd'			:	$('#equipCd').val(),
		            'equipNm'			:	$('#equipNm').val(),
		            'serialNo'			:	$('#serialNo').val(),
		            'makerNm'			:	$('#makerNm').val(),
		            'buyDate'			:	$('#buyDate').val(),
		            'buyPrice'			:	$('#buyPrice').val().replaceAll(',',''),
		            'setupLocation'		:	$('#setupLocation').val(),
		            'equipDesc'			:	$('#equipDesc').val(),
		            'useYn'				:	$('#useYn').val(),
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
			let idx = equipTable.row('.selected').data().idx;
			$.ajax({
				url: '<c:url value="/em/equipInfoUpdate"/>',
	            type: 'POST',
	            //async: false,
	            data: {
		            'idx'				:	function(){ return idx; },
		            'equipCd'			:	$('#equipCd').val(),
		            'equipNm'			:	$('#equipNm').val(),
		            'serialNo'			:	$('#serialNo').val(),
		            'makerNm'			:	$('#makerNm').val(),
		            'buyDate'			:	$('#buyDate').val(),
		            'buyPrice'			:	$('#buyPrice').val().replaceAll(',',''),
		            'setupLocation'		:	$('#setupLocation').val(),
		            'equipDesc'			:	$('#equipDesc').val(),
		            'useYn'				:	$('#useYn').val(),
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

						let idx = equipTable.row('.selected').data().idx;
						equipTable.row('#'+idx).select();
						$(equipTable.row('#'+idx).node()).trigger('click'); // 선택했던 항목 선택처리
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
		delStatus = 'equip';
		$('#deleteModal').modal('show');
	});

	// 삭제 경고창 삭제 버튼 click
	$('#btnDeleteModalY').on('click', function() {
		if(delStatus == 'equip'){
			let idx = equipTable.row('.selected').data().idx;
			$.ajax({
				url: '<c:url value="/em/equipInfoDelete"/>',
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
						$.ajax({
							url: '<c:url value="/em/equipAttachDataDelete"/>',
					        type: 'POST',
					        //async: false,
					        data: {
					            'equipIdx'	:	idx
					        },
					        beforeSend: function() {
					        	$('#my-spinner').show();
					        },
							success : function(res) {
								if (res.result == "ok") { //응답결과
									toastr.success('삭제되었습니다.');
									$('#btnSearch').trigger('click'); // 조회버튼 click
									$('.inputGroup').attr('disabled', true); // 입력항목
									$('#btnNew').attr('disabled', false); // 신규 버튼
									$('#btnSave').attr('disabled', true); // 저장 버튼
									$('#btnEdit').attr('disabled', true); // 수정 버튼
									$('#btnDel').attr('disabled', true); // 삭제 버튼
									$('#btnCancel').attr('disabled', true); // 취소 버튼
									$('#btnAttachDataNew').attr('disabled',true);
									$('#btnAttachDataSave').attr('disabled',true);
									$('#btnAttachDataDel').attr('disabled',true);
									$('#btnAttachDataCancel').attr('disabled',true);
									//파일삭제
									$('#attachDataTable tbody tr').each(function(index, item) {
										let uuid = attachDataTable.row(index).data().uuid;
										let ext = attachDataTable.row(index).data().ext;
										fileDelete({uuid:uuid,ext:ext});
									});
									attachDataTable.ajax.reload();
								} else if(res.result == 'fail') {
									toastr.warning(res.message);
								} else {
									toastr.error(res.message);
								}
								$('#my-spinner').hide();
							}
						});
					} else if(res.result == 'fail') {
						toastr.warning(res.message);
					} else {
						toastr.error(res.message);
					}
					$('#my-spinner').hide();
				}
			});
		} else if(delStatus == 'attachData'){
			let idx = attachDataTable.row('.selected').data().idx;
			$.ajax({
				url: '<c:url value="/em/equipAttachDataDelete"/>',
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
						let uuid = attachDataTable.row('.selected').data().uuid;
						let ext = attachDataTable.row('.selected').data().ext;
						fileDelete({uuid:uuid,ext:ext});
						attachDataTable.row('.selected').remove().draw();	
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

	/* 관련자료 */	
	$('#attachDataTable thead tr').clone(true).addClass('filters').appendTo('#attachDataTable thead'); // filter 생성
	let attachDataTable = $('#attachDataTable').DataTable({
		dom : "<'row'<'col-md-12 col-md-6'l><'col-md-12 col-md-6'f>>"
				+ "<'row'<'col-md-12'tr>>"
				+ "<'row pt-1'<'d-flex align-items-center d-flex'><'me-lg-auto'><'d-flex align-items-center justify-content-end'>>",
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
			url : '<c:url value="/em/equipAttachDataList"/>',
			type : 'GET',
			data : {
				'equipIdx' : function() { return equipIdx; },
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'progressOrder', className : 'text-center'},
			{ data: 'fileContents', className : 'text-center',
				render : function(data, type, row, meta) {
					if(data == null){
						return '<input type="text" class="form-control" value="" name="fileContents">';
					} else {
						return '<input disabled type="text" class="form-control" value="'+data+'" name="fileContents">';
					}
				}
			},
			{ data : 'fileNm', className : 'text-center',
				render : function(data, type, row, meta) {
					if( row['fileStatus']=='F'){
						let html = '';
							html += '<div>';
							html += '	<input type="file" style="display:none;" id="fileNm" name="fileNm" value="" multiple>';
							html += '	<input type="hidden" class="uuid" id="fileUuid" value="'+ row['fileUuid'] +'"> ';
							html += '' + row['fileSplitNm'] + '';
							html += '</div>';
						return html;	
					} else{
						let html = '';
						if(data != null && data != "") {
							html += '<a href="/file/fileDownload?uuid='+row.uuid+'&fileName='+row.fileNm+'&ext='+row.ext+'">';
							html += '<span style="font-size: 14px;">'+data+'</span>';							
							html += '<input type="hidden" id="fileHidden'+ meta.row +'" value="'+data+'">';
						}
						return html;
					}
				}
			},
		],
		columnDefs : [
			//{
			//	targets: [0],
			//	render: function(data) {
			//		return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'data+'</div>';
			//	}
			//}
		],
		buttons : [
			/* { extend: 'excel',	text: 'Excel',	charset: 'UTF-8', bom: true ,
				exportOptions: {
	                modifier: {
	                   selected:null
	                },	                
	            },
	        },
			{ extend: 'pdf',	text: 'PDF',	},
			{ extend: 'print',	text: 'Print',		charset: 'UTF-8', bom: true },
			{ extend: 'colvis',	text: 'Select Col',	}, */
		],
		order : [],
		drawCallback: function() {
			let api = this.api();
			let data = api.data();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#attachDataTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 131)+'px');

			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAllAdt').off('keyup',function() {});
			$('#searchAllAdt').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			});

			//progressOrder
			for(var i=0;i<data.length;i++) {
				let tr = $('#attachDataTable tbody').find('tr').eq(i);
				attachDataTable.row(tr).data().progressOrder = i+1;
				$(tr).find('td').eq(0).html(i+1);
			}
		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#attachDataTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#attachDataTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	attachDataTable.on('column-reorder', function( e, settings, details ) {
		let api = attachDataTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#attachDataTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	//테이블 클릭
	$('#attachDataTable tbody').on('click','tr', function() {
		$('#btnAttachDataDel').attr('disabled',false);
	});
	
	//관련자료탭클릭시
	$('#tab2Nav').on('click',function(){
		attachDataTable.ajax.reload(function(){
			attachDataTable.draw(false);
		});
	});

	//관련자료 추가 시
	$('#btnAttachDataNew').on('click',function(){
		$('#fileFake').trigger('click');
	});

	//파일 선택
	let formData = new FormData();
	$('#fileFake').on('change',function(e) {
		let fileInput = document.getElementById('fileFake'); 
		if(fileInput.files.length>0){
			let files = fileInput.files; //업로드한 파일들의 정보를 넣는다.
	
			for(let i = 0; i < document.querySelector('#fileFake').files.length; i++){
				//폼데이터 넣는곳
				let uuid = uuid_v4();
				formData.append('file+'+uuid,files[i]);
				formData.append('uuid+'+uuid,uuid);
				formData.append('ext+'+uuid,files[i].name.split('.').at(-1));
				
				//페이크 업로드파일로부터 추가된 행에 데이터 옮겨주기
				let fileData =  document.querySelector('#fileFake').files[i];

				//파일명
				let fileArr = files[i].name.split('.');
				let fileNm = _.slice(fileArr, 0, -1).join('.');
				 
				attachDataTable.row.add({
					'progressOrder' : 0,
					'ext'     : files[i].name.split('.').at(-1),
		 			'fileNm'		:	fileData.name,
		 			'fileSplitNm'	:	fileNm,
		 			'fileStatus'    :  'F',
		 			'fileUuid' 		: uuid,
		 			'fileContents'		: null,
				}).draw(false);
			}
		}
		$('#fileFake').val('');
		WM_action_ON('attachDataNew', 'workingWarningModal');
		$('#btnAttachDataSave').attr('disabled',false);
	});
	
	//관련자료 삭제 시
	$('#btnAttachDataDel').on('click',function(){
		if( !$('#attachDataTable tbody tr').hasClass('selected') ){
			toastr.warning('삭제할 항목을 선택해주세요.');
			return false;
		}
		
		let idx = attachDataTable.row('.selected').data().idx;
		if(idx != '' && idx != undefined){
			delStatus = 'attachData';
			$('#deleteModal').modal('show');
		} else {
			//폼데이터로부터 지우고 테이블 다시그리기
			let selectUuid = $('#attachDataTable tbody').find('.selected').find('.uuid').val();
			formData.delete('file+'+selectUuid);
			formData.delete('uuid+'+selectUuid);
			formData.delete('ext+'+selectUuid);
			$('#attachDataTable').DataTable().row('.selected').remove().draw();
		}
	});

	//관련자료 저장 시
	$('#btnAttachDataSave').on('click',function(){
		let fileString = [];
		let i=0;
		//삭제된 데이터들로부터 형식맞추는곳
		let formData2 = new FormData();
		let entries = formData.entries();
		for (let pair of entries) {
			if(i%3 == 0){
				formData2.append(pair[0].split('+')[0]+'-'+pair[0].split('+')[1],pair[1]);
			} else {
				formData2.append(pair[0].split('+')[0],pair[1]);
			}
			i++;
		}
		i=0;
		$('#attachDataTable tbody tr').each(function(index, item) {
			if( attachDataTable.row(this).data() != undefined && attachDataTable.row(this).data() != null){
				if( attachDataTable.row(this).data().idx == '' || attachDataTable.row(this).data().idx == undefined ){ 
					//파일스트링 만드는곳					
					let fileArr = formData2.getAll('file-'+formData2.getAll('uuid')[i])[0].name.split('.');
					let fileNm = _.slice(fileArr, 0, -1).join('.');
					
					let obj = {};
					obj.uuid = formData2.getAll('uuid')[i];
					obj.fileNm = fileNm;
					obj.ext = formData2.getAll('ext')[i];
					obj.fileContents = $(this).find('input[name=fileContents').val();
					fileString.push(obj);
					i++;
				}
			}
		});

		let idx = equipTable.row('.selected').data().idx;
		
		$.ajax({
			url: '<c:url value="/em/equipAttachDataInsert"/>',
            type: 'POST',
            //async: false,
            data: {    
	            'equipIdx'		:	function(){return idx;},
            	'fileString'		:	JSON.stringify(fileString),
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					toastr.success('저장되었습니다.');
					//$('#btnSearch').trigger('click'); // 조회버튼 click

					WM_action_OFF('attachDataNew');

					$('#btnAttachDataNew').attr('disabled',false);
					$('#btnAttachDataSave').attr('disabled',true);
					$('#btnAttachDataDel').attr('disabled',true);
					$('#btnAttachDataCancel').attr('disabled',true);
					if(fileString != ''){
						fileUpload(formData2); // 파일 업로드
					}
					attachDataTable.ajax.reload(function(){});
					formData = new FormData();
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
		
	});

	//담당자
	$('#equipUserTable thead tr').clone(true).addClass('filters').appendTo('#equipUserTable thead'); // filter 생성
	let equipUserTable = $('#equipUserTable').DataTable({
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
			url : '<c:url value="/em/equipUserInfoLst"/>',
			type : 'POST',
			data : {
				idx : function(){ return equipIdx;}, 
			},
		},
        rowId: 'idx',
		columns : [
			{	data:'equipIdx', className : 'text-center',
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
			let theadHeight = parseFloat($('#equipUserTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 161)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAllEut').off('keyup',function() {});
			$('#searchAllEut').on('keyup',function() {
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
				let cell = $('#'+table_id+'_wrapper').find('.filters th').eq(
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
				$('#'+table_id+'_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	equipUserTable.on('column-reorder', function( e, settings, details ) {
		let api = equipUserTable;
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
	
	//담당자탭
	$('#tab3Nav').on('click',function(){
		equipUserTable.ajax.reload(function(){
			equipUserTable.draw(false);
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

	$('#btnEquipUserSave').on('click',function(){
		$('#my-spinner').show();
		let insertList = [];
		//체크된 항목들만 탐색
		$('input:checkbox[name=btnCheck]:checked').each(function(indxe){
			let tr = $(this).parent().parent(); //해당 tr
			let data = equipUserTable.row(tr).data(); // 데이터 테이블의 해당 칸
			let obj = {};
			obj.USER_IDX = data.userIdx;
			obj.EQUIP_IDX = equipTable.row('.selected').data().idx;
			obj.regIdx = '';
			obj.regDate = '';
			insertList.push(obj);
		})

		$('#my-spinner').hide();
		
		$.ajax({		    	
	        url: '<c:url value="/em/equipUserDelIns"/>',
	        type: 'POST',
            data: {
                'insertJson'	:	JSON.stringify(insertList),
                'idx'	:	equipTable.row('.selected').data().idx,
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
	        success: function(res){
	        	if(res.result == "ok"){
	        		$('#my-spinner').hide();
	        		toastr.success('저장 되었습니다.');       
	        		equipUserTable.ajax.reload();
	        	}
	        	else{
	        		$('#my-spinner').hide();
	        		toastr.error(result.message);
	        	}
	        	
	        }
		});	 

	});
	
</script>
</body>
</html>
