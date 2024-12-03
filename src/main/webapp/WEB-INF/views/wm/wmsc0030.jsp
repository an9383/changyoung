<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
pageContext.setAttribute("newLineChar", "\n");
%>

<%@include file="../layout/top.jsp"%>
<%@include file="../layout/modal.jsp"%>
<%@include file="../layout/script.jsp"%>
<div id="page" onmouseup="EndDrag(this)" onmousemove="OnDrag(event)" style="grid-template-areas: 'leftcol dragbarH rightcolT' 
																								'leftcol dragbarH dragbarVT' 
																								'leftcol dragbarH rightcolM' 
																								'leftcol dragbarH dragbarVB' 
																								'leftcol dragbarH rightcolB'; 
																		grid-template-rows: 2fr 4px 4fr 4px 2fr; grid-template-columns: 7.5fr 4px 2.5fr;">
	<div id="leftcol">
		<input type="file" id="fileFake" style="display: none;" value="" multiple>
		<div class="container-fluid h-100" style="padding: 5px;">
			<div class="row" id="leftHeader" style="padding-bottom: 5px;">
				<div class="d-flex align-items-center d-flex">
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">지시일</label>
					<input type="date" max="9999-12-31" class="form-control w-auto h-100 me-1" id="startDate"> 
					<label class="form-label d-flex align-items-center m-0 me-1 h-100">~</label>
					<input type="date" max="9999-12-31" class="form-control w-auto h-100 me-1" id="endDate"> 
					<select class="form-select w-auto h-100 me-1 monthAdjust" id="monthAdjust">
					</select>
					<div class="btn-group me-3" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto monthAdjustBtn" data-val="3">
							3개월</button>
						<button type="button" class="btn btn-outline-light w-auto monthAdjustBtn" data-val="6">
							6개월</button>
						<button type="button" class="btn btn-outline-light w-auto monthAdjustBtn" data-val="12">
							12개월</button>
					</div>

					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">조회대상</label>
					<select class="form-select w-auto h-100 me-3" id="searchTarget" style="min-width: 70px;">
						<option value="">전체</option>
						<option value="N" selected>작업대상</option>
					</select> 
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">범례</label>
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100" style="background-color: #fadcdc;">컨펌대기, 수주중지</label>
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100" style="background-color: rgb(255 207 244);">작업지시전</label>
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100" style="background-color: #87CEEB;">금일작업</label>
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100" style="background-color: #fffadc;">긴급수주</label>
					<!-- <label class="form-label d-flex align-items-center header-label m-0 me-1 h-100" style="background-color: #ffb4b4 !important;">행 전체 : 수주대비 생산량미달, 생산수량 및 불량수량 : 지시량 미달</label>  -->
					<input type="text" class="form-control w-auto h-100 me-1" id="searchAll" placeholder="통합검색">
				</div>
				<div class="me-lg-auto"></div>
				<div class="btn-group me-3" role="group" aria-label="Small button group">
					<button type="button" class="btn btn-outline-light w-auto" id="btnSave">금일작업저장</button>
					<button type="button" class="btn btn-outline-light w-auto" id="btnCancel">금일작업취소</button>
				</div>
				<div class="btn-group" role="group" aria-label="Small button group">
					<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnSearch">
						<i class="fa-regular fa-clipboard"></i>
					</button>
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnOpen">
						<i class="fa-solid fa-caret-left"></i>
					</button>
				</div>
			</div>

			<div class="row">
				<table class="table table-bordered p-0 m-0" id="workOrderPrcssTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle"><input type="checkbox" id="btnAllCheck" style="width:20px; height:20px;"></th>
							<th class="text-center align-middle">수주상태</th>
							<th class="text-center align-middle">수주번호</th>
							<th class="text-center align-middle">고객사</th>
							<!-- <th class="text-center align-middle">상태</th> -->
							<th class="text-center align-middle" style="min-width: 250px;">품명</th>
							<th class="text-center align-middle">수주수량</th>
							<th class="text-center align-middle">목표요구일</th>
							<th class="text-center align-middle">진행상태</th>
							<th class="text-center align-middle">전공정 양품수량</th>
							<th class="text-center align-middle">생산수량</th>
							<th class="text-center align-middle">손지</th>
							<th class="text-center align-middle">지시비고사항</th>
							<!-- <th class="text-center align-middle">생산특이사항</th> 09.12 삭제-->
							
							<th class="text-center align-middle">공정명</th>
							<th class="text-center align-middle">접지라벨</th>
							<th class="text-center align-middle">CTCP라벨</th>
							<th class="text-center align-middle">설비명</th>
							<!-- <th class="text-center align-middle">생산지시일</th>
							
							<th class="text-center align-middle">납품요구일</th>-->
<!-- 							<th class="text-center align-middle">지시수량</th> -->
							
							
							<!-- <th class="text-center align-middle colvisHide">미생산수량</th>
							<th class="text-center align-middle colvisHide">목형번호</th>
							<th class="text-center align-middle colvisHide">수지판번호</th> -->
							
							<!-- <th class="text-center align-middle colvisHide">지시번호</th> -->
							
							
							
							<th class="text-center align-middle">도수</th>
							<th class="text-center align-middle">원지</th>
							<th class="text-center align-middle">절수</th>
							<th class="text-center align-middle">개수</th>
							<th class="text-center align-middle">칼라</th>
							<th class="text-center align-middle">코팅</th>
							<th class="text-center align-middle">성형방식</th>
							<th class="text-center align-middle">성형내용</th>
							<th class="text-center align-middle">사이즈</th>
							<th class="text-center align-middle">칼끝규격</th>
							<th class="text-center align-middle">목형번호</th>
							<th class="text-center align-middle">수지판번호</th>
							<th class="text-center align-middle">동판번호</th>
							<th class="text-center align-middle">인쇄설비</th>
							<th class="text-center align-middle">출고요청일</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
	<div id="dragbarH" onmousedown="StartDrag('H')"></div>
	<div id="rightcolT" style="overflow: hidden;">
		<div class="container-fluid h-100" style="padding: 5px;">
			<div class="row" id="rightBody">
				<div style="width: 100%;">
					<div class="nav nav-tabs" id="nav-tab2">
						<button class="nav-link active" id="tab5Nav" data-bs-toggle="tab"
							data-bs-target="#tab5">투입자재정보</button>
					</div>
					<div class="tab-content" id="nav-tabContent2">
						<div class="tab-pane fade show active" id="tab5">
							<div class="row" style="padding: 5px;">
								<div class="d-flex align-items-center justify-content-end w-100"
									id="inputMaterialHistTableHeader" style="margin-bottom: 5px;">
									<div class="btn-group" role="group"
										aria-label="Small button group">
										<button type="button" class="btn btn-outline-light w-auto"
											style="font-size: 18px !important;" id="btnClose">
											<i class="fa-solid fa-caret-right"></i>
										</button>
									</div>
								</div>
								<table class="table table-bordered p-0 m-0"
									id="inputMaterialHistTable">
									<thead class="table-light">
										<tr>
											<th class="text-center align-middle">재질</th>
											<th class="text-center align-middle">장*폭</th>
											<th class="text-center align-middle">절수/개수</th>
											<th class="text-center align-middle">이론<br>통수
											</th>
											<th class="text-center align-middle">여분포함<br>통수
											</th>
											<!-- <th class="text-center align-middle">발주량+여분</th> -->
											<th class="text-center align-middle">입고량</th>
										</tr>
									</thead>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="dragbarVT" onmousedown="StartDrag('VT')"
		ondblclick="minimum(this)"></div>
	<div id="rightcolM" style="overflow: hidden;">
		<div class="container-fluid" style="padding: 5px;">
			<div class="row">
				<div style="width: 100%;">
					<div class="nav nav-tabs" id="nav-tab2">
						<button class="nav-link active" id="tab3Nav" data-bs-toggle="tab"
							data-bs-target="#tab3">공정실적상태</button>
					</div>
					<div class="tab-content" id="nav-tabContent2">
						<div class="tab-pane fade show active" id="tab3">
							<div class="row" style="padding: 5px;">
								<table class="table table-bordered p-0 m-0 "
									id="workPrcssDtlTable">
									<thead class="table-light">
										<tr>
											<th class="text-center align-middle"
												style="vertical-align: middle;">진행상태</th>
											<th class="text-center align-middle"
												style="vertical-align: middle;">공정</th>
											<th class="text-center align-middle"
												style="vertical-align: middle;">양품</th>
											<th class="text-center align-middle"
												style="vertical-align: middle;">불량</th>
											<th class="text-center align-middle"
												style="vertical-align: middle;">단위</th>
											<th class="text-center align-middle"
												style="vertical-align: middle;">작업자</th>
										</tr>
									</thead>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="dragbarVB" onmousedown="StartDrag('VB')"
		ondblclick="minimum(this)"></div>
	<div id="rightcolB" style="overflow: hidden;">
		<div class="container-fluid" style="padding: 5px;">
			<div class="row">
				<div style="width: 100%;">
					<!-- <div class="nav nav-tabs" id="nav-tab">
						<button class="nav-link active" id="tab1Nav" data-bs-toggle="tab" data-bs-target="#tab1">공정별 진행상태</button>
						<button class="nav-link" id="tab2Nav" data-bs-toggle="tab" data-bs-target="#tab2">세부정보</button>
				  	</div>
					<div class="tab-content" id="nav-tabContent">
						<div class="tab-pane fade show active" id="tab1">
							<div class="row" style="padding: 5px;">
								<table class="table table-bordered p-0 m-0 " id="workOrdPrcssStatusTable">
									<thead class="table-light">
										<tr>
											<th class="text-center align-middle" style="vertical-align: middle;">진행상태</th>
											<th class="text-center align-middle" style="vertical-align: middle;">공정명</th>
											<th class="text-center align-middle" style="vertical-align: middle;">지시량</th>
											<th class="text-center align-middle" style="vertical-align: middle;">생산량</th>
											<th class="text-center align-middle" style="vertical-align: middle;">미생산량</th>
										</tr>
									</thead>
								</table>
							</div>
						</div>				
					</div> -->
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 실적등록 모달 -->
<div class="modal fade" id="workOrderPrcssModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog row" style="width: 70vw; max-width: 70vw; height: 93vh; max-height: 93vh;">
		<div class="modal-content" style="width: 100%; height: 100%;">
			<div class="modal-body" style="height: 100%;">
				<div style="overflow: hidden; max-height: 100%; height: 100%; display: grid; grid-gap: 5px; 
											grid-template-areas: 'bizInfoGroup btnGroup' 
																'itemInfoGroup btnGroup' 
																'matrlGroup btnGroup' 
																'workResultGroup btnGroup'
																 'workInputGroup btnGroup';
											grid-template-rows: 1fr 5fr 2fr 2fr 3fr;
											 grid-template-columns: 2.5fr 1fr;">
					<div id="bizInfoGroup">
						<table class="table table-bordered p-0 m-0" style="height: 100%;">
							<colgroup>
								<col width="12.5%">
								<col width="12.5%">
								<col width="12.5%">
								<col width="12.5%">
								<col width="12.5%">
								<col width="12.5%">
								<col width="12.5%">
								<col width="12.5%">
							</colgroup>
							<tr style="width: 100%;">
								<th class="text-center align-middle plainText">고객사</th>
								<td colspan="1" class="text-center align-middle plainText">
									<div id=bizDealCorpNm></div>
								</td>
								<th class="text-center align-middle plainText">제품명</th>
								<td colspan="5" class="text-center align-middle plainText">
									<div id="itemNm"></div>
								</td>
							</tr>
							<tr style="width: 100%;">
								<th class="text-center align-middle plainText">자재코드</th>
								<td class="text-center align-middle plainText" id="customerItemCd"></td>
								<th class="text-center align-middle plainText">버전번호</th>
								<td class="text-center align-middle plainText">
									<a id="itemVersionLink" href="" target="_blank"> 
										<span id="itemVersion"></span>
									</a>
								</td>
								<th class="text-center align-middle plainText">수주번호</th>
								<td class="text-center align-middle plainText" id="modalBizOrdDtlNo"></td>
								<th class="text-center align-middle plainText">수주량</th>
								<td class="text-center align-middle plainText" id="bizOrdQty">
								</td>
							</tr>
						</table>
					</div>
					<div id="btnGroup">
						<div class="row" style="width: 100%; height: 100%;">
							<div class="card virtualKeyboard_content2" style="width: 100%; height: 60%; margin: 0px; font-weight: bolder; border-width: 0px;">
								<div class="row virtualKeyboard_content2" style="width: 100%; height: 25%; margin-bottom: 5px;">
									<div class="col virkey" id="virkeypad_1_0" style="font-size: 2vw !important; padding-left: 5%; margin-right: 5px;">7</div>
									<div class="col virkey" id="virkeypad_1_1" style="font-size: 2vw !important; padding-left: 5%; margin-right: 5px;">8</div>
									<div class="col virkey" id="virkeypad_1_2" style="font-size: 2vw !important; padding-left: 5%; margin-right: 5px;">9</div>
									<div class="col virkey" id="virkeypad_0_0" style="font-size: 2vw; padding-left: 5%; margin-right: 5px; text-align: center;">
										<i class="fas fa-long-arrow-alt-left" id="backspace"></i>
									</div>
								</div>
								<div class="row virtualKeyboard_content2" style="width: 100%; height: 25%; margin-bottom: 5px;">
									<div class="col virkey" id="virkeypad_2_0" style="font-size: 2vw !important; padding-left: 5%; margin-right: 5px;">4</div>
									<div class="col virkey" id="virkeypad_2_1" style="font-size: 2vw !important; padding-left: 5%; margin-right: 5px;">5</div>
									<div class="col virkey" id="virkeypad_2_2" style="font-size: 2vw !important; padding-left: 5%; margin-right: 5px;">6</div>
									<div class="col virkey" id="virkeypad_2_3" style="font-size: 2vw !important; padding-left: 5%; margin-right: 5px; text-align: center;">
										<i class="far fa-caret-square-up" id="upCount"></i>
									</div>
								</div>
								<div class="row virtualKeyboard_content2" style="width: 100%; height: 25%; margin-bottom: 5px;">
									<div class="col virkey" id="virkeypad_3_0" style="font-size: 2vw !important; padding-left: 5%; margin-right: 5px;">1</div>
									<div class="col virkey" id="virkeypad_3_1" style="font-size: 2vw !important; padding-left: 5%; margin-right: 5px;">2</div>
									<div class="col virkey" id="virkeypad_3_2" style="font-size: 2vw !important; padding-left: 5%; margin-right: 5px;">3</div>
									<div class="col virkey" id="virkeypad_3_3" style="font-size: 2vw !important; padding-left: 5%; margin-right: 5px; text-align: center;">
										<i class="far fa-caret-square-down" id="downCount"></i>
									</div>

								</div>
								<div class="row virtualKeyboard_content2" style="width: 100%; height: 25%; margin-bottom: 5px;">
									<div class="col virkey" id="virkeypad_4_0" style="font-size: 2vw !important; padding-left: 5%; min-width: 10%; margin-right: 5px;">0</div>
									<div class="col virkey" id="virkeypad_4_1" style="font-size: 2vw !important; padding-left: 5%; margin-right: 5px;">.</div>
									<div class="col virkey" id="virkeypad_4_2" style="font-size: 0.8vw !important; padding-left: 5%; margin-right: 5px;">Enter</div>
								</div>

							</div>
							<div style="width: 100%; height: 40%;margin: 0px; font-weight: bolder; border-width: 0px;" class="row">
								<button type="button" id="btnWorkStart" style="font-size: 2em !important; width: 49%; margin-bottom: 5px; white-space: nowrap;" class="btn btn-outline-primary">작업시작</button>
								<button type="button" id="btnWorkEnd" style="font-size: 2em !important; width: 49%; margin-bottom: 5px; margin-left: 5px; white-space: nowrap;" class="btn btn-outline-success">작업완료</button>
								<button type="button" id="btnWorkSave" style="font-size: 2em !important; width: 49%; margin-bottom: 5px; white-space: nowrap;" class="btn btn-outline-success">저장</button>
								<button type="button" id="btnWorkDel" style="font-size: 2em !important; width: 49%; margin-bottom: 5px; margin-left: 5px; border-color: #dc3545; white-space: nowrap;" class="btn btn-outline-danger">실적삭제</button>
								<button type="button" id="btnWorkCancel" style="font-size: 2em !important; width: 49%; margin-bottom: 5px; border-color: #dc3545; white-space: nowrap;" class="btn btn-outline-danger">진행취소</button>
								<button type="button" id="btnCompulsionEnd" style="font-size: 2em !important; width: 49%; margin-bottom: 5px; margin-left: 5px; border-color: #dc3545; white-space: nowrap;" class="btn btn-outline-danger">작업중지</button>

								<!-- <button type="button" style="font-size: 2em !important;width:49%;margin-bottom:5px;white-space: nowrap;" class="btn btn-outline-success">공정검사</button>
									<button type="button" style="font-size: 2em !important;width:49%;margin-bottom:5px;margin-left:5px;white-space: nowrap;" class="btn btn-outline-success">자재반입</button> -->

								<button type="button" style="font-size: 2em !important; width: 100%; white-space: nowrap;" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
							</div>

						</div>
					</div>
					<div id="itemInfoGroup">
						<table class="table table-bordered p-0 m-0" style="height: 100%;">
							<colgroup>
								<col width="12.5%">
								<col width="12.5%">
								<col width="12.5%">
								<col width="12.5%">
								<col width="12.5%">
								<col width="12.5%">
								<col width="12.5%">
								<col width="12.5%">
							</colgroup>
							<tr style="width: 100%;">
								<th class="text-center align-middle plainText">사이즈</th>
								<th class="text-center align-middle plainText">칼끝규격</th>
								<th class="text-center align-middle plainText">착인여부</th>
								<th class="text-center align-middle plainText">도수</th>
								<th colspan="4" class="text-center align-middle plainText">Color</th>
							</tr>
							<tr style="width: 100%;">
								<td class="text-center align-middle plainText" id="itemSize" style="height: 20px;"></td>
								<td class="text-center align-middle plainText" id="knifeTipSize"></td>
								<td class="text-center align-middle plainText" id="printingYnCheck"></td>
								<td class="text-center align-middle plainText" id="itemFrequency"></td>
								<td colspan="4" class="text-center align-middle plainText" id="itemColor"></td>
							</tr>
							<tr style="width: 100%;">
								<th class="text-center align-middle plainText">검수방법</th>
								<th class="text-center align-middle plainText">FSC 유무</th>
								<th class="text-center align-middle plainText">납품처</th>
								<th class="text-center align-middle plainText">공정실적여부</th>
								<th colspan="4" class="text-center align-middle plainText strongTh">공정특이사항</th>
							</tr>
							<tr style="width: 100%;">
								<td class="text-center align-middle plainText" id="inspectMethodNm" style="height: 20px;"></td>
								<td class="text-center align-middle plainText" id="etc7"></td>
								<td class="text-center align-middle plainText" id="etc8"></td>
								<td class="text-center align-middle plainText" id="etc9"></td>
								<td colspan="4" rowspan="4" class="text-start align-middle plainText strongTh">
									<div id="specialNotice" style="overflow-y: scroll; white-space: pre-line; height: 100%;"></div>
								</td>
							</tr>
							<tr style="width: 100%;">
								<th class="text-center align-middle plainText">코팅방법</th>
								<th class="text-center align-middle plainText">코팅판번호</th>
								<th class="text-center align-middle plainText">부분UV</th>
								<th class="text-center align-middle plainText">UV수지판번호</th>
							</tr>
							<tr style="width: 100%;">
								<td class="text-center align-middle plainText" id="coatingMethod" style="height: 20px;"></td>
								<td class="text-center align-middle plainText" id="resinBoard"></td>
								<td class="text-center align-middle plainText" id="etc3"></td>
								<td class="text-center align-middle plainText" id="etc2Cd"></td>
							</tr>
							<tr style="width: 100%;">
								<th class="text-center align-middle plainText">형압판번호</th>
								<th class="text-center align-middle plainText">박동판번호</th>
								<th class="text-center align-middle plainText">목형번호</th>
								<th class="text-center align-middle plainText">타공목형번호</th>
							</tr>
							<tr style="width: 100%;">
								<td class="text-center align-middle plainText" id="etc4" style="height: 20px;"></td>
								<td class="text-center align-middle plainText" id="etc6"></td>
								<td class="text-center align-middle plainText" id="woodenCareCd"></td>
								<td class="text-center align-middle plainText" id="holeWoodenCd"></td>
								<th colspan="4" class="text-center align-middle plainText strongTh">건별 전달사항</th>
							</tr>
							<tr style="width: 100%;">
								<th class="text-center align-middle plainText">성형방식</th>
								<th colspan="2" class="text-center align-middle plainText">성형내용</th>
								<th class="text-center align-middle plainText"></th>
								<td colspan="4" rowspan="4" class="text-start align-middle plainText strongTh">
									<div id="relayNotice" style="overflow-y: scroll; white-space: pre-line; height: 100%;"></div>
								</td>
							</tr>
							<tr style="width: 100%;">
								<td class="text-center align-middle plainText" id="moldingMethod" style="height: 20px;"></td>
								<td colspan="2" class="text-center align-middle plainText" id="moldingContents"></td>
								<td class="text-center align-middle plainText"></td>
							</tr>
							<tr style="width: 100%;">
								<th class="text-center align-middle  plainText">묶음법</th>
								<th class="text-center align-middle  plainText">묶음단위</th>
								<th class="text-center align-middle  plainText">포장단위</th>
								<th class="text-center align-middle  plainText">포장박스</th>
							</tr>
							<tr style="width: 100%;">
								<td class="text-center align-middle plainText" id="bundleMethodNm" style="height: 20px;"></td>
								<td class="text-center align-middle plainText" id="bundleUnit"> </td>
								<td class="text-center align-middle plainText">
									<input type="text" class="text-center align-middle form-control inputGroup" style="font-size:15px!important;" id="packUnit">
								</td>
								<td class="text-center align-middle plainText" id="packMethodNm"></td>
							</tr>
						</table>
					</div>

					<div id="matrlGroup" style="max-width: 99.9%; max-height: 100%;">
						<div id="workOrderPrcssModalTableHeight" style="max-width: 100%; max-height: 100%;">
							<table class="table table-bordered p-0 m-0" style="max-width: 100%;" id="purchaseMatrlModalTable">
								<thead class="table-light">
									<tr>
										<th class="text-center align-middle plainText">재질</th>
										<th class="text-center align-middle plainText">절수/조수</th>
										<th class="text-center align-middle plainText">현재고</th>
										<th class="text-center align-middle plainText">정매</th>
										<th class="text-center align-middle plainText">여분</th>
										<th class="text-center align-middle plainText">합계</th>
										<th class="text-center align-middle plainText" style="background-color: #ff000078 !important;">추가재단</th>
									</tr>
								</thead>
							</table>
						</div>
					</div>

					<div id="workResultGroup" style="max-width: 99.9%; max-height: 100%;">
						<div id="workResultListTableHeight" style="max-width: 100%; max-height: 100%;">
							<table class="table table-bordered p-0 m-0" style="max-width: 100%;" id="workResultListTable">
								<thead class="table-light">
									<tr>
										<th class="text-center align-middle plainText">상태</th>
										<th class="text-center align-middle plainText">공정</th>
										<th class="text-center align-middle plainText">설비명</th>
										<th class="text-center align-middle plainText">작업단위</th>
										<th class="text-center align-middle plainText">정매수</th>
										<th class="text-center align-middle plainText">생산량</th>
										<th class="text-center align-middle plainText">여분</th>
										<th class="text-center align-middle plainText">손지</th>
										<th class="text-center align-middle plainText">작업일자</th>
										<th class="text-center align-middle plainText">작업자</th>
									</tr>
								</thead>
							</table>
						</div>
					</div>

					<div id="workInputGroup">
						<table class="table table-bordered p-0 m-0" style="height: 100%;">
							<colgroup>
								<col width="12.5%">
								<col width="12.5%">
								<col width="12.5%">
								<col width="12.5%">
								<col width="12.5%">
								<col width="12.5%">
								<col width="12.5%">
								<col width="12.5%">
							</colgroup>
							<tr style="height: 70%;">
								<th class="text-center align-middle plainText">전체공정<br>특이사항<br>
									<input type="checkbox" id="workOrdBeforePrcssDescCheck" style="width: 40px; height: 40px;">
								</th>
								<td class="text-center align-middle" colspan="3">
									<div class="row" style="height: 100%;">
										<textarea id="workOrdBeforePrcssDesc" class="form-control resize-none inputGroup" style="font-size:15px!important;resize: none; height: 100%; width: 100%;" disabled></textarea>
									</div>
								</td>
								<th class="text-center align-middle plainText">현공정<br>특이사항
								</th>
								<td class="text-center align-middle" colspan="3">
									<textarea id="fieldDesc" class="form-control resize-none inputGroup" style="font-size:15px!important;resize: none; height: 100%;" disabled="disabled"></textarea>
								</td>
							</tr>
							<tr style="height: 15%;">
								<th class="text-center align-middle plainText">시작 시간</th>
								<td class="text-center align-middle" colspan="3">
									<input type="datetime-local" class="form-control inputGroup virtualKeyboard2" id="workStartTime" disabled>
								</td>
								<th class="text-center align-middle plainText" rowspan="2">작업량</th>
								<td rowspan="2" class="text-center align-middle">
									<input type="text" id="workQtyRChange" class="form-control text-end me-1 d-none" placeholder="R변환" disabled>
									<div id="workOrdBeforePrcssQtyHidden" class="d-none"></div>
									<div id="workOrdBeforePrcssQty" class="d-none"></div>
									<div id="workOrdQty" class="d-none"></div>
									<input type="text" id="workQty" class="form-control text-end me-1 inputGroup virtualKeyboard2" value="0" onkeyup="numberFormat(this,'int')" disabled>
									<input type="text" id="workPrcssQtyUnit" class="form-control text-end me-1 d-none" placeholder="공정단위" disabled>
								</td>

								<th class="text-center align-middle plainText" rowspan="1">불량</th>
								<td class="text-center align-middle">
									<input type="text" id="workFaultyQtyRChange" class="form-control text-end me-1 d-none" placeholder="R변환" disabled> 
									<input type="text" id="workFaultyQty" class="form-control text-end me-1 inputGroup virtualKeyboard2" value="0" onkeyup="numberFormat(this,'int')" disabled>
									<input type="text" id="workPrcssFaultyQtyUnit" class="form-control text-end me-1 d-none" placeholder="공정단위" disabled>
								</td>
							</tr>
							<tr style="height: 15%;">
								<th class="text-center align-middle plainText">종료 시간</th>
								<td class="text-center align-middle" colspan="3">
									<input type="datetime-local" class="form-control inputGroup virtualKeyboard2" id="workEndTime" disabled>
								</td>
								<th class="text-center align-middle plainText" rowspan="1">추가재단량</th>
								<td class="text-center align-middle">
									<input type="text" id="workAddCuttingQty" class="form-control text-end me-1 inputGroup virtualKeyboard2" value="0" onkeyup="numberFormat(this,'int')" disabled>
								</td>
							</tr>

						</table>
					</div>
				</div>
			</div>
		</div>
	</div>

</div>
<!-- 실적등록 모달 끝 -->
<!-- 실적등록 경고 -->
<div class="modal fade" id="workResultWarningModal" tabindex="-1"
	aria-hidden="true" style="z-index: 9999;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">
					<i class="fa-solid fa-triangle-exclamation text-danger"></i>
					<spring:message code="modal.warning" text="default text" />
				</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				수량이 부족합니다.<br>이대로 입력 하시겠습니까?
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger"
					id="btnWorkResultWarningModalY" data-bs-dismiss="modal"
					style="width: 70px;">
					<spring:message code="yes" text="default text" />
				</button>
				<button type="button" class="btn btn-secondary"
					id="btnWorkResultWarningModalN" data-bs-dismiss="modal"
					style="width: 70px;">
					<spring:message code="no" text="default text" />
				</button>
			</div>
		</div>
	</div>
