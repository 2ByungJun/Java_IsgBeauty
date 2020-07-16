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
package egovframework.example.sample.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.json.JsonObject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.example.sample.service.EmpService;
import egovframework.example.sample.service.EmpVO;
import egovframework.example.sample.service.MberService;
import egovframework.example.sample.service.MberVO;
import egovframework.example.sample.service.Paging;
import egovframework.example.sample.service.ResveService;
import egovframework.example.sample.service.ResveVO;
import egovframework.example.sample.service.SampleDefaultVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import net.sf.json.JSONObject;

/**
 * @Class Name : EgovSampleController.java
 * @Description : EgovSample Controller Class
 * @Modification Information
 * @ @ 수정일 수정자 수정내용 @ --------- --------- ------------------------------- @
 *   2009.03.16 최초생성
 *
 * @author 개발프레임웍크 실행환경 개발팀
 * @since 2009. 03.16
 * @version 1.0
 * @see
 *
 * 		Copyright (C) by MOPAS All right reserved.
 */

@Controller
public class IsgBeautyController {

	/** mberService */
	@Resource(name = "mberService")
	private MberService mberService;

	/** mberService */
	@Resource(name = "empService")
	private EmpService empService;

	/** resveService */
	@Resource(name = "resveService")
	private ResveService resveService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;

	/**
	 * 로그인 페이지
	 *
	 * @param mberVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/login.do")
	public String login(){
		System.out.println("[로그인]");

		return "sample/login";
	}

/*	@RequestMapping(value= "/loginCheck.do")
	public ModelAndView loginCheck(@ModelAttribute MberVO vo, HttpSession session) {

		boolean result = empService.loginCheck(vo, session);
		ModelAndView mav = new ModelAndView();

		mav.setViewName("login");

		if(result) {
			mav.addObject("msg", "성공");
		}else {
			mav.addObject("msg", "실패");
		}

		return mav;
	}

	@RequestMapping(value= "/logout.do")
	public ModelAndView loginout(HttpSession session) {

		empService.logout(session);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("login");
		mav.addObject("msg", "logout");

		return mav;
	}*/



	/**
	 * 로그인-직원 등록 페이지
	 *
	 * @param searchVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/loginEmpRegister.do")
	public String loginEmpRegister(@ModelAttribute("searchVO") EmpVO searchVO, ModelMap model) throws Exception {
		System.out.println("[회원가입]");

		return "sample/loginEmpRegister";
	}

	/**
	 * 고객 리스트
	 *
	 * @param mberVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mberList.do")
	public String mberList(@ModelAttribute("searchVO") SampleDefaultVO searchVO, ModelMap model) throws Exception {
		System.out.println("[고객 리스트]");

		/** EgovPropertyService.sample */
		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<?> mberList = mberService.selectMberList(searchVO);
		model.addAttribute("mberList", mberList);

