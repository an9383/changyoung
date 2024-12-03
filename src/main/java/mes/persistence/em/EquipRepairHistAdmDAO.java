package mes.persistence.em;

import java.util.List;

import mes.domain.em.EquipInfoVo;
import mes.domain.em.EquipRepairHistAdmVo;

public interface EquipRepairHistAdmDAO {

	//설비수리이력 목록조회
	public List<EquipRepairHistAdmVo> equipRepairHistAdmListAll(EquipRepairHistAdmVo equipRepairHistAdmVo) throws Exception;
	
	//설비수리이력 상세조회
	public EquipRepairHistAdmVo equipRepairHistAdmSel(EquipRepairHistAdmVo equipRepairHistAdmVo) throws Exception;
	
	//설비수리이력 등록
	public void equipRepairHistAdmInsert(EquipRepairHistAdmVo equipRepairHistAdmVo) throws Exception;
	
	//설비수리이력 수정
	public void equipRepairHistAdmUpdate(EquipRepairHistAdmVo equipRepairHistAdmVo) throws Exception;
	
	//설비수리이력 삭제
	public void equipRepairHistAdmDelete(EquipRepairHistAdmVo equipRepairHistAdmVo) throws Exception;

	//설비관리대장 조회
	public List<EquipRepairHistAdmVo> equipRepairHistAdmStatusLst(EquipRepairHistAdmVo equipRepairHistAdmVo) throws Exception;
}
