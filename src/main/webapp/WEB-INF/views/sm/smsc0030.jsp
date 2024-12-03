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
																		  grid-template-columns: 1fr 4px 2fr;">
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
				<table class="table table-bordered p-0 m-0" id="commonCodeAdmTable">
					<thead class="table-light">
						<tr>
							<th class="text-center"><span style="color:#ff0000;">*</span>코드타입</th>
							<th class="text-center"><span style="color:#ff0000;">*</span>코드</th>
							<th class="text-center"><span style="color:#ff0000;">*</span>코드명</th>
							<th class="text-center"><span style="color:#ff0000;">*</span>사용여부</th>
							<th class="text-center">약칭</th>
							<th class="text-center">비고</th>
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
				<table class="table table-bordered p-0 m-0" id="commonCodeDtlTable">
					<thead class="table-light">
						<tr>
							<th class="text-center"><span style="color:#ff0000;">*</span>코드타입</th>
							<th class="text-center"><span style="color:#ff0000;">*</span>코드</th>
							<th class="text-center"><span style="color:#ff0000;">*</span>코드명</th>
							<th class="text-center"><span style="color:#ff0000;">*</span>사용여부</th>
							<th class="text-center">약칭</th>
							<th class="text-center">필드1</th>
							<th class="text-center">필드2</th>
							<th class="text-center">필드3</th>
							<th class="text-center">비고</th>
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
			$('#page').css('grid-template-columns', '1fr 4px 2fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcol').removeClass('d-none');
		} else {
			$('#page').css('grid-template-columns', '0fr 4px 2fr');
			$('#leftcol').addClass('d-none');
			$('#rightcol').removeClass('d-none');
		}
		dataTableDrawAll(); // dataTable 전체 reload
	});
	
	$('#btnClose').on('click',function() { // right-box 닫기버튼 클릭
		if($('#leftcol').hasClass('d-none')){
			$('#page').css('grid-template-columns', '1fr 4px 2fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcol').removeClass('d-none');
		} else {
			$('#page').css('grid-template-columns', '1fr 4px 0fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcol').addClass('d-none');
		}
		dataTableDrawAll(); // dataTable 전체 reload
	});
	
</script>

