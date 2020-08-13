package egovframework.example.sample.web.resve;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.example.sample.service.SampleDefaultVO;
import egovframework.example.sample.service.mber.MberService;
import egovframework.example.sample.service.mber.MberVO;
import egovframework.example.sample.service.resve.ChartVO;
import egovframework.example.sample.service.resve.ResveService;
import egovframework.example.sample.service.resve.ResveVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class ResveController {

	/** mberService */
	@Resource(name = "mberService")
	private MberService mberService;

	/** resveService */
	@Resource(name = "resveService")
	private ResveService resveService;

	/**
	 * 고객-예약 등록 View
	 *
	 * @param searchVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/resveRegister.do")
	public String resveRegister(@RequestParam("selectedId") String mberSn, @ModelAttribute("searchVO") SampleDefaultVO searchVO, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("[고객-예약 등록 View]");

		MberVO sampleVO = new MberVO();
		sampleVO.setMberSn(mberSn);
		model.addAttribute("result", selectMber(sampleVO, searchVO));

		HttpSession session = request.getSession();
		model.addAttribute("empId", session.getAttribute("empId"));

		return "/useLayout/resve/resveRegister";
	}

	/**
	 * 고객-예약 등록
	 *
	 * @param searchVO
	 * @param sampleVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/addResve.do", method = RequestMethod.POST)
	public String addResve(ResveVO resveVO) throws Exception {
		System.out.println("[고객-예약 등록]");

		resveService.insertResve(resveVO);

		return "redirect:/resveView.do";
	}

	/**
	 * CalendarView
	 *
	 * @return
	 */
	@RequestMapping(value = "/resveView.do")
	public String resveView(){
		System.out.println("[예약 캘린더]");

		return "/useLayout/resve/resveView";
	}

	/**
	 * CalendarViewData
	 *
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/resveView.json", method = RequestMethod.POST)
	public HashMap<String, Object> init(@RequestBody HashMap<String, Object> map) throws Exception{
		System.out.println("[예약 캘린더]");

		List<?> resveList = resveService.selectResveList();
		map.put("resveList", resveList);

		return map;
	}

    /**
	 * 예약 수정 View
	 *
	 * @return
     * @throws Exception
	 */
	@RequestMapping("/resveEdit.do")
	public String resveEdit(ResveVO resveVO, Model model) throws Exception {
		System.out.println("[예약 수정화면]");

		model.addAttribute("result", resveService.selectResve(resveVO));

		return "/useLayout/resve/resveEdit";
	}

	/**
	 * 예약 수정
	 *
	 * @return "forward:/resveView.do"
	 * @exception Exception
	 */

	@RequestMapping(value = "/updateResve.do", method = RequestMethod.POST)
	public String updateResve(ResveVO resveVO) throws Exception {
		System.out.println("[예약 수정 기능]");

		resveService.updateResve(resveVO);

		return "redirect:/resveView.do";
	}

	/**
	 * 예약 삭제
	 *
	 * @return "forward:/resveView.do"
	 * @exception Exception
	 */
	@RequestMapping(value = "/deleteResve.do")
	public String deleteResve(ResveVO resveVO) throws Exception {
		System.out.println("[예약 삭제 기능]");

		resveService.deleteResve(resveVO);

		return "redirect:/resveView.do";
	}

	/**
	 * CalendarAddView
	 *
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/resveViewRegister.do")
	public String resveViewRegister(@ModelAttribute("resveVO") ResveVO resveVO, Model model) throws Exception{
		System.out.println("[캘린더 등록 View]");

		model.addAttribute("listMberNM",  mberService.selectListMberNM());

		return "/useLayout/resve/resveViewRegister";
	}

	/**
	 * CalendarAdd
	 *
	 * @param resveVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/resveViewRegisterAdd.do", method = RequestMethod.POST)
	public String addResveViewRegister(ResveVO resveVO) throws Exception {
		System.out.println("[캘린더 등록 View 기능]");

		resveService.insertResve(resveVO);

		return "redirect:/resveView.do";
	}


	/**
	 * 고객 조회
	 *
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
	 * Chart
	 *
	 * @param searchVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/resveChart.do")
	public String chartResve(@ModelAttribute("searchVO") ResveVO searchVO, Model model) throws Exception {
		System.out.println("[예약 차트 기능]");

		ArrayList<String> years = resveService.selectYears();
		model.addAttribute("years", years);

		return "/useLayout/resve/resveChart";
	}

	/**
	 * barChart
	 *
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/resveBarChart.json")
	public Map<String, Object> resveBarChartJson(@RequestBody HashMap<String, Object> map) throws Exception {
		System.out.println("[예약 Bar 차트 Json]");

		ChartVO maleChartVO = new ChartVO();
		ChartVO femaleChartVO = new ChartVO();
		maleChartVO.setYear(map.get("year").toString());
		maleChartVO.setMonth(map.get("month").toString());
		maleChartVO.setSexdstn("Male");
		maleChartVO.setDateType(map.get("dateType").toString());
		femaleChartVO.setYear(map.get("year").toString());
		femaleChartVO.setMonth(map.get("month").toString());
		femaleChartVO.setSexdstn("Female");
		femaleChartVO.setDateType(map.get("dateType").toString());

		List<ChartVO> maleChartList = resveService.selectBarData(maleChartVO);
		List<ChartVO> femaleChartList = resveService.selectBarData(femaleChartVO);

		int[] maledatas;
		int[] femaledatas;

		if(map.get("dateType").equals("y")) {
			maledatas = new int[12];
			femaledatas = new int[12];

			for(ChartVO c : maleChartList) {
				maledatas[Integer.parseInt(c.getMonth())-1] = c.getCnt();
			}
			for(ChartVO c : femaleChartList) {
				femaledatas[Integer.parseInt(c.getMonth())-1] = c.getCnt();
			}
			map.put("maledatas", maledatas);
			map.put("femaledatas", femaledatas);
		} else if(map.get("dateType").equals("m")) {
			maledatas = new int[31];
			femaledatas = new int[31];

			for(ChartVO c : maleChartList) {
				maledatas[Integer.parseInt(c.getDay())-1] = c.getCnt();
			}
			for(ChartVO c : femaleChartList) {
				femaledatas[Integer.parseInt(c.getDay())-1] = c.getCnt();
			}
			map.put("maledatas", maledatas);
			map.put("femaledatas", femaledatas);
		}



		return map;
	}

	/**
	 * pieChart
	 *
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/resvePieChart.json")
	public Map<String, Object> resvePieChartJson(@RequestBody ChartVO pieChart) throws Exception {
		System.out.println("[예약 Pie 차트 Json]");
/*
		ChartVO pieChart = new ChartVO();
		pieChart.setYear(map.get("year").toString());
		pieChart.setMonth(map.get("month").toString());
		pieChart.setDay(map.get("day").toString());
		pieChart.setDateType(map.get("dateType").toString());*/
		List<ChartVO> pieChartList = resveService.selectPieData(pieChart);

		Map<String, Object> arrayMap = new HashMap<>();
		arrayMap.put("piedatas", pieChartList);

		return arrayMap;
	}

}
