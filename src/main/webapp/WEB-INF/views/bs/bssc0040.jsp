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
																		  grid-template-columns: 1.7fr 4px 1fr;">
	<div id="leftcol">
		<div class="container-fluid h-100" style="padding: 5px;">
			<div class="row" id="leftHeader" style="padding-bottom: 5px;">
				<div class="d-flex align-items-center d-flex">
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">출고일자</label>
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
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">조회대상</label>
					<select class="form-select w-auto h-100 me-3" id="searchTarget" style="min-width: 70px;">
						<option value="">전체</option>
						<option value="N" selected>미출력</option>
					</select>
					<input type="text" class="form-control w-auto h-100 me-3" id="searchAll" placeholder="통합검색">
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end">
					<div class="btn-group" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnSearch"><i class="fa-regular fa-clipboard"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnSave" disabled="disabled"><i class="fa-regular fa-floppy-disk"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnEdit"><i class="fa-regular fa-pen-to-square"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnCancel" disabled="disabled"><i class="fa-solid fa-xmark"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnOpen">
							<i class="fa-solid fa-caret-left"></i>
						</button>
					</div>
				</div>
				
			</div>
			<div class="row">
				<table class="table table-bordered p-0 m-0" id="outItemTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle">수주상세번호</th>
							<th class="text-center align-middle">고객사</th>
							<th class="text-center align-middle">출고처</th>
							<th class="text-center align-middle">제품명</th>
							<th class="text-center align-middle">수주상태</th>
							<th class="text-center align-middle">진행상태</th>
							<th class="text-center align-middle">검사결과</th>
							<th class="text-center align-middle">수주수량</th>
							<th class="text-center align-middle">출고수량</th>
							<th class="text-center align-middle">출고요청일</th>
							<th class="text-center align-middle">출고일</th>
							<th class="text-center align-middle" style="max-width:100px;min-width:100px;">명세서번호</th>
							<th class="text-center align-middle">출력여부</th>
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
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">납품일자</label>
					<input type="date" max="9999-12-31" class="form-control w-auto h-100 me-1" id="deliveryDate">
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end">
					<select class="form-select w-auto h-100 me-3" id="dealReportSelect">
					</select>
					<div class="btn-group" role="group" aria-label="Small button group">
						<%-- <button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;"
								id="btnGmail" onclick="window.open('about:blank').location.href='https://mail.google.com/mail/u/0/?tab=rm#inbox?compose=new'">
							<img class="w-auto" src="<c:url value='/resources/assets/images/gmail_icon.jpg?ver=1'/>" style="height: 14px; margin-bottom: 3px;">
						</button> --%>
						<!-- <button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnDownload"><i class="fa-solid fa-download"></i></button> -->
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
						<button class="nav-link active" id="tab1Nav" data-bs-toggle="tab" data-bs-target="#tab1">거래명세서</button>
				  	</div>
					<div class="tab-content" id="nav-tabContent">
						<div class="tab-pane fade show active" id="tab1">
							<div class="row" style="padding: 5px;">
								<table id="purchasePaperTable" class="table table-bordered m-0 d-none" style="border:1px solid #ffffff;min-height:290mm;">
									<colgroup id="trAppendTarget">
										<col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%">
										<col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%">
										<col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%">
										<col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%">
										<col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%">
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
			let leftcolMinWidth = 20; // leftcol 최소사이즈
			$('#leftHeader').children().each(function(index, item) {
				leftcolMinWidth += $(item).width();
			});
			let rightcolMinWidth = 550; // rightcol 최소사이즈
	
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
			$('#page').css('grid-template-columns', '1.7fr 4px 1fr');
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
			$('#page').css('grid-template-columns', '1.7fr 4px 1fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcol').removeClass('d-none');
		} else {
			$('#page').css('grid-template-columns', '1.7fr 4px 0fr');
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
	let printArray = new Array();
	
	
	//let paperLineCountList = getCommonCode('시스템', '019'); //발주서라인수
	//let paperLineCount = parseInt(paperLineCountList[0].commonNm);
	let selectPeriod = parseInt(getCommonCode('시스템', '040')[0].commonCd); //기본조회기간 일
	$('#startDate').val(moment().subtract('d',selectPeriod).format('YYYY-MM-DD'));
	$('#endDate').val(moment().format('YYYY-MM-DD'));
	
	let dealReportList = getCommonCode('시스템', '058'); //거래명세서종류
	dealReportList = _.orderBy(dealReportList, ['commonCd'], ['asc']);
	selectBoxAppend(dealReportList,'dealReportSelect', '01', 2);
	
	$('#deliveryDate').val(moment().format('YYYY-MM-DD'));
	$('td[name=deliveryDate]').text(moment().format('YYYY-MM-DD'));
	$('#deliveryDate').on('change',function(){
		$('td[name=deliveryDate]').text($(this).val());
	});

	//거래명세서 문구 가져오기
	let dealSentence = getCommonCode('시스템', '059'); //거래명세서 문구
	const targetCommonCds = ['담당자', 'TEL', 'FAX'];
	const dealSentenceList = {};

	targetCommonCds.forEach((targetCd) => {
		const foundSentence = dealSentence.find((sentence) => sentence.commonCd === targetCd);
		if (foundSentence) {
			dealSentenceList[targetCd] = foundSentence.commonNm;
		}
	});
	//거래명세서 문구 가져오기 끝
	
	const paperLineCount = 11;

	// 사용자정보 목록조회
	$('#outItemTable thead tr').clone(true).addClass('filters').appendTo('#outItemTable thead'); // filter 생성
	let outItemTable = $('#outItemTable').DataTable({
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
            style: 'multi',
            toggleable: true,
            items: 'row',
            info: false
        },
        ajax : {
			url : '<c:url value="/stock/outProdDtlList"/>',
			type : 'POST',
			data : {
				startDate : function() { return moment($('#startDate').val()).format('YYYYMMDD'); },
				endDate : function() { return moment($('#endDate').val()).format('YYYYMMDD'); },
				searchTarget : function() { return $('#searchTarget').val(); },
			},
		},
        rowId: 'outSlipIdx',
		columns : [
			{ //수주상세번호
				data: 'bizOrdDtlNo', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return '<div style="white-space:nowrap;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ //고객사
				data: 'dealCorpNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return '<div style="white-space:nowrap;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ //출고처
				data: 'outProdDealCorpNm', className : 'text-center align-middle',
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
						return '<div style="white-space:nowrap;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ //수주상태
				data: 'bizStatusCdNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return '<div style="white-space:nowrap;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ //진행상태
				data: 'workMethodJson', className : 'text-center align-middle',
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
				data: 'qualityJudgmentNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return '<div style="white-space:nowrap;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ //수주수량
				data: 'bizOrdQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return '<div style="white-space:nowrap;">'+addCommas(parseFloat(data))+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ //출고수량
				data: 'outQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return '<div style="white-space:nowrap;">'+addCommas(parseFloat(data))+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ //출고요청일
				data: 'outReqDate', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return '<div style="white-space:nowrap;">'+moment(data).format('YYYY-MM-DD')+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ //출고일
				data: 'outDate', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return '<div style="white-space:nowrap;">'+moment(data).format('YYYY-MM-DD')+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ //명세서번호
				data: 'groupData', className : 'text-center align-middle',name:'outProdEtc4',
				render : function(data, type, row, meta) {
					if(row['outProdEtc4'] != null && row['outProdEtc4'] != '') {
						return '<div style="white-space:nowrap;">' + row['outProdEtc4'] + '</div>';
					} else {
						return '-';
					}
				}
			},
			{ //출력여부
				data: 'printYn', className : 'text-center align-middle',
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
		/* rowsGroup: [
			'outProdEtc4:name',
			'outProdEtc5:name'
	 	], */
		drawCallback: function() {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#outItemTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 79)+'px');
			
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
				let cell = $('#outItemTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#outItemTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	outItemTable.on('column-reorder', function( e, settings, details ) {
		let api = outItemTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#outItemTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	//테이블 행 선택시, 해제 시
	outItemTable.on('select deselect', function(e, dt, type, index){
		if(getWM('edit','state')){
			outItemTable.row(index).deselect();
		} else {
			//여기서 입력값검사하고
			let dataArray = outItemTable.rows('.selected').data().toArray();
			let uniqByDealCorpList = _.uniqBy(dataArray, v=> v.dealCorpIdx); //고객사 idx 기준
			let uniqByOutProdList = _.uniqBy(dataArray, v=> v.outProdEtc1); //출고처 idx 기준
			//출고처 유니크리스트의 길이가 1이상일 경우 -> 출고처 중복
			//출고처 끼리 묶었는지 체크
			if( uniqByOutProdList.length > 1 ){
				outItemTable.row(index).deselect();
				toastr.warning('출고처가 다른 항목은<br>선택할 수 없습니다.');
				return false;
			} else {
				//출력된것끼리 묶었는지 체크
				let printNoList = _.uniqBy(dataArray, v=> v.outProdEtc4);

				if( printNoList.length > 1 ){
					outItemTable.row(index).deselect();
					toastr.warning('명세서번호가 다른 항목은<br>선택할 수 없습니다.');
					return false;
				} else {
					//칸들 지우기
					$('#purchasePaperTable').find('tr').remove();
					$('#trAppendTarget').after(makeEmptyTr( $('#deliveryDate').val(), $('#dealReportSelect').val() ));

					//공급받는자에 대한 정보는 고객사 기준으로 가져옴
					if(uniqByDealCorpList.length > 0){
						$('td[name=companyNumber]').text(uniqByDealCorpList[0].companyNumber);
						$('td[name=outProdDealCorpNm]').text(uniqByDealCorpList[0].outProdDealCorpInitial);
						$('td[name=rePresentative]').text(uniqByDealCorpList[0].rePresentative);
						$('td[name=addressAdm]').text(uniqByDealCorpList[0].addressAdm);
					} 
					
					if(e.type === 'select'){
						printArray.push(outItemTable.row(index).data());
					} else if(e.type === 'deselect'){
						let thisNo = outItemTable.row(index).data().bizOrdDtlNo;
						let bundleNum = parseInt(outItemTable.row(index).data().bundleCount);
						for(var i=0; i<printArray.length;i++){
							if(printArray[i].bizOrdDtlNo == thisNo){
								printArray.splice(i, 1+bundleNum);
								break;
							} 
						}
					}
					
					//번들링 구성품 조회
					if(outItemTable.row(index).data().bundleCount>0 && e.type === 'select'){
						$.ajax({
							url : '<c:url value="/stock/bizOrderDtlBundleListWithBizOrdDtlNo"/>',
							type : 'POST',
							async : false,
							data : {
								'bizOrdDtlNo'	: function(){ return outItemTable.row(index).data().bizOrdDtlNo; },
							},
							success : function(res){
								let bundleData = res.data;
								
								//수량을 번들링 제품의 값으로 출력되도록 구현 (2023.9.19)
								bundleData.forEach(item => {
									item.outQty = outItemTable.row(index).data().outQty;
									item.bizOrdQty = outItemTable.row(index).data().bizOrdQty;
								});
								
								for ( var i=0; i < bundleData.length; i++ ) {
									printArray.push(bundleData[i]);
								}
							}
						})
					}




					//여기서 추가 명세서들 더해줌
					if(printArray.length > paperLineCount){
						let count = Math.floor(printArray.length/paperLineCount) ;
						let paperMinHeight = 290 * (count+1);
						$('#purchasePaperTable').css('min-height',paperMinHeight+'mm');
						for( var i = 0; i < count ; i ++){
							$('#trAppendTarget').after(makeEmptyTr( $('#deliveryDate').val(), $('#dealReportSelect').val() ));
							console.log('count:'+count)
						}
					} else {
						$('#purchasePaperTable').css('min-height','290mm');
					}
					//css반영
					cssChange();

					
					let fscDnoneCheck = false;
					
					for( var i = 0; i < printArray.length ; i++ ){
						let data = printArray[i];
						let topNode = $('#purchasePaperTable').find('.topEmptyTr').first();
						let bottomNode = $('#purchasePaperTable').find('.bottomEmptyTr').first();

						//수주번호
						$(topNode).find('td[name=bizOrdDtlNo]').text(data.bizOrdDtlNo);
						$(bottomNode).find('td[name=bizOrdDtlNo]').text(data.bizOrdDtlNo);
						
						//품명 (FSC가 사용인 경우 품명 앞에 *표시 추가해서 보여주기 - 2023.07.21)
						if ( data.etc7 == 'Y' ) { fscDnoneCheck = true; }
						const itemNm = data.etc7 == 'Y' ? '* ' + data.itemNm : data.itemNm;
						$(topNode).find('td[name=itemNm]').text(itemNm);
						$(bottomNode).find('td[name=itemNm]').text(itemNm);
						
						//버전
						$(topNode).find('td[name=itemVersion]').text(data.itemVersion);
						$(bottomNode).find('td[name=itemVersion]').text(data.itemVersion);
						
						//BATCH
						$(topNode).find('td[name=bizBatch]').text(data.purchaseBatch);
						$(bottomNode).find('td[name=bizBatch]').text(data.purchaseBatch);
						
						//자재코드
						$(topNode).find('td[name=customerItemCd]').text(data.customerItemCd);
						$(bottomNode).find('td[name=customerItemCd]').text(data.customerItemCd);
						
						//수량
						let outQty;
						if ( data.statementStandard == '002' ) { //명세서수량기준에 따라 수량을 다르게 조회
							outQty = data.outQty; //출고수량
						} else { // 001 or 데이터가 없을 경우
							outQty = data.bizOrdQty; //수주수량
						}
						if( isEmptyCheck(outQty) ){
							outQty = 0;
						} else {
							outQty = addCommas(parseFloat(outQty));
						}
						$(topNode).find('td input[name^="outQty"]').val(outQty);
						$(bottomNode).find('td input[name^="outQty"]').val(outQty);
						
						//비고
						$(topNode).find('td input[name^="bizDesc"]').val(data.ordDtlDesc);
						$(bottomNode).find('td input[name^="bizDesc"]').val(data.ordDtlDesc);
						
						
						$(topNode).switchClass('topEmptyTr','topTr');
						$(bottomNode).switchClass('bottomEmptyTr','bottomTr');
					}
					
					//FSC가 사용인 품목이 하나라도 있으면 문구 보여주도록 수정 (2023.07.21)
					if ( fscDnoneCheck ) {
						$('tr[name=fscTr]').removeClass('d-none');
					} else {
						$('tr[name=fscTr]').addClass('d-none');
					}
					
					//여기서 같은 명세서번호끼리 묶어서 선택해줌
					//명세서출력번호가 있는 경우 AND 선택한경우
					if( !isEmptyCheck(dt.data().outProdEtc4 && e.type =='select' ) ){
						let tableData = outItemTable.data().toArray();
						let filterList = _.filter(tableData, v=> v.outProdEtc4 == dt.data().outProdEtc4 && v.outSlipIdx != dt.data().outSlipIdx);
						if( filterList.length > 0 ){
							let selectIdString = '#';
							for( var key in filterList ){
								selectIdString += filterList[key].outSlipIdx + ', #';
								selectIdString = selectIdString.slice(0,-3);
								outItemTable.rows(selectIdString).select();
								selectIdString = '#';
							}
						}
						return false;
					} else if( !isEmptyCheck(dt.data().outProdEtc4 && e.type =='deselect' ) ){
						//명세서출력번호가 있는 경우 AND 선택해제 한 경우
						let tableData = outItemTable.data().toArray();
						let filterList = _.filter(tableData, v=> v.outProdEtc4 == dt.data().outProdEtc4 && v.outSlipIdx != dt.data().outSlipIdx);
						if( filterList.length > 0 ){
							let selectIdString = '#';
							for( var key in filterList ){
								selectIdString += filterList[key].outSlipIdx + ', #';
								selectIdString = selectIdString.slice(0,-3);
								outItemTable.rows(selectIdString).deselect();
								selectIdString = '#';
							}
						}
						return false;
					}
				}
			}
		}
	});
	
	//거래명세서 셀렉트박스 변경시
	$('#dealReportSelect').on('change', function(){
		const selectedRows = outItemTable.rows({ selected: true }).indexes(); //선택한 행
		const selectedRowCount = selectedRows.count(); //선택한 행 개수
		
		//선택한 행이 있는지 확인
		if (selectedRowCount > 0) {
			//클릭 이벤트 호출
			printArray = new Array();
			const selectedRowIndexes = selectedRows.toArray();
			for (var i = 0; i < selectedRowIndexes.length; i++) {
		        const selectedRow = outItemTable.row(selectedRowIndexes[i]);
		        selectedRow.select();

		        // 선택된 행에 대해 클릭 이벤트를 수동으로 발생시킴
		        selectedRow.node().click(); // 또는 selectedRow.node().trigger('click');
		    }
		} else {
			//양식 초기화
			$('#purchasePaperTable').find('tr').remove();
			$('#trAppendTarget').after(makeEmptyTr( $('#deliveryDate').val(), $('#dealReportSelect').val() ));
			$('#purchasePaperTable').css('min-height','290mm');
			cssChange();
		}
	});
	
	// 조회 버튼 click
	$('#btnSearch').on('click', function() {
		$('#my-spinner').show();
		WM_action_OFF('edit');

		//거래명세서 reset start
		let selectedData = outItemTable.rows('.selected').data();
		let index = selectedData.count()-1;
		
		for(var i=index; i>=0; i--){
			let outSlipIdx = '#'+outItemTable.rows('.selected').data()[i].outSlipIdx;
			outItemTable.rows(outSlipIdx).deselect();
		}
		//거래명세서 reset end
		
		outItemTable.ajax.reload(function() {});
		$('#checkAll').prop("checked",false);
		$('#btnSave').attr('disabled',true);
		$('#btnEdit').attr('disabled',false);
		$('#btnCancel').attr('disabled',true);
		$('#btnPrint').attr('disabled',false);
		
		$('.dtlList').find('td').html('&nbsp;');
		setTimeout(function() {
			$('#my-spinner').hide();
		}, 100)
	});

	//수정버튼
	$('#btnEdit').on('click',function(){
		outItemTable.rows('.selected').deselect();
		WM_action_ON('edit', 'workingWarningModal');
		$('#btnPrint').attr('disabled',true);
		$('#btnSave').attr('disabled',false);
		$('#btnEdit').attr('disabled',true);
		$('#btnCancel').attr('disabled',false);
		$('#outItemTable tbody').find('tr').each(function(index_tr, tr) {
			$(tr).find('td').each(function(index_td, td) {
				if(index_td == outItemTable.column('outProdEtc4:name').index()) {
					let value = outItemTable.row(tr).data().outProdEtc4;
					if( !isEmptyCheck(value) ){
						let html = '';
						html += '<div style="display: flex; flex-wrap: 1 1 auto;" class="input-group">';												
						html += '<input type="text" class="form-control inputGroup inputNm" name="outProdEtc4"  style="min-width:120px;max-width:120px;border-top-right-radius :0.375rem;border-bottom-right-radius :0.375rem;" value="'+outItemTable.row(tr).data().outProdEtc4+'" disabled="">';
						html +=	'<button type="button" class="btnInputDel" name="btnDealCorpDelete" style="background-color: transparent;border-color: transparent;position: absolute;top: 0;right:0;margin: 1px 5px;margin-left: 0px;border: none;">';
						html +=	'	<i class="fa-solid fa-xmark"></i>';
						html +=	'</button>';												
						html +=	'<input type="hidden" name="outProdEtc4Idx" class="outProdEtc4Idx">';
						html += '</div>';
						$(td).html(html);
					}
				}
			});
		});
	});

	$('#btnSave').on('click',function(){
		let array = [];
		let state = true;
		$('#outItemTable tbody').find('tr').each(function(index, item) {
			let td = $(item).find('td');
			let data = outItemTable.row($(item)).data();
			let outProdEtc4 = $(td).eq(outItemTable.column('outProdEtc4:name').index()).find('input[name=outProdEtc4]').val();

			if( isEmptyCheck(outProdEtc4) ) {
				outProdEtc4 = null;
			}
			
			let obj = new Object();
			obj.outSlipIdx = data.outSlipIdx;
			obj.outProdEtc4 = outProdEtc4;
		    array.push(obj);
		});

		let tableData = [];
		for(var i=0;i<outItemTable.data().count();i++) {
			let obj = {};
			obj.outSlipIdx = outItemTable.row(i).data().outSlipIdx;
			obj.outProdEtc4 = isEmptyCheck(outItemTable.row(i).data().outProdEtc4) ? null : outItemTable.row(i).data().outProdEtc4;
			tableData.push(obj);
		}

		array = _.differenceWith(array, tableData, _.isEqual);

		let updIdx = '';
		for( var key in array ){
			updIdx += array[key].outSlipIdx + ',';
		}
		updIdx = updIdx.slice(0,-1);
		//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!중요!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		//병합된 행의 명세서번호를 지웠을 때 최상단의 번호만 지워진것으로 취급이 되서 프로시저단에서 해당 명세서번호를 가진 애들은 모두 지워줌
		$.ajax({
			url: '<c:url value="/stock/tradingStatementDel"/>',
            type: 'POST',
            data: {
            	'outSlipIdx'	:	function(){ return updIdx; },
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
	
	// 발주서 인쇄 버튼 click
	$('#btnPrint').on('click',function() {
		//해당 스타일시트날리고
	    $('#printPaperTypeStyle').remove();
	    //스타일시트 생성
	    $('<style>')
	    	.prop('type', 'text/css').prop('id','printPaperTypeStyle').prop('media','print')
	    	.html('@media print { @page { size: A4 portrait; margin: 3mm; }, html, body { width: 210mm; height: 297mm; } }')
	    	.appendTo('body');
		
		let dataArray = outItemTable.rows('.selected').data().toArray();

		if(dataArray.length > 0){
			$('#my-spinner').show();
			setTimeout(function(){
				_promise_().then((value)=>{
					let updIdx = '';
					let status = false;
					let printYn = 'N';
 					let dataArray = outItemTable.rows('.selected').data().toArray();
					
 					for( var key in dataArray ){
						updIdx += dataArray[key].outSlipIdx +',';
						//빈값이 아닐 경우 -> 이미 출력된 항목 재출력
						if( !isEmptyCheck(dataArray[key].outProdEtc4) ){
							printYn = 'Y';
						}
 	 				}
					if(updIdx != '' && updIdx != null && printYn == 'N'){
						updIdx = updIdx.slice(0,-1);
						$.ajax({
							url: '<c:url value="/stock/tradingStatementUpd"/>',
				            type: 'POST',
				            async: false,
				            data: {    
					            'outSlipIdx'	:	function(){ return updIdx; },
					            'outDate'		:	function(){ return $('#deliveryDate').val().replaceAll('-',''); },	
				            },
				            beforeSend: function() {
				            	$('#my-spinner').show();
				            },
							success : function(res) {
								if (res.result == "ok") { //응답결과
									status = true;
								} else if(res.result == 'fail') {
									toastr.warning(res.message);
									status = false;
								} else {
									toastr.error(res.message);
								}
								$('#my-spinner').hide();

							}
						});
					} else {
						status = true;
					}
					return status;
				}).then((value)=>{
					if(value){
						cssChange(); // css반영
				
						$('#purchasePaperTable').print({
							globalStyles: true,
							mediaPrint: true
						});
					}
					setTimeout(function() {
						outItemTable.rows('.selected').deselect();
						outItemTable.ajax.reload();
						printArray = new Array();
						$('#my-spinner').hide();
						$('#purchasePaperTable').find('.topTr').find('td').text('');
						$('#purchasePaperTable').find('.bottomTr').find('td').text('');
					}, 200);
				});
			},100);
		} else {
			toastr.warning('출력할 행을 선택해주세요.');
			return false;
		}
		
		
	});
	// 작업인쇄 모달이 띄워지면 인쇄
	$('#workOrderPaperModal').on('shown.bs.modal', function (e) {
		$('#purchasePaperTable').print({
			globalStyles: true,
			mediaPrint: true
		});
		printArray = new Array();
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
			  filename:     moment().format('YYYYMMDD')+'_거래명세서.pdf',
			  image:        { type: 'jpeg', quality: 0.98 },
			  html2canvas:  { scale: 1 },
			  jsPDF:        { unit: 'mm', format: 'a4', orientation: 'portrait'},
			};

			// New Promise-based usage:
			html2pdf().from(element).set(opt).save().then(() => {
				
			});
		});
	});


	// 초기 셋팅
	$(document).ready(function() {
		
		$('#my-spinner').hide();
		$('#trAppendTarget').after(makeEmptyTr( $('#deliveryDate').val(), $('#dealReportSelect').val() ));
		$('#purchasePaperTable').removeClass('d-none');

		$('input').attr('autocomplete','one-time-code');
		cssChange();
	});

	function cssChange() {
		$('#purchasePaperTable').find('td').css('font-weight', '900');
		$('#purchasePaperTable').find('td').css('border', '2px solid black');
		$('#purchasePaperTable').find('td').css('padding', '0.1rem');
		$('#purchasePaperTable').find('td').css('color', '#000000');

		$('#purchasePaperTable').find('.bg-gray').css('background-color', '#A5A5A5');
		
		$('#purchasePaperTable').find('.theadFirstCol').css('border-top', '0px');
		//$('#purchasePaperTable').find('.theadFirstCol').css('border-left', '2px');
		$('#purchasePaperTable').find('.theadNotFisrtCol').css('border-top', '0px');
		$('#purchasePaperTable').find('.theadNotFisrtCol').css('border-left', '0px');
		
		$('#purchasePaperTable').find('.tbodyFirstCol').css('border-top', '0px');
		//$('#purchasePaperTable').find('.tbodyFirstCol').css('border-left', '2px');
		$('#purchasePaperTable').find('.tbodyNotFirstCol').css('border-top', '0px');
		$('#purchasePaperTable').find('.tbodyNotFirstCol').css('border-left', '0px');

		
		$('#purchasePaperTable').find('.fw-200').css('font-weight', '200');
		$('#purchasePaperTable').find('.fw-900').css('font-weight', '900');
		$('#purchasePaperTable').find('.fs-8').css('font-size', '8px');
		$('#purchasePaperTable').find('.fs-10').css('font-size', '10px');
		$('#purchasePaperTable').find('.fs-12').css('font-size', '12px');
		$('#purchasePaperTable').find('.fs-13').css('font-size', '13px');
		$('#purchasePaperTable').find('.fs-15').css('font-size', '15px');
		$('#purchasePaperTable').find('.fs-20').css('font-size', '20px');
		$('#purchasePaperTable').find('.fs-25').css('font-size', '25px');
		$('#purchasePaperTable').find('.fs-30').css('font-size', '30px');
		$('#purchasePaperTable').find('.fs-50').css('font-size', '50px');
		$('#purchasePaperTable').find('.fc-red').css('color', '#ff0000');
		$('#purchasePaperTable').find('.fc-blue').css('color', '#0070C0');
		$('#purchasePaperTable').find('.bt-2').css('border-top', '2px solid black');
		$('#purchasePaperTable').find('.bd-n').css('border', '0px solid #ffffff');
		$('#purchasePaperTable').find('.bt-n').css('border-top', '0px solid #ffffff');
		$('#purchasePaperTable').find('.br-n').css('border-right', '0px solid #ffffff');
		$('#purchasePaperTable').find('.bb-n').css('border-bottom', '0px solid #ffffff');
		$('#purchasePaperTable').find('.bl-n').css('border-left', '0px solid #ffffff');
		$('#purchasePaperTable').find('.bd_dashed').css('border-style','dashed');
		$('#purchasePaperTable').find('.w-100').css('width', '100%');
		$('#purchasePaperTable').find('.h-5').css('height', '5px');
		$('#purchasePaperTable').find('.h-10').css('height', '10px');
		$('#purchasePaperTable').find('.h-15').css('height', '15px');
		$('#purchasePaperTable').find('.h-20').css('height', '20px');
		$('#purchasePaperTable').find('.h-21').css('height', '21px');
		$('#purchasePaperTable').find('.h-23').css('height', '23px');
		$('#purchasePaperTable').find('.h-25').css('height', '25px');
		$('#purchasePaperTable').find('.h-30').css('height', '30px');
		$('#purchasePaperTable').find('.h-35').css('height', '35px');
		$('#purchasePaperTable').find('.h-40').css('height', '40px');
		$('#purchasePaperTable').find('.h-55').css('height', '55px');
		$('#purchasePaperTable').find('.h-70').css('height', '70px');
		$('#purchasePaperTable').find('.h-100').css('height', '100px');
		$('#purchasePaperTable').find('.h-120').css('height', '120px');
		
		$('#purchasePaperTable').find('.bd-r').css('border-color', '#FF0000');
		$('#purchasePaperTable').find('.bg-r').css('background-color', '#FFCCFF');
		$('#purchasePaperTable').find('.bd-b').css('border-color', '#0070C0');
		$('#purchasePaperTable').find('.bg-b').css('background-color', '#92CDDC');
		$('#purchasePaperTable').find('.bg-tr').css('background-color', 'transparent');
		
		// 인쇄할 때 css 적용하려면 important 붙여줘야함.
		for (var i = 0; i < $('#purchasePaperTable').find('td, input').length; i++) {
		    let element = $('#purchasePaperTable').find('td, input').eq(i);
		    let style = element.attr('style') || ''; // 기존 스타일 또는 빈 문자열로 초기화
		
		    // 스타일 적용 시 !important를 사용하여 덮어쓰기
		    element.attr('style', style.replaceAll(';', ' !important;'));
		}
		
	}

	// make empty tr
	function makeEmptyTr( deliveryDate, paperType ) {
		let html = '';
		if ( paperType == '01' ) {
			//거래명세서
			html += '<tr style="height:40px!important;page-break-before: always!important;">';
			html += '	<td colspan="10" class="bd-n" ></td>';
			html += '	<td colspan="9" class="fs-25 fc-red text-center bd-r bt-n bl-n br-n" >거&nbsp;&nbsp;&nbsp;래&nbsp;&nbsp;&nbsp;명&nbsp;&nbsp;&nbsp;세&nbsp;&nbsp;&nbsp;서</td>';
			html += '	<td colspan="10" class="bd-n" ></td>';
			html += '</tr>';
			html += '<tr style="height:30px!important;">';
			html += '	<td colspan="10" class="bd-n" ></td>';
			html += '	<td colspan="9" class="fs-15 fc-red text-center bd-n" >(공급자 보관용)</td>';
			html += '	<td colspan="10" class="bd-n" ></td>';
			html += '</tr>';
			html += '<tr style="height:20px!important;">';
			html += '	<td colspan="4" class="fs-15 fc-red bd-n" nowrap>납품년월일 : </td>';
			html += '	<td colspan="25" class="fs-15 text-start bd-n" name="deliveryDate" >'+deliveryDate+'</td>';
			html += '</tr>';
			html += '<tr>';
			html += '	<td colspan="1" rowspan="4" class="fs-10 h-40 fc-red bd-r text-center align-middle not-left" >공<br>급<br>받<br>는<br>자</td>';
			html += '	<td colspan="3" class="fs-10 bd-r bg-r h-10 fc-red text-center align-middle not-left" >등록번호</td>';
			html += '	<td name="companyNumber" colspan="10" class="fs-10 h-10 bd-r text-center align-middle not-left" ></td>';
			html += '';
			html += '	<td colspan="1" rowspan="4" class="bd-r text-center align-middle not-left" ></td>';
			html += '';	 
			html += '	<td style="max-height:120px;" colspan="1" rowspan="4" class="fs-10 h-10 fc-red bd-r text-center align-middle not-left" >공<br>급<br>자</td>';
			html += '	<td colspan="3" class="fs-10 h-10 bd-r bg-r fc-red text-center align-middle not-left" >등록번호</td>';
			html += '	<td colspan="10" class="fs-10 h-10 bd-r text-center align-middle not-left" >123-86-01024</td>';
			html += '</tr>';
			html += '<tr>';
			html += '	<td colspan="3" class="fs-10 h-10 bg-r fc-red bd-r text-center align-middle not-left" >상&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;호</td>';
			html += '	<td name="outProdDealCorpNm" colspan="5" class="fs-10 h-10 bd-r text-center align-middle not-left" ></td>';
			html += '	<td colspan="2" class="fs-10 h-10 bg-r fc-red bd-r text-center align-middle not-left" >성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;명</td>';
			html += '	<td name="rePresentative" colspan="3" class="fs-10 h-10 bd-r text-center align-middle not-left" ></td>';
			html += '';	                      
			html += '	<td colspan="3" class="fs-10 h-10 bg-r fc-red bd-r text-center align-middle not-left" >상&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;호</td>';
			html += '	<td colspan="5" class="fs-10 h-10 bd-r text-center align-middle not-left" >(주)창영테크팩</td>';
			html += '	<td colspan="2" class="fs-10 h-10 bg-r fc-red bd-r text-center align-middle not-left" >성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;명</td>';
			html += '	<td colspan="3" class="fs-10 h-10 bd-r text-center align-middle not-left" >최재성</td>';
			html += '</tr>';        
			html += '<tr>';         
			html += '	<td colspan="3" class="fs-10 h-10 bg-r fc-red bd-r text-center align-middle not-left" >주&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소</td>';
			html += '	<td name="addressAdm" colspan="10" class="fs-10 bd-r text-center align-middle not-left" ></td>';
			html += '';	            
			html += '	<td colspan="3" class="fs-10 bg-r fc-red bd-r text-center align-middle not-left" >주&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소</td>';
			html += '	<td colspan="10" class="fs-10 bd-r text-center align-middle not-left" >경기도 수원시 권선구 산업로 156번길 88-39</td>';
			html += '</tr>';        
			html += '<tr>';        
			html += '	<td colspan="3" class="fs-10 h-10 bg-r fc-red bd-r text-center align-middle not-left" >업&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;태</td>';
			html += '	<td colspan="4" class="fs-10 bd-r text-center align-middle not-left" ></td>';
			html += '	<td colspan="2" class="fs-10 bg-r fc-red bd-r text-center align-middle not-left" >종&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</td>';
			html += '	<td colspan="4" class="fs-10 bd-r text-center align-middle not-left" ></td>';
			html += '';	                       
			html += '	<td colspan="3" class="fs-10 bg-r fc-red bd-r text-center align-middle not-left" >업&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;태</td>';
			html += '	<td colspan="4" class="fs-10 bd-r text-center align-middle not-left" >제조업</td>';
			html += '	<td colspan="2" class="fs-10 bg-r fc-red bd-r text-center align-middle not-left" >종&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</td>';
			html += '	<td colspan="4" class="fs-10 bd-r text-center align-middle not-left" >인쇄</td>';
			html += '</tr>';                 
			html += '<tr style="height:20px!important;">';                  
			html += '	<td colspan="2" class="fs-13 bg-r fc-red bd-r text-center align-middle not-left" >번 호</td>';
			html += '	<td colspan="12" class="fs-13 bg-r fc-red bd-r text-center align-middle not-left" >품 명</td>';
			html += '	<td colspan="2" class="fs-13 bg-r fc-red bd-r text-center align-middle not-left" >수 량</td>';
			html += '	<td colspan="4" class="fs-13 bg-r fc-red bd-r text-center align-middle not-left" >Rev.</td>';
			html += '	<td colspan="4" class="fs-13 bg-r fc-red bd-r text-center align-middle not-left" >구분/Batch</td>';
			html += '	<td colspan="5" class="fs-13 bg-r fc-red bd-r text-center align-middle not-left" >비 고</td>';
			html += '</tr>';
			for(var i = 0 ; i < paperLineCount ; i++){
				if( i % 2 == 0 ){
					html += '<tr class="topEmptyTr">';
					html += '	<td colspan="2" name="bizOrdDtlNo" class="h-21 fs-10 bd-r text-center align-middle not-left dtlList" ></td>';
					html += '	<td colspan="12" name="itemNm" class="h-21 fs-10 bd-r text-center align-middle not-left dtlList" ></td>';
					html += '	<td colspan="2" class="h-21 fs-10 bd-r text-center align-middle not-left dtlList" >';
					html += `		<input name="outQty\${i}" oninput="syncValues('outQty\${i}', this.value)" type="text" class="fs-10 bd-n fw-900 text-center p-0 w-100 bg-tr">`;
					html += '	</td>';
					html += '	<td colspan="4" name="itemVersion" class="h-21 fs-10 bd-r text-center align-middle not-left dtlList" ></td>';
					html += '	<td colspan="4" name="bizBatch" class="h-21 fs-10 bd-r text-center align-middle not-left dtlList" ></td>';
					html += '	<td colspan="5" class="h-21 fs-10 bd-r text-center align-middle not-left dtlList" >';
					html += `		<input name="bizDesc\${i}" oninput="syncValues('bizDesc\${i}', this.value)" type="text" class="fs-10 bd-n fw-900 text-center p-0 w-100 bg-tr">`;
					html += '	</td>';
					html += '</tr>';
				} else {
					html += '<tr class="topEmptyTr">';
					html += '	<td colspan="2" name="bizOrdDtlNo" class="h-21 fs-10 bg-r bd-r text-center align-middle not-left dtlList" ></td>';
					html += '	<td colspan="12" name="itemNm" class="h-21 fs-10 bg-r bd-r text-center align-middle not-left dtlList" ></td>';
					html += '	<td colspan="2" class="h-21 fs-10 bg-r bd-r text-center align-middle not-left dtlList" >';
					html += `		<input name="outQty\${i}" oninput="syncValues('outQty\${i}', this.value)" type="text" class="fs-10 bd-n fw-900 text-center p-0 w-100 bg-tr">`;
					html += '	</td>';
					html += '	<td colspan="4" name="itemVersion" class="h-21 fs-10 bg-r bd-r text-center align-middle not-left dtlList" ></td>';
					html += '	<td colspan="4" name="bizBatch" class="h-21 fs-10 bg-r bd-r text-center align-middle not-left dtlList" ></td>';
					html += '	<td colspan="5" class="h-21 fs-10 bg-r bd-r text-center align-middle not-left dtlList" >';
					html += `		<input name="bizDesc\${i}" oninput="syncValues('bizDesc\${i}', this.value)" type="text" class="fs-10 bd-n fw-900 text-center p-0 w-100 bg-tr">`;
					html += '	</td>';
					html += '</tr>';
				}
			}

			html += '<tr>';
			html += '	<td colspan="17" class="h-20 fs-13 bd-n text-start align-middle not-left">';
			html += `		<input name="dealSentence1" oninput="syncValues('dealSentence1', this.value)" value="\${dealSentenceList['담당자']}" type="text" class="fs-13 bd-n fw-900 text-start p-0 w-100">`;
			html += '	</td>';
			html += '	<td colspan="6" class="h-20 fs-13 bd-n text-start align-middle not-left">';
			html += `		<input name="dealSentence2" oninput="syncValues('dealSentence2', this.value)" value="\${dealSentenceList['TEL']}" type="text" class="fs-13 bd-n fw-900 text-start p-0 w-100">`;
			html += '	</td>';
			html += '	<td colspan="6" class="h-20 fs-13 bd-n text-start align-middle not-left">';
			html += `		<input name="dealSentence3" oninput="syncValues('dealSentence3', this.value)" value="\${dealSentenceList['FAX']}" type="text" class="fs-13 bd-n fw-900 text-start p-0 w-100">`;
			html += '	</td>';
			html += '</tr>';
			html += '<tr class="d-none" name="fscTr">';
			html += '	<td colspan="29" class="text-center fw-200 bt-n bl-n br-n bb-n h-10">*표시된 제품은 ㈜창영테크팩에서 생산된 FSC인증 제품입니다. 인증번호: SGSHK-COC-340249 인증타입: FSC Mix Credit</td>';
			html += '</tr>';
			html += '<tr>';
			html += '	<td colspan="29" class="bt-n bl-n br-n bd_dashed h-10" ></td>';
			html += '</tr>';
			html += '';
			html += '<tr style="height:40px!important;">';
			html += '	<td colspan="10" class="bd-n" ></td>';
			html += '	<td colspan="9" class="fs-25 fc-blue text-center bd-b bt-n bl-n br-n" >거&nbsp;&nbsp;&nbsp;래&nbsp;&nbsp;&nbsp;명&nbsp;&nbsp;&nbsp;세&nbsp;&nbsp;&nbsp;서</td>';
			html += '	<td colspan="10" class="bd-n" ></td>';
			html += '</tr>';
			html += '<tr style="height:30px!important;">';
			html += '	<td colspan="10" class="bd-n" ></td>';
			html += '	<td colspan="9" class="fs-15 fc-blue text-center bd-n" >(공급받는자 보관용)</td>';
			html += '	<td colspan="10" class="bd-n" ></td>';
			html += '</tr>';
			html += '<tr style="height:20px!important;">';
			html += '	<td colspan="4" class="fs-15 fc-blue bd-n" nowrap>납품년월일 : </td>';
			html += '	<td colspan="25" class="fs-15 text-start bd-n" name="deliveryDate" >'+deliveryDate+'</td>';
			html += '</tr>';
			html += '<tr>';
			html += '	<td style="max-height:100px;" colspan="1" rowspan="4" class="fs-10 h-40 fc-blue bd-b text-center align-middle not-left" >공<br>급<br>받<br>는<br>자</td>';
			html += '	<td colspan="3" class="fs-10 h-10 bd-b bg-b fc-blue text-center align-middle not-left" >등록번호</td>';
			html += '	<td name="companyNumber" colspan="10" class="fs-10 bd-b text-center align-middle not-left" ></td>';
			html += '';	
			html += '	<td colspan="1" rowspan="4" class="bd-b text-center align-middle not-left" ></td>';
			html += '';	
			html += '	<td style="max-height:100px;" colspan="1" rowspan="4" class="fs-10 fc-blue bd-b text-center align-middle not-left" >공<br>급<br>자</td>';
			html += '	<td colspan="3" class="fs-10 bd-b bg-b fc-blue text-center align-middle not-left" >등록번호</td>';
			html += '	<td colspan="10" class="fs-10 bd-b text-center align-middle not-left" >123-86-01024</td>';
			html += '</tr>';
			html += '<tr>';
			html += '	<td colspan="3" class="fs-10 h-10 bg-b fc-blue bd-b text-center align-middle not-left" >상&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;호</td>';
			html += '	<td name="outProdDealCorpNm" colspan="5" class="fs-10 bd-b text-center align-middle not-left" ></td>';
			html += '	<td colspan="2" class="fs-10 bg-b fc-blue bd-b text-center align-middle not-left" >성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;명</td>';
			html += '	<td name="rePresentative" colspan="3" class="fs-10 bd-b text-center align-middle not-left" ></td>';
			html += '';	
			html += '	<td colspan="3" class="fs-10 bg-b fc-blue bd-b text-center align-middle not-left" >상&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;호</td>';
			html += '	<td colspan="5" class="fs-10 bd-b text-center align-middle not-left" >(주)창영테크팩</td>';
			html += '	<td colspan="2" class="fs-10 bg-b fc-blue bd-b text-center align-middle not-left" >성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;명</td>';
			html += '	<td colspan="3" class="fs-10 bd-b text-center align-middle not-left" >최재성</td>';
			html += '</tr>';
			html += '<tr>';
			html += '	<td colspan="3" class="fs-10 h-10 bg-b fc-blue bd-b text-center align-middle not-left" >주&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소</td>';
			html += '	<td name="addressAdm" colspan="10" class="fs-10 bd-b text-center align-middle not-left" ></td>';
			html += '';	
			html += '	<td colspan="3" class="fs-10 bg-b fc-blue bd-b text-center align-middle not-left" >주&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소</td>';
			html += '	<td colspan="10" class="fs-10 bd-b text-center align-middle not-left" >경기도 수원시 권선구 산업로 156번길 88-39</td>';
			html += '</tr>';
			html += '<tr>';
			html += '	<td colspan="3" class="fs-10 h-10 bg-b fc-blue bd-b text-center align-middle not-left" >업&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;태</td>';
			html += '	<td colspan="4" class="fs-10 bd-b text-center align-middle not-left" ></td>';
			html += '	<td colspan="2" class="fs-10 bg-b fc-blue bd-b text-center align-middle not-left" >종&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</td>';
			html += '	<td colspan="4" class="fs-10 bd-b text-center align-middle not-left" ></td>';
			html += '';	
			html += '	<td colspan="3" class="fs-10 bg-b fc-blue bd-b text-center align-middle not-left" >업&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;태</td>';
			html += '	<td colspan="4" class="fs-10 bd-b text-center align-middle not-left" >제조업</td>';
			html += '	<td colspan="2" class="fs-10 bg-b fc-blue bd-b text-center align-middle not-left" >종&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</td>';
			html += '	<td colspan="4" class="fs-10 bd-b text-center align-middle not-left" >인쇄</td>';
			html += '</tr>';
			html += '<tr style="height:20px!important;">';
			html += '	<td colspan="2" class="fs-13 bg-b fc-blue bd-b text-center align-middle not-left" >번 호</td>';
			html += '	<td colspan="12" class="fs-13 bg-b fc-blue bd-b text-center align-middle not-left" >품 명</td>';
			html += '	<td colspan="2" class="fs-13 bg-b fc-blue bd-b text-center align-middle not-left" >수 량</td>';
			html += '	<td colspan="4" class="fs-13 bg-b fc-blue bd-b text-center align-middle not-left" >Rev.</td>';
			html += '	<td colspan="4" class="fs-13 bg-b fc-blue bd-b text-center align-middle not-left" >구분/Batch</td>';
			html += '	<td colspan="5" class="fs-13 bg-b fc-blue bd-b text-center align-middle not-left" >비 고</td>';
			html += '</tr>';

			for(var i = 0 ; i < paperLineCount ; i++){
				if( i % 2 == 0 ){
					html += '<tr class="bottomEmptyTr">';
					html += '	<td colspan="2" name="bizOrdDtlNo" class="h-21 fs-10 bd-b text-center align-middle not-left dtlList" ></td>';
					html += '	<td colspan="12" name="itemNm" class="h-21 fs-10 bd-b text-center align-middle not-left dtlList" ></td>';
					html += '	<td colspan="2" class="h-21 fs-10 bd-b text-center align-middle not-left dtlList" >';
					html += `		<input name="outQty\${i}" oninput="syncValues('outQty\${i}', this.value)" type="text" class="fs-10 bd-n fw-900 text-center p-0 w-100 bg-tr">`;
					html += '	</td>';
					html += '	<td colspan="4" name="itemVersion" class="h-21 fs-10 bd-b text-center align-middle not-left dtlList" ></td>';
					html += '	<td colspan="4" name="bizBatch" class="h-21 fs-10 bd-b text-center align-middle not-left dtlList" ></td>';
					html += '	<td colspan="5" class="h-21 fs-10 bd-b text-center align-middle not-left dtlList" >';
					html += `		<input name="bizDesc\${i}" oninput="syncValues('bizDesc\${i}', this.value)" type="text" class="fs-10 bd-n fw-900 text-center p-0 w-100 bg-tr">`;
					html += '	</td>';
					html += '</tr>';
				} else {
					html += '<tr class="bottomEmptyTr">';
					html += '	<td colspan="2" name="bizOrdDtlNo" class="h-21 fs-10 bg-b bd-b text-center align-middle not-left dtlList" ></td>';
					html += '	<td colspan="12" name="itemNm" class="h-21 fs-10 bg-b bd-b text-center align-middle not-left dtlList" ></td>';
					html += '	<td colspan="2" class="h-21 fs-10 bg-b bd-b text-center align-middle not-left dtlList" >';
					html += `		<input name="outQty\${i}" oninput="syncValues('outQty\${i}', this.value)" type="text" class="fs-10 bd-n fw-900 text-center p-0 w-100 bg-tr">`;
					html += '	</td>';
					html += '	<td colspan="4" name="itemVersion" class="h-21 fs-10 bg-b bd-b text-center align-middle not-left dtlList" ></td>';
					html += '	<td colspan="4" name="bizBatch" class="h-21 fs-10 bg-b bd-b text-center align-middle not-left dtlList" ></td>';
					html += '	<td colspan="5" class="h-21 fs-10 bg-b bd-b text-center align-middle not-left dtlList" >';
					html += `		<input name="bizDesc\${i}" oninput="syncValues('bizDesc\${i}', this.value)" type="text" class="fs-10 bd-n fw-900 text-center p-0 w-100 bg-tr">`;
					html += '	</td>';
					html += '</tr>';
				}
			}
			
			
			html += '<tr>';
			html += '	<td colspan="17" class="h-20 fs-13 bd-n text-start align-middle not-left">';
			html += `		<input name="dealSentence1" oninput="syncValues('dealSentence1', this.value)" value="\${dealSentenceList['담당자']}" type="text" class="fs-13 bd-n fw-900 text-start p-0 w-100">`;
			html += '	</td>';
			html += '	<td colspan="6" class="h-20 fs-13 bd-n text-start align-middle not-left">';
			html += `		<input name="dealSentence2" oninput="syncValues('dealSentence2', this.value)" value="\${dealSentenceList['TEL']}" type="text" class="fs-13 bd-n fw-900 text-start p-0 w-100">`;
			html += '	</td>';
			html += '	<td colspan="6" class="h-20 fs-13 bd-n text-start align-middle not-left">';
			html += `		<input name="dealSentence3" oninput="syncValues('dealSentence3', this.value)" value="\${dealSentenceList['FAX']}" type="text" class="fs-13 bd-n fw-900 text-start p-0 w-100">`;
			html += '	</td>';
			html += '</tr>';
			html += '<tr class="d-none" name="fscTr">';
			html += '	<td colspan="29" class="text-center fw-200 bt-n bl-n br-n bb-n h-10">*표시된 제품은 ㈜창영테크팩에서 생산된 FSC인증 제품입니다. 인증번호: SGSHK-COC-340249 인증타입: FSC Mix Credit</td>';
			html += '</tr>';
		} else if ( paperType == '02' ) {
			//한독 거래명세서
			html += '<tr style="height:40px!important;page-break-before: always!important;">';
			html += '	<td colspan="10" class="bd-n" ></td>';
			html += '	<td colspan="9" class="fs-25 fc-red text-center bd-r bt-n bl-n br-n" >거&nbsp;&nbsp;&nbsp;래&nbsp;&nbsp;&nbsp;명&nbsp;&nbsp;&nbsp;세&nbsp;&nbsp;&nbsp;서</td>';
			html += '	<td colspan="10" class="bd-n" ></td>';
			html += '</tr>';
			html += '<tr style="height:30px!important;">';
			html += '	<td colspan="10" class="bd-n" ></td>';
			html += '	<td colspan="9" class="fs-15 fc-red text-center bd-n" >(공급자 보관용)</td>';
			html += '	<td colspan="10" class="bd-n" ></td>';
			html += '</tr>';
			html += '<tr style="height:20px!important;">';
			html += '	<td colspan="4" class="fs-15 fc-red bd-n" nowrap>납품년월일 : </td>';
			html += '	<td colspan="25" class="fs-15 text-start bd-n" name="deliveryDate" >'+deliveryDate+'</td>';
			html += '</tr>';
			html += '<tr>';
			html += '	<td colspan="1" rowspan="4" class="fs-10 h-40 fc-red bd-r text-center align-middle not-left" >공<br>급<br>받<br>는<br>자</td>';
			html += '	<td colspan="3" class="fs-10 bd-r bg-r h-10 fc-red text-center align-middle not-left" >등록번호</td>';
			html += '	<td name="companyNumber" colspan="10" class="fs-10 h-10 bd-r text-center align-middle not-left" ></td>';
			html += '';
			html += '	<td colspan="1" rowspan="4" class="bd-r text-center align-middle not-left" ></td>';
			html += '';	 
			html += '	<td style="max-height:120px;" colspan="1" rowspan="4" class="fs-10 h-10 fc-red bd-r text-center align-middle not-left" >공<br>급<br>자</td>';
			html += '	<td colspan="3" class="fs-10 h-10 bd-r bg-r fc-red text-center align-middle not-left" >등록번호</td>';
			html += '	<td colspan="10" class="fs-10 h-10 bd-r text-center align-middle not-left" >123-86-01024</td>';
			html += '</tr>';
			html += '<tr>';
			html += '	<td colspan="3" class="fs-10 h-10 bg-r fc-red bd-r text-center align-middle not-left" >상&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;호</td>';
			html += '	<td name="outProdDealCorpNm" colspan="5" class="fs-10 h-10 bd-r text-center align-middle not-left" ></td>';
			html += '	<td colspan="2" class="fs-10 h-10 bg-r fc-red bd-r text-center align-middle not-left" >성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;명</td>';
			html += '	<td name="rePresentative" colspan="3" class="fs-10 h-10 bd-r text-center align-middle not-left" ></td>';
			html += '';	                      
			html += '	<td colspan="3" class="fs-10 h-10 bg-r fc-red bd-r text-center align-middle not-left" >상&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;호</td>';
			html += '	<td colspan="5" class="fs-10 h-10 bd-r text-center align-middle not-left" >(주)창영테크팩</td>';
			html += '	<td colspan="2" class="fs-10 h-10 bg-r fc-red bd-r text-center align-middle not-left" >성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;명</td>';
			html += '	<td colspan="3" class="fs-10 h-10 bd-r text-center align-middle not-left" >최재성</td>';
			html += '</tr>';        
			html += '<tr>';         
			html += '	<td colspan="3" class="fs-10 h-10 bg-r fc-red bd-r text-center align-middle not-left" >주&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소</td>';
			html += '	<td name="addressAdm" colspan="10" class="fs-10 bd-r text-center align-middle not-left" ></td>';
			html += '';	            
			html += '	<td colspan="3" class="fs-10 bg-r fc-red bd-r text-center align-middle not-left" >주&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소</td>';
			html += '	<td colspan="10" class="fs-10 bd-r text-center align-middle not-left" >경기도 수원시 권선구 산업로 156번길 88-39</td>';
			html += '</tr>';        
			html += '<tr>';        
			html += '	<td colspan="3" class="fs-10 h-10 bg-r fc-red bd-r text-center align-middle not-left" >업&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;태</td>';
			html += '	<td colspan="4" class="fs-10 bd-r text-center align-middle not-left" ></td>';
			html += '	<td colspan="2" class="fs-10 bg-r fc-red bd-r text-center align-middle not-left" >종&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</td>';
			html += '	<td colspan="4" class="fs-10 bd-r text-center align-middle not-left" ></td>';
			html += '';	                       
			html += '	<td colspan="3" class="fs-10 bg-r fc-red bd-r text-center align-middle not-left" >업&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;태</td>';
			html += '	<td colspan="4" class="fs-10 bd-r text-center align-middle not-left" >제조업</td>';
			html += '	<td colspan="2" class="fs-10 bg-r fc-red bd-r text-center align-middle not-left" >종&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</td>';
			html += '	<td colspan="4" class="fs-10 bd-r text-center align-middle not-left" >인쇄</td>';
			html += '</tr>';                 
			html += '<tr style="height:20px!important;">';                  
			html += '	<td colspan="2" class="fs-13 bg-r fc-red bd-r text-center align-middle not-left" >번 호</td>';
			html += '	<td colspan="3" class="fs-13 bg-r fc-red bd-r text-center align-middle not-left" >구매오더</td>';
			html += '	<td colspan="3" class="fs-13 bg-r fc-red bd-r text-center align-middle not-left" >자재코드</td>';
			html += '	<td colspan="12" class="fs-13 bg-r fc-red bd-r text-center align-middle not-left" >품 명</td>';
			html += '	<td colspan="2" class="fs-13 bg-r fc-red bd-r text-center align-middle not-left" >수 량</td>';
			html += '	<td colspan="4" class="fs-13 bg-r fc-red bd-r text-center align-middle not-left" >Rev.</td>';
			html += '	<td colspan="3" class="fs-13 bg-r fc-red bd-r text-center align-middle not-left" >비 고</td>';
			html += '</tr>';
			for(var i = 0 ; i < paperLineCount ; i++){
				if( i % 2 == 0 ){
					html += '<tr class="topEmptyTr">';
					html += '	<td colspan="2" name="bizOrdDtlNo" class="h-21 fs-10 bd-r text-center align-middle not-left dtlList" ></td>'; //번 호
					html += '	<td colspan="3" name="bizBatch" class="h-21 fs-10 bd-r text-center align-middle not-left dtlList" ></td>'; //구매오더
					html += '	<td colspan="3" name="customerItemCd" class="h-21 fs-10 bd-r text-center align-middle not-left dtlList" ></td>'; //자재코드
					html += '	<td colspan="12" name="itemNm" class="h-21 fs-10 bd-r text-center align-middle not-left dtlList" ></td>'; //품 명
					html += '	<td colspan="2" class="h-21 fs-10 bd-r text-center align-middle not-left dtlList" >'; //수 량
					html += `		<input name="outQty\${i}" oninput="syncValues('outQty\${i}', this.value)" type="text" class="fs-10 bd-n fw-900 text-center p-0 w-100 bg-tr">`;
					html += '	</td>';
					html += '	<td colspan="4" name="itemVersion" class="h-21 fs-10 bd-r text-center align-middle not-left dtlList" ></td>'; //Rev.
					html += '	<td colspan="3" class="h-21 fs-10 bd-r text-center align-middle not-left dtlList" >'; //비 고
					html += `		<input name="bizDesc\${i}" oninput="syncValues('bizDesc\${i}', this.value)" type="text" class="fs-10 bd-n fw-900 text-center p-0 w-100 bg-tr">`;
					html += '	</td>';
					html += '</tr>';
				} else {
					html += '<tr class="topEmptyTr">';
					html += '	<td colspan="2" name="bizOrdDtlNo" class="h-21 fs-10 bg-r bd-r text-center align-middle not-left dtlList" ></td>'; //번 호
					html += '	<td colspan="3" name="bizBatch" class="h-21 fs-10 bg-r bd-r text-center align-middle not-left dtlList" ></td>'; //구매오더
					html += '	<td colspan="3" name="customerItemCd" class="h-21 fs-10 bg-r bd-r text-center align-middle not-left dtlList" ></td>'; //자재코드
					html += '	<td colspan="12" name="itemNm" class="h-21 fs-10 bg-r bd-r text-center align-middle not-left dtlList" ></td>'; //품 명
					html += '	<td colspan="2" class="h-21 fs-10 bg-r bd-r text-center align-middle not-left dtlList" >'; //수 량
					html += `		<input name="outQty\${i}" oninput="syncValues('outQty\${i}', this.value)" type="text" class="fs-10 bd-n fw-900 text-center p-0 w-100 bg-tr">`;
					html += '	</td>';
					html += '	<td colspan="4" name="itemVersion" class="h-21 fs-10 bg-r bd-r text-center align-middle not-left dtlList" ></td>'; //Rev.
					html += '	<td colspan="3" class="h-21 fs-10 bg-r bd-r text-center align-middle not-left dtlList" >'; //비 고
					html += `		<input name="bizDesc\${i}" oninput="syncValues('bizDesc\${i}', this.value)" type="text" class="fs-10 bd-n fw-900 text-center p-0 w-100 bg-tr">`;
					html += '	</td>';
					html += '</tr>';
				}
			}

			html += '<tr>';
			html += '	<td colspan="17" class="h-20 fs-13 bd-n text-start align-middle not-left">';
			html += `		<input name="dealSentence1" oninput="syncValues('dealSentence1', this.value)" value="\${dealSentenceList['담당자']}" type="text" class="fs-13 bd-n fw-900 text-start p-0 w-100">`;
			html += '	</td>';
			html += '	<td colspan="6" class="h-20 fs-13 bd-n text-start align-middle not-left">';
			html += `		<input name="dealSentence2" oninput="syncValues('dealSentence2', this.value)" value="\${dealSentenceList['TEL']}" type="text" class="fs-13 bd-n fw-900 text-start p-0 w-100">`;
			html += '	</td>';
			html += '	<td colspan="6" class="h-20 fs-13 bd-n text-start align-middle not-left">';
			html += `		<input name="dealSentence3" oninput="syncValues('dealSentence3', this.value)" value="\${dealSentenceList['FAX']}" type="text" class="fs-13 bd-n fw-900 text-start p-0 w-100">`;
			html += '	</td>';
			html += '</tr>';
			html += '<tr class="d-none" name="fscTr">';
			html += '	<td colspan="29" class="text-center fw-200 bt-n bl-n br-n bb-n h-10">*표시된 제품은 ㈜창영테크팩에서 생산된 FSC인증 제품입니다. 인증번호: SGSHK-COC-340249 인증타입: FSC Mix Credit</td>';
			html += '</tr>';
			html += '<tr>';
			html += '	<td colspan="29" class="bt-n bl-n br-n bd_dashed h-10" ></td>';
			html += '</tr>';
			html += '';
			html += '<tr style="height:40px!important;">';
			html += '	<td colspan="10" class="bd-n" ></td>';
			html += '	<td colspan="9" class="fs-25 fc-blue text-center bd-b bt-n bl-n br-n" >거&nbsp;&nbsp;&nbsp;래&nbsp;&nbsp;&nbsp;명&nbsp;&nbsp;&nbsp;세&nbsp;&nbsp;&nbsp;서</td>';
			html += '	<td colspan="10" class="bd-n" ></td>';
			html += '</tr>';
			html += '<tr style="height:30px!important;">';
			html += '	<td colspan="10" class="bd-n" ></td>';
			html += '	<td colspan="9" class="fs-15 fc-blue text-center bd-n" >(공급받는자 보관용)</td>';
			html += '	<td colspan="10" class="bd-n" ></td>';
			html += '</tr>';
			html += '<tr style="height:20px!important;">';
			html += '	<td colspan="4" class="fs-15 fc-blue bd-n" nowrap>납품년월일 : </td>';
			html += '	<td colspan="25" class="fs-15 text-start bd-n" name="deliveryDate" >'+deliveryDate+'</td>';
			html += '</tr>';
			html += '<tr>';
			html += '	<td style="max-height:100px;" colspan="1" rowspan="4" class="fs-10 h-40 fc-blue bd-b text-center align-middle not-left" >공<br>급<br>받<br>는<br>자</td>';
			html += '	<td colspan="3" class="fs-10 h-10 bd-b bg-b fc-blue text-center align-middle not-left" >등록번호</td>';
			html += '	<td name="companyNumber" colspan="10" class="fs-10 bd-b text-center align-middle not-left" ></td>';
			html += '';	
			html += '	<td colspan="1" rowspan="4" class="bd-b text-center align-middle not-left" ></td>';
			html += '';	
			html += '	<td style="max-height:100px;" colspan="1" rowspan="4" class="fs-10 fc-blue bd-b text-center align-middle not-left" >공<br>급<br>자</td>';
			html += '	<td colspan="3" class="fs-10 bd-b bg-b fc-blue text-center align-middle not-left" >등록번호</td>';
			html += '	<td colspan="10" class="fs-10 bd-b text-center align-middle not-left" >123-86-01024</td>';
			html += '</tr>';
			html += '<tr>';
			html += '	<td colspan="3" class="fs-10 h-10 bg-b fc-blue bd-b text-center align-middle not-left" >상&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;호</td>';
			html += '	<td name="outProdDealCorpNm" colspan="5" class="fs-10 bd-b text-center align-middle not-left" ></td>';
			html += '	<td colspan="2" class="fs-10 bg-b fc-blue bd-b text-center align-middle not-left" >성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;명</td>';
			html += '	<td name="rePresentative" colspan="3" class="fs-10 bd-b text-center align-middle not-left" ></td>';
			html += '';	
			html += '	<td colspan="3" class="fs-10 bg-b fc-blue bd-b text-center align-middle not-left" >상&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;호</td>';
			html += '	<td colspan="5" class="fs-10 bd-b text-center align-middle not-left" >(주)창영테크팩</td>';
			html += '	<td colspan="2" class="fs-10 bg-b fc-blue bd-b text-center align-middle not-left" >성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;명</td>';
			html += '	<td colspan="3" class="fs-10 bd-b text-center align-middle not-left" >최재성</td>';
			html += '</tr>';
			html += '<tr>';
			html += '	<td colspan="3" class="fs-10 h-10 bg-b fc-blue bd-b text-center align-middle not-left" >주&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소</td>';
			html += '	<td name="addressAdm" colspan="10" class="fs-10 bd-b text-center align-middle not-left" ></td>';
			html += '';	
			html += '	<td colspan="3" class="fs-10 bg-b fc-blue bd-b text-center align-middle not-left" >주&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소</td>';
			html += '	<td colspan="10" class="fs-10 bd-b text-center align-middle not-left" >경기도 수원시 권선구 산업로 156번길 88-39</td>';
			html += '</tr>';
			html += '<tr>';
			html += '	<td colspan="3" class="fs-10 h-10 bg-b fc-blue bd-b text-center align-middle not-left" >업&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;태</td>';
			html += '	<td colspan="4" class="fs-10 bd-b text-center align-middle not-left" ></td>';
			html += '	<td colspan="2" class="fs-10 bg-b fc-blue bd-b text-center align-middle not-left" >종&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</td>';
			html += '	<td colspan="4" class="fs-10 bd-b text-center align-middle not-left" ></td>';
			html += '';	
			html += '	<td colspan="3" class="fs-10 bg-b fc-blue bd-b text-center align-middle not-left" >업&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;태</td>';
			html += '	<td colspan="4" class="fs-10 bd-b text-center align-middle not-left" >제조업</td>';
			html += '	<td colspan="2" class="fs-10 bg-b fc-blue bd-b text-center align-middle not-left" >종&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</td>';
			html += '	<td colspan="4" class="fs-10 bd-b text-center align-middle not-left" >인쇄</td>';
			html += '</tr>';
			html += '<tr style="height:20px!important;">';
			html += '	<td colspan="2" class="fs-13 bg-b fc-blue bd-b text-center align-middle not-left" >번 호</td>';
			html += '	<td colspan="3" class="fs-13 bg-b fc-blue bd-b text-center align-middle not-left" >구매오더</td>';
			html += '	<td colspan="3" class="fs-13 bg-b fc-blue bd-b text-center align-middle not-left" >자재코드</td>';
			html += '	<td colspan="12" class="fs-13 bg-b fc-blue bd-b text-center align-middle not-left" >품 명</td>';
			html += '	<td colspan="2" class="fs-13 bg-b fc-blue bd-b text-center align-middle not-left" >수 량</td>';
			html += '	<td colspan="4" class="fs-13 bg-b fc-blue bd-b text-center align-middle not-left" >Rev.</td>';
			html += '	<td colspan="3" class="fs-13 bg-b fc-blue bd-b text-center align-middle not-left" >비 고</td>';
			html += '</tr>';

			for(var i = 0 ; i < paperLineCount ; i++){
				if( i % 2 == 0 ){
					html += '<tr class="bottomEmptyTr">';
					html += '	<td colspan="2" name="bizOrdDtlNo" class="h-21 fs-10 bd-b text-center align-middle not-left dtlList" ></td>'; //번 호
					html += '	<td colspan="3" name="bizBatch" class="h-21 fs-10 bd-b text-center align-middle not-left dtlList" ></td>'; //구매오더
					html += '	<td colspan="3" name="customerItemCd" class="h-21 fs-10 bd-b text-center align-middle not-left dtlList" ></td>'; //자재코드
					html += '	<td colspan="12" name="itemNm" class="h-21 fs-10 bd-b text-center align-middle not-left dtlList" ></td>'; //품 명
					html += '	<td colspan="2" class="h-21 fs-10 bd-b text-center align-middle not-left dtlList" >'; //수 량
					html += `		<input name="outQty\${i}" oninput="syncValues('outQty\${i}', this.value)" type="text" class="fs-10 bd-n fw-900 text-center p-0 w-100 bg-tr">`;
					html += '	</td>';
					html += '	<td colspan="4" name="itemVersion" class="h-21 fs-10 bd-b text-center align-middle not-left dtlList" ></td>'; //Rev.
					html += '	<td colspan="3" class="h-21 fs-10 bd-b text-center align-middle not-left dtlList" >'; //비 고
					html += `		<input name="bizDesc\${i}" oninput="syncValues('bizDesc\${i}', this.value)" type="text" class="fs-10 bd-n fw-900 text-center p-0 w-100 bg-tr">`;
					html += '	</td>';
					html += '</tr>';
				} else {
					html += '<tr class="bottomEmptyTr">';
					html += '	<td colspan="2" name="bizOrdDtlNo" class="h-21 fs-10 bg-b bd-b text-center align-middle not-left dtlList" ></td>'; //번 호
					html += '	<td colspan="3" name="bizBatch" class="h-21 fs-10 bg-b bd-b text-center align-middle not-left dtlList" ></td>'; //구매오더
					html += '	<td colspan="3" name="customerItemCd" class="h-21 fs-10 bg-b bd-b text-center align-middle not-left dtlList" ></td>'; //자재코드
					html += '	<td colspan="12" name="itemNm" class="h-21 fs-10 bg-b bd-b text-center align-middle not-left dtlList" ></td>'; //품 명
					html += '	<td colspan="2" class="h-21 fs-10 bg-b bd-b text-center align-middle not-left dtlList" >'; //수 량
					html += `		<input name="outQty\${i}" oninput="syncValues('outQty\${i}', this.value)" type="text" class="fs-10 bd-n fw-900 text-center p-0 w-100 bg-tr">`;
					html += '	</td>';
					html += '	<td colspan="4" name="itemVersion" class="h-21 fs-10 bg-b bd-b text-center align-middle not-left dtlList" ></td>'; //Rev.
					html += '	<td colspan="3" class="h-21 fs-10 bg-b bd-b text-center align-middle not-left dtlList" >'; //비 고
					html += `		<input name="bizDesc\${i}" oninput="syncValues('bizDesc\${i}', this.value)" type="text" class="fs-10 bd-n fw-900 text-center p-0 w-100 bg-tr">`;
					html += '	</td>';
					html += '</tr>';
				}
			}
			
			
			html += '<tr>';
			html += '	<td colspan="17" class="h-20 fs-13 bd-n text-start align-middle not-left">';
			html += `		<input name="dealSentence1" oninput="syncValues('dealSentence1', this.value)" value="\${dealSentenceList['담당자']}" type="text" class="fs-13 bd-n fw-900 text-start p-0 w-100">`;
			html += '	</td>';
			html += '	<td colspan="6" class="h-20 fs-13 bd-n text-start align-middle not-left">';
			html += `		<input name="dealSentence2" oninput="syncValues('dealSentence2', this.value)" value="\${dealSentenceList['TEL']}" type="text" class="fs-13 bd-n fw-900 text-start p-0 w-100">`;
			html += '	</td>';
			html += '	<td colspan="6" class="h-20 fs-13 bd-n text-start align-middle not-left">';
			html += `		<input name="dealSentence3" oninput="syncValues('dealSentence3', this.value)" value="\${dealSentenceList['FAX']}" type="text" class="fs-13 bd-n fw-900 text-start p-0 w-100">`;
			html += '	</td>';
			html += '</tr>';
			html += '<tr class="d-none" name="fscTr">';
			html += '	<td colspan="29" class="text-center fw-200 bt-n bl-n br-n bb-n h-10">*표시된 제품은 ㈜창영테크팩에서 생산된 FSC인증 제품입니다. 인증번호: SGSHK-COC-340249 인증타입: FSC Mix Credit</td>';
			html += '</tr>';
		}
		
		return html;
	}
	
	// 해당 name 속성을 가진 모든 input 요소들의 값을 업데이트
	function syncValues(targetCd, value) {
		const numericValue = value != '' ? Number(value.replace(/,/g, '')) : '';
	    const formattedValue = isNaN(numericValue) ? value : numericValue.toLocaleString(); //숫자일 경우 천자리 콤마 추가
	    $(`input[name="\${targetCd}"]`).val(formattedValue);
	}
	
	
</script>
</body>
</html>



