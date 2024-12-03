<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/top.jsp"%>
<%@include file="../layout/modal.jsp"%>
<%@include file="../layout/script.jsp"%>
<div id="page" onmouseup="EndDrag(this)" onmousemove="OnDrag(event)" style="grid-template-areas:	'middlecolT'
																									'dragbarVT'
																									'middlecolM'
																									'dragbarVB'
																									'middlecolB';
																		  grid-template-rows: 4fr 4px 4fr 4px 2fr;
																		  grid-template-columns: 1fr;">
	
	<div id="middlecolT">
		<div class="container-fluid h-100" style="padding: 5px;">
			<div class="row" id="leftHeader" style="padding-bottom: 5px;">
				<div class="d-flex align-items-center d-flex">
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">작업지시일</label>
					<input type="date" max="9999-12-31" class="form-control w-auto h-100 me-1" id="startDate">
					<label class="form-label d-flex align-items-center m-0 me-1 h-100">~</label>
					<input type="date" max="9999-12-31" class="form-control w-auto h-100 me-3" id="endDate">
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">공정코드</label>
					<select class="form-select w-auto h-100 me-3" id="prcssCdList"></select>
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">설비목록</label>
					<select class="form-select w-auto h-100 me-3" id="equipList"></select>
					
					<input type="text" class="d-none form-control w-auto h-100 me-1" id="searchAll" placeholder="통합검색" >
				</div>
				<div class="me-lg-auto"></div>
				<div class="btn-group" role="group" aria-label="Small button group">
					<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnSearch">
						<i class="fa-regular fa-clipboard"></i>
					</button>
					<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnProduceOrdPrint">제조지시서 인쇄</button>
					<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnPrcssWorkOrdPrint">공정작업지시서 인쇄</button>
				</div>
			</div>
			
			
			
			
			<div class="row">
				<table class="table table-bordered p-0 m-0" id="workOrderTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle"><input type="checkbox" id="btnAllCheck" style="width:20px; height:20px;"></th>
							<th class="text-center align-middle">생산생태</th>
							<th class="text-center align-middle">수주상태</th>
							<th class="text-center align-middle">수주상세번호</th>
							<th class="text-center align-middle">생산지시일</th>
							<th class="text-center align-middle">목표요구일</th>
							<th class="text-center align-middle">완료예정일</th>
							<th class="text-center align-middle">공정명</th>
							<th class="text-center align-middle">수주처</th>
							<th class="text-center align-middle">제품명</th>
							<th class="text-center align-middle">수주수량</th>
							<th class="text-center align-middle">지시수량</th>
							<th class="text-center align-middle">생산량</th>
							<th class="text-center align-middle">지시비고</th>
							<th class="text-center align-middle">목형번호</th>
							<th class="text-center align-middle">수지판번호</th>
							<th class="text-center align-middle">수주특이사항</th>
							<th class="text-center align-middle">수주전달사항</th>
						</tr>
					</thead>
					
				</table>
			</div>
		</div>
	</div>
	
	<div id="dragbarVT" onmousedown="StartDrag('VT')"></div>
	
	<div id="middlecolM">
		<div class="container-fluid h-100" style="padding: 5px;">
			<div class="row">
				<table class="table table-bordered p-0 m-0" id="workOrderPrcssTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle">순번</th>
							<th class="text-center align-middle">작업상태</th>
							<th class="text-center align-middle">공정코드</th>
							<th class="text-center align-middle">공정명</th>
							<th class="text-center align-middle">지시수량</th>
							<th class="text-center align-middle">생산량</th>
							<th class="text-center align-middle">작업방법</th>
							<!-- <th class="text-center align-middle">외주구분</th>
							<th class="text-center align-middle">외주처</th> -->
							<th class="text-center align-middle">단위</th>
							<th class="text-center align-middle">비고</th>
							<th class="text-center align-middle">주의사항</th>
						</tr>
					</thead>
					
				</table>
			</div>
		</div>
	</div>
	
	<div id="dragbarVB" onmousedown="StartDrag('VB')"></div>
	
	<div id="middlecolB">
		<div class="container-fluid h-100" style="padding: 5px;">
			<div class="row">
				<table class="table table-bordered p-0 m-0" id="inputMaterialHistTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle">원단코드</th>
							<th class="text-center align-middle">장*폭</th>
							<th class="text-center align-middle">절수/개수</th>
							<th class="text-center align-middle">발주량+여분</th>
							<th class="text-center align-middle">입고량</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
	
</div>

