<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/top.jsp"%>
<%@include file="../layout/modal.jsp"%>
<%@include file="../layout/script.jsp"%>
<div id="page" onmouseup="EndDrag(this)" onmousemove="OnDrag(event)" style="grid-template-areas: 'leftcol';
																		  grid-template-rows: 1fr;
																		  grid-template-columns: 1fr;">
	<div id="leftcol">
		<div class="container-fluid h-100" style="padding: 5px;">
			<div class="row" id="leftHeader" style="padding-bottom: 5px;">
				<div class="d-flex align-items-center d-flex">
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">입고일자</label>
					<input type="date" max="9999-12-31" class="form-control w-auto h-100 me-1" id="startDate">
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
					
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">일별/월별</label>
					<select class="form-select w-auto h-100 me-3" id="searchDayGubun" style="min-width: 70px;">
						<option value="day">일별</option>
						<option value="month">월별</option>
					</select>
					
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">품목구분</label>
					<select class="form-select w-auto h-100 me-3" id="searchItemGubun" style="min-width: 70px;">
						<option value="" selected="">전체</option>
						<option value="matrl">원단</option>
						<option value="goods">상품</option>
					</select>
					
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">품명</label>
					<div class="input-group w-auto h-100 me-3">
						<input type="text" class="form-control" id="searchMatrlNm" disabled>
						<button type="button" class="btnInputDel" style="background-color: transparent;
							border-color: transparent; position: absolute;
							top: 0; right:0;
							margin: 5px 23px; margin-left: 0px;
							border: none;">
							<i class="fa-solid fa-xmark"></i>
						</button>
						<input type="hidden" id="searchMatrlIdx">
						<button type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary" id="btnSearchMatrl">
							<i class="fa-solid fa-magnifying-glass"></i>
						</button>
					</div>
					
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">고객사</label>
					<div class="input-group w-auto h-100 me-3">
						<input type="text" class="form-control" id="searchDealCorpNm" disabled> 
						<button type="button" class="btnInputDel" id="btnSearchDealCorpDel" style="background-color: transparent; border-color: transparent; position: absolute; top: 0; right: 0; margin: 5px 23px; margin-left: 0px; border: none;">
							<i class="fa-solid fa-xmark"></i>
						</button>
						<input type="hidden" id="searchDealCorpIdx">
						<button type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary" id="btnSearchDealCorp">
							<i class="fa-solid fa-magnifying-glass"></i>
						</button>
					</div>
					<input type="text" class="form-control w-auto h-100 me-1" id="searchAll" placeholder="통합검색">
				
					
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
							<th class="text-center align-middle">구분</th>
							<th class="text-center align-middle">매입처</th>
							<th class="text-center align-middle">수주번호</th>
							<th class="text-center align-middle">수주상세번호</th>
							<th class="text-center align-middle">고객사</th>
							<th class="text-center align-middle">제품명</th>
							<th class="text-center align-middle">재질</th>
							<th class="text-center align-middle">입고일</th>
							<th class="text-center align-middle">입고매수</th>
							<th class="text-center align-middle">입고연수</th>
							<th class="text-center align-middle">발주번호</th>
							<th class="text-center align-middle">출력번호</th>
							<th class="text-center align-middle">외관검사</th>
							<th class="text-center align-middle">판정자</th>
							<th class="text-center align-middle">판정일자</th>
						</tr>
					</thead>
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

	let selectPeriod = parseInt(getCommonCode('시스템', '040')[0].commonCd); //기본조회기간 일
	$('#startDate').val(moment().subtract('d',selectPeriod).format('YYYY-MM-DD'));
	$('#endDate').val(moment().format('YYYY-MM-DD'));

	let monthAdjustList = getCommonCode('시스템', '026'); //날짜조정
	monthAdjustList = _.sortBy(monthAdjustList, v=>parseInt(v.commonCd));
	selectBoxAppend(monthAdjustList, 'monthAdjust', '', '2'); //날짜조정
	
	let dealGubunList = getCommonCode('시스템', '011'); // 거래구분
	let dealCorpStatusList = getCommonCode('시스템', '015'); // 거래상태

	selectBoxAppend(dealGubunList, 'modalDealGubun', '', '1'); //거래구분
	selectBoxAppend(dealCorpStatusList, 'modalDealCorpStatus', '', '1'); //거래상태
	
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
			url : '<c:url value="/pm/inOrginLst"/>',
			type : 'POST',
			data : {
				startDate		: function() { return moment($('#startDate').val(),'YYYY-MM-DD').format('YYYYMMDD'); },
				endDate			: function() { return moment($('#endDate').val(),'YYYY-MM-DD').format('YYYYMMDD'); },
				searchDayGubun	: function() { return $('#searchDayGubun').val(); },
				dealCorpIdx		: function() { return $('#searchDealCorpIdx').val(); },
				matrlIdx		: function() { return $('#searchMatrlIdx').val(); },
				itemGubun		: function() { return $('#searchItemGubun').val(); },		
			},
		},
        rowId: 'rowNumber',
		columns : [
			{ data: 'poGubun', className : 'text-center align-middle',//입고처
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'purchaseDealCorpNm', className : 'text-center align-middle',//입고처
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'bizOrdNo', className : 'text-center align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ data: 'bizOrdDtlNo', className : 'text-center align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ data: 'customerNm', className : 'text-center align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ data: 'itemNm', className : 'text-center align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ data: 'spNm', className : 'text-center align-middle', name:'spNm', //재질
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'inDate', className : 'text-center align-middle',//입고일자
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data).format('YYYY-MM-DD')+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'inBuying', className : 'text-end align-middle',//입고매수
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseInt(data))+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'inBuying2', className : 'text-end align-middle',//입고연수
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'purchaseOrdNo', className : 'text-center align-middle', name:'purchaseOrdNo',//발주번호
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'purchasePrintNo', className : 'text-center align-middle', name:'purchasePrintNo',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'inMatrEtc1', className : 'text-center align-middle', name:'inMatrEtc1',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'inMatrEtc2', className : 'text-center align-middle', name:'inMatrEtc2',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'inMatrEtc3', className : 'text-center align-middle', name:'inMatrEtc3',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
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
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#bizOrderTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 79)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAll').off('keyup',function() {});
			$('#searchAll').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			});
