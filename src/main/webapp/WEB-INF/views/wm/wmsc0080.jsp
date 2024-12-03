<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/top.jsp"%>
<%@include file="../layout/modal.jsp"%>
<%@include file="../layout/script.jsp"%>
<div id="page" onmouseup="EndDrag(this)" onmousemove="OnDrag(event)" style="grid-template-areas: 'leftcol dragbarH ';
																		  grid-template-rows: 1fr;
																		  grid-template-columns: 1.1fr ;">
																	
	<div id="leftcol">	
		<div class="container-fluid h-100" style="padding: 5px;">
			<div class="row" id="leftHeader" style="padding-bottom: 5px;">
				<div class="d-flex align-items-center d-flex">
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">조회기간</label>
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
					
					<input type="text" class="form-control w-auto h-100 me-1" id="searchAll" placeholder="통합검색">
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end">
					<div class="btn-group" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnSearch"><i class="fa-regular fa-clipboard"></i></button>
						<!-- <button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnOpen">
							<i class="fa-solid fa-caret-left"></i>
						</button> -->
					</div>
				</div>
			</div>
			<div class="row">
				<table class="table table-bordered p-0 m-0" id="dailyWorkResultTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle">작업자<br>(부서)</th>
							<c:forEach items="${workList}" var="data">
								<th class="text-center align-middle">${data.commonNm}</th>
							</c:forEach>
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
	let isDraggingV = false; // 세로 드래그 여부
	let isDraggingH = false; // 가로 드레그 여부
	
	function SetCursor(cursor) {
		let page = document.getElementById("page");
		page.style.cursor = cursor;
	}
	
	function StartDrag(type) {
		//if(type == 'VT') { isDraggingVT = true; SetCursor("n-resize");}
		//if(type == 'VB') { isDraggingVB = true; SetCursor("n-resize");}
		if(type == 'V') { isDraggingV = true; SetCursor("n-resize");}
		if(type == 'H') { isDraggingH = true; SetCursor("ew-resize");}
	}
	
	function EndDrag(e) {
		if(isDraggingV || isDraggingH) {
			dataTableDrawAll(); // dataTable 전체 reload
			//isDraggingVT = false;
			//isDraggingVB = false;
			isDraggingV = false;
			isDraggingH = false;
			SetCursor("auto");
		}
	}
	
	function OnDrag(event) {
		if (isDraggingH) { // 좌우 스크롤
			let page = document.getElementById("page");
			let leftcol = document.getElementById("leftcol"); // 좌측
			let rightcolT = document.getElementById("rightcolT"); // 우측 상단
			//let rightcolM = document.getElementById("rightcolM"); // 우측 중단
			let rightcolB = document.getElementById("rightcolB"); // 우측 하단
			let dragbarWidth = 4;
			let leftcolMinWidth = 20; // leftcol 최소사이즈
			$('#leftHeader').children().each(function(index, item) {
				leftcolMinWidth += $(item).width();
			});
			let rightcolMinWidth = 500; // rightcol 최소사이즈
	
			let rightColWidth = page.clientWidth - parseInt(Math.max(leftcolMinWidth + 120, event.clientX));
			
			let cols = [
				parseInt(Math.max(leftcolMinWidth, page.clientWidth - dragbarWidth - parseInt(Math.max(rightColWidth, rightcolMinWidth)))),
				dragbarWidth,
				parseInt(Math.max(rightColWidth, rightcolMinWidth))
			];
	
			let newColDefn = cols.map(c => c.toString() + "px").join(" ");
			//console.log(newColDefn);
	
			page.style.gridTemplateColumns = newColDefn;
	
			event.preventDefault();
		} else if (isDraggingV) { // rightcolT와 rightcolB 사이
			let dragbarWidth = 4;

			let page_height = parseInt($('#page').height()); 			// 전체 높이
			let rightcolT_height = parseInt($('#rightcolT').height());	// 우측 상단
			let rightcolB_height = parseInt($('#rightcolB').height());	// 우측 하단

			let rightcolT_min_height = 100;	// 우측 상단 최소높이
			let rightcolB_min_height = 34;	// 우측 하단 최소높이

			let cursorY = event.clientY;	// 현재 cursor y좌표(위에서부터 얼마나 떨어졌는지)
			//console.log(cursorY);
			//console.log(page_height - rightcolB_height - dragbarWidth);
			
			let cols = [
				Math.min(Math.max(rightcolT_min_height, cursorY), page_height - rightcolB_min_height - dragbarWidth),
				dragbarWidth,
				page_height - dragbarWidth - Math.min(Math.max(rightcolT_min_height, cursorY), page_height - rightcolB_min_height - dragbarWidth),
			];
			
			//console.log(cols);
	
			let newColDefn = cols.map(c => c.toString() + "px").join(" ");

			$('#page').css('grid-template-rows',newColDefn);
	
			event.preventDefault();
		}
	}

	function minimum(node) {
		let id = $(node).attr('id');

		if(id == 'dragbarV') {
			let dragbarWidth = 4;

			let page_height = parseInt($('#page').height()); 			// 전체 높이
			let rightcolT_height = parseInt($('#rightcolT').height());	// 우측 상단
			let rightcolB_height = parseInt($('#rightcolB').height());	// 우측 하단

			let rightcolT_min_height = 100;	// 우측 상단 최소높이
			let rightcolB_min_height = 34;	// 우측 하단 최소높이

			let dragbarV_height = 4;

			let cols = [];

			//최소화기능만 적용
			cols = [
				page_height - rightcolB_min_height - dragbarWidth,
				dragbarWidth,
				rightcolB_min_height
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
			
			/* if(rightcolB_height == rightcolB_min_height) { // 원위치
				cols = [
					rightcolT_height,
					dragbarWidth,
					rightcolM_min_height,
					dragbarWidth,
					page_height - rightcolT_height - rightcolM_min_height - dragbarWidth*2
				];
			} else { // 최소화
				cols = [
					rightcolT_height,
					dragbarWidth,
					page_height - rightcolT_height - rightcolB_min_height - dragbarWidth*2,
					dragbarWidth,
					rightcolB_min_height
				];
			} */
			
			
			let newColDefn = cols.map(c => c.toString() + "px").join(" ");
			
			$('#page').css('grid-template-rows',newColDefn);
		}
		
		dataTableDrawAll(); // dataTable 전체 reload */
	}
	
	$('#btnOpen').on('click',function() { // right-box 열기버튼 클릭
		if($('#rightcolT').hasClass('d-none')){
			$('#page').css('grid-template-columns', '1.1fr 4px 1fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcolT').removeClass('d-none');
		} else {
			$('#page').css('grid-template-columns', '0fr 4px 1fr');
			$('#leftcol').addClass('d-none');
			$('#rightcolT').removeClass('d-none');
		}
		dataTableDrawAll(); // dataTable 전체 reload
	});
	$('#btnClose').on('click',function() { // right-box 닫기버튼 클릭
		if($('#leftcol').hasClass('d-none')){
			$('#page').css('grid-template-columns', '1.1fr 4px 1fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcolT').removeClass('d-none');
		} else {
			$('#page').css('grid-template-columns', '1.1fr 4px 0fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcolT').addClass('d-none');
		}
		dataTableDrawAll(); // dataTable 전체 reload
	});
</script>

<script>

	let monthAdjustList = getCommonCode('시스템', '026'); //날짜조정
	monthAdjustList = _.sortBy(monthAdjustList, v=>parseInt(v.commonCd));
	selectBoxAppend(monthAdjustList, 'monthAdjust', '', '2'); //날짜조정
	
	// 공통코드 조회
	//let dealGubunList = getCommonCode('시스템', '011'); // 거래구분

	let selectPeriod = parseInt(getCommonCode('시스템', '040')[0].commonCd); //기본조회기간 일
	$('#startDate').val(moment().subtract('d',selectPeriod).format('YYYY-MM-DD'));
	$('#endDate').val(moment().format('YYYY-MM-DD'));

	$('#btnSearch').on('click',function(){
		dailyWorkResultTable.ajax.reload();
	});
	
	/****************************** 테이블 모음집   ******************************/
	// 발주정보 발주번호 그룹 테이블
	$('#dailyWorkResultTable thead tr').clone(true).addClass('filters').appendTo('#dailyWorkResultTable thead'); // filter 생성
	let dailyWorkResultTable = $('#dailyWorkResultTable').DataTable({
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
			url : '<c:url value="/wm/dailyWorkResultLstByWorkId"/>',
			type : 'POST',
			data : {
				'startDate'	:	function(){ return $('#startDate').val(); },
				'endDate'	:	function(){ return $('#endDate').val(); },
			},
		},
        rowId: '',
		columns : [
			{ data: 'date', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != '' && data != null){
						if(row['dayOfWeek'].slice(0,1) == '일'){
							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;color:red;">'+moment(data).format('YYYY-MM-DD') + ' (' + row['dayOfWeek'].slice(0,1) +')</div>';
						} else if(row['dayOfWeek'].slice(0,1) == '토'){
							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;color:blue;">'+moment(data).format('YYYY-MM-DD') + ' (' + row['dayOfWeek'].slice(0,1) +')</div>';
						} else {
							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data).format('YYYY-MM-DD') + ' (' + row['dayOfWeek'].slice(0,1) +')</div>';
						}
					} else {
						return '-';
					}
				}
			},
			<c:forEach items="${workList}" var="list">
			{ className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseInt(row['col'+'${list.etc2}']))+'</div>';
				}
			},
			</c:forEach>
		],
		columnDefs : [
			//{
			//	targets: [0],
			//	render: function(data) {
			//		return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
			//	}
			//}
		],
		/* rowsGroup: [
			'purchaseOrdNo:name'
	 	], */
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
			
			let htmlHeight = parseFloat($('#leftcol').css('height'));
			let headHeight = parseFloat($('#leftHeader').css('height'));
			let theadHeight = parseFloat($('#dailyWorkResultTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - headHeight - theadHeight - 45)+'px');
			
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
				let cell = $('#dailyWorkResultTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#dailyWorkResultTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
			dailyWorkResultTable.draw();
		},
	});
	// dataTable colReorder event
	dailyWorkResultTable.on('column-reorder', function( e, settings, details ) {
		let api = dailyWorkResultTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#dailyWorkResultTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});


	function test(){
		$.ajax({
			url: '<c:url value="/wm/dailyWorkResultLstByWorkId"/>',
            type: 'POST',
            data: {
            	'startDate'	:	function(){ return $('#startDate').val(); },
			'endDate'	:	function(){ return $('#endDate').val(); },
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					console.log(res.data)
					
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
	}

	
	
</script>
</body>
</html>
