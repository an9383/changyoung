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
																		  grid-template-columns: 6.5fr 4px 4fr;">
	<div id="leftcol">
		<div class="container-fluid h-100" style="padding: 5px;">
			<div class="row" id="leftHeader" style="padding-bottom: 5px;">
				<div class="d-flex align-items-center d-flex">
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">발주일자</label>
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
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">조회대상</label>
					<select class="form-select w-auto h-100 me-3" id="searchTarget" style="min-width: 70px;">
						<option value="" >전체</option>
						<option value="N" selected>미입고</option>
					</select>
					<input type="text" class="form-control w-auto h-100 me-1" id="searchAll" placeholder="통합검색" >
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end">
					<div class="btn-group" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnSearch"><i class="fa-regular fa-clipboard"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnSave" disabled><i class="fa-regular fa-floppy-disk"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnEdit" ><i class="fa-regular fa-pen-to-square"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnCancel" disabled><i class="fa-solid fa-xmark"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnOpen"><i class="fa-solid fa-caret-left"></i></button>
					</div>
				</div>
			</div>
			<div class="row">
				<table class="table table-bordered p-0 m-0" id="purchaseOrderAdmTable">
					<thead class="table-light">
						<tr>
							<th class="text-center" style="padding: 0px;">
								<input class="form-check-input" type="checkbox" id="checkAll" style="margin: 0px; width: 25px; height: 25px;">
							</th>
							<th class="text-center align-middle">발주상태</th>
							<th class="text-center align-middle">발주구분</th>
							<th class="text-center align-middle">매입처</th>
							<th class="text-center align-middle">수주번호</th>
							<th class="text-center align-middle">고객사</th>
							<th class="text-center align-middle" style="min-width:200px;">제품명</th>
							<th class="text-center align-middle" style="min-width:200px;">재질</th>
							<th class="text-center align-middle" style="min-width:100px;">현재고</th>
							<th class="text-center align-middle" style="min-width:100px;">가용재고</th>
							<th class="text-center align-middle">절수</th>
							<th class="text-center align-middle">인쇄기</th>
							<th class="text-center align-middle">목표요구일</th>
							
							
							<th class="text-center align-middle">입고예정일</th>
							<!-- <th class="text-center align-middle">목표요구일</th> -->
							<th class="text-center align-middle">입고일</th>
							<th class="text-center align-middle">여분포함통수</th>
							<th class="text-center align-middle" style="min-width:50px;">발주량</th>
							<!-- <th class="text-center align-middle" style="min-width:50px;">®</th> -->
							<th class="text-center align-middle" style="min-width:50px;">입고량</th>
							<!-- <th class="text-center align-middle" style="min-width:50px;">®</th> -->
							<th class="text-center align-middle" style="min-width:50px;">잔량</th>
							<!-- <th class="text-center align-middle" style="min-width:50px;">®</th> -->
							<th class="text-center align-middle">발주번호</th>
							<th class="text-center align-middle" style="min-width:50px;">출력번호</th>
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
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;"
								id="btnGmail" onclick="window.open('about:blank').location.href='https://mail.google.com/mail/u/0/?tab=rm#inbox?compose=new'">
							<img class="w-auto" src="<c:url value='/resources/assets/images/gmail_icon.jpg?ver=1'/>" style="height: 14px; margin-bottom: 3px;">
						</button>
						<!-- <button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnDownload"><i class="fa-solid fa-download"></i></button> -->
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnPrint"><i class="fa-solid fa-print"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnClose"><i class="fa-solid fa-caret-right"></i></button>
					</div>
				</div>
			</div>
			<div class="row">
				<div style="width: 100%;">
				  	<div class="nav nav-tabs" id="nav-tab">
						<button class="nav-link active" id="tab1Nav" data-bs-toggle="tab" data-bs-target="#tab1">발주서</button>
				  	</div>
					<div class="tab-content" id="nav-tabContent">
						<div class="tab-pane fade show active" id="tab1">
							<div class="row" style="padding: 5px;">
								<table id="purchasePaperTable" class="table table-bordered m-0 d-none" style="border:1px solid #ffffff;">
									<colgroup>
										<col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%">
										<col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%">
										<col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%">
										<col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%">
										<col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%">
									</colgroup>
									<tr>
										<td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n">
										<td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n">
										<td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n">
										<td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n">
										<td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n">
									</tr>
									<tr>
										<td colspan='12' class="bd-n"></td>
										<td colspan='6' class="fs-20 text-center bt-n bl-n br-n">발&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;주&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;서</td>
										<td colspan='12' class="bd-n"></td>
									</tr>
									<tr>
										<td colspan='30' class="fs-15 text-center bd-n">ad.) 수원시 권선구 산업로 156번길 88-39 / T)031.292.6553 / F)031.292.6507</td>
									</tr>
									<tr>
										<td colspan='30' class="bd-n h-20"></td>
									</tr>
									<tr>
										<td colspan='3' class="bd-n"></td>
										<td colspan='27' class="fs-15 text-start bd-n" id="purchasePrintDate">일자 : </td>
									</tr>
									<tr>
										<td colspan='30' class="bd-n h-20"></td>
									</tr>
									<tr>
										<td colspan='30' class="fs-20 text-center bl-n br-n">비고란에 있는 번호, 입고날짜 - 꼬리표에 기재 해 주세요~!</td>
									</tr>
									<tr id="trAppendTarget">
										<td colspan='7' class="bg-gray fs-10 text-center align-middle not-left theadFirstCol">재질</td>
										<td colspan='2' class="bg-gray fs-10 text-center align-middle not-left theadNotFisrtCol">납기일</td>
										<td colspan='4' class="bg-gray fs-10 text-center align-middle not-left theadNotFisrtCol">지업사<br>발주량</td>
										<td colspan='17' class="bg-gray fs-10 text-center align-middle not-left theadNotFisrtCol">비고</td>
									</tr>
									<tr>
										<td colspan='30' class="fs-15 text-center bd-n">*모든 원지는 FSC인증 종이 입고 바랍니다.</td>
									</tr>
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
			let rightcolMinWidth = 700; // rightcol 최소사이즈
	
			let rightColWidth = isDragging ? page.clientWidth - parseInt(Math.max(leftcolMinWidth + 20, event.clientX)) : rightcol.clientWidth;

			//console.log(Math.max(rightColWidth, rightcolMinWidth));
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

	let monthAdjustList = getCommonCode('시스템', '026'); //날짜조정
	monthAdjustList = _.sortBy(monthAdjustList, v=>parseInt(v.commonCd));
	selectBoxAppend(monthAdjustList, 'monthAdjust', '', '2'); //날짜조정s
	
	let paperLineCountList = getCommonCode('시스템', '019'); //발주서라인수
	let paperLineCount = parseInt(paperLineCountList[0].commonNm);
	let selectPeriod = parseInt(getCommonCode('시스템', '040')[0].commonCd); //기본조회기간 일
	$('#startDate').val(moment().subtract('d',selectPeriod).format('YYYY-MM-DD'));
	$('#endDate').val(moment().format('YYYY-MM-DD'));
	
	// 사용자정보 목록조회
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
		colReorder: false,
		select: {
            style: 'single',
            toggleable: false,
            items: 'row',
            info: false
        },
        ajax : {
			url : '<c:url value="/pm/purchaseOrderAdmLst"/>',
			type : 'POST',
			data : {
				startDate : function() { return moment($('#startDate').val()).format('YYYYMMDD'); },
				endDate : function() { return moment($('#endDate').val()).format('YYYYMMDD'); },
				searchTarget : function() { return $('#searchTarget').val(); },
			},
		},
        rowId: 'idx',
		columns : [
			{ data:'groupData', className : 'text-center align-middle', name: 'checkbox',
				render: function(data, type, row, meta) {
					let html = '<input class="form-check-input" type="checkbox" name="purchasePrint" style="margin: 0px; width: 25px; height: 25px;">';
					if(row['purchasePrintNo'] != null && row['purchasePrintNo'] != ''){
						html += '<span name="purchasePrint" class="d-none" data-idx="'+row['purchasePrintNo']+'">'+row['purchasePrintNo']+'</span>';
					} else {
						html += '<span name="purchasePrint" class="d-none" data-idx="'+row['idx']+'">noPrint</span>';
					}
					return html;
				}
			},
			{ className : 'text-center align-middle', //발주상태
				render : function(data, type, row, meta) {
					if(row['purchasePrintNo'] == null || row['purchasePrintNo'] == '') {
						return '<div style="white-space:nowrap;">발주 대기</div>';
					} else {
						let ordQty = parseInt(row['purchaseOrdQty']); // 주문수량(제품)
						let cutQty = parseInt(row['cutQty']); // 절수
						let eaQty = parseInt(row['eaQty']); // 개수
						let extraQty = parseInt(row['extraQty']); // 여유분
						let extraPackQty = parseInt(row['extraPackQty']); // 포장단위여분
						let inQty = parseInt(row['inQty'] != null && row['inQty'] != '' ? row['inQty'] : 0); //입고수량
						
						//let printPressQty = Math.ceil(ordQty/eaQty);
						let printPressQty = Math.ceil(ordQty/(cutQty*eaQty)) * cutQty;
						let pressQty = Math.ceil((printPressQty + extraQty)/cutQty + extraPackQty); //발주수량
						if(pressQty > inQty){
							return '<div style="white-space:nowrap;">입고 대기</div>';
						} else {
							return '<div style="white-space:nowrap;">입고 완료</div>';
						}						 
					}
				}
			},
			{ className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(row['bizOrdDtlIdx'] == null || row['bizOrdDtlIdx'] == '' || row['bizOrdDtlIdx'] == '0') {
						return '<div style="white-space:nowrap;">개별발주</div>';
					} else {
						return '<div style="white-space:nowrap;">수주별발주</div>';
					}
				}
			},
			{ data: 'dealCorpNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return '<div style="white-space:nowrap;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(row['bizOrdDtlIdx'] == null || row['bizOrdDtlIdx'] == '' || row['bizOrdDtlIdx'] == '0') {
						return '<div style="white-space:nowrap;">-</div>';
					} else {
						if(row['bizOrdDtlNo'] != null && row['bizOrdDtlNo'] != '' ){
							return '<div style="white-space:nowrap;">'+row['bizOrdDtlNo']+'</div>';
						} else	{
							return '<div style="white-space:nowrap;">-</div>';
						}
					}
				}
			},
			{ data: 'bizDealCorpNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return '<div style="white-space:nowrap;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ data: 'itemNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						//return '<div style="white-space:nowrap;">'+data+'</div>';
						return data;
					} else {
						return '-';
					}
				}
			},
			{ data: 'paperType', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return '<div style="white-space:nowrap;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ data: 'spQty', className : 'text-center align-middle', //현재고
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						let returnR = '';
						if(parseInt(data) < 0){
							returnR = "-" + parseInt(-1*data/500) + "R" + parseInt(-1*data%500); 
						} else {
							returnR = parseInt(data/500) + "R" + parseInt(data%500); 
						}
						
						let html = '';
						html += '<div class="row">';
						html += '	<div class="text-end align-middle" style="white-space:nowrap;width:50%;">'+returnR+'</div>';
						html += '<div class="text-end align-middle" style="white-space:nowrap;width:50%;">'+ addCommas(parseInt(data)) + '</div>';
						html += '</div>';

						return html;
					} else {
						return '-';
					}
				}
			},
			{ data: 'asQty', className : 'text-center align-middle', //현재고
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						let returnR = '';
						if(parseInt(data) < 0){
							returnR = "-" + parseInt(-1*data/500) + "R" + parseInt(-1*data%500); 
						} else {
							returnR = parseInt(data/500) + "R" + parseInt(data%500); 
						}
						
						let html = '';
						html += '<div class="row">';
						html += '	<div class="text-end align-middle" style="white-space:nowrap;width:50%;">'+returnR+'</div>';
						html += '<div class="text-end align-middle" style="white-space:nowrap;width:50%;">'+ addCommas(parseInt(data)) + '</div>';
						html += '</div>';

						return html;
					} else {
						return '-';
					}
				}
			},
			{ data: 'cutQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return '<div style="white-space:nowrap;">'+parseInt(data)+'</div>';
					} else {
						return '-';
					}
				}
			},//절수
			{ data: 'etc1Nm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return '<div style="white-space:nowrap;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},//인쇄기
			{ data:'workEndReqDate', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space:nowrap;">'+moment(data).format('YYYY-MM-DD')+'</div>';
					} else {
						return '-';
					}
				}
			}, //목표요구일
			{ data:'purchaseInDueDate', className : 'text-center align-middle editNode',name:'purchaseInDueDate',//입고예정일
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space:nowrap;">'+moment(data).format('YYYY-MM-DD')+'</div>';
					} else {
						return '-';
					}
				}
			},
			/* { data:'workEndReqDate', className : 'text-center align-middle',//목표요구일
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space:nowrap;">'+moment(data).format('YYYY-MM-DD')+'</div>';
					} else {
						return '-';
					}
				}
			}, */
			{ data:'inDate', className : 'text-center align-middle',//입고일
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space:nowrap;">'+moment(data).format('YYYY-MM-DD')+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ className : 'text-end align-middle', name: 'printPressAndExtraQty', // 정매인쇄통수 + 여분 + 포장단위여분(여분포함통수)
				render : function(data, type, row, meta) {
					let ordQty = parseInt(row['purchaseOrdQty']); // 주문수량(제품)
					let cutQty = parseInt(row['cutQty']); // 절수
					let eaQty = parseInt(row['eaQty']); // 개수
					let extraQty = parseInt(row['extraQty']); // 여유분
					let extraPackQty = parseInt(row['extraPackQty']); // 포장단위여분

					if(cutQty == 0 || eaQty == 0) {
						return '0';
					} else {
						//let printPressQty = Math.ceil(ordQty/eaQty);
						let printPressQty = Math.ceil(ordQty/(cutQty*eaQty)) * cutQty;
						let printPressAndExtraQty = printPressQty + extraQty + (extraPackQty*cutQty);
						
						return addCommas(printPressAndExtraQty);
					}
				}
			},
			/* { data: 'purchaseOrdQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if(row['etc2'] == '02'){
						//매입단위가 "통"인 경우 수주수량 == 발주수량임
						let ordQty = parseInt(row['purchaseOrdQty']); // 주문수량(제품)
						return addCommas(ordQty);
					} else {
						//매입단위가 "연" OR 매입단위 등록안한 경우 -> 계산식 적용해야함
						let ordQty = parseInt(row['purchaseOrdQty']); // 주문수량(제품)
						let cutQty = parseInt(row['cutQty']); // 절수
						let eaQty = parseInt(row['eaQty']); // 개수
						let extraQty = parseInt(row['extraQty']); // 여유분
						let extraPackQty = parseInt(row['extraPackQty']); // 포장단위여분
						
						if(cutQty == 0 || eaQty == 0) {
							return '0';
						} else {
							//let printPressQty = Math.ceil(ordQty/eaQty);
							let printPressQty = Math.ceil(ordQty/(cutQty*eaQty)) * cutQty;
							let pressQty = Math.ceil((printPressQty + extraQty)/cutQty + extraPackQty);
							
							let R = parseInt(pressQty / 500); // R로 환산
							let finalPurchaseQty = R + "R" + (pressQty % 500);
							
							return addCommas(pressQty);
						}
					}
					
				}
			}, */
			{ data: 'purchaseOrdQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					//if(row['etc2'] == '02'){
						//매입단위가 "통"인 경우 수주수량 == 발주수량임
					//	let ordQty = parseInt(row['purchaseOrdQty']); // 주문수량(제품)
					//	let R = parseInt(ordQty / 500); // R로 환산
					//	let finalPurchaseQty = R + "R" + (ordQty % 500);
						
					//	return finalPurchaseQty;
					//} else {
						//매입단위가 "연" OR 매입단위 등록안한 경우 -> 계산식 적용해야함
						let ordQty = parseInt(row['purchaseOrdQty']); // 주문수량(제품)
						let cutQty = parseInt(row['cutQty']); // 절수
						let eaQty = parseInt(row['eaQty']); // 개수
						let extraQty = parseInt(row['extraQty']); // 여유분
						let extraPackQty = parseInt(row['extraPackQty']); // 포장단위여분
						
						if(cutQty == 0 || eaQty == 0) {
							return '0';
						} else {
							//let printPressQty = Math.ceil(ordQty/eaQty);
							let printPressQty = Math.ceil(ordQty/(cutQty*eaQty)) * cutQty;
							let pressQty = Math.ceil((printPressQty + extraQty)/cutQty + extraPackQty);
							
							let R = parseInt(pressQty / 500); // R로 환산
							let finalPurchaseQty = R + "R" + (pressQty % 500);
							
							return finalPurchaseQty;
						}
					//}
				}
			},
			/* { data:'inQty', className : 'text-end align-middle',//입고량
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space:nowrap;">'+addCommas(parseFloat(data))+'</div>';
					} else {
						return '0';
					}
				}
			}, */
			{ data:'inQty', className : 'text-end align-middle',//입고량 R
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						let returnValue = parseInt(data/500) + 'R' + parseInt(data%500);
						return '<div style="white-space:nowrap;">'+returnValue+'</div>';
					} else {
						return '0R0';
					}
				}
			},
			/* { data: 'purchaseOrdQty', className : 'text-end align-middle', //잔량(발주량-입고량) 나중에 입고량 빼줘야함
				render : function(data, type, row, meta) {
					let ordQty = parseInt(row['purchaseOrdQty']); // 주문수량(제품)
					let cutQty = parseInt(row['cutQty']); // 절수
					let eaQty = parseInt(row['eaQty']); // 개수
					let extraQty = parseInt(row['extraQty']); // 여유분
					let extraPackQty = parseInt(row['extraPackQty']); // 포장단위여분
					
					if(cutQty == 0 || eaQty == 0) {
						return '0R0';
					} else {
						//let printPressQty = Math.ceil(ordQty/eaQty);
						let printPressQty = Math.ceil(ordQty/(cutQty*eaQty)) * cutQty;
						let pressQty = Math.ceil((printPressQty + extraQty)/cutQty + extraPackQty);
						pressQty -= parseInt(row['inQty'] != null && row['inQty'] != '' ? row['inQty'] : 0);

						return addCommas(pressQty);
	
					}
				}
			}, */
			{ data: 'purchaseOrdQty', className : 'text-end align-middle', //잔량(발주량-입고량) 나중에 입고량 빼줘야함
				render : function(data, type, row, meta) {
					let ordQty = parseInt(row['purchaseOrdQty']); // 주문수량(제품)
					let cutQty = parseInt(row['cutQty']); // 절수
					let eaQty = parseInt(row['eaQty']); // 개수
					let extraQty = parseInt(row['extraQty']); // 여유분
					let extraPackQty = parseInt(row['extraPackQty']); // 포장단위여분
					
					if(cutQty == 0 || eaQty == 0) {
						return '0R0';
					} else {
						//let printPressQty = Math.ceil(ordQty/eaQty);
						let printPressQty = Math.ceil(ordQty/(cutQty*eaQty)) * cutQty;
						let pressQty = Math.ceil((printPressQty + extraQty)/cutQty + extraPackQty);
						pressQty -= parseInt(row['inQty'] != null && row['inQty'] != '' ? row['inQty'] : 0);
						if(pressQty > 0){
							let R = parseInt(pressQty / 500); // R로 환산
							let finalPurchaseQty = R + "R" + (pressQty % 500);
							
							return finalPurchaseQty;
						} else {
							return '0R0';
						}
					}
				}
			},
			{ data: 'purchaseOrdNo', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return '<div style="white-space:nowrap;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ data: 'purchasePrintNo', className : 'text-center align-middle editNode',name:'purchasePrintNo', //발주서출력번호
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space:nowrap;">'+data+'</div>';
					} else {
						return '-';
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
			{ extend: 'colvis',	text: 'Select Col',	},
		],
		/* rowsGroup: [
			'checkbox:name'
	 	], */
		order : [],
		drawCallback: function() {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#purchaseOrderAdmTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 79)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAll').off('keyup',function() {});
			$('#searchAll').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			});

			//입고가 다된경우 회색으로 표시
			for(var i=0;i<api.data().count();i++) {
				let data = api.row(i).data();
				let node = api.row(i).node();
				
				let ordQty = parseInt(data.purchaseOrdQty); // 주문수량(제품)
				let cutQty = parseInt(data.cutQty); // 절수
				let eaQty = parseInt(data.eaQty); // 개수
				let extraQty = parseInt(data.extraQty); // 여유분
				let extraPackQty = parseInt(data.extraPackQty); // 포장단위여분
				
				//let printPressQty = Math.ceil(ordQty/eaQty);
				let printPressQty = Math.ceil(ordQty/(cutQty*eaQty)) * cutQty;
				let pressQty = Math.ceil((printPressQty + extraQty)/cutQty + extraPackQty);
				
				pressQty -= parseInt(data.inQty != null && data.inQty != '' ? data.inQty : 0);
				if(pressQty <= 0){
					$(node).addClass('bg-secondary bg-gradient bg-opacity-10');
				} 
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
				if(colIdx > 0){
					$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
					$(cell).css('padding','2px');
				} else {
					$(cell).html('');
					$(cell).css('padding','2px');
				}

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#purchaseOrderAdmTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
			
			$('#btnEdit').trigger('click');
		},
	});

	// 모든 체크박스 선택
	$('#checkAll').on('click',function(){
		if($('#checkAll').prop("checked")) {
			//$('input[name=purchasePrint]').prop("checked",true);
			$('input[name=purchasePrint]').prop("checked",false);
			$('input[name=purchasePrint]').each(function(index,item){
				if(purchaseOrderAdmTable.row($(this).parent().parent()).data().purchasePrintNo == null || purchaseOrderAdmTable.row($(this).parent().parent()).data().purchasePrintNo == ''){
					$(this).prop("checked",true);
					$(this).trigger('change');
				}
			});
			
		} else{
			$('input[name=purchasePrint]').prop("checked",false);
			$('input[name=purchasePrint]').eq(0).trigger('change');
		}
		
		
	});

	// 모든 체크박스 체크/해제 되도록
	$(document).on('change','input:checkbox[name=purchasePrint]', function(){
		if( $('input:checkbox[name=purchasePrint]').length == $('input:checkbox[name=purchasePrint]:checked').length ){ //전체 체크박스 수와 체크된 박스의 수가 같을 때 -> 전체체크박스 체크 , 아닐 경우 해제
			$('#checkAll').prop("checked",true);
		} else{
			$('#checkAll').prop("checked",false);
		}
 	});

	let tempList = [];
	// 발주항목 체크
	$(document).on('change','input[name=purchasePrint]', function() {
		let checkArray = [];
		
		$('.dtlList').find('.not-edit').html('&nbsp;');
		$('.dtlList').find('.edit').find('input').val('');
		let dataList = [];
		let status = true;
		for(var i=0;i<purchaseOrderAdmTable.data().count();i++) {
			let node = purchaseOrderAdmTable.row(i).node();
			let data = purchaseOrderAdmTable.row(i).data();

			let check = false;
			
			if(status){
				//체크할땐 span태그의 data-idx값으로 체크하고
				//배열에 값을 넣을땐 span의 text로 값을 넣어줌 -> 발주서출력번호가 없는 경우는 noPrint라는 값으로 통일하기 위해서 text로 넣음
				if( $(node).find('td').eq(0).find('input').prop('checked') || checkArray.includes($(node).find('span[name=purchasePrint]').data('idx')) ){
					check = true;
				}
				if(check) {
					let checkFin = true;
					//체크할때 유니크한 배열값으로 체크
					checkArray.push($(node).find('span[name=purchasePrint]').text());
					let set = new Set(checkArray);
					let uniqueArr = [...set];
					/* if(uniqueArr.length > 1){
						toastr.warning('이미 출력된 발주서입니다.');
						status=false;
						checkFin=false;
						dataList = _.cloneDeep(tempList);
						$(this).prop("checked",false);
						// 모든 체크박스 체크/해제 되도록
						$(document).on('change','input:checkbox[name=purchasePrint]', function(){
							if( $('input:checkbox[name=purchasePrint]').length == $('input:checkbox[name=purchasePrint]:checked').length ){ //전체 체크박스 수와 체크된 박스의 수가 같을 때 -> 전체체크박스 체크 , 아닐 경우 해제
								$('#checkAll').prop("checked",true);
							} else{
								$('#checkAll').prop("checked",false);
							}
					 	});
					} else{ */

						let purchasePrintNoList = _.uniqBy(dataList, function(elem){
																		return [elem.purchasePrintNo, elem.matrlIdx].join();
								 									});
						//현재 for문 돌고있는 자재식별자
						let filterList = _.find(purchasePrintNoList, v=>v.matrlIdx == data.matrlIdx);
						//해당 식별자의 납기일과 일치하는지+ filterList가 있는 경우엔 예외처리 타도록 , 빈값일 경우 -> 첫번째 클릭인경우
						//↑↑↑↑↑ 자재별의 납기일 체크로직 넣어달라해서 추가했었던 것
						if(isEmptyCheck(filterList)){
							let obj = {}; // 그냥 data를 넣으면 아래쪽에서 값을 계산하는 과정에서 해당 data의 원본의 값이 변경되기 때문에 일일이 따로 입력
							obj.bizOrdDtlNo = data.bizOrdDtlNo;
							obj.dealCorpIdx = data.dealCorpIdx;
							obj.matrlIdx = data.matrlIdx;
							obj.matrlCd = data.matrlCd;
							obj.matrlNm = data.matrlNm;
							obj.amountAvg = data.amountAvg;
							obj.matrlSize = data.matrlSize;
							obj.matrlSizeNm = data.matrlSizeNm;
							obj.lawGubun = data.lawGubun;
							obj.lawGubunNm = data.lawGubunNm;
							obj.purchaseOrdQty = data.purchaseOrdQty;
							obj.etc2 = data.etc2;
							//if( data.etc2 == '02' ){
								//매입단위가 "통"인 경우 수주수량 == 발주수량임
							//	obj.ordQty = (data.purchaseOrdQty==null?0:data.purchaseOrdQty);
							//} else {
								obj.ordQty = (data.ordQty==null?0:data.ordQty);
							//}
							obj.cutQty = data.cutQty;
							obj.eaQty = data.eaQty;
							obj.extraQty = data.extraQty;
							obj.extraPackQty = data.extraPackQty;
							obj.paperType = data.paperType;
							if(data.bizOrdDtlNo == null) { // 개별발주일 경우
								obj.purchaseDesc = data.purchaseDesc;
							} else { // 수주별발주일 경우
								obj.purchaseDesc = data.bizOrdDtlNo + '/' + data.itemNm;//.substr(0,22);
							}
							obj.purchaseInDueDate = data.purchaseInDueDate;
		
							let ordQty = parseInt(data.purchaseOrdQty); // 주문수량(제품)
							let cutQty = parseInt(data.cutQty); // 절수
							let eaQty = parseInt(data.eaQty); // 개수
							let extraQty = parseInt(data.extraQty); // 여유분
							let extraPackQty = parseInt(data.extraPackQty); // 포장단위여분
							
							if(cutQty == 0 || eaQty == 0) {
								return '0';
							} else {
								//let printPressQty = Math.ceil(ordQty/eaQty);
								let printPressQty = Math.ceil(ordQty/(cutQty*eaQty)) * cutQty;
								let pressQty = Math.ceil((printPressQty + extraQty)/cutQty + extraPackQty);
								
								let R = parseInt(pressQty / 500); // R로 환산
								let finalPurchaseQty = R + "R" + (pressQty % 500);
		
								obj.pressQty = parseInt(pressQty);
							}

							if(cutQty == 0 || eaQty == 0) {
								return '0';
							} else {
								//let printPressQty = Math.ceil(ordQty/eaQty);
								let printPressQty = Math.ceil(ordQty/(cutQty*eaQty)) * cutQty;
								let printPressAndExtraQty = printPressQty + extraQty + (extraPackQty*cutQty);
								obj.printPressAndExtraQty = printPressAndExtraQty;
							}
							
							//발주서 출력번호
							obj.purchasePrintNo = data.purchasePrintNo != '' && data.purchasePrintNo != null ? data.purchasePrintNo : 'notPrint';
							
							dataList.push(obj);
						} else {
							//if(filterList.purchaseInDueDate == data.purchaseInDueDate){
								let obj = {}; // 그냥 data를 넣으면 아래쪽에서 값을 계산하는 과정에서 해당 data의 원본의 값이 변경되기 때문에 일일이 따로 입력
								obj.bizOrdDtlNo = data.bizOrdDtlNo;
								obj.dealCorpIdx = data.dealCorpIdx;
								obj.matrlIdx = data.matrlIdx;
								obj.matrlCd = data.matrlCd;
								obj.matrlNm = data.matrlNm;
								obj.amountAvg = data.amountAvg;
								obj.matrlSize = data.matrlSize;
								obj.matrlSizeNm = data.matrlSizeNm;
								obj.lawGubun = data.lawGubun;
								obj.lawGubunNm = data.lawGubunNm;
								obj.purchaseOrdQty = data.purchaseOrdQty;
								obj.etc2 = data.etc2;
								//if( data.etc2 == '02' ){
									//매입단위가 "통"인 경우 수주수량 == 발주수량임
								//	obj.ordQty = (data.purchaseOrdQty==null?0:data.purchaseOrdQty);
								//} else {
									obj.ordQty = (data.ordQty==null?0:data.ordQty);
								//}
								obj.cutQty = data.cutQty;
								obj.eaQty = data.eaQty;
								obj.extraQty = data.extraQty;
								obj.extraPackQty = data.extraPackQty;
								obj.paperType = data.paperType;
								if(data.bizOrdDtlNo == null) { // 개별발주일 경우
									obj.purchaseDesc = data.purchaseDesc;
								} else { // 수주별발주일 경우
									obj.purchaseDesc = data.bizOrdDtlNo + '/' + data.itemNm;//.substr(0,22);
								}
								obj.purchaseInDueDate = data.purchaseInDueDate;
			
								let ordQty = parseInt(data.purchaseOrdQty); // 주문수량(제품)
								let cutQty = parseInt(data.cutQty); // 절수
								let eaQty = parseInt(data.eaQty); // 개수
								let extraQty = parseInt(data.extraQty); // 여유분
								let extraPackQty = parseInt(data.extraPackQty); // 포장단위여분
								
								if(cutQty == 0 || eaQty == 0) {
									return '0';
								} else {
									//let printPressQty = Math.ceil(ordQty/eaQty);
									let printPressQty = Math.ceil(ordQty/(cutQty*eaQty)) * cutQty;
									let pressQty = Math.ceil((printPressQty + extraQty)/cutQty + extraPackQty);
									
									let R = parseInt(pressQty / 500); // R로 환산
									let finalPurchaseQty = R + "R" + (pressQty % 500);
			
									obj.pressQty = parseInt(pressQty);
								}
			
								if(cutQty == 0 || eaQty == 0) {
									return '0';
								} else {
									//let printPressQty = Math.ceil(ordQty/eaQty);
									let printPressQty = Math.ceil(ordQty/(cutQty*eaQty)) * cutQty;
									let printPressAndExtraQty = printPressQty + extraQty + (extraPackQty*cutQty);
									obj.printPressAndExtraQty = printPressAndExtraQty;
								}
								//발주서 출력번호
								obj.purchasePrintNo = data.purchasePrintNo != '' && data.purchasePrintNo != null ? data.purchasePrintNo : 'notPrint';
								
								dataList.push(obj);
							//} else {
							/*	toastr.warning('입고예정일이 다른 발주입니다.');
								status=false;
								checkFin=false;
								dataList = _.cloneDeep(tempList);
								$(this).prop("checked",false);
								// 모든 체크박스 체크/해제 되도록
								$(document).on('change','input:checkbox[name=purchasePrint]', function(){
									if( $('input:checkbox[name=purchasePrint]').length == $('input:checkbox[name=purchasePrint]:checked').length ){ //전체 체크박스 수와 체크된 박스의 수가 같을 때 -> 전체체크박스 체크 , 아닐 경우 해제
										$('#checkAll').prop("checked",true);
									} else{
										$('#checkAll').prop("checked",false);
									}
							 	});
							}*/
							
						}

						//dataList에 밀어넣고나서 발주처 중복 체크
						let dealCorpUniqLst = _.uniqBy(dataList, v=> v.dealCorpIdx);
						if(dealCorpUniqLst.length > 1){
							toastr.warning('발주처가 다른 항목입니다.');
							status=false;
							checkFin=false;
							dataList = _.cloneDeep(tempList);
							$(this).prop("checked",false);
							// 모든 체크박스 체크/해제 되도록
							$(document).on('change','input:checkbox[name=purchasePrint]', function(){
								if( $('input:checkbox[name=purchasePrint]').length == $('input:checkbox[name=purchasePrint]:checked').length ){ //전체 체크박스 수와 체크된 박스의 수가 같을 때 -> 전체체크박스 체크 , 아닐 경우 해제
									$('#checkAll').prop("checked",true);
								} else{
									$('#checkAll').prop("checked",false);
								}
						 	});
						}
					//}

				}
			}
			
		}
		if(!status){
			dataList = _.cloneDeep(tempList);
		} else{
			tempList = _.cloneDeep(dataList);
		}
		
		//자재, 발주서출력번호, 입고예정일별 유니크한 리스트
		let purchasePrintNoList = _.sortBy(_.uniqBy(dataList, function(elem){
														return [elem.purchasePrintNo, elem.matrlIdx, elem.purchaseInDueDate].join();
														 }) , v=> v.purchaseInDueDate ); //출력번호별 목록
		for(var i=0;i<purchasePrintNoList.length;i++) {
			let purchasePrintNo = purchasePrintNoList[i].purchasePrintNo;
			let matrlIdx = purchasePrintNoList[i].matrlIdx;
			let purchaseInDueDate = purchasePrintNoList[i].purchaseInDueDate; 
			purchasePrintNoList[i].purchaseOrdQty = _.sumBy(_.filter(dataList, ( (v => v.purchasePrintNo == purchasePrintNo && v.matrlIdx == matrlIdx && v.purchaseInDueDate == purchaseInDueDate ) || (v.purchasePrintNo == 'notPrint' && v.matrlIdx == matrlIdx) )), (v => parseInt(v.purchaseOrdQty)));
			purchasePrintNoList[i].ordQty = _.sumBy(_.filter(dataList, ( (v => v.purchasePrintNo == purchasePrintNo && v.matrlIdx == matrlIdx && v.purchaseInDueDate == purchaseInDueDate ) || (v.purchasePrintNo == 'notPrint'&& v.matrlIdx == matrlIdx) )), (v => parseInt(v.ordQty)));
			purchasePrintNoList[i].pressQty = _.sumBy(_.filter(dataList, ( (v => v.purchasePrintNo == purchasePrintNo && v.matrlIdx == matrlIdx && v.purchaseInDueDate == purchaseInDueDate ) || (v.purchasePrintNo == 'notPrint'&& v.matrlIdx == matrlIdx) )), (v => parseInt(v.pressQty)));
			purchasePrintNoList[i].printPressAndExtraQty = _.sumBy(_.filter(dataList, ( (v => v.purchasePrintNo == purchasePrintNo && v.matrlIdx == matrlIdx && v.purchaseInDueDate == purchaseInDueDate ) || (v.purchasePrintNo == 'notPrint'&& v.matrlIdx == matrlIdx) )), (v => parseInt(v.printPressAndExtraQty)));
		}
		
		let result = purchasePrintNoList;
		
		for(var i=0;i<result.length;i++) {
			let ordQty = result[i].ordQty; // 수주 주문수량
			let pressQty = result[i].pressQty; // 발주량
			let printPressAndExtraQty = result[i].printPressAndExtraQty; //여분포함통수
			
			if(pressQty != null) {
				pressQty = parseInt(pressQty/500) + "R" + parseInt(pressQty%500);
			}
			
			$('.dtlList').eq(i).find('td').eq(0).html(result[i].paperType);
			$('.dtlList').eq(i).find('td').eq(1).find('input[name=purchaseInDueDate]').val(moment(result[i].purchaseInDueDate).format('MM/DD'));
			if(result[i].etc2 == '02'){
				$('.dtlList').eq(i).find('td').eq(2).html(printPressAndExtraQty==null?'0':addCommas(printPressAndExtraQty));
			} else {
				if(ordQty != null) {
					ordQty = parseInt(ordQty/500) + "R" + parseInt(ordQty%500);
				}
				$('.dtlList').eq(i).find('td').eq(2).html(ordQty==null?'0':ordQty);
			}
			
			
			//$('.dtlList').eq(i).find('td').eq(3).html(pressQty==null?'0':pressQty);
			if(_.filter(dataList, (v => v.matrlIdx == result[i].matrlIdx && v.purchasePrintNo == result[i].purchasePrintNo && v.purchaseInDueDate == result[i].purchaseInDueDate)).length > 1) { // 2개 이상의 발주를 합쳤을 경우
				$('.dtlList').eq(i).find('td').eq(3).find('input[name=purchaseDesc]').val('[재고용]');
			} else { // 단독일 경우
				$('.dtlList').eq(i).find('td').eq(3).find('input[name=purchaseDesc]').val(result[i].purchaseDesc);
			}
			
		}
	});

	// 조회 버튼 click
	$('#btnSearch').on('click', function() {

		$('#my-spinner').show();
		purchaseOrderAdmTable.row('.selected').deselect();
		purchaseOrderAdmTable.ajax.reload(function() {
			$('#btnEdit').trigger('click');
		});
		$('#checkAll').prop("checked",false);
		$('#btnSave').attr('disabled',true);
		$('#btnEdit').attr('disabled',false);
		$('#btnCancel').attr('disabled',true);
		
		$('.dtlList').find('.not-edit').html('&nbsp;');
		$('.dtlList').find('.edit').find('input').val('');
		tempList = [];
		setTimeout(function() {
			$('#my-spinner').hide();
		}, 100)
	});

	// 발주서 인쇄 버튼 click
	$('#btnPrint').on('click',function() {
		$('#my-spinner').show();
		_promise_().then((value)=>{
			let updIdx = '';
			let status = false;
			let printYn = 'N';
			/* $('#purchaseOrderAdmTable tbody tr').each(function(index){
				let data = purchaseOrderAdmTable.row(index).data();
				let node = purchaseOrderAdmTable.row(index).node();
				let checkboxIdx = purchaseOrderAdmTable.column('checkbox:name').index();
				if( $(node).find('td').eq(checkboxIdx).find('input[name=purchasePrint]').prop('checked') ){
					updIdx += data.idx +', ';
					if(data.purchasePrintNo != null && data.purchasePrintNo !=''){
						printYn='Y';
					}
				}	
			}); */
			$('input[name=purchasePrint]:checked').each(function(index, item){
				let tr = $(item).parent().parent();
				let node = purchaseOrderAdmTable.row(tr).node();
				let data = purchaseOrderAdmTable.row(tr).data();
				updIdx += data.idx +', ';
				//if(data.purchasePrintNo != null && data.purchasePrintNo !=''){
				//	printYn='Y';
				//}				
			});
			if(updIdx != '' && updIdx != null && printYn == 'N'){
				updIdx = updIdx.slice(0,-2);
				$.ajax({
					url: '<c:url value="/pm/purchasePaperUpd"/>',
		            type: 'POST',
		            async: false,
		            data: {    
			            'idx'				:	function(){return updIdx;},
			            'printDate'			:	function(){return moment().format('YYYYMMDD');},
		            },
		            beforeSend: function() {
		            	$('#my-spinner').show();
		            },
					success : function(res) {
						if (res.result == "ok") { //응답결과
							//toastr.success('발주서 출력번호 수정되었습니다.');
							cssChange(); // css반영
							
							$('#purchasePaperTable').print({
								globalStyles: true,
								mediaPrint: true
							});
							$('#btnSearch').trigger('click');
							$('#checkAll').prop("checked",false);
							status = true;
						} else if(res.result == 'fail') {
							toastr.warning(res.message);
							$('#btnSearch').trigger('click');
							$('#checkAll').prop("checked",false);
							status = false;
						} else {
							toastr.error(res.message);
						}
						$('#my-spinner').hide();

					}
				});
			} else {
				cssChange(); // css반영
				
				$('#purchasePaperTable').print({
					globalStyles: true,
					mediaPrint: true
				});
				status = true;
			}
			return status;
		}).then((value)=>{
			setTimeout(function() {

				$('#my-spinner').hide();
			}, 200);
		});
	});
	// 작업인쇄 모달이 띄워지면 인쇄
	$('#workOrderPaperModal').on('shown.bs.modal', function (e) {
		$('#purchasePaperTable').print({
			globalStyles: true,
			mediaPrint: true
		});
		$('#workOrderPaperModal').modal('hide');
		$('#my-spinner').hide();
	});

	// 발주서 다운로드 버튼 click
	$('#btnDownload').on('click', function() {
		cssChange(); // css반영
		html2canvas($('#purchasePaperTable')[0], {
			allowTaint : true,	// cross-origin allow
			useCORS: true,		// CORS 사용한 서버로부터 이미지 로드할 것인지 여부
			scale : 2			// 기본 96dpi에서 해상도를 두 배로 증가
		}).then(function(canvas) {
			var element = document.getElementById('purchasePaperTable');
			var opt = {
			  margin:       3,
			  filename:     moment().format('YYYYMMDD')+'_발주서.pdf',
			  image:        { type: 'jpeg', quality: 0.98 },
			  html2canvas:  { scale: 1 },
			  jsPDF:        { unit: 'mm', format: 'a4', orientation: 'portrait'}
			};

			// New Promise-based usage:
			html2pdf().from(element).set(opt).save().then(() => {
				
			});
		});
	});












	// 초기 셋팅
	$(document).ready(function() {
		$('#purchasePrintDate').html('일자 : '+moment().format('YYYY년 MM월 DD일'));
		for(var i=0;i<paperLineCount;i++) { // 발주상세 빈공간 생성
			$('#trAppendTarget').after(makeEmptyTr());
		}
		
		cssChange();
		$('#my-spinner').hide();
		$('#purchasePaperTable').removeClass('d-none');

		$('input').attr('autocomplete','one-time-code');
	});

	// make empty tr
	function makeEmptyTr() {
		let html = '';
			html += '<tr class="dtlList">';
			html += '	<td colspan="7"  class="not-edit text-center align-middle not-left tbodyFirstCol">&nbsp;</td>';
			html += '	<td colspan="2"  class="edit text-center align-middle tbodyNotFirstCol"><input name="purchaseInDueDate" type="text" class="text-center p-0 fs-15" style="border:none !important;max-width:50px; font-weight: 900;"></td>';
			html += '	<td colspan="4"  class="not-edit text-center align-middle tbodyNotFirstCol">&nbsp;</td>';
			html += '	<td colspan="17" class="edit text-start align-middle tbodyNotFirstCol"><input name="purchaseDesc" type="text" class="text-center p-0 fs-15" style="border:none !important; font-weight: 900;min-width:400px;"></td>';
			html += '</tr>';

		return html;
	}

	function cssChange() {
		$('#purchasePaperTable').find('td').css('font-weight', '900');
		$('#purchasePaperTable').find('td').css('border', '2px solid black');
		$('#purchasePaperTable').find('td').css('padding', '0.1rem');
		$('#purchasePaperTable').find('td').css('color', '#000000');

		$('#purchasePaperTable').find('.bg-gray').css('background-color', '#f2f2f2');
		
		$('#purchasePaperTable').find('.theadFirstCol').css('border-top', '0px');
		//$('#purchasePaperTable').find('.theadFirstCol').css('border-left', '2px');
		$('#purchasePaperTable').find('.theadNotFisrtCol').css('border-top', '0px');
		$('#purchasePaperTable').find('.theadNotFisrtCol').css('border-left', '0px');
		
		$('#purchasePaperTable').find('.tbodyFirstCol').css('border-top', '0px');
		//$('#purchasePaperTable').find('.tbodyFirstCol').css('border-left', '2px');
		$('#purchasePaperTable').find('.tbodyNotFirstCol').css('border-top', '0px');
		$('#purchasePaperTable').find('.tbodyNotFirstCol').css('border-left', '0px');
		
		$('#purchasePaperTable').find('.fs-8').css('font-size', '8px');
		$('#purchasePaperTable').find('.fs-10').css('font-size', '10px');
		$('#purchasePaperTable').find('.fs-13').css('font-size', '13px');
		$('#purchasePaperTable').find('.fs-15').css('font-size', '15px');
		$('#purchasePaperTable').find('.fs-20').css('font-size', '20px');
		$('#purchasePaperTable').find('.fs-30').css('font-size', '30px');
		$('#purchasePaperTable').find('.fs-50').css('font-size', '50px');
		$('#purchasePaperTable').find('.fc-red').css('color', '#ff0000');
		$('#purchasePaperTable').find('.bt-2').css('border-top', '2px solid black');
		$('#purchasePaperTable').find('.bd-n').css('border', '1px solid #ffffff');
		$('#purchasePaperTable').find('.bt-n').css('border-top', '1px solid #ffffff');
		$('#purchasePaperTable').find('.br-n').css('border-right', '1px solid #ffffff');
		$('#purchasePaperTable').find('.bb-n').css('border-bottom', '1px solid #ffffff');
		$('#purchasePaperTable').find('.bl-n').css('border-left', '1px solid #ffffff');
		$('#purchasePaperTable').find('.h-5').css('height', '5px');
		$('#purchasePaperTable').find('.h-10').css('height', '10px');
		$('#purchasePaperTable').find('.h-20').css('height', '20px');
		$('#purchasePaperTable').find('.h-30').css('height', '30px');
		$('#purchasePaperTable').find('.h-40').css('height', '40px');
		$('#purchasePaperTable').find('.h-55').css('height', '55px');
		$('#purchasePaperTable').find('.h-70').css('height', '70px');
		$('#purchasePaperTable').find('.h-100').css('height', '100px');

		// 인쇄할 때 css 적용하려면 important 붙여줘야함.
		for(var i=0;i<$('#purchasePaperTable').find('td').length;i++) {
			let tdStyle = $('#purchasePaperTable').find('td').eq(i).attr('style') == undefined?'':$('#purchasePaperTable').find('td').eq(i).attr('style');
			$('#purchasePaperTable').find('td').eq(i).attr('style',tdStyle.replaceAll(';',' !important;'));
		}
	}

	//수정버튼
	$('#btnEdit').on('click',function(){
		$('#purchaseOrderAdmTable tbody').find('tr').each(function(index_tr, tr) {
			$(tr).find('td').each(function(index_td, td) {
				if($(td).hasClass('editNode') && $(td).find('input').length != 1) {
					if(index_td == purchaseOrderAdmTable.column('purchaseInDueDate:name').index()) {
						let data = purchaseOrderAdmTable.row(tr).data();
						let value = data.purchaseInDueDate;
						let ordQty = parseInt(data.purchaseOrdQty);
						let cutQty = parseInt(data.cutQty);
						let eaQty = parseInt(data.eaQty);
						let extraQty = parseInt(data.extraQty);
						let extraPackQty = parseInt(data.extraPackQty);
						let inQty = data.inQty != null && data.inQty != '' ? data.inQty : 0;
						//let printPressQty = Math.ceil(ordQty/eaQty);
						let printPressQty = Math.ceil(ordQty/(cutQty*eaQty)) * cutQty;
						let pressQty = Math.ceil((printPressQty + extraQty)/cutQty + extraPackQty);
							
						
						value = moment(value).format('YYYY-MM-DD');
						//원래 입고다된 항목은 수정 못하는 거였는데 출력된경우 수정못하도록 변경됨
						//출력했더라도 입고가 안된 경우는 수정할 수 있게끔 변경됨
						//if( parseInt(pressQty) > parseInt(inQty) ){
						if( data.purchasePrintNo == null || data.purchasePrintNo == '' || parseInt(inQty) == 0 ){
							$(td).html('<input type="date" max="9999-12-31" class="form-control text-center" value="'+value+'">');
						} else {
							$(td).html('<input disabled type="date" max="9999-12-31" class="form-control text-center" value="'+value+'">');
						}
					} else if(index_td == purchaseOrderAdmTable.column('purchasePrintNo:name').index()){
						let inQty = purchaseOrderAdmTable.row(tr).data().inQty != null && purchaseOrderAdmTable.row(tr).data().inQty != '' ? purchaseOrderAdmTable.row(tr).data().inQty : 0;
						if(inQty == 0 && purchaseOrderAdmTable.row(tr).data().purchasePrintNo != null && purchaseOrderAdmTable.row(tr).data().purchasePrintNo !=''){

							let html = '';
							html += '<div style="display: flex; flex-wrap: 1 1 auto;" class="input-group">';												
							html += '<input type="text" class="form-control inputGroup inputNm" name="purchasePrintNo"  style="min-width:110px;max-width:110px;border-top-right-radius :0.375rem;border-bottom-right-radius :0.375rem;" value="'+purchaseOrderAdmTable.row(tr).data().purchasePrintNo+'" disabled="">';
							html +=	'<button type="button" class="inputGroup" name="btnDealCorpDelete" style="background-color: transparent;border-color: transparent;position: absolute;top: 0;right:0;margin: 1px 5px;margin-left: 0px;border: none;">';
							html +=	'	<i class="fa-solid fa-xmark"></i>';
							html +=	'</button>';												
							html +=	'<input type="hidden" id="customerIdx" class="inputIdx">';
							html += '</div>';
							$(td).html(html);							
						}
						
					}
						
				}
			})
		});

		$('#btnSave').attr('disabled',false);
		$('#btnEdit').attr('disabled',true);
		$('#btnCancel').attr('disabled',false);

		purchaseOrderAdmTable.draw(false);
	});

	$('#btnSave').on('click',function(){
		let array = [];
		let state = true;
		$('#purchaseOrderAdmTable tbody').find('tr').each(function(index, item) {
			let td = $(item).find('td');
			let data = purchaseOrderAdmTable.row($(item)).data();
			let purchaseInDueDate = $(td).eq(purchaseOrderAdmTable.column('purchaseInDueDate:name').index()).find('input').val().replaceAll('-','');
			let purchasePrintNo = $(td).eq(purchaseOrderAdmTable.column('purchasePrintNo:name').index()).find('input[name=purchasePrintNo]').val();
			
			let obj = new Object();
			obj.idx = data.idx;
			obj.purchaseInDueDate = purchaseInDueDate;
			obj.purchasePrintNo = purchasePrintNo;
		    array.push(obj);
		});

		let tableData = [];
		for(var i=0;i<purchaseOrderAdmTable.data().count();i++) {
			let obj = {};
			obj.idx = purchaseOrderAdmTable.row(i).data().idx;
			obj.purchaseInDueDate = purchaseOrderAdmTable.row(i).data().purchaseInDueDate;
			obj.purchasePrintNo = purchaseOrderAdmTable.row(i).data().purchasePrintNo;
			tableData.push(obj);
		}

		array = _.differenceWith(array, tableData, _.isEqual);
		//console.log(JSON.stringify(array));
		$.ajax({
			url: '<c:url value="/pm/purchaseOrderInDueDateAdmUpd"/>',
            type: 'POST',
            data: {
                'updateJson'	:	JSON.stringify(array)
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					toastr.success('수정되었습니다.');
					$('#btnSearch').trigger('click');
					/* WM_action_OFF('ADM');
					
					itemDisposal.ajax.reload(function() {});
					$('#itemDisposal_wrapper').find('.filters th').each(function(index, item) {
						$(item).find('input').attr('disabled', false); // 검색 필터 disabled
					});
					itemDisposal.colReorder.enable();
        
					$('#btnSave').attr('disabled', true); // 저장 버튼
					$('#btnEdit').attr('disabled', false); // 수정 버튼
					$('#btnDel').attr('disabled', false); // 삭제 버튼
					$('#btnCancel').attr('disabled', true); // 취소 버튼 */
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		}); 
	});

	$('#btnCancel').on('click',function(){
		$('#cancelModal').modal('show');
		$('#cancelModal').data('type','ADM');
	});

	// 취소 경고창 취소 버튼 click
	$('#btnCancelModalY').on('click', function() {
		let type = $('#cancelModal').data('type');
		if(type == 'ADM'){
			toastr.success('취소되었습니다.');
			$('#btnSearch').trigger('click');
		}
	});
	
	//출력번호삭제기능
	$(document).on('click','button[name=btnDealCorpDelete]',function(){
 		let tr = $(this).parent().parent().parent();
 		let data = purchaseOrderAdmTable.row(tr).data();

 		$(this).prev().val('');
 		/* $('#deleteModal').data('deleteType','ADM');
 		$('#deleteModal').data('idx',data.idx);
		$('#deleteModal').modal('show'); */
 		
	});

	$('#btnDeleteModalY').on('click',function(){
		let deleteType = $('#deleteModal').data('deleteType');
		if(deleteType == 'ADM'){
			let idx = $('#deleteModal').data('idx');
			$.ajax({
				url: '<c:url value="/pm/purchasePaperDel"/>',
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
						$('#btnSearch').trigger('click');
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


</script>
</body>
</html>
