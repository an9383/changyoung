<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
pageContext.setAttribute("newLineChar", "\n");
%>

<%@include file="../layout/top.jsp"%>
<%@include file="../layout/modal.jsp"%>
<%@include file="../layout/script.jsp"%>
<div id="page" onmouseup="EndDrag(this)" onmousemove="OnDrag(event)" style="grid-template-areas: 'leftcol'; grid-template-rows: 1fr; grid-template-columns: 1fr;">
	<div id="leftcol">
		<div class="container-fluid h-100" style="padding: 5px;">
			<div class="row" id="leftHeader" style="padding-bottom: 5px;">
				<div class="d-flex align-items-center d-flex">
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">조회일시</label>
					<input type="date" class="form-control w-auto h-100 me-1" id="startDate"> 
					<label class="form-label d-flex align-items-center m-0 me-1 h-100">~</label>
					<input type="date" max="9999-12-31" class="form-control w-auto h-100 me-1" id="endDate">
					<select class="form-select w-auto h-100 me-1 monthAdjust" id="monthAdjust">
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
					
					<!-- <label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">조회대상</label>
					<select class="form-select w-auto h-100 me-3" id="searchTarget">
						<option value="" selected>전체</option>
						<option value="Y">보유품목</option>
					</select>  -->
					
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100 d-none">품목구분</label>
					<select class="form-select w-auto h-100 me-3 d-none" id="searchItemGubun">
						<option value="" >전체</option>
						<option value="item">제품</option>
						<option value="matrl" selected>자재</option>
					</select> 
					<!-- <label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">품목</label>
					<div class="input-group w-auto h-100 me-3">
						<input type="text" class="form-control" id="searchItemNm" disabled>

						<button type="button" id="btnSearchItemDel" class="" style="background-color: transparent; border-color: transparent; position: absolute; top: 0; right: 0; margin: 5px 23px; margin-left: 0px; border: none;">
							<i class="fa-solid fa-xmark"></i>
						</button>
						<input type="hidden" id="searchItemIdx">

						<button type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary" id="btnSearchItem">
							<i class="fa-solid fa-magnifying-glass"></i>
						</button>
					</div>
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">창고</label>
					<div class="input-group w-auto h-100 me-3">
						<input type="text" class="form-control" id="searchLcNm" disabled>
						<input type="hidden" id="searchLcIdx">
						<button type="button" id="btnSearchLcDel"
							style="background-color: transparent; border-color: transparent; position: absolute; top: 0; right: 0; margin: 5px 23px; margin-left: 0px; border: none;">
							<i class="fa-solid fa-xmark"></i>
						</button>
						<button type="button" style="padding: 1px 4px; margin-left: 0px;"
							class="btn btn-primary" id="btnSearchLc">
							<i class="fa-solid fa-magnifying-glass"></i>
						</button>
					</div>
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">거래처</label>
					<div class="input-group w-auto h-100 me-3">
						<input type="text" class="form-control" id="searchDealCorpNm" disabled> 
						<input type="hidden" id="searchDealCorpIdx">
						<button type="button" id="btnSearchDealCorpDel"	style="background-color: transparent; border-color: transparent; position: absolute; top: 0; right: 0; margin: 5px 23px; margin-left: 0px; border: none;">
							<i class="fa-solid fa-xmark"></i>
						</button>
						<button type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary" id="btnSearchDealCorp">
							<i class="fa-solid fa-magnifying-glass"></i>
						</button>
					</div> -->

					<input type="text" class="form-control w-auto h-100 me-1"
						id="searchAll" placeholder="통합검색">
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end">
					<div class="btn-group" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnSearch">
							<i class="fa-regular fa-clipboard"></i>
						</button>
					</div>
				</div>
			</div>
			<div class="row">
				<table class="table table-bordered p-0 m-0"	id="stockPaymentAdmTable">
					<thead class="table-light">
						
						<tr>
							<th class="text-center align-middle" >창고명</th>
							<th class="text-center align-middle" >품목명</th>
							<th class="text-center align-middle">구분</th>
							<th class="text-center align-middle">일자</th>
							<th class="text-center align-middle" >입고</th>
							<th class="text-center align-middle" >®</th>
							<th class="text-center align-middle" >출고</th>
							<th class="text-center align-middle" >®</th>
							<th class="text-center align-middle" >현재고</th>
							<th class="text-center align-middle" >®</th>
						</tr>
						<colgroup>
							<col style="width:7%;">
							<col style="width:20%;">
							<col style="width:8%;">
							<col style="width:5%;"><!-- 40 -->
							<col style="width:10%;">
							<col style="width:10%;">
							<col style="width:10%;">
							<col style="width:10%;">
							<col style="width:10%;">
							<col style="width:10%;">
						</colgroup>
					</thead>
					<tfoot id="stockPaymentAdmTableTfoot">
						<tr>
							<th class="text-center align-middle" colspan="4">합계</th>
							<th class="text-end align-middle" id="inputFoot"></th>
							<th class="text-end align-middle" id="inputFootR"></th>
							<th class="text-end align-middle" id="outputFoot"></th>
							<th class="text-end align-middle" id="outputFootR"></th>
							<th class="text-end align-middle" id="sumSpQtyFoot"></th>
							<th class="text-end align-middle" id="sumSpQtyFootR"></th>
						</tr>
					</tfoot>
				</table>
			</div>
		</div>
	</div>
