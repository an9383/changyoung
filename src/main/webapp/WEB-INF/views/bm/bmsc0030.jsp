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
																			grid-template-rows: 2.4fr 4px 2.1fr 4px 1.2fr; 
																			grid-template-columns: 7.5fr 4px 10.5fr;">
	<div id="leftcol">
		<input type="file" id="fileFake" style="display: none;" value=""multiple>
		<div class="container-fluid h-100" style="padding: 5px;">
			<div class="row" id="leftHeader" style="padding-bottom: 5px;">
				<div class="d-flex align-items-center d-flex">
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">사용여부</label>
					<select class="form-select w-auto h-100 me-3" id="searchUseYnCd" style="min-width: 70px;">
						<option value="">전체</option>
						<option value="Y" selected>사용</option>
						<option value="N">미사용</option>
					</select> 
					<input type="text" class="form-control w-auto h-100 me-1" id="searchAll" style="min-width:400px;" placeholder="통합검색" >
				</div>
				<div class="me-lg-auto"></div>
				<div class="btn-group" role="group" aria-label="Small button group">
					<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnSearch">
						<i class="fa-regular fa-clipboard"></i>
					</button>
					
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnOpen">
						<i class="fa-solid fa-caret-left"></i>
					</button>
				</div>
			</div>

			<div class="row">
				<table class="table table-bordered p-0 m-0" id="itemInfoTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle" style="min-width:100px;">고객사</th>
							<th class="text-center align-middle" style="min-width:300px;">제품명</th>
							<th class="text-center align-middle">공정수</th>
							<th class="text-center align-middle colvisHide">건별전달사항</th>
							<th class="text-center align-middle colvisHide">칼끝규격</th>
							<th class="text-center align-middle" style="min-width:135px;">자재코드</th>
							<th class="text-center align-middle" style="min-width:95px;">버전번호</th>
							<th class="text-center align-middle colvisHide">재질</th>
							<th class="text-center align-middle colvisHide">절수</th>
							<th class="text-center align-middle colvisHide">개수</th>
							<th class="text-center align-middle colvisHide">COLOR</th>
							<th class="text-center align-middle colvisHide">도수</th>
							<th class="text-center align-middle colvisHide">사이즈</th>
							<th class="text-center align-middle colvisHide">코팅방법</th>
							<th class="text-center align-middle colvisHide">특이사항</th>
							<th class="text-center align-middle colvisHide">성형방식</th>
							<th class="text-center align-middle colvisHide">성형내용</th>
							<th class="text-center align-middle colvisHide">묶음법</th>
							<th class="text-center align-middle colvisHide">묶음단위</th>
							<th class="text-center align-middle colvisHide">포장박스</th>
							<th class="text-center align-middle colvisHide">포장단위</th>
							<th class="text-center align-middle colvisHide">호기</th>			
							<th class="text-center align-middle colvisHide">목형번호</th>
							<th class="text-center align-middle colvisHide">타공목형번호</th>
							<th class="text-center align-middle colvisHide">수지판번호</th>							
							<th class="text-center align-middle colvisHide">현재고량</th>
							<th class="text-center align-middle colvisHide">검수방법</th>
							<th class="text-center align-middle colvisHide">착인여부</th>
							<th class="text-center align-middle colvisHide">사용여부</th>
							<th class="text-center align-middle colvisHide">등록일자</th>
							<th class="text-center align-middle colvisHide">후가공판번호</th>
							<th class="text-center align-middle colvisHide">부분UV</th>
							<th class="text-center align-middle colvisHide">FOIL</th>
							<th class="text-center align-middle colvisHide">형압</th>
							<th class="text-center align-middle colvisHide">FSC</th>
							<th class="text-center align-middle colvisHide">납품처</th>
							<th class="text-center align-middle colvisHide">실적등록</th>
							<th class="text-center align-middle colvisHide">컨펌유무</th>
							<th class="text-center align-middle colvisHide">기타2</th>
							<th class="text-center align-middle colvisHide">기타3</th>
							<th class="text-center align-middle colvisHide">최근 작업일자</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
	<div id="dragbarH" onmousedown="StartDrag('H')"></div>
	<div id="rightcolT">
		<div class="container-fluid h-100" style="padding: 5px;overflow: hidden;">
			<div class="row" id="rightHeader" style="padding-bottom: 5px;">
				<div class="d-flex align-items-center d-flex"></div>
				<div class="me-lg-auto"></div>
				<div class="btn-group" role="group" aria-label="Small button group">
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnNew">
						<i class="fa-solid fa-plus"></i>
					</button>
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnCopy">
						<i class="fa-regular fa-copy"></i>
					</button>
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnSave" disabled>
						<i class="fa-regular fa-floppy-disk"></i>
					</button>
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnEdit" disabled>
						<i class="fa-regular fa-pen-to-square"></i>
					</button>
					<button type="button" class="btn btn-outline-danger w-auto" style="font-size: 17px !important;" id="btnDel" disabled>
						<i class="fa-solid fa-trash-can"></i>
					</button>
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnCancel" disabled>
						<i class="fa-solid fa-xmark"></i>
					</button>
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnClose">
						<i class="fa-solid fa-caret-right"></i>
					</button>
				</div>
			</div>
			<div class="row" id="rightBody">
				<div style="width: 100%;">
					<div class="nav nav-tabs" id="nav-tab">
						<button class="nav-link active" id="tab1Nav" data-bs-toggle="tab" data-bs-target="#tab1">기본정보</button>
						<button class="nav-link d-none" id="tab2Nav" data-bs-toggle="tab" data-bs-target="#tab2">세부정보</button>
						<button class="nav-link" id="tab5Nav" data-bs-toggle="tab" data-bs-target="#tab5">버전이력</button>
						<button class="nav-link" id="tab4Nav" data-bs-toggle="tab" data-bs-target="#tab4">사진 및 첨부파일</button>
						<button class="nav-link" id="tab8Nav" data-bs-toggle="tab" data-bs-target="#tab8">제품수행이력</button>
					</div>
					<div class="tab-content" id="nav-tabContent">
						<div class="tab-pane fade show active" id="tab1">
							<div class="row" style="padding: 5px;overflow: auto;" id="tab1Table">
								<table class="table table-bordered p-0 m-0">
									<colgroup>
										<col width="9.5%">
										<col width="10.5%">
										<col width="9.5%">
										<col width="10.5%">
										<col width="7%">
										<col width="8%">
										<col width="7%">
										<col width="8%">
										<col width="7%">
										<col width="8%">
										<col width="7%">
										<col width="8%">
									</colgroup>
									<tr>
										<th class="text-center align-middle"><span style="color: #ff0000;">*</span>고객사</th>
										<td class="text-center align-middle" colspan='3'>
											<div style="display: flex; flex-wrap: 1 1 auto;" class="input-group">
												<input type="text" class="form-control inputGroup inputNm" id="customerNm" disabled>
												<button type="button" class="inputGroup nameDel" id="btnDealCorpDelete" 
													style="background-color: transparent; border-color: transparent; position: absolute; top: 0; right: 0; margin: 1px 23px; margin-left: 0px; border: none;" disabled>
													<i class="fa-solid fa-xmark"></i>
												</button>
												<input type="hidden" id="customerIdx" class="inputIdx">
												<button type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary input-sub-search inputGroup customerModalBtn" data-gubun="customer" disabled="disabled">
													<i class="fa-solid fa-magnifying-glass"></i>
												</button>
											</div>
										</td>
										<th class="text-center align-middle"><span style="color: #ff0000;">*</span>품목구분</th>
										<td class="text-center align-middle">
											<select class="form-select inputGroup" id="itemGubun" disabled>	</select>
										</td>
										<th class="text-center align-middle">사용여부</th>
										<td class="text-center align-middle">
											<select class="form-select inputGroup" id="useYnCd" disabled>
												<option value="Y" selected>사용</option>
												<option value="N">미사용</option>
											</select>
										</td>
										<th class="text-center align-middle">등록일자</th>
										<td class="text-center align-middle">
											<input type="date" max="9999-12-31" class="form-control inputGroup" id="detailDate" disabled>
										</td>
										<th class="text-center align-middle"><span style="color: #ff0000;">*</span>제품코드</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="itemCd" disabled>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle"><span style="color: #ff0000;">*</span>제품명</th>
										<td class="text-center align-middle" colspan='6'>
											<input type="text"class="form-control inputGroup" id="itemNm" disabled>
										</td>
										<th class="text-center align-middle" colspan='2'>최근작업일자</th>
										<td class="text-center align-middle">
											<input type="date" max="9999-12-31" class="form-control inputGroup" id="lastWorkDate" disabled>
										</td>
										<th class="text-center align-middle">FSC</th>
										<td class="text-center align-middle">
											<select class="form-select inputGroup" id="etc7" disabled></select>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle">자재코드</th>
										<td class="text-center align-middle" colspan='3'>
											<input type="text" class="form-control inputGroup" id="customerItemCd" disabled>
										</td>
										<th class="text-center align-middle"><span style="color: #ff0000;">*</span>버전번호</th>
										<td class="text-center align-middle" colspan='3'>
											<input type="text" class="form-control inputGroup" id="versionNum" disabled>
										</td>
										<td class="text-center align-middle" colspan='2'>
											<div style="display: flex; flex-wrap: 1 1 auto;">
												<input type="text" class="form-control" id="versionFileNm" disabled>
												<button type="button" style="padding: 1px 4px; margin-left: 5px; white-space: nowrap;" class="btn btn-warning input-sub-search inputGroup"
													id="btnVersionFile" disabled="disabled">업로드</button>
												<input class="form-control inputGroup" style="display: none;" type="file" id="versionFile" disabled>
											</div>
										</td>
										<th class="text-center align-middle">착인여부</th>
										<td class="text-center align-middle">
											<select class="form-select inputGroup" id="printingYnCheck" disabled></select>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle">현재고량</th>
										<td class="text-center align-middle" colspan='3'>
											<div style="display: flex; flex-wrap: 1 1 auto;">
												<input type="text" class="form-control inputGroup" id="stock" disabled>
												<button type="button" style="padding: 1px 4px; margin-left: 5px; white-space: nowrap;"
													class="btn btn-warning input-sub-search inputGroup" id="btnStockBtn" disabled="disabled">재고폐기등록</button>
											</div>
										</td>
										<th class="text-center align-middle" style="background-color: rgb(192, 229, 249) !important;">사이즈</th>
										<td class="text-center align-middle" colspan='3'>
											<input type="text" class="form-control inputGroup" id="itemSize" disabled>
										</td>
										<th class="text-center align-middle">칼끝규격</th>
										<td class="text-center align-middle" colspan='3'>
											<input type="text" class="form-control inputGroup" id="knifeTipSize" disabled>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle" style="background-color: rgb(255, 248, 207) !important;">도수</th>
										<td class="text-center align-middle">
											<select class="form-select inputGroup" id="frequency" disabled></select>
										</td>
										<th class="text-center align-middle" style="background-color: rgb(255, 248, 207) !important;">호기</th>
										<td class="text-center align-middle">
											<select class="form-select inputGroup" id="etc1" disabled></select>
										</td>
										<th class="text-center align-middle">COLOR</th>
										<td class="text-center align-middle" colspan='7'>
											<input type="text" class="form-control inputGroup me-1" id="itemColor" disabled>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle" style="background-color: rgb(255, 248, 207) !important;">코팅방법</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="coatingMethod" disabled>
										</td>
										<th class="text-center align-middle" style="background-color: rgb(255, 248, 207) !important;">코팅판번호</th>
										<td class="text-center align-middle">
											<div style="display: flex; flex-wrap: 1 1 auto;" class="input-group">
												<input type="text" class="form-control inputNm" id="resinBoard" disabled>
												<button type="button" class="inputGroup nameDel" id="btnWoodenCareDelete" style="background-color: transparent; border-color: transparent; position: absolute; top: 0; right: 0; margin: 1px 23px; margin-left: 0px; border: none;" disabled>
													<i class="fa-solid fa-xmark"></i>
												</button>
												<input type="hidden" class="form-control inputGroup inputIdx" id="resinBoardIdx" disabled>
												<button type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary input-sub-search inputGroup" id="resinBoardBtn" disabled="disabled">
													<i class="fa-solid fa-magnifying-glass"></i>
												</button>
											</div>
										</td>
										<th class="text-center align-middle" style="background-color: rgb(192, 229, 249) !important;">성형방식</th>
										<td class="text-center align-middle" colspan='2'>
											<input type="text" class="form-control inputGroup" id="moldingMethod" disabled>
										</td>
										<th class="text-center align-middle" style="background-color: rgb(192, 229, 249) !important;">성형내용</th>
										<td class="text-center align-middle" colspan='4'>
											<input type="text" class="form-control inputGroup" id="moldingContents" disabled>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle" style="background-color: rgb(192, 229, 249) !important;">목형번호</th>
										<td class="text-center align-middle">
											<div style="display: flex;" class="input-group">
												<input type="text" class="form-control inputGroup inputNm" id="woodenCareCd" disabled>
												<button type="button" class="inputGroup nameDel" id="btnWoodenCareDelete"
													style="background-color: transparent; border-color: transparent; position: absolute; top: 0; right: 0; margin: 1px 23px; margin-left: 0px; border: none;"
													disabled>
													<i class="fa-solid fa-xmark"></i>
												</button>
												<input type="hidden" class="form-control inputGroup inputIdx" id="woodenCareIdx" disabled>
												<button type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary input-sub-search inputGroup"
													id="woodenCareBtn" disabled="disabled">
													<i class="fa-solid fa-magnifying-glass"></i>
												</button>
											</div>
										</td>
										<th class="text-center align-middle">타공목형번호</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="holeWoodenCd" disabled>
										</td>
										<th class="text-center align-middle" style="background-color: rgb(192, 229, 249) !important;">묶음법</th>
										<td class="text-center align-middle" colspan='2'>
											<select class="form-select inputGroup" id="bundleMethod" disabled></select>
										</td>
										<th class="text-center align-middle">검수방법</th>
										<td class="text-center align-middle" colspan='4'>
											<select class="form-select inputGroup" id="inspectMethod" disabled></select>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle" style="background-color: rgb(250, 220, 233) !important;">부분UV</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="etc3" disabled>
										</td>
										<th class="text-center align-middle" style="background-color: rgb(250, 220, 233) !important;">후가공판번호</th>
										<td class="text-center align-middle">
											<div style="display: flex; flex-wrap: 1 1 auto;" class="input-group">
												<input type="text" class="form-control inputNm" id="etc2Cd" disabled>
												<button type="button" class="inputGroup nameDel" id="afterProcessingDelete"
													style="background-color: transparent; border-color: transparent; position: absolute; top: 0; right: 0; margin: 1px 23px; margin-left: 0px; border: none;" disabled>
													<i class="fa-solid fa-xmark"></i>
												</button>
												<input type="hidden" class="form-control inputGroup inputIdx" id="etc2" disabled>
												<button type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary input-sub-search inputGroup"
													id="afterProcessingBtn" disabled="disabled">
													<i class="fa-solid fa-magnifying-glass"></i>
												</button>
											</div>
										</td>
										<th class="text-center align-middle" style="background-color: rgb(192, 229, 249) !important;">묶음단위</th>
										<td class="text-center align-middle" colspan='2'>
											<input type="text" class="form-control inputGroup" id="bundleUnit" disabled>
										</td>
										<th class="text-center align-middle">실적등록</th>
										<td class="text-center align-middle" colspan='4'>
											<select class="form-select inputGroup" id="etc9" disabled>
												<option value="Y">등록</option>
												<option value="N">미등록</option>
											</select>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle">FOIL</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="etc4" disabled>
										</td>
										<th class="text-center align-middle">기타2</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="etc5" disabled>
										</td>
										<th class="text-center align-middle" style="background-color: rgb(192, 229, 249) !important;">포장단위</th>
										<td class="text-center align-middle" colspan='2'>
											<input type="text" class="form-control inputGroup" id="packUnit" disabled>
										</td>
										<th class="text-center align-middle">납품처</th>
										<td class="text-center align-middle" colspan='4'>
											<div style="display: flex; flex-wrap: 1 1 auto;" class="input-group">
												<input type="text" class="form-control inputNm" id="outCustomerNm" disabled>
												<button type="button" class="inputGroup nameDel btnInputDel" 
													style="background-color: transparent; border-color: transparent; position: absolute; top: 0; right: 0; margin: 1px 23px; margin-left: 0px; border: none;" disabled>
													<i class="fa-solid fa-xmark"></i>
												</button>
												<input type="hidden" id="outCustomerIdx">
												<button type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary input-sub-search inputGroup customerModalBtn" data-gubun="outCustomer" disabled="disabled">
													<i class="fa-solid fa-magnifying-glass"></i>
												</button>
											</div>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle">형압</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="etc6" disabled>
										</td>
										<th class="text-center align-middle">기타3</th>
										<td class="text-center align-middle">
											<input type="text" class="form-control inputGroup" id="pressMethod" disabled>
										</td>
										<th class="text-center align-middle" style="background-color: rgb(192, 229, 249) !important;">포장박스</th>
										<td class="text-center align-middle" colspan='2'>
											<select class="form-select inputGroup" id="packMethod" disabled></select>
										</td>
										<th class="text-center align-middle">컨펌유무</th>
										<td class="text-center align-middle" colspan="4">
											<select class="form-select inputGroup" id="confirmYnCheck" disabled></select>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle">건별전달사항</th>
										<td colspan="11" class="text-center align-middle" style="height: 0;">
											<textarea class="form-control inputGroup" style="resize: none; height: 100%;" id="relayNotice" disabled></textarea>
										</td>
									</tr>
									<tr>
										<th class="text-center align-middle">특이사항</th>
										<td colspan="11" class="text-center align-middle" style="height: 0;">
											<textarea class="form-control resize-none inputGroup" style="resize: none; height: 100%" id="specialNotice" disabled></textarea>
										</td>
									</tr>
								</table>
							</div>
						</div>
						<div class="tab-pane fade" id="tab5">
							<div class="row" style="padding: 5px;">
								<div class="row" style="width: 100%;">
									<div class="d-flex align-items-center justify-content-end w-100" style="margin-bottom: 5px;">
										<input type="text" class="form-control w-auto h-100 me-1" id="searchAllIvh" placeholder="통합검색" >
										<div class="btn-group" role="group" aria-label="Small button group">
											<button type="button" class="d-none btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnVersionNew" disabled>
												<i class="fa-solid fa-plus"></i>
											</button>
											<button type="button" class="d-none btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnVersionSave" disabled>
												<i class="fa-regular fa-floppy-disk"></i>
											</button>
											<button type="button" class="d-none btn btn-outline-danger w-auto" style="font-size: 17px !important;" id="btnVersionDel" disabled>
												<i class="fa-solid fa-trash-can"></i>
											</button>
											<button type="button" class="d-none btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnVersionCancel" disabled>
												<i class="fa-solid fa-xmark"></i>
											</button>
										</div>
									</div>
									<table class="table table-bordered p-0 m-0" id="itemVersionHistoryTable">
										<thead class="table-light">
											<tr>
												<th class="text-center">순번</th>
												<th class="text-center">버전번호</th>
												<th class="text-center">등록일자</th>
												<th class="text-center">파일명</th>
												<th class="text-center">확장자</th>
												<th class="text-center">다운로드</th>
												<th class="text-center align-middle">삭제</th>
											</tr>
										</thead>
									</table>
								</div>
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
											<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnFileSave" disabled>
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
								<div id="imgDiv"
									style="border: 1px solid rgba(94, 166, 230, 1); padding: 5px; margin-left: 5px; width: 49.6%;">
									<div id="imgView">
										<img id="viewer" class="imgView"
											style="object-fit: contain; height: 100px; width: 100px;">
									</div>
								</div>
							</div>
						</div>
						
						<div class="tab-pane fade" id="tab8">
							<div class="row" style="padding: 5px;">
								<div class="row" style="width: 100%;">
									<div class="d-flex align-items-center justify-content-end w-100" style="margin-bottom: 5px;">
										<input type="text" class="form-control w-auto h-100 me-1" id="searchAllIvh" placeholder="통합검색" >
										<div class="btn-group" role="group" aria-label="Small button group">
											<button type="button" class="d-none btn btn-outline-light w-auto" style="font-size: 18px !important;" id="" disabled>
												<i class="fa-solid fa-plus"></i>
											</button>
											<button type="button" class="d-none btn btn-outline-light w-auto" style="font-size: 20px !important;" id="" disabled>
												<i class="fa-regular fa-floppy-disk"></i>
											</button>
											<button type="button" class="d-none btn btn-outline-danger w-auto" style="font-size: 17px !important;" id="" disabled>
												<i class="fa-solid fa-trash-can"></i>
											</button>
											<button type="button" class="d-none btn btn-outline-light w-auto" style="font-size: 20px !important;" id="" disabled>
												<i class="fa-solid fa-xmark"></i>
											</button>
										</div>
									</div>
									<table class="table table-bordered p-0 m-0" id="itemPerformanceHistoryTable">
										<thead class="table-light">
											<tr>
												<th class="text-center align-middle">수주일</th>
												<th class="text-center align-middle">수주번호</th>
												<th class="text-center align-middle">수주량</th>
												<th class="text-center align-middle">버전번호</th>
												<th class="text-center align-middle">출고일</th>
												<th class="text-center align-middle">출고량</th>
												<th class="text-center align-middle">생산량</th>
												<th class="text-center align-middle">건별전달사항</th>
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
	<div id="dragbarVT" onmousedown="StartDrag('VT')" ondblclick="minimum(this)"></div>
	<div id="rightcolM">
		<div class="container-fluid" style="padding: 5px;">
			<div class="row">
				<div style="width: 100%;">
					<div class="nav nav-tabs" id="nav-tab2">
						<button class="nav-link active" id="tab3Nav" data-bs-toggle="tab" data-bs-target="#tab3">공정정보</button>
					</div>
					<div class="tab-content" id="nav-tabContent">
						<div class="tab-pane fade show active" id="tab3">
							<div class="row" style="padding: 5px;">
								<div class="d-flex align-items-center justify-content-end w-100" style="margin-bottom: 5px;">
									<input type="text" class="form-control w-auto h-100 me-1 d-none" id="searchAllPit" placeholder="통합검색" >
									<div class="btn-group me-3" role="group" aria-label="Small button group">
										<button type="button" class="btn btn-outline-light w-auto" id="btnPrcssNew" disabled>라우팅 불러오기</button>
									</div>
									<div class="btn-group" role="group" aria-label="Small button group">
										<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnProcessNew" disabled>
											<i class="fa-solid fa-plus"></i>
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
								<table class="table table-bordered p-0 m-0 " id="processInfoTable">
									<thead class="table-light">
										<tr>
											<th class="text-center" style="vertical-align: middle;">순번</th>
											<th class="text-center" style="vertical-align: middle;">공정코드</th>
											<th class="text-center" style="vertical-align: middle;">공정명</th>
											<th class="text-center" style="vertical-align: middle;">설비정보</th>
											<th class="text-center" style="vertical-align: middle;">외주구분</th>
											<th class="text-center" style="vertical-align: middle;">작업방법</th>
											<th class="text-center" style="vertical-align: middle;">작업세부방법</th>
											<th class="text-center" style="vertical-align: middle;">외주처</th>
											<th class="text-center" style="vertical-align: middle;">단위</th>
											<th class="text-center" style="vertical-align: middle;">비고</th>
											<th class="text-center" style="vertical-align: middle;">주의사항</th>
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
	<div id="dragbarVB" onmousedown="StartDrag('VB')" ondblclick="minimum(this)"></div>
	<div id="rightcolB">
		<div class="container-fluid" style="padding: 5px;">
			<div class="row">
				<div style="width: 100%;">
					<div class="nav nav-tabs" id="nav-tab2">
						<button class="nav-link active" id="tab6Nav" data-bs-toggle="tab" data-bs-target="#tab6">투입자재</button>
						<button class="nav-link" id="tab7Nav" data-bs-toggle="tab" data-bs-target="#tab7">번들링정보</button>
					</div>
					<div class="tab-content" id="nav-tabContent2">
						<div class="tab-pane fade show active" id="tab6">
							<div class="row" style="padding: 5px;">
								<div class="d-flex align-items-center justify-content-end w-100" style="margin-bottom: 5px;">
									<input type="text" class="form-control w-auto h-100 me-1" id="searchAllImt" placeholder="통합검색" >
									<div class="btn-group" role="group" aria-label="Small button group">
										<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnMaterialNew" disabled>
											<i class="fa-solid fa-plus"></i>
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
								<table class="table table-bordered p-0 m-0" id="inputMaterialTable">
									<thead class="table-light">
										<tr>
											<th class="text-center align-middle">원단코드</th>
											<th class="text-center align-middle">재질</th>
											<th class="text-center align-middle">가로</th>
											<th class="text-center align-middle">세로</th>
											<th class="text-center align-middle" style="max-width:80px;">절수</th>
											<th class="text-center align-middle" style="max-width:80px;">개수</th>
											<th class="text-center align-middle" style="max-width:80px;">여분</th>
											<!-- <th class="text-center align-middle">재단규격</th> -->
											<th class="text-center align-middle">매입처</th>
											<!-- <th class="text-center align-middle">비고</th> -->
										</tr>
									</thead>
								</table>
							</div>
						</div>
						<div class="tab-pane fade" id="tab7">
							<div class="row" style="padding: 5px;">
								<div class="d-flex align-items-center justify-content-end w-100" style="margin-bottom: 5px;">
									<input type="text" class="form-control w-auto h-100 me-1" id="searchAllBit" placeholder="통합검색" >
									<div class="btn-group" role="group" aria-label="Small button group">
										<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnBundleNew" disabled>
											<i class="fa-solid fa-plus"></i>
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

<!-- 설비 모달 -->
<div class="modal fade" id="prcssEquipModal" tabindex="-1"
	aria-hidden="true" style="z-index: 9999;">
	<div class="modal-dialog" style="max-width: 60vw;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="prcssEquipModalTitle">공정 설비 조회</h5>
				<div class="btn-group" role="group" aria-label="Small button group">
					<button type="button" class="btn btn-outline-light w-auto"
						style="font-size: 20px !important;" id="btnPrcssEquipModalPaste">
						<i class="fa-regular fa-paste"></i>
					</button>
					<button type="button" class="btn btn-outline-light w-auto"
						style="font-size: 20px !important;" data-bs-dismiss="modal"
						aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>
			</div>
			<div class="modal-body">
				<div class="row" style="padding-bottom: 5px;">
					<div class="d-flex align-items-center d-flex">
						<label
							class="form-label d-flex align-items-center header-label m-0 me-1 h-100">설비
							조회</label> <select class="form-select w-auto h-100 me-3"
							id="prcssEquipSelectGubun" style="min-width: 70px;">
							<option value="prcssEquip">등록된 설비</option>
							<option value="all">모든 설비</option>
						</select>
					</div>
					<div class="me-lg-auto"></div>
					<div class="d-flex align-items-center justify-content-end">
						<div class="btn-group" role="group"
							aria-label="Small button group">
							<button type="button" class="btn btn-outline-light w-auto "
								style="font-size: 18px !important;" id="btnPrcssEquipSearch">
								<i class="fa-regular fa-clipboard"></i>
							</button>
						</div>
					</div>
				</div>
				<table class="table table-bordered p-0 m-0"
					id="prcssEquipModalTable">
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

<!-- 복사 모달 -->
<div class="modal fade" id="copyModal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog" style="max-width: 95vw;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">복사</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="row" id="itemInfoModalSearchDiv" style="padding-bottom: 5px;">
					<div class="d-flex align-items-center d-flex">
						<input type="text" class="form-control w-auto h-100 me-1" id="itemSearchAll" style="min-width:400px;" placeholder="통합검색">
					</div>
					<div class="me-lg-auto"></div>
					<div class="d-flex align-items-center justify-content-end">
						<div class="btn-group" role="group" aria-label="Small button group">
							<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnitemInfoModalSearch"><i class="fa-regular fa-clipboard"></i></button>
						</div>
					</div>
				</div>
				<table class="table table-bordered p-0 m-0" id="itemInfoModalTable">
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
							<th class="text-center align-middle">기타3</th>
							<th class="text-center align-middle">현재고량</th>
							<th class="text-center align-middle">검수방법</th>
							<th class="text-center align-middle">착인여부</th>
							<th class="text-center align-middle">사용여부</th>
							<th class="text-center align-middle">등록일자</th>
							<th class="text-center align-middle">후가공판번호</th>
							<th class="text-center align-middle">부분UV</th>
							<th class="text-center align-middle">FOIL</th>
							<th class="text-center align-middle">기타2</th>
							<th class="text-center align-middle">형압</th>
							<th class="text-center align-middle">컨펌유무</th>
							<th class="text-center align-middle">기타2</th>
							<th class="text-center align-middle">기타3</th>
						</tr>
					</thead>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="copyApply">적용</button>
				<button type="button" class="btn btn-primary" id="copyCancel">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 복사 모달 끝 -->

