package egovframework.example.inteceptor;


import java.io.IOException;
import java.io.PrintWriter;
import java.util.Locale;

import javax.jms.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;


public class PspofcInterceptor extends HandlerInterceptorAdapter {

	private final String AJAX_HEADER = "AJAX";


	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws IOException, ModelAndViewDefiningException {

		request.setAttribute("contextPath", request.getContextPath());
		HttpSession session = request.getSession();

		if(!session.getAttribute("pspofc").equals("Admin")) {

			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('관리자 권한이 필요합니다.'); history.back();</script>");
			out.flush();

			return false;
		}

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
