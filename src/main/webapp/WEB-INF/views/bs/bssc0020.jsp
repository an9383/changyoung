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
					
					
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">수주확정</label>
					<select class="form-select w-auto h-100 me-3" id="searchConfirmDesign" style="min-width: 70px;">
						<option value="" selected="">전체</option>
						<option value="Y">확정</option>
						<option value="N">미확정</option>
					</select>
					
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">조회대상</label>
					<select class="form-select w-auto h-100 me-3" id="searchTarget" style="min-width: 70px;">
						<option value="" selected="">전체</option>
						<option value="Y">출고완료</option>
					</select>
					
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100 bg-warning bg-gradient">긴급</label>
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100 bg-danger bg-gradient">미확정</label>
					<input type="text" class="form-control w-auto h-100 me-1" id="searchAll" placeholder="통합검색" >
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end">
					<div class="btn-group" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnSearch"><i class="fa-regular fa-clipboard"></i></button>
					</div>
				</div>
			</div>
			<div class="row">
				<table class="table table-bordered p-0 m-0" id="bizOrderTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle">수주확정</th>
							<th class="text-center align-middle">수주상세번호</th>
							<th class="text-center align-middle">고객사</th>
							<th class="text-center align-middle">제품명</th>
							<th class="text-center align-middle">자재코드</th>
							<th class="text-center align-middle">버전번호</th>
							<th class="text-center align-middle">수주수량</th>
							<th class="text-center align-middle">재질</th>
							<th class="text-center align-middle">이론량®</th>
							<th class="text-center align-middle">발주량®</th>
							<th class="text-center align-middle">절수</th>
							<th class="text-center align-middle">개수</th>
							<th class="text-center align-middle">총여분</th>
							<th class="text-center align-middle">이론통수</th>
							<th class="text-center align-middle">건별전달사항</th>
							<th class="text-center align-middle">특이사항</th>
							<th class="text-center align-middle">COLOR</th>
							<th class="text-center align-middle">코팅</th>
							<th class="text-center align-middle">목표 요구일</th>
							<th class="text-center align-middle">출고 요청일</th>
							<th class="text-center align-middle">BOX수량</th>
							<th class="text-center align-middle">발주번호/BATCH</th>
							<th class="text-center align-middle">출고량</th>
							<th class="text-center align-middle">수주비고</th>
							<th class="text-center align-middle colvisHide">목형관리번호</th>
							<th class="text-center align-middle">수지판</th>
							<th class="text-center align-middle">성형방식</th>
							<th class="text-center align-middle">재고</th>
							<th class="text-center align-middle">칼끝규격</th>
							<th class="text-center align-middle">사이즈</th>
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
		colReorder: false,
		select: {
            style: 'single',
            toggleable: false,
            items: 'row',
            info: false
        },
        ajax : {
			url : '<c:url value="/bs/bizOrderStatusLst"/>',
			type : 'POST',
			data : {
				startDate		: function() { return moment($('#startDate').val(),'YYYY-MM-DD').format('YYYYMMDD'); },
				endDate			: function() { return moment($('#endDate').val(),'YYYY-MM-DD').format('YYYYMMDD'); },
				confirmDesign 	: function() { return $('#searchConfirmDesign').val(); },
				searchTarget	: function() { return $('#searchTarget').val(); },
			},	
		},
        rowId: 'idx',
		columns : [
			{ data: 'confirmDesign', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data == 'Y') {
						let html = '';
						html += '<input type="checkbox" class="bootstrapToggle confirmToggle p-0" data-toggle="toggle"';
						html += '		data-type="confirmDesign" data-idx="'+row['idx']+'"';
						html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
						html += '		data-size="small"';
						html += '		checked>';
						return html;
					} else {
						let html = '';
						html += '<input type="checkbox" class="bootstrapToggle confirmToggle p-0" data-toggle="toggle"';
						html += '		data-type="confirmDesign" data-idx="'+row['idx']+'"';
						html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
						html += '		data-size="small"';
						html += '		>';
						return html;
					}
				}
			},
			{ data: 'bizOrdDtlNo', className : 'text-center align-middle', name: 'rowspan' },
			{ data: 'dealCorpNm', className : 'text-center align-middle', name: 'rowspan' },
			{ data: 'itemNm', className : 'text-center align-middle', name: 'rowspan' },
			{ data: 'customerItemCd', className : 'text-center align-middle', name: 'rowspan' },
			{ data: 'itemVersion', className : 'text-center align-middle', name: 'rowspan',
				render : function(data, type, row, meta) {
					let obj = "";
						obj += "{";
						obj += "	'uuid':'"+row['uuid']+"',";
						obj += "	'fileName':'"+row['fileNm']+"',";
						obj += "	'ext':'"+row['ext']+"'";
						obj += "}";
					let html = '';
					if(row['uuid'] == '' || row['uuid'] == null) {
						html += '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						html += '<a href="/serverFile/'+row['uuid']+'.'+row['ext']+'" target="_blank">'+data+'</a>';
					}
						
					return html;
				}
			},
			{ data: 'ordQty', className : 'text-end align-middle', name: 'rowspan',
				render : function(data, type, row, meta) {
					return addCommas(parseInt(data));
				}
			},
			{ data: 'paperType', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != '' && data != null) {
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data.replaceAll(/\n/g,'<br>')+'</div>';
					} else {
						return '';
					}
				}
			},
			{ className : 'text-end align-middle', // 발주량 R
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
	
						if(cutQty == 0 || row['cutQty'] == null || eaQty == 0 || row['eaQty'] == null) {
							return '0';
						} else {
							let cuttingSize = Math.ceil(ordQty/(cutQty*eaQty));
							let R = parseInt(cuttingSize / 500); // R로 환산
							let purchaseQty = R + "R" + (cuttingSize % 500);
							
							return purchaseQty;
						}
					//}
				}
			},
			{ className : 'text-end align-middle', // 최종발주량
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
						
						if(cutQty == 0 || row['cutQty'] == null || eaQty == 0 || row['eaQty'] == null) {
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
			{ data: 'cutQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return addCommas(parseInt(data));
					} else {
						return '0';
					}
				}
			},
			{ data: 'eaQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return addCommas(parseInt(data));
					} else {
						return '0';
					}
				}
			},
			{ data: 'extraQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						let extraQty = parseInt(data);
						let extraPackQty = parseInt(row['extraPackQty']);
						return addCommas(extraQty + extraPackQty);
					} else {
						return '0';
					}
				}
			},
			{ className : 'text-end align-middle', // 정매인쇄통수 = 이론통수
				render : function(data, type, row, meta) {
					let ordQty = parseInt(row['purchaseOrdQty']); // 주문수량(제품)
					let cutQty = parseInt(row['cutQty']); // 절수
					let eaQty = parseInt(row['eaQty']); // 개수
					let extraQty = parseInt(row['extraQty']); // 여유분

					if(cutQty == 0 || row['cutQty'] == null || eaQty == 0 || row['eaQty'] == null) {
						return '0';
					} else {
						//let printPressQty = Math.ceil(ordQty/eaQty);
						let printPressQty = Math.ceil(ordQty/(cutQty*eaQty)) * cutQty;
						return addCommas(printPressQty);
					}
				}
			},
			{ data: 'ordNote', className : 'text-left align-middle',
				render : function(data, type, row, meta) {
					if(data != '' && data != null) {
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data.replaceAll(/\n/g,'<br>')+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'ordIssue', className : 'text-left align-middle',
				render : function(data, type, row, meta) {
					if(data != '' && data != null) {
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data.replaceAll(/\n/g,'<br>')+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'itemColor', className : 'text-center align-middle'},
			{ data: 'coatingMethod', className : 'text-center align-middle'},
			{ data: 'workEndReqDate', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != '' && data != null) {
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data,'YYYYMMDD').format('YYYY-MM-DD')+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'outReqDate', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != '' && data != null) {
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data,'YYYYMMDD').format('YYYY-MM-DD')+'</div>';
					} else {
						return '';
					}
				}
			},
			{ className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					/* let ordQty = parseInt(row['purchaseOrdQty']); // 주문수량(제품)
					let cutQty = parseInt(row['cutQty']); // 절수
					let eaQty = parseInt(row['eaQty']); // 개수
					let extraQty = parseInt(row['extraQty']); // 여유분
					let extraPackQty = parseInt(row['extraPackQty']); // 포장단위여분 */
					let packUnit = (row['packUnit']=='' ||  parseInt(row['packUnit'])==0) ? 1 : isNaN(row['packUnit']) ? 1 : parseInt(row['packUnit']);
					/* if(cutQty == 0 || row['cutQty'] == null || eaQty == 0 || row['eaQty'] == null) {
						return '0';
					} else {
						let printPressQty = Math.ceil(ordQty/eaQty);
						let pressQty = Math.ceil((printPressQty + extraQty + extraPackQty)/cutQty); //통수
					 */	return addCommas(Math.ceil(row['ordQty']/packUnit));
					//}
				}
			},//BOX수량
			{ data: 'purchaseBatch', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != '' && data != null) {
						return data;
					} else {
						return '';
					}
				}
			},//발주번호/BATCH
			{ data: 'outQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if(data != '' && data != null){
						return addCommas(parseFloat(data));
					} else {
						return '0';
					}	
				}
			},//출고량
			{ data: 'ordDesc', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != '' && data != null) {
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'woodenCareNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != '' && data != null) {
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'resinBoardNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != '' && data != null) {
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'moldingMethod', className : 'text-center align-middle'},
			{ data: 'spQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if(data != '' && data != null){
						return addCommas(parseFloat(data));
					} else {
						return '0';
					}					
				}
			},//재고량
			{ data: 'knifeTipSize', className : 'text-center align-middle'},
			{ data: 'itemSize', className : 'text-center align-middle'},
		],
		/* rowsGroup: [
			'rowspan:name'
	 	], */
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
				if(data.ordGubun == '20') {
					$(node).addClass('bg-warning bg-gradient');
				} else if(data.confirmDesign == 'N') {
					$(node).addClass('bg-danger bg-gradient');
				}

				if( data.bizStatusCd == '03' ) {
					$(node).find('.bootstrapToggle').bootstrapToggle('disable');
				}
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
				$(this).trigger('keyupTrigger');
			});
		});
	});

	// 조회 버튼 click
	$('#btnSearch').on('click', function() {
		$('#my-spinner').show();
		bizOrderTable.ajax.reload(function() {}, false);

		setTimeout(function() {
			$('#my-spinner').hide();
		}, 100)
	});


	// 수주확정, 디자인컨펌
	$(document).off('change','#bizOrderTable .confirmToggle');
	$(document).on('change','#bizOrderTable .confirmToggle', function() {
		let idx = $(this).data('idx');
		let type = $(this).data('type');
		let check = $(this).prop('checked');

		
		let ajaxData = {};
		ajaxData.idx = idx;
		ajaxData.confirmDesign = (check?'Y':'N');
		ajaxData.confirmOrder = ajaxData.confirmDesign;

		
		$.ajax({
			url: '<c:url value="/bs/bizOrderDtlUpd"/>',
			type: 'POST',
			data: ajaxData,
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
					bizOrderTable.ajax.reload(function(){},false);
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
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
