package egovframework.example.sample.web.login;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.example.sample.service.emp.EmpVO;

@Controller
public class LoginController {
	
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
}
