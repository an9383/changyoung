package mes.service.wm;

import java.util.List;

import mes.domain.wm.WorkOrderVo;

public interface WorkOrderService {
	
	//작업지시서 상세 조회
	public List<WorkOrderVo> workOrdDtlLstWithPrcssByOrdDate(WorkOrderVo workOrderVo) throws Exception;
	
	//작업지시서 상세 조회
	public List<WorkOrderVo> workOrdDtlLstWithPrcssByBizDtlIdx(WorkOrderVo workOrderVo) throws Exception;
	
	//작업지시서 목록(공정별) 조회
	public List<WorkOrderVo> workOrdLstWithPrcssByOrdDate(WorkOrderVo workOrderVo) throws Exception;
	
	//작업지시 기준 마지막 공정 정보 조회
	public WorkOrderVo workOrdLastPrcssSel(WorkOrderVo workOrderVo) throws Exception;
	
	//작업지시서 목록(공정별) 조회-작지기준
	public List<WorkOrderVo> workOrdLstWithPrcssByWorkOrd(WorkOrderVo workOrderVo) throws Exception;

	//작업지시서 목록(공정별) 조회-수주상세식별자기준
	public List<WorkOrderVo> workOrdLstWithPrcssByBizOrdDtlIdx(WorkOrderVo workOrderVo) throws Exception;
	
	//작업지시서 목록(생산진행현황) 조회
	public List<WorkOrderVo> workOrdPrcssStatusLst(WorkOrderVo workOrderVo) throws Exception;
	
	//작업지시서 목록(기간별생산현황) 조회
	public List<WorkOrderVo> workOrdPrcssStatusLstOrderByDealCorp(WorkOrderVo workOrderVo) throws Exception;
	
	//작업지시서 목록(기간별생산현황,지시일 오름차순) 조회
	public List<WorkOrderVo> workOrdPrcssStatusLstOrderByworkOrdDate(WorkOrderVo workOrderVo) throws Exception;

	//작업지시서 목록(공정별) 현공정 정보 조회
	public WorkOrderVo workOrdSelWithPrcss(WorkOrderVo workOrderVo) throws Exception;

	//작업지시서 인쇄
	public void workOrdPaperPrint(WorkOrderVo workOrderVo) throws Exception;
	
	//작업지시 공정 강제 완료 처리
	public void workOrdForcedPrcssEnd(WorkOrderVo workOrderVo) throws Exception;
		
	//작업지시서 목록(공정별) 현공정 작업대기 업데이트
	public void workOrdPrcssWait(WorkOrderVo workOrderVo) throws Exception;
	
	//작업지시서 목록(공정별) 현공정 작업시작
	public void workOrdPrcssStart(WorkOrderVo workOrderVo) throws Exception;
	
	//작업지시서 목록(공정별) 현공정 작업완료
	public void workOrdPrcssEnd(WorkOrderVo workOrderVo) throws Exception;
	
	//작업지시서 목록(공정별) 현공정 작업 실적 등록
	public void workOrdPrcssResultSave(WorkOrderVo workOrderVo) throws Exception;
	
	//작업지시서 목록(공정별) 현공정 작업 실적 수정
	public void workOrdPrcssResultUpd(WorkOrderVo workOrderVo) throws Exception;
	
	//작업지시서 목록(공정별) 현공정 작업 실적 삭제
	public void workOrdPrcssResultDel(WorkOrderVo workOrderVo) throws Exception;

	//작업지시서 목록(공정별) - 전공정 작업 완료 체크 
	public WorkOrderVo checkWorkOrdPrcssFinish(WorkOrderVo workOrderVo) throws Exception;

	//작업지시서 목록(공정별) - 다음공정 조회
	public WorkOrderVo workOrdNextPrcssSel(WorkOrderVo workOrderVo) throws Exception;
	
	//**********************************생산실적**********************************
	//생산실적 목록(공정별) 조회
	public List<WorkOrderVo> workOrdResultListByPrcss(WorkOrderVo workOrderVo) throws Exception;
	
	//생산실적 목록(작지별) 조회
	public List<WorkOrderVo> workOrdResultListByWorkOrdIdx(WorkOrderVo workOrderVo) throws Exception;
	
	//생산실적 작업지시 출고창고(수불발생해야할 창고) 목록 조회
	public WorkOrderVo workOrdOutMatrlLocationList(WorkOrderVo workOrderVo) throws Exception;
	
	//생산실적 작업지시 QC창고(수불발생해야할 창고) 목록 조회
	public WorkOrderVo workInProdLocationList(WorkOrderVo workOrderVo) throws Exception;
	
	//생산실적 작업지시 투입자재(수불발생해야할 자재) 목록 조회
	public List<WorkOrderVo> workOrdInMatrlList(WorkOrderVo workOrderVo) throws Exception;
	
	//생산실적 품질 테이블 데이터 INSERT
	public void workOrdPrcssResultQualityInsert(WorkOrderVo workOrderVo) throws Exception;
	
	//생산실적 품질 승인 목록 조회
	public WorkOrderVo workOrdPrcssResultQualityCheckByWorkOrdPrcssIdx(WorkOrderVo workOrderVo) throws Exception;
	
	//생산실적 품질 상태 조회
	public WorkOrderVo workOrdPrcssResultQualitySelByWorkOrdPrcssIdx(WorkOrderVo workOrderVo) throws Exception;
	
	//번들링 정보 조회
	public List<WorkOrderVo> workOrdBundleList(WorkOrderVo workOrderVo) throws Exception;
	
	//번들링 실적 저장시 - 해당 수주들의 마지막 공정의 실적
	public List<WorkOrderVo> bundleEndPrcssWorkResultList(WorkOrderVo workOrderVo) throws Exception;
	
	//번들링 실적 삭제시 - HIST기록 조회
	public List<WorkOrderVo> bundleWorkResultHistSel(WorkOrderVo workOrderVo) throws Exception;
	
	//번들링 - 실적 수정 및 hist insert
	public void workResultUpdAndHistIns(WorkOrderVo workOrderVo) throws Exception;
	
	//번들링 실적 저장시 - 해당 수주들의 생산실적 수불리스트( 제품입고, 제품검사까지만 )
	public List<WorkOrderVo> bundleBizOrdStockList(WorkOrderVo workOrderVo) throws Exception;
	
	//공정식별자로 해당 공정의 작업자 리스트
	public List<WorkOrderVo> prcssWorkerLstByPrcssIdx(WorkOrderVo workOrderVo) throws Exception;
}
