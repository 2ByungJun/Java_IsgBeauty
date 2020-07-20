package egovframework.example.sample.web.login;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hsqldb.lib.StringComparator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.example.sample.service.emp.EmpService;
import egovframework.example.sample.service.emp.EmpVO;

@Controller
public class LoginController {

	/** empService */
	@Resource(name = "empService")
	private EmpService empService;

	/**
	 * 로그인
	 *
	 * @param mberVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/login.do")
	public String login(){
		System.out.println("[로그인]");

		return "login/login";
	}

	/**
	 * 로그인-직원 등록
	 *
	 * @param searchVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/loginEmpRegister.do")
	public String loginEmpRegister(@ModelAttribute("searchVO") EmpVO searchVO, ModelMap model) throws Exception {
		System.out.println("[회원가입]");

		return "login/loginEmpRegister";
	}

	@ResponseBody
	@RequestMapping(value= "/loginCheck.json")
	public Map<String, Object> loginCheckJson(@RequestBody EmpVO searchVO,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println(searchVO.getEmpId()+"_______________test"+searchVO.getEmpPassword());

		EmpVO empLoginVO = empService.selectEmp(searchVO);
		Map<String, Object> arrayMap = new HashMap<>();
		HttpSession session = request.getSession();

		if(empLoginVO != null) {
			if(empLoginVO.getEmpPassword().equals(searchVO.getEmpPassword())) {
				arrayMap.put("result", "true");
				session.setAttribute("empId", searchVO.getEmpId());
			}
			else {
				arrayMap.put("result", "pwdError");
			}
		} else {
			arrayMap.put("result", "idError");
		}

		return arrayMap;
	}
}
