package egovframework.example.sample.web.mber;

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
	public String mberList(MberVO mberVO) throws Exception {
		System.out.println("[고객 리스트]");

		return "/useLayout/mber/mberList";
	}

	/**
	 * 고객 listData
	 *
	 * @param searchVO
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/mberList.json")
     public Map<String, Object> mberListJson(@RequestBody MberVO mberVO) throws Exception {

		int totCnt = mberService.selectMberListTotCnt(mberVO);

		mberVO.setPageUnit(propertiesService.getInt("pageUnit"));
		mberVO.setPageSize(propertiesService.getInt("pageSize"));

		Paging paging = new Paging();
		paging.setCurrentPageNo(mberVO.getPageIndex());
		paging.setRecordCountPerPage(mberVO.getPageUnit());
		paging.setPageSize(mberVO.getPageSize());
		paging.setPageCount((int)Math.ceil(totCnt/10.0));

		mberVO.setFirstIndex(paging.getFirstRecordIndex());
		mberVO.setLastIndex(paging.getLastRecordIndex());
		mberVO.setRecordCountPerPage(paging.getRecordCountPerPage());

		List<EgovMap> mberList = mberService.selectMberList(mberVO);

		Map<String, Object> arrayMap = new HashMap<>();
		arrayMap.put("pages", paging);
		arrayMap.put("dataList", mberList);
		arrayMap.put("datacnt", totCnt);

		return arrayMap;

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
	public String mberRegister(ModelMap model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		System.out.println("[고객 등록 페이지]");

		model.addAttribute("listEmpNM",  empService.selectListEmpNM());

		HttpSession session = request.getSession();
		model.addAttribute("registId", session.getAttribute("empId"));


		return "/useLayout/mber/mberRegister";
	}

	/**
	 * 고객 등록
	 *
	 * @param searchVO
	 * @param sampleVO
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/mberRegister.json", method = RequestMethod.POST)
	public Map<String, Object> mberRegisterJson(@RequestBody MberVO mberVO) throws Exception {
		System.out.println("[고객 등록]");

		mberService.insertMber(mberVO);

		Map<String, Object> arrayMap = new HashMap<>();
		arrayMap.put("result", "success");

		return arrayMap;
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
	public String mberView(MberVO mberVO, Model model) throws Exception {
		System.out.println("[고객 상세화면]");

		model.addAttribute("result", mberService.selectMber(mberVO));

		return "/useLayout/mber/mberView";
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
	public String mberEdit(MberVO mberVO, Model model) throws Exception {
		System.out.println("[고객 수정화면]");

		model.addAttribute("result", mberService.selectMber(mberVO));
		model.addAttribute("listEmpNM", empService.selectListEmpNM());

		return "/useLayout/mber/mberEdit";
	}

	/**
	 * 고객 수정
	 * @return "forward:/mberList.do"
	 * @exception Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/mberEdit.json", method = RequestMethod.POST)
	public Map<String, Object> mberEditJson(@RequestBody MberVO mberVO, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("[고객 수정 기능]");

		mberVO.setUpdtId((String) request.getAttribute("empId"));
		mberService.updateMber(mberVO);
		Map<String, Object> arrayMap = new HashMap<>();
		arrayMap.put("result", mberVO.getMberSn() );

		return arrayMap;
	}

	/**
	 * 고객 삭제
	 * @return "forward:/mberList.do"
	 * @exception Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/mberDelete.json", method = RequestMethod.POST)
	public  Map<String, Object> mberDelete(@RequestBody MberVO mberVO) throws Exception {
		System.out.println("[고객 삭제 기능]");

		Map<String, Object> arrayMap = new HashMap<>();
		arrayMap.put("delete", "success" );
		mberService.deleteMber(mberVO);

		return arrayMap;
	}

}
