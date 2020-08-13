package egovframework.example.sample.service.mber;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.example.sample.service.SampleDefaultVO;
import egovframework.example.sample.service.emp.EmpVO;
import egovframework.example.sample.service.mber.impl.MberMapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class MberService {

	@Autowired
    private MberMapper mapper;

	/**
	 * 고객 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
	public List<EgovMap> selectMberList(SampleDefaultVO vo) throws Exception {
		 return mapper.selectMberList(vo);
	}

	/**
	 * 고객 총 수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 총 갯수
	 * @exception
	 */
	public int selectMberListTotCnt(SampleDefaultVO vo) throws Exception {
		 return mapper.selectMberListTotCnt(vo);
	}

	/**
	 * 고객 등록
	 * @param vo
	 * @throws Exception
	 */
	public void insertMber(MberVO vo) throws Exception {
		mapper.insertMber(vo);
	}

	/**
	 * 고객 조회
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public MberVO selectMber(MberVO vo) throws Exception {
		return mapper.selectMber(vo);
	}

	/**
	 * 고객 삭제
	 * @param vo
	 * @throws Exception
	 */
	public void deleteMber(MberVO vo) throws Exception {
		mapper.deleteMber(vo);
	}

	/**
	 * 고객 수정
	 * @param vo
	 * @throws Exception
	 */
	public void updateMber(MberVO vo) throws Exception {
		mapper.updateMber(vo);
	}

	public List<?> selectListMberNM() throws Exception {
		 return mapper.selectListMberNM();
	}
}
