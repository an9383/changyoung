<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/top.jsp"%>
<%@include file="../layout/modal.jsp"%>
<%@include file="../layout/script.jsp"%>
<div id="page" onmouseup="EndDrag()" onmousemove="OnDrag(event)" style="grid-template-areas: 'leftcol dragbar rightcol';
																		  grid-template-rows: 1fr;
																		  grid-template-columns: 3fr 4px 6fr;">
	<div id="leftcol">
		<div class="container-fluid h-100" style="padding: 5px;">
			<div class="row" id="leftHeader" style="padding-bottom: 5px;">
				<div class="d-flex align-items-center d-flex">
					<input type="text" class="form-control w-auto h-100 me-1" id="searchAllAdm" placeholder="통합검색" >
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end">
					<div class="btn-group" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnSearch"><i class="fa-regular fa-clipboard"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnNewAdm"><i class="fa-solid fa-plus"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnSaveAdm" disabled><i class="fa-regular fa-floppy-disk"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnEditAdm"><i class="fa-regular fa-pen-to-square"></i></button>
						<button type="button" class="btn btn-outline-danger w-auto" style="font-size: 17px !important;" id="btnDelAdm"><i class="fa-solid fa-trash-can"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnCancelAdm" disabled><i class="fa-solid fa-xmark"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnOpen"><i class="fa-solid fa-caret-left"></i></button>
					</div>
				</div>
			</div>
			<div class="row">
				<table class="table table-bordered p-0 m-0" id="menuInfoAdmTable">
					<thead class="table-light">
						<tr>
							<th class="text-center"><span style="color:#ff0000;">*</span>순번</th>
							<th class="text-center"><span style="color:#ff0000;">*</span>메뉴ID</th>
							<th class="text-center"><span style="color:#ff0000;">*</span>메뉴명</th>
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
					<input type="text" class="form-control w-auto h-100 me-1" id="searchAllDtl" placeholder="통합검색" >
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end">
					<div class="btn-group" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnNewDtl"><i class="fa-solid fa-plus"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnSaveDtl" disabled><i class="fa-regular fa-floppy-disk"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnEditDtl" disabled><i class="fa-regular fa-pen-to-square"></i></button>
						<button type="button" class="btn btn-outline-danger w-auto" style="font-size: 17px !important;" id="btnDelDtl" disabled><i class="fa-solid fa-trash-can"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnCancelDtl" disabled><i class="fa-solid fa-xmark"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnClose"><i class="fa-solid fa-caret-right"></i></button>
					</div>
				</div>
			</div>
			<div class="row">
				<table class="table table-bordered p-0 m-0" id="menuInfoDtlTable">
					<thead class="table-light">
						<tr>
							<th class="text-center"><span style="color:#ff0000;">*</span>순번</th>
							<th class="text-center"><span style="color:#ff0000;">*</span>대메뉴명</th>
							<th class="text-center"><span style="color:#ff0000;">*</span>메뉴ID</th>
							<th class="text-center"><span style="color:#ff0000;">*</span>메뉴명</th>
							<th class="text-center"><span style="color:#ff0000;">*</span>메뉴경로</th>
							<th class="text-center"><span style="color:#ff0000;">*</span>사용여부</th>
							<th class="text-center">필드1</th>
							<th class="text-center">필드2</th>
							<th class="text-center">필드3</th>
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

	$('#btnOpen').on('click',function() { // right-box 열기버튼 클릭
		if($('#rightcol').hasClass('d-none')){
			$('#page').css('grid-template-columns', '3fr 4px 6fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcol').removeClass('d-none');
		} else {
			$('#page').css('grid-template-columns', '0fr 4px 6fr');
			$('#leftcol').addClass('d-none');
			$('#rightcol').removeClass('d-none');
		}
		dataTableDrawAll(); // dataTable 전체 reload
	});
	
	$('#btnClose').on('click',function() { // right-box 닫기버튼 클릭
		if($('#leftcol').hasClass('d-none')){
			$('#page').css('grid-template-columns', '3fr 4px 6fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcol').removeClass('d-none');
		} else {
			$('#page').css('grid-template-columns', '3fr 4px 0fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcol').addClass('d-none');
		}
		dataTableDrawAll(); // dataTable 전체 reload
	});
	
