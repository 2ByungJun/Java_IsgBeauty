/*
 * Copyright 2008-2009 the original author or authors.
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
package egovframework.example.sample.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.example.sample.service.impl.EmpMapper;
import egovframework.example.sample.service.impl.MberMapper;

/**
 * @Class Name : EgovSampleService.java
 * @Description : EgovSampleService Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2009.03.16           최초생성
 *
 * @author 개발프레임웍크 실행환경 개발팀
 * @since 2009. 03.16
 * @version 1.0
 * @see
 *
 *  Copyright (C) by MOPAS All right reserved.
 */

@Service
public class EmpService {

	@Autowired
    private EmpMapper mapper;

	/**
	 * 고객 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
	public List selectEmpList(EmpVO vo) throws Exception {
		 return mapper.selectEmpList(vo);
	}

	/**
	 * 고객 총 수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 총 갯수
	 * @exception
	 */
	public int selectEmpListTotCnt(EmpVO vo) throws Exception {
		 return mapper.selectEmpListTotCnt(vo);
	}
	
	/**
	 * 직원 등록
	 * @param vo
	 * @throws Exception
	 */
	public void insertEmp(EmpVO vo) throws Exception {
		mapper.insertEmp(vo);
	}
	
	/**
	 * 직원 조회
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public EmpVO selectEmp(EmpVO vo) throws Exception {
		return mapper.selectEmp(vo);
	}
	
	/**
	 * 직원 삭제
	 * @param vo
	 * @throws Exception
	 */
	public void deleteEmp(EmpVO vo) throws Exception {
		mapper.deleteEmp(vo);
	}

}