</div>
<!-- 품명조회 모달 -->
<div class="modal fade" id="itemNmModal" tabindex="-1"	aria-hidden="true">
	<div class="modal-dialog" style="max-width: 55vw;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">품목 조회</h5>
				<div class="btn-group" role="group" aria-label="Small button group">
					<button type="button" class="btn btn-outline-light w-auto"
						style="font-size: 20px !important;" id="btnItemNmModalPaste">
						<i class="fa-regular fa-paste"></i>
					</button>
					<button type="button" class="btn btn-outline-light w-auto"
						style="font-size: 20px !important;" data-bs-dismiss="modal"
						aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>
			</div>
			<div class="modal-body">
				<!-- <div class="row" style="padding-bottom: 5px;">
					<div class="d-flex align-items-center d-flex">
						<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">품목구분</label>
						<select class="form-select w-auto h-100 me-3" id="itemNmGubun">
							<option value="" selected>전체</option>
							<option value="item">제품</option>
							<option value="matrl">자재</option>
						</select>
					</div>
					<div class="me-lg-auto"></div>
					<div class="d-flex align-items-center justify-content-end">
						<div class="btn-group" role="group" aria-label="Small button group">
							<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnItemNmSearch">
								<i class="fa-regular fa-clipboard"></i>
							</button>
						</div>
					</div>
				</div> -->

				<table class="table table-bordered p-0 m-0" id="itemNmModalTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle">구분</th>
							<th class="text-center align-middle">품명</th>
						</tr>
					</thead>
				</table>
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
</script>

