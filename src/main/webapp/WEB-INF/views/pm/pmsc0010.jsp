<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/top.jsp"%>
<%@include file="../layout/modal.jsp"%>
<%@include file="../layout/script.jsp"%>
<div id="page" onmouseup="EndDrag()" onmousemove="OnDrag(event)" style="grid-template-areas: 'leftcol';
																		  grid-template-rows: 1fr;
																		  grid-template-columns: 1fr;">
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
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">디자인컨펌</label>
					<select class="form-select w-auto h-100 me-3" id="searchConfirmDesign" style="min-width: 70px;">
						<option value="" selected>전체</option>
						<option value="Y">확정</option>
						<option value="N">미확정</option>
					</select>
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">발주대상</label>
					<select class="form-select w-auto h-100 me-3" id="searchPurchaseTarget" style="min-width: 70px;">
						<option value="" selected>전체</option>
						<option value="Y">대상</option>
						<option value="N">미대상</option>
					</select>
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">입고대상</label>
					<select class="form-select w-auto h-100 me-3" id="searchInMatrlTarget" style="min-width: 70px;">
						<option value="" >전체</option>
						<option value="Y">입고완료</option>
						<option value="N" selected>입고대상</option>
					</select>
					<input type="text" class="form-control w-auto h-100 me-1" id="searchAll" placeholder="통합검색" >
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end">
					<div class="btn-group" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnSearch"><i class="fa-regular fa-clipboard"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnSave" disabled><i class="fa-regular fa-floppy-disk"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnEdit"><i class="fa-regular fa-pen-to-square"></i></button>
					</div>
				</div>
			</div>
			<div class="row">
				<table class="table table-bordered p-0 m-0" id="bizOrderTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle" style="max-width:35px;">디자인</th>
							<th class="text-center align-middle">개별발주</th>
							<th class="text-center align-middle">발주확정</th>
							<th class="text-center align-middle">출력여부</th>
							<th class="text-center align-middle">생산상태</th>
							<th class="text-center align-middle">수주상세번호</th>
							<th class="text-center align-middle">고객사</th>
							<th class="text-center align-middle">제품명</th>
							<th class="text-center align-middle">목표요구일</th>
							<th class="text-center align-middle">납품요구일</th>
							<th class="text-center align-middle">주문수량</th>
							<th class="text-center align-middle">건별전달사항</th>
							<th class="text-center align-middle">재질</th>
							<th class="text-center align-middle">실시간재고</th>
							<th class="text-center align-middle">®</th>
							<th class="text-center align-middle">발주량</th>
							<th class="text-center align-middle">®</th>
							<th class="text-center align-middle">잔량</th>
							<th class="text-center align-middle">®</th>
							<th class="text-center align-middle">추가여분수량</th>
							<th class="text-center align-middle">®</th>
							<th class="text-center align-middle">입고량</th>
							<th class="text-center align-middle">®</th>
							<th class="text-center align-middle">입고일자</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
	
	
	<!-- <div id="dragbarV" onmousedown="StartDrag()"></div>
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
	 -->
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

	let monthAdjustList = getCommonCode('시스템', '026'); //날짜조정
	monthAdjustList = _.sortBy(monthAdjustList, v=>parseInt(v.commonCd));
	selectBoxAppend(monthAdjustList, 'monthAdjust', '', '2'); //날짜조정
	
	let dealGubunList = getCommonCode('시스템', '011'); // 거래구분
	let dealCorpStatusList = getCommonCode('시스템', '015'); // 거래상태
	
	selectBoxAppend(dealGubunList, 'modalDealGubun', '', '1'); //거래구분
	selectBoxAppend(dealCorpStatusList, 'modalDealCorpStatus', '', '1'); //거래상태
	
	let selectPeriod = parseInt(getCommonCode('시스템', '040')[0].commonCd); //기본조회기간 일
	$('#startDate').val(moment().subtract('d',selectPeriod).format('YYYY-MM-DD'));
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
			url : '<c:url value="/bs/bizOrderStatusLstWithPO"/>',
			type : 'POST',
			data : {
				startDate	: function() { return moment($('#startDate').val(),'YYYY-MM-DD').format('YYYYMMDD'); },
				endDate		: function() { return moment($('#endDate').val(),'YYYY-MM-DD').format('YYYYMMDD'); },
				confirmDesign : function() { return $('#searchConfirmDesign').val(); },
				purchaseTarget : function() { return $('#searchPurchaseTarget').val(); },
				searchInMatrlTarget : function() { return $('#searchInMatrlTarget').val(); },
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'confirmDesign', className : 'text-center align-middle', //디자인컨펌
				render : function(data, type, row, meta) {
					if(data == 'Y') {
						return '<i class="fa-solid fa-check mt-1 text-success"></i>';
					} else {
						return '<i class="fa-solid fa-x mt-1 text-danger"></i>';
					}
				}
			},
			{ data: 'mergeIdx', className : 'text-center align-middle py-0',//개별발주여부
				render : function(data, type, row, meta) {
					if(data != '' && data != null && data != '0') {
						return '<i class="fa-solid fa-check mt-1 text-success"></i>';
					} else {
						return '';
					}
				}	
			},
			{ data: 'confirmYn', className : 'text-center align-middle', name: 'confirmYn', //확정여부
				render : function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						if(data == 'Y') {
							let html = '';
								html += '<input type="checkbox" class="bootstrapToggle confirmToggle p-0" data-toggle="toggle"';
								html += '		data-type="confirmOrder" data-idx="'+row['purchaseIdx']+'"';
								html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
								html += '		data-size="small"';
								html += '		checked>';
							return html;
						} else {
							let html = '';
								html += '<input type="checkbox" class="bootstrapToggle confirmToggle p-0" data-toggle="toggle"';
								html += '		data-type="confirmOrder" data-idx="'+row['purchaseIdx']+'"';
								html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
								html += '		data-size="small"';
								html += '		>';
							return html;
						}
					} else {
						let html = '';
							html += '<input type="checkbox" class="bootstrapToggle confirmToggle p-0" data-toggle="toggle"';
							html += '		data-type="confirmOrder" data-idx="'+row['purchaseIdx']+'"';
							html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
							html += '		data-size="small"';
							html += '		disabled>';
						return html;
					}
					
				}
			},
			{ data: 'printYn', className : 'text-center align-middle', //발주서출력
				render : function(data, type, row, meta) {
					if(data == 'Y') {
						return '<i class="fa-solid fa-check mt-1 text-success"></i>';
					} else {
						return '<i class="fa-solid fa-x mt-1 text-danger"></i>';
					}
				}
			},
			{ data: 'workOrdPrcssJson', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != '' && data != null) {
						let jsonData = JSON.parse(data);
						let filterList = _.filter(jsonData, (v => v.progressStatus == 'WI' || v.progressStatus == 'WC'));
						let returnValue = '';
						if(filterList.length == 0){
							returnValue = '대기';
						} else {
							if(jsonData.length == _.filter(jsonData, (v => v.progressStatus == 'WC')).length ){
								returnValue = '생산완료';
							} else {
								returnValue = '진행중';
							}
						}
						return returnValue;
					} else {
						return '작업미확정';
					}
				}
			}, //생산상태
			{ data: 'bizOrdDtlNo', className : 'text-center align-middle'}, //수주상세번호
			{ data: 'dealCorpNm', className : 'text-center align-middle'}, //고객사
			{ data: 'itemNm', className : 'text-center align-middle'},	//제품명
			{ data: 'workEndReqDate', className : 'text-center align-middle',//목표요구일(생산완료요구일)
				render : function(data, type, row, meta) {
					if(data != '' && data != null) {
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data,'YYYYMMDD').format('YYYY-MM-DD')+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ data: 'outReqDate', className : 'text-center align-middle',//납품요구일(출고요청일)
				render : function(data, type, row, meta) {
					if(data != '' && data != null) {
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data,'YYYYMMDD').format('YYYY-MM-DD')+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ data: 'ordQty', className : 'text-end align-middle', //주문수량
				render : function(data, type, row, meta) {
					return addCommas(parseInt(data));
				}
			},
			{ data: 'ordIssue', className : 'text-start align-middle', //특이사항이었는데 건별전달사항됨
				render : function(data, type, row, meta) {
					if(data != '' && data != null) {
						return '<div style="white-space:pre-wrap;width:330px;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'paperType', className : 'text-center align-middle',//재질
				render : function(data, type, row, meta) {
					if(data != '' && data != null) {
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ data: 'spQty', className : 'text-end align-middle',//실시간재고
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return addCommas(parseInt(data));
					} else {
						return '0';
					}
				}
			}, 
			{ data: 'spQty', className : 'text-end align-middle',//실시간재고 R 
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						let returnR;
						if(parseInt(data) < 0){
							returnR = "-" + parseInt(-1*data/500) + 'R' + parseInt(-1*data%500); 
						} else {
							returnR = parseInt(data/500) + 'R' + parseInt(data%500); 
						}
						return returnR;
					} else {
						return '0R0';
					}
				}
			},
			{ data: 'purchaseOrdQty', className : 'text-end align-middle', name:'purchaseOrdQty',//발주량
				render : function(data, type, row, meta) {
					//if(row['etc2'] == '02'){
						//매입단위가 "통"인 경우 수주수량 == 발주수량임
					//	let purchaseOrdQty = isEmptyCheck(row['purchaseOrdQty']) ? 0 : parseInt(row['purchaseOrdQty']);
					//	let R = parseInt(purchaseOrdQty / 500); // R로 환산
					//	let purchaseQty = R + "R" + (purchaseOrdQty % 500);
						
					//	return addCommas(parseFloat(purchaseOrdQty));
					//} else {
						//매입단위가 "연" OR 매입단위 등록안한 경우 -> 계산식 적용해야함
						let ordQty = parseInt(row['purchaseOrdQty']); // 주문수량(제품)
						let cutQty = parseInt(row['cutQty']); // 절수
						let eaQty = parseInt(row['eaQty']); // 개수
						let extraQty = parseInt(row['extraQty']); // 여유분
						let extraPackQty = parseInt(row['extraPackQty']); // 포장단위여분
						
						if(cutQty == 0 || eaQty == 0 || row['purchaseIdx'] == null || row['purchaseIdx'] == '') {
							return '0';
						} else {
							//let printPressQty = Math.ceil(ordQty/eaQty);
							let printPressQty = Math.ceil(ordQty/(cutQty*eaQty)) * cutQty;
							let pressQty = Math.ceil((printPressQty + extraQty)/cutQty + extraPackQty);
							
							let R = parseInt(pressQty / 500); // R로 환산
							let finalPurchaseQty = R + "R" + (pressQty % 500);
	
							return addCommas(parseFloat(pressQty));
							//return '<input type="text" class="form-control text-end" onkeyup="numberFormat(this, \'int\')" value="'+addCommas(parseFloat(pressQty))+'" disabled>';
						}
					//}
				}
			}, 
			{ data: 'purchaseOrdQty', className : 'text-end align-middle', name:'purchaseOrdQtyR',//발주량 R 
				render : function(data, type, row, meta) {
					//if(row['etc2'] == '02'){
						//매입단위가 "통"인 경우 수주수량 == 발주수량임
					//	let purchaseOrdQty = isEmptyCheck(row['purchaseOrdQty']) ? 0 : parseInt(row['purchaseOrdQty']);
					//	let R = parseInt(purchaseOrdQty / 500); // R로 환산
					//	let purchaseQty = R + "R" + (purchaseOrdQty % 500);
						
					//	return purchaseQty;
					//} else {
						//매입단위가 "연" OR 매입단위 등록안한 경우 -> 계산식 적용해야함
						let ordQty = parseInt(row['purchaseOrdQty']); // 주문수량(제품)
						let cutQty = parseInt(row['cutQty']); // 절수
						let eaQty = parseInt(row['eaQty']); // 개수
						let extraQty = parseInt(row['extraQty']); // 여유분
						let extraPackQty = parseInt(row['extraPackQty']); // 포장단위여분
						
						if(cutQty == 0 || eaQty == 0 || row['purchaseIdx'] == null || row['purchaseIdx'] == '') {
							return '0';
						} else {
							//let printPressQty = Math.ceil(ordQty/eaQty);
							let printPressQty = Math.ceil(ordQty/(cutQty*eaQty)) * cutQty;
							let pressQty = Math.ceil((printPressQty + extraQty)/cutQty + extraPackQty);
	
							let returnR;
							if(parseInt(pressQty) < 0){
								returnR = "-" + parseInt(-1*pressQty/500) + 'R' + parseInt(-1*pressQty%500); 
							} else {
								returnR = parseInt(pressQty/500) + 'R' + parseInt(pressQty%500); 
							}						
							//let R = parseInt(pressQty / 500); // R로 환산
							//let finalPurchaseQty = R + "R" + (pressQty % 500);
							
							return returnR;
						}
					//}
				}
			},
			{ data: 'spQty', className : 'text-end align-middle',//잔량
				render : function(data, type, row, meta) {
					//if(row['etc2'] == '02'){
						//매입단위가 "통"인 경우 수주수량 == 발주수량임
					//	if(data != null && data != '') {
					//		let purchaseOrdQty = isEmptyCheck(row['purchaseOrdQty']) ? 0 : parseInt(row['purchaseOrdQty']);
							
					//		return addCommas(parseInt(data) - parseInt(purchaseOrdQty));
					//	} else {
					//		return '0';
					//	}
					//} else {
						//매입단위가 "연" OR 매입단위 등록안한 경우 -> 계산식 적용해야함
						if(data != null && data != '') {
							let ordQty = parseInt(row['purchaseOrdQty']); // 주문수량(제품)
							let cutQty = parseInt(row['cutQty']); // 절수
							let eaQty = parseInt(row['eaQty']); // 개수
							let extraQty = parseInt(row['extraQty']); // 여유분
							let extraPackQty = parseInt(row['extraPackQty']); // 포장단위여분
							
							//let printPressQty = Math.ceil(ordQty/eaQty);
							let printPressQty = Math.ceil(ordQty/(cutQty*eaQty)) * cutQty;
							let pressQty = Math.ceil((printPressQty + extraQty)/cutQty + extraPackQty);
							
							return addCommas(parseInt(data) - parseInt(pressQty));
						} else {
							return '0';
						}
					//}
				}
			}, 
			{ data: 'spQty', className : 'text-end align-middle',//잔량 R 
				render : function(data, type, row, meta) {
					//if(row['etc2'] == '02'){
						//매입단위가 "통"인 경우 수주수량 == 발주수량임
					//	if(data != null && data != '') {
					//		let purchaseOrdQty = isEmptyCheck(row['purchaseOrdQty']) ? 0 : parseInt(row['purchaseOrdQty']);
					//		let remainQty = parseInt(data) - parseInt(purchaseOrdQty);
					//		let returnR;
					//		if(parseInt(remainQty) < 0){
					//			returnR = "-" + parseInt(-1*remainQty/500) + 'R' + parseInt(-1*remainQty%500); 
					//		} else {
					//			returnR = parseInt(remainQty/500) + 'R' + parseInt(remainQty%500); 
					//		}
							
					//		return returnR;
					//	} else {
					//		return '0';
					//	}
					//} else {
						//매입단위가 "연" OR 매입단위 등록안한 경우 -> 계산식 적용해야함
						if(data != null && data != '') {
							let ordQty = parseInt(row['purchaseOrdQty']); // 주문수량(제품)
							let cutQty = parseInt(row['cutQty']); // 절수
							let eaQty = parseInt(row['eaQty']); // 개수
							let extraQty = parseInt(row['extraQty']); // 여유분
							let extraPackQty = parseInt(row['extraPackQty']); // 포장단위여분
							
							//let printPressQty = Math.ceil(ordQty/eaQty);
							let printPressQty = Math.ceil(ordQty/(cutQty*eaQty)) * cutQty;
							let pressQty = Math.ceil((printPressQty + extraQty)/cutQty + extraPackQty);
	
							let remainQty = parseInt(data) - parseInt(pressQty);
	
							let returnR;
							if(parseInt(remainQty) < 0){
								returnR = "-" + parseInt(-1*remainQty/500) + 'R' + parseInt(-1*remainQty%500); 
							} else {
								returnR = parseInt(remainQty/500) + 'R' + parseInt(remainQty%500); 
							}
							
							return returnR;
						} else {
							return '0';
						}
					//}
				}
			},
			{ data: 'extraPackQty', className : 'text-end align-middle', name: 'purchaseOrdQtyInput',//주문량이었는데 추가여분수량으로 변경됨
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<input type="text" name="ordQty" class="form-control text-end" onkeyup="numberFormat(this, \'int\')" value="'+addCommas(parseFloat(data))+'" disabled>';
					} else {
						return '<input type="text" name="ordQty" class="form-control text-end" onkeyup="numberFormat(this, \'int\')" value="0" disabled>';
					}
				}
			}, 
			{ data: 'extraPackQty', className : 'text-end align-middle', name : 'extraPackQtyR',//주문량 R 이었는데 주문량이 바뀌니 애도 바뀜
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						//let R = parseInt( parseInt(data) / 500); // R로 환산
						//let finalPurchaseQty = R + "R" + ( parseInt(data) % 500);

						let returnR;
						if(parseInt(data) < 0){
							returnR = "-" + parseInt(-1*data/500) + 'R' + parseInt(-1*data%500); 
						} else {
							returnR = parseInt(data/500) + 'R' + parseInt(data%500); 
						}
						
						return returnR;
					} else {
						return '0R0';
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
						//let R = parseInt( parseInt(data) / 500); // R로 환산
						//let finalPurchaseQty = R + "R" + ( parseInt(data) % 500);

						let returnR;
						if(parseInt(data) < 0){
							returnR = "-" + parseInt(-1*data/500) + 'R' + parseInt(-1*data%500); 
						} else {
							returnR = parseInt(data/500) + 'R' + parseInt(data%500); 
						}
						
						return returnR;
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
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let middlecolT_height = parseFloat($('#leftcol').css('height'));
			let theadHeight = parseFloat($('#bizOrderTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#bizOrderTable_wrapper').find('.dataTables_scrollBody').css('height',(middlecolT_height - theadHeight - 80)+'px');
			
			$('#bizOrderTable_filter').addClass('d-none');
			// 통합검색
			$('#searchAll').off('keyup',function() {});
			$('#searchAll').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			});
			$('.bootstrapToggle').bootstrapToggle();

			let data = api.data();
			let node = api.rows().nodes();
			if(data.length > 0){
				$(node).each(function(index, item) {
					let selectData = bizOrderTable.row(item).data();
					if( bizOrderTable.row(item).data().printYn == 'Y' || ( selectData.mergeIdx != '' && selectData.mergeIdx != null && selectData.mergeIdx != '0') ) {
						$(bizOrderTable.row(item).node()).find('.bootstrapToggle').bootstrapToggle('disable');
						$(bizOrderTable.row(item).node()).addClass('notEdit');
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
		bizOrderTable.ajax.reload(function() {}, false);
		$('#btnSave').attr('disabled',true);
		$('#btnEdit').attr('disabled',false);
		setTimeout(function() {
			$('#my-spinner').hide();
		}, 100)
	});

	// 수주목록 선택
	$('#bizOrderTable tbody').on('click', 'tr', function() {
		let data = bizOrderTable.row(this).data();
		let idx = data.idx;
		/* if(WMCheck('ADM')) {
			setWM('ADM', 'idx', idx);
			return false;
		} */
		
		bizOrdDtlIdxVal = data.idx;
		ordQtyVal = data.ordQty;
		itemIdxVal = data.itemIdx;

		/* purchaseOrderAdmTable.clear().draw();
		purchaseOrderAdmTable.ajax.reload(); */
		
		/* $('#btnNew').attr('disabled', false); // 신규 버튼
		$('#btnSave').attr('disabled', true); // 저장 버튼
		//$('#btnEdit').attr('disabled', false); // 수정 버튼
		$('#btnDel').attr('disabled', false); // 삭제 버튼
		$('#btnCancel').attr('disabled', true); // 취소 버튼

		$('#purchaseOrderAdmTable_wrapper').find('.filters th').each(function(index, item) {
			$(item).find('input').attr('disabled', false);// 검색 필터 enable
		}); */
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
	/* $('#purchaseOrderAdmTable thead tr').clone(true).addClass('filters').appendTo('#purchaseOrderAdmTable thead'); // filter 생성
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
						let cuttingSize = Math.ceil(ordQty/(cutQty*eaQty));
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
						let printPressQty = Math.ceil(ordQty/eaQty);
						let pressQty = Math.ceil((printPressQty + extraQty + extraPackQty)/cutQty);
						
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
						let printPressQty = Math.ceil(ordQty/eaQty);
						
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
		/*],
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
 */
	// 발주확정
	$(document).off('change','.confirmToggle');
	$(document).on('change','.confirmToggle', function() {
		let data = bizOrderTable.row('.selected').data();

		if(data.confirmDesign != 'Y') { // 디자인컨펌이 되어야 추가 가능
			toastr.warning('해당 수주건이 디자인컨펌이 확인되지 않았습니다.');
			bizOrderTable.row('.selected').deselect()
			bizOrderTable.ajax.reload(function(){},false);
			
			return false;
		}
		
		let idx = $(this).data('idx');
		let check = $(this).prop('checked');

		if(idx == null){
			toastr.warning('해당 수주건의 발주.');
			bizOrderTable.ajax.reload(function(){}, false);
			return false;
		}
		
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
					bizOrderTable.row('.selected').deselect()
					bizOrderTable.ajax.reload(function(){}, false);
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
		//$('#btnEdit').attr('disabled', false); // 수정 버튼

		$('#matrlSelectModal').modal('show'); 
	});
	$('#matrlSelectModal').on('shown.bs.modal', function() {
		matrlModalSelectTable.ajax.reload(function() {
			matrlModalSelectTable.select.style('multi');
			matrlModalSelectTable.select.toggleable(true);
		}, false);
	});

	
	// 수량 계산
	$(document).on('keyup','input[name=ordQty]', function(e) {
		let tr = $(e.target).parent().parent();
		let td = $(tr).find('td');
		let ordQty = removeCommas($(td).eq(bizOrderTable.column('purchaseOrdQtyInput:name').index()).find('input[name=ordQty]').val());
		let ordQtyVal = parseInt(ordQty/500) + 'R' + parseInt(ordQty%500);
		
		$(td).eq(bizOrderTable.column('extraPackQtyR:name').index()).html((ordQtyVal));

		let data = bizOrderTable.row(tr).data();

		let purchaseOrdQty = parseFloat(data.purchaseOrdQty); // 주문수량(제품)
		let cutQty = parseFloat(data.cutQty); // 절수
		let eaQty = parseFloat(data.eaQty); // 개수
		let extraQty = parseFloat(data.extraQty); // 여유분
		let extraPackQty = parseFloat(ordQty); // 포장단위여분
		//let printPressQty = Math.ceil(purchaseOrdQty/eaQty);
		let printPressQty = Math.ceil(purchaseOrdQty/(cutQty*eaQty)) * cutQty;
		let pressQty = Math.ceil((printPressQty + extraQty)/cutQty + extraPackQty);
		let R = parseInt(pressQty / 500); // R로 환산
		let finalPurchaseQty = R + "R" + (pressQty % 500);
		

		$(td).eq(bizOrderTable.column('purchaseOrdQty:name').index()).html((addCommas(parseFloat(pressQty))));
		$(td).eq(bizOrderTable.column('purchaseOrdQtyR:name').index()).html(finalPurchaseQty);

		bizOrderTable.columns.adjust();
		
	}); 
	/* $(document).on('keyup','.editNode input', function(e) {
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

		let cuttingSize = Math.ceil(ordQty/(cutQty*eaQty)); // cuttingSize
		let printPressQty = Math.ceil(ordQty/eaQty); // 정매인쇄통수
		let pressQty = Math.ceil((printPressQty + extraQty + extraPackQty)/cutQty); // 통수
		let R = parseInt(cuttingSize / 500); // R로 환산
		let purchaseQty = R + "R" + (cuttingSize % 500); // 발주량 R
		//let finalPurchaseQty = R + "R" + (pressQty % 500); // 최종발주량
		/* 2022.11.10 통수/500해서 R앞에 붙도록 변경 */
		/*let finalPurchaseQty = parseInt(pressQty/500) + "R" + (pressQty % 500); // 최종발주량

		if(cutQty != 0 && eaQty != 0) {
			$(td).eq(purchaseOrderAdmTable.column('cuttingSize:name').index()).html(addCommas(parseInt(cuttingSize)));
			$(td).eq(purchaseOrderAdmTable.column('printPressQty:name').index()).html(addCommas(parseInt(printPressQty)));
			$(td).eq(purchaseOrderAdmTable.column('pressQty:name').index()).html(addCommas(parseInt(pressQty)));
			$(td).eq(purchaseOrderAdmTable.column('purchaseQty:name').index()).html(purchaseQty);
			$(td).eq(purchaseOrderAdmTable.column('finalPurchaseQty:name').index()).html(finalPurchaseQty);
		}
	}); */

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
				$('#matrlModalSelectTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	matrlModalSelectTable.on('column-reorder', function( e, settings, details ) {
		let api = matrlModalSelectTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#matrlModalSelectTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	$('#btnMatrlSelectReSearch').on('click',function(){
		matrlModalSelectTable.ajax.reload(function(){},false);
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
		$('#bizOrderTable tbody').find('tr').each(function(index, item) {
			let td = $(item).find('td');
			let data = bizOrderTable.row($(item)).data();
			let idx = data.purchaseIdx;

			let ordQty 			= parseFloat(data.purchaseOrdQty); // 주문수량(제품)
			let cutQty 		 	= parseFloat(data.cutQty); // 절수
			let eaQty 		 	= parseFloat(data.eaQty); // 개수
			let extraQty 	 	= parseFloat(data.extraQty); // 여유분
			let extraPackQty 	= parseFloat(data.extraPackQty); // 포장단위여분

			//let printPressQty = Math.ceil(ordQty/eaQty);
			let printPressQty = Math.ceil(ordQty/(cutQty*eaQty)) * cutQty;
			let pressQty = Math.ceil((printPressQty + extraQty + extraPackQty)/cutQty); //주문량
			pressQty = isNaN(pressQty) ? 0 : pressQty; 
			
			let purchaseOrdQtyInput = $(td).eq(bizOrderTable.column('purchaseOrdQtyInput:name').index()).find('input').val();
			purchaseOrdQtyInput = purchaseOrdQtyInput == undefined ? '0' : purchaseOrdQtyInput;
			
			let obj = new Object();
			obj.idx = idx;
			obj.purchaseOrdQty = parseFloat(removeCommas(purchaseOrdQtyInput));
			obj.beforeordQty = parseFloat(data.extraPackQty);
			obj.cutQty = cutQty;
			obj.eaQty= eaQty;
			array.push(obj);
		});

		//원본데이터
		let admTableData = [];
		for(var i=0;i<bizOrderTable.data().count();i++) {
			let obj = {};

			let data = bizOrderTable.row(i).data();
			
			let ordQty 			= parseFloat(data.purchaseOrdQty); // 주문수량(제품)
			let cutQty 		 	= parseFloat(data.cutQty); // 절수
			let eaQty 		 	= parseFloat(data.eaQty); // 개수
			let extraQty 	 	= parseFloat(data.extraQty); // 여유분
			let extraPackQty 	= parseFloat(data.extraPackQty); // 포장단위여분
			
			//let printPressQty = Math.ceil(ordQty/eaQty);
			let printPressQty = Math.ceil(ordQty/(cutQty*eaQty)) * cutQty;
			let pressQty = Math.ceil((printPressQty + extraQty + extraPackQty)/cutQty); //주문량
			pressQty = isNaN(pressQty) ? 0 : pressQty; 
			
			
			obj.idx = data.purchaseIdx;
			obj.purchaseOrdQty = parseFloat(data.extraPackQty);
			obj.beforeordQty = parseFloat(data.extraPackQty);
			obj.cutQty = cutQty;
			obj.eaQty= eaQty;
			admTableData.push(obj);
		}
		
		array = _.differenceWith(array, admTableData, _.isEqual);

		console.log(array);


		$.ajax({
			url: '<c:url value="/pm/purchaseOrderQtyAdmUpd"/>',
            type: 'POST',
            data: {
                'jsonArray'	:	JSON.stringify(array)
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					toastr.success('저장되었습니다.<br>생산이 진행된 발주는 수정되지<br>않았습니다.');
        
					WM_action_OFF('ADM');
        
					bizOrderTable.clear().draw();
					bizOrderTable.ajax.reload(function() {
					},false);
        
					$('#btnSave').attr('disabled', true); // 저장 버튼
					$('#btnEdit').attr('disabled', false); // 수정 버튼
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
		$('#my-spinner').show();
		bizOrderTable.ajax.reload(function(){
			WM_action_ON('ADM','workingWarningModal');
	
			$('#btnSave').attr('disabled', false); 
			$('#btnEdit').attr('disabled', true); 
			$('#bizOrderTable tbody tr').find('input[name=ordQty]').attr('disabled',false);
			
			$('#bizOrderTable tbody tr').each(function(index,item){
				if(!$(item).hasClass('notEdit')){
					let data = bizOrderTable.row(index).data();
					let node = bizOrderTable.row(index).node();

					if(data.confirmYn == 'Y'){
						$(node).find('td').find('input[name=ordQty]').attr('disabled',true);
					} 
					//let jsonData = JSON.parse(data.workOrdPrcssJson);
					//let filterList = _.filter(jsonData, (v => v.progressStatus == 'WI' || v.progressStatus == 'WC'));
					
					//if(filterList.length == 0){
					//	$(node).find('td').find('input[name=ordQty]').attr('disabled',false);
					//} else {
					//	$(node).find('td').find('input[name=ordQty]').attr('disabled',true);
					//}
				} else {
					let node = bizOrderTable.row(index).node();
					$(node).find('td').find('input[name=ordQty]').attr('disabled',true);
				}
			});

			$('#my-spinner').hide();
		},false);
		
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
						purchaseOrderAdmTable.ajax.reload(function(){},false);
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

			purchaseOrderAdmTable.ajax.reload(function(){},false);
			purchaseOrderAdmTable.colReorder.enable();

			$('#purchaseOrderAdmTable_wrapper').find('.filters th').each(function(index, item) {
				$(item).find('input').attr('disabled', false); // 검색 필터 disabled
			});
			
			$('#btnNew').attr('disabled', false); // 신규 버튼
			$('#btnSave').attr('disabled', true); // 저장 버튼
			//$('#btnEdit').attr('disabled', false); // 수정 버튼
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
	$('#btnDealCorpModalSearch').on('click',function(){
		dealCorpModalTable.ajax.reload(function() {},false);
	});
	
	//발주처 돋보기버튼
	$(document).on('click','.dealCorpModalBtn',function(){
		matrlIdxVal = $(this).data('matrlidx'); //자재 식별자
		if(matrlIdxVal == '' || matrlIdxVal == null || matrlIdxVal == "null"){
			matrlIdxVal = 0;
		} 
		$('#dealCorpModal').modal('show');
		setTimeout(function() {
			dealCorpModalTable.ajax.reload(function() {},false);
		}, 200);	
	});

	// 발주처 조회
	$('#btnDealCorpSelectSearch').on('click',function(){
		dealCorpModalTable.ajax.reload(function(){}, false);
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
