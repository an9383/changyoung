<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/top.jsp"%>
<%@include file="../layout/modal.jsp"%>
<%@include file="../layout/script.jsp"%>
<div id="page" onmouseup="EndDrag()" onmousemove="OnDrag(event)" style="grid-template-areas: 'rightcol';
																		  grid-template-rows: 1fr;
																		  grid-template-columns: 1fr;">
	<div id="rightcol">
		<div class="container-fluid h-100" style="padding: 5px;">
			<div class="row" id="rightHeader" style="padding-bottom: 5px;">
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
					
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100" style="background-color: #ffb4b4;">수량부족</label>
					<input type="text" class="form-control w-auto h-100 me-1" id="searchAll" placeholder="통합검색" >
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end">
					<select class="form-select w-auto h-100 me-1" id="printPaperType">
					</select>
				
					<div class="btn-group me-3" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto" id="btnBizDtlPoEnd">PO완료</button>
						<button type="button" class="btn btn-outline-light w-auto" id="btnlabelPrint">라벨 출력</button>
					</div>
				
					<div class="btn-group" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnDtlSearch"><i class="fa-regular fa-clipboard"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnSave" disabled><i class="fa-regular fa-floppy-disk"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnEdit" ><i class="fa-regular fa-pen-to-square"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnCancel" disabled><i class="fa-solid fa-xmark"></i></button>
					</div>
				</div>
			</div>
			<div class="row">
				<table class="table table-bordered p-0 m-0" id="bizOrderDtlTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle"><input type="checkbox" id="btnAllCheck" style="width:20px; height:20px;"></th>
							<th class="text-center align-middle">수주상세번호</th>
							<th class="text-center align-middle">고객사</th>
							<th class="text-center align-middle" style="min-width:300px;max-width:300px;">제품명</th>
							<th class="text-center align-middle">수주상태</th>
							<th class="text-center align-middle">진행상태</th>
							<th class="text-center align-middle">제품<br>검사</th>
							<th class="text-center align-middle">수주<br>수량</th>
							<th class="text-center align-middle">기출고<br>수량</th>
							<th class="text-center align-middle"><span style="color:#ff0000;">*</span>출고량</th>
							<th class="text-center align-middle">꼬리표<br>비고</th>
							<!-- <th class="text-center align-middle">재고활용수량</th> -->
							<th class="text-center align-middle">현재고</th>
							<th class="text-center align-middle">생산<br>수량</th>
							<th class="text-center align-middle">목표요구일</th>
							<th class="text-center align-middle">납품요구일</th>
							<th class="text-center align-middle">출고일</th>
							<th class="text-center align-middle">출하비고사항</th>
							<th class="text-center align-middle">건별주의사항</th>
							<th class="text-center align-middle">포장<br>단위</th>
							<th class="text-center align-middle">포장<br>박스</th>
							<th class="text-center align-middle">박스<br>수량</th>
							<th class="text-center align-middle"><span style="color:#ff0000;">*</span>납품처</th>
							<th class="text-center align-middle"><span style="color:#ff0000;">*</span>납품장소</th>
							<!-- <th class="text-center align-middle"><span style="color:#ff0000;">*</span>사업장구분</th> -->
							<th class="text-center align-middle">출고차량</th>
							<th class="text-center align-middle colvisHide"><span style="color:#ff0000;">*</span>창고</th>
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
<!-- 꼬리표 모달 -->
<div class="modal fade" id="tailTableModal" tabindex="-1" aria-hidden="true" style="z-index: 9999;">
	<div class="modal-dialog" style="max-width:40vw;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">꼬리표 모달</h5>
			</div>
			<div class="modal-body">
				<div class="row" style="min-width: 19cm;
										max-width: 19cm;
										min-height: 10.8cm;
										max-height: 10.8cm;">
					<table id="tailTable" class="table table-bordered m-0 d-none" style="border:1px solid #ffffff;transform: scaleX(-1) scaleY(-1);">
						<colgroup id="trTtailTableAppendTarget">
							<col width="1%"><col width="1%"><col width="1%"><col width="1%"><col width="1%">
							<col width="1%"><col width="1%"><col width="1%"><col width="1%"><col width="1%">
							<col width="1%"><col width="1%"><col width="1%"><col width="1%"><col width="1%">
							<col width="1%"><col width="1%"><col width="1%"><col width="1%"><col width="1%">
							<col width="1%"><col width="1%"><col width="1%"><col width="1%"><col width="1%">
							<col width="1%"><col width="1%"><col width="1%"><col width="1%"><col width="1%">
							<col width="1%"><col width="1%"><col width="1%"><col width="1%"><col width="1%">
							<col width="1%"><col width="1%"><col width="1%"><col width="1%"><col width="1%">
							<col width="1%"><col width="1%"><col width="1%"><col width="1%"><col width="1%">
							<col width="1%"><col width="1%"><col width="1%"><col width="1%"><col width="1%">
							<col width="1%"><col width="1%"><col width="1%"><col width="1%"><col width="1%">
							<col width="1%"><col width="1%"><col width="1%"><col width="1%"><col width="1%">
							<col width="1%"><col width="1%"><col width="1%"><col width="1%"><col width="1%">
							<col width="1%"><col width="1%"><col width="1%"><col width="1%"><col width="1%">
							<col width="1%"><col width="1%"><col width="1%"><col width="1%"><col width="1%">
							<col width="1%"><col width="1%"><col width="1%"><col width="1%"><col width="1%">
							<col width="1%"><col width="1%"><col width="1%"><col width="1%"><col width="1%">
							<col width="1%"><col width="1%"><col width="1%"><col width="1%"><col width="1%">
							<col width="1%"><col width="1%"><col width="1%"><col width="1%"><col width="1%">
							<col width="1%"><col width="1%"><col width="1%"><col width="1%"><col width="1%">
						</colgroup>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 꼬리표 모달 끝 -->
