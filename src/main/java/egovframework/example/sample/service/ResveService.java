package egovframework.example.sample.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import egovframework.example.sample.service.impl.ResveMapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class ResveService {

	@Autowired
    private ResveMapper mapper;

	/**
	 * 고객 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
	public List<EgovMap> selectResveList(SampleDefaultVO vo) throws Exception {
		 return mapper.selectResveList(vo);
	}

	/**
	 * 고객 총 수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 총 갯수
	 * @exception
	 */
	public int selectResveListTotCnt(SampleDefaultVO vo) throws Exception {
		 return mapper.selectResveListTotCnt(vo);
	}

	/**
	 * 고객 등록
	 * @param vo
	 * @throws Exception
	 */
	public void insertResve(ResveVO vo) throws Exception {
		mapper.insertResve(vo);
	}

	/**
	 * 고객 조회
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public ResveVO selectResve(ResveVO vo) throws Exception {
		return mapper.selectResve(vo);
	}

	/**
	 * 고객 삭제
	 * @param vo
	 * @throws Exception
	 */
	public void deleteResve(ResveVO vo) throws Exception {
		mapper.deleteResve(vo);
	}

	/**
	 * 고객 수정
	 * @param vo
	 * @throws Exception
	 */
	public void updateResve(ResveVO vo) throws Exception {
		mapper.updateResve(vo);
	}

}
