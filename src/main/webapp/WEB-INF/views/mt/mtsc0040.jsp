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
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">수주접수일</label>
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
						<option value="">전체</option>
						<option value="N" selected>진행중</option>
					</select>
					
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100" style="background-color: #fadcdc;">컨펌대기, 수주중지</label>
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100" style="background-color: #fffadc;">긴급수주</label>
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100" style="background-color: #ffb4b4;">수량부족</label>
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100" style="background-color: #e9ecef; color: #000000;">대기</label>
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100" style="background-color: #007bff; color: #ffffff;">진행</label>
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100" style="background-color: #28a745; color: #ffffff;">완료</label>
					<input type="text" class="form-control w-auto h-100 me-1" id="searchAll" placeholder="통합검색" >
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end">
					<div class="btn-group me-3" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto" id="btnBizDtlPoEnd">PO완료</button>
					</div>
				
					<div class="btn-group" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnSearch"><i class="fa-regular fa-clipboard"></i></button>
					</div>
				</div>
			</div>
			<div class="row">
				<table class="table table-bordered p-0 m-0" id="bizOrderTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle">수주접수일</th>
							<th class="text-center align-middle">수주상세번호</th>
							<th class="text-center align-middle">고객사</th>
							<th class="text-center align-middle" style="min-width:200px;max-width:200px;">제품명</th>
							<th class="text-center align-middle">수주상태</th>
							<th class="text-center align-middle">진행상태</th>
							<th class="text-center align-middle">수주수량</th>
							<th class="text-center align-middle">목표요구일</th>
							<th class="text-center align-middle">출고요청일</th>
							<th class="text-center align-middle">버전</th>
							
							<th class="text-center align-middle">지시수량</th>
							<th class="text-center align-middle">생산수량</th>
							<!-- <th class="text-center align-middle">생산완료일</th> -->
							<th class="text-center align-middle">출고수량</th>
							<th class="text-center align-middle">출고일</th>
							<th class="text-center align-middle" style="min-width:400px;">공정현황</th>
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
			url : '<c:url value="/mt/prcssProgressStatusLst"/>',
			type : 'POST',
			data : {
				startDate	: function() { return moment($('#startDate').val(),'YYYY-MM-DD').format('YYYYMMDD'); },
				endDate		: function() { return moment($('#endDate').val(),'YYYY-MM-DD').format('YYYYMMDD'); },
				searchTarget	:	function() { return $('#searchTarget').val(); },
			},
		},
        rowId: '',
		columns : [
			{ data: 'bizOrdDate', className : 'text-center align-middle',//수주접수일
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data).format('YYYY-MM-DD')+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'bizOrdDtlNo', className : 'text-center align-middle', //수주상세번호
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ data: 'bizOrdDealCorpNm', className : 'text-center align-middle',//고객사
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'itemNm', className : 'text-center align-middle',
				render: function(data, type, row, meta) {
					if(data != null && data != ''){
						let jsonData = JSON.parse(row['workPrcssStatusJson']);
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
			},
			{ data: 'bizStatusNm', className : 'text-center align-middle', //수주상태
				render: function(data, type, row, meta) {
					if(data != null && data != ''){
						if(data == '수주취소' || data == 'PO완료'){
							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						} else if(row['bizStopYn'] == 'Y'){
							return '수주중지';
						} else {
							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						}
					} else {
						return '-';
					}
				}
			},
			{ className : 'text-center align-middle',//진행상태
				render: function(data, type, row, meta) {
					let returnValue = '';
					if( row['etc9'] == 'N' ){
						let outQty = isEmptyCheck(row['outQty']) ? 0 : parseFloat(row['outQty']);
						let bizOrdQty = isEmptyCheck(row['bizOrdQty']) ? 0 : parseFloat(row['bizOrdQty']);
						if( outQty < bizOrdQty ){
							returnValue = '출고대기';
						} else {
							returnValue = '출고완료';
						}
					} else {
						if( row['confirmDesign'] == 'N' || row['confirmDesign'] == null || row['confirmDesign'] == '' ){
							returnValue = '컨펌대기';
						} else {
							if( row['workOrdNo'] != null && row['workOrdNo'] != '' ){
								//작업지시가 된 경우
								if( isEmptyCheck(row['workResultIdx']) ){
									//마지막공정의 생산실적식별자가 없는 경우 -> 공정진행중
									// 					   있는 경우 -> 공정 완료
									returnValue = '공정 진행 중';
								} else {
									//마지막 공정 완료여부
									let prcssStatus = isEmptyCheck(row['prcssStatus']) ? '' : row['prcssStatus'];
									if(prcssStatus == 'WC'){
										let outQty = isEmptyCheck(row['outQty']) ? 0 : parseFloat(row['outQty']);
										let bizOrdQty = isEmptyCheck(row['bizOrdQty']) ? 0 : parseFloat(row['bizOrdQty']);
										if( outQty < bizOrdQty ){
											returnValue = '출고대기';
										} else {
											returnValue = '출고완료';
										}
									} else {
										returnValue = '공정 진행 중';
									}
								}
							} else {
								//작업지시가 안된 경우
								if( row['stockUseYn'] == 'Y' ){
									//수주가 재고사용 수주인 경우 컨펌대기 이후 바로 출고대기상태로 판별
									let outQty = isEmptyCheck(row['outQty']) ? 0 : parseFloat(row['outQty']);
									let bizOrdQty = isEmptyCheck(row['bizOrdQty']) ? 0 : parseFloat(row['bizOrdQty']);
									if( outQty < bizOrdQty ){
										returnValue = '출고대기';
									} else {
										returnValue = '출고완료';
									}
								} else {
									//수주가 재고사용이 아닐 경우 원지대기인지 아닌지 판별
									if( row['inQtyCheck'] == '0'){
										returnValue = '(작업)지시대기';
									} else {
										returnValue = '원지대기';
									}
									
								}
							}
						}
					}
					
					return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+returnValue+'</div>';
				}
			},
			{ data: 'bizOrdQty', className : 'text-end align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'workEndReqDate', className : 'text-center align-middle',//목표요구일
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data).format('YYYY-MM-DD')+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'outReqDate', className : 'text-center align-middle',//출고요청일
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data).format('YYYY-MM-DD')+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'itemVersionNm', className : 'text-center align-middle',//버전번호
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},
			
			{ data: 'workOrdQty', className : 'text-end align-middle',//지시수량
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'workFairQty', className : 'text-end align-middle',//생산수량
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
					} else {
						return '';
					}
				}
			},
			/* { data: 'workEndDate', className : 'text-center align-middle',//생산완료일
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data).format('YYYY-MM-DD')+'</div>';
					} else {
						return '';
					}
				}
			}, */
			{ data: 'outQty', className : 'text-end align-middle',//출고수량
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'outDate', className : 'text-center align-middle',//출고일
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data).format('YYYY-MM-DD')+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'workPrcssStatusJson', className : 'text-center align-middle',//생산현황
				render: function(data) {
					if(data != null && data != ''){
						let jsonData = JSON.parse(data);
						let html = '';
						html += '<div class="progress">';
						for( var i = 0; i < jsonData.length; i++){
							let prcssNm = jsonData[i].prcssNm;
							let workStatus = jsonData[i].progressStatus;
							let color = '';
							let backgroundColor = '';
							if(workStatus == 'PI') { //대기
								color = '#000000';
								backgroundColor = '#e9ecef';
							} else if(workStatus == 'WI') { //진행중
								color = '#ffffff';
								backgroundColor = '#007bff';
							} else if(workStatus == 'WC') { //완료
								color = '#ffffff';
								backgroundColor = '#28a745';
							}/*  else if(workStatus == 'DT') { //비가동
								color = '#ffffff';
								backgroundColor = '#ffc107';
							} else if(workStatus == 'FQ') { //강제종료
								color = '#ffffff';
								backgroundColor = '#dc3545';
							}  */else {
								color = '#ffffff';
								backgroundColor = '#e9ecef';
							}
							html += '	<div class="progress-bar" role="progressbar"';
							html += '		style="white-space: nowrap; overflow: visible; width:100%;';
							html +=	'		background-color:'+backgroundColor+'; color:'+color+';" aria-valuemax="100">'+prcssNm+'</div>';
						}
						html += '</div>';
						return html;
					} else {
						return '';
					}
				}
			},
		],
		columnDefs : [],
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
			
			for(var i=0;i<api.data().count();i++) {
				let data = api.row(i).data();
				let node = api.row(i).node();

				
				if(data.workFairQty != null && parseInt(removeCommas(data.bizOrdQty)) > parseInt(removeCommas(data.workFairQty))){ //수량부족
					$(node).addClass('fw-bolder');
					$(node).css('background-color','#ffb4b4');
				}  
				if(data.ordGubun == '20') {
					$(node).addClass('fw-bolder');
					$(node).css('background-color','#fffadc');
				}
				if(data.confirmDesign != 'Y' || data.bizStopYn == 'Y'){
					$(node).addClass('fw-bolder');
					$(node).css('background-color','#fadcdc');
				}
				
			}
			try {
				bizOrderTable.columns.adjust();
			} catch(e){
				//console.log('테이블 생성전');
			}
			$('.bootstrapToggle').bootstrapToggle();
			
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
		bizOrderTable.ajax.reload(function() {});

		setTimeout(function() {
			$('#my-spinner').hide();
		}, 100)
	});

	/********************* po완료 *********************/
	$('#btnBizDtlPoEnd').on('click',function(){
		if($('#bizOrderTable tbody').find('tr.selected').length == 0) {
			toastr.warning('PO완료할 항목을 선택해주세요.');
			return false;
		}		
		
		$('#bizDtlPoEndModal').modal('show');
	});

	$('#btnBizDtlPoEndY').on('click',function(){
		$.ajax({
			url: '<c:url value="/bs/bizOrderDtlPoEnd"/>',
            type: 'POST',
            data: {
                'bizOrdDtlIdx'	:	function(){ return bizOrderTable.row('.selected').data().bizOrdDtlIdx; },
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					toastr.success('PO 완료 되었습니다.');
					bizOrderTable.row('.selected').deselect();
					bizOrderTable.ajax.reload(function(){},false);
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
					bizOrderTable.row('.selected').deselect();
					bizOrderTable.ajax.reload(function(){},false);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
	});
</script>

</body>
</html>
