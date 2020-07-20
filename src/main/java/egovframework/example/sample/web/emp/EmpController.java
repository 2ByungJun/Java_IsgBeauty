package egovframework.example.sample.web.emp;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.example.sample.service.SampleDefaultVO;
import egovframework.example.sample.service.emp.EmpService;
import egovframework.example.sample.service.emp.EmpVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class EmpController {
	
	/** empService */
	@Resource(name = "empService")
	private EmpService empService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	/**
	 * 직원 View
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
		
		return "emp/empList";
	}


	/**
	 * 직원 등록 View
	 *
	 * @param searchVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/empRegister.do")
	public String empRegister(@ModelAttribute("searchVO") EmpVO searchVO, ModelMap model) throws Exception {
		System.out.println("[직원/관리자 등록]");

		return "emp/empRegister";
	}

	/**
	 * 직원 상세화면 View
	 * 
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
		model.addAttribute("result", selectEmp(sampleVO, searchVO));
		
		return "emp/empView";
	}

	/**
	 * 고객 수정 View
	 * 
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
		model.addAttribute("result", selectEmp(sampleVO, searchVO));
		
		return "emp/empEdit";
	}

	/**
	 * 직원 등록
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
	 * 직원 조회
	 * 
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
	 * 직원 수정
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
	 * 직원 삭제
	 * 
	 * @param empId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/deleteEmp.do")
	public String deleteEmp(@RequestParam("selectedId") String empId) throws Exception {
		System.out.println("[직원 삭제 기능]");

		EmpVO sampleVO = new EmpVO();
		sampleVO.setEmpId(empId);
		empService.deleteEmp(sampleVO);
		
		return "forward:/empList.do";
	}
}
