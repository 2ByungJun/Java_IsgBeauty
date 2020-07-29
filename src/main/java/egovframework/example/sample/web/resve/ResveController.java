package egovframework.example.sample.web.resve;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
	 * 예약 등록 View
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

		return "/useLayout/resve/resveRegister";
	}

	/**
	 * 예약 캘린더 View
	 *
	 * @return
	 */
	@RequestMapping(value = "/resveView.do")
	public String resveView(){
		System.out.println("[예약 캘린더]");

		return "/useLayout/resve/resveView";
	}

     /**
	 * 예약 수정 View
	 *
	 * @return
     * @throws Exception
	 */
	@RequestMapping("/resveEdit.do")
	public String resveEdit(@RequestParam("selectedId") String resveSn, @ModelAttribute("searchVO") ResveVO searchVO, Model model) throws Exception {
		System.out.println("[예약 수정화면]");

		ResveVO sampleVO = new ResveVO();
		sampleVO.setResveSn(resveSn);
		model.addAttribute("result", resveService.selectResve(sampleVO));

		return "/useLayout/resve/resveEdit";
	}

	/**
	 * (Ajax) ResveVO 전달
	 *
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/resveView.do", method = RequestMethod.POST)
	public HashMap<String, Object> init(@RequestBody HashMap<String, Object> map) throws Exception{
		System.out.println("[예약 캘린더]");

		ResveVO resveVO = new ResveVO();
		List<?> resveList = resveService.selectResveList(resveVO);
		map.put("resveList", resveList);

		return map;
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
	 * 예약 등록
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

		return "redirect:/resveView.do";
	}

	/**
	 * 예약 수정
	 * @return "forward:/resveView.do"
	 * @exception Exception
	 */

	@RequestMapping(value = "/updateResve.do", method = RequestMethod.POST)
	public String updateResve(@ModelAttribute("resveVO") ResveVO sampleVO) throws Exception {
		System.out.println("[예약 수정 기능]");

		resveService.updateResve(sampleVO);

		return "redirect:/resveView.do";
	}

	/**
	 * 예약 삭제
	 * @return "forward:/resveView.do"
	 * @exception Exception
	 */
	@RequestMapping(value = "/deleteResve.do")
	public String deleteResve(@RequestParam("selectedId") String resveSn) throws Exception {
		System.out.println("[예약 삭제 기능]");

		ResveVO sampleVO = new ResveVO();
		sampleVO.setResveSn(resveSn);
		resveService.deleteResve(sampleVO);

		return "redirect:/resveView.do";
	}

	@RequestMapping(value = "/resveChart.do")
	public String chartResve(@ModelAttribute("searchVO") ResveVO searchVO, Model model) throws Exception {
		System.out.println("[예약 차트 기능]");

		ArrayList<String> years = resveService.selectYears();
		model.addAttribute("years", years);

		return "/useLayout/resve/resveChart";
	}

	@ResponseBody
	@RequestMapping(value = "/resveBarChart.json")
	public Map<String, Object> resveBarChartJson(@RequestBody HashMap<String, Object> map,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("[예약 Bar 차트 Json]");

		/*
		 *  Bar 차트 부분
		 */
		ChartVO maleChartVO = new ChartVO();
		ChartVO femaleChartVO = new ChartVO();
		maleChartVO.setYear(map.get("year").toString());
		maleChartVO.setSexdstn("Male");
		femaleChartVO.setYear(map.get("year").toString());
		femaleChartVO.setSexdstn("Female");

		int[] maledatas = {0,0,0,0,0,0,0,0,0,0,0,0};
		int[] femaledatas = {0,0,0,0,0,0,0,0,0,0,0,0};
		List<ChartVO> maleChartList = resveService.selectBarData(maleChartVO);
		List<ChartVO> femaleChartList = resveService.selectBarData(femaleChartVO);


		for(ChartVO c : maleChartList) {
			maledatas[Integer.parseInt(c.getMonth())-1] = c.getCnt();
		}
		for(ChartVO c : femaleChartList) {
			femaledatas[Integer.parseInt(c.getMonth())-1] = c.getCnt();
		}

		map.put("maledatas", maledatas);
		map.put("femaledatas", femaledatas);

		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/resvePieChart.json")
	public Map<String, Object> resvePieChartJson(@RequestBody HashMap<String, Object> map,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("[예약 Pie 차트 Json]");

		/*
		 *  Pie 차트 부분
		 */

		ChartVO pieChart = new ChartVO();
		pieChart.setYear(map.get("year").toString());
		pieChart.setMonth(map.get("month").toString());
		List<ChartVO> pieChartList = resveService.selectPieData(pieChart);

		map.put("piedatas", pieChartList);

		return map;
	}
}
