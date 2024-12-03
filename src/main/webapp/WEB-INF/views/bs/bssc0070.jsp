<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/top.jsp"%>
<%@include file="../layout/modal.jsp"%>
<%@include file="../layout/script.jsp"%>
<div id="page" onmouseup="EndDrag()" onmousemove="OnDrag(event)" style="grid-template-areas: 'leftcol';
																		  grid-template-rows: 1fr;
																		  grid-template-columns: 1fr;">
	<div id="leftcol">
		<div class="container-fluid h-100" style="padding: 5px;">
			<div class="row" id="rightHeader" style="padding-bottom: 5px;">
				<div class="d-flex align-items-center d-flex">
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">출고일자</label>
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
					
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">제품코드</label>
					<div class="input-group w-auto h-100 me-3">
						<input type="text" class="form-control" id="itemNm" style="width: 200px;" disabled>
						<button type="button" class="btnInputDel" style="background-color: transparent; border-color: transparent; position: absolute; top: 0; right: 0; margin: 5px 23px; margin-left: 0px; border: none;">
							<i class="fa-solid fa-xmark"></i>
						</button>
						<input type="hidden" id="itemIdx">
						<button type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary" id="btnSearchItem">
							<i class="fa-solid fa-magnifying-glass"></i>
						</button>
					</div>
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">거래처</label>
					<div class="input-group w-auto h-100 me-3">
						<input type="text" class="form-control" id="searchDealCorpNm" disabled> 
						<button type="button" id="btnSearchDealCorpDel" style="background-color: transparent; border-color: transparent; position: absolute; top: 0; right: 0; margin: 5px 23px; margin-left: 0px; border: none;">
							<i class="fa-solid fa-xmark"></i>
						</button>
						<input type="hidden" id="searchDealCorpIdx">
						<button type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary" id="btnSearchDealCorp">
							<i class="fa-solid fa-magnifying-glass"></i>
						</button>
					</div>
					
					<!-- <label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">차량배정</label>
					<select class="form-select w-auto h-100 me-3" id="carAssignment" style="min-width: 70px;">
					</select> -->
					<input type="text" class="form-control w-auto h-100 me-1" id="searchAll" placeholder="통합검색" >
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end">
					<div class="btn-group" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnSearch"><i class="fa-regular fa-clipboard"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnPrint"><i class="fa-solid fa-print"></i></button>
						<!-- <button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnCopy"><i class="fa-regular fa-copy"></i></button> -->
						<!-- <button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnSave" disabled><i class="fa-regular fa-floppy-disk"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnEdit" ><i class="fa-regular fa-pen-to-square"></i></button>
						<button type="button" class="btn btn-outline-danger w-auto" style="font-size: 17px !important;" id="btnDel"><i class="fa-solid fa-trash-can"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnCancel" disabled><i class="fa-solid fa-xmark"></i></button> -->
					<!-- 	<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnClose"><i class="fa-solid fa-caret-right"></i></button> -->
					</div>
				</div>
			</div>
			<div class="row">
				<table class="table table-bordered p-0 m-0" id="bizOrdOutProdTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle">출고처</th>
							<th class="text-center align-middle">출고일자</th>
							<th class="text-center align-middle">출고전표번호</th>
							<th class="text-center align-middle">수주상세</th>
							<th class="text-center align-middle">품목</th>
							<th class="text-center align-middle">자재코드</th>
							<th class="text-center align-middle">버전</th>
							
							<th class="text-center align-middle">출고요청일자</th>
							<th class="text-center align-middle">실제출고일자</th>
							<th class="text-center align-middle">수주수량</th>
							<th class="text-center align-middle">출고량</th>
							<th class="text-center align-middle">명세서출력번호</th>
						</tr>
					</thead>
					<tfoot id="bizOrdOutProdTableTfoot">
						<tr>
							<th colspan="9">TOTAL</th>
							<th id="footOrdQty">수주수량</th>
							<th id="footOutQty">출고수량</th>
							<th colspan="1"></th>
						</tr>
					</tfoot>
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
	
	$('#btnOpen').on('click',function() { // right-box 열기버튼 클릭
		$('#page').css('grid-template-columns', '1fr 4px 3fr');
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
	
	let monthAdjustList = getCommonCode('시스템', '026'); //날짜조정
	monthAdjustList = _.sortBy(monthAdjustList, v=>parseInt(v.commonCd));
	selectBoxAppend(monthAdjustList, 'monthAdjust', '', '2'); //날짜조정
	
	let dealCorpIdxVal = '';

	let dealGubunList = getCommonCode('시스템', '011'); // 거래구분
	let dealCorpStatusList = getCommonCode('시스템', '015'); // 거래상태
	let pageLengthCnt = parseInt(getCommonCode('시스템', '025')[0].commonCd); //페이징수량
	let itemGubunList = getCommonCode('일반', '001'); // 제품구분
	let useYnCdList = getCommonCode('시스템', '055'); // 사용여부
	
	selectBoxAppend(dealGubunList, 'modalDealGubun', '', '1'); //거래구분
	selectBoxAppend(dealCorpStatusList, 'modalDealCorpStatus', '', '1'); //거래상태
	selectBoxAppend(itemGubunList, 'modalItemGubunBox', '', '1'); //제품구분
	selectBoxAppend(useYnCdList, 'modalUseYnCdBox', 'Y', '1'); //사용여부

	let workplaceList = new Array();	// 사업장 리스트
	let locationList = new Array();
	
	//창고정보 조회
	$.ajax({

		url : '<c:url value="/bm/locationAdmList"/>',
		type : 'GET',
		async : false,
		data : {
			itemGubun	:	'',
			'lcTypeOutput' : function() { return 'Y'; }
		},
		success : function(res) {
			if (res.result == "ok") { //응답결과
				let data = res.data;
				data.forEach((item) => {
					var locationData = new Object();
					locationData.id = item.idx;
					locationData.text = item.lcNm;
					locationList.push(locationData);
				});
			} else if(res.result == 'fail') {
				toastr.warning(res.message);
			} else {
				toastr.error(res.message);
			}
		}
	});

	
	let selectPeriod = parseInt(getCommonCode('시스템', '040')[0].commonCd); //기본조회기간 일
	$('#startDate').val(moment().subtract('d',selectPeriod).format('YYYY-MM-DD'));
	$('#endDate').val(moment().format('YYYY-MM-DD'));

	// 수주처 목록 조회 버튼 click
	$('#btnSearch').on('click', function() {
		bizOrdOutProdTable.ajax.reload(function() {});
		$('#btnSave').attr('disabled',true);
		$('#btnEdit').attr('disabled',false);
		$('#btnDel').attr('disabled',false);
		$('#btnCancel').attr('disabled',true);
		WM_action_OFF('new');
	});

	let notHiddenArray = '';	//columns 값 지정 Array
	
	// 수주상세목록조회
	$('#bizOrdOutProdTable thead tr').clone(true).addClass('filters').appendTo('#bizOrdOutProdTable thead'); // filter 생성
	let bizOrdOutProdTable = $('#bizOrdOutProdTable').DataTable({
		dom : "<'row'<'col-md-12 col-md-6'l><'col-md-12 col-md-6'f>>"
				+ "<'row'<'col-md-12'tr>>"
				+ "<'row pt-1'<'d-flex align-items-center d-flex'B><'me-lg-auto'><'d-flex align-items-center justify-content-end'>>",
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
			url : '<c:url value="/stock/bizOrderProdOutLst"/>',
			type : 'POST',
			data : {
				'startDate' 	: function() { return moment($('#startDate').val()).format('YYYYMMDD'); },
				'endDate' 		: function() { return moment($('#endDate').val()).format('YYYYMMDD'); },
				'itemIdx'		: function() { return $('#itemIdx').val(); },
				'dealCorpIdx'	: function() { return $('#searchDealCorpIdx').val(); },
			},
		},
        rowId: 'rowNumber',
        columns : [
        	{ data : 'outProdDealCorpNm', className : 'text-center align-middle', name: 'outProdDealCorpNm',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},//납품처
			{ data : 'outDate', className : 'text-center align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data).format('YYYY-MM-DD')+'</div>';
					} else {
						return '';
					}
				}
			},//출고일자
			{ data : 'outSlipIdx', className : 'text-center align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},//출고번호
			{ data : 'bizOrdDtlNo', className : 'text-center align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},//수주상세
			{ data : 'itemNm', className : 'text-center align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},//품목

			
			{ data : 'paperType', className : 'text-center align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},//자재명
			{ data : 'versionNm', className : 'text-center align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},//버전
			{ data : 'bizOrdOutReqDate', className : 'text-center align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data).format('YYYY-MM-DD')+'</div>';
					} else {
						return '';
					}
				}
			},//출고요청일자
			{ data : 'outDate', className : 'text-center align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data).format('YYYY-MM-DD')+'</div>';
					} else {
						return '';
					}
				}
			},//실제출고일자
			{ data : 'bizOrdQty', className : 'text-end align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
					} else {
						return '';
					}
				}
			},//수주수량
			{ data : 'outQty', className : 'text-end align-middle', name : 'outQty',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
					} else {
						return '';
					}
				}
			},//출고수량
			
			{ data : 'outProdEtc4', className : 'text-center align-middle', name : 'outProdEtc4',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},//명세서출력번호
		],
		columnDefs : [
			{
				targets: '_all',
				render: function(data) {
					return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
				}
			},
		],
		buttons : [
			{ extend: 'excelHtml5',	text: 'Excel',	charset: 'UTF-8', bom: true ,
				filename : '출고원장',//엑셀파일명 
				title : '출고원장(레포트)',//엑셀파일안에 쓰일 제목
				footer: true,//데이터테이블 푸터도 값으로 넣겠따
				customize: function(xlsx) {
					var sheet = xlsx.xl.worksheets['sheet1.xml'];
					$('row[r=2] c', sheet).remove();	//2번째 행 데이터 삭제
			        $('row[r=4] c', sheet).attr( 's', '2' ); //4번째행에 데이터테이블 헤더 있으니까 스타일 변경
					
			        var row = $('row', sheet);
			        $('c[r=A'+row.length+']', sheet).attr( 's', '51' ); //row.leng번째행에 데이터테이블 푸터 있으니까 스타일 변경
			        $('c[r=J'+row.length+']', sheet).attr( 's', '63' ); //row.leng번째행에 데이터테이블 푸터 있으니까 스타일 변경
			        $('c[r=K'+row.length+']', sheet).attr( 's', '63' ); //row.leng번째행에 데이터테이블 푸터 있으니까 스타일 변경
			        
			      	//병합 하고자 하는 셀 지정 
			      	var mergeCells = $('mergeCells', sheet);

			      	//colspan
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'A'+row.length+':I'+row.length} } )
					);
					mergeCells[0].appendChild( 
							createNode( sheet, 'mergeCell', { attr: {ref: 'B3:C3'} } )
						);
					//rowspan
			      	/*mergeCells[0].appendChild( 
							createNode( sheet, 'mergeCell', { attr: {ref: 'A1:A2'} } )
						); */
			      	mergeCells.attr( 'count', mergeCells.attr( 'count' )+1 );

					/*$('row* ', sheet).each(function(index) {
					    if (index == 0) {
					        $(this).attr('ht', 30);
					        $(this).attr('customHeight', 1);
					    }
					});*/

					/* var sheet2 = xlsx.xl['styles.xml'];
			        var tagName = sheet2.getElementsByTagName('sz');
			        for (i = 0; i < tagName.length; i++) {
			          tagName[i].setAttribute("val", "22")
			        }

			        var tagName = sheet2.getElementsByTagName('border');

				    // 모든 보더 요소에 대해 반복
				    for (var i = 0; i < tagName.length; i++) {
				      var left = tagName[i].getElementsByTagName('left')[0];
				      var right = tagName[i].getElementsByTagName('right')[0];
				      var top = tagName[i].getElementsByTagName('top')[0];
				      var bottom = tagName[i].getElementsByTagName('bottom')[0];
	
				      // 보더 스타일 지정
				      left.setAttribute('style', 'thin');
				      right.setAttribute('style', 'thin');
				      top.setAttribute('style', 'thin');
				      bottom.setAttribute('style', 'thin');
				    }

			     // 변경된 스타일을 적용할 셀 스타일을 가져옴
			     var cellXfs = sheet2.getElementsByTagName('cellXfs')[0];
			     var xf = cellXfs.getElementsByTagName('xf')[0];

			     // 보더 스타일 적용
			     xf.setAttribute('borderId', '1'); */
			     	
	                function createNode( doc, nodeName, opts ) {
						var tempNode = doc.createElement( nodeName );
	                    if ( opts ) {
							if ( opts.attr ) {
	                        	$(tempNode).attr( opts.attr );
	                      	}
	   
	                      	if ( opts.children ) {
	                        	$.each( opts.children, function ( key, value ) {
	                          		tempNode.appendChild( value );
	                        	} );
	                      	}
	   
	                      	if ( opts.text !== null && opts.text !== undefined ) {
	                        	tempNode.appendChild( doc.createTextNode( opts.text ) );
	                      	}
	                    }
	                    return tempNode;
					}
				},
				customizeData: function(data){
		    	    let gapCell = new Array();	//header만큼에 공백을 추가 해주는 부분
				    for(var i=0; i<data.header.length; i++){
				    	gapCell.push(' ');
				    	
		        	}
				    //거꾸로 감, 제일 위에가 제일 밑으로 감
			        let desc = [
				        ''
					];

			        data.body.unshift(data.header);	//헤더 맨 아래 부분
			        for (var i = 0; i < desc.length; i++) {
			            data.body.unshift(desc[i]);
			        };

			        data.body[0] = ['출고일자',$('#startDate').val() + ' ~ ' + $('#endDate').val(),'','제품코드',$('#itemNm').val(),'거래처',$('#searchDealCorpNm').val()];
			    }, 
				exportOptions: {
	                modifier: {
	                    page: 'current' //현재 보고(표시,출력)있는 데이터들을 다운로드하게끔
	                },
	                
	            },
				
				/*exportOptions: {
                 	columns: notHiddenArray	//원하는 값 지정
                },*/
			},
			/*{ extend: 'pdf',	text: 'PDF',	},
			{ extend: 'print',	text: 'Print',		charset: 'UTF-8', bom: true },
			{ extend: 'colvis',	text: 'Select Col',	}, */
		],
		order : [],
		drawCallback: function() {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#bizOrdOutProdTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#bizOrdOutProdTable_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 80)+'px');
			
			$('#bizOrdOutProdTable_filter').addClass('d-none');
			// 통합검색
			$('#searchAll').off('keyup',function() {});
			$('#searchAll').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			});

			//합계표 생성		
 			let dataArray = api.rows({page:'current'}).data().toArray();
			if( dataArray.length != 0 ){
				//맨밑에 최종합계
				let totalOutQtySum = _.sumBy(dataArray, v=> parseFloat(v.outQty));
				let totalOrdQtySum = _.sumBy(dataArray, v=> parseFloat(v.bizOrdQty));
				
				$('#footOrdQty').html(addCommas(totalOrdQtySum));
				$('#footOutQty').html(addCommas(totalOutQtySum));
				
				/* let dealCorpUniq = _.uniqBy(dataArray, 'outProdDealCorpIdx'); // 출고처별로 uniq한 리스트

				for(var i=0; i<dealCorpUniq.length;i++){
					let filterLst = _.filter(dataArray, v=> v.outProdDealCorpIdx == dealCorpUniq[i].outProdDealCorpIdx);//해당 거래처 데이터값
					let outDateMonthUniq = _.uniqBy(filterLst, v=>v.outDate.substr(0,6)); // 거래처의 출고월별로 uniq한 리스트
					for(var j = 0; j < outDateMonthUniq.length; j++){
						//출고처의 월별로 값 sum
						let outQtySumFilterLst = _.filter(filterLst, v=> v.outDate.substr(0,6) == outDateMonthUniq[j].outDate.substr(0,6));
						let bizOrdQtySum =  _.sumBy(outQtySumFilterLst, v=> parseFloat(v.bizOrdQty));
						let outQtySum = _.sumBy(outQtySumFilterLst, v=> parseFloat(v.outQty));

						let html = '';
						html += '<tr class="bg-success bg-gradient bg-opacity-25">';
						html += '	<td class="text-center" colspan="4">'+dealCorpUniq[i].outProdDealCorpNm + ' ' + moment(outDateMonthUniq[j].outDate).endOf('month').format('YYYY-MM-DD').slice(0,-3) +'월 합계</td>';
						html += '	<td class="text-center align-middle" colspan="5"></td>';
						html += '	<td class="text-end align-middle">'+addCommas(bizOrdQtySum)+'</td>';//수주수량
						html += '	<td class="text-end align-middle">'+addCommas(outQtySum)+'</td>';//출고량
						html += '	<td class="text-center" colspan="1"></td>';
						html += '</tr>';
						
						let lastRowNumber = _.maxBy(outQtySumFilterLst, (v => parseInt(v.rowNumber))).rowNumber;
						let lastNode = api.row('#'+lastRowNumber).node();
						$(lastNode).after(html);
					}					
					let outDateDayUniq = _.uniqBy(filterLst, 'outDate'); // 거래처의 출고일자별로 uniq한 리스트
					for(var j = 0; j < outDateDayUniq.length; j++){
						//출고처의 일자별로 값 sum
						let outQtySumFilterLst = _.filter(filterLst, v=> v.outDate == outDateDayUniq[j].outDate);
						let bizOrdQtySum =  _.sumBy(outQtySumFilterLst, v=> parseFloat(v.bizOrdQty));
						let outQtySum = _.sumBy(outQtySumFilterLst, v=> parseFloat(v.outQty));

						let html = '';
						html += '<tr class="bg-success bg-gradient bg-opacity-10">';
						html += '	<td class="text-center" colspan="4">'+dealCorpUniq[i].outProdDealCorpNm + ' ' + moment(outDateDayUniq[j].outDate).format('YYYY-MM-DD') +'일  합계</td>';
						html += '	<td class="text-center align-middle" colspan="5"></td>';
						html += '	<td class="text-end align-middle">'+addCommas(bizOrdQtySum)+'</td>';//수주수량
						html += '	<td class="text-end align-middle">'+addCommas(outQtySum)+'</td>';//출고량
						html += '	<td class="text-center" colspan="2"></td>';
						html += '</tr>';
						
						let lastRowNumber = _.maxBy(outQtySumFilterLst, (v => parseInt(v.rowNumber))).rowNumber;
						let lastNode = api.row('#'+lastRowNumber).node();
						$(lastNode).after(html);
					}
					
				} */

				
			}
		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#bizOrdOutProdTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#bizOrdOutProdTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	bizOrdOutProdTable.on('column-reorder', function( e, settings, details ) {
		let api = bizOrdOutProdTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#bizOrdOutProdTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});


	$('#bizOrdOutProdTable_wrapper').find('.buttons-excel').attr('id','btnRealExcel');
	$('#btnRealExcel').attr('style', 'display: none;');

   //가짜 엑셀 버튼 클릭 시
	$('#btnPrint').on('click', function(){
		//bizOrdOutProdTable.buttons(0)[0].inst.c.buttons[0].exportOptions.columns = '';   //c 초기화
		$('#my-spinner').show();
		//notHiddenArray = new Array();
		
		//for( var i=0; i<$('#bizOrdOutProdTable tbody tr').eq(0).find('td').length; i++){
		//     if(!$('#bizOrdOutProdTable tbody tr').eq(0).find('td').eq(i).hasClass('d-none')){
		//         notHiddenArray.push(i);
		//     }
		// }
		
		//c, s 값 columns를  notHiddenArray에 있는 배열로 교체
		//bizOrdOutProdTable.buttons(0)[0].inst.c.buttons[0].exportOptions.columns = notHiddenArray;
		
		$('#btnRealExcel').click();
		$('#my-spinner').hide();
	});
	
	/* 거래처 모달 */
	
	// 거래처조회 버튼 click
	$('#btnSearchDealCorp').on('click', function() {
		$('#dealCorpModal').modal('show');
		$('#dealCorpModal').data('type','search');
	});

	$(document).on('click','button[name=btnDealCorpSel]',function(){
		$('#dealCorpModal').modal('show');
		$('#dealCorpModal').data('type','edit');
	});
	
	$('#dealCorpModal').on('shown.bs.modal', function() {
		dealCorpModalTable.ajax.reload(function() {});
	});


	
	// 거래처조회 x 버튼 click
	$('#btnSearchDealCorpDel').on('click', function() {
		$('#searchDealCorpNm').val('');
		$('#searchDealCorpIdx').val('');
	});

	// 거래처관리 목록조회
	$('#dealCorpModalTable thead tr').clone(true).addClass('filters').appendTo('#dealCorpModalTable thead'); // filter 생성
	let dealCorpModalTable = $('#dealCorpModalTable').DataTable({
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
			
			let htmlHeight = parseFloat($('html').css('height'));
			//let middlecolT_height = parseFloat($('#middlecolT').css('height'));
			let theadHeight = parseFloat($('#dealCorpModalTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#dealCorpModalTable_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 230)+'px');
			
			$('#dealCorpModalTable_filter').addClass('d-none');
			// 통합검색
			$('#searchAllAdm').off('keyup',function() {});
			$('#searchAllAdm').on('keyup',function() {
				$('#dealCorpModalTable_filter').find('input').val($(this).val());
				$('#dealCorpModalTable_filter').find('input').trigger('keyup');
			});
		},
		initComplete: function () {
			let api = this.api();
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#dealCorpModalTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title.replaceAll('*','') + '" />');
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

	// 거래처 모달 조회 버튼 click
	$('#btnDealCorpModalSearch').on('click', function() {
		$('#my-spinner').show();
		dealCorpModalTable.ajax.reload(function() {});
		
		setTimeout(function() {
			$('#my-spinner').hide();
		}, 100)
	});

	// 거래처 모달 붙여넣기 버튼 click
	$('#btnDealCorpModalPaste').on('click', function() {
		if(!$('#dealCorpModalTable tbody tr').hasClass('selected')){
			toastr.warning('붙여넣을 행을 선택해주세요.');
			return false;
		}
		let type = $('#dealCorpModal').data('type');
		let data = dealCorpModalTable.row('.selected').data();
		if(type =='search'){
			$('#searchDealCorpNm').val(data.dealCorpNm);
			$('#searchDealCorpIdx').val(data.idx);
		} else if(type == 'edit'){
			let node = bizOrdOutProdTable.row('.selected').node();

			$(node).find('td').eq(bizOrdOutProdTable.column('outProdDealCorpNm:name').index()).find('input[type=hidden]').val(data.idx);
			$(node).find('td').eq(bizOrdOutProdTable.column('outProdDealCorpNm:name').index()).find('input[type=text]').val(data.dealCorpNm);
		}
		$('#dealCorpModal').modal('hide');
	});


	$('#dealCorpModalTable tbody').on('dblclick','tr',function(){
		let type = $('#dealCorpModal').data('type');
		let data = dealCorpModalTable.row(this).data();
		if(type =='search'){
			$('#searchDealCorpNm').val(data.dealCorpNm);
			$('#searchDealCorpIdx').val(data.idx);
		} else if(type == 'edit'){
			let node = bizOrdOutProdTable.row('.selected').node();

			$(node).find('td').eq(bizOrdOutProdTable.column('outProdDealCorpNm:name').index()).find('input[type=hidden]').val(data.idx);
			$(node).find('td').eq(bizOrdOutProdTable.column('outProdDealCorpNm:name').index()).find('input[type=text]').val(data.dealCorpNm);
		}
		$('#dealCorpModal').modal('hide');
	});
	
	/* 제품코드 모달  */
	
	$('#btnSearchItem').on('click',function(){
		
		$('#itemCodeModal').modal('show');
		setTimeout(function() {
			itemCodeModalTable.ajax.reload(function() {itemCodeModalTable.draw(false);});
		}, 200);
	});

	//제품정보 목록(모달)조회
	$('#itemCodeModalTable thead tr').clone(true).addClass('filters').appendTo('#itemCodeModalTable thead'); // filter 생성
	let itemCodeModalTable = $('#itemCodeModalTable').DataTable({
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
				useYnCd		: function(){ return $('#modalUseYnCdBox').val(); }, //사용여부
				itemGubun	: function(){ return $('#modalItemGubunBox').val(); }, //품목구분
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'customerNm', className : 'text-center align-middle'},	//고객사
			{ data: 'itemNm', className : 'text-center align-middle'}, 		//제품명
			{ //건별전달사항
				data: 'relayNotice', className : 'text-start align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space:pre-line;width:330px;">'+data+'</div>';
						
					} else {
						return "";
					}
				}	
			},
			{ data: 'knifeTipSize', className : 'text-center align-middle'}, //칼끝규격
			{ //자재코드
				data: 'customerItemCd', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						
					} else {
						return "";
					}
				}
			},
			{ data: 'versionNum', className : 'text-center align-middle'}, //버전번호
			{ //재질
				data: 'paperType', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						
					} else {
						return "";
					}
				}
			},
			{ //절수
				data: 'cutQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
						
					} else {
						return "";
					}
				}
			},
			{ //개수
				data: 'eaQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
						
					} else {
						return "";
					}
				}
			},
			{ data: 'itemColor', className : 'text-center align-middle'}, //COLOR		
			{ //도수
				data: 'frequencyNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						
					} else {
						return "";
					}
				}
			},
			{ data: 'itemSize', className : 'text-center align-middle'}, //사이즈
			{ data: 'coatingMethod', className : 'text-center align-middle'}, //코팅방법
			{ //특이사항
				data: 'specialNotice', className : 'text-start align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space:pre-line;width:330px;">'+data+'</div>';
						
					} else {
						return "";
					}
				}
			},
			{ data: 'moldingMethod', className : 'text-center align-middle'}, //성형방식
			{ data: 'moldingContents', className : 'text-center align-middle'}, //성형내용
			{ //묶음법
				data: 'bundleMethodNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						
					} else {
						return "";
					}
				}
			},
			{ data: 'bundleUnit', className : 'text-center align-middle'}, //묶음단위
			{//포장박스
				data: 'packMethodNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return "";
					}
				}
			},
			{ data: 'packUnit', className : 'text-center align-middle'}, //포장단위
			{ //호기
				data: 'etc1Nm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						
					} else {
						return "";
					}
				}
			},
			{ //목형번호
				data: 'woodenCareNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						
					} else {
						return "";
					}
				}
			},
			{ data: 'holeWoodenCd', className : 'text-center align-middle'}, //타공목형번호
			{ //수지판번호
				data: 'resinBoardNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						
					} else {
						return "";
					}
				}
			},
			{ //현재고량
				data: 'stock', className : 'text-end  align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseInt(data))+'</div>';
						
					} else {
						return "";
					}
				}
			},
			{ //검수방법
				data: 'inspectMethodNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						
					} else {
						return "";
					}
				}
			},
			{//착인여부
				data: 'printingYnCheckNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						
					} else {
						return "";
					}
				}
			},
			{ //사용여부
				data: 'useYnCd', className : 'text-center align-middle',
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
			{ //등록일자
				data: 'detailDate', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data,'YYYY-MM-DD').format('YYYY-MM-DD')+'</div>';
						
					} else {
						return "";
					}
				}
			},
			{ //후가공판번호
				data: 'etc2Cd', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						
					} else {
						return "";
					}
				}
			},		
			{ data: 'etc3', className : 'text-center align-middle'}, //부분UV	
			{ data: 'etc4', className : 'text-center align-middle'}, //FOIL	
			{ data: 'etc6', className : 'text-center align-middle'}, //형압
			{ data: 'etc7', className : 'text-center align-middle'}, //FSC 유무
			{ data: 'etc8', className : 'text-center align-middle'}, //납품처
			{ data: 'etc9', className : 'text-center align-middle'}, //공정실적여부
			{ data: 'etc10', className : 'text-center align-middle'}, //기타1
			{ data: 'etc5', className : 'text-center align-middle'}, //기타2
			{ data: 'pressMethod', className : 'text-center align-middle'},	//기타3
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
			let theadHeight = parseFloat($('#itemCodeModalTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 250)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#modalItemCodeSearchAll').off('keyup',function() {});
			$('#modalItemCodeSearchAll').on('keyup',function() {
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
				let cell = $('#itemCodeModalTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#itemCodeModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	itemCodeModalTable.on('column-reorder', function( e, settings, details ) {
		let api = itemCodeModalTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#itemCodeModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});
	
	$('#btnItemCodeModalSearch').on('click',function(){
		itemCodeModalTable.ajax.reload(function() {});
	});

	$('#btnItemCodeModalPaste').on('click',function(){
		if( !$('#itemCodeModalTable tbody tr').hasClass('selected') ){
			toastr.warning('붙여넣을 행을 선택해주세요.');
			return false;
		}

		let data = itemCodeModalTable.row('.selected').data();
		$('#itemNm').val(data.itemNm);
		$('#itemIdx').val(data.idx);
		$('#itemCodeModal').modal('hide');
	});

	$('#itemCodeModalTable tbody').on('dblclick','tr',function(){
		let data = itemCodeModalTable.row(this).data();
		$('#itemNm').val(data.itemNm);
		$('#itemIdx').val(data.idx);
		$('#itemCodeModal').modal('hide');
	});

	// 모든 체크박스 체크/해제 되도록
	$(document).on('change','input:checkbox[name=btnCheck]', function(){
		if( $('input:checkbox[name=btnCheck]').length == $('input:checkbox[name=btnCheck]:checked').length ){ //전체 체크박스 수와 체크된 박스의 수가 같을 때 -> 전체체크박스 체크 , 아닐 경우 해제
			$('#btnAllCheck').prop('checked',true);
		} else{
			$('#btnAllCheck').prop('checked',false);
		}
 	});

	//모든 체크박스 선택
	$('#btnAllCheck').on('click',function(){
		if($('#btnAllCheck').prop("checked")){
			$('input:checkbox[name=btnCheck]').prop('checked',true);
		}else{
			$('input:checkbox[name=btnCheck]').prop('checked',false);
		}
	});
	
</script>

</body>
</html>
