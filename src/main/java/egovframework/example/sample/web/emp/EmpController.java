package egovframework.example.sample.web.emp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.example.sample.service.SampleDefaultVO;
import egovframework.example.sample.service.emp.EmpService;
import egovframework.example.sample.service.emp.EmpVO;
import egovframework.example.sample.service.paging.Paging;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

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
	public String empList(EmpVO empVO) throws Exception {
		System.out.println("[직원 리스트]");

		return "/useLayout/emp/empList";
	}

	@ResponseBody
	@RequestMapping(value = "/empList.json")
     public Map<String, Object> empListJson(@RequestBody EmpVO empVO) throws Exception {

		int totCnt = empService.selectEmpListTotCnt(empVO);

		empVO.setPageUnit(propertiesService.getInt("pageUnit"));
		empVO.setPageSize(propertiesService.getInt("pageSize"));

		Paging paging = new Paging();
		paging.setCurrentPageNo(empVO.getPageIndex());
		paging.setRecordCountPerPage(empVO.getPageUnit());
		paging.setPageSize(empVO.getPageSize());
		paging.setPageCount((int)Math.ceil(totCnt/10.0));

		empVO.setFirstIndex(paging.getFirstRecordIndex());
		empVO.setLastIndex(paging.getLastRecordIndex());
		empVO.setRecordCountPerPage(paging.getRecordCountPerPage());

		List<EgovMap> empList = empService.selectEmpList(empVO);

		Map<String, Object> arrayMap = new HashMap<>();
		arrayMap.put("pages", paging);
		arrayMap.put("dataList", empList);
		arrayMap.put("datacnt", totCnt);

		return arrayMap;


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
	public String empRegister(EmpVO empVO) throws Exception {
		System.out.println("[직원/관리자 등록]");

		return "/useLayout/emp/empRegister";
	}

	@ResponseBody
	@RequestMapping(value = "/empRegister.json")
     public Map<String, Object> empRegisterJson(@RequestBody EmpVO empVO) throws Exception {
		empVO.setFileId("File"+empVO.getEmpId());
		empService.insertEmp(empVO);

		Map<String, Object> arrayMap = new HashMap<>();
		arrayMap.put("fileId", empVO.getFileId());

		return arrayMap;
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
	public String empView(EmpVO empVO, Model model) throws Exception {
		System.out.println("[직원 상세화면 페이지]");

		model.addAttribute("result", empService.selectEmp(empVO));

		return "/useLayout/emp/empView";
	}

	/**
	 * 직원 수정 View
	 *
	 * @param empId
	 * @param searchVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/empEdit.do")
	public String empEdit(EmpVO empVO, Model model) throws Exception {
		System.out.println("[직원 수정화면]");

		model.addAttribute("result", empService.selectEmp(empVO));

		return "/useLayout/emp/empEdit";
	}

	@ResponseBody
	@RequestMapping(value = "/empEdit.json")
     public Map<String, Object> empEditJson(@RequestBody EmpVO searchVO) throws Exception {

		searchVO.setFileId("File"+searchVO.getEmpId());
		empService.updateEmp(searchVO);
		Map<String, Object> arrayMap = new HashMap<>();
		arrayMap.put("fileId", searchVO.getFileId());

		return arrayMap;
	}


	/**
	 * 직원 삭제
	 *
	 * @param empId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/deleteEmp.do")
	public String deleteEmp(EmpVO sampleVO) throws Exception {
		System.out.println("[직원 삭제 기능]");
		empService.deleteEmp(sampleVO);

		return "forward:/empList.do";
	}

	/**
	 * 관리자 회원가입
	 * @param searchVO
	 * @param snKey
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/addAdmin.do", method = RequestMethod.POST)
	public String addAdmin(EmpVO empVO) throws Exception {
		System.out.println("[관리자 등록 기능]");
		empVO.setFileId("File"+empVO.getEmpId());
		empService.insertEmp(empVO);

		return "login/login";
	}

	/**
	 * 시리얼 키 확인 (관리자 회원가입용)
	 * @param map
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/addAdminCheck.json")
     public HashMap<String, Object> snKeyCheck(@RequestBody HashMap<String, Object> map) throws Exception {
		System.out.println("[시리얼 키 확인]");
		String result = empService.snKeyCheck((String) map.get("snKey"));

		if(result != null) {
			map.put("result", "true");
		} else {
			map.put("result", "false");
		}

		return map;
	}

	/**
	 * 아이디 중복 확인
	 * @param searchVO
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/IdChecking.json")
     public Map<String, Object> IdChecking(@RequestBody EmpVO searchVO) throws Exception {
		System.out.println("[아이디 중복 확인]");

		EmpVO empLoginVO = empService.selectEmp(searchVO);
		Map<String, Object> map = new HashMap<>();

		if(empLoginVO != null) {
			map.put("result", "false");
		} else {
			map.put("result", "true");
		}
		return map;
	}

}
