<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/top.jsp"%>
<%@include file="../layout/modal.jsp"%>
<%@include file="../layout/script.jsp"%>
<div id="page" onmouseup="EndDrag()" onmousemove="OnDrag(event)" style="grid-template-areas:	'middlecolT'
																								'dragbarV'
																								'middlecolB';
																		  grid-template-rows: 1fr 4px 1fr;
																		  grid-template-columns: 1fr;">
	<div id="middlecolT">
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
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnCancelAdm" disabled><i class="fa-solid fa-xmark"></i></button>
					</div>
				</div>
			</div>
			<div class="row">
				<table class="table table-bordered p-0 m-0" id="locationAdmTable">
					<thead class="table-light">
						<tr>
							<th class="text-center"><span style="color:#ff0000;">*</span>창고코드</th>
							<th class="text-center"><span style="color:#ff0000;">*</span>창고명</th>
							<th class="text-center">출고</th>
							<th class="text-center">입고</th>
							<th class="text-center">반품</th>
							<th class="text-center">QC</th>
							<th class="text-center">외주</th>
							<th class="text-center">외주처</th>
							<th class="text-center"><span style="color:#ff0000;">*</span>양/불구분</th>
							<th class="text-center"><span style="color:#ff0000;">*</span>품목구분</th>
							<th class="text-center"><span style="color:#ff0000;">*</span>사용여부</th>
							<th class="text-center">종료일</th>
							<th class="text-center">참고사항</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
	<div id="dragbarV" onmousedown="StartDrag()"></div>
	<div id="middlecolB">
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
					</div>
				</div>
			</div>
			<div class="row">
				<table class="table table-bordered p-0 m-0" id="locationDtlTable">
					<thead class="table-light">
						<tr>
							<th class="text-center"><span style="color:#ff0000;">*</span>창고코드</th>
							<th class="text-center"><span style="color:#ff0000;">*</span>창고명</th>
							<th class="text-center"><span style="color:#ff0000;">*</span>구역</th>
							<th class="text-center"><span style="color:#ff0000;">*</span>위치(단)</th>
							<th class="text-center">위치(열)</th>
							<th class="text-center"><span style="color:#ff0000;">*</span>사용여부</th>
							<th class="text-center">비고</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>
<!-- 삭제 경고 -->
<div class="modal fade" id="useYnCheckModal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">
					<i class="fa-solid fa-triangle-exclamation text-danger"></i> <spring:message code="modal.warning" text="default text" />
				</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				미사용으로 변경할경우 창고에 속해있는 구역데이터를 사용할 수 없습니다. 그래도 변경하시겠습니까?
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" id="btnUseYnN" data-bs-dismiss="modal" style="width: 70px;">
					<spring:message code="yes" text="default text" />
				</button>
				<button type="button" class="btn btn-secondary" id="btnUseYnY" data-bs-dismiss="modal" style="width: 70px;">
					<spring:message code="no" text="default text" />
				</button>
			</div>
		</div>
	</div>