/* 
			for(var i=0;i<api.data().count();i++) {
				let tr = $('#bizOrderTable tbody').find('tr').eq(i);
				let data = api.row(i).data();
				let node = api.row(i).node();
				if(data.purchaseOrdNo == '일자별합계' || data.purchaseOrdNo == '월별합계') {
					$(node).addClass('bg-success bg-gradient bg-opacity-25');
					data.purchaseQty = ''; //해당데이터 빈값으로 만들고 
					let colIndex = bizOrderTable.column('purchaseQty:name').index();
					let colRIndex = bizOrderTable.column('purchaseQtyR:name').index();
					let colPurchaseIdx = bizOrderTable.column('purchaseOrdNo:name').index();
					//해당 칸 발주량 안보이게끔
					$(tr).find('td').eq(colIndex).html('');
					$(tr).find('td').eq(colRIndex).html('');
					$(tr).find('td').eq(colPurchaseIdx).html(data.purchaseOrdNo);
				}
			}

 */
 			//합계표 생성		
 	
 			/*
 			let dataArray = api.data().toArray();
			if( dataArray.length != 0 ){
				
				let dealCorpUniq = _.uniqBy(dataArray, 'dealCorpIdx'); // 거래처별로 uniq한 리스트
				
				for(var j=0; j<dealCorpUniq.length;j++){
					
					let dealCorpFilterLst = _.filter(dataArray, v=>v.dealCorpIdx == dealCorpUniq[j].dealCorpIdx );//거래처식별자 가진 리스트
					let inDateUniq;

					//조회된 데이터가 일별 일경우 
					if(dealCorpFilterLst[0].dayGubun == 'day'){
						inDateUniq = _.uniqBy(dealCorpFilterLst, 'inDate'); //입고일자별로 Uniq
						for(var q=0; q<inDateUniq.length;q++){

							let inQtySumFilterLst = _.filter(dealCorpFilterLst, v=> v.inDate == inDateUniq[q].inDate);
							let inQtySum = _.sumBy(inQtySumFilterLst, v=> parseFloat(v.inQty)); 

							let inQtyRLst = _.filter(inQtySumFilterLst, v=> v.itemGubun == 'matrl');
							let inQtyRSum = _.sumBy(inQtyRLst, v=> parseFloat(v.inQty));
							let inQtyR = '';
							if(inQtyRSum > 0){
								inQtyR = parseInt(inQtyRSum/500) + "R" + parseInt(inQtyRSum%500);
							} else if ( inQtyRSum < 0 ){
								inQtyR = "-" + parseInt((inQtyRSum*-1)/500) + "R" + parseInt((inQtyRSum*-1)%500);
							} else {
								inQtyR = "0R0"
							}
							
	 						let html = '';
							html += '<tr class="bg-success bg-gradient bg-opacity-25">';
							html += '	<td class="text-end align-middle"></td>';
							html += '	<td class="text-center align-middle">일별 합계</td>';
							html += '	<td class="text-center" colspan="3"></td>';
							html += '	<td class="text-center align-middle">'+moment(inDateUniq[q].inDate).format('YYYY-MM-DD')+'</td>';//입고일자
							html += '	<td class="text-end align-middle">'+addCommas(inQtySum)+'</td>';//입고량
							//html += '	<td class="text-end align-middle">'+inQtyR+'</td>';//입고량
							html += '	<td class="text-center" colspan="2"></td>';
							html += '</tr>';

							let firstRowNumber = _.minBy(inDateUniq, (v => parseInt(v.rowNumber))).rowNumber;
							let lastRowNumber = _.maxBy(inQtySumFilterLst, (v => parseInt(v.rowNumber))).rowNumber;

							let firstNode = api.row('#'+firstRowNumber).node();
							let lastNode = api.row('#'+lastRowNumber).node();
							
							$(lastNode).after(html);

							//↓↓↓↓↓ 이거 안하면 로우그룹 이상하게 됨 해줘야함
							//설명 : 한행 늘어날때마다 로우그룹이 1씩증가야함
							let beforeRowSpan = $(firstNode).find('td').first().attr('rowspan');
							$(firstNode).find('td').first().attr('rowspan',++beforeRowSpan);
						}
					} else if(dealCorpFilterLst[0].dayGubun == 'month'){
						//월별일경우
						inDateUniq = _.uniqBy(dealCorpFilterLst, v=>v.inDate.substr(0,6)); //입고일자별로 Uniq
						for(var q=0; q<inDateUniq.length;q++){

							let inQtySumFilterLst = _.filter(dealCorpFilterLst, v=> v.inDate == inDateUniq[q].inDate);
							let inQtySum = _.sumBy(dealCorpFilterLst, v=> parseFloat(v.inQty));
							
							let inQtyRLst = _.filter(dealCorpFilterLst, v=> v.itemGubun == 'matrl');
							let inQtyRSum = _.sumBy(inQtyRLst, v=> parseFloat(v.inQty));
							
							let inQtyR = '';
							if(inQtyRSum > 0){
								inQtyR = parseInt(inQtyRSum/500) + "R" + parseInt(inQtyRSum%500);
							} else if ( inQtyRSum < 0 ){
								inQtyR = "-" + parseInt((inQtyRSum*-1)/500) + "R" + parseInt((inQtyRSum*-1)%500);
							} else {
								inQtyR = "0R0"
							}
							
	 						let html = '';
							html += '<tr class="bg-success bg-gradient bg-opacity-25">';
							html += '	<td class="text-end align-middle"></td>';
							html += '	<td class="text-center align-middle">월별 합계</td>';
							html += '	<td class="text-center" colspan="3"></td>';
							html += '	<td class="text-center align-middle">'+moment(inDateUniq[q].inDate).endOf('month').format('YYYY-MM-DD')+'</td>';//입고일자
							html += '	<td class="text-end align-middle">'+addCommas(inQtySum)+'</td>';//입고량
							//html += '	<td class="text-end align-middle">'+inQtyR+'</td>';//입고량
							html += '	<td class="text-center" colspan="2"></td>';
							html += '</tr>';

							let firstRowNumber = _.minBy(dealCorpFilterLst, (v => parseInt(v.rowNumber))).rowNumber;
							let lastRowNumber = _.maxBy(dealCorpFilterLst, (v => parseInt(v.rowNumber))).rowNumber;

							let firstNode = api.row('#'+firstRowNumber).node();
							let lastNode = api.row('#'+lastRowNumber).node();
							
							$(lastNode).after(html);

							//↓↓↓↓↓ 이거 안하면 로우그룹 이상하게 됨 해줘야함
							//설명 : 한행 늘어날때마다 로우그룹이 1씩증가야함
							let beforeRowSpan = $(firstNode).find('td').first().attr('rowspan');
							$(firstNode).find('td').first().attr('rowspan',++beforeRowSpan);
						}
					}
					
					
					
					
				}
			}	
			*/
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
				$('#bizOrderTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
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
	bizOrderTable.on('column-reorder', function( e, settings, details ) {
		let api = bizOrderTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#bizOrderTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
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
		bizOrderTable.ajax.reload(function() {});

		setTimeout(function() {
			$('#my-spinner').hide();
		}, 100)
	});

	// 거래처조회 버튼 click
	$('#btnSearchDealCorp').on('click', function() {
		$('#dealCorpModal').modal('show');
		$('#dealCorpModal').data('type','search');
	});

	$(document).on('click','button[name=btnDealCorpSel]',function(){
		$('#dealCorpModal').modal('show');
		$('#dealCorpModal').data('type','edit');
	});
	
	$('#dealCorpModal').on('shown.bs.modal', function() {
		dealCorpModalTable.ajax.reload(function() {});
	});

	// 거래처관리 목록조회
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

	// 거래처 모달 조회 버튼 click
	$('#btnDealCorpModalSearch').on('click', function() {
		$('#my-spinner').show();
		dealCorpModalTable.ajax.reload(function() {});
		
		setTimeout(function() {
			$('#my-spinner').hide();
		}, 100)
	});

	// 거래처 모달 붙여넣기 버튼 click
	$('#btnDealCorpModalPaste').on('click', function() {
		if(!$('#dealCorpModalTable tbody tr').hasClass('selected')){
			toastr.warning('붙여넣을 행을 선택해주세요.');
			return false;
		}
		let type = $('#dealCorpModal').data('type');
		let data = dealCorpModalTable.row('.selected').data();
		if(type =='search'){
			$('#searchDealCorpNm').val(data.dealCorpNm);
			$('#searchDealCorpIdx').val(data.idx);
		} else if(type == 'edit'){
			let node = bizOrdOutProdTable.row('.selected').node();

			$(node).find('td').eq(bizOrdOutProdTable.column('outProdDealCorpNm:name').index()).find('input[type=hidden]').val(data.idx);
			$(node).find('td').eq(bizOrdOutProdTable.column('outProdDealCorpNm:name').index()).find('input[type=text]').val(data.dealCorpNm);
		}
		$('#dealCorpModal').modal('hide');
	});

	$('#dealCorpModalTable tbody').on('dblclick','tr',function(){
		let type = $('#dealCorpModal').data('type');
		let data = dealCorpModalTable.row(this).data();
		if(type =='search'){
			$('#searchDealCorpNm').val(data.dealCorpNm);
			$('#searchDealCorpIdx').val(data.idx);
		} else if(type == 'edit'){
			let node = bizOrdOutProdTable.row('.selected').node();

			$(node).find('td').eq(bizOrdOutProdTable.column('outProdDealCorpNm:name').index()).find('input[type=hidden]').val(data.idx);
			$(node).find('td').eq(bizOrdOutProdTable.column('outProdDealCorpNm:name').index()).find('input[type=text]').val(data.dealCorpNm);
		}
		$('#dealCorpModal').modal('hide');
	});
	
	$('#btnSearchMatrl').on('click', function(){
		$('#itemNmModal').modal('show');   	
		setTimeout(function() {
			itemNmModalTable.ajax.reload(function() {});
		}, 200);
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
			url : '<c:url value="/bm/goodsInfoAndMatrlLstAll"/>',
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
						if(data == 'goods'){
							text = '상품';
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

	$('#btnItemNmModalPaste').on('click',function(){
		if( !$('#itemNmModalTable tbody tr').hasClass('selected') ){
			toastr.warning('붙여넣을 행을 선택해주세요.');
			return false;
		}

		let data = itemNmModalTable.row('.selected').data();
		$('#searchMatrlNm').val(data.itemNm);
		$('#searchMatrlIdx').val(data.idx);

		$('#searchItemGubun').val(data.itemMatrlGubun);
		
		$('#itemNmModal').modal('hide');
	});

	$('#itemNmModalTable tbody').on('dblclick','tr',function(){
		let data = itemNmModalTable.row(this).data();
		$('#searchMatrlNm').val(data.itemNm);
		$('#searchMatrlIdx').val(data.idx);

		$('#searchItemGubun').val(data.itemMatrlGubun);
		
		$('#itemNmModal').modal('hide');
	});

	$('#searchItemGubun').on('change',function(){
		$('#searchMatrlNm').val('');
		$('#searchMatrlIdx').val('');

	});
	
</script>

</body>
</html>
