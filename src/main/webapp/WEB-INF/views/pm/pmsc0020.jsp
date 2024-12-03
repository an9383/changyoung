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
																		  grid-template-columns: 1.2fr 4px 1fr;">
	<div id="leftcol">
		<div class="container-fluid h-100" style="padding: 5px;">
			<div class="row" id="leftHeader" style="padding-bottom: 5px;">
				<div class="d-flex align-items-center d-flex">
				<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">수주일자</label>
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
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end">
					<div class="btn-group" role="group" aria-label="Small button group">
					<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnSearch"><i class="fa-regular fa-clipboard"></i></button>
					<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnAdd"><i class="fa-solid fa-cart-plus"></i></button>
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnOpen">
						<i class="fa-solid fa-caret-left"></i>
					</button>
					</div>
				</div>
			</div>
			<div class="row" id="leftSecondHeader" style="padding-bottom: 5px;">
				<div class="d-flex align-items-center d-flex">
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100" style="min-height:30px;">조회대상</label>
					<select class="form-select w-auto h-100 me-3" id="searchTarget" style="min-width: 70px;">
						<option value="" selected>전체</option>
						<option value="N">미달재고</option>
					</select>
					
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">범례</label>
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100 bg-danger bg-gradient">미달재고</label>
					<input type="text" class="form-control w-auto h-100 me-1" id="searchAll" placeholder="통합검색" >
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end">
				</div>
			</div>
			<div class="row">
				<table class="table table-bordered p-0 m-0" id="matrlTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle">재질</th>
							<th class="text-center align-middle">적정재고</th>
							<th class="text-center align-middle">Ⓡ</th>
							<th class="text-center align-middle">현재고</th>
							<th class="text-center align-middle">Ⓡ</th>
							<th class="text-center align-middle">수주량</th>
							<th class="text-center align-middle">Ⓡ</th>
							<th class="text-center align-middle">발주필요량</th>
							<th class="text-center align-middle">Ⓡ</th>
							<th class="text-center align-middle">가로*세로</th>
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
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">발주일자</label>
					<input type="date" max="9999-12-31" class="form-control w-auto h-100 me-1" id="startDate2">
					<label class="form-label d-flex align-items-center m-0 me-1 h-100">~</label>
					<input type="date" max="9999-12-31" class="form-control w-auto h-100 me-1" id="endDate2">
					<select class="form-select w-auto h-100 me-1 monthAdjust" id="monthAdjust2">
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
					<input type="text" class="form-control w-auto h-100 me-1" id="searchAllPoa" placeholder="통합검색" >
					
					<!-- <label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">입고대상</label>
					<select class="form-select w-auto h-100 me-3" id="searchInMatrlTarget" style="min-width: 70px;">
						<option value="" >전체</option>
						<option value="Y">입고완료</option>
						<option value="N" selected>입고대상</option>
					</select> -->
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end">
					<div class="btn-group" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnSearchDtl"><i class="fa-regular fa-clipboard"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnSave" disabled><i class="fa-regular fa-floppy-disk"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnEdit"><i class="fa-regular fa-pen-to-square"></i></button>
						<button type="button" class="btn btn-outline-danger w-auto" style="font-size: 17px !important;" id="btnDel"><i class="fa-solid fa-trash-can"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnCancel" disabled><i class="fa-solid fa-xmark"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnClose">
							<i class="fa-solid fa-caret-right"></i>
						</button>
					</div>
				</div>
			</div>
			<div class="row" id="rightSecondHeader" style="padding-bottom: 5px;">
				<div class="d-flex align-items-center d-flex">
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100" style="min-height:30px;">입고대상</label>
					<select class="form-select w-auto h-100 me-3" id="searchInMatrlTarget" style="min-width: 70px;">
						<option value="" >전체</option>
						<option value="Y">입고완료</option>
						<option value="N" selected>입고대상</option>
					</select>
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end">
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
							<th class="text-center align-middle">자재코드</th>
							<th class="text-center align-middle">재질</th>
							<th class="text-center align-middle">발주처</th>
							<th class="text-center align-middle">주문량</th>
							<th class="text-center align-middle">Ⓡ</th>
							<th class="text-center align-middle">참고사항</th>
							<th class="text-center align-middle">비고</th>
							<th class="text-center align-middle">입고량</th>
							<th class="text-center align-middle">Ⓡ</th>
							<th class="text-center align-middle">입고일자</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>
