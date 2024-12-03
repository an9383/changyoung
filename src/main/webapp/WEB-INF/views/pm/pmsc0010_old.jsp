<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/top.jsp"%>
<%@include file="../layout/modal.jsp"%>
<%@include file="../layout/script.jsp"%>
<div id="page" onmouseup="EndDrag()" onmousemove="OnDrag(event)" style="grid-template-areas:	'middlecolT'
																								'dragbarV'
																								'middlecolB';
																		  grid-template-rows: 2fr 4px 1fr;
																		  grid-template-columns: 1fr;">
	<div id="middlecolT">
		<div class="container-fluid h-100" style="padding: 5px;">
			<div class="row" id="leftHeader" style="padding-bottom: 5px;">
				<div class="d-flex align-items-center d-flex">
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">수주등록일</label>
					<input type="date" max="9999-12-31" class="form-control w-auto h-100 me-1" id="startDate">
					<label class="form-label d-flex align-items-center m-0 me-1 h-100">~</label>
					<input type="date" max="9999-12-31" class="form-control w-auto h-100 me-3" id="endDate">
					<input type="text" class="form-control w-auto h-100 me-1 d-none" id="searchAllAdm" placeholder="통합검색" >
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end">
					<div class="btn-group" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnSearch"><i class="fa-regular fa-clipboard"></i></button>
					</div>
				</div>
			</div>
			<div class="row">
				<table class="table table-bordered p-0 m-0" id="bizOrderTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle">수주확정</th>
							<th class="text-center align-middle">디자인컨펌</th>
							<th class="text-center align-middle">수주상세번호</th>
							<th class="text-center align-middle">고객사</th>
							<th class="text-center align-middle">제품명</th>
							<th class="text-center align-middle">자재코드</th>
							<th class="text-center align-middle">버전번호</th>
							<th class="text-center align-middle">주문수량</th>
							<th class="text-center align-middle">주의사항<br>(작업지시서)</th>
							<th class="text-center align-middle">특이사항</th>
							<th class="text-center align-middle">COLOR</th>
							<th class="text-center align-middle">코팅</th>
							<th class="text-center align-middle">목표<br>요구일</th>
							<th class="text-center align-middle">발주번호/BATCH</th>
							<th class="text-center align-middle">출고량</th>
							<th class="text-center align-middle">특기사항</th>
							<th class="text-center align-middle">목형관리번호</th>
							<th class="text-center align-middle">수지판</th>
							<th class="text-center align-middle">재고</th>
							<th class="text-center align-middle">칼끝규격</th>
							<th class="text-center align-middle">규격</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
	<div id="dragbarV" onmousedown="StartDrag()"></div>
	<div id="middlecolB">
		<div class="container-fluid h-100" style="padding: 5px;">
			<div class="row" id="rightHeader" style="padding-bottom: 5px;">
				<div class="d-flex align-items-center d-flex">
					<input type="text" class="form-control w-auto h-100 me-1 d-none" id="searchAllDtl" placeholder="통합검색" >
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end">
					<div class="btn-group" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnNew"><i class="fa-solid fa-plus"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnSave" disabled><i class="fa-regular fa-floppy-disk"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnEdit" disabled><i class="fa-regular fa-pen-to-square"></i></button>
						<button type="button" class="btn btn-outline-danger w-auto" style="font-size: 17px !important;" id="btnDel" disabled><i class="fa-solid fa-trash-can"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnCancel" disabled><i class="fa-solid fa-xmark"></i></button>
					</div>
				</div>
			</div>
			<div class="row">
				<table class="table table-bordered p-0 m-0" id="purchaseOrderAdmTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle">확정여부</th>
							<th class="text-center align-middle">진행상태</th>
							<th class="text-center align-middle">출력여부</th>
							<th class="text-center align-middle">발주번호</th>
							<th class="text-center align-middle">발주일자</th>
							<th class="text-center align-middle">입고예정일</th>
							<th class="text-center align-middle">재질</th>
							<th class="text-center align-middle">발주처</th>
							<th class="text-center align-middle">주문수량</th>
							<th class="text-center align-middle">이론량Ⓡ</th>
							<th class="text-center align-middle">발주량Ⓡ</th>
							<th class="text-center align-middle">절수</th>
							<th class="text-center align-middle">개수</th>
							<th class="text-center align-middle">여분</th>
							<th class="text-center align-middle">포장단위여분</th>
							<th class="text-center align-middle">정매인쇄통수</th>
							<th class="text-center align-middle">참고사항</th>
							<th class="text-center align-middle">비고</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>
<!-- 수주별발주 추가 자재 모달 ====================================================================================-->
<div class="modal fade" id="matrlSelectModal" tabindex="-1" aria-hidden="true" style="z-index: 9999;">
	<div class="modal-dialog" style="max-width: 60vw;">
		<div class="modal-content" style="height: calc(100vh - 5em);">
			<div class="modal-header">
				<h5 class="modal-title">
					자재 조회
				</h5>
				<div class="btn-group" role="group" aria-label="Small button group">
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnMatrlSelectModalPaste">
						<i class="fa-regular fa-paste"></i>
					</button>
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" data-bs-dismiss="modal" aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>
			</div>
			<div class="modal-body">
				<div class="row" style="padding-bottom: 5px;">
					<div class="d-flex align-items-center d-flex">
						<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">자재 발주처 조회</label>
						<select class="form-select w-auto h-100 me-3" id="matrlSelectGubun" style="min-width: 70px;">
							<option value="001">자재 BOM</option>
							<option value="002">모든 자재</option>
						</select>
					</div>
					<div class="me-lg-auto"></div>
					<div class="d-flex align-items-center justify-content-end">
						<div class="btn-group" role="group" aria-label="Small button group">
							<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnMatrlSelectReSearch">
								<i class="fa-regular fa-clipboard"></i>
							</button>
						</div>
					</div>
				</div>
				<table class="table table-bordered p-0 m-0" id="matrlModalSelectTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle">품목구분</th>
							<th class="text-center align-middle">원단코드</th>
							<th class="text-center align-middle">재질</th>
							<th class="text-center align-middle">가로</th>
							<th class="text-center align-middle">세로</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>
