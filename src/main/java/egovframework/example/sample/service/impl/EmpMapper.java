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

import javax.servlet.http.HttpSession;

import egovframework.example.sample.service.EmpVO;
import egovframework.example.sample.service.MberVO;
import egovframework.example.sample.service.SampleDefaultVO;

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
public interface EmpMapper {

	/**
	 * 직원 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
	List<?> selectEmpList(SampleDefaultVO searchVO) throws Exception;

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
	
/*	*//**
	 * 로그인 체크
	 * @param vo
	 * @param session
	 * @return
	 *//*
	public boolean loginCheck(EmpVO vo,HttpSession session);
		
	*//**
	 * 로그아웃
	 * @param session
	 *//*
	public void logout(HttpSession session);*/

}
