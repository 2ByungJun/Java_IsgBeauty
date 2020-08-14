package egovframework.example.sample.service.emp.impl;

import java.util.List;

import egovframework.example.sample.service.SampleDefaultVO;
import egovframework.example.sample.service.emp.EmpVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
 * 직원(emp)에 관한 데이터처리 매퍼 클래스
 *
 * @author  BS실 이병준, 이수호
 * @since 2020.06
 */
public interface EmpMapper {

	/**
	 * 직원 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
	List<EgovMap> selectEmpList(SampleDefaultVO searchVO) throws Exception;

	/**
	 * 직원 총 수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 총 갯수
	 * @exception
	 */
	int selectEmpListTotCnt(SampleDefaultVO searchVO);

	/**
	 * 직원을 등록한다.
	 * @param vo - 등록할 정보가 담긴 SampleVO
	 * @return 등록 결과
	 * @exception Exception
	 */
	void insertEmp(EmpVO vo) throws Exception;

	/**
	 * 직원 상세보기
	 * @param searchVO
	 * @return
	 * @throws Exception
	 */
	EmpVO selectEmp(EmpVO searchVO) throws Exception;

	/**
	 * 직원 삭제
	 * @param vo
	 * @throws Exception
	 */
	void deleteEmp(EmpVO vo) throws Exception;

	/**
	 * 직원 수정
	 * @param vo
	 * @throws Exception
	 */
	void updateEmp(EmpVO vo) throws Exception;


	/**
	 * 직원 "디자이너" 이름리스트
	 * @param vo
	 * @throws Exception
	 */
	List<?> selectListEmpNM() throws Exception;


	/**
	 * 시리얼 키 확인(관리자 회원가입용)
	 * @param snKey
	 * @throws Exception
	 */
	String snKeyCheck(String snKey) throws Exception;
}
