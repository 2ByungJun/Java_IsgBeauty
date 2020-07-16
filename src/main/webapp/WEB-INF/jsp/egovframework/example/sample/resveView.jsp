<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>IsgBeauty 프로젝트</title>
<link rel="stylesheet"
	href="<c:url  value='css/bootstrap/css/bootstrap.min.css'/>">
<script src="<c:url value='js/jquery-3.4.1.min.js' />"></script>
<script src="<c:url value='css/bootstrap/js/bootstrap.min.js'/>"></script>
</head>
<script type="text/javaScript" language="javascript" defer="defer">
	function home() {
		location.href = "<c:url value='/mberList.do'/>";
	}
</script>
<body>
	<div class="container">
		<div class="jumbotron text-center alert-info" style="margin-top: 30px"
			role="alert">
			<h2>
				<b>ISG Beauty</b>
			</h2>
			<p>
				<b>예약 캘린더</b>
			</p>
		</div>
	</div>

	
</body>


<div class="container" style="text-align: center;">
	<button type="button" class="btn btn-success" onclick="">등록</button>
	<button type="button" class=" btn btn-info" onclick="home()">이전</button>
</div>


</body>
</html>