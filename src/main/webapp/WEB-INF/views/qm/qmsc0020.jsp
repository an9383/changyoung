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
																		  grid-template-columns: 5.5fr 4px 4fr;">
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
					<input type="text" class="form-control w-auto h-100 me-1" id="searchAll" placeholder="통합검색" >
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end">
					<div class="btn-group" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnSearch"><i class="fa-regular fa-clipboard"></i></button>
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
						<option value="Y">출력</option>
						<option value="N" selected>미출력</option>
					</select>
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100" style="min-height:30px;">번들링여부</label>
					<select class="form-select w-auto h-100 me-3" id="bundleCount" style="min-width: 70px;">
						<option value="" selected>전체</option>
						<option value="Y">O</option>
						<option value="N">X</option>
					</select>
					
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
					
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end">
					<div class="btn-group" role="group" aria-label="Small button group">
					</div>
				</div>
			</div>
			<div class="row">
				<table class="table table-bordered p-0 m-0" id="qualityEndItemTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle text-nowrap"><input class="form-check-input" type="checkbox" id="allCheckBox" style="margin: 0px; width: 20px; height: 20px;"></th>
							<th class="text-center align-middle text-nowrap">수주번호</th>
							<th class="text-center align-middle text-nowrap">고객사</th>
							<th class="text-center align-middle text-nowrap" style="max-width:200px;min-width:200px;">제품명</th>
							<th class="text-center align-middle text-nowrap">수주상태</th>
							<th class="text-center align-middle text-nowrap">진행상태</th>
							<th class="text-center align-middle text-nowrap">검사결과</th>
							<th class="text-center align-middle text-nowrap">수주수량</th>
							<th class="text-center align-middle text-nowrap">출고수량</th>
							<th class="text-center align-middle text-nowrap">출고요청일</th>
							<th class="text-center align-middle text-nowrap">출고일</th>
							<th class="text-center align-middle text-nowrap">시험자</th>
							<th class="text-center align-middle text-nowrap">판정자</th>
							<th class="text-center align-middle text-nowrap">출력여부</th>
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
					<select class="form-select w-auto h-100 me-3" id="qualityReportSelect">
					</select>
					<div class="btn-group" role="group" aria-label="Small button group">
						<%-- <button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;"
								id="btnGmail" onclick="window.open('about:blank').location.href='https://mail.google.com/mail/u/0/?tab=rm#inbox?compose=new'">
							<img class="w-auto" src="<c:url value='/resources/assets/images/gmail_icon.jpg?ver=1'/>" style="height: 14px; margin-bottom: 3px;">
						</button> --%>
						<!-- <button type="button" class="btn  btn-outline-light w-auto" style="font-size: 18px !important;" id="btnDownload"><i class="fa-solid fa-download"></i></button> -->
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnPrint"><i class="fa-solid fa-print"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnClose">
							<i class="fa-solid fa-caret-right"></i>
						</button>
					</div>
				</div>
			</div>
			<div class="row">
				<div style="width: 100%;">
				  	<div class="nav nav-tabs" id="nav-tab">
						<button class="nav-link active" id="tab1Nav" data-bs-toggle="tab" data-bs-target="#tab1">자재시험성적서</button>
				  	</div>
					<div class="tab-content" id="nav-tabContent">
						<div class="tab-pane fade show active" id="tab1">
							<div class="row" style="padding: 5px;">
								<table id="qualityReportTable" class="table table-bordered m-0 d-none" style="border:1px solid #ffffff;">
									<colgroup id="trAppendTarget">
										<col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%">
										<col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%">
										<col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%">
										<col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%">
										<col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%">
									</colgroup>
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
			let leftcolMinWidth = 100; // leftcol 최소사이즈
			$('#leftHeader').children().each(function(index, item) {
				leftcolMinWidth += $(item).width();
			});
			let rightcolMinWidth = 800; // rightcol 최소사이즈
	
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
			$('#page').css('grid-template-columns', '7fr 4px 4fr');
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
			$('#page').css('grid-template-columns', '7fr 4px 4fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcol').removeClass('d-none');
		} else {
			$('#page').css('grid-template-columns', '7fr 4px 0fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcol').addClass('d-none');
		}
		dataTableDrawAll(); // dataTable 전체 reload
	});
</script>

<!-- 인쇄용지설정 -->
<style type="text/css" media="print" id="printPaperTypeStyle">
@media print {
   @page { size: A3 landscape; margin: 3mm; }, /*landscape 가로  portrait 세로 */
   html, body { width: 297mm;height: 420mm; }
}
</style>