<!-- 번들링 모달 -->
<div class="modal fade" id="bundlingLabelModal" tabindex="-1" aria-hidden="true" style="z-index: 9999;">
	<div class="modal-dialog" style="max-width:40vw;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">번들링 모달</h5>
			</div>
			<div class="modal-body">
				<div class="row">
					<table id="bundlingLabelTable" class="table table-bordered m-0 d-none" style="border:1px solid #ffffff;">
						<colgroup id="trBundlingLabelAppendTarget">
							<col width="1%"><col width="1%"><col width="1%"><col width="1%"><col width="1%">
							<col width="1%"><col width="1%"><col width="1%"><col width="1%"><col width="1%">
							<col width="1%"><col width="1%"><col width="1%"><col width="1%"><col width="1%">
							<col width="1%"><col width="1%"><col width="1%"><col width="1%"><col width="1%">
							<col width="1%"><col width="1%"><col width="1%"><col width="1%"><col width="1%">
							<col width="1%"><col width="1%"><col width="1%"><col width="1%"><col width="1%">
							<col width="1%"><col width="1%"><col width="1%"><col width="1%"><col width="1%">
							<col width="1%"><col width="1%"><col width="1%"><col width="1%"><col width="1%">
							<col width="1%"><col width="1%"><col width="1%"><col width="1%"><col width="1%">
							<col width="1%"><col width="1%"><col width="1%"><col width="1%"><col width="1%">
							<col width="1%"><col width="1%"><col width="1%"><col width="1%"><col width="1%">
							<col width="1%"><col width="1%"><col width="1%"><col width="1%"><col width="1%">
							<col width="1%"><col width="1%"><col width="1%"><col width="1%"><col width="1%">
							<col width="1%"><col width="1%"><col width="1%"><col width="1%"><col width="1%">
							<col width="1%"><col width="1%"><col width="1%"><col width="1%"><col width="1%">
							<col width="1%"><col width="1%"><col width="1%"><col width="1%"><col width="1%">
							<col width="1%"><col width="1%"><col width="1%"><col width="1%"><col width="1%">
							<col width="1%"><col width="1%"><col width="1%"><col width="1%"><col width="1%">
							<col width="1%"><col width="1%"><col width="1%"><col width="1%"><col width="1%">
							<col width="1%"><col width="1%"><col width="1%"><col width="1%"><col width="1%">
						</colgroup>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 번들링 모달 끝 -->

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
	let ordStatusList = getCommonCode('시스템', '022'); // 수주상태
	
	selectBoxAppend(carAssignmentList, 'carAssignment', '', '2'); //차량배정
	selectBoxAppend(dealGubunList, 'modalDealGubun', '', '1'); //거래구분
	selectBoxAppend(dealCorpStatusList, 'modalDealCorpStatus', '', '1'); //거래상태

	let overProdOutYn = getCommonCode('시스템', '027')[0].commonCd; //과출고여부

	let printPaperTypeList = getCommonCode('시스템', '054'); // 출고라벨종류
	selectBoxAppend(printPaperTypeList, 'printPaperType', '', '2'); //출고라벨종류
	
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

	// 수주상세목록조회
	$('#bizOrderDtlTable thead tr').clone(true).addClass('filters').appendTo('#bizOrderDtlTable thead'); // filter 생성
	let bizOrderDtlTable = $('#bizOrderDtlTable').DataTable({
		dom : "<'row'<'col-md-12 col-md-6'l><'col-md-12 col-md-6'f>>"
				+ "<'row'<'col-md-12'tr>>"
				+ "<'row pt-1'<'d-flex align-items-center d-flex'B><'me-lg-auto'><'d-flex align-items-center justify-content-end'i>>",
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
				'searchTarget' : function(){ return $('#searchTarget').val(); },
			},
		},
        rowId: '',
        columns : [
            {
            	className : 'text-center align-middle',
            	render : function(data, type, row, meta) {
            		return '<div style="display: flex;align-items: center;white-space: nowrap; text-overflow: ellipsis; overflow: hidden;"><input type="checkbox" name="btnCheck" style="width:20px; height:20px;"></div>';
				}		
            },
        	{ data: 'bizOrdDtlNo', className : 'text-center align-middle'},
        	{ data: 'bizDealCorpNm', className : 'text-center align-middle',		
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return "-";
					}
				}		
			},	//고객사
			{ data: 'itemCd', className : 'text-center align-middle',
				render: function(data, type, row, meta) {
					if(data != null && data != ''){
						let jsonData = JSON.parse(row['workMethodJson']);
						let isLess = false;
						if(jsonData!=null){
							for(var i=0; i<jsonData.length;i++){
								let calOrdQty = parseInt(jsonData[i].calOrdQty);
								let fairQty = parseInt(jsonData[i].fairQty);
								if(fairQty>0 && fairQty < calOrdQty){
									isLess = true;
									break;
								}
							}
							if( isLess ){
								return '<div> <big class="fw-bolder" style="color: #ff0000;">! </big>'+data+'</div>';
							} else {
								return data;
							} 
						} else {
							return data;
						}
						//return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						
					} else {
						return '';
					}
					
				}
			},//품목
			{ data: 'bizStatusCd', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data !=''){
						return _.filter(ordStatusList,v=>v.commonCd == data)[0].commonNm;
					} else {
						return "";
					}
				}
			},
			{ data: 'workMethodJson', className : 'text-center align-middle', //진행상태
				render : function(data, type, row, meta) {
					let outQty = isEmptyCheck(row['outQty']) ? 0 : parseInt(row['outQty']);
					let ordQty = row['ordQty'];
					if(ordQty <= outQty){
						return '출고완료';
					} else {
						if(data != '' && data != null) {
							let parseData = JSON.parse(data);
							//진행,완료된 공정의 리스트
							let filterList = parseData.filter(v=>v.progressStatus == 'WI' || v.progressStatus == 'WC');
							let finshPrcssCount = filterList.length;
							//진행 , 완료된 공정이 없다면 -> 첫 공정 작업대기 
							if(finshPrcssCount == 0){
	 							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">' + parseData[0].prcssNm + '(작업대기)</div>';
							} else if( finshPrcssCount > 0){
								// 진행 마지막 실적의 공정명, 모든 공정이 완료된(parseData길이 ==finshPrcssCount길이)경우 작업완료 
								let progressNm = '-';
								filterList = parseData.filter(v=>v.progressStatus == 'WC');
								finshPrcssCount = filterList.length;
								if( finshPrcssCount == parseData.length){
									progressNm = '생산완료';
								} else {
									// 작업중, 작업대기
									//pi,wc리스트
									let workFilterList = parseData.filter(v=>v.progressStatus == 'PI' || v.progressStatus == 'WI');
									if(workFilterList[0].progressStatus == 'PI'){
										progressNm = workFilterList[0].prcssNm + '(작업대기)';
									} else if(workFilterList[0].progressStatus == 'WI'){
										progressNm = workFilterList[0].prcssNm + '(작업중)';
									}
								}
	 							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">' + progressNm + '</div>';
							} else{
								return '-';
							}
						} else {
							return '-';
						}
					}
				}
			},
        	{ data: 'qualityJudgmentNm', className : 'text-center align-middle',		
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return "미판정";
					}
				}		
			},	//제품검사
			{ data: 'ordQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return addCommas(parseInt(data));
					} else {
						return '';
					}
				}
			}, //수주수량
			{ data: 'outQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					return addCommas(parseInt(data));
				}
			}, //기출고수량
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
			}, //출고수량
			{ className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					let html = '';
					html += '<input type="text" class="form-control text-end inputGroup" name="tagDesc" style="min-width:200px;" >';
					return html;
				}
			}, //꼬리표비고
			/* { data: 'stockReUseQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return addCommas(parseInt(data));
					} else {
						return '';
					}
				}
			}, //재고활용수량 */
			{ data: 'spQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						//현재고가 -인이면서 공정실적여부가 미등록일 경우 0으로 표시해달라함
						if(row['etc9'] == 'N' && parseInt(data) < 0){
							return '0';
						} else {
							return addCommas(parseInt(data));
						}
					} else {
						return '0';
					}
				}
			}, //현재고
			{ data: 'fairQty', className : 'text-end align-middle',//생산량
				render : function(data, type, row, meta) {
					if(data!=null) {
						return addCommas(parseInt(data));
					} else {
						return data;
					}
					
				}
			}, //생산량
			{ data: 'workEndReqDate', className : 'text-center align-middle',//목표요구일
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data).format('YYYY-MM-DD')+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data : 'outReqDate', className : 'text-center align-middle', name: 'outReqDate',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data).format('YYYY-MM-DD')+'</div>';
					} else {
						return '-';
					}
				}
			},//납품요구일
			{ data : 'outDate', className : 'text-center align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data).format('YYYY-MM-DD')+'</div>';
					} else {
						return '-';
					}
				}
			},//출고일
			{ data: 'workOutDesc', className : 'text-center align-middle',//출고비고
				render : function(data, type, row, meta) {
					if(data!=null) {
						return data;
					} else {
						return '';
					}
					
				}
			},
			{ data : 'ordIssue', className : 'text-start align-middle', name : 'ordIssue',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space:pre-line;width:170px; ">'+data+'</div>';
					} else {
						return '';
					}
				}
			},//건별주의사항
			
			{ data: 'packUnit', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return "";
					}
				}
			}, //포장단위
			{ data: 'packMethodNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return "";
					}
				}
			}, //포장박스
			{ className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					let packUnit = (row['packUnit']=='' ||  parseInt(row['packUnit'])==0) ? 1 : isNaN(row['packUnit']) ? 1 : parseInt(row['packUnit']);
					return addCommas(Math.ceil(row['ordQty']/packUnit));
				}
			}, //박스수량
			{ data: 'dealCorpJson', className : 'text-center align-middle', name: 'outProdEtc1',
				render: function(data, type, row, meta) {
					if(data != null){
						let jsonData = JSON.parse(data);
						let html='';
						html += '<div style="display: flex; flex-wrap: nowrap;" class="input-group">';
						html += '<input type="text" class="form-control inputNm" id="dealCorpNm'+meta.row+'" name="dealCorpNm" style="min-width: 100px;" disabled="disabled" value="'+jsonData[0].dealCorpNm+'">';
						html += '<button type="button" class="nameDel customerNm inputGroup" onclick="dealCorpDelete(\''+meta.row+'\')" name="btnDealCorpDel" style="background-color: transparent;border-color: transparent;position: absolute;top: 0;right:0;margin: 1px 23px;margin-left: 0px;border: none;" disabled><i class="fa-solid fa-xmark"></i></button>';
						html += '<input type="hidden" class="inputIdx" id="dealCorpIdx'+meta.row+'" name="dealCorpIdx" value ="'+jsonData[0].idx+'">';
						html += '<button disabled type="button" onclick="dealCorpSel()" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary input-sub-search inputGroup" name="btnDealCorpSel">';
						html += '<i class="fa-solid fa-magnifying-glass"></i>';
						html += '</button>';
						html += '</div>';
						return html;
					} else {
						let html='';
						html += '<div style="display: flex; flex-wrap: nowrap;" class="input-group">';
						html += '<input type="text" class="form-control inputNm" id="dealCorpNm'+meta.row+'" name="dealCorpNm" style="min-width: 100px;" disabled="disabled" value="">';
						html += '<button type="button" class="nameDel customerNm inputGroup" onclick="dealCorpDelete(\''+meta.row+'\')" name="btnDealCorpDel" style="background-color: transparent;border-color: transparent;position: absolute;top: 0;right:0;margin: 1px 23px;margin-left: 0px;border: none;" disabled><i class="fa-solid fa-xmark"></i></button>';
						html += '<input type="hidden" class="inputIdx" id="dealCorpIdx'+meta.row+'" name="dealCorpIdx" value ="">';
						html += '<button disabled type="button" onclick="dealCorpSel()" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary input-sub-search inputGroup" name="btnDealCorpSel">';
						html += '<i class="fa-solid fa-magnifying-glass"></i>';
						html += '</button>';
						html += '</div>';
						return html;
					}
				}
			},
			{ data: 'dealCorpJson', className : 'text-end align-middle', name: 'outProdEtc2',
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						let jsonData = JSON.parse(data);
						let html ='';
						html += '<input type="text" value="'+jsonData[0].dealCorpAddress+'" style="min-width: 200px;" name="outProdEtc2" class="form-control text-start inputGroup" disabled>';
						return html;
					} else {
						let html ='';
						html += '<input type="text" style="min-width: 200px;" name="outProdEtc2" class="form-control text-start inputGroup" disabled>';
						return html;
					}
				}
			},

			/* { data: 'workplaceIdx', className : 'text-end align-middle', name: 'outProdEtc3',
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
			}, */
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
		],
		columnDefs : [
			{ "targets": [0], "orderable": false },
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
			let theadHeight = parseFloat($('#bizOrderDtlTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#bizOrderDtlTable_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 79)+'px');
			
			$('#bizOrderDtlTable_filter').addClass('d-none');
			// 통합검색
			$('#searchAll').off('keyup',function() {});
			$('#searchAll').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			});
			
			$('.bootstrapToggle').bootstrapToggle();

			for(var i=0;i<api.data().count();i++) {
				let data = api.row(i).data();
				let node = api.row(i).node();
				
				if(data.fairQty != null && data.fairQty>0 && parseInt(removeCommas(data.ordQty)) > parseInt(removeCommas(data.fairQty))){ //수량부족
					$(node).addClass('fw-bolder');
					$(node).css('background-color','#ffb4b4');
				}  
			}
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
				if(colIdx > 0){
					$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
					$(cell).css('padding','2px');
				} else {
					$(cell).html('');
					$(cell).css('padding','2px');
				}

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
			bizOrderDtlTable.draw(false);
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

	/* let bizOrdDtlSelectRowObj = '';
	bizOrderDtlTable.on('select', function(e, dt, type, index){
		bizOrdDtlSelectRowObj = dt.row(index).node();
	}); */
	
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
			$('input[name=btnCheck]').attr('disabled',false);
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
			let checkRows = $('#bizOrderDtlTable tbody').find('tr').find('input[name=btnCheck]:checked').parent().parent().parent();
			let checkRowData = bizOrderDtlTable.rows(checkRows).data().toArray();
			// 모든 열(Column) 다시 보이게 하기
			bizOrderDtlTable.columns().visible(true);
			$('#bizOrderDtlTable tbody').find('tr').find('input[name=btnCheck]:checked').each(function(index, item){				
				let tr = $(item).parent().parent().parent(); 	//행 tr
				let td = $(item).parent().parent();				//해당 체크박스 td
				let rowTdList = $(tr).find('td');				//행(tr)의 td 리스트
				let data = bizOrderDtlTable.row(tr).data();		//행 데이터
				
				let outQty = $(rowTdList).eq(bizOrderDtlTable.column('outQty:name').index()).find('input').val().replaceAll(/,/g,'');
				//let outDesc = $(rowTdList).eq(bizOrderDtlTable.column('outDesc:name').index()).find('input').val();
				let outDesc = '';
				let whsIdx = $(rowTdList).eq(bizOrderDtlTable.column('whsIdx:name').index()).find('select').val();
				let outProdEtc1 = $(rowTdList).eq(bizOrderDtlTable.column('outProdEtc1:name').index()).find('input[type=hidden]').val();
				let outProdEtc2 = $(rowTdList).eq(bizOrderDtlTable.column('outProdEtc2:name').index()).find('input').val();
				//let outProdEtc3 = $(rowTdList).eq(bizOrderDtlTable.column('outProdEtc3:name').index()).find('select').val();
				let carAssignment = $(rowTdList).eq(bizOrderDtlTable.column('carAssignment:name').index()).find('select').val();

				/* if(carAssignment == '') {
					toastr.warning('차량을 배정해주세요.');
					$(rowTdList).eq(bizOrderDtlTable.column('carAssignment:name').index()).find('select').focus();
					state = false;
					return false;
				} */
				
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
				obj.outProdEtc3 = isEmptyCheck(data.workplaceIdx) ? '' : data.workplaceIdx;
				obj.bizOrdDtlNo = data.bizOrdDtlNo;
				obj.itemIdx = data.itemIdx;
				obj.itemVersionIdx = data.itemVersionIdx;
				obj.itemCd = data.itemCd;
				obj.outDate = moment().format('YYYYMMDD');
				obj.outCorpIdx = '';//출고처의 idx가 기타1,2,3 <- 여기 항목으로 정보 이관됨
				obj.carAssignment = carAssignment;
			    array.push(obj);

			    let obj2 = new Object();
			    obj2.outQty = outQty.replaceAll(/,/g,'');
			    obj2.itemIdx = data.itemIdx;
			    obj2.etc9 = data.etc9;
			    qtyCheckArray.push(obj2);
			    
			});
			// 창고 다시 안보이도록
			bizOrderDtlTable.columns(bizOrderDtlTable.column('whsIdx:name').index()).visible(false);
			
			
			if(overProdOutYn != 'Y'){
				let qtyCheckResultArray = qtyCheckArray.reduce((acc, cur) => {
																  let itemIdx = cur.itemIdx;
																  let etc9 = cur.etc9;
																  let outQty = Number(cur.outQty.replaceAll(/,/g, ''));
																  let index = acc.findIndex((obj) => obj.itemIdx === itemIdx);
																  if (index === -1) {
																    acc.push({ itemIdx, outQty, etc9 });
																  } else {
																    acc[index].outQty += outQty;
																  }
																  return acc;
																}, []);
	
				qtyCheckResultArray.forEach(function(index, item){
					let rows = $('#bizOrderDtlTable tbody').find('tr').find('input[name=btnCheck]:checked').parent().parent().parent();
					let rowData = bizOrderDtlTable.rows(rows).data().toArray();
					let spQty = parseInt(_.filter(rowData, v=>v.itemIdx == index['itemIdx'])[0].spQty);

					//체크할때 공정실적미등록제품은 예외임
					if( spQty < index['outQty'] && index['etc9'] != 'N'){
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
		/* if(!$('#bizOrderDealCorpTable tbody tr').hasClass('selected')){
			toastr.warning('붙여넣을 행을 선택해주세요.');
			return false;
		} */
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
		$('#btnSave').attr('disabled', true); // 저장 버튼
		$('#btnEdit').attr('disabled', false); // 수정 버튼
		$('#btnCancel').attr('disabled', true); // 취소 버튼
	});

	/********************* po완료 *********************/
	$('#btnBizDtlPoEnd').on('click',function(){
		if($('#bizOrderDtlTable').find('input[name=btnCheck]:checked').length == 0) {
			toastr.warning('PO완료할 항목을 체크해주세요.');
			return false;
		}		
		
		$('#bizDtlPoEndModal').modal('show');
	});

	$('#btnBizDtlPoEndY').on('click',function(){
		let updIdx = '';
		$('#bizOrderDtlTable').find('input[name=btnCheck]:checked').each(function(index, item){
			let tr = $(item).parent().parent().parent();
			let node = bizOrderDtlTable.row(tr).node();
			let data = bizOrderDtlTable.row(tr).data();
			updIdx += data.bizOrdDtlIdx +', ';
		});
		updIdx = updIdx.slice(0,-2);
		
		$.ajax({
			url: '<c:url value="/bs/bizOrderDtlPoEndByBizOrdDtlIdxString"/>',
            type: 'POST',
            data: {
                'bizOrdDtlIdxString'	:	function(){ return updIdx; },
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
	
</script>
<!-- 인쇄용지설정 -->
<style type="text/css" media="print" id="printPaperTypeStyle">
@media print {
	@page { size: 108mm 190mm landscape; margin: 5mm 4mm; } /*landscape 가로  portrait 세로 */
}
</style>
<!-- 꼬리표 출력 기능 -->
<script>
	//초기 셋팅
	$(document).ready(function() {
		$('#trTtailTableAppendTarget').after(makeEmptyTr());
		commonCssChange('tailTable');
		$('#tailTable').removeClass('d-none');

		$('#trBundlingLabelAppendTarget').after(makeEmptyTrByBundlingLabel());
		commonCssChange('bundlingLabelTable');
		$('#bundlingLabelTable').removeClass('d-none');
	
		$('input').attr('autocomplete','one-time-code');
	});

	$('#btnlabelPrint').on('click',function(){

		let paperTypeVal = $('#printPaperType').val();
		
		if( isEmptyCheck(paperTypeVal) ){
			toastr.warning('출력할 라벨 종류를 선택해주세요.');
			$('#printPaperType').focus();
			return false;
		}

		let checkCnt = $('#bizOrderDtlTable tbody').find('tr').find('input[name=btnCheck]:checked').length;
		if( checkCnt == 0 ){
			toastr.warning('출력할 항목을 체크해주세요.');
			return false;
		}
		$('#my-spinner').show();
		if( paperTypeVal == '01' ){
			//꼬리표
			//해당 스타일시트날리고
			$('#printPaperTypeStyle').remove();
			//스타일시트 생성
			$('<style>')
				.prop('type', 'text/css').prop('id','printPaperTypeStyle').prop('media','print')
				.html('@media print { @page { size: 108mm 190mm landscape; margin: 5mm 4mm; } }')
				.appendTo('body'); 

			//꼬리표 생성
			$('#tailTable').find('tr').remove();

			$('#bizOrderDtlTable tbody').find('tr').find('input[name=btnCheck]:checked').each(function(index, item){
				$('#trTtailTableAppendTarget').after(makeEmptyTr());

				let tr = $(item).parent().parent().parent();
				let node = bizOrderDtlTable.row(tr).node();
				let data = bizOrderDtlTable.row(tr).data();

				let dealCorpNm = $(node).find('input[name=dealCorpNm]').val();
				let outQty = removeCommas($(node).find('input[name=outQty]').val()); 
				let tagDesc = $(node).find('input[name=tagDesc]').val();
				
				$('#tailTable [name=outDealCorpNm]:eq(0)').text(dealCorpNm);
				
				if(data.itemNm.length > 35 ){
					$('#tailTable [name=itemNm]:eq(0)').addClass('fs-15').removeClass('fs-21');
				} else {
					$('#tailTable [name=itemNm]:eq(0)').removeClass('fs-15').addClass('fs-21');
				}
				$('#tailTable [name=itemNm]:eq(0)').text(data.itemNm);
				$('#tailTable [name=customerItemCd]:eq(0)').text(data.customerItemCd);
				$('#tailTable [name=itemVersion]:eq(0)').text(data.itemVersion);
				$('#tailTable [name=bizOrdDtlNo]:eq(0)').text(data.bizOrdDtlNo);
				$('#tailTable [name=outDate]:eq(0)').text(moment(data.outReqDate).format('YYYY-MM-DD'));
				$('#tailTable [name=outQty]:eq(0)').text(addCommas(outQty));
				$('#tailTable [name=workPlaceNm]:eq(0)').text(data.workPlaceNm);
				$('#tailTable [name=tagDesc]:eq(0)').text(tagDesc);
				
				let ordQty = parseInt(data.ordQty);
				let beforOutQty = parseInt(data.outQty);
				let calQty = ordQty - beforOutQty;
				let packUnit = (data.packUnit=='' ||  parseInt(data.packUnit)==0) ? 1 : isNaN(data.packUnit) ? 1 : parseInt(data.packUnit);
				let packCnt = Math.ceil(ordQty/packUnit);
				//띠 인쇄 기준을 충족하는 지 체크
				//수주수량 - 기출고수량한 수량에서 박스수량을 참고해서 이번 박스가 마지막 박스인지 
				if( calQty <= packCnt){
					$('#tailTable [name=lastBox]:eq(0)').addClass('bg-blue');
				} else {
					
					$('#tailTable [name=lastBox]:eq(0)').removeClass('bg-blue');
				}
			});
			
			commonCssChange('tailTable');

			$('#my-spinner').hide();

			$('input[name=tagDesc]').val('');
			$('#tailTable').print({
				globalStyles: true,
				mediaPrint: true
			});
			
		} else if( paperTypeVal == '02' ){
			//번들링
			
			//해당 스타일시트날리고
			$('#printPaperTypeStyle').remove();
			//스타일시트 생성
			$('<style>')
				.prop('type', 'text/css').prop('id','printPaperTypeStyle').prop('media','print')
				.html('@media print { @page { size: A4 portrait; margin: 5mm; }, html, body { width: 210mm; height: 297mm; } }')
				.appendTo('body');

			//번들링 생성
			$('#bundlingLabelTable').find('tr').remove();

			$('#bizOrderDtlTable tbody').find('tr').find('input[name=btnCheck]:checked').each(function(index, item){
				$('#trBundlingLabelAppendTarget').after(makeEmptyTrByBundlingLabel());
				
				let tr = $(item).parent().parent().parent();
				let node = bizOrderDtlTable.row(tr).node();
				let data = bizOrderDtlTable.row(tr).data();

				let dealCorpNm = $(node).find('input[name=dealCorpNm]').val();
				let outQty = removeCommas($(node).find('input[name=outQty]').val()); 
				let packUnit = data.packUnit;
				let tagDesc = $(node).find('input[name=tagDesc]').val();
				
				$('#bundlingLabelTable [name=outDealCorpNm]:lt(2)').text(dealCorpNm);
				if(data.itemNm.length > 35 ){
					$('#bundlingLabelTable [name=itemNm]:lt(2)').addClass('fs-15').removeClass('fs-21');
				} else {
					$('#bundlingLabelTable [name=itemNm]:lt(2)').removeClass('fs-15').addClass('fs-21');
				}
				$('#bundlingLabelTable [name=itemNm]:lt(2)').text(data.itemNm);
				$('#bundlingLabelTable [name=customerItemCd]:lt(2)').text(data.customerItemCd);
				$('#bundlingLabelTable [name=itemVersion]:lt(2)').text(data.customerItemCd + '-' + data.itemVersion);
				$('#bundlingLabelTable [name=bizOrdDtlNo]:lt(2)').text(data.bizOrdDtlNo);
				$('#bundlingLabelTable [name=outDate]:lt(2)').text(moment(data.outReqDate).format('YYYY-MM-DD'));
				$('#bundlingLabelTable [name=outQty]:lt(2)').text(packUnit);
				$('#bundlingLabelTable [name=workPlaceNm]:lt(2)').text(data.workPlaceNm);
				$('#bundlingLabelTable [name=tagDesc]:lt(2)').text(tagDesc);
				
				let bundlingJson = JSON.parse(data.bundlingJson);
				if( !isEmptyCheck(bundlingJson) ){
					for(var i = 0; i < bundlingJson.length; i++){
						if( i < 6 ){
							let bundlingData = bundlingJson[i];

							// 13 -> 10
							if(bundlingData.ITEM_NM.length > 35 ){
								$('#bundlingLabelTable [name=bundlingItemNm]:eq('+i+')').addClass('fs-10').removeClass('fs-13');
								$('#bundlingLabelTable [name=bundlingItemNm]:eq('+(i+5)+')').addClass('fs-10').removeClass('fs-13');
							} else {
								$('#bundlingLabelTable [name=bundlingItemNm]:eq('+i+')').removeClass('fs-10').addClass('fs-13');
								$('#bundlingLabelTable [name=bundlingItemNm]:eq('+(i+5)+')').removeClass('fs-10').addClass('fs-13');
							}

							
							$('#bundlingLabelTable [name=bundlingItemNm]:eq('+i+')').text(bundlingData.ITEM_NM);
							$('#bundlingLabelTable [name=bundlingBizOrdNo]:eq('+i+')').text(bundlingData.BIZ_ORD_DTL_NO);
							$('#bundlingLabelTable [name=bundlingCustomerItemCd]:eq('+i+')').text(bundlingData.CUSTOMER_ITEM_CD);
							$('#bundlingLabelTable [name=bundlingItemVersion]:eq('+i+')').text(bundlingData.ITEM_VERSION);
	
							$('#bundlingLabelTable [name=bundlingItemNm]:eq('+(i+5)+')').text(bundlingData.ITEM_NM);
							$('#bundlingLabelTable [name=bundlingBizOrdNo]:eq('+(i+5)+')').text(bundlingData.BIZ_ORD_DTL_NO);
							$('#bundlingLabelTable [name=bundlingCustomerItemCd]:eq('+(i+5)+')').text(bundlingData.CUSTOMER_ITEM_CD);
							$('#bundlingLabelTable [name=bundlingItemVersion]:eq('+(i+5)+')').text(bundlingData.ITEM_VERSION);
						}
					}
				}
			});

			commonCssChange('bundlingLabelTable');
			$('#my-spinner').hide();
			$('input[name=tagDesc]').val('');
			$('#bundlingLabelTable').print({
				globalStyles: true,
				mediaPrint: true
			});
		}
			
		
	});

	function makeEmptyTr(){
		
		let html = '';
		html += '<tr style="page-break-before: always!important;">';
		html += '	<td colspan="20" class="bd-n fc-white">납품처</td>';
		html += '	<td colspan="75" name="outDealCorpNm" class="bd-n fs-21 fw900 text-center align-middle"></td>';
		html += '	<td colspan="4" name="lastBox" class="bd-n"></td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';
		html += '<tr>';
		html += '	<td colspan="20" class="bd-n fc-white">자재명</td>';
		html += '	<td colspan="80" name="itemNm" class="bd-n fs-21 fw900 text-center align-middle"></td>';
		html += '</tr>';
		html += '<tr>';
		html += '	<td colspan="20" class="bd-n fc-white">자재코드</td>';
		html += '	<td colspan="80" name="customerItemCd" class="bd-n fs-21 fw900 text-center align-middle"></td>';
		html += '</tr>';
		html += '<tr>';
		html += '	<td colspan="20" class="bd-n fc-white">개정번호</td>';
		html += '	<td colspan="80" name="itemVersion" class="bd-n fs-21 fw900 text-center align-middle"></td>';
		html += '</tr>';
		html += '<tr>';
		html += '	<td colspan="20" class="bd-n fc-white">제조번호</td>';
		html += '	<td colspan="80" name="bizOrdDtlNo" class="bd-n fs-21 fw900 text-center align-middle"></td>';
		html += '</tr>';
		html += '<tr>';
		html += '	<td colspan="20" class="bd-n fc-white">입고일자</td>';
		html += '	<td colspan="80" name="outDate" class="bd-n fs-21 fw900 text-center align-middle"></td>';
		html += '</tr>';
		html += '<tr>';
		html += '	<td colspan="20" class="bd-n fc-white">수량</td>';
		html += '	<td colspan="80" name="outQty" class="bd-n fs-21 fw900 text-center align-middle"></td>';
		html += '</tr>';
		html += '<tr>';
		html += '	<td colspan="20" class="bd-n fc-white">납품자</td>';
		html += '	<td colspan="80" name="workPlaceNm" class="bd-n fs-21 fw900 text-center align-middle"></td>';
		html += '</tr>';
		html += '<tr>';
		html += '	<td colspan="20" class="bd-n fc-white">비고</td>';
		html += '	<td colspan="80" name="tagDesc" class="bd-n fs-21 fw900 text-center align-middle"></td>';
		html += '</tr>';
		return html;
	}

	function makeEmptyTrByBundlingLabel(){
		let bundlingHtml = '';
		bundlingHtml += '<table style="height:100%;width:100%;">';
		bundlingHtml += '<tr>';
		bundlingHtml += '	<td class="h-30 fs-15 text-center align-middle">자재명</td>';
		bundlingHtml += '	<td class="h-30 fs-15 text-center align-middle">제조번호</td>';
		bundlingHtml += '	<td class="h-30 fs-15 text-center align-middle">자재코드</td>';
		bundlingHtml += '	<td class="h-30 fs-15 text-center align-middle">개정번호</td>';
		bundlingHtml += '</tr>';
		for(var i = 0 ; i < 5; i++){
			bundlingHtml += '<tr>';
			bundlingHtml += '	<td class="h-30 fs-13" name="bundlingItemNm"></td>';
			bundlingHtml += '	<td class="h-30 fs-13" name="bundlingBizOrdNo"></td>';
			bundlingHtml += '	<td class="h-30 fs-13" name="bundlingCustomerItemCd"></td>';
			bundlingHtml += '	<td class="h-30 fs-13" name="bundlingItemVersion"></td>';
			bundlingHtml += '</tr>';
		}
		bundlingHtml += '</table>';
		
		let html = '';
		html += '<tr style="page-break-before: always!important;">';
		html += '	<td colspan="20" class="fs-25 fw900 text-center align-middle">납품처</td>';
		html += '	<td colspan="80" name="outDealCorpNm" class="fs-25 fw900 text-center align-middle"></td>';
		html += '</tr>';
		html += '<tr>';
		html += '	<td colspan="20" class="fs-25 fw900 text-center align-middle">자재명</td>';
		html += '	<td colspan="80" name="itemNm" class="fs-21 fw900 text-center align-middle"></td>';
		html += '</tr>';
		html += '<tr>';
		html += '	<td colspan="20" class="fs-25 fw900 text-center align-middle">Bundling<br>내 역</td>';
		html += '	<td colspan="80" name="bundlingHist" class="fs-25 fw900 text-center align-middle padding-10px" style="">'+bundlingHtml+'</td>';
		html += '</tr>';
		html += '	<td colspan="20" class="fs-25 fw900 text-center align-middle">제조번호</td>';
		html += '	<td colspan="80" name="bizOrdDtlNo" class="fs-25 fw900 text-center align-middle"></td>';
		html += '</tr>';
		html += '<tr>';
		html += '	<td colspan="20" class="fs-25 fw900 text-center align-middle">입고일자</td>';
		html += '	<td colspan="80" name="outDate" class="fs-25 fw900 text-center align-middle"></td>';
		html += '</tr>';
		html += '<tr>';
		html += '	<td colspan="20" class="fs-25 fw900 text-center align-middle">수량</td>';
		html += '	<td colspan="80" name="outQty" class="fs-25 fw900 text-center align-middle"></td>';
		html += '</tr>';
		html += '<tr>';
		html += '	<td colspan="20" class="fs-25 fw900 text-center align-middle">납품자</td>';
		html += '	<td colspan="80" name="workPlaceNm" class="fs-25 fw900 text-center align-middle"></td>';
		html += '</tr>';
		html += '<tr>';
		html += '	<td colspan="20" class="fs-25 fw900 text-center align-middle">비고</td>';
		html += '	<td colspan="80" name="tagDesc" class="fs-25 fw900 text-center align-middle"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="100" class="bd-n h-28"></td>';
		html += '</tr>';
		html += '<tr>';
		html += '	<td colspan="100" class="bt-n bl-n br-n bd_dashed bd2px h-10"></td>';
		html += '</tr>';
		html += '<tr>';
		html += '	<td colspan="100" class="bd-n h-32"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="20" class="fs-25 fw900 text-center align-middle">납품처</td>';
		html += '	<td colspan="80" name="outDealCorpNm" class="fs-25 fw900 text-center align-middle"></td>';
		html += '</tr>';
		html += '<tr>';
		html += '	<td colspan="20" class="fs-25 fw900 text-center align-middle">자재명</td>';
		html += '	<td colspan="80" name="itemNm" class="fs-21 fw900 text-center align-middle"></td>';
		html += '</tr>';
		html += '<tr>';
		html += '	<td colspan="20" class="fs-25 fw900 text-center align-middle">Bundling<br>내 역</td>';
		html += '	<td colspan="80" name="bundlingHist" class="fs-25 fw900 text-center align-middle padding-10px" style="">'+bundlingHtml+'</td>';
		html += '</tr>';
		html += '	<td colspan="20" class="fs-25 fw900 text-center align-middle">제조번호</td>';
		html += '	<td colspan="80" name="bizOrdDtlNo" class="fs-25 fw900 text-center align-middle"></td>';
		html += '</tr>';
		html += '<tr>';
		html += '	<td colspan="20" class="fs-25 fw900 text-center align-middle">입고일자</td>';
		html += '	<td colspan="80" name="outDate" class="fs-25 fw900 text-center align-middle"></td>';
		html += '</tr>';
		html += '<tr>';
		html += '	<td colspan="20" class="fs-25 fw900 text-center align-middle">수량</td>';
		html += '	<td colspan="80" name="outQty" class="fs-25 fw900 text-center align-middle"></td>';
		html += '</tr>';
		html += '<tr>';
		html += '	<td colspan="20" class="fs-25 fw900 text-center align-middle">납품자</td>';
		html += '	<td colspan="80" name="workPlaceNm" class="fs-25 fw900 text-center align-middle"></td>';
		html += '</tr>';
		html += '<tr>';
		html += '	<td colspan="20" class="fs-25 fw900 text-center align-middle">비고</td>';
		html += '	<td colspan="80" name="tagDesc" class="fs-25 fw900 text-center align-middle"></td>';
		html += '</tr>';
		return html;
	}
	
	function commonCssChange(tableId){
		//$('#'+tableId).find('td').css('font-weight', '900');
		$('#'+tableId).find('td').css('border', '1px solid black');
		if(tableId == 'tailTable'){
			$('#'+tableId).find('td').css('padding', '1mm');
			$('#'+tableId).find('td').css('min-height', '41px').css('max-height','41px').css('height','41px');
		} else {
			$('#'+tableId).find('td').css('padding', '0.1rem');
		}
		$('#'+tableId).find('td').css('color', '#000000');
		

		$('#'+tableId).find('.padding-10px').css('padding', '10px');
		$('#'+tableId).find('.fc-white').css('color', '#FFFFFF');
		$('#'+tableId).find('.fw900').css('font-weight', '900');
		$('#'+tableId).find('.fw-bold').css('font-weight', 'bold');
		$('#'+tableId).find('.bd2px').css('border', '2px solid black');
		
		$('#'+tableId).find('.bg-gray').css('background-color', '#C9C9C9');
		$('#'+tableId).find('.bg-blue').css('background-color', '#0000FF');


		$('#'+tableId).find('.4mmHeight').css('min-height', '4mm').css('max-height','4mm').css('height','4mm');
		
		$('#'+tableId).find('.theadFirstCol').css('border-top', '0px');
		//$('#'+tableId).find('.theadFirstCol').css('border-left', '2px');
		$('#'+tableId).find('.theadNotFisrtCol').css('border-top', '0px');
		$('#'+tableId).find('.theadNotFisrtCol').css('border-left', '0px');
		
		$('#'+tableId).find('.tbodyFirstCol').css('border-top', '0px');
		//$('#'+tableId).find('.tbodyFirstCol').css('border-left', '2px');
		$('#'+tableId).find('.tbodyNotFirstCol').css('border-top', '0px');
		$('#'+tableId).find('.tbodyNotFirstCol').css('border-left', '0px');

		//$('#'+tableId).find('.bd-doblue').css('border', '5px double');
		
		$('#'+tableId).find('.fc-red').css('color', '#ff0000');
		$('#'+tableId).find('.fc-blue').css('color', '#0070C0');
		$('#'+tableId).find('.fs-8').css('font-size', '8px');
		$('#'+tableId).find('.fs-10').css('font-size', '10px');
		$('#'+tableId).find('.fs-11').css('font-size', '11px');
		$('#'+tableId).find('.fs-12').css('font-size', '12px');
		$('#'+tableId).find('.fs-13').css('font-size', '13px');
		$('#'+tableId).find('.fs-15').css('font-size', '15px');
		$('#'+tableId).find('.fs-20').css('font-size', '20px');
		$('#'+tableId).find('.fs-21').css('font-size', '21.5px');
		$('#'+tableId).find('.fs-25').css('font-size', '25px');
		$('#'+tableId).find('.fs-30').css('font-size', '30px');
		$('#'+tableId).find('.fs-50').css('font-size', '50px');
		$('#'+tableId).find('.fc-red').css('color', '#ff0000');
		$('#'+tableId).find('.bt-2').css('border-top', '2px solid black');
		$('#'+tableId).find('.bd-n').css('border', '0px solid #ffffff');
		$('#'+tableId).find('.bt-n').css('border-top', '0px solid #ffffff');
		$('#'+tableId).find('.br-n').css('border-right', '0px solid #ffffff');
		$('#'+tableId).find('.bb-n').css('border-bottom', '0px solid #ffffff');
		$('#'+tableId).find('.bl-n').css('border-left', '0px solid #ffffff');
		$('#'+tableId).find('.h-5').css('height', '5px');
		$('#'+tableId).find('.h-10').css('height', '10px');
		$('#'+tableId).find('.h-15').css('height', '15px');
		$('#'+tableId).find('.h-20').css('height', '20px');
		$('#'+tableId).find('.h-25').css('height', '25px');
		$('#'+tableId).find('.h-28').css('height', '28px');
		$('#'+tableId).find('.h-30').css('height', '30px');
		$('#'+tableId).find('.h-32').css('height', '32px');
		$('#'+tableId).find('.h-35').css('height', '35px');
		$('#'+tableId).find('.h-40').css('height', '40px');
		$('#'+tableId).find('.h-55').css('height', '55px');
		$('#'+tableId).find('.h-70').css('height', '70px');
		$('#'+tableId).find('.h-75').css('height', '75px');
		$('#'+tableId).find('.h-90').css('height', '90px');
		$('#'+tableId).find('.h-100').css('height', '100px');
		$('#'+tableId).find('.maxh-5').css('max-height', '5px');
		$('#'+tableId).find('.maxh-10').css('max-height', '10px');
		$('#'+tableId).find('.maxh-20').css('max-height', '20px');
		$('#'+tableId).find('.maxh-25').css('max-height', '25px');
		$('#'+tableId).find('.maxh-30').css('max-height', '30px');
		$('#'+tableId).find('.maxh-40').css('max-height', '40px');
		$('#'+tableId).find('.maxh-55').css('max-height', '55px');
		$('#'+tableId).find('.maxh-70').css('max-height', '70px');
		$('#'+tableId).find('.maxh-75').css('max-height', '75px');
		$('#'+tableId).find('.maxh-100').css('max-height', '100px');

		$('#'+tableId).find('.bd_dashed').css('border-style','dotted');

		// 인쇄할 때 css 적용하려면 important 붙여줘야함.
		for(var i=0;i<$('#'+tableId).find('td').length;i++) {
			let tdStyle = $('#'+tableId).find('td').eq(i).attr('style') == undefined?'':$('#'+tableId).find('td').eq(i).attr('style');
			$('#'+tableId).find('td').eq(i).attr('style',tdStyle.replaceAll(';',' !important;'));
		}
	}

	//출고량과 포장수량 비교해서 그만큼 for문 돌기(주석 삭제 x)
	//console.log("packUnit : "+ parseInt(bizOrderDtlTable.row(index).data().packUnit));
	//console.log("outQty : "+ parseInt(removeCommas($('input[name=outQty]').eq(0).val())));
	//let printPackUnit = parseInt(bizOrderDtlTable.row(index).data().packUnit);
	//let printOutQty = parseInt(removeCommas($('input[name=outQty]').eq(index).val()));
	//let printCnt = Math.ceil(printOutQty/printPackUnit);
	//console.log('printCnt:'+printCnt)
	//let remainQty = printOutQty;
	
	
	
</script>


</body>
</html>
