<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/top.jsp"%>
<%@include file="../layout/modal.jsp"%>
<%@include file="../layout/script.jsp"%>
<div id="page" onmouseup="EndDrag()" onmousemove="OnDrag(event)" style="grid-template-areas: 'leftcol dragbar rightcol';
																		  grid-template-rows: 1fr;
																		  grid-template-columns: 2fr 4px 3fr;">
	<div id="leftcol">
		<div class="container-fluid h-100" style="padding: 5px;">
			<div class="row" id="leftHeader" style="padding-bottom: 5px;">
				<div class="d-flex align-items-center d-flex">
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">수주등록일</label>
					<input type="date" max="9999-12-31" class="form-control w-auto h-100 me-1" id="startDate">
					<label class="form-label d-flex align-items-center m-0 me-1 h-100">~</label>
					<input type="date" max="9999-12-31" class="form-control w-auto h-100 me-1" id="endDate">
					<select class="form-select w-auto h-100 me-3 monthAdjust" id="monthAdjust">
					</select>
					<div class="btn-group me-3" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto monthAdjustBtn" data-val="3">
							3개월
						</button>
						<button type="button" class="btn btn-outline-light w-auto monthAdjustBtn" data-val="6">
							6개월
						</button>
						<button type="button" class="btn btn-outline-light w-auto monthAdjustBtn" data-val="12">
							12개월
						</button>
					</div>
					
					<input type="text" class="form-control w-auto h-100 me-1 d-none" id="searchAllAdm" placeholder="통합검색" >
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end">
					<div class="btn-group" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnSearch"><i class="fa-regular fa-clipboard"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnOpen"><i class="fa-solid fa-caret-left"></i></button>
					</div>
				</div>
			</div>
			<div class="row">
				<table class="table table-bordered p-0 m-0" id="bizOrderDealCorpTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle">수주처코드</th>
							<th class="text-center align-middle">수주처명</th>
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
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">차량배정</label>
					<select class="form-select w-auto h-100 me-1" id="carAssignment" style="min-width: 70px;">
					</select>
					
					<div class="d-flex align-items-center justify-content-end me-3">
						<div class="btn-group" role="group" aria-label="Small button group">
							<button type="button" class="btn btn-outline-light w-auto" id="btnCopy">
								<!-- <i class="fa-regular fa-copy"></i> -->
								적용
							</button>
						</div>
					</div>
					
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">조회대상</label>
					<select class="form-select w-auto h-100 me-3" id="searchTarget" style="min-width: 70px;">
						<option value="">전체</option>
						<option value="N" selected>출고대상</option>
					</select>
					<!-- <input type="text" class="form-control w-auto h-100 me-1" id="searchAllDtl" placeholder="통합검색" > -->
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end">
					<div class="btn-group me-3" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto" id="btnBizDtlPoEnd">PO완료</button>
					</div>
				
					<div class="btn-group" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnDtlSearch"><i class="fa-regular fa-clipboard"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnSave" disabled><i class="fa-regular fa-floppy-disk"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnEdit" ><i class="fa-regular fa-pen-to-square"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnCancel" disabled><i class="fa-solid fa-xmark"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnClose"><i class="fa-solid fa-caret-right"></i></button>
					</div>
				</div>
			</div>
			<div class="row">
				<table class="table table-bordered p-0 m-0" id="bizOrderDtlTable">
					<thead class="table-light">
						<tr>
						<th class="text-center align-middle">체크</th>
							<th class="text-center align-middle">차량</th>
							<th class="text-center align-middle">수주일자</th>
							<th class="text-center align-middle">수주상세번호</th>
							<th class="text-center align-middle">품목</th>
							<th class="text-center align-middle">자재코드</th>
							<th class="text-center align-middle">버전</th>
							<th class="text-center align-middle">발주번호/Batch</th>
							<th class="text-center align-middle">목표요구일</th>
							<th class="text-center align-middle">출고요청일</th>
							<th class="text-center align-middle">현재고</th>
							<th class="text-center align-middle">수주수량</th>
							<th class="text-center align-middle">재고활용수량</th>
							<th class="text-center align-middle">생산량</th>
							<th class="text-center align-middle">기출고량</th>
							<th class="text-center align-middle"><span style="color:#ff0000;">*</span>출고량</th>
							<th class="text-center align-middle">미출고량</th>
							<th class="text-center align-middle">출고비고</th>
							<th class="text-center align-middle">비고</th>
							<th class="text-center align-middle"><span style="color:#ff0000;">*</span>창고</th>
							<th class="text-center align-middle"><span style="color:#ff0000;">*</span>납품처</th>
							<th class="text-center align-middle"><span style="color:#ff0000;">*</span>납품장소</th>
							<th class="text-center align-middle"><span style="color:#ff0000;">*</span>사업장구분</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>
