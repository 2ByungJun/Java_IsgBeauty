package egovframework.example.inteceptor;


import java.io.IOException;
import java.util.Locale;

import javax.jms.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;


public class LogonInterceptor extends HandlerInterceptorAdapter {

	private final String AJAX_HEADER = "AJAX";

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws IOException, ModelAndViewDefiningException {


		String requestURI = request.getServletPath();
	    boolean isPermittedURL = false;

		request.setAttribute("contextPath", request.getContextPath());
		HttpSession session = request.getSession();
		System.out.println(session+"@@@@@@@@@@");
		System.out.println(session.getAttribute("empId")+"111@@@@@@@@@@");
		return true;
	}

	/**
	 * ajax check
	 * @param request
	 * @return
	 */
	private boolean isAjax(HttpServletRequest request) {
	  return (request.getHeader(AJAX_HEADER) != null && request.getHeader(AJAX_HEADER).equals("TRUE"))
	      || ("XMLHttpRequest".equalsIgnoreCase(request.getHeader("X-Requested-With")))
	      ;
	}
}