<!-- 인쇄 미리보기 모달 -->
<div class="modal fade" id="prcssEquipModal" tabindex="-1" aria-hidden="true" style="z-index: 9999;">
	<div class="modal-dialog" style="max-width: 60vw;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="prcssEquipModalTitle">
					PDF
				</h5>
			</div>
			<div class="modal-body">
				<table id="printTable" class="table table-bordered m-0" style="border:1px solid #ffffff;">
					<colgroup>
						<col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%">
						<col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%">
						<col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="5%">
						<col width="5%"><col width="5%"><col width="3%"><col width="3%"><col width="3%"><col width="4%">
						<col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%">
					</colgroup>
					<tr>
						<td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n">
						<td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n">
						<td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n">
						<td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n">
						<td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n">
					</tr>									
					<tr id="trAppendTarget">
						<td colspan='1' class="bg-gray fs-10 text-center align-middle not-left" style="">생산<br>상태</td>
						<td colspan='1' class="bg-gray fs-10 text-center align-middle not-left theadNotFisrtCol" style="border-left:0px;">수주<br>상태</td>
						<td colspan='2' class="bg-gray fs-10 text-center align-middle not-left theadNotFisrtCol" style="border-left:0px;">수주상세번호</td>
						<td colspan='2' class="bg-gray fs-10 text-center align-middle not-left theadNotFisrtCol" style="border-left:0px;">생산<br>지시일</td>
						<td colspan='2' class="bg-gray fs-10 text-center align-middle not-left theadNotFisrtCol" style="border-left:0px;">생산완료<br>요구일</td>
						<td colspan='2' class="bg-gray fs-10 text-center align-middle not-left theadNotFisrtCol" style="border-left:0px;">완료예정일</td>
						<td colspan='2' class="bg-gray fs-10 text-center align-middle not-left theadNotFisrtCol" style="border-left:0px;">공정명</td>
						<td colspan='2' class="bg-gray fs-10 text-center align-middle not-left theadNotFisrtCol" style="border-left:0px;">수주처</td>
						<td colspan='3' class="bg-gray fs-10 text-center align-middle not-left theadNotFisrtCol" style="border-left:0px;">제품명</td>
						<td colspan='1' class="bg-gray fs-10 text-center align-middle not-left theadNotFisrtCol" style="border-left:0px;">수주<br>수량</td>
						<td colspan='1' class="bg-gray fs-10 text-center align-middle not-left theadNotFisrtCol" style="border-left:0px;">지시<br>수량</td>
						<td colspan='1' class="bg-gray fs-10 text-center align-middle not-left theadNotFisrtCol" style="border-left:0px;">생산량</td>
						<td colspan='2' class="bg-gray fs-10 text-center align-middle not-left theadNotFisrtCol" style="border-left:0px;">지시비고</td>
						<td colspan='1' class="bg-gray fs-10 text-center align-middle not-left theadNotFisrtCol" style="border-left:0px;">목형<br>번호</td>
						<td colspan='1' class="bg-gray fs-10 text-center align-middle not-left theadNotFisrtCol" style="border-left:0px;">수지판<br>번호</td>
						<td colspan='3' class="bg-gray fs-10 text-center align-middle not-left theadNotFisrtCol" style="border-left:0px;">수주특이사항</td>
						<td colspan='3' class="bg-gray fs-10 text-center align-middle not-left theadNotFisrtCol" style="border-left:0px;">수주전달사항</td>
						
					</tr>
				</table>
				<div style="width:297mm;max-height:420mm;min-height:420mm;">
					<table id="printProduceTable" class="table table-bordered m-0" style="border:1px solid #ffffff;">
						<colgroup>
							<col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%">
							<col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%">
							<col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="5%">
							<col width="5%"><col width="5%"><col width="3%"><col width="3%"><col width="3%"><col width="4%">
							<col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%">
							
						</colgroup>
						<tr>
							<td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n">
							<td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n">
							<td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n">
							<td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n">
							<td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n">
							
						</tr>									
						<tr id="trAppendTarget2">
							<td colspan='30' class="bg-gray fs-10 text-center align-middle not-left" style="">생산<br>상태</td>
							
						</tr>
					</table>
				</div>
				<%-- <div style="width:297mm;max-height:420mm;min-height:420mm;">
					<table id="printProduceTable" class="table table-bordered m-0" style="border:1px solid #ffffff;">
						<colgroup>
							<col width="1.5%"><col width="1.5%"><col width="1.5%"><col width="1.5%"><col width="1.5%"><col width="1.5%">
							<col width="1.5%"><col width="1.5%"><col width="1.5%"><col width="1.5%"><col width="1.5%"><col width="1.5%">
							<col width="1.5%"><col width="1.5%"><col width="1.5%"><col width="1.5%"><col width="1.5%"><col width="2.5%">
							<col width="2.5%"><col width="2.5%"><col width="1.5%"><col width="1.5%"><col width="1.5%"><col width="2%">
							<col width="1.5%"><col width="1.5%"><col width="1.5%"><col width="1.5%"><col width="1.5%"><col width="1.5%">
							
							<col width="1.5%"><col width="1.5%"><col width="1.5%"><col width="1.5%"><col width="1.5%"><col width="1.5%">
							<col width="1.5%"><col width="1.5%"><col width="1.5%"><col width="1.5%"><col width="1.5%"><col width="1.5%">
							<col width="1.5%"><col width="1.5%"><col width="1.5%"><col width="1.5%"><col width="1.5%"><col width="2.5%">
							<col width="2.5%"><col width="2.5%"><col width="1.5%"><col width="1.5%"><col width="1.5%"><col width="2%">
							<col width="1.5%"><col width="1.5%"><col width="1.5%"><col width="1.5%"><col width="1.5%"><col width="1.5%">
						</colgroup>
						<tr>
							<td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n">
							<td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n">
							<td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n">
							<td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n">
							<td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n">
							
							<td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n">
							<td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n">
							<td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n">
							<td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n">
							<td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n">
						</tr>									
						<tr id="trAppendTarget2">
							<td colspan='30' class="bg-gray fs-10 text-center align-middle not-left" style="">생산<br>상태</td>
							
						</tr>
					</table>
				</div> --%>
			</div>
		</div>
	</div>
</div>
<!-- 인쇄 미리보기 모달 끝 -->

<!-- 인쇄용지설정 -->
<style type="text/css" media="print">
@media print {
	@page { size: A4 portrait; margin: 3mm; }, /*landscape 가로  portrait 세로 */
	html, body { width: 210mm;height: 297mm; }
}
/*@media print {
	@page { size: A3 landscape; margin: 3mm; }, /*landscape 가로  portrait 세로 */
	/*html, body { width: 297mm;height: 420mm; }
}*/
</style>