<!-- PO완료 경고 -->
<div class="modal fade" id="bizDtlPoEndModal" tabindex="-1" aria-hidden="true" style="z-index: 9999;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">
					<i class="fa-solid fa-triangle-exclamation text-danger"></i>
					<spring:message code="modal.warning" text="default text" />
				</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<label style="">PO완료 진행시</label> 
				<br> 
				<label class="mt-2" style="color: red;">1. 더 이상 수정 및 복구가 불가능합니다.</label> 
				<br>
				<!-- <label style="color: red;">&nbsp&nbsp&nbsp단, 진행되지 않은 작업지시는 삭제됩니다.</label>
				<br>
				<label style="color: red;">2. 미확정 발주건들은 삭제됩니다.</label>
				<br>
				<label style="color: red;">3. 더 이상 수정 및 복구가 불가능합니다.</label>
				<br> -->
				<label class="mt-2">계속하시겠습니까?</label>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" id="btnBizDtlPoEndY" data-bs-dismiss="modal" style="width: 70px;">
					<spring:message code="yes" text="default text" />
				</button>
				<button type="button" class="btn btn-secondary" id="btnBizDtlPoEndN" data-bs-dismiss="modal" style="width: 70px;">
					<spring:message code="no" text="default text" />
				</button>
			</div>
		</div>
	</div>
</div>
<!-- PO완료 경고 모달 끝 -->
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
			let rightcolMinWidth = 700; // rightcol 최소사이즈
	
			let rightColWidth = isDragging ? page.clientWidth - parseInt(Math.max(leftcolMinWidth + 20, event.clientX)) : rightcol.clientWidth;

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
			$('#page').css('grid-template-columns', '2fr 4px 3fr');
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
			$('#page').css('grid-template-columns', '2fr 4px 3fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcol').removeClass('d-none');
		} else {
			$('#page').css('grid-template-columns', '2fr 4px 0fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcol').addClass('d-none');
		}
		dataTableDrawAll(); // dataTable 전체 reload
	});
</script>

