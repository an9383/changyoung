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
																		  grid-template-columns: 2.3fr 4px 3.5fr;">
	<div id="leftcol">
		<div class="container-fluid h-100" style="padding: 5px;">
			<div class="row" id="leftHeader" style="padding-bottom: 5px;">
				<div class="d-flex align-items-center d-flex">
					<input type="text" class="form-control w-auto h-100 me-1" id="searchAllIpr" placeholder="통합검색" >
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end">
					<div class="btn-group" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-danger w-auto" style="font-size: 17px !important;" id="btnAdmDel"><i class="fa-solid fa-trash-can"></i></button>								
						<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnSearch"><i class="fa-regular fa-clipboard"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnOpen"><i class="fa-solid fa-caret-left"></i></button>
					</div>
				</div>
			</div>
			<div class="row">
				<table class="table table-bordered p-0 m-0" id="itemPrcssRoutingListTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle">라우팅 번호</th>
							<th class="text-center align-middle">공정순서</th>
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
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">라우팅 번호</label>
					<input type="hidden" id="hiddenRoutingNo">
					<input type="text" max="9999-12" class="form-control w-auto h-100 me-3" id="routingNo" disabled="disabled">
					<input type="text" class="form-control w-auto h-100 me-1" id="searchAllIprd" placeholder="통합검색" >
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end">
					<div class="btn-group me-3" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto" id="btnPrcssNew" disabled="disabled">공정 불러오기</button>
					</div>
					<div class="btn-group" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnNew">
							<i class="fa-solid fa-plus"></i>
						</button>			
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnSave" disabled="disabled">
							<i class="fa-regular fa-floppy-disk"></i>
						</button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnEdit">
							<i class="fa-regular fa-pen-to-square"></i>
						</button>				
						<button type="button" class="btn btn-outline-danger w-auto" style="font-size: 17px !important;" id="btnDel">
							<i class="fa-solid fa-trash-can"></i>
						</button>								
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnCancel" disabled="disabled">
							<i class="fa-solid fa-xmark"></i>
						</button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnClose"><i class="fa-solid fa-caret-right"></i></button>
					</div>
				</div>
			</div>
			<div class="row">
				<div style="width: 100%;">
				 	<table class="table table-bordered p-0 m-0" id="itemPrcssRoutingDtlTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle">공정순서</th>
							<th class="text-center align-middle">공정코드</th>							
							<th class="text-center align-middle">공정명</th>
							<th class="text-center align-middle">설비정보</th>
							<th class="text-center align-middle">수량단위</th>
						</tr>
					</thead>
				</table>
				  
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
			let rightcolMinWidth = 1110; // rightcol 최소사이즈
	
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
			$('#page').css('grid-template-columns', '2.3fr 4px 3.5fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcol').removeClass('d-none');
		} else {
			$('#page').css('grid-template-columns', '0fr 4px 3.5fr');
			$('#leftcol').addClass('d-none');
			$('#rightcol').removeClass('d-none');
		}
		dataTableDrawAll(); // dataTable 전체 reload
	});
	$('#btnClose').on('click',function() { // right-box 닫기버튼 클릭
		if($('#leftcol').hasClass('d-none')){
			$('#page').css('grid-template-columns', '2.3fr 4px 3.5fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcol').removeClass('d-none');
		} else {
			$('#page').css('grid-template-columns', '2.3fr 4px 0fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcol').addClass('d-none');
		}
		dataTableDrawAll(); // dataTable 전체 reload
	});
</script>