<!-- 거래처 모달 -->
<div class="modal fade" id="dealCorpSelectModal" tabindex="-1" aria-hidden="true" style="z-index: 9999;">
	<div class="modal-dialog" style="max-width: 60vw;">
		<div class="modal-content" style="height: calc(100vh - 5em);">
			<div class="modal-header">
				<h5 class="modal-title">
					발주처 조회
				</h5>
				<div class="btn-group" role="group" aria-label="Small button group">
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnDealCorpSelectModalPaste">
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
						<select class="form-select w-auto h-100 me-3" id="dealCorpSelectGubun" style="min-width: 70px;">
							<option value="matrlCorp">등록된 발주처</option>
							<option value="all">모든 발주처</option>
						</select>
					</div>
					<div class="me-lg-auto"></div>
					<div class="d-flex align-items-center justify-content-end">
						<div class="btn-group" role="group" aria-label="Small button group">
							<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnDealCorpSelectSearch"><i class="fa-regular fa-clipboard"></i></button>
						</div>
					</div>
				</div>
				<table class="table table-bordered p-0 m-0" id="dealCorpSelectModalTable">
					<thead class="table-light">
						<tr>
							<th class="text-center">거래처코드</th>
							<th class="text-center">업체명</th>
							<th class="text-center">대표자</th>
							<th class="text-center">사업자번호</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>
<!-- 거래처 모달 끝 -->
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
			let rightcolMinWidth = 870; // rightcol 최소사이즈
	
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
			$('#page').css('grid-template-columns', '1.2fr 4px 1fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcol').removeClass('d-none');
		} else {
			$('#page').css('grid-template-columns', '0fr 4px 1fr');
			$('#leftcol').addClass('d-none');
			$('#rightcol').removeClass('d-none');
		}
		dataTableDrawAll(); // dataTable 전체 reload
	});
	$('#btnClose').on('click',function() { // right-box 닫기버튼 클릭
		if($('#leftcol').hasClass('d-none')){
			$('#page').css('grid-template-columns', '1.2fr 4px 1fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcol').removeClass('d-none');
		} else {
			$('#page').css('grid-template-columns', '1.2fr 4px 0fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcol').addClass('d-none');
		}
		dataTableDrawAll(); // dataTable 전체 reload
	});
</script>

