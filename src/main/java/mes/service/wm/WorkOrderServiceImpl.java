package mes.service.wm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.wm.WorkOrderVo;
import mes.persistence.wm.WorkOrderDAO;

@Service
public class WorkOrderServiceImpl implements WorkOrderService {

	@Inject
	private WorkOrderDAO dao;
	
	//작업지시서 상세 조회
	@Override
	public List<WorkOrderVo> workOrdDtlLstWithPrcssByOrdDate(WorkOrderVo workOrderVo) throws Exception {
		return dao.workOrdDtlLstWithPrcssByOrdDate(workOrderVo);
	}
	
	//작업지시서 상세 조회
	@Override
	public List<WorkOrderVo> workOrdDtlLstWithPrcssByBizDtlIdx(WorkOrderVo workOrderVo) throws Exception {
		return dao.workOrdDtlLstWithPrcssByBizDtlIdx(workOrderVo);
	}
	
	//작업지시서 목록(공정별) 조회
	@Override
	public List<WorkOrderVo> workOrdLstWithPrcssByOrdDate(WorkOrderVo workOrderVo) throws Exception {
		return dao.workOrdLstWithPrcssByOrdDate(workOrderVo);
	}
	
	//작업지시 기준 마지막 공정 정보 조회
	@Override
	public WorkOrderVo workOrdLastPrcssSel(WorkOrderVo workOrderVo) throws Exception {
		return dao.workOrdLastPrcssSel(workOrderVo);
	}
	
	//작업지시서 목록(공정별) 조회-작지기준
	@Override
	public List<WorkOrderVo> workOrdLstWithPrcssByWorkOrd(WorkOrderVo workOrderVo) throws Exception {
		return dao.workOrdLstWithPrcssByWorkOrd(workOrderVo);
	}
	
	//작업지시서 목록(공정별) 조회-수주상세식별자기준
	@Override
	public List<WorkOrderVo> workOrdLstWithPrcssByBizOrdDtlIdx(WorkOrderVo workOrderVo) throws Exception {
		return dao.workOrdLstWithPrcssByBizOrdDtlIdx(workOrderVo);
	}
	
	//작업지시서 목록(생산진행현황) 조회
	@Override
	public List<WorkOrderVo> workOrdPrcssStatusLst(WorkOrderVo workOrderVo) throws Exception {
		return dao.workOrdPrcssStatusLst(workOrderVo);
	}
	
	//작업지시서 목록(기간별생산현황) 조회
	@Override
	public List<WorkOrderVo> workOrdPrcssStatusLstOrderByDealCorp(WorkOrderVo workOrderVo) throws Exception {
		return dao.workOrdPrcssStatusLstOrderByDealCorp(workOrderVo);
	}
	
	//작업지시서 목록(기간별생산현황,지시일 오름차순) 조회
	@Override
	public List<WorkOrderVo> workOrdPrcssStatusLstOrderByworkOrdDate(WorkOrderVo workOrderVo) throws Exception {
		return dao.workOrdPrcssStatusLstOrderByworkOrdDate(workOrderVo);
	}
	
	//작업지시서 목록(공정별) 현공정 정보 조회 
	@Override
	public WorkOrderVo workOrdSelWithPrcss(WorkOrderVo workOrderVo) throws Exception {
		return dao.workOrdSelWithPrcss(workOrderVo);
	}
	
	//작업지시서 인쇄
	@Override
	public void workOrdPaperPrint(WorkOrderVo workOrderVo) throws Exception {
		dao.workOrdPaperPrint(workOrderVo);
	}
	
	//작업지시 공정 강제 완료 처리
	@Override
	public void workOrdForcedPrcssEnd(WorkOrderVo workOrderVo) throws Exception {
		dao.workOrdForcedPrcssEnd(workOrderVo);
	}
	
	//작업지시서 목록(공정별) 현공정 작업대기 업데이트
	@Override
	public void workOrdPrcssWait(WorkOrderVo workOrderVo) throws Exception {
		dao.workOrdPrcssWait(workOrderVo);
	}
	
	//작업지시서 목록(공정별) 현공정 작업시작
	@Override
	public void workOrdPrcssStart(WorkOrderVo workOrderVo) throws Exception {
		dao.workOrdPrcssStart(workOrderVo);
	}
	
	//작업지시서 목록(공정별) 현공정 작업완료
	@Override
	public void workOrdPrcssEnd(WorkOrderVo workOrderVo) throws Exception {
		dao.workOrdPrcssEnd(workOrderVo);
	}
	
	//작업지시서 목록(공정별) 현공정 작업 실적 등록
	@Override
	public void workOrdPrcssResultSave(WorkOrderVo workOrderVo) throws Exception {
		dao.workOrdPrcssResultSave(workOrderVo);
	}
	
	//작업지시서 목록(공정별) 현공정 작업 실적 수정
	@Override
	public void workOrdPrcssResultUpd(WorkOrderVo workOrderVo) throws Exception {
		dao.workOrdPrcssResultUpd(workOrderVo);
	}
		
