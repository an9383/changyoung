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
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">수리시작일</label>
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
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">설비코드</label>
					<select class="form-select h-100 me-3 w-auto" id="searchEquipCd" style="width: 220px;"></select>
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">사용여부</label>
					<select class="form-select w-auto h-100 me-3" id="searchUseYnCd" style="min-width: 70px;">
						<option value="" selected="">전체</option>
						<option value="Y">사용</option>
						<option value="N">미사용</option>
					</select>
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
				<table class="table table-bordered p-0 m-0" id="equipRepairHistAdmViewTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle">설비코드</th>
							<th class="text-center align-middle">설비명</th>
							<th class="text-center align-middle">제조사</th>
							<th class="text-center align-middle">구입일자</th>
							<th class="text-center align-middle">사용여부</th>
							<th class="text-center align-middle">설치위치</th>
							<th class="text-center align-middle">수리코드</th>
							<th class="text-center align-middle">시작일</th>
							<th class="text-center align-middle">종료일</th>
							<th class="text-center align-middle">수리내용</th>
							<th class="text-center align-middle">수리업체</th>
							<th class="text-center align-middle">수리비</th>
							<th class="text-center align-middle">부품비</th>
							<th class="text-center align-middle">인건비</th>
							<th class="text-center align-middle">비고</th>
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
</script>

