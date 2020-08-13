<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<title>IsgBeauty</title>

<!-- JS -->
<script type="text/javaScript" defer="defer">
	<% session.invalidate(); %>
	alert("로그아웃 되었습니다.");
	location.href = "<c:url value='/login.do'/>";
</script>
