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
																		  grid-template-columns: 6fr 4px 4fr;">
	<div id="leftcol">
		<div class="container-fluid h-100" style="padding: 5px;">
			<div class="row" id="leftHeader" style="padding-bottom: 5px;">
				<div class="d-flex align-items-center d-flex">
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">거래상태</label>
					<select class="form-select w-auto h-100 me-3" id="searchDealCorpStatus">
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
				<table class="table table-bordered p-0 m-0" id="dealCorpAdmTable">
					<thead class="table-light">
						<tr>
							<th class="text-center">거래구분</th>
							<th class="text-center">거래처코드</th>
							<th class="text-center">업체명(약식)</th>
							<th class="text-center">대표자</th>
							<th class="text-center">사업자번호</th>
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
						<button class="nav-link" id="tab2Nav" data-bs-toggle="tab" data-bs-target="#tab2">관련자료</button>
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
										<th class="text-center align-middle"><span style="color:#ff0000;">*</span>거래구분</th>
										<td id="dealGubunTd">
										</td>
										<th class="text-center align-middle">사업장</th>
										<td class="text-start align-middle">
											<div style="display: flex; flex-wrap: 1 1 auto;" class="input-group">
												<input type="text" placeHolder="사업장" class="form-control" id="workPlace" name="workPlace" maxlength="6" disabled>
												<input type="hidden" id="workPlaceIdx" disabled>
												<button type="button" class="inputGroup" id="btnWorkPlaceDelete" style="background-color: transparent;
																													border-color: transparent;
																													position: absolute;
																													top: 0;
																													right:0;
																													margin: 1px 23px;
																													margin-left: 0px;
																													border: none;
																													" disabled>
													<i class="fa-solid fa-xmark"></i>
												</button>	
												<button type="button" class="btn btn-primary input-sub-search inputGroup" id="btnWorkPlace" style="padding: 1px 4px; margin-left: 0px;" disabled>
													<i class="fa-solid fa-magnifying-glass"></i>
												</button>
											</div>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle"><span style="color:#ff0000;">*</span>거래처코드</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="dealCorpCd" placeholder="자동채번" disabled>
										</td>
										<th class="text-center align-middle"><span style="color:#ff0000;">*</span>업체명(약식)</th>
										<td class="text-start align-middle">
											<input type="text" class="form-control inputGroup" id="dealCorpNm" disabled>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle">대표자</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="representative" disabled>
										</td>
										<th class="text-center align-middle">사업자번호</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="companyNumber" maxlength="12" disabled>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle">대표품목</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="masterItem" disabled>
										</td>
										<th class="text-center align-middle">업체명</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="initial" disabled>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle">우편번호</th>
										<td class="text-center align-middle">
											<div style="display: flex; flex-wrap: 1 1 auto;" class="input-group">
												<input type="text" placeHolder="우편번호" class="form-control inputGroup" id="postNumber" name="postNumber" maxlength="6" disabled>
												<button type="button" class="btn btn-primary input-sub-search inputGroup" id="zipNumber" style="padding: 1px 4px; margin-left: 0px;" disabled>
													<i class="fa-solid fa-magnifying-glass"></i>
												</button>
											</div>
										</td>
										<th class="text-center align-middle">납품처</th>
										<td class="text-start align-middle">
											<div style="display: flex; flex-wrap: 1 1 auto;" class="input-group">
												<input type="text" placeHolder="납품처" class="form-control" id="outDealCorp" name="outDealCorp" maxlength="6" disabled>
												<button type="button" class="inputGroup btnInputDel" style="background-color: transparent;
																													border-color: transparent;
																													position: absolute;
																													top: 0;
																													right:0;
																													margin: 1px 23px;
																													margin-left: 0px;
																													border: none;
																													" disabled>
													<i class="fa-solid fa-xmark"></i>
												</button>	
												<input type="hidden" id="outDealCorpIdx" disabled>
												
												<button type="button" class="btn btn-primary input-sub-search inputGroup" id="btnOutDealCorp" style="padding: 1px 4px; margin-left: 0px;" disabled>
													<i class="fa-solid fa-magnifying-glass"></i>
												</button>
											</div>
										</td>
									</tr>
									<tr>
										<th rowspan="2" class="text-center align-middle">주소</th>
										<td colspan='3'>
											<input type="text"
											style="max-width: 100%" class="form-control inputGroup" id="addressAdm" placeHolder="도로명주소"
											name="addrBase" maxlength="128" disabled>
										</td>
									</tr>
									<tr>
										<td colspan='3'>
											<input type="text"
											style="max-width: 100%" class="form-control inputGroup" id="addressDtl" placeHolder="상세주소"
											name="addrDtl" maxlength="128" disabled>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle">납품처 주소</th>
										<td colspan='3'>
											<input type="text"
											style="max-width: 100%" class="form-control inputGroup" id="dealCorpAddress" placeHolder="납품처주소"
											name="dealCorpAddress" maxlength="128" disabled>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle">중요도</th>
										<td class="text-center align-middle">
											<select class="form-select w-100 h-100 me-3 inputGroup" id="importantLevel" disabled></select>
										</td>
										<th class="text-center align-middle">회사구분</th>
										<td class="text-center align-middle">
											<select class="form-select w-100 h-100 me-3 inputGroup" id="companyGubun" disabled></select>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle">전화번호</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="phoneNumber" disabled>
										</td>
										<th class="text-center align-middle">팩스번호</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="faxNumber" disabled>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle">본사영업담당</th>
										<td class="text-center align-middle">
											<div style="display: flex; flex-wrap: 1 1 auto;" class="input-group">												
												<input type="hidden" id="salesManager" disabled>
												<input type="text" placeHolder="본사영업담당" class="form-control inputGroup" id="salesManagerNm" disabled>
												<button type="button" class="inputGroup" id="btnSalesManagerDelete" style="background-color: transparent;
																													border-color: transparent;
																													position: absolute;
																													top: 0;
																													right:0;
																													margin: 1px 23px;
																													margin-left: 0px;
																													border: none;
																													" disabled>
													<i class="fa-solid fa-xmark"></i>
												</button>												
												<button type="button" class="btn btn-primary input-sub-search inputGroup" id="btnSalesManagerSel" style="padding: 1px 4px; margin-left: 0px;" disabled>
													<i class="fa-solid fa-magnifying-glass"></i>
												</button>
											</div>
										</td>
										
										
										<th class="text-center align-middle">결제정보</th>
										<td class="text-center align-middle">
											<select class="form-select w-100 h-100 me-3 inputGroup" id="paymentInfo" disabled></select>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle"><span style="color:#ff0000;">*</span>거래상태</th>
										<td class="text-center align-middle">
											<select class="form-select w-100 h-100 me-3 inputGroup" id="dealCorpStatus" disabled></select>
										</td>
										<th class="text-center align-middle">명세서수량기준</th>
										<td class="text-center align-middle">
											<select class="form-select w-100 h-100 me-3 inputGroup" id="statementStandard" disabled></select>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle">비고</th>
										<td colspan="3" class="text-center align-middle">
											<textArea class="form-control inputGroup textarea" id="dealCorpDesc" style="max-width: 100%; resize: none; min-height: 0px !important;" disabled></textArea>
										</td>
									</tr>
								</table>
								<div class="d-flex align-items-center justify-content-end w-100 my-1">
									<div class="btn-group" role="group" aria-label="Small button group">
										<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnManagerAdd"><i class="fa-solid fa-plus"></i></button>
										<button type="button" class="btn btn-outline-danger w-auto" style="font-size: 17px !important;" id="btnManagerDel" disabled><i class="fa-solid fa-trash-can"></i></button>
									</div>
								</div>
								<table class="table table-bordered p-0 m-0" id="dealCorpManagerTable">
									<colgroup>
										<col width="4%">
										<col width="24%">
										<col width="24%">
										<col width="24%">
										<col width="24%">
									</colgroup>
									<thead class="table-light">
										<tr>
											<th class="text-center">No.</th>
											<th class="text-center"><span style="color:#ff0000;">*</span>담당부서</th>
											<th class="text-center"><span style="color:#ff0000;">*</span>담당자명</th>
											<th class="text-center"><span style="color:#ff0000;">*</span>연락처</th>
											<th class="text-center"><span style="color:#ff0000;">*</span>이메일</th>
										</tr>
									</thead>
								</table>
							</div>
						</div>
						<div class="tab-pane fade" id="tab2">
							<div class="row" style="padding-right: 5px;padding-left: 5px; height: calc(100% - 84.7vh);">
								<div class="d-flex align-items-center justify-content-end w-100 my-1">
									<input type="text" class="form-control w-auto h-100 me-1" id="searchAllDcf" placeholder="통합검색" >
									<input type="file" class="d-none" id="dealCorpFile" multiple>
									<div class="btn-group" role="group" aria-label="Small button group">
										<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnFileAdd"><i class="fa-solid fa-plus"></i></button>
										<button type="button" class="btn btn-outline-danger w-auto" style="font-size: 17px !important;" id="btnFileDel" disabled><i class="fa-solid fa-trash-can"></i></button>
									</div>
								</div>
								<table class="table table-bordered p-0 m-0" id="dealCorpFileTable">
									<colgroup>
										<col width="4%">
										<col width="32%">
										<col width="32%">
										<col width="32%">
									</colgroup>
									<thead class="table-light">
										<tr>
											<th class="text-center">No.</th>
											<th class="text-center"><span style="color:#ff0000;">*</span>등록일자</th>
											<th class="text-center"><span style="color:#ff0000;">*</span>등록자</th>
											<th class="text-center"><span style="color:#ff0000;">*</span>첨부파일</th>
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
			$('#page').css('grid-template-columns', '6fr 4px 4fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcol').removeClass('d-none');
		} else {
			$('#page').css('grid-template-columns', '0fr 4px 4fr');
			$('#leftcol').addClass('d-none');
			$('#rightcol').removeClass('d-none');
		}
		dataTableDrawAll(); // dataTable 전체 reload
	});
	
	$('#btnClose').on('click',function() { // right-box 닫기버튼 클릭
		if($('#leftcol').hasClass('d-none')){
			$('#page').css('grid-template-columns', '6fr 4px 4fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcol').removeClass('d-none');
		} else {
			$('#page').css('grid-template-columns', '6fr 4px 0fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcol').addClass('d-none');
		}
		dataTableDrawAll(); // dataTable 전체 reload
	});
