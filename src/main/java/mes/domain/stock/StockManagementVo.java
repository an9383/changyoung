package mes.domain.stock;

import lombok.Data;

@Data
public class StockManagementVo {
	private String smNo;				// 전표번호
	private String smSeq;				// 전표시퀀스
	private String smItemGubun;			// 품목구분
	private String smInGubun;			// 입고구분
	private String smOutGubun;			// 출고구분
	private String smItemIdx;			// 품목식별자
	private String smItemVersionIdx;	// 품목버전식별자
	private String smCarAssignment;		// 차량배정 코드
	private String smItemCd;			// 품목코드
	private String smPrcssCd;			// 공정코드
	private String smType;				// 수불구분	입고, 출고, 이동, 조정
	private String smType2;				// 업무구분	입고, 초기입고, 조정입고, 조정출고, 상품입고, 상품출고, 외주입고, 외주출고, 샘플출고, 정산출고, 출고, 이동출고, 이동입고, 이동출고
	private String smDate;				// 일자
	private String smQty;				// 수량
	private String smLotNo;				// LOT번호
	private String smSourceNo;			// 원천번호
	private String smStatus;			// 상태
	private String smInCorpIdx;			// 입고처
	private String smInWhsGubun;		// 입고창고 구분
	private String smInWhsIdx;			// 입고창고 식별자
	private String smInLocIdx;			// 입고위치 식별자
	private String smOutCorpIdx;		// 출고처
	private String smOutWhsGubun;		// 출고창고 구분
	private String smOutWhsIdx;			// 출고창고 식별자
	private String smOutLocIdx;			// 출고위치 식별자
	private String smInRelationNo;		// 입고관련번호
	private String smOutRelationNo;		// 출고관련번호
	private String smDesc;				// 비고
	private String smEtc1;				// 기타1
	private String smEtc2;				// 기타2
	private String smEtc3;				// 기타3

	private String smCmptQty;			//전산재고
	private String smRealQty;			//실사재고
	private String smDiffQty;			//차이수량
	private String smAppdDate;			//재고반영일자
	private String smAppdYn;			//재고반영여부
	private String smInUserIdx;			//입고 담당자식별자
}