</div>
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
	WM_init('DTL');

	let lcAdmIdxVal = '';
	let lcCdVal = '';
	let lcNmVal = '';
	//공통코드 조회
	let dealGubunList = getCommonCode('시스템', '011'); // 거래구분
	let dealCorpStatusList = getCommonCode('시스템', '015'); // 거래상태
	let itemGubunList = getCommonCode('일반', '022'); // 품목구분
	let lcQualityGubunList = getCommonCode('일반', '021'); // 양불구분

	selectBoxAppend(dealGubunList, 'modalDealGubun', '', '1'); //거래구분
	selectBoxAppend(dealCorpStatusList, 'modalDealCorpStatus', '', '1'); //거래상태
	
	// 창고정보 ADM 목록조회
	$('#locationAdmTable thead tr').clone(true).addClass('filters').appendTo('#locationAdmTable thead'); // filter 생성
	let locationAdmTable = $('#locationAdmTable').DataTable({
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
			url : '<c:url value="/bm/locationAdmList"/>',
			type : 'GET',
			data : {
				itemGubun		:	'',
				lcTypeOutput 	:	'',
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'lcCd', className : 'text-center align-middle', name: 'lcCd',
				render: function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						return data;
					} else {
						return '<input type="text" class="form-control"><span class="d-none">'+data+'</span>';
					}
				}
			},
			{ data: 'lcNm', className : 'text-center align-middle', name: 'lcNm',
				render: function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						return data;
					} else {
						return '<input type="text" class="form-control"><span class="d-none">'+data+'</span>';
					}
				}
			},
			{ data: 'lcTypeOutput', className : 'text-center align-middle', name: 'lcTypeOutput',
				render : function(data, type, row, meta) {
					if(data!=null) {
						if(data == 'Y') {
							let html = '';
							html += '<input type="checkbox" class="bootstrapToggle lcTypeOutputToggle" data-toggle="toggle"';
							html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
							html += '		data-size="small"';
							html += '		disabled checked>';
							return html;
						} else {
							let html = '';
							html += '<input type="checkbox" class="bootstrapToggle lcTypeOutputToggle" data-toggle="toggle"';
							html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
							html += '		data-size="small"';
							html += '		disabled>';
							return html;
						}
					} else {
						let html = '';
						html += '<input type="checkbox" class="bootstrapToggle" data-toggle="toggle"';
						html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
						html += '		data-size="small"';
						html += '		>';
						return html;
					}
				}
			},
			{ data: 'lcTypeInput', className : 'text-center align-middle', name: 'lcTypeInput',
				render : function(data, type, row, meta) {
					if(data!=null) {
						if(data == 'Y') {
							let html = '';
							html += '<input type="checkbox" class="bootstrapToggle lcTypeInputToggle" data-toggle="toggle"';
							html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
							html += '		data-size="small"';
							html += '		disabled checked>';
							return html;
						} else {
							let html = '';
							html += '<input type="checkbox" class="bootstrapToggle lcTypeInputToggle" data-toggle="toggle"';
							html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
							html += '		data-size="small"';
							html += '		disabled>';
							return html;
						}
					} else {
						let html = '';
						html += '<input type="checkbox" class="bootstrapToggle" data-toggle="toggle"';
						html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
						html += '		data-size="small"';
						html += '		>';
						return html;
					}
				}
			},
			{ data: 'lcTypeReturn', className : 'text-center align-middle', name: 'lcTypeReturn',
				render : function(data, type, row, meta) {
					if(data!=null) {
						if(data == 'Y') {
							let html = '';
							html += '<input type="checkbox" class="bootstrapToggle lcTypeReturnToggle" data-toggle="toggle"';
							html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
							html += '		data-size="small"';
							html += '		disabled checked>';
							return html;
						} else {
							let html = '';
							html += '<input type="checkbox" class="bootstrapToggle lcTypeReturnToggle" data-toggle="toggle"';
							html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
							html += '		data-size="small"';
							html += '		disabled>';
							return html;
						}
					} else {
						let html = '';
						html += '<input type="checkbox" class="bootstrapToggle" data-toggle="toggle"';
						html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
						html += '		data-size="small"';
						html += '		>';
						return html;
					}
				}
			},
			{ data: 'lcTypeQc', className : 'text-center align-middle', name: 'lcTypeQc',
				render : function(data, type, row, meta) {
					if(data!=null) {
						if(data == 'Y') {
							let html = '';
							html += '<input type="checkbox" class="bootstrapToggle lcTypeQcToggle" data-toggle="toggle"';
							html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
							html += '		data-size="small"';
							html += '		disabled checked>';
							return html;
						} else {
							let html = '';
							html += '<input type="checkbox" class="bootstrapToggle lcTypeQcToggle" data-toggle="toggle"';
							html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
							html += '		data-size="small"';
							html += '		disabled>';
							return html;
						}
					} else {
						let html = '';
						html += '<input type="checkbox" class="bootstrapToggle" data-toggle="toggle"';
						html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
						html += '		data-size="small"';
						html += '		>';
						return html;
					}
				}
			},
			{ data: 'lcTypeOutsourcing', className : 'text-center align-middle', name: 'lcTypeOutsourcing',
				render : function(data, type, row, meta) {
					if(data!=null) {
						if(data == 'Y') {
							let html = '';
							html += '<input type="checkbox" class="bootstrapToggle lcTypeOutsourcingToggle" data-toggle="toggle"';
							html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
							html += '		data-size="small"';
							html += '		disabled checked>';
							return html;
						} else {
							let html = '';
							html += '<input type="checkbox" class="bootstrapToggle lcTypeOutsourcingToggle" data-toggle="toggle"';
							html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
							html += '		data-size="small"';
							html += '		disabled>';
							return html;
						}
					} else {
						let html = '';
						html += '<input type="checkbox" class="bootstrapToggle" data-toggle="toggle"';
						html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
						html += '		data-size="small"';
						html += '		>';
						return html;
					}
				}
			},
			{ data: 'lcOutsourcing', className : 'text-center align-middle', name: 'lcOutsourcing',
				render: function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						return row['lcOutsourcingNm'];
					} else {
						let html = '';
						html += '<div style="display: flex; flex-wrap: 1 1 auto;" class="input-group">';
						html += '<input type="hidden" name="lcOutsourcing">'
						html += '<input type="text" class="form-control inputGroup" name="lcOutsourcingNm" disabled>';
						html += '<button type="button" class="inputGroup" onclick="lcOutsourcingDelete()" name="btnLcOutsourcingDelete" style="background-color: transparent;';
						html += 'border-color: transparent;position: absolute;top: 0;right:0;margin: 1px 23px;margin-left: 0px;border: none;"><i class="fa-solid fa-xmark"></i></button>';
						html += '<button type="button" class="btn btn-primary input-sub-search inputGroup" onclick="dealCorpSel()" name="btnDealCorpSel" style="padding: 1px 4px; margin-left: 0px;">';
						html += '<i class="fa-solid fa-magnifying-glass"></i>';
						html += '</button></div>';
						return html;
					}
				}
			},
			{ data: 'lcQualityGubun', className : 'text-center align-middle', name: 'lcQualityGubun',
				render: function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						return row['lcQualityGubunNm'];
					} else {
						let html = '';
						html += '<select class="form-select">';
						if(data==null) {
							lcQualityGubunList.forEach(function(item) {
								if(item.commonNm=='양품') {
									html +='	<option value="'+item.commonCd+'" selected>'+item.commonNm+'</option>';
								} else {
									html +='	<option value="'+item.commonCd+'">'+item.commonNm+'</option>';
								}
							});
						} else {
							lcQualityGubunList.forEach(function(item) {
								html +='	<option value="'+item.commonCd+'">'+item.commonNm+'</option>';
							});							
						}
						html += '</select><span class="d-none">'+data+'</span>';
					return html;
					}
				}
			},
			{ data: 'itemGubun', className : 'text-center align-middle', name: 'itemGubun',
				render: function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						return row['itemGubunNm'];
					} else {
						let html = '';
						html += '<select class="form-select">';
						if(data==null) {
							itemGubunList.forEach(function(item) {
								if(item.commonNm=='제품') {
									html +='	<option value="'+item.commonCd+'" selected>'+item.commonNm+'</option>';
								} else {
									html +='	<option value="'+item.commonCd+'">'+item.commonNm+'</option>';
								}
							});
						} else {
							itemGubunList.forEach(function(item) {
								html +='	<option value="'+item.commonCd+'">'+item.commonNm+'</option>';
							});							
						}
						html += '</select><span class="d-none">'+data+'</span>';
					return html;
					}
				}
			},
			{ data: 'useYn', className : 'text-center align-middle', name: 'useYn',
				render: function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						if(data == 'Y') {
							return '사용';
						} else {
							return '미사용';
						}
					} else {
						return '<select onchange="useYnChange()" class="form-select" name="useYn"><option value="Y" selected>사용</option><option value="N">미사용</option></select><span class="d-none">'+data+'</span>';
					}
				}
			},
			
			{ data: 'lcEndDate', className : 'text-center align-middle', name: 'lcEndDate',
				render: function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						if(data=='') {
							return '';
						} else {
							return moment(data).format('YYYY-MM-DD');
						}
						
					} else {
						return '<input type="date" max="9999-12-31" class="form-control">';
					}
				}
			},
			{ data: 'lcNote', className : 'text-center align-middle', name: 'lcNote',
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
			let middlecolT_height = parseFloat($('#middlecolT').css('height'));
			let theadHeight = parseFloat($('#locationAdmTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#locationAdmTable_wrapper').find('.dataTables_scrollBody').css('height',(middlecolT_height - theadHeight - 80)+'px');

			$('.bootstrapToggle').bootstrapToggle();
			
			$('#locationAdmTable_filter').addClass('d-none');
			// 통합검색
			$('#searchAllAdm').off('keyup',function() {});
			$('#searchAllAdm').on('keyup',function() {
				$('#locationAdmTable_filter').find('input').val($(this).val());
				$('#locationAdmTable_filter').find('input').trigger('keyup');
			});
		},
		initComplete: function () {
			let api = this.api();
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#locationAdmTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title.replaceAll('*','') + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#locationAdmTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	locationAdmTable.on('column-reorder', function( e, settings, details ) {
		let api = commonCodeAdmTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#locationAdmTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
		$('.bootstrapToggle').bootstrapToggle();
	});
	
	// 공통코드관리 ADM 조회 버튼 click
	$('#btnSearch').on('click', function() {
		if(WMCheck('ADM')) {
			return false;
		}
		
		locationAdmTable.ajax.reload(function() {
			$('#locationAdmTable_wrapper').find('.filters th').each(function(index, item) {
				$(item).find('input').attr('disabled', false);// 검색 필터 enable
			});
			locationAdmTable.colReorder.enable();
		});

		$('#btnNewAdm').attr('disabled', false); // 신규 버튼
		$('#btnSaveAdm').attr('disabled', true); // 저장 버튼
		$('#btnEditAdm').attr('disabled', false); // 수정 버튼
		$('#btnDelAdm').attr('disabled', false); // 삭제 버튼
		$('#btnCancelAdm').attr('disabled', true); // 취소 버튼
	});

	// 창고정보 click
	$('#locationAdmTable tbody').on('click','tr', function() {
		let idx = locationAdmTable.row(this).data().idx;
		lcCdVal = locationAdmTable.row(this).data().lcCd;
		lcNmVal = locationAdmTable.row(this).data().lcNm;
		lcAdmIdxVal = idx;
		
		if(WMCheck('DTL')) { // 공통코드관리 DTL 수정중이거나 등록중일 경우
			setWM('DTL', 'idx', idx);
			return false;
		}
		
		locationDtlTable.ajax.reload(function() {
			$('#btnNewDtl').attr('disabled', false); // DTL 신규 버튼
			$('#btnSaveDtl').attr('disabled', true); // DTL 저장 버튼
			$('#btnEditDtl').attr('disabled', false); // DTL 수정 버튼
			$('#btnDelDtl').attr('disabled', false); // DTL 삭제 버튼
			$('#btnCancelDtl').attr('disabled', true); // DTL 취소 버튼
		});

		$('#locationAdmTable_wrapper').find('.filters th').each(function(index, item) {
			$(item).find('input').attr('disabled', false);// 검색 필터 enable
		});
	});

	// 공통코드관리 ADM 신규 버튼 click
	$('#btnNewAdm').on('click', function() {
		WM_action_ON('ADM','workingWarningModal');
		let col_filter_text = [];
		$('#locationAdmTable_wrapper').find('.filters th').each(function(index, item) {
			$(item).find('input').attr('disabled', true); // 검색 필터 disabled
			col_filter_text.push($(item).find('input').val());
		});
		console.log(col_filter_text)
		locationAdmTable.row.add({
			'idx'				:	'',
			'lcCd'				:	col_filter_text[0],
			'lcNm'				:	col_filter_text[1],
			'lcTypeOutput'		:	null,
			'lcTypeInput'		:	null,
			'lcTypeReturn'		:	null,
			'lcTypeQc'			:	null,
			'lcTypeOutsourcing'	:	null,
			'lcOutsourcing'		:	col_filter_text[7],
			'lcQualityGubun'		:	col_filter_text[8],
			'itemGubun'			:	col_filter_text[9],
			'useYn'				:	col_filter_text[10],
			'lcEndDate'			:	col_filter_text[11],
			'lcNote'			:	col_filter_text[12],
		}).draw(false);

		locationAdmTable.colReorder.disable();

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
		$('#locationAdmTable tbody').find('tr').each(function(index, item) {
			let node = $(item);
			let tr = $(node).parent().parent();
			let td = $(item).find('td');
			let idx = locationAdmTable.row($(item)).data().idx;
			if($(item).find('td').find('input').length != 0 && $(item).find('td').find('select').length != 0) {
				let lcCd = $(td).eq(locationAdmTable.column('lcCd:name').index()).find('input').val();
				let lcNm = $(td).eq(locationAdmTable.column('lcNm:name').index()).find('input').val();
				let lcTypeOutput = $(td).eq(locationAdmTable.column('lcTypeOutput:name').index()).find('input').prop('checked')?'Y':'N';
				let lcTypeInput = $(td).eq(locationAdmTable.column('lcTypeInput:name').index()).find('input').prop('checked')?'Y':'N';
				let lcTypeReturn = $(td).eq(locationAdmTable.column('lcTypeReturn:name').index()).find('input').prop('checked')?'Y':'N';
				let lcTypeQc = $(td).eq(locationAdmTable.column('lcTypeQc:name').index()).find('input').prop('checked')?'Y':'N';
				let lcTypeOutsourcing = $(td).eq(locationAdmTable.column('lcTypeOutsourcing:name').index()).find('input').prop('checked')?'Y':'N';

				let lcOutsourcing = $(td).eq(locationAdmTable.column('lcOutsourcing:name').index()).find('input').val();
				if($(this).find("td input[name=lcOutsourcingNm]").val()=='') {
					lcOutsourcing = '0';
				}
				let lcQualityGubun = $(td).eq(locationAdmTable.column('lcQualityGubun:name').index()).find('select').val();
				let itemGubun = $(td).eq(locationAdmTable.column('itemGubun:name').index()).find('select').val();
				let useYn = $(td).eq(locationAdmTable.column('useYn:name').index()).find('select').val();
				let lcEndDate = $(td).eq(locationAdmTable.column('lcEndDate:name').index()).find('input').val().replace(/-/g,"");
				let lcNote = $(td).eq(locationAdmTable.column('lcNote:name').index()).find('input').val();

				let itemGubunNm = locationAdmTable.row(index).data().itemGubunNm;
				let lcAdmIdx = null;
				let lcDtlDesc = null;
				let lcDtlNm = null;
				let lcDtlX = null;
				let lcDtlY = null;
				let lcDtlZ = null;
				let lcOutsourcingNm = locationAdmTable.row(index).data().lcOutsourcingNm;
				let lcQualityGubunNm = locationAdmTable.row(index).data().lcQualityGubunNm;
				let regDate = null;
				let regIdx = null;
				let updDate = null;
				let updIdx = null;
				
				if(lcCd == '') {
					toastr.warning('창고코드를 입력해주세요.');
					$(td).eq(locationAdmTable.column('lcCd:name').index()).find('input').focus();
					state = false;
					return false;
				}
				if(lcNm == '') {
					toastr.warning('창고명을 입력해주세요.');
					$(td).eq(locationAdmTable.column('lcNm:name').index()).find('input').focus();
					state = false;
					return false;
				}
				if(useYn=='N' && lcEndDate=='') {
					toastr.warning('종료일을 입력해주세요.');
					$(td).eq(locationAdmTable.column('lcEndDate:name').index()).find('input').focus();
					state = false;
					return false;
				}

				let obj = new Object();
				obj.idx = idx;
				obj.lcCd = lcCd;
				obj.lcNm = lcNm;
				obj.lcTypeOutput = lcTypeOutput;
				obj.lcTypeInput = lcTypeInput;
				obj.lcTypeReturn = lcTypeReturn;
				obj.lcTypeQc = lcTypeQc;
				obj.lcTypeOutsourcing = lcTypeOutsourcing;
				obj.lcOutsourcing = lcOutsourcing;
				obj.lcQualityGubun = lcQualityGubun;
				obj.itemGubun = itemGubun;
				obj.useYn = useYn;
				obj.lcEndDate = lcEndDate;
				obj.lcNote = lcNote;

				obj.itemGubunNm = itemGubunNm;
				obj.lcAdmIdx = lcAdmIdx;
				obj.lcDtlDesc = lcDtlDesc;
				obj.lcDtlNm = lcDtlNm;
				obj.lcDtlX = lcDtlX;
				obj.lcDtlY = lcDtlY;
				obj.lcDtlZ = lcDtlZ;
				obj.lcOutsourcingNm = lcOutsourcingNm;
				obj.lcQualityGubunNm = lcQualityGubunNm;
				obj.regDate = regDate;
				obj.regIdx = regIdx;
				obj.updDate = updDate;
				obj.updIdx = updIdx;
			    
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
		console.log(array)
		console.log(locationAdmTable.data().toArray())
		array = _.differenceWith(array, locationAdmTable.data().toArray(), _.isEqual);
		console.log(array)
		
		$.ajax({
			url: '<c:url value="/bm/locationAdmIU"/>',
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
					locationAdmTable.ajax.reload();
					$('.lcTypeOutputToggle').attr('disabled', true);
					$('.lcTypeInputToggle').attr('disabled', true);
					$('.lcTypeReturnToggle').attr('disabled', true);
					$('.lcTypeQcToggle').attr('disabled', true);
					$('.lcTypeOutsourcingToggle').attr('disabled', true);
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
		$('#locationAdmTable_wrapper').find('.filters th').each(function(index, item) {
			$(item).find('input').attr('disabled', true); // 검색 필터 disabled
		});
		
		$('#locationAdmTable tbody').find('tr').each(function(index_tr, tr) {
			$(tr).find('td').each(function(index_td, td) {
				if($(td).find('input').length == 0 && $(td).find('select').length == 0 && $(tr).find('td').length != 1) {
					if(index_td == locationAdmTable.column('lcQualityGubun:name').index()) {
						let value = locationAdmTable.row(tr).data().lcQualityGubun;
						let html = '';
						html += '<select class="form-select">';
						lcQualityGubunList.forEach(function(item) {
							if(item.commonCd==value) {
								html +='<option value="'+item.commonCd+'" selected>'+item.commonNm+'</option>';
							} else {
								html +='<option value="'+item.commonCd+'">'+item.commonNm+'</option>';
							}
						});
						html += '</select>';
						$(td).html(html);
					} else if(index_td == locationAdmTable.column('itemGubun:name').index()) {
						let value = locationAdmTable.row(tr).data().itemGubun;
						let html = '';
						html += '<select class="form-select">';
						itemGubunList.forEach(function(item) {
							if(item.commonCd==value) {
								html +='<option value="'+item.commonCd+'" selected>'+item.commonNm+'</option>';
							} else {
								html +='<option value="'+item.commonCd+'">'+item.commonNm+'</option>';
							}
						});
						html += '</select>';
						$(td).html(html);
						
					} else if(index_td == locationAdmTable.column('useYn:name').index()) {
						let value = locationAdmTable.row(tr).data().useYn;
						if(value == 'Y') {
							$(td).html('<select class="form-select"><option value="Y" selected>사용</option><option value="N">미사용</option></select>');
						} else {
							$(td).html('<select class="form-select"><option value="Y">사용</option><option value="N" selected>미사용</option></select>');
						}
						
					} else if(index_td == locationAdmTable.column('lcTypeOutput:name').index()) {
						let value = locationAdmTable.row(tr).data().lcTypeOutput;
						if(value == 'Y') {
							let html = '';
							html += '<input type="checkbox" class="bootstrapToggle lcTypeOutputToggle" data-toggle="toggle"';
							html += '	data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
							html += '	data-size="small"';
							html += 'checked>';
						} else {
							let html = '';
							html += '<input type="checkbox" class="bootstrapToggle lcTypeOutputToggle" data-toggle="toggle"';
							html += '	data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
							html += '	data-size="small"';
							html += '>';
						}
						$(td).html(html);
					} else if(index_td == locationAdmTable.column('lcTypeInput:name').index()) {
						let value = locationAdmTable.row(tr).data().lcTypeInput;
						if(value == 'Y') {
							let html = '';
							html += '<input type="checkbox" class="bootstrapToggle lcTypeInputToggle" data-toggle="toggle"';
							html += '	data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
							html += '	data-size="small"';
							html += 'checked>';
						} else {
							let html = '';
							html += '<input type="checkbox" class="bootstrapToggle lcTypeInputToggle" data-toggle="toggle"';
							html += '	data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
							html += '	data-size="small"';
							html += '>';
						}
						$(td).html(html);
					} else if(index_td == locationAdmTable.column('lcTypeReturn:name').index()) {
						let value = locationAdmTable.row(tr).data().lcTypeReturn;
						if(value == 'Y') {
							let html = '';
							html += '<input type="checkbox" class="bootstrapToggle lcTypeReturnToggle" data-toggle="toggle"';
							html += '	data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
							html += '	data-size="small"';
							html += 'checked>';
						} else {
							let html = '';
							html += '<input type="checkbox" class="bootstrapToggle lcTypeReturnToggle" data-toggle="toggle"';
							html += '	data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
							html += '	data-size="small"';
							html += '>';
						}
						$(td).html(html);
					} else if(index_td == locationAdmTable.column('lcTypeQc:name').index()) {
						let value = locationAdmTable.row(tr).data().lcTypeQc;
						if(value == 'Y') {
							let html = '';
							html += '<input type="checkbox" class="bootstrapToggle lcTypeQcToggle" data-toggle="toggle"';
							html += '	data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
							html += '	data-size="small"';
							html += 'checked>';
						} else {
							let html = '';
							html += '<input type="checkbox" class="bootstrapToggle lcTypeQcToggle" data-toggle="toggle"';
							html += '	data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
							html += '	data-size="small"';
							html += '>';
						}
						$(td).html(html);
					} else if(index_td == locationAdmTable.column('lcTypeOutsourcing:name').index()) {
						let value = locationAdmTable.row(tr).data().lcTypeOutsourcing;
						if(value == 'Y') {
							let html = '';
							html += '<input type="checkbox" class="bootstrapToggle lcTypeOutsourcingToggle" data-toggle="toggle"';
							html += '	data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
							html += '	data-size="small"';
							html += 'checked>';
						} else {
							let html = '';
							html += '<input type="checkbox" class="bootstrapToggle lcTypeOutsourcingToggle" data-toggle="toggle"';
							html += '	data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
							html += '	data-size="small"';
							html += '>';
						}
						$(td).html(html);
					} else if(index_td == locationAdmTable.column('lcOutsourcing:name').index()) {
						let value = locationAdmTable.row(tr).data().lcOutsourcing;
						let value2 = locationAdmTable.row(tr).data().lcOutsourcingNm;
						if(value2==null) {
							value2 = '';
						}
						let html = '';
						html += '<div style="display: flex; flex-wrap: 1 1 auto;" class="input-group">';
						html += '<input type="hidden" name="lcOutsourcing" value="'+value+'">'
						html += '<input type="text" class="form-control inputGroup" name="lcOutsourcingNm" value="'+value2+'" disabled>';
						html += '<button type="button" class="inputGroup" onclick="lcOutsourcingDelete()" name="btnLcOutsourcingDelete" style="background-color: transparent;';
						html += 'border-color: transparent;position: absolute;top: 0;right:0;margin: 1px 23px;margin-left: 0px;border: none;"><i class="fa-solid fa-xmark"></i></button>'; 
						html += '<button type="button" class="btn btn-primary input-sub-search inputGroup" onclick="dealCorpSel()" name="btnDealCorpSel" style="padding: 1px 4px; margin-left: 0px;">';
						html += '<i class="fa-solid fa-magnifying-glass"></i>';
						html += '</button></div>';
						$(td).html(html);
					} else if(index_td == locationAdmTable.column('lcEndDate:name').index()) {
						let value = $(td).text();
						if(value!='') {
							$(td).html('<input type="date" max="9999-12-31" class="form-control" value="'+moment(value).format('YYYY-MM-DD')+'">');
						} else {
							$(td).html('<input type="date" max="9999-12-31" class="form-control">');
						}
						
					} else {
						let value = $(td).text();
						$(td).html('<input type="text" class="form-control" value="'+value+'">');
					}
				}
			})
		});

		//애네뭐지..
		//$('.lcTypeOutputToggle').attr('disabled', false);
		//$('.lcTypeInputToggle').attr('disabled', false);
		//$('.lcTypeReturnToggle').attr('disabled', false);
		//$('.lcTypeQcToggle').attr('disabled', false);
		//$('.lcTypeOutsourcingToggle').attr('disabled', false);
		
		$('.lcTypeOutputToggle').bootstrapToggle('enable');
		$('.lcTypeInputToggle').bootstrapToggle('enable');
		$('.lcTypeReturnToggle').bootstrapToggle('enable');
		$('.lcTypeQcToggle').bootstrapToggle('enable');
		$('.lcTypeOutsourcingToggle').bootstrapToggle('enable');
		
		
		locationAdmTable.colReorder.disable();

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

	// 삭제 경고창 삭제 버튼 click
	$('#btnDeleteModalY').on('click', function() {
		let deleteType = $('#deleteModal').data('deleteType');
		let idx = locationDtlTable.row('.selected').data().idx;
		$.ajax({
			url: '<c:url value="/bm/locationDtlDelete"/>',
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
					locationDtlTable.row('.selected').remove().draw(false);
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
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
			
			locationAdmTable.colReorder.enable();
			
			$('#btnNewAdm').attr('disabled', false); // 신규 버튼
			$('#btnSaveAdm').attr('disabled', true); // 저장 버튼
			$('#btnEditAdm').attr('disabled', false); // 수정 버튼
			$('#btnDelAdm').attr('disabled', false); // 삭제 버튼
			$('#btnCancelAdm').attr('disabled', true); // 취소 버튼
		} else {
			toastr.success('취소되었습니다.');
			WM_action_OFF('DTL');

			locationDtlTable.ajax.reload();
			
			locationDtlTable.colReorder.disable();
			
			$('#btnNewDtl').attr('disabled', false); // 신규 버튼
			$('#btnSaveDtl').attr('disabled', true); // 저장 버튼
			$('#btnEditDtl').attr('disabled', false); // 수정 버튼
			$('#btnDelDtl').attr('disabled', false); // 삭제 버튼
			$('#btnCancelDtl').attr('disabled', true); // 취소 버튼
		}
	});
	
	
	// 공통코드관리 DTL 목록조회
	$('#locationDtlTable thead tr').clone(true).addClass('filters').appendTo('#locationDtlTable thead'); // filter 생성
	let locationDtlTable = $('#locationDtlTable').DataTable({
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
			url : '<c:url value="/bm/locationDtlList"/>',
			type : 'GET',
			data : {
				lcAdmIdx	:	function() { return lcAdmIdxVal; },
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'lcCd', className : 'text-center', name: 'lcCd',
				render: function(data, type, row, meta) {
					return data;
				}
			},
			{ data: 'lcNm', className : 'text-center', name: 'lcNm',
				render: function(data, type, row, meta) {
					return data;
				}
			},
			{ data: 'lcDtlNm', className : 'text-center', name: 'lcDtlNm',
				render: function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						return data;
					} else {
						return '<input type="text" class="form-control"><span class="d-none">'+data+'</span>';
					}
				}
			},
			{ data: 'lcDtlX', className : 'text-center', name: 'lcDtlX',
				render: function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						return data;
					} else {
						return '<input type="text" class="form-control"><span class="d-none">'+data+'</span>';
					}
				}
			},
			{ data: 'lcDtlY', className : 'text-center', name: 'lcDtlY',
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
			{ data: 'lcDtlDesc', className : 'text-center', name: 'lcDtlDesc',
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
			let middlecolB_height = parseFloat($('#middlecolB').css('height'));
			let theadHeight = parseFloat($('#locationDtlTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#locationDtlTable_wrapper').find('.dataTables_scrollBody').css('height',(middlecolB_height - theadHeight - 80)+'px');
			
			$('#locationDtlTable_filter').addClass('d-none');
			// 통합검색
			$('#searchAllDtl').off('keyup',function() {});
			$('#searchAllDtl').on('keyup',function() {
				$('#locationDtlTable_filter').find('input').val($(this).val());
				$('#locationDtlTable_filter').find('input').trigger('keyup');
			});
		},
		initComplete: function () {
			let api = this.api();
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#locationDtlTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title.replaceAll('*','') + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#locationDtlTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	locationDtlTable.on('column-reorder', function( e, settings, details ) {
		let api = commonCodeDtlTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#locationDtlTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});


	// 공통코드관리 DTL 신규 버튼 click
	$('#btnNewDtl').on('click', function() {
		if(locationAdmTable.row('.selected').data() == undefined || lcAdmIdxVal=='') {
			toastr.warning('추가하실 코드그룹을 선택해주세요.');
			return false;
		}
		WM_action_ON('DTL','workingWarningModal');
		
		let col_filter_text = [];
		$('#locationDtlTable_wrapper').find('.filters th').each(function(index, item) {
			$(item).find('input').attr('disabled', true); // 검색 필터 disabled
			col_filter_text.push($(item).find('input').val());
		});
		
		locationDtlTable.row.add({
			'idx'				:	'',
			'lcCd'				:	lcCdVal,
			'lcNm'				:	lcNmVal,
			'lcAdmIdx'			:	lcAdmIdxVal,
			'lcDtlNm'			:	col_filter_text[2],
			'lcDtlX'			:	col_filter_text[3],
			'lcDtlY'			:	col_filter_text[4],
			'useYn'				:	col_filter_text[5],
			'etc1'				:	col_filter_text[6],
		}).draw(false);

		locationDtlTable.colReorder.disable();

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
		$('#locationDtlTable tbody').find('tr').each(function(index, item) {
			if($(item).find('td').find('input').length != 0) {
				let td = $(item).find('td');
				let idx = locationDtlTable.row($(item)).data().idx;
				let lcDtlNm = $(td).eq(locationDtlTable.column('lcDtlNm:name').index()).find('input').val();
				let lcDtlX = $(td).eq(locationDtlTable.column('lcDtlX:name').index()).find('input').val();
				let lcDtlY = $(td).eq(locationDtlTable.column('lcDtlY:name').index()).find('input').val();
				let useYn = $(td).eq(locationDtlTable.column('useYn:name').index()).find('select').val();
				let lcDtlDesc = $(td).eq(locationDtlTable.column('lcDtlDesc:name').index()).find('input').val();
				if(lcDtlNm == '') {
					toastr.warning('구역을 입력해주세요.');
					$(td).eq(locationDtlTable.column('lcDtlNm:name').index()).find('input').focus();
					state = false;
					return false;
				}
				if(lcDtlX == '') {
					toastr.warning('위치(단)을 입력해주세요.');
					$(td).eq(locationDtlTable.column('lcDtlX:name').index()).find('input').focus();
					state = false;
					return false;
				}

				let obj = new Object();
				obj.idx = idx;
				obj.itemGubun = null;
				obj.itemGubunNm = null;
				obj.lcCd = locationAdmTable.row('.selected').data().lcCd;
				obj.lcDtlZ = null;
				obj.lcEndDate = null;
				obj.lcNm = locationAdmTable.row('.selected').data().lcNm;
				obj.lcNote = null;
				obj.lcOutsourcing = null;
				obj.lcOutsourcingNm = null;
				obj.lcQualityGubun = null;
				obj.lcQualityGubunNm = null;
				obj.lcTypeInput = null;
				obj.lcTypeOutput = null;
				obj.lcTypeOutsourcing = null;
				obj.lcTypeQc = null;
				obj.lcTypeReturn = null;
				obj.regDate = null;
				obj.regIdx = null;
				obj.updDate = null;
				obj.updIdx = null;
				
				
				obj.lcAdmIdx = lcAdmIdxVal;
				obj.lcDtlNm = lcDtlNm;
				obj.lcDtlX = lcDtlX;
				obj.lcDtlY = lcDtlY;
				obj.useYn = useYn;
				obj.lcDtlDesc = lcDtlDesc;
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
		console.log(array)
		console.log(locationDtlTable.data().toArray())
		array = _.differenceWith(array, locationDtlTable.data().toArray(), _.isEqual);
		console.log(array)
		
		$.ajax({
			url: '<c:url value="/bm/locationDtlIU"/>',
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

					locationDtlTable.ajax.reload(function() {
						$('#locationDtlTable_wrapper').find('.filters th').each(function(index, item) {
							$(item).find('input').attr('disabled', false);// 검색 필터 enable
						});
					});
					locationDtlTable.colReorder.enable();
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

		if(locationAdmTable.row('.selected').data() == undefined || lcAdmIdxVal=='') {
			toastr.warning('추가하실 코드그룹을 선택해주세요.');
			return false;
		}
		
		WM_action_ON('DTL','workingWarningModal');
		
		$('#locationDtlTable_wrapper').find('.filters th').each(function(index, item) {
			$(item).find('input').attr('disabled', true); // 검색 필터 disabled
		});
		
		$('#locationDtlTable tbody').find('tr').each(function(index_tr, tr) {
			$(tr).find('td').each(function(index_td, td) {
				if($(td).find('input').length == 0 && $(td).find('select').length == 0 && $(tr).find('td').length != 1) {
					if(index_td == locationDtlTable.column('lcCd:name').index() || index_td == locationDtlTable.column('lcNm:name').index()) {
						
					} else if(index_td == locationDtlTable.column('useYn:name').index()) {
						let value = locationDtlTable.row(tr).data().useYn;
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

		locationDtlTable.colReorder.disable();

		$('#btnNewDtl').attr('disabled', false); // DTL 신규 버튼
		$('#btnSaveDtl').attr('disabled', false); // DTL 저장 버튼
		$('#btnEditDtl').attr('disabled', true); // DTL 수정 버튼
		$('#btnDelDtl').attr('disabled', false); // DTL 삭제 버튼
		$('#btnCancelDtl').attr('disabled', false); // DTL 취소 버튼
	});

	// 공통코드관리 DTL 삭제 버튼 click
	$('#btnDelDtl').on('click', function() {

		if(locationAdmTable.row('.selected').data() == undefined || lcAdmIdxVal=='') {
			toastr.warning('추가하실 코드그룹을 선택해주세요.');
			return false;
		}
		
		if($('#locationDtlTable tbody').find('tr.selected').length == 0) {
			toastr.warning('삭제할 항목을 선택해주세요.');
			return false;
		}

		let data = locationDtlTable.row('.selected').data();

		if(data.idx != '') {
			$('#deleteModal').modal('show');
			$('#deleteModal').data('deleteType','DTL');
		} else {
			locationDtlTable.row('.selected').remove().draw();
		}
	});

	// 공통코드관리 DTL 취소 버튼 click
	$('#btnCancelDtl').on('click', function() {
		$('#cancelModal').modal('show');
		$('#cancelModal').data('cancelType', 'DTL');
	});

	function useYnChange() {
		let useYnVal = $('#locationAdmTable').DataTable().$('tr.selected').find('select[name=useYn]').val();
		if(useYnVal == 'N') {
			$('#locationAdmTable').DataTable().$('tr.selected').find('select[name=useYn]').val('Y');
			$('#useYnCheckModal').modal('show');
		}
	}

	//변경 확인
	$('#btnUseYnN').on('click', function() {
		$('#locationAdmTable').DataTable().$('tr.selected').find('select[name=useYn]').val('N');
		$('#useYnCheckModal').modal('hide');
	});

	//변경 취소
	$('#btnUseYnY').on('click', function() {
		$('#useYnCheckModal').modal('hide');
	});
	
	function dealCorpSel() {
		$('#dealCorpModal').modal('show');
		setTimeout(function() {
			dealCorpModalTable.ajax.reload(function() {});
			setTimeout(function() {
				$('#dealCorpModalTable').DataTable().$('tr.selected').removeClass('selected');
			}, 500);
		}, 200);
	}

	
	// 거래처정보 목록조회
	$('#dealCorpModalTable thead tr').clone(true).addClass('filters').appendTo('#dealCorpModalTable thead'); // filter 생성
	let dealCorpModalTable = $('#dealCorpModalTable').DataTable({
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
			let theadHeight = parseFloat($('#dealCorpModalTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 223)+'px');
			
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
				let cell = $('#dealCorpModalTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
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
	
	// 거래처모달 조회 버튼 click
	$('#btnDealCorpModalSearch').on('click', function() {
		dealCorpModalTable.ajax.reload(function(){});
	});
	
	// 거래처목록 적용 버튼 click
	$('#btnDealCorpModalPaste').on('click', function(){

		if( !$('#dealCorpModalTable tbody tr').hasClass('selected') ){
			toastr.warning('적용할 행을 선택해주세요.');
			return false;
		}
		
		let data = dealCorpModalTable.row('.selected').data();
		$('#locationAdmTable').DataTable().$('tr.selected').find('input[name=lcOutsourcing]').val(data.idx);
		$('#locationAdmTable').DataTable().$('tr.selected').find('input[name=lcOutsourcingNm]').val(data.dealCorpNm);
		$('#dealCorpModal').modal('hide');
	});

	$('#dealCorpModalTable tbody').on('dblclick','tr',function(){
		let data = dealCorpModalTable.row(this).data();
		$('#locationAdmTable').DataTable().$('tr.selected').find('input[name=lcOutsourcing]').val(data.idx);
		$('#locationAdmTable').DataTable().$('tr.selected').find('input[name=lcOutsourcingNm]').val(data.dealCorpNm);
		$('#dealCorpModal').modal('hide');
	});

	function lcOutsourcingDelete() {
		$('#locationAdmTable').DataTable().$('tr.selected').find('input[name=lcOutsourcing]').val('');
		$('#locationAdmTable').DataTable().$('tr.selected').find('input[name=lcOutsourcingNm]').val('');
	}

	/*
	$(document).on('change','#bizOrderDtlTable .confirmToggle', function() {
		let idx = $(this).data('idx');
		let type = $(this).data('type');
		let check = $(this).prop('checked');

		
		let ajaxData = {};
		ajaxData.idx = idx;
		if(type == 'confirmOrder') { // 수주확정을 눌렀을 경우
			ajaxData.confirmOrder = (check?'Y':'N');
		} else if(type == 'confirmDesign') { // 디자인컨펌을 눌렀을 경우
			ajaxData.confirmDesign = (check?'Y':'N');
		}

		console.log(type);
		console.log(check);
		console.log(ajaxData);
		
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
					bizOrderDtlTable.ajax.reload();
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
					bizOrderDtlTable.ajax.reload();
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
	});
	*/
</script>

</body>
</html>