</div>
<!-- 실적등록 경고 모달 끝 -->

<!-- 실적등록(번들링) 모달 -->
<div class="modal fade" id="workOrderPrcssBundleModal"
	data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
	aria-hidden="true">
	<div class="modal-dialog row"
		style="width: 75vw; max-width: 75vw; height: 93vh; max-height: 93vh;">
		<div class="modal-content" style="width: 100%; height: 100%;">
			<div class="modal-body" style="height: 100%; max-height: 100%;">
				<div class="row" style="width: 100%; height: 100%;">
					<div style="width: 100%; height: 100%; margin-right: 4px;">
						<div class="row" style="width: 100%; height: 70%;">
							<div style="width: 74.6%; height: 100%;">
								<div style="width: 100%; height: 100%;">
									<div
										style="padding: 5px; padding-bottom: 0px; margin-bottom: 5px; width: 100%; height: 7.5%;">
										<table class="table table-bordered p-0 m-0"
											style="height: 100%;">
											<colgroup>
												<col width="12.5%">
												<col width="12.5%">
												<col width="10%">
												<col width="15%">
												<col width="10%">
												<col width="40%">
											</colgroup>
											<tr style="width: 100%;">
												<th class="text-center align-middle">수주상세번호</th>
												<td class="text-center align-middle">
													<div id="modalBizOrdDtlNoBundle"></div>
												</td>
												<th class="text-center align-middle">공정명</th>
												<td class="text-center align-middle">
													<div id="modalPrcssNmBundle"></div>
												</td>
												<th class="text-center align-middle">제품명</th>
												<td colspan="3" class="text-center align-middle">
													<div id="itemNmBundle"></div>
												</td>
											</tr>
										</table>
									</div>

									<div
										style="padding: 0px 5px; margin-bottom: 5px; width: 100%; height: 50%;">
										<table class="table table-bordered p-0 m-0"
											style="height: 100%;">
											<colgroup>
												<col width="12.5%">
												<col width="12.5%">
												<col width="10%">
												<col width="15%">
												<col width="10%">
												<col width="15%">
												<col width="10%">
												<col width="15%">
											</colgroup>
											<tr style="width: 100%;">
												<th class="text-center align-middle">자재코드</th>
												<td class="text-center align-middle">
													<div id="customerItemCdBundle"></div>
												</td>
												<th class="text-center align-middle">버전번호</th>
												<td class="text-center align-middle"><a
													id="itemVersionLinkBundle" href="" target="_blank"> <span
														id="itemVersionBundle"></span>
												</a></td>

												<th class="text-center align-middle">코팅방법</th>
												<td class="text-center align-middle">
													<div id="coatingMethodBundle"></div>
												</td>
												<th class="text-center align-middle">코팅판번호</th>
												<td class="text-center align-middle">
													<div id="resinBoardBundle"></div>
												</td>
											</tr>
											<tr>
												<th class="text-center align-middle">COLOR</th>
												<td colspan="3" class="text-center align-middle">
													<div id="itemColorBundle"></div>
												</td>
												<!-- <th class="text-center align-middle">작업방법</th>
												<td class="text-center align-middle">	
													<div id="workMethodMultiSelect" style="width:100%;"></div>
												</td>
												<th class="text-center align-middle">버전번호</th>
												<td class="text-center align-middle">
													<a id="itemVersionLink" href="" target="_blank">
														<span id="itemVersion"></span>
													</a>
												</td> -->
												<th class="text-center align-middle">도수</th>
												<td class="text-center align-middle">
													<div id="itemFrequencyBundle"></div>
												</td>
												<th class="text-center align-middle">(수주)지시수량</th>
												<td class="text-center align-middle">
													<div id="allWorkOrdQtyBundle"></div>
												</td>
											</tr>
											<tr>
												<th class="text-center align-middle">목형번호</th>
												<td class="text-center align-middle">
													<div id="woodenCareCdBundle"></div>
												</td>
												<th class="text-center align-middle">타공목형번호</th>
												<td class="text-center align-middle">
													<div id="holeWoodenCdBundle"></div>
												</td>
												<th class="text-center align-middle">사이즈</th>
												<td class="text-center align-middle">
													<div id="itemSizeBundle"></div>
												</td>
												<th class="text-center align-middle">칼끝규격</th>
												<td class="text-center align-middle">
													<div id="knifeTipSizeBundle"></div>
												</td>
											</tr>
											<tr>
												<th class="text-center align-middle">FOIL</th>
												<td class="text-center align-middle">
													<div id="etc4Bundle"></div>
												</td>
												<th class="text-center align-middle">FOIL COLOR</th>
												<td class="text-center align-middle">
													<div id="etc5Bundle"></div>
												</td>
												<th class="text-center align-middle">부분UV</th>
												<td class="text-center align-middle">
													<div id="etc3Bundle"></div>
												</td>
												<th class="text-center align-middle">후가공판번호</th>
												<td class="text-center align-middle">
													<div id="etc2CdBundle"></div>
												</td>
											</tr>
											<tr>
												<th class="text-center align-middle">성형방식</th>
												<td class="text-center align-middle">
													<div id="moldingMethodBundle"></div>
												</td>
												<th class="text-center align-middle">성형내용</th>
												<td class="text-center align-middle">
													<div id="moldingContentsBundle"></div>
												</td>
												<th class="text-center align-middle">형압</th>
												<td class="text-center align-middle">
													<div id="etc6Bundle"></div>
												</td>
												<th class="text-center align-middle">동판번호</th>
												<td class="text-center align-middle">
													<div id="pressMethodBundle"></div>
												</td>
											</tr>
											<tr>
												<th class="text-center align-middle">묶음법</th>
												<td class="text-center align-middle">
													<div id="bundleMethodNmBundle"></div>
												</td>
												<th class="text-center align-middle">묶음단위</th>
												<td class="text-center align-middle">
													<div id="bundleUnitBundle"></div>
												</td>
												<th class="text-center align-middle">포장단위</th>
												<td class="text-center align-middle">
													<!-- <div id="packUnitBundle"></div> --> <input type="text"
													class="form-control inputGroup" id="packUnitBundle">
												</td>
												<th class="text-center align-middle">포장박스</th>
												<td class="text-center align-middle">
													<div id="packMethodNmBundle"></div>
												</td>
											</tr>
											<tr>
												<th class="text-center align-middle">건별전달사항</th>
												<td colspan="3" class="text-start align-middle">
													<div id="relayNoticeBundle"
														style="overflow: auto; white-space: pre-line; max-height: 40px;"></div>
												</td>
												<th class="text-center align-middle">특이사항</th>
												<td colspan="3" class="text-start align-middle">
													<div id="specialNoticeBundle"
														style="overflow: auto; white-space: pre-line; max-height: 40px;"></div>
												</td>
												<!-- <th class="text-center align-middle">수주특이사항</th>
												<td colspan="3" class="text-start align-middle">
													<div id="bizOrdIssue" style="white-space:pre-line;width:330px;"></div>
												</td>
												<th class="text-center align-middle">수주전달사항</th>
												<td colspan="3" class="text-start align-middle">
													<div id="bizOrdNote" style="white-space:pre-line;width:330px;"></div>
												</td> -->
												<!-- <th rowspan="2" class="text-center align-middle">지시비고사항</th>
												<td colspan="3" rowspan="2" class="text-start align-middle">
													<div id="workOrdDesc" style="white-space:pre-line;width:330px;"></div>
												</td> -->
											</tr>
											<tr>
												<th class="text-center align-middle">검수방법</th>
												<td class="text-center align-middle">
													<div id="inspectMethodNmBundle"></div>
												</td>
												<th class="text-center align-middle">기타1</th>
												<td class="text-center align-middle">
													<div id="etc7Bundle"></div>
												</td>
												<th class="text-center align-middle">기타2</th>
												<td class="text-center align-middle">
													<div id="etc8Bundle"></div>
												</td>
												<th class="text-center align-middle">기타3</th>
												<td class="text-center align-middle">
													<div id="etc9Bundle"></div>
												</td>
											</tr>
										</table>
									</div>

									<div style="padding: 0px 5px; width: 100%; height: 42%;"
										id="workOrderPrcssModalTableHeightBundle">
										<table class="table table-bordered p-0 m-0"
											id="inputBundleModalTable">
											<thead class="table-light">
												<tr>
													<th class="text-center align-middle">품목명</th>
													<th class="text-center align-middle">현재고</th>
													<th class="text-center align-middle"
														style="min-width: 59px; max-width: 59px;">투입수량</th>
													<th class="text-center align-middle">출고수량</th>
													<th class="text-center align-middle">불량수량</th>
													<th class="text-center align-middle">버전번호</th>
													<th class="text-center align-middle">수주상세번호</th>
													<th class="text-center align-middle">실적수량</th>

												</tr>
											</thead>
										</table>
									</div>
								</div>
							</div>
						</div>
						<div class="row" style="width: 74%; height: 30%;">
							<div class=""
								style="padding: 5px; padding-right: 0px; padding-top: 0px; padding-bottom: 0px; width: 37.1%; height: 100%;">
								<div style="width: 100%; height: 50%;"
									id="workOrdPrcssResultTableHeightBundle">
									<table class="table table-bordered p-0 m-0 "
										id="workOrdPrcssResultTableBundle">
										<thead class="table-light">
											<tr>
												<th class="text-center align-middle"
													style="vertical-align: middle;">실적등록일</th>
												<th class="text-center align-middle"
													style="vertical-align: middle;">등록자</th>
												<th class="text-center align-middle"
													style="vertical-align: middle;">작업량</th>
												<th class="text-center align-middle"
													style="vertical-align: middle;">불량</th>
											</tr>
										</thead>
									</table>
								</div>
								<table class="table table-bordered p-0 m-0"
									style="height: 50%; width: 100%;">
									<colgroup>
										<col width="11%">
										<col width="49%">
									</colgroup>
									<tr>
										<th class="text-center align-middle">작업일자</th>
										<td class="text-center align-middle"><input type="date"
											class="form-control inputGroup virtualKeyboard2"
											id="workDateBundle" disabled></td>
									</tr>
									<tr>
										<th class="text-center align-middle">시작시간</th>
										<td class="text-center align-middle"><input
											type="datetime-local"
											class="form-control inputGroup virtualKeyboard2"
											id="workStartTimeBundle" disabled></td>
									</tr>
									<tr>
										<th class="text-center align-middle">종료시간</th>
										<td class="text-center align-middle"><input
											type="datetime-local"
											class="form-control inputGroup virtualKeyboard2"
											id="workEndTimeBundle" disabled></td>
									</tr>
								</table>
							</div>

							<div style="width: 62.9%; /* height: 100%; */ overflow: auto;">
								<div class="row"
									style="padding-left: 5px; padding-top: 0px; padding-bottom: 1px; width: 100%; height: 100%;">
									<table class="table table-bordered p-0 m-0"
										style="height: 100%; width: 100%;">
										<colgroup>
											<col width="10%">
											<col width="15%">
											<col width="10%">
											<col width="15%">
											<col width="10%">
											<col width="40%">
										</colgroup>

										<tr>
											<th class="text-center align-middle" style="height: 50%;">전체공정<br>특이사항
											</th>
											<td class="text-center align-middle" colspan="3">
												<div class="row" style="height: 100%;">
													<textarea id="workOrdBeforePrcssDescBundle"
														class="form-control resize-none inputGroup"
														style="resize: none; height: 100%; width: 83.9%;" disabled></textarea>
													<input type="checkbox"
														id="workOrdBeforePrcssDescCheckBundle"
														style="width: 14%; margin-left: 5px;">
												</div>
											</td>
											<th class="text-center align-middle" style="height: 50%;">현공정<br>특이사항
											</th>
											<td class="text-center align-middle" colspan="3"><textarea
													id="fieldDescBundle"
													class="form-control resize-none inputGroup"
													style="resize: none; height: 100%;" disabled></textarea></td>
										</tr>
										<tr>
											<th class="text-center align-middle" style="height: 20%;">수주수량</th>
											<td class="text-end align-middle">
												<div id="bizOrdQtyBundle"></div>
											</td>
											<th class="text-center align-middle" style="height: 20%;">지시수량</th>
											<td class="text-end align-middle">
												<div id="workOrdQtyBundle"></div>
											</td>
											<th class="text-center align-middle">전공정<br>실적
											</th>
											<td class="text-end align-middle">
												<div class="row">
													<div id="workOrdBeforePrcssQtyHiddenBundle"
														style="width: 50%;"></div>
													<div id="workOrdBeforePrcssQtyBundle" style="width: 50%;"></div>
												</div>
											</td>
										</tr>
										<tr>
											<th colspan="1" class="text-center align-middle">작업량</th>
											<td colspan="5" class="text-center align-middle">
												<div style="display: flex; flex-wrap: 1 1 auto;">
													<input type="text" id="workQtyRChangeBundle"
														class="form-control text-end me-1" placeholder="R변환"
														disabled> <input type="text" id="workQtyBundle"
														class="form-control text-end me-1 inputGroup virtualKeyboard2"
														value="0" onkeyup="numberFormat(this,'int')" disabled>
													<input type="text" id="workPrcssQtyUnitBundle"
														class="form-control text-end me-1" placeholder="공정단위"
														disabled>
												</div>
											</td>
										</tr>
										<tr>
											<th colspan="1" class="text-center align-middle">불량</th>
											<td colspan="5" class="text-center align-middle">
												<div style="display: flex; flex-wrap: 1 1 auto;">
													<input type="text" id="workFaultyQtyRChangeBundle"
														class="form-control text-end me-1" placeholder="R변환"
														disabled> <input type="text"
														id="workFaultyQtyBundle"
														class="form-control text-end me-1 inputGroup virtualKeyboard2"
														value="0" onkeyup="numberFormat(this,'int')" disabled>
													<input type="text" id="workPrcssFaultyQtyUnitBundle"
														class="form-control text-end me-1" placeholder="공정단위"
														disabled>
												</div>
											</td>
										</tr>
									</table>
								</div>
							</div>
						</div>

						<div class="row">
							<div class="card virtualKeyboard_content2"
								style="width: 25%; height: 67.4vh; position: absolute; bottom: 24.75%; left: 73.8%;
	/* padding:1%; */ margin: 0px; font-weight: bolder; border-width: 0px;">
								<div class="row virtualKeyboard_content2"
									style="width: 100%; height: 19%; margin-bottom: 5px;">
									<div class="col virkey" id="virkeypad_1_0Bundle"
										style="font-size: 2vw !important; padding-left: 5%; margin-right: 5px;">7</div>
									<div class="col virkey" id="virkeypad_1_1Bundle"
										style="font-size: 2vw !important; padding-left: 5%; margin-right: 5px;">8</div>
									<div class="col virkey" id="virkeypad_1_2Bundle"
										style="font-size: 2vw !important; padding-left: 5%; margin-right: 5px;">9</div>
									<div class="col virkey" id="virkeypad_0_0Bundle"
										style="font-size: 2vw; padding-left: 5%; margin-right: 5px; text-align: center;">
										<i class="fas fa-long-arrow-alt-left" id="backspace"></i>
									</div>
								</div>
								<div class="row virtualKeyboard_content2"
									style="width: 100%; height: 19%; margin-bottom: 5px;">
									<div class="col virkey" id="virkeypad_2_0Bundle"
										style="font-size: 2vw !important; padding-left: 5%; margin-right: 5px;">4</div>
									<div class="col virkey" id="virkeypad_2_1Bundle"
										style="font-size: 2vw !important; padding-left: 5%; margin-right: 5px;">5</div>
									<div class="col virkey" id="virkeypad_2_2Bundle"
										style="font-size: 2vw !important; padding-left: 5%; margin-right: 5px;">6</div>
									<div class="col virkey" id="virkeypad_2_3Bundle"
										style="font-size: 2vw !important; padding-left: 5%; margin-right: 5px; text-align: center;">
										<i class="far fa-caret-square-up" id="upCount"></i>
									</div>
								</div>
								<div class="row virtualKeyboard_content2"
									style="width: 100%; height: 19%; margin-bottom: 5px;">
									<div class="col virkey" id="virkeypad_3_0Bundle"
										style="font-size: 2vw !important; padding-left: 5%; margin-right: 5px;">1</div>
									<div class="col virkey" id="virkeypad_3_1Bundle"
										style="font-size: 2vw !important; padding-left: 5%; margin-right: 5px;">2</div>
									<div class="col virkey" id="virkeypad_3_2Bundle"
										style="font-size: 2vw !important; padding-left: 5%; margin-right: 5px;">3</div>
									<div class="col virkey" id="virkeypad_3_3Bundle"
										style="font-size: 2vw !important; padding-left: 5%; margin-right: 5px; text-align: center;">
										<i class="far fa-caret-square-down" id="downCount"></i>
									</div>

								</div>
								<div class="row virtualKeyboard_content2"
									style="width: 100%; height: 19%; margin-bottom: 5px;">
									<div class="col virkey" id="virkeypad_4_0Bundle"
										style="font-size: 2vw !important; padding-left: 5%; min-width: 10%; margin-right: 5px;">0</div>
									<div class="col virkey" id="virkeypad_4_1Bundle"
										style="font-size: 2vw !important; padding-left: 5%; margin-right: 5px;">.</div>
									<div class="col virkey" id="virkeypad_4_2Bundle"
										style="font-size: 0.8vw !important; padding-left: 5%; margin-right: 5px;">Enter</div>
								</div>

							</div>
							<div
								style="width: 25%; height: 34.35vh; position: absolute; bottom: 2.5%; left: 73.8%;
	/* padding:1%; */ margin: 0px; font-weight: bolder; border-width: 0px;"
								class="row">
								<button type="button" id="btnWorkStartBundle"
									style="font-size: 2em !important; width: 49%; margin-bottom: 5px; white-space: nowrap;"
									class="btn btn-outline-primary">작업시작</button>
								<button type="button" id="btnWorkEndBundle"
									style="font-size: 2em !important; width: 49%; margin-bottom: 5px; margin-left: 5px; white-space: nowrap;"
									class="btn btn-outline-success">작업완료</button>

								<button type="button" id="btnWorkSaveBundle"
									style="font-size: 2em !important; width: 49%; margin-bottom: 5px; white-space: nowrap;"
									class="btn btn-outline-success">저장</button>
								<button type="button" id="btnWorkDelBundle"
									style="font-size: 2em !important; width: 49%; margin-bottom: 5px; margin-left: 5px; border-color: #dc3545; white-space: nowrap;"
									class="btn btn-outline-danger">실적삭제</button>

								<button type="button" id="btnWorkCancelBundle"
									style="font-size: 2em !important; width: 49%; margin-bottom: 5px; border-color: #dc3545; white-space: nowrap;"
									class="btn btn-outline-danger">진행취소</button>
								<button type="button" id="btnCompulsionEndBundle"
									style="font-size: 2em !important; width: 49%; margin-bottom: 5px; margin-left: 5px; border-color: #dc3545; white-space: nowrap;"
									class="btn btn-outline-danger">작업중지</button>


								<!-- <button type="button"
									style="font-size: 2em !important; width: 49%; margin-bottom: 5px; white-space: nowrap;"
									class="btn btn-outline-success">공정검사</button>
								<button type="button"
									style="font-size: 2em !important; width: 49%; margin-bottom: 5px; margin-left: 5px; white-space: nowrap;"
									class="btn btn-outline-success">자재반입</button> -->

								<button type="button"
									style="font-size: 2em !important; width: 100%; white-space: nowrap;"
									class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
							</div>

						</div>

					</div>

				</div>

			</div>

		</div>

	</div>

</div>
<!-- 실적등록(번들링) 모달 끝 -->

<!-- 공정 작업완료 경고 -->
<div class="modal fade" id="workEndModal" tabindex="-1"
	aria-hidden="true" style="z-index: 9999;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">
					<i class="fa-solid fa-triangle-exclamation text-danger"></i>
					<spring:message code="modal.warning" text="default text" />
				</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				작업완료할 경우 더 이상 공정실적을 수정할 수 없습니다.<br> 작업완료하시겠습니까?
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" id="btnWorkEndModalY"
					data-bs-dismiss="modal" style="width: 70px;">
					<spring:message code="yes" text="default text" />
				</button>
				<button type="button" class="btn btn-secondary"
					id="btnWorkEndModalN" data-bs-dismiss="modal" style="width: 70px;">
					<spring:message code="no" text="default text" />
				</button>
			</div>
		</div>
	</div>
</div>
<!-- 공정 작업완료 경고 모달 끝 -->

<!-- 수주취소 경고 -->
<div class="modal fade" id="compulsionEndModal" tabindex="-1"
	aria-hidden="true" style="z-index: 9999;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">
					<i class="fa-solid fa-triangle-exclamation text-danger"></i>
					<spring:message code="modal.warning" text="default text" />
				</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<label style="">작업중지 진행시</label> <br> <label class="mt-2"
					style="color: red;">1. 대기, 진행 중인 공정은 강제 완료처리됩니다.</label> <br>
				<label style="color: red;">2. 수주는 PO완료 처리됩니다.</label> <br> <label
					style="color: red;">3. 더 이상 수정 및 복구가 불가능합니다.</label> <br> <label
					class="mt-2">계속하시겠습니까?</label>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" id="btnCompulsionEndY"
					data-bs-dismiss="modal" style="width: 70px;">
					<spring:message code="yes" text="default text" />
				</button>
				<button type="button" class="btn btn-secondary"
					id="btnCompulsionEndN" data-bs-dismiss="modal" style="width: 70px;">
					<spring:message code="no" text="default text" />
				</button>
			</div>
		</div>
	</div>
</div>
<!-- 수주취소 경고 모달 끝 -->

<!-- 라벨프린트 모달 -->
<div class="modal fade" id="labelPrintModal" tabindex="-1" aria-hidden="true" style="z-index: 9999;">
	<div class="modal-dialog" >
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">라벨프린트 모달</h5>
			</div>
			<div class="modal-body">
				<div class="row" style="padding-bottom: 5px;">
					<table id="labelPrintTable" class="table table-bordered m-0" style="border:1px solid #ffffff;">
						<colgroup id="trlabelPrintAppendTarget">
							<col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%">
							<col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%">
							<col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%">
							<col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%">
							<col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%">
						</colgroup>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 라벨프린트 모달 끝 -->

<!-- 실적등록창 css -->
<style>
#bizInfoGroup {
	grid-area: bizInfoGroup;
}

#itemInfoGroup {
	grid-area: itemInfoGroup;
}

#matrlGroup {
	grid-area: matrlGroup;
}

#workResultGroup {
	grid-area: workResultGroup;
}

#workInputGroup {
	grid-area: workInputGroup;
}

#btnGroup {
	grid-area: btnGroup;
}

/* 투입자재 + 공정실적리스트 dataTable css */
#purchaseMatrlModalTable td {
	padding: 0px !important;
	font-size: 15px !important;
}
#purchaseMatrlModalTable th {
	padding: 0px !important;
	font-size: 15px !important;
}

#workResultListTable td {
	padding: 0px !important;
	font-size: 15px !important;
}
#workResultListTable th {
	padding: 0px !important;
	font-size: 15px !important;
}

/* workOrderPrcssModal모달 전용 css */
#workOrderPrcssModal td {
	font-size: 15px !important;
}
#workOrderPrcssModal th {
	font-size: 15px !important;
}
#workOrderPrcssModal th.strongTh {
    font-size: 18px !important; /* 다른 th보다 1px 크게 설정 */
    font-weight: bold !important;
}
#workOrderPrcssModal td.strongTh {
    font-size: 18px !important; /* 다른 th보다 1px 크게 설정 */
    font-weight: bold !important;
}
</style>
<!-- 실적등록창 css 끝 -->

<!-- 인쇄용지설정 -->
<style type="text/css" media="print" id="printPaperTypeStyle">
@media print {
	@page { size: A3 landscape; margin: 3mm; }, /*landscape 가로  portrait 세로 */
	html, body { width: 297mm;height: 420mm; }
}
</style>
<!-- 인쇄용지설정 css 끝 -->

