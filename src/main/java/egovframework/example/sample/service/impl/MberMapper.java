/*
 * Copyright 2011 MOPAS(Ministry of Public Administration and Security).
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package egovframework.example.sample.service.impl;

import java.util.List;

import egovframework.example.sample.service.MberVO;
import egovframework.example.sample.service.SampleDefaultVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

/**
 * sample에 관한 데이터처리 매퍼 클래스
 *
 * @author  표준프레임워크센터
 * @since 2014.01.24
 * @version 1.0
 * @see <pre>
 *  == 개정이력(Modification Information) ==
 *
 *          수정일          수정자           수정내용
 *  ----------------    ------------    ---------------------------
 *   2014.01.24        표준프레임워크센터          최초 생성
 *
 * </pre>
 */
public interface MberMapper {

	/*
	 * 2020.06.12 - 이병준
	 * Mapper
	 *  : 매핑 파일에 기재된 SQL을 호출하기 위한 인터페이스이다.
	 *  : 패키지 이름+"."+인터페이스이름+"."+메서드이름이 네임스페이스+"."+SQL의 ID
	 *  : SQL ID에는 매핑하는 메서드 이름을 지정하는 것이다.
	 *  : + 메소드 명은 네임스페이스 ID랑 맞춰야 한다.
	 *  
	 *  참고 링크 : https://bigstupid.tistory.com/23
	 */

	/**
	 * 고객 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
	List<?> selectMberList(MberVO searchVO) throws Exception;

	/**
	 * 고객 총 수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 총 갯수
	 * @exception
	 */
	int selectMberListTotCnt(MberVO searchVO);
	
	/**
	 * 고객 등록
	 * @param vo - 등록할 정보가 담긴 SampleVO
	 * @return 등록 결과
	 * @exception Exception
	 */
	void insertMber(MberVO vo) throws Exception;
	
	/**
	 * 고객 상세보기
	 * @param searchVO
	 * @return
	 * @throws Exception
	 */
	MberVO selectMber(MberVO searchVO) throws Exception;

	/**
	 * 고객 삭제
	 * @param vo
	 * @throws Exception
	 */
	void deleteMber(MberVO vo) throws Exception;
	
	/**
	 * 고객 수정
	 * @param vo
	 * @throws Exception
	 */
	void updateMber(MberVO vo) throws Exception;

}
