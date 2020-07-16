<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>IsgBeauty 프로젝트</title>

<!-- fullcalendar-5.1.0 -->
<link rel="stylesheet" href="<c:url  value='js/main.css'/>">
<link rel="stylesheet" href="<c:url  value='js/main.min.css'/>">
<script src="<c:url value='js/main.js' />"></script>
<script src="<c:url value='js/main.min.js'/>"></script>
<script src="<c:url value='js/locales-all.js'/>"></script>
<script src="<c:url value='js/locales-all.min.js'/>"></script>
<script src="<c:url value='js/fullcalendar-5.1.0/lib/locales/ko.js'/>"></script>


<!-- bootstrap -->
<link rel="stylesheet"
	href="<c:url  value='css/bootstrap/css/bootstrap.min.css'/>">
<script src="<c:url value='js/jquery-3.4.1.min.js' />"></script>
<script src="<c:url value='css/bootstrap/js/bootstrap.min.js'/>"></script>
</head>

<!-- Today -->
<%
	Date now = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
	String today = sf.format(now);
%>

<!-- JS -->
<script type="text/javaScript" language="javascript" defer="defer">
		
	function home() {
		location.href = "<c:url value='/mberList.do'/>";
	}
	
	function resveRegister() {
		location.href = "<c:url value='/resveRegister.do'/>";
	}

	document.addEventListener('DOMContentLoaded', function() {
		var calendarEl = document.getElementById('calendar');
		
		var calendar = new FullCalendar.Calendar(calendarEl, {
			initialView : 'dayGridMonth', // 월 달력
			editable: true, // 드래그 수정 가능
			locale : 'ko',  // 한국어 설정
			// 요일 클릭 이벤트
			dateClick : function() {
				alert('요일 클릭!');
			},
			// 일정 클릭 이벤트
			eventClick : function() {
				alert('일정 클릭!');
			},
		});	
		
		// 데이터 삽입방식
		calendar.addEvent({'title':'고객1-컷팅', 'start':'2020-07-16', 'end':'2020-07-16'});
		calendar.addEvent({'title':'고객2-펌', 'start':'2020-07-18', 'end':'2020-07-18'});
		calendar.addEvent({'title':'고객3-염색', 'start':'2020-07-20', 'end':'2020-07-20'});
		
		// 렌더링
		calendar.render();
	});
	
</script>

<body>
	<div class="container">
		<div class="jumbotron text-center alert-info" style="margin-top: 30px"
			role="alert">
			<h2>
				<b>ISG Beauty</b>
			</h2>
			<p>
				<h4 class="control-label">예약 캘린더</h4>
			</p>
		</div>

		<button type="button" style="margin-bottom: 10px;"
			class="btn btn-success" onclick="resveRegister()">등록</button>
		<button type="button" style="margin-bottom: 10px;"
			class="btn btn-danger" onclick="home()">이전</button>

		<div id="calendar"></div>

	</div>
</body>

</html>