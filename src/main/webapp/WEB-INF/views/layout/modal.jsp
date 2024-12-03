<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<div id="my-spinner">
	<div>
		<span> <img src="<c:url value='/resources/assets/images/spinner.gif'/>">
		</span>
	</div>
</div>
<!-- 작업중에 다른내역을 클릭하거나 창을 빠져나갈때-->
<div class="modal fade" id="workingWarningModal" tabindex="-1" aria-hidden="true" style="z-index: 9999;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">
					<i class="fa-solid fa-triangle-exclamation text-warning"></i> <spring:message code="modal.warning" text="default text" />
				</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<spring:message code="modal.saveGuide" text="default text" />
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="btnWorkingWarningModalY" data-bs-dismiss="modal" style="width: 70px;">
					<spring:message code="yes" text="default text" />
				</button>
				<button type="button" class="btn btn-secondary" id="btnWorkingWarningModalN" data-bs-dismiss="modal" style="width: 70px;">
					<spring:message code="no" text="default text" />
				</button>
			</div>
		</div>
	</div>
</div>
<!-- 삭제 경고 -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-hidden="true" style="z-index: 9999;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">
					<i class="fa-solid fa-triangle-exclamation text-danger"></i> <spring:message code="modal.warning" text="default text" />
				</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<spring:message code="modal.deleteGuide" text="default text" />
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" id="btnDeleteModalY" data-bs-dismiss="modal" style="width: 70px;">
					<spring:message code="yes" text="default text" />
				</button>
				<button type="button" class="btn btn-secondary" id="btnDeleteModalN" data-bs-dismiss="modal" style="width: 70px;">
					<spring:message code="no" text="default text" />
				</button>
			</div>
		</div>
	</div>
</div>
<!-- 취소 경고 -->
<div class="modal fade" id="cancelModal" tabindex="-1" aria-hidden="true" style="z-index: 9999;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">
					<i class="fa-solid fa-triangle-exclamation text-warning"></i> <spring:message code="modal.warning" text="default text" />
				</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<spring:message code="modal.cancelGuide" text="default text" />
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="btnCancelModalY" data-bs-dismiss="modal" style="width: 70px;">
					<spring:message code="yes" text="default text" />
				</button>
				<button type="button" class="btn btn-secondary" id="btnCancelModalN" data-bs-dismiss="modal" style="width: 70px;">
					<spring:message code="no" text="default text" />
				</button>
			</div>
		</div>
	</div>
</div>
<!-- 담당자 모달 -->
<div class="modal fade" id="userModal" tabindex="-1" aria-hidden="true" style="z-index: 9999;">
	<div class="modal-dialog" style="max-width: 60vw;">
		<div class="modal-content" style="height: calc(100vh - 5em);">
			<div class="modal-header">
				<h5 class="modal-title">
					사용자 조회
				</h5>
				<div class="btn-group" role="group" aria-label="Small button group">
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnUserModalPaste">
						<i class="fa-regular fa-paste"></i>
					</button>
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" data-bs-dismiss="modal" aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>
			</div>
			<div class="modal-body">
				<table class="table table-bordered p-0 m-0" id="userModalTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle"><spring:message code="userId" text="default text" /></th>
							<th class="text-center align-middle"><spring:message code="userName" text="default text" /></th>
							<th class="text-center align-middle"><spring:message code="userDepartmentCd" text="default text" /></th>
							<th class="text-center align-middle"><spring:message code="userJobCd" text="default text" /></th>
							<th class="text-center align-middle"><spring:message code="userPositionCd" text="default text" /></th>
						</tr>
					</thead>
				</table>
			</div>
			
		</div>
	</div>