<!-- 재고폐기 모달 -->
<div class="modal fade" id="stockAddModal" tabindex="-1"
	aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
	<div class="modal-dialog" style="max-width: 60vw;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="stockAddModalTitle">재고폐기 등록</h5>
				<div class="btn-group" role="group" aria-label="Small button group">
					<button type="button" class="btn btn-outline-light w-auto" id="btnDisposalPrint" >폐기 지시서 출력</button>
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnStockAddModalSave">
						<i class="fa-regular fa-floppy-disk"></i>
					</button>
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" data-bs-dismiss="modal" aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>
			</div>
			<div class="modal-body">
				<div class="row" style="padding: 5px;">
					<table class="table table-bordered p-0 m-0">
						<colgroup>
							<col width="20%">
							<col width="30%">
							<col width="20%">
							<col width="30%">
						</colgroup>
						<tr>
							<th class="text-center align-middle">고객사</th>
							<td class="text-center align-middle" id="stockModalCustomer"></td>
							<th class="text-center align-middle">제품명</th>
							<td class="text-center align-middle" id="stockModalitemNm"></td>
						</tr>
						<tr>
							<th class="text-center align-middle">자재코드</th>
							<td class="text-center align-middle"
								id="stockModalCustomerItemCd"></td>
							<th class="text-center align-middle">버전번호</th>
							<td class="text-center align-middle"> <!-- id="stockModalVersionNum" -->
								<select class="form-select" id="stockModalVersionNum">
								</select>
							</td>
						</tr>
						<tr>
							<th class="text-center align-middle">사이즈</th>
							<td class="text-center align-middle" id="stockModalSize"></td>
							<th class="text-center align-middle">현재고량</th>
							<td class="text-end align-middle" id="stockModalStockQty"></td>
						</tr>
						<tr>
							<th class="text-center align-middle">폐기코드</th>
							<td class="text-center align-middle"><select
								class="form-select" id="disposalCd">
							</select></td>
							<th class="text-center align-middle">폐기량</th>
							<td class="text-center align-middle"><input type="text"
								style="text-align: right;" class="form-control" id="disposalQty"
								onkeyup="numberFormat(this,'int')"></td>
						</tr>
						<tr>
							<th rowspan="2" class="text-center align-middle">폐기사유</th>
							<td rowspan="2" colspan="3" class="text-center align-middle">
								<textarea class="form-control"
									style="resize: none; height: 100%;" id="disposalReason"></textarea>
							</td>
						</tr>
						<tr>
						</tr>
						<tr>
							<th class="text-center align-middle">파일첨부</th>
							<td class="text-center align-middle">
								<div style="display: flex; flex-wrap: 1 1 auto;">
									<input type="text" class="form-control" id="disposalFileNm" disabled>
									<button type="button" style="padding: 1px 4px; margin-left: 5px; white-space: nowrap;" class="btn btn-warning input-sub-search" id="btnDisposalFile">업로드
									</button>
									<input class="form-control" style="display: none;" type="file" id="disposalFile">
								</div>
							</td>
							<th class="text-center align-middle">폐기일자</th>
							<td class="text-center align-middle">
								<input type="date" class="form-control" id="disposalDate">
							</td>
						</tr>
						<!-- <tr>
							<th class="text-center align-middle">제조책임자</th>
							<td class="text-center align-middle">
								<div style="display: flex; flex-wrap: 1 1 auto;" class="input-group">
									<input type="text" class="form-control inputGroup inputNm" id="disposalManagerNm" disabled>
									<button type="button" class="btnInputDel" style="background-color: transparent; border-color: transparent; position: absolute; top: 0; right: 0; margin: 1px 23px; margin-left: 0px; border: none;">
										<i class="fa-solid fa-xmark"></i>
									</button>
									<input type="hidden" id="disposalManagerIdx">
									<button type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary input-sub-search" id="btnDisposalManager">
										<i class="fa-solid fa-magnifying-glass"></i>
									</button>
								</div>
							</td>
							<th class="text-center align-middle">QA</th>
							<td class="text-center align-middle">
								<div style="display: flex; flex-wrap: 1 1 auto;" class="input-group">
									<input type="text" class="form-control inputGroup inputNm" id="produceManagerNm" disabled>
									<button type="button" class="btnInputDel" style="background-color: transparent; border-color: transparent; position: absolute; top: 0; right: 0; margin: 1px 23px; margin-left: 0px; border: none;">
										<i class="fa-solid fa-xmark"></i>
									</button>
									<input type="hidden" id="produceManagerIdx">
									<button type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary input-sub-search" id="btnProduceManager">
										<i class="fa-solid fa-magnifying-glass"></i>
									</button>
								</div>
							</td>
						</tr> -->
						<tr>
							<th class="text-center align-middle">비고사항</th>
							<td colspan="3" class="text-center align-middle">
								<input type="text" class="form-control" id="disposalDesc">
							</td>
						</tr>
					</table>
				</div>
				
				<div class="row">
					<table class="table table-bordered p-0 m-0" id="itemVersionDisposalTable">
						<thead class="table-light">
							<tr>
								<th class="text-center align-middle">순번</th>
								<th class="text-center align-middle">버전번호</th>
								<th class="text-center align-middle">현재고</th>
							</tr>
						</thead>
					</table>
				</div>				
				
			</div>
		</div>
	</div>
</div>
<!-- 재고폐기 모달 끝 -->

<!-- 제품명 중복 경고 -->
<div class="modal fade" id="itemNmCheckModal" tabindex="-1" aria-hidden="true" style="z-index: 9999;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">
					<i class="fa-solid fa-triangle-exclamation text-danger"></i> <spring:message code="modal.warning" text="default text" />
				</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				중복 제품명이 있습니다.<br>
				이대로 진행 하시겠습니까?
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" id="btnItemNmCheckModalY" data-bs-dismiss="modal" style="width: 70px;">
					<spring:message code="yes" text="default text" />
				</button>
				<button type="button" class="btn btn-secondary" id="btnItemNmCheckModalN" data-bs-dismiss="modal" style="width: 70px;">
					<spring:message code="no" text="default text" />
				</button>
			</div>
		</div>
	</div>
</div>
<!-- 제품명 중복 경고 모달 끝 -->

<!-- 폐기지시서 모달 -->
<div class="modal fade" id="disposalReportModal" tabindex="-1" aria-hidden="true" style="z-index: 9999;">
	<div class="modal-dialog" style="max-width: 60vw;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" >폐기지시서 모달</h5>
			</div>
			<div class="modal-body">
				<div class="row" style="padding-bottom: 5px;">
					<table id="disposalReportTable" class="table table-bordered m-0 d-none" style="border:1px solid #ffffff;">
						<colgroup id="trDisposalAppendTarget">
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
<!-- 폐기지시서 모달 끝 -->

<!-- 화면설정 script -->
<script>
	let isDraggingVT = false; // 세로 드레그 여부
	let isDraggingVB = false; // 세로 드레그 여부
	let isDraggingV = false; // 세로 드래그 여부
	let isDraggingH = false; // 가로 드레그 여부
	
	function SetCursor(cursor) {
		let page = document.getElementById("page");
		page.style.cursor = cursor;
	}
	
	function StartDrag(type) {
		if(type == 'VT') { isDraggingVT = true; SetCursor("n-resize");}
		if(type == 'VB') { isDraggingVB = true; SetCursor("n-resize");}
		if(type == 'V') { isDraggingV = true; SetCursor("n-resize");}
		if(type == 'H') { isDraggingH = true; SetCursor("ew-resize");}
	}
	
	function EndDrag(e) {
		if(isDraggingVT || isDraggingVB || isDraggingH || isDraggingV) {
		//if(isDraggingV || isDraggingH) {
			dataTableDrawAll(); // dataTable 전체 reload
			isDraggingVT = false;
			isDraggingVB = false;
			isDraggingV = false;
			isDraggingH = false;
			SetCursor("auto");
		}
	}

	function minimum(node) {
		let id = $(node).attr('id');

		if(id == 'dragbarV') {
			let dragbarWidth = 4;

			let page_height = parseInt($('#page').height()); 			// 전체 높이
			let rightcolT_height = parseInt($('#rightcolT').height());	// 우측 상단
			let rightcolB_height = parseInt($('#rightcolB').height());	// 우측 하단

			let rightcolT_min_height = 100;	// 우측 상단 최소높이
			let rightcolB_min_height = 34;	// 우측 하단 최소높이

			let dragbarV_height = 4;

			let cols = [];

			//최소화기능만 적용
			cols = [
				page_height - rightcolB_min_height - dragbarWidth,
				dragbarWidth,
				rightcolB_min_height
			];
			
			let newColDefn = cols.map(c => c.toString() + "px").join(" ");
			
			$('#page').css('grid-template-rows',newColDefn);
		}
		
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
		dataTableDrawAll(); // dataTable 전체 reload */
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
			let rightcolMinWidth = 500; // rightcol 최소사이즈
			
			let cursorX = event.clientX;	// 현재 cursor x좌표(좌측에서부터 얼마나 떨어졌는지)
	
			let cols = [
				Math.min(Math.max(leftcolMinWidth, cursorX), page_width - rightcolMinWidth - dragbarWidth),
				dragbarWidth,
				Math.max(page_width - Math.max(leftcolMinWidth, cursorX), rightcolMinWidth) - dragbarWidth
			];
	
			let newColDefn = cols.map(c => c.toString() + "px").join(" ");
	
			page.style.gridTemplateColumns = newColDefn;
	
			event.preventDefault();
		} else if (isDraggingV) { // rightcolT와 rightcolB 사이
			let dragbarWidth = 4;

			let page_height = parseInt($('#page').height()); 			// 전체 높이
			let rightcolT_height = parseInt($('#rightcolT').height());	// 우측 상단
			let rightcolB_height = parseInt($('#rightcolB').height());	// 우측 하단

			let rightcolT_min_height = 100;	// 우측 상단 최소높이
			let rightcolB_min_height = 34;	// 우측 하단 최소높이

			let cursorY = event.clientY;	// 현재 cursor y좌표(위에서부터 얼마나 떨어졌는지)
			
			let cols = [
				Math.min(Math.max(rightcolT_min_height, cursorY), page_height - rightcolB_min_height - dragbarWidth),
				dragbarWidth,
				page_height - dragbarWidth - Math.min(Math.max(rightcolT_min_height, cursorY), page_height - rightcolB_min_height - dragbarWidth),
			];
			
			let newColDefn = cols.map(c => c.toString() + "px").join(" ");

			$('#page').css('grid-template-rows',newColDefn);
	
			event.preventDefault();
		} else if (isDraggingVT) { // rightcolT와 rightcolM 사이
			let dragbarWidth = 4;

			let page_height = parseInt($('#page').height()); 			// 전체 높이
			let rightcolT_height = parseInt($('#rightcolT').height());	// 우측 상단
			let rightcolM_height = parseInt($('#rightcolM').height());	// 우측 중단
			let rightcolB_height = parseInt($('#rightcolB').height());	// 우측 하단

			let rightcolT_min_height = 100;	// 우측 상단 최소높이
			let rightcolM_min_height = 0;	// 우측 중단 최소높이
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

			$('#tab1Table').css('height', (parseInt($('#rightcolT').css('height')) - parseInt($('#rightHeader').css('height')) - parseInt($('#nav-tab').css('height')) - 12) + 'px'); 

			event.preventDefault();
		} else if (isDraggingVB) { // 상하 스크롤
			let dragbarWidth = 4;

			let page_height = parseInt($('#page').height()); 			// 전체 높이
			let rightcolT_height = parseInt($('#rightcolT').height());	// 우측 상단
			let rightcolM_height = parseInt($('#rightcolM').height());	// 우측 중단
			let rightcolB_height = parseInt($('#rightcolB').height());	// 우측 하단

			let rightcolT_min_height = 100;	// 우측 상단 최소높이
			let rightcolM_min_height = 0;	// 우측 중단 최소높이
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
			$('#page').css('grid-template-columns', '8fr 4px 10fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcolT').removeClass('d-none');
		} else {
			$('#page').css('grid-template-columns', '0fr 4px 10fr');
			$('#leftcol').addClass('d-none');
			$('#rightcolT').removeClass('d-none');
		}
		dataTableDrawAll(); // dataTable 전체 reload
	});
	
	$('#btnClose').on('click',function() { // right-box 닫기버튼 클릭
		if($('#leftcol').hasClass('d-none')){
			$('#page').css('grid-template-columns', '8fr 4px 10fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcolT').removeClass('d-none');
		} else {
			$('#page').css('grid-template-columns', '8fr 4px 0fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcolT').addClass('d-none');
		}
		dataTableDrawAll(); // dataTable 전체 reload
	});
	
</script>

