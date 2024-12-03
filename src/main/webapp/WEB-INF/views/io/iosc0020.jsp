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
																		  grid-template-columns: 1.7fr 4px 2fr;">
	<div id="leftcol">
		<div class="container-fluid h-100" style="padding: 5px;">
			<div class="row" id="leftHeader" style="padding-bottom: 5px;">
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
					
					<input type="text" class="form-control w-auto h-100 me-1" id="searchAll" placeholder="통합검색" >
					
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end">
					<div class="btn-group" role="group" aria-label="Small button group">
						<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnSearch"><i class="fa-regular fa-clipboard"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnOpen">
							<i class="fa-solid fa-caret-left"></i>
						</button>
					</div>
				</div>
			</div>
			<div class="row">
				<table class="table table-bordered p-0 m-0" id="outItemTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle">수주상세번호</th>
							<th class="text-center align-middle">출고처</th>
							<th class="text-center align-middle">출고번호</th>
							<th class="text-center align-middle">명세서번호</th>
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
					<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">납품일자</label>
					<input type="date" max="9999-12-31" class="form-control w-auto h-100 me-1" id="deliveryDate">
				</div>
				<div class="me-lg-auto"></div>
				<div class="d-flex align-items-center justify-content-end">
					<div class="btn-group" role="group" aria-label="Small button group">
						<%-- <button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;"
								id="btnGmail" onclick="window.open('about:blank').location.href='https://mail.google.com/mail/u/0/?tab=rm#inbox?compose=new'">
							<img class="w-auto" src="<c:url value='/resources/assets/images/gmail_icon.jpg?ver=1'/>" style="height: 14px; margin-bottom: 3px;">
						</button> --%>
						<!-- <button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnDownload"><i class="fa-solid fa-download"></i></button> -->
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnPrint"><i class="fa-solid fa-print"></i></button>
						<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" id="btnClose">
							<i class="fa-solid fa-caret-right"></i>
						</button>
					</div>
				</div>
			</div>
			<div class="row">
				<div style="width: 100%;">
				  	<div class="nav nav-tabs" id="nav-tab">
						<button class="nav-link active" id="tab1Nav" data-bs-toggle="tab" data-bs-target="#tab1">거래명세서</button>
				  	</div>
					<div class="tab-content" id="nav-tabContent">
						<div class="tab-pane fade show active" id="tab1">
							<div class="row" style="padding: 5px;">
								<table id="purchasePaperTable" class="table table-bordered m-0 d-none" style="border:1px solid #ffffff;">
									<colgroup>
										<col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%">
										<col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%">
										<col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%">
										<col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%">
										<col width="3%"><col width="3%"><col width="3%"><col width="3%"><col width="3%">
									</colgroup>
									<tr>
										<td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n">
										<td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n">
										<td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n">
										<td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n">
										<td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n"><td class="bd-n">
									</tr>
									<tr>
										<td colspan='10' class="bd-n" nowrap></td>
										<td colspan='9' class="fs-25 fc-red text-center bd-r bt-n bl-n br-n" nowrap>거&nbsp;&nbsp;&nbsp;래&nbsp;&nbsp;&nbsp;명&nbsp;&nbsp;&nbsp;세&nbsp;&nbsp;&nbsp;서</td>
										<td colspan='10' class="bd-n" nowrap></td>
									</tr>
									<tr>
										<td colspan='10' class="bd-n" nowrap></td>
										<td colspan='9' class="fs-15 fc-red text-center bd-n" nowrap>(공급자 보관용)</td>
										<td colspan='10' class="bd-n" nowrap></td>
									</tr>
									<tr>
										<td colspan='4' class="fs-15 fc-red bd-n" nowrap>납품년월일 : </td>
										<td colspan='25' class="fs-15 text-start bd-n" name="deliveryDate" nowrap></td>
									</tr>
									<tr>
										<td colspan='1' rowspan='4' class="fs-15 fc-red bd-r text-center align-middle not-left" nowrap>공<br>급<br>받<br>는<br>자</td>
										<td colspan='3' class="fs-13 bd-r bg-r fc-red text-center align-middle not-left" nowrap>등록번호</td>
										<td colspan='10' class="fs-13 bd-r text-center align-middle not-left" nowrap></td>
										
										<td colspan='1' rowspan='4' class="bd-r text-center align-middle not-left" nowrap></td>
										
										<td colspan='1' rowspan='4' class="fs-15 fc-red bd-r text-center align-middle not-left" nowrap>공<br>급<br>자</td>
										<td colspan='3' class="fs-13 bd-r bg-r fc-red text-center align-middle not-left" nowrap>등록번호</td>
										<td colspan='10' class="fs-13 bd-r text-center align-middle not-left" nowrap>123-86-01024</td>
									</tr>
									<tr>
										<td colspan='3' class="fs-13 bg-r fc-red bd-r text-center align-middle not-left" nowrap>상&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;호</td>
										<td colspan='5' class="fs-13 bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='2' class="fs-13 bg-r fc-red bd-r text-center align-middle not-left" nowrap>성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;명</td>
										<td colspan='3' class="fs-13 bd-r text-center align-middle not-left" nowrap></td>
										
										<td colspan='3' class="fs-13 bg-r fc-red bd-r text-center align-middle not-left" nowrap>상&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;호</td>
										<td colspan='5' class="fs-13 bd-r text-center align-middle not-left" nowrap>(주)창영테크팩</td>
										<td colspan='2' class="fs-13 bg-r fc-red bd-r text-center align-middle not-left" nowrap>성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;명</td>
										<td colspan='3' class="fs-13 bd-r text-center align-middle not-left" nowrap>최재성</td>
									</tr>
									<tr>
										<td colspan='3' class="fs-13 bg-r fc-red bd-r text-center align-middle not-left" nowrap>주&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소</td>
										<td colspan='10' class="fs-13 bd-r text-center align-middle not-left" nowrap></td>
										
										<td colspan='3' class="fs-13 bg-r fc-red bd-r text-center align-middle not-left" nowrap>주&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소</td>
										<td colspan='10' class="fs-13 bd-r text-center align-middle not-left" nowrap>경기도 수원시 권선구 산업로 156번길 88-39</td>
									</tr>
									<tr>
										<td colspan='3' class="fs-13 bg-r fc-red bd-r text-center align-middle not-left" nowrap>업&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;태</td>
										<td colspan='4' class="fs-13 bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='2' class="fs-13 bg-r fc-red bd-r text-center align-middle not-left" nowrap>종&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</td>
										<td colspan='4' class="fs-13 bd-r text-center align-middle not-left" nowrap></td>
										
										<td colspan='3' class="fs-13 bg-r fc-red bd-r text-center align-middle not-left" nowrap>업&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;태</td>
										<td colspan='4' class="fs-13 bd-r text-center align-middle not-left" nowrap>제조업</td>
										<td colspan='2' class="fs-13 bg-r fc-red bd-r text-center align-middle not-left" nowrap>종&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</td>
										<td colspan='4' class="fs-13 bd-r text-center align-middle not-left" nowrap>인쇄</td>
									</tr>
									<tr>
										<td colspan='3' class="fs-13 bg-r fc-red bd-r text-center align-middle not-left" nowrap>번 호</td>
										<td colspan='11' class="fs-13 bg-r fc-red bd-r text-center align-middle not-left" nowrap>품 명</td>
										<td colspan='3' class="fs-13 bg-r fc-red bd-r text-center align-middle not-left" nowrap>수 량</td>
										<td colspan='2' class="fs-13 bg-r fc-red bd-r text-center align-middle not-left" nowrap>Rev.</td>
										<td colspan='3' class="fs-13 bg-r fc-red bd-r text-center align-middle not-left" nowrap>구분/Batch</td>
										<td colspan='7' class="fs-13 bg-r fc-red bd-r text-center align-middle not-left" nowrap>비 고</td>
									</tr>
									<tr>
										<td colspan='3' class="h-23 fs-13 bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='11' class="h-23 fs-13 bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='3' class="h-23 fs-13 bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='2' class="h-23 fs-13 bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='3' class="h-23 fs-13 bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='7' class="h-23 fs-13 bd-r text-center align-middle not-left" nowrap></td>
									</tr>
									<tr>
										<td colspan='3' class="h-23 fs-13 bg-r bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='11' class="h-23 fs-13 bg-r bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='3' class="h-23 fs-13 bg-r bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='2' class="h-23 fs-13 bg-r bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='3' class="h-23 fs-13 bg-r bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='7' class="h-23 fs-13 bg-r bd-r text-center align-middle not-left" nowrap></td>
									</tr>
									<tr>
										<td colspan='3' class="h-23 fs-13 bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='11' class="h-23 fs-13 bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='3' class="h-23 fs-13 bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='2' class="h-23 fs-13 bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='3' class="h-23 fs-13 bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='7' class="h-23 fs-13 bd-r text-center align-middle not-left" nowrap></td>
									</tr>
									<tr>
										<td colspan='3' class="h-23 fs-13 bg-r bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='11' class="h-23 fs-13 bg-r bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='3' class="h-23 fs-13 bg-r bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='2' class="h-23 fs-13 bg-r bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='3' class="h-23 fs-13 bg-r bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='7' class="h-23 fs-13 bg-r bd-r text-center align-middle not-left" nowrap></td>
									</tr>
									<tr>
										<td colspan='3' class="h-23 fs-13 bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='11' class="h-23 fs-13 bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='3' class="h-23 fs-13 bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='2' class="h-23 fs-13 bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='3' class="h-23 fs-13 bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='7' class="h-23 fs-13 bd-r text-center align-middle not-left" nowrap></td>
									</tr>
									<tr>
										<td colspan='3' class="h-23 fs-13 bg-r bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='11' class="h-23 fs-13 bg-r bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='3' class="h-23 fs-13 bg-r bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='2' class="h-23 fs-13 bg-r bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='3' class="h-23 fs-13 bg-r bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='7' class="h-23 fs-13 bg-r bd-r text-center align-middle not-left" nowrap></td>
									</tr>
									<tr>
										<td colspan='3' class="h-23 fs-13 bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='11' class="h-23 fs-13 bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='3' class="h-23 fs-13 bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='2' class="h-23 fs-13 bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='3' class="h-23 fs-13 bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='7' class="h-23 fs-13 bd-r text-center align-middle not-left" nowrap></td>
									</tr>
									<tr>
										<td colspan='3' class="h-23 fs-13 bg-r bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='11' class="h-23 fs-13 bg-r bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='3' class="h-23 fs-13 bg-r bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='2' class="h-23 fs-13 bg-r bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='3' class="h-23 fs-13 bg-r bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='7' class="h-23 fs-13 bg-r bd-r text-center align-middle not-left" nowrap></td>
									</tr>
									<tr>
										<td colspan='3' class="h-23 fs-13 bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='11' class="h-23 fs-13 bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='3' class="h-23 fs-13 bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='2' class="h-23 fs-13 bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='3' class="h-23 fs-13 bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='7' class="h-23 fs-13 bd-r text-center align-middle not-left" nowrap></td>
									</tr>
									<tr>
										<td colspan='3' class="h-23 fs-13 bg-r bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='11' class="h-23 fs-13 bg-r bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='3' class="h-23 fs-13 bg-r bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='2' class="h-23 fs-13 bg-r bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='3' class="h-23 fs-13 bg-r bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='7' class="h-23 fs-13 bg-r bd-r text-center align-middle not-left" nowrap></td>
									</tr>
									<tr>
										<td colspan='3' class="h-23 fs-13 bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='11' class="h-23 fs-13 bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='3' class="h-23 fs-13 bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='2' class="h-23 fs-13 bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='3' class="h-23 fs-13 bd-r text-center align-middle not-left" nowrap></td>
										<td colspan='7' class="h-23 fs-13 bd-r text-center align-middle not-left" nowrap></td>
									</tr>
									<tr>
										<td colspan='17' class="h-23 fs-13 bd-n text-start align-middle not-left" nowrap>담당자 : 발주, 납기 : 백영선 부장, 정산 : 김아름 과장, 품질 : 라윤희 대리</td>
										<td colspan='12' class="h-23 fs-13 bd-n text-start align-middle not-left" nowrap>&nbsp;TEL : 031-292-6553 &nbsp;&nbsp;&nbsp;&nbsp; FAX : 031-292-6507</td>
									</tr>
									<!-- 절취선 -->
									<tr>
										<td colspan='30' class="bt-n bl-n br-n bd_dashed h-35" nowrap></td>
									</tr>

									
									<tr>
										<td colspan='30' class="bd-n" nowrap></td>
									</tr>
									<!-- 밑으론 밑 공급받는자용 -->
									<tr>
										<td colspan='10' class="bd-n" nowrap></td>
										<td colspan='9' class="fs-25 fc-blue text-center bd-b bt-n bl-n br-n" nowrap>거&nbsp;&nbsp;&nbsp;래&nbsp;&nbsp;&nbsp;명&nbsp;&nbsp;&nbsp;세&nbsp;&nbsp;&nbsp;서</td>
										<td colspan='10' class="bd-n" nowrap></td>
									</tr>
									<tr>
										<td colspan='10' class="bd-n" nowrap></td>
										<td colspan='9' class="fs-15 fc-blue text-center bd-n" nowrap>(공급받는자 보관용)</td>
										<td colspan='10' class="bd-n" nowrap></td>
									</tr>
									<tr>
										<td colspan='4' class="fs-15 fc-blue bd-n" nowrap>납품년월일 : </td>
										<td colspan='25' class="fs-15 text-start bd-n" name="deliveryDate" nowrap></td>
									</tr>
									<tr>
										<td colspan='1' rowspan='4' class="fs-15 fc-blue bd-b text-center align-middle not-left" nowrap>공<br>급<br>받<br>는<br>자</td>
										<td colspan='3' class="fs-13 bd-b bg-b fc-blue text-center align-middle not-left" nowrap>등록번호</td>
										<td colspan='10' class="fs-13 bd-b text-center align-middle not-left" nowrap></td>
										
										<td colspan='1' rowspan='4' class="bd-b text-center align-middle not-left" nowrap></td>
										
										<td colspan='1' rowspan='4' class="fs-15 fc-blue bd-b text-center align-middle not-left" nowrap>공<br>급<br>자</td>
										<td colspan='3' class="fs-13 bd-b bg-b fc-blue text-center align-middle not-left" nowrap>등록번호</td>
										<td colspan='10' class="fs-13 bd-b text-center align-middle not-left" nowrap>123-86-01024</td>
									</tr>
									<tr>
										<td colspan='3' class="fs-13 bg-b fc-blue bd-b text-center align-middle not-left" nowrap>상&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;호</td>
										<td colspan='5' class="fs-13 bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='2' class="fs-13 bg-b fc-blue bd-b text-center align-middle not-left" nowrap>성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;명</td>
										<td colspan='3' class="fs-13 bd-b text-center align-middle not-left" nowrap></td>
										
										<td colspan='3' class="fs-13 bg-b fc-blue bd-b text-center align-middle not-left" nowrap>상&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;호</td>
										<td colspan='5' class="fs-13 bd-b text-center align-middle not-left" nowrap>(주)창영테크팩</td>
										<td colspan='2' class="fs-13 bg-b fc-blue bd-b text-center align-middle not-left" nowrap>성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;명</td>
										<td colspan='3' class="fs-13 bd-b text-center align-middle not-left" nowrap>최재성</td>
									</tr>
									<tr>
										<td colspan='3' class="fs-13 bg-b fc-blue bd-b text-center align-middle not-left" nowrap>주&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소</td>
										<td colspan='10' class="fs-13 bd-b text-center align-middle not-left" nowrap></td>
										
										<td colspan='3' class="fs-13 bg-b fc-blue bd-b text-center align-middle not-left" nowrap>주&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소</td>
										<td colspan='10' class="fs-13 bd-b text-center align-middle not-left" nowrap>경기도 수원시 권선구 산업로 156번길 88-39</td>
									</tr>
									<tr>
										<td colspan='3' class="fs-13 bg-b fc-blue bd-b text-center align-middle not-left" nowrap>업&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;태</td>
										<td colspan='4' class="fs-13 bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='2' class="fs-13 bg-b fc-blue bd-b text-center align-middle not-left" nowrap>종&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</td>
										<td colspan='4' class="fs-13 bd-b text-center align-middle not-left" nowrap></td>
										
										<td colspan='3' class="fs-13 bg-b fc-blue bd-b text-center align-middle not-left" nowrap>업&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;태</td>
										<td colspan='4' class="fs-13 bd-b text-center align-middle not-left" nowrap>제조업</td>
										<td colspan='2' class="fs-13 bg-b fc-blue bd-b text-center align-middle not-left" nowrap>종&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</td>
										<td colspan='4' class="fs-13 bd-b text-center align-middle not-left" nowrap>인쇄</td>
									</tr>
									<tr>
										<td colspan='3' class="fs-13 bg-b fc-blue bd-b text-center align-middle not-left" nowrap>번 호</td>
										<td colspan='11' class="fs-13 bg-b fc-blue bd-b text-center align-middle not-left" nowrap>품 명</td>
										<td colspan='3' class="fs-13 bg-b fc-blue bd-b text-center align-middle not-left" nowrap>수 량</td>
										<td colspan='2' class="fs-13 bg-b fc-blue bd-b text-center align-middle not-left" nowrap>Rev.</td>
										<td colspan='3' class="fs-13 bg-b fc-blue bd-b text-center align-middle not-left" nowrap>구분/Batch</td>
										<td colspan='7' class="fs-13 bg-b fc-blue bd-b text-center align-middle not-left" nowrap>비 고</td>
									</tr>
									<tr>
										<td colspan='3' class="h-23 fs-13 bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='11' class="h-23 fs-13 bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='3' class="h-23 fs-13 bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='2' class="h-23 fs-13 bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='3' class="h-23 fs-13 bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='7' class="h-23 fs-13 bd-b text-center align-middle not-left" nowrap></td>
									</tr>
									<tr>
										<td colspan='3' class="h-23 fs-13 bg-b bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='11' class="h-23 fs-13 bg-b bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='3' class="h-23 fs-13 bg-b bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='2' class="h-23 fs-13 bg-b bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='3' class="h-23 fs-13 bg-b bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='7' class="h-23 fs-13 bg-b bd-b text-center align-middle not-left" nowrap></td>
									</tr>
									<tr>
										<td colspan='3' class="h-23 fs-13 bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='11' class="h-23 fs-13 bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='3' class="h-23 fs-13 bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='2' class="h-23 fs-13 bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='3' class="h-23 fs-13 bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='7' class="h-23 fs-13 bd-b text-center align-middle not-left" nowrap></td>
									</tr>
									<tr>
										<td colspan='3' class="h-23 fs-13 bg-b bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='11' class="h-23 fs-13 bg-b bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='3' class="h-23 fs-13 bg-b bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='2' class="h-23 fs-13 bg-b bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='3' class="h-23 fs-13 bg-b bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='7' class="h-23 fs-13 bg-b bd-b text-center align-middle not-left" nowrap></td>
									</tr>
									<tr>
										<td colspan='3' class="h-23 fs-13 bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='11' class="h-23 fs-13 bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='3' class="h-23 fs-13 bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='2' class="h-23 fs-13 bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='3' class="h-23 fs-13 bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='7' class="h-23 fs-13 bd-b text-center align-middle not-left" nowrap></td>
									</tr>
									<tr>
										<td colspan='3' class="h-23 fs-13 bg-b bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='11' class="h-23 fs-13 bg-b bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='3' class="h-23 fs-13 bg-b bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='2' class="h-23 fs-13 bg-b bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='3' class="h-23 fs-13 bg-b bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='7' class="h-23 fs-13 bg-b bd-b text-center align-middle not-left" nowrap></td>
									</tr>
									<tr>
										<td colspan='3' class="h-23 fs-13 bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='11' class="h-23 fs-13 bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='3' class="h-23 fs-13 bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='2' class="h-23 fs-13 bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='3' class="h-23 fs-13 bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='7' class="h-23 fs-13 bd-b text-center align-middle not-left" nowrap></td>
									</tr>
									<tr>
										<td colspan='3' class="h-23 fs-13 bg-b bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='11' class="h-23 fs-13 bg-b bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='3' class="h-23 fs-13 bg-b bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='2' class="h-23 fs-13 bg-b bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='3' class="h-23 fs-13 bg-b bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='7' class="h-23 fs-13 bg-b bd-b text-center align-middle not-left" nowrap></td>
									</tr>
									<tr>
										<td colspan='3' class="h-23 fs-13 bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='11' class="h-23 fs-13 bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='3' class="h-23 fs-13 bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='2' class="h-23 fs-13 bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='3' class="h-23 fs-13 bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='7' class="h-23 fs-13 bd-b text-center align-middle not-left" nowrap></td>
									</tr>
									<tr>
										<td colspan='3' class="h-23 fs-13 bg-b bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='11' class="h-23 fs-13 bg-b bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='3' class="h-23 fs-13 bg-b bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='2' class="h-23 fs-13 bg-b bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='3' class="h-23 fs-13 bg-b bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='7' class="h-23 fs-13 bg-b bd-b text-center align-middle not-left" nowrap></td>
									</tr>
									<tr>
										<td colspan='3' class="h-23 fs-13 bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='11' class="h-23 fs-13 bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='3' class="h-23 fs-13 bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='2' class="h-23 fs-13 bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='3' class="h-23 fs-13 bd-b text-center align-middle not-left" nowrap></td>
										<td colspan='7' class="h-23 fs-13 bd-b text-center align-middle not-left" nowrap></td>
									</tr>
									<tr>
										<td colspan='17' class="h-23 fs-13 bd-n text-start align-middle not-left" nowrap>담당자 : 발주, 납기 : 백영선 부장, 정산 : 김아름 과장, 품질 : 라윤희 대리</td>
										<td colspan='12' class="h-23 fs-13 bd-n text-start align-middle not-left" nowrap>&nbsp;TEL : 031-292-6553 &nbsp;&nbsp;&nbsp;&nbsp; FAX : 031-292-6507</td>
									</tr>
								</table>
							</div>
						</div>
					</div>
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
			let rightcolMinWidth = 850; // rightcol 최소사이즈
	
			let rightColWidth = isDragging ? page.clientWidth - parseInt(Math.max(leftcolMinWidth + 20, event.clientX)) : rightcol.clientWidth;

			//console.log(Math.max(rightColWidth, rightcolMinWidth));
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
			$('#page').css('grid-template-columns', '1.5fr 4px 2fr');
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
			$('#page').css('grid-template-columns', '1.5fr 4px 2fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcol').removeClass('d-none');
		} else {
			$('#page').css('grid-template-columns', '1.5fr 4px 0fr');
			$('#leftcol').removeClass('d-none');
			$('#rightcol').addClass('d-none');
		}
		dataTableDrawAll(); // dataTable 전체 reload
	});
