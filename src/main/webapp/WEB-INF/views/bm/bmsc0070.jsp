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
																		  grid-template-columns: 4fr;">
	<div id="leftcol">
		<div class="container-fluid h-100" style="padding: 5px;">
			<div class="row" id="leftHeader" style="padding-bottom: 5px;">
				<div class="d-flex align-items-center d-flex">
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">품목구분</label>
					<select class="form-select w-auto h-100 me-3" id="searchItemGubun" style="min-width: 70px;">
						<option value="" selected>전체</option>
						<option value="001">제품</option>
						<option value="002">상품</option>
					</select>
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">사용여부</label>
					<select class="form-select w-auto h-100 me-3" id="searchUseYnCd" style="min-width: 70px;">
						<option value="">전체</option>
						<option value="Y" selected>사용</option>
						<option value="N">미사용</option>
					</select>
					<input type="text" class="form-control w-auto h-100 me-1" id="searchAll" placeholder="통합검색" >
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end">
					<div class="btn-group" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnInfoChange">정보일괄변경</button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnCopy"><i class="fa-regular fa-copy"></i></button>
						<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnSearch"><i class="fa-regular fa-clipboard"></i></button>
						<!-- <button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnOpen"><i class="fa-solid fa-caret-left"></i></button> -->
					</div>
				</div>
			</div>
			<div class="row">
				<table class="table table-bordered p-0 m-0" id="itemInfoTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle">고객사</th>
							<th class="text-center align-middle">제품명</th>
							<th class="text-center align-middle">건별전달사항</th>
							<th class="text-center align-middle">칼끝규격</th>
							<th class="text-center align-middle">자재코드</th>
							<th class="text-center align-middle">버전번호</th>
							<th class="text-center align-middle">재질</th>
							<th class="text-center align-middle">절수</th>
							<th class="text-center align-middle">개수</th>
							<th class="text-center align-middle">COLOR</th>
							<th class="text-center align-middle">도수</th>
							<th class="text-center align-middle">사이즈</th>
							<th class="text-center align-middle">코팅방법</th>
							<th class="text-center align-middle">특이사항</th>
							<th class="text-center align-middle">성형방식</th>
							<th class="text-center align-middle">성형내용</th>
							<th class="text-center align-middle">묶음법</th>
							<th class="text-center align-middle">묶음단위</th>
							<th class="text-center align-middle">포장박스</th>
							<th class="text-center align-middle">포장단위</th>
							<th class="text-center align-middle">호기</th>			
							<th class="text-center align-middle">목형번호</th>
							<th class="text-center align-middle">타공목형번호</th>
							<th class="text-center align-middle">수지판번호</th>							
							<th class="text-center align-middle">동판번호</th>
							<th class="text-center align-middle">현재고량</th>
							<th class="text-center align-middle">검수방법</th>
							<th class="text-center align-middle">착인여부</th>
							<th class="text-center align-middle">사용여부</th>
							<th class="text-center align-middle">등록일자</th>
							<th class="text-center align-middle">후가공판번호</th>
							<th class="text-center align-middle">부분UV</th>
							<th class="text-center align-middle">FOIL</th>
							<th class="text-center align-middle">FOIL COLOR</th>
							<th class="text-center align-middle">형압</th>
							<th class="text-center align-middle">FSC 유무</th>
							<th class="text-center align-middle">납품처</th>
							<th class="text-center align-middle">공정실적여부</th>
							<th class="text-center align-middle">최근작업일자</th>
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
		$('#page').css('grid-template-columns', '4fr 4px 3fr');
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
	WM_init('new');
	WM_init('edit');

	// 공통코드 조회
	// 공통코드 조회
	let itemGubunList = getCommonCode('일반', '001'); // 제품구분
	let woodenList = getCommonCode('일반', '004'); // 목형번호
	let bundleList = getCommonCode('일반', '005'); // 묶음코드
	let inspectMethodList = getCommonCode('일반', '009'); // 검수방법
	let packMethodList = getCommonCode('일반', '013'); // 포장방법
	let outsrcGubunList = getCommonCode('일반', '024'); // 외주구분
	let etc1List = getCommonCode('일반', '037'); // 호기
	let etc7List = getCommonCode('시스템', '041'); //fsc
	
	selectBoxAppend(itemGubunList, 'itemGubun', '', '2'); //포장방법
	selectBoxAppend(woodenList, 'woodenCareCd', '', '2'); //목형관리번호
	selectBoxAppend(bundleList, 'bundleMethod', '', '2'); //묶음법
	selectBoxAppend(inspectMethodList, 'inspectMethod', '', '2'); //검수방법
	selectBoxAppend(packMethodList, 'packMethod', '', '2'); //포장방법
	selectBoxAppend(etc1List, 'etc1', '', '2'); //호기
	selectBoxAppend(etc7List, 'etc7', '', '2'); //fsc
	selectBoxAppend(itemGubunList, 'modalItemGubunBox', '', '1'); //제품구분

	
	let qtyUnitList = getCommonCode('일반', '003'); //수량단위
	let pageLengthCnt = parseInt(getCommonCode('시스템', '025')[0].commonCd); //페이징수량
	
	selectBoxAppend(qtyUnitList, 'qtyUnit', '', '1');
	
	//제품정보 목록조회
	$('#itemInfoTable thead tr').clone(true).addClass('filters').appendTo('#itemInfoTable thead'); // filter 생성
	let itemInfoTable = $('#itemInfoTable').DataTable({
		dom : "<'row'<'col-md-12 col-md-6'l><'col-md-12 col-md-6'f>>"
				+ "<'row'<'col-md-12'tr>>"
				+ "<'row pt-1'<'d-flex align-items-center d-flex col-sm'B><'me-lg-auto div-align-center col-sm'p><'d-flex align-items-center justify-content-end col-sm'i>>",
		language: lang_kor,
		info: true,
		ordering: true,
		processing: true,
		paging: true,
		lengthChange: false,
		searching: true,
		autoWidth: false,
		orderCellsTop: true,
        fixedHeader: false,
        scrollY: '100vh',
        scrollX: true,
		pageLength: pageLengthCnt,
		colReorder: true,
		select: {
            style: 'single',
            toggleable: false,
            items: 'row',
            info: false
        },
        ajax : {
			url : '<c:url value="/bm/itemInfoDtlListAll"/>',
			type : 'GET',
			data : {
				useYnCd : function(){return $('#searchUseYnCd').val();},
				itemGubun : function(){return $('#searchItemGubun').val();},
			},
		},
		/* ajax : function (data, callback, settings){
			$.ajax({
				url : '<c:url value="/bm/itemInfoDtlListAll"/>',
				type : 'GET',
				beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				data : {
					useYnCd : function(){return $('#searchUseYnCd').val();},
					itemGubun : function(){return $('#searchItemGubun').val();},
				},
				success : function(res) {
					if(res.result == 'ok'){
						let data = res.data;
						var out = res.data.slice(0,300);
			            for ( var i=data.start, ien=data.start+data.length ; i<ien ; i++ ) {
			                out.push( [ i+'-1', i+'-2', i+'-3', i+'-4', i+'-5' ] );
			            }
			 			
			            setTimeout( function () {
			                callback( {
			                    draw: data.draw,
			                    data: out,
			                    recordsTotal: data.length,
			                    recordsFiltered: data.length
			                } );
			            }, 50 );
					} else if(res.result == 'fail') {
						toastr.warning(res.message);
					} else {
						toastr.error(res.message);
					}
					$('#my-spinner').hide();
				},
			}); 
			
		},*/
        rowId: 'idx',
		columns : [
			{ data: 'customerNm', className : 'text-center align-middle'},	//고객사
			{ data: 'itemNm', className : 'text-center align-middle'}, 		//제품명
			{ data: 'relayNotice', className : 'text-start align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space:pre-line;width:330px;">'+data+'</div>';
						
					} else {
						return "";
					}
				}	
			},	//건별전달사항
			{ data: 'knifeTipSize', className : 'text-center align-middle'},	//칼끝규격
			{ data: 'customerItemCd', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						
					} else {
						return "";
					}
				}	
			},	//자재코드	
			{ data: 'versionNum', className : 'text-center align-middle'},	//버전번호
			{ data: 'paperType', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						
					} else {
						return "";
					}
				}	
			},	//재질	
			{ data: 'cutQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
						
					} else {
						return "";
					}
				}	
			},	//절수	
			{ data: 'eaQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
						
					} else {
						return "";
					}
				}	
			},	//개수			
			{ data: 'itemColor', className : 'text-center align-middle'},	//color		
			{ data: 'frequencyNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						
					} else {
						return "";
					}
				}	
			},	//도수
			{ data: 'itemSize', className : 'text-center align-middle'},		//사이즈
			{ data: 'coatingMethod', className : 'text-center align-middle'},//코팅방법
			{ data: 'specialNotice', className : 'text-start align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space:pre-line;width:330px;">'+data+'</div>';
						
					} else {
						return "";
					}
				}	
			},//특이사항
			{ data: 'moldingMethod', className : 'text-center align-middle'},//성형방식
			{ data: 'moldingContents', className : 'text-center align-middle'},//성형내용
			{ data: 'bundleMethodNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						
					} else {
						return "";
					}
				}	
			},//묶음법
			{ data: 'bundleUnit', className : 'text-center align-middle'},	//묶음단위
			{ data: 'packMethodNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return "";
					}
				}	
			}, //포장박스
			{ data: 'packUnit', className : 'text-center align-middle'},		//포장단위
			{ data: 'etc1Nm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						
					} else {
						return "";
					}
				}	
			},	//호기(기타1)	
			{ data: 'woodenCareNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						
					} else {
						return "";
					}
				}	
			},	//목형번호			
			{ data: 'holeWoodenCd', className : 'text-center align-middle'},	//타공목형번호
			{ data: 'resinBoardNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						
					} else {
						return "";
					}
				}	
			},	//수지판번호	
			{ data: 'pressMethod', className : 'text-center align-middle'},	//동판번호
			{ data: 'stock', className : 'text-end  align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseInt(data))+'</div>';
						
					} else {
						return "";
					}
				}	
			},		//현재고량			
			{ data: 'inspectMethodNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						
					} else {
						return "";
					}
				}	
			},	//검수방법
			{ data: 'printingYnCheckNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						
					} else {
						return "";
					}
				}	
			},//착인여부			
			{ data: 'useYnCd', className : 'text-center align-middle',		//사용여부
				render : function(data, type, row, meta) {
					if(data == 'Y'){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">사용</div>';
					} else if (data == 'N'){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">미사용</div>';
					} else {
						return "";
					}
				}			
			},			
			{ data: 'detailDate', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data,'YYYY-MM-DD').format('YYYY-MM-DD')+'</div>';
						
					} else {
						return "";
					}
				}	
			},	//일자	
			{ data: 'etc2Cd', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						
					} else {
						return "";
					}
				}	
			},	//후가공판번호	
			{ data: 'etc3', className : 'text-center align-middle'},	//부분UV	
			{ data: 'etc4', className : 'text-center align-middle'},	//FOIL	
			{ data: 'etc5', className : 'text-center align-middle'},	//FOIL COLOR	
			{ data: 'etc6', className : 'text-center align-middle'},	//형압
			{ data: 'etc7', className : 'text-center align-middle'},	//기타1
			{ data: 'etc8', className : 'text-center align-middle'},	//기타2
			{ data: 'etc9', className : 'text-center align-middle'},	//기타3
			{ data: 'lastWorkDate', className : 'text-center align-middle',
				render : function(data, type, row, meta){
					if(data !=null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data,'YYYY-MM-DD').format('YYYY-MM-DD')+'</div>';
					} else {
						return "";
					}
						
				}
			}, //최근작업일자
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
			let data = api.data();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let headerHeight = parseFloat($('#leftHeader').css('height'));
			let theadHeight = parseFloat($('#itemInfoTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - headerHeight - theadHeight - 42)+'px');

			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAll').off('keyup',function() {});
			$('#searchAll').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			});
			/* console.timeEnd('bmsc0070 itemInfo 조회');
			 */
		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#itemInfoTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#itemInfoTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	}); 
	// dataTable colReorder event
	itemInfoTable.on('column-reorder', function( e, settings, details ) {
		let api = itemInfoTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#itemInfoTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});
 
 	//let flag = true;
	// 스크롤 이벤트
 	/*$(document).ready(function(){
		$('#itemInfoTable_wrapper').find('.dataTables_scrollBody').scroll(function(){
			/* toastr.warning('스크롤 중 '); */
	    	// 현재 스크롤 위치
	 /*       var scrollTop = $(this).scrollTop();
	        // 전체 스크롤 가능한 높이
	        var scrollHeight = $(this).find('tbody').height(); //문서 전체 내용을 갖는 div의 높이
	        // 현재 보여지는 화면의 높이
	        var height = $(this).height();
	        
	        if(flag && scrollTop + height >= scrollHeight) { // 스크롤바가 아래 쪽에 위치할 때
	        	sliceCnt += 100;
	        	flag = false;
	        	dataTableAddRow();
	        	
	        }
		});
 	});

	function dataTableAddRow(){
		toastr.success('asdf');
		
		itemInfoTable.rows.add(itemInfoTableData.slice(sliceCnt-100,sliceCnt)).draw(false);
		flag = true;
		/*$.ajax({
			url : '<c:url value="/bm/itemInfoDtlListAll"/>',
			type : 'GET',
            data : {
				useYnCd : function(){return $('#searchUseYnCd').val();},
				itemGubun : function(){return $('#searchItemGubun').val();},
			},
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if(res.result == 'ok'){
					let data = res.data;
					data = data.slice(sliceCnt-100,sliceCnt);
					itemInfoTable.rows.add(data).draw(false);
					flag = true;
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});*/
	//}
 
	// 조회 버튼 click
	$('#btnSearch').on('click', function() {
		/* console.time('bmsc0070 itemInfo 조회'); */
		$('#my-spinner').show();
		itemInfoTable.ajax.reload(function() {});
		setTimeout(function() {
			$('#my-spinner').hide();
		}, 100)
	});

	// 제품코드 dblclick
	$('#itemInfoTable tbody').on('dblclick', 'tr', function() {
		let data = itemInfoTable.row(this).data();
		if(window.location != window.parent.location) { // tab일 경우
			// 제품코드등록화면 이동
			let itemIdx = data.idx;
			window.parent.selectItemInfoAdm(itemIdx,'dblClick');
	    }
	});

	//복사
	$('#btnCopy').on('click',function(){
		if( !$('#itemInfoTable tbody tr').hasClass('selected') ){
			toastr.warning('복사할 항목을 선택해주세요.');
			return false;
		}
		let data = itemInfoTable.row('.selected').data();
		let fileObject = new Object();		
		
		fileUuid = data.uuid;
		fileExt = data.ext;
		fileNm = data.fileNm;
		let formData3 = new FormData();
		let versionFileString = [];
		if(fileUuid != null && fileExt != null && fileNm != null){
			fileObject.uuid = fileUuid;
			fileObject.ext = fileExt;
			fileObject.fileNm = fileNm;
			let fileBlob = getFileBlob(fileObject);
			
			let blob = new Blob([base64ToArrayBuffer(fileBlob)], { type: data.ext });
	        let file = new File([blob], data.fileNm, { lastModified: new Date().getTime(), type: data.ext });
	        let uuid = uuid_v4();	
			formData3.append('file',file);
			formData3.append('uuid',uuid);
			formData3.append('ext',fileExt); 
			
			let obj = {};
			obj.uuid = uuid;
			obj.fileNm = fileNm;
			obj.ext = fileExt;
			
			versionFileString.push(obj);
		}
		let saveType = $(this).data('saveType');
		$.ajax({
			url: '<c:url value="/bm/itemInfoCopy"/>',
            type: 'POST',
            //async: false,
            data: {
                'idx'               :	data.idx, 
                'versionFileString' : 	JSON.stringify(versionFileString),
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					let data = res.data;
					toastr.success('신규 저장되었습니다.');

					//$('#btnSearch').trigger('click'); // 조회버튼 click

					WM_action_OFF('new');

					$('#userPw').val('');
					$('#userPwCheck').val('');
					
					$('.inputGroup').attr('disabled', true); // 입력항목
					
					$('#btnNew').attr('disabled', false); // 신규 버튼
					$('#btnSave').attr('disabled', true); // 저장 버튼
					$('#btnEdit').attr('disabled', false); // 수정 버튼
					$('#btnDel').attr('disabled', false); // 삭제 버튼
					$('#btnCancel').attr('disabled', true); // 취소 버튼
					if(versionFileString != '' && versionFileString != null){
						fileUpload(formData3); // 파일 업로드
					}
					$('#btnFileAdd').attr('disabled',true);
					$('#btnFileDel').attr('disabled',true);
					itemInfoTable.ajax.reload(function(){
						setTimeout(function() {
							itemInfoTable.row('#'+res.idx).select();
							$(itemInfoTable.row('#'+res.idx).node()).trigger('click'); // 복사된거 선택처리

							if(window.location != window.parent.location) { // tab일 경우
								// 제품코드등록화면 이동
								window.parent.selectItemInfoAdm(res.idx,'copy');
						    }
							
						}, 100)
							
					});

					
					/* $('#fileTable').DataTable().clear().draw();
					idValue = 0;
					formData = new FormData(); */

					$('#copyModal').modal('hide');
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
	});

	//정보일괄변경
	//제품정보 목록조회
	let itemInfoChangeTable = $('#itemInfoChangeTable').DataTable({
		dom : "<'row'<'col-md-12 col-md-6'l><'col-md-12 col-md-6'>>"
				+ "<'row'<'col-md-12'tr>>"
				+ "<'row pt-1'<'d-flex align-items-center d-flex col-sm'B><'me-lg-auto div-align-center col-sm'p><'d-flex align-items-center justify-content-end col-sm'i>>",
		language: lang_kor,
		info: true,
		ordering: true,
		processing: true,
		paging: true,
		lengthChange: false,
		searching: true,
		autoWidth: false,
		orderCellsTop: true,
        fixedHeader: false,
        scrollY: '70vh',
        scrollX: true,
		pageLength: pageLengthCnt,
		colReorder: true,
		select: {
            style: 'single',
            toggleable: false,
            items: 'row',
            info: false
        },
        ajax : {
			url : '<c:url value="/bm/itemInfoDtlListAll"/>',
			type : 'GET',
			data : {
				useYnCd : function(){return $('#modalUseYnCdBox').val();},
				itemGubun : function(){return $('#modalItemGubunBox').val();},
			},
		},
        rowId: 'idx',
		columns : [
			{ className : 'text-center  align-middle', name:'checkbox',
				render: function(data, type, row, meta) {
					return '<input type="checkbox" name="infoChangeCheck" style="width:20px; height:20px;">';
				}
			},
			{ data: 'customerNm', className : 'text-center align-middle'},	//고객사
			{ data: 'itemNm', className : 'text-center align-middle'}, 		//제품명
			{ data: 'customerItemCd', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						
					} else {
						return "";
					}
				}	
			},	//자재코드	
			{ data: 'versionNum', className : 'text-center align-middle'},	//버전번호
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
			let data = api.data();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			

			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAll').off('keyup',function() {});
			$('#searchAll').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			});
			/* console.timeEnd('bmsc0070 itemInfo 조회');
			 */
		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#itemInfoTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#itemInfoTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	}); 


	//부자재(목형) 모달
	$('#woodenInfoModalTable thead tr').clone(true).addClass('filters').appendTo('#woodenInfoModalTable thead'); // filter 생성
	let woodenInfoModalTable = $('#woodenInfoModalTable').DataTable({
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
			url : '<c:url value="/bm/woodenInfoAdmLst"/>',
			type : 'POST',
			data : {
				useYn: function() { return $('#searchUseYn').val(); },
				expendGubun : function(){ return '01'; },
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'wdCd', className : 'text-center align-middle'}, //코드
			{ data: 'wdSize', className : 'text-center align-middle', //사이즈
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return data;
					} else {
						return '';
					}
				}
			},
			{ data: 'moldingContents', className : 'text-center align-middle', //성형방식
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return data;
					} else {
						return '';
					}
				}
			},
			{ data: 'moldingContentsReal', className : 'text-center align-middle', //성형내용
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return data;
					} else {
						return '';
					}
				}
			},
			{ data: 'bundleMethodNm', className : 'text-center align-middle', //묶음법
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return data;
					} else {
						return '';
					}
				}
			},
			{ data: 'bundleUnit', className : 'text-center align-middle', //묶음단위
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return data;
					} else {
						return '';
					}
				}
			},
			{ data: 'packUnit', className : 'text-center align-middle', //포장단위
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return data;
					} else {
						return '';
					}
				}
			},
			{ data: 'packMethodNm', className : 'text-center align-middle', //포장박스				
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return data;
					} else {
						return '';
					}
				}
			},
			{ data: 'coating', className : 'text-center align-middle', //코팅방법
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return data;
					} else {
						return '';
					}
				}
			},
			{ data: 'wdUnitNm', className : 'text-center align-middle', //호기
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return data;
					} else {
						return '';
					}
				}
			},
			{ data: 'afterProcessing', className : 'text-center align-middle', //후가공
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return data;
					} else {
						return '';
					}
				}
			},
			{ data: 'afterProcessingWdUnitNm', className : 'text-center align-middle', //후가공호기
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return data;
					} else {
						return '';
					}
				}
			},
			{ data: 'useYn', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data == 'Y') {
						return '사용';
					} else {
						return '미사용';
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
		drawCallback: function() {
			let api = this.api();
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#woodenInfoModalTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#woodenInfoModalTable_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 234)+'px');
			
			$('#woodenInfoModalTable_filter').addClass('d-none');
			// 통합검색
			//$('#searchAll').off('keyup',function() {});
			//$('#searchAll').on('keyup',function() {
			//	$('#woodenInfoModalTable_filter').find('input').val($(this).val());
			//	$('#woodenInfoModalTable_filter').find('input').trigger('keyup');
			//});
		},
		initComplete: function () {
			let api = this.api();
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#woodenInfoModalTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#woodenInfoModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	woodenInfoModalTable.on('column-reorder', function( e, settings, details ) {
		let api = woodenInfoModalTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#woodenInfoModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	$('#btnWoodenInfoModalSearch').on('click',function(){
		woodenInfoModalTable.ajax.reload();
	});

	$('#woodenInfoModalTable tbody').on('dblclick','tr',function(){
		let data = woodenInfoModalTable.row(this).data();
		let idx = data.idx;
		$('#woodenCareCd').val(data.wdCd);
		$('#woodenCareIdx').val(idx);

		$('#itemSize').val(data.wdSize);//사이즈
		$('#moldingMethod').val(data.moldingContents);//성형방법
		$('#moldingContents').val(data.moldingContentsReal);//성형내용
		$('#bundleMethod').val(data.bundleMethod);//묶음법
		$('#bundleUnit').val(data.bundleUnit);//묶음단위
		$('#packUnit').val(data.packUnit);//포장단위
		$('#packMethod').val(data.packMethod);//포장박스
		
		$('#woodenInfoModal').modal('hide');
		
	});	

	//정보일괄변경 버튼 클릭
	$('#btnInfoChange').on('click',function(){
		$('#itemInfoChangeTable').DataTable().ajax.reload();
		
		//모달창 열기
		$('#itemInfoChangeModal').modal('show');
	});

	//정보일괄변경 모달창_조회 버튼 클릭
	$('#btnItemCodeModalSearch').on('click',function(){
		$('#itemInfoChangeTable').DataTable().ajax.reload();
	});

	//정보일괄변경 모달창_저장 버튼 클릭
	$('#btnInfoChangeSave').on('click',function(){
		//예외처리
		if(!$('input[name=inputCheck]').is(':checked')){
			toastr.warning("제품을 선택해주세요.");
		}
		
		if(!$('input[name=infoColumnCheck]').is(':checked')){
			toastr.warning("변경할 정보를 선택해주세요.");
		}

		//수정기능
		
		
	});

	//정보일괄변경 모달창_목형번호 팝업창 조회
	$('#woodenCareBtn').on('click',function(){
		expendGubun = '01';
		$('#woodenInfoModal').modal('show');
		setTimeout(function() {
			woodenInfoModalTable.ajax.reload(function() {});
		}, 200);
	});


	
	
	
</script>
</body>
</html>
