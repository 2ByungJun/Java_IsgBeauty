package egovframework.example.sample.web.resve;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.example.sample.service.SampleDefaultVO;
import egovframework.example.sample.service.emp.EmpVO;
import egovframework.example.sample.service.mber.MberService;
import egovframework.example.sample.service.mber.MberVO;
import egovframework.example.sample.service.resve.ResveService;
import egovframework.example.sample.service.resve.ResveVO;

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

		return "resve/resveRegister";
	}

	/**
	 * 예약 캘린더 View
	 *
	 * @return
	 */
	@RequestMapping(value = "/resveView.do")
	public String resveView(){
		System.out.println("[예약 캘린더]");

		return "resve/resveView";
	}
	
	
	@RequestMapping(value = "/resveEdit.do")
	public String resveEdit(){
		System.out.println("[예약 캘린더]");

		return "resve/resveEdit";
	}
	
     /**
	 * 예약 수정 View
	 *
	 * @return
     * @throws Exception 
	 */
/*	@ResponseBody
	@RequestMapping(value = "/resveEdit.do")
	public ResveVO resveEdit2(@RequestBody String resveSn, @ModelAttribute("searchVO") ResveVO searchVO ,Model model) throws Exception{
		System.out.println("[예약 수정]" + resveSn);
		
		ResveVO sampleVO = new ResveVO();
		sampleVO.setResveSn(resveSn);
		
		model.addAttribute("result", resveService.selectResve(sampleVO));

		System.out.println(resveService.selectResve(sampleVO));

		return resveService.selectResve(sampleVO);
	}*/
	
	/**
	 * 예약 수정
	 * 
	 * @param resveSn
	 * @param searchVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	/*@ResponseBody
	@RequestMapping(value = "/resveEdit.do", method = RequestMethod.POST)
	public  HashMap<String, Object> resveEdit2(@RequestBody String resveSn, @ModelAttribute("searchVO") ResveVO searchVO) throws Exception{
		System.out.println("[예약 수정 기능]");

		ResveVO sampleVO = new ResveVO();
		sampleVO.setResveSn(resveSn);
		
		HashMap<String, Object> map = new  HashMap<String, Object>();
		map.put("result", resveService.selectResve(sampleVO) );
		
		System.out.println(resveService.selectResve(sampleVO));
		
		return map;
	}*/
	
	
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
}