<script>
	WM_init('ADM');

	let monthAdjustList = getCommonCode('시스템', '026'); //날짜조정
	monthAdjustList = _.sortBy(monthAdjustList, v=>parseInt(v.commonCd));
	selectBoxAppend(monthAdjustList, 'monthAdjust', '', '2'); //날짜조정s
	selectBoxAppend(monthAdjustList, 'monthAdjust2', '', '2'); //날짜조정s
	
	let dealGubunList = getCommonCode('시스템', '011'); // 거래구분
	let dealCorpStatusList = getCommonCode('시스템', '015'); // 거래상태
	selectBoxAppend(dealGubunList, 'modalDealGubun', '', '1'); //거래구분
	selectBoxAppend(dealCorpStatusList, 'modalDealCorpStatus', '', '1'); //거래상태

	let selectPeriod = parseInt(getCommonCode('시스템', '040')[0].commonCd); //기본조회기간 일
	// 수주일자
	$('#startDate').val(moment().subtract('d',selectPeriod).format('YYYY-MM-DD'));
	$('#endDate').val(moment().format('YYYY-MM-DD'));
	// 발주일자
	$('#startDate2').val(moment().subtract('d',selectPeriod).format('YYYY-MM-DD'));
	$('#endDate2').val(moment().format('YYYY-MM-DD'));

	// 자재정보 목록조회
	$('#matrlTable thead tr').clone(true).addClass('filters').appendTo('#matrlTable thead'); // filter 생성
	let matrlTable = $('#matrlTable').DataTable({
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
            style: 'multi',
            toggleable: true,
            items: 'row',
            info: false
        },
        ajax : {
			url : '<c:url value="/bs/bizOrderDtlLstGroupByMatrl"/>',
			type : 'POST',
			data : {
				'startDate' : function(){ return $('#startDate').val().replaceAll('-','');},
				'endDate' : function(){ return $('#endDate').val().replaceAll('-','');},
				'searchTarget' : function(){ return $('#searchTarget').val();},
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'paperType', className : 'text-center align-middle'},
			{ data: 'extraStock', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return addCommas(parseInt(data));
					} else {
						return '0';
					}
				}
			},
			{ data: 'extraStock', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != '' && data != '0') {
						let returnData = parseFloat(data);
						if(returnData >= 0){
							return parseInt(returnData/500)+'R'+(returnData%500);	
						} else {
							returnData *= -1;
							return '-' + parseInt(returnData/500)+'R'+(returnData%500);
						}
					} else {
						return '0R0';
					}
				}
			},
			{ data: 'spQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return addCommas(parseInt(data));
					} else {
						return '0';
					}
				}
			},//현재고
			{ data: 'spQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						let returnData = parseFloat(data);
						if(returnData >= 0){
							return parseInt(returnData/500)+'R'+(returnData%500);	
						} else {
							returnData *= -1;
							return '-' + parseInt(returnData/500)+'R'+(returnData%500);
						}
					} else {
						return '0R0';
					}
				}
			},
			{ data: 'ordQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return addCommas(parseInt(data));
					} else {
						return '0';
					}
				}
			},//수주량
			{ data: 'ordQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						let returnData = parseFloat(data);
						if(returnData >= 0){
							return parseInt(returnData/500)+'R'+(returnData%500);	
						} else {
							returnData *= -1;
							return '-' + parseInt(returnData/500)+'R'+(returnData%500);
						}
					} else {
						return '0R0';
					}
				}
			},
			{ className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					let spQty = row['spQty'] != null && row['spQty'] != '' ? row['spQty'] : 0;
					let ordQty = row['ordQty'] != null && row['ordQty'] != '' ? row['ordQty'] : 0;
					let returnData = parseFloat(spQty) - parseFloat(ordQty);
					if(returnData < 0 ){
						return addCommas(returnData);
					} else {
						return '0';
					}
					
				}
			},//발주필요량
			{ className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					let spQty = row['spQty'] != null && row['spQty'] != '' ? row['spQty'] : 0;
					let ordQty = row['ordQty'] != null && row['ordQty'] != '' ? row['ordQty'] : 0;
					let returnData = parseFloat(spQty) - parseFloat(ordQty);
					if(returnData >= 0){
						return '0R0';	
					} else {
						returnData *= -1;
						return '-' + parseInt(returnData/500)+'R'+(returnData%500);
					}
				}
			},
			{ className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					let sizeX = row['sizeX']==null?'':row['sizeX'];
					let sizeY = row['sizeY']==null?'':row['sizeY'];
					return sizeX + "*" + sizeY;
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
			let data = api.data();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let headerHeight = parseFloat($('#leftHeader').css('height')) + parseFloat($('#leftSecondHeader').css('height')); 
			let theadHeight = parseFloat($('#matrlTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - headerHeight - theadHeight - 41)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAll').off('keyup',function() {});
			$('#searchAll').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			});
			
			for(var i=0;i<api.data().count();i++) {
				let data = api.row(i).data();
				let node = api.row(i).node();

				//적정재고
				let extraStock = parseInt(data.extraStock==null?0:data.extraStock);
				//수주량
				let ordQty = parseInt(data.ordQty==null?0:data.ordQty);
				//발주량
				let purchaseQty = parseInt(data.purchaseQty==null?0:data.purchaseQty);
				//현재고
				let spQty = parseInt(data.spQty==null?0:data.spQty);

				//적정재고 - 수주량 + 발주량 + 현재고 < 0
				// 2022.12.21 공식변경  현재고 – 수주량 + 발주량 < 적정재고
				// 2022.12.28 공식변경 현재고 - 수주량(<- 계산한게 발주필요량) < 적정재고
				if(spQty - ordQty < extraStock ) {
					$(node).addClass('bg-danger bg-gradient');
				}
			}
		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#matrlTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#matrlTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
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
	matrlTable.on('column-reorder', function( e, settings, details ) {
		let api = matrlTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#matrlTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	// 원자재목록 조회 버튼 click
	$('#btnSearch').on('click', function() {
		$('#my-spinner').show();
		matrlTable.rows().deselect();
		matrlTable.ajax.reload(function() {});
		purchaseOrderAdmTable.ajax.reload(function(){});
		setTimeout(function() {
			$('#my-spinner').hide();
		}, 100)
	});

	// 원자재목록 추가 버튼 click
	$('#btnAdd').on('click', function() {
		if(matrlTable.row('.selected').data() == undefined) {
			toastr.warning('추가할 원단을 선택해주세요.');
			return false;
		}
		WM_action_ON('ADM','workingWarningModal');
		
		purchaseOrderAdmTable.colReorder.disable();
	
		let dataList = matrlTable.rows('.selected').data().toArray();
		
		let col_filter_text = [];
		$('#purchaseOrderAdmTable_wrapper').find('.filters th').each(function(index, item) {
			$(item).find('input').attr('disabled', true); // 검색 필터 disabled
			col_filter_text.push($(item).find('input').val());
		});
	
		let addList = [];
		for(var i=0;i<dataList.length;i++) {
			let obj = {};
			obj.idx = '';
			obj.matrlIdx = dataList[i].idx;
			obj.matrlCd = dataList[i].matrlCd;
			obj.matrlNm = dataList[i].matrlNm;
			obj.paperType = dataList[i].paperType;
			obj.confirmYn = 'N';
			obj.printYn = 'N';
			obj.purchaseOrdNo = '자동채번';
			obj.purchaseOrdQty = (dataList[i].extraStock == '' || dataList[i].extraStock == null) ? 0 : dataList[i].extraStock;
			obj.purchaseOrdDate = moment().format('YYYY-MM-DD');
			obj.purchaseInDueDate = moment().format('YYYY-MM-DD');
			if(dataList[i].dealCorpIdx > 0 && dataList[i].dealCorpNm != null){
				obj.dealCorpIdx = dataList[i].dealCorpIdx;
				obj.dealCorpNm = dataList[i].dealCorpNm;
			} else {
				obj.dealCorpIdx = '';
				obj.dealCorpNm = '';
			}
			obj.cutQty = '1';
			obj.eaQty = '1';
			obj.extraQty = '0';
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
	
	// 발주관리 개별발주 목록조회
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
			url : '<c:url value="/pm/purchaseOrderAdmLstBySingle"/>',
			type : 'POST',
			data : {
				startDate : function() { return moment($('#startDate2').val()).format('YYYYMMDD'); },
				endDate : function() { return moment($('#endDate2').val()).format('YYYYMMDD'); },
				searchInMatrlTarget	 : function() { return $('#searchInMatrlTarget').val(); },
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
							html += '		data-type="confirmOrder" data-idx=""';
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
			{ data: 'matrlCd', className : 'text-center align-middle', name: 'matrlCd'},
			{ data: 'paperType', className : 'text-center align-middle', name: 'paperType'},
			{ data: 'dealCorpNm', className : 'text-end align-middle editNode', name: 'dealCorpNm',
				render : function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						let html = '';
							html += '<div class="input-group" style="min-width: 150px;">';
							html += '	<input type="text" class="form-control" value="'+data+'" disabled>';
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
							html += '		">';
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
			{ data: 'purchaseOrdQty', className : 'text-end align-middle editNode', name: 'purchaseOrdQty',
				render : function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						if(data != '' && data != null) {
							return addCommas(parseInt(data));
						} else {
							return '';
						}
					} else {
						let html = '';
							html += '<input type="text" class="form-control text-end calValue" onkeyup="numberFormat(this, \'int\')" value="'+addCommas(parseFloat(data))+'">';
							html += '<span class="d-none">'+data+'</span>';
						return html;
					}
				}
			},
			{ className : 'text-end align-middle', name: 'finalPurchaseQty', // 최종발주량
				render : function(data, type, row, meta) {
					let ordQty = parseInt(row['purchaseOrdQty']); // 주문수량(제품)
					let cutQty = parseInt(row['cutQty']); // 절수
					let eaQty = parseInt(row['eaQty']); // 개수
					let extraQty = parseInt(row['extraQty']); // 여유분
					
					if(cutQty == 0 || eaQty == 0) {
						return '0';
					} else {
						//let printPressQty = Math.ceil(ordQty/eaQty);
						let printPressQty = Math.ceil(ordQty/(cutQty*eaQty)) * cutQty;
						let pressQty = Math.ceil((printPressQty + extraQty)/cutQty);
						
						let R = parseInt(pressQty / 500); // R로 환산
						let finalPurchaseQty = R + "R" + (pressQty % 500);
						
						return finalPurchaseQty;
					}
				}
			},
			{ data: 'purchaseNote', className : 'text-center align-middle editNode', name: 'purchaseNote',
				render : function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						if(data != '' && data != null) {
							return data;
						} else {
							return '';
						}
					} else {
						let html = '';
							html += '<input type="text" class="form-control text-end" style="min-width: 200px;">';
							html += '<span class="d-none">'+data+'</span>';
						return html;
					}
				}
			},
			{ data: 'purchaseDesc', className : 'text-center align-middle editNode', name: 'purchaseDesc',
				render : function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						if(data != '' && data != null) {
							return data;
						} else {
							return '';
						}
					} else {
						let html = '';
							html += '<input type="text" class="form-control text-end" style="min-width: 100px;">';
							html += '<span class="d-none">'+data+'</span>';
						return html;
					}
				}
			},
			{ data: 'inQty', className : 'text-end align-middle',//입고량
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return addCommas(parseInt(data));
					} else {
						return '0';
					}
				}
			}, 
			{ data: 'inQty', className : 'text-end align-middle',//입고량R
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						let R = parseInt( parseInt(data) / 500); // R로 환산
						let finalPurchaseQty = R + "R" + ( parseInt(data) % 500);
						
						return finalPurchaseQty;
					} else {
						return '0R0';
					}
				}
			},
			{ data: 'inDate', className : 'text-center align-middle',//입고일
				render : function(data, type, row, meta) {
					if(data != '' && data != null) {
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data,'YYYYMMDD').format('YYYY-MM-DD')+'</div>';
					} else {
						return '-';
					}
				}
			}
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
			/* { extend: 'colvis',	text: 'Select Col',	}, */
		],
		order : [],
		drawCallback: function() {
			let api = this.api();
			
			let htmlHeight = parseFloat($('html').css('height'));
			let headerHeight = parseFloat($('#rightHeader').css('height')) + parseFloat($('#rightSecondHeader').css('height')); 
			let theadHeight = parseFloat($('#purchaseOrderAdmTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#purchaseOrderAdmTable_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - headerHeight - theadHeight - 41)+'px');
			
			$('#purchaseOrderAdmTable_filter').addClass('d-none');
			// 통합검색
			$('#searchAllPoa').off('keyup',function() {});
			$('#searchAllPoa').on('keyup',function() {
				$('#purchaseOrderAdmTable_filter').find('input').val($(this).val());
				$('#purchaseOrderAdmTable_filter').find('input').trigger('keyup');
			});
	
			$('.bootstrapToggle').bootstrapToggle();
			let data = api.data();
			let node = api.rows().nodes();
			if(data.length > 0){
				
				$(node).each(function(index, item) {
					if( purchaseOrderAdmTable.row(item).data().printYn == 'Y' ) {
						$(purchaseOrderAdmTable.row(item).node()).find('.bootstrapToggle').bootstrapToggle('disable');
						$(purchaseOrderAdmTable.row(item).node()).addClass('notEdit');
					}
				});
			}
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
				$('#purchaseOrderAdmTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	purchaseOrderAdmTable.on('column-reorder', function( e, settings, details ) {
		let api = purchaseOrderAdmTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#purchaseOrderAdmTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	
		$('.bootstrapToggle').bootstrapToggle();
	});

	// 발주확정
	$(document).off('change','.confirmToggle');
	$(document).on('change','.confirmToggle', function() {
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
					matrlTable.rows().deselect();
					matrlTable.ajax.reload(function() {});
					purchaseOrderAdmTable.ajax.reload(function(){});
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
	});

	// 개별발주목록 조회 버튼 click
	$('#btnSearchDtl').on('click', function() {
		$('#my-spinner').show();
		purchaseOrderAdmTable.clear();
		purchaseOrderAdmTable.ajax.reload(function() {});
		matrlTable.rows().deselect();
		matrlTable.ajax.reload(function() {});
		
		setTimeout(function() {
			$('#my-spinner').hide();
		}, 100)
	});
	
	// 작업중 경고 모달 예 버튼 click
	$('#btnWorkingWarningModalY').on('click', function() {
		if(WMlastIdx == 'ADM') { // 개별발주 수정중이나 신규등록중이였을 경우
			$('#btnSave').trigger('click');
			return false;
		}
	});
	
	// 작업중 경고 모달 아니요 버튼 click
	$('#btnWorkingWarningModalN').on('click', function() {
		if(WMlastIdx == 'ADM') { // 개별발주 수정중이나 신규등록중이였을 경우
			if(window.location != window.parent.location) { // tab일 경우
				// 부모 탭 닫기버튼 click
				$('#tab-list', parent.document).find('.active').find('span').eq(1).find('i').trigger('click');
		    }
		}
	});
	
	
	
	//발주처 돋보기버튼
	/* $(document).on('click','.dealCorpModalBtn',function(){
		matrlIdxVal = $(this).data('matrlidx'); //자재 식별자
		if(matrlIdxVal == '' || matrlIdxVal == null || matrlIdxVal == "null"){
			matrlIdxVal = 0;
		} 
		$('#dealCorpSelectGubun').val('matrlCorp');
		dealCorpSelectGubun = $('#dealCorpSelectGubun').val();
		$('#dealCorpSelectModal').modal('show');
		setTimeout(function() {
			dealCorpSelectModalTable.ajax.reload(function() {});
		}, 200);	
	}); */
	
	
	
	// 수량 계산
	$(document).on('keyup', '.editNode input', function(e) {
		let tr = $(e.target).parent().parent();
		let td = $(tr).find('td');
		let ordQty = $(td).eq(purchaseOrderAdmTable.column('purchaseOrdQty:name').index()).find('input').val();
		let cutQty = '1';
		let eaQty = '1';
		let extraQty = '0';
	
		ordQty = parseInt(ordQty.replaceAll(/,/g,'')); // 주문수량(제품)
		cutQty = parseInt(cutQty.replaceAll(/,/g,'')); // 절수
		eaQty = parseInt(eaQty.replaceAll(/,/g,'')); // 개수
		extraQty = parseInt(extraQty.replaceAll(/,/g,'')); // 여유분
	
		let cuttingSize = Math.ceil(ordQty/(cutQty*eaQty)); // cuttingSize
		//let printPressQty = Math.ceil(ordQty/eaQty); // 정매인쇄통수
		let printPressQty = Math.ceil(ordQty/(cutQty*eaQty)) * cutQty;
		let pressQty = Math.ceil((printPressQty + extraQty)/cutQty); // 통수
		let R = parseInt(cuttingSize / 500); // R로 환산
		let purchaseQty = R + "R" + (cuttingSize % 500); // 발주량 R
		let finalPurchaseQty = R + "R" + (pressQty % 500); // 최종발주량
	
		if(cutQty != 0 && eaQty != 0) {
			$(td).eq(purchaseOrderAdmTable.column('cuttingSize:name').index()).html(addCommas(parseInt(cuttingSize)));
			$(td).eq(purchaseOrderAdmTable.column('printPressQty:name').index()).html(addCommas(parseInt(printPressQty)));
			$(td).eq(purchaseOrderAdmTable.column('pressQty:name').index()).html(addCommas(parseInt(pressQty)));
			$(td).eq(purchaseOrderAdmTable.column('purchaseQty:name').index()).html(purchaseQty);
			$(td).eq(purchaseOrderAdmTable.column('finalPurchaseQty:name').index()).html(finalPurchaseQty);
		}
	});
	
	// 자재 붙여넣기 버튼 click
	$('#btnMatrlModalPaste').on('click', function() {
		
	});
	
	// 개별발주 저장 버튼 click
	$('#btnSave').on('click', function() {
		let array = [];
		let state = true;
		$('#purchaseOrderAdmTable tbody').find('tr').each(function(index, item) {
			if($(item).find('td').find('input').length > 3) {
				let td = $(item).find('td');
				let idx = purchaseOrderAdmTable.row($(item)).data().idx;
				let purchaseOrdNo = purchaseOrderAdmTable.row($(item)).data().purchaseOrdNo;
				
				let purchaseOrdQty = $(td).eq(purchaseOrderAdmTable.column('purchaseOrdQty:name').index()).find('input').val().replaceAll(/,/g,'');
				let purchaseOrdDate = $(td).eq(purchaseOrderAdmTable.column('purchaseOrdDate:name').index()).find('input').val();
				let purchaseInDueDate = $(td).eq(purchaseOrderAdmTable.column('purchaseInDueDate:name').index()).find('input').val();
				let dealCorpIdx = $(td).eq(purchaseOrderAdmTable.column('dealCorpNm:name').index()).find('input[type=hidden]').val();
				let cutQty = '1';
				let eaQty = '1';
				let extraQty = '0';
				let cutSize = '';
				let purchaseNote = $(td).eq(purchaseOrderAdmTable.column('purchaseNote:name').index()).find('input').val();
				let purchaseDesc = $(td).eq(purchaseOrderAdmTable.column('purchaseDesc:name').index()).find('input').val();
	
				let ordQty = parseInt(purchaseOrdQty); // 주문수량(제품)
				let cutQtyInt = parseInt(cutQty); // 절수
				let eaQtyInt = parseInt(eaQty); // 개수
				let extraQtyInt = parseInt(extraQty); // 여유분
				
				//let printPressQty = Math.ceil(ordQty/eaQtyInt);
				let printPressQty = Math.ceil(ordQty/(cutQty*eaQty)) * cutQty;
				let pressQty = Math.ceil((printPressQty + extraQtyInt)/cutQtyInt);
				
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
				if(purchaseOrdQty == '' || purchaseOrdQty == '0') {
					toastr.warning('주문수량을 입력해주세요.');
					$(td).eq(purchaseOrderAdmTable.column('purchaseOrdQty:name').index()).find('input').focus();
					state = false;
					return false;
				}
	
				let obj = new Object();
				obj.idx = idx;
				obj.bizOrdDtlIdx = '';
				obj.purchaseOrdDate = moment(purchaseOrdDate).format('YYYYMMDD');
				obj.purchaseInDueDate = moment(purchaseInDueDate).format('YYYYMMDD');
				obj.dealCorpIdx = dealCorpIdx;
				obj.cutQty = cutQty;
				obj.eaQty = eaQty;
				obj.extraQty = extraQty;
				obj.extraPackQty = '0';
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

					matrlTable.rows().deselect();
					matrlTable.ajax.reload(function() {});
						
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
	
	// 개별발주 수정 버튼 click
	$('#btnEdit').on('click', function() {
		WM_action_ON('ADM','workingWarningModal');
		
		$('#purchaseOrderAdmTable_wrapper').find('.filters th').each(function(index, item) {
			$(item).find('input').attr('disabled', true); // 검색 필터 disabled
		});
		
		$('#purchaseOrderAdmTable tbody').find('tr').each(function(index_tr, tr) {
			if(!$(tr).hasClass('notEdit')){
				$(tr).find('td').each(function(index_td, td) {
					if($(td).hasClass('editNode') && $(td).find('input').length != 1) {
						if(index_td == purchaseOrderAdmTable.column('purchaseOrdDate:name').index()) {
							let value = purchaseOrderAdmTable.row(tr).data().purchaseOrdDate;
							value = moment(value).format('YYYY-MM-DD');
							$(td).html('<input type="date" max="9999-12-31" class="form-control text-center" value="'+value+'">');
						} else if(index_td == purchaseOrderAdmTable.column('purchaseInDueDate:name').index()) {
							let value = purchaseOrderAdmTable.row(tr).data().purchaseInDueDate;
							value = moment(value).format('YYYY-MM-DD');
							$(td).html('<input type="date" max="9999-12-31" class="form-control text-center" onkeyup="numberFormat(this, \'int\')" value="'+value+'">');
						} else if(index_td == purchaseOrderAdmTable.column('dealCorpNm:name').index()) {
							$(td).find('button').attr('disabled',false);
						} else {
							let value = $(td).text();
							if(index_td == purchaseOrderAdmTable.column('cutQty:name').index() ||
							   index_td == purchaseOrderAdmTable.column('eaQty:name').index() ||
							   index_td == purchaseOrderAdmTable.column('extraQty:name').index()) {
								$(td).html('<input type="text" class="form-control text-end" onkeyup="numberFormat(this, \'int\')" value="'+value+'">');
							} else {
								$(td).html('<input type="text" class="form-control text-center" value="'+value+'">');
							}
						}
					}
				})
			}
		});
	
		purchaseOrderAdmTable.colReorder.disable();
		purchaseOrderAdmTable.draw();
	
		$('#btnNew').attr('disabled', false); // DTL 신규 버튼
		$('#btnSave').attr('disabled', false); // DTL 저장 버튼
		$('#btnEdit').attr('disabled', true); // DTL 수정 버튼
		$('#btnDel').attr('disabled', false); // DTL 삭제 버튼
		$('#btnCancel').attr('disabled', false); // DTL 취소 버튼
	});
	
	// 개별발주 삭제 버튼 click
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
	
	// 개별발주 취소 버튼 click
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
			matrlTable.rows().deselect();
			matrlTable.ajax.reload(function() {});
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
	
	
	
	
	
	//발주처(자재투입) 목록 조회
	/* let matrlIdxVal = '';
	let dealCorpSelectGubun = 'matrlCorp';
	$('#dealCorpSelectModalTable thead tr').clone(true).addClass('filters').appendTo('#dealCorpSelectModalTable thead'); // filter 생성
	let dealCorpSelectModalTable = $('#dealCorpSelectModalTable').DataTable({
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
			url : '<c:url value="/bm/matrlDealCorpAdmList"/>',
			type : 'POST',
			data : {
				matrlIdx 		   : function() { return matrlIdxVal},
				dealCorpSelectGubun: function() { return dealCorpSelectGubun; }
			},
		},
	    rowId: 'idx',
		columns : [
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
			let theadHeight = parseFloat($('#dealCorpSelectModalTable_wrapper').find('.dataTables_scrollHead').css('height'));
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
				let cell = $('#dealCorpSelectModalTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);
	
				let title = $(cell).text();
	
				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');
	
				let cursorPosition = '';
				
				// On every keypress in this input
				$('#dealCorpSelectModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	
	// dataTable colReorder event
	dealCorpSelectModalTable.on('column-reorder', function( e, settings, details ) {
		let api = dealCorpSelectModalTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#dealCorpSelectModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});
	
	// 개별발주 발주처 조회
	$('#btnDealCorpSelectSearch').on('click',function(){
		dealCorpSelectGubun = $('#dealCorpSelectGubun').val();
		dealCorpSelectModalTable.ajax.reload();
	});
	
	// 개별발주 발주처 붙여넣기
	$('#btnDealCorpSelectModalPaste').on('click',function(){
		if(!$('#dealCorpSelectModalTable tbody tr').hasClass('selected')){
			toastr.warning('붙여넣을 행을 선택해주세요.');
			return false;
		}
		let node = purchaseOrderAdmTable.row('.selected').node();
		let data = purchaseOrderAdmTable.row('.selected').data();
		let selectNodeModalData = dealCorpSelectModalTable.row('.selected').data();
		$(node).find('td').eq(purchaseOrderAdmTable.column('dealCorpNm:name').index()).find('input[type=hidden]').val(selectNodeModalData.idx);			//발주처 식별자
		$(node).find('td').eq(purchaseOrderAdmTable.column('dealCorpNm:name').index()).find('input[type=text]').val(selectNodeModalData.dealCorpNm);		//발주처 이름
		$('#dealCorpSelectModal').modal('hide');
	}); */

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
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 223)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			/* $('#searchAll').off('keyup',function() {});
			$('#searchAll').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			}); */
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

	$('#dealCorpModalTable tbody').on('dblclick','tr',function(){
		let node = purchaseOrderAdmTable.row('.selected').node();
		let data = purchaseOrderAdmTable.row('.selected').data();
		let selectNodeModalData = dealCorpModalTable.row(this).data();
		$(node).find('td').eq(purchaseOrderAdmTable.column('dealCorpNm:name').index()).find('input[type=hidden]').val(selectNodeModalData.idx);			//발주처 식별자
		$(node).find('td').eq(purchaseOrderAdmTable.column('dealCorpNm:name').index()).find('input[type=text]').val(selectNodeModalData.dealCorpNm);		//발주처 이름
		$('#dealCorpModal').modal('hide');
	});
	
</script>

</body>
</html>