<!-- 화면설정 script -->
<script>
	let isDraggingVT = false; // 세로(탑) 드레그 여부
	let isDraggingVB = false; // 세로(바텀) 드레그 여부
	
	function SetCursor(cursor) {
		let page = document.getElementById("page");
		page.style.cursor = cursor;
	}
	
	function StartDrag(type) {
		if(type == 'VT') { isDraggingVT = true; SetCursor("n-resize");}
		if(type == 'VB') { isDraggingVB = true; SetCursor("n-resize");}
	}
	
	function EndDrag(e) {
		if(isDraggingVT || isDraggingVB) {
			dataTableDrawAll(); // dataTable 전체 reload
			isDraggingVT = false;
			isDraggingVB = false;
			SetCursor("auto");
		}
	}

	//최소화 기능인데 나중에 요청하면 만들어주기
	/* function minimum(node) {
		let id = $(node).attr('id');

		if(id == 'dragbarVT') {
			let dragbarWidth = 4;

			let page_height = parseInt($('#page').height()); 			// 전체 높이
			let rightcolT_height = parseInt($('#rightcolT').height());	// 우측 상단
			let rightcolM_height = parseInt($('#rightcolM').height());	// 우측 중단
			let rightcolB_height = parseInt($('#rightcolB').height());	// 우측 하단

			let rightcolT_min_height = 100;	// 우측 상단 최소높이
			let rightcolM_min_height = 34;	// 우측 중단 최소높이
			let rightcolB_min_height = 34;	// 우측 하단 최소높이

			let dragbarV_height = 4;

			let cols = [];

			//최소화기능만 적용
			cols = [
				page_height - rightcolB_height - rightcolM_min_height - dragbarWidth*2,
				dragbarWidth,
				rightcolM_min_height,
				dragbarWidth,
				rightcolB_height
			];
			
			let newColDefn = cols.map(c => c.toString() + "px").join(" ");
			
			$('#page').css('grid-template-rows',newColDefn);
		} else if(id == 'dragbarVB') {
			let dragbarWidth = 4;

			let page_height = parseInt($('#page').height()); 			// 전체 높이
			let rightcolT_height = parseInt($('#rightcolT').height());	// 우측 상단
			let rightcolM_height = parseInt($('#rightcolM').height());	// 우측 중단
			let rightcolB_height = parseInt($('#rightcolB').height());	// 우측 하단

			let rightcolT_min_height = 100;	// 우측 상단 최소높이
			let rightcolM_min_height = 34;	// 우측 중단 최소높이
			let rightcolB_min_height = 34;	// 우측 하단 최소높이

			let dragbarV_height = 4;

			let cols = [];

			cols = [
				rightcolT_height,
				dragbarWidth,
				page_height - rightcolT_height - rightcolB_min_height - dragbarWidth*2,
				dragbarWidth,
				rightcolB_min_height
			];
			
			let newColDefn = cols.map(c => c.toString() + "px").join(" ");
			
			$('#page').css('grid-template-rows',newColDefn);
		}

		dataTableDrawAll(); // dataTable 전체 reload
	} */
	
	function OnDrag(event) {
		if (isDraggingVT) { // middlecolT와 middlecolM 사이
			let dragbarWidth = 4;

			let page_height = parseInt($('#page').height()); 			// 전체 높이
			let middlecolT_height = parseInt($('#middlecolT').height());	// 우측 상단
			let middlecolM_height = parseInt($('#middlecolM').height());	// 우측 중단
			let middlecolB_height = parseInt($('#middlecolB').height());	// 우측 하단

			let middlecolT_min_height = 100;	// 우측 상단 최소높이
			let middlecolM_min_height = 34;	// 우측 중단 최소높이
			let middlecolB_min_height = 34;	// 우측 하단 최소높이

			let cursorY = event.clientY;	// 현재 cursor y좌표(위에서부터 얼마나 떨어졌는지)

			
			let cols = [
				Math.min(Math.max(middlecolT_min_height, cursorY), page_height - middlecolB_height - middlecolM_min_height - dragbarWidth*2),
				dragbarWidth,
				page_height - middlecolB_height - dragbarWidth*2 - Math.min(Math.max(middlecolT_min_height, cursorY), page_height - middlecolB_height - middlecolM_min_height - dragbarWidth*2),
				dragbarWidth,
				middlecolB_height
			];

	
			let newColDefn = cols.map(c => c.toString() + "px").join(" ");

			$('#page').css('grid-template-rows',newColDefn);
	
			event.preventDefault();
		} else if (isDraggingVB) { // 상하 스크롤
			let dragbarWidth = 4;

			let page_height = parseInt($('#page').height()); 			// 전체 높이
			let middlecolT_height = parseInt($('#middlecolT').height());	// 우측 상단
			let middlecolM_height = parseInt($('#middlecolM').height());	// 우측 중단
			let middlecolB_height = parseInt($('#middlecolB').height());	// 우측 하단

			let middlecolT_min_height = 100;	// 우측 상단 최소높이
			let middlecolM_min_height = 34;	// 우측 중단 최소높이
			let middlecolB_min_height = 34;	// 우측 하단 최소높이

			let cursorY = event.clientY;	// 현재 cursor y좌표(위에서부터 얼마나 떨어졌는지)
			
			let cols = [
				middlecolT_height,
				dragbarWidth,
				Math.min(Math.max(cursorY - middlecolT_height - dragbarWidth, middlecolM_min_height), page_height - middlecolT_height - dragbarWidth*2 - middlecolB_min_height),
				dragbarWidth,
				Math.max(middlecolB_min_height, page_height - middlecolT_height - dragbarWidth*2 - Math.max(cursorY - middlecolT_height - dragbarWidth, middlecolM_min_height))
			];
	
			let newColDefn = cols.map(c => c.toString() + "px").join(" ");
	
			$('#page').css('grid-template-rows',newColDefn);
	
			event.preventDefault();
		}
	}
</script>