</div>
<!-- 거래처 모달 -->
<div class="modal fade" id="dealCorpModal" tabindex="-1" aria-hidden="true" style="z-index: 9999;">
	<div class="modal-dialog" style="max-width: 60vw;">
		<div class="modal-content" style="height: calc(100vh - 5em);">
			<div class="modal-header">
				<h5 class="modal-title">
					거래처 조회
				</h5>
				<div class="btn-group" role="group" aria-label="Small button group">
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnDealCorpModalPaste">
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
						<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">거래상태</label>
						<select class="form-select w-auto h-100 me-3" id="modalDealCorpStatus" style="min-width: 70px;"></select>
						<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">거래구분</label>
						<select class="form-select w-auto h-100 me-3" id="modalDealGubun" style="min-width: 70px;"></select>
					</div>
					<div class="me-lg-auto"></div>
					<div class="d-flex align-items-center justify-content-end">
						<div class="btn-group" role="group" aria-label="Small button group">
							<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnDealCorpModalSearch"><i class="fa-regular fa-clipboard"></i></button>
						</div>
					</div>
				</div>
				<table class="table table-bordered p-0 m-0" id="dealCorpModalTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle">거래구분</th>
							<th class="text-center align-middle">거래처코드</th>
							<th class="text-center align-middle">업체명</th>
							<th class="text-center align-middle">업체명(약식)</th>
							<th class="text-center align-middle">대표자</th>
							<th class="text-center align-middle">사업자번호</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>
<!-- 자재 모달 -->
<div class="modal fade" id="matrlModal" tabindex="-1" aria-hidden="true" style="z-index: 9999;">
	<div class="modal-dialog" style="max-width: 60vw;">
		<div class="modal-content" style="height: calc(100vh - 5em);">
			<div class="modal-header">
				<h5 class="modal-title">
					자재 조회
				</h5>
				<div class="btn-group" role="group" aria-label="Small button group">
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" name="btnModalNew" data-menu="pm-bmsc0090">
						<i class="fa-solid fa-plus"></i>
					</button>
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnMatrlModalPaste">
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
						<input type="text" class="form-control w-auto h-100 me-1" id="modalMatrlSearchAll" style="min-width:200px;" placeholder="통합검색">
					</div>
					<div class="me-lg-auto"></div>
					<div class="d-flex align-items-center justify-content-end">
						<div class="btn-group" role="group" aria-label="Small button group">
							<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnMatrlModalSearch"><i class="fa-regular fa-clipboard"></i></button>
						</div>
					</div>
				</div>
				<table class="table table-bordered p-0 m-0" id="matrlModalTable">
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
<!-- 공정 모달 -->
<div class="modal fade" id="prcssModal" tabindex="-1" aria-hidden="true" style="z-index: 9999;">
	<div class="modal-dialog" style="max-width: 60vw;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">
					공정 조회
				</h5>
				<div class="btn-group" role="group" aria-label="Small button group">
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnPrcssModalPaste">
						<i class="fa-regular fa-paste"></i>
					</button>
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" data-bs-dismiss="modal" aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>
			</div>
			<div class="modal-body">
				<table class="table table-bordered p-0 m-0" id="prcssModalTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle">공정코드</th>
							<th class="text-center align-middle">공정명</th>
							<th class="text-center align-middle">수량단위</th>
							<th class="text-center align-middle">이니셜</th>
							<th class="text-center align-middle">비고</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>
<!-- 부자재(목형) 모달 -->
<div class="modal fade" id="woodenInfoModal" tabindex="-1" aria-hidden="true" style="z-index: 9999;">
	<div class="modal-dialog" style="max-width: 60vw;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">
					부자재(목형) 조회
				</h5>
				<div class="btn-group" role="group" aria-label="Small button group">
					
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 18px !important;" name="btnModalNew" data-menu="wm-bmsc0040" data-path="bm/bmsc0040">
						<i class="fa-solid fa-plus"></i>
					</button>
				
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnWoodenInfoModalPaste">
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
					</div>
					<div class="me-lg-auto"></div>
					<div class="d-flex align-items-center justify-content-end">
						<div class="btn-group" role="group" aria-label="Small button group">
							<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnWoodenInfoModalSearch"><i class="fa-regular fa-clipboard"></i></button>
						</div>
					</div>
				</div>
				<table class="table table-bordered p-0 m-0" id="woodenInfoModalTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle">코드</th>
							<th class="text-center align-middle">사이즈</th>
							<th class="text-center align-middle">성형방식</th>
							<th class="text-center align-middle">성형내용</th>
							<th class="text-center align-middle">묶음법</th>
							<th class="text-center align-middle">묶음단위</th>
							<th class="text-center align-middle">포장단위</th>
							<th class="text-center align-middle">포장박스</th>
							<th class="text-center align-middle">코팅방법</th>
							<th class="text-center align-middle">호기</th>
							<th class="text-center align-middle">후가공</th>
							<th class="text-center align-middle">후가공호기</th>
							<th class="text-center align-middle">사용여부</th>
						</tr>
					</thead>
				</table>
			</div>			
		</div>
	</div>
