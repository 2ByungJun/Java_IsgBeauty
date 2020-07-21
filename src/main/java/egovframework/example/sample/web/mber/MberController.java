package egovframework.example.sample.web.mber;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import egovframework.example.sample.service.mber.MberService;
import egovframework.example.sample.service.mber.MberVO;
import egovframework.example.sample.service.paging.Paging;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class MberController {

	/** mberService */
	@Resource(name = "mberService")
	private MberService mberService;

	/** empService */
	@Resource(name = "empService")
	private EmpService empService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/**
	 * 고객 View
	 *
	 * @param mberVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mberList.do")
	public String mberList(@ModelAttribute("searchVO") SampleDefaultVO searchVO, ModelMap model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		System.out.println("[고객 리스트]");

		/*HttpSession session = request.getSession();

		String str = (String) session.getAttribute("empId");

		if(str == null) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('로그인 후 이용하실 수 있습니다.'); location.href='login.do';</script>");
			out.flush();
		}*/

		return "mber/mberList";
	}

	/**
	 * 고객 등록 View
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

		return "mber/mberRegister";
	}

	/**
	 * 고객 상세화면 View
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

		return "mber/mberView";
	}

	/**
	 * 고객 수정화면 View
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
		model.addAttribute("result", selectMber(sampleVO, searchVO));

		List<?> listEmpNM = empService.selectListEmpNM(searchVO);
		model.addAttribute("listEmpNM", listEmpNM);

		return "mber/mberEdit";
	}

	/**
	 * (Ajax)고객 List
	 *
	 * @param searchVO
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/mberList.json")
     public Map<String, Object> mberListJson(@RequestBody MberVO searchVO,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println(searchVO.getSearchKeyword()+"_______________test");

		int totCnt = mberService.selectMberListTotCnt(searchVO);

		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		Paging paging = new Paging();
		paging.setCurrentPageNo(searchVO.getPageIndex());
		paging.setRecordCountPerPage(searchVO.getPageUnit());
		paging.setPageSize(searchVO.getPageSize());
		paging.setPageCount((totCnt/10)+1);

		searchVO.setFirstIndex(paging.getFirstRecordIndex());
		searchVO.setLastIndex(paging.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paging.getRecordCountPerPage());

		List<EgovMap> mberList = mberService.selectMberList(searchVO);

		Map<String, Object> arrayMap = new HashMap<>();
		arrayMap.put("pages", paging);
		arrayMap.put("dataList", mberList);
		arrayMap.put("datacnt", totCnt);

		return arrayMap;

	}

	/**
	 * 고객 등록
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
	 * 고객 조회
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
	 * 고객 수정
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
	 * 고객 삭제
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

}