<!-- 화면설정 script -->
<script>
	let isDraggingV = false;
	
	function SetCursor(cursor) {
		let page = document.getElementById("page");
		page.style.cursor = cursor;
	}
	
	function StartDrag() {
		isDraggingV = true;
		SetCursor("n-resize");
	}
	
	function EndDrag(e) {
		if(isDraggingV) {
			dataTableDrawAll(); // dataTable 전체 reload
			isDraggingV = false;
			SetCursor("auto");
		}
	}
	
	function OnDrag(event) {
		if (isDraggingV) {
			let dragbarWidth = 4;
	
			let page_height = parseInt($('#page').height()); 				// 전체 높이
			let middlecolT_height = parseInt($('#middlecolT').height());	// 상단
			let middlecolB_height = parseInt($('#middlecolB').height());	// 하단
	
			let middlecolT_min_height = 100;	// 상단 최소높이
			let middlecolB_min_height = 100;	// 하단 최소높이
	
			let cursorY = event.clientY;	// 현재 cursor y좌표(위에서부터 얼마나 떨어졌는지)
	
			let cols = [
				Math.min(Math.max(middlecolT_min_height, cursorY), page_height - middlecolB_min_height - dragbarWidth),
				dragbarWidth,
				Math.max(page_height - Math.max(middlecolT_min_height, cursorY) - dragbarWidth, middlecolB_min_height)
			];
	
			let newColDefn = cols.map(c => c.toString() + "px").join(" ");
	
			$('#page').css('grid-template-rows',newColDefn);
	
			event.preventDefault()
		}
	}
</script>

