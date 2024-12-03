<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
pageContext.setAttribute("newLineChar", "\n");
%>

<%@include file="../layout/top.jsp"%>
<%@include file="../layout/modal.jsp"%>
<%@include file="../layout/script.jsp"%>
<div id="page" onmouseup="EndDrag()" onmousemove="OnDrag(event)" style="grid-template-areas: 'leftcol'; grid-template-rows: 1fr; grid-template-columns: 1fr;">
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
					
					<input type="text" class="form-control w-auto h-100 me-1 d-none" id="searchAllAdm" placeholder="통합검색">
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">제품코드</label>
					<div class="input-group w-auto h-100 me-3">
						<input type="text" class="form-control" id="itemNm" style="width: 200px;" disabled>
						<button type="button" class="btnInputDel" style="background-color: transparent; border-color: transparent; position: absolute; top: 0; right: 0; margin: 5px 23px; margin-left: 0px; border: none;">
							<i class="fa-solid fa-xmark"></i>
						</button>
						<input type="hidden" id="itemIdx">
						<button type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary" id="btnSearchItem">
							<i class="fa-solid fa-magnifying-glass"></i>
						</button>
					</div>
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">거래처</label>
					<div class="input-group w-auto h-100 me-3">
						<input type="text" class="form-control" id="searchDealCorpNm" disabled> <input type="hidden" id="searchDealCorpIdx">
						<button type="button" id="btnSearchDealCorpDel" style="background-color: transparent; border-color: transparent; position: absolute; top: 0; right: 0; margin: 5px 23px; margin-left: 0px; border: none;">
							<i class="fa-solid fa-xmark"></i>
						</button>
						<button type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary" id="btnSearchDealCorp">
							<i class="fa-solid fa-magnifying-glass"></i>
						</button>
					</div>

					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">조회대상</label>
					<select class="form-select w-auto h-100 me-1" id="searchTarget" style="min-width: 70px;">
						<option value="">전체</option>
						<option value="N" selected>미판정</option>
					</select>
					<!-- <select class="form-select w-auto h-100 me-3" id="searchTargetConfirm" style="min-width: 70px;">
						<option value="" selected>전체</option>
						<option value="N">미승인</option>
					</select> -->
					<input type="text" class="form-control w-auto h-100 me-1" id="searchAll" placeholder="통합검색" >
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end">
				
					<!-- <div class="btn-group me-3" role="group" aria-label="Small button group" >
						<button type="button" class="btn btn-outline-light w-auto"  data-val="01" id="btnUndecided">미판정</button>
						<button type="button" class="btn btn-outline-light w-auto"  data-val="02" id="btnJudgmentY">적합</button>
						<button type="button" class="btn btn-outline-light w-auto"  data-val="03" id="btnJudgmentN">부적합</button>
						<button type="button" class="btn btn-outline-light w-auto"  id="btnConfirmY">승인</button>	
					</div> -->
					
					<div class="btn-group" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnSearch">
							<i class="fa-regular fa-clipboard"></i>
						</button>
						<!-- <button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnSave" disabled>
							<i class="fa-regular fa-floppy-disk"></i>
						</button> -->
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnEdit">
							<i class="fa-regular fa-pen-to-square"></i>
						</button>
						<button type="button" class="btn btn-outline-danger w-auto" style="font-size: 17px !important;" id="btnDel">
							<i class="fa-solid fa-trash-can"></i>
						</button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnCancel" disabled>
							<i class="fa-solid fa-xmark"></i>
						</button>
						
					</div>
				</div>
			</div>
			<div class="row">
				<table class="table table-bordered p-0 m-0" id="prodQualityTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle"><input type="checkbox" id="btnAllCheck" style="width: 20px; height: 20px;"></th>
							<th class="text-center align-middle">수주상세</th>
							<th class="text-center align-middle">수주상태</th>
							<th class="text-center align-middle">고객사</th>
							<th class="text-center align-middle" style="min-width:280px;max-width:280px;">제품명</th>
							<th class="text-center align-middle" style="min-width:80px;max-width:80px;">재고사용수량</th>
							<th class="text-center align-middle" style="min-width:80px;max-width:80px;">재고활용수량</th>
							<!-- <th class="text-center align-middle">지시수량</th> -->
							<th class="text-center align-middle" style="min-width:80px;max-width:80px;">수주수량</th>
							<th class="text-center align-middle" style="min-width:80px;max-width:80px;">생산수량</th>
							<th class="text-center align-middle" style="min-width:80px;max-width:80px;">적합수량</th>
							<th class="text-center align-middle" style="min-width:120px;max-width:130px;">적합여부</th>
							<th class="text-center align-middle" style="min-width:60px;max-width:60px;">목표요구일</th>
							<th class="text-center align-middle" style="min-width:60px;max-width:60px;">출고요청일</th>
							<th class="text-center align-middle" style="min-width:60px;max-width:60px;">판정일자</th>
							<th class="text-center align-middle" style="max-width:110px;">시험자</th>
							<th class="text-center align-middle">승인여부</th>
							<th class="text-center align-middle" style="max-width:110px;">판정자</th>
							<th class="text-center align-middle" style="min-width:60px;max-width:60px;">승인일자</th>
							<th class="text-center align-middle">비고</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>

<!-- 부적합 경고 -->
<div class="modal fade" id="judgmentWarningModal" tabindex="-1" aria-hidden="true" style="z-index: 9999;">
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
				품질 판정 <i class="fa-solid text-danger">부적합</i>을 선택하셨습니다.<br> 계속하시겠습니까?
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" id="btnJudgmentWarningModalY" data-bs-dismiss="modal" style="width: 70px;">
					<spring:message code="yes" text="default text" />
				</button>
				<button type="button" class="btn btn-secondary" id="btnJudgmentWarningModalN" data-bs-dismiss="modal" style="width: 70px;">
					<spring:message code="no" text="default text" />
				</button>
			</div>
		</div>
	</div>