<script>
	WM_init('new');
	WM_init('edit');
	WM_init('versionNew');
	WM_init('fileNew');
	WM_init('matrlNew');
	WM_init('prcssNew');
	WM_init('bundleNew');
	
	// 공통코드 조회
	let itemGubunList = getCommonCode('일반', '001'); // 제품구분
	let woodenList = getCommonCode('일반', '004'); // 목형번호
	let bundleList = getCommonCode('일반', '005'); // 묶음코드
	let printingYnCheckList = getCommonCode('일반', '008'); // 착인여부점검
	let confirmYnCheckList = getCommonCode('일반', '040'); // 컨펌유무
	let inspectMethodList = getCommonCode('일반', '009'); // 검수방법
	let dealGubunList = getCommonCode('시스템', '011'); // 거래구분
	let dealCorpStatusList = getCommonCode('시스템', '015'); // 거래상태
	let packMethodList = getCommonCode('일반', '013'); // 포장방법
	let outsrcGubunList = getCommonCode('일반', '024'); // 외주구분
	let frequencyList = getCommonCode('일반', '036'); // 도수
	let etc1List = getCommonCode('일반', '037'); // 호기
	let disposalList = getCommonCode('일반', '038'); //폐기구분
	let etc7List = getCommonCode('시스템', '041'); //fsc
	let pageLengthCnt = parseInt(getCommonCode('시스템', '025')[0].commonCd); //페이징수량
	let useYnCdList = getCommonCode('시스템', '055'); // 사용여부
	
	selectBoxAppend(itemGubunList, 'itemGubun', '', '2'); //포장방법
	selectBoxAppend(woodenList, 'woodenCareCd', '', '2'); //목형관리번호
	selectBoxAppend(bundleList, 'bundleMethod', '', '2'); //묶음법
	selectBoxAppend(printingYnCheckList, 'printingYnCheck', '', '2'); //착인여부점검
	selectBoxAppend(confirmYnCheckList, 'confirmYnCheck', '', '2'); //컨펌유무
	selectBoxAppend(dealGubunList, 'modalDealGubun', '', '1'); //거래구분
	selectBoxAppend(dealCorpStatusList, 'modalDealCorpStatus', '', '1'); //거래상태
	selectBoxAppend(inspectMethodList, 'inspectMethod', '', '2'); //검수방법
	selectBoxAppend(packMethodList, 'packMethod', '', '2'); //포장방법
	selectBoxAppend(frequencyList, 'frequency', '', '2'); //도수
	selectBoxAppend(etc1List, 'etc1', '', '2'); //호기
	//selectBoxAppend(etc1List, 'etc4', '', '2'); //후가공호기
	selectBoxAppend(disposalList, 'disposalCd', '', '2'); //폐기구분
	selectBoxAppend(etc7List, 'etc7', '', '2'); //fsc
	selectBoxAppend(itemGubunList, 'modalItemGubunBox', '', '1'); //제품구분
	selectBoxAppend(useYnCdList, 'modalUseYnCdBox', 'Y', '1'); //사용여부
	
	let sessionUserNm = "${userNm}";//세션에서 가져온 유저이름
	let sessionUserIdx = "${userIdx}";//세션에서 가져온 유저식별자
	let itemIdx=0;
	let formData = new FormData(); //파일 전용 폼데이터
	let idValue=0;	
	let delStatus = '';
	let trId = '';
	
	//날짜
	let today = new Date();   
	let year = today.getFullYear(); // 년도
	let month = ( '0' + (today.getMonth() + 1) ).slice(-2) ;  // 월
	let date = ('0' + today.getDate()).slice(-2);  // 날짜
	let todayVal = year + '-' + month + '-' + date; // 오늘날짜 YYYY-MM-DD형태
	$('#priceDate').val(moment().format('YYYY-MM-DD'));
	let prcssEquipList = [];
	//페이지 접속시 화면 보정, 설비정보 불러오기
	$(document).ready(function(){
		 /* cols = [
			parseInt($('#rightBody').css('height')) + parseInt($('#rightHeader').css('height')) + 10,
			4,
			(parseInt($('#page').css('height'))-8-(parseInt($('#rightBody').css('height')) + parseInt($('#rightHeader').css('height')) + 10))/2,
			4,
			(parseInt($('#page').css('height'))-8-(parseInt($('#rightBody').css('height')) + parseInt($('#rightHeader').css('height')) + 10))/2
		];
		let newColDefn = cols.map(c => c.toString() + "px").join(" ");
		
		$('#page').css('grid-template-rows',newColDefn); */

		$('#tab1Table').css('height', (parseInt($('#rightcolT').css('height')) - parseInt($('#rightHeader').css('height')) - parseInt($('#nav-tab').css('height')) - 12) + 'px'); 
		 
		inputMaterialTable.draw(false);

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
		if(WMlastIdx == 'new' || WMlastIdx == 'edit') { // 등록중이거나 수정중이였을 경우
			$('#btnSave').trigger('click');
			return false;
		} else if(WMlastIdx == 'fileNew'){ //파일 등록중이었을 때
			$('#btnFileSave').trigger('click');
			return false;
		} else if(WMlastIdx == 'matrlNew'){ //투입자재 등록중이었을 때
			$('#btnMaterialSave').trigger('click');
			return false;
		}  else if(WMlastIdx == 'prcssNew'){ //공정 등록중이었을 때
			$('#btnProcessSave').trigger('click');
			return false;
		}   else if(WMlastIdx == 'bundleNew'){ //번등 등록중
			$('#btnBundleSave').trigger('click');
			return false;
		} 
	});

	// 작업중 경고 모달 아니요 버튼 click
	$('#btnWorkingWarningModalN').on('click', function() {
		if(WMlastIdx == 'new' || WMlastIdx == 'edit') { // 등록중이거나 수정중이였을 경우
			if(getWM(WMlastIdx, 'idx') != '' && getWM(WMlastIdx, 'idx') != undefined) {
				let idx = getWM(WMlastIdx, 'idx');
				WM_action_OFF('new');
				WM_action_OFF('edit');
				WM_action_OFF('fileNew');
				WM_action_OFF('prcssNew');
				WM_action_OFF('matrlNew');
				WM_action_OFF('bundleNew');
				setWM(WMlastIdx, 'idx', '');
				itemInfoTable.row('#'+idx).select();
				$(itemInfoTable.row('#'+idx).node()).trigger('click'); // 선택했던 항목 선택처리
			} else {
				WM_action_OFF('new');
				WM_action_OFF('edit');
				WM_action_OFF('fileNew');
				WM_action_OFF('prcssNew');
				WM_action_OFF('matrlNew');
				WM_action_OFF('bundleNew');
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
		}  else if(WMlastIdx == 'fileNew'){ //파일등록중이었을 때 
			if(getWM(WMlastIdx, 'idx') != '' && getWM(WMlastIdx, 'idx') != undefined) {
				let idx = getWM(WMlastIdx, 'idx');
				WM_action_OFF('new');
				WM_action_OFF('edit');
				WM_action_OFF('fileNew');
				WM_action_OFF('prcssNew');
				WM_action_OFF('matrlNew');
				WM_action_OFF('bundleNew');
				setWM(WMlastIdx, 'idx', '');
				itemInfoTable.row('#'+idx).select();
				$(itemInfoTable.row('#'+idx).node()).trigger('click'); // 선택했던 항목 선택처리
				
				$('#btnFileAdd').attr('disabled',true);
				$('#btnFileSave').attr('disabled',true);
				$('#btnFileDel').attr('disabled',true);
			} else {

				WM_action_OFF('new');
				WM_action_OFF('edit');
				WM_action_OFF('fileNew');
				WM_action_OFF('prcssNew');
				WM_action_OFF('matrlNew');
				WM_action_OFF('bundleNew');
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
		} else if(WMlastIdx == 'prcssNew'){ //공정 등록중이었을 때 
			if(getWM(WMlastIdx, 'idx') != '' && getWM(WMlastIdx, 'idx') != undefined) {
				let idx = getWM(WMlastIdx, 'idx');
				WM_action_OFF('new');
				WM_action_OFF('edit');
				WM_action_OFF('fileNew');
				WM_action_OFF('prcssNew');
				WM_action_OFF('matrlNew');
				WM_action_OFF('bundleNew');
				setWM(WMlastIdx, 'idx', '');
				itemInfoTable.row('#'+idx).select();
				$(itemInfoTable.row('#'+idx).node()).trigger('click'); // 선택했던 항목 선택처리
			} else {

				WM_action_OFF('new');
				WM_action_OFF('edit');
				WM_action_OFF('fileNew');
				WM_action_OFF('prcssNew');
				WM_action_OFF('matrlNew');
				WM_action_OFF('bundleNew');
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
		} else if(WMlastIdx == 'matrlNew'){ //자재 등록중이었을 때
			if(getWM(WMlastIdx, 'idx') != '' && getWM(WMlastIdx, 'idx') != undefined) { 
				let idx = getWM(WMlastIdx, 'idx');
				WM_action_OFF('new');
				WM_action_OFF('edit');
				WM_action_OFF('fileNew');
				WM_action_OFF('prcssNew');
				WM_action_OFF('matrlNew');
				WM_action_OFF('bundleNew');
				setWM(WMlastIdx, 'idx', '');
				itemInfoTable.row('#'+idx).select();
				$(itemInfoTable.row('#'+idx).node()).trigger('click'); // 선택했던 항목 선택처리
			} else {
				WM_action_OFF('new');
				WM_action_OFF('edit');
				WM_action_OFF('fileNew');
				WM_action_OFF('prcssNew');
				WM_action_OFF('matrlNew');
				WM_action_OFF('bundleNew');
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
		} else if(WMlastIdx == 'bundleNew'){ //번들등록 중일때
			if(getWM(WMlastIdx, 'idx') != '' && getWM(WMlastIdx, 'idx') != undefined) { 
				let idx = getWM(WMlastIdx, 'idx');
				WM_action_OFF('new');
				WM_action_OFF('edit');
				WM_action_OFF('fileNew');
				WM_action_OFF('prcssNew');
				WM_action_OFF('matrlNew');
				WM_action_OFF('bundleNew');
				setWM(WMlastIdx, 'idx', '');
				itemInfoTable.row('#'+idx).select();
				$(itemInfoTable.row('#'+idx).node()).trigger('click'); // 선택했던 항목 선택처리
			} else {
				WM_action_OFF('new');
				WM_action_OFF('edit');
				WM_action_OFF('fileNew');
				WM_action_OFF('prcssNew');
				WM_action_OFF('matrlNew');
				WM_action_OFF('bundleNew');
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

				$('#btnBundleNew').attr('disabled',false);
				$('#btnBundleSave').attr('disabled',true);
				$('#btnBundleEdit').attr('disabled',false);
				$('#btnBundleDel').attr('disabled',false);
				$('#btnBundleCancel').attr('disabled',true);
				
				$('#btnFileAdd').attr('disabled',true);
				$('#btnFileDel').attr('disabled',true);
			}
		}
		
	});

	// 삭제 경고창 삭제 버튼 click
	$('#btnDeleteModalY').on('click', function() {
		//버전이력삭제
		if ( delStatus == 'version' ) {
			const trData = itemVersionHistoryTable.row('.selected').data();
			let idx = trData.idx;
			$.ajax({
				url: '<c:url value="/bm/itemVersionDelete"/>',
	            type: 'POST',
	            async: false,
	            data: {
	                'idx'	:	function(){ return idx; }
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if(res.result == 'ok'){
						toastr.success('삭제되었습니다.');
						//서버에 남아있는 파일 삭제
						let uuid = trData.uuid;
						let ext = trData.ext;
						fileDelete({uuid:uuid,ext:ext});
						
						//$('#btnSearch').trigger('click'); // 조회버튼 click
						$('.inputGroup').val('');
						
						$('.inputGroup').attr('disabled', true); // 입력항목
						$('#btnUserIdCheck').attr('disabled', true); // 중복확인 버튼
					
						$('#btnNew').attr('disabled', false); // 신규 버튼
						$('#btnSave').attr('disabled', true); // 저장 버튼
						$('#btnEdit').attr('disabled', true); // 수정 버튼
						$('#btnDel').attr('disabled', true); // 삭제 버튼
						$('#btnCancel').attr('disabled', true); // 취소 버튼
						//테이블 리로드
						//itemVersionHistoryTable.ajax.reload(function(){});
						trId =  itemInfoTable.row('.selected').data().idx;
						itemInfoTable.rows('.selected').deselect();
						itemInfoTable.ajax.reload(function(){
							setTimeout(function() {
								itemInfoTable.row('#'+trId).select();
								$(itemInfoTable.row('#'+trId).node()).trigger('click'); // 복사된거 선택처리
							}, 100)
								
						},false);
					} else if(res.result == 'fail') {
						toastr.warning(res.message);
					} else {
						toastr.error(res.message);
					}
					$('#my-spinner').hide();
				}
			});
		} else if ( delStatus == 'versionFileDel' ) {
			const trData = itemVersionHistoryTable.row('.selected').data();
			let idx = trData.idx;
			$.ajax({
				url: '<c:url value="/bm/itemVersionUpdate"/>',
	            type: 'POST',
	            async: false,
	            data: {
	                'idx'	:	function(){ return idx; }
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if(res.result == 'ok'){
						toastr.success('파일이 삭제되었습니다.');
						//서버에 남아있는 파일 삭제
						let uuid = trData.uuid;
						let ext = trData.ext;
						fileDelete({uuid:uuid,ext:ext});
						
						//$('#btnSearch').trigger('click'); // 조회버튼 click
						$('.inputGroup').val('');
						
						$('.inputGroup').attr('disabled', true); // 입력항목
						$('#btnUserIdCheck').attr('disabled', true); // 중복확인 버튼
					
						$('#btnNew').attr('disabled', false); // 신규 버튼
						$('#btnSave').attr('disabled', true); // 저장 버튼
						$('#btnEdit').attr('disabled', true); // 수정 버튼
						$('#btnDel').attr('disabled', true); // 삭제 버튼
						$('#btnCancel').attr('disabled', true); // 취소 버튼
						//테이블 리로드
						//itemVersionHistoryTable.ajax.reload(function(){});
						trId =  itemInfoTable.row('.selected').data().idx;
						itemInfoTable.rows('.selected').deselect();
						itemInfoTable.ajax.reload(function(){
							setTimeout(function() {
								itemInfoTable.row('#'+trId).select();
								$(itemInfoTable.row('#'+trId).node()).trigger('click'); // 복사된거 선택처리
							}, 100)
								
						},false);
					} else if(res.result == 'fail') {
						toastr.warning(res.message);
					} else {
						toastr.error(res.message);
					}
					$('#my-spinner').hide();
				}
			});
		} else if( delStatus == 'file' ) {
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
		} else if( delStatus == 'inputMatrl' ) {
			let idx = inputMaterialTable.row('.selected').data().idx;
			$.ajax({
				url: '<c:url value="/bm/itemBomDelete"/>',
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

						$('#inputMaterialTable').DataTable().row('.selected').remove().draw();
					} else if(res.result == 'fail') {
						toastr.warning(res.message);
					} else {
						toastr.error(res.message);
					}
					$('#my-spinner').hide();
				}
			});
		} else if( delStatus == 'prcss' ) {
			let idx = processInfoTable.row('.selected').data().idx;
			$.ajax({
				url: '<c:url value="/bm/itemPrcssDelete"/>',
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
					} else if(res.result == 'fail') {
						toastr.warning(res.message);
					} else {
						toastr.error(res.message);
					}
					$('#my-spinner').hide();
				}
			});
		} else if( delStatus == 'bundle' ) {
			let idx = bundleInfoTable.row('.selected').data().idx;
			$.ajax({
				url: '<c:url value="/bm/bundleInfoDelete"/>',
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

						$('#bundleInfoTable').DataTable().row('.selected').remove().draw();
					} else if(res.result == 'fail') {
						toastr.warning(res.message);
					} else {
						toastr.error(res.message);
					}
					$('#my-spinner').hide();
				}
			});
		} else if(delStatus == 'item'){
			let idx = itemInfoTable.row('.selected').data().idx;
			$.ajax({
				url: '<c:url value="/bm/itemInfoDelete"/>',
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
						$('#tab1Nav').trigger('click');
						$('#tab6Nav').trigger('click');
						$('#itemInfoTable').DataTable().row('.selected').remove().draw();
						$('#itemInfoTable').DataTable().row('.selected').deselect();
						$('.inputGroup').val('');
						$('#fileTable').DataTable().clear().draw();//파일테이블 
						$('#itemVersionHistoryTable').DataTable().clear().draw();//버전테이블
						$('#itemPerformanceHistoryTable').DataTable().clear().draw();//제품수행이력테이블
						$('#processInfoTable').DataTable().clear().draw();//공정테이블
						$('#inputMaterialTable').DataTable().clear().draw();//투입자재테이블
						$('#bundleInfoTable').DataTable().clear().draw();//번들링테이블
						$('#versionFileNm').val('');
						$('#btnNew').attr('disabled', false); // 신규 버튼
						$('#btnSave').attr('disabled', true); // 저장 버튼
						$('#btnEdit').attr('disabled', true); // 수정 버튼
						$('#btnDel').attr('disabled', true); // 삭제 버튼
						$('#btnCancel').attr('disabled', true); // 취소 버튼
						$('#btnStockBtn').attr('disabled',true);//재고폐기등록버튼

						//공정정보
						$('#btnProcessNew').attr('disabled',true);//공정
						$('#btnProcessSave').attr('disabled',true);
						$('#btnProcessEdit').attr('disabled',true);
						$('#btnProcessDel').attr('disabled',true);
						$('#btnProcessCancel').attr('disabled',true);
						//버전이력
						//사진 및 첨부
						$('#btnFileAdd').attr('disabled',true);//파일추가 신규 버튼
						$('#btnFileDel').attr('disabled',true);//파일삭제 버튼
						$('#btnVersionNew').attr('disabled',true);//버전이력 신규 버튼
						$('#btnVersionDel').attr('disabled',true);//버전이력 삭제 버튼
						//투입자재
						$('#btnMaterialNew').attr('disabled',true);//투입자재
						$('#btnMaterialSave').attr('disabled',true);
						$('#btnMaterialEdit').attr('disabled',true);
						$('#btnMaterialDel').attr('disabled',true);
						$('#btnMaterialCancel').attr('disabled',true);
						//번들
						$('#btnBundleNew').attr('disabled',true);
						$('#btnBundleSave').attr('disabled',true);
						$('#btnBundleEdit').attr('disabled',true);
						$('#btnBundleDel').attr('disabled',true);
						$('#btnBundleCancel').attr('disabled',true);
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
	
	let CancelIdx = '';
	// 취소 버튼 click
	$('#btnCancel').on('click', function() {
		CancelIdx = 'new';
		$('#cancelModal').modal('show');
	});
	$('#btnProcessCancel').on('click', function() {
		CancelIdx = 'prcssNew';
		$('#cancelModal').modal('show');
	});
	$('#btnMaterialCancel').on('click', function() {
		CancelIdx = 'matrlNew';
		$('#cancelModal').modal('show');
	});
	
	// 취소 경고창 취소 버튼 click
	$('#btnCancelModalY').on('click', function() {
		toastr.success('취소되었습니다.');
		if(CancelIdx == 'new') {
			WM_action_OFF('new');
			WM_action_OFF('edit');
	
			$('.inputGroup').attr('disabled', true); // 입력항목
			$('#btnUserIdCheck').attr('disabled', true); // 중복확인 버튼
			$('#btnSignImage').attr('disabled', true); // 사진선택 버튼
			
			$('#btnNew').attr('disabled', false); // 신규 버튼
			$('#btnSave').attr('disabled', true); // 저장 버튼
			$('#btnEdit').attr('disabled', true); // 수정 버튼
			$('#btnCopy').attr('disabled', false); // 복사 버튼
			$('#btnCancel').attr('disabled', true); // 취소 버튼
	
			$('#btnFileAdd').attr('disabled',true);
			$('#btnFileDel').attr('disabled',true);
					
			$('#btnStockBtn').attr('disabled',true);//재고폐기등록버튼

			$('#btnVersionNew').attr('disabled', true);
			$('#btnVersionSave').attr('disabled', true);
			$('#btnVersionDel').attr('disabled', true);
			$('#btnVersionCancel').attr('disabled', true);
			
		} else if(CancelIdx == 'fileNew'){
			WM_action_OFF('fileNew');
			$('#btnFileAdd').attr('disabled', true);
			$('#btnFileDel').attr('disabled', true);
			fileTable.ajax.reload();
		} else if(CancelIdx == 'prcssNew'){
			WM_action_OFF('prcssNew');
			processInfoTable.ajax.reload(function(){
				$('button[name=customerModalBtn]').attr('disabled',true);
				$('button[name=equipModalBtn]').attr('disabled',true);
				

				$('#my-spinner').hide();
				setTimeout(function() {
					processInfoTable.draw(false);
				},100);
			});
			$('#btnProcessNew').attr('disabled', false);
			$('#btnProcessSave').attr('disabled', true);
			$('#btnProcessEdit').attr('disabled', false);
			$('#btnProcessDel').attr('disabled', false);
			$('#btnProcessCancel').attr('disabled', true);
		} else if(CancelIdx == 'matrlNew'){
			WM_action_OFF('matrlNew');
			
			$('#btnMaterialNew').attr('disabled', false);
			$('#btnMaterialSave').attr('disabled', true);
			$('#btnMaterialDel').attr('disabled', false);
			$('#btnMaterialEdit').attr('disabled', false);
			$('#btnMaterialCancel').attr('disabled', true);
			
			inputMaterialTable.ajax.reload(function(){
				$('#my-spinner').show();
				//발주처 selectbox append
				$('#inputMaterialTable tbody tr').each(function(index){
					if(inputMaterialTable.row(index).data() != null && inputMaterialTable.row(index).data() != undefined){
						$.ajax({
							url : '<c:url value="/bm/matrlDealInfoListAll"/>',
							type : 'GET',
							async : false,
							data : {
								'matrlIdx' : function(){ return inputMaterialTable.row(index).data().matrlIdx; },
							},
							beforeSend: function() {
				            	$('#my-spinner').show();
				            },
					        success: function(res){
					        	if(res.result == "ok"){
						        	let data = res.data; 
						        	let html2 = '';
						        	html2 += '<select class="form-select inputGroup" name="dealCorpNm" disabled>';
						        	html2 += '<option value="">선택</option>';
									for(let i=0;i<data.length;i++){
										if(data[i].mainDealCorp == 'Y'){
											html2 += '<option value="'+data[i].dealCorpIdx+'">' + data[i].dealCorpNm + '</option>';
										} else {
											html2 += '<option value="'+data[i].dealCorpIdx+'">' + data[i].dealCorpNm + '</option>';
										}
									}
									html2 += '</select>';
									$('#inputMaterialTable tbody tr').eq(index).find('td').eq(9).html(html2);
									if(inputMaterialTable.row(index).data().dealCorpIdx != null && inputMaterialTable.row(index).data().dealCorpIdx != ''){
										$('#inputMaterialTable tbody tr').eq(index).find('td').eq(9).find('select').val(inputMaterialTable.row(index).data().dealCorpIdx);
									}
							
					        	}
					        	else{
					        		toastr.error(result.message);
					        	}
					        },
						}); 
					}
				});
				$('#my-spinner').hide();
			});
		} else if(CancelIdx == 'bundle'){
			WM_action_OFF('bundleNew');
			bundleInfoTable.ajax.reload(function(){});
			$('#btnBundleNew').attr('disabled',false);
			$('#btnBundleSave').attr('disabled',true);
			$('#btnBundleEdit').attr('disabled',false);
			$('#btnBundleDel').attr('disabled',false);
			$('#btnBundleCancel').attr('disabled',true);
		}
		
	});
	
	// 품목정보 목록조회
	$('#itemInfoTable thead tr').clone(true).addClass('filters').appendTo('#itemInfoTable thead'); // filter 생성
	let itemInfoTable = $('#itemInfoTable').DataTable({
		dom : "<'row'<'col-md-12 col-md-6'l><'col-md-12 col-md-6'f>>"
			+ "<'row'<'col-md-12'tr>>"
			+ "<'row pt-1'<'d-flex align-items-center d-flex col-md-5 col-sm'B><'me-lg-auto div-align-center col-md-3 col-sm'p><'d-flex align-items-center justify-content-end col-md-4 col-sm'i>>",
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
				'useYnCd' : function(){ return $('#searchUseYnCd').val();}, 
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'customerNm', className : 'text-center align-middle'}, //고객사
			{ data: 'itemNm', className : 'text-center align-middle'}, //제품명
			{ //공정수
				data: 'prcssCnt', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+addCommas(parseFloat(data))+'</div>';
					} else {
						return "";
					}
				}
			},
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
						return data;
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
			{ //포장박스
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
			{ //착인여부
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
			{ data: 'etc7', className : 'text-center align-middle'}, //FSC
			{ data: 'etc8', className : 'text-center align-middle'}, //납품처
			{ data: 'etc9', className : 'text-center align-middle'}, //실적등록
			{ data: 'etc10', className : 'text-center align-middle'}, //컨펌유무
			{ data: 'etc5', className : 'text-center align-middle'}, //기타2
			{ data: 'pressMethod', className : 'text-center align-middle'},	//기타3
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
			{ extend: 'colvisGroup',	className: 'd-none',	hide: '.colvisHide'},
			{ extend: 'colvis',	text: 'Select Col',	},
		],
		order : [],
		drawCallback: function() {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#itemInfoTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 79)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAll').off('keyup',function() {});
			$('#searchAll').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			});
			/* console.timeEnd('bmsc0030 itemInfo 조회');
			console.timeEnd(table_id+' 전체 드로우 '); */
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
			api.button(3).trigger();
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

	let formData4 = new FormData();
	let versionFileStatus = false;
	let fileUuid = '';
	let fileExt = '';
	let fileNm = '';
	//제품테이블 클릭
	$('#itemInfoTable tbody').on('click','tr', function() {
		let idx = itemInfoTable.row(this).data().idx;		
		if(WMCheck('new')) { // 신규등록중일 경우
			setWM('new', 'idx', idx);
			return false;
		}
		if(WMCheck('edit')) { // 수정중일 경우
			setWM('edit', 'idx', idx);
			return false;
		}		
		if(WMCheck('fileNew')) { // 파일 등록중일 경우
			setWM('fileNew', 'idx', idx);
			return false;
		}
		if(WMCheck('matrlNew')) { // 투입자재 등록중일 경우
			setWM('matrlNew', 'idx', idx);
			return false;
		}
		if(WMCheck('prcssNew')) { // 공정 등록중일 경우
			setWM('prcssNew', 'idx', idx);
			return false;
		}
		if(WMCheck('bundleNew')) { // 번들등록중
			setWM('bundleNew', 'idx', idx);
			return false;
		}
		itemIdx = idx;
		formData = new FormData();
		bundleInfoTable.ajax.reload();
		processInfoTable.ajax.reload(function(){
			$('button[name=customerModalBtn]').attr('disabled',true);
			$('button[name=equipModalBtn]').attr('disabled',true);
			
			$('#my-spinner').hide();
			setTimeout(function() {
				processInfoTable.draw(false);
			},100);
		});
		
		itemVersionHistoryTable.ajax.reload(function(){	});
		itemPerformanceHistoryTable.ajax.reload(function(){	});
		inputMaterialTable.ajax.reload(function(){});
		fileTable.ajax.reload(function(){});
		let data;
		$.ajax({
			url: '<c:url value="/bm/itemInfoSel"/>',
            type: 'GET',
            //async: false,
            data: {
                'idx'	:	idx
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					data = res.data;
					
					$('#customerNm').val(data.customerNm);
					$('#customerIdx').val(data.customerIdx);
					$('#useYnCd').val(data.useYnCd);
					$('#itemCd').val(data.itemCd);
					$('#itemSize').val(data.itemSize);
					$('#specialNotice').val(data.specialNotice);
					$('#itemNm').val(data.itemNm);
					$('#woodenCareCd').val(data.woodenCareNm);
					$('#woodenCareIdx').val(data.woodenCareCd);
					$('#knifeTipSize').val(data.knifeTipSize);
					$('#holeWoodenCd').val(data.holeWoodenCd);
					$('#versionNum').val(data.versionNum);
					$('#stock').val(parseInt(data.stock));
					$('#relayNotice').val(data.relayNotice);
					$('#itemColor').val(data.itemColor);
					$('#frequency').val(data.frequency);
					$('#resinBoard').val(data.resinBoardNm);
					$('#resinBoardIdx').val(data.resinBoard);
					$('#customerItemCd').val(data.customerItemCd);
					
					//세부정보
					$('#coatingMethod').val(data.coatingMethod);
					$('#moldingMethod').val(data.moldingMethod);
					$('#moldingContents').val(data.moldingContents);
					$('#pressMethod').val(data.pressMethod);
					
					$('#bundleMethod').val(data.bundleMethod);
					$('#bundleUnit').val(data.bundleUnit);
					$('#packMethod').val(data.packMethod);
					$('#packUnit').val(data.packUnit);
					$('#workPrinter').val(data.workPrinter);
					$('#detailDate').val(moment(data.detailDate,'YYYY-MM-DD').format('YYYY-MM-DD'));
					$('#masterPaper').val(data.masterPaper);
					$('#roundPlateCnt').val(data.roundPlateCnt);
					$('#careCd').val(data.careCd);
					$('#plane').val(data.plane);
					$('#inspectMethod').val(data.inspectMethod);
					$('#printingYnCheck').val(data.printingYnCheck);
					$('#plateSize').val(data.plateSize);
					$('#etc1').val(data.etc1);
					$('#etc2').val(data.etc2);
					$('#etc2Cd').val(data.etc2Cd);
					$('#etc3').val(data.etc3);
					$('#etc4').val(data.etc4);
					$('#etc5').val(data.etc5);
					$('#etc6').val(data.etc6);
					$('#etc7').val(data.etc7);
					//$('#etc8').val(data.etc8);
					$('#outCustomerIdx').val(data.etc8);
					$('#outCustomerNm').val(data.etc8Nm);
					$('#etc9').val(data.etc9);
					$('#confirmYnCheck').val(data.etc10);
					$('#lastWorkDate').val(moment(data.lastWorkDate, 'YYYY-MM-DD').format('YYYY-MM-DD'));
					

					if(data.cmyk != null && data.cmyk !=''){
						if( data.cmyk.split('/')[0] == 'C'){
							$('#checkC').prop('checked',true);
							$('#checkCLabel').css('background-color','#009FE3');
							$('#checkCLabel').css('color','#000000');
						} else {
							$('#checkC').prop('checked',false);
							$('#checkCLabel').css('background-color','#FFFFFF');
							$('#checkCLabel').css('color','#000000');
						}
						if( data.cmyk.split('/')[1] == 'M' ){
							$('#checkM').prop('checked',true);
							$('#checkMLabel').css('background-color','#E6007E');
							$('#checkMLabel').css('color','#000000');
						} else {
							$('#checkM').prop('checked',false);
							$('#checkMLabel').css('background-color','#FFFFFF');
							$('#checkMLabel').css('color','#000000');
						}
						if( data.cmyk.split('/')[2] == 'Y' ){
							$('#checkY').prop('checked',true);
							$('#checkYLabel').css('background-color','#FEED01');
							$('#checkYLabel').css('color','#000000');
						} else {
							$('#checkY').prop('checked',false);
							$('#checkYLabel').css('background-color','#FFFFFF');
							$('#checkYLabel').css('color','#000000');
						}
						if( data.cmyk.split('/')[3] == 'K' ){
							$('#checkK').prop('checked',true);
							$('#checkKLabel').css('background-color','#000000');
							$('#checkKLabel').css('color','#FFFFFF');
						} else {
							$('#checkK').prop('checked',false);
							$('#checkKLabel').css('background-color','#FFFFFF');
							$('#checkKLabel').css('color','#000000');
						}
						
					} else {
						$('#checkCLabel').css('background-color','#FFFFFF');
						$('#checkCLabel').css('color','#009FE3');
						$('#checkMLabel').css('background-color','#FFFFFF');
						$('#checkMLabel').css('color','#E6007E');
						$('#checkYLabel').css('background-color','#FFFFFF');
						$('#checkYLabel').css('color','#FEED01');
						$('#checkKLabel').css('background-color','#FFFFFF');
						$('#checkKLabel').css('color','#000000');
					}
					$('#itemGubun').val(data.itemGubun);
					fileUuid = data.uuid;
					fileExt = data.ext;
					fileNm = data.fileNm;
					/*
					let fileObject = new Object();
					fileObject.uuid = data.uuid;
					fileObject.ext = data.ext;
					fileObject.fileNm = data.fileNm;
					
					
					let fileBlob = getFileBlob(fileObject);
					$('#versionFileNm').val(fileObject.fileNm+'.'+fileObject.ext);

					let blob = new Blob([base64ToArrayBuffer(fileBlob)], { type: data.ext });
                    let file = new File([blob], data.fileNm, { lastModified: new Date().getTime(), type: data.ext });
					formData4.append('file',file);
					formData4.append('uuid',data.uuid);
					formData4.append('ext',data.ext); 
					*/
					if(data.fileNm != null && data.fileNm != ''){
						$('#versionFileNm').val(data.fileNm+'.'+data.ext);
					} else {
						$('#versionFileNm').val('');
					}
					$('.inputGroup').attr('disabled',true);
						
					$('#btnNew').attr('disabled', false); // 신규 버튼
					$('#btnCopy').attr('disabled', false); // 복사 버튼
					$('#btnSave').attr('disabled', true); // 저장 버튼
					$('#btnEdit').attr('disabled', false); // 수정 버튼
					$('#btnDel').attr('disabled', false); //삭제버튼
					$('#btnCancel').attr('disabled', true); // 취소 버튼

					$('#btnStockBtn').attr('disabled',false); //재고폐기등록
					
					$('#btnProcessNew').attr('disabled',false);//공정
					$('#btnProcessSave').attr('disabled',true);
					$('#btnProcessEdit').attr('disabled',false);
					$('#btnProcessDel').attr('disabled',false);
					$('#btnProcessCancel').attr('disabled',true);
					$('#btnMaterialNew').attr('disabled',false);//투입자재
					$('#btnMaterialSave').attr('disabled',true);
					$('#btnMaterialEdit').attr('disabled',false);
					$('#btnMaterialDel').attr('disabled',false);
					$('#btnMaterialCancel').attr('disabled',true);
					$('#btnFileAdd').attr('disabled',false);//파일추가 신규 버튼
					$('#btnFileDel').attr('disabled',false);//파일삭제 버튼
					$('#btnVersionNew').attr('disabled',false);//버전이력 신규 버튼
					$('#btnVersionDel').attr('disabled',false);//버전이력 삭제 버튼

					$('#btnBundleNew').attr('disabled',false);
					$('#btnBundleSave').attr('disabled',true);
					$('#btnBundleEdit').attr('disabled',false);
					$('#btnBundleDel').attr('disabled',false);
					$('#btnBundleCancel').attr('disabled',true);

					$('#btnPrcssNew').attr('disabled',false);
					$('#viewer').attr('src','');
					
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
				$('#my-spinner').hide();
			}
		});
		
	});
	
	// 조회 버튼 click
	$('#btnSearch').on('click', function() {
		/* console.time('bmsc0030 itemInfo 조회'); */
		$('#my-spinner').show();
		itemIdx = '';
		itemInfoTable.rows('.selected').deselect();
		$('#tab1Nav').trigger('click');
		$('#tab6Nav').trigger('click');
		$('#fileTable').DataTable().clear().draw();//파일테이블 
		$('#itemVersionHistoryTable').DataTable().clear().draw();//버전테이블
		$('#itemPerformanceHistoryTable').DataTable().clear().draw();//제품수행이력테이블
		$('#processInfoTable').DataTable().clear().draw();//공정테이블
		$('#inputMaterialTable').DataTable().clear().draw();//투입자재테이블
		$('#bundleInfoTable').DataTable().clear().draw();//번들링테이블
		
		$('.inputGroup').val('');
		$('#versionFileNm').val('');

		$('#resinBoard').val('');
		$('#resinBoardIdx').val('');
		$('#woodenCareCd').val('');
		$('#woodenCareIdx').val('');
		$('#etc2Cd').val('');

		$('#stock').val('0');
		$('#stock').attr('disabled',true);
		itemInfoTable.ajax.reload(function() {},false);

		setTimeout(function() {
			$('#my-spinner').hide();
		}, 100)
	});

	// 신규 버튼 click
	$('#btnNew').on('click', function() {
		$('#btnSave').data('saveType','insert'); // 저장 방식 -> 등록
		
		WM_action_ON('new', 'workingWarningModal');

		itemInfoTable.row('.selected').deselect();
		
		$('#tab1Nav').trigger('click');
		//$('#tab3Nav').trigger('click');
		$('#fileTable').DataTable().clear().draw();//파일테이블 
		$('#itemVersionHistoryTable').DataTable().clear().draw();//버전테이블
		$('#itemPerformanceHistoryTable').DataTable().clear().draw();//제품수행이력테이블
		$('#processInfoTable').DataTable().clear().draw();//공정테이블
		$('#inputMaterialTable').DataTable().clear().draw();//투입자재테이블
		$('#bundleInfoTable').DataTable().clear().draw();//번들링테이블
		
		$('.inputGroup').val('');
		
		$('.inputGroup').attr('disabled', false); // 입력항목
		$('#btnUserIdCheck').attr('disabled', false); // 중복확인 버튼
		$('#btnviewer').attr('disabled', false); // 사진선택 버튼
		
		$('#btnNew').attr('disabled', true); // 신규 버튼
		$('#btnCopy').attr('disabled',true); // 복사 버튼
		$('#btnSave').attr('disabled', false); // 저장 버튼
		$('#btnEdit').attr('disabled', true); // 수정 버튼
		$('#btnDel').attr('disabled', true); // 삭제 버튼
		$('#btnCancel').attr('disabled', false); // 취소 버튼
		$('#btnStockBtn').attr('disabled',true); //재고폐기등록버튼

		//목형관리번호
		$('#woodenCareCd').attr('disabled',true);
		$('#woodenCareBtn').attr('disabled',false);
		
		//버전이력,공정정보 및 투입자재, 사진 및 첨부파일 버튼 비활성화
		$('#btnVersionNew').attr('disabled', true);
		$('#btnVersionSave').attr('disabled', true);
		$('#btnVersionDel').attr('disabled', true);
		$('#btnVersionCancel').attr('disabled', true);
		$('#btnProcessNew').attr('disabled', true);
		$('#btnProcessSave').attr('disabled', true);
		$('#btnProcessDel').attr('disabled', true);
		$('#btnProcessCancel').attr('disabled', true);
		$('#btnProcessEdit').attr('disabled', true);
		$('#btnMaterialNew').attr('disabled', true);
		$('#btnMaterialSave').attr('disabled', true);
		$('#btnMaterialDel').attr('disabled', true);
		$('#btnMaterialCancel').attr('disabled', true);
		$('#btnMaterialEdit').attr('disabled', true);
		$('#btnFileAdd').attr('disabled', true);
		$('#btnFileDel').attr('disabled', true);
		
		
		$('#customerNm').attr('disabled',true);//고객사
		//$('#itemCd').attr('disabled',true);//제품코드

		$('#checkC').prop('checked',false);
		$('#checkM').prop('checked',false);
		$('#checkY').prop('checked',false);
		$('#checkK').prop('checked',false);

		$('#checkCLabel').css('background-color','#FFFFFF');
		$('#checkCLabel').css('color','#000000');
		$('#checkMLabel').css('background-color','#FFFFFF');
		$('#checkMLabel').css('color','#000000');
		$('#checkYLabel').css('background-color','#FFFFFF');
		$('#checkYLabel').css('color','#000000');
		$('#checkKLabel').css('background-color','#FFFFFF');
		$('#checkKLabel').css('color','#000000');
		
		$('#useYnCd').val('Y');
		//$('#itemGubun').val('001');
		$('#itemCd').val('자동채번');

		$('#detailDate').val(moment().format('YYYY-MM-DD'));

		$('#versionFileNm').val('');

		$('#resinBoard').val('');
		$('#resinBoardIdx').val('');
		$('#woodenCareCd').val('');
		$('#woodenCareIdx').val('');
		$('#etc2Cd').val('');

		$('#stock').val('');
		$('#stock').attr('disabled',true);

		//품목구분 제품 (001)
		$('#itemGubun').val('001');
		//실적등록
		$('#etc9').val('Y');
	});

	let beforeVersion = '';
	//수정버튼 click
	$('#btnEdit').on('click',function(){
		if(!$('#itemInfoTable tbody tr').hasClass('selected')){
			toastr.warning('수정할 항목을 선택해주세요.');
			return false;
		}

		$('#btnSave').data('saveType','update'); // 저장 방식 -> 수정

		WM_action_ON('edit', 'workingWarningModal');
		
		$('.inputGroup').attr('disabled', false); // 입력항목
		$('#btnUserIdCheck').attr('disabled', false); // 중복확인 버튼
		//$('#btnSignImage').attr('disabled', false); // 사진선택 버튼
		
		$('#btnNew').attr('disabled', true); // 신규 버튼
		$('#btnSave').attr('disabled', false); // 저장 버튼
		$('#btnEdit').attr('disabled', true); // 수정 버튼
		$('#btnCopy').attr('disabled', true); // 복사 버튼
		$('#btnDel').attr('disabled', true); // 삭제 버튼
		$('#btnCancel').attr('disabled', false); // 취소 버튼

		$('#btnStockBtn').attr('disabled',true); //재고폐기등록
		
		$('#customerNm').attr('disabled',true);//고객사 인풋박스
		$('#itemCd').attr('disabled',true);
		//목형관리번호
		$('#woodenCareCd').attr('disabled',true);
		$('#woodenCareBtn').attr('disabled',false);
		$('#stock').attr('disabled',true);
		
		beforeVersion = $('#versionNum').val();
		if( formData4.get('file') == null || formData4.get('file') == undefined){
			let idx = itemInfoTable.row('.selected').data().idx;
			$.ajax({
				url: '<c:url value="/bm/itemInfoSel"/>',
	            type: 'GET',
	            //async: false,
	            data: {
	                'idx'	:	idx
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if (res.result == "ok") { //응답결과
						data = res.data;						
						fileUuid = data.uuid;
						fileExt = data.ext;
						fileNm = data.fileNm;
						if(data.fileNm != null && data.fileNm != ''){
							$('#versionFileNm').val(data.fileNm+'.'+data.ext);
						} else {
							$('#versionFileNm').val('');
						}
						/* let fileObject = new Object();
						fileObject.uuid = data.uuid;
						fileObject.ext = data.ext;
						fileObject.fileNm = data.fileNm;
						let fileBlob = getFileBlob(fileObject);
						$('#versionFileNm').val(fileObject.fileNm+'.'+fileObject.ext);

						let blob = new Blob([base64ToArrayBuffer(fileBlob)], { type: data.ext });
	                    let file = new File([blob], data.fileNm, { lastModified: new Date().getTime(), type: data.ext });
						formData4.append('file',file);
						formData4.append('uuid',data.uuid);
						formData4.append('ext',data.ext); */
						
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
	
	// 투입자재 목록조회
	$('#inputMaterialTable thead tr').clone(true).addClass('filters').appendTo('#inputMaterialTable thead'); // filter 생성
	let inputMaterialTable = $('#inputMaterialTable').DataTable({
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
			url : '<c:url value="/bm/itemBomList"/>',
			type : 'GET',
			data : {
				'itemIdx'	: function(){ return itemIdx; },
			},
		}, 
        rowId: 'idx',
		columns : [
			{ data: 'matrlCd', className : 'text-center', name : 'matrlCd',
				render: function(data, type, row, meta) {
					if( data == null ){
						let html='';
						html += '<div style="display: flex; flex-wrap: nowrap;" class="input-group">';
						html += '<input type="text" class="form-control inputNm" name="matrlCd" style="min-width: 150px;" disabled="disabled">';
						html += '<button type="button" class="nameDel matrlCd" name="nameDel" value="'+meta.row+'" style="background-color: transparent;border-color: transparent;position: absolute;top: 0;right:0;margin: 1px 23px;margin-left: 0px;border: none;" disabled><i class="fa-solid fa-xmark"></i></button>';
						html += '<button type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary input-sub-search" name="matrlModalBtn">';
						html += '<i class="fa-solid fa-magnifying-glass"></i>';
						html += '</button>';
						html += '</div>';
						return html;
					} else {
						let html='';
						html += '<div style="display: flex; flex-wrap: nowrap;" class="input-group">';
						html += '<input type="text" class="form-control inputNm" name="matrlCd" style="min-width: 150px;" disabled="disabled" value="'+data+'">';
						html += '<button type="button" class="nameDel matrlCd" name="nameDel" value="'+meta.row+'" style="background-color: transparent;border-color: transparent;position: absolute;top: 0;right:0;margin: 1px 23px;margin-left: 0px;border: none;" disabled><i class="fa-solid fa-xmark"></i></button>';
						html += '<button disabled type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary input-sub-search" name="matrlModalBtn">';
						html += '<i class="fa-solid fa-magnifying-glass"></i>';
						html += '</button>';
						html += '</div>';
						return html;
					}
				}
			},
			{ data: 'paperType', className : 'text-center', name : 'paperType',
				render: function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;"></div>';
					}
				}
			},//재질
			{ data: 'sizeX', className : 'text-center', name : 'sizeX',
				render: function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;"></div>';
					}
				}
			},
			{ data: 'sizeY', className : 'text-center', name : 'sizeY',
				render: function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div>';
					} else {
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;"></div>';
					}
				}
			},
			{ data: 'cutQty', className : 'text-center', name : 'cutQty',
				render: function(data, type, row, meta) {
					if( data == null ){
						return '<input type="text" style="text-align:right;" class="form-control" name="cutQty" value="0" onkeyup="numberFormat(this,\'int\')">'; 
					} else {
						return '<input disabled type="text" style="text-align:right;" class="form-control" name="cutQty" value="'+addCommas(parseFloat(data))+'" onkeyup="numberFormat(this,\'int\')">'; 
					}
				}
			},
			{ data: 'eaQty', className : 'text-center', name : 'eaQty',
				render: function(data, type, row, meta) {
					if( data == null ){
						return '<input type="text" style="text-align:right;" class="form-control" name="eaQty" value="0" onkeyup="numberFormat(this,\'int\')">'; 
					} else {
						return '<input disabled type="text" style="text-align:right;" class="form-control" name="eaQty" value="'+addCommas(parseFloat(data))+'" onkeyup="numberFormat(this,\'int\')">'; 
					}
				}
			},
			{ data: 'extraQty', className : 'text-center', name : 'extraQty',
				render: function(data, type, row, meta) {
					if( data == null ){
						return '<input type="text" style="text-align:right;" class="form-control" name="extraQty" value="0" onkeyup="numberFormat(this,\'int\')">'; 
					} else {
						return '<input disabled type="text" style="text-align:right;" class="form-control" name="extraQty" value="'+addCommas(parseFloat(data))+'" onkeyup="numberFormat(this,\'int\')">'; 
					}
				}
			}, //여분
			{ data: 'dealCorpNm', className : 'text-center', name : 'dealCorpNm',
				render: function(data, type, row, meta) {
					if( data == null ){
						let html='';
						html += '<div style="display: flex; flex-wrap: nowrap;" class="input-group">';
						html += '<input type="text" class="form-control inputNm" name="dealCorpNm" style="min-width: 150px;" disabled="disabled">';
						html += '<button type="button" class="nameDel dealCorpNm" name="nameDel" value="'+meta.row+'" style="background-color: transparent;border-color: transparent;position: absolute;top: 0;right:0;margin: 1px 23px;margin-left: 0px;border: none;" disabled><i class="fa-solid fa-xmark"></i></button>';
						html += '<input type="hidden" name="dealCorpIdx" class="inputIdx" value="'+row['dealCorpIdx']+'">';
						html += '<button type="button" value="'+row['matrlIdx']+'" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary input-sub-search" name="dealCorpModalBtn" disabled>';
						html += '<i class="fa-solid fa-magnifying-glass"></i>';
						html += '</button>';
						html += '</div>';
						return html;
					} else {
						let html='';
						html += '<div style="display: flex; flex-wrap: nowrap;" class="input-group">';
						html += '<input type="text" class="form-control inputNm" name="dealCorpNm" style="min-width: 150px;" disabled="disabled" value="'+data+'">';
						html += '<button type="button" class="nameDel dealCorpNm" name="nameDel" value="'+meta.row+'" style="background-color: transparent;border-color: transparent;position: absolute;top: 0;right:0;margin: 1px 23px;margin-left: 0px;border: none;" disabled><i class="fa-solid fa-xmark"></i></button>';
						html += '<input type="hidden" name="dealCorpIdx" class="inputIdx" value="'+row['dealCorpIdx']+'">';
						html += '<button disabled type="button" value="'+row['matrlIdx']+'" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary input-sub-search" name="dealCorpModalBtn">';
						html += '<i class="fa-solid fa-magnifying-glass"></i>';
						html += '</button>';
						html += '</div>';
						return html;
					}
				}
			},
			/* { data: 'bomDesc', className : 'text-center', name : 'bomDesc',
				render: function(data, type, row, meta) {
					if( data == null ){
						return '<input type="text" style="min-width: 150px;" class="form-control" name="bomDesc">'; 
					} else {
						return '<input disabled type="text" style="min-width: 150px;" class="form-control" value="'+data+'" name="bomDesc">'; 
					}
				}
			}, */
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
			/* { extend: 'excel',	text: 'Excel',	charset: 'UTF-8', bom: true },
			{ extend: 'pdf',	text: 'PDF',	},
			{ extend: 'print',	text: 'Print',		charset: 'UTF-8', bom: true },
			{ extend: 'colvis',	text: 'Select Col',	}, */
		],
		order : [],
		drawCallback: function() {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#inputMaterialTable_wrapper').find('.dataTables_scrollHead').css('height'));
			let baseTableHeight = parseFloat($('#rightcolB').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(((baseTableHeight)) - theadHeight - 94)+'px');
			$('#'+table_id+'_wrapper').find('.dataTables_scrollHeadInner').css('width','100%');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAllImt').off('keyup',function() {});
			$('#searchAllImt').on('keyup',function() {
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
				let cell = $('#inputMaterialTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#inputMaterialTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
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
	inputMaterialTable.on('column-reorder', function( e, settings, details ) {
		let api = inputMaterialTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#inputMaterialTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
		//수정중일 경우 ( = 수정버튼이 disabled상태인 경우 )
		if($('#btnMaterialEdit').is(':disabled')){
			$('button[name=matrlModalBtn]').attr('disabled',false);
			$('input[name=cutQty]').attr('disabled',false);
			$('input[name=eaQty]').attr('disabled',false);
			//$('input[name=cutSize]').attr('disabled',false);
			$('select[name=dealCorpNm]').attr('disabled',false);
			$('input[name=bomDesc]').attr('disabled',false);
			$('button[name=dealCorpModalBtn]').attr('disabled',false);
			$('#inputMaterialTable').find('button[name=nameDel]').attr('disabled',false);
		}
	});

	
	// 공정정보 목록조회
	let processInfoTableApi;
	//$('#processInfoTable thead tr').clone(true).addClass('filters').appendTo('#processInfoTable thead'); // filter 생성
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
			url : '<c:url value="/bm/itemPrcssList"/>',
			type : 'GET',
			data : {
				'itemIdx'	: function(){ return itemIdx; },
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
					if( data == null && data != '' ){
						let html='';
						/*html += '<div style="display: flex; flex-wrap: nowrap;" class="input-group">';
						html += '<input type="text" class="form-control inputNm" name="equipNm" style="min-width: 175px;" disabled="disabled">';
						html += '<button type="button" class="nameDel equipNm" name="nameDel" value="'+meta.row+'" style="background-color: transparent;border-color: transparent;position: absolute;top: 0;right:0;margin: 1px 23px;margin-left: 0px;border: none;" disabled><i class="fa-solid fa-xmark"></i></button>';
						html += '<input type="hidden" class="inputIdx" name="equipIdx" value="'+row['equipIdx']+'">';
						html += '<button type="button" value="'+row['prcssIdx']+'" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary input-sub-search" name="equipModalBtn">';
						html += '<i class="fa-solid fa-magnifying-glass"></i>';
						html += '</button>';
						html += '</div>';*/
						let prcssEquipFilterList = _.filter(prcssEquipList,v=>v.prcssIdx == row['prcssIdx']);
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
						/* html += '<div style="display: flex; flex-wrap: nowrap;" class="input-group">';
						html += '<input type="text" class="form-control inputNm" name="equipNm" style="min-width: 175px;" disabled="disabled" value="'+data+'">';
						html += '<button type="button" class="nameDel equipNm" name="nameDel" value="'+meta.row+'" style="background-color: transparent;border-color: transparent;position: absolute;top: 0;right:0;margin: 1px 23px;margin-left: 0px;border: none;" disabled><i class="fa-solid fa-xmark"></i></button>';
						html += '<input type="hidden" class="inputIdx" name="equipIdx" value="'+row['equipIdx']+'">';
						html += '<button disabled type="button" value="'+row['prcssIdx']+'" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary input-sub-search" name="equipModalBtn">';
						html += '<i class="fa-solid fa-magnifying-glass"></i>';
						html += '</button>';
						html += '</div>'; */
						let prcssEquipFilterList = _.filter(prcssEquipList,v=>v.prcssIdx == row['prcssIdx']);
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
			{ data: 'outsrcGubun', className : 'text-center',
				render: function(data, type, row, meta) {
					if( data == null ){
						let html='';
						html += '<select class="form-select" style="width: 55px;" name="outsrcGubun">';
						for( let i = 0; i< outsrcGubunList.length; i++){
							html += '<option value="' + outsrcGubunList[i].commonCd + '">' + outsrcGubunList[i].commonNm + '</option>'
						}
						html += '</select>';
						return html;
					} else {
						let html='';
						html += '<select disabled class="form-select" style="width: 55px;" name="outsrcGubun">';
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
					if( data == null ){
						return '<input type="text" class="form-control" name="workMethodMultiSelect">';
					} else {
						return '<input type="text" class="form-control" value="'+data+'" name="workMethodMultiSelect" disabled>';
					}
				}
			},
			{ data: 'workMethodDtl', className : 'text-center',
				render: function(data, type, row, meta) {
					if( data == null ){
						let html='';
						html += '<input type="text" class="form-control" style="min-width:100px;" value="" name="workMethodDtl">';
						return html;
					} else {
						let html='';
						html += '<input disabled type="text" class="form-control" style="min-width:100px;" value="'+data+'" name="workMethodDtl">';
						return html;
					}
				}
			},
			{ data: 'customerCd', className : 'text-center',
				render: function(data, type, row, meta) {
					if( data == null ){
						let html='';
						html += '<div style="display: flex; flex-wrap: nowrap;" class="input-group" >';
						html += '<input type="text" class="form-control inputNm" id="customerNm" style="min-width: 100px;" disabled="disabled">';
						html += '<button type="button" class="nameDel customerNm" name="nameDel" value="'+meta.row+'" style="background-color: transparent;border-color: transparent;position: absolute;top: 0;right:0;margin: 1px 23px;margin-left: 0px;border: none;" disabled><i class="fa-solid fa-xmark"></i></button>';
						html += '<input type="hidden" class="inputIdx" name="customerIdx">';
						html += '<button type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary input-sub-search" name="customerModalBtn">';
						html += '<i class="fa-solid fa-magnifying-glass"></i>';
						html += '</button>';
						html += '</div>';
						return html;
					} else {
						let html='';
						html += '<div style="display: flex; flex-wrap: nowrap;" class="input-group">';
						html += '<input type="text" class="form-control inputNm" id="customerNm" style="min-width: 100px;" disabled="disabled" value="'+row['outsrcNm']+'">';
						html += '<button type="button" class="nameDel customerNm" name="nameDel" value="'+meta.row+'" style="background-color: transparent;border-color: transparent;position: absolute;top: 0;right:0;margin: 1px 23px;margin-left: 0px;border: none;" disabled><i class="fa-solid fa-xmark"></i></button>';
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
			{ data: 'prcssDesc', className : 'text-center',
				render: function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">' + data + '</div>';
					} else {
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;"></div>';
					}
				}
			},
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
			//{
			//	targets: [0],
			//	render: function(data) {
			//		return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'data+'</div>';
			//	}
			//}
		],
		buttons : [
			/* { extend: 'excel',	text: 'Excel',	charset: 'UTF-8', bom: true },
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
			/* { extend: 'excel',	text: 'Excel',	charset: 'UTF-8', bom: true },
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
			let baseTableHeight = parseFloat($('#rightcolT').css('height'));
			let baseTableWidth = parseFloat($('#imgDiv').css('width'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(baseTableHeight - 193)+'px');
			$('#viewer').css('height',(baseTableHeight - 102)+'px');
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

	//거래처 조회 후 적용 클릭
	$('#dealCorpSelectApply').on('click',function(){
		if( $('#customerSelect').val() == '' ){
			toastr.warning('고객사를 선택해주세요.');
			$('#customerSelect').focus();
			return false;
		}
		$('#customerNm').val($('#customerSelect option:checked').text());
		$('#customerIdx').val($('#customerSelect option:checked').val());
		//$('#itemCd').val('자동채번');
		
		$('#dealCorpModal').modal('hide');
	});

	//거래처 조회 취소
	$('#dealCorpSelectCancel').on('click',function(){
		$('#dealCorpModal').modal('hide');
	});
	
	// 버전 목록조회
	$('#itemVersionHistoryTable thead tr').clone(true).addClass('filters').appendTo('#itemVersionHistoryTable thead'); // filter 생성
	let itemVersionHistoryTable = $('#itemVersionHistoryTable').DataTable({
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
		pageLength: -1,
		colReorder: true,
		select: {
            style: 'single',
            toggleable: false,
            items: 'row',
            info: false
        },
        ajax : {
			url : '<c:url value="/bm/itemVersionListAll"/>',
			type : 'GET',
			data : {
				idx   : function(){ return itemIdx;},
			},
		}, 
        rowId: 'idx',
		columns : [
			{ data: 'progressOrder', className : 'text-center align-middle'}, //순번
			{ //버전번호
				data: 'itemVersion', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data == null){
						let html = '';
						html += '<input type="text" class="form-control versionInput" id="versionInput'+meta.row+'">';
						return html;
					} else{
						return data;
					}
				}
			},
			{ //등록일자
				data: 'regDate', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					return moment(data,'YYYY-MM-DD').format('YYYY-MM-DD');
				}
			},
			{ data: 'fileNm', className : 'text-center align-middle'}, //파일명
			{ data: 'ext', className : 'text-center align-middle'}, //확장자
			{ //다운로드
				data: 'fileNm', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					let html = '';
					if(data != null && data != "") {
						html += '<a href="/serverFile/'+row['uuid']+'.'+row['ext']+'" target="_blank">';
						html += '<span style="font-size: 14px;">'+data+'</span>';							
						html += '<input type="hidden" id="fileHidden'+ meta.row +'" value="'+data+'"></a>';
						html += '<button data-idx="'+row['idx']+'" type="button" class="btn btn-outline-danger versionFileDel" style="background-color: transparent;border-color: transparent;margin: 0px 0px;margin-left: 0px;border: none;font-size:1.5rem!important;--bs-btn-hover-color: #dc3545;">';	
						html += '<i class="fa-solid fa-xmark"></i>';
						html += '</button>';
					}
					return html;
				}
			},
			{ //삭제
				className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					let html = '';
					html += '<button data-idx="'+row['idx']+'" type="button" class="btn btn-outline-danger versionDel" style="background-color: transparent;border-color: transparent;margin: 0px 0px;margin-left: 0px;border: none;font-size:1.5rem!important;--bs-btn-hover-color: #dc3545;">';	
					html += '<i class="fa-solid fa-xmark"></i>';
					html += '</button>';
					return html;
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
			/* { extend: 'excel',	text: 'Excel',	charset: 'UTF-8', bom: true },
			{ extend: 'pdf',	text: 'PDF',	},
			{ extend: 'print',	text: 'Print',		charset: 'UTF-8', bom: true },
			{ extend: 'colvis',	text: 'Select Col',	},  */
		],
		order : [],
		drawCallback: function() {
			let api = this.api();
			let data = api.data();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#itemVersionHistoryTable_wrapper').find('.dataTables_scrollHead').css('height'));
			let baseTableHeight = parseFloat($('#rightcolT').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(((baseTableHeight)) - theadHeight - 99)+'px');
			$('#'+table_id+'_wrapper').find('.dataTables_scrollHeadInner').css('width','100%');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAllIvh').off('keyup',function() {});
			$('#searchAllIvh').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			});

			//progressOrder
			for(var i=0;i<data.length;i++) {
				let tr = $('#itemVersionHistoryTable tbody').find('tr').eq(i);
				itemVersionHistoryTable.row(tr).data().progressOrder = i+1;

				let html = '';
				html += '<div class="row">';
				html += '<div>'+(i+1)+'</div>';
				html += '<button type="button" class="inputGroup versionDel" style="background-color: transparent; border-color: transparent;margin: 0px 15px; margin-left: 0px; border: none;">';
				html += '	<i class="fa-solid fa-xmark"></i>';
				html += '</button>';
				html += '</div>';				
				$(tr).find('td').eq(0).html(i+1);
			}
		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#itemVersionHistoryTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#itemVersionHistoryTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
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
	itemVersionHistoryTable.on('column-reorder', function( e, settings, details ) {
		let api = itemVersionHistoryTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#itemVersionHistoryTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	// 버전 목록조회
	$('#itemVersionDisposalTable thead tr').clone(true).addClass('filters').appendTo('#itemVersionDisposalTable thead'); // filter 생성
	let itemVersionDisposalTable = $('#itemVersionDisposalTable').DataTable({
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
		pageLength: -1,
		colReorder: true,
		select: {
            style: 'single',
            toggleable: false,
            items: 'row',
            info: false
        },
        ajax : {
			url : '<c:url value="/bm/itemVersionListAll"/>',
			type : 'GET',
			data : {
				idx   : function(){ return itemIdx;},
			},
		}, 
        rowId: 'idx',
		columns : [
			{ data: 'progressOrder', className : 'text-center align-middle'}, //순번
			{ //버전번호
				data: 'itemVersion', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if(data == null){
						let html = '';
						html += '<input type="text" class="form-control versionInput" id="versionInput'+meta.row+'">';
						return html;
					} else{
						return data;
					}
				}
			},
			{ //등록일자
				data: 'spQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					return addCommas(parseInt(data));
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
			/* { extend: 'excel',	text: 'Excel',	charset: 'UTF-8', bom: true },
			{ extend: 'pdf',	text: 'PDF',	},
			{ extend: 'print',	text: 'Print',		charset: 'UTF-8', bom: true },
			{ extend: 'colvis',	text: 'Select Col',	},  */
		],
		order : [],
		drawCallback: function() {
			let api = this.api();
			let data = api.data();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#itemVersionDisposalTable_wrapper').find('.dataTables_scrollHead').css('height'));
			let baseTableHeight = parseFloat($('#rightcolT').css('height'));
			//$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(((baseTableHeight)) - theadHeight - 99)+'px');
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height','240px');
			$('#'+table_id+'_wrapper').find('.dataTables_scrollHeadInner').css('width','100%');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			/* $('#searchAll').off('keyup',function() {});
			$('#searchAll').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			}); */

			//progressOrder
			for(var i=0;i<data.length;i++) {
				let tr = $('#itemVersionDisposalTable tbody').find('tr').eq(i);
				itemVersionDisposalTable.row(tr).data().progressOrder = i+1;

				let html = '';
				html += '<div class="row">';
				html += '<div>'+(i+1)+'</div>';
				html += '<button type="button" class="inputGroup versionDel" style="background-color: transparent; border-color: transparent;margin: 0px 15px; margin-left: 0px; border: none;">';
				html += '	<i class="fa-solid fa-xmark"></i>';
				html += '</button>';
				html += '</div>';				
				$(tr).find('td').eq(0).html(i+1);
			}
		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#itemVersionDisposalTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#itemVersionDisposalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
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
	itemVersionDisposalTable.on('column-reorder', function( e, settings, details ) {
		let api = itemVersionDisposalTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#itemVersionDisposalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	// 버전이력 신규
	$('#btnVersionNew').on('click',function(){
		//$('#btnSave').data('saveType','insert'); // 저장 방식 -> 등록
		
		WM_action_ON('versionNew', 'workingWarningModal');
		itemVersionHistoryTable.row.add({
			'progressOrder' : 0,
			'version'   : null,
			'regDate' : moment().format('YYYY-MM-DD'),
		}).draw(false);
		$('#btnVersionNew').attr('disabled',true);
		$('#btnVersionSave').attr('disabled',false);
		$('#btnVersionDel').attr('disabled',false);
		$('#btnVersionCancel').attr('disabled',false);
	});

	// 버전이력 삭제
	$('#btnVersionDel').on('click',function(){
		if(!$('#itemVersionHistoryTable tbody tr').hasClass('selected')){
			toastr.warning('삭제할 항목을 선택해주세요.');
			return false;
		}
		
		let idx = itemVersionHistoryTable.row('.selected').data().idx;
		if(idx != '' && idx != undefined){
			delStatus = 'version'
			$('#deleteModal').modal('show');
		} else {
			$('#itemVersionHistoryTable').DataTable().row('.selected').remove().draw();
		}

		let newRowCnt = 0;
		$('#itemVersionHistoryTable tbody tr').each(function(index, item) {
			if( $(this).attr('id') == undefined ){
				newRowCnt++;
			}
		});
		
		if($('#itemVersionHistoryTable').DataTable().data().count() == 0 || newRowCnt == 0){
			$('#btnVersionNew').attr('disabled',false);
			$('#btnVersionSave').attr('disabled',true);
			$('#btnVersionDel').attr('disabled',false);
			$('#btnVersionCancel').attr('disabled',true);
			WM_action_OFF('versionNew');
		}
	});

	//버전이력 저장
	$('#btnVersionSave').on('click',function(){
		let saveStatus = false;
		let versionVal = '';
		
		$('#itemVersionHistoryTable tbody tr').each(function(index, item) {
			//idx가 없을경우 신규 등록
			if( $(this).attr('id') == undefined ){
				if($(this).find('.versionInput').val() == ''){
					toastr.warning('버전번호를 입력해주세요.');
					$(this).find('.versionInput').focus();
					saveStatus = false;
					return false;
				} else {
					versionVal = $(this).find('.form-control').val();
					saveStatus = true;
				}
			}
		});
		itemIdx = itemInfoTable.row('.selected').data().idx;
		//등록을 해야하는 경우
		if( saveStatus ){
			$.ajax({
				url: '<c:url value="/bm/itemVersionInsert"/>',
	            type: 'POST',
	            //async: false,
	            data: {
	                'itemIdx'		:	function(){return itemIdx;},
	                'itemVersion'   :	function(){return versionVal;},
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if (res.result == "ok") { //응답결과
						let data = res.data;
						toastr.success('신규 저장되었습니다.');

						$('#btnSearch').trigger('click'); // 조회버튼 click

						WM_action_OFF('versionNew');

						$('#userPw').val('');
						$('#userPwCheck').val('');
						
						$('.inputGroup').attr('disabled', true); // 입력항목
						
						$('#btnNew').attr('disabled', false); // 신규 버튼
						$('#btnSave').attr('disabled', true); // 저장 버튼
						$('#btnEdit').attr('disabled', false); // 수정 버튼
						$('#btnDel').attr('disabled', false); // 삭제 버튼
						$('#btnCancel').attr('disabled', true); // 취소 버튼
						$('#btnFileAdd').attr('disabled',true);
						$('#btnFileDel').attr('disabled',true);

						itemVersionHistoryTable.ajax.reload(function(){});
						
						$('#btnVersionNew').attr('disabled', false);
						$('#btnVersionSave').attr('disabled', true);
						$('#btnVersionDel').attr('disabled', false);
						$('#btnVersionCancel').attr('disabled', true);

						$.ajax({
							url: '<c:url value="/bm/itemInfoSel"/>',
				            type: 'GET',
				            //async: false,
				            data: {
				                'idx'	:	function(){return itemIdx;},
				            },
				            beforeSend: function() {
				            	$('#my-spinner').show();
				            },
							success : function(res) {
								if (res.result == "ok") { //응답결과
									data = res.data;
									
									$('#customerNm').val(data.customerNm);
									$('#customerIdx').val(data.customerIdx);
									$('#useYnCd').val(data.useYnCd);
									$('#itemCd').val(data.itemCd);
									$('#itemSize').val(data.itemSize);
									$('#specialNotice').val(data.specialNotice);
									$('#itemNm').val(data.itemNm);
									$('#woodenCareCd').val(data.woodenCareCd);
									$('#knifeTipSize').val(data.knifeTipSize);
									$('#holeWoodenCd').val(data.holeWoodenCd);
									$('#versionNum').val(data.versionNum);
									$('#stock').val(parseInt(data.stock));
									$('#relayNotice').val(data.relayNotice);
									$('#itemColor').val(data.itemColor);
									$('#frequency').val(data.frequency);

									//세부정보
									$('#bundleMethod').val(data.bundleMethod);
									$('#bundleUnit').val(data.bundleUnit);
									$('#packMethod').val(data.packMethod);
									$('#packUnit').val(data.packUnit);
									$('#workPrinter').val(data.workPrinter);
									$('#detailDate').val(moment(data.detailDate,'YYYY-MM-DD').format('YYYY-MM-DD'));
									$('#masterPaper').val(data.masterPaper);
									$('#roundPlateCnt').val(data.roundPlateCnt);
									$('#careCd').val(data.careCd);
									$('#plane').val(data.plane);
									$('#inspectMethod').val(data.inspectMethod);
									$('#printingYnCheck').val(data.printingYnCheck);
									$('#plateSize').val(data.plateSize);
									$('#etc1').val(data.etc1);
									
									$('.inputGroup').attr('disabled',true);
										
									$('#btnNew').attr('disabled', false); // 신규 버튼
									$('#btnCopy').attr('disabled', false); // 복사 버튼
									$('#btnSave').attr('disabled', true); // 저장 버튼
									$('#btnEdit').attr('disabled', false); // 수정 버튼
									$('#btnCancel').attr('disabled', true); // 취소 버튼

									$('#btnProcessNew').attr('disabled',false);//공정 신규 버튼
									$('#btnMaterialNew').attr('disabled',false);//투입자재 신규 버튼
									$('#btnFileAdd').attr('disabled',false);//파일추가 신규 버튼
									$('#btnVersionNew').attr('disabled',false);//버전이력 신규 버튼
									
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
		}
		
	});
	
	//복사버튼클릭
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
		/*if(fileUuid != null && fileExt != null && fileNm != null){
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
		let saveType = $(this).data('saveType');*/
		//복사할때 버전이력 복사안하기로함 
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
					//if(versionFileString != '' && versionFileString != null){
					//	fileUpload(formData3); // 파일 업로드
					//}
					//복사할때 버전이력 파일 복사안함
					$('#btnFileAdd').attr('disabled',true);
					$('#btnFileDel').attr('disabled',true);
					trId = res.idx;
					itemInfoTable.ajax.reload(function(){
						setTimeout(function() {
							itemInfoTable.row('#'+trId).select();
							$(itemInfoTable.row('#'+trId).node()).trigger('click'); // 복사된거 선택처리
						}, 100)
							
					},false);

					
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
		/* $('#copyModal').modal('show');
		setTimeout(function() {
			if(itemInfoModalTable == null || itemInfoModalTable == ''){
				$('#itemInfoModalTable thead tr').clone(true).addClass('filters').appendTo('#itemInfoModalTable thead'); // filter 생성
				itemInfoModalTable = $('#itemInfoModalTable').DataTable({
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
							useYnCd : function(){return 'Y';},
							//itemGubun : function(){return $('#searchItemGubun').val();},
						},
					},
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
						},	//호기	
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
						{ data: 'pressMethod', className : 'text-center align-middle'},	//기타3
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
						{ data: 'etc5', className : 'text-center align-middle'},	//기타2	
						{ data: 'etc6', className : 'text-center align-middle'},	//형압
						{ data: 'etc7', className : 'text-center align-middle'},	//
						{ data: 'etc8', className : 'text-center align-middle'},	//기타2
						{ data: 'etc9', className : 'text-center align-middle'},	//기타3
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
						let searchHeight = parseFloat($('#itemInfoModalSearchDiv').css('height'));
						let theadHeight = parseFloat($('#itemInfoModalTable_wrapper').find('.dataTables_scrollHead').css('height'));
						$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - searchHeight - theadHeight - 250)+'px');
						
						$('#'+table_id+'_filter').addClass('d-none');
						// 통합검색
						$('#itemSearchAll').off('keyup',function() {});
						$('#itemSearchAll').on('keyup',function() {
							$('#'+table_id+'_filter').find('input').val($(this).val());
							$('#'+table_id+'_filter').find('input').trigger('keyup');
						});
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
							let cell = $('#itemInfoModalTable_wrapper').find('.filters th').eq(
								$(api.column(colIdx).header()).index()
							);

							let title = $(cell).text();

							$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
							$(cell).css('padding','2px');

							let cursorPosition = '';
							
							// On every keypress in this input
							$('#itemInfoModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
								api.column(colIdx).search(this.value, false, false, true).draw();
							}).on('keyup', function (e) {
								e.stopPropagation();
								$(this).trigger('keyupTrigger');
							});
						});
					},
				});
				// dataTable colReorder event
				itemInfoModalTable.on('column-reorder', function( e, settings, details ) {
					let api = itemInfoModalTable;
					api.columns().eq(0).each(function (colIdx) {
						$('#itemInfoModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
							api.column(colIdx).search(this.value, false, false, true).draw();
						}).on('keyup', function (e) {
							e.stopPropagation();
							$(this).trigger('keyupTrigger');
						});
					});
				});
				//itemInfoModalTable.ajax.reload(function() {});
			} else {
				itemInfoModalTable.ajax.reload(function() {});
			}
			
		}, 200); */
	});

	$('#btnitemInfoModalSearch').on('click',function(){
		itemInfoModalTable.ajax.reload(function() {});
	});
	
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
			delStatus = 'file'
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
		let idx = itemInfoTable.row('.selected').data().idx;
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
					itemIdx = itemInfoTable.row('.selected').data().idx;
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
					'regNm'   : sessionUserNm,
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

	//복사모달 적용처리
	$('#copyApply').on('click',function(){
		if( !$('#itemInfoModalTable tbody tr').hasClass('selected') ){
			toastr.warning('복사할 항목을 선택해주세요.');
			return false;
		}
		let data = itemInfoModalTable.row('.selected').data();
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
					trId = res.idx;
					itemInfoTable.ajax.reload(function(){
						setTimeout(function() {
							itemInfoTable.row('#'+trId).select();
							$(itemInfoTable.row('#'+trId).node()).trigger('click'); // 복사된거 선택처리
						}, 100)
							
					},false);

					
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

	$('#itemInfoModalTable tbody').on('dblclick','tr',function(){
		let data = itemInfoModalTable.row(this).data();
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
						}, 100)
							
					},false);

					
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
	
	//복사모달 취소처리
	$('#copyCancel').on('click',function(){
		$('#copyModal').modal('hide');
	});

	//삭제처리
	$('#btnDel').on('click',function(){
		if(!$('#itemInfoTable tbody tr').hasClass('selected')){
			toastr.warning('삭제할 행을 선택해주세요.');
			return false;
		}

		delStatus = 'item';
		$('#deleteModal').modal('show');
	});
	
	//저장처리
	$('#btnSave').on('click',function(){
		let saveType = $(this).data('saveType');
		
		if( $('#customerNm').val() == '' ){
			toastr.warning('고객사를 선택해주세요.');
			$('#tab1Nav').trigger('click');
			setTimeout(function() {
				$('#customerModalBtn').focus();
			}, 50)
			return false;
		}

		if( $('#itemGubun').val() == ''){
			toastr.warning('품목구분을 선택해주세요.');
			$('#tab1Nav').trigger('click');
			setTimeout(function() {
				$('#itemGubun').focus();
			}, 50)
			return false;
		}
		
		if( $('#itemCd').val() == '' ){
			toastr.warning('제품코드를 입력해주세요.');
			$('#tab1Nav').trigger('click');
			setTimeout(function() {
				$('#itemCd').focus();
			}, 50)
			return false;
		}
		
		if( $('#itemNm').val() == ''){
			toastr.warning('제품명을 입력해주세요.');
			$('#tab1Nav').trigger('click');
			setTimeout(function() {
				$('#itemNm').focus();
			}, 50)
			return false;
		}

		if( $('#versionNum').val() == ''){
			toastr.warning('버전번호를 입력해주세요.');
			$('#tab1Nav').trigger('click');
			setTimeout(function() {
				$('#versionNum').focus();
			}, 50)
			return false;
		}

		/* if( $('#woodenCareCd').val() == ''){
			toastr.warning('목평관리번호를 선택해주세요.');
			$('#tab1Nav').trigger('click');
			setTimeout(function() {
				$('#woodenCareCd').focus();
			}, 50)
			return false;
		} */

		/* if( $('#bundleMethod').val() == '' ){
			toastr.warning('묶음법을 선택해주세요.');
			$('#tab2Nav').trigger('click');
			setTimeout(function() {
				$('#bundleMethod').focus();
			}, 50)
			return false;
		}

		if( $('#packMethod').val() == '' ){
			toastr.warning('포장방법을 선택해주세요.');
			$('#tab2Nav').trigger('click');
			setTimeout(function() {
				$('#packMethod').focus();
			}, 50)
			return false;
		}

		if( $('#inspectMethod').val() == '' ){
			toastr.warning('검수방법을 선택해주세요.');
			$('#tab2Nav').trigger('click');
			setTimeout(function() {
				$('#inspectMethod').focus();
			}, 50)
			return false;
		}

		if( $('#printingYnCheck').val() == '' ){
			toastr.warning('착인여부점검을 선택해주세요.');
			$('#tab2Nav').trigger('click');
			setTimeout(function() {
				$('#printingYnCheck').focus();
			}, 50)
			return false;
		} */

		
		
		let cmykString = '';
		if($('#checkC').prop('checked')){
			cmykString += 'C/';
		} else {
			cmykString += '/';
		}
		if($('#checkM').prop('checked')){
			cmykString += 'M/';
		} else {
			cmykString += '/';
		}
		if($('#checkY').prop('checked')){
			cmykString += 'Y/';
		} else {
			cmykString += '/';
		}
		if($('#checkK').prop('checked')){
			cmykString += 'K/';
		} else {
			cmykString += '/';
		}

		let formData3 = new FormData();
		let versionFileString = [];
		if($('#versionFileNm').val() != '' && $('#versionFileNm').val() != undefined){
			if(versionFileStatus){
				let fileInput = document.getElementById('versionFile'); 
				let files = fileInput.files; //업로드한 파일들의 정보를 넣는다.
				let uuid = uuid_v4();	
				formData3.append('file',files[0]);
				formData3.append('uuid',uuid);
				formData3.append('ext',files[0].name.split('.').at(-1));

				let fileArr = files[0].name.split('.');
				let fileFullNm = _.slice(fileArr, 0, -1).join('.');
				
				let obj = {};
				obj.uuid = uuid;
				obj.fileNm = fileFullNm;
				obj.ext = files[0].name.split('.').at(-1);
				
				versionFileString.push(obj);
			} else {
	
				let fileObject = new Object();			
				fileObject.uuid = fileUuid;
				fileObject.ext = fileExt;
				fileObject.fileNm = fileNm;
				let fileBlob = getFileBlob(fileObject);
				let blob = new Blob([base64ToArrayBuffer(fileBlob)], { type: data.ext });
	            let file = new File([blob], data.fileNm, { lastModified: new Date().getTime(), type: data.ext });
				formData3.append('file',file);
				formData3.append('uuid',fileUuid);
				formData3.append('ext',fileExt); 
				
				let obj = {};
				obj.uuid = fileUuid;
				obj.fileNm = fileNm;
				obj.ext = fileExt;
				
				versionFileString.push(obj);
			}
		}
		//버전번호 or 파일이 바뀌었는지 체크 값
		let versionCheck = (beforeVersion != $('#versionNum').val() || versionFileStatus);

		_promise_().then(()=>{
			$('#my-spinner').show();
		}).then(()=>{
			setTimeout(function(){
				let checkItemIdx;
				let check = false;
				if( !isEmptyCheck(itemInfoTable.row('.selected').data()) ){
					checkItemIdx =  itemInfoTable.row('.selected').data().idx;
				} else {
					checkItemIdx = '';
				}
			   //제품명 중복체크
				$.ajax({
					url: '<c:url value="/bm/itemNmDupCheck"/>',
		            type: 'POST',
		            async: false,
		            data: {
			            'idx'				:	function(){return checkItemIdx;},	
		            	'itemNm'			:	$('#itemNm').val(),
		            },
		            beforeSend: function() {
		            	$('#my-spinner').show();
		            },
					success : function(res) {
						if (res.result == "ok") { //응답결과
							check = true;
						} else if(res.result == 'fail') {
							$('#itemNmCheckModal').modal('show');
						} else {
							toastr.error(res.message);
						}
						$('#my-spinner').hide();
					}
				}); 
				if(check){
					// 등록할 경우에
					if(saveType == 'insert') {
						//사이즈 코팅방법 성형방식이 일치하는 수지판 목형 찾기 && 일치하는 번호로 세팅
						/* $.ajax({
							url: '<c:url value="/bm/woodenInfoAdmLstWithSizeCoatingMolding"/>',
				            type: 'POST',
				            async: false,
				            data: {
				            	'wdSize'				:	$('#itemSize').val(), //사이즈
				            	'coating'				:	$('#coatingMethod').val(), //코팅
				                'moldingContents'		:	$('#moldingMethod').val(), //성형방식
				                'moldingContentsReal'	:	$('#moldingContents').val(), //성형내용
				                'wdUnit'				:	$('#etc1').val(),//호기
				            },
				            beforeSend: function() {
				            	$('#my-spinner').show();
				            },
							success : function(res) {
								if (res.result == "ok") { //응답결과
									data = res.data;
		
									//목형리스트					
									let list = _.filter(data, v => v.commonDesc == 'a');
									let idxList = _.maxBy(list, (v => v.idx));
									if(idxList != null && idxList != undefined && idxList != ''){
										let lastIdx = idxList.idx;
										let findList = _.filter(list, v => v.idx == lastIdx);
										
										$('#woodenCareCd').val(findList[0].wdCd);
										$('#woodenCareIdx').val(findList[0].idx);
									}
									//수지판 리스트
									list = _.filter(data, v => v.commonDesc == 'b');
									idxList = _.maxBy(list, (v => v.idx));
									if(idxList != null && idxList != undefined && idxList != ''){
										lastIdx = _.maxBy(list, (v => v.idx)).idx;
										findList = _.filter(list, v => v.idx == lastIdx);
										
										$('#resinBoard').val(findList[0].wdCd);
										$('#resinBoardIdx').val(findList[0].idx);
									}
								} else if(res.result == 'fail') {
									toastr.warning(res.message);
								} else {
									toastr.error(res.message);
								}
								$('#my-spinner').hide();
							}
						}); */
	
						
						
						$.ajax({
							url: '<c:url value="/bm/itemInfoInsert"/>',
				            type: 'POST',
				            //async: false,
				            data: {
				                'useYnCd'			:	$('#useYnCd').val(),
				                'customerIdx'		:	$('#customerIdx').val(),
				                'itemCd'			:	$('#itemCd').val(),
				                'itemNm'			:	$('#itemNm').val(),
				                'itemSize'			:	$('#itemSize').val(),
				                'knifeTipSize'		:	$('#knifeTipSize').val(),
				                'woodenCareCd'		:	$('#woodenCareIdx').val(),
				                'holeWoodenCd'		:	$('#holeWoodenCd').val(),
				                'versionNum'		:	$('#versionNum').val(),
				                'stock'				:	$('#stock').val(),
				                'itemColor'			:	$('#itemColor').val(),
				                'frequency'			:	$('#frequency').val().replaceAll(',',''),
								'customerItemCd'	:	$('#customerItemCd').val(),
				                'specialNotice'		:	$('#specialNotice').val(),
				                'relayNotice'		:	$('#relayNotice').val(),
				                'coatingMethod'		:	$('#coatingMethod').val(),
				                'moldingMethod'		:	$('#moldingMethod').val(),
				                'moldingContents'	:	$('#moldingContents').val(),
				                'pressMethod'		:	$('#pressMethod').val(),
				                'bundleMethod'		:	$('#bundleMethod').val(),
				                'bundleUnit'		:	$('#bundleUnit').val(),
				                'packMethod' 		:	$('#packMethod').val(),
				                'packUnit' 			:	$('#packUnit').val(),
				                'workPrinter'		:	'',//$('#workPrinter').val(),
				                'detailDate' 		:	$('#detailDate').val(),
				                'masterPaper'		:	'',//$('#masterPaper').val(),
				                'roundPlateCnt'		:	'',//$('#roundPlateCnt').val(),
				                'careCd' 			:	'',//$('#careCd').val(),
				                'plane'				:	'',//$('#plane').val(),
				                'inspectMethod' 	:	$('#inspectMethod').val(),
				                'printingYnCheck'  	:	$('#printingYnCheck').val(),
				                'plateSize' 		:	'',//$('#plateSize').val(),
				                'etc1'  			: 	$('#etc1').val(),
				                'etc2'  			: 	$('#etc2').val(),
				                'etc3'  			: 	$('#etc3').val(),
				                'etc4'  			: 	$('#etc4').val(),
				                'etc5'  			: 	$('#etc5').val(),
				                'etc6'  			: 	$('#etc6').val(),
				                'etc7'  			: 	$('#etc7').val(),
				                'etc8'  			: 	$('#outCustomerIdx').val(),
				                'etc9'  			: 	$('#etc9').val(),
				                'etc10'  			: 	$('#confirmYnCheck').val(),
				                'itemGubun'			:	$('#itemGubun').val(),
				                'cmyk'				: 	function(){ return cmykString;},
				                'versionFileString' : 	JSON.stringify(versionFileString),
				                'versionCheck' 		:	function(){ return versionCheck;},
				                'resinBoard'		:	$('#resinBoardIdx').val(),
				                'lastWorkDate'		:	$('#lastWorkDate').val().replace(/-/g,''),
				            },
				            beforeSend: function() {
				            	$('#my-spinner').show();
				            },
							success : function(res) {
								if (res.result == "ok") { //응답결과
									let data = res.data;
									toastr.success('신규 저장되었습니다.');
									trId = res.idx;
									//$('#btnSearch').trigger('click'); // 조회버튼 click
									itemInfoTable.rows('.selected').deselect();
									itemInfoTable.ajax.reload(function(){
										setTimeout(function() {
										itemInfoTable.row('#'+trId).select();
										$(itemInfoTable.row('#'+trId).node()).trigger('click'); // 선택했던 항목 선택처리
										},100);
									},false);
									WM_action_OFF('new');
			
									$('#userPw').val('');
									$('#userPwCheck').val('');
			
									//버전파일 업로드
									if( versionFileStatus && versionFileString != undefined &&versionFileString != null && versionFileString != ''){
										fileUpload(formData3);
									}
									
									$('.inputGroup').attr('disabled', true); // 입력항목
									
									$('#btnNew').attr('disabled', false); // 신규 버튼
									$('#btnSave').attr('disabled', true); // 저장 버튼
									$('#btnEdit').attr('disabled', false); // 수정 버튼
									$('#btnDel').attr('disabled', false); // 삭제 버튼
									$('#btnCancel').attr('disabled', true); // 취소 버튼
									$('#btnStockBtn').attr('disabled',true);//재고폐기등록버튼
									itemVersionHistoryTable.ajax.reload(function(){});
			
									formData4 = new FormData();
									versionFileStatus = false;
								} else if(res.result == 'fail') {
									toastr.warning(res.message);
								} else {
									toastr.error(res.message);
								}
								$('#my-spinner').hide();
							}
						});
					} else { // 수정할 경우에
						let idx = itemInfoTable.row('.selected').data().idx;
						trId = itemInfoTable.row('.selected').data().idx;
						$.ajax({
							url: '<c:url value="/bm/itemInfoUpdate"/>',
				            type: 'POST',
				            //async: false,
				            data: {    
					            'idx'				:	function(){return idx;},
					            'useYnCd'			:	$('#useYnCd').val(),
				                'customerIdx'		:	$('#customerIdx').val(),
				                'itemCd'			:	$('#itemCd').val(),
				                'itemNm'			:	$('#itemNm').val(),
				                'itemSize'			:	$('#itemSize').val(),
				                'knifeTipSize'		:	$('#knifeTipSize').val(),
				                'woodenCareCd'		:	$('#woodenCareIdx').val(),
				                'holeWoodenCd'		:	$('#holeWoodenCd').val(),
				                'versionNum'		:	$('#versionNum').val(),
				                'stock'				:	$('#stock').val(),
				                'itemColor'			:	$('#itemColor').val(),
				                'frequency'			:	$('#frequency').val().replaceAll(',',''),
								'customerItemCd'	:	$('#customerItemCd').val(),
				                'specialNotice'		:	$('#specialNotice').val(),
				                'relayNotice'		:	$('#relayNotice').val(),
				                'coatingMethod'		:	$('#coatingMethod').val(),
				                'moldingMethod'		:	$('#moldingMethod').val(),
				                'moldingContents'	:	$('#moldingContents').val(),
				                'pressMethod'		:	$('#pressMethod').val(),
				                'bundleMethod'		:	$('#bundleMethod').val(),
				                'bundleUnit'		:	$('#bundleUnit').val(),
				                'packMethod' 		:	$('#packMethod').val(),
				                'packUnit' 			:	$('#packUnit').val(),
				                'workPrinter'		:	'',//$('#workPrinter').val(),
				                'detailDate' 		:	$('#detailDate').val(),
				                'masterPaper'		:	'',//$('#masterPaper').val(),
				                'roundPlateCnt'		:	'',//$('#roundPlateCnt').val(),
				                'careCd' 			:	'',//$('#careCd').val(),
				                'plane'				:	'',//$('#plane').val(),
				                'inspectMethod' 	:	$('#inspectMethod').val(),
				                'printingYnCheck'  	:	$('#printingYnCheck').val(),
				                'plateSize' 		:	'',//$('#plateSize').val(),
				                'etc1'  			: 	$('#etc1').val(),
				                'etc2'  			: 	$('#etc2').val(),
				                'etc3'  			: 	$('#etc3').val(),
				                'etc4'  			: 	$('#etc4').val(),
				                'etc5'  			: 	$('#etc5').val(),
				                'etc6'  			: 	$('#etc6').val(),
				                'etc7'  			: 	$('#etc7').val(),
				                'etc8'  			: 	$('#outCustomerIdx').val(),
				                'etc9'  			: 	$('#etc9').val(),
				                'etc10'  			: 	$('#confirmYnCheck').val(),
				                'itemGubun'			:	$('#itemGubun').val(),
				                'cmyk'				: 	function(){ return cmykString;},
				                'versionFileString' : 	JSON.stringify(versionFileString),
				                'versionCheck' 		:	function(){ return versionCheck;},
				                'resinBoard'		:	$('#resinBoardIdx').val(),
				                'lastWorkDate'		:	$('#lastWorkDate').val().replace(/-/g,''),
				            },
				            beforeSend: function() {
				            	$('#my-spinner').show();
				            },
							success : function(res) {
								if (res.result == "ok") { //응답결과
									toastr.success('수정 저장되었습니다.');
			
									//$('#btnSearch').trigger('click'); // 조회버튼 click
									itemInfoTable.rows('.selected').deselect();
									itemInfoTable.ajax.reload(function(){
										setTimeout(function() {
										itemInfoTable.row('#'+trId).select();
										$(itemInfoTable.row('#'+trId).node()).trigger('click'); // 선택했던 항목 선택처리
										},100);
									},false);
									WM_action_OFF('edit');
			
									$('.inputGroup').attr('disabled', true); // 입력항목
									$('#btnUserIdCheck').attr('disabled', true); // 중복확인 버튼
			
									//버전파일 업로드
									// 수정전 버전 번호 와 수정후 번호가 다를 경우 -> 파일 업로드
									if( beforeVersion != $('#versionNum').val() || versionFileStatus ){
										fileUpload(formData3);
									}
									
									$('#btnNew').attr('disabled', false); // 신규 버튼
									$('#btnSave').attr('disabled', true); // 저장 버튼
									$('#btnEdit').attr('disabled', false); // 수정 버튼
									$('#btnCopy').attr('disabled', false); // 복사 버튼
									$('#btnCancel').attr('disabled', true); // 취소 버튼
			
									$('#btnStockBtn').attr('disabled',true);//재고폐기등록버튼
									itemVersionHistoryTable.ajax.reload(function(){});
			
									formData4 = new FormData();
									versionFileStatus = false;
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
			},5);
		});
	});

	//기본정보 탭 클릭
	$('#tab1Nav').on('click',function(){
		//탑의 레이아웃이 가려졌을 때
		// Setting - 탑의 레이아웃 필요치 , Val - 현재 탑의 레이아웃 값
		/* let rightColTop1Setting = parseInt($('#rightHeader').css('height')) + parseInt($('#nav-tab').css('height')) + parseInt($('#tab1').css('height')) + 12;
		let rightColTopVal = parseInt($('#rightcolT').css('height'));
		
		if(rightColTopVal <= rightColTop1Setting){
			$('#page').css('grid-template-rows', rightColTop1Setting + 'px 4px 1fr');
			//$('#page').css('grid-template-rows','1.415fr 4px 1fr 4px 1fr');
		}		 */
		$('#fileTable').DataTable().draw();//파일테이블 
		$('#processInfoTable').DataTable().draw();//공정테이블
		$('#inputMaterialTable').DataTable().draw();//투입자재테이블
	});
	
	//세부정보탭클릭
	/* $('#tab2Nav').on('click',function(){
		//탑의 레이아웃이 가려졌을 때
		// Setting - 탑의 레이아웃 필요치 , Val - 현재 탑의 레이아웃 값
		let rightColTop2Setting = parseInt($('#rightHeader').css('height')) + parseInt($('#nav-tab').css('height')) + parseInt($('#tab2').css('height')) + 12;
		let rightColTopVal = parseInt($('#rightcolT').css('height'));
		
		if(rightColTopVal <= rightColTop2Setting){
			$('#page').css('grid-template-rows', rightColTop2Setting + 'px 4px 1fr 4px 1fr');
			//$('#page').css('grid-template-rows','1.301fr 4px 1fr 4px 1fr');
		}	
		$('#fileTable').DataTable().draw();//파일테이블 
		$('#processInfoTable').DataTable().draw();//공정테이블
		$('#inputMaterialTable').DataTable().draw();//투입자재테이블
		
	}); */
	
	//공정정보 탭 클릭
	$('#tab3Nav').on('click',function(){
		setTimeout(function(){
			processInfoTable.ajax.reload(function(){
				$('button[name=customerModalBtn]').attr('disabled',true);
				$('button[name=equipModalBtn]').attr('disabled',true);
				

				$('#my-spinner').hide();
				setTimeout(function() {
					processInfoTable.draw(false);
				},100);
			});
		},100);
	});
	
	//사진 및 첨부파일 탭 클릭
	$('#tab4Nav').on('click',function(){
		$('#fileTable_wrapper').find('tbody').find('.selected').removeClass('selected');
		setTimeout(function(){
			fileTable.ajax.reload(function(){
				fileTable.draw(false);
				$('#viewer').attr('src','');
			});
		},100);
	});
	
	//버전이력탭 클릭
	$('#tab5Nav').on('click',function(){
		setTimeout(function(){
			itemVersionHistoryTable.ajax.reload(function(){
				itemVersionHistoryTable.draw(false);
			});
		},100);
	});
	
	//제품수행이력탭 클릭
	$('#tab8Nav').on('click',function(){
		setTimeout(function(){
			itemPerformanceHistoryTable.ajax.reload(function(){
				itemPerformanceHistoryTable.draw(false);
			});
		},100);
	});

	//파일추가
	$('#btnVersionFile').on('click',function(){
		versionFileStatus = true;
		$('#versionFile').trigger('click');
	});

	$('#versionFile').on('change',function(){
		let fileInput = document.getElementById('versionFile');
		if(fileInput.files.length>0){ 
			let files = fileInput.files; //업로드한 파일들의 정보를 넣는다.
			$('#versionFileNm').val(files[0].name);
		}
	});
	
	//cmyk 커서 올렸을 때 css 변경
	//C
	$('#checkCLabel').hover(function(){
		$('#checkCLabel').css('background-color','#009FE3');
		$('#checkCLabel').css('color','#000000');
		$('#checkCLabel').css('border-color','#009FE3');
	}, function(){
		if(!$('#checkC').prop('checked')){
			$('#checkCLabel').css('background-color','#FFFFFF');
			$('#checkCLabel').css('color','#000000');
			$('#checkCLabel').css('border-color','#009FE3');
		}
	});
	
	//M
	$('#checkMLabel').hover(function(){
		$('#checkMLabel').css('background-color','#E6007E');
		$('#checkMLabel').css('color','#000000');
		$('#checkMLabel').css('border-color','#E6007E');
	}, function(){
		if(!$('#checkM').prop('checked')){
			$('#checkMLabel').css('background-color','#FFFFFF');
			$('#checkMLabel').css('color','#000000');
			$('#checkMLabel').css('border-color','#E6007E');
		}
	});
	
	//Y
	$('#checkYLabel').hover(function(){
		$('#checkYLabel').css('background-color','#FEED01');
		$('#checkYLabel').css('color','#000000');
		$('#checkYLabel').css('border-color','#FEED01');
	}, function(){
		if(!$('#checkY').prop('checked')){
			$('#checkYLabel').css('background-color','#FFFFFF');
			$('#checkYLabel').css('color','#000000');
			$('#checkYLabel').css('border-color','#FEED01');
		}
	});
	
	//K
	$('#checkKLabel').hover(function(){
		$('#checkKLabel').css('background-color','#000000');
		$('#checkKLabel').css('color','#FFFFFF');
		$('#checkKLabel').css('border-color','#000000');
	}, function(){
		if(!$('#checkK').prop('checked')){
			$('#checkKLabel').css('background-color','#FFFFFF');
			$('#checkKLabel').css('color','#000000');
			$('#checkKLabel').css('border-color','#000000');
		}
	});

	//cmyk 체크했을 때 css 변경
	//C
	$('#checkC').on('change',function(){
		if($('#checkC').prop('checked')){
			$('#checkCLabel').css('background-color','#009FE3');
			$('#checkCLabel').css('color','#000000');
		} else{
			$('#checkCLabel').css('background-color','#FFFFFF');
			$('#checkCLabel').css('color','#000000');
		}
	});
	
	//M
	$('#checkM').on('change',function(){
		if($('#checkM').prop('checked')){
			$('#checkMLabel').css('background-color','#E6007E');
			$('#checkMLabel').css('color','#000000');
		} else{
			$('#checkMLabel').css('background-color','#FFFFFF');
			$('#checkMLabel').css('color','#000000');
		}
	});
	
	//Y
	$('#checkY').on('change',function(){
		if($('#checkY').prop('checked')){
			$('#checkYLabel').css('background-color','#FEED01');
			$('#checkYLabel').css('color','#000000');
		} else{
			$('#checkYLabel').css('background-color','#FFFFFF');
			$('#checkYLabel').css('color','#000000');
		}
	});
	
	//K
	$('#checkK').on('change',function(){
		if($('#checkK').prop('checked')){
			$('#checkKLabel').css('background-color','#000000');
			$('#checkKLabel').css('color','#FFFFFF');
		} else{
			$('#checkKLabel').css('background-color','#FFFFFF');
			$('#checkKLabel').css('color','#000000');
		}
	});
	
	//사진확대축소
	$(document).ready(function(){
	//	$("#imgDiv").hover(function() {
		$('#fileTable tbody').on('click','tr', function() {
				 const element = document.getElementById('imgView');
				 const panzoom = Panzoom(element, {});		
				 const parent = element.parentElement;
			     parent.addEventListener('wheel', panzoom.zoomWithWheel);
		});
	//	}, function(){
			//$('#imgView').attr('style','');
	//	});
	});

	function base64ToArrayBuffer(base64) {
        const binaryString = window.atob(base64); // Comment this if not using base64
        const bytes = new Uint8Array(binaryString.length);
        return bytes.map((byte, i) => binaryString.charCodeAt(i));
   	}
	let appendString = [];
   	/* 투입자재 시작  */
   	$('#btnMaterialNew').on('click',function(){
   		WM_action_ON('matrlNew', 'workingWarningModal');
   		$('#inputMaterialTable').DataTable().row.add({
			'matrlIdx'		: null,
			'matrlCd'		: null,
			'matrlNm'		: null,
			'paperType'	: null,
			'matrlSize'		: null,
			'matrlSizeNm'	: null,
			'sizeX'			: null,
			'sizeY'			: null,
			'cutQty'		: null,
			'eaQty'			: null,
			'pressQty'		: null,
			'itemSize'		: null,
			'matrlNote'		: null,
			'dealCorpNm'	: null,
			'bomDesc'		: null,
		}).draw(false);
		
		$('#btnMaterialNew').attr('disabled',false);
		$('#btnMaterialSave').attr('disabled',false);
		$('#btnMaterialEdit').attr('disabled',true);
		$('#btnMaterialDel').attr('disabled',false);
		$('#btnMaterialCancel').attr('disabled',false);
		$('button[name=matrlModalBtn]').attr('disabled',false);
		$('input[name=cutQty]').attr('disabled',false);
		$('input[name=eaQty]').attr('disabled',false);
		//$('input[name=cutSize]').attr('disabled',false);
		$('select[name=dealCorpNm]').attr('disabled',false);
		$('input[name=bomDesc]').attr('disabled',false);
		$('button[name=dealCorpModalBtn]').attr('disabled',false);
		$('#inputMaterialTable').find('button[name=nameDel]').attr('disabled',false);
   	});

   	//투입자재 자재명
   	$(document).on('click','button[name=matrlModalBtn]',function(){
		$('#matrlModal').modal('show');   	
		setTimeout(function() {
			matrlModalTable.ajax.reload(function() {});
		}, 200);
	});
   	
 	// 투입자재 목록 조회
	$('#matrlModalTable thead tr').clone(true).addClass('filters').appendTo('#matrlModalTable thead'); // filter 생성
	let matrlModalTable = $('#matrlModalTable').DataTable({
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
			url : '<c:url value="/bm/matrlInfoListAll"/>',
			type : 'GET',
			data : {
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
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#matrlModalTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 237)+'px');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#modalMatrlSearchAll').off('keyup',function() {});
			$('#modalMatrlSearchAll').on('keyup',function() {
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
				let cell = $('#matrlModalTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#matrlModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	matrlModalTable.on('column-reorder', function( e, settings, details ) {
		let api = matrlModalTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#matrlModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});
	
	$('#btnMatrlModalSearch').on('click',function(){
		matrlModalTable.ajax.reload();
	});

	$('#btnMatrlModalPaste').on('click',function(){
		let status = true;
		let ngMatrlCd = '';
		//let selectedIndex = matrlModalTable.rows('.selected').toArray()[0];
		if(!$('#matrlModalTable tbody tr').hasClass('selected')){
			toastr.warning('붙여넣을 행을 선택해주세요.');
			return false;
		}
		$('#my-spinner').show();

		//중복체크
		$('#inputMaterialTable tbody tr').each(function(index){
			if(inputMaterialTable.row(index).data() != undefined){
				if(inputMaterialTable.row(index).data().matrlIdx == matrlModalTable.row('.selected').data().idx){
					ngMatrlCd += matrlModalTable.row('.selected').data().matrlCd + ', ';
					status = false;
				}
			}
		});
		ngMatrlCd = ngMatrlCd.slice(0, -2);
		if( status ){			
			$('#btnMaterialSave').attr('disabled',false);

			let node = inputMaterialTable.row('.selected').node();
			let nodeData = inputMaterialTable.row('.selected').data();
			let selectNodeModalData = matrlModalTable.row('.selected').data();
			
			nodeData.matrlIdx = selectNodeModalData.idx; 			//자재IDX
			nodeData.matrlCd = selectNodeModalData.matrlCd;			//자재코드
			nodeData.matrlNm = selectNodeModalData.matrlNm; 		//자재명
			nodeData.lawGubunNm = selectNodeModalData.lawGubunNm;	//결
			nodeData.amoutnAvg = selectNodeModalData.amountAvg;		//평량
			nodeData.paperType = selectNodeModalData.paperType;   // 자재 - 지종명(재질,지질 ?) -> 재질로 확정
			nodeData.matrlSize = selectNodeModalData.matrlSize; 	// 사이즈코드
			nodeData.sizeX = selectNodeModalData.sizeX; 			// 가로 크기 - 장
			nodeData.sizeY = selectNodeModalData.sizeY; 			// 세로 크기 - 폭
			nodeData.matrlNote = selectNodeModalData.matrlNote;		// 참고사항
			nodeData.dealCorpNm = selectNodeModalData.dealCorpNm;	// 발주처

			let matrlCdIdx = inputMaterialTable.column('matrlCd:name').index();
			let matrlNmIdx = inputMaterialTable.column('matrlNm:name').index();
			let lawGubunNmIdx = inputMaterialTable.column('lawGubunNm:name').index();
			let amountAvgIdx = inputMaterialTable.column('amountAvg:name').index();
			let paperTypeIdx = inputMaterialTable.column('paperType:name').index();
			let matrlSizeNmIdx = inputMaterialTable.column('matrlSizeNm:name').index();
			let sizeXIdx = inputMaterialTable.column('sizeX:name').index();
			let sizeYIdx = inputMaterialTable.column('sizeY:name').index();
			let matrlNoteIdx = inputMaterialTable.column('matrlNote:name').index();
			let dealCorpNmIdx = inputMaterialTable.column('dealCorpNm:name').index();
			
			$(node).find('td').eq(matrlCdIdx).find('input[name=matrlCd]').val(selectNodeModalData.matrlCd);			//자재코드
			$(node).find('td').eq(matrlNmIdx).find('input').val(selectNodeModalData.matrlNm); 						//자재명
			$(node).find('td').eq(lawGubunNmIdx).find('div').text(selectNodeModalData.lawGubunNm); 					//결
			$(node).find('td').eq(amountAvgIdx).find('div').text(selectNodeModalData.amountAvg); 					//평량
			$(node).find('td').eq(paperTypeIdx).find('div').text(selectNodeModalData.paperType); 				//재질?지질?
			$(node).find('td').eq(matrlSizeNmIdx).find('div').text(selectNodeModalData.matrlSizeNm);							//사이즈
			$(node).find('td').eq(sizeXIdx).find('div').text(selectNodeModalData.sizeX);							//장(가로)
			$(node).find('td').eq(sizeYIdx).find('div').text(selectNodeModalData.sizeY);							//폭(세로)
			$(node).find('td').eq(matrlNoteIdx).find('div').text(selectNodeModalData.matrlNote);					//참고사항
			$(node).find('td').eq(dealCorpNmIdx).find('button[name=dealCorpModalBtn]').attr('disabled',false);		//발주처 돋보기버튼 disabled 해제
			$(node).find('td').eq(dealCorpNmIdx).find('button[name=dealCorpModalBtn]').val(selectNodeModalData.idx);//발주처 돋보기버튼에 자재식별자 넣어두기
			$(node).find('td').eq(dealCorpNmIdx).find('input[type=hidden]').val(selectNodeModalData.dealCorpIdx);	//발주처 식별자
			$(node).find('td').eq(dealCorpNmIdx).find('input[type=text]').val(selectNodeModalData.dealCorpNm);		//발주처 이름 
			
			inputMaterialTable.draw(false);
			$('#matrlModal').modal('hide');
		} else {
			toastr.warning('이미 추가된 자재가 있습니다.<br>추가된 자재 코드 : '+ngMatrlCd);
		}
		$('#my-spinner').hide();
	});

	$('#matrlModalTable tbody').on('dblclick','tr',function(){
		$('#my-spinner').show();
		let status = true;
		let ngMatrlCd = '';
		//중복체크
		$('#inputMaterialTable tbody tr').each(function(index){
			if(inputMaterialTable.row(index).data() != undefined){
				if(inputMaterialTable.row(index).data().matrlIdx == matrlModalTable.row('.selected').data().idx){
					ngMatrlCd += matrlModalTable.row('.selected').data().matrlCd + ', ';
					status = false;
				}
			}
		});
		ngMatrlCd = ngMatrlCd.slice(0, -2);
		if( status ){			
			$('#btnMaterialSave').attr('disabled',false);

			let node = inputMaterialTable.row('.selected').node();
			let nodeData = inputMaterialTable.row('.selected').data();
			let selectNodeModalData = matrlModalTable.row('.selected').data();
			
			nodeData.matrlIdx = selectNodeModalData.idx; 			//자재IDX
			nodeData.matrlCd = selectNodeModalData.matrlCd;			//자재코드
			nodeData.matrlNm = selectNodeModalData.matrlNm; 		//자재명
			nodeData.lawGubunNm = selectNodeModalData.lawGubunNm;	//결
			nodeData.amoutnAvg = selectNodeModalData.amountAvg;		//평량
			nodeData.paperType = selectNodeModalData.paperType;   // 자재 - 지종명(재질,지질 ?) -> 재질로 확정
			nodeData.matrlSize = selectNodeModalData.matrlSize; 	// 사이즈코드
			nodeData.sizeX = selectNodeModalData.sizeX; 			// 가로 크기 - 장
			nodeData.sizeY = selectNodeModalData.sizeY; 			// 세로 크기 - 폭
			nodeData.matrlNote = selectNodeModalData.matrlNote;		// 참고사항
			nodeData.dealCorpNm = selectNodeModalData.dealCorpNm;	// 발주처

			let matrlCdIdx = inputMaterialTable.column('matrlCd:name').index();
			let matrlNmIdx = inputMaterialTable.column('matrlNm:name').index();
			let lawGubunNmIdx = inputMaterialTable.column('lawGubunNm:name').index();
			let amountAvgIdx = inputMaterialTable.column('amountAvg:name').index();
			let paperTypeIdx = inputMaterialTable.column('paperType:name').index();
			let matrlSizeNmIdx = inputMaterialTable.column('matrlSizeNm:name').index();
			let sizeXIdx = inputMaterialTable.column('sizeX:name').index();
			let sizeYIdx = inputMaterialTable.column('sizeY:name').index();
			let matrlNoteIdx = inputMaterialTable.column('matrlNote:name').index();
			let dealCorpNmIdx = inputMaterialTable.column('dealCorpNm:name').index();
			
			$(node).find('td').eq(matrlCdIdx).find('input[name=matrlCd]').val(selectNodeModalData.matrlCd);			//자재코드
			$(node).find('td').eq(matrlNmIdx).find('input').val(selectNodeModalData.matrlNm); 						//자재명
			$(node).find('td').eq(lawGubunNmIdx).find('div').text(selectNodeModalData.lawGubunNm); 					//결
			$(node).find('td').eq(amountAvgIdx).find('div').text(selectNodeModalData.amountAvg); 					//평량
			$(node).find('td').eq(paperTypeIdx).find('div').text(selectNodeModalData.paperType); 				//재질?지질?
			$(node).find('td').eq(matrlSizeNmIdx).find('div').text(selectNodeModalData.matrlSizeNm);							//사이즈
			$(node).find('td').eq(sizeXIdx).find('div').text(selectNodeModalData.sizeX);							//장(가로)
			$(node).find('td').eq(sizeYIdx).find('div').text(selectNodeModalData.sizeY);							//폭(세로)
			$(node).find('td').eq(matrlNoteIdx).find('div').text(selectNodeModalData.matrlNote);					//참고사항
			$(node).find('td').eq(dealCorpNmIdx).find('button[name=dealCorpModalBtn]').attr('disabled',false);		//발주처 돋보기버튼 disabled 해제
			$(node).find('td').eq(dealCorpNmIdx).find('button[name=dealCorpModalBtn]').val(selectNodeModalData.idx);//발주처 돋보기버튼에 자재식별자 넣어두기
			$(node).find('td').eq(dealCorpNmIdx).find('input[type=hidden]').val(selectNodeModalData.dealCorpIdx);	//발주처 식별자
			$(node).find('td').eq(dealCorpNmIdx).find('input[type=text]').val(selectNodeModalData.dealCorpNm);		//발주처 이름 
			
			inputMaterialTable.draw(false);
			$('#matrlModal').modal('hide');
		} else {
			toastr.warning('이미 추가된 자재가 있습니다.<br>추가된 자재 코드 : '+ngMatrlCd);
		}
		$('#my-spinner').hide();
	});
	
	//투입자재 저장
	$('#btnMaterialSave').on('click',function(){
		let status = true;
		let message = '';
		let insertList = [];
		$('#my-spinner').show();
		if( $('#inputMaterialTable tbody tr').length - $('#inputMaterialTable tbody tr').find('.dataTables_empty').length == 0 ){

		} else {
			$('#inputMaterialTable tbody tr').each(function(index){
				let cutQtyIdx = inputMaterialTable.column('cutQty:name').index();
				let eqQtyIdx = inputMaterialTable.column('eaQty:name').index();
				let extraQtyIdx = inputMaterialTable.column('extraQty:name').index();
				
				let cutQty = $(inputMaterialTable.row(index).node()).find('td').eq(cutQtyIdx).find('input[name=cutQty]').val();
				let eaQty = $(inputMaterialTable.row(index).node()).find('td').eq(eqQtyIdx).find('input[name=eaQty]').val();
				let extraQty = $(inputMaterialTable.row(index).node()).find('td').eq(extraQtyIdx).find('input[name=extraQty]').val();
				
				if(inputMaterialTable.row(index).data().matrlIdx == null || inputMaterialTable.row(index).data().matrlIdx == undefined){
					status = false;
					message = '자재코드를 선택하지 않은 행이 있습니다.';
				} else if( cutQty <= 0 || cutQty == ''){ 
					status = false;
					message = '절수를 입력하지 않은 행이 있습니다.';
				} else if(eaQty <= 0 || eaQty == ''){ 
					status = false;
					message = '개수를 입력하지 않은 행이 있습니다.';
				} else {
					let obj = {};
					obj.itemIdx = itemInfoTable.row('.selected').data().idx;
					obj.matrlIdx = inputMaterialTable.row(index).data().matrlIdx;
					obj.cutQty = $(this).find('td').eq(cutQtyIdx).find('input').val().replaceAll(/,/g,'');
					obj.eaQty = $(this).find('td').eq(eqQtyIdx).find('input').val().replaceAll(/,/g,'');
					obj.extraQty = $(this).find('td').eq(extraQtyIdx).find('input').val().replaceAll(/,/g,'');
					//obj.cutSize = $(this).find('td').eq(cutSizeIdx).find('input').val();
					let dealCorpIdx = null;
					if($(this).find('td').eq( inputMaterialTable.column('dealCorpNm:name').index()).find('input[name=dealCorpIdx]').val() != '' && $(this).find('td').eq( inputMaterialTable.column('dealCorpNm:name').index()).find('input[name=dealCorpIdx]').val() != "null"){
						dealCorpIdx = $(this).find('td').eq(inputMaterialTable.column('dealCorpNm:name').index()).find('input[name=dealCorpIdx]').val();
					} 
					obj.dealCorpIdx = dealCorpIdx;
					//obj.bomDesc = $(this).find('td').eq(inputMaterialTable.column('bomDesc:name').index()).find('input').val();
					obj.bomDesc = ''; 
					insertList.push(obj);
				}
			});
		}
		$('#my-spinner').hide();
		if(status){
			$.ajax({
				url: '<c:url value="/bm/itemBomInsert"/>',
	            type: 'POST',
	            //async: false,
	            data: {
	                'insertList' : 	JSON.stringify(insertList),
	                'itemIdx'	: function(){ return itemIdx; },
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if (res.result == "ok") { //응답결과
						let data = res.data;
						toastr.success('신규 저장되었습니다.');
						WM_action_OFF('matrlNew');
						$('#btnMaterialNew').attr('disabled',false);
						$('#btnMaterialSave').attr('disabled',true);
						$('#btnMaterialEdit').attr('disabled',false);
						$('#btnMaterialDel').attr('disabled',false);
						$('#btnMaterialCancel').attr('disabled',true);
						
						inputMaterialTable.ajax.reload(function(){});
						
					} else if(res.result == 'fail') {
						toastr.warning(res.message);
					} else {
						toastr.error(res.message);
					}
					$('#my-spinner').hide();
				}
			});
		} else {
			toastr.warning(message);
		}		
	});

	//자재투입 수정
	$('#btnMaterialEdit').on('click',function(){
		$('#btnMaterialNew').attr('disabled',false);
		$('#btnMaterialSave').attr('disabled',false);
		$('#btnMaterialEdit').attr('disabled',true);
		$('#btnMaterialDel').attr('disabled',false);
		$('#btnMaterialCancel').attr('disabled',false);

		$('button[name=matrlModalBtn]').attr('disabled',false);
		$('input[name=cutQty]').attr('disabled',false);
		$('input[name=eaQty]').attr('disabled',false);
		$('input[name=extraQty]').attr('disabled',false);
		//$('input[name=cutSize]').attr('disabled',false);
		$('select[name=dealCorpNm]').attr('disabled',false);
		$('input[name=bomDesc]').attr('disabled',false);
		$('button[name=dealCorpModalBtn]').attr('disabled',false);
		$('#inputMaterialTable').find('button[name=nameDel]').attr('disabled',false);
		WM_action_ON('matrlNew', 'workingWarningModal');
	});
	
	//자재투입 삭제
	$('#btnMaterialDel').on('click',function(){
		if(!$('#inputMaterialTable tbody tr').hasClass('selected')){
			toastr.warning('삭제할 항목을 선택해주세요.');
			return false;
		}

		let idx = inputMaterialTable.row('.selected').data().idx;
		if(idx != '' && idx != undefined){
			delStatus = 'inputMatrl';
			$('#deleteModal').modal('show');
		} else {
			$('#inputMaterialTable').DataTable().row('.selected').remove().draw();
		}
	});

	//발주처(자재투입) 목록 조회
	let matrlIdx = '';
	
	//자재투입 발주처 돋보기버튼
	$(document).on('click','button[name=dealCorpModalBtn]',function(){
		matrlIdx = $(this).val(); //자재 식별자
		if(matrlIdx == '' || matrlIdx == null || matrlIdx == "null"){
			matrlIdx = 0;
		}
		customerModalGubun = 'inputMatrl'
		$('#dealCorpSelectGubun').val('matrlCorp');
		dealCorpSelectGubun = $('#dealCorpSelectGubun').val();
		$('#dealCorpModal').modal('show');
		setTimeout(function() {
			dealCorpModalTable.ajax.reload(function() {});
		}, 200);	
	});

	/* 공정정보 시작  */
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

   	$(document).on('click','button[name=prcssModalBtn]',function(){
   		prcssModalTable.select.style('single');
		$('#prcssModal').modal('show');   	
		setTimeout(function() {
			prcssModalTable.ajax.reload(function() {});
		}, 200);
	});

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
						'prcssOrder'			: rowLvl,
						'prcssCd'				: null,
						'prcssNm'				: null,
						'equipIdx'				: null,
						'equipNm'				: null,
						'outsrcGubun'			: null,
						'workMethod'			: null,
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
		
					$('#processInfoTable tbody tr').eq(rowLvl).find('td').eq(1).html('<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+modalData.prcssCd+'</div>');
					$('#processInfoTable tbody tr').eq(rowLvl).find('td').eq(8).html('<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+modalData.qtyUnitNm+'</div>');
					$('#processInfoTable tbody tr').eq(rowLvl).find('td').eq(9).html('<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+modalData.prcssDesc+'</div>');
					//공정명 html
					let html1='';
					html1 += '<div style="display: flex; flex-wrap: 1 1 auto;">';
					html1 += '<input type="text" class="form-control inputGroup" id="prcssNm" style="max-width: 100%;" disabled="disabled" value="'+modalData.prcssNm+'">';
					html1 += '<input type="hidden" id="prcssIdx">';
					html1 += '</div>';			
					$('#processInfoTable tbody tr').eq(rowLvl).find('td').eq(2).html(html1);

					
					
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
				$('#processInfoTable tbody').find('.selected').find('td').eq(8).html('<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+prcssModalTable.row('.selected').data().qtyUnitNm+'</div>');
				$('#processInfoTable tbody').find('.selected').find('td').eq(9).html('<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+prcssModalTable.row('.selected').data().prcssDesc+'</div>');
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
					
					obj.itemIdx = itemInfoTable.row('.selected').data().idx;
					obj.prcssOrder = processInfoTable.row(index).data().prcssOrder;
					obj.prcssIdx = processInfoTable.row(index).data().prcssIdx;
					let equipIdx = null;
					//if( processInfoTable.row(index).data().equipIdx != '' && processInfoTable.row(index).data().equipIdx != null ){
					//	equipIdx = processInfoTable.row(index).data().equipIdx;
					//}
					equipIdx = $(node).find('td').eq(3).find('select').val();
					obj.equipIdx = equipIdx;
					obj.outsrcGubun =  $(node).find('td').eq(4).find('select').val();
					obj.workMethod = $(node).find('td').eq(5).find('input[name=workMethodMultiSelect]').val();
					obj.workMethodDtl = $(node).find('td').eq(6).find('input').val();
					let outsrcIdx = null;
					if( $(node).find('td').eq(7).find('input[type=hidden]').val() != ''){
						outsrcIdx = $(node).find('td').eq(7).find('input[type=hidden]').val();
					}
					obj.outsrcIdx = outsrcIdx;
					obj.note = $(node).find('td').eq(10).find('input')	.val();
					insertList.push(obj);
				}
			});
		}
		$('#my-spinner').hide();
		if(status){
			$.ajax({
				url: '<c:url value="/bm/itemPrcssInsert"/>',
	            type: 'POST',
	            //async: false,
	            data: {
	                'insertList' : 	JSON.stringify(insertList),
	                'itemIdx'	: function(){ return itemIdx; },
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


							$('#my-spinner').hide();
							setTimeout(function() {
								processInfoTable.draw(false);
							},100);
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
			$('input[name=workMethodMultiSelect]').attr('disabled',false);
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
		if(idx != '' && idx != undefined){
			delStatus = 'prcss';
			$('#deleteModal').modal('show');
		} else {
			$('#processInfoTable').DataTable().row('.selected').remove().draw(false);
		}
	});

	let prcssIdx = '';
	let prcssEquipSelectGubun = 'prcssEquip';
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
	
	
	//제품정보 목록(모달)조회
	let itemInfoModalTable = null; 
	/* $('#itemInfoModalTable thead tr').clone(true).addClass('filters').appendTo('#itemInfoModalTable thead'); // filter 생성
	let itemInfoModalTable = $('#itemInfoModalTable').DataTable({
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
				useYnCd : function(){return 'Y';},
				//itemGubun : function(){return $('#searchItemGubun').val();},
			},
		},
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
			},	//호기	
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
			{ data: 'pressMethod', className : 'text-center align-middle'},	//기타3
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
			{ data: 'etc5', className : 'text-center align-middle'},	//기타2	
			{ data: 'etc6', className : 'text-center align-middle'},	//형압
			{ data: 'etc7', className : 'text-center align-middle'},	//
			{ data: 'etc8', className : 'text-center align-middle'},	//기타2
			{ data: 'etc9', className : 'text-center align-middle'},	//기타3
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
			let theadHeight = parseFloat($('#itemInfoModalTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 250)+'px');
			
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
				let cell = $('#itemInfoModalTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#itemInfoModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	itemInfoModalTable.on('column-reorder', function( e, settings, details ) {
		let api = itemInfoModalTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#itemInfoModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	}); */

	//고객사(거래처)모달
	let customerModalGubun = '';
	$(document).on('click','.customerModalBtn',function(){
	//$('#customerModalBtn').on('click',function(){
		//customerModalGubun = 'customer';
		customerModalGubun = $(this).data('gubun');
		$('#dealCorpModal').modal('show');
		setTimeout(function() {
			dealCorpModalTable.ajax.reload(function() {});
		}, 200);
	});

	$('#btnDealCorpModalSearch').on('click',function(){
		dealCorpModalTable.ajax.reload(function() {});
	});

	//공정정보 외주처
	$(document).on('click','button[name=customerModalBtn]',function(){
		customerModalGubun = 'prcss';
		$('#dealCorpModal').modal('show');
		setTimeout(function() {
			dealCorpModalTable.ajax.reload(function() {});
		}, 200);
	});
	
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
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 223)+'px');
			
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
	
	$('#btnDealCorpModalPaste').on('click',function(){
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
			$('#processInfoTable tbody').find('.selected').find('td').eq(7).html(html1);
			processInfoTable.draw(false);
		} else if ( customerModalGubun == 'inputMatrl' ){
			let node = inputMaterialTable.row('.selected').node();
			let nodeData = inputMaterialTable.row('.selected').data();
			let selectNodeModalData = dealCorpModalTable.row('.selected').data();
			nodeData.dealCorpNm = selectNodeModalData.dealCorpNm;
			$(node).find('td').eq(inputMaterialTable.column('dealCorpNm:name').index()).find('input[type=hidden]').val(selectNodeModalData.idx);			//발주처 식별자
			$(node).find('td').eq(inputMaterialTable.column('dealCorpNm:name').index()).find('input[type=text]').val(selectNodeModalData.dealCorpNm);		//발주처 이름
			$('#dealCorpModal').modal('hide');
		} else if ( customerModalGubun == 'outCustomer' ){
			$('#outCustomerIdx').val(idx);
			$('#outCustomerNm').val(dealCorpModalTable.row('.selected').data().dealCorpNm);
		}
		
		$('#dealCorpModal').modal('hide');
	});

	$('#dealCorpModalTable tbody').on('dblclick','tr',function(){
		let idx = dealCorpModalTable.row(this).data().idx;
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
			$('#processInfoTable tbody').find('.selected').find('td').eq(7).html(html1);
			processInfoTable.draw(false);
		} else if ( customerModalGubun == 'inputMatrl' ){
			let node = inputMaterialTable.row('.selected').node();
			let nodeData = inputMaterialTable.row('.selected').data();
			let selectNodeModalData = dealCorpModalTable.row('.selected').data();
			nodeData.dealCorpNm = selectNodeModalData.dealCorpNm;
			$(node).find('td').eq(inputMaterialTable.column('dealCorpNm:name').index()).find('input[type=hidden]').val(selectNodeModalData.idx);			//발주처 식별자
			$(node).find('td').eq(inputMaterialTable.column('dealCorpNm:name').index()).find('input[type=text]').val(selectNodeModalData.dealCorpNm);		//발주처 이름
			$('#dealCorpModal').modal('hide');
		} else if ( customerModalGubun == 'outCustomer' ){
			$('#outCustomerIdx').val(idx);
			$('#outCustomerNm').val(dealCorpModalTable.row('.selected').data().dealCorpNm);
		}
		
		$('#dealCorpModal').modal('hide');
	});	
	
	//공정순서변경되었을 때
	processInfoTable.on( 'row-reorder', function ( e, diff, changes ) {
		if(diff.length != 0){
			$('#btnProcessSave').attr('disabled',false);
			WM_action_ON('prcssNew', 'workingWarningModal');
		}
	} );

	let expendGubun = '';
	$('#woodenCareBtn').on('click',function(){
		expendGubun = '01';
		$('#woodenInfoModal').modal('show');
		setTimeout(function() {
			woodenInfoModalTable.ajax.reload(function() {});
		}, 200);
	});

	$('#resinBoardBtn').on('click',function(){
		expendGubun = '02';
		$('#woodenInfoModal').modal('show');
		setTimeout(function() {
			woodenInfoModalTable.ajax.reload(function() {});
		}, 200);
	});

	$('#afterProcessingBtn').on('click',function(){
		expendGubun = '03';
		$('#woodenInfoModal').modal('show');
		setTimeout(function() {
			woodenInfoModalTable.ajax.reload(function() {});
		}, 200);
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
				expendGubun : function(){ return expendGubun; },
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

	//$('#woodenInfoModalTable tbody').on('dblclick','tr', function() {
	$('#btnWoodenInfoModalPaste').on('click', function() {
		if( !$('#woodenInfoModalTable tbody tr').hasClass('selected') ){
			toastr.warning('적용할 행을 선택해주세요.');
			return false;
		}
		let data = woodenInfoModalTable.row('.selected').data();
		let idx = data.idx;
		if(expendGubun == '01'){
			$('#woodenCareCd').val(data.wdCd);
			$('#woodenCareIdx').val(idx);

			$('#itemSize').val(data.wdSize);//사이즈
			//$('#coatingMethod').val(data.coating);
			$('#moldingMethod').val(data.moldingContents);//성형방법
			$('#moldingContents').val(data.moldingContentsReal);//성형내용

			$('#bundleMethod').val(data.bundleMethod);//묶음법
			$('#bundleUnit').val(data.bundleUnit);//묶음단위
			$('#packUnit').val(data.packUnit);//포장단위
			$('#packMethod').val(data.packMethod);//포장박스
			
		} else if (expendGubun == '02'){
			$('#resinBoard').val(data.wdCd);
			$('#resinBoardIdx').val(idx);
			
			//$('#itemSize').val(data.wdSize);
			//$('#coatingMethod').val(data.coating);//코팅
			$('#etc1').val(data.wdUnit);//호기
			//$('#moldingMethod').val(data.moldingContents);

		} else if(expendGubun == '03'){
			$('#etc2Cd').val(data.wdCd);
			$('#etc2').val(idx);

			$('#etc3').val(data.afterProcessing);//후가공
			//$('#etc4').val(data.afterProcessingWdUnit);//후가공호기
			
		}
		$('#woodenInfoModal').modal('hide');
		
	});

	$('#woodenInfoModalTable tbody').on('dblclick','tr',function(){
		let data = woodenInfoModalTable.row(this).data();
		let idx = data.idx;
		if(expendGubun == '01'){
			$('#woodenCareCd').val(data.wdCd);
			$('#woodenCareIdx').val(idx);

			$('#itemSize').val(data.wdSize);//사이즈
			//$('#coatingMethod').val(data.coating);
			$('#moldingMethod').val(data.moldingContents);//성형방법
			$('#moldingContents').val(data.moldingContentsReal);//성형내용

			$('#bundleMethod').val(data.bundleMethod);//묶음법
			$('#bundleUnit').val(data.bundleUnit);//묶음단위
			$('#packUnit').val(data.packUnit);//포장단위
			$('#packMethod').val(data.packMethod);//포장박스
			
		} else if (expendGubun == '02'){
			$('#resinBoard').val(data.wdCd);
			$('#resinBoardIdx').val(idx);
			
			//$('#itemSize').val(data.wdSize);
			$('#coatingMethod').val(data.coating);//코팅
			$('#etc1').val(data.wdUnit);//호기
			//$('#moldingMethod').val(data.moldingContents);

		} else if(expendGubun == '03'){
			$('#etc2Cd').val(data.wdCd);
			$('#etc2').val(idx);

			$('#etc3').val(data.afterProcessing);//후가공
			//$('#etc4').val(data.afterProcessingWdUnit);//후가공호기
			
		}
		$('#woodenInfoModal').modal('hide');
		
	});	
	
	/*************************** 재고폐기등록 ***************************/
	//재고폐기등록 클릭
	$('#btnStockBtn').on('click',function(){
		let idx = itemInfoTable.row('.selected').data().idx;
		_promise_().then(()=>{
			$('#my-spinner').show();
		}).then(()=>{
			$.ajax({
				url: '<c:url value="/bm/itemInfoSel"/>',
	            type: 'GET',
	            async: false,
	            data: {
	                'idx'	:	idx
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if (res.result == "ok") { //응답결과
						data = res.data;

						let versionJson = JSON.parse(data.versionJson);
						$('#stockModalVersionNum').empty();
						let html = '';
						if( !isEmptyCheck(versionJson) ){
							for( var i = 0 ; i < versionJson.length ; i++ ){
								html += '<option value="'+versionJson[i].IDX+'">'+versionJson[i].ITEM_VERSION+'</option>';
							}
						} else {
							html += '<option value="">선택</option>';
						}
						$('#stockModalVersionNum').append(html);
						
						$('#stockModalCustomer').text(data.customerNm);
						$('#stockModalitemNm').text(data.itemNm);
						$('#stockModalCustomerItemCd').text(data.customerItemCd);
						//$('#stockModalVersionNum').text(data.versionNum);
						$('#stockModalSize').text(data.itemSize);
						$('#stockModalStockQty').text(parseInt(data.stock));
						$('#disposalDate').val(moment().format('YYYY-MM-DD'));

						$('#disposalCd').val('');
						$('#disposalQty').val('0');
						$('#disposalDesc').val('');
						$('#disposalFile').val('');
						$('#disposalFileNm').val('');
						$('#disposalReason').val('');
						$('#disposalDesc').val('');
						$('#disposalManagerIdx').val(sessionUserIdx);
						$('#disposalManagerNm').val(sessionUserNm);
						$('#produceManagerIdx').val(sessionUserIdx);
						$('#produceManagerNm').val(sessionUserNm);
						
						$('#stockAddModal').modal('show');
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

	$('#stockAddModal').on('shown.bs.modal',function(){
		itemVersionDisposalTable.ajax.reload();
	});
	
	//재고폐기파일추가
	$('#btnDisposalFile').on('click',function(){
		$('#disposalFile').val('');
		$('#disposalFile').trigger('click');
	});

	$('#disposalFile').on('change',function(){
		let fileInput = document.getElementById('disposalFile');
		if(fileInput.files.length>0){ 
			let files = fileInput.files; //업로드한 파일들의 정보를 넣는다.
			$('#disposalFileNm').val(files[0].name);
		}
	});

	//담당자
	$('#btnDisposalManager').on('click',function(){
		$('#userModal').modal('show');
		setTimeout(function() {
			userModalTable.ajax.reload(function() {});
		}, 200);
		$('#userModal').data('userType','disposal');
	});

	//제조책임자
	$('#btnProduceManager').on('click',function(){
		$('#userModal').modal('show');
		setTimeout(function() {
			userModalTable.ajax.reload(function() {});
		}, 200);
		$('#userModal').data('userType','produce');
	});

	//재고폐기 저장
	$('#btnStockAddModalSave').on('click',function(){
		if( $('#stockModalVersionNum').val() == '' ) {
			toastr.warning('폐기버전을 선택해주세요.');
			$('#stockModalVersionNum').focus();
			return false;
		} 
		
		if( $('#disposalCd').val() == '' ){
			toastr.warning('폐기코드를 선택해주세요.');
			$('#disposalCd').focus();
			return false;
		}
		if( $('#disposalQty').val() == '' || $('#disposalQty').val() == '0' ){
			toastr.warning('폐기량을 입력해주세요.');
			$('#disposalQty').focus();
			return false;
		}
		/* if( $('#disposalManagerNm').val() == '' || $('#disposalManagerIdx').val() == '' ){
			toastr.warning('담당자를 선택해주세요.');
			$('#btnDisposalManager').focus();
			return false;
		}
		if( $('#produceManagerNm').val() == '' || $('#produceManagerIdx').val() == '' ){
			toastr.warning('제조책임자를 선택해주세요.');
			$('#btnProduceManager').focus();
			return false;
		} */
		let formData3 = new FormData();
		let fileInput = document.getElementById('disposalFile');
		let uuid = '';
		let fileFullNm = '';
		let ext = '';
		//업로드된 파일이 있을 경우
		if(fileInput.files.length>0){ 
			let files = fileInput.files; //업로드한 파일들의 정보를 넣는다.
			uuid = uuid_v4();	
			formData3.append('file',files[0]);
			formData3.append('uuid',uuid);
			formData3.append('ext',files[0].name.split('.').at(-1));

			let fileArr = files[0].name.split('.');
			fileFullNm = _.slice(fileArr, 0, -1).join('.');
			ext = files[0].name.split('.').at(-1);
		}
		
		$.ajax({
			url: '<c:url value="/stock/itemDisposalAdmIns"/>',
            type: 'POST',
            data: {
            	'itemIdx'             : function(){ return itemInfoTable.row('.selected').data().idx;},
            	'mangerIdx'           : function(){ return $('#disposalManagerIdx').val();},
            	'produceMangerIdx'    : function(){ return $('#produceManagerIdx').val();},
            	'itemVerIdx'		  : function(){ return $('#stockModalVersionNum').val();},
            	'customerItemCd'	  : function(){ return itemInfoTable.row('.selected').data().customerItemCd;},
            	'disposalCd'          : function(){ return $('#disposalCd').val();},
             	'disposalQty'         : function(){ return $('#disposalQty').val().replaceAll(',','');},
            	'disposalReason'      : function(){ return $('#disposalReason').val();},
            	'fileUuid'            : function(){ return uuid;},
            	'fileNm'              : function(){ return fileFullNm;},
            	'fileExt'             : function(){ return ext;},
            	'disposalDate'        : function(){ return $('#disposalDate').val().replaceAll('-','');},
            	'disposalDesc'        : function(){ return $('#disposalDesc').val();}
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
			success : function(res) {
				if (res.result == "ok") { //응답결과
					let data = res.data;
					toastr.success('폐기 등록되었습니다.');

					if( fileInput.files.length>0){
						fileUpload(formData3);
					}
					trId =  itemInfoTable.row('.selected').data().idx;
					itemInfoTable.rows('.selected').deselect();
					itemInfoTable.ajax.reload(function(){
						setTimeout(function() {
							itemInfoTable.row('#'+trId).select();
							$(itemInfoTable.row('#'+trId).node()).trigger('click'); // 복사된거 선택처리
							$('#my-spinner').hide();
						}, 100)
							
					},false);
					$('#stockAddModal').modal('hide');
				} else if(res.result == 'fail') {
					toastr.warning(res.message);
				} else {
					toastr.error(res.message);
				}
			}
		});
	});
	
	// 사용자정보 목록조회
	$('#userModalTable thead tr').clone(true).addClass('filters').appendTo('#userModalTable thead'); // filter 생성
	let userModalTable = $('#userModalTable').DataTable({
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
			url : '<c:url value="/sm/userLst"/>',
			type : 'POST',
			data : {
				userStateCd: function() { return $('#SearchUserStateCd').val(); }
			},
		},
        rowId: 'idx',
		columns : [
			{ data: 'userId', className : 'text-center'},
			{ data: 'userName', className : 'text-center'},
			{ data: 'userDepartmentCd', className : 'text-center'},
			{ data: 'userPositionCd', className : 'text-center'},
			{ data: 'userJobCd', className : 'text-center'},
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
			let theadHeight = parseFloat($('#userModalTable_wrapper').find('.dataTables_scrollHead').css('height'));
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
				let cell = $('#userModalTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#userModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	userModalTable.on('column-reorder', function( e, settings, details ) {
		let api = userModalTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#userModalTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	// 사용자모달 조회 버튼 click
	$('#btnUserModalSearch').on('click', function() {
		userModalTable.ajax.reload(function(){});
	});
	
	// 사용자목록 적용 버튼 click
	$('#btnUserModalPaste').on('click', function(){
		if( !$('#userModalTable tbody tr').hasClass('selected') ){
			toastr.warning('적용할 행을 선택해주세요.');
			return false;
		}
		
		let data = userModalTable.row('.selected').data();
		let userType = $('#userModal').data('userType');
		if(userType == 'disposal'){
			$('#disposalManagerIdx').val(data.idx);
			$('#disposalManagerNm').val(data.userName);
		} else if(userType == 'produce'){
			$('#produceManagerIdx').val(data.idx);
			$('#produceManagerNm').val(data.userName);
		}		
		$('#userModal').modal('hide');
	});
	
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
		//투입자재에 자재코드를 지울 때
		if($(this).hasClass('matrlCd')){

			let node = inputMaterialTable.row($(this).val()).node();
			let data = inputMaterialTable.row($(this).val()).data();

			data.matrlIdx = null;
			data.matrlCd = null;
			data.matrlNm = null;
			data.lawGubunNm = null;
			data.amountAvg = null;
			data.paperType = null;
			data.sizeX = null;
			data.sizeY = null;
			
			let matrlCdIdx = inputMaterialTable.column('matrlCd:name').index();
			let lawGubunNmIdx = inputMaterialTable.column('lawGubunNm:name').index();
			let amountAvgIdx = inputMaterialTable.column('amountAvg:name').index();
			let paperTypeIdx = inputMaterialTable.column('paperType:name').index();
			let sizeXIdx = inputMaterialTable.column('sizeX:name').index();
			let sizeYIdx = inputMaterialTable.column('sizeY:name').index();
			let matrlNoteIdx = inputMaterialTable.column('matrlNote:name').index();

			$(node).find('td').eq(matrlCdIdx).find('input[name=matrlCd]').text('');		//자재코드
			$(node).find('td').eq(lawGubunNmIdx).find('div').text('');				 	//결
			$(node).find('td').eq(amountAvgIdx).find('div').text(''); 					//평량
			$(node).find('td').eq(paperTypeIdx).find('div').text(''); 				//재질?지질?
			$(node).find('td').eq(sizeXIdx).find('div').text('');						//장(가로)
			$(node).find('td').eq(sizeYIdx).find('div').text('');						//폭(세로)
			$(node).find('td').eq(matrlNoteIdx).find('div').text('');					//참고사항
		}
		//자재에 발주처 
		if($(this).hasClass('dealCorpNm')){
			let data = inputMaterialTable.row($(this).val()).data();
			let node = inputMaterialTable.row($(this).val()).node();
			data.dealCorpIdx = null;
			let dealCorpNmIdx = inputMaterialTable.column('dealCorpNm:name').index();
			//$(node).find('td').eq(dealCorpNmIdx).find('button[name=dealCorpModalBtn]').val('');//발주처 돋보기버튼에 자재식별자 넣어두기
			$(node).find('td').eq(dealCorpNmIdx).find('input[type=hidden]').val('');	//발주처 식별자
			data.dealCorpNm = null;
		}
		
		if($(this).next().hasClass('inputIdx')){
			$(this).next().val('');
		}
	});

	$('#tab6Nav').on('click',function(){
		inputMaterialTable.ajax.reload(function(){
			inputMaterialTable.draw().columns.adjust();
		});
	});
	
	/* 번들링정보 */
	$('#tab7Nav').on('click',function(){
		bundleInfoTable.ajax.reload(function(){
			bundleInfoTable.draw().columns.adjust();
		});
		
		//$('#btnBundleNew').attr('disabled',false);
		//$('#btnBundleSave').attr('disabled',true);
		//$('#btnBundleEdit').attr('disabled',false);
		//$('#btnBundleDel').attr('disabled',false);
		//$('#btnBundleCancel').attr('disabled',true);
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
			url : '<c:url value="/bm/bundleInfoList"/>',
			type : 'POST',
			data : {
				'itemIdx'	: function(){ return itemIdx; },
			},
		}, 
        rowId: 'idx',
		columns : [
			{ data: 'itemCd', className : 'text-center', name : 'itemCd',
				render: function(data, type, row, meta) {
					if(data != null){
						return '<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+data+'</div><input type="hidden" name="itemIdx" value="'+row['itemDtlIdx']+'">';
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
						return '<input type="text" class="form-control text-start" name="bizOrdDtlNo">';
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
			/* { extend: 'excel',	text: 'Excel',	charset: 'UTF-8', bom: true },
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
			{ data: 'etc10', className : 'text-center align-middle'}, //컨펌유무
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
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 260)+'px');
			
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
			obj.itemDtlIdx = dataList[i].idx;
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
				} else if(index_td == bundleInfoTable.column('bizOrdDtlNo:name').index()) { //투입수량
					let value = isEmptyCheck(bundleInfoTable.row(tr).data().bizOrdDtlNo) ? '' : bundleInfoTable.row(tr).data().bizOrdDtlNo;
					$(td).html('<input type="text" class="form-control text-start" name="bizOrdDtlNo" value="'+value+'">');
				} else if(index_td == bundleInfoTable.column('bundleDesc:name').index()) { //투입수량
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
			let bizOrdDtlNoVal = $(node).find('td').eq(bizOrdDtlNoCol).find('input[name=bizOrdDtlNo]').val().trim();
			let bundleDescVal = $(node).find('td').eq(bundleDescCol).find('input[name=bundleDesc]').val();

			/* if(inputQtyVal == '' || inputQtyVal == '0'){
				toastr.warning('투입수량을 입력해주세요.');
				$(node).find('td').eq(inputQtyCol).find('input[name=inputQty]').focus();
				state = false;
				return false;
			} */
			
			let obj = {};
			obj.idx = data.idx;
			obj.itemAdmIdx = itemInfoTable.row('.selected').data().idx;
			obj.itemDtlIdx = itemIdxVal;
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
			obj.itemAdmIdx = data.itemAdmIdx;
			obj.itemDtlIdx = data.itemDtlIdx;
			obj.inputQty = parseInt(data.inputQty);
			obj.bizOrdDtlNo = data.bizOrdDtlNo;
			obj.bundleDesc = data.bundleDesc;
			
			tableData.push(obj);
		}
		
		insertList = _.differenceWith(insertList, tableData, _.isEqual);
		if(state){
			$.ajax({
				url: '<c:url value="/bm/bundleInfoInsert"/>',
	            type: 'POST',
	            data: {
	                'insertList'	:	function(){ return JSON.stringify(insertList); }
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if(res.result == 'ok'){
						WM_action_OFF('bundleNew');
						toastr.success('등록되었습니다.');
						bundleInfoTable.ajax.reload(function(){});
						$('#btnBundleNew').attr('disabled',false);
						$('#btnBundleSave').attr('disabled',true);
						$('#btnBundleEdit').attr('disabled',false);
						$('#btnBundleDel').attr('disabled',false);
						$('#btnBundleCancel').attr('disabled',true);
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
				} else if(index_td == bundleInfoTable.column('bizOrdDtlNo:name').index()) { //투입수량
					let value = isEmptyCheck(bundleInfoTable.row(tr).data().bizOrdDtlNo) ? '' : bundleInfoTable.row(tr).data().bizOrdDtlNo;
					$(td).html('<input type="text" class="form-control text-start" name="bizOrdDtlNo" value="'+value+'">');
				} else if(index_td == bundleInfoTable.column('bundleDesc:name').index()) { //투입수량
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
			delStatus = 'bundle'
			$('#deleteModal').modal('show');
		} else {
			$('#bundleInfoTable').DataTable().row('.selected').remove().draw();
		}
		
	});	

	$('#btnBundleCancel').on('click',function(){
		CancelIdx = 'bundle';
		$('#cancelModal').modal('show');
	});

	$('#btnItemNmCheckModalY').on('click',function(){
		let saveType = $('#btnSave').data('saveType');
		let cmykString = '';
		if($('#checkC').prop('checked')){
			cmykString += 'C/';
		} else {
			cmykString += '/';
		}
		if($('#checkM').prop('checked')){
			cmykString += 'M/';
		} else {
			cmykString += '/';
		}
		if($('#checkY').prop('checked')){
			cmykString += 'Y/';
		} else {
			cmykString += '/';
		}
		if($('#checkK').prop('checked')){
			cmykString += 'K/';
		} else {
			cmykString += '/';
		}

		let formData3 = new FormData();
		let versionFileString = [];
		if($('#versionFileNm').val() != '' && $('#versionFileNm').val() != undefined){
			if(versionFileStatus){
				let fileInput = document.getElementById('versionFile'); 
				let files = fileInput.files; //업로드한 파일들의 정보를 넣는다.
				let uuid = uuid_v4();	
				formData3.append('file',files[0]);
				formData3.append('uuid',uuid);
				formData3.append('ext',files[0].name.split('.').at(-1));

				let fileArr = files[0].name.split('.');
				let fileFullNm = _.slice(fileArr, 0, -1).join('.');
				
				let obj = {};
				obj.uuid = uuid;
				obj.fileNm = fileFullNm;
				obj.ext = files[0].name.split('.').at(-1);
				
				versionFileString.push(obj);
			} else {
	
				let fileObject = new Object();			
				fileObject.uuid = fileUuid;
				fileObject.ext = fileExt;
				fileObject.fileNm = fileNm;
				let fileBlob = getFileBlob(fileObject);
				let blob = new Blob([base64ToArrayBuffer(fileBlob)], { type: data.ext });
	            let file = new File([blob], data.fileNm, { lastModified: new Date().getTime(), type: data.ext });
				formData3.append('file',file);
				formData3.append('uuid',fileUuid);
				formData3.append('ext',fileExt); 
				
				let obj = {};
				obj.uuid = fileUuid;
				obj.fileNm = fileNm;
				obj.ext = fileExt;
				
				versionFileString.push(obj);
			}
		}
		//버전번호 or 파일이 바뀌었는지 체크 값
		let versionCheck = (beforeVersion != $('#versionNum').val() || versionFileStatus);

		
		// 등록할 경우에
		if(saveType == 'insert') {
			//사이즈 코팅방법 성형방식이 일치하는 수지판 목형 찾기 && 일치하는 번호로 세팅
			$.ajax({
				url: '<c:url value="/bm/woodenInfoAdmLstWithSizeCoatingMolding"/>',
	            type: 'POST',
	            async: false,
	            data: {
	            	'wdSize'				:	$('#itemSize').val(), //사이즈
	            	'coating'				:	$('#coatingMethod').val(), //코팅
	                'moldingContents'		:	$('#moldingMethod').val(), //성형방식
	                'moldingContentsReal'	:	$('#moldingContents').val(), //성형내용
	                'wdUnit'				:	$('#etc1').val(),//호기
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if (res.result == "ok") { //응답결과
						data = res.data;

						//목형리스트					
						let list = _.filter(data, v => v.commonDesc == 'a');
						let idxList = _.maxBy(list, (v => v.idx));
						if(idxList != null && idxList != undefined && idxList != ''){
							let lastIdx = idxList.idx;
							let findList = _.filter(list, v => v.idx == lastIdx);
							
							$('#woodenCareCd').val(findList[0].wdCd);
							$('#woodenCareIdx').val(findList[0].idx);
						}
						//수지판 리스트
						list = _.filter(data, v => v.commonDesc == 'b');
						idxList = _.maxBy(list, (v => v.idx));
						if(idxList != null && idxList != undefined && idxList != ''){
							lastIdx = _.maxBy(list, (v => v.idx)).idx;
							findList = _.filter(list, v => v.idx == lastIdx);
							
							$('#resinBoard').val(findList[0].wdCd);
							$('#resinBoardIdx').val(findList[0].idx);
						}
					} else if(res.result == 'fail') {
						toastr.warning(res.message);
					} else {
						toastr.error(res.message);
					}
					$('#my-spinner').hide();
				}
			});

			
			
			$.ajax({
				url: '<c:url value="/bm/itemInfoInsert"/>',
	            type: 'POST',
	            //async: false,
	            data: {
	                'useYnCd'			:	$('#useYnCd').val(),
	                'customerIdx'		:	$('#customerIdx').val(),
	                'itemCd'			:	$('#itemCd').val(),
	                'itemNm'			:	$('#itemNm').val(),
	                'itemSize'			:	$('#itemSize').val(),
	                'knifeTipSize'		:	$('#knifeTipSize').val(),
	                'woodenCareCd'		:	$('#woodenCareIdx').val(),
	                'holeWoodenCd'		:	$('#holeWoodenCd').val(),
	                'versionNum'		:	$('#versionNum').val(),
	                'stock'				:	$('#stock').val(),
	                'itemColor'			:	$('#itemColor').val(),
	                'frequency'			:	$('#frequency').val().replaceAll(',',''),
					'customerItemCd'	:	$('#customerItemCd').val(),
	                'specialNotice'		:	$('#specialNotice').val(),
	                'relayNotice'		:	$('#relayNotice').val(),
	                'coatingMethod'		:	$('#coatingMethod').val(),
	                'moldingMethod'		:	$('#moldingMethod').val(),
	                'moldingContents'	:	$('#moldingContents').val(),
	                'pressMethod'		:	$('#pressMethod').val(),
	                'bundleMethod'		:	$('#bundleMethod').val(),
	                'bundleUnit'		:	$('#bundleUnit').val(),
	                'packMethod' 		:	$('#packMethod').val(),
	                'packUnit' 			:	$('#packUnit').val(),
	                'workPrinter'		:	'',//$('#workPrinter').val(),
	                'detailDate' 		:	$('#detailDate').val(),
	                'masterPaper'		:	'',//$('#masterPaper').val(),
	                'roundPlateCnt'		:	'',//$('#roundPlateCnt').val(),
	                'careCd' 			:	'',//$('#careCd').val(),
	                'plane'				:	'',//$('#plane').val(),
	                'inspectMethod' 	:	$('#inspectMethod').val(),
	                'printingYnCheck'  	:	$('#printingYnCheck').val(),
	                'plateSize' 		:	'',//$('#plateSize').val(),
	                'etc1'  			: 	$('#etc1').val(),
	                'etc2'  			: 	$('#etc2').val(),
	                'etc3'  			: 	$('#etc3').val(),
	                'etc4'  			: 	$('#etc4').val(),
	                'etc5'  			: 	$('#etc5').val(),
	                'etc6'  			: 	$('#etc6').val(),
	                'etc7'  			: 	$('#etc7').val(),
	                'etc8'  			: 	$('#etc8').val(),
	                'etc9'  			: 	$('#etc9').val(),
	                'etc10'  			: 	$('#confirmYnCheck').val(),
	                'itemGubun'			:	$('#itemGubun').val(),
	                'cmyk'				: 	function(){ return cmykString;},
	                'versionFileString' : 	JSON.stringify(versionFileString),
	                'versionCheck' 		:	function(){ return versionCheck;},
	                'resinBoard'		:	$('#resinBoardIdx').val(),
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if (res.result == "ok") { //응답결과
						let data = res.data;
						toastr.success('신규 저장되었습니다.');

						//$('#btnSearch').trigger('click'); // 조회버튼 click
						itemInfoTable.ajax.reload(function(){
							setTimeout(function() {
							itemInfoTable.row('#'+res.idx).select();
							$(itemInfoTable.row('#'+res.idx).node()).trigger('click'); // 선택했던 항목 선택처리
							},100);
						},false);
						WM_action_OFF('new');

						$('#userPw').val('');
						$('#userPwCheck').val('');

						//버전파일 업로드
						if( versionFileStatus && versionFileString != undefined &&versionFileString != null && versionFileString != ''){
							fileUpload(formData3);
						}
						
						$('.inputGroup').attr('disabled', true); // 입력항목
						
						$('#btnNew').attr('disabled', false); // 신규 버튼
						$('#btnSave').attr('disabled', true); // 저장 버튼
						$('#btnEdit').attr('disabled', false); // 수정 버튼
						$('#btnDel').attr('disabled', false); // 삭제 버튼
						$('#btnCancel').attr('disabled', true); // 취소 버튼
						$('#btnStockBtn').attr('disabled',true);//재고폐기등록버튼
						itemVersionHistoryTable.ajax.reload(function(){});

						formData4 = new FormData();
						versionFileStatus = false;
					} else if(res.result == 'fail') {
						toastr.warning(res.message);
					} else {
						toastr.error(res.message);
					}
					$('#my-spinner').hide();
				}
			});
		} else { // 수정할 경우에
			let idx = itemInfoTable.row('.selected').data().idx;
			$.ajax({
				url: '<c:url value="/bm/itemInfoUpdate"/>',
	            type: 'POST',
	            //async: false,
	            data: {    
		            'idx'				:	function(){return idx;},
		            'useYnCd'			:	$('#useYnCd').val(),
	                'customerIdx'		:	$('#customerIdx').val(),
	                'itemCd'			:	$('#itemCd').val(),
	                'itemNm'			:	$('#itemNm').val(),
	                'itemSize'			:	$('#itemSize').val(),
	                'knifeTipSize'		:	$('#knifeTipSize').val(),
	                'woodenCareCd'		:	$('#woodenCareIdx').val(),
	                'holeWoodenCd'		:	$('#holeWoodenCd').val(),
	                'versionNum'		:	$('#versionNum').val(),
	                'stock'				:	$('#stock').val(),
	                'itemColor'			:	$('#itemColor').val(),
	                'frequency'			:	$('#frequency').val().replaceAll(',',''),
					'customerItemCd'	:	$('#customerItemCd').val(),
	                'specialNotice'		:	$('#specialNotice').val(),
	                'relayNotice'		:	$('#relayNotice').val(),
	                'coatingMethod'		:	$('#coatingMethod').val(),
	                'moldingMethod'		:	$('#moldingMethod').val(),
	                'moldingContents'	:	$('#moldingContents').val(),
	                'pressMethod'		:	$('#pressMethod').val(),
	                'bundleMethod'		:	$('#bundleMethod').val(),
	                'bundleUnit'		:	$('#bundleUnit').val(),
	                'packMethod' 		:	$('#packMethod').val(),
	                'packUnit' 			:	$('#packUnit').val(),
	                'workPrinter'		:	'',//$('#workPrinter').val(),
	                'detailDate' 		:	$('#detailDate').val(),
	                'masterPaper'		:	'',//$('#masterPaper').val(),
	                'roundPlateCnt'		:	'',//$('#roundPlateCnt').val(),
	                'careCd' 			:	'',//$('#careCd').val(),
	                'plane'				:	'',//$('#plane').val(),
	                'inspectMethod' 	:	$('#inspectMethod').val(),
	                'printingYnCheck'  	:	$('#printingYnCheck').val(),
	                'plateSize' 		:	'',//$('#plateSize').val(),
	                'etc1'  			: 	$('#etc1').val(),
	                'etc2'  			: 	$('#etc2').val(),
	                'etc3'  			: 	$('#etc3').val(),
	                'etc4'  			: 	$('#etc4').val(),
	                'etc5'  			: 	$('#etc5').val(),
	                'etc6'  			: 	$('#etc6').val(),
	                'etc7'  			: 	$('#etc7').val(),
	                'etc8'  			: 	$('#etc8').val(),
	                'etc9'  			: 	$('#etc9').val(),
	                'etc10'  			: 	$('#confirmYnCheck').val(),
	                'itemGubun'			:	$('#itemGubun').val(),
	                'cmyk'				: 	function(){ return cmykString;},
	                'versionFileString' : 	JSON.stringify(versionFileString),
	                'versionCheck' 		:	function(){ return versionCheck;},
	                'resinBoard'		:	$('#resinBoardIdx').val(),
	            },
	            beforeSend: function() {
	            	$('#my-spinner').show();
	            },
				success : function(res) {
					if (res.result == "ok") { //응답결과
						toastr.success('수정 저장되었습니다.');

						$('#btnSearch').trigger('click'); // 조회버튼 click

						WM_action_OFF('edit');

						$('.inputGroup').attr('disabled', true); // 입력항목
						$('#btnUserIdCheck').attr('disabled', true); // 중복확인 버튼

						//버전파일 업로드
						// 수정전 버전 번호 와 수정후 번호가 다를 경우 -> 파일 업로드
						if( beforeVersion != $('#versionNum').val() || versionFileStatus ){
							fileUpload(formData3);
						}
						
						$('#btnNew').attr('disabled', false); // 신규 버튼
						$('#btnSave').attr('disabled', true); // 저장 버튼
						$('#btnEdit').attr('disabled', false); // 수정 버튼
						$('#btnCopy').attr('disabled', false); // 복사 버튼
						$('#btnCancel').attr('disabled', true); // 취소 버튼

						$('#btnStockBtn').attr('disabled',true);//재고폐기등록버튼
						itemVersionHistoryTable.ajax.reload(function(){});

						formData4 = new FormData();
						versionFileStatus = false;
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

	//버전이력 탭 - 행 삭제
	$(document).on('click', '.versionDel', function(){
		let idx = $(this).data('idx');
		//등록된 버전일경우
		if(!isEmptyCheck(idx)){
			delStatus = 'version';
			$('#deleteModal').modal('show');
		} else {
			itemVersionHistoryTable.row('.selected').remove().draw();
		}
	});
	
	//버전이력 탭 - 파일 삭제
	$(document).on('click', '.versionFileDel', function(){
		let idx = $(this).data('idx');
		//등록된 버전일경우
		if(!isEmptyCheck(idx)){
			delStatus = 'versionFileDel';
			$('#deleteModal').modal('show');
		}
	});
	
	function itemInfoTableClick(itemIdx) {
		$('#my-spinner').show();
		itemInfoTable.rows('.selected').deselect();
		itemInfoTable.ajax.reload(function(){
			let node = itemInfoTable.row('#'+itemIdx).node();
			$(node).trigger('click');
			itemInfoTable.row('#'+itemIdx).select();
				
			//let offset = $('#itemInfoTable').find($('#itemInfoTable').find('tr#' + itemIdx)).offset();
        	//$('#itemInfoTable_wrapper').find('.dataTables_scrollBody').scrollTop(offset.top - 200);
        	$('#my-spinner').hide();
		},false);
	}
	
	function itemInfoTableCopy(itemIdx) {
		$('#my-spinner').show();
		itemInfoTable.rows('.selected').deselect();
		itemInfoTable.ajax.reload(function(){
			let node = itemInfoTable.row('#'+itemIdx).node();
			$(node).trigger('click');
			itemInfoTable.row('#'+itemIdx).select();

			//let offset = $('#itemInfoTable').find($('#itemInfoTable').find('tr#' + itemIdx)).offset();
			//$('#itemInfoTable_wrapper').find('.dataTables_scrollBody').scrollTop(offset.top - 200); 
			$('#my-spinner').hide();
		},false);
	}	
	
	//객체(json)에서 키(field)로 값 찾기
	function getPrcssIdx(input, field) {
	    let output = [];
	    for (let i=0; i < input.length ; ++i)
	        output.push(input[i][field]);
	    return output;
	}

	$('#btnDisposalPrint').on('click',function(){

		//견본첨부파일 이미지변환
		let fileInput = document.getElementById('disposalFile'); 
		if(fileInput.files.length>0){
			let files = fileInput.files; //업로드한 파일들의 정보를 넣는다.
	
			for(let i = 0; i < document.querySelector('#disposalFile').files.length; i++){
				let bases64 = getImgBase64(files[i]);
				$('#disposalReportTable [name=disposalImage]').attr('src','data:image/jpeg;base64,'+bases64);
				$('#disposalReportTable [name=disposalImage]').css('display','');
			}
		} else {
			$('#disposalReportTable [name=disposalImage]').attr('src','');
		}
		
		$('#disposalReportTable td[name=printDate]').text(moment().format('YYYY/MM/DD'));

		let data = itemInfoTable.row('.selected').data();
		$('#disposalReportTable [name=customerNm]').text(data.customerNm);
		$('#disposalReportTable [name=itemNm]').text(data.itemNm);
		$('#disposalReportTable [name=paperType]').text(data.paperType);
		$('#disposalReportTable [name=itemColor]').text(data.itemColor);
		$('#disposalReportTable [name=itemSize]').text(data.itemSize);
		$('#disposalReportTable [name=coatingMethod]').text(data.coatingMethod);
		$('#disposalReportTable [name=moldingMethod]').text(data.moldingMethod);
		$('#disposalReportTable [name=customerItemCd]').text(data.customerItemCd);
		$('#disposalReportTable [name=itemVersion]').text($('#stockModalVersionNum option:selected').text());
		$('#disposalReportTable [name=disposalQty]').text(addCommas(parseInt(removeCommas($('#disposalQty').val()))));

		$('#disposalReportTable [name=disposalReason]').text($('#disposalReason').val());
		if( !isEmptyCheck(data.lastProdDate) ) {
			$('#disposalReportTable [name=lastProdDate]').text(moment(data.lastProdDate).format('YYYY/MM/DD'));
		} else {
			$('#disposalReportTable [name=lastProdDate]').text('');

		}
		//$('#disposalReportTable [name=disposalDate]').text(moment($('#disposalDate').val()).format('YYYY년 MM월 DD일'));
		$('#disposalReportTable [name=mangerNm]').text($('#disposalManagerNm').val());
		$('#disposalReportTable [name=produceMangerNm]').text($('#produceManagerNm').val());
		
		$('#disposalReportTable').print({
			globalStyles: true,
			mediaPrint: true
		});
	});
	

</script>

<!-- 출력물 -->
<script>
	// 초기 셋팅
	$(document).ready(function() {
		//폐기지시서
		$('#trDisposalAppendTarget').after(makeDisposalReport());
		cssChange('disposalReportTable');
		$('#disposalReportTable').removeClass('d-none');
		$('#my-spinner').hide();
		
	});	

	$('#itemDisposal tbody').on('click','tr',function(){
		let data = itemDisposal.row(this).data();
		$('#disposalReportTable [name=customerNm]').text(data.customerNm);
		$('#disposalReportTable [name=itemNm]').text(data.itemNm);
		$('#disposalReportTable [name=paperType]').text(data.paperType);
		$('#disposalReportTable [name=itemColor]').text(data.itemColor);
		$('#disposalReportTable [name=itemSize]').text(data.itemSize);
		$('#disposalReportTable [name=coatingMethod]').text(data.coatingMethod);
		$('#disposalReportTable [name=moldingMethod]').text(data.moldingMethod);
		$('#disposalReportTable [name=customerItemCd]').text(data.customerItemCd);
		$('#disposalReportTable [name=itemVersion]').text(data.itemVersion);
		$('#disposalReportTable [name=disposalQty]').text(addCommas(parseInt(data.disposalQty)));

		$('#disposalReportTable [name=disposalReason]').text(data.disposalReason);
		//$('#disposalReportTable [name=disposalDate]').text(moment(data.disposalDate).format('YYYY년 MM월 DD일'));
		$('#disposalReportTable [name=mangerNm]').text(data.mangerNm);
		$('#disposalReportTable [name=produceMangerNm]').text(data.produceMangerNm);
	});
	
</script>
<!-- 출력물 css-->
<script>
	function cssChange(tableId){
		$('#'+tableId).find('td').css('font-weight', '900');
		$('#'+tableId).find('td').css('border', '1px solid black');
		$('#'+tableId).find('td').css('padding', '0.1rem');
		$('#'+tableId).find('td').css('color', '#000000');

		$('#'+tableId).find('.fw900').css('font-weight', '900');
		$('#'+tableId).find('.fw-bold').css('font-weight', 'bold');
		$('#'+tableId).find('.bd2px').css('border', '2px solid black');


		$('#'+tableId).find('.text-bottom-black-line').css('text-decoration', 'underline');
		$('#'+tableId).find('.text-bottom-black-line').css('text-decoration-color', '#9E9E9E');
		$('#'+tableId).find('.text-bottom-black-line').css('text-decoration-thickness', '1px');
		
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
		$('#'+tableId).find('.fc-gray').css('color', '#d3d3d3');
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
		$('#'+tableId).find('.h-270').css('height', '270px');
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
		$('#'+tableId).find('.maxh-270').css('max-height', '270px');
		

		// 인쇄할 때 css 적용하려면 important 붙여줘야함.
		for(var i=0;i<$('#'+tableId).find('td').length;i++) {
			let tdStyle = $('#'+tableId).find('td').eq(i).attr('style') == undefined?'':$('#'+tableId).find('td').eq(i).attr('style');
			$('#'+tableId).find('td').eq(i).attr('style',tdStyle.replaceAll(';',' !important;'));
		}
	}
</script>

<!-- 폐기지시서 -->
<script>
	function makeDisposalReport(){
		let html = '';
		
		html += '<tr style="page-break-before: always!important;">';
		html += '		<td class="bd-n h-25" colspan="30">';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="28" class="fs-25 fw900 bd-n align-middle text-center bt-n bl-n br-n">재고 폐기 지시서</td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';
		
		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="8" class="text-center max-h55 h-55 bd-n align-middle bt-n bl-n br-n" style="border-width: 0px 0px 2px !important; border-style: solid !important; border-color: rgb(255, 255, 255) rgb(255, 255, 255) black !important; border-image: initial !important; padding: 0.1rem !important; color: rgb(0, 0, 0) !important; height: 55px !important;"><img src="/resources/assets/images/header_logo.png" style="width:100%;height:100%;"></td>';
		html += '	<td colspan="13" class="bd-n"></td>';
		html += '	<td colspan="3" class="fs-15 bt-n bl-n br-n text-start align-bottom">DATE : </td>';
		html += '	<td colspan="4" class="fs-15 bt-n bl-n br-n text-start align-bottom" name="printDate"></td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';
		
		html += '<tr>';
		html += '	<td class="bd-n h-20" colspan="30">';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="5" class="fs-15 bd-n text-start align-middle text-bottom-black-line">1. 거 래 처 : </td>';
		html += '	<td colspan="23" class="fs-15 bd-n text-start align-middle text-bottom-black-line" name="customerNm"></td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td class="bd-n h-20" colspan="30">';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="5" class="fs-15 bd-n text-start align-middle text-bottom-black-line">2. 제 품 명 : </td>';
		html += '	<td colspan="23" class="fs-15 bd-n text-start align-middle text-bottom-black-line" name="itemNm"></td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td class="bd-n h-20" colspan="30">';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="5" class="fs-15 bd-n text-start align-middle text-bottom-black-line">3. 구성정보 </td>';
		html += '	<td colspan="23" class="fs-15 bd-n text-start align-middle"></td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="8" class="fs-15 text-center align-middle bb-n">지질</td>';
		html += '	<td colspan="7" class="fs-15 text-center align-middle bb-n">칼라</td>';
		html += '	<td colspan="4" class="fs-15 text-center align-middle bb-n">규격</td>';
		html += '	<td colspan="4" class="fs-15 text-center align-middle bb-n">코팅</td>';
		html += '	<td colspan="5" class="fs-15 text-center align-middle bb-n">성형방법</td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="8" class="fs-15 h-20 text-center align-middle" name="paperType"></td>';
		html += '	<td colspan="7" class="fs-15 text-center align-middle" name="itemColor"></td>';
		html += '	<td colspan="4" class="fs-15 text-center align-middle" name="itemSize"></td>';
		html += '	<td colspan="4" class="fs-15 text-center align-middle" name="coatingMethod"></td>';
		html += '	<td colspan="5" class="fs-15 text-center align-middle" name="moldingMethod"></td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td class="bd-n h-20" colspan="30">';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="5" class="fs-15 bd-n text-start align-middle text-bottom-black-line">4. 세부내용 </td>';
		html += '	<td colspan="23" class="fs-15 bd-n text-start align-middle"></td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="15" class="fs-15 text-center align-middle bb-n">구분</td>';
		html += '	<td colspan="3" class="fs-15 text-center align-middle bb-n">점검여부</td>';
		html += '	<td colspan="5" class="fs-15 text-center align-middle bb-n">점검자</td>';
		html += '	<td colspan="5" class="fs-15 text-center align-middle bb-n">확인자</td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="5" class="fs-15 text-center align-middle bb-n">자재번호</td>';
		html += '	<td colspan="10" class="fs-15 text-center align-middle bb-n" name="customerItemCd"></td>';
		html += '	<td colspan="3" class="fs-15 text-center align-middle bb-n">□</td>';
		html += '	<td colspan="5" class="fc-gray fs-15 text-center align-middle bb-n">서 명</td>';
		html += '	<td colspan="5" class="fc-gray fs-15 text-center align-middle bb-n">서 명</td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="5" class="fs-15 text-center align-middle bb-n">버전번호</td>';
		html += '	<td colspan="10" class="fs-15 text-center align-middle bb-n" name="itemVersion"></td>';
		html += '	<td colspan="3" class="fs-15 text-center align-middle bb-n">□</td>';
		html += '	<td colspan="5" class="fc-gray fs-15 text-center align-middle bb-n">서 명</td>';
		html += '	<td colspan="5" class="fc-gray fs-15 text-center align-middle bb-n">서 명</td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="5" class="fs-15 text-center align-middle bb-n">생성일자</td>';
		html += '	<td colspan="10" class="fs-15 text-center align-middle bb-n" name="lastProdDate"></td>';
		html += '	<td colspan="3" class="fs-15 text-center align-middle bb-n">□</td>';
		html += '	<td colspan="5" class="fc-gray fs-15 text-center align-middle bb-n">서 명</td>';
		html += '	<td colspan="5" class="fc-gray fs-15 text-center align-middle bb-n">서 명</td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="5" class="fs-15 text-center align-middle ">재고량</td>';
		html += '	<td colspan="10" class="fs-15 text-center align-middle" name="disposalQty"></td>';
		html += '	<td colspan="3" class="fs-15 text-center align-middle ">□</td>';
		html += '	<td colspan="5" class="fc-gray fs-15 text-center align-middle ">서 명</td>';
		html += '	<td colspan="5" class="fc-gray fs-15 text-center align-middle ">서 명</td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';
		
		html += '<tr>';
		html += '	<td class="bd-n h-20" colspan="30">';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="5" class="fs-15 bd-n text-start align-middle text-bottom-black-line">5. 폐기사유 </td>';
		html += '	<td colspan="23" class="fs-15 bd-n text-start align-middle"></td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="28" class="fs-15 bd-n text-start align-middle"> ';
		html += '	<textarea rows="2" name="disposalReason" class="form-control text-start p-0"'; 
		html += '		style="background-color: #f2f2f2;resize: none; overflow: hidden;font-size:15px!important;';
		html += '		border: none !important; width:100%;"></textarea>'; 
		html += '	</td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td class="bd-n h-20" colspan="30">';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="5" class="fs-15 bd-n text-start align-middle text-bottom-black-line">6. 견본첨부</td>';
		html += '	<td colspan="23" class="fs-15 bd-n text-start align-middle"></td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td class="bd-n h-270 maxh-270" colspan="30"><img name="disposalImage" onerror="this.style.display=\'none\'" style="object-fit: contain; height: 100%; width: 100%;" src=""> </td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="5" class="fs-15 bd-n text-start align-middle text-bottom-black-line">7. 폐기일자 :</td>';
		html += '	<td colspan="23" class="fs-15 bd-n text-start align-middle text-bottom-black-line" name="disposalDate">';
		html += '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;년&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;월&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;일</td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';


		html += '<tr>';
		html += '	<td class="bd-n h-20" colspan="30">';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="2" class="fs-15 text-center">담당</td>';
		html += '	<td colspan="4" class="fs-15 text-center">' + sessionUserNm + '</td>';
		html += '	<td colspan="5" class="fs-15 text-center">제조관리 책임자</td>';
		html += '	<td colspan="5" class="fs-15 text-center" name="mangerNm"></td>';
		html += '	<td colspan="6" class="fs-15 text-center">QA</td>';
		html += '	<td colspan="6" class="fs-15 text-center" name="produceMangerNm"></td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';

		html += '<tr>';
		html += '	<td class="bd-n h-10" colspan="30">';
		html += '</tr>';

		html += '<tr>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '	<td colspan="28" class="fs-15 bd-n text-start">문서번호 : 재고폐기지시서 230701-02 </td>';
		html += '	<td colspan="1" class="bd-n"></td>';
		html += '</tr>';  
		
		return html;
	}


	//공정 불러오기 시작---------------------
	
	//공정정보모달 조회
	$('#prcssRoutingTable thead tr').clone(true).addClass('filters').appendTo('#prcssRoutingTable thead'); // filter 생성
	let prcssRoutingTable = $('#prcssRoutingTable').DataTable({
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
            toggleable: true,
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
			let theadHeight = parseFloat($('#prcssRoutingTable_wrapper').find('.dataTables_scrollHead').css('height'));
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
				let cell = $('#prcssRoutingTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#prcssRoutingTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	prcssRoutingTable.on('column-reorder', function( e, settings, details ) {
		let api = prcssRoutingTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#prcssRoutingTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	//공정 추가
   	$('#btnPrcssNew').on('click',function(){
   		prcssRoutingTable.rows('.selected').deselect();
		$('#prcssRoutingModal').modal('show');   	
		setTimeout(function() {
			prcssRoutingTable.ajax.reload(function() {});
		}, 200);
   	});

  	//공정 복사
	$('#prcssRoutingTable tbody').on('dblclick','tr',function(){
		console.log('dd');
		
		//초기화 
		processInfoTable.clear().draw();
		
		//routingNo
		let routingNo = prcssRoutingTable.rows(this).data().toArray()[0].routingNo;

		$.ajax({
			url : '<c:url value="/bm/itemPrcssRoutingSel"/>',
			type : 'GET',
			async : false,
			data : {
				'routingNo' : function(){return routingNo}
			},
			success : function(res){

				let data = res.data;
				
				console.log('data:'+data);
				console.log('data.length:'+data.length);
				
				for(var i=0; i<data.length; i++){
					let modalData = data[i];
					
					console.log('modalData.prcssInfoIdx:'+modalData.prcssInfoIdx)
					let rowLvl = data[i].prcssOrder;
					$('#processInfoTable').DataTable().row.add({
						'rowGubun'				: 'add',
						'prcssOrder'			: rowLvl,
						'prcssCd'				: modalData.prcssCd,
						'prcssNm'				: modalData.prcssNm,
						'equipIdx'				: modalData.equipIdx,
						'equipNm'				: modalData.equipNm,
						'outsrcGubun'			: null,
						'workMethod'			: null,
						'workMethodDtl'			: null,
						'customerCd'			: null,
						'qtyUnitNm'				: modalData.qtyUnitNm,
						'prcssDesc'				: null,
						'note'					: null,
						'prcssIdx'				: modalData.prcssInfoIdx,
					}).draw(false);

					$('#processInfoTable tbody tr').eq(rowLvl).find('td').eq(1).html('<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+modalData.prcssCd+'</div>');
					$('#processInfoTable tbody tr').eq(rowLvl).find('td').eq(8).html('<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+modalData.qtyUnitNm+'</div>');
					$('#processInfoTable tbody tr').eq(rowLvl).find('td').eq(9).html('<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;"></div>');

					//공정명 html
					let html1='';
					html1 += '<div style="display: flex; flex-wrap: 1 1 auto;">';
					html1 += '<input type="text" class="form-control inputGroup" id="prcssNm" style="max-width: 100%;" disabled="disabled" value="'+modalData.prcssNm+'">';
					html1 += '<input type="hidden" id="prcssIdx">';
					html1 += '</div>';			
					$('#processInfoTable tbody tr').eq(rowLvl).find('td').eq(2).html(html1); 
				}

				$('#btnProcessEdit').attr('disabled',true);
				$('#btnProcessSave').attr('disabled',false);
				$('#prcssRoutingModal').modal('hide');

				$('#btnProcessSave').trigger('click');
			}
		})
	});

	//공정 복사
	$('#btnprcssRoutingPaste').on('click',function(){

		//초기화 
		processInfoTable.clear().draw();
		
		//routingNo
		let routingNo = prcssRoutingTable.rows('.selected').data().toArray()[0].routingNo;

		$.ajax({
			url : '<c:url value="/bm/itemPrcssRoutingSel"/>',
			type : 'GET',
			async : false,
			data : {
				'routingNo' : function(){return routingNo}
			},
			success : function(res){

				let data = res.data;
				
				console.log('data:'+data);
				console.log('data.length:'+data.length);
				
				for(var i=0; i<data.length; i++){
					let modalData = data[i];
					
					console.log('modalData.prcssInfoIdx:'+modalData.prcssInfoIdx)
					let rowLvl = data[i].prcssOrder;
					$('#processInfoTable').DataTable().row.add({
						'rowGubun'				: 'add',
						'prcssOrder'			: rowLvl,
						'prcssCd'				: modalData.prcssCd,
						'prcssNm'				: modalData.prcssNm,
						'equipIdx'				: modalData.equipIdx,
						'equipNm'				: modalData.equipNm,
						'outsrcGubun'			: null,
						'workMethod'			: null,
						'workMethodDtl'			: null,
						'customerCd'			: null,
						'qtyUnitNm'				: modalData.qtyUnitNm,
						'prcssDesc'				: null,
						'note'					: null,
						'prcssIdx'				: modalData.prcssInfoIdx,
					}).draw(false);

					$('#processInfoTable tbody tr').eq(rowLvl).find('td').eq(1).html('<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+modalData.prcssCd+'</div>');
					$('#processInfoTable tbody tr').eq(rowLvl).find('td').eq(8).html('<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;">'+modalData.qtyUnitNm+'</div>');
					$('#processInfoTable tbody tr').eq(rowLvl).find('td').eq(9).html('<div style="white-space: nowrap; text-overflow: ellipsis; overflow: hidden;"></div>');

					//공정명 html
					let html1='';
					html1 += '<div style="display: flex; flex-wrap: 1 1 auto;">';
					html1 += '<input type="text" class="form-control inputGroup" id="prcssNm" style="max-width: 100%;" disabled="disabled" value="'+modalData.prcssNm+'">';
					html1 += '<input type="hidden" id="prcssIdx">';
					html1 += '</div>';			
					$('#processInfoTable tbody tr').eq(rowLvl).find('td').eq(2).html(html1); 
				}

				$('#btnProcessEdit').attr('disabled',true);
				$('#btnProcessSave').attr('disabled',false);
				$('#prcssRoutingModal').modal('hide');

				$('#btnProcessSave').trigger('click');
			}
		})

	});

	
	
	//공정 불러오기 종료---------------------
	
	
	// 제품수행이력 목록조회
	$('#itemPerformanceHistoryTable thead tr').clone(true).addClass('filters').appendTo('#itemPerformanceHistoryTable thead'); // filter 생성
	let itemPerformanceHistoryTable = $('#itemPerformanceHistoryTable').DataTable({
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
		pageLength: -1,
		colReorder: true,
		select: {
            style: 'single',
            toggleable: false,
            items: 'row',
            info: false
        },
        ajax : {
			url : '<c:url value="/bm/itemPerformanceHistoryLst"/>',
			type : 'GET',
			data : {
				itemIdx   : function(){ return itemIdx;},
			},
		},
        rowId: 'idx',
		columns : [
			{ //수주일
				data: 'ordDate', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if (data != null) {
						return moment(data,'YYYY-MM-DD').format('YYYY-MM-DD');
					} else {
						return "";
					}
				}
			},
			{ data: 'bizOrdNo', className : 'text-center align-middle'}, //수주번호
			{ //수주량
				data: 'ordQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if (data != null) {
						return addCommas(parseFloat(data));
					} else {
						return "";
					}
				}
			},
			{ data: 'itemVersion', className : 'text-center align-middle'}, //버전번호
			{ //출고일
				data: 'outDate', className : 'text-center align-middle',
				render : function(data, type, row, meta) {
					if (data != null) {
						return moment(data,'YYYY-MM-DD').format('YYYY-MM-DD');
					} else {
						return "";
					}
				}
			},
			{ //출고량
				data: 'outQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if (data != null) {
						return addCommas(parseFloat(data));
					} else {
						return "";
					}
				}
			},
			{ //생산량
				data: 'passQty', className : 'text-end align-middle',
				render : function(data, type, row, meta) {
					if (data != null) {
						return addCommas(parseFloat(data));
					} else {
						return "";
					}
				}
			},
			{ data: 'ordIssue', className : 'text-center align-middle'}, //건별전달사항
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
			/* { extend: 'excel',	text: 'Excel',	charset: 'UTF-8', bom: true },
			{ extend: 'pdf',	text: 'PDF',	},
			{ extend: 'print',	text: 'Print',		charset: 'UTF-8', bom: true },
			{ extend: 'colvis',	text: 'Select Col',	},  */
		],
		order : [],
		drawCallback: function() {
			let api = this.api();
			let data = api.data();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#itemPerformanceHistoryTable_wrapper').find('.dataTables_scrollHead').css('height'));
			let baseTableHeight = parseFloat($('#rightcolT').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(((baseTableHeight)) - theadHeight - 99)+'px');
			$('#'+table_id+'_wrapper').find('.dataTables_scrollHeadInner').css('width','100%');
			
			$('#'+table_id+'_filter').addClass('d-none');
			// 통합검색
			$('#searchAllIvh').off('keyup',function() {});
			$('#searchAllIvh').on('keyup',function() {
				$('#'+table_id+'_filter').find('input').val($(this).val());
				$('#'+table_id+'_filter').find('input').trigger('keyup');
			});
			
			// 집계표 생성
			let dataArray = api.data().toArray();

			if (dataArray.length != 0) {
				let lastIdx = _.last(dataArray).idx;
				let ordQtyAvg = _.sumBy(dataArray, (v => parseInt(v.ordQty))) / dataArray.length;
				let lastHtml = '';
					lastHtml += '<tr class="bg-success bg-gradient bg-opacity-10">';
					lastHtml += '	<td class="text-center">평균발주량</td>';
					lastHtml += '	<td colspan="1"></td>';
					lastHtml += '	<td class="text-end align-middle">'+addCommas(parseInt(ordQtyAvg))+'</td>';
					lastHtml += '	<td colspan="5"></td>';
					lastHtml += '</tr>';
				let lastNode = api.row('#'+lastIdx).node();
				$(lastNode).after(lastHtml);
			}
		},
		initComplete: function () {
			let api = this.api();
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			// For each column
			api.columns().eq(0).each(function (colIdx) {
				// Set the header cell to contain the input element
				let cell = $('#itemPerformanceHistoryTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#itemPerformanceHistoryTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
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
	itemPerformanceHistoryTable.on('column-reorder', function( e, settings, details ) {
		let api = itemPerformanceHistoryTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#itemPerformanceHistoryTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});
	
</script>

</body>
</html>