<script>
	WM_init('ADM');
	WM_init('DTL');

	let dealGubunList = getCommonCode('시스템', '011'); // 거래구분
	let dealCorpStatusList = getCommonCode('시스템', '015'); // 거래상태
	
	selectBoxAppend(dealGubunList, 'modalDealGubun', '', '1'); //거래구분
	selectBoxAppend(dealCorpStatusList, 'modalDealCorpStatus', '', '1'); //거래상태
	
	
	$('#startDate').val(moment().subtract('w',1).format('YYYY-MM-DD'));
	$('#endDate').val(moment().format('YYYY-MM-DD'));

	let bizOrdDtlIdxVal = '';
	let ordQtyVal = '';
	let itemIdxVal = '';

	// 수주관리 전체 목록조회
	$('#bizOrderTable thead tr').clone(true).addClass('filters').appendTo('#bizOrderTable thead'); // filter 생성
	let bizOrderTable = $('#bizOrderTable').DataTable({
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
			url : '<c:url value="/bs/bizOrderStatusLst"/>',
			type : 'POST',
			data : {
				startDate	: function() { return moment($('#startDate').val(),'YYYY-MM-DD').format('YYYYMMDD'); },
				endDate		: function() { return moment($('#endDate').val(),'YYYY-MM-DD').format('YYYYMMDD'); },
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'confirmOrder', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data == 'Y') {
						return '<i class="fa-solid fa-check mt-1 text-success"></i>';
					} else {
						return '<i class="fa-solid fa-x mt-1 text-danger"></i>';
					}
				}
			},
			{ data: 'confirmDesign', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data == 'Y') {
						return '<i class="fa-solid fa-check mt-1 text-success"></i>';
					} else {
						return '<i class="fa-solid fa-x mt-1 text-danger"></i>';
					}
				}
			},
			{ data: 'bizOrdDtlNo', className : 'text-center align-middle'},
			{ data: 'dealCorpNm', className : 'text-center align-middle'},
			{ data: 'itemNm', className : 'text-center align-middle'},
			{ data: 'customerItemCd', className : 'text-center align-middle'},
			{ data: 'itemVersion', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					let obj = "";
						obj += "{";
						obj += "	'uuid':'"+row['uuid']+"',";
						obj += "	'fileName':'"+row['fileNm']+"',";
						obj += "	'ext':'"+row['ext']+"'";
						obj += "}";
					let html = '';
					if(row['uuid'] == '' || row['uuid'] == null) {
						html += '<span style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</span>';
					} else {
						html += '<a href="#" onclick="fileDownload('+obj+');" style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</a>';
					}
						
					return html;
				}
			},
			{ data: 'ordQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					return addCommas(parseInt(data));
				}
			},
			{ data: 'ordNote', className : 'text-start align-middle',
				render : function(data, type, row, meta) {
					if(data != '' && data != null) {
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data.replaceAll(/\n/g,'<br>')+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'ordIssue', className : 'text-start align-middle',
				render : function(data, type, row, meta) {
					if(data != '' && data != null) {
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data.replaceAll(/\n/g,'<br>')+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'itemColor', className : 'text-center align-middle'},
			{ data: 'coatingMethod', className : 'text-center align-middle'},
			/* { data: 'cmyk', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					let cmyk = data.split('/');
					let html = '';
						html += '<span style="background-color: #'+(cmyk[0]==''?'ffffff':'009FE3')+'; border: 1px solid #009FE3; padding: 1px 4px; color: #000000;">C</span>';
						html += '<span style="background-color: #'+(cmyk[1]==''?'ffffff':'E6007E')+'; border: 1px solid #E6007E; padding: 1px 4px; color: #000000;">M</span>';
						html += '<span style="background-color: #'+(cmyk[2]==''?'ffffff':'FEED01')+'; border: 1px solid #FEED01; padding: 1px 4px; color: #000000;">Y</span>';
						html += '<span style="background-color: #'+(cmyk[3]==''?'ffffff':'000000')+'; border: 1px solid #000000; padding: 1px 4px; color: #'+(cmyk[3]==''?'000000':'ffffff')+';">K</span>';
					return html;
				}
			}, */
			{ data: 'workEndReqDate', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != '' && data != null) {
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data,'YYYYMMDD').format('YYYY-MM-DD')+'</div>';
					} else {
						return '';
					}
				}
			},
			{ className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					return '-';
				}
			},
			{ className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					return '0';
				}
			},
			{ data: 'ordDesc', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != '' && data != null) {
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'woodenCareNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != '' && data != null) {
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'resinBoardNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != '' && data != null) {
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},
			{ className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					return '0';
				}
			},
			{ data: 'knifeTipSize', className : 'text-center align-middle'},
			{ className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					return '-';
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
			{ extend: 'excel',	text: 'Excel',	charset: 'UTF-8', bom: true },
			{ extend: 'pdf',	text: 'PDF',	},
			{ extend: 'print',	text: 'Print',		charset: 'UTF-8', bom: true },
			{ extend: 'colvis',	text: 'Select Col',	},
		],
		order : [],
		drawCallback: function() {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let middlecolT_height = parseFloat($('#middlecolT').css('height'));
			let theadHeight = parseFloat($('#bizOrderTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#bizOrderTable_wrapper').find('.dataTables_scrollBody').css('height',(middlecolT_height - theadHeight - 80)+'px');
			
			$('#bizOrderTable_filter').addClass('d-none');
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
				let cell = $('#bizOrderTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#bizOrderTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup change').on('change', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('change');
				});
			});
		},
	});
	// dataTable colReorder event
	bizOrderTable.on('column-reorder', function( e, settings, details ) {
		let api = bizOrderTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#bizOrderTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup change').on('change', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('change');
			});
		});
	});

	// 조회 버튼 click
	$('#btnSearch').on('click', function() {
		$('#my-spinner').show();
		bizOrderTable.ajax.reload(function() {});

		setTimeout(function() {
			$('#my-spinner').hide();
		}, 100)
	});

	// 수주목록 선택
	$('#bizOrderTable tbody').on('click', 'tr', function() {
		let data = bizOrderTable.row(this).data();
		let idx = data.idx;
		if(WMCheck('ADM')) {
			setWM('ADM', 'idx', idx);
			return false;
		}
		
		bizOrdDtlIdxVal = data.idx;
		ordQtyVal = data.ordQty;
		itemIdxVal = data.itemIdx;

		purchaseOrderAdmTable.clear().draw();
		purchaseOrderAdmTable.ajax.reload();
		
		$('#btnNew').attr('disabled', false); // 신규 버튼
		$('#btnSave').attr('disabled', true); // 저장 버튼
		$('#btnEdit').attr('disabled', false); // 수정 버튼
		$('#btnDel').attr('disabled', false); // 삭제 버튼
		$('#btnCancel').attr('disabled', true); // 취소 버튼

		$('#purchaseOrderAdmTable_wrapper').find('.filters th').each(function(index, item) {
			$(item).find('input').attr('disabled', false);// 검색 필터 enable
		});
	});

	// 작업중 경고 모달 예 버튼 click
	$('#btnWorkingWarningModalY').on('click', function() {
		if(WMlastIdx == 'ADM') { // 수주별발주 수정중이나 신규등록중이였을 경우
			$('#btnSave').trigger('click');
			return false;
		}
	});

	// 작업중 경고 모달 아니요 버튼 click
	$('#btnWorkingWarningModalN').on('click', function() {
		if(WMlastIdx == 'ADM') { // 수주별발주 수정중이나 신규등록중이였을 경우
			if(getWM(WMlastIdx, 'idx') != '' && getWM(WMlastIdx, 'idx') != undefined) {
				let idx = getWM(WMlastIdx, 'idx');
				WM_action_OFF(WMlastIdx);
				setWM(WMlastIdx, 'idx', '');
				bizOrderTable.row('#'+idx).select();
				$(bizOrderTable.row('#'+idx).node()).trigger('click'); // 선택했던 항목 선택처리
			} else {
				WM_action_OFF(WMlastIdx);
				if(window.location != window.parent.location) { // tab일 경우
					// 부모 탭 닫기버튼 click
					$('#tab-list', parent.document).find('.active').find('span').eq(1).find('i').trigger('click');
			    }
			}
		}
	});







	// 수주별발주 수주별 목록조회
	$('#purchaseOrderAdmTable thead tr').clone(true).addClass('filters').appendTo('#purchaseOrderAdmTable thead'); // filter 생성
	let purchaseOrderAdmTable = $('#purchaseOrderAdmTable').DataTable({
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
			url : '<c:url value="/pm/purchaseOrderAdmLstByBizDtl"/>',
			type : 'POST',
			data : {
				bizOrdDtlIdx	: function() { return bizOrdDtlIdxVal; }
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'confirmYn', className : 'text-center align-middle', name: 'confirmYn',
				render : function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						if(data == 'Y') {
							let html = '';
								html += '<input type="checkbox" class="bootstrapToggle confirmToggle p-0" data-toggle="toggle"';
								html += '		data-type="confirmOrder" data-idx="'+row['idx']+'"';
								html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
								html += '		data-size="small"';
								html += '		checked>';
							return html;
						} else {
							let html = '';
								html += '<input type="checkbox" class="bootstrapToggle confirmToggle p-0" data-toggle="toggle"';
								html += '		data-type="confirmOrder" data-idx="'+row['idx']+'"';
								html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
								html += '		data-size="small"';
								html += '		>';
							return html;
						}
					} else {
						let html = '';
							html += '<input type="checkbox" class="bootstrapToggle confirmToggle p-0" data-toggle="toggle"';
							html += '		data-type="confirmOrder" data-idx="'+row['idx']+'"';
							html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
							html += '		data-size="small"';
							html += '		disabled>';
						return html;
					}
					
				}
			},
			{ className : 'text-center align-middle', name: 'purchaseOrdStatus',
				render : function(data, type, row, meta) {
					return '-';
				}
			},
			{ data: 'printYn', className : 'text-center align-middle', name: 'printYn',
				render : function(data, type, row, meta) {
					if(data == 'Y') {
						return '<i class="fa-solid fa-check mt-1 text-success"></i>';
					} else {
						return '<i class="fa-solid fa-x mt-1 text-danger"></i>';
					}
				}
			},
			{ data: 'purchaseOrdNo', className : 'text-center align-middle', name: 'purchaseOrdNo',
				render : function(data, type, row, meta) {
					if(data != '' && data != null) {
						return data;
					} else {
						return '자동채번';
					}
				}
			},
			{ data: 'purchaseOrdDate', className : 'text-center align-middle editNode', name: 'purchaseOrdDate',
				render : function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						if(data != '' && data != null) {
							return moment(data,'YYYYMMDD').format('YYYY-MM-DD');
						} else {
							return '';
						}
					} else { // 등록되어있지 않는 값
						let html = '';
							html += '<input type="date" max="9999-12-31" class="form-control text-center" value="'+moment().format('YYYY-MM-DD')+'">';
							html += '<span class="d-none">'+data+'</span>';
						return html;
					}
				}
			},
			{ data: 'purchaseInDueDate', className : 'text-center align-middle editNode', name: 'purchaseInDueDate',
				render : function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						if(data != '' && data != null) {
							return moment(data,'YYYYMMDD').format('YYYY-MM-DD');
						} else {
							return '';
						}
					} else {
						let html = '';
							html += '<input type="date" max="9999-12-31" class="form-control text-center" value="'+moment().format('YYYY-MM-DD')+'">';
							html += '<span class="d-none">'+data+'</span>';
						return html;
					}
				}
			},
			{ data: 'paperType', className : 'text-center align-middle', name: 'paperType'},
			{ data: 'dealCorpNm', className : 'text-end align-middle editNode', name: 'dealCorpNm',
				render : function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						let html = '';
							html += '<div class="input-group" style="min-width: 150px;">';
							html += '	<input type="text" class="form-control" value="'+data+'"  disabled>';
							html += '	<button type="button" class="btnInputDel" style="background-color: transparent;';
							html += '		border-color: transparent; position: absolute;';
							html += '		top: 0; right:0;';
							html += '		margin: 1px 23px; margin-left: 0px;';
							html += '		border: none;';
							html += '		" disabled>';
							html += '		<i class="fa-solid fa-xmark"></i>';
							html += '	</button>';
							html += '	<input type="hidden" value="'+row['dealCorpIdx']+'">';
							html += '	<button type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary dealCorpModalBtn"';
							html += '	 data-matrlidx="'+row['matrlIdx']+'" disabled>';
							html += '		<i class="fa-solid fa-magnifying-glass"></i>';
							html += '	</button>';
							html += '</div>';
							html += '<span class="d-none">'+data+'</span>';
						return html;
					} else { // 등록되어있지 않는 값
						let html = '';
							html += '<div class="input-group" style="min-width: 150px;">';
							html += '	<input type="text" class="form-control" value="'+data+'" disabled>';
							html += '	<button type="button" class="btnInputDel" style="background-color: transparent;';
							html += '		border-color: transparent; position: absolute;';
							html += '		top: 0; right:0;';
							html += '		margin: 1px 23px; margin-left: 0px;';
							html += '		border: none;';
							html += '		" >';
							html += '		<i class="fa-solid fa-xmark"></i>';
							html += '	</button>';
							html += '	<input type="hidden" value="'+row['dealCorpIdx']+'">';
							html += '	<button type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary dealCorpModalBtn"';
							html += '	 data-matrlidx="'+row['matrlIdx']+'">';
							html += '		<i class="fa-solid fa-magnifying-glass"></i>';
							html += '	</button>';
							html += '</div>';
							html += '<span class="d-none">'+data+'</span>';
						return html;
					}
					
				}
			},
			{ data: 'purchaseOrdQty', className : 'text-end align-middle', name: 'purchaseOrdQty',
				render : function(data, type, row, meta) {
					return addCommas(parseInt(data));
				}
			},
			{ className : 'text-end align-middle', name: 'purchaseQty', // 발주량 R
				render : function(data, type, row, meta) {
					let ordQty = parseInt(row['purchaseOrdQty']); // 주문수량(제품)
					let cutQty = parseInt(row['cutQty']); // 절수
					let eaQty = parseInt(row['eaQty']); // 개수
					let extraQty = parseInt(row['extraQty']); // 여유분

					if(cutQty == 0 || eaQty == 0) {
						return '0';
					} else {
						let cuttingSize = Math.round(ordQty/(cutQty*eaQty));
						let R = parseInt(cuttingSize / 500); // R로 환산
						let purchaseQty = R + "R" + (cuttingSize % 500);
						
						return purchaseQty;
					}
				}
			},
			{ className : 'text-end align-middle', name: 'finalPurchaseQty', // 최종발주량
				render : function(data, type, row, meta) {
					let ordQty = parseInt(row['purchaseOrdQty']); // 주문수량(제품)
					let cutQty = parseInt(row['cutQty']); // 절수
					let eaQty = parseInt(row['eaQty']); // 개수
					let extraQty = parseInt(row['extraQty']); // 여유분
					let extraPackQty = parseInt(row['extraPackQty']); // 포장단위여분
					
					if(cutQty == 0 || eaQty == 0) {
						return '0';
					} else {
						let printPressQty = Math.round(ordQty/eaQty);
						let pressQty = Math.round((printPressQty + extraQty + extraPackQty)/cutQty);
						
						let R = parseInt(pressQty / 500); // R로 환산
						let finalPurchaseQty = R + "R" + (pressQty % 500);
						
						return finalPurchaseQty;
					}
				}
			},
			{ data: 'cutQty', className : 'text-end align-middle editNode', name: 'cutQty',
				render : function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						return addCommas(parseInt(data));
					} else {
						let html = '';
							html += '<input type="text" class="form-control text-end calValue" onkeyup="numberFormat(this, \'int\')" value="0">';
							html += '<span class="d-none">'+data+'</span>';
						return html;
					}
				}
			},
			{ data: 'eaQty', className : 'text-end align-middle editNode', name: 'eaQty',
				render : function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						return addCommas(parseInt(data));
					} else {
						let html = '';
							html += '<input type="text" class="form-control text-end calValue" onkeyup="numberFormat(this, \'int\')" value="0">';
							html += '<span class="d-none">'+data+'</span>';
						return html;
					}
				}
			},			
			{ data: 'extraQty', className : 'text-end align-middle calValue editNode', name: 'extraQty',
				render : function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						return addCommas(parseInt(data));
					} else {
						let html = '';
							html += '<input type="text" class="form-control text-end" onkeyup="numberFormat(this, \'int\')" value="0">';
							html += '<span class="d-none">'+data+'</span>';
						return html;
					}
				}
			},
			{ data: 'extraPackQty', className : 'text-end align-middle editNode', name: 'extraPackQty',
				render : function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						return addCommas(parseInt(data));
					} else {
						let html = '';
							html += '<input type="text" class="form-control text-end" onkeyup="numberFormat(this, \'int\')" value="0">';
							html += '<span class="d-none">'+data+'</span>';
						return html;
					}
				}
			},
			{ className : 'text-end align-middle', name: 'printPressQty', // 정매인쇄통수
				render : function(data, type, row, meta) {
					let ordQty = parseInt(row['purchaseOrdQty']); // 주문수량(제품)
					let cutQty = parseInt(row['cutQty']); // 절수
					let eaQty = parseInt(row['eaQty']); // 개수
					let extraQty = parseInt(row['extraQty']); // 여유분

					if(cutQty == 0 || eaQty == 0) {
						return '0';
					} else {
						let printPressQty = Math.round(ordQty/eaQty);
						
						return addCommas(printPressQty);
					}
				}
			},
			{ data: 'purchaseNote', className : 'text-center align-middle editNode', name: 'purchaseNote',
				render : function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						if(data != '' && data != null) {
							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						} else {
							return '';
						}
					} else {
						let html = '';
							html += '<input type="text" class="form-control" style="min-width: 200px;">';
							html += '<span class="d-none">'+data+'</span>';
						return html;
					}
				}
			},
			{ data: 'purchaseDesc', className : 'text-center align-middle editNode', name: 'purchaseDesc',
				render : function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						if(data != '' && data != null) {
							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						} else {
							return '';
						}
					} else {
						let html = '';
							html += '<input type="text" class="form-control" style="min-width: 100px;">';
							html += '<span class="d-none">'+data+'</span>';
						return html;
					}
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
			{ extend: 'excel',	text: 'Excel',	charset: 'UTF-8', bom: true },
			{ extend: 'pdf',	text: 'PDF',	},
			{ extend: 'print',	text: 'Print',		charset: 'UTF-8', bom: true },
			/* { extend: 'colvis',	text: 'Select Col',	}, */
		],
		order : [],
		drawCallback: function() {
			let api = this.api();
			
			let htmlHeight = parseFloat($('html').css('height'));
			let middlecolB_height = parseFloat($('#middlecolB').css('height'));
			let theadHeight = parseFloat($('#purchaseOrderAdmTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#purchaseOrderAdmTable_wrapper').find('.dataTables_scrollBody').css('height',(middlecolB_height - theadHeight - 80)+'px');
			
			$('#purchaseOrderAdmTable_filter').addClass('d-none');
			// 통합검색
			$('#searchAll').off('keyup',function() {});
			$('#searchAll').on('keyup',function() {
				$('#purchaseOrderAdmTable_filter').find('input').val($(this).val());
				$('#purchaseOrderAdmTable_filter').find('input').trigger('keyup');
			});

			$('.bootstrapToggle').bootstrapToggle();

			
		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#purchaseOrderAdmTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#purchaseOrderAdmTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup change').on('change', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('change');
				});
			});
		},
	});
	// dataTable colReorder event
	purchaseOrderAdmTable.on('column-reorder', function( e, settings, details ) {
		let api = purchaseOrderAdmTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#purchaseOrderAdmTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup change').on('change', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('change');
			});
		});

		$('.bootstrapToggle').bootstrapToggle();
	});

	// 발주확정
	$(document).off('change','.confirmToggle');
	$(document).on('change','.confirmToggle', function() {
		let data = bizOrderTable.row('.selected').data();

		if(data.confirmDesign != 'Y') { // 디자인컨펌이 되어야 추가 가능
			toastr.warning('해당 수주건이 디자인컨펌이 확인되지 않았습니다.');
			return false;
		}
		
		let idx = $(this).data('idx');
		let check = $(this).prop('checked');
		
		$.ajax({
			url: '<c:url value="/pm/purchaseOrderAdmUpd"/>',
			type: 'POST',
			data: {
				'idx'			:	idx,
				'confirmYn'		:	(check?'Y':'N')
			},
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					if(check) {
						toastr.success('처리되었습니다.');
					} else {
						toastr.success('취소처리되었습니다.');
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

	// 수주별발주 신규 버튼 click
	$('#btnNew').on('click', function() {
		if(bizOrderTable.row('.selected').data() == undefined) {
			toastr.warning('추가하실 수주상세번호를 선택해주세요.');
			return false;
		}

		
		WM_action_ON('ADM','workingWarningModal');
		
		purchaseOrderAdmTable.colReorder.disable();

		$('#btnNew').attr('disabled', false); // 신규 버튼
		$('#btnEdit').attr('disabled', false); // 수정 버튼

		$('#matrlSelectModal').modal('show'); 
	});
	$('#matrlSelectModal').on('shown.bs.modal', function() {
		matrlModalSelectTable.ajax.reload(function() {
			matrlModalSelectTable.select.style('multi');
			matrlModalSelectTable.select.toggleable(true);
		});
	});

	
	// 수량 계산
	$(document).on('keyup','.editNode input', function(e) {
		let tr = $(e.target).parent().parent();
		let td = $(tr).find('td');
		let ordQty = $(td).eq(purchaseOrderAdmTable.column('purchaseOrdQty:name').index()).html();
		let cutQty = $(td).eq(purchaseOrderAdmTable.column('cutQty:name').index()).find('input').val();
		let eaQty = $(td).eq(purchaseOrderAdmTable.column('eaQty:name').index()).find('input').val();
		let extraQty = $(td).eq(purchaseOrderAdmTable.column('extraQty:name').index()).find('input').val();
		let extraPackQty = $(td).eq(purchaseOrderAdmTable.column('extraPackQty:name').index()).find('input').val();
		
		ordQty = parseInt(ordQty.replaceAll(/,/g,'')); // 주문수량(제품)
		cutQty = parseInt(cutQty.replaceAll(/,/g,'')); // 절수
		eaQty = parseInt(eaQty.replaceAll(/,/g,'')); // 개수
		extraQty = parseInt(extraQty.replaceAll(/,/g,'')); // 여유분
		extraPackQty = parseInt(extraPackQty.replaceAll(/,/g,'')); // 포장단위여분

		let cuttingSize = Math.round(ordQty/(cutQty*eaQty)); // cuttingSize
		let printPressQty = Math.round(ordQty/eaQty); // 정매인쇄통수
		let pressQty = Math.round((printPressQty + extraQty + extraPackQty)/cutQty); // 통수
		let R = parseInt(cuttingSize / 500); // R로 환산
		let purchaseQty = R + "R" + (cuttingSize % 500); // 발주량 R
		//let finalPurchaseQty = R + "R" + (pressQty % 500); // 최종발주량
		/* 2022.11.10 통수/500해서 R앞에 붙도록 변경 */
		let finalPurchaseQty = parseInt(pressQty/500) + "R" + (pressQty % 500); // 최종발주량

		if(cutQty != 0 && eaQty != 0) {
			$(td).eq(purchaseOrderAdmTable.column('cuttingSize:name').index()).html(addCommas(parseInt(cuttingSize)));
			$(td).eq(purchaseOrderAdmTable.column('printPressQty:name').index()).html(addCommas(parseInt(printPressQty)));
			$(td).eq(purchaseOrderAdmTable.column('pressQty:name').index()).html(addCommas(parseInt(pressQty)));
			$(td).eq(purchaseOrderAdmTable.column('purchaseQty:name').index()).html(purchaseQty);
			$(td).eq(purchaseOrderAdmTable.column('finalPurchaseQty:name').index()).html(finalPurchaseQty);
		}
	});

	// 자재 목록 조회
	$('#matrlModalSelectTable thead tr').clone(true).addClass('filters').appendTo('#matrlModalSelectTable thead'); // filter 생성
	let matrlModalSelectTable = $('#matrlModalSelectTable').DataTable({
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
        	url : '<c:url value="/bm/matrlInfoLstByItemBom"/>',
			type : 'POST',
			data : {
				itemIdx				:	function() { return itemIdxVal;},
				matrlSelectGubun	:	function() { return $('#matrlSelectGubun').val();}
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'itemGubunNm', className : 'text-center'},
			{ data: 'matrlCd', className : 'text-center'},
			{ data: 'paperType', className : 'text-center'},//재질
			{ data: 'sizeX', className : 'text-center'},//가로
			{ data: 'sizeY', className : 'text-center'},//세로
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
			{ extend: 'print',	text: 'Print',		charset: 'UTF-8', bom: true },
			{ extend: 'colvis',	text: 'Select Col',	},
		],
		order : [],
		drawCallback: function() {
			let api = this.api();
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#matrlModalSelectTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#matrlModalSelectTable_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 223)+'px');
			
			$('#matrlModalSelectTable_filter').addClass('d-none');
			// 통합검색
			$('#searchAll').off('keyup',function() {});
			$('#searchAll').on('keyup',function() {
				$('#matrlModalSelectTable_filter').find('input').val($(this).val());
				$('#matrlModalSelectTable_filter').find('input').trigger('keyup');
			});
		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#matrlModalSelectTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#matrlModalSelectTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup change').on('change', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('change');
				});
			});
		},
	});
	// dataTable colReorder event
	matrlModalSelectTable.on('column-reorder', function( e, settings, details ) {
		let api = matrlModalSelectTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#matrlModalSelectTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup change').on('change', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('change');
			});
		});
	});

	$('#btnMatrlSelectReSearch').on('click',function(){
		matrlModalSelectTable.ajax.reload();
	});
	
	// 자재 붙여넣기 버튼 click
	$('#btnMatrlSelectModalPaste').on('click', function() {
		let dataList = matrlModalSelectTable.rows('.selected').data().toArray();

		let col_filter_text = [];
		$('#purchaseOrderAdmTable_wrapper').find('.filters th').each(function(index, item) {
			$(item).find('input').attr('disabled', true); // 검색 필터 disabled
			col_filter_text.push($(item).find('input').val());
		});

		let addList = [];
		for(var i=0;i<dataList.length;i++) {
			let obj = {};
			obj.idx = '';
			obj.matrlIdx = dataList[i].matrlIdx;
			obj.matrlCd = dataList[i].matrlCd;
			obj.matrlNm = dataList[i].matrlNm;
			obj.paperType = dataList[i].paperType;
			obj.confirmYn = 'N';
			obj.printYn = 'N';
			obj.purchaseOrdNo = '자동채번';
			obj.purchaseOrdQty = ordQtyVal;
			obj.purchaseOrdDate = moment().format('YYYY-MM-DD');
			obj.purchaseInDueDate = moment().format('YYYY-MM-DD');
			if(dataList[i].dealCorpIdx > 0 && dataList[i].dealCorpNm != null){
				obj.dealCorpIdx = dataList[i].dealCorpIdx;
				obj.dealCorpNm = dataList[i].dealCorpNm;
			} else {
				obj.dealCorpIdx = '';
				obj.dealCorpNm = '';
			}
			obj.cutQty = '0';
			obj.eaQty = '0';
			obj.extraQty = '0';
			obj.extraPackQty = '0';
			obj.cutSize = '';
			obj.purchaseNote = '';
			obj.purchaseDesc = '';
			addList.push(obj);
		}
		
		purchaseOrderAdmTable.rows.add(addList).draw(false);

		$('#btnSave').attr('disabled', false); // 저장 버튼
		$('#btnDel').attr('disabled', false); // 삭제 버튼
		$('#btnCancel').attr('disabled', false); // 취소 버튼
	});

	// 수주별발주 저장 버튼 click
	$('#btnSave').on('click', function() {
		let array = [];
		let state = true;
		$('#purchaseOrderAdmTable tbody').find('tr').each(function(index, item) {
			if($(item).find('td').find('input').length > 3) {
				let td = $(item).find('td');
				let idx = purchaseOrderAdmTable.row($(item)).data().idx;
				let purchaseOrdNo = purchaseOrderAdmTable.row($(item)).data().purchaseOrdNo;
				let purchaseOrdQty = purchaseOrderAdmTable.row($(item)).data().purchaseOrdQty;
				
				let purchaseOrdDate = $(td).eq(purchaseOrderAdmTable.column('purchaseOrdDate:name').index()).find('input').val();
				let purchaseInDueDate = $(td).eq(purchaseOrderAdmTable.column('purchaseInDueDate:name').index()).find('input').val();
				let dealCorpIdx = $(td).eq(purchaseOrderAdmTable.column('dealCorpNm:name').index()).find('input[type=hidden]').val();
				let cutQty = $(td).eq(purchaseOrderAdmTable.column('cutQty:name').index()).find('input').val();
				let eaQty = $(td).eq(purchaseOrderAdmTable.column('eaQty:name').index()).find('input').val();
				let extraQty = $(td).eq(purchaseOrderAdmTable.column('extraQty:name').index()).find('input').val();
				let extraPackQty = $(td).eq(purchaseOrderAdmTable.column('extraPackQty:name').index()).find('input').val();
				let cutSize = $(td).eq(purchaseOrderAdmTable.column('cutSize:name').index()).find('input').val();
				let purchaseNote = $(td).eq(purchaseOrderAdmTable.column('purchaseNote:name').index()).find('input').val();
				let purchaseDesc = $(td).eq(purchaseOrderAdmTable.column('purchaseDesc:name').index()).find('input').val();

				let ordQty = parseInt(purchaseOrdQty); // 주문수량(제품)
				let cutQtyInt = parseInt(cutQty); // 절수
				let eaQtyInt = parseInt(eaQty); // 개수
				let extraQtyInt = parseInt(extraQty); // 여유분
				
				let printPressQty = Math.round(ordQty/eaQtyInt);
				let pressQty = Math.round((printPressQty + extraQtyInt)/cutQtyInt);
				
				let R = parseInt(pressQty / 500); // R로 환산
				let finalPressQty = R + "R" + (pressQty % 500);
				

				if(purchaseOrdDate == '') {
					toastr.warning('발주일을 선택해주세요.');
					$(td).eq(purchaseOrderAdmTable.column('purchaseOrdDate:name').index()).find('input').focus();
					state = false;
					return false;
				}
				if(purchaseInDueDate == '') {
					toastr.warning('입고예정일을 입력해주세요.');
					$(td).eq(purchaseOrderAdmTable.column('purchaseInDueDate:name').index()).find('input').focus();
					state = false;
					return false;
				}
				if(dealCorpIdx == '') {
					toastr.warning('발주처를 선택해주세요.');
					$(td).eq(purchaseOrderAdmTable.column('dealCorpNm:name').index()).find('button').focus();
					state = false;
					return false;
				}
				if(cutQty == '' || cutQty == '0') {
					toastr.warning('절수를 입력해주세요.');
					$(td).eq(purchaseOrderAdmTable.column('cutQty:name').index()).find('input').focus();
					state = false;
					return false;
				}
				if(eaQty == '' || eaQty == '0') {
					toastr.warning('개수를 입력해주세요.');
					$(td).eq(purchaseOrderAdmTable.column('eaQty:name').index()).find('input').focus();
					state = false;
					return false;
				}
				if(cutSize == '') {
					toastr.warning('재단규격을 입력해주세요.');
					$(td).eq(purchaseOrderAdmTable.column('cutSize:name').index()).find('input').focus();
					state = false;
					return false;
				}

				let obj = new Object();
				obj.idx = idx;
				obj.bizOrdDtlIdx = bizOrdDtlIdxVal;
				obj.purchaseOrdDate = moment(purchaseOrdDate).format('YYYYMMDD');
				obj.purchaseInDueDate = moment(purchaseInDueDate).format('YYYYMMDD');
				obj.dealCorpIdx = dealCorpIdx;
				obj.cutQty = cutQty.replaceAll(/,/g,'');
				obj.eaQty = eaQty.replaceAll(/,/g,'');
				obj.extraQty = extraQty.replaceAll(/,/g,'');
				obj.extraPackQty = extraPackQty.replaceAll(/,/g,'');
				obj.cutSize = cutSize;
				obj.purchaseNote = purchaseNote;
				obj.purchaseDesc = purchaseDesc;
				obj.purchaseOrdIdxList = [];
				
				obj.purchaseOrdNo = purchaseOrderAdmTable.row($(item)).data().purchaseOrdNo;
				obj.confirmYn = purchaseOrderAdmTable.row($(item)).data().confirmYn;
				obj.matrlIdx = purchaseOrderAdmTable.row($(item)).data().matrlIdx;
				obj.matrlCd = purchaseOrderAdmTable.row($(item)).data().matrlCd;
				obj.matrlNm = purchaseOrderAdmTable.row($(item)).data().matrlNm;
				obj.paperType = purchaseOrderAdmTable.row($(item)).data().paperType;
				obj.printYn = purchaseOrderAdmTable.row($(item)).data().printYn;
				obj.purchaseOrdQty = purchaseOrdQty;
				obj.regDate = purchaseOrderAdmTable.row($(item)).data().regDate;
				obj.regIdx = purchaseOrderAdmTable.row($(item)).data().regIdx;
				obj.updDate = purchaseOrderAdmTable.row($(item)).data().updDate;
				obj.updIdx = purchaseOrderAdmTable.row($(item)).data().updIdx;
			    
			    array.push(obj);
		    }
		});

		if(!state) {
			return false;
		}

		array = _.differenceWith(array, purchaseOrderAdmTable.data().toArray(), _.isEqual);

		console.log(array);

		$.ajax({
			url: '<c:url value="/pm/purchaseOrderAdmIU"/>',
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
        
					WM_action_OFF('ADM');
        
					purchaseOrderAdmTable.clear().draw();
					purchaseOrderAdmTable.ajax.reload(function() {
						$('#purchaseOrderAdmTable_wrapper').find('.filters th').each(function(index, item) {
							$(item).find('input').attr('disabled', false);// 검색 필터 enable
						});
					});
        
					purchaseOrderAdmTable.colReorder.enable();
        
					$('#btnNew').attr('disabled', false); // 신규 버튼
					$('#btnSave').attr('disabled', true); // 저장 버튼
					$('#btnEdit').attr('disabled', false); // 수정 버튼
					$('#btnDel').attr('disabled', false); // 삭제 버튼
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

	// 수주별발주 수정 버튼 click
	$('#btnEdit').on('click', function() {
		WM_action_ON('ADM','workingWarningModal');
		
		$('#purchaseOrderAdmTable_wrapper').find('.filters th').each(function(index, item) {
			$(item).find('input').attr('disabled', true); // 검색 필터 disabled
		});
		
		$('#purchaseOrderAdmTable tbody').find('tr').each(function(index_tr, tr) {
			$(tr).find('td').each(function(index_td, td) {
				if($(td).hasClass('editNode') && $(td).find('input').length != 1) {
					if(index_td == purchaseOrderAdmTable.column('purchaseOrdDate:name').index()) { // 발주일자
						let value = purchaseOrderAdmTable.row(tr).data().purchaseOrdDate;
						value = moment(value).format('YYYY-MM-DD');
						$(td).html('<input type="date" max="9999-12-31" class="form-control text-center" value="'+value+'">');
					} else if(index_td == purchaseOrderAdmTable.column('purchaseInDueDate:name').index()) { // 입고예정일
						let value = purchaseOrderAdmTable.row(tr).data().purchaseInDueDate;
						value = moment(value).format('YYYY-MM-DD');
						$(td).html('<input type="date" max="9999-12-31" class="form-control text-center" onkeyup="numberFormat(this, \'int\')" value="'+value+'">');
					} else if(index_td == purchaseOrderAdmTable.column('dealCorpNm:name').index()) { // 발주처
						$(td).find('button').attr('disabled',false);
					} else { // 그 외
						let value = $(td).text();
						if(index_td == purchaseOrderAdmTable.column('cutQty:name').index() ||
						   index_td == purchaseOrderAdmTable.column('eaQty:name').index() ||
						   index_td == purchaseOrderAdmTable.column('extraQty:name').index() ||
						   index_td == purchaseOrderAdmTable.column('extraPackQty:name').index()) { // 절수, 개수, 여분, 포장단위여분
							$(td).html('<input type="text" class="form-control text-end" onkeyup="numberFormat(this, \'int\')" value="'+value+'">');
						} else {
							$(td).html('<input type="text" class="form-control text-center" value="'+value+'">');
						}
					}
				}
			})
		});

		purchaseOrderAdmTable.colReorder.disable();
		purchaseOrderAdmTable.draw();

		$('#btnNew').attr('disabled', false); // DTL 신규 버튼
		$('#btnSave').attr('disabled', false); // DTL 저장 버튼
		$('#btnEdit').attr('disabled', true); // DTL 수정 버튼
		$('#btnDel').attr('disabled', false); // DTL 삭제 버튼
		$('#btnCancel').attr('disabled', false); // DTL 취소 버튼
	});

	// 수주별발주 삭제 버튼 click
	$('#btnDel').on('click', function() {
		if($('#purchaseOrderAdmTable tbody').find('tr.selected').length == 0) {
			toastr.warning('삭제할 항목을 선택해주세요.');
			return false;
		}

		let data = purchaseOrderAdmTable.row('.selected').data();

		if(data.idx != '') {
			$('#deleteModal').modal('show');
			$('#deleteModal').data('deleteType','ADM');
		} else {
			purchaseOrderAdmTable.row('.selected').remove().draw();
		}
	});

	// 삭제 경고창 삭제 버튼 click
	$('#btnDeleteModalY').on('click', function() {
		let deleteType = $('#deleteModal').data('deleteType');
		if(deleteType == 'ADM') {
			let idx = purchaseOrderAdmTable.row('.selected').data().idx;
			$.ajax({
				url: '<c:url value="/pm/purchaseOrderAdmDel"/>',
	            type: 'POST',
	            data: {
	                'idx'	:	idx
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if (res.result == "ok") { //응답결과
						toastr.success('삭제되었습니다.');

						purchaseOrderAdmTable.clear().draw();
						purchaseOrderAdmTable.ajax.reload();
						purchaseOrderAdmTable.row('.selected').remove().draw(false);
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

	// 수주별발주 취소 버튼 click
	$('#btnCancel').on('click', function() {
		$('#cancelModal').modal('show');
		$('#cancelModal').data('cancelType', 'ADM');
	});

	// 취소 경고창 취소 버튼 click
	$('#btnCancelModalY').on('click', function() {
		let cancelType = $('#cancelModal').data('cancelType');

		if(cancelType == 'ADM') {
			toastr.success('취소되었습니다.');
			WM_action_OFF('ADM');

			$('#btnSearch').trigger('click'); // 조회 버튼 click

			purchaseOrderAdmTable.ajax.reload();
			purchaseOrderAdmTable.colReorder.enable();

			$('#purchaseOrderAdmTable_wrapper').find('.filters th').each(function(index, item) {
				$(item).find('input').attr('disabled', false); // 검색 필터 disabled
			});
			
			$('#btnNew').attr('disabled', false); // 신규 버튼
			$('#btnSave').attr('disabled', true); // 저장 버튼
			$('#btnEdit').attr('disabled', false); // 수정 버튼
			$('#btnDel').attr('disabled', false); // 삭제 버튼
			$('#btnCancel').attr('disabled', true); // 취소 버튼
		}
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
			{ extend: 'excel',	text: 'Excel',	charset: 'UTF-8', bom: true },
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
				$('#dealCorpModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup change').on('change', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('change');
				});
			});
		},
	});
	// dataTable colReorder event
	dealCorpModalTable.on('column-reorder', function( e, settings, details ) {
		let api = dealCorpModalTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#dealCorpModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup change').on('change', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('change');
			});
		});
	});
	$('#btnDealCorpModalSearch').on('click',function(){
		dealCorpModalTable.ajax.reload(function() {});
	});
	
	//발주처 돋보기버튼
	$(document).on('click','.dealCorpModalBtn',function(){
		matrlIdxVal = $(this).data('matrlidx'); //자재 식별자
		if(matrlIdxVal == '' || matrlIdxVal == null || matrlIdxVal == "null"){
			matrlIdxVal = 0;
		} 
		$('#dealCorpModal').modal('show');
		setTimeout(function() {
			dealCorpModalTable.ajax.reload(function() {});
		}, 200);	
	});

	// 발주처 조회
	$('#btnDealCorpSelectSearch').on('click',function(){
		dealCorpModalTable.ajax.reload();
	});

	// 발주처 붙여넣기
	$('#btnDealCorpModalPaste').on('click',function(){
		if(!$('#dealCorpModalTable tbody tr').hasClass('selected')){
			toastr.warning('붙여넣을 행을 선택해주세요.');
			return false;
		}
		let node = purchaseOrderAdmTable.row('.selected').node();
		let data = purchaseOrderAdmTable.row('.selected').data();
		let selectNodeModalData = dealCorpModalTable.row('.selected').data();
		$(node).find('td').eq(purchaseOrderAdmTable.column('dealCorpNm:name').index()).find('input[type=hidden]').val(selectNodeModalData.idx);			//발주처 식별자
		$(node).find('td').eq(purchaseOrderAdmTable.column('dealCorpNm:name').index()).find('input[type=text]').val(selectNodeModalData.dealCorpNm);		//발주처 이름
		$('#dealCorpModal').modal('hide');
	});
</script>

</body>
</html>