<script>
	WM_init('ADM');
	WM_init('DTL_NEW');
	WM_init('DTL_EDIT');

	//변수 선언 모음
	let routingNo = '';
	let setView = '';
	let prcssEquipList = [];

	//페이지 접속시 설비정보 불러오기
	$(document).ready(function(){
		$.ajax({
			url : '<c:url value="/em/prcssEquipInfoListAll"/>',
			type : 'POST',
			async: false,
			data : {
				prcssEquipSelectGubun : function(){ return 'prcssAll';}
			},
			success : function(res) {
				if (res.result == "ok") { //응답결과
					prcssEquipList = res.data;
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
	});
		
	// 작업중 경고 모달 예 버튼 click
	$('#btnWorkingWarningModalY').on('click', function() {
		if(WMlastIdx == 'DTL_NEW' || WMlastIdx == 'DTL_EDIT') { // 등록중이거나 수정중이였을 경우
			$('#btnSave').trigger('click');
			return false;
		}
	});
	
	// 작업중 경고 모달 아니요 버튼 click
	$('#btnWorkingWarningModalN').on('click', function() {
		if(WMlastIdx == 'DTL_NEW' || WMlastIdx == 'DTL_EDIT') { // 등록중이거나 수정중이였을 경우
			if(getWM(WMlastIdx, 'idx') != '' && getWM(WMlastIdx, 'idx') != undefined) {
				let idx = getWM(WMlastIdx, 'idx');
				WM_action_OFF(WMlastIdx);
				setWM(WMlastIdx, 'idx', '');
				itemPrcssRoutingListTable.row('#'+idx).select();
				$(itemPrcssRoutingListTable.row('#'+idx).node()).trigger('click'); // 선택했던 항목 선택처리
			} else {
				WM_action_OFF(WMlastIdx);
				if(window.location != window.parent.location) { // tab일 경우
					// 부모 탭 닫기버튼 click
					$('#tab-list', parent.document).find('.active').find('span').eq(1).find('i').trigger('click');
			    }
				$('#btnNew').attr('disabled', false); // 신규 버튼
				$('#btnSave').attr('disabled', true); // 저장 버튼
				$('#btnEdit').attr('disabled', false); // 수정 버튼
				$('#btnDel').attr('disabled', false); // 삭제 버튼
				$('#btnCancel').attr('disabled', false); // 취소 버튼
				$('#btnPrcssNew').attr('disabled', true); // 공정불러오기 버튼
				$('#routingNo').attr('disabled', true); // 라우팅 번호
				$('#routingNo').val('')
				
			}
		}
	});
	
	//공정라우팅 조회
	$('#itemPrcssRoutingListTable thead tr').clone(true).addClass('filters').appendTo('#itemPrcssRoutingListTable thead'); // filter 생성
	let itemPrcssRoutingListTable = $('#itemPrcssRoutingListTable').DataTable({
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
			url : '<c:url value="/bm/itemPrcssRoutingListAll"/>',
			type : 'GET',
			data : {
			},
		},
        rowId: 'routingNo',
		columns : [
			{ data: 'routingNo', className : 'text-center align-middle'},
			{ data: 'prcssOrderFlow', className : 'text-center align-middle'},			
		],
		columnDefs : [
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
		order : [[0,'asc']],
		drawCallback: function() {
			let api = this.api();
			let data = api.data();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#itemPrcssRoutingListTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 79)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAllIpr').off('keyup',function() {});
			$('#searchAllIpr').on('keyup',function() {
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
				let cell = $('#itemPrcssRoutingListTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#itemPrcssRoutingListTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});

	// 공정라우팅 상세조회
	$('#itemPrcssRoutingDtlTable thead tr').clone(true).addClass('filters').appendTo('#itemPrcssRoutingDtlTable thead'); // filter 생성
	let itemPrcssRoutingDtlTable = $('#itemPrcssRoutingDtlTable').DataTable({
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
		rowReorder: {
			enable: false,
			dataSrc: 'prcssOrder',
		},
		select: {
            style: 'single',
            toggleable: false,
            items: 'row',
            info: false
        },
        ajax : {
			url : '<c:url value="/bm/itemPrcssRoutingSel"/>',
			type : 'GET',
			data : {
				'routingNo'	:	function(){ return routingNo; },
			},
		},
        rowId: 'idx',
		columns : [
			//공정순서
			{ data: 'prcssOrder', className : 'text-center', name:'prcssOrder'},
			//공정코드
			{ data: 'prcssCd', className : 'text-center align-middle',name:'prcssCd',
				render : function(data, type, row, meta) {
					let html='';
					html += '<div style="display: flex; flex-wrap: 1 1 auto;">';
					html += '<input type="text" class="form-control" name="prcssCd" style="mix-width: 100px;" disabled="disabled" value="'+data+'">';
					html += '<input type="hidden" name="prcssInfoIdx" value="'+row['prcssInfoIdx']+'">';
					html += '</div>';
					return html;
				}
			},
			//공정명
			{ data: 'prcssNm', className : 'text-center align-middle',name:'prcssNm',
				render : function(data, type, row, meta) {
					return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">' + data + '</div>';
				}
			},
			{ data: 'equipNm', className : 'text-center',
				render: function(data, type, row, meta) {
					if( data == null && data != '' ){
						let html='';
						let prcssEquipFilterList = _.filter(prcssEquipList,v=>v.prcssIdx == row['prcssInfoIdx']);
						html += '<select disabled name="equipIdx" class="form-select" style="min-width:150px;">';
						html += '<option selected value="">선택</option>';				
						for(var i=0; i<prcssEquipFilterList.length; i++){
							if( i == 0 && row['rowGubun'] == 'add'){
								html += '<option selected value="'+prcssEquipFilterList[i].equipIdx+'">'+prcssEquipFilterList[i].equipNm +'</option>';
							} else {
								html += '<option value="'+prcssEquipFilterList[i].equipIdx+'">'+prcssEquipFilterList[i].equipNm +'</option>';
							}
						}
						html += '</select>';
						return html;
					} else {
						let html='';
						let prcssEquipFilterList = _.filter(prcssEquipList,v=>v.prcssIdx == row['prcssInfoIdx']);
						html += '<select disabled name="equipIdx" class="form-select" style="min-width:150px;">'						
						for(var i=0; i<prcssEquipFilterList.length; i++){
							if(prcssEquipFilterList[i].equipIdx == row['equipIdx']){
								html += '<option selected value="'+prcssEquipFilterList[i].equipIdx+'">'+prcssEquipFilterList[i].equipNm +'</option>';
							} else {
								html += '<option value="'+prcssEquipFilterList[i].equipIdx+'">'+prcssEquipFilterList[i].equipNm +'</option>';
							}
						}
						html += '</select>';
						return html;
					}
				}
			},
			//수량단위		
			{ data: 'qtyUnitNm', className : 'text-center align-middle',name:'qtyUnitNm',
				render : function(data, type, row, meta) {
					return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">' + data + '</div>';
				}
			},
		],
		columnDefs : [
			{ "targets": '_all', "orderable": false },
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
		order : [[0,'asc']],
		drawCallback: function() {
			let api = this.api();
			let data = api.data();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#itemPrcssRoutingDtlTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 79)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAllIprd').off('keyup',function() {});
			$('#searchAllIprd').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			});

			//progressOrder
			for(var i=0;i<data.length;i++) {
				let tr = $('#' + table_id + ' tbody').find('tr').eq(i);
				itemPrcssRoutingDtlTable.row(tr).data().prcssOrder = i+1;
				$(tr).find('td').eq(0).html(i+1);
			}
		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#itemPrcssRoutingDtlTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#itemPrcssRoutingDtlTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	
	// dataTable colReorder event
	itemPrcssRoutingDtlTable.on('column-reorder', function( e, settings, details ) {
		let api = itemPrcssRoutingDtlTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#itemPrcssRoutingDtlTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	//공정순서변경되었을 때
	itemPrcssRoutingDtlTable.on('row-reorder', function ( e, diff, changes ) {
		if(diff.length != 0){
			$('#btnSave').attr('disabled',false);
			$('#btnEdit').attr('disabled',true);
			$('#btnNew').attr('disabled',true);
		}
	} );
	
	$('#itemPrcssRoutingListTable tbody').on('click', 'tr', function(){

		//console.log('hear!!!');
		//console.log('WMCheck(\'DTL_NEW\'):'+WMCheck('DTL_NEW'));
		//console.log('WMCheck(\'DTL_EDIT\'):'+WMCheck('DTL_EDIT'));
		
		routingNo = itemPrcssRoutingListTable.row(this).data().routingNo;
		//console.log("routingNo:"+routingNo)
		
		if(WMCheck('DTL_NEW')) { // 등록중일 경우
			//console.log('new');
			setWM('DTL_NEW', 'idx', routingNo);
			return false;
		} 
		if(WMCheck('DTL_EDIT')) { // 수정중일 경우
			//console.log('edit');
			setWM('DTL_EDIT', 'idx', routingNo);
			return false;
		}  

		//필터 잠금
		$('#itemPrcssRoutingDtlTable_wrapper').find('.filters th').each(function(index, item) {
			$(item).find('input').attr('disabled', false); // 검색 필터 disabled
		});

		$('#routingNo').val(routingNo);
		$('#routingNo').attr('disabled', true); // 라우팅 번호
		$('#btnNew').attr('disabled', false); // 신규 버튼
		$('#btnSave').attr('disabled', true); // 저장 버튼
		$('#btnEdit').attr('disabled', false); // 수정 버튼
		$('#btnDel').attr('disabled', false); // 삭제 버튼
		$('#btnCancel').attr('disabled', true); // 취소 버튼
		$('#btnPrcssNew').attr('disabled', true); // 신규 버튼
		itemPrcssRoutingDtlTable.ajax.reload(function(){});
 		
	});


	$('#btnNew').on('click',function(){
		setView = 'add';
		
		itemPrcssRoutingDtlTable.clear().draw();

		//열 움직이는 기능 잠금
		itemPrcssRoutingDtlTable.colReorder.disable();

		//rowReorder 해제
		itemPrcssRoutingDtlTable.rowReorder.enable();	
		
		//필터 잠금
		$('#itemPrcssRoutingDtlTable_wrapper').find('.filters th').each(function(index, item) {
			$(item).find('input').attr('disabled', true); // 검색 필터 disabled
		});
		
		WM_action_ON('DTL_NEW', 'workingWarningModal');

		$('#routingNo').val('');
		$('#routingNo').attr('disabled',false);
		$('#btnPrcssNew').attr('disabled',false);

		$('#btnNew').attr('disabled', true); // 신규 버튼
		$('#btnSave').attr('disabled', false); // 저장 버튼
		$('#btnEdit').attr('disabled', true); // 수정 버튼
		$('#btnDel').attr('disabled', false); // 삭제 버튼
		$('#btnCancel').attr('disabled', true); // 취소 버튼
	})


	//멀티셀렉트 값 바뀌면 테이블 헤더 보정
	$(document).on('change','select[name=workMethodMultiSelect]',function(){
		processInfoTable.draw(false);
	});
	

	// 수정버튼 클릭시
	$('#btnEdit').on('click',function(){

		if($('#itemPrcssRoutingListTable tbody').find('tr.selected').length == 0) {
			toastr.warning('수정할 항목을 선택해주세요.');
			return false;
		}
		
		setView = 'edit';
		
		itemPrcssRoutingDtlTable.columns.adjust().draw(false);
		
		//열 움직이는 기능 잠금
		itemPrcssRoutingDtlTable.colReorder.disable();

		//rowReorder 해제
		itemPrcssRoutingDtlTable.rowReorder.enable();	
		
		//필터 잠금
		$('#itemPrcssRoutingDtlTable_wrapper').find('.filters th').each(function(index, item) {
			$(item).find('input').attr('disabled', true); // 검색 필터 disabled
		});

		WM_action_ON('DTL_EDIT', 'workingWarningModal');

		$('#btnNew').attr('disabled',true);
		$('#btnSave').attr('disabled',false);
		$('#btnEdit').attr('disabled',true);
		$('#btnDel').attr('disabled',false);
		$('#btnCancel').attr('disabled',false);
		$('#btnPrcssNew').attr('disabled',false);
		$('select[name=equipIdx]').attr('disabled',false);
		
		$('#hiddenRoutingNo').val( $('#routingNo').val() );
		$('#routingNo').attr('disabled', false);
	});
	
 	
	//저장처리
	$('#btnSave').on('click',function(){
		routingNo = $('#routingNo').val();
		$('#my-spinner').show();	
		itemPrcssRoutingIns();
	});

	function itemPrcssRoutingIns(){
		let array = [];
		let state = true;

		if(itemPrcssRoutingDtlTable.data().count()=="0"){
			toastr.warning('등록할 공정이 없습니다.<br> 공정 불러오기를 하십시오.');
			$('#my-spinner').hide();	
			state = false;
			return false;
		}

		if($('#routingNo').val()==''){
			toastr.warning('라우팅 번호를 입력해주세요.');
			$('#my-spinner').hide();	
			state = false;
			return false;
		}

		$('#itemPrcssRoutingDtlTable tbody').find('tr').each(function(index, item) {
			let obj = new Object();
			obj.routingNo = routingNo;
			obj.prcssOrder = itemPrcssRoutingDtlTable.row(index).data().prcssOrder;
			obj.prcssInfoIdx = itemPrcssRoutingDtlTable.row(index).data().prcssInfoIdx;
			obj.equipIdx = $(this).find('td').eq(3).find('select').val();

			array.push(obj);
			//console.log(array);
		});

		if(state){
			$.ajax({
				url: '<c:url value="/bm/itemPrcssRoutingInsert"/>',
	            type: 'POST',
	            data: {
	            	'array'	:	JSON.stringify(array),
	            	'setView' : function(){return setView;},
	            	'routingNo' :   function(){return setView == 'add' ? routingNo : $('#hiddenRoutingNo').val();}
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if (res.result == "ok") { //응답결과
						toastr.success('등록되었습니다.');
						itemPrcssRoutingListTable.rows('.selected').deselect();
						itemPrcssRoutingDtlTable.rows('.selected').deselect();
						itemPrcssRoutingListTable.ajax.reload();
						itemPrcssRoutingDtlTable.ajax.reload();

						//열 움직이는 기능 잠금
						itemPrcssRoutingDtlTable.colReorder.enable();

						//rowReorder 잠금
						itemPrcssRoutingDtlTable.rowReorder.disable();	
						
						//필터 잠금
						$('#itemPrcssRoutingDtlTable_wrapper').find('.filters th').each(function(index, item) {
							$(item).find('input').attr('disabled', false); // 검색 필터 disabled
						});

						if(setView=="add"){
							WM_action_OFF('DTL_NEW');

						}else{
							WM_action_OFF('DTL_EDIT');
						}
						
						$('#btnNew').attr('disabled',false);
						$('#btnSave').attr('disabled',true);
						$('#btnEdit').attr('disabled',false);
						$('#btnDel').attr('disabled',false);
						$('#btnCancel').attr('disabled',true);
						$('#routingNo').attr('disabled',true);
						$('#btnPrcssNew').attr('disabled',true);

						//itemPrcssRoutingListTable.ajax.reload();이 동기적으로 실행되는 도중에 아래 코드가 실행되면 오류 발생. (2023.08.18)
// 						$('#itemPrcssRoutingListTable').DataTable().row('.selected').remove().draw(false);

					} else if(res.result == 'fail') {
						toastr.warning(res.message);
					} else {
						toastr.error(res.message);
					}
					$('#my-spinner').hide();
				}
			});
		} else{
			$('#my-spinner').hide();
		}
		
	}
	
	//삭제처리
	$('#btnDel').on('click',function(){
		if($('#itemPrcssRoutingDtlTable tbody').find('tr.selected').length == 0) {
			toastr.warning('삭제할 항목을 선택해주세요.');
			return false;
		}

		let idx = itemPrcssRoutingDtlTable.row('.selected').data().idx;
		if(isEmptyCheck(idx)){
			itemPrcssRoutingDtlTable.row('.selected').remove().draw(false);
		} else {
			$('#deleteModal').modal('show');
			$('#deleteModal').data('deleteType','DTL');
		}
	});

	//삭제처리
	$('#btnAdmDel').on('click',function(){
		if($('#itemPrcssRoutingListTable tbody').find('tr.selected').length == 0) {
			toastr.warning('삭제할 항목을 선택해주세요.');
			return false;
		}

		$('#deleteModal').modal('show');
		$('#deleteModal').data('deleteType','ADM');
	});

	$('#btnDeleteModalY').on('click',function(){
		let deleteType = $('#deleteModal').data('deleteType');
		//console.log('deleteType:'+deleteType);
		if(deleteType == 'DTL'){
			let idx = itemPrcssRoutingDtlTable.row('.selected').data().idx;
			let routingNo = $('#routingNo').val();
			$.ajax({
				url: '<c:url value="/bm/itemPrcssRoutingDelete"/>',
	            type: 'POST',
	            data: {
		            'idx'		:	function(){ return idx; },
		            'routingNo'	:	function(){ return routingNo; },
		            'delGubun' 	: 	function(){ return deleteType; },
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if (res.result == "ok") { //응답결과
						toastr.success('삭제되었습니다.');
						$('#itemPrcssRoutingDtlTable').DataTable().row('.selected').remove().draw(false);
						itemPrcssRoutingListTable.ajax.reload(function(){});
						
						if(itemPrcssRoutingDtlTable.data().length == 0){
							$('#btnNew').attr('disabled',false);
							$('#btnSave').attr('disabled',true);
							$('#btnEdit').attr('disabled',false);
							$('#btnDel').attr('disabled',false);
							$('#btnCancel').attr('disabled',true);
							$('#routingNo').attr('disabled',true);
							$('#btnPrcssNew').attr('disabled',true);
							$('#routingNo').attr('disabled',true);
							$('#routingNo').val('');
						}else{
							itemPrcssRoutingListTable.row('#'+routingNo).select();
							//$(itemPrcssRoutingListTable.row('#'+routingNo).node()).trigger('click');
						}
					} else {
						toastr.error(res.message);
					}
					$('#my-spinner').hide();
				}
			});
		}else {
			$.ajax({
				url: '<c:url value="/bm/itemPrcssRoutingDelete"/>',
	            type: 'POST',
	            data: {
		            'routingNo'	:	function(){ return routingNo; },
		            'delGubun' 	: 	function(){ return deleteType; },
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if (res.result == "ok") { //응답결과
						toastr.success('삭제되었습니다.');
						$('#itemPrcssRoutingListTable').DataTable().row('.selected').remove().draw(false);
						itemPrcssRoutingDtlTable.clear().draw();
						$('#routingNo').val('');
						
					} else {
						toastr.error(res.message);
					}
					$('#my-spinner').hide();
				}
			});
		}
	});	


	
	//취소처리
	$('#btnCancel').on('click', function() {
		$('#cancelModal').modal('show');
	});

	$('#btnCancelModalY').on('click',function(){
		WM_action_OFF('ADM');
		WM_action_OFF('DTL_NEW');
		WM_action_OFF('DTL_EDIT');

		itemPrcssRoutingDtlTable.rows('.selected').deselect();
		itemPrcssRoutingDtlTable.ajax.reload();

		//열 움직이는 기능 잠금
		itemPrcssRoutingDtlTable.colReorder.enable();
		//필터 잠금
		$('#itemPrcssRoutingDtlTable_wrapper').find('.filters th').each(function(index, item) {
			$(item).find('input').attr('disabled', false); // 검색 필터 disabled
		});
		
		$('#btnNew').attr('disabled', false); // 신규 버튼
		$('#btnSave').attr('disabled', true); // 저장 버튼
		$('#btnEdit').attr('disabled', false); // 수정 버튼
		$('#btnDel').attr('disabled', false); // 삭제 버튼
		$('#btnCancel').attr('disabled', true); // 취소 버튼
		$('#btnPrcssNew').attr('disabled',true); // 공정불러오기 버튼
		$('#routingNo').attr('disabled',true);
		$('#routingNo').val('');
		
	});

	$('#btnSearch').on('click',function(){
		WM_action_OFF('ADM');
		WM_action_OFF('DTL_NEW');
		WM_action_OFF('DTL_EDIT');

		routingNo = '';

		itemPrcssRoutingListTable.rows('.selected').deselect();
		itemPrcssRoutingDtlTable.rows('.selected').deselect();
		itemPrcssRoutingListTable.ajax.reload();
		itemPrcssRoutingDtlTable.ajax.reload();
		$('#routingNo').val('');
		
		//열 움직이는 기능 잠금
		itemPrcssRoutingDtlTable.colReorder.enable();
		//필터 잠금
		$('#itemPrcssRoutingDtlTable_wrapper').find('.filters th').each(function(index, item) {
			$(item).find('input').attr('disabled', false); // 검색 필터 disabled
		});
		
		$('#btnNew').attr('disabled', false); // 신규 버튼
		$('#btnSave').attr('disabled', true); // 저장 버튼
		$('#btnEdit').attr('disabled', true); // 수정 버튼
		$('#btnDel').attr('disabled', false); // 삭제 버튼
		$('#btnCancel').attr('disabled', true); // 취소 버튼
	});

	//공정정보모달 조회
	$('#prcssModalTable thead tr').clone(true).addClass('filters').appendTo('#prcssModalTable thead'); // filter 생성
	let prcssModalTable = $('#prcssModalTable').DataTable({
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
            style: 'multi',
            toggleable: true,
            items: 'row',
            info: false
        },
        ajax : {
			url : '<c:url value="/bm/prcssListAll"/>',
			type : 'GET',
			data : {
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'prcssCd', className : 'text-center'},
			{ data: 'prcssNm', className : 'text-center'},
			{ data: 'qtyUnitNm', className : 'text-center'},
			{ data: 'initial', className : 'text-center'},
			{ data: 'prcssDesc', className : 'text-center'},
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
			let data = api.data();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#prcssModalTable_wrapper').find('.dataTables_scrollHead').css('height'));
			let baseTableHeight = parseFloat($('#rightcolM').css('height'));
			
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 197)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			//$('#searchAll').off('keyup',function() {});
			//$('#searchAll').on('keyup',function() {
			//	$('#'+table_id+'_filter').find('input').val($(this).val());
			//	$('#'+table_id+'_filter').find('input').trigger('keyup');
			//});
		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#prcssModalTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#prcssModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	prcssModalTable.on('column-reorder', function( e, settings, details ) {
		let api = prcssModalTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#prcssModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	//공정 추가
   	$('#btnPrcssNew').on('click',function(){
  	 	prcssModalTable.rows('.selected').deselect();
		$('#prcssModal').modal('show');   	
		setTimeout(function() {
			prcssModalTable.ajax.reload(function() {});
		}, 200);
   	});

	//공정 복사
	$('#btnPrcssModalPaste').on('click',function(){
		let status = true;
		let ngPrcssCd = '';
		
		if(!$('#prcssModalTable tbody tr').hasClass('selected')){
			toastr.warning('붙여넣을 행을 선택해주세요.');
			return false;
		}

		$('#my-spinner').show();
		let selectedIndex = prcssModalTable.rows('.selected').toArray()[0];
		if( status ){
			//모달창에서 선택되어있는 공정 IDX들( 붙여넣을 항목 )
			let prcssIdxArray = getPrcssIdx(prcssModalTable.rows('.selected').data().toArray(),"idx");
			let i = 0;
			let j = 0;
			let rowDeleteCnt = 0;
			let prcssTableLen = $('#itemPrcssRoutingDtlTable tbody tr').length - $('#itemPrcssRoutingDtlTable tbody tr').find('.dataTables_empty').length;
			//필터된 array(삽입 해야할 항목)
			for(i = 0; i < prcssIdxArray.length; i++){
				//모달 행 위치
				let modalRow = getPrcssIdx(prcssModalTable.data().toArray(),"idx").indexOf(prcssIdxArray[i]); 
				//console.log("modalRow:"+modalRow)
				//추가될 row = 테이블 행 갯수 - 데이터가 없는 경우 나오는 행
				let rowLvl = $('#itemPrcssRoutingDtlTable tbody tr').length - $('#itemPrcssRoutingDtlTable tbody tr').find('.dataTables_empty').length;

				let modalData = prcssModalTable.row(modalRow).data();
				//console.log("modalData:"+modalData)
				
				$('#itemPrcssRoutingDtlTable').DataTable().row.add({
					'rowGubun'				: 'add',
					'prcssOrder'			: rowLvl+1,
					'prcssInfoIdx'			: modalData.idx,
					'prcssCd'				: modalData.prcssCd,
					'prcssNm'				: modalData.prcssNm,
					'qtyUnitNm'				: modalData.qtyUnitNm,
				}).draw(false);
			} 
			itemPrcssRoutingDtlTable.draw(false);
			$('select[name=equipIdx]').attr('disabled',false);
			$('#prcssModal').modal('hide'); 
			toastr.success('공정이 추가되었습니다.');
		} else {				
			toastr.warning('이미 추가된 공정이 있습니다.<br>추가된 공정 코드 : '+ngPrcssCd);
		}
		$('#my-spinner').hide();
	});

	//객체(json)에서 키(field)로 값 찾기
	function getPrcssIdx(input, field) {
	    let output = [];
	    for (let i=0; i < input.length ; ++i)
	        output.push(input[i][field]);
	    return output;
	}
	
</script>

</body>
</html>
