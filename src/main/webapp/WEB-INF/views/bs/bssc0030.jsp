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
																		  grid-template-columns: 2fr 4px 2fr;">
	<div id="leftcol">
		<div class="container-fluid h-100" style="padding: 5px;">
			<div class="row" id="leftHeader" style="padding-bottom: 5px;">
				<div class="d-flex align-items-center d-flex">
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">수주등록일</label>
					<input type="date" max="9999-12-31" class="form-control w-auto h-100 me-1" id="startDate">
					<label class="form-label d-flex align-items-center m-0 me-1 h-100">~</label>
					<input type="date" max="9999-12-31" class="form-control w-auto h-100 me-1" id="endDate">
					<select class="form-select w-auto h-100 me-1 monthAdjust" id="monthAdjust">
					</select>
					<div class="btn-group me-1" role="group" aria-label="Small button group">
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
					<input type="text" class="form-control w-auto h-100 me-1" id="searchAllAdm" placeholder="통합검색" >
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end">
					<div class="btn-group" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnSearch"><i class="fa-regular fa-clipboard"></i></button>
						<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnSelectAll">ALL</button>
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
					<input type="text" class="form-control w-auto h-100 me-1" id="searchAllDtl" placeholder="통합검색" >
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end">
					<div class="btn-group" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnClose"><i class="fa-solid fa-caret-right"></i></button>
					</div>
				</div>
			</div>
			<div class="row">
				<table class="table table-bordered p-0 m-0" id="bizOrderDtlTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle">수주처명</th>
							<th class="text-center align-middle colvisHide">품목구분</th>
							<th class="text-center align-middle colvisHide">제품코드</th>
							<th class="text-center align-middle">제품명</th>
							<th class="text-center align-middle">수주수량</th>
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
			$('#page').css('grid-template-columns', '1.5fr 4px 2fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcol').removeClass('d-none');
		} else {
			$('#page').css('grid-template-columns', '0fr 4px 2fr');
			$('#leftcol').addClass('d-none');
			$('#rightcol').removeClass('d-none');
		}
		dataTableDrawAll(); // dataTable 전체 reload
	});
	$('#btnClose').on('click',function() { // right-box 닫기버튼 클릭
		if($('#leftcol').hasClass('d-none')){
			$('#page').css('grid-template-columns', '1.5fr 4px 2fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcol').removeClass('d-none');
		} else {
			$('#page').css('grid-template-columns', '1.5fr 4px 0fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcol').addClass('d-none');
		}
		dataTableDrawAll(); // dataTable 전체 reload
	});
</script>