<!-- 화면설정 script -->
<script>
	let isDraggingVT = false; // 세로 드레그 여부
	let isDraggingVB = false; // 세로 드레그 여부
	let isDraggingH = false; // 가로 드레그 여부
	
	function SetCursor(cursor) {
		let page = document.getElementById("page");
		page.style.cursor = cursor;
	}
	
	function StartDrag(type) {
		if(type == 'VT') { isDraggingVT = true; SetCursor("n-resize");}
		if(type == 'VB') { isDraggingVB = true; SetCursor("n-resize");}
		if(type == 'H') { isDraggingH = true; SetCursor("ew-resize");}
	}
	
	function EndDrag(e) {
		if(isDraggingVT || isDraggingVB || isDraggingH) {
			dataTableDrawAll(); // dataTable 전체 reload
			isDraggingVT = false;
			isDraggingVB = false;
			isDraggingH = false;
			SetCursor("auto");
		}
	}

	function minimum(node) {
		let id = $(node).attr('id');

		if(id == 'dragbarVT') {
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

			//최소화기능만 적용
			cols = [
				page_height - rightcolB_height - rightcolM_min_height - dragbarWidth*2,
				dragbarWidth,
				rightcolM_min_height,
				dragbarWidth,
				rightcolB_height
			];
		
			/* if(rightcolM_height == rightcolM_min_height) { // 원위치
				cols = [
					rightcolT_min_height,
					dragbarWidth,
					page_height - dragbarWidth*2 - rightcolB_height - rightcolT_min_height,
					dragbarWidth,
					rightcolB_height
				];
			} else { // 최소화
				cols = [
					page_height - rightcolB_height - rightcolM_min_height - dragbarWidth*2,
					dragbarWidth,
					rightcolM_min_height,
					dragbarWidth,
					rightcolB_height
				];
			} */
			
			
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

		dataTableDrawAll(); // dataTable 전체 reload
	}
	
	function OnDrag(event) {
		if (isDraggingH) { // 좌우 스크롤
			let page = document.getElementById("page");
			let leftcol = document.getElementById("leftcol"); // 좌측
			let rightcolT = document.getElementById("rightcolT"); // 우측 상단
			let rightcolM = document.getElementById("rightcolM"); // 우측 중단
			let rightcolB = document.getElementById("rightcolB"); // 우측 하단
			let dragbarWidth = 4;
			let leftcolMinWidth = 20; // leftcol 최소사이즈
			$('#leftHeader').children().each(function(index, item) {
				leftcolMinWidth += $(item).width();
			});
			let rightcolMinWidth = 200; // rightcol 최소사이즈
	
			let rightColWidth = page.clientWidth - parseInt(Math.max(leftcolMinWidth + 120, event.clientX));
			
			let cols = [
				parseInt(Math.max(leftcolMinWidth, page.clientWidth - dragbarWidth - parseInt(Math.max(rightColWidth, rightcolMinWidth)))),
				dragbarWidth,
				parseInt(Math.max(rightColWidth, rightcolMinWidth))
			];
	
			let newColDefn = cols.map(c => c.toString() + "px").join(" ");
	
			page.style.gridTemplateColumns = newColDefn;
	
			event.preventDefault();
		} else if (isDraggingVT) { // rightcolT와 rightcolM 사이
			let dragbarWidth = 4;

			let page_height = parseInt($('#page').height()); 			// 전체 높이
			let rightcolT_height = parseInt($('#rightcolT').height());	// 우측 상단
			let rightcolM_height = parseInt($('#rightcolM').height());	// 우측 중단
			let rightcolB_height = parseInt($('#rightcolB').height());	// 우측 하단

			let rightcolT_min_height = 100;	// 우측 상단 최소높이
			let rightcolM_min_height = 34;	// 우측 중단 최소높이
			let rightcolB_min_height = 34;	// 우측 하단 최소높이

			let cursorY = event.clientY;	// 현재 cursor y좌표(위에서부터 얼마나 떨어졌는지)

			
			let cols = [
				Math.min(Math.max(rightcolT_min_height, cursorY), page_height - rightcolB_height - rightcolM_min_height - dragbarWidth*2),
				dragbarWidth,
				page_height - rightcolB_height - dragbarWidth*2 - Math.min(Math.max(rightcolT_min_height, cursorY), page_height - rightcolB_height - rightcolM_min_height - dragbarWidth*2),
				dragbarWidth,
				rightcolB_height
			];

	
			let newColDefn = cols.map(c => c.toString() + "px").join(" ");

			$('#page').css('grid-template-rows',newColDefn);
	
			event.preventDefault();
		} else if (isDraggingVB) { // 상하 스크롤
			let dragbarWidth = 4;

			let page_height = parseInt($('#page').height()); 			// 전체 높이
			let rightcolT_height = parseInt($('#rightcolT').height());	// 우측 상단
			let rightcolM_height = parseInt($('#rightcolM').height());	// 우측 중단
			let rightcolB_height = parseInt($('#rightcolB').height());	// 우측 하단

			let rightcolT_min_height = 100;	// 우측 상단 최소높이
			let rightcolM_min_height = 34;	// 우측 중단 최소높이
			let rightcolB_min_height = 34;	// 우측 하단 최소높이

			let cursorY = event.clientY;	// 현재 cursor y좌표(위에서부터 얼마나 떨어졌는지)
			
			let cols = [
				rightcolT_height,
				dragbarWidth,
				Math.min(Math.max(cursorY - rightcolT_height - dragbarWidth, rightcolM_min_height), page_height - rightcolT_height - dragbarWidth*2 - rightcolB_min_height),
				dragbarWidth,
				Math.max(rightcolB_min_height, page_height - rightcolT_height - dragbarWidth*2 - Math.max(cursorY - rightcolT_height - dragbarWidth, rightcolM_min_height))
			];
	
			let newColDefn = cols.map(c => c.toString() + "px").join(" ");
	
			$('#page').css('grid-template-rows',newColDefn);
	
			event.preventDefault();
		}
	}

	$('#btnOpen').on('click',function() { // right-box 열기버튼 클릭
		if($('#rightcolT').hasClass('d-none')){
			$('#page').css('grid-template-columns', '7.5fr 4px 2.5fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcolT').removeClass('d-none');
		} else {
			$('#page').css('grid-template-columns', '0fr 4px 2.5fr');
			$('#leftcol').addClass('d-none');
			$('#rightcolT').removeClass('d-none');
		}
		dataTableDrawAll(); // dataTable 전체 reload
	});
	$('#btnClose').on('click',function() { // right-box 닫기버튼 클릭
		if($('#leftcol').hasClass('d-none')){
			$('#page').css('grid-template-columns', '7.5fr 4px 2.5fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcolT').removeClass('d-none');
		} else {
			$('#page').css('grid-template-columns', '7.5fr 4px 0fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcolT').addClass('d-none');
		}
		dataTableDrawAll(); // dataTable 전체 reload
	});
</script>

<script>
	WM_init('new');
	WM_init('edit');

	$('#btnClose').trigger('click');

	let monthAdjustList = getCommonCode('시스템', '026'); //날짜조정
	monthAdjustList = _.sortBy(monthAdjustList, v=>parseInt(v.commonCd));
	selectBoxAppend(monthAdjustList, 'monthAdjust', '', '2'); //날짜조정
	
	// 공통코드 조회
	let faultyReasonList = getCommonCode('일반', '030'); // 불량구분
	let ordStatusList = getCommonCode('시스템', '022'); // 수주상태

	//공통코드조회시 사용되는 맵변수
	const prcssCdAndComCode = {
		'A1' : '042',
		'A2' : '043',
		'A3' : '044',
		'C1' : '045',
		'C2' : '046',
		'C3' : '047',
		'C4' : '047',
		'C5' : '048',
		'C6' : '049',		
		'B1' : '050',
		'B2' : '051',
		'C7' : '052',
		'B3' : '053'
	}
	
	selectBoxAppend(faultyReasonList, 'faultyReason', '', '1'); //불량구분


	let reloadTimeList = getCommonCode('시스템', '039'); // 갱신주기
	
	let sessionUserNm = "${userNm}";//세션에서 가져온 유저이름
	let delStatus = '';

	let workMethodJson = '';
	let workMethod = '';
	let workOrdIdx = '';
	let bizOrdDtlIdxVal = '';
	let workOrdPrcssIdx = '';
	let workOrdPrcssIdxVal = '';
	let checkVo = '';
	let prcssQtyUnit = false;
	
	//공정작업상태맵 
	let progressStatusListMap = new Map();
	progressStatusListMap.set('PI','대기');
	progressStatusListMap.set('WI','진행');
	progressStatusListMap.set('WC','완료');

	let trId = '';
	let selectPeriod = parseInt(getCommonCode('시스템', '040')[0].commonCd); //기본조회기간 일
	let startDate = moment().subtract('d',selectPeriod).format('YYYY-MM-DD').replaceAll('-','');
	let endDate = moment().format('YYYY-MM-DD');

	$('#startDate').val(moment().subtract('d',selectPeriod).format('YYYY-MM-DD'));
	$('#endDate').val(moment().format('YYYY-MM-DD'));

	//30분마다 자동조회
	function intervalReload(){
		$('#my-spinner').show();
		
		if( !isEmptyCheck(workOrderPrcssTable.row('.selected').data()) ){
			trId = workOrderPrcssTable.row('.selected').data().workOrdPrcssIdx;
		} else {
			trId = '';
		}
		workOrderPrcssTable.ajax.reload(function(){
			$('#my-spinner').hide();
			let reloadEndData = workOrderPrcssTable.data().toArray();
			//해당 checkVo의 idx가 현재 리로드된 테이블에 데이터가 없을 경우
			if(!reloadEndData.map(v=>v.workOrdPrcssIdx).includes(trId)){
				workOrderPrcssTable.row('.selected').deselect();
				//workOrdPrcssStatusTable.clear().draw();
				workPrcssDtlTable.clear().draw();
				inputMaterialHistTable.clear().draw();
				//모든 모달 닫도록
				$('.modal').modal('hide');
			} else {
				//있을경우
				setTimeout(function() {
        			workOrderPrcssTable.row('#'+trId).select();
					$(workOrderPrcssTable.row('#'+trId).node()).trigger('click'); // 선택처리
				}, 100)
			}
		});
	}
	//1,800,000 == 30분
	// 60,000 == 1분
	setInterval( intervalReload , parseInt(reloadTimeList[0].commonCd) * 60000);
	
	/**************************************************************작지공정목록**************************************************************/
	// 작지공정 목록조회
	let filterObj = ''; 
	let timer;
	$('#workOrderPrcssTable thead tr').clone(true).addClass('filters').appendTo('#workOrderPrcssTable thead'); // filter 생성
	let workOrderPrcssTable = $('#workOrderPrcssTable').DataTable({
		dom : "<'row'<'col-md-12 col-md-6'l><'col-md-12 col-md-6'f>>"
				+ "<'row'<'col-md-12'tr>>"
				+ "<'row pt-1'<'d-flex align-items-center d-flex'Bp><'me-lg-auto'><'d-flex align-items-center justify-content-end'i>>",
		language: lang_kor,
		info: true,
		ordering: true,
		processing: true,
//		paging: true,
 		paging: false,
		lengthChange: false,
		searching: true,
		autoWidth: false,
		orderCellsTop: true,
        fixedHeader: false,
        scrollY: '100vh',
        scrollX: true,
//		pageLength: 15,
 		pageLength: -1,
		colReorder: false,
		select: {
            style: 'single',
            //selector : 'tr:not(.notSelect)',
            toggleable: false,
            items: 'row',
            info: false
        },
        ajax : {
			url : '<c:url value="/wm/workOrdLstWithPrcssByOrdDate"/>',
			type : 'POST',
			data : {
				'searchTarget' : function(){ return $('#searchTarget').val();},
				'startDate' : function(){return startDate;},
				'endDate'	: function(){return endDate;}
			},
		}, 
        rowId: 'workOrdPrcssIdx',
		columns : [
			{//체크박스
				className : 'text-center align-middle',
				render: function(data, type, row, meta) {
					return '<div style="white-space: nowrap;"><input class="form-check-input" type="checkbox" name="btnCheck" style="margin: 0px; width:20px; height:20px;"></div>';
				}, orderable: false
			},
			{ data: 'bizStatusCd', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return _.filter(ordStatusList,v=>v.commonCd == data)[0].commonNm;
					} else {
						return '수주등록';
					}
				}
			},//수주상태
			{ data : 'bizOrdDtlNo', className : 'text-center align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},//수주번호
			{ data : 'dealCorpNm', className : 'text-center align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},//고객사
			/* { data: 'progressStatus', className : 'text-center align-middle',
				render: function(data, type, row, meta) {
					return progressStatusListMap.get(data);
				}
			},//공정작업상태 */
			{ data : 'itemNm', className : 'text-center align-middle',
				render: function(data, type, row, meta) {
					if(data != null && data != ''){
						let fairQty = isEmptyCheck(row['fairQty'])?'-':parseInt(row['fairQty']);
						let calOrdQty = isEmptyCheck(row['calOrdQty'])?0:parseInt(row['calOrdQty']);
						if(fairQty!='-'&&fairQty<calOrdQty){
							return '<div><big class="fw-bolder" style="color: #ff0000;">! </big>'+data+'</div>'; 
						} else {
							return '<div>'+data+'</div>';
						}
					} else {
						return '-';
					}
				}
			},//품명
			{ data : 'bizOrdQty', className : 'text-end align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
					} else {
						return '0';
					}
				}
			},//수주수량
			{ data : 'ordEndDate', className : 'text-center align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data).format('YYYY-MM-DD')+'</div>';
					} else {
						return '-';
					}
				}
			},//목표요구일
			{ data: 'workOrdPrcssJson', className : 'text-center align-middle', name : 'progressStatus',
				render: function(data, type, row, meta) {
					if(data != '' && data != null) {
						let parseData = JSON.parse(data);
						//진행,완료된 공정의 리스트
						let filterList = parseData.filter(v=>v.progressStatus == 'WI' || v.progressStatus == 'WC');
						let finshPrcssCount = filterList.length;
						//진행 , 완료된 공정이 없다면 -> 첫 공정 작업대기 
						if(finshPrcssCount == 0){
 							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">' + parseData[0].prcssNm + '(작업대기)</div>';
						} else if( finshPrcssCount > 0){
							// 진행 마지막 실적의 공정명, 모든 공정이 완료된(parseData길이 ==finshPrcssCount길이)경우 작업완료
							filterList = parseData.filter(v=> v.progressStatus == 'WC');
						 	finshPrcssCount = filterList.length; 
							let progressNm = '-';
							if( finshPrcssCount == parseData.length){
								progressNm = '생산완료';
							} else {
								// 작업중, 작업대기
								//pi,wc리스트
								let workFilterList = parseData.filter(v=>v.progressStatus == 'PI' || v.progressStatus == 'WI');
								if(workFilterList[0].progressStatus == 'PI'){
									progressNm = workFilterList[0].prcssNm + '(작업대기)';
								} else if(workFilterList[0].progressStatus == 'WI'){
									progressNm = workFilterList[0].prcssNm + '(작업중)';
								}
							}
 							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">' + progressNm + '</div>';
						} else{
							return '-';
						}
					} else {
						return '-';
					}
				}
			},//진행상태
			{ data : 'prevPrcssFairQty', className : 'text-end align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
					} else {
						return '0';
					}
				}
			},//전공정 양품수량
			{ data : 'fairQty',className : 'text-end align-middle', name: 'fairQty',
				render: function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+ addCommas(parseFloat(data))+'</div>';
					} else {
						return '0';
					}
				}
			},//생산수량
			{ data : 'faultyQty',className : 'text-end align-middle', name: 'faultyQty',
				render: function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+ addCommas(parseFloat(data))+'</div>';
					} else {
						return '0';
					}
				}
			},//손지
			/* { data : 'workOrdDesc', className : 'text-center align-middle', name : 'workOrdDesc',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},//지시비고사항 */
			{ data : 'workOrdDesc', className : 'text-center align-middle', name : 'workOrdDesc',
				render: function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div class="" style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},//지시비고사항
			
			/* { data : 'prcssDesc', className : 'text-center align-middle',
				render: function(data) {
					if(data != null && data != ''){						
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},//생산 특이사항 */
			{ data : 'prcssNm', className : 'text-center align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},//공정명
			{ //접지라벨
				data : 'groundPrintYn', className : 'text-center align-middle', name : 'groundPrintYn',
				render: function(data) {
					if ( data != null && data == 'Y' ) {
						return '<button type="button" class="btn btn-success w-auto" style="font-size: 18px !important;" name="btnGroundPrint"><i class="fa-solid fa-print"></i></button>';
					} else {
						return '<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" name="btnGroundPrint"><i class="fa-solid fa-print"></i></button>';
					}
				}
			},
			{ //CTCP라벨
				data : 'ctcpPrintYn', className : 'text-center align-middle', name : 'ctcpPrintYn',
				render: function(data) {
					if ( data != null && data == 'Y' ) {
						return '<button type="button" class="btn btn-success w-auto" style="font-size: 18px !important;" name="btnCtcpPrint"><i class="fa-solid fa-print"></i></button>';
					} else {
						return '<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" name="btnCtcpPrint"><i class="fa-solid fa-print"></i></button>';
					}
				}
			},
			{ data : 'equipNm', className : 'text-center align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},//설비명
			/* { data : 'ordDate', className : 'text-center align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data).format('YYYY-MM-DD')+'</div>';
					} else {
						return '-';
					}
				}
			},//생산지시일
			
			{ data : 'outReqDate', className : 'text-center align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data).format('YYYY-MM-DD')+'</div>';
					} else {
						return '-';
					}
				}
			},//납품요구일 */
// 			{ data : 'workOrdQty', className : 'text-end align-middle',
// 				render: function(data, type, row, meta) {
// 					let addCuttingVal = row['addCutting'] != null & row['addCutting'] != '' ? row['addCutting'] : 0;
// 					if(data != null && data != ''){
// 						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data) + parseFloat(addCuttingVal))+'</div>';
// 					} else {
// 						return '0';
// 					}
// 				}
// 			},//지시수량
			/* { data : 'fairQty',className : 'text-end align-middle',
				render: function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+ addCommas(parseFloat(row['workOrdQty']) - parseFloat(data) - parseFloat(row['faultyQty']) )+'</div>';
					} else {
						return addCommas(parseFloat(row['workOrdQty']));
					}
				}
			},//미생산수량
			{ data : 'woodenWdCd', className : 'text-center align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},//목형번호
			{ data : 'resinBoardWdCd', className : 'text-center align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},//수지판번호 */
			
			/* { data : 'workOrdNo', className : 'text-center align-middle',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},//지시번호 */
			
			{ data : 'frequency', className : 'text-center align-middle', name : 'frequency',
				render: function(data, type, row, meta) {
					if(data != null && data != '' && row['comCodeJson'] != null && row['comCodeJson'] != ''){
						let comCodeJson = JSON.parse(row['comCodeJson']);
						let comDesc = comCodeJson?.filter(v => v.ETC_1 === 'frequency')[0].COMMON_DESC;
						
						if(comDesc == 'Y'){
							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						} else {
							return '-';
						}
					} else {
						return '-';
					}
				}
			},//도수		
			{ data : 'matrlInfoJson', className : 'text-center align-middle', name : 'paperType',
				render: function(data, type, row, meta) {
					if(data != null && data != '' && row['comCodeJson'] != null && row['comCodeJson'] != ''){
						let matrlJson = JSON.parse(data);
						
						let comCodeJson = JSON.parse(row['comCodeJson']);
						let comDesc = comCodeJson?.filter(v => v.ETC_1 === 'paperType')[0].COMMON_DESC;
						
						if(comDesc == 'Y'){
							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+matrlJson[0].PAPER_TYPE+'</div>';
						} else {
							return '-';
						}
					} else {
						return '-';
					}
				}
			},//원지
			{ data : 'matrlInfoJson', className : 'text-center align-middle', name : 'cutQty',
				render: function(data, type, row, meta) {
					if(data != null && data != '' && row['comCodeJson'] != null && row['comCodeJson'] != ''){
						let matrlJson = JSON.parse(data);
						
						let comCodeJson = JSON.parse(row['comCodeJson']);
						let comDesc = comCodeJson?.filter(v => v.ETC_1 === 'cutQty')[0].COMMON_DESC;
						
						if(comDesc == 'Y'){
							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+matrlJson[0].CUT_QTY+'</div>';
						} else {
							return '-';
						}
					} else {
						return '-';
					}
				}
			},//절수
			{ data : 'matrlInfoJson', className : 'text-center align-middle', name : 'eaQty',
				render: function(data, type, row, meta) {
					if(data != null && data != '' && row['comCodeJson'] != null && row['comCodeJson'] != ''){
						let matrlJson = JSON.parse(data);
						
						let comCodeJson = JSON.parse(row['comCodeJson']);
						let comDesc = comCodeJson?.filter(v => v.ETC_1 === 'eaQty')[0].COMMON_DESC;
						
						if(comDesc == 'Y'){
							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+matrlJson[0].EA_QTY+'</div>';
						} else {
							return '-';
						}
					} else {
						return '-';
					}
				}
			},//개수
			{ data : 'itemColor', className : 'text-center align-middle', name : 'itemColor',
				render: function(data, type, row, meta) {
					if(data != null && data != '' && row['comCodeJson'] != null && row['comCodeJson'] != ''){
						let comCodeJson = JSON.parse(row['comCodeJson']);
						let comDesc = comCodeJson?.filter(v => v.ETC_1 === 'itemColor')[0].COMMON_DESC;
						
						if(comDesc == 'Y'){
							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						} else {
							return '-';
						}
					} else {
						return '-';
					}
				}
			},//칼라
			{ data : 'coatingMethod', className : 'text-center align-middle', name : 'coatingMethod',
				render: function(data, type, row, meta) {
					if(data != null && data != '' && row['comCodeJson'] != null && row['comCodeJson'] != ''){
						let comCodeJson = JSON.parse(row['comCodeJson']);
						let comDesc = comCodeJson?.filter(v => v.ETC_1 === 'coatingMethod')[0].COMMON_DESC;
						
						if(comDesc == 'Y'){
							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						} else {
							return '-';
						}
					} else {
						return '-';
					}
				}
			},//코팅		
			{ data : 'moldingMethod', className : 'text-center align-middle', name : 'moldingMethod',
				render: function(data, type, row, meta) {
					if(data != null && data != '' && row['comCodeJson'] != null && row['comCodeJson'] != ''){
						let comCodeJson = JSON.parse(row['comCodeJson']);
						let comDesc = comCodeJson?.filter(v => v.ETC_1 === 'moldingMethod')[0].COMMON_DESC;
						
						if(comDesc == 'Y'){
							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						} else {
							return '-';
						}
					} else {
						return '-';
					}
				}
			},//성형방식
			{ data : 'moldingContents', className : 'text-center align-middle', name : 'moldingContents',
				render: function(data, type, row, meta) {
					if(data != null && data != '' && row['comCodeJson'] != null && row['comCodeJson'] != ''){
						let comCodeJson = JSON.parse(row['comCodeJson']);
						let comDesc = comCodeJson?.filter(v => v.ETC_1 === 'moldingContents')[0].COMMON_DESC;
						
						if(comDesc == 'Y'){
							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						} else {
							return '-';
						}
					} else {
						return '-';
					}
				}
			},//성형내용
			{ data : 'itemSize', className : 'text-center align-middle', name : 'itemSize',
				render: function(data, type, row, meta) {
					if(data != null && data != '' && row['comCodeJson'] != null && row['comCodeJson'] != ''){
						let comCodeJson = JSON.parse(row['comCodeJson']);
						let comDesc = comCodeJson?.filter(v => v.ETC_1 === 'itemSize')[0].COMMON_DESC;
						
						if(comDesc == 'Y'){
							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						} else {
							return '-';
						}
					} else {
						return '-';
					}
				}
			},//사이즈
			{ data : 'knifeTipSize', className : 'text-center align-middle', name : 'knifeTipSize',
				render: function(data, type, row, meta) {
					if(data != null && data != '' && row['comCodeJson'] != null && row['comCodeJson'] != ''){
						let comCodeJson = JSON.parse(row['comCodeJson']);
						let comDesc = comCodeJson?.filter(v => v.ETC_1 === 'knifeTipSize')[0].COMMON_DESC;
						
						if(comDesc == 'Y'){
							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						} else {
							return '-';
						}
					} else {
						return '-';
					}
				}
			},//칼끝규격
			{ data : 'woodenWdCd', className : 'text-center align-middle', name : 'woodenWdCd',
				render: function(data, type, row, meta) {
					if(data != null && data != '' && row['comCodeJson'] != null && row['comCodeJson'] != ''){
						let comCodeJson = JSON.parse(row['comCodeJson']);
						let comDesc = comCodeJson?.filter(v => v.ETC_1 === 'woodenWdCd')[0].COMMON_DESC;
						
						if(comDesc == 'Y'){
							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						} else {
							return '-';
						}
					} else {
						return '-';
					}
				}
			},//목형번호
			{ data : 'resinBoardWdCd', className : 'text-center align-middle', name : 'resinBoardWdCd',
				render: function(data, type, row, meta) {
					if(data != null && data != '' && row['comCodeJson'] != null && row['comCodeJson'] != ''){
						let comCodeJson = JSON.parse(row['comCodeJson']);
						let comDesc = comCodeJson?.filter(v => v.ETC_1 === 'resinBoardWdCd')[0].COMMON_DESC;
						
						if(comDesc == 'Y'){
							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						} else {
							return '-';
						}
					} else {
						return '-';
					}
				}
			},//수지판번호
			{ data : 'pressMethod', className : 'text-center align-middle', name : 'pressMethod',
				render: function(data, type, row, meta) {
					if(data != null && data != '' && row['comCodeJson'] != null && row['comCodeJson'] != ''){
						let comCodeJson = JSON.parse(row['comCodeJson']);
						let comDesc = comCodeJson?.filter(v => v.ETC_1 === 'pressMethod')[0].COMMON_DESC;
						
						if(comDesc == 'Y'){
							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						} else {
							return '-';
						}
					} else {
						return '-';
					}
				}
			},//동판번호
			{ data : 'equipNm', className : 'text-center align-middle', name : 'equipNm',
				render: function(data, type, row, meta) {
					if(data != null && data != '' && row['comCodeJson'] != null && row['comCodeJson'] != ''){
						let comCodeJson = JSON.parse(row['comCodeJson']);
						let comDesc = comCodeJson?.filter(v => v.ETC_1 === 'equipNm')[0].COMMON_DESC;
						
						if(comDesc == 'Y'){
							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
						} else {
							return '-';
						}
					} else {
						return '-';
					}
				}
			},//인쇄설비
			{ data : 'outReqDate', className : 'text-center align-middle', name : 'outReqDate',
				render: function(data, type, row, meta) {
					if(data != null && data != '' && row['comCodeJson'] != null && row['comCodeJson'] != ''){
						let comCodeJson = JSON.parse(row['comCodeJson']);
						let comDesc = comCodeJson?.filter(v => v.ETC_1 === 'outReqDate')[0].COMMON_DESC;
						
						if(comDesc == 'Y'){
							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data).format('YYYY-MM-DD')+'</div>';
						} else {
							return '-';
						}
					} else {
						return '-';
					}
				}
			},//출고요청일
		],
		columnDefs : [
			/*{
				targets: '_all',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},*/
// 			{ "targets": [0], "orderable": false },
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
			let theadHeight = parseFloat($('#workOrderPrcssTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 80)+'px');
			 
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAll').off('keyup',function() {});
			$('#searchAll').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			});
			
			$('#my-spinner').fadeIn(25, function() {
	
				let rowData = api.rows({'page':'current'}).data().toArray();
				if(rowData.length != 0){
				
					for(var i = 0; i < rowData.length ; i++){
						//다음공정이없고 생산량이 수주량보다 작은경우 -> 마지막공정에 생산량 미달
						/* if( rowData[i].progressStatus == 'WC'
							&& (rowData[i].prcssNextIdx == null || rowData[i].prcssNextIdx == '')
							&& (rowData[i].fairQty < rowData[i].bizOrdQty) ){
							let node = api.row('#'+rowData[i].workOrdPrcssIdx).node();
							//$(node).addClass('bg-danger bg-gradient');
							$(node).css('background-color','#ffb4b4');
							
						} */

						//작업지시미발행인경우
						if(rowData[i].workOrdNo == 'biz'){
							let node = api.row('#'+rowData[i].workOrdPrcssIdx).node();
							$(node).addClass('fw-bolder');
							$(node).addClass('notSelect');
							$(node).css('background-color','rgb(255 207 244)');
						}
						
						
						if(rowData[i].ordGubun == '20'){
							let node = api.row('#'+rowData[i].workOrdPrcssIdx).node();
							$(node).addClass('fw-bolder');
							$(node).css('background-color','#FFF2CC');
						}
						
						//금일 작업유무 Y일 경우 하늘색 표시
						if(rowData[i].todayWorkYn == 'O'){
							let node = api.row('#'+rowData[i].workOrdPrcssIdx).node();
							$(node).addClass('fw-bolder');
							$(node).css('background-color','#87CEEB');
						}

						//컴펌대기,수주중지 일 경우
						if((rowData[i].confirmDesign != 'Y' && rowData[i].bizStatusCd !='03') || rowData[i].bizStopYn=="Y"){
							let node = api.row('#'+rowData[i].workOrdPrcssIdx).node();
							$(node).addClass('fw-bolder');
							$(node).css('background-color','#fadcdc');
						}

						//생산지시량보다 생산수량+불량수량이 적은 경우 -> 빨간셀로 표기해달라함
						/* let workOrdQty = isEmptyCheck(rowData[i].workOrdQty) ? 0 : parseInt(rowData[i].workOrdQty);
						let fairQty = isEmptyCheck(rowData[i].fairQty) ? 0 : parseInt(rowData[i].fairQty);
						let faultyQty = isEmptyCheck(rowData[i].faultyQty) ? 0 : parseInt(rowData[i].faultyQty);
						if( workOrdQty > fairQty + faultyQty && fairQty > 0 ){
							let tr = $('#workOrderPrcssTable tbody').find('tr').eq(i);
							let colIndex = workOrderPrcssTable.column('fairQty:name').index(); 
							$(tr).find('td').eq(colIndex).attr('style','background-color: #ffb4b4 !important;');
							colIndex = workOrderPrcssTable.column('faultyQty:name').index(); 
							$(tr).find('td').eq(colIndex).attr('style','background-color: #ffb4b4 !important;');
						} */
						
					}				
				
					// 모든 열(Column) 다시 보이게 하기
					workOrderPrcssTable.columns().visible(true);
					
					let prcssCdMap = _.map(rowData, 'prcssCd');
					let prcssCdUniqueArray = _.uniq(prcssCdMap);

					let commonCodeString = '';
					for(var i = 0; i < prcssCdUniqueArray.length; i++){
						if(prcssCdAndComCode[prcssCdUniqueArray[i]] != undefined){
							commonCodeString += prcssCdAndComCode[prcssCdUniqueArray[i]] + ',';
						}
					}
					commonCodeString = commonCodeString.slice(0,-1);

					$.ajax({
						url: '<c:url value="/sm/commonCodeDtlLstByCommonCdString"/>',
			            type: 'POST',
			            async: false,
			            data: {
			                'commonType'	:	function(){ return '시스템'; },
			                'commonCd'		:	function(){ return commonCodeString; },
			            },
			            beforeSend: function() {
			            	$('#my-spinner').show();
			            },
						success : function(res) {
							if (res.result == "ok") { //응답결과
								let data = res.data;
								//dataMap
								let dataMap = data.map(v => ({  ETC1: v.etc1, COMMON_DESC: v.commonDesc }));
								//컬럼리스트
								let columnLst = _.uniqBy(dataMap, v=> v.ETC1);
								let hideColIndex = '';
								for( var i = 0; i < columnLst.length; i++){
									let columnNm = columnLst[i].ETC1;

									//컬럼이름과 컬럼이 보여지는 여부가 Y인걸 검색했을 때 0보다 클 경우 해당 열은 숨길필요 X
									let filterLst = _.filter(dataMap, v=> v.ETC1 == columnNm && v.COMMON_DESC == 'Y')

									if(filterLst.length == 0){
										hideColIndex += workOrderPrcssTable.column(columnNm+':name').index() + ',';
									}
								}
								hideColIndex = hideColIndex.slice(0,-1);
								if(hideColIndex != ''){
									workOrderPrcssTable.columns( hideColIndex ).visible( false );
								}
								$('#my-spinner').hide();
							} else if(res.result == 'fail') { 
								toastr.warning(res.message);
							} else {
								toastr.error(res.message);
							}
						}
					});
				}
				if(filterObj != null && filterObj != ''){
					$(filterObj).focus();
				}
				try{
					workOrderPrcssTable.columns.adjust();
					$('#my-spinner').hide();
				} catch(e){
					//console.log('테이블 생성전');
				} finally {
					$('#my-spinner').hide();
				}
				
			});
		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#workOrderPrcssTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();
				if(colIdx > 0){
					$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
					$(cell).css('padding','2px');
				} else {
					$(cell).html('');
					$(cell).css('padding','2px');
				}
				let cursorPosition = '';
				
				// On every keypress in this input
				$('#workOrderPrcssTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					filterObj = this;
					clearTimeout(timer);
					timer = setTimeout(function(){
						$('#my-spinner').fadeIn(25, function() {
							api.column(colIdx).search(filterObj.value, false, false, true).draw();
							//toastr.success('a');
						});
					}, 1000);
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				}); 
			});
			api.button(3).trigger();
		},
	});
	// dataTable colReorder event
	workOrderPrcssTable.on('column-reorder', function( e, settings, details ) {
		let api = workOrderPrcssTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#workOrderPrcssTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				filterObj = this;
				$('#my-spinner').fadeIn(50, function() {
					api.column(colIdx).search(filterObj.value, false, false, true).draw();
				});
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	let itemIdx = '';
	let bodIdx = '';
	$('#workOrderPrcssTable tbody').on('click','tr', function() {
		let data = workOrderPrcssTable.row(this).data();
		if( data.workOrdPrcssIdx.includes("BIZ") ){
			//toastr.warning('작업지시 대기인 항목은<br>클릭 할 수 없습니다.');
		} else {
			workOrdIdx = data.workOrdIdx;
			workOrdPrcssIdxVal = data.workOrdPrcssIdx;
			itemIdx = data.itemIdx;
			bodIdx = data.bizOrdDtlIdx;
			//workOrdPrcssStatusTable.ajax.reload();
			workPrcssDtlTable.ajax.reload();
			inputMaterialHistTable.ajax.reload();
		}
	});
	
	$('#workOrderPrcssModal').on('shown.bs.modal', function () {
		$('#my-spinner').show();

		let modalHeight = parseInt($('#workOrderPrcssModal').find('.modal-content').css('width'));
		//0.12345 <- 0.1fr 0.5fr 1fr 3.5fr 3fr 이렇게있으면 1fr % 비율
		let modalHeightMatrl = parseInt(0.055 * modalHeight);
		let modalHeightWork = parseInt(0.115 * modalHeight);
	    
		let theadHeight = parseInt($('#purchaseMatrlModalTable_wrapper').find('.dataTables_scrollHead').css('height'));
		$('#purchaseMatrlModalTable_wrapper').find('.dataTables_scrollBody').css('height',(modalHeightMatrl - theadHeight )+'px');
		$('#purchaseMatrlModalTable_wrapper').css('height','100%');

		theadHeight = parseInt($('#workResultListTable_wrapper').find('.dataTables_scrollHead').css('height'));
		//$('#workResultListTable_wrapper').find('.dataTables_scrollBody').css('height',(modalHeightWork - theadHeight )+'px');
		$('#workResultListTable_wrapper').find('.dataTables_scrollBody').css('height','97px');
		
		$('#workResultListTable_wrapper').css('height','100%');
		
		setTimeout(function(){
			purchaseMatrlModalTable.columns.adjust();
			workResultListTable.columns.adjust().draw();
			$('#my-spinner').hide();
		},100);
		
		//for(var i = 0; i<100;i++){
		//	setTimeout(function(){
		//		purchaseMatrlModalTable.columns.adjust();
		//		workResultListTable.columns.adjust();
		//		},200);
		//}
		
		/* $('#workMethodMultiSelect').select2({
    		data: JSON.parse(workMethodJson),
    		multiple : true,
    		placeholder: "",
    	});
		$('#workMethodMultiSelect').next().css('width','80%');
		$('#workMethodMultiSelect').find('span').eq(0).css('width','70%');
		$('#workMethodMultiSelect').find('.select2-search__field').css('width','70%');
		$('#workMethodMultiSelect').find('.select2-selection__rendered').attr('style','display:flex; align-content:flex-start; flex-direction:column; flex-wrap:wrap; overflow:auto;');
    	
		if(workMethod != null && workMethod != ''){
			let splitData = workMethod.split(',');
			$('#workMethodMultiSelect').val(splitData).trigger('change');
		}
		$('#workMethodMultiSelect').trigger('change'); */
		//setTimeout(function() {
			//workOrdPrcssResultTable.columns.adjust();
		//	purchaseMatrlModalTable.columns.adjust();
		//	workResultListTable.columns.adjust();
		//}, 500);
	});

	$('#workOrderPrcssBundleModal').on('shown.bs.modal',function(){
		inputBundleModalTable.draw(false).columns.adjust();
		workOrdPrcssResultTableBundle.draw(false).columns.adjust();

	});
	
	
	//더블클릭
	$('#workOrderPrcssTable tbody').on('dblclick','tr', function() {
		let data = workOrderPrcssTable.row(this).data();
		if( data.workOrdPrcssIdx.includes("BIZ") ){
			toastr.warning('작업지시 대기인 항목은<br>조회 할 수 없습니다.');
		} else {
			workOrdIdx = data.workOrdIdx;
			workOrdPrcssIdxVal = data.workOrdPrcssIdx;
			itemIdx = data.itemIdx;
			bodIdx = data.bizOrdDtlIdx;
			workOrdIdx = data.workOrdIdx;
			bizOrdDtlIdxVal = data.bizOrdDtlIdx;
			workOrdPrcssIdx = data.workOrdPrcssIdx;
			//전 공정들이 다 작업되었는지 체크
			$.ajax({
				url: '<c:url value="/wm/checkWorkOrdPrcssFinish"/>',
	            type: 'POST',
	            data: {
	                'workOrdIdx'	  :	function(){ return data.workOrdIdx; },
					'workOrdPrcssIdx' : function(){ return data.workOrdPrcssIdx; },
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if(res.result == 'ok'){
						let data = res.data;

						if(data.beforePrcssDesc != '' && data.beforePrcssDesc != null && data.descCheckYn != 'Y'){
							//toastr.warning('전공정 특이사항을 읽은 후<br>작업해주세요.');
						} 
						if(data.resultPageNm == 'workOrderPrcssBundleModal'){
							workOrdPrcssResultModal(data,'Bundle','open');
						} else {
							workOrdPrcssResultModal(data,'','open');
						}
						
						//공정이 대기,완료인경우 -> 버튼 비활성화 , 공정이 진행중인 경우 -> 버튼 활성화
						//대기
						if(data.progressStatus == 'PI'){
							workInputDisabled(true);
							$('#workOrdBeforePrcssDescCheck').attr('disabled',false);
							$('#workOrdBeforePrcssDescCheckBundle').attr('disabled',false);
						} else if(data.progressStatus == 'WI'){//진행
							workInputDisabled(false);
							$('#workOrdBeforePrcssDescCheck').attr('disabled',true);
							$('#workOrdBeforePrcssDescCheckBundle').attr('disabled',true);
						} else if(data.progressStatus == 'WC'){//완료
							workInputDisabled(true);
							$('#workOrdBeforePrcssDescCheck').attr('disabled',true);
							$('#workOrdBeforePrcssDescCheckBundle').attr('disabled',true);
						}
						
					} else if(res.result == 'fail') {
						toastr.warning(res.message);
						workOrderPrcssTable.ajax.reload(function(){},false);
					} else {
						toastr.error(res.message);
					}
					$('#my-spinner').hide();
				}
			});
		}
	}); 

	//작업시작버튼 클릭
	$('#btnWorkStart, #btnWorkStartBundle').on('click',function(){
		let btnGubun = $(this).attr('id');
		let data = workOrderPrcssTable.row('.selected').data();
		//현 공정의 상태값 체크
		$.ajax({
			url: '<c:url value="/wm/workOrdSelWithPrcss"/>',
            type: 'POST',
            data: {
            	'workOrdIdx'	  :	function(){ return data.workOrdIdx; },
 				'workOrdPrcssIdx' : function(){ return data.workOrdPrcssIdx; },
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if(res.result == 'ok'){
					let data = res.data;
					//현공정이 대기인경우 -> 작업시작, 공정이 진행,완료중인 경우 -> 이미 진행중 toastr
					if(data.progressStatus == 'WI'){//진행
						if(btnGubun == 'btnWorkStartBundle'){
							workOrderModalDisabled(data,'Bundle',false);
						} else {
							workOrderModalDisabled(data,'',false);
						}

						toastr.warning('이미 진행중인 공정입니다.');
						
					} else if(data.progressStatus == 'WC'){//완료
						toastr.warning('이미 작업완료된 공정입니다.');
					} else if(data.progressStatus == 'PI'){//대기
						//작업시작
						$.ajax({
							url: '<c:url value="/wm/workOrdPrcssStart"/>',
				            type: 'POST',
				            data: {
				            	'workOrdIdx'	  :	function(){ return data.workOrdIdx; },
				 				'workOrdPrcssIdx' : function(){ return data.workOrdPrcssIdx; },
				            },
				            beforeSend: function() {
				            	$('#my-spinner').show();
				            },
				            success : function(res) {
				            	if(res.result == 'ok'){
									let data = res.data;
									toastr.success('공정이 시작되었습니다.');
									if(btnGubun == 'btnWorkStartBundle'){
										workOrderModalDisabled(data,'Bundle',false);
										$('#workQtyBundle').attr('disabled',false);
										$('#workQtyBundle').focus();
										$('#workQtyBundle').trigger('click'); //가상키보드 입력 안되는 오류 수정 - 2023.10.06
									} else {
										workOrderModalDisabled(data,'',false);
										$('#workQty').attr('disabled',false);
										$('#workQty').focus();
										$('#workQty').trigger('click'); //가상키보드 입력 안되는 오류 수정 - 2023.10.06
									}

									$('#workStartTime'+name).val(moment(data.workTime,'YYYYMMDD HHmm').format('YYYY-MM-DD HH:mm'));
					            	$('#workOrdBeforePrcssDescCheck').attr('disabled',true);
					            	$('#workOrdBeforePrcssDescCheckBundle').attr('disabled',true);
				            	} else if(res.result == 'fail') {
									toastr.warning(res.message);
								} else {
									toastr.error(res.message);
								}
				            	$('#my-spinner').hide();
				            }
						});
					}
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
	});

	//작업저장버튼 클릭
	$('#btnWorkSave').on('click',function(){
		let data = workOrderPrcssTable.row('.selected').data();
		/* if( data.progressStatus == 'PI'){
			toastr.warning('공정이 대기상태입니다.<br>작업 시작 후 다시 시도해주세요.');
			return false;
		}
		if( data.progressStatus == 'WC'){
			toastr.warning('이미 작업완료된 공정입니다.');
			return false;
		} */
		
		//if( $('#workDate').val() == '' || $('#workDate').val() == null ){
		//	toastr.warning('작업일자를 선택해주세요.');
		//	$('#workDate').focus();
		//	return false;
		//}
		/* if( $('#workStartTime').val() == '' || $('#workStartTime').val() == null ){
			toastr.warning('시작시간을 선택해주세요.');
			$('#workStartTime').focus();
			return false;
		}
		if( $('#workEndTime').val() == '' || $('#workEndTime').val() == null ){
			toastr.warning('종료시간을 선택해주세요.');
			$('#workEndTime').focus();
			return false;
		} */
		let workOrdQtyVal = parseInt(workOrderPrcssTable.row('.selected').data().workOrdQty);
		
		if( $('#workQty').val() == '' || ( $('#workQty').val() == '0' /* && workOrdQtyVal != '0' */ )){
			toastr.warning('작업량을 입력해주세요.');
			$('#workQty').focus();
			return false;
		}
		if( $('#workFaultyQty').val() == '' ){
			toastr.warning('불량을 입력해주세요.');
			$('#workFaultyQty').focus();
			return false;
		}
		let equalsTargetVal = 0;
		let addCuttingVal = isEmptyCheck(workOrderPrcssTable.row('.selected').data().addCutting) ? 0 : workOrderPrcssTable.row('.selected').data().addCutting;
		let addCutting = parseInt(addCuttingVal);
		//작업공정의 단위와 전공정실적단위가 같다면 전공정실적 비교 / 다르다면 지시수량으로 비교
		if( $('#workPrcssQtyUnit').val().replaceAll(/[0-9]/gi,'') == $('#workOrdBeforePrcssQty').text().replaceAll(',','').replaceAll(/[0-9]/gi,'') ){
			equalsTargetVal = parseFloat(removeCommas($('#workOrdBeforePrcssQty').text().replaceAll(',','').replaceAll(/[^0-9]/gi,'')));
			//전공정실적 + 추가재단 수량 반영되어야함
			equalsTargetVal += addCutting;
		} else {
			equalsTargetVal = parseFloat(removeCommas($('#workOrdQty').text().replaceAll(',','')));
		}

		if(equalsTargetVal < parseFloat(removeCommas($('#workQty').val())) + parseFloat(removeCommas($('#workFaultyQty').val())) ){
			toastr.warning('지시수량을 초과했습니다.');
			$('#workQty').focus();
			return false;
		}
			
		let saveType = '';
		let workOrdResultIdx = '';
		
		
		let popupPrcssData = workResultListTable.row('#'+workOrdPrcssIdx).data();
		let popupPrcssCalOrdQty = isEmptyCheck(popupPrcssData.calOrdQty) ? 0 : parseInt(popupPrcssData.calOrdQty)	//정매수
		let popupPrcssBizOrdQty = isEmptyCheck(workOrderPrcssTable.row('.selected').data().bizOrdQty) ? 0 : parseInt(workOrderPrcssTable.row('.selected').data().bizOrdQty); //수주수량
		let popupPrcssUnitNm = popupPrcssData.produceQtyUnitNm;	//작업단위
		let popupWorkQty = parseFloat(removeCommas($('#workQty').val())) + parseFloat(removeCommas($('#workFaultyQty').val())); //작업량+불량수량

		console.log("정매수(popupPrcssCalOrdQty):"+popupPrcssCalOrdQty)
		console.log("수주수량(popupPrcssBizOrdQty):"+popupPrcssBizOrdQty)
		console.log("작업단위(popupPrcssUnitNm):"+popupPrcssUnitNm)
		console.log("작업량+불량수량(popupWorkQty):"+popupWorkQty)

		//이전 소스코드 시작---------
		//let calOrdQtyVal = isEmptyCheck(workOrderPrcssTable.row('.selected').data().calOrdQty) ? 0 : parseInt(workOrderPrcssTable.row('.selected').data().calOrdQty);
		//계산된 정매수 보다 실적수량이 적을 경우
		//if( calOrdQtyVal > parseFloat(removeCommas($('#workQty').val())) + parseFloat(removeCommas($('#workFaultyQty').val()))){
		//이전 소스코드 종료---------
		
		//작업단위 통인경우 = 정매수보다 입력된 생산량이 적을경우
		//작업단위 매인경우 = 수주량보다 입력된 생산량이 적을경우
		if((popupPrcssUnitNm == "매" && (popupPrcssBizOrdQty>popupWorkQty))
				|| (popupPrcssUnitNm != '매' && (popupPrcssCalOrdQty>popupWorkQty))){
			showWorkResultWarningModal()
			.then(function() {
				if(workResultListTable.row('.selected').data() == undefined){
					saveType = 'insert';
					workOrdResultIdx = '0';
				} else {
					saveType = 'update';
					workOrdResultIdx = workResultListTable.row('.selected').data().idx;
				}
				//공정실적등록
				$.ajax({
					url: '<c:url value="/wm/workOrdPrcssResultSave"/>',
		            type: 'POST',
		            data: {
		                'workOrdIdx'		:	function(){ return data.workOrdIdx; },
						'workOrdPrcssIdx'	:	function(){ return data.workOrdPrcssIdx; },
		                'prcssIdx'			:	function(){ return data.prcssIdx; },
						'prcssOrder'		:	function(){ return data.prcssOrder; },
		                'workDate'			:	function(){ return moment().format('YYYYMMDD'); },
		                'workStartTime'		:	function(){ return $('#workStartTime').val().replaceAll('-','').replaceAll(':','').replaceAll('T',' '); },
		                'workEndTime'		:	function(){ return $('#workEndTime').val().replaceAll('-','').replaceAll(':','').replaceAll('T',' '); },
		                'fairQty'			:	function(){ return $('#workQty').val().replaceAll(',',''); },
		                'faultyQty'			:	function(){ return $('#workFaultyQty').val().replaceAll(',',''); },
		                'workAddCuttingQty'	:	function(){ return $('#workAddCuttingQty').val().replaceAll(',',''); },
		                'faultyReason'		:	function(){ return $('#faultyReason').val(); },
		                'prcssDesc'			:	function(){ return $('#fieldDesc').val(); },
		                'saveType'			:	function(){ return saveType; },
		                'workOrdResultIdx'	:	function(){ return workOrdResultIdx; },
		            },
		            beforeSend: function() {
		            	$('#my-spinner').show();
		            },
		            success : function(res) {
		            	if(res.result == 'ok'){
							toastr.success('공정 실적이 등록되었습니다.');
							workResultListTable.rows('.selected').deselect();
							workResultListTable.ajax.reload();
							workOrderPrcssTable.ajax.reload(function(){
			            		setTimeout(function() {
			            			workOrderPrcssTable.row('#'+data.workOrdPrcssIdx).select();
									$(workOrderPrcssTable.row('#'+data.workOrdPrcssIdx).node()).trigger('click'); // 선택처리
								}, 100)
			            	});
							//workOrdPrcssStatusTable.ajax.reload();
							purchaseMatrlModalTable.ajax.reload();
							//workPrcssDtlTable.ajax.reload();

							//workPrcssCheckAndReload();
							
		            	} else if(res.result == 'fail') {
							toastr.warning(res.message);
							purchaseMatrlModalTable.ajax.reload();
						} else {
							toastr.error(res.message);
						}
		            	$('#my-spinner').hide();
		            }
				});		
			})
			.catch(function() {
				$('#my-spinner').hide();
			});
		} else {
			if(workResultListTable.row('.selected').data() == undefined){
				saveType = 'insert';
				workOrdResultIdx = '0';
			} else {
				saveType = 'update';
				workOrdResultIdx = workResultListTable.row('.selected').data().idx;
			}
			//공정실적등록
			$.ajax({
				url: '<c:url value="/wm/workOrdPrcssResultSave"/>',
	            type: 'POST',
	            data: {
	                'workOrdIdx'		:	function(){ return data.workOrdIdx; },
					'workOrdPrcssIdx'	:	function(){ return data.workOrdPrcssIdx; },
	                'prcssIdx'			:	function(){ return data.prcssIdx; },
					'prcssOrder'		:	function(){ return data.prcssOrder; },
	                'workDate'			:	function(){ return moment().format('YYYYMMDD'); },
	                'workStartTime'		:	function(){ return $('#workStartTime').val().replaceAll('-','').replaceAll(':','').replaceAll('T',' '); },
	                'workEndTime'		:	function(){ return $('#workEndTime').val().replaceAll('-','').replaceAll(':','').replaceAll('T',' '); },
	                'fairQty'			:	function(){ return $('#workQty').val().replaceAll(',',''); },
	                'faultyQty'			:	function(){ return $('#workFaultyQty').val().replaceAll(',',''); },
	                'workAddCuttingQty'	:	function(){ return $('#workAddCuttingQty').val().replaceAll(',',''); },
	                'faultyReason'		:	function(){ return $('#faultyReason').val(); },
	                'prcssDesc'			:	function(){ return $('#fieldDesc').val(); },
	                'saveType'			:	function(){ return saveType; },
	                'workOrdResultIdx'	:	function(){ return workOrdResultIdx; },
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
	            success : function(res) {
	            	if(res.result == 'ok'){
						toastr.success('공정 실적이 등록되었습니다.');
						workResultListTable.rows('.selected').deselect();
						workResultListTable.ajax.reload();
						workOrderPrcssTable.ajax.reload(function(){
		            		setTimeout(function() {
		            			workOrderPrcssTable.row('#'+data.workOrdPrcssIdx).select();
								$(workOrderPrcssTable.row('#'+data.workOrdPrcssIdx).node()).trigger('click'); // 선택처리
							}, 100)
		            	});
						//workOrdPrcssStatusTable.ajax.reload();
						purchaseMatrlModalTable.ajax.reload();
						//workPrcssDtlTable.ajax.reload();

						//workPrcssCheckAndReload();
						
	            	} else if(res.result == 'fail') {
						toastr.warning(res.message);
						purchaseMatrlModalTable.ajax.reload();
					} else {
						toastr.error(res.message);
					}
	            	$('#my-spinner').hide();
	            }
			});		
		}
	});

	//번들링작업저장버튼 클릭
	$('#btnWorkSaveBundle').on('click',function(){
		let data = workOrderPrcssTable.row('.selected').data();
		if( data.progressStatus == 'PI'){
			toastr.warning('공정이 대기상태입니다.<br>작업 시작 후 다시 시도해주세요.');
			return false;
		}
		if( data.progressStatus == 'WC'){
			toastr.warning('이미 작업완료된 공정입니다.');
			return false;
		}
		
		if( $('#workDateBundle').val() == '' || $('#workDateBundle').val() == null ){
			toastr.warning('작업일자를 선택해주세요.');
			$('#workDateBundle').focus();
			return false;
		}
		if( $('#workStartTimeBundle').val() == '' || $('#workStartTimeBundle').val() == null ){
			toastr.warning('시작시간을 선택해주세요.');
			$('#workStartTimeBundle').focus();
			return false;
		}
		if( $('#workEndTimeBundle').val() == '' || $('#workEndTimeBundle').val() == null ){
			toastr.warning('종료시간을 선택해주세요.');
			$('#workEndTimeBundle').focus();
			return false;
		}
		if( $('#workQtyBundle').val() == '' || $('#workQtyBundle').val() == '0'){
			toastr.warning('작업량을 입력해주세요.');
			$('#workQtyBundle').focus();
			return false;
		}
		if( $('#workFaultyQtyBundle').val() == '' ){
			toastr.warning('불량을 입력해주세요.');
			$('#workFaultyQtyBundle').focus();
			return false;
		}
		/* let equalsTargetVal = 0;
		//작업공정의 단위와 전공정실적단위가 같다면 전공정실적 비교 / 다르다면 지시수량으로 비교
		if( $('#workPrcssQtyUnitBundle').val().replaceAll(/[0-9]/gi,'') == $('#workOrdBeforePrcssQtyBundle').text().replaceAll(',','').replaceAll(/[0-9]/gi,'') ){
			equalsTargetVal = parseFloat(removeCommas($('#workOrdBeforePrcssQtyBundle').text().replaceAll(',','').replaceAll(/[^0-9]/gi,'')));
		} else {
			equalsTargetVal = parseFloat(removeCommas($('#workOrdQtyBundle').text().replaceAll(',','')));
		}

		if(equalsTargetVal < parseFloat(removeCommas($('#workQtyBundle').val())) + parseFloat(removeCommas($('#workFaultyQtyBundle').val())) ){
			toastr.warning('지시수량을 초과했습니다.');
			$('#workQtyBundle').focus();
			return false;
		} */
			
		let saveType = '';
		let workOrdResultIdx = '';
		if(workOrdPrcssResultTableBundle.row('.selected').data() == undefined){
			saveType = 'insert';
			workOrdResultIdx = '0';
		} else {
			saveType = 'update';
			workOrdResultIdx = workOrdPrcssResultTableBundle.row('.selected').data().idx;
		}
		
		let array = [];
		let state = true;
		//투입수량 정보
		if(inputBundleModalTable.data().length > 0){
			$('#inputBundleModalTable tbody').find('tr').each(function(index, item) {
				let td = $(item).find('td');
				let data = inputBundleModalTable.row($(item)).data();
				let node = inputBundleModalTable.row($(item)).node();
	
				let inputQty = $(node).find('td').eq(inputBundleModalTable.column('inputQty:name').index()).find('input[name=inputQty]').val();
	
				let workQty = parseFloat(removeCommas($('#workQtyBundle').val()));
				let workFaultyQty = parseFloat(removeCommas($('#workFaultyQtyBundle').val()));
				
				if(inputQty == '') {
					toastr.warning('투입수량을 입력해주세요.');
					$(node).find('td').eq(inputBundleModalTable.column('inputQty:name').index()).find('input[name=inputQty]').focus();
					state = false;
					return false;
				}
				//해당 투입수량이 작업량+불량보다 수량이 적을 경우
				if(inputQty < workQty+workFaultyQty){
					toastr.warning('작업 수량보다 투입수량이 작습니다.<br>투입수량을 확인해주세요.');
					$(node).find('td').eq(inputBundleModalTable.column('inputQty:name').index()).find('input[name=inputQty]').focus();
					state = false;
					return false;
				}
				
				let obj = new Object();
				obj.itemIdx = data.itemIdx;
				obj.inputQty = removeCommas(inputQty);
				array.push(obj);
				
			});
		} else {
			toastr.warning('번들링 제품을 확인해주세요.');
			state = false;
			return false;
		}
		if(state){
			//공정실적등록
			$.ajax({
				url: '<c:url value="/wm/workOrdPrcssResultSaveBundle"/>',
	            type: 'POST',
	            data: {
	                'workOrdIdx'		:	function(){ return data.workOrdIdx; },
					'workOrdPrcssIdx'	:	function(){ return data.workOrdPrcssIdx; },
	                'prcssIdx'			:	function(){ return data.prcssIdx; },
					'prcssOrder'		:	function(){ return data.prcssOrder; },
	                'workDate'			:	function(){ return $('#workDateBundle').val().replaceAll('-',''); },
	                'workStartTime'		:	function(){ return $('#workStartTimeBundle').val().replaceAll('-','').replaceAll(':','').replaceAll('T',' '); },
	                'workEndTime'		:	function(){ return $('#workEndTimeBundle').val().replaceAll('-','').replaceAll(':','').replaceAll('T',' '); },
	                'fairQty'			:	function(){ return $('#workQtyBundle').val().replaceAll(',',''); },
	                'faultyQty'			:	function(){ return $('#workFaultyQtyBundle').val().replaceAll(',',''); },
	                'faultyReason'		:	function(){ return $('#faultyReasonBundle').val(); },
	                'prcssDesc'			:	function(){ return $('#fieldDescBundle').val(); },
	                'saveType'			:	function(){ return saveType; },
	                'workOrdResultIdx'	:	function(){ return workOrdResultIdx; },
	                'inputQtyJson'		:	function(){ return JSON.stringify(array); },
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
	            success : function(res) {
	            	if(res.result == 'ok'){
						toastr.success('공정 실적이 등록되었습니다.');
						workOrdPrcssResultTableBundle.rows('.selected').deselect();
						workOrdPrcssResultTableBundle.ajax.reload();
						workOrderPrcssTable.ajax.reload(function(){
		            		setTimeout(function() {
		            			workOrderPrcssTable.row('#'+data.workOrdPrcssIdx).select();
								$(workOrderPrcssTable.row('#'+data.workOrdPrcssIdx).node()).trigger('click'); // 선택처리
							}, 100)
		            	});
						inputBundleModalTable.ajax.reload(function(){
							$(inputBundleModalTable.nodes()).find('td').find('input[name=inputQty]').attr('disabled',false);
							$(inputBundleModalTable.nodes()).find('td').find('input[name=inputQty]').val($('#workOrdQtyBundle').text());
						});
						//workOrdPrcssStatusTable.ajax.reload();
						purchaseMatrlModalTable.ajax.reload();
						//workPrcssDtlTable.ajax.reload();
						//workPrcssCheckAndReload();
	            	} else if(res.result == 'fail') {
						toastr.warning(res.message);
						inputBundleModalTable.ajax.reload(function(){
							$(inputBundleModalTable.nodes()).find('td').find('input[name=inputQty]').attr('disabled',false);
							$(inputBundleModalTable.nodes()).find('td').find('input[name=inputQty]').val($('#workOrdQtyBundle').text());
						});
					} else {
						toastr.error(res.message);
					}
	            	$('#my-spinner').hide();
	            }
			});		
		}
	});
	
	//작업완료 클릭
	$('#btnWorkEnd, #btnWorkEndBundle').on('click',function(){
		$('#workEndModal').data('type',$(this).attr('id'))
		$('#workEndModal').modal('show');
	});
	let packUnit = '';
	$('#btnWorkEndModalY').on('click',function(){
		let type = $('#workEndModal').data('type');
		let data = workOrderPrcssTable.row('.selected').data();
		packUnit = '';
		if(type == 'btnWorkEnd'){
			packUnit = $('#packUnit').val();
		} else if(type == 'btnWorkEndBundle'){
			packUnit = $('#packUnitBundle').val();
		}
		//현 공정의 상태값 체크
		$.ajax({
			url: '<c:url value="/wm/workOrdSelWithPrcss"/>',
            type: 'POST',
            data: {
            	'workOrdIdx'	  	:	function(){ return data.workOrdIdx; },
 				'workOrdPrcssIdx' 	:	function(){ return data.workOrdPrcssIdx; },
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if(res.result == 'ok'){
					let data = res.data;
					//현공정이 대기,완료인경우 -> toastr, 공정이 진행인 경우 -> 작업완료처리
					if(data.progressStatus == 'WI'){//진행
						//작업완료
						$.ajax({
							url: '<c:url value="/wm/workOrdPrcssEnd"/>',
				            type: 'POST',
				            data: {
				            	'workOrdIdx'	  :	function(){ return data.workOrdIdx; },
				 				'workOrdPrcssIdx' : function(){ return data.workOrdPrcssIdx; },
				 				'itemIdx'			:	function(){ return data.itemIdx; },
				 				'packUnit'			:	function(){ return packUnit; },
				            },
				            beforeSend: function() {
				            	$('#my-spinner').show();
				            },
				            success : function(res) {
				            	if(res.result == 'ok'){
									let data = res.data;
									checkVo = data;
									toastr.success('공정이 완료되었습니다.');
									$('#workOrderPrcssModal').modal('hide');
									$('#workOrderPrcssBundleModal').modal('hide');
									workOrderPrcssTable.ajax.reload(function(){
 										let reloadEndData = workOrderPrcssTable.data().toArray();
										//해당 checkVo의 idx가 현재 리로드된 테이블에 데이터가 없을 경우
										if(!reloadEndData.map(v=>v.workOrdPrcssIdx).includes(checkVo.workOrdPrcssIdx)){
											workOrderPrcssTable.row('.selected').deselect();
											//workOrdPrcssStatusTable.clear().draw();
											workPrcssDtlTable.clear().draw();
											inputMaterialHistTable.clear().draw();
										} else {
											//있을경우
											setTimeout(function() {
						            			workOrderPrcssTable.row('#'+checkVo.workOrdPrcssIdx).select();
												$(workOrderPrcssTable.row('#'+checkVo.workOrdPrcssIdx).node()).trigger('click'); // 선택처리
											}, 100)
										}
									});
									
									$('#workOrdBeforePrcssDescCheck').attr('disabled',true);
					            	$('#workOrdBeforePrcssDescCheckBundle').attr('disabled',true);
				            	} else if(res.result == 'fail') {
									toastr.warning(res.message);
								} else {
									toastr.error(res.message);
								}
				            	$('#my-spinner').hide();
				            }
						});
					} else if(data.progressStatus == 'WC'){ //완료
						toastr.warning('이미 작업완료된 공정입니다.');
						if(type == 'btnWorkEndBundle'){
							workOrderModalDisabled(data,'Bundle',true);
						} else {
							workOrderModalDisabled(data,'',true);
						}
					} else if(data.progressStatus == 'PI'){//대기
						toastr.warning('작업 대기상태인 공정입니다.');
						if(type == 'btnWorkEndBundle'){
							workOrderModalDisabled(data,'Bundle',true);
						} else {
							workOrderModalDisabled(data,'',true);
						}
						
					}
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
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

	let clickIdx;
	$('#btnSearch').on('click',function(){
		startDate = $('#startDate').val().replaceAll('-','');
		endDate = $('#endDate').val().replaceAll('-','');

		let trigger = false;
		
		if($('#workOrderPrcssTable tbody tr').hasClass('selected')){
			trigger = true;
			clickIdx = workOrderPrcssTable.row('.selected').data().workOrdPrcssIdx;
		}
		
		workOrderPrcssTable.ajax.reload(function(){
			let reloadEndData = workOrderPrcssTable.data().toArray();
			$('#btnAllCheck').prop('checked',false);
			if(trigger){
				setTimeout(function() {
					if(!reloadEndData.map(v=>v.workOrdPrcssIdx).includes(clickIdx)){
						//해당 행이 사라진 경우
						workOrderPrcssTable.row('.selected').deselect();
						//workOrdPrcssStatusTable.clear().draw();
						workPrcssDtlTable.clear().draw();
						inputMaterialHistTable.clear().draw();
					} else {
						//해당 행이 있는 경우
						workOrderPrcssTable.row('#'+clickIdx).select();
						$(workOrderPrcssTable.row('#'+clickIdx).node()).trigger('click'); // 선택처리
					}
				}, 50)
			}
		});
	});

	/**************************************************************공정별 진행상태**************************************************************/	
	// 공정별 진행상태 목록조회
	//$('#workOrdPrcssStatusTable thead tr').clone(true).addClass('filters').appendTo('#workOrdPrcssStatusTable thead'); // filter 생성
	/* let workOrdPrcssStatusTable = $('#workOrdPrcssStatusTable').DataTable({
		dom : "<'row'<'col-md-12 col-md-6'l><'col-md-12 col-md-6'f>>"
				+ "<'row'<'col-md-12'tr>>"
				+ "<'row pt-1'<'d-flex align-items-center d-flex'><'me-lg-auto'><'d-flex align-items-center justify-content-end'>>",
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
		/* select: {
            style: 'single',
            toggleable: false,
            items: 'row',
            info: false
        }, */
       /* ajax : {
			url : '<c:url value="/wm/workOrdLstWithPrcssByWorkOrd"/>',
			type : 'POST',
			data : {
				'workOrdIdx' : function(){return workOrdIdx;},
			},
		},
        rowId: 'workOrdPrcssIdx',
		columns : [
			{ data: 'progressStatus', className : 'text-center',
				render: function(data, type, row, meta) {
					return progressStatusListMap.get(data);
				}
			},//공정작업 진행상태
			{ data : 'prcssNm', className : 'text-center',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},//공정명
			{ data : 'workOrdQty', className : 'text-end',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
					} else {
						return '0';
					}
				}
			},//지시수량
			{ data : 'fairQty', className : 'text-end',
				render: function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data) + parseFloat(row['faultyQty']))+'</div>';
					} else {
						return '0';
					}
				}
			},//생산량
			{ data : 'fairQty',className : 'text-end',
				render: function(data, type, row, meta) {
					if(data != null && data != ''){
						let workOrdQty = row['workOrdQty'] != null && row['workOrdQty'] != '' ? row['workOrdQty'] : 0;
						let faultyQty = row['faultyQty'] != null && row['faultyQty'] != '' ? row['faultyQty'] : 0;
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+ (addCommas(parseFloat(workOrdQty) - parseFloat(data) - parseFloat(faultyQty)))+'</div>';
					} else {
						let workOrdQty = row['workOrdQty'] != null && row['workOrdQty'] != '' ? row['workOrdQty'] : 0;
						return addCommas(parseFloat(workOrdQty));
					}
				}
			},//미생산수량
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
			/* { extend: 'excel',	text: 'Excel',	charset: 'UTF-8', bom: true ,
				exportOptions: {
	                modifier: {
	                   selected:null
	                },	                
	            },
	        },
			{ extend: 'pdf',	text: 'PDF',	},
			{ extend: 'print',	text: 'Print',		charset: 'UTF-8', bom: true },
			{ extend: 'colvis',	text: 'Select Col',	}, */
		/*],
		order : [],
		drawCallback: function() {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#workOrdPrcssStatusTable_wrapper').find('.dataTables_scrollHead').css('height'));
			let	topHeight = parseFloat($('#rightcolB').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(topHeight - theadHeight - 58)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAll').off('keyup',function() {});
			$('#searchAll').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			});

			let rowData = api.data().toArray();
			if(rowData.length != 0){
				for(var i = 0; i < rowData.length ; i++){
					if(rowData[i].workOrdPrcssIdx == workOrdPrcssIdxVal){
						let node = api.row('#'+rowData[i].workOrdPrcssIdx).node();
						$(node).css('background-color','rgb(246 242 195)');
					}
					if(rowData[i].progressStatus == 'PI'){
						let node = api.row('#'+rowData[i].workOrdPrcssIdx).node();
						$(node).find('td').eq(0).css('font-weight','900');
					} else if(rowData[i].progressStatus == 'WI'){
						let node = api.row('#'+rowData[i].workOrdPrcssIdx).node();
						$(node).find('td').eq(0).css('color','blue').css('font-weight','900');
					} else if(rowData[i].progressStatus == 'WC'){
						let node = api.row('#'+rowData[i].workOrdPrcssIdx).node();
						$(node).find('td').eq(0).css('color','green').css('font-weight','900');
					}
					
				}
			}
			
		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#workOrdPrcssStatusTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#workOrdPrcssStatusTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	workOrdPrcssStatusTable.on('column-reorder', function( e, settings, details ) {
		let api = workOrdPrcssStatusTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#workOrdPrcssStatusTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	}); */

	/**************************************************************생산공정**************************************************************/
	// 생산공정내역 목록조회
	//$('#workPrcssDtlTable thead tr').clone(true).addClass('filters').appendTo('#workPrcssDtlTable thead'); // filter 생성
	let workPrcssDtlTable = $('#workPrcssDtlTable').DataTable({
		dom : "<'row'<'col-md-12 col-md-6'l><'col-md-12 col-md-6'f>>"
			+ "<'row'<'col-md-12'tr>>"
			+ "<'row pt-1'<'d-flex align-items-center d-flex'><'me-lg-auto'><'d-flex align-items-center justify-content-end'>>",
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
		/* select: {
	        style: 'single',
	        toggleable: false,
	        items: 'row',
	        info: false
	    }, */
        ajax : {
			url : '<c:url value="/wm/workOrdLstWithPrcssByWorkOrd"/>',
			type : 'POST',
			data : {
				'workOrdIdx' : function(){return workOrdIdx;},
			},
		}, 
        rowId: 'workOrdPrcssIdx',
		columns : [
			{ data: 'progressStatus', className : 'text-center',
				render: function(data, type, row, meta) {
					return progressStatusListMap.get(data);
				}
			},//공정작업 진행상태
			{ data : 'prcssNm', className : 'text-center',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},//공정명
			{ data : 'fairQty', className : 'text-end',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
					} else {
						return '0';
					}
				}
			},//양품
			{ data : 'faultyQty', className : 'text-end',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
					} else {
						return '0';
					}
				}
			},//불량
			{ data : 'produceQtyUnitNm', className : 'text-center',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},//단위
			{ data : 'regUserNm', className : 'text-center',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},//공정명
		],
		columnDefs : [
			//{ "targets": '_all', "orderable": false },
			//{
			//	targets: [0],
			//	render: function(data) {
			//		return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
			//	}
			//}
		],
		buttons : [
			/* { extend: 'excel',	text: 'Excel',	charset: 'UTF-8', bom: true ,
				exportOptions: {
	                modifier: {
	                   selected:null
	                },	                
	            },
	        },
			{ extend: 'pdf',	text: 'PDF',	},
			{ extend: 'print',	text: 'Print',		charset: 'UTF-8', bom: true },
			{ extend: 'colvis',	text: 'Select Col',	}, */
		],
		order : [],
		drawCallback: function() {
			let api = this.api();
			let data = api.data();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#workPrcssDtlTable_wrapper').find('.dataTables_scrollHead').css('height'));
			let	topHeight = parseFloat($('#rightcolM').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(topHeight - theadHeight - 58)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAll').off('keyup',function() {});
			$('#searchAll').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			});
			//progressOrder
			/* for(var i=0;i<data.length;i++) {
				let tr = $('#' + table_id + ' tbody').find('tr').eq(i);
				workPrcssDtlTable.row(tr).data().prcssOrder = i+1;
				$(tr).find('td').eq(0).html(i+1);
			} */
			$('#'+table_id+' tbody tr').attr('style',"vertical-align: middle;");

			let rowData = api.data().toArray();
			if(rowData.length != 0){
				for(var i = 0; i < rowData.length ; i++){
					if(rowData[i].workOrdPrcssIdx == workOrdPrcssIdxVal){
						let node = api.row('#'+rowData[i].workOrdPrcssIdx).node();
						$(node).css('background-color','rgb(246 242 195)');
					}
					if(rowData[i].progressStatus == 'PI'){
						let node = api.row('#'+rowData[i].workOrdPrcssIdx).node();
						$(node).find('td').eq(0).css('font-weight','900');
					} else if(rowData[i].progressStatus == 'WI'){
						let node = api.row('#'+rowData[i].workOrdPrcssIdx).node();
						$(node).find('td').eq(0).css('color','blue').css('font-weight','900');
					} else if(rowData[i].progressStatus == 'WC'){
						let node = api.row('#'+rowData[i].workOrdPrcssIdx).node();
						$(node).find('td').eq(0).css('color','green').css('font-weight','900');
					}
				}
			}
		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#workPrcssDtlTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#workPrcssDtlTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	workPrcssDtlTable.on('column-reorder', function( e, settings, details ) {
		let api = workPrcssDtlTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#workPrcssDtlTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	/**************************************************************투입자재**************************************************************/
	// 투입자재내역 목록조회
	//$('#inputMaterialHistTable thead tr').clone(true).addClass('filters').appendTo('#inputMaterialHistTable thead'); // filter 생성
	let inputMaterialHistTable = $('#inputMaterialHistTable').DataTable({
		dom : "<'row'<'col-md-12 col-md-6'l><'col-md-12 col-md-6'f>>"
				+ "<'row'<'col-md-12'tr>>"
				+ "<'row pt-1'<'d-flex align-items-center d-flex'><'me-lg-auto'><'d-flex align-items-center justify-content-end'>>",
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
		/* select: {
            style: 'single',
            toggleable: false,
            items: 'row',
            info: false
        }, */
        ajax : {
			url : '<c:url value="/wm/workOrdInputMaterialLst"/>',
			type : 'POST',
			data : {
				'itemIdx' : function(){ return itemIdx; },
				'bodIdx'  : function(){ return bodIdx; },
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'paperType', className : 'text-center align-middle'},
			{ className : 'text-center align-middle',
				render: function(data, type, row, meta) {
					if((row['sizeX'] == null || row['sizeX'] == '') && (row['sizeY'] != null && row['sizeY'] != '')){
						return '0*' + addCommas(parseFloat(row['sizeY']));
					} else if((row['sizeX'] != null && row['sizeX'] != '') && (row['sizeY'] == null || row['sizeY'] == '')) {
						return addCommas(parseFloat(row['sizeX'])) + '*0';
					} else if((row['sizeX'] != null && row['sizeX'] != '') && (row['sizeY'] != null && row['sizeY'] != '')){
						return addCommas(parseFloat(row['sizeX'])) + '*' + addCommas(parseFloat(row['sizeY']));
					} else {
						return '0*0';
					}
				}
			},//장 * 폭
			{ className : 'text-center align-middle',
				render: function(data, type, row, meta) {
					return addCommas(parseFloat(row['cutQty'])) + '절/' + addCommas(parseFloat(row['eaQty'])) + '개';
				}
			},// 절수/개수
			/* {  className : 'text-center align-middle',
				render: function(data, type, row, meta) {
					let ordQty = parseInt(row['purchaseOrdQty']); // 주문수량(제품)
					let cutQty = parseInt(row['cutQty']); // 절수
					let eaQty = parseInt(row['eaQty']); // 개수
					let extraQty = parseInt(row['extraQty']); // 여유분
					
					if(row['purchaseOrdQty'] == 'notPurchase'){//발주를 하지않은 경우
						return '-';
					} else if(cutQty == 0 || eaQty == 0) {
						return '0';
					} else {
						//let printPressQty = Math.ceil(ordQty/eaQty);
						//let printPressQty = Math.ceil(ordQty/(cutQty*eaQty)) * cutQty;
						//let pressQty = Math.ceil((printPressQty + extraQty)/cutQty);
						
						let cuttingSize = Math.ceil(ordQty/(cutQty*eaQty));
						let pressQty = cuttingSize + extraQty;
						
						let R = parseInt(pressQty / 500); // R로 환산
						let finalPurchaseQty = R + "R" + (pressQty % 500);
						
						return finalPurchaseQty;
					}
					//return addCommas(parseFloat(row['purchaseOrdQty'])) + '+' + addCommas(parseFloat(row['extraQty']));
				}
			},//발주량+여분 */
			{ className : 'text-end align-middle', name: 'printPressQty', // 정매인쇄통수(이론통수)
				//********매우 중요**********
				// 이론통수를 구할때 이론 통수는 절수의 배수로 나와야하기때문에 올림된 이론통수값을 절수로 나눈 나머지로 
				// (절수-나머지) + 이론통수 해줘야 이론통수임
				// ↑↑↑↑↑↑↑↑↑↑ 였는데 2023.01.02에 다시 배수가 아니라 그냥 올림만 하기로함
				// ↑↑↑↑↑↑↑↑↑↑ 였는데 2023.01.10에 다시 이론량*절수의 값으로 하기로함
				render : function(data, type, row, meta) {
					let ordQty = parseInt(row['purchaseOrdQty']); // 주문수량(제품)
					let cutQty = parseInt(row['cutQty']); // 절수
					let eaQty = parseInt(row['eaQty']); // 개수
					let extraQty = parseInt(row['extraQty']); // 여유분

					if(row['purchaseOrdQty'] == 'notPurchase'){//발주를 하지않은 경우
						return '-';
					} else if(cutQty == 0 || eaQty == 0) {
						return '0R0';
					} else {
						//let printPressQty = Math.ceil(ordQty/eaQty);
						let printPressQty = Math.ceil(ordQty/(cutQty*eaQty)) * cutQty;

						let R = parseInt(printPressQty / 500); // R로 환산
						let finalPurchaseQty = R + "R" + (printPressQty % 500);
						
						return finalPurchaseQty;
					}
				}
			},
			{ className : 'text-end align-middle', name: 'printPressAndExtraQty', // 정매인쇄통수 + 여분 + 포장단위여분(여분포함통수)
				render : function(data, type, row, meta) {
					let ordQty = parseInt(row['purchaseOrdQty']); // 주문수량(제품)
					let cutQty = parseInt(row['cutQty']); // 절수
					let eaQty = parseInt(row['eaQty']); // 개수
					let extraQty = parseInt(row['extraQty']); // 여유분
					let extraPackQty = row['extraPackQty']; // 포장단위여분
					extraPackQty = isEmptyCheck(extraPackQty) ? 0 : extraPackQty;

					if(row['purchaseOrdQty'] == 'notPurchase'){//발주를 하지않은 경우
						return '-';
					} else if(cutQty == 0 || eaQty == 0) {
						return '0R0';
					} else {
						//let printPressQty = Math.ceil(ordQty/eaQty);
						let printPressQty = Math.ceil(ordQty/(cutQty*eaQty)) * cutQty;
						let printPressAndExtraQty = printPressQty + extraQty + (extraPackQty*cutQty);

						let R = parseInt(printPressAndExtraQty / 500); // R로 환산
						let finalPurchaseQty = R + "R" + (printPressAndExtraQty % 500);
						
						return finalPurchaseQty;
						
					}
				}
			},
			{  data: 'inQty', className : 'text-end align-middle',
				render: function(data, type, row, meta) {
					if(row['purchaseOrdQty'] == 'notPurchase'){//발주를 하지않은 경우
						return '-';
					} else if(data != null && data != ''){
						return addCommas(parseFloat(data));
					} else {
						return '0';
					}
				}
			},//입고량
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
			/* { extend: 'excel',	text: 'Excel',	charset: 'UTF-8', bom: true ,
				exportOptions: {
	                modifier: {
	                   selected:null
	                },	                
	            },
	        },
			{ extend: 'pdf',	text: 'PDF',	},
			{ extend: 'print',	text: 'Print',		charset: 'UTF-8', bom: true },
			{ extend: 'colvis',	text: 'Select Col',	}, */
		],
		order : [],
		drawCallback: function() {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#inputMaterialHistTable_wrapper').find('.dataTables_scrollHead').css('height'));
			let	topHeight = parseFloat($('#rightcolT').css('height'));
			let	inputMaterialHistTableHeader = parseFloat($('#inputMaterialHistTableHeader').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(topHeight - theadHeight - inputMaterialHistTableHeader - 62)+'px');
			
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
				let cell = $('#inputMaterialHistTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#inputMaterialHistTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	inputMaterialHistTable.on('column-reorder', function( e, settings, details ) {
		let api = inputMaterialHistTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#inputMaterialHistTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	/************************************************************** 모달들 **************************************************************/
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
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 197)+'px');
			
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

	//$('#purchaseMatrlModalTable thead tr').clone(true).addClass('filters').appendTo('#purchaseMatrlModalTable thead'); // filter 생성
	let purchaseMatrlModalTable = $('#purchaseMatrlModalTable').DataTable({
		dom : "<'row'<'col-md-12 col-md-6'l><'col-md-12 col-md-6'f>>"
				+ "<'row'<'col-md-12'tr>>"
				+ "<'row pt-1'<'d-flex align-items-center d-flex'><'me-lg-auto'><'d-flex align-items-center justify-content-end'>>",
		language: lang_kor,
		info: true,
		ordering: false,
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
		/* select: {
            style: 'single',
            toggleable: false,
            items: 'row',
            info: false
        }, */
        ajax : {
			url : '<c:url value="/pm/purchaseOrderAdmLstByWorkOrdPrcss"/>',
			type : 'POST',
			data : {
				workOrdPrcssIdx	: function() { return workOrdPrcssIdx; }
			},
		}, 
        rowId: 'matrlIdx',
		columns : [
			{ data : 'paperType', className : 'text-center',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},//재질
			{ className : 'text-center align-middle', // 절수개수
				render : function(data, type, row, meta) {
					return parseInt(row['cutQty']) + "/" + parseInt(row['eaQty']); 
				}
			},
			{ data : 'spQty', className : 'text-center',
				render: function(data) {
					if(data != null && data != ''){
						let returnR;
						if(parseInt(data) < 0){
							returnR = "-" + parseInt(-1*data/500) + 'R' + parseInt(-1*data%500); 
						} else {
							returnR = parseInt(data/500) + 'R' + parseInt(data%500); 
						}
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+returnR+'</div>';
					} else {
						return '0';
					}
				}
			},//현재고R			
			{ className : 'text-center align-middle', // 정매인쇄통수(이론통수)
				render : function(data, type, row, meta) {
					let ordQty = parseInt(row['purchaseOrdQty']); // 주문수량(제품)
					let cutQty = parseInt(row['cutQty']); // 절수
					let eaQty = parseInt(row['eaQty']); // 개수
					let extraQty = parseInt(row['extraQty']); // 여유분

					if(row['purchaseOrdQty'] == 'notPurchase'){//발주를 하지않은 경우
						return '-';
					} else if(cutQty == 0 || eaQty == 0) {
						return '0';
					} else {
						//let printPressQty = Math.ceil(ordQty/eaQty);
						let printPressQty = Math.ceil(ordQty/(cutQty*eaQty)) * cutQty;

						let R = parseInt(printPressQty/500) + 'R' + parseInt(printPressQty%500);   
						
						let html = '';
						html += '<div class="row">';
						//html += '	<div class="text-end align-middle" style="white-space:nowrap;width:50%;">'+R+'</div>';
						html += '	<div class="text-center align-middle" style="white-space:nowrap;width:100%;">'+addCommas(printPressQty)+'</div>';
						html += '</div>';
						
						return html;
					}
				}
			},
			{ className : 'text-center align-middle', // 여분
				render : function(data, type, row, meta) {
					let ordQty = parseInt(row['purchaseOrdQty']); // 주문수량(제품)
					let cutQty = parseInt(row['cutQty']); // 절수
					let eaQty = parseInt(row['eaQty']); // 개수
					let extraQty = parseInt(row['extraQty']); // 여유분
					let extraPackQty = parseInt(row['extraPackQty']); // 포장단위여분

					if(row['purchaseOrdQty'] == 'notPurchase'){//발주를 하지않은 경우
						return '-';
					} else if(cutQty == 0 || eaQty == 0) {
						return '0';
					} else {
						//let printPressQty = Math.ceil(ordQty/eaQty);
						let printPressQty = Math.ceil(ordQty/(cutQty*eaQty)) * cutQty;
						//여분포함통수 - 이론통수 = 여분
						let printPressAndExtraQty = (printPressQty + extraQty + (extraPackQty*cutQty)) - printPressQty;

						let R = parseInt(printPressAndExtraQty/500) + 'R' + parseInt(printPressAndExtraQty%500);   
						
						let html = '';
						html += '<div class="row">';
						//html += '	<div class="text-end align-middle" style="white-space:nowrap;width:50%;">'+R+'</div>';
						html += '	<div class="text-center align-middle" style="white-space:nowrap;width:100%;">'+addCommas(printPressAndExtraQty)+'</div>';
						html += '</div>';
						
						return html;
					}
				}
			},
			{ className : 'text-center align-middle', // 합계(여분포함통수)
				render : function(data, type, row, meta) {
					let ordQty = parseInt(row['purchaseOrdQty']); // 주문수량(제품)
					let cutQty = parseInt(row['cutQty']); // 절수
					let eaQty = parseInt(row['eaQty']); // 개수
					let extraQty = parseInt(row['extraQty']); // 여유분
					let extraPackQty = parseInt(row['extraPackQty']); // 포장단위여분

					if(row['purchaseOrdQty'] == 'notPurchase'){//발주를 하지않은 경우
						return '-';
					} else if(cutQty == 0 || eaQty == 0) {
						return '0';
					} else {
						//let printPressQty = Math.ceil(ordQty/eaQty);
						let printPressQty = Math.ceil(ordQty/(cutQty*eaQty)) * cutQty;
						let printPressAndExtraQty = printPressQty + extraQty + (extraPackQty*cutQty) ;
						
						let R = parseInt(printPressAndExtraQty/500) + 'R' + parseInt(printPressAndExtraQty%500);   
						
						let html = '';
						html += '<div class="row">';
						//html += '	<div class="text-end align-middle" style="white-space:nowrap;width:50%;">'+R+'</div>';
						html += '	<div class="text-center align-middle" style="white-space:nowrap;width:100%;">'+addCommas(printPressAndExtraQty)+'</div>';
						html += '</div>';
						
						return html;
					}
				}
			},
			{ data : 'addCutting', className : 'text-end align-middle', name:'addCutting', // 추가재단
				render : function(data, type, row, meta) {
					return addCommas(parseFloat(data));
				}
			},
		],
		columnDefs : [
			{ "width": "25%", "targets": 0 },
			{ "width": "12.5%", "targets": 1 },
			{ "width": "12.5%", "targets": 2 },
			{ "width": "12.5%", "targets": 3 },
			{ "width": "12.5%", "targets": 4 },
			{ "width": "12.5%", "targets": 5 },
			{ "width": "12.5%", "targets": 6 },
			/*{
				targets: '_all',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},*/
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
			
			//let htmlHeight = parseFloat($('#matrlGroup').css('height'));
			//let theadHeight = parseFloat($('#purchaseMatrlModalTable_wrapper').find('.dataTables_scrollHead').css('height'));
			//$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight )+'px');
			//$('#purchaseMatrlModalTable_wrapper').css('height','100%');
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAll').off('keyup',function() {});
			$('#searchAll').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			});

			//$('#'+table_id+' tbody tr td').attr('style',"vertical-align: middle;");
			for(var i=0;i<data.length;i++) {
				let tr = $('#purchaseMatrlModalTable tbody').find('tr').eq(i);
				let colIndex = purchaseMatrlModalTable.column('addCutting:name').index(); 
				$(tr).find('td').eq(colIndex).attr('style','background-color: #ff000078 !important;');
			} 

			try {
				purchaseMatrlModalTable.columns.adjust();
			} catch{

			}
		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#purchaseMatrlModalTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();
				
				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#purchaseMatrlModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	purchaseMatrlModalTable.on('column-reorder', function( e, settings, details ) {
		let api = purchaseMatrlModalTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#purchaseMatrlModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	//번들링리스트
	//$('#inputBundleModalTable thead tr').clone(true).addClass('filters').appendTo('#inputBundleModalTable thead'); // filter 생성
	let inputBundleModalTable = $('#inputBundleModalTable').DataTable({
		dom : "<'row'<'col-md-12 col-md-6'l><'col-md-12 col-md-6'f>>"
				+ "<'row'<'col-md-12'tr>>"
				+ "<'row pt-1'<'d-flex align-items-center d-flex'><'me-lg-auto'><'d-flex align-items-center justify-content-end'>>",
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
			url : '<c:url value="/wm/workOrdBundleList"/>',
			type : 'POST',
			data : {
				'bizOrdDtlIdx'	: function(){ return bizOrdDtlIdxVal; },
				'workOrdPrcssIdx'	: function(){ return workOrdPrcssIdxVal; },
			},
		}, 
        rowId: 'idx',
		columns : [
			{ data : 'itemNm', className : 'text-center',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},//품명
			{ data : 'stockQty', className : 'text-end',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseInt(data))+'</div>';
					} else {
						return '-';
					}
				}
			},//현재고
			{ data : 'inputQty', className : 'text-end', name:'inputQty',
				render: function(data) {
					if(data != null && data != ''){
						return '<input style="min-width:80px;max-width:80px;" type="text" name="inputQty" class="form-control text-end " value="'+addCommas(parseInt(data))+'" onkeyup="numberFormat(this,\'int\')">';
					} else {
						return '-';
					}
				}
			},// 투입수량
			{ data : 'productionOutWorkQty', className : 'text-end',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseInt(data))+'</div>';
					} else {
						return '-';
					}
				}
			},// 제품출고수량
			{ data : 'productionOutDisQty', className : 'text-end',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseInt(data))+'</div>';
					} else {
						return '-';
					}
				}
			},// 제품폐기수량
			{ data : 'itemVersion', className : 'text-center',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},//버전번호
			{ data : 'bizOrdDtlNo', className : 'text-center',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},//수주상세번호
			{ data : 'fairQty', className : 'text-center',
				render: function(data, type, row, meta) {
					if(data != null && data != ''){
						let fairQty = isEmptyCheck(row['fairQty']) ? 0 : addCommas(parseInt(row['fairQty']));
						let faultyQty = isEmptyCheck(row['faultyQty']) ? 0 : addCommas(parseInt(row['faultyQty']));
						
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+ fairQty +' / ' + faultyQty +'</div>';
					} else {
						return '-';
					}
				}
			},//실적수량
			
		],
		columnDefs : [
			/*{
				targets: '_all',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},*/
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
			
			let htmlHeight = parseFloat($('#workOrderPrcssModalTableHeightBundle').css('height'));
			let theadHeight = parseFloat($('#inputBundleModalTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 14)+'px');
			$('#inputBundleModalTable_wrapper').css('height','100%');
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			//$('#searchAll').off('keyup',function() {});
			//$('#searchAll').on('keyup',function() {
			//	$('#'+table_id+'_filter').find('input').val($(this).val());
			//	$('#'+table_id+'_filter').find('input').trigger('keyup');
			//});

			$('#'+table_id+' tbody tr td').attr('style',"vertical-align: middle;");
			for(var i=0;i<data.length;i++) {
				let tr = $('#inputBundleModalTable tbody').find('tr').eq(i);
				let colIndex = inputBundleModalTable.column('addCutting:name').index(); 
				$(tr).find('td').eq(colIndex).attr('style','background-color: #ff000078 !important;');
			}
		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#inputBundleModalTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();
				
				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#inputBundleModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	inputBundleModalTable.on('column-reorder', function( e, settings, details ) {
		let api = inputBundleModalTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#inputBundleModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	//분할실적리스트
	//$('#workOrdPrcssResultTable thead tr').clone(true).addClass('filters').appendTo('#workOrdPrcssResultTable thead'); // filter 생성
	let workOrdPrcssResultTable = $('#workOrdPrcssResultTable').DataTable({
		dom : "<'row'<'col-md-12 col-md-6'l><'col-md-12 col-md-6'f>>"
				+ "<'row'<'col-md-12'tr>>"
				+ "<'row pt-1'<'d-flex align-items-center d-flex'><'me-lg-auto'><'d-flex align-items-center justify-content-end'>>",
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
			url : '<c:url value="/wm/workOrdResultListByPrcss"/>',
			type : 'POST',
			data : {
				workOrdPrcssIdx	: function() { return workOrdPrcssIdxVal; }
			},
		},  
        rowId: 'idx',
		columns : [
			{ data:'workDate', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data,'YYYYMMDD').format('YYYY-MM-DD')+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ data:'regUserNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ data: 'fairQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
					} else {
						return '0';
					}
				}
			},
			{ data: 'faultyQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
					} else {
						return '0';
					}
				}
			},
		],
		columnDefs : [
			/*{
				targets: '_all',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},*/
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
			
			let htmlHeight = parseFloat($('#workOrdPrcssResultTableHeight').css('height'));
			let theadHeight = parseFloat($('#workOrdPrcssResultTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight )+'px');
			//$('#workOrdPrcssResultTable_wrapper').css('height','100%');
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAll').off('keyup',function() {});
			$('#searchAll').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			});

			$('#'+table_id+' tbody tr td').attr('style',"vertical-align: middle;");
			/*for(var i=0;i<data.length;i++) {
				let tr = $('#workOrdPrcssResultTable tbody').find('tr').eq(i);
				let colIndex = workOrdPrcssResultTable.column('addCutting:name').index(); 
				$(tr).find('td').eq(colIndex).attr('style','background-color: #ff000078 !important;');
			}*/
		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#workOrdPrcssResultTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();
				
				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#workOrdPrcssResultTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	workOrdPrcssResultTable.on('column-reorder', function( e, settings, details ) {
		let api = workOrdPrcssResultTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#workOrdPrcssResultTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	//번들링 분할실적리스트
	//$('#workOrdPrcssResultTableBundle thead tr').clone(true).addClass('filters').appendTo('#workOrdPrcssResultTableBundle thead'); // filter 생성
	let workOrdPrcssResultTableBundle = $('#workOrdPrcssResultTableBundle').DataTable({
		dom : "<'row'<'col-md-12 col-md-6'l><'col-md-12 col-md-6'f>>"
				+ "<'row'<'col-md-12'tr>>"
				+ "<'row pt-1'<'d-flex align-items-center d-flex'><'me-lg-auto'><'d-flex align-items-center justify-content-end'>>",
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
			url : '<c:url value="/wm/workOrdResultListByPrcss"/>',
			type : 'POST',
			data : {
				workOrdPrcssIdx	: function() { return workOrdPrcssIdxVal; }
			},
		},  
        rowId: 'idx',
		columns : [
			{ data:'workDate', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data,'YYYYMMDD').format('YYYY-MM-DD')+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ data:'regUserNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ data: 'fairQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
					} else {
						return '0';
					}
				}
			},
			{ data: 'faultyQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
					} else {
						return '0';
					}
				}
			},
		],
		columnDefs : [
			/*{
				targets: '_all',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},*/
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
			
			let htmlHeight = parseFloat($('#workOrdPrcssResultTableHeightBundle').css('height'));
			let theadHeight = parseFloat($('#workOrdPrcssResultTableBundle_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight )+'px');
			//$('#workOrdPrcssResultTableBundle_wrapper').css('height','100%');
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAll').off('keyup',function() {});
			$('#searchAll').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			});

			$('#'+table_id+' tbody tr td').attr('style',"vertical-align: middle;");
			/*for(var i=0;i<data.length;i++) {
				let tr = $('#workOrdPrcssResultTableBundle tbody').find('tr').eq(i);
				let colIndex = workOrdPrcssResultTableBundle.column('addCutting:name').index(); 
				$(tr).find('td').eq(colIndex).attr('style','background-color: #ff000078 !important;');
			}*/
		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#workOrdPrcssResultTableBundle_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();
				
				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#workOrdPrcssResultTableBundle_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	workOrdPrcssResultTableBundle.on('column-reorder', function( e, settings, details ) {
		let api = workOrdPrcssResultTableBundle;
		api.columns().eq(0).each(function (colIdx) {
			$('#workOrdPrcssResultTableBundle_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});
	
	/****************************가상키보드  ****************************/
	let virtualKeyboard_selector_type = '';
	$(document).on('click','.virtualKeyboard2',function() {
		virtualKeyboard_selector = $(this);
		virtualKeyboard_selector_type = $(this).attr('type');
	});

	$(document).on('click','.virtualKeyboard_content2 .virkey',function() {
		$(virtualKeyboard_selector).focus();
		var virkey_input_str = $(virtualKeyboard_selector).val();
		if($(this).attr('id') == 'virkey_0_13' || $(this).attr('id') == 'virkey_0_13Bundle') { // backspace
			$(virtualKeyboard_selector).val(virkey_input_str.substring(0, virkey_input_str.length - 1)).trigger('keyup');
		} else if($(this).attr('id') == 'virkey_1_0' || $(this).attr('id') == 'virkey_1_0Bundle') { // tab
			//$(virtualKeyboard_selector).next().focus();
			//virtualKeyboard_selector = $(virtualKeyboard_selector).next();
		} else if($(this).attr('id') == 'virkey_2_0' || $(this).attr('id') == 'virkey_2_0Bundle') { // Caps Lock
			capsLockKey();
		} else if($(this).attr('id') == 'virkey_2_12' || $(this).attr('id') == 'virkey_2_12Bundle') { // Enter
			$(virtualKeyboard_selector).val(virkey_input_str + '\n');
		} else if($(this).attr('id') == 'virkey_3_0' || $(this).attr('id') == 'virkey_3_11' || $(this).attr('id') == 'virkey_3_0Bundle' || $(this).attr('id') == 'virkey_3_11Bundle') { // Shift
			shiftKey();
		} else if($(this).attr('id') == 'virkey_4_0' || $(this).attr('id') == 'virkey_4_5' || $(this).attr('id') == 'virkey_4_0Bundle' || $(this).attr('id') == 'virkey_4_5Bundle') { // Ctrl
			
		} else if($(this).attr('id') == 'virkey_4_1' || $(this).attr('id') == 'virkey_4_1Bundle') { // Win
			
		} else if($(this).attr('id') == 'virkey_4_2' || $(this).attr('id') == 'virkey_4_2Bundle') { // Alt
			
		} else if($(this).attr('id') == 'virkey_4_3' || $(this).attr('id') == 'virkey_4_3Bundle') { // SpaceBar
			$(virtualKeyboard_selector).val(virkey_input_str+' ').trigger('keyup');
		} else if($(this).attr('id') == 'virkey_4_4' || $(this).attr('id') == 'virkey_4_4Bundle') { // 한영 전환
			if(virtualKeyboard_language == 'ko') {
				languageChange('en');
				virtualKeyboard_language = 'en';
			} else if(virtualKeyboard_language == 'en'){
				languageChange('ko');
				virtualKeyboard_language = 'ko';
			}
		} else if($(this).attr('id') == 'virkeypad_0_0' || $(this).attr('id') == 'backspace' || $(this).attr('id') == 'virkeypad_0_0Bundle') { // backspace
			$(virtualKeyboard_selector).val(virkey_input_str.substring(0, virkey_input_str.length - 1)).trigger('keyup');
		} else if($(this).attr('id') == 'virkeypad_2_3' || $(this).attr('id') == 'upCount' || $(this).attr('id') == 'virkeypad_2_3Bundle') { // +1
			$(virtualKeyboard_selector).val(virkey_input_str==''?0:addCommas(parseFloat(removeCommas(virkey_input_str))+1)).trigger('keyup');
		} else if($(this).attr('id') == 'virkeypad_3_3' || $(this).attr('id') == 'downCount' || $(this).attr('id') == 'virkeypad_3_3Bundle') { // -1
			$(virtualKeyboard_selector).val(virkey_input_str==''?0:virkey_input_str>0?addCommas(parseFloat(removeCommas(virkey_input_str))-1):0).trigger('keyup');
		} else if($(this).attr('id') == 'virkeypad_4_2' || $(this).attr('id') == 'virkeypad_4_2Bundle') { // Enter
			
		} else {
			if(virtualKeyboard_selector_type != 'date' && virtualKeyboard_selector_type != 'datetime-local'){
				$(virtualKeyboard_selector).val(Hangul.assemble(Hangul.disassemble(virkey_input_str+$(this).text()))).trigger('keyup');
			} else {
				//date
				if(virtualKeyboard_selector_type == 'date'){
					//음
				} else if(virtualKeyboard_selector_type == 'datetime-local'){
				
				}
			}
		}
	});
	
	/* 공통 함수 */
	function workInputDisabled(disabled){
		$('#workDate').attr('disabled',disabled);
		$('#workStartTime').attr('disabled',disabled);
		$('#workEndTime').attr('disabled',disabled);
		$('#workQty').attr('disabled',disabled);
		$('#workFaultyQty').attr('disabled',disabled);
		$('#workAddCuttingQty').attr('disabled',disabled);
		$('#faultyReason').attr('disabled',disabled);
		$('#fieldDesc').attr('disabled',disabled);

		$('#workDateBundle').attr('disabled',disabled);
		$('#workStartTimeBundle').attr('disabled',disabled);
		$('#workEndTimeBundle').attr('disabled',disabled);
		$('#workQtyBundle').attr('disabled',disabled);
		$('#workFaultyQtyBundle').attr('disabled',disabled);
		$('#faultyReasonBundle').attr('disabled',disabled);
		$('#fieldDescBundle').attr('disabled',disabled);		
	}

	/* R변환 연산  */
	$('#workQty').on('keyup',function(){
		if(prcssQtyUnit){
			let rVal = (parseInt($('#workQty').val().replaceAll(',','') / 500)) + 'R' +(parseInt($('#workQty').val().replaceAll(',','') % 500));
			$('#workQtyRChange').val(rVal);
		}

		//불량수량자동계산
		let value;
		let addCuttingVal = isEmptyCheck(workOrderPrcssTable.row('.selected').data().addCutting) ? 0 : workOrderPrcssTable.row('.selected').data().addCutting;
		let addCutting = parseInt(addCuttingVal);
		//작업공정의 단위와 전공정실적단위가 같다면 전공정실적으로 수량계산 / 다르다면 지시수량으로 계산
		if( $('#workPrcssQtyUnit').val().replaceAll(/[0-9]/gi,'') == $('#workOrdBeforePrcssQty').text().replaceAll(',','').replaceAll(/[0-9]/gi,'') ){
			value = parseFloat(removeCommas($('#workOrdBeforePrcssQty').text().replaceAll(',','').replaceAll(/[^0-9]/gi,''))) - parseFloat(removeCommas($('#workQty').val().replaceAll(',','')));
			value += addCutting;
		} else {
			value = parseFloat(removeCommas($('#workOrdQty').text().replaceAll(',',''))) - parseFloat(removeCommas($('#workQty').val().replaceAll(',','')));
		}
		$('#workFaultyQty').val( value < 0 ? 0 : addCommas(value));
	});
	
	$('#workFaultyQty').on('keyup',function(){
		if(prcssQtyUnit){
			let rVal = (parseInt($('#workFaultyQty').val().replaceAll(',','') / 500)) + 'R' +(parseInt($('#workFaultyQty').val().replaceAll(',','') % 500));
			$('#workFaultyQtyRChange').val(rVal);
		}
		/*
		//작업량자동계산
		let value;
		//작업공정의 단위와 전공정실적단위가 같다면 전공정실적으로 수량계산 / 다르다면 지시수량으로 계산
		if( $('#workPrcssQtyUnit').val().replaceAll(/[0-9]/gi,'') == $('#workOrdBeforePrcssQty').text().replaceAll(',','').replaceAll(/[0-9]/gi,'') ){
			value = parseFloat(removeCommas($('#workOrdBeforePrcssQty').text().replaceAll(',','').replaceAll(/[^0-9]/gi,''))) - parseFloat(removeCommas($('#workFaultyQty').val().replaceAll(',','')));
		} else {
			value = parseFloat(removeCommas($('#workOrdQty').text().replaceAll(',',''))) - parseFloat(removeCommas($('#workFaultyQty').val().replaceAll(',','')));
		}
		$('#workQty').val( value < 0 ? 0 : addCommas(value));
		*/
	});


	/* R변환 연산  */
	$('#workQtyBundle').on('keyup',function(){
		if(prcssQtyUnit){
			let rVal = (parseInt($('#workQtyBundle').val().replaceAll(',','') / 500)) + 'R' +(parseInt($('#workQtyBundle').val().replaceAll(',','') % 500));
			$('#workQtyRChange').val(rVal);
		}

		//불량수량자동계산
		let value;
		//작업공정의 단위와 전공정실적단위가 같다면 전공정실적으로 수량계산 / 다르다면 지시수량으로 계산
		if( $('#workPrcssQtyUnitBundle').val().replaceAll(/[0-9]/gi,'') == $('#workOrdBeforePrcssQtyBundle').text().replaceAll(',','').replaceAll(/[0-9]/gi,'') ){
			value = parseFloat(removeCommas($('#workOrdBeforePrcssQtyBundle').text().replaceAll(',','').replaceAll(/[^0-9]/gi,''))) - parseFloat(removeCommas($('#workQtyBundle').val().replaceAll(',','')));
		} else {
			value = parseFloat(removeCommas($('#workOrdQtyBundle').text().replaceAll(',',''))) - parseFloat(removeCommas($('#workQtyBundle').val().replaceAll(',','')));
		}
		$('#workFaultyQtyBundle').val( value < 0 ? 0 : addCommas(value));
	});
	$('#workFaultyQtyBundle').on('keyup',function(){
		if(prcssQtyUnit){
			let rVal = (parseInt($('#workFaultyQtyBundle').val().replaceAll(',','') / 500)) + 'R' +(parseInt($('#workFaultyQtyBundle').val().replaceAll(',','') % 500));
			$('#workFaultyQtyRChangeBundle').val(rVal);
		}
		/*
		//작업량자동계산
		let value;
		//작업공정의 단위와 전공정실적단위가 같다면 전공정실적으로 수량계산 / 다르다면 지시수량으로 계산
		if( $('#workPrcssQtyUnit').val().replaceAll(/[0-9]/gi,'') == $('#workOrdBeforePrcssQty').text().replaceAll(',','').replaceAll(/[0-9]/gi,'') ){
			value = parseFloat(removeCommas($('#workOrdBeforePrcssQty').text().replaceAll(',','').replaceAll(/[^0-9]/gi,''))) - parseFloat(removeCommas($('#workFaultyQty').val().replaceAll(',','')));
		} else {
			value = parseFloat(removeCommas($('#workOrdQty').text().replaceAll(',',''))) - parseFloat(removeCommas($('#workFaultyQty').val().replaceAll(',','')));
		}
		$('#workQty').val( value < 0 ? 0 : addCommas(value));
		*/
	});
	
	//***************************실적삭제***********************
	$('#btnWorkDel, #btnWorkDelBundle').on('click',function(){
		let delGubun = $(this).attr('id');
		if(delGubun == 'btnWorkDelBundle'){
			if(!$('#workOrdPrcssResultTableBundle tbody tr').hasClass('selected')){
				toastr.warning('삭제할 실적을 선택해주세요.');
				return false;
			}
		} else{
			if(!$('#workResultListTable tbody tr').hasClass('selected')){
				toastr.warning('삭제할 실적을 선택해주세요.');
				return false;
			}
		} 
		_promise_().then(()=>{
			$('#my-spinner').show();
		}).then(()=>{
			setTimeout(function(){
				let nextPrcss;
				if(delGubun == 'btnWorkDelBundle'){
				
				} else {
					workOrdIdx = workResultListTable.row('.selected').data().workOrdIdx;
					workOrdPrcssIdx = workResultListTable.row('.selected').data().workOrdPrcssIdx;
				}
				
				$.ajax({
					url: '<c:url value="/wm/workOrdNextPrcssSel"/>',
		            type: 'POST',
		            async: false,
		            data: {
		            	'workOrdIdx'		:	function(){ return workOrdIdx; },
		            	'workOrdPrcssIdx'	:	function(){ return workOrdPrcssIdx; },
		            },
		            beforeSend: function() {
		            	$('#my-spinner').show();
		            },
					success : function(res) {
						if (res.result == "ok") { //응답결과
							nextPrcss = res.data;

						} else if(res.result == 'fail') {
							toastr.warning(res.message);
						} else {
							toastr.error(res.message);
						}
						$('#my-spinner').hide();
					}
				});
				if(nextPrcss != null && nextPrcss != ''){
					if(nextPrcss.progressStatus == 'PI'){
						if(delGubun == 'btnWorkDelBundle'){
							if(!$('#workOrdPrcssResultTableBundle tbody tr').hasClass('selected')){
								toastr.warning('삭제할 실적을 선택해주세요.');
								return false;
							}
						} else{
							if(!$('#workResultListTable tbody tr').hasClass('selected')){
								toastr.warning('삭제할 실적을 선택해주세요.');
								return false;
							}

							if( isEmptyCheck(workResultListTable.row('.selected').data().idx) ){
								toastr.warning('해당 공정의 실적이 등록되지<br>않았습니다.');
								return false;
							}
						} 
						$('#deleteModal').modal('show');
						$('#deleteModal').data('deleteType','workOrdPrcssResult');
						$('#deleteModal').data('deleteGubun',delGubun);
					} else {
						toastr.warning('다음 공정이 진행되어<br>실적 삭제할 수 없습니다.');
					}
				} else {
					if(delGubun == 'btnWorkDelBundle'){
						if(!$('#workOrdPrcssResultTableBundle tbody tr').hasClass('selected')){
							toastr.warning('삭제할 실적을 선택해주세요.');
							return false;
						}
					} else{
						if(!$('#workResultListTable tbody tr').hasClass('selected')){
							toastr.warning('삭제할 실적을 선택해주세요.');
							return false;
						}

						if( isEmptyCheck(workResultListTable.row('.selected').data().idx) ){
							toastr.warning('해당 공정의 실적이 등록되지<br>않았습니다.');
							return false;
						}
					} 
					$('#deleteModal').modal('show');
					$('#deleteModal').data('deleteType','workOrdPrcssResult');
					$('#deleteModal').data('deleteGubun',delGubun);
					//toastr.warning('마지막 공정 실적 삭제가 불가능합니다.');
				}
			},10);	
		});
	});

	let workOrdPrcssTempIdx = '';
	$('#btnDeleteModalY').on('click', function() {
		let deleteType = $('#deleteModal').data('deleteType');
		let deleteGubun = $('#deleteModal').data('deleteGubun');
		if(deleteGubun == 'btnWorkDelBundle'){
			
		} else {
			workOrdPrcssTempIdx = workOrderPrcssTable.row('.selected').data().workOrdPrcssIdx;
			workOrdIdx = workResultListTable.row('.selected').data().workOrdIdx;
			workOrdPrcssIdx = workResultListTable.row('.selected').data().workOrdPrcssIdx;
		}
		if(deleteType == 'workOrdPrcssResult'){
			if(deleteGubun == 'btnWorkDelBundle'){
				let idx = workOrdPrcssResultTableBundle.row('.selected').data().idx;
				$.ajax({
					url: '<c:url value="/wm/workOrdPrcssResultDelBundle"/>',
		            type: 'POST',
		            data: {
			            'idx'				:	function(){ return idx; },
		            	'workOrdIdx'		:	function(){ return workOrdIdx; },
		            	'workOrdPrcssIdx'	:	function(){ return workOrdPrcssIdx; },
		            },
		            beforeSend: function() {
		            	$('#my-spinner').show();
		            },
					success : function(res) {
						if (res.result == "ok") { //응답결과
							toastr.success('삭제되었습니다.');
							workOrdPrcssResultTableBundle.rows('.selected').deselect();
							workOrdPrcssResultTableBundle.ajax.reload();
							workOrderPrcssTable.ajax.reload(function(){
								setTimeout(function() {
			            			workOrderPrcssTable.row('#'+workOrdPrcssIdx).select();
									$(workOrderPrcssTable.row('#'+workOrdPrcssIdx).node()).trigger('click'); // 선택처리
									let data = workOrderPrcssTable.row('.selected').data();

									inputBundleModalTable.ajax.reload(function(){
										if(data.progressStatus == 'PI'){
											workInputDisabled(true);
											$(inputBundleModalTable.nodes()).find('td').find('input[name=inputQty]').attr('disabled',true);
										} else if(data.progressStatus == 'WI'){
											workInputDisabled(false);
											$(inputBundleModalTable.nodes()).find('td').find('input[name=inputQty]').attr('disabled',false);
										} else if(data.progressStatus == 'WC'){
											workInputDisabled(true);
											$(inputBundleModalTable.nodes()).find('td').find('input[name=inputQty]').attr('disabled',true);
										}
											
										$('#inputBundleModalTable tbody tr').find('td').find('input[name=inputQty]').val(removeCommas($('#workOrdQtyBundle').text()));
										});
									
								}, 100)
							});
							//workPrcssCheckAndReload();
							
						} else if(res.result == 'fail') {
							toastr.warning(res.message);
						} else {
							toastr.error(res.message);
						}
						$('#my-spinner').hide();
					}
				});
			} else{
				let idx = workResultListTable.row('.selected').data().idx;
				$.ajax({
					url: '<c:url value="/wm/workOrdPrcssResultDel"/>',
		            type: 'POST',
		            data: {
			            'idx'				:	function(){ return idx; },
		            	'workOrdIdx'		:	function(){ return workOrdIdx; },
		            	'workOrdPrcssIdx'	:	function(){ return workOrdPrcssIdx; },
		            },
		            beforeSend: function() {
		            	$('#my-spinner').show();
		            },
					success : function(res) {
						if (res.result == "ok") { //응답결과
							toastr.success('삭제되었습니다.');
							workResultListTable.rows('.selected').deselect();
							workResultListTable.ajax.reload();
							workOrdPrcssIdx = workOrdPrcssTempIdx;
							workOrderPrcssTable.ajax.reload(function(){
								setTimeout(function() {
			            			workOrderPrcssTable.row('#'+workOrdPrcssIdx).select();
									$(workOrderPrcssTable.row('#'+workOrdPrcssIdx).node()).trigger('click'); // 선택처리
									let data = workOrderPrcssTable.row('.selected').data();
									if(data.progressStatus == 'PI'){
										workInputDisabled(true);
									} else if(data.progressStatus == 'WI'){
										workInputDisabled(false);
									} else if(data.progressStatus == 'WC'){
										workInputDisabled(true);
									}
								}, 100)
							});
							//workPrcssCheckAndReload();
							purchaseMatrlModalTable.ajax.reload();
						} else if(res.result == 'fail') {
							toastr.warning(res.message);
						} else {
							toastr.error(res.message);
						}
						$('#my-spinner').hide();
					}
				});
			}
		}
	});

	function workOrdPrcssResultModal(data,name,gubun){
		workMethodJson = data.workMethodJson;
		workMethod = data.workMethod;
		
		if(data.descCheckYn == 'Y'){
			$('#workOrdBeforePrcssDescCheck'+name).prop('checked',true);
			$('#workOrdBeforePrcssDescCheck'+name).attr('disabled',true);
		} else {
			$('#workOrdBeforePrcssDescCheck'+name).prop('checked',false);
			$('#workOrdBeforePrcssDescCheck'+name).attr('disabled',false);
		}

		if(gubun == 'open'){
			$('#printingYnCheck'+name).text(data.printingYnCheck);
			$('#bizDealCorpNm'+name).text(data.dealCorpNm);
			$('#etc7'+name).text(data.etc7);
			$('#etc8'+name).text(data.etc8);
			$('#etc9'+name).text(data.etc9);
			$('#inspectMethodNm'+name).text(data.inspectMethodNm);
			$('#relayNotice'+name).text(data.relayNotice);
			$('#specialNotice'+name).text(data.specialNotice);
			$('#packMethodNm'+name).text(data.packMethodNm);
			//$('#packUnit'+name).text(data.packUnit);
			$('#packUnit'+name).val(data.packUnit);
			$('#bundleUnit'+name).text(data.bundleUnit);
			$('#bundleMethodNm'+name).text(data.bundleMethodNm);
			$('#pressMethod'+name).text(data.pressMethod);
			$('#moldingMethod'+name).text(data.moldingMethod);
			$('#moldingContents'+name).text(data.moldingContents);
			$('#etc6'+name).text(data.etc6);
			$('#etc3'+name).text(data.etc3);
			$('#etc4'+name).text(data.etc4);
			$('#etc5'+name).text(data.etc5);
			$('#etc2Cd'+name).text(data.etc2Cd);
			$('#holeWoodenCd'+name).text(data.holeWoodenCd);
			$('#coatingMethod'+name).text(data.coatingMethod);
			$('#allWorkOrdQty'+name).text(addCommas(parseFloat(data.allWorkOrdQty != null && data.allWorkOrdQty != '' ? data.allWorkOrdQty : 0 )));
			$('#modalBizOrdDtlNo'+name).text(data.bizOrdDtlNo);
			$('#modalPrcssNm'+name).text(data.prcssNm);
			$('#itemNm'+name).text(data.itemNm);
			$('#itemColor'+name).text(data.itemColor);
			$('#customerItemCd'+name).text(data.customerItemCd);
			$('#itemVersion'+name).text(data.itemVersion);
			$('#itemFrequency'+name).text(data.frequency);
			$('#workMethodMultiSelect'+name).text(data.workMethod);
			if(data.ext != null && data.ext != '' && data.uuid != null && data.uuid != ''){
				$('#itemVersionLink'+name).attr('href','/serverFile/'+data.uuid+'.'+data.ext);
				let fileObject = new Object();
				fileObject.uuid = data.uuid;
				fileObject.ext = data.ext;
				//let blob = getFileBlob(fileObject);
				//$('#imgView').attr('style','');
				//$('#viewer').attr('src','data:image/jpeg;base64,'+blob);
				
			} else {
				$('#itemVersionLink'+name).removeAttr('href');
				//$('#imgView').attr('style','');
				//$('#viewer').attr('src','data:image/jpeg;base64,');
			}
		}
		$('#knifeTipSize'+name).text(data.knifeTipSize);
		$('#woodenCareCd'+name).text(data.woodenWdCd);		
		$('#resinBoard'+name).text(data.resinBoardWdCd);
		$('#itemSize'+name).text(data.itemSize);
		$('#bizOrdIssue'+name).text(data.bizOrdIssue);
		$('#workOrdDesc'+name).text(data.workOrdDesc);	
		$('#bizOrdNote'+name).text(data.bizOrdNote);
		let workOrdQtyVal = data.workOrdQty != null && data.workOrdQty != '' ? data.workOrdQty : 0; 
		let addCuttingVal = data.addCutting != null && data.addCutting != '' ? data.addCutting : 0; 
		$('#workOrdQty'+name).text(addCommas(parseFloat(workOrdQtyVal) + parseFloat(addCuttingVal)));
		let bizOrdQty = isEmptyCheck(data.bizOrdQty) ? 0 : data.bizOrdQty; 
		$('#bizOrdQty'+name).text(addCommas(parseFloat(bizOrdQty)));
		
		let beforePrcssDesc = data.beforePrcssDesc != null && data.beforePrcssDesc != '' ? data.beforePrcssDesc : '';
		$('#workOrdBeforePrcssDesc'+name).val(beforePrcssDesc.replaceAll('\\n','\n'));
		
		$('#workOrderPrcss'+name+'Modal').modal('show');
		$('#my-spinner').show();

		if(data.workDate != null && data.workDate != ''){
			$('#workDate'+name).val(moment(data.workDate,'YYYYMMDD').format('YYYY-MM-DD'));
			
		} else {
			$('#workDate'+name).val(moment().format('YYYY-MM-DD'));
			$('#workEndTime'+name).val(moment().format('YYYY-MM-DD HH:mm'));	
		} 

		//시작시간
		if(data.workStartTime != null && data.workStartTime != ''){
			$('#workStartTime'+name).val(moment(data.workStartTime,'YYYYMMDD HHmm').format('YYYY-MM-DD HH:mm'));
			$('#workEndTime'+name).val(moment(data.workEndTime,'YYYYMMDD HHmm').format('YYYY-MM-DD HH:mm'));	
		} else {
			$('#workStartTime'+name).val('');
			$('#workEndTime'+name).val(moment().format(''));
		} 
		
		if(data.fairQty != null && data.fairQty != ''){
			$('#workQty'+name).val(addCommas(parseFloat(data.fairQty)));
		} else {
			$('#workQty'+name).val('0');
		}
		if(data.faultyQty != null && data.faultyQty != ''){
			$('#workFaultyQty'+name).val(addCommas(parseFloat(data.faultyQty)));
		} else {
			$('#workFaultyQty'+name).val('0');
		}
		if(data.workAddCuttingQty != null && data.workAddCuttingQty != ''){
			$('#workAddCuttingQty'+name).val(addCommas(parseFloat(data.workAddCuttingQty)));
		} else {
			$('#workAddCuttingQty'+name).val('0');
		}
		$('#faultyReason'+name).val(data.faultyReason);
		$('#fieldDesc'+name).val(data.prcssDesc != null && data.prcssDesc != '' ? data.prcssDesc : '');
		//반환값이0-> R문자가 있는경우, 없을 경우 -> -1
		let qtyUnitNm = data.qtyUnitNm != null && data.qtyUnitNm != '' ? data.qtyUnitNm : '';
		if(qtyUnitNm.indexOf('R') == -1){
			prcssQtyUnit = false;
			$('#workQtyRChange'+name).val('');
			$('#workFaultyQtyRChange'+name).val('');
		} else {
			prcssQtyUnit = true;
			let rVal = (parseInt($('#workQty'+name).val().replaceAll(',','') / 500)) + 'R' +(parseInt($('#workQty'+name).val().replaceAll(',','') % 500));
			$('#workQtyRChange').val(rVal);
			let rFaultyVal = (parseInt($('#workFaultyQty'+name).val().replaceAll(',','') / 500)) + 'R' +(parseInt($('#workFaultyQty'+name).val().replaceAll(',','') % 500));
			$('#workFaultyQtyRChange'+name).val(rFaultyVal);
		}
		$('#workPrcssQtyUnit'+name).val(data.qtyUnitNm);
		$('#workPrcssFaultyQtyUnit'+name).val(data.qtyUnitNm);
		if(name=='Bundle'){
			inputBundleModalTable.rows('.selected').deselect();
			
			inputBundleModalTable.ajax.reload(function() {
				setTimeout(function(){
					//전공정실적
					let unitNm = data.beforeQtyUnitNm != null && data.beforeQtyUnitNm != '' ? data.beforeQtyUnitNm : ''; 
		
					if(data.qtyUnitNm == '매' && unitNm == '통'){
						if(data.beforeFairQty != null && data.beforeFairQty !=''){
							//$('#workOrdBeforePrcssQtyHidden'+name).text(addCommas(parseFloat(data.beforeFairQty)) + unitNm);
							//$('#workOrdBeforePrcssQty'+name).text(addCommas(parseFloat(data.beforeFairQty) * parseFloat(purchaseMatrlModalTable.row(0).data().eaQty)) + data.qtyUnitNm);
						} else {
							$('#workOrdBeforePrcssQtyHidden'+name).text('0'+unitNm);
							$('#workOrdBeforePrcssQty'+name).text('0' + data.qtyUnitNm);
						}
					} else {
						if(data.beforeFairQty != null && data.beforeFairQty !=''){
							$('#workOrdBeforePrcssQtyHidden'+name).text('');
							$('#workOrdBeforePrcssQty'+name).text(addCommas(parseFloat(data.beforeFairQty)) + unitNm);
						} else {
							$('#workOrdBeforePrcssQtyHidden'+name).text('');
							$('#workOrdBeforePrcssQty'+name).text('0'+unitNm);
						}
					}
					if(data.progressStatus == 'PI'){
						$(inputBundleModalTable.nodes()).find('td').find('input[name=inputQty]').attr('disabled',true);
					} else if(data.progressStatus == 'WI'){
						$(inputBundleModalTable.nodes()).find('td').find('input[name=inputQty]').attr('disabled',false);
					} else if(data.progressStatus == 'WC'){
						$(inputBundleModalTable.nodes()).find('td').find('input[name=inputQty]').attr('disabled',true);
					}
					$(inputBundleModalTable.nodes()).find('td').find('input[name=inputQty]').val(addCommas(parseFloat(removeCommas($('#workOrdQtyBundle').text()))));
					
					},200);
			});
			
			
			workOrdPrcssResultTableBundle.rows('.selected').deselect();
			workOrdPrcssResultTableBundle.ajax.reload(function(){
				if( $('#workOrdPrcssResultTableBundle tbody tr').length - $('#workOrdPrcssResultTableBundle tbody tr').find('.dataTables_empty').length > 0 ){
					workOrdPrcssResultTableBundle.row(0).select();
				}
				workOrdPrcssResultTableBundle.draw(false).columns.adjust();
			});
		} else {
			purchaseMatrlModalTable.ajax.reload(function() {
				setTimeout(function(){
					purchaseMatrlModalTable.columns.adjust();
					//전공정실적
					let unitNm = data.beforeQtyUnitNm != null && data.beforeQtyUnitNm != '' ? data.beforeQtyUnitNm : ''; 
		
					if(data.qtyUnitNm == '매' && unitNm == '통'){
						if(data.beforeFairQty != null && data.beforeFairQty !=''){
							$('#workOrdBeforePrcssQtyHidden'+name).text(addCommas(parseFloat(data.beforeFairQty)) + unitNm);
							$('#workOrdBeforePrcssQty'+name).text(addCommas(parseFloat(data.beforeFairQty) * parseFloat(purchaseMatrlModalTable.row(0).data().eaQty)) + data.qtyUnitNm);
						} else {
							$('#workOrdBeforePrcssQtyHidden'+name).text('0'+unitNm);
							$('#workOrdBeforePrcssQty'+name).text('0' + data.qtyUnitNm);
						}
					} else {
						if(data.beforeFairQty != null && data.beforeFairQty !=''){
							$('#workOrdBeforePrcssQtyHidden'+name).text('');
							$('#workOrdBeforePrcssQty'+name).text(addCommas(parseFloat(data.beforeFairQty)) + unitNm);
						} else {
							$('#workOrdBeforePrcssQtyHidden'+name).text('');
							$('#workOrdBeforePrcssQty'+name).text('0'+unitNm);
						}
					}
				},200);
			});
			
			purchaseMatrlModalTable.rows('.selected').deselect();
			//workOrdPrcssResultTable.rows('.selected').deselect();
			//workOrdPrcssResultTable.ajax.reload(function(){
			//	if( $('#workOrdPrcssResultTable tbody tr').length - $('#workOrdPrcssResultTable tbody tr').find('.dataTables_empty').length > 0 ){
			//		workOrdPrcssResultTable.row(0).select();
			//	}
			//	workOrdPrcssResultTable.draw(false).columns.adjust();;
			//});

			workResultListTable.rows('.selected').deselect();
			workResultListTable.ajax.reload(function(){
				setTimeout(function(){
					workResultListTable.columns.adjust();
				},10);
			});
		}
	}

	function workOrderModalDisabled(data,name, bool){
		if(data.descCheckYn == 'Y'){
			$('#workOrdBeforePrcssDescCheck'+name).prop('checked',true);
			$('#workOrdBeforePrcssDescCheck'+name).attr('disabled',true);
		} else {
			$('#workOrdBeforePrcssDescCheck'+name).prop('checked',false);
			$('#workOrdBeforePrcssDescCheck'+name).attr('disabled',false);
		}
		
		$('#workDate'+name).attr('disabled',bool);
		$('#workStartTime'+name).attr('disabled',bool);
		$('#workEndTime'+name).attr('disabled',bool);
		$('#workQty'+name).attr('disabled',bool);
		$('#workFaultyQty'+name).attr('disabled',bool);
		$('#workAddCuttingQty'+name).attr('disabled',bool);
		$('#faultyReason'+name).attr('disabled',bool);
		$('#fieldDesc'+name).attr('disabled',bool);
    	workOrderPrcssTable.ajax.reload(function(){
    		setTimeout(function() {
    			workOrderPrcssTable.row('#'+data.workOrdPrcssIdx).select();
				$(workOrderPrcssTable.row('#'+data.workOrdPrcssIdx).node()).trigger('click'); // 선택처리
			}, 100)
    	});
		//workOrdPrcssStatusTable.ajax.reload();
		//workPrcssDtlTable.ajax.reload();
    	//전공정실적
		/* if(data.beforeFairQty != null && data.beforeFairQty !=''){
			$('#workOrdBeforePrcssQty').text(addCommas(parseFloat(data.beforeFairQty)));
		} else {
			$('#workOrdBeforePrcssQty').text('0');
		} */
		let beforePrcssDesc = data.beforePrcssDesc != null && data.beforePrcssDesc != '' ? data.beforePrcssDesc : '';
		$('#workOrdBeforePrcssDesc'+name).val(beforePrcssDesc.replaceAll('\\n','\n'));
		
    	if(data.workDate != null && data.workDate != ''){
			$('#workDate'+name).val(moment(data.workDate,'YYYYMMDD').format('YYYY-MM-DD'));
		} else {
			$('#workDate'+name).val(moment().format('YYYY-MM-DD'));
		} 
		
    	if(data.workStartTime != null && data.workStartTime != ''){
			$('#workStartTime'+name).val(moment(data.workStartTime,'YYYYMMDD HHmm').format('YYYY-MM-DD HH:mm'));
			$('#workEndTime'+name).val(moment(data.workEndTime,'YYYYMMDD HHmm').format('YYYY-MM-DD HH:mm'));	
		} else {
			$('#workStartTime'+name).val(moment().format(''));
			$('#workEndTime'+name).val(moment().format(''));
		} 
		
		
		if(data.fairQty != null && data.fairQty != ''){
			$('#workQty'+name).val(addCommas(parseFloat(data.fairQty)));
		} else {
			$('#workQty'+name).val('0');
		}
		if(data.faultyQty != null && data.faultyQty != ''){
			$('#workFaultyQty'+name).val(addCommas(parseFloat(data.faultyQty)));
		} else {
			$('#workFaultyQty'+name).val('0');
		}
		if(data.workAddCuttingQty != null && data.workAddCuttingQty != ''){
			$('#workQty'+name).val(addCommas(parseFloat(data.workAddCuttingQty)));
		} else {
			$('#workQty'+name).val('0');
		}
		
		$('#faultyReason'+name).val(data.faultyReason);
		$('#fieldDesc'+name).val(data.prcssDesc);

		if(name == 'Bundle'){
			inputBundleModalTable.ajax.reload(function() {
				//전공정실적
				let unitNm = data.beforeQtyUnitNm != null && data.beforeQtyUnitNm != '' ? data.beforeQtyUnitNm : ''; 

				if(data.qtyUnitNm == '매' && unitNm == '통'){
					if(data.beforeFairQty != null && data.beforeFairQty !=''){
						$('#workOrdBeforePrcssQtyHidden'+name).text(addCommas(parseFloat(data.beforeFairQty)) + unitNm);
						$('#workOrdBeforePrcssQty'+name).text(addCommas(parseFloat(data.beforeFairQty) * parseFloat(purchaseMatrlModalTable.row(0).data().eaQty)) + data.qtyUnitNm);
					} else {
						$('#workOrdBeforePrcssQtyHidden'+name).text('0'+unitNm);
						$('#workOrdBeforePrcssQty'+name).text('0' + data.qtyUnitNm);
					}
				} else {
					if(data.beforeFairQty != null && data.beforeFairQty !=''){
						$('#workOrdBeforePrcssQtyHidden'+name).text('');
						$('#workOrdBeforePrcssQty'+name).text(addCommas(parseFloat(data.beforeFairQty)) + unitNm);
					} else {
						$('#workOrdBeforePrcssQtyHidden'+name).text('');
						$('#workOrdBeforePrcssQty'+name).text('0'+unitNm);
					}
				}
				$('#inputBundleModalTable tbody tr').find('td').find('input[name=inputQty]').val(removeCommas($('#workOrdQtyBundle').text()));
				$('#inputBundleModalTable tbody tr').find('td').find('input[name=inputQty]').attr('disabled',bool);
			});
			workOrdPrcssResultTableBundle.ajax.reload(function(){
				workOrdPrcssResultTableBundle.draw(false);
			});
		} else {
			purchaseMatrlModalTable.ajax.reload(function() {
				//전공정실적
				let unitNm = data.beforeQtyUnitNm != null && data.beforeQtyUnitNm != '' ? data.beforeQtyUnitNm : ''; 

				if(data.qtyUnitNm == '매' && unitNm == '통'){
					if(data.beforeFairQty != null && data.beforeFairQty !=''){
						$('#workOrdBeforePrcssQtyHidden'+name).text(addCommas(parseFloat(data.beforeFairQty)) + unitNm);
						$('#workOrdBeforePrcssQty'+name).text(addCommas(parseFloat(data.beforeFairQty) * parseFloat(purchaseMatrlModalTable.row(0).data().eaQty)) + data.qtyUnitNm);
					} else {
						$('#workOrdBeforePrcssQtyHidden'+name).text('0'+unitNm);
						$('#workOrdBeforePrcssQty'+name).text('0' + data.qtyUnitNm);
					}
				} else {
					if(data.beforeFairQty != null && data.beforeFairQty !=''){
						$('#workOrdBeforePrcssQtyHidden'+name).text('');
						$('#workOrdBeforePrcssQty'+name).text(addCommas(parseFloat(data.beforeFairQty)) + unitNm);
					} else {
						$('#workOrdBeforePrcssQtyHidden'+name).text('');
						$('#workOrdBeforePrcssQty'+name).text('0'+unitNm);
					}
				}
			});
			workResultListTable.ajax.reload(function(){
				workResultListTable.draw(false);
			});
		
		}
	}

	$('#workOrdBeforePrcssDescCheck, #workOrdBeforePrcssDescCheckBundle').on('change',function(){
		let checkYn = $(this).prop('checked') ? 'Y' : 'N';
		let id = $(this).attr('id');

		if(id == 'workOrdBeforePrcssDescCheck'){
			if( $('#workOrdBeforePrcssDesc').val() == '' ) {
				toastr.warning('확인할 공정 내용이 없습니다.');
				$(this).prop('checked',false);
				return false;
			}
		} else if(id == 'workOrdBeforePrcssDescCheckBundle'){
			if( $('#workOrdBeforePrcssDescBundle').val() == '' ) {
				toastr.warning('확인할 공정 내용이 없습니다.');
				$(this).prop('checked',false);
				return false;
			}
		}
		
		$.ajax({
			url: '<c:url value="/wm/workOrdPrcssUpd"/>',
		        type: 'POST',
		        data: {
		            'idx' : 	workOrderPrcssTable.row('.selected').data().workOrdPrcssIdx,
		            'descCheckYn'	: function(){ return checkYn; },
		        },
		        beforeSend: function() {
		        	$('#my-spinner').show();
		        },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					let data = res.data;
					if(checkYn == 'Y'){
						toastr.success('전공정 특이사항 확인되었습니다.');
						$('#workOrdBeforePrcssDescCheck').attr('disabled',true);
						$('#workOrdBeforePrcssDescCheckBundle').attr('disabled',true);
					} else {
						toastr.success('전공정 특이사항 확인 취소되었습니다.');
						$('#workOrdBeforePrcssDescCheck').attr('disabled',false);
						$('#workOrdBeforePrcssDescCheckBundle').attr('disabled',false);
					}
					
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
	});

	//번들링 수량 자동으로 똑같게 해주는기능
	$(document).on('keyup','input[name=inputQty]',function(){
		$('input[name=inputQty]').val($(this).val());
	});

	function workPrcssCheckAndReload(){
		//전 공정들이 다 작업되었는지 체크
		$.ajax({
			url: '<c:url value="/wm/checkWorkOrdPrcssFinish"/>',
            type: 'POST',
            data: {
                'workOrdIdx'	  :	function(){ return workOrdIdx; },
				'workOrdPrcssIdx' : function(){ return workOrdPrcssIdxVal; },
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if(res.result == 'ok'){
					let data = res.data;
					console.log('data:'+workStartTime)		

					if(data.beforePrcssDesc != '' && data.beforePrcssDesc != null && data.descCheckYn != 'Y'){
						//toastr.warning('전공정 특이사항을 읽은 후<br>작업해주세요.');
					} 
					if(data.resultPageNm == 'workOrderPrcssBundleModal'){
						workOrdPrcssResultModal(data,'Bundle','reload');
					} else {
						workOrdPrcssResultModal(data,'','reload');
					}
					
					//공정이 대기,완료인경우 -> 버튼 비활성화 , 공정이 진행중인 경우 -> 버튼 활성화
					//대기
					if(data.progressStatus == 'PI'){
						workInputDisabled(true);
						$('#workOrdBeforePrcssDescCheck').attr('disabled',false);
						$('#workOrdBeforePrcssDescCheckBundle').attr('disabled',false);
					} else if(data.progressStatus == 'WI'){//진행
						workInputDisabled(false);
						$('#workOrdBeforePrcssDescCheck').attr('disabled',true);
						$('#workOrdBeforePrcssDescCheckBundle').attr('disabled',true);
					} else if(data.progressStatus == 'WC'){//완료
						workInputDisabled(true);
						$('#workOrdBeforePrcssDescCheck').attr('disabled',true);
						$('#workOrdBeforePrcssDescCheckBundle').attr('disabled',true);
					}
					
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
					workOrderPrcssTable.ajax.reload(function(){},false);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
	}

	//진행취소
	$('#btnWorkCancelBundle, #btnWorkCancel').on('click',function(){
		let data = workOrderPrcssTable.row('.selected').data();
		//현 공정의 상태값 체크
		$.ajax({
			url: '<c:url value="/wm/workOrdSelWithPrcss"/>',
            type: 'POST',
            data: {
            	'workOrdIdx'	  :	function(){ return data.workOrdIdx; },
 				'workOrdPrcssIdx' : function(){ return data.workOrdPrcssIdx; },
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if(res.result == 'ok'){
					let data = res.data;
					//현공정이 대기인경우 -> 작업시작, 공정이 진행,완료중인 경우 -> 이미 진행중 toastr
					if(data.progressStatus == 'WI'){//진행
						//공정 상태 업데이트
						$.ajax({
							url: '<c:url value="/wm/workOrdPrcssWait"/>',
				            type: 'POST',
				            data: {
				            	'workOrdIdx'	  :	function(){ return data.workOrdIdx; },
				 				'workOrdPrcssIdx' : function(){ return data.workOrdPrcssIdx; },
				            },
				            beforeSend: function() {
				            	$('#my-spinner').show();
				            },
				            success : function(res) {
				            	if(res.result == 'ok'){
				            		let data = res.data;
									checkVo = data;
									toastr.success('공정 진행 취소 되었습니다.');
									$('#workOrderPrcssModal').modal('hide');
									$('#workOrderPrcssBundleModal').modal('hide');
									workOrderPrcssTable.ajax.reload(function(){
 										let reloadEndData = workOrderPrcssTable.data().toArray();
										//해당 checkVo의 idx가 현재 리로드된 테이블에 데이터가 없을 경우
										if(!reloadEndData.map(v=>v.workOrdPrcssIdx).includes(checkVo.workOrdPrcssIdx)){
											workOrderPrcssTable.row('.selected').deselect();
											//workOrdPrcssStatusTable.clear().draw();
											workPrcssDtlTable.clear().draw();
											inputMaterialHistTable.clear().draw();
										} else {
											//있을경우
											setTimeout(function() {
						            			workOrderPrcssTable.row('#'+checkVo.workOrdPrcssIdx).select();
												$(workOrderPrcssTable.row('#'+checkVo.workOrdPrcssIdx).node()).trigger('click'); // 선택처리
											}, 100)
										}
									});
				            	} else if(res.result == 'fail') {
									toastr.warning(res.message);
								} else {
									toastr.error(res.message);
								}
				            	$('#my-spinner').hide();
				            }
						});
					} else if(data.progressStatus == 'WC'){//완료
						toastr.warning('이미 작업완료된 공정입니다.');
					} else if(data.progressStatus == 'PI'){
						toastr.warning('대기 중인 공정입니다.');
					}
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
	});

	//작업중지 버튼 클릭 시
	$('#btnCompulsionEnd, #btnCompulsionEndBundle').on('click',function(){
		$('#compulsionEndModal').modal('show');
	});

	
	$('#btnCompulsionEndY').on('click',function(){
		$('#my-spinner').show();

		$.ajax({
			url: '<c:url value="/bs/bizOrderDtlStop"/>',
			type: 'POST',
			data: {
				'idx'		: function(){ return workOrderPrcssTable.row('.selected').data().bizOrdDtlIdx; },
				'bizStopYn'	: function(){ return 'Y' },
			},
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					toastr.success('작업중지되었습니다.');
					$('#workOrderPrcssModal').modal('hide');
					$('#workOrderPrcssBundleModal').modal('hide');
					
					trId = workOrderPrcssTable.row('.selected').data().workOrdPrcssIdx;
					workOrderPrcssTable.ajax.reload(function(){
						let reloadEndData = workOrderPrcssTable.data().toArray();
						//해당 checkVo의 idx가 현재 리로드된 테이블에 데이터가 없을 경우
						if(!reloadEndData.map(v=>v.workOrdPrcssIdx).includes(trId)){
							workOrderPrcssTable.row('.selected').deselect();
							//workOrdPrcssStatusTable.clear().draw();
							workPrcssDtlTable.clear().draw();
							inputMaterialHistTable.clear().draw();
						} else {
							//있을경우
							setTimeout(function() {
		            			workOrderPrcssTable.row('#'+trId).select();
								$(workOrderPrcssTable.row('#'+trId).node()).trigger('click'); // 선택처리
							}, 100)
						}
					});
					
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
	});

	/*
	$('#btnCompulsionEndBundle').on('click',function(){
		$('#compulsionEndModal').modal('show');
	});

	$('#btnCompulsionEndY').on('click',function(){
		$.ajax({
			url: '<c:url value="/wm/workOrdForcedPrcssEnd"/>',
            type: 'POST',
            data: {
                'workOrdIdx'	:	function(){ return workOrderPrcssTable.row('.selected').data().workOrdIdx; },
                'bizOrdDtlIdx'	:	function(){ return workOrderPrcssTable.row('.selected').data().bizOrdDtlIdx; },
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					toastr.success('강제 완료 되었습니다.');
					$('#workOrderPrcssModal').modal('hide');
					$('#workOrderPrcssBundleModal').modal('hide');
					trId = workOrderPrcssTable.row('.selected').data().workOrdPrcssIdx;
					workOrderPrcssTable.ajax.reload(function(){
						let reloadEndData = workOrderPrcssTable.data().toArray();
						//해당 checkVo의 idx가 현재 리로드된 테이블에 데이터가 없을 경우
						if(!reloadEndData.map(v=>v.workOrdPrcssIdx).includes(trId)){
							workOrderPrcssTable.row('.selected').deselect();
							//workOrdPrcssStatusTable.clear().draw();
							workPrcssDtlTable.clear().draw();
							inputMaterialHistTable.clear().draw();
						} else {
							//있을경우
							setTimeout(function() {
		            			workOrderPrcssTable.row('#'+trId).select();
								$(workOrderPrcssTable.row('#'+trId).node()).trigger('click'); // 선택처리
							}, 100)
						}
					});
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
	});
	*/

	//실적등록창의 실적리스트
	let workResultListTable = $('#workResultListTable').DataTable({
		dom : "<'row'<'col-md-12 col-md-6'l><'col-md-12 col-md-6'f>>"
				+ "<'row'<'col-md-12'tr>>"
				+ "<'row pt-1'<'d-flex align-items-center d-flex'><'me-lg-auto'><'d-flex align-items-center justify-content-end'>>",
		language: lang_kor,
		info: true,
		ordering: false,
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
        	url : '<c:url value="/wm/workOrdResultListByWorkOrdIdx"/>',
			type : 'POST',
			data : {
				workOrdIdx	: function() { return workOrdIdx; }
			},
		}, 
        rowId: 'workOrdPrcssIdx',
		columns : [
			{ data:'progressStatus', className : 'text-center align-middle',//진행상태
				render : function(data, type, row, meta) {
					return progressStatusListMap.get(data);
				}
			},
			{ data:'prcssNm', className : 'text-center align-middle',//공정
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ data:'equipNm', className : 'text-center align-middle',//설비명
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ data:'produceQtyUnitNm', className : 'text-center align-middle',//작업단위
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},
			/* { data:'ordQty', className : 'text-end align-middle',//정매수
				render : function(data, type, row, meta) {
					let ordQty = parseInt(row['purchaseOrdQty']); // 주문수량(제품)
					let cutQty = parseInt(row['cutQty']); // 절수
					let eaQty = parseInt(row['eaQty']); // 개수
					let extraQty = parseInt(row['extraQty']); // 여유분
					let extraPackQty = parseInt(row['extraPackQty']); // 포장단위여분

					if(row['purchaseOrdQty'] == 'notPurchase'){//발주를 하지않은 경우
						return '-';
					} else if(cutQty == 0 || eaQty == 0) {
						return '0';
					} else {
						//let printPressQty = Math.ceil(ordQty/eaQty);
						let printPressQty = Math.ceil(ordQty/(cutQty*eaQty)) * cutQty;
						//여기선
						let printPressAndExtraQty = printPressQty + extraQty + (extraPackQty*cutQty) ;
						
						let R = parseInt(printPressAndExtraQty/500) + 'R' + parseInt(printPressAndExtraQty%500);   
						
						let html = '';
						html += '<div class="row">';
						html += '	<div class="text-end align-middle" style="white-space:nowrap;width:50%;">'+R+'</div>';
						html += '	<div class="text-end align-middle" style="white-space:nowrap;width:50%;">'+addCommas(printPressAndExtraQty)+'</div>';
						html += '</div>';
						
						return html;
					}
				
				}
			}, */
			{ data:'calOrdQty', className : 'text-center align-middle',//정매수
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return addCommas(parseInt(data));
					} else {
						return '-';
					}
				
				}
			},
			{ data: 'fairQty', className : 'text-center align-middle',//생산량
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						let fairQty = isEmptyCheck(row['fairQty']) ? 0 : parseInt(row['fairQty']);
						let workAddCuttingQty = isEmptyCheck(row['workAddCuttingQty']) ? 0 : parseInt(row['workAddCuttingQty']);
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(fairQty))+'</div>';
					} else {
						return '0';
					}
				}
			},
			{ data:'nextExtraQty', className : 'text-center align-middle',//여분컬럼
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return addCommas(parseInt(data));
					} else {
						return '-';
					}
				
				}
			},
			{ data: 'faultyQty', className : 'text-center align-middle',//손지
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						let faultyQty = isEmptyCheck(row['faultyQty']) ? 0 : parseInt(row['faultyQty']);
						let workAddCuttingQty = isEmptyCheck(row['workAddCuttingQty']) ? 0 : parseInt(row['workAddCuttingQty']);
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(faultyQty + workAddCuttingQty))+'</div>';
					} else {
						return '0';
					}
				}
			},
			{ data: 'workDate', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data).format('YYYY-MM-DD')+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ data:'regUserNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},
		],
		columnDefs : [
			{ "width": "9.375%", "targets": 0 },
			{ "width": "9.375%", "targets": 1 },
			{ "width": "9.375%", "targets": 2 },
			{ "width": "9.375%", "targets": 3 },
			{ "width": "12.5%", "targets": 4 },
			{ "width": "12.5%", "targets": 5 },
			{ "width": "12.5%", "targets": 6 },
			{ "width": "12.5%", "targets": 7 },
			{ "width": "12.5%", "targets": 8 },
			/*{
				targets: '_all',
				render: function(data) {
					if(data != null && data != ''){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},*/
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
			
			//let htmlHeight = parseFloat($('#matrlGroup').css('height'));
			//let theadHeight = parseFloat($('#workResultListTable_wrapper').find('.dataTables_scrollHead').css('height'));
			//$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight )+'px');
			//$('#workResultListTable_wrapper').css('height','100%');
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAll').off('keyup',function() {});
			$('#searchAll').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			});

			let rowData = api.data().toArray();
			if(rowData.length != 0){
				for(var i = 0; i < rowData.length ; i++){
					if(rowData[i].workOrdPrcssIdx == workOrdPrcssIdxVal){
						let node = api.row('#'+rowData[i].workOrdPrcssIdx).node();
						$(node).css('background-color','rgb(246 242 195)');
					}
					if(rowData[i].progressStatus == 'PI'){
						let node = api.row('#'+rowData[i].workOrdPrcssIdx).node();
						$(node).find('td').eq(0).css('font-weight','900');
					} else if(rowData[i].progressStatus == 'WI'){
						let node = api.row('#'+rowData[i].workOrdPrcssIdx).node();
						$(node).find('td').eq(0).css('color','blue').css('font-weight','900');
					} else if(rowData[i].progressStatus == 'WC'){
						let node = api.row('#'+rowData[i].workOrdPrcssIdx).node();
						$(node).find('td').eq(0).css('color','green').css('font-weight','900');
					}
				}
			}
			
			try {
				workResultListTable.columns.adjust();
			} catch{

			}

			//선택된 공정의 위치가 밑에서 2번째 ( 4개의 행 중 위에서 3번째)에 오도록 스크롤 조정
			let rowArrayIndex = rowData.findIndex(v => v.workOrdPrcssIdx == workOrdPrcssIdxVal);
			if( rowArrayIndex != '-1' ){
				//해당 공정의 포지션 노드
				let rowPosNode = workResultListTable.row('#'+rowData[rowArrayIndex].workOrdPrcssIdx).node();
				//해당 공정이 탑으로부터 떨어진 거리
				let offSetTopVal = workResultListTable.row('#'+rowData[rowArrayIndex].workOrdPrcssIdx).node().offsetTop;
				//tr 하나의 높이 * 2 해서 위에로부터 추가로 떨어져야할 거리
				let trHeight = parseInt($(rowPosNode).css('height')) * 2;
				
				
				$('#workResultListTable').parent().scrollTop(offSetTopVal - trHeight);
			}
		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#workResultListTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();
				
				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#workResultListTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	workResultListTable.on('column-reorder', function( e, settings, details ) {
		let api = workResultListTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#workResultListTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	function showWorkResultWarningModal() {
		return new Promise(function(resolve, reject) {
			$('#workResultWarningModal').modal('show');
		   
		    $('#btnWorkResultWarningModalY').on('click', function() {
		    	$('#workResultWarningModal').modal('hide');
		    	resolve(); 
		    });
		    
		    $('#btnWorkResultWarningModalN').on('click', function() {
		    	$('#workResultWarningModal').modal('hide');
		    	reject(); 
		    });
		});
	}
	
	/**************** 작업지시서 인쇄 ****************/
	
	// 접지라벨 출력, CTCP라벨 출력
	$('#workOrderPrcssTable').on('click', 'button[name="btnGroundPrint"], button[name="btnCtcpPrint"]', function () {
		//해당 스타일시트날리고
		$('#printPaperTypeStyle').remove();
		//스타일시트 생성
		$('<style>')
			.prop('type', 'text/css').prop('id','printPaperTypeStyle').prop('media','print')
			.html('@media print { @page { size: A4 portrait; margin: 3mm; }, html, body { width: 210mm; height: 297mm; } }')
			.appendTo('body');
		
		$('#labelPrintTable').find('tr').remove(); //1. 테이블 행 삭제
		
		const clickedButton = $(this); // 클릭한 버튼을 변수에 저장
    	const rowData = workOrderPrcssTable.row($(this).closest('tr')).data(); //선택한 행 데이터
    	let groundPrintYn = null; //접지라벨 출력여부
    	let ctcpPrintYn = null; //CTCP라벨 출력여부

		if(rowData.workOrdPrcssIdx.includes("BIZ")){
			toastr.warning('작업지시 대기인 항목은<br>클릭 할 수 없습니다.');
		} else {
			if ($(this).attr('name') === 'btnGroundPrint') { //접지라벨
	    		
	    		$('#trlabelPrintAppendTarget').after(makeEmptyTrWithGround()); //2. 테이블 행 추가
	    		
	    		//1) 변수 설정
	    		const bizOrdDtlNo = rowData.bizOrdDtlNo != null ? rowData.bizOrdDtlNo : ''; //수주번호
	    		const itemCd = rowData.itemCd != null ? rowData.itemCd : ''; //제품코드
	    		const itemNm = rowData.itemNm != null ? rowData.itemNm : ''; //제품명
	    		const customerItemCd = rowData.customerItemCd != null ? rowData.customerItemCd : ''; //자재코드
	    		const versionNum = rowData.versionNum != null ? rowData.versionNum : ''; //버전번호
	    		
	    		//2) 값 입력
	    		$('#labelPrintTable [name=bizOrdDtlNo]').text( bizOrdDtlNo ); //수주번호
	    		//$('#labelPrintTable [name=itemCd]').text( itemCd ); //제품코드
	    		$('#labelPrintTable [name=itemNm]').text( itemNm ); //제품명
	    		$('#labelPrintTable [name=customerItemCd]').text( customerItemCd ); //자재코드
	    		$('#labelPrintTable [name=versionNum]').text( versionNum ); //버전번호
	    		
	    		groundPrintYn = 'Y'; //접지라벨 출력여부
	    	} else if ($(this).attr('name') === 'btnCtcpPrint') { //CTCP라벨
	    		
				$('#trlabelPrintAppendTarget').after(makeEmptyTrWithCtcp()); //2. 테이블 행 추가
	    		
	    		//1) 변수 설정
	    		const nowDate = moment().format("YYYY-MM-DD HH:mm"); //현재날짜
	    		const bizOrdDtlNo = rowData.bizOrdDtlNo != null ? rowData.bizOrdDtlNo : ''; //수주번호
	    		const itemNm = rowData.itemNm != null ? rowData.itemNm : ''; //제품명
	    		const frequencyNm = rowData.frequencyNm != null ? rowData.frequencyNm : ''; //도수
	    		const coatingMethod = rowData.coatingMethod != null ? rowData.coatingMethod : ''; //코팅방법
	    		
	    		//2) 값 입력
	    		$('#labelPrintTable [name=nowDate]').text( nowDate ); //현재날짜
	    		$('#labelPrintTable [name=bizOrdDtlNo]').text( bizOrdDtlNo ); //수주번호
	    		$('#labelPrintTable [name=itemNm]').text( itemNm ); //제품명
	    		$('#labelPrintTable [name=frequencyNm]').text( frequencyNm ); //도수
	    		$('#labelPrintTable [name=coatingMethod]').text( coatingMethod ); //코팅방법
	    		
	    		ctcpPrintYn = 'Y'; //CTCP라벨 출력여부
	    	}
	    	
	    	cssChangeWithLabelPrint(); //3. CSS 적용
			
			$('#labelPrintTable').print({ //4. 출력
				globalStyles: true,
				mediaPrint: true
			});
	    	
	    	//라벨 출력여부 등록
			$.ajax({
				url: '<c:url value="/wm/workOrdPrcssUpd"/>',
		        type: 'POST',
		        data: {
		            'idx' 			: rowData.workOrdPrcssIdx,
		            ...(groundPrintYn === 'Y' ? {'groundPrintYn': groundPrintYn} : {}), //접지라벨 출력여부
		            ...(ctcpPrintYn === 'Y' ? {'ctcpPrintYn': ctcpPrintYn} : {}), //CTCP라벨 출력여부
		        },
		        beforeSend: function() {
		        	$('#my-spinner').show();
		        },
				success : function(res) {
					if (res.result == "ok") {
						//출력 후 버튼 색상 변경 처리
				    	clickedButton.removeClass('btn-outline-light').addClass('btn-success');
					} else {
						toastr.error(res.message);
					}
					$('#my-spinner').hide();
				}
			});
		}
    	
    });
	
	function cssChangeWithLabelPrint() {
		$('#labelPrintTable').find('td').css('border', '1px solid black');
		$('#labelPrintTable').find('td').css('padding', '0.1rem');
		$('#labelPrintTable').find('td').css('color', '#000000');
		$('#labelPrintTable').find('td').css('vertical-align', 'middle');

		$('#labelPrintTable').find('.ff-gyeon').css('font-family', 'HY견고딕, serif');
		$('#labelPrintTable').find('.ff-head').css('font-family', 'HYHeadLine, serif');
		$('#labelPrintTable').find('.ff-dod').css('font-family', '돋움, serif');
		$('#labelPrintTable').find('.fw900').css('font-weight', '900');
		$('#labelPrintTable').find('.fw-bold').css('font-weight', 'bold');
		$('#labelPrintTable').find('.bd2px').css('border', '2px solid black');
		
		$('#labelPrintTable').find('.bg-gray').css('background-color', '#C9C9C9');
		
		$('#labelPrintTable').find('.theadFirstCol').css('border-top', '0px');
		$('#labelPrintTable').find('.theadNotFisrtCol').css('border-top', '0px');
		$('#labelPrintTable').find('.theadNotFisrtCol').css('border-left', '0px');
		
		$('#labelPrintTable').find('.tbodyFirstCol').css('border-top', '0px');
		$('#labelPrintTable').find('.tbodyNotFirstCol').css('border-top', '0px');
		$('#labelPrintTable').find('.tbodyNotFirstCol').css('border-left', '0px');

		$('#labelPrintTable').find('.fc-red').css('color', '#ff0000');
		$('#labelPrintTable').find('.fc-blue').css('color', '#0070C0');
		$('#labelPrintTable').find('.fs-8').css('font-size', '8px');
		$('#labelPrintTable').find('.fs-10').css('font-size', '10px');
		$('#labelPrintTable').find('.fs-11').css('font-size', '11px');
		$('#labelPrintTable').find('.fs-12').css('font-size', '12px');
		$('#labelPrintTable').find('.fs-13').css('font-size', '13px');
		$('#labelPrintTable').find('.fs-15').css('font-size', '15px');
		$('#labelPrintTable').find('.fs-20').css('font-size', '20px');
		$('#labelPrintTable').find('.fs-25').css('font-size', '25px');
		$('#labelPrintTable').find('.fs-30').css('font-size', '30px');
		$('#labelPrintTable').find('.fs-40').css('font-size', '40px');
		$('#labelPrintTable').find('.fs-50').css('font-size', '50px');
		$('#labelPrintTable').find('.fs-55').css('font-size', '55px');
		$('#labelPrintTable').find('.fs-60').css('font-size', '60px');
		$('#labelPrintTable').find('.fs-65').css('font-size', '65px');
		$('#labelPrintTable').find('.fs-70').css('font-size', '70px');
		$('#labelPrintTable').find('.fs-80').css('font-size', '80px');
		$('#labelPrintTable').find('.fs-90').css('font-size', '90px');
		$('#labelPrintTable').find('.fs-95').css('font-size', '95px');
		$('#labelPrintTable').find('.fs-100').css('font-size', '100px');
		$('#labelPrintTable').find('.fc-red').css('color', '#ff0000');
		$('#labelPrintTable').find('.bt-2').css('border-top', '2px solid black');
		$('#labelPrintTable').find('.bd-n').css('border', '0px solid #ffffff');
		$('#labelPrintTable').find('.bt-n').css('border-top', '0px solid #ffffff');
		$('#labelPrintTable').find('.br-n').css('border-right', '0px solid #ffffff');
		$('#labelPrintTable').find('.bb-n').css('border-bottom', '0px solid #ffffff');
		$('#labelPrintTable').find('.bl-n').css('border-left', '0px solid #ffffff');
		$('#labelPrintTable').find('.h-5').css('height', '5px');
		$('#labelPrintTable').find('.h-10').css('height', '10px');
		$('#labelPrintTable').find('.h-15').css('height', '15px');
		$('#labelPrintTable').find('.h-20').css('height', '20px');
		$('#labelPrintTable').find('.h-25').css('height', '25px');
		$('#labelPrintTable').find('.h-30').css('height', '30px');
		$('#labelPrintTable').find('.h-40').css('height', '40px');
		$('#labelPrintTable').find('.h-55').css('height', '55px');
		$('#labelPrintTable').find('.h-70').css('height', '70px');
		$('#labelPrintTable').find('.h-75').css('height', '75px');
		$('#labelPrintTable').find('.h-90').css('height', '90px');
		$('#labelPrintTable').find('.h-100').css('height', '100px');
		$('#labelPrintTable').find('.h-115').css('height', '115px');
		$('#labelPrintTable').find('.h-130').css('height', '130px');
		$('#labelPrintTable').find('.h-140').css('height', '140px');
		$('#labelPrintTable').find('.h-150').css('height', '150px');
		$('#labelPrintTable').find('.h-200').css('height', '200px');
		$('#labelPrintTable').find('.h-250').css('height', '250px');
		$('#labelPrintTable').find('.h-280').css('height', '280px');
		$('#labelPrintTable').find('.h-300').css('height', '300px');
		$('#labelPrintTable').find('.h-330').css('height', '330px');
		$('#labelPrintTable').find('.h-350').css('height', '350px');
		$('#labelPrintTable').find('.h-400').css('height', '400px');
		$('#labelPrintTable').find('.h-450').css('height', '450px');
		$('#labelPrintTable').find('.maxh-5').css('max-height', '5px');
		$('#labelPrintTable').find('.maxh-10').css('max-height', '10px');
		$('#labelPrintTable').find('.maxh-20').css('max-height', '20px');
		$('#labelPrintTable').find('.maxh-25').css('max-height', '25px');
		$('#labelPrintTable').find('.maxh-30').css('max-height', '30px');
		$('#labelPrintTable').find('.maxh-40').css('max-height', '40px');
		$('#labelPrintTable').find('.maxh-55').css('max-height', '55px');
		$('#labelPrintTable').find('.maxh-70').css('max-height', '70px');
		$('#labelPrintTable').find('.maxh-75').css('max-height', '75px');
		$('#labelPrintTable').find('.maxh-100').css('max-height', '100px');
		$('#labelPrintTable').find('.lh-1').css('line-height', '1');
		$('#labelPrintTable').find('.lh-1_1').css('line-height', '1.1');
		$('#labelPrintTable').find('.lh-1_2').css('line-height', '1.2');
		$('#labelPrintTable').find('.lh-2').css('line-height', '2');
		$('#labelPrintTable').find('.lh-2_4').css('line-height', '2.4');
		
		// 글자의 길이에 따라 폰트 사이즈가 달라지도록 구현 (임시방편으로 하드코딩 함. 더 좋은 코드로 개선 필요)
		const $coatingMethodCell = $('#labelPrintTable').find('.fs-auto'); //CTCP라벨 코팅방법 셀
		const cellWidth = 279.644; // 셀 가로길이
		const maxFontSize = 95; // 최대 글꼴 크기
		const minFontSize = 10; // 최소 글꼴 크기
		const text = $coatingMethodCell.text().trim();

		// 글꼴 크기 조정을 위해 설정된 최대, 최소 폰트 크기를 기준으로 계산
		const fontSize = Math.min(maxFontSize, Math.max(minFontSize, cellWidth / (text.length * 1.15)));
		$coatingMethodCell.css('font-size', fontSize + 'px'); // 폰트 크기를 설정
		
		// 인쇄할 때 css 적용하려면 important 붙여줘야함.
		for(var i=0;i<$('#labelPrintTable').find('td').length;i++) {
			let tdStyle = $('#labelPrintTable').find('td').eq(i).attr('style') == undefined?'':$('#labelPrintTable').find('td').eq(i).attr('style');
			$('#labelPrintTable').find('td').eq(i).attr('style',tdStyle.replaceAll(';',' !important;'));
		}
	}
	
	//접지라벨 틀 구성
	function makeEmptyTrWithGround(){
		let html = '';
		html += '<tr style="page-break-before: always!important;">';
		html += '	<td class="bd-n h-150" colspan="30">';
		html += '</tr>';
		html += '';

		/* html += '<tr>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '	<td colspan="26" class="ff-gyeon fs-95 fw-bold text-center lh-1 bt-n bl-n br-n" name="itemCd"></td>'; //제품코드
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';
 */

		html += '<tr>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '	<td colspan="26" class="ff-gyeon fs-95 fw-bold text-center lh-1 bt-n bl-n br-n" name="bizOrdDtlNo"></td>'; //수주번호
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';
 
		html += '<tr>';
		html += '	<td class="bd-n h-40" colspan="30">';
		html += '</tr>';
		
		html += '<tr>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '	<td colspan="26" class="ff-head fs-60 fw-bold text-center lh-1_2 bd-n" name="itemNm"></td>'; //제품명
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';
		
		html += '<tr>';
		html += '	<td class="bd-n h-40" colspan="30">';
		html += '</tr>';
		
		html += '<tr>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '	<td colspan="23" class="ff-gyeon fs-65 fw-bold text-center bd-n" name="customerItemCd"></td>'; //자재코드
		html += '	<td colspan="3" class="ff-gyeon fs-40 fw-bold text-center lh-2_4 bd-n">-</td>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';
		
		html += '<tr>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '	<td colspan="26" class="ff-gyeon fs-65 fw-bold text-center lh-1_2 bt-n bl-n br-n" name="versionNum"></td>'; //버전번호
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';

		return html;
	}
	
	//CTCP라벨 틀 구성
	function makeEmptyTrWithCtcp(){
		let html = '';
		html += '<tr style="page-break-before: always!important;">';
		html += '		<td class="bd-n h-450" colspan="30">';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '	<td colspan="18" class="bd-n"></td>';
		html += '	<td colspan="8" class="ff-dod fs-15 text-center bd-n" name="nowDate"></td>'; //현재날짜
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';
		
		html += '<tr>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '	<td colspan="26" class="ff-gyeon fs-95 fw-bold text-center lh-1_1 bd-n" name="bizOrdDtlNo"></td>'; //수주번호
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';
		
		html += '<tr>';
		html += '	<td class="bd-n h-15" colspan="30">';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '	<td colspan="26" class="ff-head fs-65 fw-bold text-center lh-1_2 bd-n" name="itemNm"></td>'; //제품명
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';
		
		html += '<tr>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '	<td colspan="10" class="ff-gyeon fs-95 fw-bold text-center bd-n" name="frequencyNm"></td>'; //도수
		html += '	<td colspan="4" class="ff-dod fs-95 fw-bold text-center bd-n">+</td>';
		html += '	<td colspan="12" class="ff-gyeon fs-auto fw-bold text-center bd-n" name="coatingMethod"></td>'; //코팅방법
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';

		return html;
	}
	
	//금일 작업 등록 버튼 클릭시
	$('#btnSave').on('click',function(){
		const selfId = $(this).attr('id');
		updateTodayWorkYn(selfId);
	});
	
	//금일 작업 취소 버튼 클릭시
	$('#btnCancel').on('click',function(){
		const selfId = $(this).attr('id');
		updateTodayWorkYn(selfId);
	});
	
	//금일작업 등록 or 취소
	function updateTodayWorkYn(twYn) {
		$('#my-spinner').show();
		
		let updateList = [];
		//체크된 항목들만 탐색
		let updIdx = '';
		let checkObj = $('input[name=btnCheck]:checked');
		checkObj.each(function(index, item){
			let tr = $(item).parent().parent().parent();
			let data = workOrderPrcssTable.row(tr).data();
			updIdx += data.workOrdPrcssIdx +',';
		});
		updIdx = updIdx.slice(0,-1);
		let todayWorkYn = twYn == "btnSave" ? 'Y' : '';

		$('#my-spinner').hide();
		
		$.ajax({
	        url: '<c:url value="/wm/workOrdPrcssTodayWorkYnUpd"/>',
	        type: 'POST',
            data: {
            	'idx'			:	function(){ return updIdx; },
            	'todayWorkYn'	:	function(){ return todayWorkYn; },
            	'dwDate'		:	function(){ return moment().format('YYYYMMDD');},
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
	        success: function(res){
	        	if(res.result == "ok"){
	        		$('#my-spinner').hide();
	        		if ( twYn == "btnSave" ) {
	        			toastr.success('금일작업이 등록되었습니다.');       
	        		} else if ( twYn == "btnCancel" ) {
	        			toastr.success('금일작업이 취소되었습니다.');
	        		}
	        		workOrderPrcssTable.ajax.reload(function(){
						$('#btnAllCheck').prop('checked', false);
					}, false);
	        	}
	        	else{
	        		$('#my-spinner').hide();
	        		toastr.error(result.message);
	        	}
	        	
	        }
		});	 
	}

	
</script>
</body>
</html>