</div>
<!-- 부적합 경고 모달 끝 -->

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

	let monthAdjustList = getCommonCode('시스템', '026'); //날짜조정
	monthAdjustList = _.sortBy(monthAdjustList, v=>parseInt(v.commonCd));
	selectBoxAppend(monthAdjustList, 'monthAdjust', '', '2'); //날짜조정
	
	//공통코드
	let ordStatusList = getCommonCode('시스템', '022'); // 수주상태
	let dealGubunList = getCommonCode('시스템', '011'); // 거래구분
	let dealStatusList = getCommonCode('시스템', '015'); // 거래상태
	let qualityJudgmentCdList = getCommonCode('시스템', '020'); // 품질판정
	let qualityConfirmList = getCommonCode('시스템', '021'); // 품질승인
	let pageLengthCnt = parseInt(getCommonCode('시스템', '025')[0].commonCd); //페이징수량s
	let itemGubunList = getCommonCode('일반', '001'); // 제품구분
	let useYnCdList = getCommonCode('시스템', '055'); // 사용여부
	
	selectBoxAppend(qualityJudgmentCdList, 'searchTarget', '', '1'); //품질판정
	selectBoxAppend(dealGubunList, 'modalDealGubun', '', '1'); //거래구분
	selectBoxAppend(dealStatusList, 'modalDealCorpStatus', '', '1'); //거래상태
	selectBoxAppend(itemGubunList, 'modalItemGubunBox', '', '1'); //제품구분
	selectBoxAppend(useYnCdList, 'modalUseYnCdBox', 'Y', '1'); //사용여부

	let selectPeriod = parseInt(getCommonCode('시스템', '040')[0].commonCd); //기본조회기간 일
	$('#startDate').val(moment().subtract('d',selectPeriod).format('YYYY-MM-DD'));
	$('#endDate').val(moment().format('YYYY-MM-DD'));

	//조회대상 - 품질판정 01(미판정)으로 세팅ㅊ
	$('#searchTarget').val('01');

	let sessionUserNm = "${userNm}";//세션에서 가져온 유저이름
	let sessionUserIdx = "${userIdx}";//세션에서 가져온 유저식별자
	
	// 작지공정 목록조회
	$('#prodQualityTable thead tr').clone(true).addClass('filters').appendTo('#prodQualityTable thead'); // filter 생성
	let prodQualityTable = $('#prodQualityTable').DataTable({
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
			url : '<c:url value="/qm/prodQualityAdmLst"/>',
			type : 'POST',
			data : {
				'startDate' : function(){return $('#startDate').val().replaceAll('-','');},
				'endDate'	: function(){return $('#endDate').val().replaceAll('-','');},
				'itemIdx'	: function(){ return $('#itemIdx').val(); },
				'dealCorpidx' 	: function(){ return $('#searchDealCorpIdx').val();} , 
				'searchTarget'  : function(){ return $('#searchTarget').val(); },
				/* 'searchTargetConfirm'	: function(){ return $('#searchTargetConfirm').val(); }, */
			
			},
		}, 
        rowId: 'idx',
		columns : [
			{ className : 'text-center  align-middle', name:'checkbox',
				render: function(data, type, row, meta) {
					//승인 및 출고대기상태만 삭제가능하도록
					if(row['confirmCd'] == '01' && row['bizStatusCd'] == '06'){
						return '<input type="checkbox" name="inputCheck" style="width:20px; height:20px;">';
					} else {
						return '<input disabled type="checkbox" name="inputNotCheck" style="width:20px; height:20px;">';
					}
				}
			},
			{ data: 'bizOrdDtlNo', className : 'text-center align-middle',//수주상세
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ data: 'bizStatusCd', className : 'text-center align-middle', //수주상태
				render : function(data, type, row, meta) {
					if(data != null && data !=''){
						return _.filter(ordStatusList,v=>v.commonCd == data)[0].commonNm;
					} else {
						return "";
					}
				}
			},
			{ data: 'dealCorpNm', className : 'text-center align-middle',//고객사
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ data: 'itemNm', className : 'text-center align-middle',//제품명
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						if( row['workQtyCheck'] == '1' ){
							return '<div><big class="fw-bolder" style="color: #ff0000;">! </big>'+data+'</div>';
						} else {
							return '<div>'+data+'</div>';
						} 
					} else {
						return '-';
					}
				}
			},
			
			{ data: 'stockUseQty', className : 'text-end align-middle',//재고사용수량
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseInt(data))+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ data: 'stockReUseQty', className : 'text-end align-middle',//재고활용수량
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseInt(data))+'</div>';
					} else {
						return '-';
					}
				}
			},
			
			/* { data: 'workOrdQty', className : 'text-end align-middle',//지시수량
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseInt(data))+'</div>';
					} else {
						return '-';
					}
				}
			}, */
			{ data: 'bizOrdQty', className : 'text-end align-middle',//수주수량
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseInt(data))+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ data: 'fairQty', className : 'text-end align-middle',//생산수량
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseInt(data))+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ data: 'passQty', className : 'text-end align-middle',name:'passQty',//적합수량
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseInt(data))+'</div>';
					} else {
						return '0';
					}
				}
			},
			{ data: 'qualityJudgmentCd', className : 'text-center align-middle',name:'qualityJudgmentCd',//적합여부
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						let html ='';
						html += '<div class="row d-flex justify-content-center align-items-center" style="min-width:150px;">';
						html += '<div class="btn-group" role="group" aria-label="Small button group">';
						if(data == '02'){
							html += '<input disabled checked data-val="02" type="checkbox" class="btn-check" id="JudgmentY'+meta.row+'">';
							html += '<label disabled data-val="02" class="btn btn-outline-primary d-flex justify-content-center align-items-center" style="min-width:75px;max-width:75px;" for="JudgmentY'+meta.row+'" >적합</label>';
							html += '<input disabled data-val="03" type="checkbox" class="btn-check" id="JudgmentN'+meta.row+'">';
							html += '<label disabled data-val="03" class="btn btn-outline-danger d-flex justify-content-center align-items-center" style="min-width:75px;max-width:75px;border-color: #dc3545;" for="JudgmentN'+meta.row+'">부적합</label>';
							html += '</div>';
							html += '</div>';
						} else if(data == '03'){
							html += '<input disabled data-val="02" type="checkbox" class="btn-check" id="JudgmentY'+meta.row+'">';
							html += '<label disabled data-val="02" class="btn btn-outline-primary d-flex justify-content-center align-items-center" style="min-width:75px;max-width:75px;" for="JudgmentY'+meta.row+'">적합</label>';
							html += '<input disabled checked data-val="03" type="checkbox" class="btn-check" id="JudgmentN'+meta.row+'">';
							html += '<label disabled data-val="03" class="btn btn-outline-danger d-flex justify-content-center align-items-center" style="min-width:75px;max-width:75px;border-color: #dc3545;" for="JudgmentN'+meta.row+'">부적합</label>';
							html += '</div>';
							html += '</div>';
						}
						return html;						
					} else {
						let html ='';
						html += '<div class="row d-flex justify-content-center align-items-center" style="min-width:150px;">';
						html += '<div class="btn-group" role="group" aria-label="Small button group">';
						html += '<button type="button" class="btn btn-outline-light w-auto" style="min-width:75px;max-width:75px;" disabled>적합</button>';
						html += '<button type="button" class="btn btn-outline-light w-auto" style="min-width:75px;max-width:75px;" disabled>부적합</button>';
						//html += '<label disabled data-val="02" class="btn btn-outline-light d-flex justify-content-center align-items-center" style="min-width:75px;max-width:75px;">적합</label>';
						//html += '<label disabled data-val="03" class="btn btn-outline-light d-flex justify-content-center align-items-center" style="min-width:75px;max-width:75px;">부적합</label>';
						html += '</div>';
						html += '</div>';
						return html;
					}
				}
			},
			{ data: 'ordEndDate', className : 'text-center align-middle',//목표요구일
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data).format('YYYY-MM-DD')+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ data: 'outReqDate', className : 'text-center align-middle',//출고요청일
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data).format('YYYY-MM-DD')+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ data: 'judgmentDate', className : 'text-center align-middle',name:'judgmentDate',//판정일자
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data).format('YYYY-MM-DD')+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ data: 'judgmentUserNm', className : 'text-center align-middle',name:'judgmentUserNm',//판정자
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '판정대기';
					}
				}
			},
			{ data: 'confirmCd', className : 'text-center align-middle',name:'conFirmCd',//승인여부
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+_.filter(qualityConfirmList,v=>v.commonCd == data)[0].commonNm+'</div>';
					} else {
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">미승인</div>';
					}
				}
			},
			{ data: 'confirmUserNm', className : 'text-center align-middle',name:'confirmUserNm',//승인자
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ data: 'confirmDate', className : 'text-center align-middle',name:'confirmDate',//승인일자
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data).format('YYYY-MM-DD')+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ data: 'qualityDesc', className : 'text-center align-middle',name:'qualityDesc',//비고
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			}, 
			
		],
		columnDefs : [
			/*{
				targets: '_all',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},*/
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
			{ extend: 'colvisGroup',	className: 'd-none',	hide: '.colvisHide'},
			/* { extend: 'colvis',	text: 'Select Col',	}, */
		],
		order : [],
		drawCallback: function() {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#prodQualityTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 80)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAll').off('keyup',function() {});
			$('#searchAll').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			});

			let data = api.data();
			let node = api.nodes();
			if(data.length > 0){
				$(node).find('tbody tr').each(function(index, item) {
					if( prodQualityTable.row(item).data().confirmCd == '01' ) {
						$(prodQualityTable.row(item).node()).addClass('notEdit')
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
				let cell = $('#prodQualityTable_wrapper').find('.filters th').eq(
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
				$('#prodQualityTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
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
	prodQualityTable.on('column-reorder', function( e, settings, details ) {
		let api = prodQualityTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#prodQualityTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	//수정눌렀을떄
	$('#btnEdit').on('click',function(){
		var i = 0;
		WM_action_ON('ADM', 'workingWarningModal');

		$('#btnSearch').attr('disabled',false);
		$('#btnSave').attr('disabled',false);
		$('#btnEdit').attr('disabled',true);
		$('#btnCancel').attr('disabled',false);
		$('#btnConfirmY').attr('disabled',true);
		
		$('#prodQualityTable_wrapper').find('.filters th').each(function(index, item) {
			$(item).find('input').attr('disabled', true); // 검색 필터 disabled
		});
		//열 움직이는 기능 잠금
		prodQualityTable.colReorder.disable();
		
		$('#prodQualityTable tbody').find('tr').each(function(index_tr, tr) {
			if(!$(tr).hasClass('notEdit')){
				$(tr).find('td').each(function(index_td, td) {
					let data = prodQualityTable.row(tr).data();
					if(!isEmptyCheck(data)){
						let bizOrdQty = parseInt(data.bizOrdQty);		//수주수량
						let stockUseQty = parseInt(data.stockUseQty);	//재고사용수량
						let fairQty = parseInt(isEmptyCheck(data.fairQty) ? 0 : data.fairQty);
						// 수주>재고사용수량 and 생산이 된경우 OR 수주<=재고사용수량인경우
						if( (bizOrdQty > stockUseQty && fairQty != 0) || (bizOrdQty <= stockUseQty) ){
							if(index_td == prodQualityTable.column('passQty:name').index()) { //적합수량
								//let value = prodQualityTable.row(tr).data().fairQty != null && prodQualityTable.row(tr).data().fairQty != '' ? prodQualityTable.row(tr).data().fairQty : 0;
								//value = addCommas(parseInt(value));
								
								let value = '';
								if(data.rowGubun == 'workOrd'){
									value = isEmptyCheck(prodQualityTable.row(tr).data().fairQty) ? 0 : prodQualityTable.row(tr).data().fairQty;
								} else if(data.rowGubun == 'bizStockUse'){
									value = isEmptyCheck(prodQualityTable.row(tr).data().workOrdQty) ? 0 : prodQualityTable.row(tr).data().workOrdQty;
								}
								value = parseInt(value) + parseInt(prodQualityTable.row(tr).data().stockUseQty);
								
								value = addCommas(parseInt(value));
								$(td).html('<input type="text" name="passQty" class="form-control text-end calValue" onkeyup="numberFormat(this, \'int\')" value="'+value+'">');
							} else if(index_td == prodQualityTable.column('judgmentUserNm:name').index()) { //판정자
								let value = prodQualityTable.row(tr).data().judgmentUserNm;
								let html = '';
								if(value != null && value != ''){
									html += '<div class="input-group" style="min-width: 105px;max-width: 105px;">';
									html += '	<input type="text" class="form-control" value="'+value+'" disabled>';
									html += '	<button type="button" class="btnInputDel" style="background-color: transparent;';
									html += '		border-color: transparent; position: absolute;';
									html += '		top: 0; right:0;';
									html += '		margin: 1px 23px; margin-left: 0px;';
									html += '		border: none;';
									html += '		">';
									html += '		<i class="fa-solid fa-xmark"></i>';
									html += '	</button>';
									html += '	<input type="hidden" value="'+prodQualityTable.row(tr).data().judgmentUserIdx+'">';
									html += '	<button data-type="judgmentUserNm" type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary btnUserModalShow">';
									html += '		<i class="fa-solid fa-magnifying-glass"></i>';
									html += '	</button>';
									html += '</div>';
								} else {
									html += '<div class="input-group" style="min-width: 105px;max-width: 105px;">';
									html += '	<input type="text" class="form-control" value="'+sessionUserNm+'" disabled>';
									html += '	<button type="button" class="btnInputDel" style="background-color: transparent;';
									html += '		border-color: transparent; position: absolute;';
									html += '		top: 0; right:0;';
									html += '		margin: 1px 23px; margin-left: 0px;';
									html += '		border: none;';
									html += '		">';
									html += '		<i class="fa-solid fa-xmark"></i>';
									html += '	</button>';
									html += '	<input type="hidden" value="'+sessionUserIdx+'">';
									html += '	<button data-type="judgmentUserNm" type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary btnUserModalShow">';
									html += '		<i class="fa-solid fa-magnifying-glass"></i>';
									html += '	</button>';
									html += '</div>';
								}
								html += '<span class="d-none"></span>';
								$(td).html(html);
							} else if(index_td == prodQualityTable.column('judgmentDate:name').index()) { //판정일자
								let value = prodQualityTable.row(tr).data().judgmentDate;
								if(value == null || value == ''){
									value =  moment().format('YYYY-MM-DD');
								}
								value = moment(value).format('YYYY-MM-DD');
								$(td).html('<input name="judgmentDate" type="date" max="9999-12-31" class="form-control text-center" value="'+value+'">');
							} /* else if(index_td == prodQualityTable.column('conFirmCd:name').index()) { //승인여부
								let value = prodQualityTable.row(tr).data().conFirmCd;
								let html ='';
								html += '<select class="form-select">';
								if(value != null && value != ''){
									qualityConfirmList.forEach(function(item) {
										if(item.commonCd==value) {
											html +='	<option value="'+item.commonCd+'" selected>'+item.commonNm+'</option>';
										} else {
											html +='	<option value="'+item.commonCd+'">'+item.commonNm+'</option>';
										}
									});
								} else {
									qualityConfirmList.forEach(function(item) {
										html +='	<option value="'+item.commonCd+'">'+item.commonNm+'</option>';
									});
								}
								html += '</select>';
								
								$(td).html(html);
							} */ else if(index_td == prodQualityTable.column('qualityJudgmentCd:name').index()) { //적합여부
								let value = prodQualityTable.row(tr).data().qualityJudgmentCd;
								let html ='';
								html += '<div class="row d-flex justify-content-center align-items-center" style="min-width:150px;">';
								html += '<div class="btn-group" role="group" aria-label="Small button group">';
								//html += '<button type="button" class="btn btn-outline-light w-auto" style="min-width:75px;max-width:75px;" data-val="02" name="btnJudgmentY">적합</button>';
								//html += '<button type="button" class="btn btn-outline-light w-auto" style="min-width:75px;max-width:75px;" data-val="03" name="btnJudgmentN">부적합</button>';
								html += '<input data-val="02" type="checkbox" class="btn-check" name="JudgmentY" id="JudgmentY'+i+'">';
								html += '<label data-val="02" class="btn btn-outline-primary d-flex justify-content-center align-items-center" style="min-width:75px;max-width:75px;" for="JudgmentY'+i+'" name="btnJudgmentY">적합</label>';
								html += '<input data-val="03" type="checkbox" class="btn-check" name="JudgmentN" id="JudgmentN'+i+'">';
								html += '<label data-val="03" class="btn btn-outline-danger d-flex justify-content-center align-items-center" style="min-width:75px;max-width:75px;border-color: #dc3545;" for="JudgmentN'+i+'" name="btnJudgmentN">부적합</label>';
								html += '</div>';
								html += '</div>';
								/* html += '<select name="qualityJudgmentCd" class="form-select">';
								if(value != null && value != ''){
									qualityJudgmentCdList.forEach(function(item) {
										if(item.commonCd==value) {
											html +='	<option value="'+item.commonCd+'" selected>'+item.commonNm+'</option>';
										} else {
											html +='	<option value="'+item.commonCd+'">'+item.commonNm+'</option>';
										}
									});
								} else {
									qualityJudgmentCdList.forEach(function(item) {
										html +='	<option value="'+item.commonCd+'">'+item.commonNm+'</option>';
									});
								}
								html += '</select>'; */
								i++;
								$(td).html(html);
							} else if(index_td == prodQualityTable.column('confirmUserNm:name').index()) { //승인자
								let value = prodQualityTable.row(tr).data().confirmUserNm;
								let html = '';
								if(value != null && value != ''){
									html += '<div class="input-group" style="min-width: 105px;max-width: 105px;">';
									html += '	<input type="text" class="form-control" value="'+value+'" disabled>';
									html += '	<button type="button" class="btnInputDel" style="background-color: transparent;';
									html += '		border-color: transparent; position: absolute;';
									html += '		top: 0; right:0;';
									html += '		margin: 1px 23px; margin-left: 0px;';
									html += '		border: none;';
									html += '		">';
									html += '		<i class="fa-solid fa-xmark"></i>';
									html += '	</button>';
									html += '	<input type="hidden" value="'+prodQualityTable.row(tr).data().confirmUserIdx+'">';
									html += '	<button data-type="confirmUserNm" type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary btnUserModalShow">';
									html += '		<i class="fa-solid fa-magnifying-glass"></i>';
									html += '	</button>';
									html += '</div>';
								} else {
									html += '<div class="input-group" style="min-width: 105px;max-width: 105px;">';
									html += '	<input type="text" class="form-control" value="'+sessionUserNm+'" disabled>';
									html += '	<button type="button" class="btnInputDel" style="background-color: transparent;';
									html += '		border-color: transparent; position: absolute;';
									html += '		top: 0; right:0;';
									html += '		margin: 1px 23px; margin-left: 0px;';
									html += '		border: none;';
									html += '		">';
									html += '		<i class="fa-solid fa-xmark"></i>';
									html += '	</button>';
									html += '	<input type="hidden" value="'+sessionUserIdx+'">';
									html += '	<button data-type="confirmUserNm" type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary btnUserModalShow">';
									html += '		<i class="fa-solid fa-magnifying-glass"></i>';
									html += '	</button>';
									html += '</div>';
								}
								html += '<span class="d-none"></span>';
								$(td).html(html);
							} else if(index_td == prodQualityTable.column('confirmDate:name').index()) { //승인일자
								let value = prodQualityTable.row(tr).data().confirmDate;
								if(value == null || value == ''){
									value =  moment().format('YYYY-MM-DD');
								}
								value = moment(value).format('YYYY-MM-DD');
								$(td).html('<input name="judgmentDate" type="date" max="9999-12-31" class="form-control text-center" value="'+value+'">');
							}
						}
					}
				})
			}
		});

		prodQualityTable.draw(false);
	})
	
	$('#btnSearch').on('click',function(){
		WM_action_OFF('ADM');
		prodQualityTable.ajax.reload();
		prodQualityTable.colReorder.enable();
		$('#prodQualityTable_wrapper').find('.filters th').each(function(index, item) {
			$(item).find('input').attr('disabled', false); // 검색 필터 disabled
		});
		$('#btnSave').attr('disabled', true); // 저장 버튼
		$('#btnEdit').attr('disabled', false); // 수정 버튼
		$('#btnDel').attr('disabled', false); // 삭제 버튼
		$('#btnCancel').attr('disabled', true); // 취소 버튼
		$('#btnConfirmY').attr('disabled',false);

		$('#btnAllCheck').prop("checked",false);
	});
	
	//저장
	$('#btnSave').on('click',function(){
		let array = [];
		let arrayConfirm = [];
		let state = true;
		let workOrdResultIdxString = '';
		let bizOrdDtlIdxString = '';
		$('#prodQualityTable tbody').find('tr').each(function(index, item) {
			if( $(item).find('td').find('input[name=inputCheck]').prop('checked') ){
				let td = $(item).find('td');
				let data = prodQualityTable.row($(item)).data();
				let node = prodQualityTable.row($(item)).node();
				
				let passQty = removeCommas($(td).eq(prodQualityTable.column('passQty:name').index()).find('input').val());
				//let qualityJudgmentCd = $(td).eq(prodQualityTable.column('qualityJudgmentCd:name').index()).find('select').val();
				let qualityJudgmentElement = $(td).eq(prodQualityTable.column('qualityJudgmentCd:name').index()).find('input:checked');
				let qualityJudgmentCd = $(qualityJudgmentElement[0]).data('val');
				let judgmentUserIdx = $(td).eq(prodQualityTable.column('judgmentUserNm:name').index()).find('input[type=hidden]').val();
				let judgmentDate = $(td).eq(prodQualityTable.column('judgmentDate:name').index()).find('input').val().replaceAll('-','');
				let confirmUserIdx = $(td).eq(prodQualityTable.column('confirmUserNm:name').index()).find('input[type=hidden]').val();
				let confirmDate = $(td).eq(prodQualityTable.column('confirmDate:name').index()).find('input').val().replaceAll('-','');
	
				if(passQty == '' || passQty == null || passQty == undefined){
					toastr.warning('적합수량을 입력 해주세요.');
					$(td).eq(prodQualityTable.column('passQty:name').index()).find('input').focus();
					state = false;
					return false;
				}
				//if(qualityJudgmentCd == '' || qualityJudgmentCd == null || qualityJudgmentCd == undefined){
				if(qualityJudgmentElement.length == 0){
					toastr.warning('적합여부를 선택 해주세요.');
					$(td).eq(prodQualityTable.column('qualityJudgmentCd:name').index()).find('select').focus();
					state = false;
					return false;
				}		
				if(judgmentUserIdx == '' || judgmentUserIdx == null || judgmentUserIdx == undefined){
					toastr.warning('판정자를 선택 해주세요.');
					$(td).eq(prodQualityTable.column('judgmentUserNm:name').index()).find('.btnUserModalShow').focus();
					state = false;
					return false;
				}			
				if(judgmentDate == '' || judgmentDate == null || judgmentDate == undefined){
					toastr.warning('판정일자를 선택 해주세요.');
					$(td).eq(prodQualityTable.column('judgmentDate:name').index()).find('input').focus();
					state = false;
					return false;
				}		
				if(confirmUserIdx == '' || confirmUserIdx == null || confirmUserIdx == undefined){
					toastr.warning('승인자를 선택 해주세요.');
					$(td).eq(prodQualityTable.column('confirmUserNm:name').index()).find('.btnUserModalShow').focus();
					state = false;
					return false;
				}			
				if(confirmDate == '' || confirmDate == null || confirmDate == undefined){
					toastr.warning('승인일자를 선택 해주세요.');
					$(td).eq(prodQualityTable.column('confirmDate:name').index()).find('input').focus();
					state = false;
					return false;
				}				
				let obj = new Object();
				obj.idx = data.idx;
				
				if(data.rowGubun == 'workOrd'){
					obj.testGubun = '01'; //시스템 035번 검사구분 01 생산제품검사 
					obj.workOrdResultIdx = data.workOrdResultIdx;
					obj.bizOrdDtlIdx = 0;
				} else if(data.rowGubun == 'bizStockUse'){
					obj.testGubun = '02'; //시스템 035번 검사구분 02 재고제품검사
					obj.workOrdResultIdx = 0;
					obj.bizOrdDtlIdx = data.bizOrdDtlIdx;
				}
				
				obj.passQty = passQty;
				obj.qualityJudgmentCd = qualityJudgmentCd;
				obj.judgmentUserIdx = judgmentUserIdx
				obj.judgmentDate = judgmentDate;
				obj.confirmUserIdx = confirmUserIdx;
				obj.confirmDate = confirmDate;
				array.push(obj);
				//품질 적합,부적합인경우 승인도 같이 되도록 변경
				if(qualityJudgmentCd == '02' || qualityJudgmentCd == '03'){
					let obj = new Object();
					obj.idx = data.idx;
					obj.workOrdResultIdx = data.workOrdResultIdx;
					obj.itemIdx = data.itemIdx;
					obj.bizOrdDtlIdx = data.bizOrdDtlIdx;
					obj.bizOrdDtlNo = data.bizOrdDtlNo;
					arrayConfirm.push(obj);
					bizOrdDtlIdxString += data.bizOrdDtlIdx +',';
					workOrdResultIdxString += data.workOrdResultIdx +',';
				} 
			}
		});
		if(!state) {
			return false;
		}
		
		if(array.length == 0 && arrayConfirm.length == 0) {
			toastr.warning('등록할 항목을 체크해주세요.');
			state = false;
			return false;
		}
		
		let updateList = _.filter(array, v=> v.idx != null && v.idx != '');
		let insertList = _.filter(array, v=> v.idx == null || v.idx == '');
		workOrdResultIdxString = workOrdResultIdxString.slice(0,-1);
		bizOrdDtlIdxString = bizOrdDtlIdxString.slice(0,-1);
		$.ajax({
			url: '<c:url value="/qm/prodQualityAdmUpd"/>',
            type: 'POST',
            data: {
                'updateList'	:	JSON.stringify(updateList),
                'insertList'	:	JSON.stringify(insertList),
                'insertConfimList' :	JSON.stringify(arrayConfirm),
                'workOrdResultIdxString' : function(){ return workOrdResultIdxString; },
                'bizOrdDtlIdxString'		: function(){ return bizOrdDtlIdxString; },
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					toastr.success('수정되었습니다.');
					$('#prodQualityTable_wrapper').find('.filters th').each(function(index, item) {
						$(item).find('input').attr('disabled', false); // 검색 필터 disabled
					});
					//열 움직이는 기능 잠금
					prodQualityTable.colReorder.enable();
					WM_action_OFF('ADM');
					prodQualityTable.rows('.selected').deselect();
					
					prodQualityTable.ajax.reload();
					$('#btnSearch').attr('disabled',false);
					$('#btnSave').attr('disabled',true);
					$('#btnEdit').attr('disabled',false);
					$('#btnCancel').attr('disabled',true);
					$('#btnConfirmY').attr('disabled',false);
					$('#btnAllCheck').prop("checked",false);
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
		
	})
	
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

			prodQualityTable.clear();
		}
	});

	$('#btnWorkingWarningModalY').on('click', function() {
		if(WMlastIdx == 'ADM') {
			$('#btnSave').trigger('click');
			return false;
		}
	});

	/* 승인처리 */
	$('#btnConfirmY').on('click',function(){
		let array = [];
		let state = true;
		$('#prodQualityTable tbody').find('tr').each(function(index, item) {
			if( $(item).find('td').find('input[name=inputCheck]').prop('checked') ){
				let td = $(item).find('td');
				let data = prodQualityTable.row($(item)).data();
				let node = prodQualityTable.row($(item)).node();

				//미판정인경우
				if(data.qualityJudgmentCd == '01'){
					toastr.warning('미판정인 경우 승인할 수 없습니다.<br>수주상세 : '+data.bizOrdDtlNo);
					//$(td).eq(prodQualityTable.column('checkbox:name').index()).find('input').focus();
					state = false;
					return false;
				}
								
				let obj = new Object();
				obj.idx = data.idx;
				obj.itemIdx = data.itemIdx;
				obj.itemVersionIdx = data.itemVersionIdx;
				obj.bizOrdDtlIdx = data.bizOrdDtlIdx;
				obj.bizOrdDtlNo = data.bizOrdDtlNo;n
				
				array.push(obj);
			}
		});
		
		if(!state) {
			return false;
		}
		
		if(array.length == 0) {
			toastr.warning('승인할 항목을 체크해주세요.');
			state = false;
			return false;
		}

		$.ajax({
			url: '<c:url value="/qm/prodQualityAdmConfirmUpd"/>',
            type: 'POST',
            data: {
                'updateList'	:	JSON.stringify(array)
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					toastr.success('승인되었습니다.');
					$('#prodQualityTable_wrapper').find('.filters th').each(function(index, item) {
						$(item).find('input').attr('disabled', false); // 검색 필터 disabled
					});
					//열 움직이는 기능 잠금
					prodQualityTable.colReorder.enable();
					WM_action_OFF('ADM');
					prodQualityTable.rows('.selected').deselect();
					
					prodQualityTable.ajax.reload();
					$('#btnSearch').attr('disabled',false);
					$('#btnSave').attr('disabled',true);
					$('#btnEdit').attr('disabled',false);
					$('#btnCancel').attr('disabled',true);
					$('#btnConfirmY').attr('disabled',false);
					$('#btnAllCheck').prop("checked",false);
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
	});

	/* 삭제처리 */
	$('#btnDel').on('click',function(){
		/* if($('#prodQualityTable tbody').find('tr.selected').length == 0) {
			toastr.warning('삭제할 항목을 선택해주세요.');
			return false;
		}
		let idx = prodQualityTable.row('.selected').data().idx;
		if(idx == null || idx == 'null' || idx == '' || idx == undefined){
			toastr.warning('검사된 항목만 삭제할 수 있습니다.');
			return false;
		} */ 
		if($('input[name=inputCheck]:checked').length == 0){
			toastr.warning('삭제할 항목을 체크해주세요.');
			return false;
		}
		$('#deleteModal').modal('show');
		$('#deleteModal').data('deleteType','ADM');
	});

	$('#btnDeleteModalY').on('click',function(){
		let deleteType = $('#deleteModal').data('deleteType');
		if(deleteType == 'ADM'){
			let array = [];
			
			$('input[name=inputCheck]:checked').each(function(index, item){
				let tr = $(item).parent().parent();
				let node = prodQualityTable.row(tr).node();
				let data = prodQualityTable.row(tr).data();

				let obj = {};
				obj.idx = data.idx;
				obj.bizOrdDtlIdx = data.bizOrdDtlIdx;
				obj.bizOrdDtlNo = data.bizOrdDtlNo;
				array.push(obj);
			});
			$.ajax({
				url: '<c:url value="/qm/prodQualityAdmDel"/>',
	            type: 'POST',
	            data: {
		            'deleteList'	:	function(){ return JSON.stringify(array); }
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
			/* let idx = prodQualityTable.row('.selected').data().idx;
			let bizOrdDtlIdx = prodQualityTable.row('.selected').data().bizOrdDtlIdx;
			let bizOrdDtlNo = prodQualityTable.row('.selected').data().bizOrdDtlNo;
			$.ajax({
				url: '<c:url value="/qm/prodQualityAdmDel"/>',
	            type: 'POST',
	            data: {
		            'idx'				:	function(){ return idx; },
		            'bizOrdDtlIdx'		:	function(){ return bizOrdDtlIdx; },
	            	'bizOrdDtlNo'		:	function(){ return bizOrdDtlNo; },
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
			}); */
						
		}
		
	});
	
	/* 거래처 모달 */
	
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
	
	/* 제품코드 모달  */
	
	$('#btnSearchItem').on('click',function(){
		
		$('#itemCodeModal').modal('show');
		setTimeout(function() {
			itemCodeModalTable.ajax.reload(function() {itemCodeModalTable.draw(false);});
		}, 200);
	});

	//제품정보 목록(모달)조회
	$('#itemCodeModalTable thead tr').clone(true).addClass('filters').appendTo('#itemCodeModalTable thead'); // filter 생성
	let itemCodeModalTable = $('#itemCodeModalTable').DataTable({
		dom : "<'row'<'col-md-12 col-md-6'l><'col-md-12 col-md-6'f>>"
				+ "<'row'<'col-md-12'tr>>"
				+ "<'row pt-1'<'d-flex align-items-center d-flex col-sm'B><'me-lg-auto div-align-center col-sm'p><'d-flex align-items-center justify-content-end col-sm'i>>",
		language: lang_kor,
		info: true,
		ordering: true,
		processing: true,
		paging: true,
		lengthChange: false,
		searching: true,
		autoWidth: false,
		orderCellsTop: true,
        fixedHeader: false,
        scrollY: '100vh',
        scrollX: true,
		pageLength: pageLengthCnt,
		colReorder: true,
		select: {
            style: 'single',
            toggleable: false,
            items: 'row',
            info: false
        },
        ajax : {
			url : '<c:url value="/bm/itemInfoDtlListAll"/>',
			type : 'GET',
			data : {
				useYnCd		: function(){ return $('#modalUseYnCdBox').val(); }, //사용여부
				itemGubun	: function(){ return $('#modalItemGubunBox').val(); }, //품목구분
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'customerNm', className : 'text-center align-middle'},	//고객사
			{ data: 'itemNm', className : 'text-center align-middle'}, 		//제품명
			{ //건별전달사항
				data: 'relayNotice', className : 'text-start align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space:pre-line;width:330px;">'+data+'</div>';
						
					} else {
						return "";
					}
				}	
			},
			{ data: 'knifeTipSize', className : 'text-center align-middle'}, //칼끝규격
			{ //자재코드
				data: 'customerItemCd', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						
					} else {
						return "";
					}
				}
			},
			{ data: 'versionNum', className : 'text-center align-middle'}, //버전번호
			{ //재질
				data: 'paperType', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						
					} else {
						return "";
					}
				}
			},
			{ //절수
				data: 'cutQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
						
					} else {
						return "";
					}
				}
			},
			{ //개수
				data: 'eaQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
						
					} else {
						return "";
					}
				}
			},
			{ data: 'itemColor', className : 'text-center align-middle'}, //COLOR		
			{ //도수
				data: 'frequencyNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						
					} else {
						return "";
					}
				}
			},
			{ data: 'itemSize', className : 'text-center align-middle'}, //사이즈
			{ data: 'coatingMethod', className : 'text-center align-middle'}, //코팅방법
			{ //특이사항
				data: 'specialNotice', className : 'text-start align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space:pre-line;width:330px;">'+data+'</div>';
						
					} else {
						return "";
					}
				}
			},
			{ data: 'moldingMethod', className : 'text-center align-middle'}, //성형방식
			{ data: 'moldingContents', className : 'text-center align-middle'}, //성형내용
			{ //묶음법
				data: 'bundleMethodNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						
					} else {
						return "";
					}
				}
			},
			{ data: 'bundleUnit', className : 'text-center align-middle'}, //묶음단위
			{//포장박스
				data: 'packMethodNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return "";
					}
				}
			},
			{ data: 'packUnit', className : 'text-center align-middle'}, //포장단위
			{ //호기
				data: 'etc1Nm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						
					} else {
						return "";
					}
				}
			},
			{ //목형번호
				data: 'woodenCareNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						
					} else {
						return "";
					}
				}
			},
			{ data: 'holeWoodenCd', className : 'text-center align-middle'}, //타공목형번호
			{ //수지판번호
				data: 'resinBoardNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						
					} else {
						return "";
					}
				}
			},
			{ //현재고량
				data: 'stock', className : 'text-end  align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseInt(data))+'</div>';
						
					} else {
						return "";
					}
				}
			},
			{ //검수방법
				data: 'inspectMethodNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						
					} else {
						return "";
					}
				}
			},
			{//착인여부
				data: 'printingYnCheckNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						
					} else {
						return "";
					}
				}
			},
			{ //사용여부
				data: 'useYnCd', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data == 'Y'){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">사용</div>';
					} else if (data == 'N'){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">미사용</div>';
					} else {
						return "";
					}
				}
			},
			{ //등록일자
				data: 'detailDate', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data,'YYYY-MM-DD').format('YYYY-MM-DD')+'</div>';
						
					} else {
						return "";
					}
				}
			},
			{ //후가공판번호
				data: 'etc2Cd', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						
					} else {
						return "";
					}
				}
			},		
			{ data: 'etc3', className : 'text-center align-middle'}, //부분UV	
			{ data: 'etc4', className : 'text-center align-middle'}, //FOIL	
			{ data: 'etc6', className : 'text-center align-middle'}, //형압
			{ data: 'etc7', className : 'text-center align-middle'}, //FSC 유무
			{ data: 'etc8', className : 'text-center align-middle'}, //납품처
			{ data: 'etc9', className : 'text-center align-middle'}, //공정실적여부
			{ data: 'etc10', className : 'text-center align-middle'}, //기타1
			{ data: 'etc5', className : 'text-center align-middle'}, //기타2
			{ data: 'pressMethod', className : 'text-center align-middle'},	//기타3
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
			let theadHeight = parseFloat($('#itemCodeModalTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 250)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#modalItemCodeSearchAll').off('keyup',function() {});
			$('#modalItemCodeSearchAll').on('keyup',function() {
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
				let cell = $('#itemCodeModalTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#itemCodeModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	itemCodeModalTable.on('column-reorder', function( e, settings, details ) {
		let api = itemCodeModalTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#itemCodeModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});
	
	$('#btnItemCodeModalSearch').on('click',function(){
		itemCodeModalTable.ajax.reload(function() {});
	});

	$('#btnItemCodeModalPaste').on('click',function(){
		if( !$('#itemCodeModalTable tbody tr').hasClass('selected') ){
			toastr.warning('붙여넣을 행을 선택해주세요.');
			return false;
		}

		let data = itemCodeModalTable.row('.selected').data();
		$('#itemNm').val(data.itemNm);
		$('#itemIdx').val(data.idx);
		$('#itemCodeModal').modal('hide');
	});

	$('#itemCodeModalTable tbody').on('dblclick','tr',function(){
		let data = itemCodeModalTable.row(this).data();
		$('#itemNm').val(data.itemNm);
		$('#itemIdx').val(data.idx);
		$('#itemCodeModal').modal('hide');
	});

	/* 사용자 모달 */
	// 유저모달 버튼 click
	$(document).on('click', '.btnUserModalShow', function() {
		$('#userModal').data('type',$(this).data('type'));
		$('#userModal').modal('show');
	});
	$('#userModal').on('shown.bs.modal', function() {
		userModalTable.ajax.reload(function() {});
	});

	// 사용자정보 목록조회
	$('#userModalTable thead tr').clone(true).addClass('filters').appendTo('#userModalTable thead'); // filter 생성
	let userModalTable = $('#userModalTable').DataTable({
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
			url : '<c:url value="/sm/userLst"/>',
			type : 'POST',
			data : {
				userStateCd: function() { return $('#SearchUserStateCd').val(); }
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'userId', className : 'text-center'},
			{ data: 'userName', className : 'text-center'},
			{ data: 'userDepartmentNm', className : 'text-center'},
			{ data: 'userPositionNm', className : 'text-center'},
			{ data: 'userJobCd', className : 'text-center'},
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
			let theadHeight = parseFloat($('#userModalTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 197)+'px');
			
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
				let cell = $('#userModalTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#userModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	userModalTable.on('column-reorder', function( e, settings, details ) {
		let api = userModalTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#userModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	// 사용자목록 적용 버튼 click
	$('#btnUserModalPaste').on('click', function(){
		if(!$('#userModalTable tbody tr').hasClass('selected')){
			toastr.warning('붙여넣을 행을 선택해주세요.');
			return false;
		}
		let table = $('#prodQualityTable').dataTable().api();
		let node = table.row('.selected').node();
		let data = table.row('.selected').data();
		let selectNodeModalData = userModalTable.row('.selected').data();
		$(node).find('td').eq(table.column($('#userModal').data('type')+':name').index()).find('input[type=hidden]').val(selectNodeModalData.idx);	//사용자 식별자
		$(node).find('td').eq(table.column($('#userModal').data('type')+':name').index()).find('input[type=text]').val(selectNodeModalData.userName);		//사용자 이름
		$('#userModal').modal('hide');
	});
	
	$('#userModalTable tbody').on('dblclick','tr',function(){
		let table = $('#prodQualityTable').dataTable().api();
		let node = table.row('.selected').node();
		let data = table.row('.selected').data();
		let selectNodeModalData = userModalTable.row(this).data();
		$(node).find('td').eq(table.column($('#userModal').data('type')+':name').index()).find('input[type=hidden]').val(selectNodeModalData.idx);	//사용자 식별자
		$(node).find('td').eq(table.column($('#userModal').data('type')+':name').index()).find('input[type=text]').val(selectNodeModalData.userName);		//사용자 이름
		$('#userModal').modal('hide');
	});
	
	//모든 체크박스 선택
	$('#btnAllCheck').on('click',function(){
		if($('#btnAllCheck').prop("checked")){
			$('input:checkbox[name=inputCheck]').prop("checked",true);
		}else{
			$('input:checkbox[name=inputCheck]').prop("checked",false);
		}
	});
	// 모든 체크박스 체크/해제 되도록
	$(document).on('change','input:checkbox[name=inputCheck]', function(){
		if( $('input:checkbox[name=inputCheck]').length == $('input:checkbox[name=inputCheck]:checked').length ){ //전체 체크박스 수와 체크된 박스의 수가 같을 때 -> 전체체크박스 체크 , 아닐 경우 해제
			$('#btnAllCheck').prop("checked",true);
		} else{
			$('#btnAllCheck').prop("checked",false);
		}
 	});

	//일괄 미판정,적합,부적합
	$('#btnUndecided, #btnJudgmentY, #btnJudgmentN').on('click',function(){
		let btnVal = $(this).data('val');
		$('input[name=inputCheck]:checked').each(function(index,item){
			let tr = $(item).parent().parent();
			let node = prodQualityTable.row(tr).node();
			let data = prodQualityTable.row(tr).data();

			$(node).find('select[name=qualityJudgmentCd]').val(btnVal);
		});
	});

	//적합 / 부적합 버튼 클릭시 해당 선택되도록
	/*$(document).on('change', 'input[name=JudgmentY]', function(){
		if( $(this).prop('checked') ) {
			$(this).next().css('background-color','#3daf33');
			$(this).next().css('color','#FFFFFF');
			$(this).parent().find('input[name=JudgmentN]').prop('checked',false);
			$(this).parent().find('label[name=btnJudgmentN]').css('background-color','#FFFFFF');
			$(this).parent().find('label[name=btnJudgmentN]').css('color','#3daf33');
		} else {   
			$(this).next().css('background-color','#FFFFFF');
			$(this).next().css('color','#3daf33');
		}
	});
	$(document).on('change', 'input[name=JudgmentN]', function(){
		if( $(this).prop('checked') ) {
			$(this).next().css('background-color','#3daf33');
			$(this).next().css('color','#FFFFFF');
			$(this).parent().find('input[name=JudgmentY]').prop('checked',false);
			$(this).parent().find('label[name=btnJudgmentY]').css('background-color','#FFFFFF');
			$(this).parent().find('label[name=btnJudgmentY]').css('color','#3daf33');
		} else {   
			$(this).next().css('background-color','#FFFFFF');
			$(this).next().css('color','#3daf33');
		}
	});*/
	$(document).on('click', 'label[name=btnJudgmentN], label[name=btnJudgmentY]', function(){
		$('#my-spinner').show();
		let tr = $(this).parent().parent().parent().parent();

		let array = [];
		let arrayConfirm = [];
		let state = true;
		let workOrdResultIdxString = '';
		let bizOrdDtlIdxString = '';

		let td = $(tr).find('td');
		let data = prodQualityTable.row(tr).data();
		let node = prodQualityTable.row(tr).node();
		
		let passQty = removeCommas($(td).eq(prodQualityTable.column('passQty:name').index()).find('input').val());
		//let qualityJudgmentCd = $(td).eq(prodQualityTable.column('qualityJudgmentCd:name').index()).find('select').val();
		let qualityJudgmentCd = $(this).data('val');
		let judgmentUserIdx = $(td).eq(prodQualityTable.column('judgmentUserNm:name').index()).find('input[type=hidden]').val();
		let judgmentDate = $(td).eq(prodQualityTable.column('judgmentDate:name').index()).find('input').val().replaceAll('-','');
		let confirmUserIdx = $(td).eq(prodQualityTable.column('confirmUserNm:name').index()).find('input[type=hidden]').val();
		let confirmDate = $(td).eq(prodQualityTable.column('confirmDate:name').index()).find('input').val().replaceAll('-','');

		let bizOrdQty = parseInt(data.bizOrdQty);		//수주수량
		let stockUseQty = parseInt(data.stockUseQty);	//재고사용수량
		let fairQty = parseInt(isEmptyCheck(data.fairQty) ? 0 : data.fairQty);			//생산수량

		//수주수량 > 재고사용수량인 경우 생산수량이 있을 경우 검사하도록
		//원래는 jsp말고 컨트롤러랑 프로시저에서 체크해줘야함 -> 동시성이나 여러가지 문제되면 그때바꾸면됨
		if(bizOrdQty > stockUseQty && fairQty == 0){
			toastr.warning('해당 수주는 생산이 완료된 경우<br>검사할 수 있습니다.');
			state = false;
		}
		
		if(passQty == '' || passQty == null || passQty == undefined || passQty == 0){
			toastr.warning('적합수량을 입력 해주세요.');
			$(td).eq(prodQualityTable.column('passQty:name').index()).find('input').focus();
			state = false;
		}

		if(judgmentUserIdx == '' || judgmentUserIdx == null || judgmentUserIdx == undefined){
			toastr.warning('판정자를 선택 해주세요.');
			$(td).eq(prodQualityTable.column('judgmentUserNm:name').index()).find('.btnUserModalShow').focus();
			state = false;
		}			
		if(judgmentDate == '' || judgmentDate == null || judgmentDate == undefined){
			toastr.warning('판정일자를 선택 해주세요.');
			$(td).eq(prodQualityTable.column('judgmentDate:name').index()).find('input').focus();
			state = false;
		}		
		if(confirmUserIdx == '' || confirmUserIdx == null || confirmUserIdx == undefined){
			toastr.warning('승인자를 선택 해주세요.');
			$(td).eq(prodQualityTable.column('confirmUserNm:name').index()).find('.btnUserModalShow').focus();
			state = false;
		}			
		if(confirmDate == '' || confirmDate == null || confirmDate == undefined){
			toastr.warning('승인일자를 선택 해주세요.');
			$(td).eq(prodQualityTable.column('confirmDate:name').index()).find('input').focus();
			state = false;
		}				

		//부적합판정인경우 경고모달
		if(qualityJudgmentCd == '03' && state == true){
			$('#my-spinner').hide();
			$(this).prop('checked',false);
			$(this).css('background-color','transparent');
			$(this).css('color','#dc3545');
			showModal()
				.then(function() {
					// 모달 확인 버튼을 눌렀을 때
					let obj = new Object();
					obj.idx = data.idx;
					
					if(data.rowGubun == 'workOrd'){
						obj.testGubun = '01'; //시스템 035번 검사구분 01 생산제품검사 
						obj.workOrdResultIdx = data.workOrdResultIdx;
						obj.bizOrdDtlIdx = data.bizOrdDtlIdx;
					} else if(data.rowGubun == 'bizStockUse'){
						obj.testGubun = '02'; //시스템 035번 검사구분 02 재고제품검사
						obj.workOrdResultIdx = data.workOrdResultIdx;
						obj.bizOrdDtlIdx = data.bizOrdDtlIdx;
					}
					
					obj.passQty = passQty;
					obj.qualityJudgmentCd = qualityJudgmentCd;
					obj.judgmentUserIdx = judgmentUserIdx
					obj.judgmentDate = judgmentDate;
					obj.confirmUserIdx = confirmUserIdx;
					obj.confirmDate = confirmDate;
					array.push(obj);
					//품질 적합,부적합인경우 승인도 같이 되도록 변경
					if(qualityJudgmentCd == '02' || qualityJudgmentCd == '03'){
						let obj = new Object();
						obj.idx = data.idx;
						obj.workOrdResultIdx = data.workOrdResultIdx;
						obj.itemIdx = data.itemIdx;
						obj.bizOrdDtlIdx = data.bizOrdDtlIdx;
						obj.bizOrdDtlNo = data.bizOrdDtlNo;
						arrayConfirm.push(obj);
						bizOrdDtlIdxString += data.bizOrdDtlIdx +',';
						workOrdResultIdxString += data.workOrdResultIdx +',';
					} 
					if(!state) {
						$('#my-spinner').hide();
						return false;
					}
					let updateList = _.filter(array, v=> v.idx != null && v.idx != '');
					let insertList = _.filter(array, v=> v.idx == null || v.idx == '');
					workOrdResultIdxString = workOrdResultIdxString.slice(0,-1);
					bizOrdDtlIdxString = bizOrdDtlIdxString.slice(0,-1);
					$.ajax({
						url: '<c:url value="/qm/prodQualityAdmUpd"/>',
			            type: 'POST',
			            data: {
			                'updateList'	:	JSON.stringify(updateList),
			                'insertList'	:	JSON.stringify(insertList),
			                'insertConfimList' :	JSON.stringify(arrayConfirm),
			                'workOrdResultIdxString' : function(){ return workOrdResultIdxString; },
			                'bizOrdDtlIdxString'		: function(){ return bizOrdDtlIdxString; },
			            },
			            beforeSend: function() {
			            	$('#my-spinner').show();
			            },
						success : function(res) {
							if (res.result == "ok") { //응답결과
								toastr.success('수정되었습니다.');
								$('#prodQualityTable_wrapper').find('.filters th').each(function(index, item) {
									$(item).find('input').attr('disabled', false); // 검색 필터 disabled
								});
								//열 움직이는 기능 잠금
								prodQualityTable.colReorder.enable();
								WM_action_OFF('ADM');
								prodQualityTable.rows('.selected').deselect();
								
								prodQualityTable.ajax.reload(function(){
									$('#btnEdit').trigger('click');
								}, false);
								$('#btnSearch').attr('disabled',false);
								$('#btnSave').attr('disabled',true);
								$('#btnEdit').attr('disabled',false);
								$('#btnCancel').attr('disabled',true);
								$('#btnConfirmY').attr('disabled',false);
								$('#btnAllCheck').prop("checked",false);
							} else if(res.result == 'fail') {
								toastr.warning(res.message);
							} else {
								toastr.error(res.message);
							}
							$('#my-spinner').hide();
						}
					});
				})
				.catch(function() {
					$('#my-spinner').hide();
				});
		} else {
			let obj = new Object();
			obj.idx = data.idx;
			
			if(data.rowGubun == 'workOrd'){
				obj.testGubun = '01'; //시스템 035번 검사구분 01 생산제품검사 
				obj.workOrdResultIdx = data.workOrdResultIdx;
				obj.bizOrdDtlIdx = data.bizOrdDtlIdx;
			} else if(data.rowGubun == 'bizStockUse'){
				obj.testGubun = '02'; //시스템 035번 검사구분 02 재고제품검사
				obj.workOrdResultIdx = data.workOrdResultIdx;
				obj.bizOrdDtlIdx = data.bizOrdDtlIdx;
			}
			
			obj.passQty = passQty;
			obj.qualityJudgmentCd = qualityJudgmentCd;
			obj.judgmentUserIdx = judgmentUserIdx
			obj.judgmentDate = judgmentDate;
			obj.confirmUserIdx = confirmUserIdx;
			obj.confirmDate = confirmDate;
			array.push(obj);
			//품질 적합,부적합인경우 승인도 같이 되도록 변경
			if(qualityJudgmentCd == '02' || qualityJudgmentCd == '03'){
				let obj = new Object();
				obj.idx = data.idx;
				obj.workOrdResultIdx = data.workOrdResultIdx;
				obj.itemIdx = data.itemIdx;
				obj.bizOrdDtlIdx = data.bizOrdDtlIdx;
				obj.bizOrdDtlNo = data.bizOrdDtlNo;
				arrayConfirm.push(obj);
				bizOrdDtlIdxString += data.bizOrdDtlIdx +',';
				workOrdResultIdxString += data.workOrdResultIdx +',';
			} 
			if(!state) {
				$('#my-spinner').hide();
				return false;
			}
			let updateList = _.filter(array, v=> v.idx != null && v.idx != '');
			let insertList = _.filter(array, v=> v.idx == null || v.idx == '');
			workOrdResultIdxString = workOrdResultIdxString.slice(0,-1);
			bizOrdDtlIdxString = bizOrdDtlIdxString.slice(0,-1);
			$.ajax({
				url: '<c:url value="/qm/prodQualityAdmUpd"/>',
	            type: 'POST',
	            data: {
	                'updateList'	:	JSON.stringify(updateList),
	                'insertList'	:	JSON.stringify(insertList),
	                'insertConfimList' :	JSON.stringify(arrayConfirm),
	                'workOrdResultIdxString' : function(){ return workOrdResultIdxString; },
	                'bizOrdDtlIdxString'		: function(){ return bizOrdDtlIdxString; },
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if (res.result == "ok") { //응답결과
						toastr.success('수정되었습니다.');
						$('#prodQualityTable_wrapper').find('.filters th').each(function(index, item) {
							$(item).find('input').attr('disabled', false); // 검색 필터 disabled
						});
						//열 움직이는 기능 잠금
						prodQualityTable.colReorder.enable();
						WM_action_OFF('ADM');
						prodQualityTable.rows('.selected').deselect();
						
						prodQualityTable.ajax.reload(function(){
							$('#btnEdit').trigger('click');
						}, false);
						$('#btnSearch').attr('disabled',false);
						$('#btnSave').attr('disabled',true);
						$('#btnEdit').attr('disabled',false);
						$('#btnCancel').attr('disabled',true);
						$('#btnConfirmY').attr('disabled',false);
						$('#btnAllCheck').prop("checked",false);
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

	function showModal() {
		return new Promise(function(resolve, reject) {
			$('#judgmentWarningModal').modal('show');
		   
		    $('#btnJudgmentWarningModalY').on('click', function() {
		    	$('#judgmentWarningModal').modal('hide');
		    	resolve(); 
		    });
		    
		    $('#btnJudgmentWarningModalN').on('click', function() {
		    	$('#judgmentWarningModal').modal('hide');
		    	reject(); 
		    });
		});
	}
	
</script>

</body>
</html>
