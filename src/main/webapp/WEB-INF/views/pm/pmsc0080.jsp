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
				
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100" id="bizOrdDateLabel">년/월</label>
					<div class="row" id="dateDiv" style="height: 32px;">
						<input type="month" max="9999-12-31" class="form-control w-auto h-100 me-1" id="date" autocomplete="one-time-code">
					</div>
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
					<input type="text" class="form-control w-auto h-100 me-1" id="searchAll" placeholder="통합검색" >
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end">
					<div class="btn-group me-1" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto" id="btnUnitChange">단위전환</button>
					</div>
					<div class="btn-group" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnSearch"><i class="fa-regular fa-clipboard"></i></button>
					</div>
				</div>
			</div>
			<div class="row">
				<table class="table table-bordered p-0 m-0" id="bizOrderTable">
					<colgroup>
						<col width="9%">
						<col width="6.5%">
						<col width="6.5%">
						<col width="6.5%">
						<col width="6.5%">
						<col width="6.5%">
						<col width="6.5%">
						<col width="6.5%">
						<col width="6.5%">
						<col width="6.5%">
						<col width="6.5%">
						<col width="6.5%">
						<col width="6.5%">
						<col width="6.5%">
						<col width="6.5%">
						
					</colgroup>
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle">재질</th>
							<th class="text-center align-middle">가용재고</th>
							<th class="text-center align-middle">현재고</th>
							<c:forEach var="item" items="${dayList}" varStatus="status">
								<th class="text-center align-middle monthVal">${fn: substring(item,1,3)}월</th>
							</c:forEach> 
						</tr>
					</thead>
					<tfoot class="thead-light">
						<tr>
							<th colspan='1'>합계</th>
							<th class="dayQty calSum"></th>
							<th class="dayQty sumStock"></th>
							<th class="dayQty sumQty1"></th>
							<th class="dayQty sumQty2"></th>
							<th class="dayQty sumQty3"></th>
							<th class="dayQty sumQty4"></th>
							<th class="dayQty sumQty5"></th>
							<th class="dayQty sumQty6"></th>
							<th class="dayQty sumQty7"></th>
							<th class="dayQty sumQty8"></th>
							<th class="dayQty sumQty9"></th>
							<th class="dayQty sumQty10"></th>
							<th class="dayQty sumQty11"></th>
							<th class="dayQty sumQty12"></th>
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

	let unitChangeStatus = 'origin';

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


	let dateData = moment().format('YYYY-MM');
	$('#date').val(dateData);
	
	let dayList = new Array();
	<c:forEach items="${dayList}" var="item" varStatus="status">
		dayList.push("${item}");
	</c:forEach>

	console.log("dayList:"+dayList);
	
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
				searchDayGubun	: function() { return 'total'; },
				matrlIdx		: function() { return $('#searchMatrlIdx').val(); },
				date 			: function() { return $('#date').val().replace(/-/g,''); },
			},
		},
		columns : [
			{ data: 'spNm', className : 'text-center align-middle',//재질
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'calSum', className : 'text-end align-middle',//가용재고
				render: function(data) {
					if(unitChangeStatus=="origin"){
						if(data != null && data != ''){
							return '<div class="dayQty" style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
						}else{
							return '<div class="dayQty" style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">0</div>'
						}
					}else {
						if(data != null && data != ''){
							let monInQty = removeCommas(data);
							
							return '<div class="dayQty" style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+(monInQty<0?Math.ceil(monInQty/500):Math.floor(monInQty/500)) + 'R' + (monInQty<0?monInQty*-1:monInQty)%500+'</div>';
						}else{
							return '<div class="dayQty" style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">0R0</div>'
						}
					}
				}
			},
			{ data: 'stock', className : 'text-end align-middle', //현재고
				render: function(data) {
					if(unitChangeStatus=="origin"){
						if(data != null && data != ''){
							return '<div class="dayQty" style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
						}else{
							return '<div class="dayQty" style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">0</div>'
						}
					}else {
						if(data != null && data != ''){
							let monInQty = removeCommas(data);
							return '<div class="dayQty" style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+(monInQty<0?Math.ceil(monInQty/500):Math.floor(monInQty/500)) + 'R' + (monInQty<0?monInQty*-1:monInQty)%500+'</div>';
						}else{
							return '<div class="dayQty" style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">0R0</div>'
						}
					}
				}
			},
			<c:forEach items="${dayList}" var="item" varStatus="status">
				{ data: '${item}', className : 'text-end align-middle', //M
					render: function(data) {
						if(unitChangeStatus=="origin"){
							if(data != null && data != ''){
								return '<div class="dayQty" style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
							}else{
								return '<div class="dayQty" style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">0</div>'
							}
						}else {
							if(data != null && data != ''){
								let monInQty = removeCommas(data);
								return '<div class="dayQty" style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+(monInQty<0?Math.ceil(monInQty/500):Math.floor(monInQty/500)) + 'R' + (monInQty<0?monInQty*-1:monInQty)%500+'</div>';
							}else{
								return '<div class="dayQty" style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">0R0</div>'
							}
						}
					}
				},
			</c:forEach>
		],
		columnDefs : [
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
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 110)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAll').off('keyup',function() {});
			$('#searchAll').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			});

 			//합계표 생성		
 			$('#bizOrderTable').find('tfoot').remove();
 			
 			let calSum = $('#bizOrderTable').DataTable().column(1,{ page: 'current'} ).data().sum(); 
			let sumStock = $('#bizOrderTable').DataTable().column(2,{ page: 'current'} ).data().sum(); 
			let sumQty1 = $('#bizOrderTable').DataTable().column(3,{ page: 'current'} ).data().sum(); 
			let sumQty2 = $('#bizOrderTable').DataTable().column(4,{ page: 'current'} ).data().sum(); 
			let sumQty3 = $('#bizOrderTable').DataTable().column(5,{ page: 'current'} ).data().sum(); 
			let sumQty4 = $('#bizOrderTable').DataTable().column(6,{ page: 'current'} ).data().sum(); 
			let sumQty5 = $('#bizOrderTable').DataTable().column(7,{ page: 'current'} ).data().sum(); 
			let sumQty6 = $('#bizOrderTable').DataTable().column(8,{ page: 'current'} ).data().sum(); 
			let sumQty7 = $('#bizOrderTable').DataTable().column(9,{ page: 'current'} ).data().sum(); 
			let sumQty8 = $('#bizOrderTable').DataTable().column(10,{ page: 'current'} ).data().sum();
			let sumQty9 = $('#bizOrderTable').DataTable().column(11,{ page: 'current'} ).data().sum(); 
			let sumQty10 = $('#bizOrderTable').DataTable().column(12,{ page: 'current'} ).data().sum();
			let sumQty11 = $('#bizOrderTable').DataTable().column(13,{ page: 'current'} ).data().sum();
			let sumQty12 = $('#bizOrderTable').DataTable().column(14,{ page: 'current'} ).data().sum();

			if(unitChangeStatus=="origin"){
				$('.calSum').text(addCommas(calSum));
				$('.sumStock').text(addCommas(sumStock));
				$('.sumQty1').text(addCommas(sumQty1));
				$('.sumQty2').text(addCommas(sumQty2));
				$('.sumQty3').text(addCommas(sumQty3));
				$('.sumQty4').text(addCommas(sumQty4));
				$('.sumQty5').text(addCommas(sumQty5));
				$('.sumQty6').text(addCommas(sumQty6));
				$('.sumQty7').text(addCommas(sumQty7));
				$('.sumQty8').text(addCommas(sumQty8));
				$('.sumQty9').text(addCommas(sumQty9));
				$('.sumQty10').text(addCommas(sumQty10));
				$('.sumQty11').text(addCommas(sumQty11));
				$('.sumQty12').text(addCommas(sumQty12));
			}else {
				$('.calSum').text(Math.floor(calSum/500) + 'R' + calSum%500);
				$('.sumStock').text(Math.floor(sumStock/500) + 'R' + sumStock%500);
				$('.sumQty1').text(Math.floor(sumQty1/500) + 'R' + sumQty1%500);
				$('.sumQty2').text(Math.floor(sumQty2/500) + 'R' + sumQty2%500);
				$('.sumQty3').text(Math.floor(sumQty3/500) + 'R' + sumQty3%500);
				$('.sumQty4').text(Math.floor(sumQty4/500) + 'R' + sumQty4%500);
				$('.sumQty5').text(Math.floor(sumQty5/500) + 'R' + sumQty5%500);
				$('.sumQty6').text(Math.floor(sumQty6/500) + 'R' + sumQty6%500);
				$('.sumQty7').text(Math.floor(sumQty7/500) + 'R' + sumQty7%500);
				$('.sumQty8').text(Math.floor(sumQty8/500) + 'R' + sumQty8%500);
				$('.sumQty9').text(Math.floor(sumQty9/500) + 'R' + sumQty9%500);
				$('.sumQty10').text(Math.floor(sumQty10/500) + 'R' + sumQty10%500);
				$('.sumQty11').text(Math.floor(sumQty11/500) + 'R' + sumQty11%500);
				$('.sumQty12').text(Math.floor(sumQty12/500) + 'R' + sumQty12%500);
			}
			
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
				$(this).trigger('change');
			});
		});
	});

	
	// 단위전환 버튼 click
	$('#btnUnitChange').on('click',function(){

		unitChangeStatus = unitChangeStatus=="origin"?unitChangeStatus = "change": unitChangeStatus = "origin";
		
		$('#my-spinner').show();
		bizOrderTable.ajax.reload(function() {});

		setTimeout(function() {
			$('#my-spinner').hide();
		}, 100)
	});

	// 조회 버튼 click
	$('#btnSearch').on('click', function() {
		$('#my-spinner').show();
		bizOrderTable.ajax.reload(function() {});

		setTimeout(function() {
			$('#my-spinner').hide();
		}, 100)
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
				$(this).trigger('change');
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