</script>

<script>
	WM_init('new');
	WM_init('edit');
	
	let monthAdjustList = getCommonCode('시스템', '026'); //날짜조정
	monthAdjustList = _.sortBy(monthAdjustList, v=>parseInt(v.commonCd));
	let itemGubunList = getCommonCode('일반', '001'); // 제품구분
	let useYnCdList = getCommonCode('시스템', '055'); // 사용여부
	
	selectBoxAppend(monthAdjustList, 'monthAdjust', '', '2'); //날짜조정
	selectBoxAppend(itemGubunList, 'modalItemGubunBox', '', '1'); //제품구분
	selectBoxAppend(useYnCdList, 'modalUseYnCdBox', 'Y', '1'); //사용여부
	
	//let paperLineCountList = getCommonCode('시스템', '019'); //발주서라인수
	//let paperLineCount = parseInt(paperLineCountList[0].commonNm);
	$('#startDate').val(moment().subtract('w',1).format('YYYY-MM-DD'));
	$('#endDate').val(moment().format('YYYY-MM-DD'));
	
	$('#deliveryDate').val(moment().format('YYYY-MM-DD'));
	$('td[name=deliveryDate]').text(moment().format('YYYY-MM-DD'));
	$('#deliveryDate').on('change',function(){
		$('td[name=deliveryDate]').text($(this).val());
	});
	

	// 사용자정보 목록조회
	$('#outItemTable thead tr').clone(true).addClass('filters').appendTo('#outItemTable thead'); // filter 생성
	let outItemTable = $('#outItemTable').DataTable({
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
		select: {
            style: 'single',
            toggleable: false,
            items: 'row',
            info: false
        },
        ajax : {
			url : '<c:url value="/stock/outProdDtlList"/>',
			type : 'POST',
			data : {
				startDate : function() { return moment($('#startDate').val()).format('YYYYMMDD'); },
				endDate : function() { return moment($('#endDate').val()).format('YYYYMMDD'); },
			},
		},
        rowId: 'idx',
		columns : [
			/* { className : 'text-center align-middle', //체크박스
				render : function(data, type, row, meta) {
					return '<div style="white-space:nowrap;"><input class="form-check-input" type="checkbox" name="checkBox" style="margin: 0px; width: 20px; height: 20px;"></div>';
				}
			}, */
			{ data: 'bizOrdDtlNo', className : 'text-center align-middle', //수주상세
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return '<div style="white-space:nowrap;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ data: 'outProdDealCorpNm', className : 'text-center align-middle', //고객사
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return '<div style="white-space:nowrap;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ data: 'itemNm', className : 'text-center align-middle', //제품명
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return '<div style="white-space:nowrap;">'+data+'</div>';
					} else {
						return '-';
					}
				}
			},
			{ data: 'outProdEtc4', className : 'text-center align-middle', //명세서번호
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
						return '<div style="white-space:nowrap;">'+data+'</div>';
					} else {
						return '-';
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
			let table_id = $(api.table().node()).attr('id'); // dataTable ID
			
			let htmlHeight = parseFloat($('html').css('height'));
			let theadHeight = parseFloat($('#outItemTable_wrapper').find('.dataTables_scrollHead').css('height'));
			$('#'+table_id+'_wrapper').find('.dataTables_scrollBody').css('height',(htmlHeight - theadHeight - 79)+'px');
			
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
				let cell = $('#outItemTable_wrapper').find('.filters th').eq(
					$(api.column(colIdx).header()).index()
				);

				let title = $(cell).text();

				$(cell).html('<input type="text" class="form-control" placeholder="' + title + '" />');
				$(cell).css('padding','2px');

				let cursorPosition = '';
				
				// On every keypress in this input
				$('#outItemTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
					api.column(colIdx).search(this.value, false, false, true).draw();
				}).on('keyup', function (e) {
					e.stopPropagation();
					$(this).trigger('keyupTrigger');
				});
			});
		},
	});
	// dataTable colReorder event
	outItemTable.on('column-reorder', function( e, settings, details ) {
		let api = outItemTable;
		api.columns().eq(0).each(function (colIdx) {
			$('#outItemTable_wrapper').find('.filters th').eq($(api.column(colIdx).header()).index()).find('input').off('keyup keyupTrigger').on('keyupTrigger', function (e) {
				api.column(colIdx).search(this.value, false, false, true).draw();
			}).on('keyup', function (e) {
				e.stopPropagation();
				$(this).trigger('keyupTrigger');
			});
		});
	});

	$('#outItemTable tbody').on('click','tr', function() {
		let data = outItemTable.row(this).data();
		
		$('#purchaseCustomerNm').text(data.bizOrdDealCorpNm);//고객사
		$('#testItemNm').text(data.itemNm);//제품명
		$('#workDate').text(moment(data.workDate).format('YYYY-MM-DD'));//제조일자
		$('#bizOrdDtlNo').text(data.bizOrdDtlNo);//제조번호
		$('#testJudgmentDate').text(moment(data.judgmentDate).format('YYYY-MM-DD'));//검사일자
		$('#itemVersion').text(data.itemVersion);//도안번호
		$('#paperType').text(data.paperType);//재질명
		$('#quailtyPassQty').text(addCommas(parseFloat(data.quailtyPassQty)));//입고수량
		$('#eaQty').text(addCommas(parseFloat(data.eaQty)));//원판수량
		$('#inPackMethod').text(data.bundleUnit + ' / ' + data.bundleMethodNm);//포장방법 내부
		$('#outPackMethod').text(data.packUnit);//포장방법 외부
		$('#coatingMethod').text(data.coatingMethod);//코팅
		$('#itemColor').text(data.itemColor);//색상
		$('#moldingMethod').text(data.moldingMethod);//성형방식


		$('#testPaperType').text(data.paperType);//재질명
		$('#testSizeXY').text(data.sizeX +'*'+data.sizeY);//규격
		$('#testItemVersion').text(data.itemVersion);//도안번호
		$('#testItemColor').text(data.itemColor);//색상
		$('#testCoatingMethod').text(data.coatingMethod);//코팅

		$('#judUserName').text(data.judUserName);//시험자
		$('#judgmentDate').text(moment(data.judgmentDate).format('YYYY-MM-DD'));//시험일자
		$('#conUserName').text(data.conUserName);//판정자
		$('#confirmDate').text(moment(data.confirmDate).format('YYYY-MM-DD'));//판정일자
		$('#qualityJudgmentNm').text(data.qualityJudgmentNm);//판정결과
	});
	
	// 성적서출력 체크
	$(document).on('change','input[name=checkBox]', function() {
	});

	// 조회 버튼 click
	$('#btnSearch').on('click', function() {
		$('#my-spinner').show();
		outItemTable.row('.selected').deselect();
		outItemTable.ajax.reload(function() {});
		$('#checkAll').prop("checked",false);
		$('#btnSave').attr('disabled',true);
		$('#btnEdit').attr('disabled',false);
		$('#btnCancel').attr('disabled',true);
		
		$('.dtlList').find('td').html('&nbsp;');
		setTimeout(function() {
			$('#my-spinner').hide();
		}, 100)
	});

	// 발주서 인쇄 버튼 click
	$('#btnPrint').on('click',function() {
		$('#my-spinner').show();
		cssChange(); // css반영

		$('#purchasePaperTable').print({
			globalStyles: true,
			mediaPrint: true
		});
		
		setTimeout(function() {
			$('#my-spinner').hide();
		}, 200);
	});
	// 작업인쇄 모달이 띄워지면 인쇄
	$('#workOrderPaperModal').on('shown.bs.modal', function (e) {
		$('#purchasePaperTable').print({
			globalStyles: true,
			mediaPrint: true
		});
		$('#workOrderPaperModal').modal('hide');
		$('#my-spinner').hide();
	});

	// 발주서 다운로드 버튼 click
	$('#btnDownload').on('click', function() {
		cssChange(); // css반영
		html2canvas($('#purchasePaperTable')[0], {
			allowTaint : true,	// cross-origin allow
			useCORS: true,		// CORS 사용한 서버로부터 이미지 로드할 것인지 여부
			scale : 2			// 기본 96dpi에서 해상도를 두 배로 증가
		}).then(function(canvas) {
			var element = document.getElementById('purchasePaperTable');
			var opt = {
			  margin:       3,
			  filename:     moment().format('YYYYMMDD')+'_거래명세서.pdf',
			  image:        { type: 'jpeg', quality: 0.98 },
			  html2canvas:  { scale: 1 },
			  jsPDF:        { unit: 'mm', format: 'a4', orientation: 'portrait'},
			};

			// New Promise-based usage:
			html2pdf().from(element).set(opt).save().then(() => {
				
			});
		});
	});


	// 초기 셋팅
	$(document).ready(function() {
		cssChange();
		$('#my-spinner').hide();
		$('#purchasePaperTable').removeClass('d-none');

		$('input').attr('autocomplete','one-time-code');
	});

	function cssChange() {
		$('#purchasePaperTable').find('td').css('font-weight', '900');
		$('#purchasePaperTable').find('td').css('border', '2px solid black');
		$('#purchasePaperTable').find('td').css('padding', '0.1rem');
		$('#purchasePaperTable').find('td').css('color', '#000000');

		$('#purchasePaperTable').find('.bg-gray').css('background-color', '#A5A5A5');
		
		$('#purchasePaperTable').find('.theadFirstCol').css('border-top', '0px');
		//$('#purchasePaperTable').find('.theadFirstCol').css('border-left', '2px');
		$('#purchasePaperTable').find('.theadNotFisrtCol').css('border-top', '0px');
		$('#purchasePaperTable').find('.theadNotFisrtCol').css('border-left', '0px');
		
		$('#purchasePaperTable').find('.tbodyFirstCol').css('border-top', '0px');
		//$('#purchasePaperTable').find('.tbodyFirstCol').css('border-left', '2px');
		$('#purchasePaperTable').find('.tbodyNotFirstCol').css('border-top', '0px');
		$('#purchasePaperTable').find('.tbodyNotFirstCol').css('border-left', '0px');

		
		$('#purchasePaperTable').find('.fs-8').css('font-size', '8px');
		$('#purchasePaperTable').find('.fs-10').css('font-size', '10px');
		$('#purchasePaperTable').find('.fs-12').css('font-size', '12px');
		$('#purchasePaperTable').find('.fs-13').css('font-size', '13px');
		$('#purchasePaperTable').find('.fs-15').css('font-size', '15px');
		$('#purchasePaperTable').find('.fs-20').css('font-size', '20px');
		$('#purchasePaperTable').find('.fs-25').css('font-size', '25px');
		$('#purchasePaperTable').find('.fs-30').css('font-size', '30px');
		$('#purchasePaperTable').find('.fs-50').css('font-size', '50px');
		$('#purchasePaperTable').find('.fc-red').css('color', '#ff0000');
		$('#purchasePaperTable').find('.fc-blue').css('color', '#0070C0');
		$('#purchasePaperTable').find('.bt-2').css('border-top', '2px solid black');
		$('#purchasePaperTable').find('.bd-n').css('border', '0px solid #ffffff');
		$('#purchasePaperTable').find('.bt-n').css('border-top', '0px solid #ffffff');
		$('#purchasePaperTable').find('.br-n').css('border-right', '0px solid #ffffff');
		$('#purchasePaperTable').find('.bb-n').css('border-bottom', '0px solid #ffffff');
		$('#purchasePaperTable').find('.bl-n').css('border-left', '0px solid #ffffff');
		$('#purchasePaperTable').find('.bd_dashed').css('border-style','dashed');
		$('#purchasePaperTable').find('.h-5').css('height', '5px');
		$('#purchasePaperTable').find('.h-10').css('height', '10px');
		$('#purchasePaperTable').find('.h-20').css('height', '20px');
		$('#purchasePaperTable').find('.h-23').css('height', '23px');
		$('#purchasePaperTable').find('.h-25').css('height', '25px');
		$('#purchasePaperTable').find('.h-30').css('height', '30px');
		$('#purchasePaperTable').find('.h-35').css('height', '35px');
		$('#purchasePaperTable').find('.h-40').css('height', '40px');
		$('#purchasePaperTable').find('.h-55').css('height', '55px');
		$('#purchasePaperTable').find('.h-70').css('height', '70px');
		$('#purchasePaperTable').find('.h-100').css('height', '100px');

		$('#purchasePaperTable').find('.bd-r').css('border-color', '#FF0000');
		$('#purchasePaperTable').find('.bg-r').css('background-color', '#FFCCFF');

		$('#purchasePaperTable').find('.bd-b').css('border-color', '#0070C0');
		$('#purchasePaperTable').find('.bg-b').css('background-color', '#92CDDC');
		
		// 인쇄할 때 css 적용하려면 important 붙여줘야함.
		for(var i=0;i<$('#purchasePaperTable').find('td').length;i++) {
			let tdStyle = $('#purchasePaperTable').find('td').eq(i).attr('style') == undefined?'':$('#purchasePaperTable').find('td').eq(i).attr('style');
			$('#purchasePaperTable').find('td').eq(i).attr('style',tdStyle.replaceAll(';',' !important;'));
		}
	}


	/* 거래처 모달 */
	
	// 거래처조회 버튼 click
	$('#btnSearchDealCorp').on('click', function() {
		$('#dealCorpModal').modal('show');
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
		let data = dealCorpModalTable.row('.selected').data();
		$('#searchDealCorpNm').val(data.dealCorpNm);
		$('#searchDealCorpIdx').val(data.idx);
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

	/* 사용자 모달 */
	// 유저모달 버튼 click
	$(document).on('click', '.btnUserModalShow', function() {
		$('#userModal').data('type',$(this).data('type'));
		$('#userModal').modal('show');
	});
	$('#userModal').on('shown.bs.modal', function() {
		userModalTable.ajax.reload(function() {});
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
			{ data: 'userDepartmentNm', className : 'text-center'},
			{ data: 'userPositionNm', className : 'text-center'},
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

	// 사용자목록 적용 버튼 click
	$('#btnUserModalPaste').on('click', function(){
		if(!$('#userModalTable tbody tr').hasClass('selected')){
			toastr.warning('붙여넣을 행을 선택해주세요.');
			return false;
		}
		let table = $('#prodQualityTable').dataTable().api();
		let node = table.row('.selected').node();
		let data = table.row('.selected').data();
		let selectNodeModalData = userModalTable.row('.selected').data();
		$(node).find('td').eq(table.column($('#userModal').data('type')+':name').index()).find('input[type=hidden]').val(selectNodeModalData.idx);	//사용자 식별자
		$(node).find('td').eq(table.column($('#userModal').data('type')+':name').index()).find('input[type=text]').val(selectNodeModalData.userName);		//사용자 이름
		$('#userModal').modal('hide');
	});

</script>
</body>
</html>