<script>
	WM_init('new');
	WM_init('edit');
	WM_init('prcssNew');
	
	// 공통코드 조회
	let itemGubunList = getCommonCode('일반', '001'); // 제품구분
	let woodenList = getCommonCode('일반', '004'); // 목형번호
	let bundleList = getCommonCode('일반', '005'); // 묶음코드
	let printingYnCheckList = getCommonCode('일반', '008'); // 착인여부점검
	let inspectMethodList = getCommonCode('일반', '009'); // 검수방법
	let packMethodList = getCommonCode('일반', '013'); // 포장방법
	let outsrcGubunList = getCommonCode('일반', '024'); // 외주구분
	//let wdGubunList = getCommonCode('일반', '025'); // 소모품구분
	
	selectBoxAppend(itemGubunList, 'itemGubun', '', '2'); //포장방법
	selectBoxAppend(woodenList, 'woodenCareCd', '', '2'); //목형관리번호
	selectBoxAppend(bundleList, 'bundleMethod', '', '2'); //묶음법
	selectBoxAppend(printingYnCheckList, 'printingYnCheck', '', '2'); //착인여부점검
	selectBoxAppend(inspectMethodList, 'inspectMethod', '', '2'); //검수방법
	selectBoxAppend(packMethodList, 'packMethod', '', '2'); //포장방법
	
	let sessionUserNm = "${userNm}";//세션에서 가져온 유저이름
	let delStatus = '';
	let workOrdIdxVal = '';
	let itemIdxVal = '';
	let bodIdxVal = '';
	let workOrdPrcssIdxVal = '';
	let prcssIdxVal = '';
	let equipIdxVal = '';
	
	let startDate = moment().subtract('w',1).format('YYYY-MM-DD').replaceAll('-','');
	let endDate = moment().format('YYYY-MM-DD');
	
	$('#startDate').val(moment().subtract('w',1).format('YYYY-MM-DD'));
	$('#endDate').val(moment().format('YYYY-MM-DD'));
	
	//날짜
	let today = new Date();   
	let year = today.getFullYear(); // 년도
	let month = ( '0' + (today.getMonth() + 1) ).slice(-2) ;  // 월
	let date = ('0' + today.getDate()).slice(-2);  // 날짜
	let todayVal = year + '-' + month + '-' + date; // 오늘날짜 YYYY-MM-DD형태
	$('#priceDate').val(moment().format('YYYY-MM-DD'));
	

	$(document).ready(function() {
		cssChange('printTable');
		cssChange('printProduceTable');
		_promise_().then(()=>{
		$('#my-spinner').show();
		}).then(()=>{
		//조회조건append
		//공정코드
		$.ajax({
			url: '<c:url value="/bm/prcssListAll"/>',
            type: 'GET',
            async: false,
            data: {
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if(res.result == 'ok'){
					let data = res.data;
					$('#prcssCdList').empty();
					$('#prcssCdList').append($('<option value="">전체</option>'));
					for(var i = 0 ; i< data.length;i++){
						let option = $('<option value="'+data[i].idx+'">'+data[i].prcssNm+'</option>');
						$('#prcssCdList').append(option);
					}
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
			}
		});
		//설비목록
		$.ajax({
			url: '<c:url value="/em/equipInfoListAll"/>',
            type: 'GET',
            async: false,
            data: {
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if(res.result == 'ok'){
					let data = res.data;
					$('#equipList').empty();
					$('#equipList').append($('<option value="">전체</option>'));
					for(var i = 0 ; i< data.length;i++){
						let option = $('<option value="'+data[i].idx+'">'+data[i].equipNm+'</option>');
						$('#equipList').append(option);
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
	});
	
	/**************************************************************작지목록**************************************************************/
	// 작지 목록조회
	$('#workOrderTable thead tr').clone(true).addClass('filters').appendTo('#workOrderTable thead'); // filter 생성
	let workOrderTable = $('#workOrderTable').DataTable({
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
			url : '<c:url value="/wm/workOrdLstWithPrcssByOrdDate"/>',
			type : 'POST',
			data : {
				'startDate' : function(){return startDate;},
				'endDate'	: function(){return endDate;},
				'prcssIdx'  : function(){return prcssIdxVal;},
				'equipIdx'  : function(){return equipIdxVal;}
			},
		}, 
        rowId: 'idx',
		columns : [
			{ className : 'text-center align-middle',
				render: function(data, type, row, meta) {
					return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;"><input type="checkbox" name="btnCheck" style="width:20px; height:20px;"></div>';
				}
			},//체크박스
			{ className : 'text-center align-middle',
				render: function(data, type, row, meta) {
					return '-';
				}
			},//생산상태
			{ className : 'text-center align-middle',
				render: function(data, type, row, meta) {
					return '-';
				}
			},//수주상태
			{ data : 'bizOrdDtlNo', className : 'text-center align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},//수주상세번호
			{ data : 'ordDate', className : 'text-center align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data).format('YYYY-MM-DD')+'</div>';
					} else {
						return '';
					}
				}
			},//생산지시일
			{ data : 'ordEndDate', className : 'text-center align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data).format('YYYY-MM-DD')+'</div>';
					} else {
						return '';
					}
				}
			},//목표요구일
			{ className : 'text-center align-middle',
				render: function(data, type, row, meta) {
					return '-';
				}
			},//완료예정일
			{ data : 'prcssNm', className : 'text-center align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},//공정명
			{ data : 'dealCorpNm', className : 'text-center align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},//수주처
			{ data : 'itemNm', className : 'text-center align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},//제품명
			{ data : 'bizOrdQty', className : 'text-end align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
					} else {
						return '0';
					}
				}
			},//수주수량
			{ data : 'workOrdQty', className : 'text-end align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
					} else {
						return '0';
					}
				}
			},//지시수량
			{ data : 'fairQty', className : 'text-end align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
					} else {
						return '0';
					}
				}
			},//생산량
			{ data : 'workOrdDesc', className : 'text-start align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},//작지 지시비고
			{ data : 'woodenWdCd', className : 'text-center align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},//목형번호
			{ data : 'resinBoardWdCd', className : 'text-center align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},//수지판번호
			{ data : 'bizOrdIssue', className : 'text-start align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space:pre-line;width:330px;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},//수주특이사항
			{ data : 'bizOrdNote', className : 'text-start align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space:pre-line;width:330px;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},//수주전달사항
		],
		columnDefs : [
			/*{
				targets: '_all',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					}
				}
			},*/
			{ "targets": [0], "orderable": false },
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
			let theadHeight = parseFloat($('#workOrderTable_wrapper').find('.dataTables_scrollHead').css('height'));
			let	topHeight = parseFloat($('#middlecolT').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(topHeight - theadHeight - 77)+'px');
			//$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('overflow-y','scroll');
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
				let cell = $('#workOrderTable_wrapper').find('.filters th').eq(
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
				$('#workOrderTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup change').on('change', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('change');
				});
			});
		},
	});
	// dataTable colReorder event
	workOrderTable.on('column-reorder', function( e, settings, details ) {
		let api = workOrderTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#workOrderTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup change').on('change', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('change');
			});
		});
	});

	$('#workOrderTable tbody').on('click','tr', function() {
		let data = workOrderTable.row(this).data();
		workOrdIdxVal = data.workOrdIdx;
		workOrdPrcssIdxVal = data.workOrdPrcssIdx;
		itemIdxVal = data.itemIdx;
		bodIdxVal = data.bizOrdDtlIdx;
		inputMaterialHistTable.ajax.reload();
		workOrderPrcssTable.ajax.reload(function(){
			$('#workOrderPrcssTable tbody tr').each(function(index){
				let node = workOrderPrcssTable.row(index).node();
				if(workOrderPrcssTable.row(index).data() != undefined && workOrderPrcssTable.row(index).data() != ''){
					let multipleNode = $(node).find('td').eq(6).find('select[name=workMethodMultiSelect]');
					$(multipleNode).select2({
			    		data: JSON.parse(workOrderPrcssTable.row(index).data().workMethodJson),
			    		multiple : true,
			    		placeholder: "작업방법 선택",
			    	});
					$(node).find('td').eq(6).find('span').eq(0).css('width','100%');
			    	$(node).find('td').eq(6).find('.select2-search__field').css('width','100%');
			    	$(node).find('td').eq(6).find('.select2-selection__rendered').attr('style','display:flex; align-content:flex-start; flex-direction:column; flex-wrap:wrap; overflow:auto;');
			    	
					if( workOrderPrcssTable.row(index).data().workMethod != null && workOrderPrcssTable.row(index).data().workMethod != ''){
						let splitData =  workOrderPrcssTable.row(index).data().workMethod.split(',');
						$(node).find('td').eq(6).find('select[name=workMethodMultiSelect]').val(splitData).trigger('change')
					}
					
					$(node).find('td').eq(6).find('select[name=workMethodMultiSelect]').attr('disabled',true);
				}
				
				workOrderPrcssTable.draw(false);
			});
		
		});
	});
	
	$('#btnSearch').on('click',function(){
		startDate = $('#startDate').val().replaceAll('-','');
		endDate = $('#endDate').val().replaceAll('-','');
		prcssIdxVal = $('#prcssCdList').val();
		equipIdxVal = $('#equipList').val();
		workOrderTable.ajax.reload(function(){
			$('#btnAllCheck').prop('checked',false);
		});
	});
	
	// 모든 체크박스 체크/해제 되도록
	$(document).on('change','input:checkbox[name=btnCheck]', function(){
		if( $('input:checkbox[name=btnCheck]').length == $('input:checkbox[name=btnCheck]:checked').length ){ //전체 체크박스 수와 체크된 박스의 수가 같을 때 -> 전체체크박스 체크 , 아닐 경우 해제
			$('#btnAllCheck').prop('checked',true);
		} else{
			$('#btnAllCheck').prop('checked',false);
		}
 	});

	//모든 체크박스 선택
	$('#btnAllCheck').on('click',function(){
		if($('#btnAllCheck').prop("checked")){
			$('input:checkbox[name=btnCheck]').prop('checked',true);
		}else{
			$('input:checkbox[name=btnCheck]').prop('checked',false);
		}
	});

	/**************************************************************작지 공정 목록**************************************************************/
	// 작지 목록조회
	$('#workOrderPrcssTable thead tr').clone(true).addClass('filters').appendTo('#workOrderPrcssTable thead'); // filter 생성
	let workOrderPrcssTable = $('#workOrderPrcssTable').DataTable({
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
		/* rowReorder: {
			enable: true,
			dataSrc: 'prcssOrder',
		}, */
		select: {
            style: 'single',
            toggleable: false,
            items: 'row',
            info: false
        },
        ajax : {
			url : '<c:url value="/wm/workOrdLstWithPrcssByWorkOrd"/>',
			type : 'POST',
			data : {
				'workOrdIdx' : function(){return workOrdIdxVal;},
			},
		},
        rowId: 'workOrdPrcssIdx',
		columns : [
			{ data: 'prcssOrder', className : 'text-center align-middle'},//순번
			{ data: 'progressStatus', className : 'text-center align-middle',
				render: function(data, type, row, meta) {
					if(data == 'PI'){
						return '대기';
					} else if(data == 'WI'){
						return '진행';
					} else if(data == 'WC'){
						return '완료';
					} else {
						return '-';
					}
				}
			},//공정작업상태
			{ data : 'prcssCd', className : 'text-center align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},//공정코드
			{ data : 'prcssNm', className : 'text-center align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},//공정명
			{ data : 'workOrdQty', className : 'text-end align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
					} else {
						return '0';
					}
				}
			},//지시수량
			{ data : 'fairQty', className : 'text-end align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
					} else {
						return '0';
					}
				}
			},//생산량
			{ data: 'workMethod', className : 'text-center align-middle',
				render: function(data, type, row, meta) {
					if( data == null ){
						return '<select class="form-select" name="workMethodMultiSelect">';
					} else {
						return '<select class="form-select" name="workMethodMultiSelect">';
					}
				}
			},//작업방법
			{ className : 'text-center align-middle',
				render: function(data, type, row, meta) {
					return '-';
				}
			},//단위?
			{ className : 'text-center align-middle',
				render: function(data, type, row, meta) {
					return '-';
				}
			},//비고?
			{ className : 'text-center align-middle',
				render: function(data, type, row, meta) {
					return '-';
				}
			},//주의사항?
			
		],
		columnDefs : [
			{ "targets": '_all', "orderable": false },
			/*{
				targets: '_all',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					}
				}
			},*/
		],
		buttons : [
			{ extend: 'excel',	text: 'Excel',	charset: 'UTF-8', bom: true },
			{ extend: 'pdf',	text: 'PDF',	},
			{ extend: 'print',	text: 'Print',		charset: 'UTF-8', bom: true },
			{ extend: 'colvis',	text: 'Select Col',	},
		],
		order : [[0,'asc']],
		drawCallback: function() {
			let api = this.api();
			let data = api.data();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID

			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#workOrderPrcssTable_wrapper').find('.dataTables_scrollHead').css('height'));
			let	topHeight = parseFloat($('#middlecolM').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(topHeight - theadHeight - 10)+'px');
			//$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('overflow-y','scroll');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAll').off('keyup',function() {});
			$('#searchAll').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			});
			for(var i=0;i<data.length;i++) {
				let tr = $('#' + table_id + ' tbody').find('tr').eq(i);
				workOrderPrcssTable.row(tr).data().prcssOrder = i+1;
				$(tr).find('td').eq(0).html(i+1);
			}

			let rowData = api.data().toArray();
			if(rowData.length != 0){
				for(var i = 0; i < rowData.length ; i++){
					if(rowData[i].workOrdPrcssIdx == workOrdPrcssIdxVal){
						let node = api.row('#'+rowData[i].workOrdPrcssIdx).node();
						$(node).css('background-color','rgb(246 242 195)');
					}
				}
			}

		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#workOrderPrcssTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();
				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#workOrderPrcssTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup change').on('change', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('change');
				});
			});
		},
	});
	// dataTable colReorder event
	workOrderPrcssTable.on('column-reorder', function( e, settings, details ) {
		let api = workOrderPrcssTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#workOrderPrcssTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup change').on('change', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('change');
			});
		});
	});

	/******************************************* 투입자재내역 *******************************************/
	
	// 투입자재내역 목록조회
	//$('#inputMaterialHistTable thead tr').clone(true).addClass('filters').appendTo('#inputMaterialHistTable thead'); // filter 생성
	let inputMaterialHistTable = $('#inputMaterialHistTable').DataTable({
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
		colReorder: true,
		select: {
            style: 'single',
            toggleable: false,
            items: 'row',
            info: false
        },
        ajax : {
			url : '<c:url value="/wm/workOrdInputMaterialLst"/>',
			type : 'POST',
			data : {
				'itemIdx' : function(){ return itemIdxVal; },
				'bodIdx'  : function(){ return bodIdxVal; },
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'matrlCd', className : 'text-center'},
			{ className : 'text-center',
				render: function(data, type, row, meta) {
					if((row['sizeX'] == null || row['sizeX'] == '') && (row['sizeY'] != null && row['sizeY'] != '')){
						return '0*' + addCommas(parseFloat(row['sizeY']));
					} else if((row['sizeX'] != null && row['sizeX'] != '') && (row['sizeY'] == null || row['sizeY'] == '')) {
						return addCommas(parseFloat(row['sizeX'])) + '*0';
					} else if((row['sizeX'] != null && row['sizeX'] != '') && (row['sizeY'] != null && row['sizeY'] != '')){
						return addCommas(parseFloat(row['sizeX'])) + '*' + addCommas(parseFloat(row['sizeY']));
					} else {
						return '0*0';
					}
				}
			},//장 * 폭
			{ className : 'text-center',
				render: function(data, type, row, meta) {
					return addCommas(parseFloat(row['cutQty'])) + '절/' + addCommas(parseFloat(row['eaQty'])) + '개';
				}
			},// 절수/개수
			{  className : 'text-center',
				render: function(data, type, row, meta) {
					let ordQty = parseInt(row['purchaseOrdQty']); // 주문수량(제품)
					let cutQty = parseInt(row['cutQty']); // 절수
					let eaQty = parseInt(row['eaQty']); // 개수
					let extraQty = parseInt(row['extraQty']); // 여유분
					
					if(cutQty == 0 || eaQty == 0) {
						return '0';
					} else {
						let printPressQty = Math.ceil(ordQty/eaQty);
						let pressQty = Math.ceil((printPressQty + extraQty)/cutQty);
						
						let R = parseInt(pressQty / 500); // R로 환산
						let finalPurchaseQty = R + "R" + (pressQty % 500);
						
						return finalPurchaseQty;
					}
					//return addCommas(parseFloat(row['purchaseOrdQty'])) + '+' + addCommas(parseFloat(row['extraQty']));
				}
			},//발주량+여분
			{  data: 'inQty', className : 'text-end',
				render: function(data, type, row, meta) {
					if(data != null && data != ''){
						return addCommas(parseFloat(data));
					} else {
						return '0';
					}
				}
			},//입고량
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
			/* { extend: 'excel',	text: 'Excel',	charset: 'UTF-8', bom: true },
			{ extend: 'pdf',	text: 'PDF',	},
			{ extend: 'print',	text: 'Print',		charset: 'UTF-8', bom: true },
			{ extend: 'colvis',	text: 'Select Col',	}, */
		],
		order : [],
		drawCallback: function() {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#inputMaterialHistTable_wrapper').find('.dataTables_scrollHead').css('height'));
			let	topHeight = parseFloat($('#middlecolB').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(topHeight - theadHeight - 10)+'px');
			//$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('overflow-y','scroll');
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
				let cell = $('#inputMaterialHistTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#inputMaterialHistTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup change').on('change', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('change');
				});
			});
		},
	});
	// dataTable colReorder event
	inputMaterialHistTable.on('column-reorder', function( e, settings, details ) {
		let api = inputMaterialHistTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#inputMaterialHistTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup change').on('change', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('change');
			});
		});
	});

	/******************************* 제조지시서 인쇄  *******************************/
	$('#btnProduceOrdPrint').on('click',function(){
		$('#my-spinner').show();
		
		cssChange('printProduceTable');
		$('#printProduceTable').print({
			globalStyles: true,
			mediaPrint: true
		});
		
		setTimeout(function() {
			$('#my-spinner').hide();
		}, 200);
	});

	/******************************* 공정작업지시서 인쇄  *******************************/
	$('#btnPrcssWorkOrdPrint').on('click',function(){
		cssChange('printTable');

		html2canvas($('#printTable')[0], {
			allowTaint : true,	// cross-origin allow
			useCORS: true,		// CORS 사용한 서버로부터 이미지 로드할 것인지 여부
			scale : 2			// 기본 96dpi에서 해상도를 두 배로 증가
		}).then(function(canvas) {
			var element = document.getElementById('printTable');
			var opt = {
			  margin:       3,
			  filename:     moment().format('YYYYMMDD')+'_공정작업지시서.pdf',
			  image:        { type: 'jpeg', quality: 0.98 },
			  html2canvas:  { scale: 1 },
			  jsPDF:        { unit: 'mm', format: 'a4', orientation: 'landscape'}
			};
			// New Promise-based usage:
			html2pdf().from(element).set(opt).save().then(() => {
			});
		});
		
	});

	// 초기 셋팅
	$(document).ready(function() {
		for(var i=0;i<55;i++) { // 발주상세 빈공간 생성
			$('#trAppendTarget2').after(makeEmptyTr());
		}
		cssChange('printProduceTable');
		$('#my-spinner').hide();
	});


	$(document).on('change','#btnAllCheck, input[name=btnCheck]', function() {
		$('.dtlList').find('td').html('&nbsp;');
		let dataList = [];
		for(var i=0;i<workOrderTable.data().count();i++) {
			let node = workOrderTable.row(i).node();
			let data = workOrderTable.row(i).data();
			let check = $(node).find('td').eq(0).find('input').prop('checked');
			//체크 된거만 넣어주기
			if(check) {
				let obj = {}; 
				obj.bizOrdDtlNo = data.bizOrdDtlNo; //수주상세번호
				obj.ordDate = data.ordDate; //생산지시일
				obj.ordEndDate = data.ordEndDate; //목표요구일
				obj.prcssNm = data.prcssNm; //공정명
				obj.dealCorpNm = data.dealCorpNm; //수주처
				obj.itemNm = data.itemNm; //제품명
				obj.bizOrdQty = ( data.bizOrdQty == null || data.bizOrdQty == '' ) ? 0 : data.bizOrdQty; //수주수량
				obj.workOrdQty = ( data.workOrdQty == null || data.workOrdQty == '' ) ? 0 : data.workOrdQty; //지시수량
				obj.fairQty = ( data.fairQty == null || data.fairQty == '' ) ? 0 : data.fairQty; //생산량
				obj.workOrdDesc = data.workOrdDesc; //작지비고
				obj.woodenWdCd = data.woodenWdCd; //목형번호
				obj.resinBoardWdCd = data.resinBoardWdCd; //수지판번호
				obj.bizOrdIssue = data.bizOrdIssue; //수주특이사항
				obj.bizOrdNote = data.bizOrdNote; //수주전달사항
				dataList.push(obj);
			}
		}
		//리스트목록 삭제
		$('.dtlList').remove();
		//첫번째행 만들기
		$('#trAppendTarget').after(makeEmptyTr());
		for(var i=0;i<dataList.length;i++) {
			$('.dtlList').eq(i).find('td').eq(0).html('-');//생산상태
			$('.dtlList').eq(i).find('td').eq(1).html('-');//수주상태
			$('.dtlList').eq(i).find('td').eq(2).html(dataList[i].bizOrdDtlNo);//수주상세번호
			$('.dtlList').eq(i).find('td').eq(3).html(moment(dataList[i].ordDate).format('YYYY-MM-DD'));//생산지시일
			$('.dtlList').eq(i).find('td').eq(4).html(moment(dataList[i].ordEndDate).format('YYYY-MM-DD'));//목표요구일
			$('.dtlList').eq(i).find('td').eq(5).html('-');//생산완료예정일
			$('.dtlList').eq(i).find('td').eq(6).html(dataList[i].prcssNm);//공정명
			$('.dtlList').eq(i).find('td').eq(7).html(dataList[i].dealCorpNm);//수주처
			$('.dtlList').eq(i).find('td').eq(8).html(dataList[i].itemNm);//제품명
			$('.dtlList').eq(i).find('td').eq(9).html(addCommas(parseFloat(dataList[i].bizOrdQty)));//수주수량
			$('.dtlList').eq(i).find('td').eq(10).html(addCommas(parseFloat(dataList[i].workOrdQty)));//지시수량
			$('.dtlList').eq(i).find('td').eq(11).html(addCommas(parseFloat(dataList[i].fairQty)));//생산량
			$('.dtlList').eq(i).find('td').eq(12).html(dataList[i].workOrdDesc);//지시비고
			$('.dtlList').eq(i).find('td').eq(13).html(dataList[i].woodenWdCd);//목형번호
			$('.dtlList').eq(i).find('td').eq(14).html(dataList[i].resinBoardWdCd);//수지판번호
			$('.dtlList').eq(i).find('td').eq(15).html(dataList[i].bizOrdIssue);//수주특이사항
			$('.dtlList').eq(i).find('td').eq(16).html(dataList[i].bizOrdNote);//수주전달사항

			//마지막행이 아니면 -> 다음행 생성 
			if( i+1 != dataList.length){
				$('.dtlList').eq(i).after(makeEmptyTr());
			}
		}
	});

	function makeEmptyTr() {
		let html = '';
			html += '<tr class="dtlList">';
			html += '	<td colspan="1"  class="text-center fs-8 align-middle not-left tbodyFirstCol">&nbsp;</td>';
			html += '	<td colspan="1"  class="text-center fs-8 align-middle not-left tbodyNotFirstCol">&nbsp;</td>';
			html += '	<td colspan="2"  class="text-center fs-8 align-middle not-left tbodyNotFirstCol">&nbsp;</td>';
			html += '	<td colspan="2"  class="text-center fs-8 align-middle not-left tbodyNotFirstCol">&nbsp;</td>';
			html += '	<td colspan="2"  class="text-center fs-8 align-middle not-left tbodyNotFirstCol">&nbsp;</td>';
			html += '	<td colspan="2"  class="text-center fs-8 align-middle not-left tbodyNotFirstCol">&nbsp;</td>';
			html += '	<td colspan="2"  class="text-center fs-8 align-middle not-left tbodyNotFirstCol">&nbsp;</td>';
			html += '	<td colspan="2"  class="text-center fs-8 align-middle not-left tbodyNotFirstCol">&nbsp;</td>';
			html += '	<td colspan="3"  class="text-center fs-8 align-middle not-left tbodyNotFirstCol">&nbsp;</td>';
			html += '	<td colspan="1"  class="text-end fs-8 align-middle not-left tbodyNotFirstCol">&nbsp;</td>';
			html += '	<td colspan="1"  class="text-end fs-8 align-middle not-left tbodyNotFirstCol">&nbsp;</td>';
			html += '	<td colspan="1"  class="text-end fs-8 align-middle not-left tbodyNotFirstCol">&nbsp;</td>';
			html += '	<td colspan="2"  class="text-center fs-8 align-middle not-left tbodyNotFirstCol">&nbsp;</td>';
			html += '	<td colspan="1"  class="text-center fs-8 align-middle not-left tbodyNotFirstCol">&nbsp;</td>';
			html += '	<td colspan="1"  class="text-center fs-8 align-middle not-left tbodyNotFirstCol">&nbsp;</td>';
			html += '	<td colspan="3"  class="text-start fs-8 align-middle not-left tbodyNotFirstCol" style="white-space:pre-line;width:330px;">&nbsp;</td>';
			html += '	<td colspan="3"  class="text-start fs-8 align-middle not-left tbodyNotFirstCol" style="white-space:pre-line;width:330px;">&nbsp;</td>';
			html += '</tr>';

		return html;
	}

	function cssChange(tableId) {
		$('#' + tableId).find('td').css('font-weight', '900');
		$('#' + tableId).find('td').css('border', '2px solid black');
		$('#' + tableId).find('td').css('padding', '0.1rem');
		$('#' + tableId).find('td').css('color', '#000000');

		$('#' + tableId).find('.bg-gray').css('background-color', '#f2f2f2');
		$('#' + tableId).find('.theadNotFisrtCol').css('border-left', '0px');
		$('#' + tableId).find('.tbodyFirstCol').css('border-top', '0px');
		$('#' + tableId).find('.tbodyNotFirstCol').css('border-left', '0px');
		$('#' + tableId).find('.tbodyNotFirstCol').css('border-top', '0px');
		$('#' + tableId).find('.fs-8').css('font-size', '8px');
		$('#' + tableId).find('.fs-10').css('font-size', '10px');
		$('#' + tableId).find('.fs-13').css('font-size', '13px');
		$('#' + tableId).find('.fs-15').css('font-size', '15px');
		$('#' + tableId).find('.fs-20').css('font-size', '20px');
		$('#' + tableId).find('.fs-30').css('font-size', '30px');
		$('#' + tableId).find('.fs-50').css('font-size', '50px');
		$('#' + tableId).find('.fc-red').css('color', '#ff0000');
		$('#' + tableId).find('.bt-2').css('border-top', '2px solid black');
		$('#' + tableId).find('.bd-n').css('border', '1px solid #ffffff');
		$('#' + tableId).find('.bt-n').css('border-top', '1px solid #ffffff');
		$('#' + tableId).find('.br-n').css('border-right', '1px solid #ffffff');
		$('#' + tableId).find('.bb-n').css('border-bottom', '1px solid #ffffff');
		$('#' + tableId).find('.bl-n').css('border-left', '1px solid #ffffff');
		$('#' + tableId).find('.h-5').css('height', '5px');
		$('#' + tableId).find('.h-10').css('height', '10px');
		$('#' + tableId).find('.h-20').css('height', '20px');
		$('#' + tableId).find('.h-30').css('height', '30px');
		$('#' + tableId).find('.h-40').css('height', '40px');
		$('#' + tableId).find('.h-55').css('height', '55px');
		$('#' + tableId).find('.h-70').css('height', '70px');
		$('#' + tableId).find('.h-100').css('height', '100px');

		// 인쇄할 때 css 적용하려면 important 붙여줘야함.
		for(var i=0;i<$('#' + tableId).find('td').length;i++) {
			let tdStyle = $('#' + tableId).find('td').eq(i).attr('style') == undefined?'':$('#' + tableId).find('td').eq(i).attr('style');
			$('#' + tableId).find('td').eq(i).attr('style',tdStyle.replaceAll(';',' !important;'));
		}
	}
	
</script>
</body>
</html>