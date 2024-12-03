package mes.domain.bm;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
@Alias("WoodenInfoVo")
public class WoodenInfoVo{
	
	private String idx;
	private String workOrdResultIdx;
	private String useQty;
	private String bizOrdDtlNo;
	private String wdIdx;
	private String expendGubun;
	private String wdGubun;
	private String wdCd;
	private String wdNm;
	private String wdSize;
	private String useYn;
	private String bundleMethod;
	private String bundleMethodNm;
	private String bundleUnit;
	private String packUnit;
	private String packMethod;
	private String packMethodNm;
	private String coating;
	private String moldingContents;
	private String exEndDate;
	private String location;
	private String inputDate;
	private String baseHitQty;
	private String initHitQty;
	private String useHitQty;
	private String calHitQty;
	private String remainHitQty;
	private String wdDesc;
	private String wdUnit;
	private String wdUnitNm;
	private String regIdx;
	private String regDate;
	private String updIdx;
	private String updDate;

	private String expendGubunNm;
	private String wdGubunNm;
	private String regIdxNm;
	
	private String moldingContentsReal; //성형내용
	private String afterProcessing; //후가공
	private String afterProcessingWdUnit; //후가공호기
	private String afterProcessingWdUnitNm; //후가공호기
	private String commonDesc; 		//공통코드비고
	
	
}