	//작업지시서 목록(공정별) 현공정 작업 실적 삭제
	@Override
	public void workOrdPrcssResultDel(WorkOrderVo workOrderVo) throws Exception {
		dao.workOrdPrcssResultDel(workOrderVo);
	}
		
	//작업지시서 목록(공정별) - 전공정 작업 완료 체크 
	@Override
	public WorkOrderVo checkWorkOrdPrcssFinish(WorkOrderVo workOrderVo) throws Exception {
		return dao.checkWorkOrdPrcssFinish(workOrderVo);
	}
	
	//작업지시서 목록(공정별) - 다음공정 조회
	@Override
	public WorkOrderVo workOrdNextPrcssSel(WorkOrderVo workOrderVo) throws Exception {
		return dao.workOrdNextPrcssSel(workOrderVo);
	}
	
	//**********************************생산실적**********************************
	//생산실적 목록(공정별) 조회
	@Override
	public List<WorkOrderVo> workOrdResultListByPrcss(WorkOrderVo workOrderVo) throws Exception {
		return dao.workOrdResultListByPrcss(workOrderVo);
	}
	
	//생산실적 목록(작지별) 조회
	@Override
	public List<WorkOrderVo> workOrdResultListByWorkOrdIdx(WorkOrderVo workOrderVo) throws Exception {
		return dao.workOrdResultListByWorkOrdIdx(workOrderVo);
	}
	
	//생산실적 작업지시 출고창고(수불발생해야할 창고) 목록 조회
	@Override
	public WorkOrderVo workOrdOutMatrlLocationList(WorkOrderVo workOrderVo) throws Exception {
		return dao.workOrdOutMatrlLocationList(workOrderVo);
	}
	
	//생산실적 작업지시 QC창고(수불발생해야할 창고) 목록 조회
	@Override
	public WorkOrderVo workInProdLocationList(WorkOrderVo workOrderVo) throws Exception {
		return dao.workInProdLocationList(workOrderVo);
	}
	
	//생산실적 작업지시 투입자재(수불발생해야할 자재) 목록 조회
	@Override
	public List<WorkOrderVo> workOrdInMatrlList(WorkOrderVo workOrderVo) throws Exception {
		return dao.workOrdInMatrlList(workOrderVo);
	}
	
	//생산실적 품질 테이블 데이터 INSERT
	@Override
	public void workOrdPrcssResultQualityInsert(WorkOrderVo workOrderVo) throws Exception {
		dao.workOrdPrcssResultQualityInsert(workOrderVo);
	}
	
	//생산실적 품질 승인 목록 조회
	@Override
	public WorkOrderVo workOrdPrcssResultQualityCheckByWorkOrdPrcssIdx(WorkOrderVo workOrderVo) throws Exception {
		return dao.workOrdPrcssResultQualityCheckByWorkOrdPrcssIdx(workOrderVo);
	}
	
	//생산실적 품질 상태 조회
	@Override
	public WorkOrderVo workOrdPrcssResultQualitySelByWorkOrdPrcssIdx(WorkOrderVo workOrderVo) throws Exception {
		return dao.workOrdPrcssResultQualitySelByWorkOrdPrcssIdx(workOrderVo);
	}
	
	//번들링 정보 조회
	@Override
	public List<WorkOrderVo> workOrdBundleList(WorkOrderVo workOrderVo) throws Exception {
		return dao.workOrdBundleList(workOrderVo);
	}
	
	//번들링 실적 저장시 - 해당 수주들의 마지막 공정의 실적
	@Override
	public List<WorkOrderVo> bundleEndPrcssWorkResultList(WorkOrderVo workOrderVo) throws Exception {
		return dao.bundleEndPrcssWorkResultList(workOrderVo);
	}
	
	//번들링 실적 삭제시 - HIST기록 조회
	@Override
	public List<WorkOrderVo> bundleWorkResultHistSel(WorkOrderVo workOrderVo) throws Exception {
		return dao.bundleWorkResultHistSel(workOrderVo);
	}
	
	//번들링 - 실적 수정 및 hist insert
	@Override
	public void workResultUpdAndHistIns(WorkOrderVo workOrderVo) throws Exception {
		dao.workResultUpdAndHistIns(workOrderVo);
	}
	
	//번들링 실적 저장시 - 해당 수주들의 생산실적 수불리스트( 제품입고, 제품검사까지만 )
	@Override
	public List<WorkOrderVo> bundleBizOrdStockList(WorkOrderVo workOrderVo) throws Exception {
		return dao.bundleBizOrdStockList(workOrderVo);
	}
	
	//공정식별자로 해당 공정의 작업자 리스트
	@Override
	public List<WorkOrderVo> prcssWorkerLstByPrcssIdx(WorkOrderVo workOrderVo) throws Exception {
		return dao.prcssWorkerLstByPrcssIdx(workOrderVo);
	}
}