<script>
	WM_init('new');
	WM_init('edit');

	let monthAdjustList = getCommonCode('시스템', '026'); //날짜조정
	monthAdjustList = _.sortBy(monthAdjustList, v=>parseInt(v.commonCd));
	selectBoxAppend(monthAdjustList, 'monthAdjust', '', '2'); //날짜조정
	
	let dealGubunList = getCommonCode('시스템', '011'); //거래구분
	let dealCorpStatusList = getCommonCode('시스템', '015'); //거래상태
	let pageLengthCnt = parseInt(getCommonCode('시스템', '025')[0].commonCd); //페이징수량
	let itemGubunList = getCommonCode('일반', '001'); // 제품구분
	let useYnCdList = getCommonCode('시스템', '055'); // 사용여부
	
	selectBoxAppend(dealGubunList, 'modalDealGubun', '', '1'); //거래구분
	selectBoxAppend(dealCorpStatusList, 'modalDealCorpStatus', '', '1'); //거래상태
	selectBoxAppend(itemGubunList, 'modalItemGubunBox', '', '1'); //제품구분
	selectBoxAppend(useYnCdList, 'modalUseYnCdBox', 'Y', '1'); //사용여부

	let qualityReportList = getCommonCode('시스템', '028'); //성적서 종류
	qualityReportList = _.orderBy(qualityReportList, ['commonCd'], ['asc']);
	selectBoxAppend(qualityReportList,'qualityReportSelect', '', 2);
	
	//시험성적서 내용 가져오기
	let testContents = getCommonCode('시스템', '060'); //시험성적서 내용
	const targetCommonCds = ['시험자', '판정자'];
	const testContentsList = {};

	targetCommonCds.forEach((targetCd) => {
		const foundSentence = testContents.find((sentence) => sentence.commonCd === targetCd);
		if (foundSentence) {
			testContentsList[targetCd] = foundSentence.commonNm;
		}
	});
	//시험성적서 내용 가져오기 끝
	
	//select 요소중 인덱스가 1인(2번째 항목) 선택
	//$('#qualityReportSelect').prop('selectedIndex',1);
	$('#qualityReportSelect').val('01');
	let selectPeriod = parseInt(getCommonCode('시스템', '040')[0].commonCd); //기본조회기간 일
	$('#startDate').val(moment().subtract('d',selectPeriod).format('YYYY-MM-DD'));
	$('#endDate').val(moment().format('YYYY-MM-DD'));
	

	// 사용자정보 목록조회
	$('#qualityEndItemTable thead tr').clone(true).addClass('filters').appendTo('#qualityEndItemTable thead'); // filter 생성
	let qualityEndItemTable = $('#qualityEndItemTable').DataTable({
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
		pageLength: -1,
		colReorder: false,
		select: {
            style: 'single',
            toggleable: false,
            items: 'row',
            info: false
        },
        ajax : {
			url : '<c:url value="/qm/prodQualityPassLst"/>',
			type : 'POST',
			data : {
				startDate : function() { return moment($('#startDate').val()).format('YYYYMMDD'); },
				endDate : function() { return moment($('#endDate').val()).format('YYYYMMDD'); },
				searchTarget : function() { return $('#searchTarget').val(); },
				bundleCount : function() { return $('#bundleCount').val(); }, //번들링여부
				itemIdx	: function(){ return $('#itemIdx').val(); },
				dealCorpidx	: function(){ return $('#searchDealCorpIdx').val();} , 
			},
		},
        rowId: 'idx',
		columns : [
			{ //체크박스
				className : 'text-center align-middle text-nowrap',
				render : function(data, type, row, meta) {
					return '<div style="white-space:nowrap;"><input class="form-check-input" type="checkbox" name="checkBox" style="margin: 0px; width: 20px; height: 20px;"></div>';
				}
			},
			{ //수주번호
				data: 'bizOrdDtlNo', className : 'text-center align-middle text-nowrap',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return '<div style="white-space:nowrap;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ //고객사
				data: 'bizOrdDealCorpNm', className : 'text-center align-middle text-nowrap',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return '<div style="white-space:nowrap;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ //제품명
				data: 'itemNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						//return '<div style="white-space:nowrap;">'+data+'</div>';
						return data;
					} else {
						return '-';
					}
				}
			},
			{ //수주상태
				data: 'bizStatusCdNm', className : 'text-center align-middle text-nowrap',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return '<div style="white-space:nowrap;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ //진행상태
				data: 'workMethodJson', className : 'text-center align-middle text-nowrap',
				render : function(data, type, row, meta) {
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
			},
			{ //검사결과
				data: 'qualityJudgmentNm', className : 'text-center align-middle text-nowrap',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return '<div style="white-space:nowrap;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ //수주수량
				data: 'bizOrdQty', className : 'text-end align-middle text-nowrap',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return '<div style="white-space:nowrap;">'+addCommas(parseFloat(data))+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ //출고수량
				data: 'outQty', className : 'text-end align-middle text-nowrap',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return '<div style="white-space:nowrap;">'+addCommas(parseFloat(data))+'</div>';
					} else {
						return '0';
					}
				}
			},
			{ //출고요청일
				data: 'bizOutReqDate', className : 'text-center align-middle text-nowrap',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return '<div style="white-space:nowrap;">'+moment(data).format('YYYY-MM-DD')+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ //출고일
				data: 'outDate', className : 'text-center align-middle text-nowrap',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return '<div style="white-space:nowrap;">'+moment(data).format('YYYY-MM-DD')+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ //시험자
				data: 'judUserName', className : 'text-center align-middle text-nowrap',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return '<div style="white-space:nowrap;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ //판정자
				data: 'conUserName', className : 'text-center align-middle text-nowrap',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return '<div style="white-space:nowrap;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ //출력여부
				data: 'printYn', className : 'text-center align-middle text-nowrap',
				render : function(data, type, row, meta) {
					if( data == 'Y' ) {
						return '<i class="fa-solid fa-check mt-1 text-success"></i>';
					} else {
						return '<i class="fa-solid fa-x mt-1 text-danger"></i>';
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
		order : [],
		drawCallback: function() {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let headerHeight = parseFloat($('#leftHeader').css('height')) + parseFloat($('#leftSecondHeader').css('height'));
			let theadHeight = parseFloat($('#qualityEndItemTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - headerHeight - 43)+'px');
			
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
				let cell = $('#qualityEndItemTable_wrapper').find('.filters th').eq(
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
				$('#qualityEndItemTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	qualityEndItemTable.on('column-reorder', function( e, settings, details ) {
		let api = qualityEndItemTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#qualityEndItemTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	// 모든 체크박스 체크/해제 되도록
	$(document).on('change','input:checkbox[name=checkBox]', function(){
		if( $('input:checkbox[name=checkBox]').length == $('input:checkbox[name=checkBox]:checked').length ){ //전체 체크박스 수와 체크된 박스의 수가 같을 때 -> 전체체크박스 체크 , 아닐 경우 해제
			$('#allCheckBox').prop('checked',true);
		} else{
			$('#allCheckBox').prop('checked',false);
		}
 	});

	//모든 체크박스 선택
	$('#allCheckBox').on('click',function(){
		if($('#allCheckBox').prop("checked")){
			$('input:checkbox[name=checkBox]').prop('checked',true);
		}else{
			$('input:checkbox[name=checkBox]').prop('checked',false);
		}
		$('#my-spinner').show();
		paperCreate();
	});
	
	/* $('#qualityEndItemTable tbody').on('click','tr', function() {
		let data = qualityEndItemTable.row(this).data();
		
		$('#purchaseCustomerNm').text(data.bizOrdDealCorpNm);//고객사
		$('#testItemNm').text(data.itemNm);//제품명
		$('#workDate').val(moment(data.workDate).format('YYYY-MM-DD'));//제조일자
		$('#bizOrdDtlNo').text(data.bizOrdDtlNo);//제조번호
		$('#testJudgmentDate').val(moment(data.judgmentDate).format('YYYY-MM-DD'));//검사일자
		let customerItemCd = isEmptyCheck(data.customerItemCd) ? '' : data.customerItemCd;
		$('#itemVersion').text(customerItemCd + ' / ' + data.itemVersion);//도안번호
		$('#paperType').text(data.paperType);//재질명
		$('#quailtyPassQty').val(addCommas(parseFloat(data.outQty)));//입고수량
		$('#eaQty').text(addCommas(parseFloat(data.eaQty)));//원판수량
		let bundleMethodNm = isEmptyCheck(data.bundleMethodNm) ? '' : data.bundleMethodNm;
		$('#inPackMethod').text(data.bundleUnit + ' / ' + bundleMethodNm);//포장방법 내부
		$('#outPackMethod').text(data.packMethodNm);//포장방법 외부
		$('#coatingMethod').text(data.coatingMethod);//코팅
		$('#itemColor').text(data.itemColor);//색상
		$('#moldingMethod').text(data.moldingMethod);//성형방식


		$('#testPaperType').text(data.paperType);//재질명
		//$('#testSizeXY').text(data.sizeX +'*'+data.sizeY);//규격
		$('#testSizeXY').text(data.itemSize); //규격
		$('#testItemVersion').text(data.itemVersion);//도안번호
		$('#testItemColor').text(data.itemColor);//색상
		$('#testCoatingMethod').text(data.coatingMethod);//코팅

		$('#judUserName').val(testContentsList['시험자']);//시험자
		$('#judgmentDate').val(moment(data.judgmentDate).format('YYYY.MM.DD)'));//시험일자
		$('#conUserName').val(testContentsList['판정자']);//판정자
		$('#confirmDate').val(moment(data.confirmDate).format('YYYY.MM.DD)'));//판정일자
		$('#qualityJudgmentNm').val(data.qualityJudgmentNm);//판정결과
	}); */
	
	// 성적서출력 체크
	$(document).on('change','input[name=checkBox]', function() {
		$('#my-spinner').show();
		paperCreate();
	});

	$('#qualityReportSelect').on('change',function(){
		$('#my-spinner').show();
		paperCreate();
	});
	
	// 조회 버튼 click
	$('#btnSearch').on('click', function() {
		$('#my-spinner').show();
		qualityEndItemTable.row('.selected').deselect();
		qualityEndItemTable.ajax.reload(function() {});
		$('#checkAll').prop("checked",false);
		$('#btnSave').attr('disabled',true);
		$('#btnEdit').attr('disabled',false);
		$('#btnCancel').attr('disabled',true);
		
		$('.dtlList').find('td').html('&nbsp;');
		setTimeout(function() {
			$('#my-spinner').hide();
		}, 100)
	});

	// 발주서 인쇄 버튼 click
	$('#btnPrint').on('click',function() {
		//해당 스타일시트날리고
	    $('#printPaperTypeStyle').remove();
	    //스타일시트 생성
	    $('<style>')
	    	.prop('type', 'text/css').prop('id','printPaperTypeStyle').prop('media','print')
	    	.html('@media print { @page { size: A4 portrait; margin: 3mm; }, html, body { width: 210mm; height: 297mm; } }')
	    	.appendTo('body');
	    
		$('#my-spinner').show();
		cssChange(); // css반영

		setTimeout(function(){
			let updIdx = '';
			//updIdx += qualityEndItemTable.row('.selected').data().idx +', ';
			let checkObj = $('input[name=checkBox]:checked');
			checkObj.each(function(index,item){
				let tr = $(item).parent().parent().parent();
				let data = qualityEndItemTable.row(tr).data();
				updIdx += data.bizOrdDtlIdx +',';
			});
			updIdx = updIdx.slice(0,-1);

			$.ajax({
				url: '<c:url value="/qm/prodQualityPaperUpd"/>',
	            type: 'POST',
	            async: false,
	            data: {    
		            'idx'				:	function(){return updIdx;},
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					qualityEndItemTable.ajax.reload(function(){
						$('#allCheckBox').prop('checked',false);
						$('#my-spinner').show();
						paperCreate();
					}, false);
				}
			});
			
			$('#qualityReportTable').print({
				globalStyles: true,
				mediaPrint: true
			});
			
			setTimeout(function() {
				$('#my-spinner').hide();
			}, 200);
		}, 10);		
	});

	// 초기 셋팅
	$(document).ready(function() {
		$('#trAppendTarget').after(makeEmptyTr($('#qualityReportSelect').val()));
		cssChange();
		$('#my-spinner').hide();
		$('#qualityReportTable').removeClass('d-none');
		

		$('input').attr('autocomplete','one-time-code');
	});

	function cssChange() {
		//$('#qualityReportTable').find('td').css('font-weight', '900');
		$('#qualityReportTable').find('td').css('border', '1px solid black');
		$('#qualityReportTable').find('td').css('padding', '0.1rem');
		$('#qualityReportTable').find('td').css('color', '#000000');

		$('#qualityReportTable').find('.fw200').css('font-weight', '200');
		$('#qualityReportTable').find('.fw900').css('font-weight', '900');
		$('#qualityReportTable').find('.bd2px').css('border', '2px solid black');
		
		$('#qualityReportTable').find('.bg-gray').css('background-color', '#C9C9C9');
		
		$('#qualityReportTable').find('.theadFirstCol').css('border-top', '0px');
		//$('#qualityReportTable').find('.theadFirstCol').css('border-left', '2px');
		$('#qualityReportTable').find('.theadNotFisrtCol').css('border-top', '0px');
		$('#qualityReportTable').find('.theadNotFisrtCol').css('border-left', '0px');
		
		$('#qualityReportTable').find('.tbodyFirstCol').css('border-top', '0px');
		//$('#qualityReportTable').find('.tbodyFirstCol').css('border-left', '2px');
		$('#qualityReportTable').find('.tbodyNotFirstCol').css('border-top', '0px');
		$('#qualityReportTable').find('.tbodyNotFirstCol').css('border-left', '0px');

		//$('#qualityReportTable').find('.bd-doblue').css('border', '5px double');
		
		$('#qualityReportTable').find('.fs-8').css('font-size', '8px');
		$('#qualityReportTable').find('.fs-10').css('font-size', '10px');
		$('#qualityReportTable').find('.fs-11').css('font-size', '11px');
		$('#qualityReportTable').find('.fs-12').css('font-size', '12px');
		$('#qualityReportTable').find('.fs-13').css('font-size', '13px');
		$('#qualityReportTable').find('.fs-15').css('font-size', '15px');
		$('#qualityReportTable').find('.fs-20').css('font-size', '20px');
		$('#qualityReportTable').find('.fs-25').css('font-size', '25px');
		$('#qualityReportTable').find('.fs-30').css('font-size', '30px');
		$('#qualityReportTable').find('.fs-50').css('font-size', '50px');
		$('#qualityReportTable').find('.fc-red').css('color', '#ff0000');
		$('#qualityReportTable').find('.bt-2').css('border-top', '2px solid black');
		$('#qualityReportTable').find('.bd-n').css('border', '0px solid #ffffff');
		$('#qualityReportTable').find('.bt-n').css('border-top', '0px solid #ffffff');
		$('#qualityReportTable').find('.br-n').css('border-right', '0px solid #ffffff');
		$('#qualityReportTable').find('.bb-n').css('border-bottom', '0px solid #ffffff');
		$('#qualityReportTable').find('.bl-n').css('border-left', '0px solid #ffffff');
		$('#qualityReportTable').find('.h-5').css('height', '5px');
		$('#qualityReportTable').find('.h-10').css('height', '10px');
		$('#qualityReportTable').find('.h-15').css('height', '15px');
		$('#qualityReportTable').find('.h-20').css('height', '20px');
		$('#qualityReportTable').find('.h-25').css('height', '25px');
		$('#qualityReportTable').find('.h-30').css('height', '30px');
		$('#qualityReportTable').find('.h-40').css('height', '40px');
		$('#qualityReportTable').find('.h-55').css('height', '55px');
		$('#qualityReportTable').find('.h-70').css('height', '70px');
		$('#qualityReportTable').find('.h-75').css('height', '75px');
		$('#qualityReportTable').find('.h-100').css('height', '100px');
		$('#qualityReportTable').find('.maxh-5').css('max-height', '5px');
		$('#qualityReportTable').find('.maxh-10').css('max-height', '10px');
		$('#qualityReportTable').find('.maxh-20').css('max-height', '20px');
		$('#qualityReportTable').find('.maxh-25').css('max-height', '25px');
		$('#qualityReportTable').find('.maxh-30').css('max-height', '30px');
		$('#qualityReportTable').find('.maxh-40').css('max-height', '40px');
		$('#qualityReportTable').find('.maxh-55').css('max-height', '55px');
		$('#qualityReportTable').find('.maxh-70').css('max-height', '70px');
		$('#qualityReportTable').find('.maxh-75').css('max-height', '75px');
		$('#qualityReportTable').find('.maxh-100').css('max-height', '100px');
		

		// 인쇄할 때 css 적용하려면 important 붙여줘야함.
		for(var i=0;i<$('#qualityReportTable').find('td').length;i++) {
			let tdStyle = $('#qualityReportTable').find('td').eq(i).attr('style') == undefined?'':$('#qualityReportTable').find('td').eq(i).attr('style');
			$('#qualityReportTable').find('td').eq(i).attr('style',tdStyle.replaceAll(';',' !important;'));
		}
	}


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
// 			$('#searchAll').off('keyup',function() {});
// 			$('#searchAll').on('keyup',function() {
// 				$('#'+table_id+'_filter').find('input').val($(this).val());
// 				$('#'+table_id+'_filter').find('input').trigger('keyup');
// 			});
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

		
	function makeEmptyTr(paperType){
		let html = '';
		if(paperType == '00'){
			//번들링 성적서
			html += '	<tr style="page-break-before: always!important;">';
			html += '		<td class="bd-n h-25" colspan="30">';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n max-h75 h-75"></td>';
			html += '		<td colspan="13" class="text-center max-h75 h-75 bd2px align-middle bt-n bl-n br-n">';
			html += '			<img src="/resources/assets/images/header_logo.png" style="width:70%;height:100%;">';
			html += '		</td>';
			html += '		<td colspan="11" class="bt-n bl-n br-n max-h70 bd2px fs-12" style="height:100%!important;">';
			html += '			㈜ 창영테크팩<br>';
			html += '			주소 : 경기도 수원시 권선구 산업로 156번길 88-39<br>';
			html += '			Tel : 031-292-6553<br>';
			html += '			Fax : 031-292-6507';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n max-h75 h-75"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td class="bd-n h-25" colspan="30">';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="8" class="bd-n"></td>';
			html += '		<td colspan="14" class="fs-30 fw900 bd2px text-center bt-n bl-n br-n">자&nbsp;&nbsp;재&nbsp;&nbsp;시&nbsp;&nbsp;험&nbsp;&nbsp;성&nbsp;&nbsp;적&nbsp;&nbsp;서</td>';
			html += '		<td colspan="8" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="12" class="fs-20 fw900 bd2px text-center bt-n bl-n br-n" name="purchaseCustomerNm"></td>';
			html += '		<td colspan="15" class="fs-20 fw900 bd2px bd-n">貴中</td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="30" class="bd-n h-10"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">제 품 명</td>';
			html += '		<td colspan="21" class="fs-12 text-center align-middle " name="testItemNm"></td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">제조일자</td>';
			html += '		<td colspan="11" class="bg-gray fs-12 text-center align-middle ">';
			html += '			<input name="workDate" type="text" class="bg-gray text-center p-0 fs-15" style="border:none !important;max-width:70px">';
			html += '		</td>';
			html += '		<td colspan="2" class="fs-12 text-center align-middle ">제조번호</td>';
			html += '		<td colspan="8" class="bg-gray fs-12 text-center align-middle " name="bizOrdDtlNo"></td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">검사일자</td>';
			html += '		<td colspan="11" class="bg-gray fs-12 text-center align-middle " >';
			html += '			<input name="testJudgmentDate" type="text" class="bg-gray text-center p-0 " style="border:none !important;max-width:70px;">';
			html += '		</td>';
			html += '		<td colspan="2" class="fs-12 text-center align-middle ">입고수량</td>';
			html += '		<td colspan="8" class="bg-gray fs-12 text-center align-middle " >';
			html += '			<input name="quailtyPassQty" type="text" class="bg-gray text-center p-0 " style="border:none !important;max-width:200px;min-width:200px;">';
			html += '		</td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="30" class="bd-n h-10"></td>';
			html += '	</tr>';

			html += ' <tr class="bundleInfoTr">';
			html += ' 	<td colspan="3" class="bd-n"></td>';
			html += '	<td colspan="3" class="fs-12 text-center align-middle">item</td>';
			html += '	<td colspan="11" class="fs-12 text-center align-middle">Bundling Packet 조합</td>';
			html += '	<td colspan="2" class="fs-12 text-center align-middle" nowrap>제조번호</td>';
			html += '	<td colspan="4" class="fs-12 text-center align-middle">자재코드</td>';
			html += '	<td colspan="4" class="fs-12 text-center align-middle">버전번호</td>';
			html += ' 	<td colspan="3" class="bd-n"></td>';
			html += ' </tr>';

			html += '	<tr>';
			html += '		<td colspan="30" class="bd-n h-10"></td>';
			html += '	</tr>';

			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">포장방법</td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">내부</td>';
			html += '		<td colspan="4" class="fs-12 text-center align-middle " name="bundleUnit"></td>';
			html += '		<td colspan="2" class="fs-12 text-center align-middle ">/</td>';
			html += '		<td colspan="4" class="fs-12 text-center align-middle " name="bundleMethodNm"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">외부</td>';
			html += '		<td colspan="5" class="fs-12 text-center align-middle " name="packMethodNm"></td>';
			
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			
			html += '	<tr>';
			html += '		<td colspan="30" class="bd-n h-10"></td>';
			html += '	</tr>';
			
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="fs-12 text-center align-middle ">시험항목</td>';
			html += '		<td colspan="6" class="br-n fs-12 text-center align-middle ">기준</td>';
			html += '		<td colspan="7" class="bl-n br-n fs-12 text-center align-middle ">검사내용</td>';
			html += '		<td colspan="7" class="bl-n fs-12 text-center align-middle ">시험결과</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr class="bundlePackInfoTr">';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="rowMerge fs-12 text-start align-middle ">1)Packet 조합</td>';
			html += '		<td colspan="6" class="h-20 fs-12 text-center align-middle " name="itemNmTd0"></td>';
			html += '		<td colspan="7" class="rowMerge fs-10 text-start align-middle ">Packet조합은 바르게 되었는가?</td>';
			html += '		<td colspan="7" class="rowMerge fs-10 text-start align-middle ">결과 : 적합&nbsp;,&nbsp;부적합</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="fs-12 text-start align-middle ">2)자재별 품질</td>';
			html += '		<td colspan="6" class="fs-12 text-center align-middle " name="">자재별 품질관리 결과</td>';
			html += '		<td colspan="7" class="fs-10 text-start align-middle ">자재별 성적서를 확인하였는가??</td>';
			html += '		<td colspan="7" class="fs-10 text-start align-middle ">결과 : 적합&nbsp;,&nbsp;부적합</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr class="bundlePharmacodeTr">';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="rowMerge fs-12 text-start align-middle ">3)Pharmacode</td>';
			html += '		<td colspan="6" class="h-20 fs-12 text-center align-middle " name="itemNmTd0"></td>';
			html += '		<td colspan="7" class="rowMerge fs-10 text-start align-middle ">Pharmacode가 모두 올바른가?</td>';
			html += '		<td colspan="7" class="rowMerge fs-10 text-start align-middle ">결과 : 적합&nbsp;,&nbsp;부적합,&nbsp;미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="fs-12 text-start align-middle ">4)Banding 상태</td>';
			html += '		<td colspan="6" class="fs-12 text-center align-middle " name="">Banding 상태</td>';
			html += '		<td colspan="7" class="fs-10 text-start align-middle ">테이핑이 잘되었는가?</td>';
			html += '		<td colspan="7" class="fs-10 text-start align-middle ">결과 : 적합&nbsp;,&nbsp;부적합</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			
			html += '	<tr class="bundleCntCheckTr">';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td rowspan="2" colspan="4" class="rowMerge fs-12 text-start align-middle ">5)수량 확인</td>';
			html += '		<td rowspan="2" colspan="6" class="fs-10 text-center align-middle " name="">Bundling 전후 수량 및 잔량</td>';
			html += '		<td colspan="7" class="fs-10 text-start align-middle ">전후 전체 수량이 일치하는가</td>';
			html += '		<td colspan="7" class="fs-10 text-start align-middle ">결과 : 일치&nbsp;,&nbsp;불일치</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';

			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="7" class="fs-10 text-start align-middle ">불일치시 전수검사를 실시하여<br>누락 여부를 확인하였는가?</td>';
			html += '		<td colspan="7" class="fs-10 text-start align-middle ">결과 : 적합&nbsp;,&nbsp;부적합,&nbsp;미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';

			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="fs-12 text-start align-middle ">6)라벨</td>';
			html += '		<td colspan="6" class="fs-12 text-center align-middle">내부 규정범위</td>';
			html += '		<td colspan="7" class="fs-10 text-start align-middle ">라벨 표기사항 부착 여부</td>';
			html += '		<td colspan="7" class="fs-10 text-start align-middle ">결과 : 양호&nbsp;,&nbsp;보통,&nbsp;미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="fs-12 text-start align-middle ">7)포장</td>';
			html += '		<td colspan="6" class="fs-12 text-center align-middle">내부 규정범위</td>';
			html += '		<td colspan="7" class="fs-10 text-start align-middle ">내용물이 안보이게 포장되었는가?</td>';
			html += '		<td colspan="7" class="fs-10 text-start align-middle ">결과 : 양호&nbsp;,&nbsp;보통,&nbsp;미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			
			html += '	<tr>';
			html += '		<td colspan="30" class="text-center align-middle bd-n fw200 fs-8" name="fscTd">';
			html += '		</td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="30" class="bd-n h-10"></td>';
			html += '	</tr>';
			html += '';		
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="fs-15 text-start align-middle bd-n">시&nbsp;&nbsp;험&nbsp;&nbsp;자 : </td>';
			html += '		<td colspan="8" class="fs-15 text-start align-middle bd-n" >';
			html += '			<input name="judUserName" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="7" class="fs-15 text-end align-middle bd-n">(일자 : </td>';
			html += '		<td colspan="5" class="fs-15 text-start align-middle bd-n">';
			html += '			<input name="judgmentDate" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="fs-15 text-start align-middle bd-n">판&nbsp;&nbsp;정&nbsp;&nbsp;자 : </td>';
			html += '		<td colspan="8" class="fs-15 text-start align-middle bd-n">';
			html += '			<input name="conUserName" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="7" class="fs-15 text-end align-middle bd-n">(일자 : </td>';
			html += '		<td colspan="5" class="fs-15 text-start align-middle bd-n" >';
			html += '			<input name="confirmDate" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="fs-15 text-start align-middle bd-n">판정&nbsp;결과 : </td>';
			html += '		<td colspan="20" class="fs-15 text-start align-middle bd-n" >';
			html += '			<input name="qualityJudgmentNm" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="24" class="fs-15 text-start align-middle bd-n">';
			html += '			<input value="문서&nbsp;번호 : &nbsp;&nbsp;&nbsp;시험성적서 7-220713-03" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
		} else if(paperType == '01'){
			//시험성적서
			html += '	<tr style="page-break-before: always!important;">';
			html += '		<td class="bd-n h-25" colspan="30">';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n max-h75 h-75"></td>';
			html += '		<td colspan="13" class="text-center max-h75 h-75 bd2px align-middle bt-n bl-n br-n">';
			html += '			<img src="/resources/assets/images/header_logo.png" style="width:70%;height:100%;">';
			html += '		</td>';
			html += '		<td colspan="11" class="bt-n bl-n br-n max-h70 bd2px fs-12" style="height:100%!important;">';
			html += '			㈜ 창영테크팩<br>';
			html += '			주소 : 경기도 수원시 권선구 산업로 156번길 88-39<br>';
			html += '			Tel : 031-292-6553<br>';
			html += '			Fax : 031-292-6507';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n max-h75 h-75"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td class="bd-n h-15" colspan="30">';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="8" class="bd-n"></td>';
			html += '		<td colspan="14" class="fs-30 fw900 bd2px text-center bt-n bl-n br-n">자&nbsp;&nbsp;재&nbsp;&nbsp;시&nbsp;&nbsp;험&nbsp;&nbsp;성&nbsp;&nbsp;적&nbsp;&nbsp;서</td>';
			html += '		<td colspan="8" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="12" class="fs-20 fw900 bd2px text-center bt-n bl-n br-n" name="purchaseCustomerNm"></td>';
			html += '		<td colspan="15" class="fs-20 fw900 bd2px bd-n">貴中</td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="30" class="bd-n h-10"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">제 품 명</td>';
			html += '		<td colspan="21" class="fs-12 text-center align-middle " name="testItemNm"></td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">제조일자</td>';
			html += '		<td colspan="6" class="bg-gray fs-12 text-center align-middle ">';
			html += '			<input name="workDate" type="text" class="bg-gray text-center p-0 fs-15" style="border:none !important;max-width:70px">';
			html += '		</td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">제조번호</td>';
			html += '		<td colspan="12" class="bg-gray fs-12 text-center align-middle " name="bizOrdDtlNo"></td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">검사일자</td>';
			html += '		<td colspan="6" class="bg-gray fs-12 text-center align-middle " >';
			html += '			<input name="testJudgmentDate" type="text" class="bg-gray text-center p-0 " style="border:none !important;max-width:70px;">';
			html += '		</td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">도안번호</td>';
			html += '		<td colspan="12" class="fs-12 text-center align-middle " name="itemVersion"></td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">재질명</td>';
			html += '		<td colspan="6" class="fs-12 text-center align-middle " name="paperType"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">입고수량</td>';
			html += '		<td colspan="12" class="bg-gray fs-12 text-center align-middle " >';
			html += '			<input name="quailtyPassQty" type="text" class="bg-gray text-center p-0 " style="border:none !important;max-width:200px;min-width:200px;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">원판 수량</td>';
			html += '		<td colspan="6" class="fs-12 text-center align-middle " name="eaQty"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">포장방법</td>';
			html += '		<td colspan="2" class="fs-12 text-center align-middle ">내부</td>';
			html += '		<td colspan="4" class="fs-12 text-center align-middle " name="inPackMethod"></td>';
			html += '		<td colspan="2" class="fs-12 text-center align-middle ">외부</td>';
			html += '		<td colspan="4" class="fs-12 text-center align-middle " name="outPackMethod"></td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">코팅</td>';
			html += '		<td colspan="6" class="fs-12 text-center align-middle " name="coatingMethod"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">색 상</td>';
			html += '		<td colspan="12" class="fs-12 text-center align-middle " name="itemColor"></td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">성형방식</td>';
			html += '		<td colspan="6" class="fs-12 text-center align-middle " name="moldingMethod"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">보관조건</td>';
			html += '		<td colspan="12" class="fs-12 text-center align-middle ">온도 : 실온( 1 ~ 30℃ )</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="30" class="bd-n h-10"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">시험항목</td>';
			html += '		<td colspan="7" class="br-n fs-12 text-center align-middle ">기준</td>';
			html += '		<td colspan="9" class="bl-n br-n fs-12 text-center align-middle ">검사내용</td>';
			html += '		<td colspan="5" class="bl-n fs-12 text-center align-middle ">시험결과</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle ">1)재질</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle " name="testPaperType"></td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">기준과 실제 생산용</td>';
			html += '		<td colspan="1" class="fs-10 text-start align-middle br-n">재질 :</td>';
			html += '		<td colspan="3" class="fs-10 text-start align-middle bl-n br-n" style="width: 100%;">';
			html += '			<input type="text" class="text-end p-0" style="width: 100%; border: none; font-size: 10px !important; box-sizing: border-box;">';
			html += '		</td>';
			html += '		<td colspan="1" class="fs-10 text-start align-middle bl-n">㎡</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" rowspan="2" class="fs-12 text-start align-middle ">2)규격</td>';
			html += '		<td colspan="7" rowspan="2" class="fs-12 text-center align-middle " name="testSizeXY"></td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">정확한 자로 규격을 측정한다<sub style="font-size:6px!important;transform: translate(-8%, -50%) scale(0.8);display: inline-block;">(오차범위±0.5mm)</sub></td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle" style="width: 100%;">';
			html += '			<div style="display: flex; width: 100%;">';
			html += '		    	<input type="text" class="text-end p-0" style="width: 34%; border: none; font-size: 10px !important; box-sizing: border-box;">(L)*';
			html += '		    	<input type="text" class="text-end p-0" style="width: 33%; border: none; font-size: 10px !important; box-sizing: border-box;">(W)*';
			html += '		    	<input type="text" class="text-end p-0" style="width: 33%; border: none; font-size: 10px !important; box-sizing: border-box;">(H)';
			html += '		  	</div>';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">재단면 또는 톰슨은 완벽한가</td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle text-nowrap">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>'; //가로 길이 유지를 위한 공백 부여
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle ">3)도안번호</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle " name="testItemVersion"></td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">도안번호 확인</td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 정확, 부정확, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle ">4)색 상</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle " name="testItemColor"></td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">지정 색도와 일치하는가를 확인</td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle ">5)표시사항</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">기준 견본</td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">문자, 글꼴등 견본과 일치하는가?</td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" rowspan="3" class="fs-12 text-start align-middle ">6)인쇄 상태</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">문안 부위</td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">1㎟ 미만의 점이 3개이내인가?</td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">문안 외 부위</td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">1㎟ 미만의 점이 5개이내인가?</td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">인쇄 전체</td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">이중인쇄 인쇄번짐이 없는가?</td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="bg-gray fs-12 text-start align-middle ">7)바코드</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">기준 견본</td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">정확하게 읽혀야 한다.</td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 정확, 부정확, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" rowspan="2" class="bg-gray fs-12 text-start align-middle ">8)코팅</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle " name="testCoatingMethod"></td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">코팅상태가 깨끗하여야한다.</td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">라미네이팅시 표면 접착강도</td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">테이프시험시 인쇄가 떨어지지 않는다.</td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="bg-gray fs-12 text-start align-middle ">9)접착면</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">내부 규정 범위</td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">접착 품질 확인</td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle ">10)외관</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">내부 규정 범위</td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">손상, 파손등의 확인</td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle ">11)라벨</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">내부 규정 범위</td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">라벨 표기사항 부착 여부</td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle ">12)포장</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">내부 규정 범위</td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">Tapping 상태</td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="30" class="bd-n h-10"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="5" class="fs-15 text-start align-middle  br-n">특기사항 기록란</td>';
			html += '		<td colspan="19" class="fs-15 text-start align-middle  bl-n bb-n">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="24" class="text-start align-middle  bb-n bt-n">';
			html += '			<input type="text" class="text-start p-0 fs-15" style="border:none !important;max-width:600px;min-width:600px;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="5" class="fs-15 text-start align-middle  bt-n br-n">유효일자</td>';
			html += '		<td colspan="19" class="fs-15 text-start align-middle  bt-n bl-n bb-n"></td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="24" class="text-start align-middle  bb-n bt-n">';
			html += '			<input type="text" class="text-start p-0 fs-15" style="border:none !important;max-width:600px;min-width:600px;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="24" class="text-center align-middle bt-n fw200 fs-8" name="fscTd">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '';		
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="fs-15 text-start align-middle bd-n">시험자 : </td>';
			html += '		<td colspan="8" class="fs-15 text-start align-middle bd-n" >';
			html += '			<input name="judUserName" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="7" class="fs-15 text-end align-middle bd-n">(일자 : </td>';
			html += '		<td colspan="5" class="fs-15 text-start align-middle bd-n">';
			html += '			<input name="judgmentDate" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="fs-15 text-start align-middle bd-n">판정자 : </td>';
			html += '		<td colspan="8" class="fs-15 text-start align-middle bd-n">';
			html += '			<input name="conUserName" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="7" class="fs-15 text-end align-middle bd-n">(일자 : </td>';
			html += '		<td colspan="5" class="fs-15 text-start align-middle bd-n" >';
			html += '			<input name="confirmDate" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="fs-15 text-start align-middle bd-n">판정결과 : </td>';
			html += '		<td colspan="20" class="fs-15 text-start align-middle bd-n" >';
			html += '			<input name="qualityJudgmentNm" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="14" class="fs-15 text-start align-middle bd-n"></td>';
			html += '		<td colspan="10" class="fs-15 text-start align-middle bd-n">㈜ 창영테크팩    최 재 성';
			html += '			<img src="/resources/assets/images/ceo_sign.png" style="width:35%;height:100%;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="24" class="fs-15 text-start align-middle bd-n">';
			html += '			<input value="문서번호 : 시험성적서 1-190910-03" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
		} else if(paperType == '02'){
			//셀트리온 시험성적서
			html += '	<tr style="page-break-before: always!important;">';
			html += '		<td class="bd-n h-25" colspan="30">';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n max-h75 h-75"></td>';
			html += '		<td colspan="13" class="text-center max-h75 h-75 bd2px align-middle bt-n bl-n br-n">';
			html += '			<img src="/resources/assets/images/header_logo.png" style="width:70%;height:100%;">';
			html += '		</td>';
			html += '		<td colspan="11" class="bt-n bl-n br-n max-h70 bd2px fs-12" style="height:100%!important;">';
			html += '			㈜ 창영테크팩<br>';
			html += '			주소 : 경기도 수원시 권선구 산업로 156번길 88-39<br>';
			html += '			Tel : 031-292-6553<br>';
			html += '			Fax : 031-292-6507';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n max-h75 h-75"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td class="bd-n h-20" colspan="30">';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="8" class="bd-n"></td>';
			html += '		<td colspan="14" class="fs-30 fw900 bd2px text-center bt-n bl-n br-n">자&nbsp;&nbsp;재&nbsp;&nbsp;시&nbsp;&nbsp;험&nbsp;&nbsp;성&nbsp;&nbsp;적&nbsp;&nbsp;서</td>';
			html += '		<td colspan="8" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="12" class="fs-20 fw900 bd2px text-center bt-n bl-n br-n" name="purchaseCustomerNm"></td>';
			html += '		<td colspan="15" class="fs-20 fw900 bd2px bd-n">貴中</td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="30" class="bd-n h-10"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">제 품 명</td>';
			html += '		<td colspan="21" class="fs-12 text-center align-middle " name="testItemNm"></td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">제조일자</td>';
			html += '		<td colspan="6" class="bg-gray fs-12 text-center align-middle ">';
			html += '			<input name="workDate" type="text" class="bg-gray text-center p-0 fs-15" style="border:none !important;max-width:70px">';
			html += '		</td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">제조번호</td>';
			html += '		<td colspan="12" class="bg-gray fs-12 text-center align-middle " name="bizOrdDtlNo"></td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">검사일자</td>';
			html += '		<td colspan="6" class="bg-gray fs-12 text-center align-middle " >';
			html += '			<input name="testJudgmentDate" type="text" class="bg-gray text-center p-0 " style="border:none !important;max-width:70px;">';
			html += '		</td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">도안번호</td>';
			html += '		<td colspan="12" class="fs-12 text-center align-middle " name="itemVersion"></td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">재질명</td>';
			html += '		<td colspan="6" class="fs-12 text-center align-middle " name="paperType"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">입고수량</td>';
			html += '		<td colspan="12" class="bg-gray fs-12 text-center align-middle " >';
			html += '			<input name="quailtyPassQty" type="text" class="bg-gray text-center p-0 " style="border:none !important;max-width:200px;min-width:200px;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">원판 수량</td>';
			html += '		<td colspan="6" class="fs-12 text-center align-middle " name="eaQty"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">포장방법</td>';
			html += '		<td colspan="2" class="fs-12 text-center align-middle ">내부</td>';
			html += '		<td colspan="4" class="fs-12 text-center align-middle " name="inPackMethod"></td>';
			html += '		<td colspan="2" class="fs-12 text-center align-middle ">외부</td>';
			html += '		<td colspan="4" class="fs-12 text-center align-middle " name="outPackMethod"></td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">코팅</td>';
			html += '		<td colspan="6" class="fs-12 text-center align-middle " name="coatingMethod"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">색 상</td>';
			html += '		<td colspan="12" class="fs-12 text-center align-middle bg-gray" name="itemColor"></td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">성형방식</td>';
			html += '		<td colspan="6" class="fs-12 text-center align-middle " name="moldingMethod"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">판정 결과</td>';
			html += '		<td colspan="12" class="fs-12 text-center align-middle">';
			html += '			<input name="qualityResult" type="text" class="text-start p-0 " style="border:none !important;width:100%;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="30" class="bd-n h-20"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">시험항목</td>';
			html += '		<td colspan="7" class="br-n fs-12 text-center align-middle ">기준</td>';
			html += '		<td colspan="9" class="bl-n br-n fs-12 text-center align-middle ">검사내용</td>';
			html += '		<td colspan="5" class="bl-n fs-12 text-center align-middle ">시험결과</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle ">1)재질</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle " name="testPaperType"></td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">기준과 실제 생산용</td>';
			html += '		<td colspan="1" class="fs-12 text-start align-middle br-n">재질 :</td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle bl-n br-n" style="width: 100%;">';
			html += '			<input type="text" class="text-end p-0" style="width: 100%; border: none; font-size: 12px !important; box-sizing: border-box;">';
			html += '		</td>';
			html += '		<td colspan="1" class="fs-12 text-start align-middle bl-n">㎡</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" rowspan="2" class="fs-12 text-start align-middle ">2)규격</td>';
			html += '		<td colspan="7" rowspan="2" class="fs-12 text-center align-middle " name="testSizeXY"></td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">정확한 자로 규격을 측정한다</td>';
			html += '		<td colspan="5" class="fs-12 text-start align-middle" style="width: 100%;">';
			html += '			<div style="display: flex; width: 100%;">';
			html += '		    	<input type="text" class="text-end p-0" style="width: 34%; border: none; font-size: 12px !important; box-sizing: border-box;">(L)*';
			html += '		    	<input type="text" class="text-end p-0" style="width: 33%; border: none; font-size: 12px !important; box-sizing: border-box;">(W)*';
			html += '		    	<input type="text" class="text-end p-0" style="width: 33%; border: none; font-size: 12px !important; box-sizing: border-box;">(H)';
			html += '		  	</div>';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">절단면은 박리 현상 유무</td>';
			html += '		<td colspan="5" class="fs-12 text-start align-middle text-nowrap">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>'; //가로 길이 유지를 위한 공백 부여
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle ">3)도안번호</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle " name="testItemVersion"></td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">도안번호 확인</td>';
			html += '		<td colspan="5" class="fs-12 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle ">4)색 상</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle " name="testItemColor"></td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">지정 색도와 일치하는가?</td>';
			html += '		<td colspan="5" class="fs-12 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle ">5)표시사항</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">기준 견본</td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">문자, 글꼴등 견본과 일치하는가?</td>';
			html += '		<td colspan="5" class="fs-12 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" rowspan="3" class="fs-12 text-start align-middle ">6)인쇄 상태</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">문안 부위</td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">1㎟ 미만의 점이 3개이내인가?</td>';
			html += '		<td colspan="5" class="fs-12 text-start align-middle ">결과 : 정확, 부정확, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">문안 외 부위</td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">1㎟ 미만의 점이 5개이내인가?</td>';
			html += '		<td colspan="5" class="fs-12 text-start align-middle ">결과 : 정확, 부정확, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">인쇄 전체</td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">이중인쇄 인쇄번짐이 없는가?</td>';
			html += '		<td colspan="5" class="fs-12 text-start align-middle ">결과 : 정확, 부정확, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			//html += '	<tr>';
			//html += '		<td colspan="3" class="bd-n"></td>';
			//html += '		<td colspan="3" class="bg-gray fs-12 text-start align-middle ">7)바코드</td>';
			//html += '		<td colspan="7" class="fs-12 text-center align-middle ">기준 견본</td>';
			//html += '		<td colspan="9" class="fs-10 text-start align-middle ">정확하게 읽혀야 한다.</td>';
			//html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 양호, 부정확, 미적용</td>';
			//html += '		<td colspan="3" class="bd-n"></td>';
			//html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle ">7)코팅</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle " name="testCoatingMethod"></td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">코팅상태가 깨끗하여야한다.</td>';
			html += '		<td colspan="5" class="fs-12 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			//html += '	<tr>';
			//html += '		<td colspan="3" class="bd-n"></td>';
			//html += '		<td colspan="7" class="fs-12 text-center align-middle ">라미네이팅시 표면 접착강도</td>';
			//html += '		<td colspan="9" class="fs-10 text-start align-middle ">테이프시험시 인쇄가 떨어지지 않는다.</td>';
			//html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			//html += '		<td colspan="3" class="bd-n"></td>';
			//html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" rowspan="2" class="fs-12 text-start align-middle ">8)접착면</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">내부 규정 범위</td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">접착 과다 및 위치 여부</td>';
			html += '		<td colspan="5" class="fs-12 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">내부 규정 범위</td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">접착 후 조립 이상 유무</td>';
			html += '		<td colspan="5" class="fs-12 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle ">9)라벨</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">내부 규정 범위</td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">라벨 표기사항 부착 여부</td>';
			html += '		<td colspan="5" class="fs-12 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle ">10)포장</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">내부 규정 범위</td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">내용물이 안보이게 포장되었는가?</td>';
			html += '		<td colspan="5" class="fs-12 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="30" class="bd-n h-20"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="5" class="fs-15 text-start align-middle  br-n">특기사항 기록란</td>';
			html += '		<td colspan="19" class="fs-15 text-start align-middle  bl-n bb-n">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			//html += '	<tr>';
			//html += '		<td colspan="3" class="bd-n"></td>';
			//html += '		<td colspan="24" class="text-start align-middle  bb-n bt-n">';
			//html += '			<input type="text" class="text-start p-0 fs-15" style="border:none !important;max-width:600px;min-width:600px;">';
			//html += '		</td>';
			//html += '		<td colspan="3" class="bd-n"></td>';
			//html += '	</tr>';
			//html += '	<tr>';
			//html += '		<td colspan="3" class="bd-n"></td>';
			//html += '		<td colspan="5" class="fs-15 text-start align-middle  bt-n br-n">유효일자</td>';
			//html += '		<td colspan="19" class="fs-15 text-start align-middle  bt-n bl-n bb-n"></td>';
			//html += '		<td colspan="3" class="bd-n"></td>';
			//html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="24" class="text-start align-middle bb-n bt-n ">';
			html += '			<textarea rows="4" name="issueDesc" class="form-control text-start p-0 fs-15" style="resize: none;overflow:hidden;border:none !important;max-width:600px;min-width:600px;"></textarea>';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="24" class="text-center align-middle bt-n fw200 fs-8" name="fscTd">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '';		
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="fs-15 text-start align-middle bd-n">시험자 : </td>';
			html += '		<td colspan="8" class="fs-15 text-start align-middle bd-n" >';
			html += '			<input name="judUserName" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="7" class="fs-15 text-end align-middle bd-n">(일자 : </td>';
			html += '		<td colspan="5" class="fs-15 text-start align-middle bd-n">';
			html += '			<input name="judgmentDate" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="fs-15 text-start align-middle bd-n">판정자 : </td>';
			html += '		<td colspan="8" class="fs-15 text-start align-middle bd-n">';
			html += '			<input name="conUserName" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="7" class="fs-15 text-end align-middle bd-n">(일자 : </td>';
			html += '		<td colspan="5" class="fs-15 text-start align-middle bd-n" >';
			html += '			<input name="confirmDate" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="fs-15 text-start align-middle bd-n">판정결과 : </td>';
			html += '		<td colspan="20" class="fs-15 text-start align-middle bd-n" >';
			html += '			<input name="qualityJudgmentNm" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="30" class="bd-n h-20"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="24" class="fs-15 text-start align-middle bd-n">';
			html += '			<input value="문서번호 : 시험성적서 3-190910-03" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
		}  else if(paperType == '03'){
			//셀트리온 시험성적서-영문판
			html += '	<tr style="page-break-before: always!important;">';
			html += '		<td class="bd-n h-25" colspan="30">';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n max-h75 h-75"></td>';
			html += '		<td colspan="13" class="text-center max-h75 h-75 bd2px align-middle bt-n bl-n br-n">';
			html += '			<img src="/resources/assets/images/header_logo.png" style="width:70%;height:100%;">';
			html += '		</td>';
			html += '		<td colspan="11" class="bt-n bl-n br-n max-h70 bd2px fs-12" style="height:100%!important;">';
			html += '			ChangYoung Techpack co., Ltd.<br>';
			html += '			Add: 88-39, Saneop-ro 156beon-gil, Gwonseon-gu,<br>';
			html += '			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Suwon-si, Gyeonggi-do, Republic of Korea<br>';
			html += '			Tel: 82-31-292-6553&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Fax: 82-31-292-6507';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n max-h75 h-75"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td class="bd-n h-20" colspan="30">';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="7" class="bd-n"></td>';
			html += '		<td colspan="16" class="fs-30 fw900 bd2px text-center bt-n bl-n br-n">Certification of Analysis</td>';
			html += '		<td colspan="7" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="10" class="fs-20 fw900 bd2px text-center bt-n bl-n br-n">Celltrion</td>';
			html += '		<td colspan="17" class="fs-20 fw900 bd2px bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="30" class="bd-n h-10"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="fs-12 text-center align-middle"><sub style="font-size:6px!important;transform: translate(0%, 0%);display: inline-block;">Product Name</sub></td>';
			html += '		<td colspan="20" class="fs-12 text-center align-middle " name="testItemNm"></td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="fs-12 text-center align-middle ">MFG. date</td>';
			html += '		<td colspan="6" class="bg-gray fs-12 text-center align-middle ">';
			html += '			<input name="workDate" type="text" class="bg-gray text-center p-0 fs-15" style="border:none !important;max-width:70px">';
			html += '		</td>';
			html += '		<td colspan="4" class="fs-12 text-center align-middle ">Lot No.</td>';
			html += '		<td colspan="10" class="bg-gray fs-12 text-center align-middle " name="bizOrdDtlNo"></td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="fs-12 text-center align-middle ">Test date</td>';
			html += '		<td colspan="6" class="bg-gray fs-12 text-center align-middle " >';
			html += '			<input name="testJudgmentDate" type="text" class="bg-gray text-center p-0 " style="border:none !important;max-width:70px;">';
			html += '		</td>';
			html += '		<td colspan="4" class="fs-12 text-center align-middle ">Catalog No.</td>';
			html += '		<td colspan="10" class="fs-12 text-center align-middle " name="itemVersion"></td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="fs-12 text-center align-middle "><sub style="font-size:2px!important;transform: translate(0%, 0%);display: inline-block;">Paper material</sub></td>';
			html += '		<td colspan="6" class="fs-12 text-center align-middle " name="paperType"></td>';
			html += '		<td colspan="4" class="fs-12 text-center align-middle "><sub style="font-size:2px!important;transform: translate(0%, 0%);display: inline-block;">Delivery qunantity</sub></td>';
			html += '		<td colspan="10" class="bg-gray fs-12 text-center align-middle " >';
			html += '			<input name="quailtyPassQty" type="text" class="bg-gray text-center p-0 " style="border:none !important;max-width:200px;min-width:200px;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="fs-12 text-center align-middle "><sub style="font-size:2px!important;transform: translate(0%, 0%);display: inline-block;">Negative quantity</sub></td>';
			html += '		<td colspan="6" class="fs-12 text-center align-middle " name="eaQty"></td>';
			html += '		<td colspan="4" class="fs-12 text-center align-middle ">Packaging</td>';
			html += '		<td colspan="2" class="fs-12 text-center align-middle ">Inner</td>';
			html += '		<td colspan="4" class="fs-12 text-center align-middle " name="inPackMethod"></td>';
			html += '		<td colspan="2" class="fs-12 text-center align-middle ">Outer</td>';
			html += '		<td colspan="2" class="fs-12 text-center align-middle " name="outPackMethod"></td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="fs-12 text-center align-middle ">Coating</td>';
			html += '		<td colspan="6" class="fs-12 text-center align-middle " name="coatingMethod"></td>';
			html += '		<td colspan="4" class="fs-12 text-center align-middle ">Color</td>';
			html += '		<td colspan="10" class="fs-12 text-center align-middle bg-gray" name="itemColor"></td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="fs-12 text-center align-middle ">Forming type</td>';
			html += '		<td colspan="6" class="fs-12 text-center align-middle " name="moldingMethod"></td>';
			html += '		<td colspan="4" class="fs-12 text-center align-middle ">Test result</td>';
			html += '		<td colspan="10" class="fs-12 text-center align-middle">';
			html += '			<input name="qualityResult" type="text" class="text-start p-0 " style="border:none !important;width:100%;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="30" class="bd-n h-20"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="fs-12 text-center align-middle ">Test tem</td>';
			html += '		<td colspan="7" class="br-n fs-12 text-center align-middle ">Inspection criteria</td>';
			html += '		<td colspan="9" class="bl-n br-n fs-12 text-center align-middle ">Inspection content</td>';
			html += '		<td colspan="4" class="bl-n fs-12 text-center align-middle ">Result</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="fs-10 text-start align-middle ">1)Paper material</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle " name="testPaperType"></td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">actual material for production</td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle bl-n br-n" style="width: 100%;">';
			html += '			<input type="text" class="text-end p-0" style="width: 100%; border: none; font-size: 12px !important; box-sizing: border-box;">';
			html += '		</td>';
			html += '		<td colspan="1" class="fs-12 text-start align-middle bl-n">㎡</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" rowspan="2" class="fs-12 text-start align-middle ">2)Paper Size</td>';
			html += '		<td colspan="7" rowspan="2" class="fs-12 text-center align-middle " name="testSizeXY"></td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">measure paper with a ruler</td>';
			html += '		<td colspan="4" class="fs-12 text-start align-middle" style="width: 100%;">';
			html += '			<div style="display: flex; width: 100%;">';
			html += '		    	<input type="text" class="text-end p-0" style="width: 34%; border: none; font-size: 12px !important; box-sizing: border-box;">(L)*';
			html += '		    	<input type="text" class="text-end p-0" style="width: 33%; border: none; font-size: 12px !important; box-sizing: border-box;">(W)*';
			html += '		    	<input type="text" class="text-end p-0" style="width: 33%; border: none; font-size: 12px !important; box-sizing: border-box;">(H)';
			html += '		  	</div>';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">check for insection separation phenomenon</td>';
			html += '		<td colspan="4" class="fs-12 text-start align-middle text-nowrap">Result : Good / Fair&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="fs-12 text-start align-middle ">3)Drawing No.</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle " name="testItemVersion"></td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">check for drawing no.</td>';
			html += '		<td colspan="4" class="fs-10 text-start align-middle ">Result : Good / Fair / Unapplied</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="fs-12 text-start align-middle ">4)Color</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle " name="testItemColor"></td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">check for chromaticity consistent with the specified</td>';
			html += '		<td colspan="4" class="fs-10 text-start align-middle ">Result : Good / Fair / Unapplied</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="fs-12 text-start align-middle ">5)Mark item</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">sample criteria</td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">check for consistent with the criteria sample</td>';
			html += '		<td colspan="4" class="fs-10 text-start align-middle ">Result : Good / Fair / Unapplied</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" rowspan="3" class="fs-12 text-start align-middle ">6)Print quality</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">Contents of printed</td>';
			html += "		<td colspan='9' class='fs-10 text-start align-middle '>check for printing defects<br>- Dot size : less than 1㎟ / Q'ty : less than 3</td>";
			html += '		<td colspan="4" class="fs-10 text-start align-middle ">Result : Accuracy /<br>Inaccuracy / Unapplied</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">Except contents of printed</td>';
			html += "		<td colspan='9' class='fs-10 text-start align-middle '>check for printing defects<br>- Dot size : less than 1㎟ / Q'ty : less than 5</td>";
			html += '		<td colspan="4" class="fs-10 text-start align-middle ">Result : Accuracy /<br>Inaccuracy / Unapplied</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">Entire print status</td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">check for mackle or bad printing</td>';
			html += '		<td colspan="4" class="fs-10 text-start align-middle ">Result : Accuracy /<br>Inaccuracy / Unapplied</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			//html += '	<tr>';
			//html += '		<td colspan="3" class="bd-n"></td>';
			//html += '		<td colspan="3" class="bg-gray fs-12 text-start align-middle ">7)바코드</td>';
			//html += '		<td colspan="7" class="fs-12 text-center align-middle ">기준 견본</td>';
			//html += '		<td colspan="9" class="fs-10 text-start align-middle ">정확하게 읽혀야 한다.</td>';
			//html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 양호, 부정확, 미적용</td>';
			//html += '		<td colspan="3" class="bd-n"></td>';
			//html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="fs-12 text-start align-middle ">7)Coating</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">non-coated</td>'; //testCoatingMethod
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">check for coating area</td>';
			html += '		<td colspan="4" class="fs-10 text-start align-middle ">Result : Good / Fair / Unapplied</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			//html += '	<tr>';
			//html += '		<td colspan="3" class="bd-n"></td>';
			//html += '		<td colspan="7" class="fs-12 text-center align-middle ">라미네이팅시 표면 접착강도</td>';
			//html += '		<td colspan="9" class="fs-10 text-start align-middle ">테이프시험시 인쇄가 떨어지지 않는다.</td>';
			//html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			//html += '		<td colspan="3" class="bd-n"></td>';
			//html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" rowspan="2" class="fs-12 text-start align-middle ">8)adherend</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">Internal specification range</td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">check for adherend area</td>';
			html += '		<td colspan="4" class="fs-10 text-start align-middle ">Result : Good / Fair / Unapplied</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">Internal specification range</td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">check for the status of assembly</td>';
			html += '		<td colspan="4" class="fs-10 text-start align-middle ">Result : Good / Fair / Unapplied</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="fs-12 text-start align-middle ">9)Label</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">Internal specification range</td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">check for labeling</td>';
			html += '		<td colspan="4" class="fs-10 text-start align-middle ">Result : Good / Fair / Unapplied</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="fs-12 text-start align-middle ">10)Packaging</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">Internal specification range</td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">check for packaging status</td>';
			html += '		<td colspan="4" class="fs-10 text-start align-middle ">Result : Good / Fair / Unapplied</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="30" class="bd-n h-20"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="5" class="fs-15 text-start align-middle  br-n">Remarks</td>';
			html += '		<td colspan="19" class="fs-15 text-start align-middle  bl-n bb-n">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			//html += '	<tr>';
			//html += '		<td colspan="3" class="bd-n"></td>';
			//html += '		<td colspan="24" class="text-start align-middle  bb-n bt-n">';
			//html += '			<input type="text" class="text-start p-0 fs-15" style="border:none !important;max-width:600px;min-width:600px;">';
			//html += '		</td>';
			//html += '		<td colspan="3" class="bd-n"></td>';
			//html += '	</tr>';
			//html += '	<tr>';
			//html += '		<td colspan="3" class="bd-n"></td>';
			//html += '		<td colspan="5" class="fs-15 text-start align-middle  bt-n br-n">유효일자</td>';
			//html += '		<td colspan="19" class="fs-15 text-start align-middle  bt-n bl-n bb-n"></td>';
			//html += '		<td colspan="3" class="bd-n"></td>';
			//html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="24" class="text-start align-middle bb-n bt-n ">';
			html += '			<textarea rows="4" name="issueDesc" class="form-control text-start p-0 fs-15" style="resize: none;overflow:hidden;border:none !important;max-width:600px;min-width:600px;"></textarea>';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="24" class="text-center align-middle bt-n fw200 fs-8" name="fscTd">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '';		
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="fs-15 text-start align-middle bd-n">Experimenter : </td>';
			html += '		<td colspan="8" class="fs-15 text-start align-middle bd-n" >';
			html += '			<input name="judUserName" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="7" class="fs-15 text-end align-middle bd-n">(Date : </td>';
			html += '		<td colspan="5" class="fs-15 text-start align-middle bd-n">';
			html += '			<input name="judgmentDate" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="fs-15 text-start align-middle bd-n">Approver : </td>';
			html += '		<td colspan="8" class="fs-15 text-start align-middle bd-n">';
			html += '			<input name="conUserName" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="7" class="fs-15 text-end align-middle bd-n">(Date : </td>';
			html += '		<td colspan="5" class="fs-15 text-start align-middle bd-n" >';
			html += '			<input name="confirmDate" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="fs-15 text-start align-middle bd-n">Test result : </td>';
			html += '		<td colspan="20" class="fs-15 text-start align-middle bd-n" >';
			html += '			<input name="qualityJudgmentNm" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="30" class="bd-n h-20"></td>';
			html += '	</tr>'; 
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="24" class="fs-15 text-start align-middle bd-n">';
			html += '			<input value="문서번호 : 시험성적서 3-190910-03" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
		} else if(paperType == '04'){
			//셀트리온제약 오창,한독 
			html += '	<tr style="page-break-before: always!important;">';
			html += '		<td class="bd-n h-25" colspan="30">';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n max-h75 h-75"></td>';
			html += '		<td colspan="13" class="text-center max-h75 h-75 bd2px align-middle bt-n bl-n br-n">';
			html += '			<img src="/resources/assets/images/header_logo.png" style="width:70%;height:100%;">';
			html += '		</td>';
			html += '		<td colspan="11" class="bt-n bl-n br-n max-h70 bd2px fs-12" style="height:100%!important;">';
			html += '			㈜ 창영테크팩<br>';
			html += '			주소 : 경기도 수원시 권선구 산업로 156번길 88-39<br>';
			html += '			Tel : 031-292-6553<br>';
			html += '			Fax : 031-292-6507';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n max-h75 h-75"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td class="bd-n h-15" colspan="30">';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="8" class="bd-n"></td>';
			html += '		<td colspan="14" class="fs-30 fw900 bd2px text-center bt-n bl-n br-n">자&nbsp;&nbsp;재&nbsp;&nbsp;시&nbsp;&nbsp;험&nbsp;&nbsp;성&nbsp;&nbsp;적&nbsp;&nbsp;서</td>';
			html += '		<td colspan="8" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="12" class="fs-20 fw900 bd2px text-center bt-n bl-n br-n" name="purchaseCustomerNm"></td>';
			html += '		<td colspan="15" class="fs-20 fw900 bd2px bd-n">貴中</td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="30" class="bd-n h-10"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">제 품 명</td>';
			html += '		<td colspan="21" class="fs-12 text-center align-middle " name="testItemNm"></td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">제조일자</td>';
			html += '		<td colspan="6" class="bg-gray fs-12 text-center align-middle ">';
			html += '			<input name="workDate" type="text" class="bg-gray text-center p-0 fs-15" style="border:none !important;max-width:70px">';
			html += '		</td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">제조번호</td>';
			html += '		<td colspan="12" class="bg-gray fs-12 text-center align-middle " name="bizOrdDtlNo"></td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">검사일자</td>';
			html += '		<td colspan="6" class="bg-gray fs-12 text-center align-middle " >';
			html += '			<input name="testJudgmentDate" type="text" class="bg-gray text-center p-0 " style="border:none !important;max-width:70px;">';
			html += '		</td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">도안번호</td>';
			html += '		<td colspan="12" class="fs-12 text-center align-middle " name="itemVersion"></td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">재질명</td>';
			html += '		<td colspan="6" class="fs-12 text-center align-middle " name="paperType"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">입고수량</td>';
			html += '		<td colspan="12" class="bg-gray fs-12 text-center align-middle " >';
			html += '			<input name="quailtyPassQty" type="text" class="bg-gray text-center p-0 " style="border:none !important;max-width:200px;min-width:200px;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">원판 수량</td>';
			html += '		<td colspan="6" class="fs-12 text-center align-middle " name="eaQty"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">포장방법</td>';
			html += '		<td colspan="2" class="fs-12 text-center align-middle ">내부</td>';
			html += '		<td colspan="4" class="fs-12 text-center align-middle " name="inPackMethod"></td>';
			html += '		<td colspan="2" class="fs-12 text-center align-middle ">외부</td>';
			html += '		<td colspan="4" class="fs-12 text-center align-middle " name="outPackMethod"></td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">코팅</td>';
			html += '		<td colspan="6" class="fs-12 text-center align-middle " name="coatingMethod"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">색 상</td>';
			html += '		<td colspan="12" class="fs-12 text-center align-middle " name="itemColor"></td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">성형방식</td>';
			html += '		<td colspan="6" class="fs-12 text-center align-middle " name="moldingMethod"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">보관조건</td>';
			html += '		<td colspan="12" class="fs-12 text-center align-middle ">온도 : 실온( 15 ~ 25℃ )</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="30" class="bd-n h-10"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">시험항목</td>';
			html += '		<td colspan="7" class="br-n fs-12 text-center align-middle ">기준</td>';
			html += '		<td colspan="9" class="bl-n br-n fs-12 text-center align-middle ">검사내용</td>';
			html += '		<td colspan="5" class="bl-n fs-12 text-center align-middle ">시험결과</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle ">1)재질</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle " name="testPaperType"></td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">기준과 실제 생산용</td>';
			html += '		<td colspan="1" class="fs-10 text-start align-middle br-n">재질 :</td>';
			html += '		<td colspan="3" class="fs-10 text-start align-middle bl-n br-n" style="width: 100%;">';
			html += '			<input type="text" class="text-end p-0" style="width: 100%; border: none; font-size: 10px !important; box-sizing: border-box;">';
			html += '		</td>';
			html += '		<td colspan="1" class="fs-10 text-start align-middle bl-n">㎡</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" rowspan="3" class="fs-12 text-start align-middle ">2)규격</td>';
			html += '		<td colspan="7" rowspan="3" class="fs-12 text-center align-middle " name="testSizeXY"></td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">정확한 자로 규격을 측정한다.<sub style="font-size:6px!important;transform: translate(-8%, -50%) scale(0.8);display: inline-block;">(오차범위±0.5mm)</sub></td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle" style="width: 100%;">';
			html += '			<div style="display: flex; width: 100%;">';
			html += '		    	<input type="text" class="text-end p-0" style="width: 34%; border: none; font-size: 10px !important; box-sizing: border-box;">(L)*';
			html += '		    	<input type="text" class="text-end p-0" style="width: 33%; border: none; font-size: 10px !important; box-sizing: border-box;">(W)*';
			html += '		    	<input type="text" class="text-end p-0" style="width: 33%; border: none; font-size: 10px !important; box-sizing: border-box;">(H)';
			html += '		  	</div>';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">재단면 또는 톰슨은 완벽한가</td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle text-nowrap">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>'; //가로 길이 유지를 위한 공백 부여
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">접지 후 규격을 측정한다.<sub style="font-size:6px!important;transform: translate(-8%, -50%) scale(0.8);display: inline-block;">(오차범위±2mm)</sub></td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle" style="width: 100%;">';
			html += '			<div style="display: flex; width: 100%;">';
			html += '		    	<input type="text" class="text-end p-0" style="width: 34%; border: none; font-size: 10px !important; box-sizing: border-box;">(L)*';
			html += '		    	<input type="text" class="text-end p-0" style="width: 33%; border: none; font-size: 10px !important; box-sizing: border-box;">(W)*';
			html += '		    	<input type="text" class="text-end p-0" style="width: 33%; border: none; font-size: 10px !important; box-sizing: border-box;">(H)';
			html += '		  	</div>';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle ">3)도안번호</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle " name="testItemVersion"></td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">도안번호 확인</td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 정확, 부정확, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle ">4)색 상</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle " name="testItemColor"></td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">지정 색도와 일치하는가를 확인</td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle ">5)표시사항</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">기준 견본</td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">문자, 글꼴등 견본과 일치하는가?</td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" rowspan="3" class="fs-12 text-start align-middle ">6)인쇄 상태</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">문안 부위</td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">1㎟ 미만의 점이 3개이내인가?</td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">문안 외 부위</td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">1㎟ 미만의 점이 5개이내인가?</td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">인쇄 전체</td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">이중인쇄 인쇄번짐이 없는가?</td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="bg-gray fs-12 text-start align-middle ">7)바코드</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">기준 견본</td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">정확하게 읽혀야 한다.</td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 정확, 부정확, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" rowspan="2" class="bg-gray fs-12 text-start align-middle ">8)코팅</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle " name="testCoatingMethod"></td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">코팅상태가 깨끗하여야한다.</td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">라미네이팅시 표면 접착강도</td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">테이프시험시 인쇄가 떨어지지 않는다.</td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="bg-gray fs-12 text-start align-middle ">9)접착면</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">내부 규정 범위</td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">접착 품질 확인</td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle ">10)외관</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">내부 규정 범위</td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">손상, 파손등의 확인</td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle ">11)라벨</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">내부 규정 범위</td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">라벨 표기사항 부착 여부</td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle ">12)포장</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">내부 규정 범위</td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">Tapping 상태</td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="30" class="bd-n h-10"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="5" class="fs-15 text-start align-middle  br-n">특기사항 기록란</td>';
			html += '		<td colspan="19" class="fs-15 text-start align-middle  bl-n bb-n">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="24" class="text-start align-middle  bb-n bt-n">';
			html += '			<input type="text" class="text-start p-0 fs-15" style="border:none !important;max-width:600px;min-width:600px;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="5" class="fs-15 text-start align-middle  bt-n br-n">유효일자</td>';
			html += '		<td colspan="19" class="fs-15 text-start align-middle  bt-n bl-n bb-n"></td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="24" class="text-start align-middle bb-n bt-n ">';
			html += '			<input type="text" class="text-start p-0 fs-15" style="border:none !important;max-width:600px;min-width:600px;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="24" class="text-center align-middle bt-n fw200 fs-8" name="fscTd">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '';		
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="fs-15 text-start align-middle bd-n">시험자 : </td>';
			html += '		<td colspan="8" class="fs-15 text-start align-middle bd-n" >';
			html += '			<input name="judUserName" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="7" class="fs-15 text-end align-middle bd-n">(일자 : </td>';
			html += '		<td colspan="5" class="fs-15 text-start align-middle bd-n">';
			html += '			<input name="judgmentDate" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="fs-15 text-start align-middle bd-n">판정자 : </td>';
			html += '		<td colspan="8" class="fs-15 text-start align-middle bd-n">';
			html += '			<input name="conUserName" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="7" class="fs-15 text-end align-middle bd-n">(일자 : </td>';
			html += '		<td colspan="5" class="fs-15 text-start align-middle bd-n" >';
			html += '			<input name="confirmDate" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="fs-15 text-start align-middle bd-n">판정결과 : </td>';
			html += '		<td colspan="20" class="fs-15 text-start align-middle bd-n" >';
			html += '			<input name="qualityJudgmentNm" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="14" class="fs-15 text-start align-middle bd-n"></td>';
			html += '		<td colspan="10" class="fs-15 text-start align-middle bd-n">㈜ 창영테크팩    최 재 성';
			html += '			<img src="/resources/assets/images/ceo_sign.png" style="width:28%;height:100%;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="24" class="fs-15 text-start align-middle bd-n">';
			html += '			<input value="문서번호 : 시험성적서 4-190910-03" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
		} else if(paperType == '05'){
			//명인 시험성적서
			html += '	<tr style="page-break-before: always!important;">';
			html += '		<td class="bd-n h-25" colspan="30">';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n max-h75 h-75"></td>';
			html += '		<td colspan="13" class="text-center max-h75 h-75 bd2px align-middle bt-n bl-n br-n">';
			html += '			<img src="/resources/assets/images/creativeLab.jpeg" style="width:70%;height:100%;">';
			html += '		</td>';
			html += '		<td colspan="11" class="bt-n bl-n br-n max-h70 bd2px fs-12" style="height:100%!important;">';
			html += '			크리에이티브 랩<br>';
			html += '			주소 : 경기도 수원시 권선구 산업로 156번길 88-39<br>';
			html += '			Tel : 031-292-6553<br>';
			html += '			Fax : 031-292-6507';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n max-h75 h-75"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td class="bd-n h-20" colspan="30">';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="8" class="bd-n"></td>';
			html += '		<td colspan="14" class="fs-30 fw900 bd2px text-center bt-n bl-n br-n">자&nbsp;&nbsp;재&nbsp;&nbsp;시&nbsp;&nbsp;험&nbsp;&nbsp;성&nbsp;&nbsp;적&nbsp;&nbsp;서</td>';
			html += '		<td colspan="8" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="12" class="fs-20 fw900 bd2px text-center bt-n bl-n br-n" name="purchaseCustomerNm"></td>';
			html += '		<td colspan="15" class="fs-20 fw900 bd2px bd-n">貴中</td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="30" class="bd-n h-10"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">제 품 명</td>';
			html += '		<td colspan="21" class="fs-12 text-center align-middle " name="testItemNm"></td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">제조일자</td>';
			html += '		<td colspan="6" class="bg-gray fs-12 text-center align-middle ">';
			html += '			<input name="workDate" type="text" class="bg-gray text-center p-0 fs-15" style="border:none !important;max-width:70px">';
			html += '		</td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">제조번호</td>';
			html += '		<td colspan="12" class="bg-gray fs-12 text-center align-middle " name="bizOrdDtlNo"></td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">검사일자</td>';
			html += '		<td colspan="6" class="bg-gray fs-12 text-center align-middle " >';
			html += '			<input name="testJudgmentDate" type="text" class="bg-gray text-center p-0 " style="border:none !important;max-width:70px;">';
			html += '		</td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">도안번호</td>';
			html += '		<td colspan="12" class="fs-12 text-center align-middle " name="itemVersion"></td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">재질명</td>';
			html += '		<td colspan="6" class="fs-12 text-center align-middle " name="paperType"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">입고수량</td>';
			html += '		<td colspan="12" class="bg-gray fs-12 text-center align-middle " >';
			html += '			<input name="quailtyPassQty" type="text" class="bg-gray text-center p-0 " style="border:none !important;max-width:200px;min-width:200px;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">원판 수량</td>';
			html += '		<td colspan="6" class="fs-12 text-center align-middle " name="eaQty"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">포장방법</td>';
			html += '		<td colspan="2" class="fs-12 text-center align-middle ">내부</td>';
			html += '		<td colspan="4" class="fs-12 text-center align-middle " name="inPackMethod"></td>';
			html += '		<td colspan="2" class="fs-12 text-center align-middle ">외부</td>';
			html += '		<td colspan="4" class="fs-12 text-center align-middle " name="outPackMethod"></td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">코팅</td>';
			html += '		<td colspan="6" class="fs-12 text-center align-middle " name="coatingMethod"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">색 상</td>';
			html += '		<td colspan="12" class="fs-12 text-center align-middle" name="itemColor"></td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">성형방식</td>';
			html += '		<td colspan="6" class="fs-12 text-center align-middle " name="moldingMethod"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">판정 결과</td>';
			html += '		<td colspan="12" class="fs-12 text-center align-middle">';
			html += '			<input name="qualityResult" type="text" class="text-start p-0 " style="border:none !important;width:100%;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="30" class="bd-n h-20"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">시험항목</td>';
			html += '		<td colspan="7" class="br-n fs-12 text-center align-middle ">기준</td>';
			html += '		<td colspan="9" class="bl-n br-n fs-12 text-center align-middle ">검사내용</td>';
			html += '		<td colspan="5" class="bl-n fs-12 text-center align-middle ">시험결과</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle ">1)재질</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle " name="testPaperType"></td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">기준과 실제 생산용</td>';
			html += '		<td colspan="1" class="fs-12 text-start align-middle br-n">재질 :</td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle bl-n br-n" style="width: 100%;">';
			html += '			<input type="text" class="text-end p-0" style="width: 100%; border: none; font-size: 12px !important; box-sizing: border-box;">';
			html += '		</td>';
			html += '		<td colspan="1" class="fs-12 text-start align-middle bl-n">㎡</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" rowspan="2" class="fs-12 text-start align-middle ">2)규격</td>';
			html += '		<td colspan="7" rowspan="2" class="fs-12 text-center align-middle " name="testSizeXY"></td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">정확한 자로 규격을 측정한다</td>';
			html += '		<td colspan="5" class="fs-12 text-start align-middle" style="width: 100%;">';
			html += '			<div style="display: flex; width: 100%;">';
			html += '		    	<input type="text" class="text-end p-0" style="width: 34%; border: none; font-size: 12px !important; box-sizing: border-box;">(L)*';
			html += '		    	<input type="text" class="text-end p-0" style="width: 33%; border: none; font-size: 12px !important; box-sizing: border-box;">(W)*';
			html += '		    	<input type="text" class="text-end p-0" style="width: 33%; border: none; font-size: 12px !important; box-sizing: border-box;">(H)';
			html += '		  	</div>';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">절단면은 박리 현상 유무</td>';
			html += '		<td colspan="5" class="fs-12 text-start align-middle text-nowrap">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>'; //가로 길이 유지를 위한 공백 부여
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle ">3)도안번호</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle " name="testItemVersion"></td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">도안번호 확인</td>';
			html += '		<td colspan="5" class="fs-12 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle ">4)색 상</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle " name="testItemColor"></td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">지정 색도와 일치하는가?</td>';
			html += '		<td colspan="5" class="fs-12 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle ">5)표시사항</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">기준 견본</td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">문자, 글꼴등 견본과 일치하는가?</td>';
			html += '		<td colspan="5" class="fs-12 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" rowspan="3" class="fs-12 text-start align-middle ">6)인쇄 상태</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">문안 부위</td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">1㎟ 미만의 점이 3개이내인가?</td>';
			html += '		<td colspan="5" class="fs-12 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">문안 외 부위</td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">1㎟ 미만의 점이 5개이내인가?</td>';
			html += '		<td colspan="5" class="fs-12 text-start align-middle ">결과 : 정확, 부정확, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">인쇄 전체</td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">이중인쇄 인쇄번짐이 없는가?</td>';
			html += '		<td colspan="5" class="fs-12 text-start align-middle ">결과 : 정확, 부정확, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			//html += '	<tr>';
			//html += '		<td colspan="3" class="bd-n"></td>';
			//html += '		<td colspan="3" class="bg-gray fs-12 text-start align-middle ">7)바코드</td>';
			//html += '		<td colspan="7" class="fs-12 text-center align-middle ">기준 견본</td>';
			//html += '		<td colspan="9" class="fs-10 text-start align-middle ">정확하게 읽혀야 한다.</td>';
			//html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 양호, 부정확, 미적용</td>';
			//html += '		<td colspan="3" class="bd-n"></td>';
			//html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle ">7)코팅</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle " name="testCoatingMethod"></td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">코팅상태가 깨끗하여야한다.</td>';
			html += '		<td colspan="5" class="fs-12 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			//html += '	<tr>';
			//html += '		<td colspan="3" class="bd-n"></td>';
			//html += '		<td colspan="7" class="fs-12 text-center align-middle ">라미네이팅시 표면 접착강도</td>';
			//html += '		<td colspan="9" class="fs-10 text-start align-middle ">테이프시험시 인쇄가 떨어지지 않는다.</td>';
			//html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			//html += '		<td colspan="3" class="bd-n"></td>';
			//html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" rowspan="2" class="fs-12 text-start align-middle ">8)접착면</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">내부 규정 범위</td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">접착 과다 및 위치 여부</td>';
			html += '		<td colspan="5" class="fs-12 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">내부 규정 범위</td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">접착 후 조립 이상 유무</td>';
			html += '		<td colspan="5" class="fs-12 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle ">9)라벨</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">내부 규정 범위</td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">라벨 표기사항 부착 여부</td>';
			html += '		<td colspan="5" class="fs-12 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle ">10)포장</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">내부 규정 범위</td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">내용물이 안보이게 포장되었는가?</td>';
			html += '		<td colspan="5" class="fs-12 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="30" class="bd-n h-20"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="5" class="fs-15 text-start align-middle  br-n">특기사항 기록란</td>';
			html += '		<td colspan="19" class="fs-15 text-start align-middle  bl-n bb-n">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			//html += '	<tr>';
			//html += '		<td colspan="3" class="bd-n"></td>';
			//html += '		<td colspan="24" class="text-start align-middle  bb-n bt-n">';
			//html += '			<input type="text" class="text-start p-0 fs-15" style="border:none !important;max-width:600px;min-width:600px;">';
			//html += '		</td>';
			//html += '		<td colspan="3" class="bd-n"></td>';
			//html += '	</tr>';
			//html += '	<tr>';
			//html += '		<td colspan="3" class="bd-n"></td>';
			//html += '		<td colspan="5" class="fs-15 text-start align-middle  bt-n br-n">유효일자</td>';
			//html += '		<td colspan="19" class="fs-15 text-start align-middle  bt-n bl-n bb-n"></td>';
			//html += '		<td colspan="3" class="bd-n"></td>';
			//html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="24" class="text-start align-middle bb-n bt-n ">';
			html += '			<textarea rows="6" name="issueDesc" class="form-control text-start p-0 fs-15" style="resize: none;overflow:hidden;border:none !important;max-width:600px;min-width:600px;"></textarea>';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="24" class="text-center align-middle bt-n fw200 fs-8" name="fscTd">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '';		
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="fs-15 text-start align-middle bd-n">시험자 : </td>';
			html += '		<td colspan="8" class="fs-15 text-start align-middle bd-n" >';
			html += '			<input name="judUserName" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="7" class="fs-15 text-end align-middle bd-n">(일자 : </td>';
			html += '		<td colspan="5" class="fs-15 text-start align-middle bd-n">';
			html += '			<input name="judgmentDate" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="fs-15 text-start align-middle bd-n">판정자 : </td>';
			html += '		<td colspan="8" class="fs-15 text-start align-middle bd-n">';
			html += '			<input name="conUserName" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="7" class="fs-15 text-end align-middle bd-n">(일자 : </td>';
			html += '		<td colspan="5" class="fs-15 text-start align-middle bd-n" >';
			html += '			<input name="confirmDate" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="fs-15 text-start align-middle bd-n">판정결과 : </td>';
			html += '		<td colspan="20" class="fs-15 text-start align-middle bd-n" >';
			html += '			<input name="qualityJudgmentNm" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="30" class="bd-n h-20"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="24" class="fs-15 text-start align-middle bd-n">';
			html += '			<input value="문서번호 : 시험성적서 6-190910-03" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
		} else if(paperType == '06'){
			//크리, 건일
			html += '	<tr style="page-break-before: always!important;">';
			html += '		<td class="bd-n h-25" colspan="30">';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n max-h75 h-75"></td>';
			html += '		<td colspan="13" class="text-center max-h75 h-75 bd2px align-middle bt-n bl-n br-n">';
			html += '			<img src="/resources/assets/images/creativeLab.jpeg" style="width:70%;height:100%;">';
			html += '		</td>';
			html += '		<td colspan="11" class="bt-n bl-n br-n max-h70 bd2px fs-12" style="height:100%!important;">';
			html += '			크리에이티브 랩<br>';
			html += '			주소 : 경기도 수원시 권선구 산업로 156번길 88-39<br>';
			html += '			Tel : 031-292-6553<br>';
			html += '			Fax : 031-292-6507';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n max-h75 h-75"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td class="bd-n h-20" colspan="30">';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="8" class="bd-n"></td>';
			html += '		<td colspan="14" class="fs-30 fw900 bd2px text-center bt-n bl-n br-n">자&nbsp;&nbsp;재&nbsp;&nbsp;시&nbsp;&nbsp;험&nbsp;&nbsp;성&nbsp;&nbsp;적&nbsp;&nbsp;서</td>';
			html += '		<td colspan="8" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="12" class="fs-20 fw900 bd2px text-center bt-n bl-n br-n" name="purchaseCustomerNm"></td>';
			html += '		<td colspan="15" class="fs-20 fw900 bd2px bd-n">貴中</td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="30" class="bd-n h-10"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">제 품 명</td>';
			html += '		<td colspan="21" class="fs-12 text-center align-middle " name="testItemNm"></td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">제조일자</td>';
			html += '		<td colspan="6" class="bg-gray fs-12 text-center align-middle ">';
			html += '			<input name="workDate" type="text" class="bg-gray text-center p-0 fs-15" style="border:none !important;max-width:70px">';
			html += '		</td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">제조번호</td>';
			html += '		<td colspan="12" class="bg-gray fs-12 text-center align-middle " name="bizOrdDtlNo"></td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">검사일자</td>';
			html += '		<td colspan="6" class="bg-gray fs-12 text-center align-middle " >';
			html += '			<input name="testJudgmentDate" type="text" class="bg-gray text-center p-0 " style="border:none !important;max-width:70px;">';
			html += '		</td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">도안번호</td>';
			html += '		<td colspan="12" class="fs-12 text-center align-middle " name="itemVersion"></td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">재질명</td>';
			html += '		<td colspan="6" class="fs-12 text-center align-middle " name="paperType"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">입고수량</td>';
			html += '		<td colspan="12" class="bg-gray fs-12 text-center align-middle " >';
			html += '			<input name="quailtyPassQty" type="text" class="bg-gray text-center p-0 " style="border:none !important;max-width:200px;min-width:200px;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">원판 수량</td>';
			html += '		<td colspan="6" class="fs-12 text-center align-middle " name="eaQty"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">포장방법</td>';
			html += '		<td colspan="2" class="fs-12 text-center align-middle ">내부</td>';
			html += '		<td colspan="4" class="fs-12 text-center align-middle " name="inPackMethod"></td>';
			html += '		<td colspan="2" class="fs-12 text-center align-middle ">외부</td>';
			html += '		<td colspan="4" class="fs-12 text-center align-middle " name="outPackMethod"></td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">코팅</td>';
			html += '		<td colspan="6" class="fs-12 text-center align-middle " name="coatingMethod"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">색 상</td>';
			html += '		<td colspan="12" class="fs-12 text-center align-middle" name="itemColor"></td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">성형방식</td>';
			html += '		<td colspan="6" class="fs-12 text-center align-middle " name="moldingMethod"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">판정 결과</td>';
			html += '		<td colspan="12" class="fs-12 text-center align-middle">';
			html += '			<input name="qualityResult" type="text" class="text-start p-0 " style="border:none !important;width:100%;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="30" class="bd-n h-20"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">시험항목</td>';
			html += '		<td colspan="7" class="br-n fs-12 text-center align-middle ">기준</td>';
			html += '		<td colspan="9" class="bl-n br-n fs-12 text-center align-middle ">검사내용</td>';
			html += '		<td colspan="5" class="bl-n fs-12 text-center align-middle ">시험결과</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle ">1)재질</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle " name="testPaperType"></td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">기준과 실제 생산용</td>';
			html += '		<td colspan="1" class="fs-12 text-start align-middle br-n">재질 :</td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle bl-n br-n" style="width: 100%;">';
			html += '			<input type="text" class="text-end p-0" style="width: 100%; border: none; font-size: 12px !important; box-sizing: border-box;">';
			html += '		</td>';
			html += '		<td colspan="1" class="fs-12 text-start align-middle bl-n">㎡</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" rowspan="2" class="fs-12 text-start align-middle ">2)규격</td>';
			html += '		<td colspan="7" rowspan="2" class="fs-12 text-center align-middle " name="testSizeXY"></td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">정확한 자로 규격을 측정한다</td>';
			html += '		<td colspan="5" class="fs-12 text-start align-middle" style="width: 100%;">';
			html += '			<div style="display: flex; width: 100%;">';
			html += '		    	<input type="text" class="text-end p-0" style="width: 34%; border: none; font-size: 12px !important; box-sizing: border-box;">(L)*';
			html += '		    	<input type="text" class="text-end p-0" style="width: 33%; border: none; font-size: 12px !important; box-sizing: border-box;">(W)*';
			html += '		    	<input type="text" class="text-end p-0" style="width: 33%; border: none; font-size: 12px !important; box-sizing: border-box;">(H)';
			html += '		  	</div>';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">절단면은 박리 현상 유무</td>';
			html += '		<td colspan="5" class="fs-12 text-start align-middle text-nowrap">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>'; //가로 길이 유지를 위한 공백 부여
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle ">3)도안번호</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle " name="testItemVersion"></td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">도안번호 확인</td>';
			html += '		<td colspan="5" class="fs-12 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle ">4)색 상</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle " name="testItemColor"></td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">지정 색도와 일치하는가?</td>';
			html += '		<td colspan="5" class="fs-12 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle ">5)표시사항</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">기준 견본</td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">문자, 글꼴등 견본과 일치하는가?</td>';
			html += '		<td colspan="5" class="fs-12 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" rowspan="3" class="fs-12 text-start align-middle ">6)인쇄 상태</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">문안 부위</td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">1㎟ 미만의 점이 3개이내인가?</td>';
			html += '		<td colspan="5" class="fs-12 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">문안 외 부위</td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">1㎟ 미만의 점이 5개이내인가?</td>';
			html += '		<td colspan="5" class="fs-12 text-start align-middle ">결과 : 정확, 부정확, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">인쇄 전체</td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">이중인쇄 인쇄번짐이 없는가?</td>';
			html += '		<td colspan="5" class="fs-12 text-start align-middle ">결과 : 정확, 부정확, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			//html += '	<tr>';
			//html += '		<td colspan="3" class="bd-n"></td>';
			//html += '		<td colspan="3" class="bg-gray fs-12 text-start align-middle ">7)바코드</td>';
			//html += '		<td colspan="7" class="fs-12 text-center align-middle ">기준 견본</td>';
			//html += '		<td colspan="9" class="fs-10 text-start align-middle ">정확하게 읽혀야 한다.</td>';
			//html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 양호, 부정확, 미적용</td>';
			//html += '		<td colspan="3" class="bd-n"></td>';
			//html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle ">7)코팅</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle " name="testCoatingMethod"></td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">코팅상태가 깨끗하여야한다.</td>';
			html += '		<td colspan="5" class="fs-12 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			//html += '	<tr>';
			//html += '		<td colspan="3" class="bd-n"></td>';
			//html += '		<td colspan="7" class="fs-12 text-center align-middle ">라미네이팅시 표면 접착강도</td>';
			//html += '		<td colspan="9" class="fs-10 text-start align-middle ">테이프시험시 인쇄가 떨어지지 않는다.</td>';
			//html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			//html += '		<td colspan="3" class="bd-n"></td>';
			//html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" rowspan="2" class="fs-12 text-start align-middle ">8)접착면</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">내부 규정 범위</td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">접착 과다 및 위치 여부</td>';
			html += '		<td colspan="5" class="fs-12 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">내부 규정 범위</td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">접착 후 조립 이상 유무</td>';
			html += '		<td colspan="5" class="fs-12 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle ">9)라벨</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">내부 규정 범위</td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">라벨 표기사항 부착 여부</td>';
			html += '		<td colspan="5" class="fs-12 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle ">10)포장</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">내부 규정 범위</td>';
			html += '		<td colspan="9" class="fs-12 text-start align-middle ">내용물이 안보이게 포장되었는가?</td>';
			html += '		<td colspan="5" class="fs-12 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="30" class="bd-n h-20"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="5" class="fs-15 text-start align-middle  br-n">특기사항 기록란</td>';
			html += '		<td colspan="19" class="fs-15 text-start align-middle  bl-n bb-n">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			//html += '	<tr>';
			//html += '		<td colspan="3" class="bd-n"></td>';
			//html += '		<td colspan="24" class="text-start align-middle  bb-n bt-n">';
			//html += '			<input type="text" class="text-start p-0 fs-15" style="border:none !important;max-width:600px;min-width:600px;">';
			//html += '		</td>';
			//html += '		<td colspan="3" class="bd-n"></td>';
			//html += '	</tr>';
			//html += '	<tr>';
			//html += '		<td colspan="3" class="bd-n"></td>';
			//html += '		<td colspan="5" class="fs-15 text-start align-middle  bt-n br-n">유효일자</td>';
			//html += '		<td colspan="19" class="fs-15 text-start align-middle  bt-n bl-n bb-n"></td>';
			//html += '		<td colspan="3" class="bd-n"></td>';
			//html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="24" class="text-start align-middle bb-n bt-n ">';
			html += '			<textarea rows="6" name="issueDesc" class="form-control text-start p-0 fs-15" style="resize: none;overflow:hidden;border:none !important;max-width:600px;min-width:600px;"></textarea>';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="24" class="text-center align-middle bt-n fw200 fs-8" name="fscTd">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '';		
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="fs-15 text-start align-middle bd-n">시험자 : </td>';
			html += '		<td colspan="8" class="fs-15 text-start align-middle bd-n" >';
			html += '			<input name="judUserName" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="7" class="fs-15 text-end align-middle bd-n">(일자 : </td>';
			html += '		<td colspan="5" class="fs-15 text-start align-middle bd-n">';
			html += '			<input name="judgmentDate" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="fs-15 text-start align-middle bd-n">판정자 : </td>';
			html += '		<td colspan="8" class="fs-15 text-start align-middle bd-n">';
			html += '			<input name="conUserName" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="7" class="fs-15 text-end align-middle bd-n">(일자 : </td>';
			html += '		<td colspan="5" class="fs-15 text-start align-middle bd-n" >';
			html += '			<input name="confirmDate" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="fs-15 text-start align-middle bd-n">판정결과 : </td>';
			html += '		<td colspan="20" class="fs-15 text-start align-middle bd-n" >';
			html += '			<input name="qualityJudgmentNm" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="30" class="bd-n h-20"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="24" class="fs-15 text-start align-middle bd-n">';
			html += '			<input value="문서번호 : 시험성적서 5-190910-03" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
		} else if(paperType == '07'){
			//대웅제약 오송
			html += '	<tr style="page-break-before: always!important;">';
			html += '		<td class="bd-n h-25" colspan="30">';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n max-h75 h-75"></td>';
			html += '		<td colspan="13" class="text-center max-h75 h-75 bd2px align-middle bt-n bl-n br-n">';
			html += '			<img src="/resources/assets/images/header_logo.png" style="width:70%;height:100%;">';
			html += '		</td>';
			html += '		<td colspan="11" class="bt-n bl-n br-n max-h70 bd2px fs-12" style="height:100%!important;">';
			html += '			㈜ 창영테크팩<br>';
			html += '			주소 : 경기도 수원시 권선구 산업로 156번길 88-39<br>';
			html += '			Tel : 031-292-6553<br>';
			html += '			Fax : 031-292-6507';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n max-h75 h-75"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td class="bd-n h-15" colspan="30">';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="8" class="bd-n"></td>';
			html += '		<td colspan="14" class="fs-30 fw900 bd2px text-center bt-n bl-n br-n">자&nbsp;&nbsp;재&nbsp;&nbsp;시&nbsp;&nbsp;험&nbsp;&nbsp;성&nbsp;&nbsp;적&nbsp;&nbsp;서</td>';
			html += '		<td colspan="8" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="12" class="fs-20 fw900 bd2px text-center bt-n bl-n br-n" name="purchaseCustomerNm"></td>';
			html += '		<td colspan="15" class="fs-20 fw900 bd2px bd-n">貴中</td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="30" class="bd-n h-10"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">제 품 명</td>';
			html += '		<td colspan="21" class="fs-12 text-center align-middle " name="testItemNm"></td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">제조일자</td>';
			html += '		<td colspan="6" class="bg-gray fs-12 text-center align-middle ">';
			html += '			<input name="workDate" type="text" class="bg-gray text-center p-0 fs-15" style="border:none !important;max-width:70px">';
			html += '		</td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">제조번호</td>';
			html += '		<td colspan="12" class="bg-gray fs-12 text-center align-middle " name="bizOrdDtlNo"></td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">검사일자</td>';
			html += '		<td colspan="6" class="bg-gray fs-12 text-center align-middle " >';
			html += '			<input name="testJudgmentDate" type="text" class="bg-gray text-center p-0 " style="border:none !important;max-width:70px;">';
			html += '		</td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">도안번호</td>';
			html += '		<td colspan="12" class="fs-12 text-center align-middle " name="itemVersion"></td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">재질명</td>';
			html += '		<td colspan="6" class="fs-12 text-center align-middle " name="paperType"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">입고수량</td>';
			html += '		<td colspan="12" class="bg-gray fs-12 text-center align-middle " >';
			html += '			<input name="quailtyPassQty" type="text" class="bg-gray text-center p-0 " style="border:none !important;max-width:200px;min-width:200px;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">원판 수량</td>';
			html += '		<td colspan="6" class="fs-12 text-center align-middle " name="eaQty"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">포장방법</td>';
			html += '		<td colspan="2" class="fs-12 text-center align-middle ">내부</td>';
			html += '		<td colspan="4" class="fs-12 text-center align-middle " name="inPackMethod"></td>';
			html += '		<td colspan="2" class="fs-12 text-center align-middle ">외부</td>';
			html += '		<td colspan="4" class="fs-12 text-center align-middle " name="outPackMethod"></td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">코팅</td>';
			html += '		<td colspan="6" class="fs-12 text-center align-middle " name="coatingMethod"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">색 상</td>';
			html += '		<td colspan="12" class="fs-12 text-center align-middle " name="itemColor"></td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">성형방식</td>';
			html += '		<td colspan="6" class="fs-12 text-center align-middle " name="moldingMethod"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">보관조건</td>';
			html += '		<td colspan="12" class="fs-12 text-center align-middle ">온도 : 실온( 1 ~ 30℃ )</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="30" class="bd-n h-10"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-center align-middle ">시험항목</td>';
			html += '		<td colspan="7" class="br-n fs-12 text-center align-middle ">기준</td>';
			html += '		<td colspan="9" class="bl-n br-n fs-12 text-center align-middle ">검사내용</td>';
			html += '		<td colspan="5" class="bl-n fs-12 text-center align-middle ">시험결과</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle ">1)재질</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle " name="testPaperType"></td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">기준과 실제 생산용</td>';
			html += '		<td colspan="1" class="fs-10 text-start align-middle br-n">재질 :</td>';
			html += '		<td colspan="3" class="fs-10 text-start align-middle bl-n br-n" style="width: 100%;">';
			html += '			<input type="text" class="text-end p-0" style="width: 100%; border: none; font-size: 10px !important; box-sizing: border-box;">';
			html += '		</td>';
			html += '		<td colspan="1" class="fs-10 text-start align-middle bl-n">㎡</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" rowspan="2" class="fs-12 text-start align-middle ">2)규격</td>';
			html += '		<td colspan="7" rowspan="2" class="fs-12 text-center align-middle " name="testSizeXY"></td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">정확한 자로 규격을 측정한다<sub style="font-size:6px!important;transform: translate(-8%, -50%) scale(0.8);display: inline-block;">(오차범위±1mm)</sub></td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle" style="width: 100%;">';
			html += '			<div style="display: flex; width: 100%;">';
			html += '		    	<input type="text" class="text-end p-0" style="width: 34%; border: none; font-size: 10px !important; box-sizing: border-box;">(L)*';
			html += '		    	<input type="text" class="text-end p-0" style="width: 33%; border: none; font-size: 10px !important; box-sizing: border-box;">(W)*';
			html += '		    	<input type="text" class="text-end p-0" style="width: 33%; border: none; font-size: 10px !important; box-sizing: border-box;">(H)';
			html += '		  	</div>';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">재단면 또는 톰슨은 완벽한가</td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle text-nowrap">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>'; //가로 길이 유지를 위한 공백 부여
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle ">3)도안번호</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle " name="testItemVersion"></td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">도안번호 확인</td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 정확, 부정확, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle ">4)색 상</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle " name="testItemColor"></td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">지정 색도와 일치하는가를 확인</td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle ">5)표시사항</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">기준 견본</td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">문자, 글꼴등 견본과 일치하는가?</td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" rowspan="3" class="fs-12 text-start align-middle ">6)인쇄 상태</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">문안 부위</td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">1㎟ 미만의 점이 3개이내인가?</td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">문안 외 부위</td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">1㎟ 미만의 점이 5개이내인가?</td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">인쇄 전체</td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">이중인쇄 인쇄번짐이 없는가?</td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="bg-gray fs-12 text-start align-middle ">7)바코드</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">기준 견본</td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">정확하게 읽혀야 한다.</td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 정확, 부정확, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" rowspan="2" class="bg-gray fs-12 text-start align-middle ">8)코팅</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle " name="testCoatingMethod"></td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">코팅상태가 깨끗하여야한다.</td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">라미네이팅시 표면 접착강도</td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">테이프시험시 인쇄가 떨어지지 않는다.</td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="bg-gray fs-12 text-start align-middle ">9)접착면</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">내부 규정 범위</td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">접착 품질 확인</td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle ">10)외관</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">내부 규정 범위</td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">손상, 파손등의 확인</td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle ">11)라벨</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">내부 규정 범위</td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">라벨 표기사항 부착 여부</td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="3" class="fs-12 text-start align-middle ">12)포장</td>';
			html += '		<td colspan="7" class="fs-12 text-center align-middle ">내부 규정 범위</td>';
			html += '		<td colspan="9" class="fs-10 text-start align-middle ">Tapping 상태</td>';
			html += '		<td colspan="5" class="fs-10 text-start align-middle ">결과 : 양호, 보통&nbsp;&nbsp;&nbsp;, 미적용</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="30" class="bd-n h-10"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="5" class="fs-15 text-start align-middle  br-n">특기사항 기록란</td>';
			html += '		<td colspan="19" class="fs-15 text-start align-middle  bl-n bb-n">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="24" class="text-start align-middle  bb-n bt-n">';
			html += '			<input type="text" class="text-start p-0 fs-15" style="border:none !important;max-width:600px;min-width:600px;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="5" class="fs-15 text-start align-middle  bt-n br-n">유효일자</td>';
			html += '		<td colspan="19" class="fs-15 text-start align-middle  bt-n bl-n bb-n"></td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="24" class="text-start align-middle bb-n bt-n ">';
			html += '			<input name="effDate" type="text" class="text-start p-0 fs-15" style="border:none !important;max-width:600px;min-width:600px;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="24" class="text-center align-middle bt-n fw200 fs-8" name="fscTd">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '';		
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="fs-15 text-start align-middle bd-n">시험자 : </td>';
			html += '		<td colspan="8" class="fs-15 text-start align-middle bd-n" >';
			html += '			<input name="judUserName" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="7" class="fs-15 text-end align-middle bd-n">(일자 : </td>';
			html += '		<td colspan="5" class="fs-15 text-start align-middle bd-n">';
			html += '			<input name="judgmentDate" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="fs-15 text-start align-middle bd-n">판정자 : </td>';
			html += '		<td colspan="8" class="fs-15 text-start align-middle bd-n">';
			html += '			<input name="conUserName" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="7" class="fs-15 text-end align-middle bd-n">(일자 : </td>';
			html += '		<td colspan="5" class="fs-15 text-start align-middle bd-n" >';
			html += '			<input name="confirmDate" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="4" class="fs-15 text-start align-middle bd-n">판정결과 : </td>';
			html += '		<td colspan="20" class="fs-15 text-start align-middle bd-n" >';
			html += '			<input name="qualityJudgmentNm" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="14" class="fs-15 text-start align-middle bd-n"></td>';
			html += '		<td colspan="10" class="fs-15 text-start align-middle bd-n">㈜ 창영테크팩    최 재 성';
			html += '			<img src="/resources/assets/images/ceo_sign.png" style="width:35%;height:100%;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
			html += '	<tr>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '		<td colspan="24" class="fs-15 text-start align-middle bd-n">';
			html += '			<input value="문서번호 : 시험성적서 2-190910-03" type="text" class="text-start p-0 " style="border:none !important;width:100%;font-size:15px!important;">';
			html += '		</td>';
			html += '		<td colspan="3" class="bd-n"></td>';
			html += '	</tr>';
		}
		return html;

	}

	//성적서
	function paperCreate(){
		setTimeout(function(){
			let checkObj = $('input[name=checkBox]:checked');
			let checkNodeCnt = checkObj.length;
			$('#qualityReportTable').find('tr').remove();
			if( checkNodeCnt > 0 ){
				//0보다 클경우 성적서를 만들고 해당값 넣어줘야함
				for( var i = 0; i < checkNodeCnt ; i++){
					$('#trAppendTarget').after(makeEmptyTr($('#qualityReportSelect').val()));
					
				}
			} else {
				//0보다 큰 경우가 아닐 경우 빈 성적서만 만들어주면됨
				$('#trAppendTarget').after(makeEmptyTr($('#qualityReportSelect').val()));
				
			}
			checkObj.each(function(index,item){
				let tr = $(item).parent().parent().parent();
				let data = qualityEndItemTable.row(tr).data();

				//FSC가 사용인 품목이면 품명 앞에 *표시 추가, 문구 보여주도록 수정 (2023.07.21)
				const itemNmVal = data.etc7 == 'Y' ? '* ' + data.itemNm : data.itemNm;
				if ( $('#qualityReportSelect').val() != '03' && data.etc7 == 'Y' ) {
					$('td[name=fscTd]').text('*표시된 제품은 ㈜창영테크팩에서 생산된 FSC인증 제품입니다. 인증번호: SGSHK-COC-340249 인증타입: FSC Mix Credit');
				} else {
					$('td[name=fscTd]').text('');
				}
				
				//명세서수량기준이 출고량이면 출고수량, 아니면 수주수량 보여주도록 수정 (2023.07.27)
				const quailtyPassQtyVal = data.statementStandard == '002' ? data.outQty : data.bizOrdQty;
				
				if($('#qualityReportSelect').val() == '00'){
					let bundleJson = JSON.parse(data.bundleJson);
					let PAC = '';
					let leaflet = '';
					if(!isEmptyCheck(bundleJson)){
						PAC = bundleJson.filter(v=> v.ITEM_NM.includes('PAC'));
						leaflet = bundleJson.filter(v=> !v.ITEM_NM.includes('PAC'));
						let bundleInfoTrHtml = '';
						let bundlePackInfoTrHtml = '';
						let bundleCntCheckTrHtml = '';
						
						const itemNmArray = []; //Bundling Packet 조합 값들을 넣는 배열
						
						//PAC
						for(var i = 0; i < PAC.length; i++){
							bundleInfoTrHtml += '<tr>';
							bundleInfoTrHtml += '<td colspan="3" class="bd-n"></td>';
							bundleInfoTrHtml += '<td colspan="3" class="fs-12 text-center align-middle">Pac card</td>';
							bundleInfoTrHtml += '<td colspan="11" class="fs-10 text-center align-middle">'+PAC[i].ITEM_NM+'</td>';
							bundleInfoTrHtml += '<td colspan="2" class="bg-gray fs-10 text-center align-middle">'+PAC[i].BIZ_ORD_DTL_NO+'</td>';
							bundleInfoTrHtml += '<td colspan="4" class="fs-10 text-center align-middle">'+PAC[i].CUSTOMER_ITEM_CD+'</td>';
							bundleInfoTrHtml += '<td colspan="4" class="fs-10 text-center align-middle">'+PAC[i].ITEM_VERSION+'</td>';
							bundleInfoTrHtml += '</tr>';
							
							bundleCntCheckTrHtml += '<tr>';
							bundleCntCheckTrHtml += '<td colspan="3" class="bd-n"></td>';
							if(i==0){
								let rowspanVal = PAC.length + leaflet.length + 1;
								bundleCntCheckTrHtml += '<td rowspan="'+rowspanVal+'" colspan="6" class="fs-10 text-center align-middle " name="">수량 기록</td>';
							}
							bundleCntCheckTrHtml += '<td colspan="7" class="fs-10 text-start align-middle ">PAC Card</td>';
							bundleCntCheckTrHtml += '<td colspan="7" class="bg-gray fs-10 text-start align-middle ">'+addCommas(parseInt(data.workFairQty)) + 'Ea' +'</td>';
							bundleCntCheckTrHtml += '</tr>';
							
							itemNmArray.push(PAC[i].ITEM_NM);
						}
						//leaflet
						for(var i = 0; i < leaflet.length; i++ ){
							bundleInfoTrHtml += '<tr>';
							bundleInfoTrHtml += '<td colspan="3" class="bd-n"></td>';
							bundleInfoTrHtml += '<td colspan="3" class="fs-12 text-center align-middle">leaflet '+(i+1)+'</td>';
							bundleInfoTrHtml += '<td colspan="11" class="fs-10 text-center align-middle">'+leaflet[i].ITEM_NM+'</td>';
							bundleInfoTrHtml += '<td colspan="2" class="bg-gray fs-10 text-center align-middle">'+leaflet[i].BIZ_ORD_DTL_NO+'</td>';
							bundleInfoTrHtml += '<td colspan="4" class="fs-10 text-center align-middle">'+leaflet[i].CUSTOMER_ITEM_CD+'</td>';
							bundleInfoTrHtml += '<td colspan="4" class="fs-10 text-center align-middle">'+leaflet[i].ITEM_VERSION+'</td>';
							bundleInfoTrHtml += '</tr>';


							bundleCntCheckTrHtml += '<tr>';
							bundleCntCheckTrHtml += '<td colspan="3" class="bd-n"></td>';
							if(i==0 && PAC.length == 0){
								let rowspanVal = PAC.length + leaflet.length + 1;
								bundleCntCheckTrHtml += '<td rowspan="'+rowspanVal+'" colspan="6" class="fs-10 text-center align-middle " name="">수량 기록</td>';
							}
							bundleCntCheckTrHtml += '<td colspan="7" class="fs-10 text-start align-middle ">leaflet '+ (i+1) +'</td>';
							bundleCntCheckTrHtml += '<td colspan="7" class="bg-gray fs-10 text-start align-middle ">'+addCommas(parseInt(data.workFairQty)) + 'Ea' +'</td>';
							bundleCntCheckTrHtml += '</tr>';
							
							itemNmArray.push(leaflet[i].ITEM_NM);
						}
						//Pack조합 및 Pharmacode
						for(var i = 0; i < PAC.length + leaflet.length - 1; i++ ){
							bundlePackInfoTrHtml += '<tr>';
							bundlePackInfoTrHtml += '<td colspan="3" class="bd-n"></td>';
							bundlePackInfoTrHtml += `<td colspan="6" class="h-20 fs-12 text-center align-middle " name="itemNmTd\${i+1}"></td>`;
							bundlePackInfoTrHtml += '<td colspan="3" class="bd-n"></td>';
							bundlePackInfoTrHtml += '</tr>';
						}
						
						bundleCntCheckTrHtml += '<tr>';
						bundleCntCheckTrHtml += '<td colspan="3" class="bd-n"></td>';
						bundleCntCheckTrHtml += '<td colspan="7" class="fs-10 text-start align-middle ">Bundle</td>';
						bundleCntCheckTrHtml += '<td colspan="7" class="bg-gray fs-10 text-start align-middle ">' + addCommas(parseInt(data.workFairQty)) + 'Ea' +'</td>';
						bundleCntCheckTrHtml += '</tr>';
						
						let bundlePackTr = $('.bundlePackInfoTr')[index];
						let bundlePharmacodeTr = $('.bundlePharmacodeTr')[index];
						let bundleCntCheckTr = $('.bundleCntCheckTr')[index];
						
						//행추가
						$($('.bundleInfoTr')[index]).after(bundleInfoTrHtml);
						$(bundlePackTr).after(bundlePackInfoTrHtml);
						$(bundlePharmacodeTr).after(bundlePackInfoTrHtml);
						$(bundleCntCheckTr).next().after(bundleCntCheckTrHtml);
						
						//값 할당
						for (let i = 0; i < itemNmArray.length; i++) {
							$(`td[name="itemNmTd\${i}"]`).text(itemNmArray[i]);
						}

						//행 합치기
						$(bundlePackTr).find('td').filter('.rowMerge').attr('rowspan', (PAC.length + leaflet.length));
						$(bundlePharmacodeTr).find('td').filter('.rowMerge').attr('rowspan', (PAC.length + leaflet.length));
						$(bundleCntCheckTr).find('td').filter('.rowMerge').attr('rowspan', (PAC.length + leaflet.length + 3));					
						
						//번들링성적서
						$($('[name=purchaseCustomerNm]')[index]).text(data.bizOrdDealCorpInitial);//고객사
						$($('[name=testItemNm]')[index]).text(itemNmVal);//제품명
						$($('[name=workDate]')[index]).val(moment(data.workDate).format('YYYY-MM-DD'));//제조일자
						$($('[name=bizOrdDtlNo]')[index]).text(data.bizOrdDtlNo);//제조번호
						$($('[name=testJudgmentDate]')[index]).val(moment().format('YYYY-MM-DD'));//검사일자
						let customerItemCd = isEmptyCheck(data.customerItemCd) ? '' : data.customerItemCd;
						$($('[name=quailtyPassQty]')[index]).val(addCommas(parseFloat(quailtyPassQtyVal)));//입고수량
						let bundleMethodNm = isEmptyCheck(data.bundleMethodNm) ? '' : data.bundleMethodNm;

						$($('[name=bundleUnit]')[index]).text(data.bundleUnit); //내부포장방법
						$($('[name=bundleMethodNm]')[index]).text(bundleMethodNm); //내부포장방법
						$($('[name=packMethodNm]')[index]).text(data.packMethodNm); //외부포장방법
						
						$($('[name=judUserName]')[index]).val(testContentsList['시험자']);//시험자
						$($('[name=judgmentDate]')[index]).val(moment(data.judgmentDate).format('YYYY.MM.DD)'));//시험일자
						$($('[name=conUserName]')[index]).val(testContentsList['판정자']);//판정자
						$($('[name=confirmDate]')[index]).val(moment(data.confirmDate).format('YYYY.MM.DD)'));//판정일자
						$($('[name=qualityJudgmentNm]')[index]).val(data.qualityJudgmentNm);//판정결과
						
					}
				} else if($('#qualityReportSelect').val() == '01'){
					//시험성적서
					$($('[name=purchaseCustomerNm]')[index]).text(data.bizOrdDealCorpInitial);//고객사
					$($('[name=testItemNm]')[index]).text(itemNmVal);//제품명
					$($('[name=workDate]')[index]).val(moment(data.workDate).format('YYYY-MM-DD'));//제조일자
					$($('[name=bizOrdDtlNo]')[index]).text(data.bizOrdDtlNo);//제조번호
					$($('[name=testJudgmentDate]')[index]).val(moment().format('YYYY-MM-DD'));//검사일자
					let customerItemCd = isEmptyCheck(data.customerItemCd) ? '' : data.customerItemCd;
					$($('[name=itemVersion]')[index]).text(customerItemCd + ' / ' + data.itemVersion);//도안번호
					$($('[name=paperType]')[index]).text(data.paperType);//재질명
					$($('[name=quailtyPassQty]')[index]).val(addCommas(parseFloat(quailtyPassQtyVal)));//입고수량
					$($('[name=eaQty]')[index]).text(addCommas(parseFloat(data.eaQty)));//원판수량
					let bundleMethodNm = isEmptyCheck(data.bundleMethodNm) ? '' : data.bundleMethodNm;
					$($('[name=inPackMethod]')[index]).text(data.bundleUnit + ' / ' + bundleMethodNm);//포장방법 내부
					$($('[name=outPackMethod]')[index]).text(data.packMethodNm);//포장방법 외부
					$($('[name=coatingMethod]')[index]).text(data.coatingMethod);//코팅
					$($('[name=itemColor]')[index]).text(data.itemColor);//색상
					$($('[name=moldingMethod]')[index]).text(data.moldingMethod);//성형방식
		
		
					$($('[name=testPaperType]')[index]).text(data.paperType);//재질명
					//$('[name=testSizeXY').text(data.sizeX +'*'+data.sizeY);//규격
					$($('[name=testSizeXY]')[index]).text(data.itemSize); //규격
					$($('[name=testItemVersion]')[index]).text(data.itemVersion);//도안번호
					$($('[name=testItemColor]')[index]).text(data.itemColor);//색상
					$($('[name=testCoatingMethod]')[index]).text(data.coatingMethod);//코팅
		
					$($('[name=judUserName]')[index]).val(testContentsList['시험자']);//시험자
					$($('[name=judgmentDate]')[index]).val(moment(data.judgmentDate).format('YYYY.MM.DD)'));//시험일자
					$($('[name=conUserName]')[index]).val(testContentsList['판정자']);//판정자
					$($('[name=confirmDate]')[index]).val(moment(data.confirmDate).format('YYYY.MM.DD)'));//판정일자
					$($('[name=qualityJudgmentNm]')[index]).val(data.qualityJudgmentNm);//판정결과
					
				} else if($('#qualityReportSelect').val() == '02'){
					//셀트리온 시험성적서
					$($('[name=purchaseCustomerNm]')[index]).text(data.bizOrdDealCorpInitial);//고객사
					$($('[name=testItemNm]')[index]).text(itemNmVal);//제품명
					$($('[name=workDate]')[index]).val(moment(data.workDate).format('YYYY-MM-DD'));//제조일자
					$($('[name=bizOrdDtlNo]')[index]).text(data.bizOrdDtlNo);//제조번호
					$($('[name=testJudgmentDate]')[index]).val(moment().format('YYYY-MM-DD'));//검사일자
					let customerItemCd = isEmptyCheck(data.customerItemCd) ? '' : data.customerItemCd;
					$($('[name=itemVersion]')[index]).text(customerItemCd + ' / ' + data.itemVersion);//도안번호
					$($('[name=paperType]')[index]).text(data.paperType);//재질명
					$($('[name=quailtyPassQty]')[index]).val(addCommas(parseFloat(quailtyPassQtyVal)));//입고수량
					$($('[name=eaQty]')[index]).text(addCommas(parseFloat(data.eaQty)));//원판수량
					let bundleMethodNm = isEmptyCheck(data.bundleMethodNm) ? '' : data.bundleMethodNm;
					$($('[name=inPackMethod]')[index]).text(data.bundleUnit + ' / ' + bundleMethodNm);//포장방법 내부
					$($('[name=outPackMethod]')[index]).text(data.packMethodNm);//포장방법 외부
					$($('[name=coatingMethod]')[index]).text(data.coatingMethod);//코팅
					$($('[name=itemColor]')[index]).text(data.itemColor);//색상
					$($('[name=moldingMethod]')[index]).text(data.moldingMethod);//성형방식
		
		
					$($('[name=testPaperType]')[index]).text(data.paperType);//재질명
					//$('[name=testSizeXY').text(data.sizeX +'*'+data.sizeY);//규격
					$($('[name=testSizeXY]')[index]).text(data.itemSize); //규격
					$($('[name=testItemVersion]')[index]).text(data.itemVersion);//도안번호
					$($('[name=testItemColor]')[index]).text(data.itemColor);//색상
					$($('[name=testCoatingMethod]')[index]).text(data.coatingMethod);//코팅
		
					$($('[name=judUserName]')[index]).val(testContentsList['시험자']);//시험자
					$($('[name=judgmentDate]')[index]).val(moment(data.judgmentDate).format('YYYY.MM.DD)'));//시험일자
					$($('[name=conUserName]')[index]).val(testContentsList['판정자']);//판정자
					$($('[name=confirmDate]')[index]).val(moment(data.confirmDate).format('YYYY.MM.DD)'));//판정일자
					$($('[name=qualityJudgmentNm]')[index]).val(data.qualityJudgmentNm);//판정결과
					$($('[name=qualityResult]')[index]).val(data.qualityJudgmentNm);//판정결과

					let issueDesc = isEmptyCheck(data.etc1Nm) ? '' : (data.etc1Nm+' 호기');
					
					$($('[name=issueDesc]')[index]).val(issueDesc);//특기사항 기록란
				}  else if($('#qualityReportSelect').val() == '03'){
					//셀트리온 시험성적서-영문
					$($('[name=purchaseCustomerNm]')[index]).text(data.bizOrdDealCorpInitial);//고객사
					$($('[name=testItemNm]')[index]).text(itemNmVal);//제품명
					$($('[name=workDate]')[index]).val(moment(data.workDate).format('YYYY-MM-DD'));//제조일자
					$($('[name=bizOrdDtlNo]')[index]).text(data.bizOrdDtlNo);//제조번호
					$($('[name=testJudgmentDate]')[index]).val(moment().format('YYYY-MM-DD'));//검사일자
					let customerItemCd = isEmptyCheck(data.customerItemCd) ? '' : data.customerItemCd;
					$($('[name=itemVersion]')[index]).text(customerItemCd + ' / ' + data.itemVersion);//도안번호
					$($('[name=paperType]')[index]).text(data.paperType);//재질명
					$($('[name=quailtyPassQty]')[index]).val(addCommas(parseFloat(quailtyPassQtyVal)));//입고수량
					$($('[name=eaQty]')[index]).text(addCommas(parseFloat(data.eaQty)));//원판수량
					let bundleMethodNm = isEmptyCheck(data.bundleMethodNm) ? '' : data.bundleMethodNm;
					$($('[name=inPackMethod]')[index]).text(data.bundleUnit + ' / ' + bundleMethodNm);//포장방법 내부
					$($('[name=outPackMethod]')[index]).text(data.packMethodNm);//포장방법 외부
					$($('[name=coatingMethod]')[index]).text(data.coatingMethod);//코팅
					$($('[name=itemColor]')[index]).text(data.itemColor);//색상
					$($('[name=moldingMethod]')[index]).text(data.moldingMethod);//성형방식
		
		
					$($('[name=testPaperType]')[index]).text(data.paperType);//재질명
					//$('[name=testSizeXY').text(data.sizeX +'*'+data.sizeY);//규격
					$($('[name=testSizeXY]')[index]).text(data.itemSize); //규격
					$($('[name=testItemVersion]')[index]).text(data.itemVersion);//도안번호
					$($('[name=testItemColor]')[index]).text(data.itemColor);//색상
					$($('[name=testCoatingMethod]')[index]).text(data.coatingMethod);//코팅
		
					$($('[name=judUserName]')[index]).val(testContentsList['시험자']);//시험자
					$($('[name=judgmentDate]')[index]).val(moment(data.judgmentDate).format('YYYY.MM.DD)'));//시험일자
					$($('[name=conUserName]')[index]).val(testContentsList['판정자']);//판정자
					$($('[name=confirmDate]')[index]).val(moment(data.confirmDate).format('YYYY.MM.DD)'));//판정일자
					$($('[name=qualityJudgmentNm]')[index]).val(data.qualityJudgmentNm);//판정결과
					$($('[name=qualityResult]')[index]).val(data.qualityJudgmentNm);//판정결과

					//let issueDesc = isEmptyCheck(data.etc1Nm) ? '' : (data.etc1Nm+' 호기');
					
					//$($('[name=issueDesc]')[index]).val(issueDesc);//특기사항 기록란
				} else if($('#qualityReportSelect').val() == '04'){
					//셀트리온 제약 오창,한독 성적서
					$($('[name=purchaseCustomerNm]')[index]).text(data.bizOrdDealCorpInitial);//고객사
					$($('[name=testItemNm]')[index]).text(itemNmVal);//제품명
					$($('[name=workDate]')[index]).val(moment(data.workDate).format('YYYY-MM-DD'));//제조일자
					$($('[name=bizOrdDtlNo]')[index]).text(data.bizOrdDtlNo);//제조번호
					$($('[name=testJudgmentDate]')[index]).val(moment().format('YYYY-MM-DD'));//검사일자
					let customerItemCd = isEmptyCheck(data.customerItemCd) ? '' : data.customerItemCd;
					$($('[name=itemVersion]')[index]).text(customerItemCd + ' / ' + data.itemVersion);//도안번호
					$($('[name=paperType]')[index]).text(data.paperType);//재질명
					$($('[name=quailtyPassQty]')[index]).val(addCommas(parseFloat(quailtyPassQtyVal)));//입고수량
					$($('[name=eaQty]')[index]).text(addCommas(parseFloat(data.eaQty)));//원판수량
					let bundleMethodNm = isEmptyCheck(data.bundleMethodNm) ? '' : data.bundleMethodNm;
					$($('[name=inPackMethod]')[index]).text(data.bundleUnit + ' / ' + bundleMethodNm);//포장방법 내부
					$($('[name=outPackMethod]')[index]).text(data.packMethodNm);//포장방법 외부
					$($('[name=coatingMethod]')[index]).text(data.coatingMethod);//코팅
					$($('[name=itemColor]')[index]).text(data.itemColor);//색상
					$($('[name=moldingMethod]')[index]).text(data.moldingMethod);//성형방식
		
		
					$($('[name=testPaperType]')[index]).text(data.paperType);//재질명
					//$('[name=testSizeXY').text(data.sizeX +'*'+data.sizeY);//규격
					$($('[name=testSizeXY]')[index]).text(data.itemSize); //규격
					$($('[name=testItemVersion]')[index]).text(data.itemVersion);//도안번호
					$($('[name=testItemColor]')[index]).text(data.itemColor);//색상
					$($('[name=testCoatingMethod]')[index]).text(data.coatingMethod);//코팅
		
					$($('[name=judUserName]')[index]).val(testContentsList['시험자']);//시험자
					$($('[name=judgmentDate]')[index]).val(moment(data.judgmentDate).format('YYYY.MM.DD)'));//시험일자
					$($('[name=conUserName]')[index]).val(testContentsList['판정자']);//판정자
					$($('[name=confirmDate]')[index]).val(moment(data.confirmDate).format('YYYY.MM.DD)'));//판정일자
					$($('[name=qualityJudgmentNm]')[index]).val(data.qualityJudgmentNm);//판정결과
					
				} else if($('#qualityReportSelect').val() == '05'){
					//명인시험 성적서
					$($('[name=purchaseCustomerNm]')[index]).text(data.bizOrdDealCorpInitial);//고객사
					$($('[name=testItemNm]')[index]).text(itemNmVal);//제품명
					$($('[name=workDate]')[index]).val(moment(data.workDate).format('YYYY-MM-DD'));//제조일자
					$($('[name=bizOrdDtlNo]')[index]).text(data.bizOrdDtlNo);//제조번호
					$($('[name=testJudgmentDate]')[index]).val(moment().format('YYYY-MM-DD'));//검사일자
					let customerItemCd = isEmptyCheck(data.customerItemCd) ? '' : data.customerItemCd;
					$($('[name=itemVersion]')[index]).text(customerItemCd + ' / ' + data.itemVersion);//도안번호
					$($('[name=paperType]')[index]).text(data.paperType);//재질명
					$($('[name=quailtyPassQty]')[index]).val(addCommas(parseFloat(quailtyPassQtyVal)));//입고수량
					$($('[name=eaQty]')[index]).text(addCommas(parseFloat(data.eaQty)));//원판수량
					let bundleMethodNm = isEmptyCheck(data.bundleMethodNm) ? '' : data.bundleMethodNm;
					$($('[name=inPackMethod]')[index]).text(data.bundleUnit + ' / ' + bundleMethodNm);//포장방법 내부
					$($('[name=outPackMethod]')[index]).text(data.packMethodNm);//포장방법 외부
					$($('[name=coatingMethod]')[index]).text(data.coatingMethod);//코팅
					$($('[name=itemColor]')[index]).text(data.itemColor);//색상
					$($('[name=moldingMethod]')[index]).text(data.moldingMethod);//성형방식
		
		
					$($('[name=testPaperType]')[index]).text(data.paperType);//재질명
					//$('[name=testSizeXY').text(data.sizeX +'*'+data.sizeY);//규격
					$($('[name=testSizeXY]')[index]).text(data.itemSize); //규격
					$($('[name=testItemVersion]')[index]).text(data.itemVersion);//도안번호
					$($('[name=testItemColor]')[index]).text(data.itemColor);//색상
					$($('[name=testCoatingMethod]')[index]).text(data.coatingMethod);//코팅
		
					$($('[name=judUserName]')[index]).val(testContentsList['시험자']);//시험자
					$($('[name=judgmentDate]')[index]).val(moment(data.judgmentDate).format('YYYY.MM.DD)'));//시험일자
					$($('[name=conUserName]')[index]).val(testContentsList['판정자']);//판정자
					$($('[name=confirmDate]')[index]).val(moment(data.confirmDate).format('YYYY.MM.DD)'));//판정일자
					$($('[name=qualityJudgmentNm]')[index]).val(data.qualityJudgmentNm);//판정결과
					$($('[name=qualityResult]')[index]).val(data.qualityJudgmentNm);//판정결과

					//let issueDesc = isEmptyCheck(data.etc1Nm) ? '' : (data.etc1Nm+' 호기');
					
					//$($('[name=issueDesc]')[index]).val(issueDesc);//특기사항 기록란
				} else if($('#qualityReportSelect').val() == '06'){
					//크리, 건일 성적서
					$($('[name=purchaseCustomerNm]')[index]).text(data.bizOrdDealCorpInitial);//고객사
					$($('[name=testItemNm]')[index]).text(itemNmVal);//제품명
					$($('[name=workDate]')[index]).val(moment(data.workDate).format('YYYY-MM-DD'));//제조일자
					$($('[name=bizOrdDtlNo]')[index]).text(data.bizOrdDtlNo);//제조번호
					$($('[name=testJudgmentDate]')[index]).val(moment().format('YYYY-MM-DD'));//검사일자
					let customerItemCd = isEmptyCheck(data.customerItemCd) ? '' : data.customerItemCd;
					$($('[name=itemVersion]')[index]).text(customerItemCd + ' / ' + data.itemVersion);//도안번호
					$($('[name=paperType]')[index]).text(data.paperType);//재질명
					$($('[name=quailtyPassQty]')[index]).val(addCommas(parseFloat(quailtyPassQtyVal)));//입고수량
					$($('[name=eaQty]')[index]).text(addCommas(parseFloat(data.eaQty)));//원판수량
					let bundleMethodNm = isEmptyCheck(data.bundleMethodNm) ? '' : data.bundleMethodNm;
					$($('[name=inPackMethod]')[index]).text(data.bundleUnit + ' / ' + bundleMethodNm);//포장방법 내부
					$($('[name=outPackMethod]')[index]).text(data.packMethodNm);//포장방법 외부
					$($('[name=coatingMethod]')[index]).text(data.coatingMethod);//코팅
					$($('[name=itemColor]')[index]).text(data.itemColor);//색상
					$($('[name=moldingMethod]')[index]).text(data.moldingMethod);//성형방식
		
		
					$($('[name=testPaperType]')[index]).text(data.paperType);//재질명
					//$('[name=testSizeXY').text(data.sizeX +'*'+data.sizeY);//규격
					$($('[name=testSizeXY]')[index]).text(data.itemSize); //규격
					$($('[name=testItemVersion]')[index]).text(data.itemVersion);//도안번호
					$($('[name=testItemColor]')[index]).text(data.itemColor);//색상
					$($('[name=testCoatingMethod]')[index]).text(data.coatingMethod);//코팅
		
					$($('[name=judUserName]')[index]).val(testContentsList['시험자']);//시험자
					$($('[name=judgmentDate]')[index]).val(moment(data.judgmentDate).format('YYYY.MM.DD)'));//시험일자
					$($('[name=conUserName]')[index]).val(testContentsList['판정자']);//판정자
					$($('[name=confirmDate]')[index]).val(moment(data.confirmDate).format('YYYY.MM.DD)'));//판정일자
					$($('[name=qualityJudgmentNm]')[index]).val(data.qualityJudgmentNm);//판정결과
					$($('[name=qualityResult]')[index]).val(data.qualityJudgmentNm);//판정결과

					//let issueDesc = isEmptyCheck(data.etc1Nm) ? '' : (data.etc1Nm+' 호기');
					
					//$($('[name=issueDesc]')[index]).val(issueDesc);//특기사항 기록란
				} else if($('#qualityReportSelect').val() == '07'){
					//대웅제약 오송
					$($('[name=purchaseCustomerNm]')[index]).text(data.bizOrdDealCorpInitial);//고객사
					$($('[name=testItemNm]')[index]).text(itemNmVal);//제품명
					$($('[name=workDate]')[index]).val(moment(data.workDate).format('YYYY-MM-DD'));//제조일자
					$($('[name=bizOrdDtlNo]')[index]).text(data.bizOrdDtlNo);//제조번호
					$($('[name=testJudgmentDate]')[index]).val(moment().format('YYYY-MM-DD'));//검사일자
					let customerItemCd = isEmptyCheck(data.customerItemCd) ? '' : data.customerItemCd;
					$($('[name=itemVersion]')[index]).text(customerItemCd + ' / ' + data.itemVersion);//도안번호
					$($('[name=paperType]')[index]).text(data.paperType);//재질명
					$($('[name=quailtyPassQty]')[index]).val(addCommas(parseFloat(quailtyPassQtyVal)));//입고수량
					$($('[name=eaQty]')[index]).text(addCommas(parseFloat(data.eaQty)));//원판수량
					let bundleMethodNm = isEmptyCheck(data.bundleMethodNm) ? '' : data.bundleMethodNm;
					$($('[name=inPackMethod]')[index]).text(data.bundleUnit + ' / ' + bundleMethodNm);//포장방법 내부
					$($('[name=outPackMethod]')[index]).text(data.packMethodNm);//포장방법 외부
					$($('[name=coatingMethod]')[index]).text(data.coatingMethod);//코팅
					$($('[name=itemColor]')[index]).text(data.itemColor);//색상
					$($('[name=moldingMethod]')[index]).text(data.moldingMethod);//성형방식
		
		
					$($('[name=testPaperType]')[index]).text(data.paperType);//재질명
					//$('[name=testSizeXY').text(data.sizeX +'*'+data.sizeY);//규격
					$($('[name=testSizeXY]')[index]).text(data.itemSize); //규격
					$($('[name=testItemVersion]')[index]).text(data.itemVersion);//도안번호
					$($('[name=testItemColor]')[index]).text(data.itemColor);//색상
					$($('[name=testCoatingMethod]')[index]).text(data.coatingMethod);//코팅
		
					$($('[name=judUserName]')[index]).val(testContentsList['시험자']);//시험자
					$($('[name=judgmentDate]')[index]).val(moment(data.judgmentDate).format('YYYY.MM.DD)'));//시험일자
					$($('[name=conUserName]')[index]).val(testContentsList['판정자']);//판정자
					$($('[name=confirmDate]')[index]).val(moment(data.confirmDate).format('YYYY.MM.DD)'));//판정일자
					$($('[name=qualityJudgmentNm]')[index]).val(data.qualityJudgmentNm);//판정결과
					$($('[name=qualityResult]')[index]).val(data.qualityJudgmentNm);//판정결과
					$($('[name=effDate]')[index]).val('제조년월일로부터 3년');

					//let issueDesc = isEmptyCheck(data.etc1Nm) ? '' : (data.etc1Nm+' 호기');
					
					//$($('[name=issueDesc]')[index]).val(issueDesc);//특기사항 기록란
				}
			});
			cssChange();

			$('#my-spinner').hide();
		},10);
	} 
	
</script>
</body>
</html>