<script>
	WM_init('ADM');
	WM_init('DTL');

	let monthAdjustList = getCommonCode('시스템', '026'); //날짜조정
	monthAdjustList = _.sortBy(monthAdjustList, v=>parseInt(v.commonCd));
	selectBoxAppend(monthAdjustList, 'monthAdjust', '', '2'); //날짜조정
	
	let dealCorpIdxVal = '';

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
			url : '<c:url value="/bs/bizOrderAdmLstAsDealCorp"/>',
			type : 'POST',
			data : {
				startDate	: function() { return moment($('#startDate').val(),'YYYY-MM-DD').format('YYYYMMDD'); },
				endDate		: function() { return moment($('#endDate').val(),'YYYY-MM-DD').format('YYYYMMDD'); },
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'dealCorpCd', className : 'text-center align-middle'},
			{ data: 'dealCorpNm', className : 'text-center align-middle'},
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
		bizOrderDealCorpTable.ajax.reload(function() {});
	});

	// ALL 버튼 click
	$('#btnSelectAll').on('click', function() {
		dealCorpIdxVal = '';
		
		bizOrderDealCorpTable.ajax.reload(function() {});
		bizOrderDtlTable.ajax.reload(function() {});
	});

	// 수주처 목록 선택
	$('#bizOrderDealCorpTable tbody').on('click', 'tr', function() {
		let data = bizOrderDealCorpTable.row(this).data();
		dealCorpIdxVal = data.dealCorpIdx;

		bizOrderDtlTable.ajax.reload(function() {});
	});


	// 수주처 목록 목록조회
	$('#bizOrderDtlTable thead tr').clone(true).addClass('filters').appendTo('#bizOrderDtlTable thead'); // filter 생성
	let bizOrderDtlTable = $('#bizOrderDtlTable').DataTable({
		dom : "<'row'<'col-md-12 col-md-6'l><'col-md-12 col-md-6'f>>"
				+ "<'row'<'col-md-12'tr>>"
				+ "<'row pt-1'<'d-flex align-items-center d-flex'Bp><'me-lg-auto'><'d-flex align-items-center justify-content-end'i>>",
		language: lang_kor,
		info: true,
		ordering: false,
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
			url : '<c:url value="/bs/bizOrderDtlLstByDealCorp"/>',
			type : 'POST',
			data : {
				dealCorpIdx	: function() { return dealCorpIdxVal; },
				startDate	: function() { return moment($('#startDate').val(),'YYYY-MM-DD').format('YYYYMMDD'); },
				endDate		: function() { return moment($('#endDate').val(),'YYYY-MM-DD').format('YYYYMMDD'); },
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'dealCorpNm', className : 'text-center align-middle'},
			{ data: 'itemGubunNm', className : 'text-center align-middle'},
			{ data: 'itemCd', className : 'text-center align-middle'},
			{ data: 'itemNm', className : 'text-center align-middle'},
			{ data: 'ordQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					return addCommas(parseInt(data));
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
			{ extend: 'excel',	text: 'Excel',	charset: 'UTF-8', bom: true ,
				exportOptions: {
	                modifier: {
	                   selected:null
	                },	                
	            },
	        },
			{ extend: 'pdf',	text: 'PDF',	},
			{ extend: 'print',	text: 'Print',		charset: 'UTF-8', bom: true },
			{ extend: 'colvisGroup',	className: 'd-none',	hide: '.colvisHide'},
			{ extend: 'colvis',	text: 'Select Col',	},
		],
		order : [],
		drawCallback: function() {
			let api = this.api();
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#bizOrderDtlTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#bizOrderDtlTable_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 79)+'px');
			
			$('#bizOrderDtlTable_filter').addClass('d-none');
			// 통합검색
			$('#searchAllDtl').off('keyup',function() {});
			$('#searchAllDtl').on('keyup',function() {
				$('#bizOrderDtlTable_filter').find('input').val($(this).val());
				$('#bizOrderDtlTable_filter').find('input').trigger('keyup');
			});


			// 집계표 생성
			let data = api.data().toArray();

			if(data.length != 0) {
				let dealCorpUniq = _.uniqBy(data, 'dealCorpIdx'); // 수주처별로 uniq한 리스트
				for(var i=0;i<dealCorpUniq.length;i++) {
					let dealCorpIdx = dealCorpUniq[i].dealCorpIdx;
					let dealCorpList = _.filter(data, (v => v.dealCorpIdx == dealCorpIdx));
					
					let itemUniq = _.uniqBy(dealCorpList, 'itemIdx'); // 수주처별 품목별로 uniq한 리스트
					let dealLastIdx = _.maxBy(dealCorpList, (v => parseInt(v.rowNumber))).idx;
					let dealSum = _.sumBy(dealCorpList, (v => parseInt(v.ordQty)));
					let dealHtml = '';
						dealHtml += '<tr class="bg-success bg-gradient bg-opacity-25">';
						dealHtml += '	<td class="text-center">수주처별합계</td>';
						dealHtml += '	<td colspan="1"></td>';
						dealHtml += '	<td class="text-end align-middle">'+addCommas(parseInt(dealSum))+'</td>';
						dealHtml += '</tr>';
					let dealNode = api.row('#'+dealLastIdx).node();
					$(dealNode).after(dealHtml);
					for(var j=0;j<itemUniq.length;j++) {
						let itemIdx = itemUniq[j].itemIdx;
						let itemList = _.filter(data, (v => v.itemIdx == itemIdx && v.dealCorpIdx == dealCorpIdx));
						let itemLastIdx = _.maxBy(itemList, (v => v.rowNumber)).idx;
						let itemSum = _.sumBy(itemList, (v => parseInt(v.ordQty)));
						let itemHtml = '';
							itemHtml += '<tr class="bg-success bg-gradient bg-opacity-10">';
							itemHtml += '	<td class="text-center">품목별합계</td>';
							itemHtml += '	<td colspan="1"></td>';
							itemHtml += '	<td class="text-end align-middle">'+addCommas(parseInt(itemSum))+'</td>';
							itemHtml += '</tr>';
						let itemNode = api.row('#'+itemLastIdx).node();
						$(itemNode).after(itemHtml);
					}
					
				}
				let lastIdx = _.last(data).idx;
				let ordQtySum = _.sumBy(data, (v => parseInt(v.ordQty)));
				let lastHtml = '';
					lastHtml += '<tr class="bg-success bg-gradient bg-opacity-50">';
					lastHtml += '	<td class="text-center">전체합계</td>';
					lastHtml += '	<td colspan="1"></td>';
					lastHtml += '	<td class="text-end align-middle">'+addCommas(parseInt(ordQtySum))+'</td>';
					lastHtml += '</tr>';
				let lastNode = api.row('#'+lastIdx).node();
				$(lastNode).next().next().after(lastHtml);
			}
		},
		initComplete: function () {
			let api = this.api();
			
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

			api.button(3).trigger();
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
</script>

</body>
</html>