<script>

	let selectPeriod = parseInt(getCommonCode('시스템', '040')[0].commonCd); //기본조회기간 일
	$('#startDate').val(moment().subtract('d',selectPeriod).format('YYYY-MM-DD'));
	$('#endDate').val(moment().format('YYYY-MM-DD'));
	
	let monthAdjustList = getCommonCode('시스템', '026'); //날짜조정
	monthAdjustList = _.sortBy(monthAdjustList, v=>parseInt(v.commonCd));
	selectBoxAppend(monthAdjustList, 'monthAdjust', '', '2'); //날짜조정

	// 공통코드 조회
	let repairCdList  = getCommonCode('일반', '029'); //수리코드
	
	let equipCdList = new Array();	//설비 코드 리스트

	//설비 코드 담기
	$.ajax({
		url: '<c:url value="/em/equipInfoListAll"/>',
        type: 'GET',
        async: false,
        data: {},
		success : function(res) {
			let data = res.data;
			data.forEach((item) => {
				var equipData = new Object();
				equipData.id = item.equipCd;
				equipData.text = item.equipNm;
				equipCdList.push(equipData);
			});

			$('#searchEquipCd').select2({
				data: equipCdList,
				multiple : true,
				placeholder: "설비 선택",
			});
			$('#searchEquipCd').find('span').eq(0).css('width','100%');
			$('#searchEquipCd').find('.select2-search__field').css('width','100%');
			$('.select2-container').addClass('me-1');
		}
	});

	$('#searchEquipCd').on('change',function(e) {
		let searchEquipCdDataList = $('#searchEquipCd').val();
		width = 220;
		
		if(searchEquipCdDataList.length<=2) {
			document.getElementById('searchEquipCd').style.width=width+'px';
		} else {
			console.log(searchEquipCdDataList)
			for(let i = 2; i<searchEquipCdDataList.length;i++) {
				let equipCd = searchEquipCdDataList[i];
				equipCdList.forEach((item) => {
					let equipTextLength = 0;
					if(item.id==equipCd) {
						equipTextLength = (item.text).length;
						if(equipTextLength<=4) {
							width = width+(equipTextLength*20);
						} else {
							width = width+(equipTextLength*16);
						}
						
						return false;
					}
				});
			}
			console.log(width)
			document.getElementById('searchEquipCd').style.width=width+'px';
		}
		
		$('#searchEquipCd').select2({
			data: equipCdList,
			multiple : true,
			placeholder: "설비 선택",
		});
		$('#searchEquipCd').find('span').eq(0).css('width','100%');
		$('#searchEquipCd').find('.select2-search__field').css('width','100%');
		$('.select2-container').addClass('me-1');
	})

	// 수주관리 전체 목록조회
	$('#equipRepairHistAdmViewTable thead tr').clone(true).addClass('filters').appendTo('#equipRepairHistAdmViewTable thead'); // filter 생성
	let equipRepairHistAdmViewTable = $('#equipRepairHistAdmViewTable').DataTable({
		dom : "<'row'<'col-md-12 col-md-6'l><'col-md-12 col-md-6'f>>"
				+ "<'row'<'col-md-12'tr>>"
				+ "<'row pt-1'<'d-flex align-items-center d-flex'Bp><'me-lg-auto'><'d-flex align-items-center justify-content-end'i>>",
		language: lang_kor,
		info: true,
		ordering: false,
		processing: false,
		paging: false,
		lengthChange: false,
		searching: true,
		autoWidth: false,
		orderCellsTop: false,
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
			url : '<c:url value="/em/equipRepairHistAdmStatusLst"/>',
			type : 'POST',
			data : {
				startDate	: function() { return moment($('#startDate').val(),'YYYY-MM-DD').format('YYYYMMDD'); },
				endDate		: function() { return moment($('#endDate').val(),'YYYY-MM-DD').format('YYYYMMDD'); },
				useYn		: function() { return $('#searchUseYnCd').val();},
				repairCd	: function() {
					if($('#searchEquipCd').val().length == 0) {
						return '';
					} else {
						return $('#searchEquipCd').val().join(',');
					}
				}
			},
		},
        rowId: 'rowNumber',
		columns : [
			{ data: 'equipCd', className : 'text-center align-middle', name: 'rowspan' },
			{ data: 'equipNm', className : 'text-center align-middle', name: 'rowspan' },
			{ data: 'makerNm', className : 'text-center align-middle', name: 'rowspan' },
			{ data: 'buyDate', className : 'text-center align-middle', name: 'rowspan',
				render : function(data, type, row, meta) {
					if(data != '' && data != null) {
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data,'YYYYMMDD').format('YYYY-MM-DD')+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'useYn', className : 'text-center align-middle', name: 'rowspan' },
			{ data: 'setupLocation', className : 'text-center align-middle', name: 'rowspan' },
			{ data: 'repairNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != '' && data != null) {
						return data;
					} else {
						return '';
					}
				}
			},
			{ data: 'repairStartDate', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != '' && data != null) {
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data,'YYYYMMDD').format('YYYY-MM-DD')+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'repairEndDate', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != '' && data != null) {
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data,'YYYYMMDD').format('YYYY-MM-DD')+'</div>';
					} else {
						return '';
					}
				}
			},
			{ data: 'repairContent', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != '' && data != null) {
						return data.replaceAll(/\n/g,'<br>');
					} else {
						return '';
					}
				}
			},
			{ data: 'repairCompany', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != '' && data != null) {
						return data;
					} else {
						return '';
					}
				}
			},
			{ data: 'repairCost', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if(data != '' && data != null) {
						return data;
					} else {
						return '';
					}
				}
			},
			{ data: 'partCost', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if(data != '' && data != null) {
						return data;
					} else {
						return '';
					}
				}
			},
			{ data: 'laborCost', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if(data != '' && data != null) {
						return data;
					} else {
						return '';
					}
				}
			},
			{ data: 'repairDesc', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != '' && data != null) {
						return data;
					} else {
						return '';
					}
				}
			},
		],
		rowsGroup: [
			'rowspan:name'
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
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#equipRepairHistAdmViewTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 79)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAll').off('keyup',function() {});
			$('#searchAll').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			});

			// 집계표 생성
			let data = api.data().toArray();

			if(data.length != 0) {
				let equipUniq = _.uniqBy(data, 'equipCd'); // 설비별로 uniq한 리스트
				console.log(equipUniq)
				for(var i=0;i<equipUniq.length;i++) {
					//같은 설비끼리 묶기
					let equipCd = equipUniq[i].equipCd;
					let equipCdList = _.filter(data, (v => v.equipCd == equipCd));

					let repairCode001Count = 0;
					let repairCode002Count = 0;
					let repairCode003Count = 0;
					for(var j=0;j<equipCdList.length;j++) {
						if(equipCdList[j].repairCd=='01') {
							repairCode001Count++;
						} else if(equipCdList[j].repairCd=='02') {
							repairCode002Count++;
						} else if(equipCdList[j].repairCd=='03') {
							repairCode003Count++;
						}
					};
					
					
					let equipLastIdx = _.maxBy(equipCdList, (v => v.rowNumber)).rowNumber;
					let equipLastCd = _.maxBy(equipCdList, (v => v.rowNumber)).equipCd;
					//let dealSum = _.sumBy(dealCorpList, (v => parseInt(v.ordQty)));
					let equipHtml = '';
						equipHtml += '<tr class="bg-success bg-gradient bg-opacity-10">';
						equipHtml += '	<td colspan ="6" class="text-start">합계</td>';
						equipHtml += '	<td colspan="9" class="text-start">';
					if(repairCode001Count>0) {
						equipHtml += '수리 : ' + repairCode001Count + '회';
					} 
					if(repairCode002Count>0) {
						if(repairCode001Count>0) {
							equipHtml += '/';
						}
						equipHtml += '교체 : ' + repairCode002Count + '회';
					}
					if(repairCode003Count>0) {
						if(repairCode001Count>0 || repairCode002Count>0) {
							equipHtml += '/';
						}
						equipHtml += '점검 : ' + repairCode003Count + '회';
					}
						equipHtml += '</td>';
						//equipHtml += '	<td class="text-end align-middle">'+addCommas(parseInt(dealSum))+'</td>';
						equipHtml += '</tr>';
					let equipNode = api.row('#'+equipLastIdx).node();
					$(equipNode).after(equipHtml);
				}
			}
		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#equipRepairHistAdmViewTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#equipRepairHistAdmViewTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
			//$("#equipRepairHistAdmViewTable").wrap("<div style='overflow:auto; width:100%;position:relative;'></div>");
			equipRepairHistAdmViewTable.draw();
		},
	});
	// dataTable colReorder event
	equipRepairHistAdmViewTable.on('column-reorder', function( e, settings, details ) {
		let api = equipRepairHistAdmViewTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#equipRepairHistAdmViewTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
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
		equipRepairHistAdmViewTable.ajax.reload(function() {});

		setTimeout(function() {
			$('#my-spinner').hide();
		}, 100)
	});
</script>

</body>
</html>