</div>
<!-- 창고 모달 -->
<div class="modal fade" id="locationModal" tabindex="-1" aria-hidden="true" style="z-index: 9999;">
	<div class="modal-dialog" style="max-width: 60vw;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">
					창고 조회
				</h5>
				<div class="btn-group" role="group" aria-label="Small button group">
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnLocationModalPaste">
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
						<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">품목구분</label>
						<select class="form-select w-auto h-100 me-3" id="locationModalItemGubun"></select>
					</div>
					<div class="me-lg-auto"></div>
					<div class="d-flex align-items-center justify-content-end">
						<div class="btn-group" role="group" aria-label="Small button group">
							<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnLocationSearch">
								<i class="fa-regular fa-clipboard"></i>
							</button>
						</div>
					</div>
				</div>
				<table class="table table-bordered p-0 m-0" id="locationModalTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle">창고코드</th>
							<th class="text-center align-middle">창고명</th>
							<th class="text-center align-middle">출고</th>
							<th class="text-center align-middle">입고</th>
							<th class="text-center align-middle">반품</th>
							<th class="text-center align-middle">QC</th>
							<th class="text-center align-middle">외주</th>
							<th class="text-center align-middle">품목구분</th>
						</tr>
					</thead>
				</table>
			</div>			
		</div>
	</div>
</div>
<!-- 창고 구역/위치 모달 -->
<div class="modal fade" id="locationDtlModal" tabindex="-1" aria-hidden="true" style="z-index: 9999;">
	<div class="modal-dialog" style="max-width: 60vw;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">
					창고 구역/위치 조회
				</h5>
				<div class="btn-group" role="group" aria-label="Small button group">
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnLocationDtlModalPaste">
						<i class="fa-regular fa-paste"></i>
					</button>
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" data-bs-dismiss="modal" aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>
			</div>
			<div class="modal-body">
				<table class="table table-bordered p-0 m-0" id="locationDtlModalTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle">창고코드</th>
							<th class="text-center align-middle">창고명</th>
							<th class="text-center align-middle">구역</th>
							<th class="text-center align-middle">위치(단)</th>
							<th class="text-center align-middle">위치(열)</th>
							<th class="text-center align-middle">사용여부</th>
							<th class="text-center align-middle">비고</th>
						</tr>
					</thead>
				</table>
			</div>			
		</div>
	</div>
</div>
<!-- 사업장 모달 -->
<div class="modal fade" id="workPlaceModal" tabindex="-1" aria-hidden="true" style="z-index: 9999;">
	<div class="modal-dialog" style="max-width: 60vw;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">
					사업장 조회
				</h5>
				<div class="btn-group" role="group" aria-label="Small button group">
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnWorkPlaceModalPaste">
						<i class="fa-regular fa-paste"></i>
					</button>
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" data-bs-dismiss="modal" aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>
			</div>
			<div class="modal-body">
				<table class="table table-bordered p-0 m-0" id="workPlaceModalTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle">주사업장여부</th>
							<th class="text-center align-middle">사업장코드</th>
							<th class="text-center align-middle">사업장명칭</th>
						</tr>
					</thead>
				</table>
			</div>			
		</div>
	</div>
