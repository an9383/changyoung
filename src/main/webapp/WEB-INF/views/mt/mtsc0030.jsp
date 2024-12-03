<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/top.jsp"%>
<%@include file="../layout/modal.jsp"%>
<%@include file="../layout/script.jsp"%>
<div id="page" onmouseup="EndDrag(this)" onmousemove="OnDrag(event)" style="grid-template-areas: 'leftcol dragbar rightcol'
																									/* 'leftcol dragbarH dragbarV' */
																									/* 'leftcol dragbarH rightcolB' */;
																		 /*  grid-template-rows: 1fr 4px 1fr; */
																		   grid-template-columns: 2fr 4px 5fr;">
																	
	<div id="leftcol">	
		<div class="container-fluid h-100" style="padding: 5px;">
			<div class="row" id="leftHeader" style="padding-bottom: 5px;">
				<div class="d-flex align-items-center d-flex">
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">기준년도</label>
					<select class="form-select w-auto h-100 me-3" id="startDate">
					</select>
					<input type="text" class="form-control w-auto h-100 me-1" id="searchAllPt" placeholder="통합검색" >
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end">
					<div class="btn-group" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnSearch"><i class="fa-regular fa-clipboard"></i></button>
					</div>
				</div>
			</div>
			<div class="row">
				<table class="table table-bordered p-0 m-0" id="produceTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle">생산년월</th>
							<th class="text-center align-middle">양품수량</th>
							<th class="text-center align-middle">불량수량</th>
							<th class="text-center align-middle">불량률</th>
						</tr>
					</thead>
					<tfoot>
						<tr>
							<th class="text-center align-middle">총합계</th>
							<th class="text-end align-middle" id="fairQtySum"></th>
							<th class="text-end align-middle" id="faultyQtySum"></th>
							<th class="text-end align-middle" id="faultyQtyPercent"></th>
						</tr>
					</tfoot>
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
				<div class="d-flex align-items-center justify-content-end w-100" id ="abc">
				</div>
			</div>
			<div class="row" id="rightBody">
				<div style="width: 100%;">
					<div class="nav nav-tabs" id="nav-tab">
						<button class="nav-link active" id="tab1Nav" data-bs-toggle="tab" data-bs-target="#tab1">제품별 불량률</button>
				  	</div>
					<div class="tab-content" id="nav-tabContent">
						<div class="tab-pane fade show active" id="tab1">
							<div class="row" style="padding: 5px;">
								<div class="d-flex align-items-center d-flex">
									<input type="text" class="form-control w-auto h-100 me-1" id="searchAllPit" placeholder="통합검색" >
								</div>
								<table class="table table-bordered p-0 m-0" id="produceItemTable">
									<thead class="table-light">
										<tr>
											<th class="text-center align-middle">생산년월</th>
											<th class="text-center align-middle">제품명</th>
											<th class="text-center align-middle">양품수량</th>
											<th class="text-center align-middle">불량수량</th>
											<th class="text-center align-middle">불량률</th>
										</tr>
									</thead>
									<tfoot>
										<tr>
											<th class="text-center align-middle" colspan='2'>총합계</th>
											<th class="text-end align-middle" id="itemFairQtySum"></th>
											<th class="text-end align-middle" id="itemFaultyQtySum"></th>
											<th class="text-end align-middle" id="itemFaultyQtyPercent"></th>
										</tr>
									</tfoot>
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
			let leftcolMinWidth = 250; // leftcol 최소사이즈
			$('#leftHeader').children().each(function(index, item) {
				leftcolMinWidth += $(item).width();
			});
			let rightcolMinWidth = 500; // rightcol 최소사이즈
	
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
		$('#page').css('grid-template-columns', '2fr 4px 5fr');
		$('#rightcol').removeClass('d-none');
		dataTableDrawAll(); // dataTable 전체 reload
	});
	$('#btnClose').on('click',function() { // right-box 닫기버튼 클릭
		$('#page').css('grid-template-columns', '1fr');
		$('#rightcol').addClass('d-none');
		dataTableDrawAll(); // dataTable 전체 reload
	});
</script>