</script>

<script>
	WM_init('new');
	WM_init('edit');

	$('#userModal').draggable({handle: ".modal-header"});
	
	// 공통코드 조회
	let dealGubunList = getCommonCode('시스템', '011'); // 거래구분
	let importantLevelList = getCommonCode('시스템', '012'); // 중요도
	let companyGubunList = getCommonCode('시스템', '013'); // 회사구분
	let paymentInfoList = getCommonCode('시스템', '014'); // 결제정보
	let dealCorpStatusList = getCommonCode('시스템', '015'); // 거래상태
	let statementStandardList = getCommonCode('시스템', '056'); // 명세서수량기준

	selectBoxAppend(dealGubunList, 'modalDealGubun', '', '1'); //거래구분
	selectBoxAppend(dealCorpStatusList, 'modalDealCorpStatus', '', '1'); //거래상태
	
	let idx = '';
	let userName = "${userName}";
	let formData = new FormData();
	let deleteData = '';
	let managerNumber = 0;
	let fileNumber = 0;
	
	function dealGubunReset() {
		let dealGubunHtml = '';
		for(var i in dealGubunList ) {
			dealGubunHtml += '<div class="form-check form-check-inline">';
			dealGubunHtml += '<input class="form-check-input" type="radio" value="'+dealGubunList[i].commonCd+'" name="dealGubun" id="dealGubun'+(parseInt(i)+1)+'">';
			dealGubunHtml += '<label class="form-check-label" for="dealGubun'+(parseInt(i)+1)+'">'+dealGubunList[i].commonNm+'</label>';
			dealGubunHtml += '</div>';
		}
		$('#dealGubunTd').html(dealGubunHtml);
	}
	
	dealGubunReset();
	$('input[name="dealGubun"]').attr('disabled', true);
	
	selectBoxAppend(importantLevelList, 'importantLevel', '', '2');
	selectBoxAppend(companyGubunList, 'companyGubun', '', '2');
	selectBoxAppend(paymentInfoList, 'paymentInfo', '', '2');
	selectBoxAppend(dealCorpStatusList, 'dealCorpStatus', '', '2');
	selectBoxAppend(dealCorpStatusList, 'searchDealCorpStatus', '001', '1');
	selectBoxAppend(statementStandardList, 'statementStandard', '', '2'); //명세서수량기준

	$('#tab1Nav').on('click',function() { // 기본정보 탭 클릭
		setTimeout(function() {
			$('#dealCorpManagerTable').DataTable().ajax.reload(function(){
				dealCorpManagerTable.draw(false);
			});
		}, 200);
	});

	$('#tab2Nav').on('click',function() { // 관련자료 탭 클릭
		setTimeout(function() {
			$('#dealCorpFileTable').DataTable().ajax.reload(function(){
				dealCorpFileTable.draw(false);
			});
		}, 200);
	});

	/*
	$('#searchDealCorpStatus').on('change',function() {
		let selectTextLength = $("#searchDealCorpStatus option:checked").text();
		console.log(parseInt(selectTextLength)*23)
		document.getElementById('(searchDealCorpStatus)').style.width = parseInt(selectTextLength) * 23;
	});
	*/
	
	
	// 거래처정보 목록 조회
	$('#dealCorpAdmTable thead tr').clone(true).addClass('filters').appendTo('#dealCorpAdmTable thead'); // filter 생성
	let dealCorpAdmTable = $('#dealCorpAdmTable').DataTable({
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
			url : '<c:url value="/bm/dealCorpAdmList"/>',
			type : 'POST',
			data : {
				dealCorpStatus: function() { return $('#searchDealCorpStatus').val(); }
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'dealGubunNm', className : 'text-center'},
			{ data: 'dealCorpCd', className : 'text-center'},
			{ data: 'dealCorpNm', className : 'text-center'},
			{ data: 'representative', className : 'text-center'},
			{ data: 'companyNumber', className : 'text-center'},
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
			let theadHeight = parseFloat($('#dealCorpAdmTable_wrapper').find('.dataTables_scrollHead').css('height'));
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
				let cell = $('#dealCorpAdmTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#dealCorpAdmTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	dealCorpAdmTable.on('column-reorder', function( e, settings, details ) {
		let api = dealCorpAdmTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#dealCorpAdmTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
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
		dealCorpAdmTable.ajax.reload(function() {});

		setTimeout(function() {
			$('#my-spinner').hide();
		}, 100)
	});

	// 거래처정보목록 click
	$('#dealCorpAdmTable tbody').on('click','tr', function() {
		idx = dealCorpAdmTable.row(this).data().idx;
		$('#salesManager').val('');
		$('#salesManagerNm').val('');
		managerNumber = 0;
		fileNumber = 0;
		if(WMCheck('new')) { // 신규등록중일 경우
			setWM('new', 'idx', idx);
			return false;
		}
		if(WMCheck('edit')) { // 수정중일 경우
			setWM('edit', 'idx', idx);
			return false;
		}
		dealCorpAdmTableSel();
		dealCorpManagerTable.ajax.reload(function() {});
		dealCorpFileTable.ajax.reload(function() {});
		formData = new FormData();
		
		
		$('input[name="dealGubun"]').attr('disabled', true);
		$('.inputGroup').attr('disabled', true); // 입력항목
		$('#btnUserIdCheck').attr('disabled', true); // 중복확인 버튼
		$('#btnSignImage').attr('disabled', true); // 사진선택 버튼

		$('#btnNew').attr('disabled', false); // 신규 버튼
		$('#btnSave').attr('disabled', true); // 저장 버튼
		$('#btnEdit').attr('disabled', false); // 수정 버튼
		$('#btnDel').attr('disabled', false); // 삭제 버튼
		$('#btnCancel').attr('disabled', true); // 취소 버튼
	});

	function dealCorpAdmTableSel() {
		let data;
		$.ajax({
			url: '<c:url value="/bm/dealCorpAdmSel"/>',
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


		$('input[name="dealGubun"]').val([data.dealGubun]);
		$('#workPlace').val(data.workPlaceNm);
		$('#workPlaceIdx').val(data.workPlaceIdx);
		$('#userId').val(data.userId);
		$('#dealCorpCd').val(data.dealCorpCd);
		$('#dealCorpNm').val(data.dealCorpNm);
		$('#representative').val(data.representative);
		$('#companyNumber').val(data.companyNumber);
		$('#masterItem').val(data.masterItem);
		$('#initial').val(data.initial);
		$('#postNumber').val(data.postNumber);
		$('#addressAdm').val(data.addressAdm);
		$('#addressDtl').val(data.addressDtl);
		$('#dealCorpAddress').val(data.dealCorpAddress);
		$('#importantLevel').val(data.importantLevel);
		$('#companyGubun').val(data.companyGubun);
		$('#phoneNumber').val(data.phoneNumber);
		$('#faxNumber').val(data.faxNumber);
		$('#salesManager').val(data.salesManager);
		$('#salesManagerNm').val(data.salesManagerNm);
		$('#paymentInfo').val(data.paymentInfo);
		$('#dealCorpStatus').val(data.dealCorpStatus);
		$('#statementStandard').val(data.statementStandard); //명세서수량기준
		$('#dealCorpDesc').val(data.dealCorpDesc);
		$('#outDealCorpIdx').val(data.outDealCorpIdx);
		$('#outDealCorp').val(data.outDealCorpNm)
		
	}


	//거래처정보 담당자 조회
	let dealCorpManagerTable = $('#dealCorpManagerTable').DataTable({
		language: lang_kor,
		info: false,
		ordering: true,
		processing: true,
		paging: false,
		lengthChange: false,
		searching: false,
		autoWidth: false,
		orderCellsTop: false,
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
			url : '<c:url value="/bm/dealCorpManagerList"/>',
			type : 'POST',
			data : {
				admIdx: function() { return idx; }
			},
		},
        rowId: 'idx',
		columns : [
			{
				render: function(data, type, row, meta) {
					managerNumber++;
					return '<div name="managerIndex">'+managerNumber+'</div>';
				}, "className": "text-center align-middle"
			},
			{ data: 'chargeDepartment',
				render: function(data, type, row, meta) {
					if(data!=null) {
						return '<input type="text" class="form-control inputGroup" name="chargeDepartment" value="'+data+'" disabled>';
					} else {
						return '<input type="text" class="form-control inputGroup" name="chargeDepartment" disabled>';
					}
				}
			},
			{ data: 'chargeName',
				render: function(data, type, row, meta) {
					if(data!=null) {
						return '<input type="text" class="form-control inputGroup" name="chargeName" value="'+data+'" disabled>';
					} else {
						return '<input type="text" class="form-control inputGroup" name="chargeName" disabled>';
					}
				}
			},
			{ data: 'chargePhoneNumber',
				render: function(data, type, row, meta) {
					if(data!=null) {
						return '<input type="text" class="form-control inputGroup" name="chargePhoneNumber" value="'+data+'" disabled>';
					} else {
						return '<input type="text" class="form-control inputGroup" name="chargePhoneNumber" disabled>';
					}
				}
			},
			{ data: 'chargeEmail',
				render: function(data, type, row, meta) {
					if(data!=null) {
						return '<input type="text" class="form-control inputGroup" name="chargeEmail" value="'+data+'" disabled>';
					} else {
						return '<input type="text" class="form-control inputGroup" name="chargeEmail" disabled>';
					}
				}
			},
		],
		drawCallback: function() {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			let htmlHeight = parseFloat($('html').css('height'));
			let table1_height = $('#tab1').find('table').eq(0).height();
			let theadHeight = parseFloat($('#dealCorpManagerTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - table1_height - 130 )+'px');
		},
		columnDefs : [],
		buttons : [],
		order : [],
	});

	//거래처정보 관련파일 조회
	$('#dealCorpFileTable thead tr').clone(true).addClass('filters').appendTo('#dealCorpFileTable thead'); // filter 생성
	let dealCorpFileTable = $('#dealCorpFileTable').DataTable({
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
		colReorder: true,
		select: {
            style: 'single',
            toggleable: false,
            items: 'row',
            info: false
        },
        ajax : {
			url : '<c:url value="/bm/dealCorpFileList"/>',
			type : 'POST',
			data : {
				admIdx: function() { return idx; }
			},
		},
        rowId: 'idx',
		columns : [
			{
				render: function(data, type, row, meta) {
					fileNumber++;
					return '<div name="fileIndex">'+fileNumber+'</div>';
				}, "className": "text-center align-middle"
			},
			{ data: 'regDate',
				render: function(data, type, row, meta) {
					if(row['insertYn']=='001') {
						return moment(data,'YYYY-MM-DD HH:mm:ss.000').format('YYYY-MM-DD');
					} else {
						return moment().format('YYYY-MM-DD');
					}
				}, "className": "text-center align-middle"
			},
			{ data: 'regName'},
			{ data: 'fileName',
				render: function(data, type, row, meta) {
					if(row['insertYn']=='001') {
						return "<a href=\"#\" onclick=\"dealCorpFileDownload(\'"+row['uuid']+"\',\'"+row['fileName']+"\',\'"+row['fileExt']+"\')\">"+row['fileName']+"."+row['fileExt']+"</a>";
					} else {
						return data;
					}
				}
			},
		],
		drawCallback: function() {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#dealCorpFileTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 120)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAllDcf').off('keyup',function() {});
			$('#searchAllDcf').on('keyup',function() {
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

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

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
		columnDefs : [],
		buttons : [],
		order : [],
	});
	// dataTable colReorder event
	dealCorpFileTable.on('column-reorder', function( e, settings, details ) {
		let api = dealCorpFileTable;
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
				idx = getWM(WMlastIdx, 'idx');
				WM_action_OFF(WMlastIdx);
				setWM(WMlastIdx, 'idx', '');
				dealCorpAdmTable.row('#'+idx).select();
				$(dealCorpAdmTable.row('#'+idx).node()).trigger('click'); // 선택했던 항목 선택처리
				
				$('#btnManagerAdd').attr('disabled', true); // 추가 버튼
				$('#btnManagerDel').attr('disabled', true); // 삭제 버튼
				$('#btnFileAdd').attr('disabled', true); // 추가 버튼
				$('#btnFileDel').attr('disabled', true); // 삭제 버튼
				formData = new FormData();
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
				$('#btnManagerAdd').attr('disabled', true); // 추가 버튼
				$('#btnManagerDel').attr('disabled', true); // 삭제 버튼
				$('#btnFileAdd').attr('disabled', true); // 추가 버튼
				$('#btnFileDel').attr('disabled', true); // 삭제 버튼
				formData = new FormData();
			}
			
			return false;
		}
	});

	// 신규 버튼 click
	$('#btnNew').on('click', function() {
		$('#btnSave').data('saveType','insert'); // 저장 방식 -> 등록
		
		WM_action_ON('new', 'workingWarningModal');
		formData = new FormData();
		$('.inputGroup').val('');
		$('#salesManager').val('');
		$('#salesManagerNm').val('');
		dealGubunReset();
		$('#dealCorpStatus').val('001');
		$('#statementStandard').val('001'); //명세서수량기준 - 발주량
		
		$('input[name="dealGubun"]').attr('disabled', false);
		
		$('.inputGroup').attr('disabled', false); // 입력항목
		$('#btnUserIdCheck').attr('disabled', false); // 중복확인 버튼
		$('#btnSignImage').attr('disabled', false); // 사진선택 버튼
		
		$('#btnNew').attr('disabled', true); // 신규 버튼
		$('#btnSave').attr('disabled', false); // 저장 버튼
		$('#btnEdit').attr('disabled', true); // 수정 버튼
		$('#btnDel').attr('disabled', true); // 삭제 버튼
		$('#btnCancel').attr('disabled', false); // 취소 버튼
		$('#btnManagerAdd').attr('disabled', false); // 추가 버튼
		$('#btnManagerDel').attr('disabled', false); // 삭제 버튼
		$('#btnFileAdd').attr('disabled', false); // 추가 버튼
		$('#btnFileDel').attr('disabled', false); // 삭제 버튼
		$('#dealCorpManagerTable').DataTable().clear().draw();	//담당자 테이블 초기화
		$('#dealCorpFileTable').DataTable().clear().draw();	//관련파일 테이블 초기화
		
		$('#dealCorpCd').attr('disabled', true); // 거래처코드
		$('#salesManagerNm').attr('disabled', true); // 본사영업담당명
	});

	// 담당자 추가 버튼 클릭
	$('#btnManagerAdd').on('click', function() {
    	$('#dealCorpManagerTable').DataTable().row.add({
    			'chargeDepartment'	: null,
    			'chargeName'		: null,
    			'chargePhoneNumber'	: null,
    			'chargeEmail'		: null,
		}).draw(false);
		managerNumber = 1;
    	$('#dealCorpManagerTable tbody tr').each(function(index, item){
    		$(this).find("div[name=managerIndex]").text(managerNumber);
    		managerNumber++;
        });
    	$('.inputGroup').attr('disabled', false); // 입력항목
	});

	// 담당자 삭제 버튼 클릭
	$('#btnManagerDel').on('click', function() {
		if ($('#dealCorpManagerTable tbody').find('tr.selected').length == 0) {
			toastr.warning("삭제할 데이터를 선택해 주세요.");
			return false;
		}
		$('#dealCorpManagerTable').DataTable().row('.selected').remove().draw();
		managerNumber = 1;
		$('#dealCorpManagerTable tbody tr').each(function(index, item){
    		$(this).find("div[name=managerIndex]").text(managerNumber);
    		managerNumber++;
        });
	});

	// 관련파일 추가 버튼 클릭
	$('#btnFileAdd').on('click', function() {
		$('#dealCorpFile').trigger('click');
	});

	// 파일 선택
	$('#dealCorpFile').on('change',function() {
		let fileInput = document.getElementById("dealCorpFile"); //id로 파일 태그를 호출
		let files = fileInput.files;		//업로드한 파일들의 정보를 넣는다.
		for(let i=0; i<files.length; i++ ) {
			let uuid = uuid_v4();

			let fileNameList = files[i].name.split('.');
			let fileFullNm = _.slice(fileNameList, 0, -1).join('.');
			
			$('#dealCorpFileTable').DataTable().row.add({
				'uuid'		: uuid,
				'fileName'	: fileFullNm,
				'fileExt'	: files[i].name.split('.').at(-1),
				'regName'	: userName,
				'regDate'	: null,
				'insertYn'	: '002'
			}).draw(false);
			
			formData.append('file-'+uuid,files[i]);
			formData.append('uuid-'+uuid,uuid);
			formData.append('ext-'+uuid,files[i].name.split('.').at(-1));
		}
		fileNumber = 1;
    	$('#dealCorpFileTable tbody tr').each(function(index, item){
    		$(this).find("div[name=fileIndex]").text(fileNumber);
    		fileNumber++;
        });
	})
	
	// 파일 다운로드
	function dealCorpFileDownload(uuid, fileName, ext) {
		fileDownload({uuid:uuid, fileName:fileName, ext:ext});
	}

	// 관련파일 삭제 버튼 클릭
	$('#btnFileDel').on('click', function() {
		
		if ($('#dealCorpFileTable tbody').find('tr.selected').length == 0) {
			toastr.warning("삭제할 데이터를 선택해 주세요.");
			return false;
		}
		
		if($('#dealCorpFileTable').DataTable().row('.selected').data().insertYn=='001') {
			deleteData = 'FILE';
			$('#deleteModal').modal('show');
		} else {
			let uuid = dealCorpFileTable.row('.selected').data().uuid;
			formData.delete('file-'+uuid);
			formData.delete('uuid-'+uuid);
			formData.delete('ext-'+uuid);
			$('#dealCorpFileTable').DataTable().row('.selected').remove().draw();
			fileNumber = 1;
	    	$('#dealCorpFileTable tbody tr').each(function(index, item){
	    		$(this).find("div[name=fileIndex]").text(fileNumber);
	    		fileNumber++;
	        });
		}
	});

	
	// 저장 버튼 click
	$('#btnSave').on('click', function() {
		let saveType = $(this).data('saveType');
		let admCheck = true;
		let managerCheck = true;
		let fileCheck = true;
		new Promise((resolve, reject) => {
			setTimeout(function() {
				$('#my-spinner').show();
			},50)
			$('#my-spinner').show();
			setTimeout(function() {
				if($('input[name="dealGubun"]:checked').val() == undefined) {
					toastr.warning('거래구분을 선택해주세요.');
					$('#dealGubunTd').select();
					admCheck = false;
					managerCheck = false;
					fileCheck = false;
					$('#my-spinner').hide();
					return false;
				}
				
// 				if($('#dealCorpCd').val() == '') { 거래처코드 자동채번 기능으로 인해 입력 체크 기능 불필요 - 2023.10.06
// 					toastr.warning('거래처코드를 입력해주세요.');
// 					$('#dealCorpCd').select();
// 					admCheck = false;
// 					managerCheck = false;
// 					fileCheck = false;
// 					$('#my-spinner').hide();
// 					return false;
// 				}
				
				if($('#dealCorpNm').val() == '') {
					toastr.warning('업체명(약식)을 입력해주세요.');
					$('#dealCorpNm').select();
					admCheck = false;
					managerCheck = false;
					fileCheck = false;
					$('#my-spinner').hide();
					return false;
				}

				if($('#companyNumber').val() != '') {
					//사업자번호 형식 체크 xxx-xx-xxxxx
					let companyNumberList = $('#companyNumber').val().split('-');
					
					if(companyNumberList.length!=3) {
						toastr.warning('사업자번호를 형식에 맞게 입력해주세요.');
						$('#companyNumber').select();
						admCheck = false;
						managerCheck = false;
						fileCheck = false;
						$('#my-spinner').hide();
						return false;
					}
					if(companyNumberList[0].length!=3) {
						toastr.warning('사업자번호를 형식에 맞게 입력해주세요.');
						$('#companyNumber').select();
						admCheck = false;
						managerCheck = false;
						fileCheck = false;
						$('#my-spinner').hide();
						return false;
					}
					if(companyNumberList[1].length!=2) {
						toastr.warning('사업자번호를 형식에 맞게 입력해주세요.');
						$('#companyNumber').select();
						admCheck = false;
						managerCheck = false;
						fileCheck = false;
						$('#my-spinner').hide();
						return false;
					}
					if(companyNumberList[2].length!=5) {
						toastr.warning('사업자번호를 형식에 맞게 입력해주세요.');
						$('#companyNumber').select();
						admCheck = false;
						managerCheck = false;
						fileCheck = false;
						$('#my-spinner').hide();
						return false;
					}
				}

				if($('#dealCorpStatus').val() == '') {
					toastr.warning('거래상태를 선택해주세요.');
					$('#my-spinner').hide();
					admCheck = false;
					managerCheck = false;
					fileCheck = false;
					$('#dealCorpStatus').select();
					return false;
				}
				
				let dataArray = new Array();
				if( $('#dealCorpManagerTable').DataTable().rows().count()>0 ){
					$('#dealCorpManagerTable tbody tr').each(function(index, item){
						if ($(this).find("td input[name=chargeDepartment]").val()=="") {				 
							toastr.warning('담당부서를 입력해주세요');	
							admCheck = false;
							managerCheck = false;
							fileCheck = false;
							$('#my-spinner').hide();
							return false;
						}
	
						if ($(this).find("td input[name=chargeName]").val()=="") {				 
							toastr.warning('담당자명을 입력해주세요');	
							admCheck = false;
							managerCheck = false;
							fileCheck = false;
							$('#my-spinner').hide();
							return false;
						}

						if ($(this).find("td input[name=chargePhoneNumber]").val()=="") {				 
							toastr.warning('연락처를 입력해주세요');	
							admCheck = false;
							managerCheck = false;
							fileCheck = false;
							$('#my-spinner').hide();
							return false;
						}
	
						if($(this).find("td input[name=chargeEmail]").val() == '') {
							toastr.warning('이메일을 입력해주세요.');
							$(this).find("td input[name=chargeEmail]").select();
							admCheck = false;
							managerCheck = false;
							fileCheck = false;
							$('#my-spinner').hide();
							return false;
						} else { // 정규식 확인
							let regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
							if($(this).find("td input[name=chargeEmail]").val().match(regExp) == null) { // 정규식에 맞지 않을 경우
								toastr.warning('이메일 형식이 잘못되었습니다.');
								$(this).find("td input[name=chargeEmail]").select();
								admCheck = false;
								managerCheck = false;
								fileCheck = false;
								$('#my-spinner').hide();
								return false;
							}
						}
						var rowData = new Object();
						rowData.admIdx= '';
						rowData.chargeDepartment = $(this).find("td input[name=chargeDepartment]").val();
						rowData.chargeName = $(this).find("td input[name=chargeName]").val();
						rowData.chargePhoneNumber = $(this).find("td input[name=chargePhoneNumber]").val();
						rowData.chargeEmail = $(this).find("td input[name=chargeEmail]").val();
				        dataArray.push(rowData);
					});
					
				} else {
					managerCheck = false;
				}
				
				let fileData = new Array();
	
				if( $('#dealCorpFileTable').DataTable().rows().count()>0 ){
					$('#dealCorpFileTable tbody tr').each(function(index, item){
						if(dealCorpFileTable.row(this).data().insertYn=='002') {
							var rowData = new Object();
							rowData.admIdx = '';
							rowData.uuid= dealCorpFileTable.row(this).data().uuid;
							rowData.fileName = dealCorpFileTable.row(this).data().fileName;
							rowData.fileExt = dealCorpFileTable.row(this).data().fileExt;
							fileData.push(rowData);
						}
					});
					if(fileData.length==0) {
						fileCheck = false;
					}
				} else {
					fileCheck = false;
				}
				
				idx = '';
				if(admCheck) {
					// 등록할 경우에
					if(saveType == 'insert') {
						$.ajax({
							url: '<c:url value="/bm/dealCorpAdmIns"/>',
				            type: 'POST',
				            async: false,
				            data: {
				                'workPlaceIdx'		:	$('#workPlaceIdx').val(),
				            	'dealGubun'			:	$('input[name="dealGubun"]:checked').val(),
				                'dealCorpCd'		:	$('#dealCorpCd').val(),
				                'dealCorpNm'		:	$('#dealCorpNm').val(),
				                'representative'	:	$('#representative').val(),
				                'companyNumber'		:	$('#companyNumber').val(),
				                'postNumber'		:	$('#postNumber').val(),
				                'masterItem'		:	$('#masterItem').val(),
				                'initial'			:	$('#initial').val(),
				                'addressAdm'		:	$('#addressAdm').val(),
				                'addressDtl'		:	$('#addressDtl').val(),
				                'importantLevel'	:	$('#importantLevel').val(),
				                'companyGubun'		:	$('#companyGubun').val(),
				                'phoneNumber'		:	$('#phoneNumber').val(),
				                'faxNumber'			:	$('#faxNumber').val(),
				                'salesManager'		:	$('#salesManager').val(),
				                'paymentInfo'		:	$('#paymentInfo').val(),
				                'dealCorpStatus'	:	$('#dealCorpStatus').val(),
				                'statementStandard'	:	$('#statementStandard').val(), //명세서수량기준
				                'dealCorpDesc'		:	$('#dealCorpDesc').val(),
				                'dealCorpAddress'	:	$('#dealCorpAddress').val(),
				                'outDealCorpIdx'	:	function(){ return $('#outDealCorpIdx').val(); },
				            },
				            beforeSend: function() {
				            	//$('#my-spinner').show();
				            },
							success : function(res) {
								if (res.result == "ok") { //응답결과
									toastr.success('신규 저장되었습니다.');
									idx = res.idx;
									$('#btnSearch').trigger('click'); // 조회버튼 click
									
	
									WM_action_OFF('new');
									$('input[name="dealGubun"]').attr('disabled', true);
									$('.inputGroup').attr('disabled', true); // 입력항목
									$('#btnNew').attr('disabled', false); // 신규 버튼
									$('#btnSave').attr('disabled', true); // 저장 버튼
									$('#btnEdit').attr('disabled', true); // 수정 버튼
									$('#btnDel').attr('disabled', true); // 삭제 버튼
									$('#btnCancel').attr('disabled', true); // 취소 버튼
									$('#btnManagerAdd').attr('disabled', true); // 추가 버튼
									$('#btnManagerDel').attr('disabled', true); // 삭제 버튼
									$('#btnFileAdd').attr('disabled', true); // 추가 버튼
									$('#btnFileDel').attr('disabled', true); // 삭제 버튼
								} else if(res.result == 'fail') {
									$('#my-spinner').hide();
									managerCheck = false;
									fileCheck = false;
									toastr.warning(res.message);
								} else {
									toastr.error(res.message);
								}
							}
						});
					} else { // 수정할 경우에
						idx = dealCorpAdmTable.row('.selected').data().idx;
						$.ajax({
							url: '<c:url value="/bm/dealCorpAdmUpd"/>',
				            type: 'POST',
				            async: false,
				            data: {
				                'idx'				:	idx,
				                'workPlaceIdx'		:	$('#workPlaceIdx').val(),
				                'dealGubun'			:	$('input[name="dealGubun"]:checked').val(),
				                'dealCorpCd'		:	$('#dealCorpCd').val(),
				                'dealCorpNm'		:	$('#dealCorpNm').val(),
				                'representative'	:	$('#representative').val(),
				                'companyNumber'		:	$('#companyNumber').val(),
				                'masterItem'		:	$('#masterItem').val(),
				                'initial'			:	$('#initial').val(),
				                'postNumber'		:	$('#postNumber').val(),
				                'addressAdm'		:	$('#addressAdm').val(),
				                'addressDtl'		:	$('#addressDtl').val(),
				                'importantLevel'	:	$('#importantLevel').val(),
				                'companyGubun'		:	$('#companyGubun').val(),
				                'phoneNumber'		:	$('#phoneNumber').val(),
				                'faxNumber'			:	$('#faxNumber').val(),
				                'salesManager'		:	$('#salesManager').val(),
				                'paymentInfo'		:	$('#paymentInfo').val(),
				                'dealCorpStatus'	:	$('#dealCorpStatus').val(),
				                'statementStandard'	:	$('#statementStandard').val(), //명세서수량기준
				                'dealCorpDesc'		:	$('#dealCorpDesc').val(),
				                'dealCorpAddress'	:	$('#dealCorpAddress').val(),
				                'outDealCorpIdx'	:	function(){ return $('#outDealCorpIdx').val(); },
				            },
				            beforeSend: function() {
				            	//$('#my-spinner').show();
				            },
							success : function(res) {
								if (res.result == "ok") { //응답결과
									toastr.success('수정 저장되었습니다.');
	
									$('#btnSearch').trigger('click'); // 조회버튼 click
	
									WM_action_OFF('edit');
									$('input[name="dealGubun"]').attr('disabled', true);
									$('.inputGroup').attr('disabled', true); // 입력항목
									$('#btnNew').attr('disabled', false); // 신규 버튼
									$('#btnSave').attr('disabled', true); // 저장 버튼
									$('#btnEdit').attr('disabled', true); // 수정 버튼
									$('#btnDel').attr('disabled', true); // 삭제 버튼
									$('#btnCancel').attr('disabled', true); // 취소 버튼
									$('#btnManagerAdd').attr('disabled', true); // 추가 버튼
									$('#btnManagerDel').attr('disabled', true); // 삭제 버튼
									$('#btnFileAdd').attr('disabled', true); // 추가 버튼
									$('#btnFileDel').attr('disabled', true); // 삭제 버튼
									idx = dealCorpAdmTable.row('.selected').data().idx;
									dealCorpAdmTable.row('#'+idx).select();
									//$(dealCorpAdmTable.row('#'+idx).node()).trigger('click'); // 선택했던 항목 선택처리
								} else if(res.result == 'fail') {
									$('#my-spinner').hide();
									managerCheck = false;
									fileCheck = false;
									toastr.warning(res.message);
								} else {
									toastr.error(res.message);
								}
							}
						});
					}
				}
				if(managerCheck) {
					dataArray[0].admIdx = idx;
					$.ajax({
						url: '<c:url value="/bm/dealCorpManagerIns"/>',
						type : 'POST',
						async: false,
						datatype: 'json',
						data: JSON.stringify(dataArray),
						contentType : "application/json; charset=UTF-8",
						beforeSend: function() {
			            	//$('#my-spinner').show();
			            },
						success : function(res) {		
						},
					});
				}
	
				if(fileCheck) {
					let fileFormData = new FormData();
					let fileSubKeyIndex = 1;
					let fileKeyIndex = 0; 
					for (var key of formData.keys()) {
						if(fileSubKeyIndex==1) {
							fileFormData.append(key, formData.get(key));
						} else if(fileSubKeyIndex==2) {
							fileFormData.append('uuid', formData.get(key));
						} else {
							fileFormData.append('ext', formData.get(key));
						} 
						fileSubKeyIndex++;
						
						if(fileSubKeyIndex==3) {
							fileSubKeyIndex = 0;
							fileKeyIndex++;
						}
					}
					fileUpload(fileFormData);
					if(fileData.length>0) {
						fileData[0].admIdx = idx;
					}
					
					$.ajax({
						url: '<c:url value="/bm/dealCorpFileIns"/>',
						type : 'POST',
						async: false,
						datatype: 'json',
						data: JSON.stringify(fileData),
						contentType : "application/json; charset=UTF-8",
						beforeSend: function() {
			            	//$('#my-spinner').show();
			            },
						success : function(res) {
							fileNumber = 0;
							formData = new FormData();
							dealCorpFileTable.ajax.reload(function() {});
						},
					});
				}
			},100)
		})
		$('#my-spinner').hide();
	});

	// 수정 버튼 click
	$('#btnEdit').on('click', function() {
		$('#btnSave').data('saveType','update'); // 저장 방식 -> 수정
		//formData = new FormData();
		WM_action_ON('edit', 'workingWarningModal');
		$('input[name="dealGubun"]').attr('disabled', false);
		$('.inputGroup').attr('disabled', false); // 입력항목
		$('#btnUserIdCheck').attr('disabled', false); // 중복확인 버튼
		$('#btnSignImage').attr('disabled', false); // 사진선택 버튼
		
		$('#btnNew').attr('disabled', true); // 신규 버튼
		$('#btnSave').attr('disabled', false); // 저장 버튼
		$('#btnEdit').attr('disabled', true); // 수정 버튼
		$('#btnDel').attr('disabled', true); // 삭제 버튼
		$('#btnCancel').attr('disabled', false); // 취소 버튼
		$('#btnManagerAdd').attr('disabled', false); // 추가 버튼
		$('#btnManagerDel').attr('disabled', false); // 삭제 버튼
		$('#btnFileAdd').attr('disabled', false); // 추가 버튼
		$('#btnFileDel').attr('disabled', false); // 삭제 버튼

		$('#dealCorpCd').attr('disabled', true); // 거래처코드
		$('#dealCorpNm').attr('disabled', false); // 업체명(약식)
		$('#salesManagerNm').attr('disabled', true); // 본사영업담당명
		
	});

	// 삭제 버튼 click
	$('#btnDel').on('click', function() {
		deleteData = 'ADM';
		$('#deleteModal').modal('show');
	});

	// 삭제 경고창 삭제 버튼 click
	$('#btnDeleteModalY').on('click', function() {
		idx = dealCorpAdmTable.row('.selected').data().idx;
		if(deleteData=='ADM') {
			if( $('#dealCorpFileTable').DataTable().rows().count()>0 ){
				$('#dealCorpFileTable tbody tr').each(function(index, item){
					if(dealCorpFileTable.row(this).data().insertYn=='001') {
						let uuid = dealCorpFileTable.row(this).data().uuid;
						let ext = dealCorpFileTable.row(this).data().fileExt;
						fileDelete({uuid:uuid,ext:ext});
					}
				});
			}
			$.ajax({
				url: '<c:url value="/bm/dealCorpAdmDel"/>',
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
						$('#salesManager').val('');
						$('#salesManagerNm').val('');
						dealGubunReset();
						$('input[name="dealGubun"]').attr('disabled', true);						

						$('#btnNew').attr('disabled', false); // 신규 버튼
						$('#btnSave').attr('disabled', true); // 저장 버튼
						$('#btnEdit').attr('disabled', true); // 수정 버튼
						$('#btnDel').attr('disabled', true); // 삭제 버튼
						$('#btnCancel').attr('disabled', true); // 취소 버튼
						$('#btnManagerAdd').attr('disabled', true); // 추가 버튼
						$('#btnManagerDel').attr('disabled', true); // 삭제 버튼
						$('#btnFileAdd').attr('disabled', true); // 추가 버튼
						$('#btnFileDel').attr('disabled', true); // 삭제 버튼
						$('#dealCorpManagerTable').DataTable().clear().draw();	//담당자 테이블 초기화
						$('#dealCorpFileTable').DataTable().clear().draw();	//관련파일 테이블 초기화
						$('#my-spinner').hide();
					} else if(res.result == 'fail') {
						toastr.warning(res.message);
					} else {
						toastr.error(res.message);
					}
				}
			});
		} else {
			$.ajax({
				url: '<c:url value="/bm/dealCorpFileDel"/>',
	            type: 'POST',
	            async: false,
	            data: {
	                'admIdx'	:	idx,
	                'idx'		:	$('#dealCorpFileTable').DataTable().row('.selected').data().idx
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					let uuid = $('#dealCorpFileTable').DataTable().row('.selected').data().uuid;;
					let ext = $('#dealCorpFileTable').DataTable().row('.selected').data().fileExt;
					fileDelete({uuid:uuid,ext:ext});
					if (res.result == "ok") { //응답결과
						toastr.success('삭제되었습니다.');
						$('#dealCorpFileTable').DataTable().row('.selected').remove().draw();
						fileNumber = 1;
				    	$('#dealCorpFileTable tbody tr').each(function(index, item){
				    		$(this).find("div[name=fileIndex]").text(fileNumber);
				    		fileNumber++;
				        });
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

		dealCorpManagerTable.ajax.reload(function() {});
		dealCorpFileTable.ajax.reload(function() {});
		dealCorpAdmTableSel();
		$('#btnNew').attr('disabled', false); // 신규 버튼
		$('#btnSave').attr('disabled', true); // 저장 버튼
		$('#btnEdit').attr('disabled', true); // 수정 버튼
		$('#btnDel').attr('disabled', true); // 삭제 버튼
		$('#btnCancel').attr('disabled', true); // 취소 버튼
		$('#btnManagerAdd').attr('disabled', true); // 추가 버튼
		$('#btnManagerDel').attr('disabled', true); // 삭제 버튼
		$('#btnFileAdd').attr('disabled', true); // 추가 버튼
		$('#btnFileDel').attr('disabled', true); // 삭제 버튼
	});
	
	$("#zipNumber").on("click",function(){
		fn_jusoPopup();
	});

	//input click event
	function fn_jusoPopup(){
		// 주소검색을 수행할 팝업 페이지를 호출합니다.
		// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(https://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
		var pop = window.open("/popup/jusoPopup","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
		
		// 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(https://www.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
	    //var pop = window.open("/popup/jusoPopup.jsp","pop","scrollbars=yes, resizable=yes"); 
	}

	var mySggNm = '';
	var myEmdNm = '';
	var mySiNm = '';
	var myZipNo;
	
	function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo){
		console.log("road full" + roadFullAddr, "road part 1"+roadAddrPart1, "add Detail"+addrDetail, "load Part 2"+roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo);			
		//인풋 벨류
		$("#search-input").val(roadFullAddr);
		//값 넣어주기
		$("#postNumber").val(zipNo);
		$("#addressAdm").val(roadAddrPart1);
		$("#addressDtl").val(addrDetail);
		mySggNm = sggNm;
		myEmdNm = emdNm;
		mySiNm = siNm;
		myZipNo = zipNo;
	     
		console.log(myZipNo + "= zipNo" , mySiNm + "= siNm"  ,mySggNm + "= sggNm" , myEmdNm + "emdNm" );
	}
	$("#btnSalesManagerSel").on("click",function(){
		$('#userModal').modal('show');
		setTimeout(function() {
			userModalTable.ajax.reload(function() {});
		}, 200);
	});
	
	// 사용자정보 목록조회
	$('#userModalTable thead tr').clone(true).addClass('filters').appendTo('#userModalTable thead'); // filter 생성
	let userModalTable = $('#userModalTable').DataTable({
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
			{ data: 'userDepartmentCd', className : 'text-center'},
			{ data: 'userPositionCd', className : 'text-center'},
			{ data: 'userJobCd', className : 'text-center'},
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
			let theadHeight = parseFloat($('#userModalTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 197)+'px');
			
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
				let cell = $('#userModalTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#userModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	userModalTable.on('column-reorder', function( e, settings, details ) {
		let api = userModalTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#userModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	// 사용자모달 조회 버튼 click
	$('#btnUserModalSearch').on('click', function() {
		userModalTable.ajax.reload(function(){});
	});
	
	// 사용자목록 적용 버튼 click
	$('#btnUserModalPaste').on('click', function(){
		if( !$('#userModalTable tbody tr').hasClass('selected') ){
			toastr.warning('적용할 행을 선택해주세요.');
			return false;
		}
		
		let data = userModalTable.row('.selected').data();
		$('#salesManager').val(data.idx);
		$('#salesManagerNm').val(data.userName);
		$('#userModal').modal('hide');
	});

	// 본사영업담당 삭제
	$('#btnSalesManagerDelete').on('click', function() {
		$('#salesManager').val('');
		$('#salesManagerNm').val('');
	});


	// 사업자번호 MASK
	$(document).on('keyup',"#companyNumber", function(event){
		//백스페이스바를 누를땐 하이픈이 생기지 않음
		if(event.which != 8) {
			if($(this).val().length==3) {
				$(this).val($(this).val()+'-');
			} else if($(this).val().length==6) {
				$(this).val($(this).val()+'-');
			}
		}
	});

	
	/* 사업장 모달  */
	$('#btnWorkPlace').on('click',function(){
		$('#workPlaceModal').modal('show');
		setTimeout(function() {
			workPlaceModalTable.ajax.reload(function(){});
		},200);
	});

	$('#btnWorkPlaceModalPaste').on('click',function(){
		if(!$('#workPlaceModalTable tbody tr').hasClass('selected')){
			toastr.warning('붙여넣을 행을 선택해주세요.');
			return false;
		}
		let data = workPlaceModalTable.row('.selected').data();
		$('#workPlace').val(data.workplaceNm);
		$('#workPlaceIdx').val(data.idx);

		$('#workPlaceModal').modal('hide');
	});
	
	$('#btnWorkPlaceDelete').on('click',function(){
		$('#workPlace').val('');
		$('#workPlaceIdx').val('');
	});
		
	$('#workPlaceModalTable thead tr').clone(true).addClass('filters').appendTo('#workPlaceModalTable thead'); // filter 생성
	let workPlaceModalTable = $('#workPlaceModalTable').DataTable({
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
			let theadHeight = parseFloat($('#workPlaceModalTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 197)+'px');
			
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
				let cell = $('#workPlaceModalTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#workPlaceModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	workPlaceModalTable.on('column-reorder', function( e, settings, details ) {
		let api = workPlaceModalTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#workPlaceModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});
	
	$('#workPlaceModalTable tbody').on('dblclick','tr',function(){
		let data = workPlaceModalTable.row(this).data();
		$('#workPlace').val(data.workplaceNm);
		$('#workPlaceIdx').val(data.idx);

		$('#workPlaceModal').modal('hide');
	});	

	// 거래처정보 목록 조회
	$('#dealCorpModalTable thead tr').clone(true).addClass('filters').appendTo('#dealCorpModalTable thead'); // filter 생성
	let dealCorpModalTable = $('#dealCorpModalTable').DataTable({
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
			url : '<c:url value="/bm/dealCorpAdmList"/>',
			type : 'POST',
			data : {
				dealGubun : function(){ return $('#modalDealGubun').val();},
				dealCorpStatus: function() { return $('#modalDealCorpStatus').val(); }
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'dealGubunNm', className : 'text-center'},
			{ data: 'dealCorpCd', className : 'text-center'},
			{ data: 'initial', className : 'text-center'},
			{ data: 'dealCorpNm', className : 'text-center'},
			{ data: 'representative', className : 'text-center'},
			{ data: 'companyNumber', className : 'text-center'},
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
			let theadHeight = parseFloat($('#dealCorpModalTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 234)+'px');
			
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
				let cell = $('#dealCorpModalTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#dealCorpModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	dealCorpModalTable.on('column-reorder', function( e, settings, details ) {
		let api = dealCorpModalTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#dealCorpModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});
	
	$('#btnOutDealCorp').on('click',function(){
		$('#modalDealGubun').val('003');
		$('#dealCorpModal').modal('show');
	});
	
	$('#dealCorpModal').on('shown.bs.modal', function() {
		dealCorpModalTable.ajax.reload(function() {});
	});

	$('#btnDealCorpModalSearch').on('click', function(){
		dealCorpModalTable.ajax.reload(function() {});
	});

	$('#btnDealCorpModalPaste').on('click',function(){
		if( !$('#dealCorpModalTable tbody tr').hasClass('selected') ){
			toastr.warning('적용할 행을 선택해주세요.');
			return false;
		}

		let data = dealCorpModalTable.row('.selected').data();
		workPlaceIdxVal = data.workPlaceIdx;
		customerIdxVal = data.idx;
		$('#outDealCorpIdx').val(data.idx);
		$('#outDealCorp').val(data.dealCorpNm)

		$('#dealCorpModal').modal('hide');
	});
</script>

</body>
</html>