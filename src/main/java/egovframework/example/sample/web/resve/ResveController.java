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
	public String resveRegister(MberVO mberVO, Model model, HttpServletRequest request) throws Exception {

		model.addAttribute("mberVO", mberService.selectMber(mberVO));

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
	public Map<String, Object> init() throws Exception{

		List<?> resveList = resveService.selectResveList();

		Map<String, Object> arrayMap = new HashMap<>();
		arrayMap.put("resveList", resveList);

		return arrayMap;
	}

    /**
	 * 예약 수정 View
	 *
	 * @return
     * @throws Exception
	 */
	@RequestMapping("/resveEdit.do")
	public String resveEdit(ResveVO resveVO, Model model) throws Exception {

		model.addAttribute("resveVO", resveService.selectResve(resveVO));

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

		resveService.insertResve(resveVO);

		return "redirect:/resveView.do";
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
	public String chartResve(Model model) throws Exception {

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
	public Map<String, Object> resveBarChartJson(@RequestBody ChartVO chartVO) throws Exception {

		chartVO.setSexdstn("Male");
		List<ChartVO> maleChartList = resveService.selectBarData(chartVO);

		chartVO.setSexdstn("Female");
		List<ChartVO> femaleChartList = resveService.selectBarData(chartVO);

		int[] maledatas;
		int[] femaledatas;
		Map<String, Object> arrayMap = new HashMap<>();

		if(chartVO.getDateType().equals("y")) {
			maledatas = new int[12];
			femaledatas = new int[12];

			for(ChartVO c : maleChartList) {
				maledatas[Integer.parseInt(c.getMonth())-1] = c.getCnt();
			}
			for(ChartVO c : femaleChartList) {
				femaledatas[Integer.parseInt(c.getMonth())-1] = c.getCnt();
			}
			arrayMap.put("maledatas", maledatas);
			arrayMap.put("femaledatas", femaledatas);
		} else if(chartVO.getDateType().equals("m")) {
			maledatas = new int[31];
			femaledatas = new int[31];

			for(ChartVO c : maleChartList) {
				maledatas[Integer.parseInt(c.getDay())-1] = c.getCnt();
			}
			for(ChartVO c : femaleChartList) {
				femaledatas[Integer.parseInt(c.getDay())-1] = c.getCnt();
			}
			arrayMap.put("maledatas", maledatas);
			arrayMap.put("femaledatas", femaledatas);
		}

		return arrayMap;
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

		List<ChartVO> pieChartList = resveService.selectPieData(pieChart);

		Map<String, Object> arrayMap = new HashMap<>();
		arrayMap.put("piedatas", pieChartList);

		return arrayMap;
	}

}