<script>
	WM_init('ADM');
	WM_init('DTL');

	let commonCodeAdmIdxVal = '';
	let commonTypeVal = '';

	// 공통코드관리 ADM 목록조회
	$('#commonCodeAdmTable thead tr').clone(true).addClass('filters').appendTo('#commonCodeAdmTable thead'); // filter 생성
	let commonCodeAdmTable = $('#commonCodeAdmTable').DataTable({
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
			url : '<c:url value="/sm/commonCodeAdmLst"/>',
			type : 'POST',
			data : {
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'commonType', className : 'text-center', name: 'commonType',
				render: function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						return data;
					} else {
						let html = '';
							html += '<select class="form-select">';
							html += '	<option value="시스템" selected>시스템</option>';
							html += '	<option value="일반">일반</option>';
							html += '</select><span class="d-none">'+data+'</span>';
						return html;
					}
				}
			},
			{ data: 'commonCd', className : 'text-center', name: 'commonCd',
				render: function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						return data;
					} else {
						return '<input type="text" class="form-control"><span class="d-none">'+data+'</span>';
					}
				}
			},
			{ data: 'commonNm', className : 'text-center', name: 'commonNm',
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
			{ data: 'attr', className : 'text-center', name: 'attr',
				render: function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						return data;
					} else {
						return '<input type="text" class="form-control"><span class="d-none">'+data+'</span>';
					}
				}
			},
			{ data: 'commonDesc', className : 'text-center', name: 'commonDesc',
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
		order : [],
		drawCallback: function() {
			let api = this.api();
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#commonCodeAdmTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#commonCodeAdmTable_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 79)+'px');
			
			$('#commonCodeAdmTable_filter').addClass('d-none');
			// 통합검색
			$('#searchAllAdm').off('keyup',function() {});
			$('#searchAllAdm').on('keyup',function() {
				$('#commonCodeAdmTable_filter').find('input').val($(this).val());
				$('#commonCodeAdmTable_filter').find('input').trigger('keyup');
			});
		},
		initComplete: function () {
			let api = this.api();
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#commonCodeAdmTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title.replaceAll('*','') + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#commonCodeAdmTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	commonCodeAdmTable.on('column-reorder', function( e, settings, details ) {
		let api = commonCodeAdmTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#commonCodeAdmTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	// 공통코드관리 ADM 조회 버튼 click
	$('#btnSearch').on('click', function() {
		if(WMCheck('ADM')) {
			return false;
		}
		
		commonCodeAdmTable.clear().draw();
		commonCodeAdmTable.ajax.reload(function() {
			$('#commonCodeAdmTable_wrapper').find('.filters th').each(function(index, item) {
				$(item).find('input').attr('disabled', false);// 검색 필터 enable
			});
			commonCodeAdmTable.colReorder.enable();
		});

		$('#btnNewAdm').attr('disabled', false); // 신규 버튼
		$('#btnSaveAdm').attr('disabled', true); // 저장 버튼
		$('#btnEditAdm').attr('disabled', false); // 수정 버튼
		$('#btnDelAdm').attr('disabled', false); // 삭제 버튼
		$('#btnCancelAdm').attr('disabled', true); // 취소 버튼
	});

	// 사용자목록 click
	$('#commonCodeAdmTable tbody').on('click','tr', function() {
		let idx = commonCodeAdmTable.row(this).data().idx;
		let commonType = commonCodeAdmTable.row(this).data().commonType;
		commonCodeAdmIdxVal = idx;
		commonTypeVal = commonType;
		
		if(WMCheck('DTL')) { // 공통코드관리 DTL 수정중이거나 등록중일 경우
			setWM('DTL', 'idx', idx);
			return false;
		}

		commonCodeDtlTable.ajax.reload(function() {
			$('#btnNewDtl').attr('disabled', false); // DTL 신규 버튼
			$('#btnSaveDtl').attr('disabled', true); // DTL 저장 버튼
			$('#btnEditDtl').attr('disabled', false); // DTL 수정 버튼
			$('#btnDelDtl').attr('disabled', false); // DTL 삭제 버튼
			$('#btnCancelDtl').attr('disabled', true); // DTL 취소 버튼
		});

		$('#commonCodeDtlTable_wrapper').find('.filters th').each(function(index, item) {
			$(item).find('input').attr('disabled', false);// 검색 필터 enable
		});
	});

	// 공통코드관리 ADM 신규 버튼 click
	$('#btnNewAdm').on('click', function() {
		WM_action_ON('ADM','workingWarningModal');
		let col_filter_text = [];
		$('#commonCodeAdmTable_wrapper').find('.filters th').each(function(index, item) {
			$(item).find('input').attr('disabled', true); // 검색 필터 disabled
			col_filter_text.push($(item).find('input').val());
		});
		commonCodeAdmTable.row.add({
			'idx'			:	'',
			'commonType'	:	col_filter_text[0],
			'commonCd'		:	col_filter_text[1],
			'commonNm'		:	col_filter_text[2],
			'useYn'			:	col_filter_text[3],
			'attr'			:	col_filter_text[4],
			'commonDesc'	:	col_filter_text[5]
		}).draw(false);

		commonCodeAdmTable.colReorder.disable();

		$('#btnNewAdm').attr('disabled', false); // 신규 버튼
		$('#btnSaveAdm').attr('disabled', false); // 저장 버튼
		$('#btnEditAdm').attr('disabled', false); // 수정 버튼
		$('#btnDelAdm').attr('disabled', false); // 삭제 버튼
		$('#btnCancelAdm').attr('disabled', false); // 취소 버튼
	});

	// 공통코드관리 ADM 저장 버튼 click
	$('#btnSaveAdm').on('click', function() {
		let array = [];
		let state = true;
		$('#commonCodeAdmTable tbody').find('tr').each(function(index, item) {
			if($(item).find('td').find('input').length != 0) {
				let td = $(item).find('td');
				let idx = commonCodeAdmTable.row($(item)).data().idx;
				let commonType = $(td).eq(commonCodeAdmTable.column('commonType:name').index()).find('select').val();
				let commonCd = $(td).eq(commonCodeAdmTable.column('commonCd:name').index()).find('input').val();
				let commonNm = $(td).eq(commonCodeAdmTable.column('commonNm:name').index()).find('input').val();
				let useYn = $(td).eq(commonCodeAdmTable.column('useYn:name').index()).find('select').val();
				let attr = $(td).eq(commonCodeAdmTable.column('attr:name').index()).find('input').val();
				let commonDesc = $(td).eq(commonCodeAdmTable.column('commonDesc:name').index()).find('input').val();

				if(commonType == '') {
					toastr.warning('코드타입을 선택해주세요.');
					$(td).eq(commonCodeAdmTable.column('commonType:name').index()).find('select').focus();
					state = false;
					return false;
				}
				if(commonCd == '') {
					toastr.warning('코드를 입력해주세요.');
					$(td).eq(commonCodeAdmTable.column('commonCd:name').index()).find('input').focus();
					state = false;
					return false;
				}
				if(commonNm == '') {
					toastr.warning('코드명을 입력해주세요.');
					$(td).eq(commonCodeAdmTable.column('commonNm:name').index()).find('input').focus();
					state = false;
					return false;
				}
				if(useYn == '') {
					toastr.warning('사용여부를 선택해주세요.');
					$(td).eq(commonCodeAdmTable.column('useYn:name').index()).find('select').focus();
					state = false;
					return false;
				}

				let obj = new Object();
				obj.idx = idx;
				obj.commonType = commonType;
				obj.commonCd = commonCd;
				obj.commonNm = commonNm;
				obj.useYn = useYn;
				obj.attr = attr;
				obj.commonDesc = commonDesc;
				obj.commonCodeAdmIdx = commonCodeAdmTable.row($(item)).data().commonCodeAdmIdx;
				obj.etc1 = commonCodeAdmTable.row($(item)).data().etc1;
				obj.etc2 = commonCodeAdmTable.row($(item)).data().etc2;
				obj.etc3 = commonCodeAdmTable.row($(item)).data().etc3;
				obj.regDate = commonCodeAdmTable.row($(item)).data().regDate;
				obj.regIdx = commonCodeAdmTable.row($(item)).data().regIdx;
				obj.updDate = commonCodeAdmTable.row($(item)).data().updDate;
				obj.updIdx = commonCodeAdmTable.row($(item)).data().updIdx;
			    
			    array.push(obj);
		    }
		});

		if(!state) {
			return false;
		}
		
		/* if(array.length != _.uniqBy(array, 'commonCd').length) {
			toastr.warning('중복되는 코드가 존재합니다.');
			return false;
		} */

		array = _.differenceWith(array, commonCodeAdmTable.data().toArray(), _.isEqual);
		
		$.ajax({
			url: '<c:url value="/sm/commonCodeAdmIU"/>',
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

	// 공통코드관리 ADM 수정 버튼 click
	$('#btnEditAdm').on('click', function() {
		WM_action_ON('ADM','workingWarningModal');
		$('#commonCodeAdmTable_wrapper').find('.filters th').each(function(index, item) {
			$(item).find('input').attr('disabled', true); // 검색 필터 disabled
		});
		
		$('#commonCodeAdmTable tbody').find('tr').each(function(index_tr, tr) {
			$(tr).find('td').each(function(index_td, td) {
				if($(td).find('input').length == 0 && $(td).find('select').length == 0 && $(tr).find('td').length != 1) {
					if(index_td == commonCodeAdmTable.column('commonType:name').index()) {
						let value = commonCodeAdmTable.row(tr).data().commonType;
						if(value == '시스템') {
							$(td).html('<select class="form-select"><option value="시스템" selected>시스템</option><option value="일반">일반</option></select>');
						} else {
							$(td).html('<select class="form-select"><option value="시스템">시스템</option><option value="일반" selected>일반</option></select>');
						}
						
					} else if(index_td == commonCodeAdmTable.column('useYn:name').index()) {
						let value = commonCodeAdmTable.row(tr).data().useYn;
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

		commonCodeAdmTable.colReorder.disable();

		$('#btnNewAdm').attr('disabled', false); // ADM 신규 버튼
		$('#btnSaveAdm').attr('disabled', false); // ADM 저장 버튼
		$('#btnEditAdm').attr('disabled', true); // ADM 수정 버튼
		$('#btnDelAdm').attr('disabled', false); // ADM 삭제 버튼
		$('#btnCancelAdm').attr('disabled', false); // ADM 취소 버튼
	});

	// 작업중 경고 모달 예 버튼 click
	$('#btnWorkingWarningModalY').on('click', function() {
		if(WMlastIdx == 'ADM') { // 공통코드관리 ADM 수정중이나 신규등록중이였을 경우
			$('#btnSaveAdm').trigger('click');
			return false;
		} else if(WMlastIdx == 'DTL') { // 공통코드관리 DTL 수정중이나 신규등록중이였을 경우
			$('#btnSaveDtl').trigger('click');
			return false;
		}
	});

	// 작업중 경고 모달 아니요 버튼 click
	$('#btnWorkingWarningModalN').on('click', function() {
		if(WMlastIdx == 'ADM') { // 공통코드관리 ADM 수정중이나 신규등록중이였을 경우
			WM_action_OFF(WMlastIdx);
			$('#btnSearch').trigger('click');
			if(WM_close_check()) {
				if(window.location != window.parent.location) { // tab일 경우
					// 부모 탭 닫기버튼 click
					$('#tab-list', parent.document).find('.active').find('span').eq(1).find('i').trigger('click');
			    }
			}
			return false;
		} else if(WMlastIdx == 'DTL') { // 공통코드관리 DTL 수정중이나 신규등록중이였을 경우
			if(getWM(WMlastIdx, 'idx') != '' && getWM(WMlastIdx, 'idx') != undefined) {
				let idx = getWM(WMlastIdx, 'idx');
				WM_action_OFF(WMlastIdx);
				setWM(WMlastIdx, 'idx', '');
				commonCodeAdmTable.row('#'+idx).select();
				$(commonCodeAdmTable.row('#'+idx).node()).trigger('click'); // 선택했던 항목 선택처리
			} else {
				WM_action_OFF(WMlastIdx);
				if(window.location != window.parent.location) { // tab일 경우
					// 부모 탭 닫기버튼 click
					$('#tab-list', parent.document).find('.active').find('span').eq(1).find('i').trigger('click');
			    }
			}
		}
	});

	// 공통코드관리 ADM 삭제 버튼 click
	$('#btnDelAdm').on('click', function() {
		if($('#commonCodeAdmTable tbody').find('tr.selected').length == 0) {
			toastr.warning('삭제할 항목을 선택해주세요.');
			return false;
		}

		let data = commonCodeAdmTable.row('.selected').data();

		if(data.idx != '') {
			$('#deleteModal').modal('show');
			$('#deleteModal').data('deleteType','ADM');
		} else {
			commonCodeAdmTable.row('.selected').remove().draw();
		}
	});

	// 삭제 경고창 삭제 버튼 click
	$('#btnDeleteModalY').on('click', function() {
		let deleteType = $('#deleteModal').data('deleteType');
		if(deleteType == 'ADM') {
			let idx = commonCodeAdmTable.row('.selected').data().idx;
			$.ajax({
				url: '<c:url value="/sm/commonCodeAdmDel"/>',
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

						commonCodeDtlTable.clear().draw();
						commonCodeDtlTable.ajax.reload();
						commonCodeAdmTable.row('.selected').remove().draw(false);
					} else if(res.result == 'fail') {
						toastr.warning(res.message);
					} else {
						toastr.error(res.message);
					}
					$('#my-spinner').hide();
				}
			});
		} else if(deleteType == 'DTL') {
			let idx = commonCodeDtlTable.row('.selected').data().idx;
			$.ajax({
				url: '<c:url value="/sm/commonCodeDtlDel"/>',
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

						commonCodeDtlTable.row('.selected').remove().draw(false);
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

	// 공통코드관리 ADM 취소 버튼 click
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
			
			commonCodeAdmTable.colReorder.enable();
			
			$('#btnNewAdm').attr('disabled', false); // 신규 버튼
			$('#btnSaveAdm').attr('disabled', true); // 저장 버튼
			$('#btnEditAdm').attr('disabled', false); // 수정 버튼
			$('#btnDelAdm').attr('disabled', false); // 삭제 버튼
			$('#btnCancelAdm').attr('disabled', true); // 취소 버튼
		} else {
			toastr.success('취소되었습니다.');
			WM_action_OFF('DTL');

			commonCodeDtlTable.ajax.reload();
			
			commonCodeDtlTable.colReorder.disable();
			
			$('#btnNewDtl').attr('disabled', false); // 신규 버튼
			$('#btnSaveDtl').attr('disabled', true); // 저장 버튼
			$('#btnEditDtl').attr('disabled', false); // 수정 버튼
			$('#btnDelDtl').attr('disabled', false); // 삭제 버튼
			$('#btnCancelDtl').attr('disabled', true); // 취소 버튼
		}
	});
	


	// 공통코드관리 DTL 목록조회
	$('#commonCodeDtlTable thead tr').clone(true).addClass('filters').appendTo('#commonCodeDtlTable thead'); // filter 생성
	let commonCodeDtlTable = $('#commonCodeDtlTable').DataTable({
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
			url : '<c:url value="/sm/commonCodeDtlLst"/>',
			type : 'POST',
			data : {
				commonCodeAdmIdx	:	function() { return commonCodeAdmIdxVal; },
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'commonType', className : 'text-center', name: 'commonType',
				render: function(data, type, row, meta) {
					return data;
				}
			},
			{ data: 'commonCd', className : 'text-center', name: 'commonCd',
				render: function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						return data;
					} else {
						return '<input type="text" class="form-control"><span class="d-none">'+data+'</span>';
					}
				}
			},
			{ data: 'commonNm', className : 'text-center', name: 'commonNm',
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
			{ data: 'attr', className : 'text-center', name: 'attr',
				render: function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						return data;
					} else {
						return '<input type="text" class="form-control"><span class="d-none">'+data+'</span>';
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
			{ data: 'commonDesc', className : 'text-center', name: 'commonDesc',
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
		order : [],
		drawCallback: function() {
			let api = this.api();
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#commonCodeDtlTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#commonCodeDtlTable_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 79)+'px');
			
			$('#commonCodeDtlTable_filter').addClass('d-none');
			// 통합검색
			$('#searchAllDtl').off('keyup',function() {});
			$('#searchAllDtl').on('keyup',function() {
				$('#commonCodeDtlTable_filter').find('input').val($(this).val());
				$('#commonCodeDtlTable_filter').find('input').trigger('keyup');
			});
		},
		initComplete: function () {
			let api = this.api();
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#commonCodeDtlTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title.replaceAll('*','') + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#commonCodeDtlTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	commonCodeDtlTable.on('column-reorder', function( e, settings, details ) {
		let api = commonCodeDtlTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#commonCodeDtlTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});


	// 공통코드관리 DTL 신규 버튼 click
	$('#btnNewDtl').on('click', function() {
		if(commonCodeAdmTable.row('.selected').data() == undefined) {
			toastr.warning('추가하실 코드그룹을 선택해주세요.');
			return false;
		}
		WM_action_ON('DTL','workingWarningModal');
		
		let col_filter_text = [];
		$('#commonCodeDtlTable_wrapper').find('.filters th').each(function(index, item) {
			$(item).find('input').attr('disabled', true); // 검색 필터 disabled
			col_filter_text.push($(item).find('input').val());
		});
		commonCodeDtlTable.row.add({
			'idx'				:	'',
			'commonCodeAdmIdx'	:	commonCodeAdmIdxVal,
			'commonType'		:	commonTypeVal,
			'commonCd'			:	col_filter_text[1],
			'commonNm'			:	col_filter_text[2],
			'useYn'				:	col_filter_text[3],
			'attr'				:	col_filter_text[4],
			'etc1'				:	col_filter_text[5],
			'etc2'				:	col_filter_text[6],
			'etc3'				:	col_filter_text[7],
			'commonDesc'		:	col_filter_text[8]
		}).draw(false);

		commonCodeDtlTable.colReorder.disable();

		$('#btnNewDtl').attr('disabled', false); // 신규 버튼
		$('#btnSaveDtl').attr('disabled', false); // 저장 버튼
		$('#btnEditDtl').attr('disabled', false); // 수정 버튼
		$('#btnDelDtl').attr('disabled', false); // 삭제 버튼
		$('#btnCancelDtl').attr('disabled', false); // 취소 버튼
	});

	// 공통코드관리 DTL 저장 버튼 click
	$('#btnSaveDtl').on('click', function() {
		let array = [];
		let state = true;
		$('#commonCodeDtlTable tbody').find('tr').each(function(index, item) {
			if($(item).find('td').find('input').length != 0) {
				let td = $(item).find('td');
				let idx = commonCodeDtlTable.row($(item)).data().idx;
				let commonType = $(td).eq(commonCodeDtlTable.column('commonType:name').index()).html();
				let commonCd = $(td).eq(commonCodeDtlTable.column('commonCd:name').index()).find('input').val();
				let commonNm = $(td).eq(commonCodeDtlTable.column('commonNm:name').index()).find('input').val();
				let useYn = $(td).eq(commonCodeDtlTable.column('useYn:name').index()).find('select').val();
				let attr = $(td).eq(commonCodeDtlTable.column('attr:name').index()).find('input').val();
				let etc1 = $(td).eq(commonCodeDtlTable.column('etc1:name').index()).find('input').val();
				let etc2 = $(td).eq(commonCodeDtlTable.column('etc2:name').index()).find('input').val();
				let etc3 = $(td).eq(commonCodeDtlTable.column('etc3:name').index()).find('input').val();
				let commonDesc = $(td).eq(commonCodeDtlTable.column('commonDesc:name').index()).find('input').val();

				if(commonType == '') {
					toastr.warning('코드타입을 선택해주세요.');
					$(td).eq(commonCodeDtlTable.column('commonType:name').index()).find('select').focus();
					state = false;
					return false;
				}
				if(commonCd == '') {
					toastr.warning('코드를 입력해주세요.');
					$(td).eq(commonCodeDtlTable.column('commonCd:name').index()).find('input').focus();
					state = false;
					return false;
				}
				if(commonNm == '') {
					toastr.warning('코드명을 입력해주세요.');
					$(td).eq(commonCodeDtlTable.column('commonNm:name').index()).find('input').focus();
					state = false;
					return false;
				}
				if(useYn == '') {
					toastr.warning('사용여부를 선택해주세요.');
					$(td).eq(commonCodeDtlTable.column('useYn:name').index()).find('select').focus();
					state = false;
					return false;
				}

				let obj = new Object();
				obj.idx = idx;
				obj.commonCodeAdmIdx = commonCodeAdmIdxVal;
				obj.commonType = commonType;
				obj.commonCd = commonCd;
				obj.commonNm = commonNm;
				obj.useYn = useYn;
				obj.attr = attr;
				obj.etc1 = etc1;
				obj.etc2 = etc2;
				obj.etc3 = etc3;
				obj.commonDesc = commonDesc;
				obj.regDate = commonCodeDtlTable.row($(item)).data().regDate;
				obj.regIdx = commonCodeDtlTable.row($(item)).data().regIdx;
				obj.updDate = commonCodeDtlTable.row($(item)).data().updDate;
				obj.updIdx = commonCodeDtlTable.row($(item)).data().updIdx;
			    
			    array.push(obj);
		    }
		});

		if(!state) {
			return false;
		}
		
		/* if(array.length != _.uniqBy(array, 'commonCd').length) {
			toastr.warning('중복되는 코드가 존재합니다.');
			return false;
		} */

		array = _.differenceWith(array, commonCodeDtlTable.data().toArray(), _.isEqual);

		$.ajax({
			url: '<c:url value="/sm/commonCodeDtlIU"/>',
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

					commonCodeDtlTable.clear().draw();
					commonCodeDtlTable.ajax.reload(function() {
						$('#commonCodeDtlTable_wrapper').find('.filters th').each(function(index, item) {
							$(item).find('input').attr('disabled', false);// 검색 필터 enable
						});
					});

					commonCodeDtlTable.colReorder.enable();

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

	// 공통코드관리 DTL 수정 버튼 click
	$('#btnEditDtl').on('click', function() {
		WM_action_ON('DTL','workingWarningModal');
		
		$('#commonCodeDtlTable_wrapper').find('.filters th').each(function(index, item) {
			$(item).find('input').attr('disabled', true); // 검색 필터 disabled
		});
		
		$('#commonCodeDtlTable tbody').find('tr').each(function(index_tr, tr) {
			$(tr).find('td').each(function(index_td, td) {
				if($(td).find('input').length == 0 && $(td).find('select').length == 0 && $(tr).find('td').length != 1) {
					if(index_td == commonCodeDtlTable.column('commonType:name').index()) {
						
					} else if(index_td == commonCodeDtlTable.column('useYn:name').index()) {
						let value = commonCodeDtlTable.row(tr).data().useYn;
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

		commonCodeDtlTable.colReorder.disable();

		$('#btnNewDtl').attr('disabled', false); // DTL 신규 버튼
		$('#btnSaveDtl').attr('disabled', false); // DTL 저장 버튼
		$('#btnEditDtl').attr('disabled', true); // DTL 수정 버튼
		$('#btnDelDtl').attr('disabled', false); // DTL 삭제 버튼
		$('#btnCancelDtl').attr('disabled', false); // DTL 취소 버튼
	});

	// 공통코드관리 DTL 삭제 버튼 click
	$('#btnDelDtl').on('click', function() {
		if($('#commonCodeDtlTable tbody').find('tr.selected').length == 0) {
			toastr.warning('삭제할 항목을 선택해주세요.');
			return false;
		}

		let data = commonCodeDtlTable.row('.selected').data();

		if(data.idx != '') {
			$('#deleteModal').modal('show');
			$('#deleteModal').data('deleteType','DTL');
		} else {
			commonCodeDtlTable.row('.selected').remove().draw();
		}
	});

	// 공통코드관리 DTL 취소 버튼 click
	$('#btnCancelDtl').on('click', function() {
		$('#cancelModal').modal('show');
		$('#cancelModal').data('cancelType', 'DTL');
	});
</script>

</body>
</html>
