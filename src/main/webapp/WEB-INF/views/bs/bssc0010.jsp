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
																			 grid-template-rows: 4fr 4px 2fr 4px 2fr; 
																			 grid-template-columns: 3.8fr 4px 8fr;">
	<input type="file" id="fileFake" style="display: none;" value="" multiple>
	<div id="leftcol">
		<div class="container-fluid h-100" style="padding: 5px;">
			<div class="row" id="leftHeader" style="padding-bottom: 5px;">
				<div class="d-flex align-items-center d-flex">
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">수주등록일</label>
					<input type="date" max="9999-12-31" class="form-control w-auto h-100 me-1" id="startDate"> 
					<label class="form-label d-flex align-items-center m-0 me-1 h-100">~</label>
					<input type="date" max="9999-12-31" class="form-control w-auto h-100 me-1" id="endDate"> 
					<select class="form-select w-auto h-100 me-1 monthAdjust" id="monthAdjust"></select> 
					
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end">
					<div class="btn-group" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto monthAdjustButton" data-val="3">
							3개월
						</button>
						<button type="button" class="btn btn-outline-light w-auto monthAdjustButton" data-val="6">
							6개월
						</button>
						<button type="button" class="btn btn-outline-light w-auto monthAdjustButton" data-val="12">
							12개월
						</button>
					</div>	
				</div>
			</div>
			<div class="row" id="leftSecondHeader" style="padding-bottom: 5px;">
				<div class="d-flex align-items-center d-flex">
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">조회대상</label>
					<select class="form-select w-auto h-100 me-1" id="searchTarget">
						<option value="">전체</option>
						<option value="Y" selected>출고제외</option>
					</select>
					<input type="text" class="form-control w-auto h-100 me-1" id="searchAll" placeholder="통합검색">
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end">
					<div class="btn-group" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnSearchBizAdm">
							<i class="fa-regular fa-clipboard"></i>
						</button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnNewAdm">
							<i class="fa-solid fa-plus"></i>
						</button>
						<button type="button" class="btn btn-outline-danger w-auto" style="font-size: 17px !important;" id="btnDelAdm" disabled>
							<i class="fa-solid fa-trash-can"></i>
						</button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnOpen">
							<i class="fa-solid fa-caret-left"></i>
						</button>
					</div>
				</div>
					
			</div>
			<div class="row">
				<table class="table table-bordered p-0 m-0" id="bizOrderAdmTable">
					<thead class="table-light">
						<tr>
							<th class="text-center">수주<br>번호</th>
							<th class="text-center">수주처</th>
							<th class="text-center">수주<br>상세</th>
							<th class="text-center">컨펌<br>대기</th>
							<th class="text-center">지시서<br>미발행</th>
							<th class="text-center">원지<br>발주</th>
							<th class="text-center">미출고<!-- <br><span style="color: #ff0000;">(재고사용)</span> --> </th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
	<div id="dragbarH" onmousedown="StartDrag('H')"></div>
	<div id="rightcolT">
		<div class="container-fluid h-100" style="padding: 5px;">
			<div class="row" id="rightHeader" style="padding-bottom: 5px;">
				<div class="d-flex align-items-center d-flex">
					<input type="text" class="form-control w-auto h-100 me-1" id="searchAllBod" placeholder="통합검색" >
				</div>
				<div class="me-lg-auto"></div>
				<div class="btn-group me-3" role="group" aria-label="Small button group">
					<button type="button" class="btn btn-outline-light w-auto" id="btnBizDtlPoEnd" disabled>PO완료</button>
					<button type="button" class="btn btn-outline-light w-auto" id="btnBizDtlCancel" disabled>수주취소</button>
				</div>
				<div class="btn-group" role="group" aria-label="Small button group">
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnEditDtl" disabled>
						<i class="fa-regular fa-pen-to-square"></i>
					</button>
					<button type="button" class="btn btn-outline-danger w-auto" style="font-size: 17px !important;" id="btnDelDtl" disabled>
						<i class="fa-solid fa-trash-can"></i>
					</button>
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnClose">
						<i class="fa-solid fa-caret-right"></i>
					</button>
					
				</div>
			</div>
			<div class="row" id="rightBody">
				<table class="table table-bordered p-0 m-0" id="bizOrderDtlTable">
					<thead class="table-light">
						<tr>
							
							<th class="text-center align-middle">수주<br>중지
							</th>
							<!-- <th class="text-center align-middle">수주<br>재고사용
							</th> -->
							<!-- <th class="text-center align-middle">수주<br>확정
							</th> -->
							<th class="text-center align-middle">수주<br>확정
							</th>
							<th class="text-center align-middle">수주상세번호</th>
							<th class="text-center align-middle">수주상태</th>
							<th class="text-center align-middle">진행상태</th>
							<th class="text-center align-middle">고객사</th>
							<th class="text-center align-middle">제품명</th>
							<th class="text-center align-middle">자재코드</th>
							<th class="text-center align-middle">버전번호</th>
							<th class="text-center align-middle">버전변경
							</th>
							<th class="text-center align-middle">현재고</th>
							<th class="text-center align-middle">수주수량</th>
							<th class="text-center align-middle">재고사용수량</th>
							<th class="text-center align-middle">목표요구일</th>
							<th class="text-center align-middle">출고요청일</th>
							<th class="text-center align-middle">건별 전달사항</th>
							<th class="text-center align-middle">특이사항</th>
							<th class="text-center align-middle">사이즈</th>
							<th class="text-center align-middle">칼끝규격</th>
							<th class="text-center align-middle">COLOR</th>
							<th class="text-center align-middle">코팅</th>
							<th class="text-center align-middle">비고</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
	<div id="dragbarVT" onmousedown="StartDrag('VT')" ondblclick="minimum(this)"></div>
	<div id="rightcolM">
		<div class="container-fluid" style="padding: 5px;">
			<div class="row">
				<div style="width: 100%;">
					<div class="nav nav-tabs" id="nav-tab2">
						<button class="nav-link active" id="tab3Nav" data-bs-toggle="tab" data-bs-target="#tab3">공정정보</button>
						<button class="nav-link" id="tab4Nav" data-bs-toggle="tab" data-bs-target="#tab4">사진 및 첨부파일</button>
					</div>
					<div class="tab-content" id="nav-tabContent2">
						<div class="tab-pane fade show active" id="tab3">
							<div class="row" style="padding: 5px;">
								<div class="d-flex align-items-center justify-content-end w-100" style="margin-bottom: 5px;">
									<input type="text" class="form-control w-auto h-100 me-1" id="searchAllPit" placeholder="통합검색" >
									<div class="btn-group me-3" role="group" aria-label="Small button group">
										<button type="button" class="btn btn-outline-light w-auto" id="btnNewEditPrint" >관리 내역서 출력</button>
										<button type="button" class="btn btn-outline-light w-auto" id="btnWorkPrint" disabled>지시서 출력</button>
										<button type="button" class="btn btn-outline-light w-auto" id="btnWorkOrdConfirm" disabled>작업계획확정</button>
										<button type="button" class="btn btn-outline-light w-auto" id="btnWorkOrdDel" disabled>작업계획취소</button>
									
									</div>
									<div class="btn-group" role="group" aria-label="Small button group">
										<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnProcessNew" disabled>
											<i class="fa-solid fa-plus"></i>
										</button>
										<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnProcessCopy" disabled>
											<i class="fa-regular fa-copy"></i>
										</button>
										<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnProcessSave" disabled>
											<i class="fa-regular fa-floppy-disk"></i>
										</button>
										<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnProcessEdit" disabled>
											<i class="fa-regular fa-pen-to-square"></i>
										</button>
										<button type="button" class="btn btn-outline-danger w-auto" style="font-size: 17px !important;" id="btnProcessDel" disabled>
											<i class="fa-solid fa-trash-can"></i>
										</button>
										<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnProcessCancel" disabled>
											<i class="fa-solid fa-xmark"></i>
										</button>
									</div>
								</div>
								<table class="table table-bordered p-0 m-0" id="processInfoTable">
									<thead class="table-light">
										<tr>
											<th class="text-center align-middle">순번</th>
											<th class="text-center align-middle">공정코드</th>
											<th class="text-center align-middle">공정명</th>
											<th class="text-center align-middle" style="min-width: 120px; max-width: 120px;">설비정보</th>
											<th class="text-center align-middle">외주구분</th>
											<th class="text-center align-middle">작업방법</th>
											<th class="text-center align-middle">작업세부방법</th>
											<th class="text-center align-middle">생산지시단위</th>
											<th class="text-center align-middle">작업지시량</th>
											<th class="text-center align-middle" style="min-width: 120px; max-width: 120px;">외주처</th>
											<th class="text-center align-middle">단위</th>
											<!-- <th class="text-center align-middle">비고</th> -->
											<th class="text-center align-middle">주의사항</th>
										</tr>
									</thead>
								</table>
							</div>
						</div>
						<div class="tab-pane fade" id="tab4">
							<div style="padding: 5px; display: flex; flex-wrap: 1 1 auto;">
								<div class="row" style="width: 50%;">
									<div class="d-flex align-items-center justify-content-end w-100" style="margin-bottom: 5px;">
										<input type="text" class="form-control w-auto h-100 me-1" id="searchAllFt" placeholder="통합검색" >
										<div class="btn-group" role="group" aria-label="Small button group">
											<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnFileAdd" disabled>
												<i class="fa-solid fa-plus"></i>
											</button>
											<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnFileSave"
												disabled>
												<i class="fa-regular fa-floppy-disk"></i>
											</button>
											<button type="button" class="btn btn-outline-danger w-auto" style="font-size: 17px !important;" id="btnFileDel" disabled>
												<i class="fa-solid fa-trash-can"></i>
											</button>
										</div>
									</div>
									<table class="table table-bordered p-0 m-0" id="fileTable">
										<thead class="table-light">
											<tr>
												<th class="text-center">순번</th>
												<th class="text-center">파일명</th>
												<th class="text-center">확장자</th>
												<th class="text-center">등록일자</th>
												<th class="text-center">다운로드</th>
											</tr>
										</thead>
									</table>
								</div>
								<div id="imgDiv" style="border: 1px solid rgba(94, 166, 230, 1); padding: 5px; margin-left: 5px; width: 49.6%;">
									<div id="imgView">
										<img id="viewer" class="imgView"
											style="object-fit: contain; height: 100px; width: 100px;">
									</div>
								</div>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="dragbarVB" onmousedown="StartDrag('VB')" ondblclick="minimum(this)"></div>
	<div id="rightcolB">
		<div class="container-fluid" style="padding: 5px;">
			<div class="row">
				<div style="width: 100%;">
					<div class="nav nav-tabs" id="nav-tab3">
						<button class="nav-link active" id="tab5Nav" data-bs-toggle="tab" data-bs-target="#tab5">수주별발주</button>
						<button class="nav-link" id="tab6Nav" data-bs-toggle="tab" data-bs-target="#tab6">번들링정보</button>
					</div>
					<div class="tab-content" id="nav-tabContent2">
						<div class="tab-pane fade show active" id="tab5">
							<div class="row" style="padding: 5px;">
								<div class="d-flex align-items-center justify-content-end w-100" style="margin-bottom: 5px;">
									<input type="text" class="form-control w-auto h-100 me-1" id="searchAllPoa" placeholder="통합검색" >
									<div class="btn-group" role="group" aria-label="Small button group">
										<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnMaterialNew" disabled>
											<i class="fa-solid fa-plus"></i>
										</button>
										<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnMaterialCopy" disabled>
											<i class="fa-regular fa-copy"></i>
										</button>
										<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnMaterialSave" disabled>
											<i class="fa-regular fa-floppy-disk"></i>
										</button>
										<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnMaterialEdit" disabled>
											<i class="fa-regular fa-pen-to-square"></i>
										</button>
										<button type="button" class="btn btn-outline-danger w-auto" style="font-size: 17px !important;" id="btnMaterialDel" disabled>
											<i class="fa-solid fa-trash-can"></i>
										</button>
										<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnMaterialCancel" disabled>
											<i class="fa-solid fa-xmark"></i>
										</button>
									</div>
								</div>
								<table class="table table-bordered p-0 m-0" id="purchaseOrderAdmTable">
									<thead class="table-light">
										<tr>
											<th class="text-center align-middle">확정여부</th>
											<th class="text-center align-middle">발주재고사용</th>
											<!-- <th class="text-center align-middle">출력여부</th> -->
											<th class="text-center align-middle">가용재고</th>
											<th class="text-center align-middle">현재고</th>
											<th class="text-center align-middle">발주번호</th>
											<!-- <th class="text-center align-middle">발주일자</th>
											<th class="text-center align-middle">입고예정일</th> -->
											<!-- <th class="text-center align-middle">원단코드</th> -->
											<th class="text-center align-middle">재질</th>
											<th class="text-center align-middle">발주처</th>
											<th class="text-center align-middle">주문수량</th>
											<th class="text-center align-middle">이론량Ⓡ</th>
											<th class="text-center align-middle">발주량Ⓡ</th>
											<th class="text-center align-middle">절수</th>
											<th class="text-center align-middle">개수</th>
											<th class="text-center align-middle">이론통수</th>
											<th class="text-center align-middle">여분포함통수</th>
											<th class="text-center align-middle">여분</th>
											<th class="text-center align-middle">추가여분</th>
											<th class="text-center align-middle">비고</th>
										</tr>
									</thead>
								</table>
							</div>
						</div>
						<div class="tab-pane fade" id="tab6">
							<div class="row" style="padding: 5px;">
								<div class="d-flex align-items-center justify-content-end w-100" style="margin-bottom: 5px;">
									<input type="text" class="form-control w-auto h-100 me-1" id="searchAllBit" placeholder="통합검색" >
									<div class="btn-group me-3" role="group" aria-label="Small button group">
										<button type="button" class="btn btn-outline-light w-auto d-none" id="btnBundlingPrint">Bundling지시서 출력</button>
									</div>
								
									<div class="btn-group" role="group" aria-label="Small button group">
										<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnBundleNew" disabled>
											<i class="fa-solid fa-plus"></i>
										</button>
										<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnBundleCopy" disabled>
											<i class="fa-regular fa-copy"></i>
										</button>
										<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnBundleSave" disabled>
											<i class="fa-regular fa-floppy-disk"></i>
										</button>
										<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnBundleEdit" disabled>
											<i class="fa-regular fa-pen-to-square"></i>
										</button>
										<button type="button" class="btn btn-outline-danger w-auto" style="font-size: 17px !important;" id="btnBundleDel" disabled>
											<i class="fa-solid fa-trash-can"></i>
										</button>
										<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnBundleCancel" disabled>
											<i class="fa-solid fa-xmark"></i>
										</button>
									</div>
								</div>
								<table class="table table-bordered p-0 m-0 " id="bundleInfoTable">
									<thead class="table-light">
										<tr>
											<th class="text-center align-middle">품목코드</th>
											<th class="text-center align-middle">품목명</th>
											<th class="text-center align-middle">현재고</th>
											<th class="text-center align-middle">투입수량</th>
											<th class="text-center align-middle">수주상세번호</th>
											<th class="text-center align-middle">비고</th>
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
</div>
<!-- modal -->
<!-- 수주등록/수정 모달 ====================================================================-->
<div class="modal fade" id="orderAddEditModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
	<div class="modal-dialog" style="max-width: 80vw;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">수주등록/수정</h5>
				<div class="btn-group" role="group" aria-label="Small button group">
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnSave">
						<i class="fa-regular fa-floppy-disk"></i>
					</button>
					<button type="button" class="btn btn-outline-light w-auto" data-bs-dismiss="modal" style="font-size: 20px !important;">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>
			</div>
			<div class="modal-body" style="padding: 1rem;">
				<div class="container-fluid p-0 h-100">
					<div class="row" style="padding-bottom: 5px;">
						<table class="table table-bordered p-0 m-0">
							<colgroup>
								<col width="7%">
								<col width="18%">
								<col width="7%">
								<col width="43%">
								<col width="10%">
								<col width="15%">
							</colgroup>
							<tr>
								<th class="text-center align-middle"><span style="color: #ff0000;">*</span>고객사</th>
								<td class="text-center align-middle">
									<div style="display: flex; flex-wrap: 1 1 auto;">
										<input type="text" class="form-control inputGroup" id="dealCorpNm" disabled> 
										<input type="hidden" class="inputGroup" id="dealCorpIdx">
										<button type="button" style="padding: 1px 4px; margin-left: 5px;" class="btn btn-primary input-sub-search" id="btnDealCorpSelect">
											<i class="fa-solid fa-magnifying-glass"></i>
										</button>
									</div>
								</td>
								<th class="text-center align-middle" rowspan="5">비고</th>
								<td class="text-center align-middle" colspan='1' rowspan="5">
									<textarea class="form-control inputGroup" id="ordDesc" rows="8" style="resize: none;"></textarea>
								</td>
								<th class="text-center align-middle">발주서</th>
								<td class="text-center align-middle">
									<div style="display: flex; flex-wrap: 1 1 auto;">
										<input type="text" class="form-control" id="purchaseFileNm" disabled>
										<button type="button" style="padding: 1px 4px; margin-left: 5px; 
																	white-space: nowrap;" class="btn btn-warning input-sub-search inputGroup"
															 id="purchaseFileUpload">업로드</button>
										<input class="form-control inputGroup" style="display: none;" type="file" id="purchaseFile">
									</div>
								</td>
							</tr>
							<tr>
								<th class="text-center align-middle"><span style="color: #ff0000;">*</span>수주등록일</th>
								<td class="text-center align-middle"><input type="date" max="9999-12-31" class="form-control inputGroup" id="ordDate">
								</td>
								<td class="text-center align-middle" colspan='2' rowspan="4" style="height: 0;">
									<div id="purchaseImgDiv" style="border: 1px solid rgba(94, 166, 230, 1); padding: 5px; width: 100%; height: 100%;">
										<div id="purchaseImgView" style="width: 100%; height: 100%;">
											<img id="purchaseViewer" class="imgView" style="object-fit: contain; height: 100px; width: 100px;" src="">
										</div>
									</div>
								</td>
							</tr>
							<!-- <tr>
								<th class="text-center align-middle"><span style="color: #ff0000;">*</span>수주구분</th>
								<td class="text-center align-middle">
									<select class="form-select w-100 inputGroup" id="ordGubun"></select>
								</td>
							</tr> -->
							<tr>
								<th class="text-center align-middle"><span style="color: #ff0000;">*</span>수주번호</th>
								<td class="text-center align-middle">
									<input type="text" class="form-control" id="bizOrdNo" disabled>
								</td>
							</tr>
							<tr>
								<th class="text-center align-middle"><span style="color: #ff0000;">*</span>등록자</th>
								<td class="text-center align-middle">
									<input type="text" class="form-control" id="regIdxNm" disabled>
								</td>
							</tr>
						</table>
					</div>
					<div class="row" style="padding-bottom: 5px;">
						<div class="d-flex align-items-center d-flex"></div>
						<div class="me-lg-auto"></div>
						<div class="btn-group" role="group" aria-label="Small button group">
							<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnItemAdd">
								<i class="fa-solid fa-plus"></i>
							</button>
							<button type="button" class="btn btn-outline-danger w-auto" style="font-size: 17px !important;" id="btnItemDel">
								<i class="fa-solid fa-trash-can"></i>
							</button>
						</div>
					</div>
					<div class="row">
						<table class="table table-bordered p-0 m-0" id="bizOrderDtlAddEditTable">
							<thead class="table-light">
								<tr>
									<th class="text-center align-middle">순번</th>
									<th class="text-center align-middle" style="min-width:60px;">수주구분</th>
									<!-- <th class="text-center align-middle">사업장</th> -->
									<th class="text-center align-middle">수주상세번호</th>
									<!-- <th class="text-center align-middle" style="min-width:60px;max-width:60px;">수주상태</th> -->
									<!-- <th class="text-center align-middle" style="min-width:60px;max-width:60px;">재고사용</th> -->
									<th class="text-center align-middle">제품명</th>
									<th class="text-center align-middle">자재코드</th>
									<th class="text-center align-middle">버전번호</th>
									<!-- <th class="text-center align-middle">사이즈</th>
									<th class="text-center align-middle">칼끝규격</th>
									<th class="text-center align-middle">COLOR</th>
									<th class="text-center align-middle">코팅</th> -->
									<th class="text-center align-middle">현재고</th>
									<th class="text-center align-middle">수주수량</th>
									<th class="text-center align-middle">재고사용수량</th>
									<th class="text-center align-middle">재고활용수량</th>
									<th class="text-center align-middle">발주번호/BATCH</th>
									<!-- <th class="text-center align-middle" style="min-width:380px;max-width:380px;">특이사항</th> -->
									<th class="text-center align-middle"
										style="min-width: 340px; max-width: 340px;">전달사항</th>
									<!-- <th class="text-center align-middle">목표요구일</th> -->
									<th class="text-center align-middle">출고요청일</th>
									<!-- <th class="text-center align-middle">비고</th> -->
								</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- ================================================================ 수주등록/수정 모달 -->
<!-- 제품코드조회 ====================================================================-->
<div class="modal fade" id="itemInfoAdmListModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false" style="overflow: visible;">
	<div class="modal-dialog" style="max-width: 70vw;">
		<div class="modal-content" style="resize: both; overflow: auto; max-width: 95vw; max-height: 100vh;">
			<div class="modal-header">
				<h5 class="modal-title">제품코드조회</h5>
				<div class="btn-group" role="group" aria-label="Small button group">
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnitemInfoAdmListSave">
						<i class="fa-regular fa-floppy-disk"></i>
					</button>
					<button type="button" class="btn btn-outline-light w-auto" data-bs-dismiss="modal" style="font-size: 20px !important;">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>
			</div>
			<div class="modal-body">
				<div class="container-fluid h-100" style="padding: 5px;">
					<div class="row" style="padding-bottom: 5px;">
						<div class="d-flex align-items-center d-flex">
							<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">품목구분</label>
							<select class="form-select w-auto h-100 me-3" id="searchItemGubun" style="min-width: 70px;">
								<option value="" selected>전체</option>
								<option value="001">제품</option>
								<option value="002">상품</option>
							</select> 
							<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">사용여부</label>
							<select class="form-select w-auto h-100 me-3" id="searchUseYnCd" style="min-width: 70px;">
								<option value="" selected>전체</option>
								<option value="Y">사용</option>
								<option value="N">미사용</option>
							</select>
							<input type="text" class="form-control w-auto h-100 me-1" id="itemInfoAdmListSearchAll" style="min-width: 400px;" placeholder="통합검색">
						</div>
						<div class="me-lg-auto"></div>
						<div class="d-flex align-items-center justify-content-end">
							<div class="btn-group" role="group" aria-label="Small button group">
								<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnitemInfoAdmListSearch">
									<i class="fa-regular fa-clipboard"></i>
								</button>
							</div>
						</div>
					</div>
					<div class="row">
						<table class="table table-bordered p-0 m-0" id="itemInfoTable">
							<thead class="table-light">
								<tr>
									<th class="text-center" style="padding: 0px;"><input class="form-check-input" type="checkbox" id="checkAll" style="margin: 0px; width: 25px; height: 25px;"></th>
									<th class="text-center align-middle">고객사</th>
									<!-- <th class="text-center align-middle">제품코드</th> -->
									<th class="text-center align-middle">제품명</th>
									<th class="text-center align-middle">공정수</th>
									<th class="text-center align-middle">칼끝규격</th>
									<th class="text-center align-middle">자재코드</th>
									<th class="text-center align-middle">버전번호</th>
									<th class="text-center align-middle">COLOR</th>
									<th class="text-center align-middle">품목구분</th>
									<th class="text-center align-middle">사용여부</th>
									<th class="text-center align-middle">사이즈</th>
									<th class="text-center align-middle">목형관리번호</th>
									<th class="text-center align-middle">수지판</th>
									<th class="text-center align-middle">타공목형번호</th>
									<th class="text-center align-middle">현재고량</th>
									<th class="text-center align-middle">도수</th>
									<!-- <th class="text-center align-middle">특이사항</th>
									<th class="text-center align-middle">전달사항</th> -->
									<th class="text-center align-middle">묶음법</th>
									<th class="text-center align-middle">포장방법</th>
									<th class="text-center align-middle">작업인쇄기</th>
									<th class="text-center align-middle">명인원지</th>
									<th class="text-center align-middle">관리번호</th>
									<th class="text-center align-middle">검수방법</th>
									<th class="text-center align-middle">큰판작은판</th>
									<th class="text-center align-middle">묶음단위</th>
									<th class="text-center align-middle">포장단위</th>
									<th class="text-center align-middle">일자</th>
									<th class="text-center align-middle">원판수량</th>
									<th class="text-center align-middle">면방</th>
									<th class="text-center align-middle">착인여부점검</th>
									<th class="text-center align-middle">호기</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- ================================================================ 수주등록/수정 모달 -->
<!-- 설비 모달 -->
<div class="modal fade" id="prcssEquipModal" tabindex="-1" aria-hidden="true" style="z-index: 9999;">
	<div class="modal-dialog" style="max-width: 60vw;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="prcssEquipModalTitle">공정 설비 조회</h5>
				<div class="btn-group" role="group" aria-label="Small button group">
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnPrcssEquipModalPaste">
						<i class="fa-regular fa-paste"></i>
					</button>
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" data-bs-dismiss="modal" aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>
			</div>
			<div class="modal-body">
				<div class="row" style="padding-bottom: 5px;">
					<div class="d-flex align-items-center d-flex">
						<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">설비 조회</label> 
						<select class="form-select w-auto h-100 me-3" id="prcssEquipSelectGubun" style="min-width: 70px;">
							<option value="prcssEquip">등록된 설비</option>
							<option value="all">모든 설비</option>
						</select>
					</div>
					<div class="me-lg-auto"></div>
					<div class="d-flex align-items-center justify-content-end">
						<div class="btn-group" role="group" aria-label="Small button group">
							<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnPrcssEquipSearch">
								<i class="fa-regular fa-clipboard"></i>
							</button>
						</div>
					</div>
				</div>
				<table class="table table-bordered p-0 m-0" id="prcssEquipModalTable">
					<thead class="table-light">
						<tr>
							<th class="text-center">설비코드</th>
							<th class="text-center">설비명</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>
<!-- 설비 모달 끝 -->
<!-- 거래처 모달 -->
<div class="modal fade" id="dealCorpSelectModal" tabindex="-1" aria-hidden="true" style="z-index: 9999;">
	<div class="modal-dialog" style="max-width: 60vw;">
		<div class="modal-content" style="height: calc(100vh - 5em);">
			<div class="modal-header">
				<h5 class="modal-title">발주처 조회</h5>
				<div class="btn-group" role="group" aria-label="Small button group">
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnDealCorpSelectModalPaste">
						<i class="fa-regular fa-paste"></i>
					</button>
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" data-bs-dismiss="modal" aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>
			</div>
			<div class="modal-body">
				<div class="row" style="padding-bottom: 5px;">
					<div class="d-flex align-items-center d-flex">
						<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">자재 발주처 조회</label>
						<select class="form-select w-auto h-100 me-3" id="dealCorpSelectGubun" style="min-width: 70px;">
							<option value="matrlCorp">등록된 발주처</option>
							<option value="all">모든 발주처</option>
						</select>
					</div>
					<div class="me-lg-auto"></div>
					<div class="d-flex align-items-center justify-content-end">
						<div class="btn-group" role="group" aria-label="Small button group">
							<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnDealCorpSelectSearch">
								<i class="fa-regular fa-clipboard"></i>
							</button>
						</div>
					</div>
				</div>
				<table class="table table-bordered p-0 m-0" id="dealCorpSelectModalTable">
					<thead class="table-light">
						<tr>
							<th class="text-center">거래처코드</th>
							<th class="text-center">업체명</th>
							<th class="text-center">대표자</th>
							<th class="text-center">사업자번호</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>
<!-- 거래처 모달 끝 -->
<!-- 수주별발주 추가 자재 모달 ====================================================================================-->
<div class="modal fade" id="matrlSelectModal" tabindex="-1" aria-hidden="true" style="z-index: 9999;">
	<div class="modal-dialog" style="max-width: 60vw;">
		<div class="modal-content" style="height: calc(100vh - 5em);">
			<div class="modal-header">
				<h5 class="modal-title">자재 조회</h5>
				<div class="btn-group" role="group" aria-label="Small button group">
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnMatrlSelectModalPaste">
						<i class="fa-regular fa-paste"></i>
					</button>
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" data-bs-dismiss="modal" aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>
			</div>
			<div class="modal-body">
				<div class="row" style="padding-bottom: 5px;">
					<div class="d-flex align-items-center d-flex">
						<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">자재 발주처 조회</label> 
						<select class="form-select w-auto h-100 me-3" id="matrlSelectGubun" style="min-width: 70px;">
							<option value="001">BOM목록</option>
							<option value="002">모든 자재</option>
						</select>
					</div>
					<div class="me-lg-auto"></div>
					<div class="d-flex align-items-center justify-content-end">
						<div class="btn-group" role="group" aria-label="Small button group">
							<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnMatrlSelectReSearch">
								<i class="fa-regular fa-clipboard"></i>
							</button>
						</div>
					</div>
				</div>
				<table class="table table-bordered p-0 m-0" id="matrlModalSelectTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle">품목구분</th>
							<th class="text-center align-middle">원단코드</th>
							<th class="text-center align-middle">재질</th>
							<th class="text-center align-middle">가로</th>
							<th class="text-center align-middle">세로</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>

<!-- 공정 작업계획 경고 -->
<div class="modal fade" id="workOrderModal" tabindex="-1" aria-hidden="true" style="z-index: 9999;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">
					<i class="fa-solid fa-triangle-exclamation text-danger"></i>
					<spring:message code="modal.warning" text="default text" />
				</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				이미 확정된 작업계획이 있을 경우 내용이 변경될 수 있습니다.<br> 계속하시겠습니까?
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" id="btnWorkOrderModalY" data-bs-dismiss="modal" style="width: 70px;">
					<spring:message code="yes" text="default text" />
				</button>
				<button type="button" class="btn btn-secondary" id="btnWorkOrderModalN" data-bs-dismiss="modal" style="width: 70px;">
					<spring:message code="no" text="default text" />
				</button>
			</div>
		</div>
	</div>
</div>
<!-- 공정 작업계획 경고 모달 끝 -->

<!-- 수주취소 경고 -->
<div class="modal fade" id="bizDtlCancelModal" tabindex="-1" aria-hidden="true" style="z-index: 9999;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">
					<i class="fa-solid fa-triangle-exclamation text-danger"></i>
					<spring:message code="modal.warning" text="default text" />
				</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<label style="">수주취소 진행시</label> 
				<br> 
				<label class="mt-2" style="color: red;">1. 작업지시가 진행된 대기, 진행 중인 공정은 강제 완료처리됩니다.</label>
				<br> 
				<label style="color: red;">&nbsp;&nbsp;&nbsp;단, 진행되지 않은 작업지시는 삭제됩니다.</label>
				<br> 
				<label style="color: red;">2. 미확정 발주건들은 삭제됩니다.</label> 
				<br> 
				<label style="color: red;">3. 더 이상 수정 및 복구가 불가능합니다.</label> 
				<br> 
				<label class="mt-2">계속하시겠습니까?</label>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" id="btnBizDtlCancelY" data-bs-dismiss="modal" style="width: 70px;">
					<spring:message code="yes" text="default text" />
				</button>
				<button type="button" class="btn btn-secondary" id="btnBizDtlCancelN" data-bs-dismiss="modal" style="width: 70px;">
					<spring:message code="no" text="default text" />
				</button>
			</div>
		</div>
	</div>
</div>
<!-- 수주취소 경고 모달 끝 -->
<!-- PO완료 경고 -->
<div class="modal fade" id="bizDtlPoEndModal" tabindex="-1" aria-hidden="true" style="z-index: 9999;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">
					<i class="fa-solid fa-triangle-exclamation text-danger"></i>
					<spring:message code="modal.warning" text="default text" />
				</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<label style="">PO완료 진행시</label> 
				<br> 
				<label class="mt-2" style="color: red;">1. 더 이상 수정 및 복구가 불가능합니다.</label> 
				<br>
				<!-- <label style="color: red;">&nbsp&nbsp&nbsp단, 진행되지 않은 작업지시는 삭제됩니다.</label>
				<br>
				<label style="color: red;">2. 미확정 발주건들은 삭제됩니다.</label>
				<br>
				<label style="color: red;">3. 더 이상 수정 및 복구가 불가능합니다.</label>
				<br> -->
				<label class="mt-2">계속하시겠습니까?</label>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" id="btnBizDtlPoEndY" data-bs-dismiss="modal" style="width: 70px;">
					<spring:message code="yes" text="default text" />
				</button>
				<button type="button" class="btn btn-secondary" id="btnBizDtlPoEndN" data-bs-dismiss="modal" style="width: 70px;">
					<spring:message code="no" text="default text" />
				</button>
			</div>
		</div>
	</div>
</div>
<!-- PO완료 경고 모달 끝 -->
<!-- 발주서 -->
<div class="modal fade" id="purchaseViewerModal" tabindex="-1" aria-hidden="true" style="z-index: 9999;">
	<div class="modal-dialog" style="max-width: 40vw;">
		<div class="modal-content">
			<div class="modal-header">
				<h5>발주서</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="container-fluid p-0 h-100">
					<a id="modalPurchaseTag" style="width: 100%; height: 90%;" href="" target="_blank"></a>
					<img id="modalPurchaseViewer" class="imgView"style="object-fit: contain; width: 100%; height: 90%;" src="">
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 발주서 모달 끝 -->
<!-- 작업지시서 모달 -->
<div class="modal fade" id="workOrderReportModal" tabindex="-1" aria-hidden="true" style="z-index: 9999;">
	<div class="modal-dialog" style="max-width: 60vw;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="prcssEquipModalTitle">작업지시서 모달</h5>
			</div>
			<div class="modal-body">
				<div class="row" style="padding-bottom: 5px;">
					<table id="workOrderReportTable" class="table table-bordered m-0 d-none" style="border:1px solid #ffffff;">
						<colgroup id="trAppendTarget">
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
<!-- 작업지시서 모달 끝 -->

<!-- 신규/수정 관리 내역서 모달 -->
<div class="modal fade" id="newEditHistoryModal" tabindex="-1" aria-hidden="true" style="z-index: 9999;">
	<div class="modal-dialog" >
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">신규/수정 관리 내역서 모달</h5>
			</div>
			<div class="modal-body">
				<div class="row" style="padding-bottom: 5px;">
					<table id="newEditHistoryTable" class="table table-bordered m-0 d-none" style="border:1px solid #ffffff;">
						<colgroup id="trNewEditHistoryAppendTarget">
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
<!-- 신규/수정 관리 내역서 모달 끝 -->

<!-- 번들링 지시서 모달 -->
<div class="modal fade" id="bundlingOrderModal" tabindex="-1" aria-hidden="true" style="z-index: 9999;">
	<div class="modal-dialog" >
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">번들링 지시서 모달</h5>
			</div>
			<div class="modal-body">
				<div class="row" style="padding-bottom: 5px;">
					<table id="bundlingOrderTable" class="table table-bordered m-0 d-none" style="border:1px solid #ffffff;">
						<colgroup id="trBundlingOrderAppendTarget">
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
<!-- 번들링 지시서 모달 끝 -->

<!-- modal -->
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

			let rightcolT_min_height = 150;	// 우측 상단 최소높이
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
			
			let newColDefn = cols.map(c => c.toString() + "px").join(" ");
			
			$('#page').css('grid-template-rows',newColDefn);
		} else if(id == 'dragbarVB') {
			let dragbarWidth = 4;

			let page_height = parseInt($('#page').height()); 			// 전체 높이
			let rightcolT_height = parseInt($('#rightcolT').height());	// 우측 상단
			let rightcolM_height = parseInt($('#rightcolM').height());	// 우측 중단
			let rightcolB_height = parseInt($('#rightcolB').height());	// 우측 하단

			let rightcolT_min_height = 150;	// 우측 상단 최소높이
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
			
			let newColDefn = cols.map(c => c.toString() + "px").join(" ");
			
			$('#page').css('grid-template-rows',newColDefn);
		}

		dataTableDrawAll(); // dataTable 전체 reload
	}
	
	function OnDrag(event) {
		if (isDraggingH) { // 좌우 스크롤
			let page = document.getElementById("page");
			let leftcol = document.getElementById("leftcol"); // 좌측

			let page_height = parseInt($('#page').height()); 		// 전체 높이
			let page_width = parseInt($('#page').width()); 			// 전체 넓이
			
			let dragbarWidth = 4;
			let leftcolMinWidth = 20; // leftcol 최소사이즈
			$('#leftHeader').children().each(function(index, item) {
				leftcolMinWidth += $(item).width();
			});
			let leftcol_min_width = leftcolMinWidth; // leftcol 최소사이즈
			let rightcol_min_width = 300; // leftcol 최소사이즈
			
			let cursorX = event.clientX;	// 현재 cursor x좌표(좌측에서부터 얼마나 떨어졌는지)
			
			let cols = [
				Math.min(Math.max(leftcol_min_width, cursorX), page_width - rightcol_min_width - dragbarWidth),
				dragbarWidth,
				Math.max(page_width - Math.max(leftcol_min_width, cursorX), rightcol_min_width) - dragbarWidth
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

			let rightcolT_min_height = 150;	// 우측 상단 최소높이
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

			let rightcolT_min_height = 150;	// 우측 상단 최소높이
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
			$('#page').css('grid-template-columns', '3.8fr 4px 8fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcolT').removeClass('d-none');
		} else {
			$('#page').css('grid-template-columns', '0fr 4px 8fr');
			$('#leftcol').addClass('d-none');
			$('#rightcolT').removeClass('d-none');
		}
		dataTableDrawAll(); // dataTable 전체 reload
	});
	$('#btnClose').on('click',function() { // right-box 닫기버튼 클릭
		if($('#leftcol').hasClass('d-none')){
			$('#page').css('grid-template-columns', '3.8fr 4px 8fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcolT').removeClass('d-none');
		} else {
			$('#page').css('grid-template-columns', '3.8fr 4px 0fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcolT').addClass('d-none');
		}
		dataTableDrawAll(); // dataTable 전체 reload
	});
	
</script>
<!-- 인쇄용지설정 -->
<style type="text/css" media="print" id="printPaperTypeStyle">
@media print {
	@page { size: A3 landscape; margin: 3mm; }, /*landscape 가로  portrait 세로 */
	html, body { width: 297mm;height: 420mm; }
}
</style>
<script>
	WM_init('new');
	WM_init('edit');
	WM_init('prcssNew');
	WM_init('fileNew');
	WM_init('matrlNew');
	WM_init('bundleNew');

	let monthAdjustList = getCommonCode('시스템', '026'); //날짜조정
	monthAdjustList = _.sortBy(monthAdjustList, v=>parseInt(v.commonCd));
	selectBoxAppend(monthAdjustList, 'monthAdjust', '', '2'); //날짜조정
	
	let dealGubunList = getCommonCode('시스템', '011'); // 거래구분
	let dealCorpStatusList = getCommonCode('시스템', '015'); // 거래상태
	let ordGubunList = getCommonCode('일반', '023'); // 수주구분
	let outsrcGubunList = getCommonCode('일반', '024'); // 외주구분
	let ordStatusList = getCommonCode('시스템', '022'); // 수주상태
	let pageLengthCnt = parseInt(getCommonCode('시스템', '025')[0].commonCd); //페이징수량
	let selectPeriod = parseInt(getCommonCode('시스템', '040')[0].commonCd); //기본조회기간 일
	let itemGubunList = getCommonCode('일반', '001'); // 제품구분
	let useYnCdList = getCommonCode('시스템', '055'); // 사용여부
	
	selectBoxAppend(dealGubunList, 'modalDealGubun', '', '1'); //거래구분
	selectBoxAppend(dealCorpStatusList, 'modalDealCorpStatus', '', '1'); //거래상태
	selectBoxAppend(ordGubunList, 'ordGubun', '', '2');
	selectBoxAppend(itemGubunList, 'modalItemGubunBox', '', '1'); //제품구분
	selectBoxAppend(useYnCdList, 'modalUseYnCdBox', 'Y', '1'); //사용여부

	let purchaseFormData = new FormData(); //발주서파일 전용 폼데이터
    
	$('#startDate').val(moment().subtract('M',1).format('YYYY-MM-DD'));	//(doyeji 8.29 수정, 수주등록 화면이 느려 한달로 변경함)
	$('#endDate').val(moment().format('YYYY-MM-DD'));

	let bizOrdAdmIdxVal = '';
	let bizOrdDtlIdxVal = '';
	let customerIdxVal = '';
	let ordQtyVal = '';
	let stockUseQtyVal = '';
	let workPlaceIdxVal = '';
	let bizOrdAdmTrId = '';
	let bizOrdDtlTrId = '';
	let bizOrdAdmUuid = '';
	let bizOrdAdmExt = '';

	let itemSelectList = [];

	let prcssEquipList = [];
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
	let workPlaceList = [];
	$.ajax({
		url : '<c:url value="/sm/workplaceLst"/>',
		type : 'POST',
		async : false,
		data : {
			'useYnCd' : function() { return '001'; }
		},
        beforeSend: function() {
        	$('#my-spinner').show();
        },
		success : function(res) {
			if (res.result == "ok") { //응답결과
				let data = res.data;
				workPlaceList = data;
			} else if(res.result == 'fail') {
				toastr.warning(res.message);
			} else {
				toastr.error(res.message);
			}
			$('#my-spinner').hide();
		}
	});

	
	// 수주관리 목록조회
	$('#bizOrderAdmTable thead tr').clone(true).addClass('filters').appendTo('#bizOrderAdmTable thead'); // filter 생성
	let bizOrderAdmTable = $('#bizOrderAdmTable').DataTable({
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
			url : '<c:url value="/bs/bizOrderAdmLst"/>',
			type : 'POST',
			data : {
				startDate : function() { return moment($('#startDate').val()).format('YYYYMMDD'); },
				endDate : function() { return moment($('#endDate').val()).format('YYYYMMDD'); },
				searchTarget	: function() { return $('#searchTarget').val(); },
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'bizOrdNo', className : 'text-center align-middle'},
			{ data: 'dealCorpNm', className : 'text-center align-middle'},
			{ data: 'bizOrdDtlCnt', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
						
					} else {
						return "";
					}
				}	
			},
			{ data: 'conFirmCnt', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
						
					} else {
						return "";
					}
				}	
			},
			{ data: 'workOrdCnt', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						let stockOutCnt = isEmptyCheck(row['stockOutCnt']) ? 0 : row['stockOutCnt'];
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data) - parseFloat(stockOutCnt))+'</div>';
						
					} else {
						return "";
					}
				}	
			},
			{ data: 'purOrdCnt', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						let stockOutCnt = isEmptyCheck(row['stockOutCnt']) ? 0 : row['stockOutCnt'];
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
						
					} else {
						return "";
					}
				}	
			},
			{ data: 'prodOutCnt', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						let stockOutCnt = isEmptyCheck(row['stockOutCnt']) ? 0 : row['stockOutCnt'];
						
						let html = '';
						html += '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
						//html += '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+ '<span style="color: #ff0000;">(' + addCommas(parseFloat(stockOutCnt))  + ')</span>' +'</div>';
						return html;
					} else {
						return "";
					}
				}	
			},
			
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
					columns: ':visible',
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
			let theadHeight = parseFloat($('#bizOrderAdmTable_wrapper').find('.dataTables_scrollHead').css('height'));
 			let leftHeader = parseFloat($('#leftHeader').css('height'));
 			let leftSecondHeader = parseFloat($('#leftSecondHeader').css('height'));

			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - leftHeader - leftSecondHeader - 43)+'px');
			
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
				let cell = $('#bizOrderAdmTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#bizOrderAdmTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});

			bizOrderAdmTable.draw(false);
		},
	});
	// dataTable colReorder event
	bizOrderAdmTable.on('column-reorder', function( e, settings, details ) {
		let api = bizOrderAdmTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#bizOrderAdmTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	// 수주관리 메인 조회버튼 click
	$('#btnSearchBizAdm').on('click', function() {
		bizOrderAdmTable.row('.selected').deselect();
		bizOrderDtlTable.row('.selected').deselect();
		$('#btnWorkOrdConfirm').addClass('btn-outline-light');
		$('#btnWorkOrdConfirm').removeClass('btn-success');
		bizOrdAdmIdxVal = '';
		bizOrdDtlIdxVal = '';
		itemIdx = '';
		
		bizOrderAdmTable.ajax.reload();
		bizOrderDtlTable.ajax.reload(function(){},false);
		processInfoTable.ajax.reload();
		purchaseOrderAdmTable.ajax.reload();
		fileTable.ajax.reload();
		bundleInfoTable.ajax.reload();
	});

	// 수주관리 메인 항목 선택
	$('#bizOrderAdmTable tbody').on('click', 'tr', function() {
		let idx = bizOrderAdmTable.row(this).data().idx;
		if(WMCheck('prcssNew')) { // 공정 등록중일 경우
			setWM('prcssNew', 'idx', idx);
			setWM('prcssNew', 'gubun', bizOrderAdmTable);
			return false;
		} 
		if(WMCheck('fileNew')) { // 파일 등록중일 경우
			setWM('fileNew', 'idx', idx);
			setWM('fileNew', 'gubun', bizOrderAdmTable);
			return false;
		}
		if(WMCheck('matrlNew')) { // 자재 등록중일 경우
			setWM('matrlNew', 'idx', idx);
			setWM('matrlNew', 'gubun', bizOrderAdmTable);
			return false;
		}
		if(WMCheck('bundleNew')) { // 번들링 등록중일 경우
			setWM('bundleNew', 'idx', idx);
			setWM('bundleNew', 'gubun', bizOrderAdmTable);
			return false;
		}
		let data = bizOrderAdmTable.row(this).data();
		
		bizOrdAdmUuid = data.purchaseUuid;
		bizOrdAdmExt = data.purchaseExt;
		
		bizOrdAdmIdxVal = idx;
		bizOrderDtlTable.row('.selected').deselect();
		
		bizOrderDtlTable.ajax.reload(function(){},false);

		
		itemIdx = 0;
		bizOrdDtlIdxVal = 0;
		$('#btnProcessCopy').attr('disabled',true);
		$('#btnProcessNew').attr('disabled',true);
		$('#btnProcessSave').attr('disabled',true);
		$('#btnProcessEdit').attr('disabled',true);
		$('#btnProcessDel').attr('disabled',true);
		$('#btnProcessCancel').attr('disabled',true);
		$('#btnWorkPrint').attr('disabled',true);
		
		$('#btnWorkOrdConfirm').attr('disabled',true);
		processInfoTable.clear().draw();
		//사진 및 첨부파일 버튼들
		$('#btnFileAdd').attr('disabled',true);
		$('#btnFileSave').attr('disabled',true);
		$('#btnFileDel').attr('disabled',true);
		fileTable.clear().draw();
		$('#imgView').attr('style','');
		$('#viewer').attr('src','data:image/jpeg;base64,');
		//수주별발주 버튼들
		$('#btnMaterialNew').attr('disabled',true);
		$('#btnMaterialCopy').attr('disabled',true);
		$('#btnMaterialSave').attr('disabled',true);
		$('#btnMaterialEdit').attr('disabled',true);
		$('#btnMaterialDel').attr('disabled',true);
		$('#btnMaterialCancel').attr('disabled',true);
		$('#purchaseOrderAdmTable_wrapper').find('.filters th').each(function(index, item) {
			$(item).find('input').attr('disabled', false); // 검색 필터 disabled
		});
		purchaseOrderAdmTable.colReorder.enable();
		purchaseOrderAdmTable.clear().draw();
		bundleInfoTable.clear().draw();
		$('#btnNewAdm').attr('disabled', false);
		$('#btnDelAdm').attr('disabled', false);
		$('#btnEditDtl').attr('disabled', false);
		$('#btnDelDtl').attr('disabled', false);
	});

	// 신규 버튼 click
	$('#btnNewAdm').on('click', function() {
		$('.inputGroup').val('');

		WM_action_ON('new', 'workingWarningModal');

		$('#bizOrdNo').val('자동채번');
		$('#regIdxNm').val("${userNm}");
		$('#ordDate').val(moment().format('YYYY-MM-DD'));
		$('#ordGubun').val('10'); // 기본으로 일반 선택

		//
		$('#ordDesc').attr('disabled',false);
		$('#ordGubun').attr('disabled',false);
		$('#ordDate').attr('disabled',false);
		$('#btnDealCorpSelect').attr('disabled',false);

		purchaseFormData = new FormData();
		$('#purchaseFileNm').val('');
		$('#purchaseViewer').attr('src','');
		$('#purchaseFileUpload').attr('disabled',false);
		let element = document.getElementById('purchaseImgView');
		let panzoom = Panzoom(element, {});		
		let parent = element.parentElement;
	    parent.addEventListener('wheel', panzoom.zoomWithWheel);

	    /*   
	    	톰 캣
	        /\_/\
	      =( °w° )=
	        )   (  //
	       (__ __)//
	    */
	    bizOrderAdmTable.rows('.selected').deselect();
	    bizOrderDtlTable.clear().draw();
	    processInfoTable.clear().draw();
	    fileTable.clear().draw();
	    purchaseOrderAdmTable.clear().draw();
	    bundleInfoTable.clear().draw();
	    
	    bizOrdAdmUuid = '';
		bizOrdAdmExt = '';
		bizOrdAdmIdxVal = 0;
		itemIdx = 0;
		bizOrdDtlIdxVal = 0;
		
		
		$('#orderAddEditModal').modal('show');
		setTimeout(function() {
			bizOrderDtlAddEditTable.clear().draw();
			
			let viewWidth = (parseInt($('#purchaseImgDiv').css('width'))) + 'px';
			$('#purchaseViewer').css('width',viewWidth);

			let viewHeight = (parseInt($('#purchaseImgDiv').css('height'))) + 'px';
			$('#purchaseViewer').css('height',viewHeight);
		}, 200);
	});

	// 수정 버튼 click
	$('#btnEditDtl').on('click', function() {
		if(bizOrderAdmTable.row('.selected').data() == undefined) {
			toastr.warning('수주를 선택해주세요.');
			return false;
		}

		WM_action_ON('edit', 'workingWarningModal');

		let idx = bizOrderAdmTable.row('.selected').data().idx;
		let data = bizOrderAdmSel(idx);

		bizOrdAdmIdxVal = data.idx;

		$('#bizOrdNo').val(data.bizOrdNo);
		$('#dealCorpIdx').val(data.dealCorpIdx);
		$('#dealCorpNm').val(data.dealCorpNm);
		$('#ordDate').val(moment(data.ordDate,'YYYYMMDD').format('YYYY-MM-DD'));
		$('#outReqDate').val(moment(data.outReqDate, 'YYYYMMDD').format('YYYY-MM-DD'));
		$('#ordGubun').val(data.ordGubun);
		$('#regIdxNm').val(data.regIdxNm);
		$('#ordDesc').val(data.ordDesc);

		//
		$('#ordDesc').attr('disabled',false);
		$('#ordGubun').attr('disabled',false);
		$('#ordDate').attr('disabled',true);
		$('#btnDealCorpSelect').attr('disabled',true);

		$('#purchaseFileUpload').attr('disabled',false);
		if( !isEmptyCheck(data.purchaseUuid) && !isEmptyCheck(data.purchaseExt) ){
			//파일 blob로 불러오는곳
			let fileObject = new Object();
			fileObject.uuid = data.purchaseUuid;
			fileObject.ext = data.purchaseExt;
			let fileBlob = getFileBlob(fileObject);
			let blob = new Blob([base64ToArrayBuffer(fileBlob)], { type: data.ext });
            let file = new File([blob], data.fileNm, { lastModified: new Date().getTime(), type: data.ext });
            purchaseFormData.append('file',file);
            purchaseFormData.append('uuid',data.purchaseUuid);
            purchaseFormData.append('ext',data.purchaseExt); 
            purchaseFormData.append('fileNm', data.purchaseFileName);
            
			 //인코딩 및 파일명 
		    $('#purchaseFileNm').val(data.purchaseFileName + '.' + data.purchaseExt);
			$('#purchaseViewer').attr('src','data:image/jpeg;base64,'+fileBlob);
		} else {
			$('#purchaseFileNm').val('');
			$('#purchaseViewer').attr('src','');
		}
		//불러온 파일로 마우스 커서이벤트
		let element = document.getElementById('purchaseImgView');
		let panzoom = Panzoom(element, {});		
		let parent = element.parentElement;
	    parent.addEventListener('wheel', panzoom.zoomWithWheel);
	   
		
		$('#orderAddEditModal').modal('show');
		setTimeout(function() {
			bizOrderDtlAddEditTable.clear().draw();
			let viewWidth = (parseInt($('#purchaseImgDiv').css('width'))) + 'px';
			$('#purchaseViewer').css('width',viewWidth);

			let viewHeight = (parseInt($('#purchaseImgDiv').css('height'))) + 'px';
			$('#purchaseViewer').css('height',viewHeight);
			bizOrderDtlAddEditTable.ajax.reload(function() {
			});
		}, 200);
	});

	// 작업중 경고 모달 예 버튼 click
	$('#btnWorkingWarningModalY').on('click', function() {
		if(WMlastIdx == 'new' || WMlastIdx == 'edit') { // 등록중이거나 수정중이였을 경우
			$('#btnSave').trigger('click');
			return false;
		} else if(WMlastIdx == 'prcssNew'){ //공정 등록중이었을 때
			$('#btnProcessSave').trigger('click');
			return false;
		} else if(WMlastIdx == 'fileNew'){ //파일 등록중이었을 때
			$('#btnFileSave').trigger('click');
			return false;
		} else if(WMlastIdx == 'matrlNew'){ //자재 등록중이었을 때
			$('#btnMaterialSave').trigger('click');
			return false;
		} else if(WMlastIdx == 'bundleNew'){ //자재 등록중이었을 때
			$('#btnBundleSave').trigger('click');
			return false;
		}
	});

	// 작업중 경고 모달 아니요 버튼 click
	$('#btnWorkingWarningModalN').on('click', function() {
		if(WMlastIdx == 'new' || WMlastIdx == 'edit') { // 등록중이거나 수정중이였을 경우
			if(getWM(WMlastIdx, 'idx') != '' && getWM(WMlastIdx, 'idx') != undefined) {
				let idx = getWM(WMlastIdx, 'idx');
				WM_action_OFF(WMlastIdx);
				setWM(WMlastIdx, 'idx', '');
				userTable.row('#'+idx).select();
				$(userTable.row('#'+idx).node()).trigger('click'); // 선택했던 항목 선택처리
			} else {
				WM_action_OFF(WMlastIdx);
				if(window.location != window.parent.location) { // tab일 경우
					// 부모 탭 닫기버튼 click
					$('#tab-list', parent.document).find('.active').find('span').eq(1).find('i').trigger('click');
			    }
				
				$('.inputGroup').attr('disabled', true); // 입력항목
				$('#btnUserIdCheck').attr('disabled', true); // 중복확인 버튼
				$('#btnSignImage').attr('disabled', true); // 사진선택 버튼
				
				$('#btnNew').attr('disabled', false); // 신규 버튼
				$('#btnSave').attr('disabled', true); // 저장 버튼
				$('#btnEdit').attr('disabled', true); // 수정 버튼
				$('#btnDel').attr('disabled', true); // 삭제 버튼
				$('#btnCancel').attr('disabled', true); // 취소 버튼
			}
			
			return false;
		} else if(WMlastIdx == 'prcssNew'){ //공정 등록중이었을 때 
			if(getWM(WMlastIdx, 'idx') != '' && getWM(WMlastIdx, 'idx') != undefined) {
				let idx = getWM(WMlastIdx, 'idx');
				let gubun = getWM(WMlastIdx, 'gubun');
				WM_action_OFF('new');
				WM_action_OFF('edit');
				WM_action_OFF('prcssNew');
				WM_action_OFF('fileNew');
				WM_action_OFF('matrlNew');
				setWM(WMlastIdx, 'idx', '');
				gubun.row('#'+idx).select();
				$(gubun.row('#'+idx).node()).trigger('click'); // 선택했던 항목 선택처리
			} else {
				WM_action_OFF(WMlastIdx);
				if(window.location != window.parent.location) { // tab일 경우
					// 부모 탭 닫기버튼 click
					$('#tab-list', parent.document).find('.active').find('span').eq(1).find('i').trigger('click');
			    }
				
				$('.inputGroup').attr('disabled', true); // 입력항목
				$('#btnUserIdCheck').attr('disabled', true); // 중복확인 버튼
				$('#btnSignImage').attr('disabled', true); // 사진선택 버튼
				
				$('#btnNew').attr('disabled', false); // 신규 버튼
				$('#btnSave').attr('disabled', true); // 저장 버튼
				$('#btnEdit').attr('disabled', true); // 수정 버튼
				$('#btnDel').attr('disabled', true); // 삭제 버튼
				$('#btnCancel').attr('disabled', true); // 취소 버튼				
				
				$('#btnFileAdd').attr('disabled',true);
				$('#btnFileDel').attr('disabled',true);
			}
		} else if(WMlastIdx == 'fileNew'){ //파일등록중이었을 때 
			if(getWM(WMlastIdx, 'idx') != '' && getWM(WMlastIdx, 'idx') != undefined) {
				let idx = getWM(WMlastIdx, 'idx');
				let gubun = getWM(WMlastIdx, 'gubun');
				WM_action_OFF('new');
				WM_action_OFF('edit');
				WM_action_OFF('prcssNew');
				WM_action_OFF('fileNew');
				WM_action_OFF('matrlNew');
				setWM(WMlastIdx, 'idx', '');
				gubun.row('#'+idx).select();
				$(gubun.row('#'+idx).node()).trigger('click'); // 선택했던 항목 선택처리
				
			} else {
				WM_action_OFF(WMlastIdx);
				if(window.location != window.parent.location) { // tab일 경우
					// 부모 탭 닫기버튼 click
					$('#tab-list', parent.document).find('.active').find('span').eq(1).find('i').trigger('click');
			    }
				
				$('.inputGroup').attr('disabled', true); // 입력항목
				$('#btnUserIdCheck').attr('disabled', true); // 중복확인 버튼
				$('#btnSignImage').attr('disabled', true); // 사진선택 버튼
				
				$('#btnNew').attr('disabled', false); // 신규 버튼
				$('#btnSave').attr('disabled', true); // 저장 버튼
				$('#btnEdit').attr('disabled', true); // 수정 버튼
				$('#btnDel').attr('disabled', true); // 삭제 버튼
				$('#btnCancel').attr('disabled', true); // 취소 버튼				
				
				$('#btnFileAdd').attr('disabled',true);
				$('#btnFileDel').attr('disabled',true);
			}
			return false;
		} else if(WMlastIdx == 'matrlNew'){ //자재등록중이었을 때 
			if(getWM(WMlastIdx, 'idx') != '' && getWM(WMlastIdx, 'idx') != undefined) {
				let idx = getWM(WMlastIdx, 'idx');
				let gubun = getWM(WMlastIdx, 'gubun');
				WM_action_OFF('new');
				WM_action_OFF('edit');
				WM_action_OFF('prcssNew');
				WM_action_OFF('fileNew');
				WM_action_OFF('matrlNew');
				setWM(WMlastIdx, 'idx', '');
				gubun.row('#'+idx).select();
				$(gubun.row('#'+idx).node()).trigger('click'); // 선택했던 항목 선택처리
				
			} else {
				WM_action_OFF(WMlastIdx);
				if(window.location != window.parent.location) { // tab일 경우
					// 부모 탭 닫기버튼 click
					$('#tab-list', parent.document).find('.active').find('span').eq(1).find('i').trigger('click');
			    }
				
				$('.inputGroup').attr('disabled', true); // 입력항목
				$('#btnUserIdCheck').attr('disabled', true); // 중복확인 버튼
				$('#btnSignImage').attr('disabled', true); // 사진선택 버튼
				
				$('#btnNew').attr('disabled', false); // 신규 버튼
				$('#btnSave').attr('disabled', true); // 저장 버튼
				$('#btnEdit').attr('disabled', true); // 수정 버튼
				$('#btnDel').attr('disabled', true); // 삭제 버튼
				$('#btnCancel').attr('disabled', true); // 취소 버튼				
				
				$('#btnFileAdd').attr('disabled',true);
				$('#btnFileDel').attr('disabled',true);
			}
			return false;
		}
	});

	// 수주관리 메인 삭제버튼 click
	$('#btnDelAdm').on('click', function() {
		if($('#bizOrderAdmTable tbody').find('tr.selected').length == 0) {
			toastr.warning('삭제할 항목을 선택해주세요.');
			return false;
		}

		$('#deleteModal').modal('show');
		$('#deleteModal').data('deleteType','ADM');
	});

	// 삭제 경고창 삭제 버튼 click
	$('#btnDeleteModalY').on('click', function() {
		let deleteType = $('#deleteModal').data('deleteType');
		if(deleteType == 'ADM') {
			let idx = bizOrderAdmTable.row('.selected').data().idx;
			let uuid = bizOrderAdmTable.row('.selected').data().purchaseUuid;
			let ext = bizOrderAdmTable.row('.selected').data().purchaseExt;
			$.ajax({
				url: '<c:url value="/bs/bizOrderAdmDel"/>',
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
						//등록되었떤 파일 삭제처리
						fileDelete({uuid:uuid,ext:ext});
						$('#btnSearchBizAdm').trigger('click');
						//bizOrderAdmTable.row('.selected').remove().draw(false);
					} else if(res.result == 'fail') {
						toastr.warning(res.message);
					} else {
						toastr.error(res.message);
					}
					$('#my-spinner').hide();
				}
			});
		} else if(deleteType == 'DTL') {
			let idx = bizOrderDtlTable.row('.selected').data().idx;
			$.ajax({
				url: '<c:url value="/bs/bizOrderDtlDel"/>',
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
						bizOrdDtlIdxVal = '';
						bizOrderDtlTable.ajax.reload(function(){},false);
						processInfoTable.ajax.reload();
						purchaseOrderAdmTable.ajax.reload();
						fileTable.ajax.reload();
					} else if(res.result == 'fail') {
						toastr.warning(res.message);
					} else {
						toastr.error(res.message);
					}
					$('#my-spinner').hide();
				}
			});
		} else if(deleteType == 'file'){
			let idx = fileTable.row('.selected').data().idx;
			$.ajax({
				url: '<c:url value="/bm/itemFileDelete"/>',
	            type: 'POST',
	            //async: false,
	            data: {
	                'idx'	:	function(){ return idx; }
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if(res.result == 'ok'){
						toastr.success('삭제되었습니다.');
						let uuid = $('#fileTable').DataTable().row('.selected').data().uuid;
						let ext = $('#fileTable').DataTable().row('.selected').data().ext;
						fileDelete({uuid:uuid,ext:ext});
						//테이블 리로드
						fileTable.ajax.reload(function(){});
						
					} else if(res.result == 'fail') {
						toastr.warning(res.message);
					} else {
						toastr.error(res.message);
					}
					$('#my-spinner').hide();
				}
			});
		} else if(deleteType == 'prcss'){
			let idx = processInfoTable.row('.selected').data().idx;
			$.ajax({
				url: '<c:url value="/bs/bizOrderItemPrcssDelete"/>',
	            type: 'POST',
	            data: {
	                'idx'	:	function(){ return idx; }
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if(res.result == 'ok'){
						toastr.success('삭제되었습니다.');

						$('#processInfoTable').DataTable().row('.selected').remove().draw();

						$('#btnProcessCopy').attr('disabled',false);
					} else if(res.result == 'fail') {
						toastr.warning(res.message);
					} else {
						toastr.error(res.message);
					}
					$('#my-spinner').hide();
				}
			});
		} else if(deleteType == 'inputMatrl'){
			let idx = purchaseOrderAdmTable.row('.selected').data().idx;
			$.ajax({
				url: '<c:url value="/pm/purchaseOrderAdmDel"/>',
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

						//purchaseOrderAdmTable.clear().draw();
						//purchaseOrderAdmTable.ajax.reload();
						purchaseOrderAdmTable.row('.selected').remove().draw(false);

						// 수주별발주내역이 존재하지 않을 경우 BOM목록을 불러와 저장할 수 있는 상태로 셋팅
						/* $('#matrlSelectGubun').val('001');
						if(purchaseOrderAdmTable.data().count() == 0 && bizOrderDtlTable.row('.selected').data() != undefined) {
							let dataList = matrlModalSelectTable.data().toArray();
							let addList = [];
							for(var i=0;i<dataList.length;i++) {
								let obj = {};
								obj.idx = '';
								obj.matrlIdx = dataList[i].matrlIdx;
								obj.matrlCd = dataList[i].matrlCd;
								obj.matrlNm = dataList[i].matrlNm;
								obj.paperType = dataList[i].paperType;
								obj.confirmYn = 'N';
								obj.printYn = 'N';
								obj.purchaseOrdNo = '자동채번';
								obj.purchaseOrdQty = ordQtyVal;
								obj.purchaseOrdDate = moment().format('YYYY-MM-DD');
								obj.purchaseInDueDate = moment().format('YYYY-MM-DD');
								if(dataList[i].dealCorpIdx > 0 && dataList[i].dealCorpNm != null){
									obj.dealCorpIdx = dataList[i].dealCorpIdx;
									obj.dealCorpNm = dataList[i].dealCorpNm;
								} else {
									obj.dealCorpIdx = '';
									obj.dealCorpNm = '';
								}
								obj.cutQty = dataList[i].cutQty;
								obj.eaQty = dataList[i].eaQty;
								obj.extraQty = dataList[i].extraQty;
								obj.extraPackQty = '0';
								obj.cutSize = dataList[i].cutSize;
								obj.purchaseNote = '';
								obj.purchaseDesc = '';
								addList.push(obj);
							}
							purchaseOrderAdmTable.rows.add(addList).draw(false);
							$('#purchaseOrderAdmTable_wrapper').find('.filters th').each(function(index, item) {
								$(item).find('input').attr('disabled', true); // 검색 필터 disabled
							});
							purchaseOrderAdmTable.colReorder.disable();
							purchaseOrderAdmTable.draw();
			
							$('#btnMaterialNew').attr('disabled', false); // DTL 신규 버튼
							$('#btnMaterialSave').attr('disabled', false); // DTL 저장 버튼
							$('#btnMaterialEdit').attr('disabled', true); // DTL 수정 버튼
							$('#btnMaterialDel').attr('disabled', false); // DTL 삭제 버튼
							$('#btnMaterialCancel').attr('disabled', false); // DTL 취소 버튼
			
							
							
						} else {
							$('#purchaseOrderAdmTable_wrapper').find('.filters th').each(function(index, item) {
								$(item).find('input').attr('disabled', false); // 검색 필터 disabled
							});
							purchaseOrderAdmTable.colReorder.enable();
						} */
					} else if(res.result == 'fail') {
						toastr.warning(res.message);
					} else {
						toastr.error(res.message);
					}
					$('#my-spinner').hide();
				}
			});
		} else if(deleteType == 'bundle'){
			let idx = bundleInfoTable.row('.selected').data().idx;
			let bizOrdDtlIdx = bundleInfoTable.row('.selected').data().bizOrdDtlIdx; 
			$.ajax({
				url: '<c:url value="/bs/bizOrderDtlBundleDel"/>',
	            type: 'POST',
	            data: {
	                'idx'			:	function(){ return idx; },
                	'bizOrdDtlIdx'	:	function(){ return bizOrdDtlIdx; },
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if(res.result == 'ok'){
						toastr.success('삭제되었습니다.');

						$('#bundleInfoTable').DataTable().row('.selected').remove().draw();

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
	









	// 수주관리 목록조회
	$('#bizOrderDtlTable thead tr').clone(true).addClass('filters').appendTo('#bizOrderDtlTable thead'); // filter 생성
	let bizOrderDtlTable = $('#bizOrderDtlTable').DataTable({
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
		select: {
            style: 'single',
            toggleable: false,
            items: 'row',
            info: false
        },
        ajax : {
			url : '<c:url value="/bs/bizOrderDtlLst"/>',
			type : 'POST',
			data : {
				bizOrdAdmIdx: function() { return bizOrdAdmIdxVal; }
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'bizStopYn', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data == 'Y') {
						let html = '';
						html += '<input type="checkbox" class="bootstrapToggle bizStopToggle p-0" data-toggle="toggle"';
						html += '		data-type="bizStopYn" data-idx="'+row['idx']+'"';
						html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
						html += '		data-size="small"';
						html += '		checked>';
						return html;
					} else {
						let html = '';
						html += '<input type="checkbox" class="bootstrapToggle bizStopToggle p-0" data-toggle="toggle"';
						html += '		data-type="bizStopYn" data-idx="'+row['idx']+'"';
						html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
						html += '		data-size="small"';
						html += '		>';
						return html;
					}
				}
			},
			/* { data: 'stockUseYn', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data == 'Y') {
						let html = '';
						html += '<input type="checkbox" class="bootstrapToggle bizStock p-0" data-toggle="toggle"';
						html += '		data-type="stockUse" data-idx="'+row['idx']+'"';
						html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
						html += '		data-size="small"';
						html += '		checked>';
						return html;
					} else {
						let html = '';
						html += '<input type="checkbox" class="bootstrapToggle bizStock p-0" data-toggle="toggle"';
						html += '		data-type="stockUse" data-idx="'+row['idx']+'"';
						html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
						html += '		data-size="small"';
						html += '		>';
						return html;
					}
				}
			}, */
			/* { data: 'confirmOrder', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data == 'Y') {
						let html = '';
						html += '<input type="checkbox" class="bootstrapToggle confirmToggle p-0" data-toggle="toggle"';
						html += '		data-type="confirmOrder" data-idx="'+row['idx']+'"';
						html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
						html += '		data-size="small"';
						html += '		checked>';
						return html;
					} else {
						let html = '';
						html += '<input type="checkbox" class="bootstrapToggle confirmToggle p-0" data-toggle="toggle"';
						html += '		data-type="confirmOrder" data-idx="'+row['idx']+'"';
						html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
						html += '		data-size="small"';
						html += '		>';
						return html;
					}
				}
			}, */
			{ data: 'confirmDesign', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data == 'Y') {
						let html = '';
						html += '<input type="checkbox" class="bootstrapToggle confirmToggle p-0" data-toggle="toggle"';
						html += '		data-type="confirmDesign" data-idx="'+row['idx']+'"';
						html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
						html += '		data-size="small"';
						html += '		checked>';
						return html;
					} else {
						let html = '';
						html += '<input type="checkbox" class="bootstrapToggle confirmToggle p-0" data-toggle="toggle"';
						html += '		data-type="confirmDesign" data-idx="'+row['idx']+'"';
						html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
						html += '		data-size="small"';
						html += '		>';
						return html;
					}
				}
			},
			{ data: 'bizOrdDtlNo', className : 'text-center align-middle'},
			{ data: 'bizStatusCd', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data !=''){
						//수주취소 , po완료 
						if(data == '03' || data == '08'){
							return _.filter(ordStatusList,v=>v.commonCd == data)[0].commonNm;;
						} else if(row['bizStopYn'] == 'Y'){
							return '수주중지';
						} else {
							return _.filter(ordStatusList,v=>v.commonCd == data)[0].commonNm;;
						}
					} else {
						return "수주등록";
					}
				}
			},
			{ data: 'workMethodJson', className : 'text-center align-middle', //진행상태
				render : function(data, type, row, meta) {
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
							let progressNm = '-';
							filterList = parseData.filter(v=>v.progressStatus == 'WC');
							finshPrcssCount = filterList.length;
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
			},
			{ data: 'dealCorpNm', className : 'text-center align-middle'},
			{ data: 'itemNm', className : 'text-center align-middle'},
			{ data: 'customerItemCd', className : 'text-center align-middle'},
			{ data: 'itemVersion', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					let obj = "";
						obj += "{";
						obj += "	'uuid':'"+row['uuid']+"',";
						obj += "	'fileName':'"+row['fileNm']+"',";
						obj += "	'ext':'"+row['ext']+"'";
						obj += "}";
					let html = '';
					if(row['uuid'] == '' || row['uuid'] == null) {
						html += '<span>'+data+'</span>';
					} else {
						html += '<a href="/serverFile/'+row['uuid']+'.'+row['ext']+'" target="_blank">'+data+'<a>';
					}
						
					return html;
				}
			},			
			{ className : 'text-center align-middle', //버전번호 변경(최신화)
				render : function(data, type, row, meta) {
					let html = '';
					html += '<div class="btn-group" role="group" aria-label="Small button group">';
					html += '	<button type="button" class="btn btn-outline-light w-auto monthAdjustBtn versionUpdate">';
					html += '변경</button>';
					html += '</div>';
					
					return html;
				}
			},
			{ data: 'spQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return addCommas(parseInt(data));
					} else {
						return '0';
					}
				}
			},
			{ data: 'ordQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return addCommas(parseInt(data));
					} else {
						return '0';
					}
				}
			},
			{ data: 'stockUseQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return addCommas(parseInt(data));
					} else {
						return '0';
					}
				}
			},
			{ data: 'workEndReqDate', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != '' && data != null) {
						return moment(data,'YYYYMMDD').format('YYYY-MM-DD');
					} else {
						return '';
					}
				}
			},
			{ data: 'outReqDate', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != '' && data != null) {
						return moment(data,'YYYYMMDD').format('YYYY-MM-DD');
					} else {
						return '';
					}
				}
			},
			{ data: 'ordIssue', className : 'text-start align-middle',
				render : function(data, type, row, meta) {
					if(data != '' && data != null) {
						return '<div style="white-space:pre-line;width:330px;">'+data+'</div>';
					} else {
						return '';
					}
				}
			}, //건별전달사항
			{ data: 'ordNote', className : 'text-start align-middle',
				render : function(data, type, row, meta) {
					if(data != '' && data != null) {
						return '<div style="white-space:pre-line;width:330px;">'+data+'</div>';
					} else {
						return '';
					}
				}
			}, //특이사항
			{ data: 'itemSize', className : 'text-center align-middle'},
			{ data: 'knifeTipSize', className : 'text-center align-middle'},
			{ data: 'itemColor', className : 'text-center align-middle'},
			{ data: 'coatingMethod', className : 'text-center align-middle'},
			
			{ data: 'ordDtlDesc', className : 'text-center align-middle'},
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
			{ extend: 'colvis',	text: 'Select Col',	dropup: true},
		],
		order : [],
		drawCallback: function() {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#bizOrderDtlTable_wrapper').find('.dataTables_scrollHead').css('height'));
			let page_height = parseInt($('#page').height()); 			// 전체 높이
			let rightcolT_height = parseInt($('#rightcolT').height());	// 우측 상단
			let rightcolM_height = parseInt($('#rightcolM').height());	// 우측 중단
			let rightcolB_height = parseInt($('#rightcolB').height());	// 우측 하단
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - rightcolM_height - rightcolB_height - 55)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAllBod').off('keyup',function() {});
			$('#searchAllBod').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			});
			let data = api.data();
			let node = api.nodes();
			$('.bootstrapToggle').bootstrapToggle();
			
			
			if(data.length > 0){
				$(node).find('tbody tr').each(function(index, item) {
					if( bizOrderDtlTable.row(item).data().bizStatusCd == '03' || bizOrderDtlTable.row(item).data().bizStatusCd == '08') {
						$(bizOrderDtlTable.row(item).node()).find('.bootstrapToggle').bootstrapToggle('disable');
					}
					if( bizOrderDtlTable.row(item).data().bizStatusCd != '01' ){
						$(bizOrderDtlTable.row(item).node()).find('.bizStock').bootstrapToggle('disable');
					}
				});
			}
			try {
				bizOrderDtlTable.columns.adjust();
			} catch(e){
				//console.log('테이블 생성전');
			}
		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#bizOrderDtlTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#bizOrderDtlTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
			bizOrderDtlTable.draw(false);
		},
	});
	// dataTable colReorder event
	bizOrderDtlTable.on('column-reorder', function( e, settings, details ) {
		let api = bizOrderDtlTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#bizOrderDtlTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
		$('.bootstrapToggle').bootstrapToggle();
	});

	// 수주정지
	$(document).off('change','#bizOrderDtlTable .bizStopToggle');
	$(document).on('change','#bizOrderDtlTable .bizStopToggle', function() {
		$('#my-spinner').show();
		let idx = $(this).data('idx');
		let type = $(this).data('type');
		let check = $(this).prop('checked');

		if(type == 'bizStopYn'){
			$.ajax({
				url: '<c:url value="/bs/bizOrderDtlStop"/>',
				type: 'POST',
				data: {
					'idx'		: function(){ return idx; },
					'bizStopYn'	: function(){ return (check?'Y':'N'); },
				},
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if (res.result == "ok") { //응답결과
						if(check) {
							toastr.success('중지되었습니다.');
						} else {
							toastr.success('중지 취소되었습니다.');
						}
						bizOrdAdmTrId = bizOrderAdmTable.row('.selected').data().idx; 
						bizOrderAdmTable.rows('.selected').deselect();
						bizOrderAdmTable.ajax.reload(function(){
							bizOrderAdmTable.row('#'+bizOrdAdmTrId).select();
							//$(bizOrderAdmTable.row('#'+bizOrdAdmTrId).node()).trigger('click'); 
						},false);
						bizOrderDtlTable.ajax.reload(function(){},false);
					} else if(res.result == 'fail') {
						toastr.warning(res.message);
						bizOrderDtlTable.ajax.reload(function(){},false);
					} else {
						toastr.error(res.message);
					}
					$('#my-spinner').hide();
				}
			});
		}
	});
	
	// 수주확정, 디자인컨펌
	$(document).off('change','#bizOrderDtlTable .confirmToggle');
	$(document).on('change','#bizOrderDtlTable .confirmToggle', function() {
		$('#my-spinner').show();
		let idx = $(this).data('idx');
		let type = $(this).data('type');
		let check = $(this).prop('checked');

		
		let ajaxData = {};
		ajaxData.idx = idx;
		if(type == 'confirmOrder') { // 수주확정을 눌렀을 경우
			ajaxData.confirmOrder = (check?'Y':'N');
		} else if(type == 'confirmDesign') { // 디자인컨펌을 눌렀을 경우
			ajaxData.confirmDesign = (check?'Y':'N');
			/* 수주도 확정되도록 변경 */
			//ajaxData.confirmOrder = ajaxData.confirmDesign;
		}
		$('#my-spinner').hide();
		
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
					bizOrdAdmTrId = bizOrderAdmTable.row('.selected').data().idx; 
					bizOrderAdmTable.rows('.selected').deselect();
					bizOrderAdmTable.ajax.reload(function(){
						bizOrderAdmTable.row('#'+bizOrdAdmTrId).select();
						//$(bizOrderAdmTable.row('#'+bizOrdAdmTrId).node()).trigger('click'); 
					},false);
					bizOrderDtlTable.ajax.reload(function(){},false);
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
					bizOrderDtlTable.ajax.reload(function(){},false);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
	});

	// 재고사용
	$(document).off('change','#bizOrderDtlTable .bizStock');
	$(document).on('change','#bizOrderDtlTable .bizStock', function() {
		let idx = $(this).data('idx');
		let type = $(this).data('type');
		let check = $(this).prop('checked');
		if(type == 'stockUse' && !isEmptyCheck($(this).data('idx'))){
			$.ajax({
				url: '<c:url value="/bs/bizOrderDtlStockYnUpd"/>',
				type: 'POST',
				data: {
					'idx'			:	idx,
					'stockUseYn'	:	(check?'Y':'N')
				},
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
						bizOrdDtlTrId = bizOrderDtlTable.row('.selected').data().idx;
						bizOrderDtlTable.rows('.selected').deselect();
						bizOrderDtlTable.ajax.reload(function(){
							bizOrderDtlTable.row('#'+bizOrdDtlTrId).select();
							$(bizOrderDtlTable.row('#'+bizOrdDtlTrId).node()).trigger('click'); 
						},false);
					} else if(res.result == 'fail') {
						toastr.warning(res.message);
						bizOrderDtlTable.ajax.reload(function(){
						},false);
					} else {
						toastr.error(res.message);
					}

					$('#my-spinner').hide();
				}
			});
		}
	})
	
	let itemIdx = 0;
	//수주관리 목록 클릭
	$('#bizOrderDtlTable tbody').on('click','tr', function() {

		let idx = bizOrderDtlTable.row(this).data().idx;
		if(WMCheck('prcssNew')) { // 공정 등록중일 경우
			setWM('prcssNew', 'idx', idx);
			setWM('prcssNew', 'gubun', bizOrderDtlTable);
			return false;
		}
		if(WMCheck('fileNew')) { // 파일 등록중일 경우
			setWM('fileNew', 'idx', idx);
			setWM('fileNew', 'gubun', bizOrderDtlTable);
			return false;
		}
		if(WMCheck('matrlNew')) { // 자재 등록중일 경우
			setWM('matrlNew', 'idx', idx);
			setWM('matrlNew', 'gubun', bizOrderDtlTable);
			return false;
		}
		if(WMCheck('bundleNew')) { // 번들링 등록중일 경우
			setWM('bundleNew', 'idx', idx);
			setWM('bundleNew', 'gubun', bizOrderAdmTable);
			return false;
		}
		if(bizOrderDtlTable.row(this).data().bizStatusCd != '03' && bizOrderDtlTable.row(this).data().bizStatusCd != '08'){
			$('#btnBizDtlPoEnd').attr('disabled',false);
			$('#btnBizDtlCancel').attr('disabled',false);
		} else {
			$('#btnBizDtlPoEnd').attr('disabled',true);
			$('#btnBizDtlCancel').attr('disabled',true);
		}
		itemIdx = bizOrderDtlTable.row(this).data().itemIdx;
		bizOrdDtlIdxVal = bizOrderDtlTable.row(this).data().idx;
		ordQtyVal = bizOrderDtlTable.row(this).data().ordQty;
		stockUseQtyVal = isEmptyCheck(bizOrderDtlTable.row(this).data().stockUseQty) ? 0 : parseInt(bizOrderDtlTable.row(this).data().stockUseQty);
		
		if( parseInt(bizOrderDtlTable.row(this).data().bundleCnt) > 0 ){
			//번들링 지시서가 나와야하는 경우
			if(parseInt(bizOrderDtlTable.row(this).data().workOrdCnt) > 0){
				$('#btnWorkOrdConfirm').removeClass('btn-outline-light');
				$('#btnWorkOrdConfirm').addClass('btn-success');
			} else {
				$('#btnWorkOrdConfirm').addClass('btn-outline-light');
				$('#btnWorkOrdConfirm').removeClass('btn-success');
			}
			$('#btnWorkPrint').attr('disabled',false);
			if(bizOrderDtlTable.row(this).data().bundlePrintYn == 'Y'){
				$('#btnWorkPrint').removeClass('btn-outline-light');
				$('#btnWorkPrint').addClass('btn-success');

				//$('#btnWorkPrint').attr('disabled',false);
			} else {
				$('#btnWorkPrint').addClass('btn-outline-light');
				$('#btnWorkPrint').removeClass('btn-success');

				//$('#btnWorkPrint').attr('disabled',true);
			}
		} else {
			//일반 지시서가 나와야하는 경우
			if(parseInt(bizOrderDtlTable.row(this).data().workOrdCnt) > 0){
				$('#btnWorkOrdConfirm').removeClass('btn-outline-light');
				$('#btnWorkOrdConfirm').addClass('btn-success');

				$('#btnWorkPrint').attr('disabled',false);
			} else {
				$('#btnWorkOrdConfirm').addClass('btn-outline-light');
				$('#btnWorkOrdConfirm').removeClass('btn-success');

				$('#btnWorkPrint').attr('disabled',false);
			}

			if(bizOrderDtlTable.row(this).data().workPrintYn == 'Y'){
				$('#btnWorkPrint').removeClass('btn-outline-light');
				$('#btnWorkPrint').addClass('btn-success');

				//$('#btnWorkPrint').attr('disabled',false);
			} else {
				$('#btnWorkPrint').addClass('btn-outline-light');
				$('#btnWorkPrint').removeClass('btn-success');

				//$('#btnWorkPrint').attr('disabled',true);
			}
				
		}
		
		if(bizOrderDtlTable.row(this).data().newEditHistPrintYn == 'Y'){
			$('#btnNewEditPrint').removeClass('btn-outline-light');
			$('#btnNewEditPrint').addClass('btn-success');

			//$('#btnWorkPrint').attr('disabled',false);
		} else {
			$('#btnNewEditPrint').addClass('btn-outline-light');
			$('#btnNewEditPrint').removeClass('btn-success');

			//$('#btnWorkPrint').attr('disabled',true);
		}

		$('#btnProcessCopy').attr('disabled',true);
		//공정정보 버튼들
		$('#btnProcessNew').attr('disabled',false);
		$('#btnProcessSave').attr('disabled',true);
		$('#btnProcessEdit').attr('disabled',false);
		$('#btnProcessDel').attr('disabled',false);
		$('#btnProcessCancel').attr('disabled',true);

		$('#btnWorkOrdConfirm').attr('disabled',false);	// 작업계획확정
		$('#btnWorkOrdDel').attr('disabled',false);	//작업계획취소
		//사진 및 첨부파일 버튼들
		$('#btnFileAdd').attr('disabled',false);
		$('#btnFileSave').attr('disabled',true);
		$('#btnFileDel').attr('disabled',false);
		//수주별발주 버튼들
		$('#btnMaterialNew').attr('disabled',false);
		$('#btnMaterialCopy').attr('disabled',false);
		$('#btnMaterialSave').attr('disabled',true);
		$('#btnMaterialEdit').attr('disabled',false);
		$('#btnMaterialDel').attr('disabled',false);
		$('#btnMaterialCancel').attr('disabled',true);

		//번들링정보
		$('#btnBundleNew').attr('disabled',false);
		$('#btnBundleCopy').attr('disabled',false);
		$('#btnBundleSave').attr('disabled',true);
		$('#btnBundleEdit').attr('disabled',false);
		$('#btnBundleDel').attr('disabled',false);
		$('#btnBundleCancel').attr('disabled',true);
	
		/************************ 공정정보 리로드  ************************/
		processInfoTable.ajax.reload(function(){
			$('button[name=customerModalBtn]').attr('disabled',true);
			$('button[name=equipModalBtn]').attr('disabled',true);
			$('#btnProcessCopy').attr('disabled',false);
			setTimeout(function() {
				processInfoTable.draw(false);
			},100);
		});
		/************************ 사진 및 첨부파일 리로드  ************************/
		fileTable.ajax.reload(function(){});
		$('#imgView').attr('style','');
		$('#viewer').attr('src','data:image/jpeg;base64,');
		/************************ 수주별발주 리로드  ************************/
		
		purchaseOrderAdmTable.ajax.reload(function(){
			purchaseOrderAdmTable.draw(false);
			// 수주별발주내역이 존재하지 않을 경우 BOM목록을 불러와 저장할 수 있는 상태로 셋팅
			/* $('#matrlSelectGubun').val('001');
			matrlModalSelectTable.ajax.reload(function() {
				setTimeout(function() {
					if(purchaseOrderAdmTable.data().count() == 0 && bizOrderDtlTable.row('.selected').data() != undefined) {
						let dataList = matrlModalSelectTable.data().toArray();
						let addList = [];
						for(var i=0;i<dataList.length;i++) {
							let obj = {};
							obj.idx = '';
							obj.matrlIdx = dataList[i].matrlIdx;
							obj.matrlCd = dataList[i].matrlCd;
							obj.matrlNm = dataList[i].matrlNm;
							obj.paperType = dataList[i].paperType;
							obj.confirmYn = 'N';
							obj.printYn = 'N';
							obj.purchaseOrdNo = '자동채번';
							obj.purchaseOrdQty = ordQtyVal;
							obj.purchaseOrdDate = moment().format('YYYY-MM-DD');
							obj.purchaseInDueDate = moment().format('YYYY-MM-DD');
							if(dataList[i].dealCorpIdx > 0 && dataList[i].dealCorpNm != null){
								obj.dealCorpIdx = dataList[i].dealCorpIdx;
								obj.dealCorpNm = dataList[i].dealCorpNm;
							} else {
								obj.dealCorpIdx = '';
								obj.dealCorpNm = '';
							}
							obj.cutQty = dataList[i].cutQty;
							obj.eaQty = dataList[i].eaQty;
							obj.extraQty = dataList[i].extraQty;
							obj.extraPackQty = '0';
							obj.cutSize = dataList[i].cutSize;
							obj.purchaseNote = '';
							obj.purchaseDesc = dataList[i].etc1;
							addList.push(obj);
						}
						purchaseOrderAdmTable.rows.add(addList).draw(false);
						$('#purchaseOrderAdmTable_wrapper').find('.filters th').each(function(index, item) {
							$(item).find('input').attr('disabled', true); // 검색 필터 disabled
						});
						purchaseOrderAdmTable.colReorder.disable();
						purchaseOrderAdmTable.draw();
		
						$('#btnMaterialNew').attr('disabled', false); // DTL 신규 버튼
						$('#btnMaterialSave').attr('disabled', false); // DTL 저장 버튼
						$('#btnMaterialEdit').attr('disabled', true); // DTL 수정 버튼
						$('#btnMaterialDel').attr('disabled', false); // DTL 삭제 버튼
						$('#btnMaterialCancel').attr('disabled', false); // DTL 취소 버튼
		
						
						
					} else {
						$('#purchaseOrderAdmTable_wrapper').find('.filters th').each(function(index, item) {
							$(item).find('input').attr('disabled', false); // 검색 필터 disabled
						});
						purchaseOrderAdmTable.colReorder.enable();
					}
				},100); 
			}); */
		});

		/************************ 번들링 리로드  ************************/
		bundleInfoTable.ajax.reload(function(){
			bundleInfoTable.draw(false);
		});
	});
	
	// 수주관리 상세 삭제버튼 click
	$('#btnDelDtl').on('click', function() {
		if($('#bizOrderDtlTable tbody').find('tr.selected').length == 0) {
			toastr.warning('삭제할 항목을 선택해주세요.');
			return false;
		}
	
		$('#deleteModal').modal('show');
		$('#deleteModal').data('deleteType','DTL');
	});
	













	// 수주등록/수정 수주상세 목록조회
	//$('#bizOrderDtlAddEditTable thead tr').clone(true).addClass('filters').appendTo('#bizOrderDtlAddEditTable thead'); // filter 생성
	let bizOrderDtlAddEditTable = $('#bizOrderDtlAddEditTable').DataTable({
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
			dataSrc: 'progressOrder',
		},
		select: {
            style: 'single',
            toggleable: false,
            items: 'row',
            info: false
        },
        ajax : {
			url : '<c:url value="/bs/bizOrderDtlLst"/>',
			type : 'POST',
			data : {
				bizOrdAdmIdx: function() { return bizOrdAdmIdxVal; }
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'progressOrder', className : 'text-center align-middle'},
			/* { data: 'workplaceIdx', className : 'text-center align-middle', name : 'workplaceIdx',
				render : function(data, type, row, meta) {
					return workPlaceSelectBoxAppend(data);
					//return getWorkplaceLst(data);
				}
			}, */
			{ data: 'ordGubun',className : 'text-center',
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						let html = '';
						html += '<select name="ordGubun" class="form-select">';
						ordGubunList.forEach(function(item) {
							if(item.commonCd==data) {
								html +='<option value="'+item.commonCd+'" selected>'+item.commonNm+'</option>';
							} else {
								html +='<option value="'+item.commonCd+'">'+item.commonNm+'</option>';
							}
						});
						html += '</select>';
						return html;						
					} else {
						let html = '';
						html += '<select name="ordGubun" class="form-select">';
						ordGubunList.forEach(function(item) {
							html +='<option value="'+item.commonCd+'">'+item.commonNm+'</option>';
						});
						html += '</select>';
						return html;
					}
				}
			},
			{ data: 'bizOrdDtlNo', className : 'text-center align-middle'},
			/* { data: 'bizStatusCd',className : 'text-center', name : 'bizStatusCd',
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return _.filter(ordStatusList,v=>v.commonCd == data)[0].commonNm;
					} else {
						return '수주등록';						
					}
				}
			}, */
			/* { data: 'stockUseYn',className : 'text-center', name : 'stockUseYn',
				render : function(data, type, row, meta) {
					if(data == 'Y') {
						let html = '';
							html += '<input type="checkbox" class="bootstrapToggle confirmToggle p-0" data-toggle="toggle"';
							html += '		data-type="stockUse" data-idx="'+row['idx']+'"';
							html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
							html += '		data-size="mini"';
							html += '		checked>';
						return html;
					} else {
						let html = '';
							html += '<input type="checkbox" class="bootstrapToggle confirmToggle p-0" data-toggle="toggle"';
							html += '		data-type="stockUse" data-idx="'+row['idx']+'"';
							html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
							html += '		data-size="mini"';
							html += '		>';
						return html;
					}
				}
			}, */
			{ data: 'itemNm', className : 'text-center align-middle'},
			{ data: 'customerItemCd', className : 'text-center align-middle'},
			{ data: 'itemVersion', className : 'text-center align-middle'},
			/* { data: 'itemSize', className : 'text-center align-middle'},
			{ data: 'knifeTipSize', className : 'text-center align-middle'},
			{ data: 'itemColor', className : 'text-center align-middle'},
			{ data: 'coatingMethod', className : 'text-center align-middle'}, */
			{ data: 'spQty', className : 'text-end align-middle', name: 'stockQty',
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return addCommas(parseInt(data));
					} else {
						return '0';						
					}
				}
			},
			{ data: 'ordQty', className : 'text-end align-middle', name : 'ordQty',
				render : function(data, type, row, meta) {
					let html = '';
						html += '<input type="text" name="ordQty" class="form-control text-end" onkeyup="numberFormat(this, \'int\')" value="'+addCommas(parseInt(data))+'">';
					return html;
				}
			},
 			{ data: 'stockUseQty', className : 'text-end align-middle', name : 'stockUseQty',
				render : function(data, type, row, meta) {
					let html = '';
						html += '<input type="text" name="stockUseQty" class="form-control text-end" onkeyup="numberFormat(this, \'int\')" value="'+addCommas(parseInt(data))+'">';
					return html;
				}
			},
			{ data: 'stockReUseQty', className : 'text-end align-middle', name : 'stockReUseQty',
				render : function(data, type, row, meta) {
					let html = '';
						html += '<input type="text" name="stockReUseQty" class="form-control text-end" onkeyup="numberFormat(this, \'int\')" value="'+addCommas(parseInt(data))+'">';
					return html;
				}
			},
			{ data: 'purchaseBatch', className : 'text-end align-middle', name : 'purchaseBatch',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						let html = '';
							html += '<input type="text" name="purchaseBatch" class="form-control text-start" value="'+data+'">';
						return html;
					} else {
						let html = '';
							html += '<input type="text" name="purchaseBatch" class="form-control text-start">';
						return html;
					}
					
				}
			},
			/* { data: 'ordNote', className : 'text-center align-middle', name : 'ordNote',
				render : function(data, type, row, meta) {
					let html = '';
					if(data != null && data != ''){
						html += '<textarea class="form-control" rows="2" style="resize: none;width:100%;">'+data+'</textarea>';
					} else {
						html += '<textarea class="form-control" rows="2" style="resize: none;width:100%;"></textarea>';
					}
					return html;
				}
			}, */
			{ data: 'ordIssue', className : 'text-center align-middle', name : 'ordIssue',
				render : function(data, type, row, meta) {
					let html = '';
					if(data != null && data != ''){
						html += '<textarea class="form-control" rows="2" style="resize: none;width:100%;">'+data+'</textarea>';
					} else {
						html += '<textarea class="form-control" rows="2" style="resize: none;width:100%;"></textarea>';
					}
					return html;
				}
			},
			/* { data: 'workEndReqDate', className : 'text-center align-middle', name : 'workEndReqDate',
				render : function(data, type, row, meta) {
					let html = '';
						html += '<input type="date" max="9999-12-31" class="form-control" value="'+moment(data,'YYYYMMDD').format('YYYY-MM-DD')+'">';
					return html;
				}
			}, */
			{ data: 'outReqDate', className : 'text-center align-middle', name : 'outReqDate',
				render : function(data, type, row, meta) {
					let html = '';
						html += '<input type="date" name="outReqDate" max="9999-12-31" class="form-control" value="'+moment(data,'YYYYMMDD').format('YYYY-MM-DD')+'">';
					return html;
				}
			},
			/* { data: 'ordDtlDesc', className : 'text-center align-middle'}, */
			
		],
		columnDefs : [
			{ "targets": '_all', "orderable": false },
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
			/* { extend: 'colvis',	text: 'Select Col',	}, */
		],
		order : [[0,'asc']],
		drawCallback: function() {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let modal_header_height = parseInt($('#orderAddEditModal').find('.modal-header').height());
			let modal_content_row_1 = parseInt($('#orderAddEditModal').find('.container-fluid').find('.row').eq(0).height());
			let modal_content_row_2 = parseInt($('#orderAddEditModal').find('.container-fluid').find('.row').eq(1).height());
			let theadHeight = parseFloat($('#bizOrderDtlAddEditTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - 28 - modal_header_height - modal_content_row_1 - modal_content_row_2 - 208)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			//$('#searchAll').off('keyup',function() {});
			//$('#searchAll').on('keyup',function() {
			//	$('#'+table_id+'_filter').find('input').val($(this).val());
			//	$('#'+table_id+'_filter').find('input').trigger('keyup');
			//});


			let data = api.data();
			let node = api.nodes();
			$('#'+table_id+' tbody tr td').attr('style',"vertical-align: middle;");
			for(var i=0;i<data.length;i++) {
				let tr = $('#bizOrderDtlAddEditTable tbody').find('tr').eq(i);
				let colIndex = bizOrderDtlAddEditTable.column('stockQty:name').index(); 
				if(parseFloat($(tr).find('td').eq(colIndex).text()) <= 0 ){ 
					$(tr).find('td').eq(colIndex).attr('style','background-color: #fcff0078 !important;');
				}
			}
			if(data.length > 0){
				$(node).find('tbody tr').each(function(index, item) {
					let rowData = bizOrderDtlAddEditTable.row(item).data();
					let rowNode = bizOrderDtlAddEditTable.row(index).node(); 

					let idx = rowData.idx;
					let spQty = isEmptyCheck(rowData.spQty) ? 0 : parseInt(rowData.spQty);
					let versionStock = isEmptyCheck(rowData.versionStock) ? 0 : parseInt(rowData.versionStock);
					let stockUseQty = isEmptyCheck(rowData.stockUseQty) ? 0 : parseInt(rowData.stockUseQty);
					let stockReUseQty = isEmptyCheck(rowData.stockReUseQty) ? 0 : parseInt(rowData.stockReUseQty);

					//수주 등록상태 / 수주정지 상태 일경우 -> 입력못하도록 
					if( rowData.bizStatusCd != '01' 
						|| rowData.bizStopYn == 'Y'
						/* || rowData.stockUseYn == 'Y' */ ) {
						$(rowNode).find('input').attr('disabled',true);
						$(rowNode).find('select').attr('disabled',true);
						$(rowNode).find('textarea').attr('disabled',false);
						$('input[name=purchaseBatch]').attr('disabled',false);
						$(rowNode).find('select[name=ordGubun]').attr('disabled',false);
					}

					//현재고 없을 경우 재고활용,재고사용 입력못하도록
					//단 재고사용수량, 활용수량이 입력되어있을경우 예외
					if( parseInt(spQty) <= 0 && parseInt(stockUseQty) <= 0 && parseInt(stockReUseQty) <= 0 ){
						$(rowNode).find('input[name=stockUseQty]').attr('disabled',true);
						$(rowNode).find('input[name=stockReUseQty]').attr('disabled',true);
					} 

					//현재고와 버전별 재고수량이 다를 경우 재고사용 및 활용을 못하도록
					if( parseInt(spQty) != parseInt(versionStock) ){
						$(rowNode).css('background-color','#ffb4b4');
						$(rowNode).find('input[name=stockUseQty]').attr('disabled',true);
						$(rowNode).find('input[name=stockReUseQty]').attr('disabled',true);
					}
					
				});
			}
			//progressOrder
			for(var i=0;i<data.length;i++) {
				let tr = $('#' + table_id + ' tbody').find('tr').eq(i);
				bizOrderDtlAddEditTable.row(tr).data().progressOrder = i+1;
				$(tr).find('td').eq(0).html(i+1);
			}

			$('.bootstrapToggle').bootstrapToggle();
		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			/* api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#bizOrderDtlAddEditTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#bizOrderDtlAddEditTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			}); */
		},
	});
	// dataTable colReorder event
	/* bizOrderDtlAddEditTable.on('column-reorder', function( e, settings, details ) {
		let api = bizOrderDtlAddEditTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#bizOrderDtlAddEditTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	}); */

	// 품목추가 버튼 click
	$('#btnItemAdd').on('click', function() {
		if($('#dealCorpIdx').val() == '') {
			toastr.warning('고객사를 먼저 선택해주세요.');
			$('#btnDealCorpSelect').focus();
			return false;
		}
		
		$('#searchUseYnCd').val('Y');
		$('#itemInfoAdmListModal').modal('show');
		$('#itemInfoAdmListModal').css('left','0').css('top','0');
		$('#itemInfoAdmListModal').find('.modal-content').css('width','70vw').height('85.2vh');
		$('#itemInfoAdmListModal').draggable({handle: ".modal-header"});
		itemSelectList.splice(0, itemSelectList.length);
		
	});
	$('#itemInfoAdmListModal').on('shown.bs.modal', function() {
		itemInfoTable.ajax.reload(function() {});
	});

	// 품목삭제 버튼 click
	$('#btnItemDel').on('click', function() {
		if(bizOrderDtlAddEditTable.row('.selected').data() == undefined) {
			toastr.warning('삭제할 항목을 선택해주세요.');
			return false;
		}
		bizOrderDtlAddEditTable.row('.selected').remove().draw();
	});

	// 고객사 검색 버튼 click
	$('#btnDealCorpSelect').on('click', function() {
		dealCorpModalGubun = 'bizOrder';
		$('#dealCorpModal').modal('show');
	});
	$('#dealCorpModal').on('shown.bs.modal', function() {
		dealCorpModalTable.ajax.reload(function() {});
	});


	$('#purchaseFileUpload').on('click',function(){
		$('#purchaseFile').trigger('click');
	});
	
	$('#purchaseFile').on('change',function(){
		let fileInput = document.getElementById('purchaseFile'); 
		if(fileInput.files.length>0){
			//폼데이터 초기화
			purchaseFormData = new FormData();
			
			let files = fileInput.files; //업로드한 파일들의 정보를 넣는다.
	
			for(let i = 0; i < document.querySelector('#purchaseFile').files.length; i++){
				//폼데이터 넣는곳
				let uuid = uuid_v4();
				let fileArr = files[i].name.split('.');
				let fileFullNm = _.slice(fileArr, 0, -1).join('.');

				purchaseFormData.append('file',files[i]);
				purchaseFormData.append('uuid',uuid);
				purchaseFormData.append('ext',files[i].name.split('.').at(-1));
				purchaseFormData.append('fileNm', fileFullNm);
				
				$('#purchaseFileNm').val(files[i].name);
				let bases64 = getImgBase64(files[i]);
				$('#purchaseViewer').attr('src','data:image/jpeg;base64,'+bases64);

				let element = document.getElementById('purchaseImgView');
				let panzoom = Panzoom(element, {});		
				let parent = element.parentElement;
			    parent.addEventListener('wheel', panzoom.zoomWithWheel);
			}
		}
		$(this).val(null);
	});
	
	// 수주등록/수정 저장버튼 click
	$('#btnSave').on('click', function() {
		if($('#dealCorpIdx').val() == '') {
			toastr.warning('고객사를 선택해주세요.');
			$('#btnDealCorpSelect').focus();
			return false;
		}
		if($('#ordDate').val() == '') {
			toastr.warning('수주등록일을 선택해주세요.');
			$('#ordDate').focus();
			return false;
		}
		/* if($('#ordGubun').val() == '') {
			toastr.warning('수주구분을 선택해주세요.');
			$('#ordGubun').focus();
			return false;
		} */
		if(bizOrderDtlAddEditTable.data().count() == 0) {
			toastr.warning('수주등록할 품목을 선택해주세요.');
			$('#btnItemAdd').focus();
			return false;
		}

		let array = [];
		let state = true;
		for(var i=0;i<bizOrderDtlAddEditTable.data().count();i++) {
			let data = bizOrderDtlAddEditTable.row(i).data();
			let tr = bizOrderDtlAddEditTable.row(i).node();
			let tr2 = $(tr).next();
			let outReqDateVal = $(tr).find('td').eq(bizOrderDtlAddEditTable.column('outReqDate:name').index()).find('input').val();
			let ordGubun = $(tr).find('td').find('select[name=ordGubun]').val();
			if(data.bizStatusCd == '01'){
				if($(tr).find('td').eq(bizOrderDtlAddEditTable.column('ordQty:name').index()).find('input').val() == '0' ||
					$(tr).find('td').eq(bizOrderDtlAddEditTable.column('ordQty:name').index()).find('input').val() == '') {
					toastr.warning('수주수량을 입력해주세요.');
					$(tr).find('td').eq(bizOrderDtlAddEditTable.column('ordQty:name').index()).find('input').select();
					state = false;
					return false;
				}
	
				if(moment(outReqDateVal).format('YYYYMMDD') < moment().format('YYYYMMDD') ){
					toastr.warning('출고요청일은 금일보다 이전 날짜는<br>입력할 수 없습니다.');
					$(tr).find('td').eq(bizOrderDtlAddEditTable.column('outReqDate:name').index()).find('input').focus();
					state = false;
					return false;
				}
			}
			let obj = {};
			obj.progressOrder = data.progressOrder
			obj.idx = data.idx;
			obj.ordGubun = ordGubun;
			//obj.workplaceIdx = $(tr).find('td').eq(bizOrderDtlAddEditTable.column('workplaceIdx:name').index()).find('select').val();
			obj.workplaceIdx = data.workplaceIdx;
			obj.bizOrdAdmIdx = bizOrdAdmIdxVal;
			obj.bizOrdDtlNo = data.bizOrdDtlNo;
			//obj.bizStatusCd = $(tr).find('td').eq(bizOrderDtlAddEditTable.column('bizStatusCd:name').index()).find('select').val();
			//obj.stockUseYn = $(tr).find('td').eq(bizOrderDtlAddEditTable.column('stockUseYn:name').index()).find('input[type=checkbox]').prop('checked')? 'Y' : 'N';
			obj.stockUseYn = data.stockUseYn;
			obj.ordQty = $(tr).find('td').eq(bizOrderDtlAddEditTable.column('ordQty:name').index()).find('input').val().replaceAll(/,/g,'');
			obj.stockUseQty = $(tr).find('td').eq(bizOrderDtlAddEditTable.column('stockUseQty:name').index()).find('input').val().replaceAll(/,/g,'');
			obj.stockReUseQty = $(tr).find('td').eq(bizOrderDtlAddEditTable.column('stockReUseQty:name').index()).find('input').val().replaceAll(/,/g,'');
			obj.purchaseBatch = $(tr).find('td').eq(bizOrderDtlAddEditTable.column('purchaseBatch:name').index()).find('input').val();
			obj.itemIdx = data.itemIdx;
			obj.itemVerIdx = data.itemVerIdx;
			//obj.ordNote =  $(tr).find('td').eq(bizOrderDtlAddEditTable.column('ordNote:name').index()).find('textarea').val();
			obj.ordNote = '';
			obj.ordIssue =  $(tr).find('td').eq(bizOrderDtlAddEditTable.column('ordIssue:name').index()).find('textarea').val();
			//obj.workEndReqDate = moment($(tr).find('td').eq(bizOrderDtlAddEditTable.column('workEndReqDate:name').index()).find('input').val()).format('YYYYMMDD');
			obj.outReqDate = outReqDateVal != '' ? moment(outReqDateVal).format('YYYYMMDD') : '';
			//obj.workEndReqDate = moment(outReqDateVal).subtract('d',3).format('YYYYMMDD');
			obj.workEndReqDate = workingDateCalc(outReqDateVal, 3, '-');
			obj.confirmOrder = data.confirmOrder;
			obj.confirmDesign = data.confirmDesign;
			obj.ordDtlDesc = data.ordDtlDesc;
			array.push(obj);
		}

		if(!state) {
			return false;
		}

		let fileUuid;
		let fileNm;
		let fileExt;
		for( var pair of purchaseFormData.entries() ){
			if(pair[0].includes('uuid')){
				fileUuid = pair[1];
			} else if(pair[0].includes('ext')){
				fileExt = pair[1];
			} else if(pair[0].includes('fileNm')){
				fileNm = pair[1];
			}

		}
		array = _.orderBy(array, ['progressOrder'],['asc']);
		$.ajax({
			url: '<c:url value="/bs/bizOrderAdmIU"/>',
            type: 'POST',
            data: {
                'idx'				:	bizOrdAdmIdxVal,
                'bizOrdAdmIdx'		:	bizOrdAdmIdxVal,
                'bizOrdNo'			:	($('#bizOrdNo').val()=='자동채번'?'':$('#bizOrdNo').val()),
                'dealCorpIdx'		:	$('#dealCorpIdx').val(),
                'ordDate'			:	($('#ordDate').val()==''?'':moment($('#ordDate').val()).format('YYYYMMDD')),
                'outReqDate'		:	($('#outReqDate').val()==''?'':moment($('#outReqDate').val()).format('YYYYMMDD')),
                //'ordGubun'			:	$('#ordGubun').val(),
                'ordDesc'			:	$('#ordDesc').val(),
                'purchaseUuid'		:	function(){ return fileUuid; },
                'purchaseExt'		:	function(){ return fileExt; },
                'purchaseFileName'	:	function(){ return fileNm; },
                'jsonArray'			:	JSON.stringify(array)
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					toastr.success('저장되었습니다.');
					bizOrdAdmTrId = res.idx; 
					bizOrderAdmTable.rows('.selected').deselect();
					bizOrderAdmTable.ajax.reload(function(){
						bizOrderAdmTable.row('#'+bizOrdAdmTrId).select();
						$(bizOrderAdmTable.row('#'+bizOrdAdmTrId).node()).trigger('click'); 
					},false);
					//bizOrderDtlTable.ajax.reload(function(){},false);

					let formDataEntries = purchaseFormData.entries();
					if(!formDataEntries.next().done){
						//폼데이터에 파일이 있으므로 업로드
						//기존 Uuid랑 ext로 파일 지우고 업로드
						fileDelete({uuid:bizOrdAdmUuid,ext:bizOrdAdmExt});
						fileUpload(purchaseFormData); // 파일 업로드
						purchaseFormData = new FormData();
					}
					
					$('#orderAddEditModal').modal('hide');
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
	});

	// 등록/수정모달이 닫혔을 경우
	$('#orderAddEditModal').on('hide.bs.modal', function() {
		WM_action_OFF('new');
		WM_action_OFF('edit');
		$('#itemInfoAdmListModal').modal('hide');
	});



















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
			url : '<c:url value="/bm/itemInfoListAll"/>',
			type : 'GET',
			data : {
				useYnCd : function(){return $('#searchUseYnCd').val();},
				itemGubun : function(){return $('#searchItemGubun').val();},
				customerIdx : function(){return $('#dealCorpIdx').val();},
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'idx', className : 'text-center align-middle',
				render: function(data, type, row, meta) {
					//index -1이 아닌경우 -> 리스트에 해당 객체 있을 경우
					if( itemSelectList.findIndex( v => v.itemIdx == data ) != '-1'){
						return '<input checked class="form-check-input" type="checkbox" name="itemAddCheck" style="margin: 0px; width: 25px; height: 25px;" >';
					} else {
						return '<input class="form-check-input" type="checkbox" name="itemAddCheck" style="margin: 0px; width: 25px; height: 25px;" >';
					}
				}
			},
			{ data: 'customerNm', className : 'text-center'},	//고객사
			/* { data: 'itemCd', className : 'text-center'},		//제품코드 */
			{ data: 'itemNm', className : 'text-center'}, 		//제품명
			{ data: 'prcssCnt', className : 'text-center',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
						
					} else {
						return "";
					}
				}	
			},	//공정수
			{ data: 'knifeTipSize', className : 'text-center'},	//칼끝규격
			{ data: 'customerItemCd', className : 'text-center'}, 		//자재코드
			{ data: 'versionNum', className : 'text-center'},	//버전번호
			{ data: 'itemColor', className : 'text-center'},	//color
			{ data: 'itemGubunNm', className : 'text-center'},		//품목구분
			{ data: 'useYnCd', className : 'text-center',		//사용여부
				render : function(data, type, row, meta) {
					if(data == 'Y'){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">사용</div>';
					} else if (data == 'N'){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">미사용</div>';
					} else {
						return "-";
					}
				}			
			},		
			{ data: 'itemSize', className : 'text-center'},		//사이즈
			{ data: 'woodenCareNm', className : 'text-center',		
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return "-";
					}
				}		
			},	//목형관리번호
			{ data: 'resinBoardNm', className : 'text-center',		
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return "-";
					}
				}		
			},	//수지판
			{ data: 'holeWoodenCd', className : 'text-center'},	//타공목형번호	
			{ data: 'stock', className : 'text-end',		
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
					} else {
						return "0";
					}
				}	
			},		//현재고량
			{ data: 'frequencyNm', className : 'text-center',		
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return "-";
					}
				}		
			},	//도수
			/* { data: 'specialNotice', className : 'text-center'},//특이사항
			{ data: 'relayNotice', className : 'text-center'},	//전달사항 */
			{ data: 'bundleMethodNm', className : 'text-center',		
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return "-";
					}
				}	
			},//묶음법
			{ data: 'packMethodNm', className : 'text-center',		
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return "-";
					}
				}	
			}, //포장방법
			{ data: 'workPrinter', className : 'text-center'},		//작업인쇄기
			{ data: 'masterPaper', className : 'text-center'},	//명인원지
			{ data: 'careCd', className : 'text-center'},		//관리번호
			{ data: 'inspectMethodNm', className : 'text-center',		
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return "-";
					}
				}	
			},	//검수방법
			{ data: 'plateSize', className : 'text-center'},	//큰판작은판
			{ data: 'bundleUnit', className : 'text-center'},	//묶음단위
			{ data: 'packUnit', className : 'text-center'},		//포장단위
			{ data: 'detailDate', className : 'text-center',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+moment(data,'YYYY-MM-DD').format('YYYY-MM-DD')+'</div>';
					} else {
						return "-";
					}
				}	
			},	//일자
			{ data: 'roundPlateCnt', className : 'text-center'},//원판수량
			{ data: 'plane', className : 'text-center'},	//면방
			{ data: 'printingYnCheckNm', className : 'text-center',		
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return "-";
					}
				}	
			},		//착인여부점검
			{ data: 'etc1Nm', className : 'text-center',		
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return "-";
					}
				}		
			},	//기타1-호기
		],
		columnDefs : [
			{
				targets: '_all',
				render: function(data) {
					return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
				}
			},
			{
				targets: [0], orderable: false
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
			
			//let htmlHeight = parseFloat($('html').css('height'));
			//let modal_header_height = parseInt($('#orderAddEditModal').find('.modal-header').height());
			//let modal_content_row_1 = parseInt($('#orderAddEditModal').find('.container-fluid').find('.row').eq(0).height());
			//$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - 28 - modal_header_height - modal_content_row_1 - 198)+'px');
	
			let modalHeight = parseInt($('#itemInfoAdmListModal').find('.modal-content').css('height'));
			let modal_header_height = parseInt($('#orderAddEditModal').find('.modal-header').height());
			let modal_content_row_1 = parseInt($('#orderAddEditModal').find('.container-fluid').find('.row').eq(0).height());

			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(modalHeight - modal_header_height - modal_content_row_1 - 30)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#itemInfoAdmListSearchAll').off('keyup',function() {});
			$('#itemInfoAdmListSearchAll').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			});

			//모든 체크박스 선택
			$('#checkAll').off('click');
			$('#checkAll').on('click',function(){
				if($('#checkAll').prop("checked")){
					$('input:checkbox[name=itemAddCheck]').prop("checked",true);
				} else{
					$('input:checkbox[name=itemAddCheck]').prop("checked",false);
				}
			});
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

				if($(api.column(colIdx).header()).index() == 0) { // 체크박스부분일 경우
					$(cell).html('');
				} else {
					$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				}
				
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

	$('#btnitemInfoAdmListSearch').on('click', function() {
		$('#my-spinner').show();
		itemInfoTable.ajax.reload(function() {});

		setTimeout(function() {
			$('#my-spinner').hide();
		}, 100)
	});

	$(document).on('change','input:checkbox[name=itemAddCheck]',function(){
		let tr = $(this).parent().parent();
		let data = itemInfoTable.row($(this).parent().parent()).data()
		if($(this).is(':checked')){
			let obj = {};
			obj.rowGubun = 'new';
			obj.idx = '';
			obj.ordGubun = '10';
			obj.workplaceIdx = workPlaceIdxVal;
			obj.itemIdx = data.idx;
			obj.itemVerIdx = data.itemVerIdx;
			obj.itemGubun = data.itemGubun;
			obj.itemGubunNm = data.itemGubunNm;
			obj.itemNm = data.itemNm;
			obj.customerItemCd = data.customerItemCd;
			obj.itemVersion = data.versionNum;
			obj.itemSize = data.itemSize;
			obj.knifeTipSize = data.knifeTipSize;
			obj.itemColor = data.itemColor;
			obj.coatingMethod = data.coatingMethod;
			obj.cmyk = data.cmyk;
			obj.woodenCareCd = data.woodenCareCd;
			obj.woodenCareNm = data.woodenCareNm;
			obj.ordQty = '0';
			obj.stockUseQty = '0';
			obj.stockReUseQty = '0';
			obj.spQty = data.stock;
			obj.versionStock = data.versionStock;
			obj.workEndReqDate = moment().add('d',11).format('YYYYMMDD');
			obj.outReqDate = moment().add('d',14).format('YYYYMMDD');
			obj.confirmOrder = 'N';
			obj.confirmDesign = 'N';
			obj.ordDtlDesc = '';
			obj.bizOrdDtlNo = '자동채번';
			obj.ordNote = data.specialNotice;
			obj.ordIssue = data.relayNotice;
			obj.bizStatusCd = '01';
			obj.stockUseYn = 'N';
			obj.progressOrder = itemSelectList.length + 1 + bizOrderDtlAddEditTable.rows().count();
			itemSelectList.push(obj);
		} else {
			let deleteIndex = itemSelectList.findIndex( v => v.itemIdx == data.idx ); 
			itemSelectList.splice(deleteIndex,1);
			
		}
				
	});
	
	// 제품코드조회 적용 버튼 click
	$('#btnitemInfoAdmListSave').on('click', function() {
		let list = [];
		bizOrderDtlAddEditTable.rows.add(itemSelectList).draw();
		bizOrderDtlAddEditTable.columns.adjust();
		itemSelectList.splice(0, itemSelectList.length);
		$('#itemInfoAdmListModal').modal('hide');
		/*$('input:checkbox[name=itemAddCheck]').each(function(index, item) {
			let node = $(item);
			state = true;
			if($(node).prop("checked")) { // 체크 되었을 경우
				let tr = $(node).parent().parent();
				let data = itemInfoTable.row(tr).data();

				// 이미 추가된 제품코드일 경우
				/*if(bizOrderDtlAddEditTable.data().toArray().find(v => v.itemIdx == data.idx) != undefined) {
					toastr.warning('이미 추가된 제품코드입니다.<br>제품명   : '+data.itemNm+'<br>버전번호 : '+data.versionNum);
					state = false;
					return false;
				}*/
				
				/*let obj = {};
				obj.idx = '';
				obj.workplaceIdx = workPlaceIdxVal;
				obj.itemIdx = data.idx;
				obj.itemGubun = data.itemGubun;
				obj.itemGubunNm = data.itemGubunNm;
				obj.itemNm = data.itemNm;
				obj.customerItemCd = data.customerItemCd;
				obj.itemVersion = data.versionNum;
				obj.itemSize = data.itemSize;
				obj.knifeTipSize = data.knifeTipSize;
				obj.itemColor = data.itemColor;
				obj.coatingMethod = data.coatingMethod;
				obj.cmyk = data.cmyk;
				obj.woodenCareCd = data.woodenCareCd;
				obj.woodenCareNm = data.woodenCareNm;
				obj.ordQty = '0';
				obj.stockUseQty = '0';
				obj.spQty = data.stock;
				obj.workEndReqDate = moment().add('d',11).format('YYYYMMDD');
				obj.outReqDate = moment().add('d',14).format('YYYYMMDD');
				obj.confirmOrder = 'N';
				obj.confirmDesign = 'N';
				obj.ordDtlDesc = '';
				obj.bizOrdDtlNo = '자동채번';
				obj.ordNote = data.specialNotice;
				obj.ordIssue = data.relayNotice;
				obj.bizStatusCd = '01';
				obj.stockUseYn = 'N';
				list.push(obj);
			}
		});*/

		/*if(state) {
			bizOrderDtlAddEditTable.rows.add(list).draw();
			bizOrderDtlAddEditTable.columns.adjust();
			/* setTimeout(function() {
				for(var i=0;i<bizOrderDtlAddEditTable.data().count();i++) {
					let data = bizOrderDtlAddEditTable.row(i).data();
					let itemIdx = data.itemIdx;
					if(list.find(v => v.itemIdx == itemIdx) != undefined && ( data.idx == '' || data.idx == null)) {
						let html = '';
							html += '<table class="table table-bordered p-0 m-0">';
							html += '	<colgroup>';
							html += '		<col width="10%">';
							html += '		<col width="40%">';
							html += '		<col width="10%">';
							html += '		<col width="40%">';
							html += '	</colgroup>';
							html += '	<tr>';
							html += '		<th class="text-center align-middle">특이사항</th>';
							html += '		<td>';
							html += '			<textarea class="form-control" rows="2" style="resize: none;">'+data.ordNote+'</textarea>';
							html += '		</td>';
							html += '		<th class="text-center align-middle">전달사항</th>';
							html += '		<td>';
							html += '			<textarea class="form-control" rows="2" style="resize: none;">'+data.ordIssue+'</textarea>';
							html += '		</td>';
							html += '	</tr>';
							html += '</table>';
						bizOrderDtlAddEditTable.row(i).child(html,['p-0']).show();
					}
				}
			}, 100); */
			/*
			$('#itemInfoAdmListModal').modal('hide');
		}*/
	});










	// 수주관리 메인 상세조회
	function bizOrderAdmSel(idx) {
		let result = '';
		$.ajax({
			url: '<c:url value="/bs/bizOrderAdmSel"/>',
            type: 'POST',
            async: false,
            data: {
                'idx'	:	idx
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					result = res.data;
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
		return result;
	}















	// 거래처정보 목록 조회
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
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 234)+'px');
			
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

	$('#btnDealCorpModalSearch').on('click',function(){
		dealCorpModalTable.ajax.reload(function() {});
	});

	// 수주등록/수정 고객사 모달 붙여넣기 버튼 click
	let dealCorpModalGubun = '';
	$('#btnDealCorpModalPaste').on('click',function(){
		if(dealCorpModalGubun == 'bizOrder'){ // 수주등록/수정일 경우
			if( !$('#dealCorpModalTable tbody tr').hasClass('selected') ){
				toastr.warning('적용할 행을 선택해주세요.');
				return false;
			}
			
			let data = dealCorpModalTable.row('.selected').data();
			workPlaceIdxVal = data.workPlaceIdx;
			customerIdxVal = data.idx;
			$('#dealCorpIdx').val(data.idx);
			$('#dealCorpNm').val(data.dealCorpNm)
			
		} else if (dealCorpModalGubun == 'prcss'){ // 공정등록일 경우
			if( !$('#dealCorpModalTable tbody tr').hasClass('selected') ){
				toastr.warning('적용할 행을 선택해주세요.');
				return false;
			}
			
			let idx = dealCorpModalTable.row('.selected').data().idx;
			if(customerModalGubun == 'customer'){
				$('#customerIdx').val(idx);
				$('#customerNm').val(dealCorpModalTable.row('.selected').data().dealCorpNm);
			} else if ( customerModalGubun == 'prcss' ){
				processInfoTable.row('.selected').data().customerIdx = idx;
				//공정명 html
				let html1='';
				html1 += '<div style="display: flex; flex-wrap: nowrap;" class="input-group">';
				html1 += '<input type="text" class="form-control inputNm" id="customerNm" style="max-width: 90%;" disabled="disabled" value="'+dealCorpModalTable.row('.selected').data().dealCorpNm+'">';
				html1 += '<button type="button" class="nameDel customerNm" name="nameDel" style="background-color: transparent;border-color: transparent;position: absolute;top: 0;right:0;margin: 1px 23px;margin-left: 0px;border: none;" ><i class="fa-solid fa-xmark"></i></button>';
				html1 += '<input type="hidden"  class="inputIdx" name="customerIdx" value="'+idx+'">';
				html1 += '<button type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary input-sub-search inputGroup" name="customerModalBtn">';
				html1 += '<i class="fa-solid fa-magnifying-glass"></i>';
				html1 += '</button>';
				html1 += '</div>';			
				$('#processInfoTable tbody').find('.selected').find('td').eq(9).html(html1);
				processInfoTable.draw(false);
			} 
		} else if(dealCorpModalGubun == 'inputMat'){
			let node = purchaseOrderAdmTable.row('.selected').node();
			let nodeData = purchaseOrderAdmTable.row('.selected').data();
			let selectNodeModalData = dealCorpModalTable.row('.selected').data();
			$(node).find('td').eq(purchaseOrderAdmTable.column('dealCorpNm:name').index()).find('input[type=hidden]').val(selectNodeModalData.idx);			//발주처 식별자
			$(node).find('td').eq(purchaseOrderAdmTable.column('dealCorpNm:name').index()).find('input[type=text]').val(selectNodeModalData.dealCorpNm);		//발주처 이름
			$('#dealCorpSelectModal').modal('hide');
		}


		$('#dealCorpModal').modal('hide');
	});


	$('#dealCorpModalTable tbody').on('dblclick','tr',function(){
		if(dealCorpModalGubun == 'bizOrder'){ // 수주등록/수정일 경우
			
			let data = dealCorpModalTable.row('.selected').data();
			workPlaceIdxVal = data.workPlaceIdx;
			customerIdxVal = data.idx;
			$('#dealCorpIdx').val(data.idx);
			$('#dealCorpNm').val(data.dealCorpNm)
			
		} else if (dealCorpModalGubun == 'prcss'){ // 공정등록일 경우
			
			let idx = dealCorpModalTable.row('.selected').data().idx;
			if(customerModalGubun == 'customer'){
				$('#customerIdx').val(idx);
				$('#customerNm').val(dealCorpModalTable.row('.selected').data().dealCorpNm);
			} else if ( customerModalGubun == 'prcss' ){
				processInfoTable.row('.selected').data().customerIdx = idx;
				//공정명 html
				let html1='';
				html1 += '<div style="display: flex; flex-wrap: nowrap;" class="input-group">';
				html1 += '<input type="text" class="form-control inputNm" id="customerNm" style="max-width: 90%;" disabled="disabled" value="'+dealCorpModalTable.row('.selected').data().dealCorpNm+'">';
				html1 += '<button type="button" class="nameDel customerNm" name="nameDel" style="background-color: transparent;border-color: transparent;position: absolute;top: 0;right:0;margin: 1px 23px;margin-left: 0px;border: none;" ><i class="fa-solid fa-xmark"></i></button>';
				html1 += '<input type="hidden"  class="inputIdx" name="customerIdx" value="'+idx+'">';
				html1 += '<button type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary input-sub-search inputGroup" name="customerModalBtn">';
				html1 += '<i class="fa-solid fa-magnifying-glass"></i>';
				html1 += '</button>';
				html1 += '</div>';			
				$('#processInfoTable tbody').find('.selected').find('td').eq(9).html(html1);
				processInfoTable.draw(false);
			} 
		} else if(dealCorpModalGubun == 'inputMat'){
			let node = purchaseOrderAdmTable.row('.selected').node();
			let nodeData = purchaseOrderAdmTable.row('.selected').data();
			let selectNodeModalData = dealCorpModalTable.row('.selected').data();
			$(node).find('td').eq(purchaseOrderAdmTable.column('dealCorpNm:name').index()).find('input[type=hidden]').val(selectNodeModalData.idx);			//발주처 식별자
			$(node).find('td').eq(purchaseOrderAdmTable.column('dealCorpNm:name').index()).find('input[type=text]').val(selectNodeModalData.dealCorpNm);		//발주처 이름
			$('#dealCorpSelectModal').modal('hide');
		}
		$('#dealCorpModal').modal('hide');
	});





	
 	/************************ 공정정보 ************************/
	// 공정정보 목록조회
	$('#processInfoTable thead tr').clone(true).addClass('filters').appendTo('#processInfoTable thead'); // filter 생성
	let processInfoTable = $('#processInfoTable').DataTable({
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
		rowReorder: {
			enable: true,
			dataSrc: 'prcssOrder',
		},
		select: {
            style: 'single',
            toggleable: false,
            items: 'row',
            info: false
        },
        ajax : {
			url : '<c:url value="/bs/bizOrderItemPrcssList"/>',
			type : 'GET',
			data : {
				'itemIdx'		: function(){ return itemIdx; },
				'bizOrdDtlIdx'  : function(){ return bizOrdDtlIdxVal; },
			},
		},
        rowId: 'idx',
        columns : [
        	{ data: 'prcssOrder', className : 'text-center'},
			{ data: 'prcssCd', className : 'text-center',
				render: function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">' + data + '</div>';
					} else {
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;"></div>';
					}
				}
			},
			{ data: 'prcssNm', className : 'text-center',
				render: function(data, type, row, meta) {
					if( data == null ){
						let html='';
						html += '<div style="display: flex; flex-wrap: 1 1 auto;">';
						html += '<input type="text" class="form-control" id="prcssNm" style="mix-width: 100px;" disabled="disabled">';
						html += '<input type="hidden" id="prcssIdx">';
						html += '</div>';
						return html;
					} else {
						let html='';
						html += '<div style="display: flex; flex-wrap: 1 1 auto;">';
						html += '<input type="text" class="form-control" id="prcssNm" style="min-width: 100px;" disabled="disabled" value="'+data+'">';
						html += '<input type="hidden" id="prcssIdx">';
						html += '</div>';
						return html;
					}
				}
			},
			{ data: 'equipNm', className : 'text-center',
				render: function(data, type, row, meta) {
					if( row['equipIdx'] != null && row['equipIdx'] != ''){
						let prcssEquipFilterList = _.filter(prcssEquipList,v=>v.prcssIdx == row['prcssIdx']);
						
						let html='';
						html += '<select disabled name="equipIdx" class="form-select" style="min-width:100px;">'		
						html += '<option value="">선택</option>';				
						for(var i=0; i<prcssEquipFilterList.length; i++){
							if(prcssEquipFilterList[i].equipIdx == row['equipIdx']){
								html += '<option selected value="'+prcssEquipFilterList[i].equipIdx+'">'+prcssEquipFilterList[i].equipNm +'</option>';
							} else {
								html += '<option value="'+prcssEquipFilterList[i].equipIdx+'">'+prcssEquipFilterList[i].equipNm +'</option>';
							}
						}
						html += '</select>';
						return html;
					} else{
						let prcssEquipFilterList = _.filter(prcssEquipList,v=>v.prcssIdx == row['prcssIdx']);
						
						let html='';
						html += '<select disabled name="equipIdx" class="form-select" style="min-width:100px;">'
						html += '<option value="">선택</option>';							
						for(var i=0; i<prcssEquipFilterList.length; i++){
							if(i == 0 && row['rowGubun'] == 'add'){
								html += '<option selected value="'+prcssEquipFilterList[i].equipIdx+'">'+prcssEquipFilterList[i].equipNm +'</option>';
							} else {
								html += '<option value="'+prcssEquipFilterList[i].equipIdx+'">'+prcssEquipFilterList[i].equipNm +'</option>';
							}
						}
						html += '</select>';
						return html;
					}
					/* if( data == null ){
						let html='';
						html += '<div style="display: flex; flex-wrap: nowrap;min-width:100px;max-width: 100px;" class="input-group">';
						html += '<input type="text" class="form-control inputNm" name="equipNm" style="min-width:100px;max-width: 100px;" disabled="disabled">';
						html += '<button type="button" class="nameDel equipNm" name="nameDel" value="'+meta.row+'" style="background-color: transparent;border-color: transparent;position: absolute;top: 0;right:0;margin: 1px 0px;margin-left: 0px;border: none;" disabled><i class="fa-solid fa-xmark"></i></button>';
						html += '<input type="hidden" class="inputIdx" name="equipIdx" value="'+row['equipIdx']+'">';
						html += '<button type="button" value="'+row['prcssIdx']+'" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary input-sub-search" name="equipModalBtn">';
						html += '<i class="fa-solid fa-magnifying-glass"></i>';
						html += '</button>';
						html += '</div>';
						return html;
					} else {
						let html='';
						html += '<div style="display: flex; flex-wrap: nowrap;min-width:100px;max-width: 100px;" class="input-group">';
						html += '<input type="text" class="form-control inputNm" name="equipNm" style="min-width:100px;max-width: 100px;" disabled="disabled" value="'+data+'">';
						html += '<button type="button" class="nameDel equipNm" name="nameDel" value="'+meta.row+'" style="background-color: transparent;border-color: transparent;position: absolute;top: 0;right:0;margin: 1px 0px;margin-left: 0px;border: none;" disabled><i class="fa-solid fa-xmark"></i></button>';
						html += '<input type="hidden" class="inputIdx" name="equipIdx" value="'+row['equipIdx']+'">';
						html += '<button disabled type="button" value="'+row['prcssIdx']+'" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary input-sub-search" name="equipModalBtn">';
						html += '<i class="fa-solid fa-magnifying-glass"></i>';
						html += '</button>';
						html += '</div>';
						return html;
					} */
				}
			},
			{ data: 'outsrcGubun', className : 'text-center',
				render: function(data, type, row, meta) {
					if( data == null ){
						let html='';
						html += '<select class="form-select" style="" name="outsrcGubun">';
						for( let i = 0; i< outsrcGubunList.length; i++){
							html += '<option value="' + outsrcGubunList[i].commonCd + '">' + outsrcGubunList[i].commonNm + '</option>'
						}
						html += '</select>';
						return html;
					} else {
						let html='';
						html += '<select disabled class="form-select" style="" name="outsrcGubun">';
						for( let i = 0; i< outsrcGubunList.length; i++){
							if(outsrcGubunList[i].commonCd == data){
								html += '<option value="' + outsrcGubunList[i].commonCd + '" selected>' + outsrcGubunList[i].commonNm + '</option>'
							} else {
								html += '<option value="' + outsrcGubunList[i].commonCd + '">' + outsrcGubunList[i].commonNm + '</option>'
							}
						}
						html += '</select>';
						return html;
					}
				}
			},
			{ data: 'workMethod', className : 'text-center',
				render: function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">' + data + '</div>';
					} else {
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;"></div>';
					}
				}
			},
			{ data: 'workMethodDtl', className : 'text-center',
				render: function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">' + data + '</div>';
					} else {
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;"></div>';
					}
				}
			},
			{ data: 'produceQtyUnitNm', className : 'text-center',
				render: function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">' + data + '</div>';
					} else {
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;"></div>';
					}
				}
			},
			{ data: 'workOrdQty', className : 'text-center',
				render: function(data, type, row, meta) {
					if(data == '자동계산'){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">자동계산</div>';
					} else if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">' + addCommas(parseInt(data)) + '</div>';
					} else {
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;"></div>';
					}
				}
			},
			{ data: 'customerCd', className : 'text-center',
				render: function(data, type, row, meta) {
					if( data == null ){
						let html='';
						html += '<div style="display: flex; flex-wrap: nowrap;min-width: 100px;max-width: 100px;" class="input-group" >';
						html += '<input type="text" class="form-control inputNm" id="customerNm" style="min-width: 100px;max-width: 100px;" disabled="disabled">';
						html += '<button type="button" class="nameDel customerNm" name="nameDel" value="'+meta.row+'" style="background-color: transparent;border-color: transparent;position: absolute;top: 0;right:0;margin: 1px 0px;margin-left: 0px;border: none;" disabled><i class="fa-solid fa-xmark"></i></button>';
						html += '<input type="hidden" class="inputIdx" name="customerIdx">';
						html += '<button type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary input-sub-search" name="customerModalBtn">';
						html += '<i class="fa-solid fa-magnifying-glass"></i>';
						html += '</button>';
						html += '</div>';
						return html;
					} else {
						let html='';
						html += '<div style="display: flex; flex-wrap: nowrap;min-width: 100px;max-width: 100px;" class="input-group">';
						html += '<input type="text" class="form-control inputNm" id="customerNm" style="min-width: 100px;max-width: 100px;" disabled="disabled" value="'+row['outsrcNm']+'">';
						html += '<button type="button" class="nameDel customerNm" name="nameDel" value="'+meta.row+'" style="background-color: transparent;border-color: transparent;position: absolute;top: 0;right:0;margin: 1px 0px;margin-left: 0px;border: none;" disabled><i class="fa-solid fa-xmark"></i></button>';
						html += '<input type="hidden" class="inputIdx" name="customerIdx" value ="'+row['outsrcIdx']+'">';
						html += '<button disabled type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary input-sub-search" name="customerModalBtn">';
						html += '<i class="fa-solid fa-magnifying-glass"></i>';
						html += '</button>';
						html += '</div>';
						return html;
					}
				}
			},
			{ data: 'qtyUnitNm', className : 'text-center',
				render: function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">' + data + '</div>';
					} else {
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;"></div>';
					}
				}
			},
			/* { data: 'prcssDesc', className : 'text-center',
				render: function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">' + data + '</div>';
					} else {
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;"></div>';
					}
				}
			}, */
			{ data: 'note', className : 'text-center',
				render: function(data, type, row, meta) {
					if( data == null ){
						let html='';
						html += '<input type="text" class="form-control" style="min-width:100px;" value="" name="note">';
						return html;
					} else {
						let html='';
						html += '<input disabled type="text" class="form-control" style="min-width:100px;" value="'+data+'" name="note">';
						return html;
					}
				}
			},
		],
		columnDefs : [
 			{ "targets": '_all', "orderable": false },
			{
				targets: '_all',
				render: function(data) {
					return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
				}
			}
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
		order : [[0,'asc']],
		drawCallback: function() {
			let api = this.api();
			processInfoTableApi = api;
			let data = api.data();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#processInfoTable_wrapper').find('.dataTables_scrollHead').css('height'));
			let baseTableHeight = parseFloat($('#rightcolM').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(((baseTableHeight)) - theadHeight - 94)+'px');
			
			//$('#'+table_id+'_wrapper').find('.dataTables_scrollHeadInner').css('width','100%');

			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAllPit').off('keyup',function() {});
			$('#searchAllPit').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			});
			//progressOrder
			for(var i=0;i<data.length;i++) {
				let tr = $('#' + table_id + ' tbody').find('tr').eq(i);
				processInfoTable.row(tr).data().prcssOrder = i+1;
				$(tr).find('td').eq(0).html(i+1);
			}
			$('#'+table_id+' tbody tr').attr('style',"vertical-align: middle;");
		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#processInfoTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#processInfoTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});

			$('#' + table_id + '_wrapper').find('.dataTables_scrollHeadInner').find('table').css('width','100%');
		},
	});
	// dataTable colReorder event
	processInfoTable.on('column-reorder', function( e, settings, details ) {
		let api = processInfoTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#processInfoTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	//공정순서변경되었을 때
	processInfoTable.on( 'row-reordered', function ( e, diff, changes ) {
		$('#my-spinner').fadeIn(50, function() {
			//분할작업지시 구조적으로 안된다고 하셨고, 분할작업지시 안내리므로 하나의 수주에서 작업지시 공정 조회시 
			//해당 공정 == 수주공정이므로 조회해서 비교해가면서 하면됨 
			const originPrcssData = processInfoTable.rows().data().toArray();
			$.ajax({
				url : '<c:url value="/bs/bizOrderItemPrcssList"/>',
				type : 'GET',
				async : false,
				data : {
					'itemIdx'		: function(){ return itemIdx; },
					'bizOrdDtlIdx'  : function(){ return bizOrdDtlIdxVal; },
				},
				beforeSend: function() {
		        	$('#my-spinner').show();
		        },
		        success : function(res) {
					if (res.result == "ok") { //응답결과
						let data = res.data;				

						//예외처리 시작 -> 1. 대기가 아닌 공정에 한해서만 변경가능
						let status = true;	
						for(let i = 0; i < data.length && status; i++){
							if(data[i].idx != $('#processInfoTable tbody tr').eq(i).attr('id')){ //ajax통한 데이터랑 실제 테이블에 그려진 데이터랑 다를 경우 -> 수정됨
								if(data[i].progressStatus != 'PI'){ //대기가 아닌경우 수정불가능
									status = false;
								}
							}
						}
						if( status ){
							WM_action_ON('prcssNew', 'workingWarningModal');
							$('#btnProcessNew').attr('disabled', true);
							$('#btnProcessCopy').attr('disabled',true);
							$('#btnProcessSave').attr('disabled', false);
							$('#btnProcessEdit').attr('disabled', true);
							$('#btnProcessDel').attr('disabled', false);
							$('#btnProcessCancel').attr('disabled', false);
						} else {
							toastr.warning('대기중인 공정만 수정할 수 있습니다.');
							WM_action_OFF('prcssNew');
							$('#my-spinner').hide();
							processInfoTable.ajax.reload(function(){},false);
							$('#btnProcessNew').attr('disabled', false);
							$('#btnProcessCopy').attr('disabled',false);
							$('#btnProcessSave').attr('disabled', true);
							$('#btnProcessEdit').attr('disabled', false);
							$('#btnProcessDel').attr('disabled', false);
							$('#btnProcessCancel').attr('disabled', true);
							return false;
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

	let prcssIdx = '';
	let prcssEquipSelectGubun = 'prcssEquip';
	//공정복사
	$('#btnProcessCopy').on('click',function(){
		$.ajax({
			url: '<c:url value="/bs/bizOrderItemPrcssCopy"/>',
            type: 'POST',
            //async: false,
            data: {
                'bizOrdDtlIdx' : 	bizOrdDtlIdxVal,
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					let data = res.data;
					toastr.success('공정 정보를 가져왔습니다.');
					processInfoTable.ajax.reload(function(){
						$('button[name=customerModalBtn]').attr('disabled',true);
						$('button[name=equipModalBtn]').attr('disabled',true);
						/* $('#processInfoTable tbody tr').each(function(index){
							let node = processInfoTable.row(index).node();
							if(processInfoTable.row(index).data() != undefined && processInfoTable.row(index).data() != ''){
								let prcssIdx = processInfoTable.row(index).data().prcssIdx;
								let multipleNode = $(node).find('td').eq(5).find('select[name=workMethodMultiSelect]');
								
								$(multipleNode).select2({
						    		data: JSON.parse(processInfoTable.row(index).data().workMethodJson),
						    		multiple : true,
						    		placeholder: "작업방법 선택",
						    	});
						    	
								$(node).find('td').eq(5).find('span').eq(0).css('width','100%');
						    	$(node).find('td').eq(5).find('.select2-search__field').css('width','100%');
						    	$(node).find('td').eq(5).find('.select2-selection__rendered').attr('style','display:flex; align-content:flex-start; flex-direction:column; flex-wrap:wrap; overflow:auto;');
					    	
							
								if( processInfoTable.row(index).data().workMethod != null && processInfoTable.row(index).data().workMethod != ''){
									let splitData =  processInfoTable.row(index).data().workMethod.split(',');
									$(node).find('td').eq(5).find('select[name=workMethodMultiSelect]').val(splitData).trigger('change')
								}
								$(node).find('td').eq(5).find('select[name=workMethodMultiSelect]').attr('disabled',true);
							}
						}); */

						$('#my-spinner').hide();
						setTimeout(function() {
							processInfoTable.draw(false);
						},100);

						$('#btnProcessCopy').attr('disabled',false);
		
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
	
	//공정정보에서 설비정보
	$(document).on('click','button[name=equipModalBtn]',function(){
		prcssIdx = $(this).val();
		if(prcssIdx == '' || prcssIdx == null || prcssIdx == "null"){
			prcssIdx = 0;
		}
		$('#prcssEquipSelectGubun').val('prcssEquip');
		prcssEquipSelectGubun = $('#prcssEquipSelectGubun').val();
		$('#prcssEquipModal').modal('show');
		setTimeout(function() {
			prcssEquipModalTable.ajax.reload(function() {});
		}, 200);
	});

	//공정 설비 조회에서 붙여넣기
	$('#btnPrcssEquipModalPaste').on('click',function(){
		if(!$('#prcssEquipModalTable tbody tr').hasClass('selected')){
			toastr.warning('붙여넣을 행을 선택해주세요.');
			return false;
		}
		let data = prcssEquipModalTable.row('.selected').data();
		let node = processInfoTable.row('.selected').node();
		processInfoTable.row('.selected').data().equipIdx = data.idx;
		processInfoTable.row('.selected').data().equipNm = data.equipNm;
		$(node).find('td').eq(3).find('input[name=equipNm]').val(data.equipNm);
		$('#prcssEquipModal').modal('hide');
	});

	//공정설비조회 
	$('#btnPrcssEquipSearch').on('click',function(){
		prcssEquipSelectGubun = $('#prcssEquipSelectGubun').val();
		prcssEquipModalTable.ajax.reload(function() {});
	});
	$('#prcssEquipSelectGubun').on('change',function(){
		prcssEquipSelectGubun = $('#prcssEquipSelectGubun').val();
		prcssEquipModalTable.ajax.reload(function() {});
	});
	
	
	//설비정보 모달 조회
	$('#prcssEquipModalTable thead tr').clone(true).addClass('filters').appendTo('#prcssEquipModalTable thead'); // filter 생성
	let prcssEquipModalTable = $('#prcssEquipModalTable').DataTable({
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
			url : '<c:url value="/em/prcssEquipInfoListAll"/>',
			type : 'POST',
			data : {
				prcssIdx			  : function(){ return prcssIdx;},
				prcssEquipSelectGubun : function(){ return prcssEquipSelectGubun;}
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'equipCd', className : 'text-center'},
			{ data: 'equipNm', className : 'text-center'},
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
			let theadHeight = parseFloat($('#prcssEquipModalTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 234)+'px');
			
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
				let cell = $('#prcssEquipModalTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#prcssEquipModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	prcssEquipModalTable.on('column-reorder', function( e, settings, details ) {
		let api = prcssEquipModalTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#prcssEquipModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	//공정정보 외주처
	$(document).on('click','button[name=customerModalBtn]',function(){
		dealCorpModalGubun = 'prcss';
		customerModalGubun = 'prcss';
		$('#dealCorpModal').modal('show');
		setTimeout(function() {
			dealCorpModalTable.ajax.reload(function() {});
		}, 200);
	});
	
	//공정순서변경되었을 때
	processInfoTable.on( 'row-reorder', function ( e, diff, changes ) {
		if(diff.length != 0){
			$('#btnProcessSave').attr('disabled',false);
			WM_action_ON('prcssNew', 'workingWarningModal');
		}
	} );
	
	//공정정보 신규
	$('#btnProcessNew').on('click',function(){
   		prcssModalTable.select.style('multi');
   		//선택되어있는 행들 취소 시키고 선택(등록되어있는 행) 시키기			
		prcssModalTable.rows('.selected').deselect();
   		$('#prcssModal').modal('show');   	
		setTimeout(function() {
			prcssModalTable.ajax.reload(function() {
				//선택(등록되어있는 행)
				/* for( let i = 0; i < processInfoTable.data().length; i++){
					//인덱스 구해서 선택시키기
					prcssModalTable.row($('#prcssModalTable tbody').find('#'+processInfoTable.row(i).data().prcssIdx).index()).select();
				} */
			});
		}, 200);
   		//WM_action_ON('prcssNew', 'workingWarningModal');
   		
		$('#btnProcessNew').attr('disabled',false);
		$('#btnProcessSave').attr('disabled',false);
		$('#btnProcessEdit').attr('disabled',true);
		$('#btnProcessDel').attr('disabled',false);
		$('#btnProcessCancel').attr('disabled',false);

   	});


	//공정정보 모달에서 붙여넣기
	$('#btnPrcssModalPaste').on('click',function(){
		let status = true;
		let ngPrcssCd = '';
		
		if(!$('#prcssModalTable tbody tr').hasClass('selected')){
			toastr.warning('붙여넣을 행을 선택해주세요.');
			return false;
		}

		$('#my-spinner').show();

		//처음으로 공정선택할 때 다중 행
		if(prcssModalTable.select.style() == 'multi'){
			let selectedIndex = prcssModalTable.rows('.selected').toArray()[0];
			if( status ){
				//모달창에서 선택되어있는 공정 IDX들( 붙여넣을 항목 )
				let prcssIdxArray = getPrcssIdx(prcssModalTable.rows('.selected').data().toArray(),"idx");
				let i = 0;
				let j = 0;
				let rowDeleteCnt = 0;
				let prcssTableLen = $('#processInfoTable tbody tr').length - $('#processInfoTable tbody tr').find('.dataTables_empty').length;
				/* for(j = 0 ; j < prcssTableLen; j++){
					//for에서 반복된 테이블(공정정보) 행이 / 모달창에서 선택되어있는 행의 idx가 있다면 -> 수정이므로 삽입 X  
					// 							/ 없다면 -> for에서 반복된 테이블(공정정보) 행 지우기 OR 신규 삽입 대상
					//indexOf return값이 -1보다 큰 경우 true(값이있다), -1일경우 false(값이없다)
					if(processInfoTable.row(j-rowDeleteCnt).data() != undefined){
						if( prcssIdxArray.indexOf(processInfoTable.row(j-rowDeleteCnt).data().prcssIdx) > -1 ){
							//해당 인덱스는 배열 값에서 제외 ( 이미 삽입되어있기 때문 )
							prcssIdxArray = prcssIdxArray.filter((element) => element !== processInfoTable.row(j-rowDeleteCnt).data().prcssIdx);
						} else {
							//모달에서 선택안된 행 지우기 
							processInfoTable.row(j-rowDeleteCnt).remove().draw();
							rowDeleteCnt++;
						}
					}
				} */
				//필터된 array(삽입 해야할 항목)
				for(i = 0; i < prcssIdxArray.length; i++){
					//모달 행 위치
					let modalRow = getPrcssIdx(prcssModalTable.data().toArray(),"idx").indexOf(prcssIdxArray[i]); 
					
					//추가될 row = 테이블 행 갯수 - 데이터가 없는 경우 나오는 행
					let rowLvl = $('#processInfoTable tbody tr').length - $('#processInfoTable tbody tr').find('.dataTables_empty').length;

					let modalData = prcssModalTable.row(modalRow).data();
					
					$('#processInfoTable').DataTable().row.add({
						'rowGubun'				: 'add',
						'prcssOrder'			: null,
						'prcssCd'				: null,
						'prcssNm'				: null,
						'equipIdx'				: null,
						'equipNm'				: null,
						'outsrcGubun'			: null,
						'workMethod'			: null,
						'workOrdQty'            : '자동계산',
						'produceQtyUnitNm'      : null,
						'workMethodDtl'			: null,
						'customerCd'			: null,
						'qtyUnitNm'				: null,
						'prcssDesc'				: null,
						'note'					: null,
						'prcssIdx'				:	modalData.idx,
					}).draw(false);					
					
					processInfoTable.row(rowLvl).data().prcssIdx = modalData.idx;
					processInfoTable.row(rowLvl).data().prcssCd = modalData.prcssCd;
					processInfoTable.row(rowLvl).data().prcssNm = modalData.prcssNm;
					//단위
					processInfoTable.row(rowLvl).data().qtyNuit = modalData.qtyNuit;
					processInfoTable.row(rowLvl).data().qtyUnitNm = modalData.qtyUnitNm;
					//비고
					processInfoTable.row(rowLvl).data().prcssDesc = modalData.prcssDesc;

					//생산단위
					processInfoTable.row(rowLvl).data().produceQtyUnitNm = modalData.produceQtyUnitNm;
					$('#processInfoTable tbody tr').eq(rowLvl).find('td').eq(7).html('<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+modalData.produceQtyUnitNm+'</div>');
					
					$('#processInfoTable tbody tr').eq(rowLvl).find('td').eq(1).html('<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+modalData.prcssCd+'</div>');
					$('#processInfoTable tbody tr').eq(rowLvl).find('td').eq(10).html('<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+modalData.qtyUnitNm+'</div>');
					//$('#processInfoTable tbody tr').eq(rowLvl).find('td').eq(11).html('<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+modalData.prcssDesc+'</div>');
					//공정명 html
					let html1='';
					html1 += '<div style="display: flex; flex-wrap: 1 1 auto;">';
					html1 += '<input type="text" class="form-control inputGroup" id="prcssNm" style="max-width: 100%;" disabled="disabled" value="'+modalData.prcssNm+'">';
					html1 += '<input type="hidden" id="prcssIdx">';
					html1 += '</div>';			
					$('#processInfoTable tbody tr').eq(rowLvl).find('td').eq(2).html(html1);

					let node = processInfoTable.row(rowLvl).node();
					//설비정보
					$(node).find('td').eq(3).find('button[name=equipModalBtn]').val(modalData.idx);//발주처 돋보기버튼에 공정식별자 넣어두기

					/* let multipleNode = $(node).find('td').eq(5).find('select[name=workMethodMultiSelect]');
			    	$(multipleNode).select2({
			    		data: JSON.parse(modalData.workMethodJson),
			    		multiple : true,
			    		placeholder: "작업방법 선택",
			    	});
			    	$(node).find('td').eq(5).find('span').eq(0).css('width','100%');
			    	$(node).find('td').eq(5).find('.select2-search__field').css('width','100%');
			    	$(node).find('td').eq(5).find('.select2-selection__rendered').attr('style','display:flex; align-content:flex-start; flex-direction:column; flex-wrap:wrap; overflow:auto;');
			    	 */
					
				} 
				processInfoTable.draw(false);
				$('button[name=prcssModalBtn]').attr('disabled',false);
				$('select[name=outsrcGubun]').attr('disabled',false);
				$('input[name=workMethodDtl]').attr('disabled',false);
				$('button[name=customerModalBtn]').attr('disabled',false);
				$('input[name=note]').attr('disabled',false);
				$('button[name=equipModalBtn]').attr('disabled',false);
				$('select[name=workMethodMultiSelect]').attr('disabled',false);
				$('button[name=nameDel]').attr('disabled',false);
				$('select[name=equipIdx]').attr('disabled',false);
				$('#prcssModal').modal('hide'); 
				toastr.success('공정이 추가되었습니다.');
				WM_action_ON('prcssNew', 'workingWarningModal');
			} else {				
				toastr.warning('이미 추가된 공정이 있습니다.<br>추가된 공정 코드 : '+ngPrcssCd);
			}

			
		} else if(prcssModalTable.select.style() == 'single'){ //단일 행 선택해서 수정일 경우
			//중복체크
			$('#processInfoTable tbody tr').each(function(index){
				if(processInfoTable.row(index).data() != undefined ){
					if(processInfoTable.row(index).data().prcssIdx == prcssModalTable.row('.selected').data().idx){
						ngPrcssCd += prcssModalTable.row('.selected').data().prcssCd;
						status = false;
					}
				}
			});
			if( status ){
				processInfoTable.row('.selected').data().prcssIdx = prcssModalTable.row('.selected').data().idx;
				//단위
				processInfoTable.row('.selected').data().qtyNuit = prcssModalTable.row('.selected').data().qtyNuit;
				processInfoTable.row('.selected').data().qtyUnitNm = prcssModalTable.row('.selected').data().qtyUnitNm;
				//비고
				processInfoTable.row('.selected').data().prcssDesc = prcssModalTable.row('.selected').data().prcssDesc;
			
				$('#processInfoTable tbody').find('.selected').find('td').eq(1).html('<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+prcssModalTable.row('.selected').data().prcssCd+'</div>');
				$('#processInfoTable tbody').find('.selected').find('td').eq(10).html('<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+prcssModalTable.row('.selected').data().qtyUnitNm+'</div>');
				$('#processInfoTable tbody').find('.selected').find('td').eq(11).html('<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+prcssModalTable.row('.selected').data().prcssDesc+'</div>');
				//공정명 html
				let html1='';
				html1 += '<div style="display: flex; flex-wrap: 1 1 auto;">';
				html1 += '<input type="text" class="form-control inputGroup" id="prcssNm" style="max-width: 100%;" disabled="disabled" value="'+prcssModalTable.row('.selected').data().prcssNm+'">';
				html1 += '<input type="hidden" id="prcssIdx">';
				html1 += '</div>';			
				$('#processInfoTable tbody').find('.selected').find('td').eq(2).html(html1);
				processInfoTable.draw(false);
				$('#prcssModal').modal('hide');  
				WM_action_ON('prcssNew', 'workingWarningModal');
			} else {
				toastr.warning('이미 추가된 공정이 있습니다.<br>추가된 공정 코드 : '+ngPrcssCd);
			}
		}
		$('#my-spinner').hide();
	});

	//멀티셀렉트 값 바뀌면 테이블 헤더 보정
	$(document).on('change','select[name=workMethodMultiSelect]',function(){
		processInfoTable.draw(false);
	});

	//공정정보 저장
	$('#btnProcessSave').on('click',function(){
		let status = true;
		let insertList = [];
		$('#my-spinner').show();
		if($('#processInfoTable tbody tr').length - $('#processInfoTable tbody tr').find('.dataTables_empty').length == 0){
			
		} else {
		
			$('#processInfoTable tbody tr').each(function(index){
				if(processInfoTable.row(index).data().prcssIdx == null || processInfoTable.row(index).data().matrlIdx == prcssIdx){
					status = false;
				} else {
					let obj = {};

					let node = processInfoTable.row(index).node();
					obj.bizOrdDtlIdx = bizOrdDtlIdxVal;
					obj.itemIdx = itemIdx;
					obj.prcssOrder = processInfoTable.row(index).data().prcssOrder;
					obj.prcssIdx = processInfoTable.row(index).data().prcssIdx;
					let equipIdx = null;
					//if( processInfoTable.row(index).data().equipIdx != '' && processInfoTable.row(index).data().equipIdx != null ){
					//	equipIdx = processInfoTable.row(index).data().equipIdx;
					//}
					equipIdx = $(node).find('td').eq(3).find('select').val();
					obj.equipIdx = equipIdx;
					obj.outsrcGubun =  $(node).find('td').eq(4).find('select').val();
					//obj.workMethod = $(node).find('td').eq(5).find('select[name=workMethodMultiSelect]').val().join(',');
					obj.workMethodDtl = $(node).find('td').eq(6).find('input').val();
					let outsrcIdx = null;
					if( $(node).find('td').eq(9).find('input[type=hidden]').val() != ''){
						outsrcIdx = $(node).find('td').eq(9).find('input[type=hidden]').val();
					}
					obj.outsrcIdx = outsrcIdx;
					obj.note = $(node).find('td').eq(11).find('input').val();
					insertList.push(obj);
				}
			});
		}
		$('#my-spinner').hide();
		if(status){
			$.ajax({
				url: '<c:url value="/bs/bizOrderItemPrcssInsert"/>',
	            type: 'POST',
	            //async: false,
	            data: {
	                'insertList' : JSON.stringify(insertList),
	                'itemIdx'	: function(){ return itemIdx; },
	                'bizOrdDtlIdx' : function(){return bizOrdDtlIdxVal;},
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if (res.result == "ok") { //응답결과
						let data = res.data;
						toastr.success('신규 저장되었습니다.');
						WM_action_OFF('prcssNew');
						$('#btnProcessNew').attr('disabled',false);
						$('#btnProcessSave').attr('disabled',true);
						$('#btnProcessEdit').attr('disabled',false);
						$('#btnProcessDel').attr('disabled',false);
						$('#btnProcessCancel').attr('disabled',true);						
						processInfoTable.ajax.reload(function(){
							$('button[name=customerModalBtn]').attr('disabled',true);
							$('button[name=equipModalBtn]').attr('disabled',true);

							/* $('#processInfoTable tbody tr').each(function(index){
								let node = processInfoTable.row(index).node();
								if(processInfoTable.row(index).data() != undefined && processInfoTable.row(index).data() != ''){
									let prcssIdx = processInfoTable.row(index).data().prcssIdx;
									//작업방법 멀티셀렉트를 해야하는데 //공정코드 -> 작업방법 리스트화 -> select2
									let multipleNode = $(node).find('td').eq(5).find('select[name=workMethodMultiSelect]');
									
									$(multipleNode).select2({
							    		data: JSON.parse(processInfoTable.row(index).data().workMethodJson),
							    		multiple : true,
							    		placeholder: "작업방법 선택",
							    	});
							    	
									$(node).find('td').eq(5).find('span').eq(0).css('width','100%');
							    	$(node).find('td').eq(5).find('.select2-search__field').css('width','100%');
							    	$(node).find('td').eq(5).find('.select2-selection__rendered').attr('style','display:flex; align-content:flex-start; flex-direction:column; flex-wrap:wrap; overflow:auto;');
									
									if( processInfoTable.row(index).data().workMethod != null && processInfoTable.row(index).data().workMethod != ''){
										let splitData =  processInfoTable.row(index).data().workMethod.split(',');
										$(node).find('td').eq(5).find('select[name=workMethodMultiSelect]').val(splitData).trigger('change')
									}
									$(node).find('td').eq(5).find('select[name=workMethodMultiSelect]').attr('disabled',true);
								}
							}); */

							$('#my-spinner').hide();
							setTimeout(function() {
								processInfoTable.draw(false);
							},100);

							$('#btnProcessCopy').attr('disabled',false);
							
						});
						
					} else if(res.result == 'fail') {
						toastr.warning(res.message);
					} else {
						toastr.error(res.message);
					}
					$('#my-spinner').hide();
				}
			});
		} else {
			toastr.warning('공정명을 선택하지 않은 행이 있습니다.');
		}		
	});

	//수정
	$('#btnProcessEdit').on('click',function(){
		_promise_().then(()=>{
			$('#btnProcessNew').attr('disabled',false);
			$('#btnProcessSave').attr('disabled',false);
			$('#btnProcessEdit').attr('disabled',true);
			$('#btnProcessDel').attr('disabled',false);
			$('#btnProcessCancel').attr('disabled',false);

			$('button[name=prcssModalBtn]').attr('disabled',false);
			$('select[name=outsrcGubun]').attr('disabled',false);
			$('input[name=workMethodDtl]').attr('disabled',false);
			$('button[name=customerModalBtn]').attr('disabled',false);
			$('input[name=note]').attr('disabled',false);
			$('button[name=equipModalBtn]').attr('disabled',false);
			$('select[name=workMethodMultiSelect]').attr('disabled',false);
			$('select[name=equipIdx]').attr('disabled',false);
			$('#processInfoTable').find('button[name=nameDel]').attr('disabled',false);
			WM_action_ON('prcssNew', 'workingWarningModal');
		}).then(()=>{
			processInfoTable.draw(false);
		});
			
	});
	
	$('#btnProcessDel').on('click',function(){
		if(!$('#processInfoTable tbody tr').hasClass('selected')){
			toastr.warning('삭제할 항목을 선택해주세요.');
			return false;
		}
		let idx = processInfoTable.row('.selected').data().idx;
		if(idx != '' && idx != undefined && idx != null){
			//delStatus = 'prcss';
			$('#deleteModal').data('deleteType','prcss');
			$('#deleteModal').modal('show');
		} else {
			$('#processInfoTable').DataTable().row('.selected').remove().draw(false);
		}
	});
	
	//객체(json)에서 키(field)로 값 찾기
	function getPrcssIdx(input, field) {
	    let output = [];
	    for (let i=0; i < input.length ; ++i)
	        output.push(input[i][field]);
	    return output;
	}
	
	/************************ 사진 및 첨부파일 ************************/
	// 파일 목록조회
	$('#fileTable thead tr').clone(true).addClass('filters').appendTo('#fileTable thead'); // filter 생성
	let fileTable = $('#fileTable').DataTable({
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
		select: {
            style: 'single',
            toggleable: false,
            items: 'row',
            info: false
        },
        ajax : {
			url : '<c:url value="/bm/itemFileListAll"/>',
			type : 'GET',
			data : {
				'idx' : function() { return itemIdx; },
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'progressOrder', className : 'text-center'},
			{ data: 'fileSplitNm', className : 'text-center'},
			{ data: 'ext', className : 'text-center'},
			{ data: 'regDate', className : 'text-center'},
			{ data : 'download', className : 'text-center',
				render : function(data, type, row, meta) {
					if( row['fileStatus']=='F'){
						let html = '';
							html += '<div>';
							html += '	<input type="file" style="display:none;" id="fileNm'+ idValue +'" name="fileNm'+ idValue +'" value="" multiple>';
							html += '	<input type="hidden" class="uuid" id="fileUuid'+ idValue + '" value="'+ row['fileUuid'] +'"> ';
							html += '' + data + '';
							html += '</div>';
						return html;	
					} else{
						let html = '';
						if(data != null && data != "") {
							html += '<a href="/file/fileDownload?uuid='+row.uuid+'&fileName='+row.fileNm+'&ext='+row.ext+'">';
							html += '<span style="font-size: 14px;">'+data+'</span>';							
							html += '<input type="hidden" id="fileHidden'+ meta.row +'" value="'+data+'">';
						}
						return html;
					}
				}
			},
		],
		columnDefs : [
			//{
			//	targets: [0],
			//	render: function(data) {
			//		return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'data+'</div>';
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
			let theadHeight = parseFloat($('#fileTable_wrapper').find('.dataTables_scrollHead').css('height'));
			let baseTableHeight = parseFloat($('#rightcolM').css('height'));
			let baseTableWidth = parseFloat($('#imgDiv').css('width'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(baseTableHeight - 155)+'px');
			$('#viewer').css('height',(baseTableHeight - 66)+'px');
			$('#viewer').css('width', (baseTableWidth - 14)+'px');
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAllFt').off('keyup',function() {});
			$('#searchAllFt').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			});

			//progressOrder
			for(var i=0;i<data.length;i++) {
				let tr = $('#fileTable tbody').find('tr').eq(i);
				fileTable.row(tr).data().progressOrder = i+1;
				$(tr).find('td').eq(0).html(i+1);
			}
		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#fileTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#fileTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	fileTable.on('column-reorder', function( e, settings, details ) {
		let api = fileTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#fileTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});
	/************************ 공정정보 , 사진 및 첨부파일 탭 클릭 ************************/
	$('#tab3Nav').on('click',function(){
		$('#my-spinner').show();
		processInfoTable.ajax.reload(function(){
			$('button[name=customerModalBtn]').attr('disabled',true);
			$('button[name=equipModalBtn]').attr('disabled',true);
			$('#processInfoTable tbody tr').each(function(index){
				let node = processInfoTable.row(index).node();
				if(processInfoTable.row(index).data() != undefined && processInfoTable.row(index).data() != ''){
					let prcssIdx = processInfoTable.row(index).data().prcssIdx;
					//작업방법 멀티셀렉트를 해야하는데 //공정코드 -> 작업방법 리스트화 -> select2
					let multipleNode = $(node).find('td').eq(5).find('select[name=workMethodMultiSelect]');
					
					/* $(multipleNode).select2({
			    		data: JSON.parse(processInfoTable.row(index).data().workMethodJson),
			    		multiple : true,
			    		placeholder: "작업방법 선택",
			    	});
			    	
					$(node).find('td').eq(5).find('span').eq(0).css('width','100%');
			    	$(node).find('td').eq(5).find('.select2-search__field').css('width','100%');
			    	$(node).find('td').eq(5).find('.select2-selection__rendered').attr('style','display:flex; align-content:flex-start; flex-direction:column; flex-wrap:wrap; overflow:auto;');
		    	
					if( processInfoTable.row(index).data().workMethod != null && processInfoTable.row(index).data().workMethod != ''){
						let splitData =  processInfoTable.row(index).data().workMethod.split(',');
						$(node).find('td').eq(5).find('select[name=workMethodMultiSelect]').val(splitData).trigger('change')
					}
					$(node).find('td').eq(5).find('select[name=workMethodMultiSelect]').attr('disabled',true);
					 */
				}
			});

			if($('#processInfoTable tbody tr').find('.dataTables_empty').length == 1){
				$('#btnProcessCopy').attr('disabled',false);
			} else {
				$('#btnProcessCopy').attr('disabled',true);
			}

			$('#my-spinner').hide();
			setTimeout(function() {
				processInfoTable.draw(false);
			},100);
		});
	});

	$('#tab4Nav').on('click',function(){
		fileTable.ajax.reload(function(){
			$('#fileTable_wrapper').find('tbody').find('.selected').removeClass('selected');
			$('#viewer').attr('src','');
		});
	});

	// 취소 경고창 취소 버튼 click
	$('#btnCancelModalY').on('click', function() {
		toastr.success('취소되었습니다.');
		if(CancelIdx == 'prcssNew'){
			WM_action_OFF('prcssNew');
			processInfoTable.ajax.reload(function(){
				$('button[name=customerModalBtn]').attr('disabled',true);
				$('button[name=equipModalBtn]').attr('disabled',true);
				$('#processInfoTable tbody tr').each(function(index){
					let node = processInfoTable.row(index).node();
					if(processInfoTable.row(index).data() != undefined && processInfoTable.row(index).data() != ''){
						let prcssIdx = processInfoTable.row(index).data().prcssIdx;
						let multipleNode = $(node).find('td').eq(5).find('select[name=workMethodMultiSelect]');
						
						/* $(multipleNode).select2({
				    		data: JSON.parse(processInfoTable.row(index).data().workMethodJson),
				    		multiple : true,
				    		placeholder: "작업방법 선택",
				    	});
				    	
						$(node).find('td').eq(5).find('span').eq(0).css('width','100%');
				    	$(node).find('td').eq(5).find('.select2-search__field').css('width','100%');
				    	$(node).find('td').eq(5).find('.select2-selection__rendered').attr('style','display:flex; align-content:flex-start; flex-direction:column; flex-wrap:wrap; overflow:auto;');
			    	
					
						if( processInfoTable.row(index).data().workMethod != null && processInfoTable.row(index).data().workMethod != ''){
							let splitData =  processInfoTable.row(index).data().workMethod.split(',');
							$(node).find('td').eq(5).find('select[name=workMethodMultiSelect]').val(splitData).trigger('change')
						}
						$(node).find('td').eq(5).find('select[name=workMethodMultiSelect]').attr('disabled',true);
						 */
					}
				});

				$('#my-spinner').hide();
				setTimeout(function() {
					processInfoTable.draw(false);
				},100);

				if($('#processInfoTable tbody tr').find('.dataTables_empty').length == 1){
					$('#btnProcessCopy').attr('disabled',false);
				} else {
					$('#btnProcessCopy').attr('disabled',true);
				}
				
			});
			$('#btnProcessNew').attr('disabled', false);
			$('#btnProcessSave').attr('disabled', true);
			$('#btnProcessEdit').attr('disabled', false);
			$('#btnProcessDel').attr('disabled', false);
			$('#btnProcessCancel').attr('disabled', true);
		} else if(CancelIdx == 'matrlNew'){
			WM_action_OFF('matrlNew');

			purchaseOrderAdmTable.ajax.reload();
			purchaseOrderAdmTable.colReorder.enable();
			// 수주별발주내역이 존재하지 않을 경우 BOM목록을 불러와 저장할 수 있는 상태로 셋팅
			/* $('#matrlSelectGubun').val('001');
			if(purchaseOrderAdmTable.data().count() == 0 && bizOrderDtlTable.row('.selected').data() != undefined) {
				let dataList = matrlModalSelectTable.data().toArray();
				let addList = [];
				for(var i=0;i<dataList.length;i++) {
					let obj = {};
					obj.idx = '';
					obj.matrlIdx = dataList[i].matrlIdx;
					obj.matrlCd = dataList[i].matrlCd;
					obj.matrlNm = dataList[i].matrlNm;
					obj.paperType = dataList[i].paperType;
					obj.confirmYn = 'N';
					obj.printYn = 'N';
					obj.purchaseOrdNo = '자동채번';
					obj.purchaseOrdQty = ordQtyVal;
					obj.purchaseOrdDate = moment().format('YYYY-MM-DD');
					obj.purchaseInDueDate = moment().format('YYYY-MM-DD');
					if(dataList[i].dealCorpIdx > 0 && dataList[i].dealCorpNm != null){
						obj.dealCorpIdx = dataList[i].dealCorpIdx;
						obj.dealCorpNm = dataList[i].dealCorpNm;
					} else {
						obj.dealCorpIdx = '';
						obj.dealCorpNm = '';
					}
					obj.cutQty = dataList[i].cutQty;
					obj.eaQty = dataList[i].eaQty;
					obj.extraQty = dataList[i].extraQty;
					obj.extraPackQty = '0';
					obj.cutSize = dataList[i].cutSize;
					obj.purchaseNote = '';
					obj.purchaseDesc = '';
					addList.push(obj);
				}
				purchaseOrderAdmTable.rows.add(addList).draw(false);
				$('#purchaseOrderAdmTable_wrapper').find('.filters th').each(function(index, item) {
					$(item).find('input').attr('disabled', true); // 검색 필터 disabled
				});
				purchaseOrderAdmTable.colReorder.disable();
				purchaseOrderAdmTable.draw();

				$('#btnMaterialNew').attr('disabled', false); // DTL 신규 버튼
				$('#btnMaterialSave').attr('disabled', false); // DTL 저장 버튼
				$('#btnMaterialEdit').attr('disabled', true); // DTL 수정 버튼
				$('#btnMaterialDel').attr('disabled', false); // DTL 삭제 버튼
				$('#btnMaterialCancel').attr('disabled', false); // DTL 취소 버튼

				
				
			} else {
				$('#purchaseOrderAdmTable_wrapper').find('.filters th').each(function(index, item) {
					$(item).find('input').attr('disabled', false); // 검색 필터 disabled
				});
				purchaseOrderAdmTable.colReorder.enable();
			} */
			$('#purchaseOrderAdmTable_wrapper').find('.filters th').each(function(index, item) {
				$(item).find('input').attr('disabled', false); // 검색 필터 disabled
			});
			
			$('#btnMaterialNew').attr('disabled', false); // 신규 버튼
			$('#btnMaterialCopy').attr('disabled',false);
			$('#btnMaterialSave').attr('disabled', true); // 저장 버튼
			$('#btnMaterialEdit').attr('disabled', false); // 수정 버튼
			$('#btnMaterialDel').attr('disabled', false); // 삭제 버튼
			$('#btnMaterialCancel').attr('disabled', true); // 취소 버튼
		} else if(CancelIdx == 'bundle'){
			WM_action_OFF('bundleNew');
			bundleInfoTable.ajax.reload();
			$('#btnBundleNew').attr('disabled',false);
			$('#btnBundleSave').attr('disabled',true);
			$('#btnBundleEdit').attr('disabled',false);
			$('#btnBundleDel').attr('disabled',false);
			$('#btnBundleCancel').attr('disabled',true);
		}
		
	});

	/************ 파일(사진 및 첨부파일)기능 ************/
	//파일추가
	$('#btnFileAdd').on('click',function(){
		$('#fileFake').trigger('click');
	});

	//파일삭제
	$('#btnFileDel').on('click',function(){
		if( !$('#fileTable tbody tr').hasClass('selected') ){
			toastr.warning('삭제할 항목을 선택해주세요.');
			return false;
		}
		
		let idx = fileTable.row('.selected').data().idx;
		if(idx != '' && idx != undefined){
			//delStatus = 'file'
			$('#deleteModal').data('deleteType','file');
			$('#deleteModal').modal('show');
		} else {
			//폼데이터로부터 지우고 테이블 다시그리기
			let selectUuid = $('#fileTable tbody').find('.selected').find('.uuid').val();
			formData.delete('file+'+selectUuid);
			formData.delete('uuid+'+selectUuid);
			formData.delete('ext+'+selectUuid);
			$('#fileTable').DataTable().row('.selected').remove().draw();
		}
	});

	//파일 저장
	$('#btnFileSave').on('click',function(){
		let fileString = [];
		let i=0;
		//삭제된 데이터들로부터 형식맞추는곳
		let formData2 = new FormData();
		let entries = formData.entries();
		for (let pair of entries) {
			if(i%3 == 0){
				formData2.append(pair[0].split('+')[0]+'-'+pair[0].split('+')[1],pair[1]);
			} else {
				formData2.append(pair[0].split('+')[0],pair[1]);
			}
			i++;
		}
		i=0;
		$('#fileTable tbody tr').each(function(index, item) {
			if( fileTable.row(this).data() != undefined && fileTable.row(this).data() != null){
				if( fileTable.row(this).data().idx == '' || fileTable.row(this).data().idx == undefined ){ 
					//파일스트링 만드는곳
					let fileArr = formData2.getAll('file-'+formData2.getAll('uuid')[i])[0].name.split('.');
					let fileFullNm = _.slice(fileArr, 0, -1).join('.');
					let obj = {};
					obj.uuid = formData2.getAll('uuid')[i];
					obj.fileNm = fileFullNm;
					obj.ext = formData2.getAll('ext')[i];
					
					fileString.push(obj);
					/* fileString += formData2.getAll('uuid')[i] + '/' 
					+ formData2.getAll('file-'+formData2.getAll('uuid')[i])[0].name.split('.')[0] + '/'
					 + formData2.getAll('ext')[i] + '★'; */
					i++;
				}
			}
		});
		let idx = bizOrderDtlTable.row('.selected').data().itemIdx;
		$.ajax({
			url: '<c:url value="/bm/itemFileInsert"/>',
            type: 'POST',
            //async: false,
            data: {    
	            'itemIdx'		:	function(){return idx;},
            	'fileString'		:	JSON.stringify(fileString),
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					toastr.success('저장되었습니다.');
					//$('#btnSearch').trigger('click'); // 조회버튼 click

					WM_action_OFF('fileNew');

					$('#btnFileAdd').attr('disabled',false);
					$('#btnFileSave').attr('disabled',true);
					$('#btnFileDel').attr('disabled',false);
					if(fileString != ''){
						fileUpload(formData2); // 파일 업로드
					}
					itemIdx = bizOrderDtlTable.row('.selected').data().itemIdx;
					fileTable.ajax.reload(function(){});
					formData = new FormData();
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
		
	});
	
	// 파일 선택
	let idValue=0;	
	let formData = new FormData();
	$('#fileFake').on('change',function(e) {
		let fileInput = document.getElementById('fileFake'); 
		if(fileInput.files.length>0){
			let files = fileInput.files; //업로드한 파일들의 정보를 넣는다.
	
			for(let i = 0; i < document.querySelector('#fileFake').files.length; i++){
				//폼데이터 넣는곳
				let uuid = uuid_v4();
				formData.append('file+'+uuid,files[i]);
				formData.append('uuid+'+uuid,uuid);
				formData.append('ext+'+uuid,files[i].name.split('.').at(-1));

				let fileArr = files[i].name.split('.');
				let fileFullNm = _.slice(fileArr, 0, -1).join('.');
				
				//페이크 업로드파일로부터 추가된 행에 데이터 옮겨주기
				let fileData =  document.querySelector('#fileFake').files[i]; 
				fileTable.row.add({
					'progressOrder' : 0,
					'ext'     : files[i].name.split('.').at(-1),
					//'regNm'   : sessionUserNm,
					'regDate' : moment().format('YYYY-MM-DD'),
		 			'fileSplitNm'		:	fileFullNm,
		 			'fileNm'		:	fileData.name,
		 			'fileStatus'    :  'F',
		 			'fileUuid' 		: uuid,
		 			'download'  : files[i].name,
		 			'idValue' 	: idValue,
				}).draw(false);
				idValue++;
			}
		}
		WM_action_ON('fileNew', 'workingWarningModal');
		$('#btnFileSave').attr('disabled',false);
	});

	//파일테이블 클릭
	$('#fileTable tbody').on('click','tr', function() {
		
		let idNumber = fileTable.row(this).data().idValue;
		let ext = fileTable.row(this).data().ext;
		if(WMCheck('new')) { // 신규등록중일 경우
			setWM('new', 'idx', idx);
			return false;
		}
		if(WMCheck('edit')) { // 수정중일 경우
			setWM('edit', 'idx', idx);
			return false;
		}

		$('#imgView').attr('style','');
		
		if( fileTable.row(this).data().idx == undefined ){
			let fileUuid = fileTable.row(this).data().fileUuid;
			let bases64 = getImgBase64(formData.get('file+'+fileUuid));
			$('#imgView').attr('style','');
			$('#viewer').attr('src','data:image/jpeg;base64,'+bases64);
		} else {
			let fileObject = new Object();
			fileObject.uuid = fileTable.row(this).data().uuid;
			fileObject.ext = fileTable.row(this).data().ext;
			if(fileTable.row(this).data().ext == 'bmp' || fileTable.row(this).data().ext == 'rle'
				|| fileTable.row(this).data().ext == 'dlb' || fileTable.row(this).data().ext == 'rle'
				|| fileTable.row(this).data().ext == 'jpg' || fileTable.row(this).data().ext == 'png'
				|| fileTable.row(this).data().ext == 'jfif' || fileTable.row(this).data().ext == 'gif'){
				let blob = getFileBlob(fileObject);
				$('#imgView').attr('style','');
				$('#viewer').attr('src','data:image/jpeg;base64,'+blob);
			} else {
				$('#imgView').attr('style','');
				$('#viewer').attr('src','data:image/jpeg;base64,');
			}
		}

	 });

	//사진확대축소
	$(document).ready(function(){
		$('#fileTable tbody').on('click','tr', function() {
				 const element = document.getElementById('imgView');
				 const panzoom = Panzoom(element, {});		
				 const parent = element.parentElement;
			     parent.addEventListener('wheel', panzoom.zoomWithWheel);
		});
	});

	/********************************* 수주별발주 *********************************/	
	// 수주별발주 수주별 목록조회
	$('#purchaseOrderAdmTable thead tr').clone(true).addClass('filters').appendTo('#purchaseOrderAdmTable thead'); // filter 생성
	let purchaseOrderAdmTable = $('#purchaseOrderAdmTable').DataTable({
		dom : "<'row'<'col-md-12 col-md-6'l><'col-md-12 col-md-6'f>>"
				+ "<'row'<'col-md-12'tr>>"
				+ "<'row pt-1'<'d-flex align-items-center d-flex'Bp><'me-lg-auto'><'d-flex align-items-center justify-content-end'i>>",
		language: lang_kor,
		info: false,
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
			url : '<c:url value="/pm/purchaseOrderAdmLstByBizDtl"/>',
			type : 'POST',
			data : {
				bizOrdDtlIdx	: function() { return bizOrdDtlIdxVal; }
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'confirmYn', className : 'text-center align-middle', name: 'confirmYn',
				render : function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						if(data == 'Y') {
							let html = '';
								html += '<input type="checkbox" class="bootstrapToggle confirmToggle p-0" data-toggle="toggle"';
								html += '		data-type="confirmOrder" data-idx="'+row['idx']+'"';
								html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
								html += '		data-size="small"';
								html += '		checked>';
							return html;
						} else {
							let html = '';
								html += '<input type="checkbox" class="bootstrapToggle confirmToggle p-0" data-toggle="toggle"';
								html += '		data-type="confirmOrder" data-idx="'+row['idx']+'"';
								html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
								html += '		data-size="small"';
								html += '		>';
							return html;
						}
					} else {
						let html = '';
							html += '<input type="checkbox" class="bootstrapToggle confirmToggle p-0" data-toggle="toggle"';
							html += '		data-type="confirmOrder" data-idx="'+row['idx']+'"';
							html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
							html += '		data-size="small"';
							html += '		disabled>';
						return html;
					}
					
				}
			},
			{ data: 'stockUseYn', className : 'text-center align-middle', name: 'confirmYn',
				render : function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						if(data == 'Y') {
							let html = '';
							html += '<input type="checkbox" class="bootstrapToggle confirmToggle p-0" data-toggle="toggle"';
							html += '		data-type="stockUseYn" data-idx="'+row['idx']+'"';
							html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
							html += '		data-size="small"';
							html += '		checked>';
							return html;
						} else {
							let html = '';
							html += '<input type="checkbox" class="bootstrapToggle confirmToggle p-0" data-toggle="toggle"';
							html += '		data-type="stockUseYn" data-idx="'+row['idx']+'"';
							html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
							html += '		data-size="small"';
							html += '		>';
							return html;
						}			
					} else {
						let html = '';
						html += '<input type="checkbox" class="bootstrapToggle confirmToggle p-0" data-toggle="toggle"';
						html += '		data-type="stockUseYn" data-idx="'+row['idx']+'"';
						html += '		data-on="<i class=\'fa-solid fa-check mt-1\'></i>" data-off="<i class=\'fa-solid fa-x mt-1\'></i>"';
						html += '		data-size="small"';
						html += '		disabled>';
						return html;
					}
				}
			},
			{ data: 'asQty', className : 'text-end align-middle', name: 'asQty',
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return addCommas(parseInt(data));
					} else {
						return '0';
					}
				}
			},
			{ data: 'spQty', className : 'text-end align-middle', 
				render : function(data, type, row, meta) {
					if(data != null && data != ''){
						return addCommas(parseInt(data));
					} else {
						return '0';
					}
				}
			},
			/* { data: 'printYn', className : 'text-center align-middle', name: 'printYn',
				render : function(data, type, row, meta) {
					if(data == 'Y') {
						return '<i class="fa-solid fa-check mt-1 text-success"></i>';
					} else {
						return '<i class="fa-solid fa-x mt-1 text-danger"></i>';
					}
				}
			}, */
			{ data: 'purchaseOrdNo', className : 'text-center align-middle', name: 'purchaseOrdNo',
				render : function(data, type, row, meta) {
					if(data != '' && data != null) {
						return data;
					} else {
						return '자동채번';
					}
				}
			},
			/* { data: 'purchaseOrdDate', className : 'text-center align-middle editNode', name: 'purchaseOrdDate',
				render : function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						if(data != '' && data != null) {
							return moment(data,'YYYYMMDD').format('YYYY-MM-DD');
						} else {
							return '';
						}
					} else { // 등록되어있지 않는 값
						let html = '';
							html += '<input type="date" max="9999-12-31" class="form-control text-center" value="'+moment().format('YYYY-MM-DD')+'">';
							html += '<span class="d-none">'+data+'</span>';
						return html;
					}
				}
			},
			{ data: 'purchaseInDueDate', className : 'text-center align-middle editNode', name: 'purchaseInDueDate',
				render : function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						if(data != '' && data != null) {
							return moment(data,'YYYYMMDD').format('YYYY-MM-DD');
						} else {
							return '';
						}
					} else {
						let html = '';
							html += '<input type="date" max="9999-12-31" class="form-control text-center" value="'+moment().format('YYYY-MM-DD')+'">';
							html += '<span class="d-none">'+data+'</span>';
						return html;
					}
				}
			}, */
			/* { data: 'matrlCd', className : 'text-center align-middle', name: 'matrlCd'}, */
			{ data: 'paperType', className : 'text-center align-middle', name: 'paperType'},
			{ data: 'dealCorpNm', className : 'text-end align-middle editNode', name: 'dealCorpNm',
				render : function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						let dealCorpNm = isEmptyCheck(data) ? '' : data;
						
						let html = '';
							html += '<div class="input-group" style="min-width: 150px;">';
							html += '	<input type="text" class="form-control" value="'+dealCorpNm+'" disabled>';
							html += '	<button type="button" class="btnInputDel" style="background-color: transparent;';
							html += '		border-color: transparent; position: absolute;';
							html += '		top: 0; right:0;';
							html += '		margin: 1px 23px; margin-left: 0px;';
							html += '		border: none;';
							html += '		" disabled>';
							html += '		<i class="fa-solid fa-xmark"></i>';
							html += '	</button>';
							html += '	<input type="hidden" value="'+row['dealCorpIdx']+'">';
							html += '	<button type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary dealCorpModalBtn"';
							html += '	 data-matrlidx="'+row['matrlIdx']+'" disabled>';
							html += '		<i class="fa-solid fa-magnifying-glass"></i>';
							html += '	</button>';
							html += '</div>';
							html += '<span class="d-none">'+data+'</span>';
						return html;
					} else { // 등록되어있지 않는 값
						let dealCorpNm = isEmptyCheck(data) ? '' : data;
						let html = '';
							html += '<div class="input-group" style="min-width: 150px;">';
							html += '	<input type="text" class="form-control" value="'+dealCorpNm+'" disabled>';
							html += '	<button type="button" class="btnInputDel" style="background-color: transparent;';
							html += '		border-color: transparent; position: absolute;';
							html += '		top: 0; right:0;';
							html += '		margin: 1px 23px; margin-left: 0px;';
							html += '		border: none;';
							html += '		" >';
							html += '		<i class="fa-solid fa-xmark"></i>';
							html += '	</button>';
							html += '	<input type="hidden" value="'+row['dealCorpIdx']+'">';
							html += '	<button type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary dealCorpModalBtn"';
							html += '	 data-matrlidx="'+row['matrlIdx']+'">';
							html += '		<i class="fa-solid fa-magnifying-glass"></i>';
							html += '	</button>';
							html += '</div>';
							html += '<span class="d-none">'+data+'</span>';
						return html;
					}
					
				}
			},
			{ data: 'purchaseOrdQty', className : 'text-end align-middle', name: 'purchaseOrdQty',
				render : function(data, type, row, meta) {
					return addCommas(parseInt(data));
				}
			},
			{ className : 'text-end align-middle', name: 'purchaseQty', // 발주량 R -> 이론량 
				render : function(data, type, row, meta) {
					//if(row['etc2'] == '02'){
						//매입단위가 "통"인 경우 수주수량 == 발주수량임
					//	let purchaseOrdQty = isEmptyCheck(row['purchaseOrdQty']) ? 0 : parseInt(row['purchaseOrdQty']);
					//	let R = parseInt(purchaseOrdQty / 500); // R로 환산
					//	let purchaseQty = R + "R" + (purchaseOrdQty % 500);
						
					//	return purchaseQty;
					//} else {
						//매입단위가 "연" OR 매입단위 등록안한 경우 -> 계산식 적용해야함
						let ordQty = parseInt(row['purchaseOrdQty']); // 주문수량(제품)
						let cutQty = parseInt(row['cutQty']); // 절수
						let eaQty = parseInt(row['eaQty']); // 개수
						let extraQty = parseInt(row['extraQty']); // 여유분

						if(cutQty == 0 || eaQty == 0) {
							return '0';
						} else {
							let cuttingSize = Math.ceil(ordQty/(cutQty*eaQty));
							
							let R = parseInt(cuttingSize / 500); // R로 환산
							let purchaseQty = R + "R" + (cuttingSize % 500);
							
							return purchaseQty;
						}
					//}
					
				}
			},
			{ className : 'text-end align-middle', name: 'finalPurchaseQty', // 최종발주량 -> 발주량
				render : function(data, type, row, meta) {
					//if(row['etc2'] == '02'){
						//매입단위가 "통"인 경우 수주수량 == 발주수량임
					//	let purchaseOrdQty = isEmptyCheck(row['purchaseOrdQty']) ? 0 : parseInt(row['purchaseOrdQty']);
					//	let R = parseInt(purchaseOrdQty / 500); // R로 환산
					//	let purchaseQty = R + "R" + (purchaseOrdQty % 500);
						
					//	return purchaseQty;
					//} else {
						//매입단위가 "연" OR 매입단위 등록안한 경우 -> 계산식 적용해야함
						let ordQty = parseInt(row['purchaseOrdQty']); // 주문수량(제품)
						let cutQty = parseInt(row['cutQty']); // 절수
						let eaQty = parseInt(row['eaQty']); // 개수
						let extraQty = parseInt(row['extraQty']); // 여유분
						let extraPackQty = parseInt(row['extraPackQty']); // 포장단위여분
						
						if(cutQty == 0 || eaQty == 0) {
							return '0';
						} else {
							//let printPressQty = Math.ceil(ordQty/eaQty);
							let printPressQty = Math.ceil(ordQty/(cutQty*eaQty)) * cutQty;
							let pressQty = Math.ceil((printPressQty + extraQty)/cutQty + extraPackQty);
							
							let R = parseInt(pressQty / 500); // R로 환산
							let finalPurchaseQty = R + "R" + (pressQty % 500);
							
							return finalPurchaseQty;
						}
					//}
				}
			},
			{ data: 'cutQty', className : 'text-end align-middle editNode', name: 'cutQty',
				render : function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						return addCommas(parseInt(data));
					} else {
						let html = '';
							html += '<input type="text" class="form-control text-end calValue" onkeyup="numberFormat(this, \'int\')" value="'+parseInt(data)+'">';
							html += '<span class="d-none">'+data+'</span>';
						return html;
					}
				}
			},
			{ data: 'eaQty', className : 'text-end align-middle editNode', name: 'eaQty',
				render : function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						return addCommas(parseInt(data));
					} else {
						let html = '';
							html += '<input type="text" class="form-control text-end calValue" onkeyup="numberFormat(this, \'int\')" value="'+parseInt(data)+'">';
							html += '<span class="d-none">'+data+'</span>';
						return html;
					}
				}
			},
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

					if(cutQty == 0 || eaQty == 0) {
						return '0';
					} else {
						//let printPressQty = Math.ceil(ordQty/eaQty);
						let printPressQty = Math.ceil(ordQty/(cutQty*eaQty)) * cutQty;
						return addCommas(printPressQty);
					}
				}
			},
			{ className : 'text-end align-middle', name: 'printPressAndExtraQty', // 정매인쇄통수 + 여분 + 포장단위여분(여분포함통수)
				render : function(data, type, row, meta) {
					let ordQty = parseInt(row['purchaseOrdQty']); // 주문수량(제품)
					let cutQty = parseInt(row['cutQty']); // 절수
					let eaQty = parseInt(row['eaQty']); // 개수
					let extraQty = parseInt(row['extraQty']); // 여유분
					let extraPackQty = parseInt(row['extraPackQty']); // 포장단위여분

					if(cutQty == 0 || eaQty == 0) {
						return '0';
					} else {
						//let printPressQty = Math.ceil(ordQty/eaQty);
						let printPressQty = Math.ceil(ordQty/(cutQty*eaQty)) * cutQty;
						let printPressAndExtraQty = printPressQty + extraQty + (extraPackQty*cutQty);
						
						return addCommas(printPressAndExtraQty);
					}
				}
			},
			{ data: 'extraQty', className : 'text-end align-middle calValue editNode', name: 'extraQty',
				render : function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						return addCommas(parseInt(data));
					} else {
						let html = '';
							html += '<input type="text" class="form-control text-end" onkeyup="numberFormat(this, \'int\')" value="'+parseInt(data)+'">';
							html += '<span class="d-none">'+data+'</span>';
						return html;
					}
				}
			},
			{ data: 'extraPackQty', className : 'text-end align-middle editNode', name: 'extraPackQty',
				render : function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						return addCommas(parseInt(data));
					} else {
						let html = '';
							html += '<input type="text" class="form-control text-end" onkeyup="numberFormat(this, \'int\')" value="0">';
							html += '<span class="d-none">'+data+'</span>';
						return html;
					}
				}
			},
			{ data: 'purchaseDesc', className : 'text-center align-middle editNode', name: 'purchaseDesc',
				render : function(data, type, row, meta) {
					if(row['idx'] != '' && row['idx'] != null) {
						if(data != '' && data != null) {
							let text = isEmptyCheck(data) ? '' : data;
							return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+text+'</div>';
						} else {
							return '';
						}
					} else {
						let text = isEmptyCheck(data) ? '' : data;
						let html = '';
							html += '<input type="text" class="form-control" style="min-width: 100px;" value="'+text+'">';
							html += '<span class="d-none">'+data+'</span>';
						return html;
					}
				}
			},
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
			// { extend: 'excel',	text: 'Excel',	charset: 'UTF-8', bom: true ,
			//	exportOptions: {
	        //        modifier: {
	        //           selected:null
	        //        },	                
	        //    },
	        //},
			// { extend: 'pdf',	text: 'PDF',	},
			// { extend: 'print',	text: 'Print',		charset: 'UTF-8', bom: true },
			// { extend: 'colvis',	text: 'Select Col',	},
		],
		order : [],
		drawCallback: function() {
			let api = this.api();
			
			let htmlHeight = parseFloat($('html').css('height'));
			let rightcolB_height = parseFloat($('#rightcolB').css('height'));
			let theadHeight = parseFloat($('#purchaseOrderAdmTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#purchaseOrderAdmTable_wrapper').find('.dataTables_scrollBody').css('height',(rightcolB_height - theadHeight - 94)+'px');
			
			$('#purchaseOrderAdmTable_filter').addClass('d-none');
			// 통합검색
			$('#searchAllPoa').off('keyup',function() {});
			$('#searchAllPoa').on('keyup',function() {
				$('#purchaseOrderAdmTable_filter').find('input').val($(this).val());
				$('#purchaseOrderAdmTable_filter').find('input').trigger('keyup');
			});

			$('.bootstrapToggle').bootstrapToggle();

			let data = api.data();
			let node = api.rows().nodes();
			if(data.length > 0){
				
				$(node).each(function(index, item) {
					if( purchaseOrderAdmTable.row(item).data().printYn == 'Y' ) {
						$(purchaseOrderAdmTable.row(item).node()).find('.bootstrapToggle').bootstrapToggle('disable');
					}
				});
			}
			
		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#purchaseOrderAdmTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#purchaseOrderAdmTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	purchaseOrderAdmTable.on('column-reorder', function( e, settings, details ) {
		let api = purchaseOrderAdmTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#purchaseOrderAdmTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});

		$('.bootstrapToggle').bootstrapToggle();
	});


	// 발주확정
	$(document).off('change','#purchaseOrderAdmTable .confirmToggle');
	$(document).on('change','#purchaseOrderAdmTable .confirmToggle', function() {
		let type = $(this).data('type');

		if(type == 'confirmOrder'){
			let data = bizOrderDtlTable.row('.selected').data();

			let tableData = purchaseOrderAdmTable.row($(this).parent().parent()).data();
			/*if(data.confirmDesign != 'Y') { // 디자인컨펌이 되어야 추가 가능
				toastr.warning('해당 수주건이 디자인컨펌이 확인되지 않았습니다.');
				purchaseOrderAdmTable.ajax.reload();
				// 수주별발주내역이 존재하지 않을 경우 BOM목록을 불러와 저장할 수 있는 상태로 셋팅
				/* $('#matrlSelectGubun').val('001');
				if(purchaseOrderAdmTable.data().count() == 0 && bizOrderDtlTable.row('.selected').data() != undefined) {
					let dataList = matrlModalSelectTable.data().toArray();
					let addList = [];
					for(var i=0;i<dataList.length;i++) {
						let obj = {};
						obj.idx = '';
						obj.matrlIdx = dataList[i].matrlIdx;
						obj.matrlCd = dataList[i].matrlCd;
						obj.matrlNm = dataList[i].matrlNm;
						obj.paperType = dataList[i].paperType;
						obj.confirmYn = 'N';
						obj.printYn = 'N';
						obj.purchaseOrdNo = '자동채번';
						obj.purchaseOrdQty = ordQtyVal;
						obj.purchaseOrdDate = moment().format('YYYY-MM-DD');
						obj.purchaseInDueDate = moment().format('YYYY-MM-DD');
						if(dataList[i].dealCorpIdx > 0 && dataList[i].dealCorpNm != null){
							obj.dealCorpIdx = dataList[i].dealCorpIdx;
							obj.dealCorpNm = dataList[i].dealCorpNm;
						} else {
							obj.dealCorpIdx = '';
							obj.dealCorpNm = '';
						}
						obj.cutQty = dataList[i].cutQty;
						obj.eaQty = dataList[i].eaQty;
						obj.extraQty = dataList[i].extraQty;
						obj.extraPackQty = '0';
						obj.cutSize = dataList[i].cutSize;
						obj.purchaseNote = '';
						obj.purchaseDesc = '';
						addList.push(obj);
					}
					purchaseOrderAdmTable.rows.add(addList).draw(false);
					$('#purchaseOrderAdmTable_wrapper').find('.filters th').each(function(index, item) {
						$(item).find('input').attr('disabled', true); // 검색 필터 disabled
					});
					purchaseOrderAdmTable.colReorder.disable();
					purchaseOrderAdmTable.draw();

					$('#btnMaterialNew').attr('disabled', false); // DTL 신규 버튼
					$('#btnMaterialSave').attr('disabled', false); // DTL 저장 버튼
					$('#btnMaterialEdit').attr('disabled', true); // DTL 수정 버튼
					$('#btnMaterialDel').attr('disabled', false); // DTL 삭제 버튼
					$('#btnMaterialCancel').attr('disabled', false); // DTL 취소 버튼

					
					
				} else {
					$('#purchaseOrderAdmTable_wrapper').find('.filters th').each(function(index, item) {
						$(item).find('input').attr('disabled', false); // 검색 필터 disabled
					});
					purchaseOrderAdmTable.colReorder.enable();
				} */
				/*return false;
			} */
			if(tableData.printYn == 'Y'){
				toastr.warning('해당 발주서가 출력되어 수정할 수 없습니다.');
				purchaseOrderAdmTable.ajax.reload();
				
				return false;
			}
			let idx = $(this).data('idx');
			let check = $(this).prop('checked');
			let cofirmData = null;
			let stockData = null;
			//발주확정여부 선택한 경우
			if(check){
				cofirmData = 'Y';
			} else {
				stockData = 'N';
				cofirmData = 'N';
			}
			$.ajax({
				url: '<c:url value="/pm/purchaseOrderAdmUpd"/>',
				type: 'POST',
				data: {
					'idx'			:	idx,
					'confirmYn'		:	cofirmData,
					'stockUseYn'	:	stockData,
				},
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
						bizOrdAdmTrId = bizOrderAdmTable.row('.selected').data().idx;
						bizOrderAdmTable.rows('.selected').deselect(); 
						purchaseOrderAdmTable.ajax.reload(function(){},false);
						bizOrderAdmTable.ajax.reload(function(){
							bizOrderAdmTable.row('#'+bizOrdAdmTrId).select();
						},false);
					} else if(res.result == 'fail') {
						toastr.warning(res.message);
						bizOrdAdmTrId = bizOrderAdmTable.row('.selected').data().idx;
						bizOrderAdmTable.rows('.selected').deselect(); 
						purchaseOrderAdmTable.ajax.reload(function(){},false);
						bizOrderAdmTable.ajax.reload(function(){
							bizOrderAdmTable.row('#'+bizOrdAdmTrId).select();
						},false);
					} else {
						toastr.error(res.message);
					}
					$('#my-spinner').hide();
				}
			});
		} else if(type == 'stockUseYn'){
			let idx = $(this).data('idx');
			let check = $(this).prop('checked');
			let cofirmData = null;
			let stockData = null;
			if(check){
				stockData = 'Y';
				cofirmData = 'Y';
			} else {
				stockData = 'N';
				//cofirmData = 'N';
			}

			$.ajax({
				url: '<c:url value="/pm/purchaseOrderAdmUpd"/>',
				type: 'POST',
				data: {
					'idx'			:	idx,
					'confirmYn'		:	cofirmData,
					'stockUseYn'	:	stockData,
				},
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
						bizOrdAdmTrId = bizOrderAdmTable.row('.selected').data().idx;
						bizOrderAdmTable.rows('.selected').deselect(); 
						purchaseOrderAdmTable.ajax.reload(function(){},false);
						bizOrderAdmTable.ajax.reload(function(){
							bizOrderAdmTable.row('#'+bizOrdAdmTrId).select();
						},false);
					} else if(res.result == 'fail') {
						toastr.warning(res.message);
						bizOrdAdmTrId = bizOrderAdmTable.row('.selected').data().idx;
						bizOrderAdmTable.rows('.selected').deselect(); 
						purchaseOrderAdmTable.ajax.reload(function(){},false);
						bizOrderAdmTable.ajax.reload(function(){
							bizOrderAdmTable.row('#'+bizOrdAdmTrId).select();
						},false);
					} else {
						toastr.error(res.message);
					}
					$('#my-spinner').hide();
				}
			});
		}
		
	});

	// 수량 계산
	$(document).on('keyup','.editNode input', function(e) {
		let tr = $(e.target).parent().parent();
		let td = $(tr).find('td');
		let data = purchaseOrderAdmTable.row(td).data();
		//if(data.etc2 != '02'){
			//매입단위가 "통"인 아닌 경우 -> //매입단위가 "연" OR 매입단위 등록안한 경우 -> 계산식 적용해야함
			let ordQty = $(td).eq(purchaseOrderAdmTable.column('purchaseOrdQty:name').index()).html();
			let cutQty = $(td).eq(purchaseOrderAdmTable.column('cutQty:name').index()).find('input').val();
			let eaQty = $(td).eq(purchaseOrderAdmTable.column('eaQty:name').index()).find('input').val();
			let extraQty = $(td).eq(purchaseOrderAdmTable.column('extraQty:name').index()).find('input').val();
			let extraPackQty = $(td).eq(purchaseOrderAdmTable.column('extraPackQty:name').index()).find('input').val();
	
			ordQty = parseInt(ordQty.replaceAll(/,/g,'')); // 주문수량(제품)
			cutQty = parseInt(cutQty.replaceAll(/,/g,'')); // 절수
			eaQty = parseInt(eaQty.replaceAll(/,/g,'')); // 개수
			extraQty = parseInt(extraQty.replaceAll(/,/g,'')); // 여유분
			extraPackQty = parseInt(extraPackQty.replaceAll(/,/g,'')); // 포장단위여분
	
			let cuttingSize = Math.ceil(ordQty/(cutQty*eaQty)); // cuttingSize
			// 이론통수를 구할때 이론 통수는 절수의 배수로 나와야하기때문에 올림된 이론통수값을 절수로 나눈 나머지로 
			// (절수-나머지) + 이론통수 해줘야 이론통수임
			// ↑↑↑↑ 2023.01.02 다시 배수가 아닌 그냥 나누고 올림만 하기로 함
			// ↑↑↑↑ 였는데 2023.01.10에 다시 이론량*절수의 값으로 하기로함
			//let printPressQty = Math.ceil(ordQty/eaQty); // 정매인쇄통수(이론통수)
			let printPressQty = Math.ceil(ordQty/(cutQty*eaQty)) * cutQty;
			let pressQty = Math.ceil((printPressQty + extraQty)/cutQty + extraPackQty); // 통수
			let R = parseInt(cuttingSize / 500); // R로 환산
			let purchaseQty = R + "R" + (cuttingSize % 500); // 발주량 R
			//let finalPurchaseQty = R + "R" + (pressQty % 500); // 최종발주량
			/* 2022.11.09 통수/500해서 R앞에 붙도록 변경 */
			let finalPurchaseQty = parseInt(pressQty/500) + "R" + (pressQty % 500); // 최종발주량
			let printPressAndExtraQty = printPressQty + extraQty + (extraPackQty*cutQty); // 정매인쇄통수 + 여유분 + 포장단위여분
	
			if(cutQty != 0 && eaQty != 0) {
				// $(td).eq(purchaseOrderAdmTable.column('cuttingSize:name').index()).html(addCommas(parseInt(cuttingSize)));
				$(td).eq(purchaseOrderAdmTable.column('printPressQty:name').index()).html(addCommas(parseInt(printPressQty)));
				$(td).eq(purchaseOrderAdmTable.column('printPressAndExtraQty:name').index()).html(addCommas(parseInt(printPressAndExtraQty)));
				// $(td).eq(purchaseOrderAdmTable.column('pressQty:name').index()).html(addCommas(parseInt(pressQty)));
				$(td).eq(purchaseOrderAdmTable.column('purchaseQty:name').index()).html(purchaseQty);
				$(td).eq(purchaseOrderAdmTable.column('finalPurchaseQty:name').index()).html(finalPurchaseQty);
			}
		//}
		
	});

	// 수주별발주 신규버튼 click
	$('#btnMaterialNew').on('click',function(){
   		WM_action_ON('matrlNew', 'workingWarningModal');

   		if(bizOrderDtlTable.row('.selected').data() == undefined) {
			toastr.warning('추가하실 수주상세번호를 선택해주세요.');
			return false;
		}

		
		WM_action_ON('matrlNew','workingWarningModal');
		
		purchaseOrderAdmTable.colReorder.disable();

		$('#btnNew').attr('disabled', false); // 신규 버튼
		$('#btnEdit').attr('disabled', false); // 수정 버튼

		$('#matrlSelectModal').modal('show'); 
   	});
	$('#matrlSelectModal').on('shown.bs.modal', function() {
		matrlModalSelectTable.ajax.reload(function() {
			matrlModalSelectTable.select.style('multi');
			matrlModalSelectTable.select.toggleable(true);
		});
	});

	// 자재 목록 조회
	$('#matrlModalSelectTable thead tr').clone(true).addClass('filters').appendTo('#matrlModalSelectTable thead'); // filter 생성
	let matrlModalSelectTable = $('#matrlModalSelectTable').DataTable({
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
			url : '<c:url value="/bm/matrlInfoLstByItemBom"/>',
			type : 'POST',
			data : {
				itemIdx				:	function() { return itemIdx;},
				matrlSelectGubun	:	function() { return $('#matrlSelectGubun').val();}
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'itemGubunNm', className : 'text-center'},
			{ data: 'matrlCd', className : 'text-center'},
			{ data: 'paperType', className : 'text-center'},//재질
			{ data: 'sizeX', className : 'text-center'},//가로
			{ data: 'sizeY', className : 'text-center'},//세로
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
			let theadHeight = parseFloat($('#matrlModalSelectTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#matrlModalSelectTable_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 223)+'px');
			
			$('#matrlModalSelectTable_filter').addClass('d-none');
			// 통합검색
			//$('#searchAll').off('keyup',function() {});
			//$('#searchAll').on('keyup',function() {
			//	$('#matrlModalSelectTable_filter').find('input').val($(this).val());
			//	$('#matrlModalSelectTable_filter').find('input').trigger('keyup');
			//});
		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#matrlModalSelectTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#matrlModalSelectTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	matrlModalSelectTable.on('column-reorder', function( e, settings, details ) {
		let api = matrlModalSelectTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#matrlModalSelectTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	// 자재목록 조회버튼 click
	$('#btnMatrlSelectReSearch').on('click', function() {
		matrlModalSelectTable.ajax.reload();
	});

	$('#matrlSelectGubun').on('change',function(){
		matrlModalSelectTable.ajax.reload();
	});
	
	// 자재 붙여넣기 버튼 click
	$('#btnMatrlSelectModalPaste').on('click', function() {
		let dataList = matrlModalSelectTable.rows('.selected').data().toArray();

		let col_filter_text = [];
		$('#purchaseOrderAdmTable_wrapper').find('.filters th').each(function(index, item) {
			$(item).find('input').attr('disabled', true); // 검색 필터 disabled
			col_filter_text.push($(item).find('input').val());
		});

		let addList = [];
		for(var i=0;i<dataList.length;i++) {
			let obj = {};
			obj.idx = '';
			obj.matrlIdx = dataList[i].matrlIdx;
			obj.matrlCd = dataList[i].matrlCd;
			obj.matrlNm = dataList[i].matrlNm;
			obj.paperType = dataList[i].paperType;
			obj.confirmYn = 'N';
			obj.printYn = 'N';
			obj.purchaseOrdNo = '자동채번';
			obj.purchaseOrdQty = ordQtyVal - stockUseQtyVal;
			obj.purchaseOrdDate = moment().format('YYYYMMDD');
			obj.purchaseInDueDate = moment().add(3,'d').format('YYYYMMDD');
			if(dataList[i].dealCorpIdx > 0 && dataList[i].dealCorpNm != null){
				obj.dealCorpIdx = dataList[i].dealCorpIdx;
				obj.dealCorpNm = dataList[i].dealCorpNm;
			} else {
				obj.dealCorpIdx = '';
				obj.dealCorpNm = '';
			}
			if( $('#matrlSelectGubun').val() == '001' ) {
				obj.cutQty = dataList[i].cutQty;
				obj.eaQty = dataList[i].eaQty;
				obj.extraQty = dataList[i].extraQty;
				obj.extraPackQty = '0';
				obj.cutSize = dataList[i].cutSize;
			} else {
				obj.cutQty = '0';
				obj.eaQty = '0';
				obj.extraQty = '0';
				obj.extraPackQty = '0';
				obj.cutSize = '';
			}
			
			obj.purchaseNote = '';
			obj.purchaseDesc = dataList[i].etc1;
			addList.push(obj);
		}
		$('#purchaseOrderAdmTable tbody').find('tr').each(function(index_tr, tr) {
			$(tr).find('td').each(function(index_td, td) {
				if($(td).hasClass('editNode') && $(td).find('input').length != 1) {
					if(index_td == purchaseOrderAdmTable.column('purchaseOrdDate:name').index()) { // 발주일자
						let value = purchaseOrderAdmTable.row(tr).data().purchaseOrdDate;
						value = moment(value).format('YYYY-MM-DD');
						$(td).html('<input type="date" max="9999-12-31" class="form-control text-center" value="'+value+'">');
					} else if(index_td == purchaseOrderAdmTable.column('purchaseInDueDate:name').index()) { // 입고예정일
						let value = purchaseOrderAdmTable.row(tr).data().purchaseInDueDate;
						value = moment(value).format('YYYY-MM-DD');
						$(td).html('<input type="date" max="9999-12-31" class="form-control text-center" onkeyup="numberFormat(this, \'int\')" value="'+value+'">');
					} else if(index_td == purchaseOrderAdmTable.column('dealCorpNm:name').index()) { // 발주처
						$(td).find('button').attr('disabled',false);
					} else { // 그 외
						let value = $(td).text();
						if(index_td == purchaseOrderAdmTable.column('cutQty:name').index() ||
						   index_td == purchaseOrderAdmTable.column('eaQty:name').index() ||
						   index_td == purchaseOrderAdmTable.column('extraQty:name').index() ||
						   index_td == purchaseOrderAdmTable.column('extraPackQty:name').index()) { // 절수, 개수, 여분, 포장단위여분
							$(td).html('<input type="text" class="form-control text-end" onkeyup="numberFormat(this, \'int\')" value="'+value+'">');
						} else {
							$(td).html('<input type="text" class="form-control text-center" value="'+value+'">');
						}
					}
				}
			})
		});
		$(purchaseOrderAdmTable.rows().nodes()).find('.bootstrapToggle').bootstrapToggle('disable');
		purchaseOrderAdmTable.rows.add(addList).draw(false);

		$('#btnMaterialCopy').attr('disabled', true);
		$('#btnMaterialSave').attr('disabled', false); // 저장 버튼
		$('#btnMaterialDel').attr('disabled', false); // 삭제 버튼
		$('#btnMaterialCancel').attr('disabled', false); // 취소 버튼
	});

	//수주별발주 저장
	$('#btnMaterialSave').on('click',function(){
		$('#my-spinner').show();
		setTimeout(function(){
			$.ajax({
				url: '<c:url value="/wm/workOrdLstWithPrcssByBizOrdDtlIdx"/>',
	            type: 'POST',
	            async: false,
	            data: {
	                'bodIdx'	:	function(){ return bizOrdDtlIdxVal; }
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if(res.result == 'ok'){
						list = res.data;
					} else if(res.result == 'fail') {
						toastr.warning(res.message);
					} else {
						toastr.error(res.message);
					}
				}
			});
	
			list = _.filter(list, v => v.progressStatus == 'WI' || v.progressStatus == 'WC')
			if(list.length != 0){
				purchaseOrderAdmTable.ajax.reload();
				$('#btnMaterialNew').attr('disabled', false); // DTL 신규 버튼
				$('#btnMaterialSave').attr('disabled', true); // DTL 저장 버튼
				$('#btnMaterialEdit').attr('disabled', false); // DTL 수정 버튼
				$('#btnMaterialDel').attr('disabled', false); // DTL 삭제 버튼
				$('#btnMaterialCancel').attr('disabled', false); // DTL 취소 버튼
				toastr.warning('이미 생산이 진행된 발주는 수정이 불가능합니다.');
				$('#my-spinner').hide();
				return false;
			} 
			$('#my-spinner').show();
			let array = [];
			let state = true;
			$('#purchaseOrderAdmTable tbody').find('tr').each(function(index, item) {
				if($(item).find('td').find('input').length > 3) {
					let td = $(item).find('td');
					let idx = purchaseOrderAdmTable.row($(item)).data().idx;
					let purchaseOrdNo = purchaseOrderAdmTable.row($(item)).data().purchaseOrdNo;
					let purchaseOrdQty = purchaseOrderAdmTable.row($(item)).data().purchaseOrdQty;
					
					//let purchaseOrdDate = $(td).eq(purchaseOrderAdmTable.column('purchaseOrdDate:name').index()).find('input').val();
					//let purchaseInDueDate = $(td).eq(purchaseOrderAdmTable.column('purchaseInDueDate:name').index()).find('input').val();
					let dealCorpIdx = $(td).eq(purchaseOrderAdmTable.column('dealCorpNm:name').index()).find('input[type=hidden]').val();
					let cutQty = $(td).eq(purchaseOrderAdmTable.column('cutQty:name').index()).find('input').val();
					let eaQty = $(td).eq(purchaseOrderAdmTable.column('eaQty:name').index()).find('input').val();
					let extraQty = $(td).eq(purchaseOrderAdmTable.column('extraQty:name').index()).find('input').val();
					let extraPackQty = $(td).eq(purchaseOrderAdmTable.column('extraPackQty:name').index()).find('input').val();
					let purchaseNote = $(td).eq(purchaseOrderAdmTable.column('purchaseNote:name').index()).find('input').val();
					let purchaseDesc = $(td).eq(purchaseOrderAdmTable.column('purchaseDesc:name').index()).find('input').val();

					let ordQty = parseInt(purchaseOrdQty); // 주문수량(제품)
					let cutQtyInt = parseInt(cutQty); // 절수
					let eaQtyInt = parseInt(eaQty); // 개수
					let extraQtyInt = parseInt(extraQty); // 여유분
					
					let printPressQty = Math.ceil(ordQty/eaQtyInt);
					let pressQty = Math.ceil((printPressQty + extraQtyInt)/cutQtyInt);
					
					let R = parseInt(pressQty / 500); // R로 환산
					let finalPressQty = R + "R" + (pressQty % 500);
					

					/*if(purchaseOrdDate == '') {
						toastr.warning('발주일을 선택해주세요.');
						$(td).eq(purchaseOrderAdmTable.column('purchaseOrdDate:name').index()).find('input').focus();
						state = false;
						return false;
					}
					if(purchaseInDueDate == '') {
						toastr.warning('입고예정일을 입력해주세요.');
						$(td).eq(purchaseOrderAdmTable.column('purchaseInDueDate:name').index()).find('input').focus();
						state = false;
						return false;
					}*/
					if(dealCorpIdx == '' || dealCorpIdx == 0) {
						toastr.warning('발주처를 선택해주세요.');
						$(td).eq(purchaseOrderAdmTable.column('dealCorpNm:name').index()).find('button').focus();
						state = false;
						return false;
					}
					if(cutQty == '' || cutQty == '0') {
						toastr.warning('절수를 입력해주세요.');
						$(td).eq(purchaseOrderAdmTable.column('cutQty:name').index()).find('input').focus();
						state = false;
						return false;
					}
					if(eaQty == '' || eaQty == '0') {
						toastr.warning('개수를 입력해주세요.');
						$(td).eq(purchaseOrderAdmTable.column('eaQty:name').index()).find('input').focus();
						state = false;
						return false;
					}

					let obj = new Object();
					obj.idx = idx;
					obj.bizOrdDtlIdx = bizOrdDtlIdxVal;
					//obj.purchaseOrdDate = moment(purchaseOrdDate).format('YYYYMMDD');
					//obj.purchaseInDueDate = moment(purchaseInDueDate).format('YYYYMMDD');
					//obj.purchaseOrdDate = purchaseOrderAdmTable.row($(item)).data().purchaseOrdDate;
					//obj.purchaseInDueDate = purchaseOrderAdmTable.row($(item)).data().purchaseInDueDate;
					obj.purchaseOrdDate = moment(bizOrderAdmTable.row('.selected').data().ordDate).add(1, 'd').format('YYYYMMDD');
					obj.purchaseInDueDate = moment(bizOrderAdmTable.row('.selected').data().ordDate).add(2, 'd').format('YYYYMMDD');
					obj.dealCorpIdx = dealCorpIdx;
					obj.cutQty = cutQty.replaceAll(/,/g,'');
					obj.eaQty = eaQty.replaceAll(/,/g,'');
					obj.extraQty = extraQty.replaceAll(/,/g,'');
					obj.extraPackQty = extraPackQty.replaceAll(/,/g,'');
					obj.purchaseNote = purchaseNote;
					obj.purchaseDesc = purchaseDesc;
					obj.purchaseOrdIdxList = [];
					
					obj.purchaseOrdNo = purchaseOrderAdmTable.row($(item)).data().purchaseOrdNo;
					obj.confirmYn = purchaseOrderAdmTable.row($(item)).data().confirmYn;
					obj.matrlIdx = purchaseOrderAdmTable.row($(item)).data().matrlIdx;
					obj.matrlCd = purchaseOrderAdmTable.row($(item)).data().matrlCd;
					obj.matrlNm = purchaseOrderAdmTable.row($(item)).data().matrlNm;
					obj.paperType = purchaseOrderAdmTable.row($(item)).data().paperType;
					obj.printYn = purchaseOrderAdmTable.row($(item)).data().printYn;
					obj.purchaseOrdQty = purchaseOrdQty;
					obj.regDate = purchaseOrderAdmTable.row($(item)).data().regDate;
					obj.regIdx = purchaseOrderAdmTable.row($(item)).data().regIdx;
					obj.updDate = purchaseOrderAdmTable.row($(item)).data().updDate;
					obj.updIdx = purchaseOrderAdmTable.row($(item)).data().updIdx;
				    
				    array.push(obj);
			    }
			});

			if(!state) {
				$('#my-spinner').hide();
				return false;
			}

			array = _.differenceWith(array, purchaseOrderAdmTable.data().toArray(), _.isEqual);

			$.ajax({
				url: '<c:url value="/bs/bizOrderDtlSel"/>',
	            type: 'POST',
	            async: false,
	            data: {
	                'idx'	:	function(){ return bizOrdDtlIdxVal; }
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if(res.result == 'ok'){
						//if(res.data.confirmDesign == 'Y'){
							if(res.data.bizStopYn == 'N'){
								$.ajax({
									url: '<c:url value="/pm/purchaseOrderAdmUpdCheckByBizOrdDtlIdx"/>',
						            type: 'POST',
						            async: false,
						            data: {
						                'bizOrdDtlIdx'	:	function(){ return bizOrdDtlIdxVal; }
						            },
						            beforeSend: function() {
						            	$('#my-spinner').show();
						            },
									success : function(res) {
										if(res.result == 'ok'){
											$.ajax({
												url: '<c:url value="/pm/purchaseOrderAdmIU"/>',
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
									        
														WM_action_OFF('matrlNew');
														$(purchaseOrderAdmTable.rows().nodes()).find('.bootstrapToggle').bootstrapToggle('enable');
														purchaseOrderAdmTable.clear().draw();
														purchaseOrderAdmTable.ajax.reload(function() {
															$('#purchaseOrderAdmTable_wrapper').find('.filters th').each(function(index, item) {
																$(item).find('input').attr('disabled', false);// 검색 필터 enable
															});
														});
									        
														purchaseOrderAdmTable.colReorder.enable();

														processInfoTable.ajax.reload(function(){
															$('button[name=customerModalBtn]').attr('disabled',true);
															$('button[name=equipModalBtn]').attr('disabled',true);
															$('#processInfoTable tbody tr').each(function(index){
																let node = processInfoTable.row(index).node();
																if(processInfoTable.row(index).data() != undefined && processInfoTable.row(index).data() != ''){
																	let prcssIdx = processInfoTable.row(index).data().prcssIdx;
																	
																	let multipleNode = $(node).find('td').eq(5).find('select[name=workMethodMultiSelect]');
																}
															});
															
															$('#my-spinner').hide();
															$('#btnProcessCopy').attr('disabled',false);
															
															setTimeout(function() {
																processInfoTable.draw(false);
															},100);
														});
												        
														$('#btnMaterialNew').attr('disabled', false); // 신규 버튼
														$('#btnMaterialCopy').attr('disabled', false); // 저장 버튼
														$('#btnMaterialSave').attr('disabled', true); // 저장 버튼
														$('#btnMaterialEdit').attr('disabled', false); // 수정 버튼
														$('#btnMaterialDel').attr('disabled', false); // 삭제 버튼
														$('#btnMaterialCancel').attr('disabled', true); // 취소 버튼
													} else if(res.result == 'fail') {
														toastr.warning(res.message);
													} else {
														toastr.error(res.message);
													}
												}
											});
										} else if(res.result == 'fail') {
											toastr.warning(res.message);
											purchaseOrderAdmTable.ajax.reload();
											$('#btnMaterialNew').attr('disabled', false); // 신규 버튼
											$('#btnMaterialCopy').attr('disabled', false); // 복사
											$('#btnMaterialSave').attr('disabled', true); // 저장 버튼
											$('#btnMaterialEdit').attr('disabled', false); // 수정 버튼
											$('#btnMaterialDel').attr('disabled', false); // 삭제 버튼
											$('#btnMaterialCancel').attr('disabled', true); // 취소 버튼
											WM_action_OFF('matrlNew');
										} else {
											toastr.error(res.message);
										}
						            	$('#my-spinner').hide();
									}
								});
							} else {
								toastr.warning('수주 중지된 경우 수주별발주를<br> 수정/저장할 수 없습니다.');
								$('#my-spinner').hide();
							}
						//} else {
						//	toastr.warning('수주 확정이 안된 경우 수주별발주를<br> 수정/저장할 수 없습니다.');
						//	$('#my-spinner').hide();
						//}				
					} else if(res.result == 'fail') {
						toastr.warning(res.message);
						purchaseOrderAdmTable.ajax.reload();
					} else {
						toastr.error(res.message);
					}
	            	$('#my-spinner').hide();
				}
			});

				
		},100);	
	});

	//자재투입 수정
	$('#btnMaterialEdit').on('click',function(){
		let selectData = bizOrderDtlTable.row('.selected').data();
		//if(selectData.confirmDesign == 'Y' ){
			//if(selectData.stockUseYn != 'Y'){
				let list = [];
				_promise_().then(()=>{
					$('#my-spinner').show();
				}).then(()=>{
					setTimeout(function(){
						$.ajax({
							url: '<c:url value="/pm/purchaseOrderAdmUpdCheckByBizOrdDtlIdx"/>',
				            type: 'POST',
				            async: false,
				            data: {
				                'bizOrdDtlIdx'	:	function(){ return bizOrdDtlIdxVal; }
				            },
				            beforeSend: function() {
				            	$('#my-spinner').show();
				            },
							success : function(res) {
								if(res.result == 'ok'){
									WM_action_ON('matrlNew', 'workingWarningModal');
									
									$('#purchaseOrderAdmTable_wrapper').find('.filters th').each(function(index, item) {
										$(item).find('input').attr('disabled', true); // 검색 필터 disabled
									});

									$(purchaseOrderAdmTable.rows().nodes()).find('.bootstrapToggle').bootstrapToggle('disable');
									
									$('#purchaseOrderAdmTable tbody').find('tr').each(function(index_tr, tr) {
										$(tr).find('td').each(function(index_td, td) {
											if($(td).hasClass('editNode') && $(td).find('input').length != 1) {
												if(index_td == purchaseOrderAdmTable.column('purchaseOrdDate:name').index()) { // 발주일자
													let value = purchaseOrderAdmTable.row(tr).data().purchaseOrdDate;
													value = moment(value).format('YYYY-MM-DD');
													$(td).html('<input type="date" max="9999-12-31" class="form-control text-center" value="'+value+'">');
												} else if(index_td == purchaseOrderAdmTable.column('purchaseInDueDate:name').index()) { // 입고예정일
													let value = purchaseOrderAdmTable.row(tr).data().purchaseInDueDate;
													value = moment(value).format('YYYY-MM-DD');
													$(td).html('<input type="date" max="9999-12-31" class="form-control text-center" onkeyup="numberFormat(this, \'int\')" value="'+value+'">');
												} else if(index_td == purchaseOrderAdmTable.column('dealCorpNm:name').index()) { // 발주처
													$(td).find('button').attr('disabled',false);
												} else { // 그 외
													let value = $(td).text();
													if(index_td == purchaseOrderAdmTable.column('cutQty:name').index() ||
													   index_td == purchaseOrderAdmTable.column('eaQty:name').index() ||
													   index_td == purchaseOrderAdmTable.column('extraQty:name').index() ||
													   index_td == purchaseOrderAdmTable.column('extraPackQty:name').index()) { // 절수, 개수, 여분, 포장단위여분
														$(td).html('<input type="text" class="form-control text-end" onkeyup="numberFormat(this, \'int\')" value="'+value+'">');
													} else {
														$(td).html('<input type="text" class="form-control text-center" value="'+value+'">');
													}
												}
											}
										})
									});
							
									purchaseOrderAdmTable.colReorder.disable();
									purchaseOrderAdmTable.draw();
							
									$('#btnMaterialNew').attr('disabled', false); // DTL 신규 버튼
									$('#btnMaterialSave').attr('disabled', false); // DTL 저장 버튼
									$('#btnMaterialEdit').attr('disabled', true); // DTL 수정 버튼
									$('#btnMaterialDel').attr('disabled', false); // DTL 삭제 버튼
									$('#btnMaterialCancel').attr('disabled', false); // DTL 취소 버튼
								} else if(res.result == 'fail') {
									toastr.warning(res.message);
									purchaseOrderAdmTable.ajax.reload();
									$('#btnMaterialNew').attr('disabled', false); // 신규 버튼
									$('#btnMaterialCopy').attr('disabled', false); // 복사
									$('#btnMaterialSave').attr('disabled', true); // 저장 버튼
									$('#btnMaterialEdit').attr('disabled', false); // 수정 버튼
									$('#btnMaterialDel').attr('disabled', false); // 삭제 버튼
									$('#btnMaterialCancel').attr('disabled', true); // 취소 버튼
									WM_action_OFF('matrlNew');
								} else {
									toastr.error(res.message);
								}
				            	$('#my-spinner').hide();
							}
						});
					},100);
				})
			//} else {
			//	toastr.warning('재고사용인 경우<br>수정할 수 없습니다.');	
			//}
		//} else {
		//	toastr.warning('수주 확정이 안된 경우<br>수정할 수 없습니다.');
		//}
	});
	
	//자재투입 삭제
	$('#btnMaterialDel').on('click',function(){
		if($('#purchaseOrderAdmTable tbody').find('tr.selected').length == 0) {
			toastr.warning('삭제할 항목을 선택해주세요.');
			return false;
		}

		let data = purchaseOrderAdmTable.row('.selected').data();

		if(data.idx != '') {
			$('#deleteModal').modal('show');
			$('#deleteModal').data('deleteType','inputMatrl');
		} else {
			purchaseOrderAdmTable.row('.selected').remove().draw();
		}
	});

	//발주처(자재투입) 목록 조회
	let matrlIdx = '';
	let dealCorpSelectGubun = 'matrlCorp';
	
	//자재투입 발주처 돋보기버튼
	$(document).on('click','.dealCorpModalBtn',function(){
		matrlIdx = purchaseOrderAdmTable.row('.selected').data().matrlIdx; //자재 식별자
		if(matrlIdx == '' || matrlIdx == null || matrlIdx == "null"){
			matrlIdx = 0;
		}
		dealCorpModalGubun = 'inputMat';
		$('#dealCorpModal').modal('show');
		setTimeout(function() {
			dealCorpModalTable.ajax.reload(function() {});
		}, 200);
		/* $('#dealCorpSelectGubun').val('matrlCorp');
		dealCorpSelectGubun = $('#dealCorpSelectGubun').val();
		$('#dealCorpSelectModal').modal('show');
		setTimeout(function() {
			dealCorpSelectModalTable.ajax.reload(function() {});
		}, 200);	 */
	});

	//자재투입 발주처 조회
	/* $('#btnDealCorpSelectSearch').on('click',function(){
		dealCorpSelectGubun = $('#dealCorpSelectGubun').val();
		dealCorpSelectModalTable.ajax.reload();
	});
	$('#dealCorpSelectGubun').on('change',function(){
		dealCorpSelectGubun = $('#dealCorpSelectGubun').val();
		dealCorpSelectModalTable.ajax.reload();
	});

	//자재투입 발주처 붙여넣기
	$('#btnDealCorpSelectModalPaste').on('click',function(){
		if(!$('#dealCorpSelectModalTable tbody tr').hasClass('selected')){
			toastr.warning('붙여넣을 행을 선택해주세요.');
			return false;
		}
		let node = purchaseOrderAdmTable.row('.selected').node();
		let nodeData = purchaseOrderAdmTable.row('.selected').data();
		let selectNodeModalData = dealCorpSelectModalTable.row('.selected').data();
		$(node).find('td').eq(purchaseOrderAdmTable.column('dealCorpNm:name').index()).find('input[type=hidden]').val(selectNodeModalData.idx);			//발주처 식별자
		$(node).find('td').eq(purchaseOrderAdmTable.column('dealCorpNm:name').index()).find('input[type=text]').val(selectNodeModalData.dealCorpNm);		//발주처 이름
		$('#dealCorpSelectModal').modal('hide');
	}); */

	//X버튼 눌렀을 때
	$(document).on('click','.nameDel',function(){
		/* prev-이전요소(name을 가르키는 input이어야함),next-다음요소(idx를 가르키는 hidden input이어야함) */
		if($(this).prev().hasClass('inputNm')){
			$(this).prev().val('');
		}
		//공정정보에 설비정보 지울 때 데이터테이블 값도 지워주기
		if($(this).hasClass('equipNm')){
				processInfoTable.row($(this).val()).data().equipIdx = null;
		}
		//수주별발주에 자재명을 지울 때
		if($(this).hasClass('matrlNm')){

			let node = purchaseOrderAdmTable.row($(this).val()).node();
			let data = purchaseOrderAdmTable.row($(this).val()).data();

			data.matrlIdx = null;
			data.matrlCd = null;
			data.matrlNm = null;
			data.paperType = null;
			data.sizeX = null;
			data.sizeY = null;
			
			let matrlCdIdx = purchaseOrderAdmTable.column('matrlCd:name').index();
			let paperTypeIdx = purchaseOrderAdmTable.column('paperType:name').index();
			let sizeXIdx = purchaseOrderAdmTable.column('sizeX:name').index();
			let sizeYIdx = purchaseOrderAdmTable.column('sizeY:name').index();
			let matrlNoteIdx = purchaseOrderAdmTable.column('matrlNote:name').index();

			$(node).find('td').eq(matrlCdIdx).find('div').text('');						//자재코드
			$(node).find('td').eq(paperTypeIdx).find('div').text(''); 				//재질?지질?
			$(node).find('td').eq(sizeXIdx).find('div').text('');						//장(가로)
			$(node).find('td').eq(sizeYIdx).find('div').text('');						//폭(세로)
			$(node).find('td').eq(matrlNoteIdx).find('div').text('');					//참고사항
		}
		//자재에 발주처 
		if($(this).hasClass('dealCorpNm')){
			let data = purchaseOrderAdmTable.row($(this).val()).data();
			let node = purchaseOrderAdmTable.row($(this).val()).node();
			data.dealCorpIdx = null;
			let dealCorpNmIdx = purchaseOrderAdmTable.column('dealCorpNm:name').index();
			//$(node).find('td').eq(dealCorpNmIdx).find('button[name=dealCorpModalBtn]').val('');//발주처 돋보기버튼에 자재식별자 넣어두기
			$(node).find('td').eq(dealCorpNmIdx).find('input[type=hidden]').val('');	//발주처 식별자
			data.dealCorpNm = null;
		}
		
		if($(this).next().hasClass('inputIdx')){
			$(this).next().val('');
		}
	});
	
	/* 취소 처리 */
	let CancelIdx = '';
	// 취소 버튼 click
	$('#btnProcessCancel').on('click', function() {
		CancelIdx = 'prcssNew';
		$('#cancelModal').modal('show');
	});
	$('#btnMaterialCancel').on('click', function() {
		$('#cancelModal').modal('show');
		$('#cancelModal').data('cancelType', 'ADM');
		CancelIdx = 'matrlNew';
		$('#cancelModal').modal('show');
	});

	// 사업장정보 조회
	function getWorkplaceLst(sVal) {
		let result = [];
		$.ajax({
			url : '<c:url value="/sm/workplaceLst"/>',
			type : 'POST',
			async : false,
			data : {
				'useYnCd' : function() { return '001'; }
			},
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					let data = res.data;
					result = data;
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});

		let html = '';
		if(sVal != '' && sVal != null) { // 시작값이 있을 경우
			html += '<select class="form-select w-auto" ><option value="">선택</option>';
		} else {
			html += '<select class="form-select w-auto" selected><option value="">선택</option>';
		}
		for(let i=0;i<result.length;i++) {
			let data = result[i];
			if(sVal != '' && sVal != null && sVal != 0) { // 시작값이 있을 경우
				if(data.idx == sVal) {
					html += '<option value="' + data.idx + '" selected>'+data.workplaceNm+'</option>';
				} else {
					html += '<option value="' + data.idx + '" >'+data.workplaceNm+'</option>';
				}
			} else { // 시작값이 있을 경우
				if(data.mainYn == 'Y') {
					html += '<option value="' + data.idx + '" selected>'+data.workplaceNm+'</option>';
				} else {
					html += '<option value="' + data.idx + '" >'+data.workplaceNm+'</option>';
				}
			}
		}
			html += '</select>';
		return html;
	}
	function workPlaceSelectBoxAppend(sVal){
		let html = '';
		if(sVal != '' && sVal != null) { // 시작값이 있을 경우
			html += '<select class="form-select w-auto" ><option value="">선택</option>';
		} else {
			html += '<select class="form-select w-auto" selected><option value="">선택</option>';
		}
		for(let i=0;i<workPlaceList.length;i++) {
			let data = workPlaceList[i];
			if(sVal != '' && sVal != null && sVal != 0) { // 시작값이 있을 경우
				if(data.idx == sVal) {
					html += '<option value="' + data.idx + '" selected>'+data.workplaceNm+'</option>';
				} else {
					html += '<option value="' + data.idx + '" >'+data.workplaceNm+'</option>';
				}
			} else { // 시작값이 있을 경우
				if(data.mainYn == 'Y') {
					html += '<option value="' + data.idx + '" selected>'+data.workplaceNm+'</option>';
				} else {
					html += '<option value="' + data.idx + '" >'+data.workplaceNm+'</option>';
				}
			}
		}
			html += '</select>';
		return html;
	}
	
	//작업계획확정 클릭
	$('#btnWorkOrdConfirm').on('click',function(){
		let data = bizOrderDtlTable.row('.selected').data().idx;

		$.ajax({
			url: '<c:url value="/bs/bizOrderWorkOrderCheckList"/>',
            type: 'POST',
            data: {
                'bizOrdDtlIdx'			:	function(){ return bizOrdDtlIdxVal; },
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					let data = res.data;
					//등록된 작업지시가 없을 경우 작업지시 등록해주기
					if(data.length == 0){
						$.ajax({
							url: '<c:url value="/bs/bizOrderWorkOrderInsert"/>',
				            type: 'POST',
				            data: {
				                'bizOrdDtlIdx'	:	function(){ return bizOrdDtlIdxVal; },
				                'itemIdx'		:	function(){ return itemIdx; },
				            },
				            beforeSend: function() {
				            	$('#my-spinner').show();
				            },
							success : function(res) {
								if (res.result == "ok") { //응답결과
									toastr.success('작업계획확정 되었습니다.');
									bizOrdDtlIdxVal = bizOrderDtlTable.row('.selected').data().idx;
									bizOrderDtlTable.rows('.selected').deselect();
									bizOrderDtlTable.ajax.reload(function(){
										bizOrderDtlTable.row('#'+bizOrdDtlIdxVal).select();
										$(bizOrderDtlTable.row('#'+bizOrdDtlIdxVal).node()).trigger('click'); 
									},false);
								} else if(res.result == 'fail') {
									toastr.warning(res.message);
								} else {
									toastr.error(res.message);
								}
								$('#my-spinner').hide();
							}
						});
					} else if(data.length != 0){
						// 진행, 완료 상태가 있는 리스트
						let filterList = _.filter(data,v => v.progressStatus == 'WI' || v.progressStatus == 'WC');
						//진행,완료된 공정이 있는경우 -> 등록불가 , 없는 경우 등록가능 
						if(filterList.length > 0){
							toastr.warning('진행된 공정이 있어 작업계획확정이 불가능합니다.');
						} else if(filterList.length == 0){
							$('#workOrderModal').modal('show');
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

	$('#btnWorkOrderModalY').on('click',function(){
		$.ajax({
			url: '<c:url value="/bs/bizOrderWorkOrderInsert"/>',
            type: 'POST',
            data: {
                'bizOrdDtlIdx'	:	function(){ return bizOrdDtlIdxVal; },
                'itemIdx'		:	function(){ return itemIdx; },
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					toastr.success('작업계획확정 되었습니다.');
					bizOrdDtlIdxVal = bizOrderDtlTable.row('.selected').data().idx;
					bizOrderDtlTable.rows('.selected').deselect();
					bizOrderDtlTable.ajax.reload(function(){
						bizOrderDtlTable.row('#'+bizOrdDtlIdxVal).select();
						$(bizOrderDtlTable.row('#'+bizOrdDtlIdxVal).node()).trigger('click'); 
					},false);
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
	});

	//작업계획취소 클릭
	$('#btnWorkOrdDel').on('click',function(){
		let bizOrdDtlIdx = bizOrderDtlTable.row('.selected').data().idx;

		$.ajax({
			url: '<c:url value="/bs/bizOrderWorkOrderDelete"/>',
            type: 'POST',
            data: {
                'bizOrdDtlIdx'	:	function(){ return bizOrdDtlIdx; }
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if(res.result == 'ok'){
					//if(res.data.resultYn == 'Y'){
						toastr.success('작업계획취소 되었습니다.');
						bizOrdDtlIdxVal = bizOrderDtlTable.row('.selected').data().idx;
						bizOrderDtlTable.rows('.selected').deselect();
						bizOrderDtlTable.ajax.reload(function(){
							bizOrderDtlTable.row('#'+bizOrdDtlIdxVal).select();
							$(bizOrderDtlTable.row('#'+bizOrdDtlIdxVal).node()).trigger('click'); 
						},false);
					//} else {
					//	toastr.warning('진행이 된 공정은 삭제가 불가능합니다.');
					//	processInfoTable.ajax.reload(function(){
			
					//		$('#my-spinner').hide();
					//		setTimeout(function() {
					//			processInfoTable.draw(false);
					//		},100);
					//	});
					//}
					
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
	});

	/********************* 수주취소 *********************/
	$('#btnBizDtlCancel').on('click',function(){
		$('#bizDtlCancelModal').modal('show');
	});

	$('#btnBizDtlCancelY').on('click',function(){
		$.ajax({
			url: '<c:url value="/bs/bizOrderDtlCancel"/>',
            type: 'POST',
            data: {
                'bizOrdDtlIdx'	:	function(){ return bizOrderDtlTable.row('.selected').data().idx; },
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					toastr.success('수주 취소 되었습니다.');
					bizOrdAdmTrId = bizOrderAdmTable.row('.selected').data().idx; 
					let idx = bizOrderDtlTable.row('.selected').data().idx;
					
					bizOrderAdmTable.rows('.selected').deselect();
					bizOrderAdmTable.ajax.reload(function(){
						bizOrderAdmTable.row('#'+bizOrdAdmTrId).select();
						//$(bizOrderAdmTable.row('#'+bizOrdAdmTrId).node()).trigger('click'); 
					},false);
					
					
					bizOrderDtlTable.row('.selected').deselect();
					bizOrderDtlTable.ajax.reload(function(){
						setTimeout(function(){
							bizOrderDtlTable.row('#'+idx).select();
							$(bizOrderDtlTable.row('#'+idx).node()).trigger('click');
							},20);
					},false);
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
					bizOrderDtlTable.row('.selected').deselect();
					bizOrderDtlTable.ajax.reload(function(){},false);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
	});

	/********************* po완료 *********************/
	$('#btnBizDtlPoEnd').on('click',function(){
		$('#bizDtlPoEndModal').modal('show');
	});

	$('#btnBizDtlPoEndY').on('click',function(){
		$.ajax({
			url: '<c:url value="/bs/bizOrderDtlPoEnd"/>',
            type: 'POST',
            data: {
                'bizOrdDtlIdx'	:	function(){ return bizOrderDtlTable.row('.selected').data().idx; },
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					toastr.success('PO 완료 되었습니다.');
					bizOrdAdmTrId = bizOrderAdmTable.row('.selected').data().idx; 
					let idx = bizOrderDtlTable.row('.selected').data().idx;
					bizOrderDtlTable.row('.selected').deselect();

					bizOrderAdmTable.rows('.selected').deselect();
					bizOrderAdmTable.ajax.reload(function(){
						bizOrderAdmTable.row('#'+bizOrdAdmTrId).select();
						//$(bizOrderAdmTable.row('#'+bizOrdAdmTrId).node()).trigger('click'); 
					},false);
					
					bizOrderDtlTable.ajax.reload(function(){
						setTimeout(function(){
							bizOrderDtlTable.row('#'+idx).select();
							$(bizOrderDtlTable.row('#'+idx).node()).trigger('click');
							},20);
					},false);
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
					bizOrderDtlTable.row('.selected').deselect();
					bizOrderDtlTable.ajax.reload(function(){},false);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
	});

	/***************************** 번들링 *****************************/
	// 번들링 목록조회
	$('#bundleInfoTable thead tr').clone(true).addClass('filters').appendTo('#bundleInfoTable thead'); // filter 생성
	let bundleInfoTable = $('#bundleInfoTable').DataTable({
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
		select: {
            style: 'single',
            toggleable: false,
            items: 'row',
            info: false
        },
        ajax : {
			url : '<c:url value="/bs/bizOrderDtlBundleList"/>',
			type : 'POST',
			data : {
				'bizOrdDtlIdx'	: function(){ return bizOrdDtlIdxVal; },
			},
		}, 
        rowId: 'idx',
		columns : [
			{ data: 'itemCd', className : 'text-center', name : 'itemCd',
				render: function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div><input type="hidden" name="itemIdx" value="'+row['itemIdx']+'">';
					} else {
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;"></div>';
					}
				}
			},//품목코드
			{ data: 'itemNm', className : 'text-center', name : 'itemNm',
				render: function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;"></div>';
					}
				}
			},//품목명
			{ data: 'stock', className : 'text-end', name : 'stock',
				render: function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseInt(data))+'</div>';
					} else {
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">0</div>';
					}
				}
			},//현재고
			{ data: 'inputQty', className : 'text-end', name : 'inputQty',
				render: function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseInt(data))+'</div>';
					} else {
						return '<input type="text" class="form-control text-end" name="inputQty" onkeyup="numberFormat(this, \'int\')" value="0">';
					}
				}
			},//투입수량
			{ data: 'bizOrdDtlNo', className : 'text-center', name : 'bizOrdDtlNo',
				render: function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '';
					}
				}
			},//수주상세번호
			{ data: 'bundleDesc', className : 'text-center', name : 'bundleDesc',
				render: function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '<input type="text" class="form-control text-start" name="bundleDesc">';
					}
				}
			},//비고
		],
		columnDefs : [
			{
				/*targets: '_all',
				render: function(data) {
					return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
				}*/
			}
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
			let theadHeight = parseFloat($('#bundleInfoTable_wrapper').find('.dataTables_scrollHead').css('height'));
			let baseTableHeight = parseFloat($('#rightcolB').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(((baseTableHeight)) - theadHeight - 94)+'px');
			$('#'+table_id+'_wrapper').find('.dataTables_scrollHeadInner').css('width','100%');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAllBit').off('keyup',function() {});
			$('#searchAllBit').on('keyup',function() {
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
				let cell = $('#bundleInfoTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#bundleInfoTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});

			$('#' + table_id + '_wrapper').find('.dataTables_scrollHeadInner').find('table').css('width','100%');
		},
	});
	// dataTable colReorder event
	bundleInfoTable.on('column-reorder', function( e, settings, details ) {
		let api = bundleInfoTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#bundleInfoTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	$('#tab6Nav').on('click',function(){
		$('#my-spinner').show();
		bundleInfoTable.ajax.reload(function(){
			bundleInfoTable.columns.adjust();
			$('#my-spinner').hide();
		});
	});

	//번들링 등록
	$('#btnBundleNew').on('click',function(){
		$('#itemCodeModal').modal('show');
		itemCodeModalTable.select.style('multi');
		itemCodeModalTable.select.toggleable(true);
		itemCodeModalTable.rows('.selected').deselect();
		setTimeout(function() {
			itemCodeModalTable.ajax.reload(function() {});
		},200);
	});

	//번들링 복사
	$('#btnBundleCopy').on('click',function(){
		$.ajax({
			url: '<c:url value="/bs/bizOrderDtlBundleCopy"/>',
            type: 'POST',
            //async: false,
            data: {
                'bizOrdDtlIdx' : 	bizOrdDtlIdxVal,
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					toastr.success('번들링 정보를 가져왔습니다.');
					/*bundleInfoTable.ajax.reload(function(){
						bundleInfoTable.columns.adjust();
						$('#my-spinner').hide();
					});*/
					WM_action_OFF('bundleNew');
					//bundleInfoTable.ajax.reload(function(){});
					bizOrdDtlIdxVal = bizOrderDtlTable.row('.selected').data().idx;
					bizOrderDtlTable.rows('.selected').deselect();
					bizOrderDtlTable.ajax.reload(function(){
						bizOrderDtlTable.row('#'+bizOrdDtlIdxVal).select();
						$(bizOrderDtlTable.row('#'+bizOrdDtlIdxVal).node()).trigger('click');
						$('#my-spinner').hide(); 
					},false);
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
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

		let dataList = itemCodeModalTable.rows('.selected').data().toArray();
		let addList = [];
		for(var i=0;i<dataList.length;i++) {
			//이미 추가된 자재일 경우
			if( bundleInfoTable.data().toArray().find(v => v.itemDtlIdx == dataList[i].idx) ){
				toastr.warning(dataList[i].itemNm+'<br>은(는) 이미 추가된 제품입니다');
				return false;
			}
			let obj = {};
			obj.idx = null;
			obj.bizOrdDtlIdx = bizOrdDtlIdxVal;
			obj.bizOrdDtlNo = '자동기입';
			obj.itemIdx = dataList[i].idx;
			obj.itemCd = dataList[i].itemCd;
			obj.itemNm = dataList[i].itemNm;
			obj.stock = dataList[i].stock;
			addList.push(obj);
		}
		
		$('#bundleInfoTable tbody').find('tr').each(function(index_tr, tr) {
			$(tr).find('td').each(function(index_td, td) {
				if(index_td == bundleInfoTable.column('inputQty:name').index()) { //투입수량
					let value = bundleInfoTable.row(tr).data().inputQty != null && bundleInfoTable.row(tr).data().inputQty != '' ? bundleInfoTable.row(tr).data().inputQty : 0;
					value = addCommas(parseInt(value));
					$(td).html('<input type="text" class="form-control text-end" name="inputQty" onkeyup="numberFormat(this, \'int\')" value="'+value+'">');
				}/*  else if(index_td == bundleInfoTable.column('bizOrdDtlNo:name').index()) { //투입수량
					let value = isEmptyCheck(bundleInfoTable.row(tr).data().bizOrdDtlNo) ? '' : bundleInfoTable.row(tr).data().bizOrdDtlNo;
					$(td).html('<input type="text" class="form-control text-start" name="bizOrdDtlNo" value="'+value+'">');
				}  */else if(index_td == bundleInfoTable.column('bundleDesc:name').index()) { //투입수량
					let value = isEmptyCheck(bundleInfoTable.row(tr).data().bundleDesc) ? '' : bundleInfoTable.row(tr).data().bundleDesc;
					$(td).html('<input type="text" class="form-control text-start" name="bundleDesc" value="">');
				}
			});
		}); 
		
		
		bundleInfoTable.rows.add(addList).draw(false);
		WM_action_ON('bundleNew', 'workingWarningModal');

		$('#btnBundleNew').attr('disabled',false);
		$('#btnBundleSave').attr('disabled',false);
		$('#btnBundleEdit').attr('disabled',false);
		$('#btnBundleDel').attr('disabled',false);
		$('#btnBundleCancel').attr('disabled',false);

	
		
		$('#itemCodeModal').modal('hide');
	});

	$('#btnBundleSave').on('click',function(){
		let insertList = [];
		let state = true;
		$('#bundleInfoTable tbody').find('tr').each(function(index, item) {
			let td = $(item).find('td');
			let data = bundleInfoTable.row($(item)).data();
			let node = bundleInfoTable.row($(item)).node();

			//col index
			let itemCdCol = bundleInfoTable.column('itemCd:name').index();//제품코드
			let inputQtyCol = bundleInfoTable.column('inputQty:name').index();//투입수량
			let bizOrdDtlNoCol = bundleInfoTable.column('bizOrdDtlNo:name').index();//수주상세번호
			let bundleDescCol = bundleInfoTable.column('bundleDesc:name').index();//비고

			//col value
			let itemIdxVal = $(node).find('td').eq(itemCdCol).find('input[type=hidden]').val();
			let inputQtyVal = $(node).find('td').eq(inputQtyCol).find('input[name=inputQty]').val();
			//let bizOrdDtlNoVal = $(node).find('td').eq(bizOrdDtlNoCol).find('input[name=bizOrdDtlNo]').val().trim();
			let bizOrdDtlNoVal = '';
			let bundleDescVal = $(node).find('td').eq(bundleDescCol).find('input[name=bundleDesc]').val();

			/* if(inputQtyVal == '' || inputQtyVal == '0'){
				toastr.warning('투입수량을 입력해주세요.');
				$(node).find('td').eq(inputQtyCol).find('input[name=inputQty]').focus();
				state = false;
				return false;
			} */
			
			let obj = {};
			obj.idx = data.idx;
			obj.bizOrdDtlIdx = data.bizOrdDtlIdx;
			obj.itemIdx = itemIdxVal;
			obj.inputQty = parseInt(removeCommas(inputQtyVal));
			obj.bizOrdDtlNo = bizOrdDtlNoVal;
			obj.bundleDesc = bundleDescVal;
			insertList.push(obj);	
		});

		//원본데이터
		let tableData = [];
		for(var i=0;i<bundleInfoTable.data().count();i++) {
			let obj = {};

			let data = bundleInfoTable.row(i).data();

			obj.idx = data.idx;
			obj.bizOrdDtlIdx = data.bizOrdDtlIdx;
			obj.itemAdmIdx = data.itemIdx;
			obj.inputQty = parseInt(data.inputQty);
			obj.bizOrdDtlNo = data.bizOrdDtlNo;
			obj.bundleDesc = data.bundleDesc;
			
			tableData.push(obj);
		}
		
		insertList = _.differenceWith(insertList, tableData, _.isEqual);
		if(state){
			$.ajax({
				url: '<c:url value="/bs/bizOrderDtlBundleIns"/>',
	            type: 'POST',
	            data: {
	                'insertList'	:	function(){ return JSON.stringify(insertList); },
	                'bizOrdDtlIdx'	:	function(){ return bizOrdDtlIdxVal;},                 
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if(res.result == 'ok'){
						WM_action_OFF('bundleNew');
						//bundleInfoTable.ajax.reload(function(){});
						bizOrdDtlIdxVal = bizOrderDtlTable.row('.selected').data().idx;
						bizOrderDtlTable.rows('.selected').deselect();
						bizOrderDtlTable.ajax.reload(function(){
							toastr.success('저장되었습니다.');
							bizOrderDtlTable.row('#'+bizOrdDtlIdxVal).select();
							$(bizOrderDtlTable.row('#'+bizOrdDtlIdxVal).node()).trigger('click');
							$('#my-spinner').hide(); 
						},false);
						$('#btnBundleNew').attr('disabled',false);
						$('#btnBundleSave').attr('disabled',true);
						$('#btnBundleEdit').attr('disabled',false);
						$('#btnBundleDel').attr('disabled',false);
						$('#btnBundleCancel').attr('disabled',true);
					} else if(res.result == 'fail') {
						toastr.warning(res.message);
						$('#my-spinner').hide();
					} else {
						toastr.error(res.message);
						$('#my-spinner').hide();
					}
				}
			});
		}
	});	

	$('#btnBundleEdit').on('click',function(){
		WM_action_ON('bundleNew', 'workingWarningModal');

		$('#btnBundleNew').attr('disabled',false);
		$('#btnBundleSave').attr('disabled',false);
		$('#btnBundleEdit').attr('disabled',true);
		$('#btnBundleDel').attr('disabled',false);
		$('#btnBundleCancel').attr('disabled',false);
		
		$('#bundleInfoTable tbody').find('tr').each(function(index_tr, tr) {
			$(tr).find('td').each(function(index_td, td) {
				if(index_td == bundleInfoTable.column('inputQty:name').index()) { //투입수량
					let value = bundleInfoTable.row(tr).data().inputQty != null && bundleInfoTable.row(tr).data().inputQty != '' ? bundleInfoTable.row(tr).data().inputQty : 0;
					value = addCommas(parseInt(value));
					$(td).html('<input type="text" class="form-control text-end" name="inputQty" onkeyup="numberFormat(this, \'int\')" value="'+value+'">');
				}/*  else if(index_td == bundleInfoTable.column('bizOrdDtlNo:name').index()) { //투입수량
					let value = isEmptyCheck(bundleInfoTable.row(tr).data().bizOrdDtlNo) ? '' : bundleInfoTable.row(tr).data().bizOrdDtlNo;
					$(td).html('<input type="text" class="form-control text-start" name="bizOrdDtlNo" value="'+value+'">');
				}  */else if(index_td == bundleInfoTable.column('bundleDesc:name').index()) { //투입수량
					let value = isEmptyCheck(bundleInfoTable.row(tr).data().bundleDesc) ? '' : bundleInfoTable.row(tr).data().bundleDesc;
					$(td).html('<input type="text" class="form-control text-start" name="bundleDesc" value="">');
				}
			});
		});
		
	});

	//번들 삭제
	$('#btnBundleDel').on('click',function(){
		
		if(!$('#bundleInfoTable tbody tr').hasClass('selected')){
			toastr.warning('삭제할 항목을 선택해주세요.');
			return false;
		}

		let idx = bundleInfoTable.row('.selected').data().idx;
		if(idx != '' && idx != undefined){
			$('#deleteModal').data('deleteType','bundle');
			$('#deleteModal').modal('show');
		} else {
			$('#bundleInfoTable').DataTable().row('.selected').remove().draw();
		}
		
	});

	//번들취소
	$('#btnBundleCancel').on('click',function(){
		CancelIdx = 'bundle';
		$('#cancelModal').modal('show');
	});

	$(document).on('keyup','input[name=inputQty]',function(){
		$('input[name=inputQty]').val($(this).val());
	});

	/* $(document).on('blur', 'input[name=outReqDate]', function(){
		let data = $(this).val();
		if( moment(data).format('YYYYMMDD') < moment().format('YYYYMMDD') ){
			toastr.warning('금일보다 이전 날짜는<br>입력할 수 없습니다.');
			$(this).val(moment().format('YYYY-MM-DD'));
		}
	}); */

	$('#purchaseViewer').on('dblclick',function(){
		let idx = bizOrderAdmTable.row('.selected').data().idx;
		let data = bizOrderAdmSel(idx);
		if( !isEmptyCheck(data.purchaseUuid) && !isEmptyCheck(data.purchaseExt) ){
			//파일 blob로 불러오는곳
			let fileObject = new Object();
			fileObject.uuid = data.purchaseUuid;
			fileObject.ext = data.purchaseExt;
			let blob = getFileBlob(fileObject);
			$('#modalPurchaseViewer').attr('src','data:image/jpeg;base64,'+blob);
			$('#modalPurchaseTag').attr('href','/serverFile/' + data.purchaseUuid + '.' + data.purchaseExt);
			$('#modalPurchaseTag').text(data.purchaseFileName);
		} else {
			$('#modalPurchaseViewer').attr('src','');
			$('#modalPurchaseTag').attr('href','');
			$('#modalPurchaseTag').text('')
		}
		$('#purchaseViewerModal').modal('show');
		$('#purchaseViewerModal').css('left','0').css('top','0');
		$('#purchaseViewerModal').draggable({handle: ".modal-header"});
	});
	
	function base64ToArrayBuffer(base64) {
        const binaryString = window.atob(base64); // Comment this if not using base64
        const bytes = new Uint8Array(binaryString.length);
        return bytes.map((byte, i) => binaryString.charCodeAt(i));
   	}

	$('.monthAdjustButton').on('click',function(){
		let adjustVal = $(this).data('val');

		let startDateVal = $('#startDate').val();
		let endDateVal = $('#endDate').val();

		if( adjustVal != '' ){			
			$('#startDate').val(moment(endDateVal).subtract('M', adjustVal).format('YYYY-MM-DD'));
		}
	});

	/**************** 작업지시서 인쇄 ****************/
	// 초기 셋팅
	$(document).ready(function() {
		//작업지시서
		$('#trAppendTarget').after(makeEmptyTr());
		cssChange();
		$('#workOrderReportTable').removeClass('d-none');

		//신규/수정 관리 내역서
		$('#trNewEditHistoryAppendTarget').after(makeEmptyTrWithNewEditHistory());
		cssChangeWithNewEditHistory();
		$('#newEditHistoryTable').removeClass('d-none');

		//번들링 지시서
		$('#trBundlingOrderAppendTarget').after(makeEmptyTrWithBundlingOrder());
		commonCssChange('bundlingOrderTable');
		$('#bundlingOrderTable').removeClass('d-none');
		$('#my-spinner').hide();
		
	});

	function makeEmptyTr(){
		let html = '';
		html += '<tr style="page-break-before: always!important;">';
		html += '		<td class="bd-n h-30" colspan="30">';
		html += '</tr>';
		html += '';

		html += '<tr>';
		html += '	<td colspan="18" class="bd-n"></td>';
		html += '	<td colspan="10" class="fs-30 fw900 bd2px text-center bt-n bl-n br-n"></td>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td class="bd-n h-90" colspan="30">';
		html += '</tr>';
		
		html += '<tr>';
		html += '	<td class="bd-n h-10" colspan="30">';
		html += '</tr>';

		html += '<tr>';
		html += '	<td class="bd-n h-10" colspan="30">';
		html += '</tr>';
		
		html += '<tr>';
		html += '	<td colspan="18" class="bd-n"></td>';
		//html += '	<td colspan="3" class="fs-13 text-start bt-n bl-n br-n">발행일 :</td>';
		html += '	<td colspan="3" class="fs-13 fc-blue text-start bt-n bl-n br-n fw-bold" name="printDate"></td>';
		html += '	<td colspan="4" class="bd-n"></td>';
		//html += '	<td colspan="4" class="fs-13 text-start bt-n bl-n br-n">제조관리번호 :</td>';
		html += '	<td colspan="3" class="fs-13 fc-blue text-start bt-n bl-n br-n fw-bold" name="bizOrdDtlNo"></td>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td class="bd-n h-15" colspan="30">';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="18" class="bd-n"></td>';
		//html += '	<td colspan="3" class="fs-13 text-start bt-n bl-n br-n">Client:</td>';
		html += '	<td colspan="7" class="fs-13 text-start bt-n bl-n br-n fc-blue fw-bold" name="bizOrdDealCorpNm"></td>';
		//html += '	<td colspan="3" class="fs-13 text-start bt-n bl-n br-n">발주번호:</td>';
		html += '	<td colspan="3" class="fs-13 fc-red text-start bt-n bl-n br-n fw-bold" name="purchaseOrdNo"></td>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';

		/* html += '<tr>';
		html += '	<td class="bd-n h-10" colspan="30">';
		html += '</tr>';
		 */
		html += '<tr>';
		html += '	<td colspan="18" class="bd-n"></td>';
		//html += '	<td colspan="3" class="fs-13 text-start bt-n bl-n br-n">Project:</td>';
		html += '	<td colspan="10" class="fs-13 fc-blue text-start bt-n bl-n br-n fw-bold" name="itemNm"></td>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';
		html += '<tr>';
		html += '	<td colspan="18" class="bd-n"></td>';
		//html += '	<td colspan="3" class="fs-13 text-start bt-n bl-n br-n">Quantity:</td>';
		html += '	<td colspan="7" class="fs-13 fc-blue text-start bt-n bl-n br-n fw-bold" name="bizOrdQty"></td>';
		//html += '	<td colspan="4" class="fs-13 text-start bt-n bl-n br-n">Revision No.:</td>';
		html += '	<td colspan="5" class="fs-13 fc-blue text-start bt-n bl-n br-n fw-bold" name="itemVersion"></td>';
		//html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';
		html += '<tr>';
		html += '	<td colspan="19" class="bd-n"></td>';
		//html += '	<td colspan="5" class="fs-13 text-start bt-n bl-n br-n">Working Deadline :</td>';
		html += '	<td colspan="7" class="fs-13 text-start bt-n bl-n br-n fw-bold" name="workDeadline"></td>';
		//html += '	<td colspan="5" class="fs-13 text-start bt-n bl-n br-n">Delivery Deadline :</td>';
		html += '	<td colspan="2" class="fs-13 fc-red text-start bt-n bl-n br-n fw-bold" name="ordEndDate"></td>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';
		
		html += '<tr>';
		html += '	<td class="bd-n h-25" colspan="30">';
		html += '</tr>';

		html += '<tr>';
		html += '	<td class="bd-n h-20" colspan="30">';
		html += '</tr>';

		//html += '<tr>';
		//html += '	<td colspan="1" class="bd-n"></td>';
		//html += '	<td colspan="26" class="fs-13 text-start bt-n bl-n br-n">Specification</td>';
		//html += '	<td colspan="2" class="fs-13 fc-blue text-start bt-n bl-n br-n"></td>';
		//html += '	<td colspan="1" class="bd-n"></td>';
		//html += '</tr>';
		html += '<tr>';
		html += '	<td colspan="18" class="bd-n"></td>';
		//html += '	<td colspan="3" class="fs-13 text-start bt-n bl-n br-n">Paper:</td>';
		html += '	<td colspan="10" class="fs-13 fc-blue text-start bt-n bl-n br-n fw-bold" name="paperType"></td>';
		//html += '	<td colspan="4" class="fs-13 text-start bt-n bl-n br-n">Cutting Size :</td>';
		html += '	<td colspan="2" class="fs-13 fc-blue text-start bt-n bl-n br-n" name="cutSize"></td>';		
		//html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';
		html += '<tr>';
		html += '	<td colspan="18" class="bd-n"></td>';
		//html += '	<td colspan="3" class="fs-13 text-start bt-n bl-n br-n">Fixed Sheet:</td>';
		html += '	<td colspan="5" class="fs-13 fc-blue text-start bt-n bl-n br-n" name="fixedSheet"></td>';
		//html += '	<td colspan="3" class="fs-13 text-start bt-n bl-n br-n">No. Sheet :</td>';
		html += '	<td colspan="5" class="fs-13 fc-blue text-start bt-n bl-n br-n" name="noSheet"></td>';
		//html += '	<td colspan="3" class="fs-13 text-start bt-n bl-n br-n">Ex. Sheet :</td>';
		html += '	<td colspan="2" class="fs-13 fc-blue text-start bt-n bl-n br-n" name="exSheet"></td>';
		//html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';
		html += '<tr>';
		html += '	<td colspan="18" class="bd-n"></td>';
		//html += '	<td colspan="3" class="fs-13 text-start bt-n bl-n br-n">Work Sheet:</td>';
		html += '	<td colspan="6" class="fs-13 fc-red text-start bt-n bl-n br-n" name="workSheet"></td>';
		//html += '	<td colspan="3" class="fs-13 text-start bt-n bl-n br-n">+Add.Sheet:</td>';
		html += '	<td colspan="3" class="fs-13 fc-blue text-start bt-n bl-n br-n"></td>';
		//html += '	<td colspan="4" class="fs-13 text-start bt-n bl-n br-n">+Add.Reason:</td>';
		html += '	<td colspan="1" class="fs-13 fc-blue text-start bt-n bl-n br-n"></td>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';
		html += '<tr>';
		html += '	<td colspan="18" class="bd-n"></td>';
		//html += '	<td colspan="3" class="fs-13 text-start bt-n bl-n br-n">Notice:</td>';
		html += '	<td colspan="10" class="fs-13 h-20 fc-red text-start bt-n bl-n br-n">';
		html += '	<textarea rows="2" name="notice" class="form-control text-start p-0 fw-bold fc-red"'; 
		html += '		style="resize: none; overflow: hidden;font-size:16px!important;line-height:1;';
		html += '		border: none !important; width:100%;"></textarea>'; 
		html +=	'	</td>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td class="bd-n h-30" colspan="30">';
		html += '</tr>';
		
		html += '<tr>';
		html += '	<td colspan="18" class="bd-n"></td>';
	//	html += '	<td colspan="3" class="fs-13 text-start bt-n bl-n br-n">착인유무 :</td>';
		html += '	<td colspan="4" class="align-bottom fs-13 fw-bold fc-red text-start bt-n bl-n br-n" name="printingYnCheck"></td>';
		//html += '	<td colspan="3" class="fs-13 text-start bt-n bl-n br-n">Size :</td>';
		html += '	<td colspan="5" class="align-bottom fs-13 fw-bold fc-blue text-start bt-n bl-n br-n" name="itemSize"></td>';
		//html += '	<td colspan="3" class="fs-13 text-start bt-n bl-n br-n">칼끝규격 :</td>';
		html += '	<td colspan="3" class="align-bottom fs-13 fw-bold fc-red text-start bt-n bl-n br-n" name="knifeTipSize"></td>';
		//html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="18" class="bd-n"></td>';
		//html += '	<td colspan="3" class="fs-13 text-start bt-n bl-n br-n">Color :</td>';
		html += '	<td colspan="10" class="align-middle fs-13 fw-bold fc-blue text-start bt-n bl-n br-n" name="itemColor"></td>';
		//html += '	<td colspan="6" class="fs-13 text-start bt-n bl-n br-n">Printing Machine :</td>';
		html += '	<td colspan="2" class="align-middle fs-13 fc-blue text-start bt-n bl-n br-n" name="etc1Nm"></td>';
		//html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';
		
		html += '<tr>';
		html += '	<td colspan="18" class="bd-n"></td>';
		//html += '	<td colspan="3" class="fs-13 text-start bt-n bl-n br-n">Coating :</td>';
		html += '	<td colspan="5" class="align-middle fs-13 fc-blue text-start bt-n bl-n br-n" name="coatingMethod"></td>';
		//html += '	<td colspan="3" class="fs-13 text-start bt-n bl-n br-n">검수방법 :</td>';
		html += '	<td colspan="7" class="align-middle fs-13 fw-bold fc-red text-start bt-n bl-n br-n" name="inspectMethodNm"></td>';
		//html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';
		
		html += '<tr>';
		html += '	<td colspan="18" class="bd-n"></td>';
		//html += '	<td colspan="3" class="fs-13 text-start bt-n bl-n br-n">코팅판 No. :</td>';
		html += '	<td colspan="4" class="align-middle fs-13 fc-blue text-start bt-n bl-n br-n" style="min-height:20px;max-height:20px;height:20px;" name="resinBoardNm"></td>';
		//html += '	<td colspan="3" class="fs-13 text-start bt-n bl-n br-n">Foil :</td>';
		html += '	<td colspan="6" class="align-middle fs-13 fc-blue text-start bt-n bl-n br-n" name="foil"></td>';
		//html += '	<td colspan="5" class="fs-13 text-start bt-n bl-n br-n">Wooden Patter No.</td>';
		html += '	<td colspan="2" class="align-middle fs-13 fc-blue text-start bt-n bl-n br-n" name="woodenCareNm"></td>';
		//html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="18" class="bd-n"></td>';
		//html += '	<td colspan="4" class="fs-13 text-start bt-n bl-n br-n">후가공판 No. :</td>';
		html += '	<td colspan="4" class="align-middle fs-13 fc-blue text-start bt-n bl-n br-n" style="min-height:20px;max-height:20px;height:20px;" name="etc2Cd"></td>';
		//html += '	<td colspan="3" class="fs-13 text-start bt-n bl-n br-n">Embo :</td>';
		html += '	<td colspan="5" class="align-middle fs-13 fc-blue text-start bt-n bl-n br-n" name="etc6"></td>';
		//html += '	<td colspan="3" class="fs-13 text-start bt-n bl-n br-n">타공판No.</td>';
		html += '	<td colspan="3" class="align-middle fs-13 fc-blue text-start bt-n bl-n br-n" name="holeWoodenCd"></td>';
		//html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';
		
		html += '<tr>';
		html += '	<td colspan="18" class="bd-n"></td>';
		//html += '	<td colspan="3" class="fs-13 text-start bt-n bl-n br-n">Remark</td>';
		html += '	<td colspan="10" class="align-middle h-20 fs-13 fc-red text-start bt-n bl-n br-n">';
		html += '	<textarea rows="4" name="ordIssue" class="form-control text-start p-0 fc-red"'; 
		html += '		style="resize: none; overflow: hidden;font-size:16px!important;';
		html += '		border: none !important; width:100%;"></textarea>'; 
		html += '	</td>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';
		
		html += '<tr>';
		html += '	<td class="bd-n h-20" colspan="30">';
		html += '</tr>';
		
		//html += '<tr>';
		//html += '	<td colspan="1" class="bd-n"></td>';
		//html += '	<td colspan="4" class="fs-13 text-center">Delivery Date</td>';
		//html += '	<td colspan="3" class="fs-13 text-center">포장단위</td>';
		//html += '	<td colspan="3" class="fs-13 text-center">성형방식</td>';
		//html += '	<td colspan="5" class="fs-13 text-center">성형내용</td>';
		//html += '	<td colspan="5" class="fs-13 text-center">묶음법</td>';
		//html += '	<td colspan="4" class="fs-13 text-center">묶음단위</td>';
		//html += '	<td colspan="4" class="fs-13 text-center">포장방법</td>';
		//html += '	<td colspan="1" class="bd-n"></td>';
		//html += '</tr>';
		
		html += '<tr>';
		html += '	<td class="bd-n h-24" colspan="30">';
		html += '</tr>';
		
		html += '<tr>';
		html += '	<td colspan="18" class="bd-n"></td>';
		//html += '	<td colspan="2" class="h-20 fs-13 text-start bd-n"></td>';
		html += '	<td colspan="2" class="fs-13 fc-blue text-center align-middle bd-n" name="packUnit"></td>';
		html += '	<td colspan="2" class="fs-13 fc-blue text-start align-middle bd-n" name="moldingMethod"></td>';
		html += '	<td colspan="2" class="fs-13 fc-blue text-center align-middle bd-n" name="moldingContents"></td>';
		html += '	<td colspan="3" class="real-fs-13 fc-blue text-center align-middle bd-n" style="white-space: nowrap!important; text-overflow: ellipsis!important; overflow: hidden!important;" name="bundleMethodNm"></td>';
		html += '	<td colspan="1" class="fs-13 fc-blue text-end align-middle bd-n padding-right" name="bundleUnit"></td>';
		html += '	<td colspan="2" class="real-fs-13 fc-blue text-center align-middle bd-n" name="packMethodNm"></td>';
		//html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';

		 html += '<tr>';
		html += '	<td class="bd-n h-25" colspan="30">';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="18" class="bd-n"></td>';
		//html += '	<td colspan="3" class="h-20 fs-13 text-center bd-n"></td>';
		html += '	<td colspan="10" class="fs-13 fc-blue text-start bd-n" name="packUnit"></td>';

		html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>'; 
		return html;
	}

	function makeEmptyTrWithNewEditHistory(){
		let html = '';
		html += '<tr style="page-break-before: always!important;">';
		html += '		<td class="bd-n h-25" colspan="30">';
		html += '</tr>';
		html += '';

		html += '<tr>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '	<td colspan="7" class="text-center max-h55 h-55 bd-n align-middle bt-n bl-n br-n" style="border-width: 0px 0px 2px !important; border-style: solid !important; border-color: rgb(255, 255, 255) rgb(255, 255, 255) black !important; border-image: initial !important; padding: 0.1rem !important; color: rgb(0, 0, 0) !important; height: 55px !important;">			<img src="/resources/assets/images/header_logo.png" style="width:100%;height:100%;"></td>';
		html += '	<td colspan="12" class="fs-25 fw900 bd-n align-middle text-center bt-n bl-n br-n">신규/수정 관리 내역서</td>';
		html += '	<td colspan="7" class="bd-n"></td>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '	<td colspan="2" class="fs-13 fw-bold text-start bt-n bl-n br-n">DATE :</td>';
		html += '	<td colspan="4" class="fs-13 fw-bold text-start bt-n bl-n br-n" name="printDate"></td>';
		html += '	<td colspan="14" class="bd-n"></td>';
		html += '	<td colspan="2" class="fs-13 fw-bold text-start bl-n br-n bt-n">No.:</td>';
		html += '	<td colspan="4" class="fs-13 fw-bold text-start bl-n br-n bt-n" name="bizOrdDtlNo"></td>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';


		html += '<tr>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '	<td colspan="3" class="fs-13 fw-bold text-start bt-n bl-n br-n">Client:</td>';
		html += '	<td colspan="23" class="fs-13 fw-bold text-start bt-n bl-n br-n " name="bizOrdDealCorpNm"></td>';
		//html += '	<td colspan="3" class="fs-13 text-start bt-n bl-n br-n">발주번호:</td>';
		//html += '	<td colspan="5" class="fs-13 fc-red text-start bt-n bl-n br-n" name="purchaseOrdNo"></td>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';
		html += '<tr>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '	<td colspan="3" class="fs-13 fw-bold text-start bt-n bl-n br-n">Project:</td>';
		html += '	<td colspan="23" class="fs-13 fw-bold text-start bt-n bl-n br-n" name="itemNm"></td>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';
		html += '<tr>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '	<td colspan="3" class="fs-13 fw-bold text-start bt-n bl-n br-n">Quantity:</td>';
		html += '	<td colspan="9" class="fs-13 fw-bold text-start bt-n bl-n br-n" name="bizOrdQty"></td>';
		html += '	<td colspan="4" class="fs-13 fw-bold text-start bt-n bl-n br-n">Revision No.:</td>';
		html += '	<td colspan="10" class="fs-13 fw-bold text-start bt-n bl-n br-n" name="itemVersion"></td>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';
		html += '<tr>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '	<td colspan="5" class="fs-13 fw-bold text-start bt-n bl-n br-n">Working Deadline :</td>';
		html += '	<td colspan="7" class="fs-13 fw-bold text-start bt-n bl-n br-n" name="workDeadline"></td>';
		html += '	<td colspan="5" class="fs-13 fw-bold text-start bt-n bl-n br-n">Delivery Deadline :</td>';
		html += '	<td colspan="9" class="fs-13 fw-bold fc-red text-start bt-n bl-n br-n" name="ordEndDate"></td>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';
		
		html += '<tr>';
		html += '	<td class="bd-n h-10" colspan="30">';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '	<td colspan="26" class="fs-13 fw-bold text-start bt-n bl-n br-n">Specification</td>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';
		html += '<tr>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '	<td colspan="3" class="fs-13 fw-bold text-start bt-n bl-n br-n">Paper:</td>';
		html += '	<td colspan="9" class="fs-13 fw-bold text-start bt-n bl-n br-n" name="paperType"></td>';
		html += '	<td colspan="4" class="fs-13 fw-bold text-start bt-n bl-n br-n">Cutting Size :</td>';
		html += '	<td colspan="10" class="fs-13 fw-bold text-start bt-n bl-n br-n" name="cutSize"></td>';	
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';
		html += '<tr>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '	<td colspan="3" class="fs-13 fw-bold text-start bt-n bl-n br-n">Fixed Sheet:</td>';
		html += '	<td colspan="9" class="fs-13 fw-bold text-start bt-n bl-n br-n" name="fixedSheet"></td>';
		html += '	<td colspan="3" class="fs-13 fw-bold text-start bt-n bl-n br-n">No. Sheet :</td>';
		html += '	<td colspan="4" class="fs-13 fw-bold text-start bt-n bl-n br-n" name="noSheet"></td>';
		html += '	<td colspan="3" class="fs-13 fw-bold text-start bt-n bl-n br-n">Ex. Sheet :</td>';
		html += '	<td colspan="4" class="fs-13 fw-bold text-start bt-n bl-n br-n" name="exSheet"></td>'; 
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';
		html += '<tr>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '	<td colspan="3" class="fs-13 fw-bold text-start bt-n bl-n br-n">Work Sheet:</td>';
		html += '	<td colspan="9" class="fs-13 fw-bold text-start bt-n bl-n br-n" name="workSheet"></td>';
		html += '	<td colspan="3" class="fs-13 fw-bold text-start bt-n bl-n br-n">+Add.Sheet:</td>';
		html += '	<td colspan="11" class="fs-13 fw-bold text-start bt-n bl-n br-n"></td>';
	 	html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>'; 
		html += '<tr>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '	<td colspan="3" class="fs-13 fw-bold align-middle text-start bt-n bl-n br-n">Notice :</td>';
		html += '	<td colspan="23" class="fs-13 fw-bold h-20 fc-red text-start bt-n bl-n br-n">';
		html += '	<textarea rows="2" name="notice" class="form-control text-start p-0 fs-13 fc-red"'; 
		html += '		style="resize: none; overflow: hidden;';
		html += '		border: none !important; width:100%;font-weight:bold;"></textarea>'; 
		html +=	'	</td>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>'; 
		
		html += '<tr>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '	<td colspan="3" class="fs-13 fw-bold text-start bt-n bl-n br-n">착인유무 :</td>';
		html += '	<td colspan="4" class="fs-13 fw-bold fc-red text-start bt-n bl-n br-n" name="printingYnCheck"></td>';
		html += '	<td colspan="3" class="fs-13 fw-bold text-start bt-n bl-n br-n">Size :</td>';
		html += '	<td colspan="7" class="fs-13 fw-bold text-start bt-n bl-n br-n" name="itemSize"></td>';
		html += '	<td colspan="3" class="fs-13 fw-bold text-start bt-n bl-n br-n">칼끝규격 :</td>';
		html += '	<td colspan="6" class="fs-13 fw-bold fc-red text-start bt-n bl-n br-n" name="knifeTipSize"></td>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '	<td colspan="3" class="fs-13 fw-bold text-start bt-n bl-n br-n">Color :</td>';
		html += '	<td colspan="14" class="fs-13 fw-bold fc-blue text-start bt-n bl-n br-n" name="itemColor"></td>';
		html += '	<td colspan="6" class="fs-13 fw-bold text-start bt-n bl-n br-n">Printing Machine :</td>';
		html += '	<td colspan="3" class="fs-13 fw-bold fc-blue text-start bt-n bl-n br-n" name="etc1Nm"></td>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';
		
		html += '<tr>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '	<td colspan="3" class="fs-13 fw-bold text-start bt-n bl-n br-n">Coating :</td>';
		html += '	<td colspan="9" class="fs-13 fw-bold text-start bt-n bl-n br-n" name="coatingMethod"></td>';
		html += '	<td colspan="3" class="fs-13 fw-bold text-start bt-n bl-n br-n">검수방법 :</td>';
		html += '	<td colspan="11" class="fs-13 fw-bold fc-blue text-start bt-n bl-n br-n" name="inspectMethodNm"></td>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';
		
		html += '<tr>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '	<td colspan="3" class="fs-13 fw-bold text-start bt-n bl-n br-n">코팅판 No. :</td>';
		html += '	<td colspan="4" class="fs-13 fw-bold fc-blue text-start bt-n bl-n br-n" name="resinBoardNm"></td>';
		html += '	<td colspan="3" class="fs-13 fw-bold text-start bt-n bl-n br-n">Foil :</td>';
		html += '	<td colspan="7" class="fs-13 fw-bold fc-blue text-start bt-n bl-n br-n" name="foil"></td>';
		html += '	<td colspan="6" class="fs-13 fw-bold text-start bt-n bl-n br-n">Wooden Patter No.</td>';
		html += '	<td colspan="3" class="fs-13 fw-bold text-start bt-n bl-n br-n" name="woodenCareNm"></td>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';
		
		html += '<tr>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '	<td colspan="4" class="fs-13 fw-bold text-start bt-n bl-n br-n">후가공판 No. :</td>';
		html += '	<td colspan="3" class="fs-13 fw-bold text-start bt-n bl-n br-n" name="etc2Cd"></td>';
		html += '	<td colspan="3" class="fs-13 fw-bold text-start bt-n bl-n br-n">Embo :</td>';
		html += '	<td colspan="7" class="fs-13 fw-bold fc-blue text-start bt-n bl-n br-n" name="etc6"></td>';
		html += '	<td colspan="3" class="fs-13 fw-bold text-start bt-n bl-n br-n">타공판No.</td>';
		html += '	<td colspan="6" class="fs-13 fw-bold fc-blue text-start bt-n bl-n br-n" name="holeWoodenCd"></td>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';
		
		html += '<tr>';
		html += '	<td class="bd-n h-20" colspan="30">';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '	<td colspan="1" class="fs-13 fw-bold text-start bb-n br-n"></td>';
		html += '	<td colspan="25" class="fs-13 fw-bold text-start bb-n bl-n">관리내역 및 특이사항 : </td>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';
		
		html += '<tr>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '	<td colspan="2" class="fs-13 fw-bold text-start bt-n br-n"></td>';
		html += '	<td colspan="24" class="h-20  fw-bold fs-13 fc-red text-start bt-n bl-n">';
		html += '	<textarea rows="20" name="ordIssue" class="form-control text-start p-0 fs-13 fc-red"'; 
		html += '		style="resize: none; overflow: hidden;';
		html += '		border: none !important; width:100%;font-weight:bold;"></textarea>'; 
		html += '	</td>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';
		
		html += '<tr>';
		html += '	<td class="bd-n h-5" colspan="30">';
		html += '</tr>';

		
		html += '<tr>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '	<td colspan="4" class="fs-13 fw-bold text-center">Delivery Date</td>';
		html += '	<td colspan="4" class="fs-13 fw-bold text-center">포장단위/BOX</td>';
		html += '	<td colspan="3" class="fs-13 fw-bold text-center">성형방식</td>';
		html += '	<td colspan="4" class="fs-13 fw-bold text-center">성형내용</td>';
		html += '	<td colspan="4" class="fs-13 fw-bold text-center">묶음법</td>';
		html += '	<td colspan="3" class="fs-13 fw-bold text-center">묶음단위</td>';
		html += '	<td colspan="4" class="fs-13 fw-bold text-center">포장방법</td>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';
		html += '<tr>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '	<td colspan="4" class="h-20 fs-13 text-center"></td>';
		html += '	<td colspan="4" class="fs-11 fw-bold text-center" name="packUnit"></td>';
		html += '	<td colspan="3" class="fs-11 fw-bold text-center" name="moldingMethod"></td>';
		html += '	<td colspan="4" class="fs-11 fw-bold text-center" name="moldingContents"></td>';
		html += '	<td colspan="4" class="fs-11 fw-bold text-center" name="bundleMethodNm"></td>';
		html += '	<td colspan="3" class="fs-11 fw-bold text-center" name="bundleUnit"></td>';
		html += '	<td colspan="4" class="fs-11 fw-bold text-center" name="packMethodNm"></td>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td class="bd-n h-5" colspan="30">';
		html += '</tr>';
		
		html += '<tr>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '	<td colspan="4" class="fs-13 fw-bold text-center">담당</td>';
		html += '	<td colspan="4" class="fs-13 fw-bold text-center"></td>';
		html += '	<td colspan="5" class="fs-13 fw-bold text-center">제조관리 책임자</td>';
		html += '	<td colspan="4" class="fs-13 fw-bold text-center"></td>';
		html += '	<td colspan="5" class="fs-13 fw-bold text-center">QA</td>';
		html += '	<td colspan="4" class="fs-13 fw-bold text-center"></td>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';
		
		html += '<tr>';
		html += '	<td class="bd-n h-40" colspan="30">';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '	<td colspan="26" class="fs-13 fw-bold bd-n text-start">문서번호 : 신규/수정관리내역서 20230701-02</td>';
		html += '	<td colspan="2" class="bd-n"></td>';
		html += '</tr>';  
		return html;
	}
	function makeEmptyTrWithBundlingOrder(){
		let html = '';
		
		html += '<tr style="page-break-before: always!important;">';
		html += '		<td class="bd-n h-20" colspan="30">';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="28" class="fs-25 fw900 bd-n align-middle text-center bt-n bl-n br-n">Bundling(조립/해체/재조립)지시서 및 기록서</td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';
		
		html += '<tr>';
		html += '	<td colspan="1" rowspan="2" class="bd-n"></td>';
		html += '	<td colspan="8" rowspan="2" class="text-center max-h55 h-55 bd-n align-middle bt-n bl-n br-n" style="border-width: 0px 0px 2px !important; border-style: solid !important; border-color: rgb(255, 255, 255) rgb(255, 255, 255) black !important; border-image: initial !important; padding: 0.1rem !important; color: rgb(0, 0, 0) !important; height: 55px !important;"><img src="/resources/assets/images/header_logo.png" style="width:100%;height:100%;"></td>';
		html += '	<td colspan="13" rowspan="2" class="bd-n"></td>';
		html += '	<td colspan="3" class="fs-13 bt-n bl-n br-n text-start align-middle">DATE</td>';
		html += '	<td colspan="4" class="fs-13 bt-n bl-n br-n text-start align-middle" name="printDate"></td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="3" class="fs-13 bt-n bl-n br-n text-start align-middle">No.:</td>';
		html += '	<td colspan="4" class="fs-13 bt-n bl-n br-n text-start align-middle" name="bizOrdDtlNo"></td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="3" class="fs-13 text-start bt-n bl-n br-n fw-bold">Client :</td>';
		html += '	<td colspan="25" class="fs-13 text-start bt-n bl-n br-n fw-bold" name="bizOrdDealCorpNm"></td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="3" class="fs-13 text-start bt-n bl-n br-n fw-bold">Project :</td>';
		html += '	<td colspan="25" class="fs-13 text-start bt-n bl-n br-n fw-bold" name="itemNm"></td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="3" class="fs-13 text-start bt-n bl-n br-n fw-bold">Quantity :</td>';
		html += '	<td colspan="14" class="fs-13 text-start bt-n bl-n br-n fw-bold" name="bizOrdQty"></td>';
		html += '	<td colspan="6" class="fs-13 text-start bt-n bl-n br-n fw-bold">Delivery deadline :</td>';
		html += '	<td colspan="5" class="fs-13 text-start bt-n bl-n br-n fw-bold" name="ordEndDate"></td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td class="bd-n h-5" colspan="30">';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td class="bd-n" colspan="29" class="fs-13 text-start">1. 공정대상 자재 내역</td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="11" class="fs-13 text-center align-middle bb-n">자재명</td>';
		html += '	<td colspan="2" class="fs-10 text-center align-middle bb-n">제조<br>번호</td>';
		html += '	<td colspan="7" class="fs-13 text-center align-middle bb-n">Revision No</td>'; 
		html += '	<td colspan="2" class="fs-13 text-center align-middle bb-n">인수량</td>'; 
		html += '	<td colspan="2" class="fs-13 text-center align-middle bb-n">인계자</td>';
		html += '	<td colspan="2" class="fs-13 text-center align-middle bb-n">인수자</td>';
		html += '	<td colspan="2" class="fs-13 text-center align-middle bb-n">비고</td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';

		for(var i = 0; i < 5; i++ ){
			if( i < 4 ) {
				html += '<tr>';
				html += '	<td colspan="1" class="bd-n"></td>';
				html += '	<td colspan="11" class="fs-10 text-center align-middle bb-n h-25" name="bundleItemNm"></td>';
				html += '	<td colspan="2" class="fs-10 text-center align-middle bb-n h-25" name="bundleBizOrdNo"></td>';
				html += '	<td colspan="3" class="fs-10 text-center align-middle bb-n h-25" name="bundleItemCustomerItemCd"></td>'; 
				html += '	<td colspan="4" class="fs-10 text-center align-middle bb-n h-25" name="bundleItemVersion"></td>'; 
				html += '	<td colspan="2" class="fs-13 text-center align-middle bb-n h-25"></td>'; 
				html += '	<td colspan="2" class="fs-13 text-center align-middle bb-n h-25"></td>';
				html += '	<td colspan="2" class="fs-13 text-center align-middle bb-n h-25"></td>';
				html += '	<td colspan="2" class="fs-13 text-center align-middle bb-n h-25"></td>';
				html += '	<td colspan="1" class="bd-n"></td>';
				html += '</tr>';
			} else {
				html += '<tr>';
				html += '	<td colspan="1" class="bd-n"></td>';
				html += '	<td colspan="11" class="fs-10 text-center align-middle h-25" name="bundleItemNm"></td>';
				html += '	<td colspan="2" class="fs-10 text-center align-middle h-25" name="bundleBizOrdNo"></td>';
				html += '	<td colspan="3" class="fs-10 text-center align-middle h-25" name="bundleItemCustomerItemCd"></td>'; 
				html += '	<td colspan="4" class="fs-10 text-center align-middle h-25" name="bundleItemVersion"></td>'; 
				html += '	<td colspan="2" class="fs-13 text-center align-middle h-25"></td>'; 
				html += '	<td colspan="2" class="fs-13 text-center align-middle h-25"></td>';
				html += '	<td colspan="2" class="fs-13 text-center align-middle h-25"></td>';
				html += '	<td colspan="2" class="fs-13 text-center align-middle h-25"></td>';
				html += '	<td colspan="1" class="bd-n"></td>';
				html += '</tr>';
			}
		}

		html += '<tr>';
		html += '	<td class="bd-n h-5" colspan="30">';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td class="bd-n" colspan="29" class="fs-13 text-start">2. 공정전 점검항목</td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="8" class="fs-13 text-center align-middle bb-n">점검항목</td>';
		html += '	<td colspan="4" class="fs-13 text-center align-middle bb-n">점검결과</td>';
		html += '	<td colspan="4" class="fs-13 text-center align-middle bb-n">조치내용</td>';
		html += '	<td colspan="5" class="fs-13 text-center align-middle bb-n">점검일자</td>';
		html += '	<td colspan="4" class="fs-13 text-center align-middle bb-n">확인자</td>';
		html += '	<td colspan="3" class="fs-13 text-center align-middle bb-n">비고</td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="8" class="fs-13 text-center align-middle bb-n">Line Clearance</td>';
		html += '	<td colspan="2" class="fs-13 text-center align-middle bb-n">적합</td>';
		html += '	<td colspan="2" class="fs-13 text-center align-middle bb-n">부적합</td>';
		html += '	<td colspan="4" class="fs-13 text-center align-middle bb-n"></td>';
		html += '	<td colspan="5" class="fs-13 text-center align-middle bb-n"></td>';
		html += '	<td colspan="4" class="fs-13 text-center align-middle bb-n"></td>';
		html += '	<td colspan="3" class="fs-13 text-center align-middle bb-n"></td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';
		
		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="8" class="fs-13 text-center align-middle bb-n">Revision No. Check</td>';
		html += '	<td colspan="2" class="fs-13 text-center align-middle bb-n">적합</td>';
		html += '	<td colspan="2" class="fs-13 text-center align-middle bb-n">부적합</td>';
		html += '	<td colspan="4" class="fs-13 text-center align-middle bb-n"></td>';
		html += '	<td colspan="5" class="fs-13 text-center align-middle bb-n"></td>';
		html += '	<td colspan="4" class="fs-13 text-center align-middle bb-n"></td>';
		html += '	<td colspan="3" class="fs-13 text-center align-middle bb-n"></td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="8" class="fs-13 text-center align-middle bb-n">Pharmacode. Check</td>';
		html += '	<td colspan="2" class="fs-13 text-center align-middle bb-n">적합</td>';
		html += '	<td colspan="2" class="fs-13 text-center align-middle bb-n">부적합</td>';
		html += '	<td colspan="4" class="fs-13 text-center align-middle bb-n"></td>';
		html += '	<td colspan="5" class="fs-13 text-center align-middle bb-n"></td>';
		html += '	<td colspan="4" class="fs-13 text-center align-middle bb-n"></td>';
		html += '	<td colspan="3" class="fs-13 text-center align-middle bb-n"></td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="8" class="fs-13 text-center align-middle bb-n">밴딩기 가동상태</td>';
		html += '	<td colspan="2" class="fs-13 text-center align-middle bb-n">적합</td>';
		html += '	<td colspan="2" class="fs-13 text-center align-middle bb-n">부적합</td>';
		html += '	<td colspan="4" class="fs-13 text-center align-middle bb-n"></td>';
		html += '	<td colspan="5" class="fs-13 text-center align-middle bb-n"></td>';
		html += '	<td colspan="4" class="fs-13 text-center align-middle bb-n"></td>';
		html += '	<td colspan="3" class="fs-13 text-center align-middle bb-n"></td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="8" class="fs-13 text-center align-middle">작업장 청결상태</td>';
		html += '	<td colspan="2" class="fs-13 text-center align-middle">적합</td>';
		html += '	<td colspan="2" class="fs-13 text-center align-middle">부적합</td>';
		html += '	<td colspan="4" class="fs-13 text-center align-middle"></td>';
		html += '	<td colspan="5" class="fs-13 text-center align-middle"></td>';
		html += '	<td colspan="4" class="fs-13 text-center align-middle"></td>';
		html += '	<td colspan="3" class="fs-13 text-center align-middle"></td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';


		html += '<tr>';
		html += '	<td class="bd-n h-5" colspan="30">';
		html += '</tr>';

		html += '<tr>';
		html += '	<td rowspan="2" colspan="1" class="bd-n"></td>';
		html += '	<td rowspan="2" colspan="5" class="bd-n fs-13 text-start">3. 공정 검사</td>';
		html += '	<td rowspan="2" colspan="2" class="bd-n fs-13 text-start">기준 : </td>';
		html += '	<td class="bd-n" colspan="19" class="fs-13 text-start">1 ) Bundling 후 Pharmacode 전수검사 실시 한다.</td>';
		html += '</tr>';
		
		html += '<tr>';
		html += '	<td class="bd-n" colspan="19" class="fs-13 text-start">2 ) 최소 1개 매 1시간 마다 Revision No 확인 후 기록서에 체크 한다.</td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="4" class="fs-13 text-center align-middle bb-n">공정일시/시간</td>';
		html += '	<td colspan="1" class="fs-13 text-center align-middle bb-n">P</td>';
		html += '	<td colspan="1" class="fs-13 text-center align-middle bb-n">L1</td>';
		html += '	<td colspan="1" class="fs-13 text-center align-middle bb-n">L2</td>';
		html += '	<td colspan="1" class="fs-13 text-center align-middle bb-n">L3</td>';
		html += '	<td colspan="2" class="fs-13 text-center align-middle bb-n">확인자</td>';
		html += '	<td colspan="4" class="fs-13 text-center align-middle bb-n">Revision No</td>';
		html += '	<td colspan="4" class="fs-13 text-center align-middle bb-n">공정일시/시간</td>';
		html += '	<td colspan="1" class="fs-13 text-center align-middle bb-n">P</td>';
		html += '	<td colspan="1" class="fs-13 text-center align-middle bb-n">L1</td>';
		html += '	<td colspan="1" class="fs-13 text-center align-middle bb-n">L2</td>';
		html += '	<td colspan="1" class="fs-13 text-center align-middle bb-n">L3</td>';
		html += '	<td colspan="2" class="fs-13 text-center align-middle bb-n">확인자</td>';
		html += '	<td colspan="4" class="fs-13 text-center align-middle bb-n">Revision No</td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';

		for(var i = 0; i < 7; i++){
			if( i < 6 ) {
				html += '<tr>';
				html += '	<td colspan="1" class="bd-n"></td>';
				html += '	<td colspan="4" class="fs-13 text-center align-middle bb-n h-25"></td>';
				html += '	<td colspan="1" class="fs-13 text-center align-middle bb-n h-25"></td>';
				html += '	<td colspan="1" class="fs-13 text-center align-middle bb-n h-25"></td>';
				html += '	<td colspan="1" class="fs-13 text-center align-middle bb-n h-25"></td>';
				html += '	<td colspan="1" class="fs-13 text-center align-middle bb-n h-25"></td>';
				html += '	<td colspan="2" class="fs-13 text-center align-middle bb-n h-25"></td>';
				html += '	<td colspan="4" class="fs-13 text-center align-middle bb-n h-25"></td>';
				html += '	<td colspan="4" class="fs-13 text-center align-middle bb-n h-25"></td>';
				html += '	<td colspan="1" class="fs-13 text-center align-middle bb-n h-25"></td>';
				html += '	<td colspan="1" class="fs-13 text-center align-middle bb-n h-25"></td>';
				html += '	<td colspan="1" class="fs-13 text-center align-middle bb-n h-25"></td>';
				html += '	<td colspan="1" class="fs-13 text-center align-middle bb-n h-25"></td>';
				html += '	<td colspan="2" class="fs-13 text-center align-middle bb-n h-25"></td>';
				html += '	<td colspan="4" class="fs-13 text-center align-middle bb-n h-25"></td>';
				html += '	<td colspan="1" class="bd-n"></td>';
				html += '</tr>';
			}  else {
				html += '<tr>';
				html += '	<td colspan="1" class="bd-n"></td>';
				html += '	<td colspan="4" class="fs-13 text-center align-middle h-25"></td>';
				html += '	<td colspan="1" class="fs-13 text-center align-middle h-25"></td>';
				html += '	<td colspan="1" class="fs-13 text-center align-middle h-25"></td>';
				html += '	<td colspan="1" class="fs-13 text-center align-middle h-25"></td>';
				html += '	<td colspan="1" class="fs-13 text-center align-middle h-25"></td>';
				html += '	<td colspan="2" class="fs-13 text-center align-middle h-25"></td>';
				html += '	<td colspan="4" class="fs-13 text-center align-middle h-25"></td>';
				html += '	<td colspan="4" class="fs-13 text-center align-middle h-25"></td>';
				html += '	<td colspan="1" class="fs-13 text-center align-middle h-25"></td>';
				html += '	<td colspan="1" class="fs-13 text-center align-middle h-25"></td>';
				html += '	<td colspan="1" class="fs-13 text-center align-middle h-25"></td>';
				html += '	<td colspan="1" class="fs-13 text-center align-middle h-25"></td>';
				html += '	<td colspan="2" class="fs-13 text-center align-middle h-25"></td>';
				html += '	<td colspan="4" class="fs-13 text-center align-middle h-25"></td>';
				html += '	<td colspan="1" class="bd-n"></td>';
				html += '</tr>';
			}
		}

		html += '<tr>';
		html += '	<td class="bd-n h-5" colspan="30">';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="5" class="bd-n fs-13 text-start">4. 공정 완료 내역</td>';
		html += '	<td colspan="2" class="bd-n fs-13 text-start">기준 : </td>';
		html += '	<td colspan="21" class="bd-n fs-13 text-start">인수량 기준으로 작업 완료시 잔량에 대한 수량차이가 발생시 전수검사를 실시한다.</td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="3" class="fs-13 text-center align-middle bb-n">구분</td>';
		html += '	<td colspan="3" class="fs-13 text-center align-middle bb-n">인수량</td>';
		html += '	<td colspan="3" class="fs-13 text-center align-middle bb-n">작업량</td>';
		html += '	<td colspan="3" class="fs-13 text-center align-middle bb-n">불량</td>';
		html += '	<td colspan="3" class="fs-13 text-center align-middle bb-n">양품</td>';
		html += '	<td colspan="3" class="fs-13 text-center align-middle bb-n">결과</td>';
		html += '	<td colspan="3" class="fs-13 text-center align-middle bb-n">차이수량</td>';
		html += '	<td colspan="3" class="fs-13 text-center align-middle bb-n">폐기내역</td>';
		html += '	<td colspan="4" class="fs-13 text-center align-middle bb-n">확인자</td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';
		
		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="3" class="fs-13 text-center align-middle bb-n">PAC</td>';
		html += '	<td colspan="3" class="fs-13 text-center align-middle bb-n"></td>';
		html += '	<td colspan="3" rowspan="5" class="fs-13 text-center align-middle bb-n"></td>';
		html += '	<td colspan="3" class="fs-13 text-center align-middle bb-n"></td>';
		html += '	<td colspan="3" class="fs-13 text-center align-middle bb-n"></td>';
		html += '	<td colspan="3" class="fs-13 text-center align-middle bb-n"></td>';
		html += '	<td colspan="3" class="fs-13 text-center align-middle bb-n"></td>';
		html += '	<td colspan="3" class="fs-13 text-center align-middle bb-n"></td>';
		html += '	<td colspan="4" class="fs-13 text-center align-middle bb-n"></td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';

		for(var i = 0 ; i < 4; i++){
			html += '<tr>';
			html += '	<td colspan="1" class="bd-n"></td>';
			html += '	<td colspan="3" class="fs-13 text-center align-middle bb-n">Leaflet</td>';
			html += '	<td colspan="3" class="fs-13 text-center align-middle bb-n"></td>';
			html += '	<td colspan="3" class="fs-13 text-center align-middle bb-n"></td>';
			html += '	<td colspan="3" class="fs-13 text-center align-middle bb-n"></td>';
			html += '	<td colspan="3" class="fs-13 text-center align-middle bb-n"></td>';
			html += '	<td colspan="3" class="fs-13 text-center align-middle bb-n"></td>';
			html += '	<td colspan="3" class="fs-13 text-center align-middle bb-n"></td>';
			html += '	<td colspan="4" class="fs-13 text-center align-middle bb-n"></td>';
			html += '	<td colspan="1" class="bd-n"></td>';
			html += '</tr>';
		}
		
		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="3" class="fs-13 text-center align-middle bb-n">묶음단위</td>';
		html += '	<td colspan="3" class="fs-13 text-center align-middle bb-n">묶음법</td>';
		html += '	<td colspan="3" class="fs-13 text-center align-middle bb-n">포장단위</td>';
		html += '	<td colspan="3" class="fs-13 text-center align-middle bb-n">포장방법</td>';
		html += '	<td colspan="11" class="fs-13 text-center align-middle bb-n">포장내역</td>';
		html += '	<td colspan="5" class="fs-13 text-center align-middle bb-n">Total</td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="3" class="fs-13 text-center align-middle" name="bundleUnit"></td>';
		html += '	<td colspan="3" class="fs-13 text-center align-middle" name="bundleMethodNm"></td>';
		html += '	<td colspan="3" class="fs-13 text-center align-middle" name="packUnit"></td>';
		html += '	<td colspan="3" class="fs-13 text-center align-middle" name="packMethodNm"></td>';
		html += '	<td colspan="2" class="fs-13 text-center align-middle" name="packUnit"></td>';
		html += '	<td colspan="1" class="fs-13 text-center align-middle">X</td>';
		html += '	<td colspan="2" class="fs-13 text-center align-middle"></td>';
		html += '	<td colspan="2" class="fs-13 text-center align-middle">BOX</td>';
		html += '	<td colspan="1" class="fs-13 text-center align-middle">+</td>';
		html += '	<td colspan="3" class="fs-13 text-center align-middle"></td>';
		html += '	<td colspan="5" class="fs-13 text-center align-middle"></td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td class="bd-n h-10" colspan="30">';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="29" class="bd-n fs-13 text-start">문서번호 : Bundling지시및기록서-230701-06</td>';
		html += '</tr>';

		
		return html;
	}
	
	function cssChange() {
		//$('#workOrderReportTable').find('td').css('font-weight', '900');
		$('#workOrderReportTable').find('td').css('border', '1px solid black');
		$('#workOrderReportTable').find('td').css('padding', '0rem');
		$('#workOrderReportTable').find('td').css('color', '#000000');
		$('#workOrderReportTable').find('td').css('font-weight', '500');

		$('#workOrderReportTable').find('.padding-right').css('padding-right', '10px');
		$('#workOrderReportTable').find('.fw900').css('font-weight', '900');
		$('#workOrderReportTable').find('.fw-bold').css('font-weight', 'bold');
		$('#workOrderReportTable').find('.bd2px').css('border', '2px solid black');
		
		$('#workOrderReportTable').find('.bg-gray').css('background-color', '#C9C9C9');
		
		$('#workOrderReportTable').find('.theadFirstCol').css('border-top', '0px');
		//$('#workOrderReportTable').find('.theadFirstCol').css('border-left', '2px');
		$('#workOrderReportTable').find('.theadNotFisrtCol').css('border-top', '0px');
		$('#workOrderReportTable').find('.theadNotFisrtCol').css('border-left', '0px');
		
		$('#workOrderReportTable').find('.tbodyFirstCol').css('border-top', '0px');
		//$('#workOrderReportTable').find('.tbodyFirstCol').css('border-left', '2px');
		$('#workOrderReportTable').find('.tbodyNotFirstCol').css('border-top', '0px');
		$('#workOrderReportTable').find('.tbodyNotFirstCol').css('border-left', '0px');

		//$('#workOrderReportTable').find('.bd-doblue').css('border', '5px double');
		
		$('#workOrderReportTable').find('.fc-red').css('color', '#ff0000');
		//$('#workOrderReportTable').find('.fc-blue').css('color', '#0070C0');
		//$('#workOrderReportTable').find('.fc-blue').css('color', '#17017E');
		$('#workOrderReportTable').find('.fc-blue').css('color', '#0000FF');
		$('#workOrderReportTable').find('.fs-8').css('font-size', '8px');
		$('#workOrderReportTable').find('.fs-10').css('font-size', '10px');
		$('#workOrderReportTable').find('.fs-11').css('font-size', '11px');
		$('#workOrderReportTable').find('.fs-12').css('font-size', '12px');
		$('#workOrderReportTable').find('.real-fs-13').css('font-size', '13px');
		
		$('#workOrderReportTable').find('.fs-13').css('font-size', '16px');
		$('#workOrderReportTable').find('.fs-14').css('font-size', '14px');
		$('#workOrderReportTable').find('.fs-15').css('font-size', '15px');
		$('#workOrderReportTable').find('.fs-20').css('font-size', '20px');
		$('#workOrderReportTable').find('.fs-25').css('font-size', '25px');
		$('#workOrderReportTable').find('.fs-30').css('font-size', '30px');
		$('#workOrderReportTable').find('.fs-50').css('font-size', '50px');
		$('#workOrderReportTable').find('.fc-red').css('color', '#ff0000');
		$('#workOrderReportTable').find('.bt-2').css('border-top', '2px solid black');
		$('#workOrderReportTable').find('.bd-n').css('border', '0px solid #ffffff');
		$('#workOrderReportTable').find('.bt-n').css('border-top', '0px solid #ffffff');
		$('#workOrderReportTable').find('.bt-n').css('border-bottom', '0px solid #ffffff');
		$('#workOrderReportTable').find('.br-n').css('border-right', '0px solid #ffffff');
		$('#workOrderReportTable').find('.bb-n').css('border-bottom', '0px solid #ffffff');
		$('#workOrderReportTable').find('.bl-n').css('border-left', '0px solid #ffffff');
		$('#workOrderReportTable').find('.h-5').css('height', '5px');
		$('#workOrderReportTable').find('.h-10').css('height', '10px');
		$('#workOrderReportTable').find('.h-15').css('height', '15px');
		$('#workOrderReportTable').find('.h-17').css('height', '17px');
		$('#workOrderReportTable').find('.h-18-5').css('height', '18.5px');
		$('#workOrderReportTable').find('.h-20').css('height', '20px');
		$('#workOrderReportTable').find('.h-22').css('height', '22px');
		$('#workOrderReportTable').find('.h-24').css('height', '24px');
		$('#workOrderReportTable').find('.minh-20').css('min-height', '20px');
		$('#workOrderReportTable').find('.h-25').css('height', '25px');
		$('#workOrderReportTable').find('.h-27').css('height', '27px');
		$('#workOrderReportTable').find('.h-28').css('height', '28px');
		$('#workOrderReportTable').find('.h-29').css('height', '29px');
		$('#workOrderReportTable').find('.h-30').css('height', '30px');
		$('#workOrderReportTable').find('.h-33').css('height', '33px');
		$('#workOrderReportTable').find('.h-40').css('height', '40px');
		$('#workOrderReportTable').find('.h-55').css('height', '55px');
		$('#workOrderReportTable').find('.h-70').css('height', '70px');
		$('#workOrderReportTable').find('.h-75').css('height', '75px');
		$('#workOrderReportTable').find('.h-90').css('height', '90px');
		$('#workOrderReportTable').find('.h-100').css('height', '100px');
		$('#workOrderReportTable').find('.maxh-5').css('max-height', '5px');
		$('#workOrderReportTable').find('.maxh-10').css('max-height', '10px');
		$('#workOrderReportTable').find('.maxh-20').css('max-height', '20px');
		$('#workOrderReportTable').find('.maxh-25').css('max-height', '25px');
		$('#workOrderReportTable').find('.maxh-30').css('max-height', '30px');
		$('#workOrderReportTable').find('.maxh-40').css('max-height', '40px');
		$('#workOrderReportTable').find('.maxh-55').css('max-height', '55px');
		$('#workOrderReportTable').find('.maxh-70').css('max-height', '70px');
		$('#workOrderReportTable').find('.maxh-75').css('max-height', '75px');
		$('#workOrderReportTable').find('.maxh-100').css('max-height', '100px');

		$('#workOrderReportTable').find('.w-5').css('width', '5px');
		$('#workOrderReportTable').find('.w-10').css('width', '10px');
		$('#workOrderReportTable').find('.w-15').css('width', '15px');
		$('#workOrderReportTable').find('.w-20').css('width', '20px');
		$('#workOrderReportTable').find('.w-25').css('width', '25px');
		$('#workOrderReportTable').find('.w-30').css('width', '30px');
		$('#workOrderReportTable').find('.w-40').css('width', '40px');
		$('#workOrderReportTable').find('.w-55').css('width', '55px');
		$('#workOrderReportTable').find('.w-70').css('width', '70px');
		$('#workOrderReportTable').find('.w-75').css('width', '75px');
		$('#workOrderReportTable').find('.w-90').css('width', '90px');
		$('#workOrderReportTable').find('.w-100').css('width', '100px');

		$('#workOrderReportTable').find('.w-speical').css('min-width', '1000px');
		

		// 인쇄할 때 css 적용하려면 important 붙여줘야함.
		for(var i=0;i<$('#workOrderReportTable').find('td').length;i++) {
			let tdStyle = $('#workOrderReportTable').find('td').eq(i).attr('style') == undefined?'':$('#workOrderReportTable').find('td').eq(i).attr('style');
			$('#workOrderReportTable').find('td').eq(i).attr('style',tdStyle.replaceAll(';',' !important;'));
		}
	}

	function cssChangeWithNewEditHistory() {
		//$('#newEditHistoryTable').find('td').css('font-weight', '900');
		$('#newEditHistoryTable').find('td').css('border', '1px solid black');
		$('#newEditHistoryTable').find('td').css('padding', '0.1rem');
		$('#newEditHistoryTable').find('td').css('color', '#000000');

		$('#newEditHistoryTable').find('.fw900').css('font-weight', '900');
		$('#newEditHistoryTable').find('.fw-bold').css('font-weight', 'bold');
		$('#newEditHistoryTable').find('.bd2px').css('border', '2px solid black');
		
		$('#newEditHistoryTable').find('.bg-gray').css('background-color', '#C9C9C9');
		
		$('#newEditHistoryTable').find('.theadFirstCol').css('border-top', '0px');
		//$('#newEditHistoryTable').find('.theadFirstCol').css('border-left', '2px');
		$('#newEditHistoryTable').find('.theadNotFisrtCol').css('border-top', '0px');
		$('#newEditHistoryTable').find('.theadNotFisrtCol').css('border-left', '0px');
		
		$('#newEditHistoryTable').find('.tbodyFirstCol').css('border-top', '0px');
		//$('#newEditHistoryTable').find('.tbodyFirstCol').css('border-left', '2px');
		$('#newEditHistoryTable').find('.tbodyNotFirstCol').css('border-top', '0px');
		$('#newEditHistoryTable').find('.tbodyNotFirstCol').css('border-left', '0px');

		//$('#newEditHistoryTable').find('.bd-doblue').css('border', '5px double');
		
		$('#newEditHistoryTable').find('.fc-red').css('color', '#ff0000');
		$('#newEditHistoryTable').find('.fc-blue').css('color', '#0070C0');
		$('#newEditHistoryTable').find('.fs-8').css('font-size', '8px');
		$('#newEditHistoryTable').find('.fs-10').css('font-size', '10px');
		$('#newEditHistoryTable').find('.fs-11').css('font-size', '11px');
		$('#newEditHistoryTable').find('.fs-12').css('font-size', '12px');
		$('#newEditHistoryTable').find('.fs-13').css('font-size', '13px');
		$('#newEditHistoryTable').find('.fs-15').css('font-size', '15px');
		$('#newEditHistoryTable').find('.fs-20').css('font-size', '20px');
		$('#newEditHistoryTable').find('.fs-25').css('font-size', '25px');
		$('#newEditHistoryTable').find('.fs-30').css('font-size', '30px');
		$('#newEditHistoryTable').find('.fs-50').css('font-size', '50px');
		$('#newEditHistoryTable').find('.fc-red').css('color', '#ff0000');
		$('#newEditHistoryTable').find('.bt-2').css('border-top', '2px solid black');
		$('#newEditHistoryTable').find('.bd-n').css('border', '0px solid #ffffff');
		$('#newEditHistoryTable').find('.bt-n').css('border-top', '0px solid #ffffff');
		$('#newEditHistoryTable').find('.br-n').css('border-right', '0px solid #ffffff');
		$('#newEditHistoryTable').find('.bb-n').css('border-bottom', '0px solid #ffffff');
		$('#newEditHistoryTable').find('.bl-n').css('border-left', '0px solid #ffffff');
		$('#newEditHistoryTable').find('.h-5').css('height', '5px');
		$('#newEditHistoryTable').find('.h-10').css('height', '10px');
		$('#newEditHistoryTable').find('.h-20').css('height', '20px');
		$('#newEditHistoryTable').find('.h-25').css('height', '25px');
		$('#newEditHistoryTable').find('.h-30').css('height', '30px');
		$('#newEditHistoryTable').find('.h-40').css('height', '40px');
		$('#newEditHistoryTable').find('.h-55').css('height', '55px');
		$('#newEditHistoryTable').find('.h-70').css('height', '70px');
		$('#newEditHistoryTable').find('.h-75').css('height', '75px');
		$('#newEditHistoryTable').find('.h-90').css('height', '90px');
		$('#newEditHistoryTable').find('.h-100').css('height', '100px');
		$('#newEditHistoryTable').find('.maxh-5').css('max-height', '5px');
		$('#newEditHistoryTable').find('.maxh-10').css('max-height', '10px');
		$('#newEditHistoryTable').find('.maxh-20').css('max-height', '20px');
		$('#newEditHistoryTable').find('.maxh-25').css('max-height', '25px');
		$('#newEditHistoryTable').find('.maxh-30').css('max-height', '30px');
		$('#newEditHistoryTable').find('.maxh-40').css('max-height', '40px');
		$('#newEditHistoryTable').find('.maxh-55').css('max-height', '55px');
		$('#newEditHistoryTable').find('.maxh-70').css('max-height', '70px');
		$('#newEditHistoryTable').find('.maxh-75').css('max-height', '75px');
		$('#newEditHistoryTable').find('.maxh-100').css('max-height', '100px');
		

		// 인쇄할 때 css 적용하려면 important 붙여줘야함.
		for(var i=0;i<$('#newEditHistoryTable').find('td').length;i++) {
			let tdStyle = $('#newEditHistoryTable').find('td').eq(i).attr('style') == undefined?'':$('#newEditHistoryTable').find('td').eq(i).attr('style');
			$('#newEditHistoryTable').find('td').eq(i).attr('style',tdStyle.replaceAll(';',' !important;'));
		}
	}

	function commonCssChange(tableId){
		//$('#'+tableId).find('td').css('font-weight', '900');
		$('#'+tableId).find('td').css('border', '1px solid black');
		$('#'+tableId).find('td').css('padding', '0.1rem');
		$('#'+tableId).find('td').css('color', '#000000');

		$('#'+tableId).find('.fw900').css('font-weight', '900');
		$('#'+tableId).find('.fw-bold').css('font-weight', 'bold');
		$('#'+tableId).find('.bd2px').css('border', '2px solid black');
		
		$('#'+tableId).find('.bg-gray').css('background-color', '#C9C9C9');
		
		$('#'+tableId).find('.theadFirstCol').css('border-top', '0px');
		//$('#'+tableId).find('.theadFirstCol').css('border-left', '2px');
		$('#'+tableId).find('.theadNotFisrtCol').css('border-top', '0px');
		$('#'+tableId).find('.theadNotFisrtCol').css('border-left', '0px');
		
		$('#'+tableId).find('.tbodyFirstCol').css('border-top', '0px');
		//$('#'+tableId).find('.tbodyFirstCol').css('border-left', '2px');
		$('#'+tableId).find('.tbodyNotFirstCol').css('border-top', '0px');
		$('#'+tableId).find('.tbodyNotFirstCol').css('border-left', '0px');

		//$('#'+tableId).find('.bd-doblue').css('border', '5px double');
		
		$('#'+tableId).find('.fc-red').css('color', '#ff0000');
		$('#'+tableId).find('.fc-blue').css('color', '#0070C0');
		$('#'+tableId).find('.fs-8').css('font-size', '8px');
		$('#'+tableId).find('.fs-10').css('font-size', '10px');
		$('#'+tableId).find('.fs-11').css('font-size', '11px');
		$('#'+tableId).find('.fs-12').css('font-size', '12px');
		$('#'+tableId).find('.fs-13').css('font-size', '13px');
		$('#'+tableId).find('.fs-15').css('font-size', '15px');
		$('#'+tableId).find('.fs-20').css('font-size', '20px');
		$('#'+tableId).find('.fs-25').css('font-size', '25px');
		$('#'+tableId).find('.fs-30').css('font-size', '30px');
		$('#'+tableId).find('.fs-50').css('font-size', '50px');
		$('#'+tableId).find('.fc-red').css('color', '#ff0000');
		$('#'+tableId).find('.bt-2').css('border-top', '2px solid black');
		$('#'+tableId).find('.bd-n').css('border', '0px solid #ffffff');
		$('#'+tableId).find('.bt-n').css('border-top', '0px solid #ffffff');
		$('#'+tableId).find('.br-n').css('border-right', '0px solid #ffffff');
		$('#'+tableId).find('.bb-n').css('border-bottom', '0px solid #ffffff');
		$('#'+tableId).find('.bl-n').css('border-left', '0px solid #ffffff');
		$('#'+tableId).find('.h-5').css('height', '5px');
		$('#'+tableId).find('.h-10').css('height', '10px');
		$('#'+tableId).find('.h-20').css('height', '20px');
		$('#'+tableId).find('.h-25').css('height', '25px');
		$('#'+tableId).find('.h-30').css('height', '30px');
		$('#'+tableId).find('.h-40').css('height', '40px');
		$('#'+tableId).find('.h-55').css('height', '55px');
		$('#'+tableId).find('.h-70').css('height', '70px');
		$('#'+tableId).find('.h-75').css('height', '75px');
		$('#'+tableId).find('.h-90').css('height', '90px');
		$('#'+tableId).find('.h-100').css('height', '100px');
		$('#'+tableId).find('.maxh-5').css('max-height', '5px');
		$('#'+tableId).find('.maxh-10').css('max-height', '10px');
		$('#'+tableId).find('.maxh-20').css('max-height', '20px');
		$('#'+tableId).find('.maxh-25').css('max-height', '25px');
		$('#'+tableId).find('.maxh-30').css('max-height', '30px');
		$('#'+tableId).find('.maxh-40').css('max-height', '40px');
		$('#'+tableId).find('.maxh-55').css('max-height', '55px');
		$('#'+tableId).find('.maxh-70').css('max-height', '70px');
		$('#'+tableId).find('.maxh-75').css('max-height', '75px');
		$('#'+tableId).find('.maxh-100').css('max-height', '100px');
		

		// 인쇄할 때 css 적용하려면 important 붙여줘야함.
		for(var i=0;i<$('#'+tableId).find('td').length;i++) {
			let tdStyle = $('#'+tableId).find('td').eq(i).attr('style') == undefined?'':$('#'+tableId).find('td').eq(i).attr('style');
			$('#'+tableId).find('td').eq(i).attr('style',tdStyle.replaceAll(';',' !important;'));
		}
	}
	
	$('#btnWorkPrint').on('click',function(){
		
		if( parseInt(bizOrderDtlTable.row('.selected').data().bundleCnt) > 0 ){
			//번들링 지시서가 나와야하는 경우
			if(bizOrderDtlTable.row('.selected').data() == undefined) {
				toastr.warning('출력할 수주를 선택해주세요.');
				return false;
			}

			//해당 스타일시트날리고
			$('#printPaperTypeStyle').remove();
			//스타일시트 생성
			$('<style>')
				.prop('type', 'text/css').prop('id','printPaperTypeStyle').prop('media','print')
				.html('@media print { @page { size: A4 portrait; margin: 9mm; margin-top: 6mm; margin-bottom: 0mm; }, html, body { width: 210mm; height: 297mm; } }')
				.appendTo('body'); 
			$('#my-spinner').fadeIn(50, function() {
				$.ajax({
					url: '<c:url value="/bs/bizOrderDtlBundleList"/>',
		            type: 'POST',
		            async: false,
		            data: {
		                'bizOrdDtlIdx'	:	function(){ return bizOrderDtlTable.row('.selected').data().idx;} ,
		            },
		            beforeSend: function() {
		            	$('#my-spinner').show();
		            },
					success : function(res) {
						if (res.result == "ok") { //응답결과
							let bizDtlData = bizOrderDtlTable.row('.selected').data();
							let data = res.data;
							let dataLength = data.length;
							
							$('td[name=printDate]').text(moment().format('YYYY/MM/DD'));
							$('#bundlingOrderTable [name=bizOrdDtlNo]:eq(0)').text(bizDtlData.bizOrdDtlNo); 								
							$('#bundlingOrderTable [name=bizOrdDealCorpNm]:eq(0)').text(bizDtlData.dealCorpNm); 													
							$('#bundlingOrderTable [name=itemNm]:eq(0)').text(bizDtlData.itemNm);										
							$('#bundlingOrderTable [name=bizOrdQty]:eq(0)').text(addCommas(parseInt(bizDtlData.ordQty)));				
							$('#bundlingOrderTable [name=ordEndDate]:eq(0)').text(moment(bizDtlData.workEndReqDate).format('YYYY-MM-DD'));
											
							$('#bundlingOrderTable [name=bundleUnit]:eq(0)').text(bizDtlData.bundleUnit);	
							$('#bundlingOrderTable [name=bundleMethodNm]:eq(0)').text(bizDtlData.bundleMethodNm);
							$('#bundlingOrderTable [name=packUnit]:eq(0)').text(bizDtlData.packUnit);
							$('#bundlingOrderTable [name=packMethodNm]:eq(0)').text(bizDtlData.packMethodNm);					
							$('#bundlingOrderTable [name=packUnit]:eq(1)').text(bizDtlData.packUnit);			

							for(var i = 0; i < 5; i++){
								if( dataLength > i ){
									let bundlingData = data[i];									
									$('#bundlingOrderTable [name=bundleItemNm]:eq('+i+')').text(bundlingData.itemNm);
									$('#bundlingOrderTable [name=bundleBizOrdNo]:eq('+i+')').text(bundlingData.bizOrdDtlNo);
									$('#bundlingOrderTable [name=bundleItemVersion]:eq('+i+')').text(bundlingData.itemVersion);
									$('#bundlingOrderTable [name=bundleItemCustomerItemCd]:eq('+i+')').text(bundlingData.customerItemCd);
									//$('#bundlingOrderTable [name=bundleItemQty]:eq('+i+')').text(addCommas(parseInt(bundlingData.inputQty)));
								} else {
									$('#bundlingOrderTable [name=bundleItemNm]:eq('+i+')').text('');
									$('#bundlingOrderTable [name=bundleBizOrdNo]:eq('+i+')').text('');
									$('#bundlingOrderTable [name=bundleItemVersion]:eq('+i+')').text('');
									$('#bundlingOrderTable [name=bundleItemCustomerItemCd]:eq('+i+')').text('');
								}								
							}
							
							$('#bundlingOrderTable').print({
								globalStyles: true,
								mediaPrint: true
							});

							$.ajax({
								url: '<c:url value="/bs/bizOrderDtlUpdByBundlePrint"/>',
					            type: 'POST',
					            //async: false,
					            data: {    
						            'bizOrdDtlIdx'	:	function(){ return bizOrderDtlTable.row('.selected').data().idx;} ,
					            },
					            beforeSend: function() {
					            	$('#my-spinner').show();
					            },
								success : function(res) {
									if (res.result == "ok") { //응답결과
										bizOrdAdmTrId = bizOrderAdmTable.row('.selected').data().idx;
										bizOrdDtlIdxVal = bizOrderDtlTable.row('.selected').data().idx;

										bizOrderAdmTable.rows('.selected').deselect();
										bizOrderDtlTable.rows('.selected').deselect();
										
										bizOrderAdmTable.ajax.reload(function(){
											bizOrderAdmTable.row('#'+bizOrdAdmTrId).select();
											//$(bizOrderAdmTable.row('#'+bizOrdAdmTrId).node()).trigger('click');
											
											bizOrderDtlTable.ajax.reload(function(){
												bizOrderDtlTable.row('#'+bizOrdDtlIdxVal).select();
												$(bizOrderDtlTable.row('#'+bizOrdDtlIdxVal).node()).trigger('click'); 
											},false);
											 
										},false);
										
									} else if(res.result == 'fail') {
										toastr.warning(res.message);
									} else {
										toastr.error(res.message);
									}
									$('#my-spinner').hide();

								}
							});
							
						}
						$('#my-spinner').hide();
					}
				});
				
			});
			
		} else {
			//일반 지시서가 나와야하는 경우
			//해당 스타일시트날리고
			$('#printPaperTypeStyle').remove();
			//스타일시트 생성
			$('<style>')
				.prop('type', 'text/css').prop('id','printPaperTypeStyle').prop('media','print')
				.html('@media print { @page { size: A3 landscape; margin: 3mm; }, html, body { width: 297mm; height: 420mm; } }')
				.appendTo('body'); 
			$('#my-spinner').fadeIn(50, function() {
				$.ajax({
					url: '<c:url value="/wm/workOrdDtlLstWithPrcssByBizDtlIdx"/>',
		            type: 'POST',
		            async: false,
		            data: {
		                'bizOrdDtlIdx'	:	function(){ return bizOrderDtlTable.row('.selected').data().idx;} ,
		            },
		            beforeSend: function() {
		            	$('#my-spinner').show();
		            },
					success : function(res) {
						if (res.result == "ok") { //응답결과

							$('td[name=printDate]').text(moment().format('YYYY-MM-DD hh:mm'));
							let data = res.data[0];
							let customerItemCd = isEmptyCheck(data.customerItemCd) ? '' : data.customerItemCd;
							let itemVersion = isEmptyCheck(data.itemVersion) ? '' : data.itemVersion;
							let paperType = isEmptyCheck(data.paperType) ? '' : data.paperType;
							let woodenCareNm = isEmptyCheck(data.woodenCareNm) ? '' : data.woodenCareNm;
							let cutQty = parseInt(isEmptyCheck(data.cutQty) ? 0 : data.cutQty);
							let eaQty = parseInt(isEmptyCheck(data.eaQty) ? 0 : data.eaQty);
							let extraQty = parseInt(isEmptyCheck(data.extraQty) ? 0 : data.extraQty);
							let extraPackQty = parseInt(isEmptyCheck(data.extraPackQty) ? 0 : data.extraPackQty);
							let printPressQty = Math.ceil((data.bizOrdQty - data.stockUseQty)/(cutQty*eaQty)) * cutQty;
							let printPressAndExtraQty = printPressQty + extraQty + (extraPackQty*cutQty);
							let fixedSheet = Math.ceil( (data.bizOrdQty - data.stockUseQty) / (cutQty * eaQty) );
							fixedSheet = isFinite(fixedSheet) ? fixedSheet : 0;
							let fixedSheetR = parseInt(fixedSheet/500) + 'R' + parseInt(fixedSheet%500);
							//workSheet = (여분+정매인쇄통수) / 절수 , 정매인쇄통수는 fixedSheet에 절수 곱하면됨
							//workSheet = ((추가여분*절수) + 여분+정매인쇄통수) / 절수 , 정매인쇄통수는 fixedSheet에 절수 곱하면됨
							let workSheet = Math.ceil(( (extraPackQty * cutQty) + extraQty + (fixedSheet * cutQty)) / cutQty	);
							workSheet = isNaN(workSheet) ? 0 : workSheet;
							let workSheetR = parseInt(workSheet/500) + 'R' + parseInt(workSheet%500);
							//noSheet = (절수 * (수주수량/(절수*개수)) )임 즉 fixedSheet에 절수곱한값 
							let noSheet = fixedSheet * cutQty;
							noSheet = isNaN(noSheet) ? 0 : noSheet;
							//exSheet = (절수 * 통수:workSheet) - noSheet
							//let exSheet = (cutQty *  workSheet) - noSheet;
							//exSheet -> 여분포함통수 - 이론통수임
							let exSheet = printPressAndExtraQty - printPressQty;
							exSheet = isNaN(exSheet) ? 0 : exSheet;
							let cutSize = parseInt(cutQty) + '절' + parseInt(eaQty) + '개';
							let ordEndDate = data.ordEndDate;
							//let workDeadline = moment(ordEndDate).subtract('d',3).format('YYYY-MM-DD')
							//workDeadLine은 워킹데이기준으로 계산되어야함 -> 함수 활용
							let workDeadline = workingDateCalc(ordEndDate, 3, '-');
							
							// 0번째가 추가된 tr이라서 밑에처럼함 / for문 2번쓸려했는데 나중가서 문제될거같아서 이렇게함
							$('#workOrderReportTable [name=bizOrdDtlNo]:eq(0)').text(data.bizOrdDtlNo); 								//제조관리번호
							$('#workOrderReportTable [name=bizOrdDealCorpNm]:eq(0)').text(data.bizDealCorpNm); 						//수주고객사
							$('#workOrderReportTable [name=itemNm]:eq(0)').text(data.itemNm); 										//제품명
							$('#workOrderReportTable [name=bizOrdQty]:eq(0)').text(addCommas(parseInt(data.bizOrdQty)));	 			//수주수량
							$('#workOrderReportTable [name=itemVersion]:eq(0)').text( customerItemCd + ' - ' + itemVersion ); 		//제품버전
							$('#workOrderReportTable [name=paperType]:eq(0)').text( paperType ); 										//발주자재
							$('#workOrderReportTable [name=woodenCareNm]:eq(0)').text( woodenCareNm ); 								//목형번호
							$('#workOrderReportTable [name=holeWoodenCd]:eq(0)').text( data.holeWoodenCd ); 							//타공목형번호
							$('#workOrderReportTable [name=fixedSheet]:eq(0)').text( fixedSheetR ); 									//fixedSheet
							$('#workOrderReportTable [name=cutSize]:eq(0)').text( cutSize ); 											//cutSizeeet
							$('#workOrderReportTable [name=workSheet]:eq(0)').text( workSheetR ); 									//workSheetR
							$('#workOrderReportTable [name=noSheet]:eq(0)').text( addCommas(parseInt(noSheet)) ); 					//noSheet
							$('#workOrderReportTable [name=exSheet]:eq(0)').text( addCommas(parseInt(exSheet)) );						//exSheet
							$('#workOrderReportTable [name=notice]:eq(0)').text( data.specialNotice ); 								//notice
							$('#workOrderReportTable [name=knifeTipSize]:eq(0)').text( data.knifeTipSize ); 							//knifeTipSize
							$('#workOrderReportTable [name=printingYnCheck]:eq(0)').text( data.printingYnCheck ); 					//printingYnCheck
							$('#workOrderReportTable [name=inspectMethodNm]:eq(0)').text( data.inspectMethodNm ); 					//inspectMethodNm
							$('#workOrderReportTable [name=etc6]:eq(0)').text( data.etc6 ); 											//etc6
							$('#workOrderReportTable [name=ordEndDate]:eq(0)').text( moment(ordEndDate).format('YYYY-MM-DD') );		//ordEndDate
							$('#workOrderReportTable [name=workDeadline]:eq(0)').text( moment(workDeadline).format('YYYY-MM-DD') );	//ordEndDate
							$('#workOrderReportTable [name=itemSize]:eq(0)').text( data.itemSize ); 									//itemSize
							$('#workOrderReportTable [name=coatingMethod]:eq(0)').text( data.coatingMethod ); 						//coatingMethod
							$('#workOrderReportTable [name=resinBoardNm]:eq(0)').text( data.resinBoardNm ); 							//resinBoardNm
							$('#workOrderReportTable [name=etc1Nm]:eq(0)').text( data.etc1Nm ); 										//etc1Nm
							$('#workOrderReportTable [name=itemColor]:eq(0)').text( data.itemColor ); 								//itemColor
							$('#workOrderReportTable [name=ordIssue]:eq(0)').text( data.ordIssue ); 									//ordIssue
							$('#workOrderReportTable [name=purchaseOrdNo]:eq(0)').text( data.purchaseBatch ); 						//purchaseOrdNo
							$('#workOrderReportTable [name=packUnit]:eq(0)').text( data.packUnit ); 						//packUnit
							$('#workOrderReportTable [name=packUnit]:eq(1)').text( data.packUnit ); 						//packUnit
							$('#workOrderReportTable [name=moldingMethod]:eq(0)').text( data.moldingMethod ); 						//packUnit
							$('#workOrderReportTable [name=moldingContents]:eq(0)').text( data.moldingContents ); 						//packUnit
							$('#workOrderReportTable [name=bundleMethodNm]:eq(0)').text( data.bundleMethodNm ); 						//packUnit
							$('#workOrderReportTable [name=bundleUnit]:eq(0)').text( data.bundleUnit ); 						//packUnit
							$('#workOrderReportTable [name=packMethodNm]:eq(0)').text( data.packMethodNm ); 						//packUnit
							$('#workOrderReportTable [name=foil]:eq(0)').text( data.etc4 ); 						//foil
							$('#workOrderReportTable [name=etc2Cd]:eq(0)').text( data.etc2Cd ); 						//etc2Cd

							$('#workOrderReportTable').print({
								globalStyles: true,
								mediaPrint: true
							});
							$.ajax({
								url: '<c:url value="/wm/workOrdPaperPrint"/>',
					            type: 'POST',
					            //async: false,
					            data: {    
						            'bizOrdDtlIdx'	:	function(){ return res.data[0].bizOrdDtlIdx;} ,
					            },
					            beforeSend: function() {
					            	$('#my-spinner').show();
					            },
								success : function(res) {
									if (res.result == "ok") { //응답결과
										bizOrdAdmTrId = bizOrderAdmTable.row('.selected').data().idx;
										bizOrdDtlIdxVal = bizOrderDtlTable.row('.selected').data().idx;

										bizOrderAdmTable.rows('.selected').deselect();
										bizOrderDtlTable.rows('.selected').deselect();
										
										bizOrderAdmTable.ajax.reload(function(){
											bizOrderAdmTable.row('#'+bizOrdAdmTrId).select();
											//$(bizOrderAdmTable.row('#'+bizOrdAdmTrId).node()).trigger('click');
											
											bizOrderDtlTable.ajax.reload(function(){
												bizOrderDtlTable.row('#'+bizOrdDtlIdxVal).select();
												$(bizOrderDtlTable.row('#'+bizOrdDtlIdxVal).node()).trigger('click'); 
											},false);
											 
										},false);
										
									} else if(res.result == 'fail') {
										toastr.warning(res.message);
									} else {
										toastr.error(res.message);
									}
									$('#my-spinner').hide();

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
		}
		
	});

	$('#btnNewEditPrint').on('click',function(){
		if(bizOrderDtlTable.row('.selected').data() == undefined) {
			toastr.warning('출력할 수주를 선택해주세요.');
			return false;
		}
		
		//해당 스타일시트날리고
		$('#printPaperTypeStyle').remove();
		//스타일시트 생성
		$('<style>')
			.prop('type', 'text/css').prop('id','printPaperTypeStyle').prop('media','print')
			.html('@media print { @page { size: A4 portrait; margin: 3mm; }, html, body { width: 210mm; height: 297mm; } }')
			.appendTo('body'); 
		
		$('#my-spinner').fadeIn(50, function() {
			$.ajax({
				url: '<c:url value="/wm/workOrdDtlLstWithPrcssByBizDtlIdx"/>',
	            type: 'POST',
	            async: false,
	            data: {
	                'bizOrdDtlIdx'	:	function(){ return bizOrderDtlTable.row('.selected').data().idx;} ,
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if (res.result == "ok") { //응답결과

						$('td[name=printDate]').text(moment().format('YYYY/MM/DD'));
						let data = res.data[0];
						let customerItemCd = isEmptyCheck(data.customerItemCd) ? '' : data.customerItemCd;
						let itemVersion = isEmptyCheck(data.itemVersion) ? '' : data.itemVersion;
						let paperType = isEmptyCheck(data.paperType) ? '' : data.paperType;
						let woodenCareNm = isEmptyCheck(data.woodenCareNm) ? '' : data.woodenCareNm;
						let cutQty = parseInt(isEmptyCheck(data.cutQty) ? 0 : data.cutQty);
						let eaQty = parseInt(isEmptyCheck(data.eaQty) ? 0 : data.eaQty);
						let extraQty = parseInt(isEmptyCheck(data.extraQty) ? 0 : data.extraQty);
						let extraPackQty = parseInt(isEmptyCheck(data.extraPackQty) ? 0 : data.extraPackQty);
						let fixedSheet = Math.ceil( (data.bizOrdQty - data.stockUseQty) / (cutQty * eaQty) );
						fixedSheet = isFinite(fixedSheet) ? fixedSheet : 0;
						let fixedSheetR = parseInt(fixedSheet/500) + 'R' + parseInt(fixedSheet%500);
						//workSheet = (여분+정매인쇄통수) / 절수 , 정매인쇄통수는 fixedSheet에 절수 곱하면됨
						let workSheet = Math.ceil(( extraQty + (fixedSheet * cutQty)) / cutQty);
						workSheet = isNaN(workSheet) ? 0 : workSheet;
						let workSheetR = parseInt(workSheet/500) + 'R' + parseInt(workSheet%500);
						//noSheet = (절수 * (수주수량/(절수*개수)) )임 즉 fixedSheet에 절수곱한값 
						let noSheet = fixedSheet * cutQty;
						noSheet = isNaN(noSheet) ? 0 : noSheet;
						//exSheet = (절수 * 통수:workSheet) - noSheet
						let exSheet = (cutQty * workSheet) - noSheet;
						exSheet = isNaN(exSheet) ? 0 : exSheet;
						let cutSize = parseInt(cutQty) + '절' + parseInt(eaQty) + '개';
						let ordEndDate = data.ordEndDate;
						//let workDeadline = moment(ordEndDate).subtract('d',3).format('YYYY-MM-DD')
						//workDeadLine은 워킹데이기준으로 계산되어야함 -> 함수 활용
						let workDeadline = workingDateCalc(ordEndDate, 3, '-');
						
						// 0번째가 추가된 tr이라서 밑에처럼함 / for문 2번쓸려했는데 나중가서 문제될거같아서 이렇게함
						$('#newEditHistoryTable [name=bizOrdDtlNo]:eq(0)').text(data.bizOrdDtlNo); 								//제조관리번호
						$('#newEditHistoryTable [name=bizOrdDealCorpNm]:eq(0)').text(data.bizDealCorpNm); 						//수주고객사
						$('#newEditHistoryTable [name=itemNm]:eq(0)').text(data.itemNm); 										//제품명
						$('#newEditHistoryTable [name=bizOrdQty]:eq(0)').text(addCommas(parseInt(data.bizOrdQty)));	 			//수주수량
						$('#newEditHistoryTable [name=itemVersion]:eq(0)').text( customerItemCd + ' - ' + itemVersion ); 		//제품버전
						$('#newEditHistoryTable [name=paperType]:eq(0)').text( paperType ); 										//발주자재
						$('#newEditHistoryTable [name=woodenCareNm]:eq(0)').text( woodenCareNm ); 								//목형번호
						$('#newEditHistoryTable [name=holeWoodenCd]:eq(0)').text( data.holeWoodenCd ); 							//타공목형번호
						$('#newEditHistoryTable [name=fixedSheet]:eq(0)').text( fixedSheetR ); 									//fixedSheet
						$('#newEditHistoryTable [name=cutSize]:eq(0)').text( cutSize ); 											//cutSizeeet
						$('#newEditHistoryTable [name=workSheet]:eq(0)').text( workSheetR ); 									//workSheetR
						$('#newEditHistoryTable [name=noSheet]:eq(0)').text( addCommas(parseInt(noSheet)) ); 					//noSheet
						$('#newEditHistoryTable [name=exSheet]:eq(0)').text( addCommas(parseInt(exSheet)) );						//exSheet
						$('#newEditHistoryTable [name=notice]:eq(0)').text( data.specialNotice ); 								//notice
						$('#newEditHistoryTable [name=knifeTipSize]:eq(0)').text( data.knifeTipSize ); 							//knifeTipSize
						$('#newEditHistoryTable [name=printingYnCheck]:eq(0)').text( data.printingYnCheck ); 					//printingYnCheck
						$('#newEditHistoryTable [name=inspectMethodNm]:eq(0)').text( data.inspectMethodNm ); 					//inspectMethodNm
						$('#newEditHistoryTable [name=etc6]:eq(0)').text( data.etc6 ); 											//etc6
						$('#newEditHistoryTable [name=ordEndDate]:eq(0)').text( moment(ordEndDate).format('YYYY-MM-DD') );		//ordEndDate
						$('#newEditHistoryTable [name=workDeadline]:eq(0)').text( moment(workDeadline).format('YYYY-MM-DD') );	//ordEndDate
						$('#newEditHistoryTable [name=itemSize]:eq(0)').text( data.itemSize ); 									//itemSize
						if(data.coatingMethod.length >= 23){
							$('#newEditHistoryTable [name=coatingMethod]:eq(0)').removeClass('fs-13').addClass('fs-11');
							$('#newEditHistoryTable [name=coatingMethod]:eq(0)').text( data.coatingMethod ); 	
						} else {
							$('#newEditHistoryTable [name=coatingMethod]:eq(0)').removeClass('fs-11').addClass('fs-13');
							$('#newEditHistoryTable [name=coatingMethod]:eq(0)').text( data.coatingMethod ); 						//coatingMethod
						}
						$('#newEditHistoryTable [name=resinBoardNm]:eq(0)').text( data.resinBoardNm ); 							//resinBoardNm
						$('#newEditHistoryTable [name=etc1Nm]:eq(0)').text( data.etc1Nm ); 										//etc1Nm
						$('#newEditHistoryTable [name=itemColor]:eq(0)').text( data.itemColor ); 								//itemColor
						$('#newEditHistoryTable [name=ordIssue]:eq(0)').text( data.ordIssue ); 									//ordIssue
						$('#newEditHistoryTable [name=purchaseOrdNo]:eq(0)').text( data.purchaseBatch ); 						//purchaseOrdNo
						$('#newEditHistoryTable [name=packUnit]:eq(0)').text( data.packUnit ); 						//packUnit
						$('#newEditHistoryTable [name=packUnit]:eq(1)').text( data.packUnit ); 						//packUnit
						$('#newEditHistoryTable [name=moldingMethod]:eq(0)').text( data.moldingMethod ); 						//packUnit
						$('#newEditHistoryTable [name=moldingContents]:eq(0)').text( data.moldingContents ); 						//packUnit
						$('#newEditHistoryTable [name=bundleMethodNm]:eq(0)').text( data.bundleMethodNm ); 						//packUnit
						$('#newEditHistoryTable [name=bundleUnit]:eq(0)').text( data.bundleUnit ); 						//packUnit
						$('#newEditHistoryTable [name=packMethodNm]:eq(0)').text( data.packMethodNm ); 						//packUnit
						$('#newEditHistoryTable [name=foil]:eq(0)').text( data.etc4 ); 						//foil
						$('#newEditHistoryTable [name=etc2Cd]:eq(0)').text( data.etc2Cd ); 						//etc2Cd

						cssChangeWithNewEditHistory();
						
						$('#newEditHistoryTable').print({
							globalStyles: true,
							mediaPrint: true
						});
						
						$.ajax({
							url: '<c:url value="/bs/bizOrderDtlUpdByEditHistoryPrint"/>',
				            type: 'POST',
				            //async: false,
				            data: {    
					            'bizOrdDtlIdx'	:	function(){ return bizOrderDtlTable.row('.selected').data().idx;} ,
				            },
				            beforeSend: function() {
				            	$('#my-spinner').show();
				            },
							success : function(res) {
								if (res.result == "ok") { //응답결과
									bizOrdDtlIdxVal = bizOrderDtlTable.row('.selected').data().idx;
									bizOrderDtlTable.rows('.selected').deselect();
									bizOrderDtlTable.ajax.reload(function(){
										bizOrderDtlTable.row('#'+bizOrdDtlIdxVal).select();
										$(bizOrderDtlTable.row('#'+bizOrdDtlIdxVal).node()).trigger('click'); 
									},false);
									
								} else if(res.result == 'fail') {
									toastr.warning(res.message);
								} else {
									toastr.error(res.message);
								}
								$('#my-spinner').hide();

							}
						});
						
					}
					$('#my-spinner').hide();
				}
			});
			
		});
	});

	$('#btnBundlingPrint').on('click',function(){
		if(bizOrderDtlTable.row('.selected').data() == undefined) {
			toastr.warning('출력할 수주를 선택해주세요.');
			return false;
		}
		
		//해당 스타일시트날리고
		$('#printPaperTypeStyle').remove();
		//스타일시트 생성
		$('<style>')
			.prop('type', 'text/css').prop('id','printPaperTypeStyle').prop('media','print')
			.html('@media print { @page { size: A4 portrait; margin: 9mm; margin-bottom: 0mm; }, html, body { width: 210mm; height: 297mm; } }')
			.appendTo('body'); 
		$('#my-spinner').fadeIn(50, function() {
			$.ajax({
				url: '<c:url value="/bs/bizOrderDtlBundleList"/>',
	            type: 'POST',
	            async: false,
	            data: {
	                'bizOrdDtlIdx'	:	function(){ return bizOrderDtlTable.row('.selected').data().idx;} ,
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if (res.result == "ok") { //응답결과
						let bizDtlData = bizOrderDtlTable.row('.selected').data();
						let data = res.data;
						let dataLength = data.length;
						
						$('td[name=printDate]').text(moment().format('YYYY/MM/DD'));
						$('#bundlingOrderTable [name=bizOrdDtlNo]:eq(0)').text(bizDtlData.bizOrdDtlNo); 								
						$('#bundlingOrderTable [name=bizOrdDealCorpNm]:eq(0)').text(bizDtlData.dealCorpNm); 													
						$('#bundlingOrderTable [name=itemNm]:eq(0)').text(bizDtlData.itemNm);										
						$('#bundlingOrderTable [name=bizOrdQty]:eq(0)').text(addCommas(parseInt(bizDtlData.ordQty)));				
						$('#bundlingOrderTable [name=ordEndDate]:eq(0)').text(moment(bizDtlData.workEndReqDate).format('YYYY-MM-DD'));
										
						$('#bundlingOrderTable [name=bundleUnit]:eq(0)').text(bizDtlData.bundleUnit);	
						$('#bundlingOrderTable [name=bundleMethodNm]:eq(0)').text(bizDtlData.bundleMethodNm);
						$('#bundlingOrderTable [name=packUnit]:eq(0)').text(bizDtlData.packUnit);
						$('#bundlingOrderTable [name=packMethodNm]:eq(0)').text(bizDtlData.packMethodNm);					
						$('#bundlingOrderTable [name=packUnit]:eq(1)').text(bizDtlData.packUnit);			

						for(var i = 0; i < 5; i++){
							if( dataLength > i ){
								let bundlingData = data[i];									
								$('#bundlingOrderTable [name=bundleItemNm]:eq('+i+')').text(bundlingData.itemNm);
								$('#bundlingOrderTable [name=bundleBizOrdNo]:eq('+i+')').text(bundlingData.bizOrdDtlNo);
								$('#bundlingOrderTable [name=bundleItemVersion]:eq('+i+')').text(bundlingData.itemVersion);
								$('#bundlingOrderTable [name=bundleItemCustomerItemCd]:eq('+i+')').text(bundlingData.customerItemCd);
								//$('#bundlingOrderTable [name=bundleItemQty]:eq('+i+')').text(addCommas(parseInt(bundlingData.inputQty)));
							}								
						}
						
						$('#bundlingOrderTable').print({
							globalStyles: true,
							mediaPrint: true
						});
					}
					$('#my-spinner').hide();
				}
			});
			
		});

		
	});

	//수주별발주 투입자재 복사
	$('#btnMaterialCopy').on('click',function(){
		$.ajax({
			url: '<c:url value="/bs/bizOrderItemBomCopy"/>',
            type: 'POST',
            //async: false,
            data: {
                'bizOrdDtlIdx' : 	bizOrdDtlIdxVal,
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					let data = res.data;
					toastr.success('발주 정보를 가져왔습니다.');
					bizOrdDtlIdxVal = bizOrderDtlTable.row('.selected').data().idx;
					bizOrderDtlTable.rows('.selected').deselect();
					bizOrderDtlTable.ajax.reload(function(){
						bizOrderDtlTable.row('#'+bizOrdDtlIdxVal).select();
						$(bizOrderDtlTable.row('#'+bizOrdDtlIdxVal).node()).trigger('click'); 
					},false);
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
			
	});

	//수주의 제품의 버전 업데이트
	//업데이트 클릭
	$(document).on('click', '.versionUpdate', function() {
		let tr = $(this).parent().parent().parent();
		let data = bizOrderDtlTable.row(tr).data();
		let bizOrdDtlIdx = data.idx;

		$.ajax({
			url: '<c:url value="/bs/bizOrderDtlItemVersionUpd"/>',
			type: 'POST',
			data: {
				'bizOrdDtlIdx'	: function(){ return bizOrdDtlIdx; },
			},
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					toastr.success('버전 업데이트 되었습니다.');
					bizOrdAdmTrId = bizOrderAdmTable.row('.selected').data().idx; 
					bizOrderAdmTable.rows('.selected').deselect();
					bizOrderAdmTable.ajax.reload(function(){
						bizOrderAdmTable.row('#'+bizOrdAdmTrId).select();
						$(bizOrderAdmTable.row('#'+bizOrdAdmTrId).node()).trigger('click'); 
					},false);
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
					bizOrderDtlTable.ajax.reload(function(){},false);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
	});
	
</script>
</body>
</html>