		int totCnt = mberService.selectMberListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		return "sample/mberList";
	}


	@ResponseBody
	@RequestMapping(value = "/mberList.json")
	public void mberListJson(@ModelAttribute("searchVO") SampleDefaultVO searchVO, ModelMap model,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("json@@@@@@@@@@@@@@@@@@@@@@@");

		List<egovMap> mberList = mberService.selectMberList(searchVO);

		int totCnt = mberService.selectMberListTotCnt(searchVO);

		Paging paging = new Paging();

		paging.setPageCount((mberService.selectMberListTotCnt(searchVO)/10)+1);
		paging.setPageNo(searchVO.getPageIndex());

		Map<String, Object> arrayMap = new HashMap<>();
		arrayMap.put("pages", paging);
		arrayMap.put("dataList", mberList);
		arrayMap.put("datacnt", totcnt);


	}

	/**
	 * 직원 리스트
	 *
	 * @param searchVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/empList.do")
	public String empList(@ModelAttribute("searchVO") SampleDefaultVO searchVO, ModelMap model) throws Exception {
		System.out.println("[직원 리스트]");

		/** EgovPropertyService.sample */
		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<?> sampleList = empService.selectEmpList(searchVO);
		model.addAttribute("resultList", sampleList);

		int totCnt = empService.selectEmpListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		System.out.println("_----------" + totCnt);
		return "sample/empList";
	}

	/**
	 * 고객 등록 페이지
	 *
	 * @param searchVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mberRegister.do")
	public String mberRegister(@ModelAttribute("searchVO") EmpVO searchVO, ModelMap model) throws Exception {
		System.out.println("[고객 등록 페이지]");

		List<?> listEmpNM = empService.selectListEmpNM(searchVO);
		model.addAttribute("listEmpNM", listEmpNM);

		return "sample/mberRegister";
	}

	/**
	 * 고객 등록 기능
	 *
	 * @param searchVO
	 * @param sampleVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/addMber.do", method = RequestMethod.POST)
	public String addMber(@ModelAttribute("searchVO") MberVO searchVO, MberVO sampleVO) throws Exception {
		System.out.println("[고객 등록]");

		mberService.insertMber(sampleVO);
		return "forward:/mberList.do";
	}

	/**
	 * 고객 상세화면 페이지
	 * @param mberSn
	 * @param searchVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/mberView.do")
	public String mberView(@RequestParam("selectedId") String mberSn,
			@ModelAttribute("searchVO") SampleDefaultVO searchVO, Model model) throws Exception {
		System.out.println("[고객 상세화면]");

		MberVO sampleVO = new MberVO();
		sampleVO.setMberSn(mberSn);
		// 변수명은 CoC 에 따라 sampleVO
		model.addAttribute("result", selectMber(sampleVO, searchVO));

		return "sample/mberView";
	}

	/**
	 * 고객 수정화면 페이지
	 * @param mberSn
	 * @param searchVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/mberEdit.do")
	public String mberEdit(@RequestParam("selectedId") String mberSn,
			@ModelAttribute("searchVO") EmpVO searchVO, Model model) throws Exception {
		System.out.println("[고객 수정화면]");

		MberVO sampleVO = new MberVO();
		sampleVO.setMberSn(mberSn);
		// 변수명은 CoC 에 따라 sampleVO
		model.addAttribute("result", selectMber(sampleVO, searchVO));

		List<?> listEmpNM = empService.selectListEmpNM(searchVO);
		model.addAttribute("listEmpNM", listEmpNM);

		return "sample/mberEdit";
	}

	/**
	 * 고객 조회 기능
	 * @param sampleVO
	 * @param searchVO
	 * @return
	 * @throws Exception
	 */
	public MberVO selectMber(MberVO sampleVO, @ModelAttribute("searchVO") SampleDefaultVO searchVO) throws Exception {
		System.out.println("[고객 조회 기능]");
		return mberService.selectMber(sampleVO);
	}


	/**
	 * 고객 삭제 기능
	 * @return "forward:/mberList.do"
	 * @exception Exception
	 */
	@RequestMapping("/deleteMber.do")
	public String deleteMber(@RequestParam("selectedId") String mberSn) throws Exception {
		System.out.println("[고객 삭제 기능]");

		MberVO sampleVO = new MberVO();
		sampleVO.setMberSn(mberSn);
		mberService.deleteMber(sampleVO);
		return "forward:/mberList.do";
	}

	/**
	 * 고객 수정 기능
	 * @return "forward:/mberList.do"
	 * @exception Exception
	 */

	@RequestMapping(value = "/updateMber.do", method = RequestMethod.POST)
	public String updateMber(@ModelAttribute("mberVO") MberVO sampleVO) throws Exception {
		System.out.println("[고객 수정 기능]");

		mberService.updateMber(sampleVO);
		return "forward:/mberList.do";
	}

	/**
	 * 직원 등록 페이지
	 *
	 * @param searchVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/empRegister.do")
	public String empRegister(@ModelAttribute("searchVO") EmpVO searchVO, ModelMap model) throws Exception {
		System.out.println("[직원/관리자 등록]");

		return "sample/empRegister";
	}

	/**
	 * 직원 등록 기능
	 *
	 * @param searchVO
	 * @param sampleVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/addEmp.do", method = RequestMethod.POST)
	public String addEmp(@ModelAttribute("searchVO") EmpVO searchVO, EmpVO sampleVO) throws Exception {
		System.out.println("[직원 등록 기능]");
		empService.insertEmp(sampleVO);
		return "forward:/empList.do";
	}

	/**
	 * 직원 상세화면 페이지
	 * @param empId
	 * @param searchVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/empView.do")
	public String empView(@RequestParam("selectedId") String empId,
			@ModelAttribute("searchVO") SampleDefaultVO searchVO, Model model) throws Exception {
		System.out.println("[직원 상세화면 페이지]");
		EmpVO sampleVO = new EmpVO();
		sampleVO.setEmpId(empId);

		// 변수명은 CoC 에 따라 sampleVO
		model.addAttribute("result", selectEmp(sampleVO, searchVO));
		return "sample/empView";
	}


	/**
	 * 직원 조회 기능
	 * @param sampleVO
	 * @param searchVO
	 * @return
	 * @throws Exception
	 */
	public EmpVO selectEmp(EmpVO sampleVO, @ModelAttribute("searchVO") SampleDefaultVO searchVO) throws Exception {
		System.out.println("[직원 조회 기능]");
		return empService.selectEmp(sampleVO);
	}

	/**
	 * 글 삭제기능
	 * @param empId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/deleteEmp.do")
	public String deleteEmp(@RequestParam("selectedId") String empId) throws Exception {
		System.out.println("[고객 삭제 기능]");

		EmpVO sampleVO = new EmpVO();
		sampleVO.setEmpId(empId);
		empService.deleteEmp(sampleVO);
		return "forward:/empList.do";
	}

	/**
	 * 고객 수정화면 페이지
	 * @param empId
	 * @param searchVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/empEdit.do")
	public String empEdit(@RequestParam("selectedId") String empId,
			@ModelAttribute("searchVO") SampleDefaultVO searchVO, Model model) throws Exception {
		System.out.println("[직원 수정화면]");

		EmpVO sampleVO = new EmpVO();
		sampleVO.setEmpId(empId);
		// 변수명은 CoC 에 따라 sampleVO
		model.addAttribute("result", selectEmp(sampleVO, searchVO));
		return "sample/empEdit";
	}

	/**
	 *
	 * @param sampleVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateEmp.do", method = RequestMethod.POST)
	public String updateEmp(@ModelAttribute("empVO") EmpVO sampleVO) throws Exception {
		System.out.println("[직원 수정 기능]");

		empService.updateEmp(sampleVO);
		return "forward:/empList.do";
	}


	/**
	 * 예약 등록 페이지
	 *
	 * @param searchVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/resveRegister.do")
	public String resveRegister(@RequestParam("selectedId") String mberSn, @ModelAttribute("searchVO") SampleDefaultVO searchVO, Model model) throws Exception {
		System.out.println("[예약 등록 페이지]");

		MberVO sampleVO = new MberVO();
		sampleVO.setMberSn(mberSn);
		model.addAttribute("result", selectMber(sampleVO, searchVO));

		return "sample/resveRegister";
	}

	/**
	 * 예약 등록 기능
	 *
	 * @param searchVO
	 * @param sampleVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/addResve.do", method = RequestMethod.POST)
	public String addResve(@ModelAttribute("searchVO") ResveVO searchVO) throws Exception {
		System.out.println("[예약 등록]");

		resveService.insertResve(searchVO);
		return "forward:/resveView.do";
	}

	/**
	 * 예약 뷰
	 *
	 * @return
	 */
	@RequestMapping(value = "/resveView.do")
	public String resveView(){
		System.out.println("[예약 캘린더]");

		return "sample/resveView";
	}

	/**
	 * 글 등록 화면을 조회한다.
	 *
	 * @param searchVO
	 *            - 목록 조회조건 정보가 담긴 VO
	 * @param model
	 * @return "egovSampleRegister"
	 * @exception Exception
	 */
	/*
	 * @RequestMapping(value = "/addSample.do", method = RequestMethod.GET) public
	 * String addSampleView(@ModelAttribute("searchVO") SampleDefaultVO searchVO,
	 * Model model) throws Exception { model.addAttribute("sampleVO", new
	 * SampleVO()); return "sample/egovSampleRegister"; }
	 *
	 *//**
		 * 글을 등록한다.
		 *
		 * @param sampleVO
		 *            - 등록할 정보가 담긴 VO
		 * @param searchVO
		 *            - 목록 조회조건 정보가 담긴 VO
		 * @param status
		 * @return "forward:/egovSampleList.do"
		 * @exception Exception
		 */
	/*
	 * @RequestMapping(value = "/addSample.do", method = RequestMethod.POST) public
	 * String addSample(@ModelAttribute("searchVO") SampleDefaultVO searchVO,
	 * SampleVO sampleVO, BindingResult bindingResult, Model model, SessionStatus
	 * status) throws Exception {
	 *
	 * // Server-Side Validation beanValidator.validate(sampleVO, bindingResult);
	 *
	 * if (bindingResult.hasErrors()) { model.addAttribute("sampleVO", sampleVO);
	 * return "sample/egovSampleRegister"; }
	 *
	 * sampleService.insertSample(sampleVO); status.setComplete(); return
	 * "forward:/egovSampleList.do"; }
	 *
	 *//**
		 * 글 수정화면을 조회한다.
		 *
		 * @param id
		 *            - 수정할 글 id
		 * @param searchVO
		 *            - 목록 조회조건 정보가 담긴 VO
		 * @param model
		 * @return "egovSampleRegister"
		 * @exception Exception
		 */
	/*
	 * @RequestMapping("/updateSampleView.do") public String
	 * updateSampleView(@RequestParam("selectedId") String
	 * id, @ModelAttribute("searchVO") SampleDefaultVO searchVO, Model model) throws
	 * Exception { SampleVO sampleVO = new SampleVO(); sampleVO.setId(id); // 변수명은
	 * CoC 에 따라 sampleVO model.addAttribute(selectSample(sampleVO, searchVO));
	 * return "sample/egovSampleRegister"; }
	 *
	 *//**
		 * 글을 조회한다.
		 *
		 * @param sampleVO
		 *            - 조회할 정보가 담긴 VO
		 * @param searchVO
		 *            - 목록 조회조건 정보가 담긴 VO
		 * @param status
		 * @return @ModelAttribute("sampleVO") - 조회한 정보
		 * @exception Exception
		 */
	/*
	 * public SampleVO selectSample(SampleVO sampleVO, @ModelAttribute("searchVO")
	 * SampleDefaultVO searchVO) throws Exception { return
	 * sampleService.selectSample(sampleVO); }
	 *
	 *//**
		 * 글을 수정한다.
		 *
		 * @param sampleVO
		 *            - 수정할 정보가 담긴 VO
		 * @param searchVO
		 *            - 목록 조회조건 정보가 담긴 VO
		 * @param status
		 * @return "forward:/egovSampleList.do"
		 * @exception Exception
		 */
	/*
	 * @RequestMapping("/updateSample.do") public String
	 * updateSample(@ModelAttribute("searchVO") SampleDefaultVO searchVO, SampleVO
	 * sampleVO, BindingResult bindingResult, Model model, SessionStatus status)
	 * throws Exception {
	 *
	 * beanValidator.validate(sampleVO, bindingResult);
	 *
	 * if (bindingResult.hasErrors()) { model.addAttribute("sampleVO", sampleVO);
	 * return "sample/egovSampleRegister"; }
	 *
	 * sampleService.updateSample(sampleVO); status.setComplete(); return
	 * "forward:/egovSampleList.do"; }
	 *
	 *//**
		 * 글을 삭제한다.
		 *
		 * @param sampleVO
		 *            - 삭제할 정보가 담긴 VO
		 * @param searchVO
		 *            - 목록 조회조건 정보가 담긴 VO
		 * @param status
		 * @return "forward:/egovSampleList.do"
		 * @exception Exception
		 *//*
			 * @RequestMapping("/deleteSample.do") public String deleteSample(SampleVO
			 * sampleVO, @ModelAttribute("searchVO") SampleDefaultVO searchVO, SessionStatus
			 * status) throws Exception { sampleService.deleteSample(sampleVO);
			 * status.setComplete(); return "forward:/egovSampleList.do"; }
			 */
}