</div>
<!-- 제품코드 모달 -->
<div class="modal fade" id="itemCodeModal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog" style="max-width: 95vw;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">
					제품코드 조회
				</h5>
				<div class="btn-group" role="group" aria-label="Small button group">
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnItemCodeModalPaste">
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
						<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">품목구분</label>
						<select class="form-select w-auto h-100 me-3" id="modalItemGubunBox" style="min-width: 70px;"></select>
						<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">사용여부</label>
						<select class="form-select w-auto h-100 me-3" id="modalUseYnCdBox" style="min-width: 70px;"></select>
						<input type="text" class="form-control w-auto h-100 me-1" id="modalItemCodeSearchAll" style="min-width:200px;" placeholder="통합검색">
					</div>
					<div class="me-lg-auto"></div>
					<div class="d-flex align-items-center justify-content-end">
						<div class="btn-group" role="group" aria-label="Small button group">
							<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnItemCodeModalSearch"><i class="fa-regular fa-clipboard"></i></button>
						</div>
					</div>
				</div>
				<table class="table table-bordered p-0 m-0" id="itemCodeModalTable">
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
							<th class="text-center align-middle">현재고량</th>
							<th class="text-center align-middle">검수방법</th>
							<th class="text-center align-middle">착인여부</th>
							<th class="text-center align-middle">사용여부</th>
							<th class="text-center align-middle">등록일자</th>
							<th class="text-center align-middle">후가공판번호</th>
							<th class="text-center align-middle">부분UV</th>
							<th class="text-center align-middle">FOIL</th>
							<th class="text-center align-middle">형압</th>
							<th class="text-center align-middle">FSC 유무</th>
							<th class="text-center align-middle">납품처</th>
							<th class="text-center align-middle">공정실적여부</th>
							<th class="text-center align-middle">기타1</th>
							<th class="text-center align-middle">기타2</th>
							<th class="text-center align-middle">기타3</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>
<!-- 공정라우팅 모달 -->
<div class="modal fade" id="prcssRoutingModal" tabindex="-1" aria-hidden="true" style="z-index: 9999;">
	<div class="modal-dialog" style="max-width: 60vw;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">
					공정 라우팅 조회
				</h5>
				<div class="btn-group" role="group" aria-label="Small button group">
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnprcssRoutingPaste">
						<i class="fa-regular fa-paste"></i>
					</button>
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" data-bs-dismiss="modal" aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>
			</div>
			<div class="modal-body">
				<table class="table table-bordered p-0 m-0" id="prcssRoutingTable">
					<thead class="table-light">
						<tr>
							<th class="text-center align-middle">라우팅 번호</th>
							<th class="text-center align-middle">공정 순서</th>
						</tr>
					</thead>
				</table>
			</div>			
		</div>
	</div>