<script>

	let monthAdjustList = getCommonCode('시스템', '026'); //날짜조정
	monthAdjustList = _.sortBy(monthAdjustList, v=>parseInt(v.commonCd));
	selectBoxAppend(monthAdjustList, 'monthAdjust', '', '2'); //날짜조정
	//공통코드 조회
	let dealGubunList = getCommonCode('시스템', '011'); // 거래구분
	let dealStatusList = getCommonCode('시스템', '015'); // 거래상태
	let locationModalItemGubunList = getCommonCode('일반', '022'); // 품목구분
	selectBoxAppend(dealGubunList, 'modalDealGubun', '', '1'); //거래구분
	selectBoxAppend(dealStatusList, 'modalDealCorpStatus', '', '1'); //거래상태
	selectBoxAppend(locationModalItemGubunList, 'locationModalItemGubun', '', '1');

	let selectPeriod = parseInt(getCommonCode('시스템', '040')[0].commonCd); //기본조회기간 일
	$('#startDate').val(moment().subtract('d',selectPeriod).format('YYYY-MM-DD'));
	$('#endDate').val(moment().format('YYYY-MM-DD'));
	
	// 사용자정보 목록조회
	$('#stockPaymentAdmTable thead tr').clone(true).addClass('filters').appendTo('#stockPaymentAdmTable thead'); // filter 생성
	let stockPaymentAdmTable = $('#stockPaymentAdmTable').DataTable({
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
		select: {
            style: 'single',
            toggleable: false,
            items: 'row',
            info: false
        },
        ajax : {
			url : '<c:url value="/stock/stockPaymentAdmOriginalLst"/>',
			type : 'POST',
			data : {
				startDate		: function() { return moment($('#startDate').val()).format('YYYYMMDD'); },
				endDate			: function() { return moment($('#endDate').val()).format('YYYYMMDD'); },
				lcIdx			: function() { return $('#searchLcIdx').val(); },
				itemIdx			: function() { return $('#searchItemIdx').val(); },
				itemGubun		: function() { return $('#searchItemGubun').val(); },
				dealCorpIdx		: function() { return $('#searchDealCorpIdx').val(); },
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'lcNm', className : 'text-center align-middle', name:'rowsGroup'},
			{ data: 'spCd', className : 'text-center align-middle', name:'rowsGroup'},
			{ data: 'spType2', className : 'text-center align-middle'},
			{ data: 'spDate', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						if(data.slice(-2) == '00'){//초기재고 반영된 경우 끝2자리가 00일로 되어있음
							return moment(data.slice(0,-2) + '01').format('YYYY-MM');
						} else {
							return moment(data).format('YYYY-MM-DD');
						}
					} else {
						return '-';
					}
				}
			},
			{ data: 'spQty', className : 'text-end align-middle',name:'inQty',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						if(row['spType'] == '입고' || row['spType'] == '조정입고'){
							return addCommas(parseInt(data));
						} else{
							return '';
						}
					} else {
						return '';
					}
				}
			},
			{ data: 'spQty', className : 'text-end align-middle',name:'inQtyR',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						if(row['spType'] == '입고' || row['spType'] == '조정입고'){
							let returnR = '';
							if(row['spGubun'] == '002'){//자재인경우
								if(parseInt(data) < 0){
									returnR = "-" + parseInt(-1*data/500) + "R" + parseInt(-1*data%500); 
								} else {
									returnR = parseInt(data/500) + "R" + parseInt(data%500); 
								}
							} else {
								returnR = '-';
							}
							return returnR;
						} else{
							return '';
						}
					} else {
						return '';
					}
				}
			},
			{ data: 'spQty', className : 'text-end align-middle',name:'outQty',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						if(row['spType'] == '출고' || row['spType'] == '조정출고'){
							return addCommas(parseInt(data));
						} else{
							return '';
						}
					} else {
						return '';
					}
				}
			},
			{ data: 'spQty', className : 'text-end align-middle',name:'outQtyR',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						if(row['spType'] == '출고' || row['spType'] == '조정출고'){
							let returnR = '';
							if(row['spGubun'] == '002'){//자재인경우
								if(parseInt(data) < 0){
									returnR = "-" + parseInt(-1*data/500) + "R" + parseInt(-1*data%500); 
								} else {
									returnR = parseInt(data/500) + "R" + parseInt(data%500); 
								}
							} else {
								returnR = '-';
							}
							return returnR;
						} else{
							return '';
						}
					} else {
						return '';
					}
				}
			},
			{ data: 'sumSpQty', className : 'text-end align-middle',name:'sumSpQty',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return addCommas(parseInt(data));
					} else {
						return '';
					}
				}
			},
			{ data: 'sumSpQty', className : 'text-end align-middle',name:'sumSpQtyR',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						let returnR = '';
						if(row['spGubun'] == '002'){//자재인경우
							if(parseInt(data) < 0){
								returnR = "-" + parseInt(-1*data/500) + "R" + parseInt(-1*data%500); 
							} else {
								returnR = parseInt(data/500) + "R" + parseInt(data%500); 
							}
						} else {
							returnR = '-';
						}
						return returnR;
					} else {
						return '';
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
			{ extend: 'colvis',	text: 'Select Col',	},
		],
		/* rowsGroup: [
			'rowsGroup:name'
	 	], */
		order : [],
		drawCallback: function() {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#stockPaymentAdmTable_wrapper').find('.dataTables_scrollHead').css('height'));
			let tfootHeight = parseFloat($('#stockPaymentAdmTableTfoot').css('height'));
			
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - tfootHeight - 108)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAll').off('keyup',function() {});
			$('#searchAll').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			});

			$('#stockPaymentAdmTable tfoot').remove();
			for(var i=0;i<api.data().count();i++) {
				let data = api.row(i).data();
				let node = api.row(i).node();
				if(data.spType2 == '현재고') {
					$(node).addClass('bg-warning bg-gradient bg-opacity-50');
				}

			}
			
		},
		footerCallback : function() {
			let api = this.api();
			let data = api.rows( {page : 'current'} ).data().toArray();

			//입출고
			let inQtyData = _.filter(data, v=> v.spType == '입고' || v.spType =='조정입고');
			let outQtyData = _.filter(data, v=> v.spType == '출고' || v.spType =='조정출고');
			let inQty = _.sumBy(inQtyData,v=>parseFloat(v.spQty));
			let outQty = _.sumBy(outQtyData,v=>parseFloat(v.spQty));
			//현재고
			let sumSpQtyData = _.filter(data, v=> v.spType2 == '현재고');
			let sumSpQty = _.sumBy(sumSpQtyData,v=>parseFloat(v.spQty));
			
			//기본 합계 
			$('#inputFoot').html(addCommas(inQty));
			$('#outputFoot').html(addCommas(outQty));
			$('#sumSpQtyFoot').html(addCommas(sumSpQty));
			//R컬럼 함수화 시켜놈 (소스 엄청길어서 가시성 떨어짐)
			dataRFootDraw(data);
		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#stockPaymentAdmTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#stockPaymentAdmTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	stockPaymentAdmTable.on('column-reorder', function( e, settings, details ) {
		let api = stockPaymentAdmTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#stockPaymentAdmTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
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
		stockPaymentAdmTable.ajax.reload(function() {});

		setTimeout(function() {
			$('#my-spinner').hide();
		}, 100)
	});

	// ---------------------------------------------------------------- 창고목록조회 -------------------------------------------------------------
	// 창고조회버튼 click
	$('#btnSearchLc').on('click', function() {
		$('#locationModal').modal('show');
	});
	$('#locationModal').on('shown.bs.modal', function() {
		locationModalTable.ajax.reload(function() {});
	});

	// 창고조회 x 버튼 click
	$('#btnSearchLcDel').on('click', function() {
		$('#searchLcNm').val('');
		$('#searchLcIdx').val('');
	});

	// 창고관리 목록조회
	$('#locationModalTable thead tr').clone(true).addClass('filters').appendTo('#locationModalTable thead'); // filter 생성
	let locationModalTable = $('#locationModalTable').DataTable({
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
		colReorder: true,
		select: {
            style: 'single',
            toggleable: false,
            items: 'row',
            info: false
        },
        ajax : {
			url : '<c:url value="/bm/locationAdmList"/>',
			type : 'GET',
			data : {
				itemGubun	:	function() { return $('#locationModalItemGubun').val();}
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'lcCd', className : 'text-center align-middle'},
			{ data: 'lcNm', className : 'text-center align-middle'},
			{ data: 'lcTypeOutput', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data == 'Y') {
						return '<i class="fa-solid fa-check mt-1 text-success"></i>';
					} else {
						return '<i class="fa-solid fa-x mt-1 text-danger"></i>';
					}
				}
			},
			{ data: 'lcTypeInput', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data == 'Y') {
						return '<i class="fa-solid fa-check mt-1 text-success"></i>';
					} else {
						return '<i class="fa-solid fa-x mt-1 text-danger"></i>';
					}
				}
			},
			{ data: 'lcTypeReturn', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data == 'Y') {
						return '<i class="fa-solid fa-check mt-1 text-success"></i>';
					} else {
						return '<i class="fa-solid fa-x mt-1 text-danger"></i>';
					}
				}
			},
			{ data: 'lcTypeQc', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data == 'Y') {
						return '<i class="fa-solid fa-check mt-1 text-success"></i>';
					} else {
						return '<i class="fa-solid fa-x mt-1 text-danger"></i>';
					}
				}
			},
			{ data: 'lcTypeOutsourcing', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data == 'Y') {
						return '<i class="fa-solid fa-check mt-1 text-success"></i>';
					} else {
						return '<i class="fa-solid fa-x mt-1 text-danger"></i>';
					}
				}
			},
			{ data: 'itemGubunNm', className : 'text-center align-middle'},
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
			//let middlecolT_height = parseFloat($('#middlecolT').css('height'));
			let theadHeight = parseFloat($('#locationModalTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#locationModalTable_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 230)+'px');
			
			$('#locationModalTable_filter').addClass('d-none');
			// 통합검색
			//$('#searchAllAdm').off('keyup',function() {});
			//$('#searchAllAdm').on('keyup',function() {
			//	$('#locationModalTable_filter').find('input').val($(this).val());
			//	$('#locationModalTable_filter').find('input').trigger('keyup');
			//});
		},
		initComplete: function () {
			let api = this.api();
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#locationModalTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title.replaceAll('*','') + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#locationModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	locationModalTable.on('column-reorder', function( e, settings, details ) {
		let api = locationModalTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#locationModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	// 창고 모달 조회 버튼 click
	$('#btnLocationSearch').on('click', function() {
		$('#my-spinner').show();
		locationModalTable.ajax.reload(function() {});
		
		setTimeout(function() {
			$('#my-spinner').hide();
		}, 100)
	});

	// 창고 모달 붙여넣기 버튼 click
	$('#btnLocationModalPaste').on('click', function() {
		if(!$('#locationModalTable tbody tr').hasClass('selected')){
			toastr.warning('붙여넣을 행을 선택해주세요.');
			return false;
		}
		let data = locationModalTable.row('.selected').data();
		$('#searchLcNm').val(data.lcNm);
		$('#searchLcIdx').val(data.idx);
		$('#locationModal').modal('hide');
	});

	$('#locationModalTable tbody').on('dblclick','tr',function(){
		let data = locationModalTable.row(this).data();
		$('#searchLcNm').val(data.lcNm);
		$('#searchLcIdx').val(data.idx);
		$('#locationModal').modal('hide');
	});
	
	// ---------------------------------------------------------------- 품목목록조회 -------------------------------------------------------------
	// 품목추가 버튼 click
	$('#btnSearchItem').on('click', function() {
		$('#itemNmModal').modal('show');
		setTimeout(function() {
			itemNmModalTable.ajax.reload(function() {itemNmModalTable.draw(false);});
		}, 200);
	});

	$('#btnItemNmSearch').on('click',function(){
		itemNmModalTable.ajax.reload(function() {itemNmModalTable.draw(false);});
	});

	$('#btnItemNmModalPaste').on('click',function(){

		if(!$('#itemNmModalTable tbody tr').hasClass('selected')){
			toastr.warning('붙여넣을 행을 선택해주세요.');
			return false;
		}

		let data = itemNmModalTable.row('.selected').data();
		$('#searchItemNm').val(data.itemNm);
		$('#searchItemIdx').val(data.idx);
		$('#searchItemGubun').val(data.itemMatrlGubun);

		$('#itemNmModal').modal('hide');
		
	});
	
	$('#btnSearchItemDel').on('click',function(){
		$('#searchItemNm').val('');
		$('#searchItemIdx').val('');
		$('#searchItemGubun').val('');
	});

	$('#searchItemGubun').on('change',function(){
		$('#searchItemNm').val('');
		$('#searchItemIdx').val('');
	});
	
	//제품정보 목록(모달)조회
	$('#itemNmModalTable thead tr').clone(true).addClass('filters').appendTo('#itemNmModalTable thead'); // filter 생성
	let itemNmModalTable = $('#itemNmModalTable').DataTable({
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
			url : '<c:url value="/bm/itemInfoAndMatrlListAll"/>',
			type : 'POST',
			data : {
				itemMatrlGubun : function(){return $('#searchItemGubun').val();},
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'itemMatrlGubun', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						let text = '';
						if(data == 'item'){
							text = '제품';
						} else {
							text = '자재';
						}
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+text+'</div>';
					} else {
						return "-";
					}
				}	
			},	//구분
			{ data: 'itemNm', className : 'text-center align-middle'}, 		//제품명
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
			let data = api.data();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#itemNmModalTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 250)+'px');
			
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
				let cell = $('#itemNmModalTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#itemNmModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	itemNmModalTable.on('column-reorder', function( e, settings, details ) {
		let api = itemNmModalTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#itemNmModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	$('#itemNmModalTable tbody').on('dblclick','tr',function(){
		let data = itemNmModalTable.row(this).data();
		$('#searchItemNm').val(data.itemNm);
		$('#searchItemIdx').val(data.idx);
		$('#searchItemGubun').val(data.itemMatrlGubun);

		$('#itemNmModal').modal('hide');
	});
	
	// ---------------------------------------------------------------- 거래처목록조회 -------------------------------------------------------------
	// 거래처조회 버튼 click
	$('#btnSearchDealCorp').on('click', function() {
		$('#dealCorpModal').modal('show');
	});
	$('#dealCorpModal').on('shown.bs.modal', function() {
		dealCorpModalTable.ajax.reload(function() {});
	});

	// 거래처조회 x 버튼 click
	$('#btnSearchDealCorpDel').on('click', function() {
		$('#searchDealCorpNm').val('');
		$('#searchDealCorpIdx').val('');
	});

	// 창고관리 목록조회
	$('#dealCorpModalTable thead tr').clone(true).addClass('filters').appendTo('#dealCorpModalTable thead'); // filter 생성
	let dealCorpModalTable = $('#dealCorpModalTable').DataTable({
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
			//let middlecolT_height = parseFloat($('#middlecolT').css('height'));
			let theadHeight = parseFloat($('#dealCorpModalTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#dealCorpModalTable_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 230)+'px');
			
			$('#dealCorpModalTable_filter').addClass('d-none');
			// 통합검색
			$('#searchAllAdm').off('keyup',function() {});
			$('#searchAllAdm').on('keyup',function() {
				$('#dealCorpModalTable_filter').find('input').val($(this).val());
				$('#dealCorpModalTable_filter').find('input').trigger('keyup');
			});
		},
		initComplete: function () {
			let api = this.api();
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#dealCorpModalTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title.replaceAll('*','') + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#dealCorpModalTable_wrapper').find('.filters th')
												.eq($(api.column(colIdx).header()).index())
												.find('input')
												.off('keyup change').on('change', function (e) {
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

	// 창고 모달 조회 버튼 click
	$('#btnDealCorpModalSearch').on('click', function() {
		$('#my-spinner').show();
		dealCorpModalTable.ajax.reload(function() {});
		
		setTimeout(function() {
			$('#my-spinner').hide();
		}, 100)
	});

	// 창고 모달 붙여넣기 버튼 click
	$('#btnDealCorpModalPaste').on('click', function() {
		if(!$('#dealCorpModalTable tbody tr').hasClass('selected')){
			toastr.warning('붙여넣을 행을 선택해주세요.');
			return false;
		}
		let data = dealCorpModalTable.row('.selected').data();
		$('#searchDealCorpNm').val(data.dealCorpNm);
		$('#searchDealCorpIdx').val(data.idx);
		$('#dealCorpModal').modal('hide');
	});

	$('#dealCorpModalTable tbody').on('dblclick','tr',function(){
		let data = dealCorpModalTable.row(this).data();
		$('#searchDealCorpNm').val(data.dealCorpNm);
		$('#searchDealCorpIdx').val(data.idx);
		$('#dealCorpModal').modal('hide');
	});
	
	function dataRFootDraw(data){
		//spgubun이 002(자재)로 필터
		let filterData = _.filter(data, v=> v.spGubun == '002');
		let inQtyData = _.filter(filterData, v=> v.spType == '입고' || v.spType =='조정입고');
		let outQtyData = _.filter(filterData, v=> v.spType == '출고' || v.spType =='조정출고');
		let inQty = _.sumBy(inQtyData,v=>parseFloat(v.spQty));
		let outQty = _.sumBy(outQtyData,v=>parseFloat(v.spQty));

		let sumQtyData = _.filter(filterData, v=> v.spType2 == '현재고');
		let sumQty = _.sumBy(sumQtyData,v=>parseFloat(v.spQty));
		
		
		let returnR = '';

		//입고 R(자재)
		if(parseInt(inQty) < 0){
			returnR = "-" + parseInt(-1*inQty/500) + "R" + parseInt(-1*inQty%500); 
		} else {
			returnR = parseInt(inQty/500) + "R" + parseInt(inQty%500); 
		}	
		$('#inputFootR').html(returnR);

		//출고 R(자재)
		if(parseInt(outQty) < 0){
			returnR = "-" + parseInt(-1*outQty/500) + "R" + parseInt(-1*outQty%500); 
		} else {
			returnR = parseInt(outQty/500) + "R" + parseInt(outQty%500); 
		}	
		$('#outputFootR').html(returnR);
		
		//현재고 R(자재)
		if(parseInt(sumQty) < 0){
			returnR = "-" + parseInt(-1*sumQty/500) + "R" + parseInt(-1*sumQty%500); 
		} else {
			returnR = parseInt(sumQty/500) + "R" + parseInt(sumQty%500); 
		}	
		$('#sumSpQtyFootR').html(returnR);
		
	}
</script>

</body>
</html>