<script>
	WM_init('new');

	let monthAdjustList = getCommonCode('시스템', '026'); //날짜조정
	monthAdjustList = _.sortBy(monthAdjustList, v=>parseInt(v.commonCd));
	selectBoxAppend(monthAdjustList, 'monthAdjust', '', '2'); //날짜조정
	
	let dealCorpIdxVal = '';

	let carAssignmentList = getCommonCode('일반', '039'); // 차량배정
	let dealGubunList = getCommonCode('시스템', '011'); // 거래구분
	let dealCorpStatusList = getCommonCode('시스템', '015'); // 거래상태

	selectBoxAppend(carAssignmentList, 'carAssignment', '', '2'); //차량배정
	selectBoxAppend(dealGubunList, 'modalDealGubun', '', '1'); //거래구분
	selectBoxAppend(dealCorpStatusList, 'modalDealCorpStatus', '', '1'); //거래상태

	let overProdOutYn = getCommonCode('시스템', '027')[0].commonCd; //과출고여부
	
	let workplaceList = new Array();	// 사업장 리스트
	let locationList = new Array();
	// 사업장정보 조회
	$.ajax({
		url : '<c:url value="/sm/workplaceLst"/>',
		type : 'POST',
		async : false,
		data : {
			'useYnCd' : function() { return '001'; }
		},
		success : function(res) {
			if (res.result == "ok") { //응답결과
				let data = res.data;
				data.forEach((item) => {
					var workplaceData = new Object();
					workplaceData.id = item.idx;
					workplaceData.text = item.workplaceNm;
					workplaceList.push(workplaceData);
				});
			} else if(res.result == 'fail') {
				toastr.warning(res.message);
			} else {
				toastr.error(res.message);
			}
		}
	});
	//창고정보 조회
	$.ajax({

		url : '<c:url value="/bm/locationAdmList"/>',
		type : 'GET',
		async : false,
		data : {
			itemGubun	:	'',
			'lcTypeOutput' : function() { return 'Y'; }
		},
		success : function(res) {
			if (res.result == "ok") { //응답결과
				let data = res.data;
				data.forEach((item) => {
					var locationData = new Object();
					locationData.id = item.idx;
					locationData.text = item.lcNm;
					locationList.push(locationData);
				});
			} else if(res.result == 'fail') {
				toastr.warning(res.message);
			} else {
				toastr.error(res.message);
			}
		}
	});
	
	let selectPeriod = parseInt(getCommonCode('시스템', '040')[0].commonCd); //기본조회기간 일
	$('#startDate').val(moment().subtract('d',selectPeriod).format('YYYY-MM-DD'));
	$('#endDate').val(moment().format('YYYY-MM-DD'));

	// 수주처 목록 목록조회
	$('#bizOrderDealCorpTable thead tr').clone(true).addClass('filters').appendTo('#bizOrderDealCorpTable thead'); // filter 생성
	let bizOrderDealCorpTable = $('#bizOrderDealCorpTable').DataTable({
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
			url : '<c:url value="/bs/bizOrderAdmLstGroupByDealCorp"/>',
			type : 'POST',
			data : {
				startDate : function() { return moment($('#startDate').val()).format('YYYYMMDD'); },
				endDate : function() { return moment($('#endDate').val()).format('YYYYMMDD'); }
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'dealCorpCd', className : 'text-center'},
			{ data: 'dealCorpNm', className : 'text-center'},
		],
		columnDefs : [
			{
				targets: '_all',
				render: function(data) {
					return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
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
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#bizOrderDealCorpTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#bizOrderDealCorpTable_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 79)+'px');
			
			$('#bizOrderDealCorpTable_filter').addClass('d-none');
			// 통합검색
			$('#searchAllAdm').off('keyup',function() {});
			$('#searchAllAdm').on('keyup',function() {
				$('#bizOrderDealCorpTable_filter').find('input').val($(this).val());
				$('#bizOrderDealCorpTable_filter').find('input').trigger('keyup');
			});
		},
		initComplete: function () {
			let api = this.api();
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#bizOrderDealCorpTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title.replaceAll('*','') + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#bizOrderDealCorpTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	bizOrderDealCorpTable.on('column-reorder', function( e, settings, details ) {
		let api = bizOrderDealCorpTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#bizOrderDealCorpTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	// 수주처 목록 조회 버튼 click
	$('#btnSearch').on('click', function() {
		dealCorpIdxVal = '';

		bizOrderDealCorpTable.rows('.selected').deselect();
		
		bizOrderDealCorpTable.ajax.reload(function() {});
		bizOrderDtlTable.ajax.reload(function() {});
	});

	// 수주처 목록 선택
	$('#bizOrderDealCorpTable tbody').on('click', 'tr', function() {
		let data = bizOrderDealCorpTable.row(this).data();
		if(WMCheck('new')) { // 신규등록중일 경우
			setWM('new', 'idx', data.idx);
			return false;
		}
		dealCorpIdxVal = data.dealCorpIdx;
		
		bizOrderDtlTable.ajax.reload(function() {});
		$('.inputGroup').attr('disabled', true); // 입력항목
		$('#btnSave').attr('disabled', true); // 저장 버튼
		$('#btnEdit').attr('disabled', false); // 수정 버튼
		$('#btnCancel').attr('disabled', true); // 취소 버튼
	});

	// 수주상세목록조회
	$('#bizOrderDtlTable thead tr').clone(true).addClass('filters').appendTo('#bizOrderDtlTable thead'); // filter 생성
	let bizOrderDtlTable = $('#bizOrderDtlTable').DataTable({
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
		colReorder: false,
		select: {
            style: 'single',
            toggleable: false,
            items: 'row',
            info: false
        },
        ajax : {
			url : '<c:url value="/stock/bizOrderDtlList"/>',
			type : 'POST',
			data : {
				'startDate' : function() { return moment($('#startDate').val()).format('YYYYMMDD'); },
				'endDate' : function() { return moment($('#endDate').val()).format('YYYYMMDD'); },
				'dealCorpIdx'  : function(){ return dealCorpIdxVal; },
				'searchTarget' : function(){ return $('#searchTarget').val(); },
			},
		},
        rowId: '',
        columns : [
        	{ className : 'text-center align-middle',
				render: function(data, type, row, meta) {
					return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;"><input type="checkbox" class="inputGroup align-middle" name="insertYn" style="width:20px; height:20px;" disabled></div>';
				}
			},
			{ className : 'text-center align-middle',name: 'carAssignment',
				render: function(data, type, row, meta) {
					let html = '';
					html += '<select name="carAssignmentSelect" class="form-select inputGroup" style="min-width: 100px;" disabled>';
					html +='	<option value="">선택</option>';
					carAssignmentList.forEach(function(item) {
						html +='	<option value="'+item.commonCd+'">'+item.commonNm+'</option>';
					});							
					html += '</select>';
					return html;
				}
			},
			{ data: 'ordDate', className : 'text-center align-middle',
				render: function(data, type, row, meta) {
					return moment(data).format('YYYY-MM-DD');
				}
			},
			{ data: 'bizOrdDtlNo', className : 'text-center align-middle'},
			{ data: 'itemCd', className : 'text-center align-middle',
				render: function(data, type, row, meta) {
					if(data != null && data != ''){
						if( row['workQtyCheck'] == '1' ){
							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;"><big class="fw-bolder" style="color: #ff0000;">! </big>'+data+'</div>';
						} else {
							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						} 
					} else {
						return '-';
					}
					
				}
			},
			{ data: 'customerItemCd', className : 'text-center align-middle'},
			{ data: 'versionNum', className : 'text-center align-middle'},
			{ data: 'purchaseBatch', className : 'text-center align-middle'},
			{ data: 'workEndReqDate', className : 'text-center align-middle',
				render: function(data, type, row, meta) {
					if(data!=null) {
						return moment(data).format('YYYY-MM-DD');
					} else {
						return '';
					}
				}
			},
			{ data: 'outReqDate', className : 'text-center align-middle',
				render: function(data, type, row, meta) {
					if(data!=null && data!='') {
						return moment(data).format('YYYY-MM-DD');
					} else {
						return '';
					}
				}
			},
			{ data: 'spQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return addCommas(parseInt(data));
					} else {
						return '0';
					}
				}
			},
			{ data: 'ordQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return addCommas(parseInt(data));
					} else {
						return '';
					}
				}
			},
			{ data: 'stockReUseQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return addCommas(parseInt(data));
					} else {
						return '';
					}
				}
			},
			{ data: 'fairQty', className : 'text-end align-middle',//생산량
				render : function(data, type, row, meta) {
					if(data!=null) {
						return addCommas(parseInt(data));
					} else {
						return data;
					}
					
				}
			},
			{ data: 'outQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					return addCommas(parseInt(data));
				}
			},
			{ data : 'outQty', className : 'text-end align-middle', name: 'outQty', //출고량
				render : function(data, type, row, meta) {
					if(row['fairQty']!=null) {
						let html = '';
						html += '<input type="text" class="form-control text-end inputGroup" name="outQty" onkeyup="numberFormat(this, \'int\')" value="'+addCommas(parseInt(row['fairQty'])-parseInt(data))+'" disabled>';
						return html;
					} else {
						let html = '';
						html += '<input type="text" class="form-control text-end inputGroup" name="outQty" onkeyup="numberFormat(this, \'int\')" value="'+0+'" disabled>';
						return html;
					}
				}
			},

			{ data: 'outQty', className : 'text-end align-middle', name: 'remainQty',
				render : function(data, type, row, meta) {
					if(row['ordQty']!=null) {
						return addCommas(parseInt(row['ordQty'])-parseInt(data));
					} else {
						return 0;
					}
					
				}
			},
			{ data: 'workOutDesc', className : 'text-center align-middle',//출고비고
				render : function(data, type, row, meta) {
					if(data!=null) {
						return data;
					} else {
						return '';
					}
					
				}
			},
			{ data: 'outDesc', className : 'text-end align-middle', name: 'outDesc',
				render : function(data, type, row, meta) {
					let html = '';
						html += '<input type="text" name="outDesc" style="min-width: 150px;" class="form-control text-start inputGroup" disabled>';
					return html;
				}
			},
			{ data: 'whsIdx', className : 'text-end align-middle', name: 'whsIdx',
				render : function(data, type, row, meta) {
					let html = '';
					html += '<select name="whsIdx" class="form-select inputGroup" style="min-width: 100px;" disabled>';
					//html +='	<option value="">선택</option>';
					locationList.forEach(function(item) {
						html +='	<option value="'+item.id+'">'+item.text+'</option>';
					});							
					html += '</select>';
					return html;
				}
			},
			{ data: 'dealCorpIdx', className : 'text-center align-middle', name: 'outProdEtc1',
				render: function(data, type, row, meta) {
					let html='';
					html += '<div style="display: flex; flex-wrap: nowrap;" class="input-group">';
					html += '<input type="text" class="form-control inputNm" id="dealCorpNm'+meta.row+'" name="dealCorpNm" style="min-width: 100px;" disabled="disabled" value="'+row['dealCorpNm']+'">';
					html += '<button type="button" class="nameDel customerNm inputGroup" onclick="dealCorpDelete(\''+meta.row+'\')" name="btnDealCorpDel" style="background-color: transparent;border-color: transparent;position: absolute;top: 0;right:0;margin: 1px 23px;margin-left: 0px;border: none;" disabled><i class="fa-solid fa-xmark"></i></button>';
					html += '<input type="hidden" class="inputIdx" id="dealCorpIdx'+meta.row+'" name="dealCorpIdx" value ="'+data+'">';
					html += '<button disabled type="button" onclick="dealCorpSel()" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary input-sub-search inputGroup" name="btnDealCorpSel">';
					html += '<i class="fa-solid fa-magnifying-glass"></i>';
					html += '</button>';
					html += '</div>';
					return html;
				}
			},
			{ data: 'outProdEtc2', className : 'text-end align-middle', name: 'outProdEtc2',
				render : function(data, type, row, meta) {
					if(row['dealCorpAddress'] != null && row['dealCorpAddress'] != ''){
						let html ='';
						html += '<input type="text" value="'+row['dealCorpAddress']+'" style="min-width: 100px;" name="outProdEtc2" class="form-control text-start inputGroup" disabled>';
						return html;
					} else {
						let html ='';
						html += '<input type="text" style="min-width: 100px;" name="outProdEtc2" class="form-control text-start inputGroup" disabled>';
						return html;
					}
				}
			},

			{ data: 'workplaceIdx', className : 'text-end align-middle', name: 'outProdEtc3',
				render : function(data, type, row, meta) {
					let html='';
					html += '<select disabled class="form-select inputGroup" style="min-width: 100px;" name="outProdEtc3">';
					for( let i = 0; i< workplaceList.length; i++){
						if(workplaceList[i].id == data){
							html += '<option value="' + workplaceList[i].id + '" selected>' + workplaceList[i].text + '</option>'
						} else {
							html += '<option value="' + workplaceList[i].id + '">' + workplaceList[i].text + '</option>'
						}
					}
					html += '</select>';
					return html;
				}
			},
		],
		columnDefs : [
			{
				targets: '_all',
				render: function(data) {
					return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
				}
			}
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
		order : [[2,'asc']],
		drawCallback: function() {
			let api = this.api();
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#bizOrderDtlTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#bizOrderDtlTable_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 50)+'px');
			
			$('#bizOrderDtlTable_filter').addClass('d-none');
			$('.bootstrapToggle').bootstrapToggle();
		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#bizOrderDtlTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title.replaceAll('*','') + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#bizOrderDtlTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	bizOrderDtlTable.on('column-reorder', function( e, settings, details ) {
		let api = bizOrderDtlTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#bizOrderDtlTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
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
				let idx = getWM(WMlastIdx, 'idx');
				WM_action_OFF(WMlastIdx);
				setWM(WMlastIdx, 'idx', '');
				bizOrderDealCorpTable.row('#'+idx).select();
				$(bizOrderDealCorpTable.row('#'+idx).node()).trigger('click'); // 선택했던 항목 선택처리
			} else {
				WM_action_OFF(WMlastIdx);
				if(window.location != window.parent.location) { // tab일 경우
					// 부모 탭 닫기버튼 click
					$('#tab-list', parent.document).find('.active').find('span').eq(1).find('i').trigger('click');
			    }
				
				$('.inputGroup').attr('disabled', true); // 입력항목
				
				$('#btnSave').attr('disabled', true); // 저장 버튼
				$('#btnEdit').attr('disabled', true); // 수정 버튼
				$('#btnCancel').attr('disabled', true); // 취소 버튼
			}
			return false;
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

		$('.inputGroup').attr('disabled', true); // 입력항목
		
		$('#btnSave').attr('disabled', true); // 저장 버튼
		$('#btnEdit').attr('disabled', false); // 수정 버튼
		$('#btnDel').attr('disabled', true); // 삭제 버튼
		$('#btnCancel').attr('disabled', true); // 취소 버튼
		bizOrderDtlTable.ajax.reload(function() {});
	});

	//수정
	$('#btnEdit').on('click',function(){
		_promise_().then(()=>{
			WM_action_ON('new', 'workingWarningModal');
			$('#btnCancel').attr('disabled',false);
			$('#btnSave').attr('disabled',false);
			$('#btnEdit').attr('disabled',true);
			$('input[name=insertYn]').attr('disabled',false);
			/*
			
			$('input[name=outQty]').attr('disabled',false);
			$('input[name=outDesc]').attr('disabled',false);
			$('select[name=whsIdx]').attr('disabled',false);
			$('button[name=btnDealCorpDel]').attr('disabled',false);
			$('button[name=btnDealCorpSel]').attr('disabled',false);
			$('input[name=outProdEtc2]').attr('disabled',false);
			$('select[name=outProdEtc3]').attr('disabled',false);
			*/
			$('.inputGroup').attr('disabled',false);
		}).then(()=>{
			bizOrderDtlTable.draw(false);
		});
			
	});

	function dealCorpSel() {
		$('#dealCorpModal').modal('show');
		setTimeout(function() {
			dealCorpModalTable.ajax.reload(function() {});
			setTimeout(function() {
				$('#dealCorpModalTable').DataTable().$('tr.selected').removeClass('selected');
			}, 500);
		}, 200);
	}

	
	// 거래처정보 목록조회
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
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 223)+'px');
			
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
	
	// 거래처모달 조회 버튼 click
	$('#btnDealCorpModalSearch').on('click', function() {
		dealCorpModalTable.ajax.reload(function(){});
	});
	
	// 거래처목록 적용 버튼 click
	$('#btnDealCorpModalPaste').on('click', function(){

		if( !$('#dealCorpModalTable tbody tr').hasClass('selected') ){
			toastr.warning('적용할 행을 선택해주세요.');
			return false;
		}
		
		let data = dealCorpModalTable.row('.selected').data();
		$('#bizOrderDtlTable').DataTable().$('tr.selected').find('input[name=dealCorpIdx]').val(data.idx);
		$('#bizOrderDtlTable').DataTable().$('tr.selected').find('input[name=dealCorpNm]').val(data.dealCorpNm);
		$('#bizOrderDtlTable').DataTable().$('tr.selected').find('input[name=outProdEtc2]').val(data.dealCorpAddress);
		$('#dealCorpModal').modal('hide');
	});

	$('#dealCorpModalTable tbody').on('dblclick','tr',function(){
		let data = dealCorpModalTable.row(this).data();
		$('#bizOrderDtlTable').DataTable().$('tr.selected').find('input[name=dealCorpIdx]').val(data.idx);
		$('#bizOrderDtlTable').DataTable().$('tr.selected').find('input[name=dealCorpNm]').val(data.dealCorpNm);
		$('#bizOrderDtlTable').DataTable().$('tr.selected').find('input[name=outProdEtc2]').val(data.dealCorpAddress);
		$('#dealCorpModal').modal('hide');
	});
	
	function dealCorpDelete(value) {
		$('#dealCorpIdx'+value).val('');
		$('#dealCorpNm'+value).val('');
	}

	// 저장버튼 click
	$('#btnSave').on('click', function() {
		$('#my-spinner').show();
		setTimeout(function(){
			overProdOutYn = getCommonCode('시스템', '027')[0].commonCd; //과출고여부

			let equalsData;
			if(overProdOutYn != 'Y'){
				$.ajax({
					url : '<c:url value="/stock/bizOrderDtlList"/>',
					type : 'POST',
					async : false,
					data : {
						'startDate' : function() { return moment($('#startDate').val()).format('YYYYMMDD'); },
						'endDate' : function() { return moment($('#endDate').val()).format('YYYYMMDD'); },
						'dealCorpIdx'  : function(){ return dealCorpIdxVal; },
					},
		            beforeSend: function() {
		            	$('#my-spinner').show();
		            },
					success : function(res) {
						if (res.result == "ok") { //응답결과
							equalsData = res.data;
						} else if(res.result == 'fail') {
							toastr.warning(res.message);
						} else {
							toastr.error(res.message);
						}
						$('#my-spinner').hide();
					}
				});
			}
			
			let array = [];
			let qtyCheckArray = [];			
			let state = true;
			let checkRows = $('#bizOrderDtlTable tbody').find('tr').find('input[name=insertYn]:checked').parent().parent().parent();
			let checkRowData = bizOrderDtlTable.rows(checkRows).data().toArray();
			
			$('#bizOrderDtlTable tbody').find('tr').find('input[name=insertYn]:checked').each(function(index, item){				
				let tr = $(item).parent().parent().parent(); 	//행 tr
				let td = $(item).parent().parent();				//해당 체크박스 td
				let rowTdList = $(tr).find('td');				//행(tr)의 td 리스트
				let data = bizOrderDtlTable.row(tr).data();		//행 데이터
				
				let outQty = $(rowTdList).eq(bizOrderDtlTable.column('outQty:name').index()).find('input').val().replaceAll(/,/g,'');
				let outDesc = $(rowTdList).eq(bizOrderDtlTable.column('outDesc:name').index()).find('input').val();
				let whsIdx = $(rowTdList).eq(bizOrderDtlTable.column('whsIdx:name').index()).find('select').val();
				let outProdEtc1 = $(rowTdList).eq(bizOrderDtlTable.column('outProdEtc1:name').index()).find('input[type=hidden]').val();
				let outProdEtc2 = $(rowTdList).eq(bizOrderDtlTable.column('outProdEtc2:name').index()).find('input').val();
				let outProdEtc3 = $(rowTdList).eq(bizOrderDtlTable.column('outProdEtc3:name').index()).find('select').val();
				let carAssignment = $(rowTdList).eq(bizOrderDtlTable.column('carAssignment:name').index()).find('select').val();

				if(carAssignment == '') {
					toastr.warning('차량을 배정해주세요.');
					$(rowTdList).eq(bizOrderDtlTable.column('carAssignment:name').index()).find('select').focus();
					state = false;
					return false;
				}
				
				if(outQty == '0') {
					toastr.warning('출고수량을 입력해주세요.');
					$(rowTdList).eq(bizOrderDtlTable.column('outQty:name').index()).find('input').focus();
					state = false;
					return false;
				}
				
				if(whsIdx == '') {
					toastr.warning('창고를 선택해주세요.');
					$(rowTdList).eq(bizOrderDtlTable.column('whsIdx:name').index()).find('select').focus();
					state = false;
					return false;
				}

				if(outProdEtc1 == '') {
					toastr.warning('납품처를 선택해주세요.');
					$(rowTdList).eq(bizOrderDtlTable.column('outProdEtc1:name').index()).find('button').eq(1).focus();
					state = false;
					return false;
				}
				
				if(outProdEtc2 == '') {
					toastr.warning('납품장소를 입력해주세요.');
					$(rowTdList).eq(bizOrderDtlTable.column('outProdEtc2:name').index()).find('input').focus();
					state = false;
					return false;
				}
				
				let obj = new Object();
				obj.outQty = outQty.replaceAll(/,/g,'');
				obj.outDesc = outDesc;
				obj.whsIdx = whsIdx;				
				obj.outProdEtc1 = outProdEtc1;
				obj.outProdEtc2 = outProdEtc2;
				obj.outProdEtc3 = outProdEtc3;
				obj.bizOrdDtlNo = data.bizOrdDtlNo;
				obj.itemIdx = data.itemIdx;
				obj.itemCd = data.itemCd;
				obj.outDate = moment().format('YYYYMMDD');
				obj.outCorpIdx = data.dealCorpIdx;
				obj.carAssignment = carAssignment;
			    array.push(obj);

			    let obj2 = new Object();
			    obj2.outQty = outQty.replaceAll(/,/g,'');
			    obj2.itemIdx = data.itemIdx;
			    qtyCheckArray.push(obj2);
			    
			});
			if(overProdOutYn != 'Y'){
				let qtyCheckResultArray = qtyCheckArray.reduce((acc, cur) => {
																  let itemIdx = cur.itemIdx;
																  let outQty = Number(cur.outQty.replaceAll(/,/g, ''));
																  let index = acc.findIndex((obj) => obj.itemIdx === itemIdx);
																  if (index === -1) {
																    acc.push({ itemIdx, outQty });
																  } else {
																    acc[index].outQty += outQty;
																  }
																  return acc;
																}, []);
	
				qtyCheckResultArray.forEach(function(index, item){
					let rows = $('#bizOrderDtlTable tbody').find('tr').find('input[name=insertYn]:checked').parent().parent().parent();
					let rowData = bizOrderDtlTable.rows(rows).data().toArray();
					let spQty = parseInt(_.filter(rowData, v=>v.itemIdx == index['itemIdx'])[0].spQty);
	
					if( spQty < index['outQty'] ){
						toastr.warning('현재고가 부족하여 출고를<br>등록할 수 없습니다');
						state = false;
						return false;
					}
				});
			}
			
			if(array.length == 0 && state) {
				toastr.warning('등록할 데이터를 선택해주세요.');
				state = false;
			}

			if(!state) {
				$('#my-spinner').hide();
				return false;
			}
			$.ajax({
				url: '<c:url value="/stock/outProdWhsAdmIns"/>',
	            type: 'POST',
	            data: {
	                'jsonArray'	:	JSON.stringify(array)
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if (res.result == "ok") { //응답결과
						toastr.success('저장되었습니다.');
						console.log('1')
						WM_action_OFF('new');
						console.log('2')
						bizOrderDtlTable.ajax.reload(function() {});
	        
						bizOrderDtlTable.colReorder.enable();
	        
						$('#btnSave').attr('disabled', true); // 저장 버튼
						$('#btnEdit').attr('disabled', false); // 수정 버튼
						$('#btnCancel').attr('disabled', true); // 취소 버튼
					} else if(res.result == 'fail') {
						toastr.warning(res.message);
					} else {
						toastr.error(res.message);
					}
					$('#my-spinner').hide();
				}
			});
				
		},100);
		
	});

	//차량배정
	$('#btnCopy').on('click',function(){
		if(!$('#bizOrderDealCorpTable tbody tr').hasClass('selected')){
			toastr.warning('붙여넣을 행을 선택해주세요.');
			return false;
		}
		if( $('#carAssignment').val() == '' ){
			toastr.warning('차량배정을 선택해주세요.');
			$('#carAssignment').focus();
			return false;
		}

		$('select[name=carAssignmentSelect]').val($('#carAssignment').val());
		$('#btnEdit').trigger('click');
	});

	$('#btnDtlSearch').on('click',function(){
		bizOrderDtlTable.ajax.reload();
	});

	/********************* po완료 *********************/
	$('#btnBizDtlPoEnd').on('click',function(){
		if($('#bizOrderDtlTable tbody').find('tr.selected').length == 0) {
			toastr.warning('PO완료할 항목을 선택해주세요.');
			return false;
		}		
		
		$('#bizDtlPoEndModal').modal('show');
	});

	$('#btnBizDtlPoEndY').on('click',function(){
		$.ajax({
			url: '<c:url value="/bs/bizOrderDtlPoEnd"/>',
            type: 'POST',
            data: {
                'bizOrdDtlIdx'	:	function(){ return bizOrderDtlTable.row('.selected').data().bizOrdDtlIdx; },
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					toastr.success('PO 완료 되었습니다.');
					bizOrderDtlTable.row('.selected').deselect();
					bizOrderDtlTable.ajax.reload(function(){},false);
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
					bizOrderDtlTable.row('.selected').deselect();
					bizOrderDtlTable.ajax.reload(function(){},false);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
	});
	
</script>

</body>
</html>