</div>
<!-- 제품정보 일괄변경 모달 -->
<div class="modal fade" id="itemInfoChangeModal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog" style="max-width: 95vw;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">
					제품정보 일괄변경
				</h5>
				<div class="btn-group" role="group" aria-label="Small button group">
					<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" data-bs-dismiss="modal" aria-label="Close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>
			</div>
			<div class="modal-body">
				<div style="display: grid; grid-template-columns: 1.5fr 1fr;">
					<div style="margin-right: 10px;">
						<div class="row" style="padding-bottom: 5px;">
							<div class="d-flex align-items-center d-flex">
								<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">품목구분</label>
								<select class="form-select w-auto h-100 me-3" id="modalItemGubunBox" style="min-width: 70px;">
									<option value="" selected>전체</option>
									<option value="001">제품</option>
									<option value="002">상품</option>
								</select>
								<label class="form-label d-flex align-items-center header-label m-0 me-1 h-100">사용여부</label>
								<select class="form-select w-auto h-100 me-3" id="modalUseYnCdBox" style="min-width: 70px;">
									<option value="">전체</option>
									<option value="Y" selected>사용</option>
									<option value="N">미사용</option>
								</select>
								<input type="text" class="form-control w-auto h-100 me-1" id="modalItemCodeSearchAll" style="min-width:200px;" placeholder="통합검색">
							</div>
							<div class="me-lg-auto"></div>
							<div class="d-flex align-items-center justify-content-end">
								<div class="btn-group" role="group" aria-label="Small button group">
									<button type="button" class="btn btn-outline-light w-auto " style="font-size: 18px !important;" id="btnItemCodeModalSearch"><i class="fa-regular fa-clipboard"></i></button>
								</div>
							</div>
						</div>
						<table class="table table-bordered p-0 m-0" id="itemInfoChangeTable">
							<thead class="table-light">
								<tr>
									<th class="text-center align-middle">
										<input type="checkbox" class="form-contorl" id="infoChangeCheckAll" name="infoChangeCheckAll" style="width:20px; height:20px;">
									</th>
									<th class="text-center align-middle">고객사</th>
									<th class="text-center align-middle">제품명</th>
									<th class="text-center align-middle">자재코드</th>
									<th class="text-center align-middle">버전번호</th>
								</tr>
							</thead>
						</table>
					</div>
					<div>
						<div class="row" style="padding-bottom: 5px;">
							<div class="me-lg-auto"></div>
							<div class="d-flex align-items-center justify-content-end">
								<div class="btn-group" role="group" aria-label="Small button group">
									<button type="button" class="btn btn-outline-light w-auto" style="font-size: 20px !important;" id="btnInfoChangeSave">
										<i class="fa-regular fa-floppy-disk"></i>
									</button>
								</div>
							</div>
						</div>
						<table class="table table-bordered p-0 m-0">
							<colgroup>
								<col width="20%">
								<col width="30%">
								<col width="20%">
								<col width="30%">
								
							</colgroup>
							<tr>
								<th style="background-color: rgb(192, 229, 249) !important;">
									<div style="display: grid; grid-template-columns: 0.5fr 1fr;"> 
									    <div><input type="checkbox" name="infoColumnCheck" style="width:20px; height:20px;" class="" checked> </div>
									    <div>사이즈</div>
									</div>
								</th>
								<td class="text-center align-middle">
									<input type="text" class="form-control inputGroup" id="itemSize">
								</td>
								<th class="text-center align-middle">
									<div style="display: grid; grid-template-columns: 0.5fr 1fr;"> 
									    <div><input type="checkbox" name="infoColumnCheck" style="width:20px; height:20px;" class="" checked> </div>
									    <div>칼끝규격</div>
									</div>
								</th>
								<td class="text-center align-middle">
									<input type="text" class="form-control inputGroup" id="knifeTipSize">
								</td>
							</tr>
							<tr>
								<th class="text-center align-middle" style="background-color: rgb(192, 229, 249) !important;">
									<div style="display: grid; grid-template-columns: 0.5fr 1fr;"> 
									    <div><input type="checkbox" name="infoColumnCheck" style="width:20px; height:20px;" class="" checked> </div>
									    <div>성형방식</div>
									</div>
								</th>
								<td class="text-center align-middle">
									<input type="text" class="form-control inputGroup" id="moldingMethod">
								</td>
								<th class="text-center align-middle" style="background-color: rgb(192, 229, 249) !important;">
									<div style="display: grid; grid-template-columns: 0.5fr 1fr;"> 
									    <div><input type="checkbox" name="infoColumnCheck" style="width:20px; height:20px;" class="" checked> </div>
									    <div>성형내용</div>
									</div>
								</th>
								<td class="text-center align-middle">
									<input type="text" class="form-control inputGroup" id="moldingContents">
								</td>
							</tr>
							<tr>
								<th class="text-center align-middle" style="background-color: rgb(192, 229, 249) !important;">
									<div style="display: grid; grid-template-columns: 0.5fr 1fr;"> 
									    <div><input type="checkbox" name="infoColumnCheck" style="width:20px; height:20px;" class="" checked> </div>
									    <div>묶음법</div>
									</div>
								</th>
								<td class="text-center align-middle">
									<select class="form-select inputGroup" id="bundleMethod"></select>
								</td>
								<th class="text-center align-middle" style="background-color: rgb(192, 229, 249) !important;">
									<div style="display: grid; grid-template-columns: 0.5fr 1fr;"> 
									    <div><input type="checkbox" name="infoColumnCheck" style="width:20px; height:20px;" class="" checked> </div>
									    <div>묶음단위</div>
									</div>
								</th>
								<td class="text-center align-middle">
									<input type="text" class="form-control inputGroup" id="bundleUnit">
								</td>
							</tr>
							<tr>
								<th class="text-center align-middle" style="background-color: rgb(192, 229, 249) !important;">
									<div style="display: grid; grid-template-columns: 0.5fr 1fr;"> 
									    <div><input type="checkbox" name="infoColumnCheck" style="width:20px; height:20px;" class="" checked> </div>
									    <div>포장박스</div>
									</div>
								</th>
								<td class="text-center align-middle">
									<select class="form-select inputGroup" id="packMethod"></select>
								</td>
								<th class="text-center align-middle" style="background-color: rgb(192, 229, 249) !important;">
									<div style="display: grid; grid-template-columns: 0.5fr 1fr;"> 
									    <div><input type="checkbox" name="infoColumnCheck" style="width:20px; height:20px;" class="" checked> </div>
									    <div>포장단위</div>
									</div>
								</th>
								<td class="text-center align-middle">
									<input type="text" class="form-control inputGroup" id="packUnit">
								</td>
							</tr>
							<tr>
								<th class="text-center align-middle" style="background-color: rgb(192, 229, 249) !important;">
									<div style="display: grid; grid-template-columns: 0.5fr 1fr;"> 
									    <div><input type="checkbox" name="infoColumnCheck" style="width:20px; height:20px;" class="" checked> </div>
									    <div>목형번호</div>
									</div>
								</th>
								<td class="text-center align-middle">
									<div style="display: flex;" class="input-group">
										<input type="text" class="form-control inputGroup inputNm" id="woodenCareCd" disabled>
										<button type="button" class="inputGroup nameDel" id="btnWoodenCareDelete"
											style="background-color: transparent; border-color: transparent; position: absolute; top: 0; right: 0; margin: 1px 23px; margin-left: 0px; border: none;">
											<i class="fa-solid fa-xmark"></i>
										</button>
										<input type="hidden" class="form-control inputGroup inputIdx" id="woodenCareIdx">
										<button type="button" style="padding: 1px 4px; margin-left: 0px;" class="btn btn-primary input-sub-search inputGroup"
											id="woodenCareBtn">
											<i class="fa-solid fa-magnifying-glass"></i>
										</button>
									</div>
								</td>
								<th class="text-center align-middle">
									<div style="display: grid; grid-template-columns: 0.5fr 1fr;"> 
									    <div><input type="checkbox" name="infoColumnCheck" style="width:20px; height:20px;" class="" checked> </div>
									    <div>타공목형번호</div>
									</div>
								</th>
								<td class="text-center align-middle">
									<input type="text" class="form-control inputGroup" id="holeWoodenCd">
								</td>
							</tr>
							<tr>
								<th class="text-center align-middle" style="background-color: rgb(255, 248, 207) !important;">
									<div style="display: grid; grid-template-columns: 0.5fr 1fr;"> 
									    <div><input type="checkbox" name="infoColumnCheck" style="width:20px; height:20px;" class="" checked> </div>
									    <div>코팅방법</div>
									</div>
								</th>
								<td class="text-center align-middle">
									<input type="text" class="form-control inputGroup" id="coatingMethod">
								</td>
									<th class="text-center align-middle" style="background-color: rgb(255, 248, 207) !important;">
									<div style="display: grid; grid-template-columns: 0.5fr 1fr;"> 
									    <div><input type="checkbox" name="infoColumnCheck" style="width:20px; height:20px;" class="" checked> </div>
									    <div>호기</div>
									</div>
								</th>
								<td class="text-center align-middle">
									<select class="form-select inputGroup" id="etc1"></select>
								</td>
							</tr>
							<tr>	
								<th class="text-center align-middle">
									<div style="display: grid; grid-template-columns: 0.5fr 1fr;"> 
									    <div><input type="checkbox" name="infoColumnCheck" style="width:20px; height:20px;" class="" checked> </div>
									    <div>검수방법</div>
									</div>
								</th>
								<td class="text-center align-middle">
									<select class="form-select inputGroup" id="inspectMethod"></select>
								</td>
								<th class="text-center align-middle">
									<div style="display: grid; grid-template-columns: 0.5fr 1fr;"> 
									    <div><input type="checkbox" name="infoColumnCheck" style="width:20px; height:20px;" class="" checked> </div>
									    <div>FSC</div>
									</div>
								</th>
								<td class="text-center align-middle">
									<select class="form-select inputGroup" id="etc7"></select>
								</td>
							</tr>
							
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