<script>
	//WM_init('new');
	//WM_init('edit');
	// 공통코드 조회
	//let repairCdList  = getCommonCode('일반', '029'); //수리코드
	//selectBoxAppend(repairCdList, 'repairCd', '', '2');

	//let equipIdxVal = '';
	//let tableChoice = 0;
	
	for(var i = 2022; i <=2122; i++){
		$('#startDate').append('<option value="'+i+'">'+i+'년</option>')	;	
	}

	$('#startDate').val(moment().format('YYYYMMDD').substr(0,4));
	let itemStartDate = '';
	
	$('#produceTable thead tr').clone(true).addClass('filters').appendTo('#produceTable thead'); // filter 생성
	let produceTable = $('#produceTable').DataTable({
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
			url : '<c:url value="/mt/defectiveRateAdmLst"/>',
			type : 'POST',
			data : {
				startDate	: function() { return $('#startDate').val(); },
			},
		},
       // rowId: 'idx',
		columns : [
			{ data: 'ordDate', className : 'text-center align-middle',//생산년월
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data+'01').format('YYYY-MM')+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'fairQtySum', className : 'text-end align-middle',name:'fairQtySum',//양품수량
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'faultyQtySum', className : 'text-end align-middle',name:'faultyQtySum',//불량수량
				render: function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
					} else {
						return '';
					}
				}
			},
			{ className : 'text-end align-middle',//불량률
				render: function(data, type, row, meta) {
					let fairQtySum = isEmptyCheck(row['fairQtySum']) ? 0 : row['fairQtySum'];
					let faultyQtySum = isEmptyCheck(row['faultyQtySum']) ? 0 : row['faultyQtySum'];
					let qtySum = parseFloat(fairQtySum) + parseFloat(faultyQtySum);
					let percent;
					if( qtySum > 0){
						percent = faultyQtySum / qtySum * 100;
					} else {
						percent = 0;
					}
					return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(percent).toFixed(2))+'%</div>';
				}
			},
			
		],
		columnDefs : [
			/* {
				targets: '_all',
				render: function(data) {
					return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
				} 
			} */
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
			let theadHeight = parseFloat($('#produceTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 113)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAllPt').off('keyup',function() {});
			$('#searchAllPt').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			});
			$('#produceTable tfoot').remove();
			let fairQtySum = api.column( $('#produceTable').DataTable().column('fairQtySum:name').index(), {page:'current'} ).data().sum();
			let faultyQtySum = api.column( $('#produceTable').DataTable().column('faultyQtySum:name').index(), {page:'current'} ).data().sum();
			let faultyQtyPercent;
			if(fairQtySum+faultyQtySum > 0){
				faultyQtyPercent = faultyQtySum/(fairQtySum+faultyQtySum) * 100;
			} else {
				faultyQtyPercent = 0;
			}
				
			$('#fairQtySum').html(addCommas(fairQtySum));
			$('#faultyQtySum').html(addCommas(faultyQtySum));
			$('#faultyQtyPercent').html(faultyQtyPercent.toFixed(2) +'%');
			
		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#produceTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#produceTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
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
	produceTable.on('column-reorder', function( e, settings, details ) {
		let api = produceTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#produceTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});
	//select
	$('#produceTable tbody').on('click','tr', function() {
		itemStartDate = produceTable.row(this).data().ordDate;
		produceItemTable.ajax.reload();
	});
	
	
	$('#produceItemTable thead tr').clone(true).addClass('filters').appendTo('#produceItemTable thead'); // filter 생성
	let produceItemTable = $('#produceItemTable').DataTable({
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
			url : '<c:url value="/mt/defectiveRateItemDtlLst"/>',
			type : 'POST',
			data : {
				startDate	: function() { return itemStartDate; },
			},
		},
       // rowId: 'idx',
		columns : [
			{ data: 'ordDate', className : 'text-center align-middle',//생산년월
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data+'01').format('YYYY-MM')+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'itemNm', className : 'text-center align-middle',//생산년월
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'fairQtySum', className : 'text-end align-middle',name:'fairQtySum',//양품수량
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'faultyQtySum', className : 'text-end align-middle',name:'faultyQtySum',//불량수량
				render: function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
					} else {
						return '';
					}
				}
			},
			{ className : 'text-end align-middle',//불량률
				render: function(data, type, row, meta) {
					let fairQtySum = isEmptyCheck(row['fairQtySum']) ? 0 : row['fairQtySum'];
					let faultyQtySum = isEmptyCheck(row['faultyQtySum']) ? 0 : row['faultyQtySum'];
					let qtySum = parseFloat(fairQtySum) + parseFloat(faultyQtySum);
					let percent;
					if( qtySum > 0){
						percent = faultyQtySum / qtySum * 100;
					} else {
						percent = 0;
					}
					return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(percent).toFixed(2))+'%</div>';
				}
			},
			
		],
		columnDefs : [
			/* {
				targets: '_all',
				render: function(data) {
					return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
				} 
			} */
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
			let theadHeight = parseFloat($('#produceItemTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 145)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAllPit').off('keyup',function() {});
			$('#searchAllPit').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			});

			$('#produceItemTable tfoot').remove();
			let fairQtySum = api.column( $('#produceItemTable').DataTable().column('fairQtySum:name').index(), {page:'current'} ).data().sum();
			let faultyQtySum = api.column( $('#produceItemTable').DataTable().column('faultyQtySum:name').index(), {page:'current'} ).data().sum();
			let faultyQtyPercent;
			if(fairQtySum+faultyQtySum > 0){
				faultyQtyPercent = faultyQtySum/(fairQtySum+faultyQtySum) * 100;
			} else {
				faultyQtyPercent = 0;
			}
			$('#itemFairQtySum').html(addCommas(fairQtySum));
			$('#itemFaultyQtySum').html(addCommas(faultyQtySum));
			$('#itemFaultyQtyPercent').html(faultyQtyPercent.toFixed(2) +'%');
		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#produceItemTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#produceItemTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
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
	produceItemTable.on('column-reorder', function( e, settings, details ) {
		let api = produceItemTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#produceItemTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});
	
	$('#btnSearch').on('click',function(){
		produceTable.ajax.reload();
	});
	
	
</script>
</body>
</html>