</script>

<script>
	WM_init('ADM');
	WM_init('DTL');

	let menuInfoAdmIdxVal = '';
	let menuInfoAdmList = [];

	// 메뉴정보관리 ADM 목록조회
	$('#menuInfoAdmTable thead tr').clone(true).addClass('filters').appendTo('#menuInfoAdmTable thead'); // filter 생성
	let menuInfoAdmTable = $('#menuInfoAdmTable').DataTable({
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
			enable: true,
			dataSrc: 'menuOrder'
		},
		select: {
            style: 'single',
            toggleable: false,
            items: 'row',
            info: false
        },
        ajax : {
			url : '<c:url value="/sm/menuInfoAdmLst"/>',
			type : 'POST',
			data : {
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'menuOrder', className : 'text-center', name: 'menuOrder' },
			{ data: 'menuId', className : 'text-center', name: 'menuId',
				render: function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						return data;
					} else {
						return '<input type="text" class="form-control"><span class="d-none">'+data+'</span>';
					}
				}
			},
			{ data: 'menuNm', className : 'text-center', name: 'menuNm',
				render: function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						return data;
					} else {
						return '<input type="text" class="form-control"><span class="d-none">'+data+'</span>';
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
			/* { extend: 'colvis',	text: 'Select Col',	}, */
		],
		order : [
			[ 0, 'asc' ]
		],
		drawCallback: function() {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#menuInfoAdmTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 79)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAllAdm').off('keyup',function() {});
			$('#searchAllAdm').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			});
			
			// 순서 셋팅
			for(var i=0;i<api.data().count();i++) {
				let tr = $('#menuInfoAdmTable tbody').find('tr').eq(i);
				menuInfoAdmTable.row(tr).data().menuOrder = i+1;
				$(tr).find('td').eq(0).html(i+1);
			}
		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#menuInfoAdmTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title.replaceAll('*','') + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#menuInfoAdmTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	menuInfoAdmTable.on('column-reorder', function( e, settings, details ) {
		let api = menuInfoAdmTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#menuInfoAdmTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	// 메뉴정보관리 ADM 조회 버튼 click
	$('#btnSearch').on('click', function() {
		if(WMCheck('ADM')) {
			return false;
		}
		$('#my-spinner').show();

		menuInfoAdmTable.clear().draw();
		menuInfoAdmTable.ajax.reload(function() {
			menuInfoAdmTable.rowReorder.disable();
		});
		
		$('#menuInfoAdmTable_wrapper').find('.filters th').each(function(index, item) {
			$(item).find('input').attr('disabled', false);// 검색 필터 enable
		});

		$('#btnNewAdm').attr('disabled', false); // 신규 버튼
		$('#btnSaveAdm').attr('disabled', true); // 저장 버튼
		$('#btnEditAdm').attr('disabled', false); // 수정 버튼
		$('#btnDelAdm').attr('disabled', false); // 삭제 버튼
		$('#btnCancelAdm').attr('disabled', true); // 취소 버튼

		setTimeout(function() {
			$('#my-spinner').hide();
		}, 100)
	});

	// 메뉴목록 click
	$('#menuInfoAdmTable tbody').on('click','tr', function() {
		let idx = menuInfoAdmTable.row(this).data().idx;
		menuInfoAdmIdxVal = idx;
		
		if(WMCheck('DTL')) { // 메뉴정보관리 DTL 수정중이거나 등록중일 경우
			setWM('DTL', 'idx', idx);
			return false;
		}

		$.ajax({
			url: '<c:url value="/sm/menuInfoAdmLst"/>',
            type: 'POST',
            async: false,
            data: {
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					menuInfoAdmList = res.data;
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});

		menuInfoDtlTable.ajax.reload(function() {
			menuInfoDtlTable.rowReorder.disable();
			
			$('#btnNewDtl').attr('disabled', false); // DTL 신규 버튼
			$('#btnSaveDtl').attr('disabled', true); // DTL 저장 버튼
			$('#btnEditDtl').attr('disabled', false); // DTL 수정 버튼
			$('#btnDelDtl').attr('disabled', false); // DTL 삭제 버튼
			$('#btnCancelDtl').attr('disabled', true); // DTL 취소 버튼
		});
	});

	// 메뉴정보관리 ADM 신규 버튼 click
	$('#btnNewAdm').on('click', function() {
		WM_action_ON('ADM','workingWarningModal');
		let order = menuInfoAdmTable.data().count()+1;
		menuInfoAdmTable.row.add({
			'idx'			:	'',
			'menuOrder'		:	order,
			'menuId'		:	'',
			'menuNm'		:	'',
		}).draw(false);

		$('#btnNewAdm').attr('disabled', false); // 신규 버튼
		$('#btnSaveAdm').attr('disabled', false); // 저장 버튼
		$('#btnEditAdm').attr('disabled', false); // 수정 버튼
		$('#btnDelAdm').attr('disabled', false); // 삭제 버튼
		$('#btnCancelAdm').attr('disabled', false); // 취소 버튼
	});

	// 메뉴정보관리 ADM 저장 버튼 click
	$('#btnSaveAdm').on('click', function() {
		let array = [];
		let state = true;
		$('#menuInfoAdmTable tbody').find('tr').each(function(index, item) {
			if($(item).find('td').find('input').length != 0) {
				let td = $(item).find('td');
				let idx = menuInfoAdmTable.row($(item)).data().idx;
				let menuOrder = $(td).eq(menuInfoAdmTable.column('menuOrder:name').index()).html();
				let menuId = $(td).eq(menuInfoAdmTable.column('menuId:name').index()).find('input').val();
				let menuNm = $(td).eq(menuInfoAdmTable.column('menuNm:name').index()).find('input').val();

				if(menuId == '') {
					toastr.warning('메뉴ID를  입력해주세요.');
					$(td).eq(menuInfoAdmTable.column('menuId:name').index()).find('input').focus();
					state = false;
					return false;
				}
				if(menuNm == '') {
					toastr.warning('메뉴명을 입력해주세요.');
					$(td).eq(menuInfoAdmTable.column('menuNm:name').index()).find('input').focus();
					state = false;
					return false;
				}
				
				let obj = new Object();
				obj.idx = idx;
				obj.menuOrder = menuOrder;
				obj.menuId = menuId;
				obj.menuNm = menuNm;
				obj.useYn = 'Y';
			    
			    array.push(obj);
		    }
		});

		if(!state) {
			return false;
		}
		
		if(array.length != _.uniqBy(array, 'menuNm').length) {
			toastr.warning('중복되는 메뉴명이 존재합니다.');
			return false;
		}

		$.ajax({
			url: '<c:url value="/sm/menuInfoAdmIU"/>',
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

					WM_action_OFF('ADM');

					$('#btnSearch').trigger('click'); // 조회버튼 click

					$('#btnNewAdm').attr('disabled', false); // 신규 버튼
					$('#btnSaveAdm').attr('disabled', true); // 저장 버튼
					$('#btnEditAdm').attr('disabled', false); // 수정 버튼
					$('#btnDelAdm').attr('disabled', false); // 삭제 버튼
					$('#btnCancelAdm').attr('disabled', true); // 취소 버튼
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
	});

	// 메뉴정보관리 ADM 수정 버튼 click
	$('#btnEditAdm').on('click', function() {
		WM_action_ON('ADM','workingWarningModal');
		
		$('#menuInfoAdmTable tbody').find('tr').each(function(index_tr, tr) {
			$(tr).find('td').each(function(index_td, td) {
				if($(td).find('input').length == 0 && $(td).find('select').length == 0 && $(tr).find('td').length != 1 && index_td != 0) {
					if(index_td == menuInfoAdmTable.column('useYn:name').index()) {
						let value = menuInfoAdmTable.row(tr).data().useYn;
						if(value == 'Y') {
							$(td).html('<select class="form-select"><option value="Y" selected>사용</option><option value="N">미사용</option></select>');
						} else {
							$(td).html('<select class="form-select"><option value="Y">사용</option><option value="N" selected>미사용</option></select>');
						}
						
					} else {
						let value = $(td).text();
						$(td).html('<input type="text" class="form-control" value="'+value+'">');
					}
				}
			})
		});

		menuInfoAdmTable.rowReorder.enable();

		$('#btnNewAdm').attr('disabled', false); // ADM 신규 버튼
		$('#btnSaveAdm').attr('disabled', false); // ADM 저장 버튼
		$('#btnEditAdm').attr('disabled', true); // ADM 수정 버튼
		$('#btnDelAdm').attr('disabled', false); // ADM 삭제 버튼
		$('#btnCancelAdm').attr('disabled', false); // ADM 취소 버튼
	});

	// 작업중 경고 모달 예 버튼 click
	$('#btnWorkingWarningModalY').on('click', function() {
		if(WMlastIdx == 'ADM') { // 메뉴정보관리 ADM 수정중이나 신규등록중이였을 경우
			$('#btnSaveAdm').trigger('click');
			return false;
		} else if(WMlastIdx == 'DTL') { // 메뉴정보관리 DTL 수정중이나 신규등록중이였을 경우
			$('#btnSaveDtl').trigger('click');
			return false;
		}
	});

	// 작업중 경고 모달 아니요 버튼 click
	$('#btnWorkingWarningModalN').on('click', function() {
		if(WMlastIdx == 'ADM') { // 메뉴정보관리 ADM 수정중이나 신규등록중이였을 경우
			WM_action_OFF(WMlastIdx);
			$('#btnSearch').trigger('click');
			if(WM_close_check()) {
				if(window.location != window.parent.location) { // tab일 경우
					// 부모 탭 닫기버튼 click
					$('#tab-list', parent.document).find('.active').find('span').eq(1).find('i').trigger('click');
			    }
			}
			return false;
		} else if(WMlastIdx == 'DTL') { // 메뉴정보관리 DTL 수정중이나 신규등록중이였을 경우
			if(getWM(WMlastIdx, 'idx') != '' && getWM(WMlastIdx, 'idx') != undefined) {
				let idx = getWM(WMlastIdx, 'idx');
				WM_action_OFF(WMlastIdx);
				setWM(WMlastIdx, 'idx', '');
				menuInfoAdmTable.row('#'+idx).select();
				$(menuInfoAdmTable.row('#'+idx).node()).trigger('click'); // 선택했던 항목 선택처리
			} else {
				WM_action_OFF(WMlastIdx);
				if(window.location != window.parent.location) { // tab일 경우
					// 부모 탭 닫기버튼 click
					$('#tab-list', parent.document).find('.active').find('span').eq(1).find('i').trigger('click');
			    }
			}
		}
	});

	// 메뉴정보관리 ADM 삭제 버튼 click
	$('#btnDelAdm').on('click', function() {
		if($('#menuInfoAdmTable tbody').find('tr.selected').length == 0) {
			toastr.warning('삭제할 항목을 선택해주세요.');
			return false;
		}

		let data = menuInfoAdmTable.row('.selected').data();

		if(data.idx != '') {
			$('#deleteModal').modal('show');
			$('#deleteModal').data('deleteType','ADM');
		} else {
			menuInfoAdmTable.row('.selected').remove().draw();
		}
	});

	// 삭제 경고창 삭제 버튼 click
	$('#btnDeleteModalY').on('click', function() {
		let deleteType = $('#deleteModal').data('deleteType');
		if(deleteType == 'ADM') {
			let idx = menuInfoAdmTable.row('.selected').data().idx;
			$.ajax({
				url: '<c:url value="/sm/menuInfoAdmDel"/>',
	            type: 'POST',
	            data: {
	                'idx'	:	idx
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if (res.result == "ok") { //응답결과
						toastr.success('삭제되었습니다.');

						menuInfoDtlTable.clear().draw();
						menuInfoDtlTable.ajax.reload();
						menuInfoAdmTable.row('.selected').remove().draw(false);
					} else if(res.result == 'fail') {
						toastr.warning(res.message);
					} else {
						toastr.error(res.message);
					}
					$('#my-spinner').hide();
				}
			});
		} else if(deleteType == 'DTL') {
			let idx = menuInfoDtlTable.row('.selected').data().idx;
			$.ajax({
				url: '<c:url value="/sm/menuInfoDtlDel"/>',
	            type: 'POST',
	            data: {
	                'idx'	:	idx
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if (res.result == "ok") { //응답결과
						toastr.success('삭제되었습니다.');

						menuInfoDtlTable.row('.selected').remove().draw(false);
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

	// 메뉴정보관리 ADM 취소 버튼 click
	$('#btnCancelAdm').on('click', function() {
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
			
			$('#btnNewAdm').attr('disabled', false); // 신규 버튼
			$('#btnSaveAdm').attr('disabled', true); // 저장 버튼
			$('#btnEditAdm').attr('disabled', false); // 수정 버튼
			$('#btnDelAdm').attr('disabled', false); // 삭제 버튼
			$('#btnCancelAdm').attr('disabled', true); // 취소 버튼
		} else {
			toastr.success('취소되었습니다.');
			WM_action_OFF('DTL');

			menuInfoDtlTable.ajax.reload();
			
			$('#btnNewDtl').attr('disabled', false); // 신규 버튼
			$('#btnSaveDtl').attr('disabled', true); // 저장 버튼
			$('#btnEditDtl').attr('disabled', false); // 수정 버튼
			$('#btnDelDtl').attr('disabled', false); // 삭제 버튼
			$('#btnCancelDtl').attr('disabled', true); // 취소 버튼
		}
	});
	
	function getMenuInfoList(sVal) {
		let html = '';
			html += '<select class="form-select" ><option value="">선택</option>';

		for(let i=0;i<menuInfoAdmList.length;i++) {
			let data = menuInfoAdmList[i];
			if(data.idx == sVal) {
				html += '<option value="' + data.idx + '" selected>'+data.menuNm+'</option>';
			} else {
				html += '<option value="' + data.idx + '" >'+data.menuNm+'</option>';
			}
		}
			html += '</select>';
		return html;
	}
	


	// 메뉴정보관리 DTL 목록조회
	$('#menuInfoDtlTable thead tr').clone(true).addClass('filters').appendTo('#menuInfoDtlTable thead'); // filter 생성
	let menuInfoDtlTable = $('#menuInfoDtlTable').DataTable({
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
			enable: true,
			dataSrc: 'menuOrder'
		},
		select: {
            style: 'single',
            toggleable: false,
            items: 'row',
            info: false
        },
        ajax : {
			url : '<c:url value="/sm/menuInfoDtlLst"/>',
			type : 'POST',
			data : {
				menuInfoAdmIdx	:	function() { return menuInfoAdmIdxVal; },
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'menuOrder', className : 'text-center', name: 'menuOrder' },
			{ data: 'menuNmAdm', className : 'text-center', name: 'menuNmAdm',
				render: function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						return data;
					} else {
						let menuInfoAdmIdx = row['menuInfoAdmIdx'];
						return getMenuInfoList(menuInfoAdmIdx) + '<span class="d-none">'+data+'</span>';
					}
				}
			},
			{ data: 'menuId', className : 'text-center', name: 'menuId',
				render: function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						return data;
					} else {
						return '<input type="text" class="form-control"><span class="d-none">'+data+'</span>';
					}
				}
			},
			{ data: 'menuNm', className : 'text-center', name: 'menuNm',
				render: function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						return data;
					} else {
						return '<input type="text" class="form-control"><span class="d-none">'+data+'</span>';
					}
				}
			},
			{ data: 'menuPath', className : 'text-center', name: 'menuPath',
				render: function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						return data;
					} else {
						return '<input type="text" class="form-control"><span class="d-none">'+data+'</span>';
					}
				}
			},
			{ data: 'useYn', className : 'text-center', name: 'useYn',
				render: function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						if(data == 'Y') {
							return '사용';
						} else {
							return '미사용';
						}
					} else {
						return '<select class="form-select"><option value="Y" selected>사용</option><option value="N">미사용</option></select><span class="d-none">'+data+'</span>';
					}
				}
			},
			{ data: 'etc1', className : 'text-center', name: 'etc1',
				render: function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						return data;
					} else {
						return '<input type="text" class="form-control"><span class="d-none">'+data+'</span>';
					}
				}
			},
			{ data: 'etc2', className : 'text-center', name: 'etc2',
				render: function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						return data;
					} else {
						return '<input type="text" class="form-control"><span class="d-none">'+data+'</span>';
					}
				}
			},
			{ data: 'etc3', className : 'text-center', name: 'etc3',
				render: function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						return data;
					} else {
						return '<input type="text" class="form-control"><span class="d-none">'+data+'</span>';
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
			/* { extend: 'colvis',	text: 'Select Col',	}, */
		],
		order : [
			[ 0, 'asc' ]
		],
		drawCallback: function() {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#menuInfoDtlTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 79)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAllDtl').off('keyup',function() {});
			$('#searchAllDtl').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			});

			// 순서 셋팅
			for(var i=0;i<api.data().count();i++) {
				let tr = $('#menuInfoDtlTable tbody').find('tr').eq(i);
				menuInfoDtlTable.row(tr).data().menuOrder = i+1;
				$(tr).find('td').eq(0).html(i+1);
			}
		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#menuInfoDtlTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title.replaceAll('*','') + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#menuInfoDtlTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	menuInfoDtlTable.on('column-reorder', function( e, settings, details ) {
		let api = menuInfoDtlTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#menuInfoDtlTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});


	// 메뉴정보관리 DTL 신규 버튼 click
	$('#btnNewDtl').on('click', function() {
		if(menuInfoAdmTable.row('.selected').data() == undefined) {
			toastr.warning('추가하실 대메뉴를 선택해주세요.');
			return false;
		}
		WM_action_ON('DTL','workingWarningModal');

		let order = menuInfoDtlTable.data().count()+1;
		
		menuInfoDtlTable.row.add({
			'idx'				:	'',
			'menuInfoAdmIdx'	:	menuInfoAdmIdxVal,
			'menuOrder'			:	order,
			'menuNmAdm'			:	'',
			'menuId'			:	'',
			'menuNm'			:	'',
			'menuPath'			:	'',
			'useYn'				:	'Y',
			'attr'				:	'',
			'etc1'				:	'',
			'etc2'				:	'',
			'etc3'				:	'',
		}).draw(false);

		$('#btnNewDtl').attr('disabled', false); // 신규 버튼
		$('#btnSaveDtl').attr('disabled', false); // 저장 버튼
		$('#btnEditDtl').attr('disabled', false); // 수정 버튼
		$('#btnDelDtl').attr('disabled', false); // 삭제 버튼
		$('#btnCancelDtl').attr('disabled', false); // 취소 버튼
	});

	// 메뉴정보관리 DTL 저장 버튼 click
	$('#btnSaveDtl').on('click', function() {
		let array = [];
		let state = true;
		$('#menuInfoDtlTable tbody').find('tr').each(function(index, item) {
			if($(item).find('td').find('input').length != 0) {
				let td = $(item).find('td');
				let idx = menuInfoDtlTable.row($(item)).data().idx;
				let menuInfoAdmIdx = $(td).eq(menuInfoDtlTable.column('menuNmAdm:name').index()).find('select').val();
				let menuOrder = $(td).eq(menuInfoDtlTable.column('menuOrder:name').index()).html();
				let menuId = $(td).eq(menuInfoDtlTable.column('menuId:name').index()).find('input').val();
				let menuNm = $(td).eq(menuInfoDtlTable.column('menuNm:name').index()).find('input').val();
				let menuPath = $(td).eq(menuInfoDtlTable.column('menuPath:name').index()).find('input').val();
				let useYn = $(td).eq(menuInfoDtlTable.column('useYn:name').index()).find('select').val();
				let etc1 = $(td).eq(menuInfoDtlTable.column('etc1:name').index()).find('input').val();
				let etc2 = $(td).eq(menuInfoDtlTable.column('etc2:name').index()).find('input').val();
				let etc3 = $(td).eq(menuInfoDtlTable.column('etc3:name').index()).find('input').val();

				if(menuId == '') {
					toastr.warning('메뉴ID를 입력해주세요.');
					$(td).eq(menuInfoDtlTable.column('menuId:name').index()).find('input').focus();
					state = false;
					return false;
				}
				if(menuNm == '') {
					toastr.warning('메뉴명을 입력해주세요.');
					$(td).eq(menuInfoDtlTable.column('menuNm:name').index()).find('input').focus();
					state = false;
					return false;
				}
				if(menuPath == '') {
					toastr.warning('메뉴경로를 입력해주세요.');
					$(td).eq(menuInfoDtlTable.column('menuPath:name').index()).find('input').focus();
					state = false;
					return false;
				}
				if(useYn == '') {
					toastr.warning('사용여부를 선택해주세요.');
					$(td).eq(menuInfoDtlTable.column('useYn:name').index()).find('select').focus();
					state = false;
					return false;
				}

				let obj = new Object();
				obj.idx = idx;
				obj.menuInfoAdmIdx = menuInfoAdmIdx;
				obj.menuOrder = menuOrder;
				obj.menuId = menuId;
				obj.menuNm = menuNm;
				obj.menuPath = menuPath;
				obj.useYn = useYn;
				obj.etc1 = etc1;
				obj.etc2 = etc2;
				obj.etc3 = etc3;
			    
			    array.push(obj);
		    }
		});

		if(!state) {
			return false;
		}
		
		if(array.length != _.uniqBy(array, 'menuNm').length) {
			toastr.warning('중복되는 메뉴명이 존재합니다.');
			return false;
		}

		$.ajax({
			url: '<c:url value="/sm/menuInfoDtlIU"/>',
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

					WM_action_OFF('DTL');

					menuInfoDtlTable.clear().draw();
					menuInfoDtlTable.ajax.reload(function() {
						menuInfoDtlTable.rowReorder.disable();
					});

					$('#btnNewDtl').attr('disabled', false); // 신규 버튼
					$('#btnSaveDtl').attr('disabled', true); // 저장 버튼
					$('#btnEditDtl').attr('disabled', false); // 수정 버튼
					$('#btnDelDtl').attr('disabled', false); // 삭제 버튼
					$('#btnCancelDtl').attr('disabled', true); // 취소 버튼
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
	});

	// 메뉴정보관리 DTL 수정 버튼 click
	$('#btnEditDtl').on('click', function() {
		WM_action_ON('DTL','workingWarningModal');

		menuInfoDtlTable.rowReorder.enable();
		
		$('#menuInfoDtlTable tbody').find('tr').each(function(index_tr, tr) {
			$(tr).find('td').each(function(index_td, td) {
				if($(td).find('input').length == 0 && $(td).find('select').length == 0 && $(tr).find('td').length != 1 && index_td != 0) {
					if(index_td == menuInfoDtlTable.column('menuNmAdm:name').index()) {
						$(td).html(getMenuInfoList(menuInfoAdmIdxVal));
					} else if(index_td == menuInfoDtlTable.column('useYn:name').index()) {
						let value = menuInfoDtlTable.row(tr).data().useYn;
						if(value == 'Y') {
							$(td).html('<select class="form-select"><option value="Y" selected>사용</option><option value="N">미사용</option></select>');
						} else {
							$(td).html('<select class="form-select"><option value="Y">사용</option><option value="N" selected>미사용</option></select>');
						}
						
					} else {
						let value = $(td).text();
						$(td).html('<input type="text" class="form-control" value="'+value+'">');
					}
				}
			})
		});
		
		

		$('#btnNewDtl').attr('disabled', false); // DTL 신규 버튼
		$('#btnSaveDtl').attr('disabled', false); // DTL 저장 버튼
		$('#btnEditDtl').attr('disabled', true); // DTL 수정 버튼
		$('#btnDelDtl').attr('disabled', false); // DTL 삭제 버튼
		$('#btnCancelDtl').attr('disabled', false); // DTL 취소 버튼
	});

	// 메뉴정보관리 DTL 삭제 버튼 click
	$('#btnDelDtl').on('click', function() {
		if($('#menuInfoDtlTable tbody').find('tr.selected').length == 0) {
			toastr.warning('삭제할 항목을 선택해주세요.');
			return false;
		}

		let data = menuInfoDtlTable.row('.selected').data();

		if(data.idx != '') {
			$('#deleteModal').modal('show');
			$('#deleteModal').data('deleteType','DTL');
		} else {
			menuInfoDtlTable.row('.selected').remove().draw();
		}
	});

	// 메뉴정보관리 DTL 취소 버튼 click
	$('#btnCancelDtl').on('click', function() {
		$('#cancelModal').modal('show');
		$('#cancelModal').data('cancelType', 'DTL');
	});
</script>

</body>
</html>
