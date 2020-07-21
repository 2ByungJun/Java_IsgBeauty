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

		var obj = {};
		$.ajax({
			url : "<c:url value="/resveView.do"/>",
			type : "post",
			dataType : "json",
			data : JSON.stringify(obj),
			contentType : "application/json",
			success : function(data) {
				console.log(data);
				$.each(data.resveList, function(index, item) {
					calendar.addEvent({
						'title' : item.mberNm + '-' + item.tretmentNm,
						'start' : item.resveDt + 'T' + item.resveTime,
						'resveSn' : item.resveSn,
						'processSttus' : item.processSttus,
						'classNames' : 'bjTooltip'
					});
				});
			},
			error : function(errorThrown) {
				alert(errorThrown.statusText);
			}
		});

		var calendar = new FullCalendar.Calendar(calendarEl, {
			initialView : 'dayGridMonth', // 월 달력
			// 달력 툴
			headerToolbar : {
				left : 'prevYear,prev,next,nextYear,today',
				center : 'title',
				right : 'dayGridMonth,dayGridWeek,dayGridDay'
			},
			editable : true, // 드래그 수정 가능
			navLinks : true, // 클릭시, 달력-주 달력으로 넘어감
			dayMaxEventRows : true, // 셀 크기보다 많은 이벤트가 존재할 시, 'more'로 표기함
			views : {
				dayGrid : {
					dayMaxEventRows : 3
				}
			},
			locale : 'ko', // 한국어 설정
			// 일정 - 마우스 클릭 이벤트
			eventClick : function(data) {
				var check = confirm("예약을 변경하시겠습니까?");
				if (check) {
					$("#resveSn").val(data.event.extendedProps.resveSn);
					view(data.event.extendedProps.resveSn);
				} else {
					// 취소
				}
			},
			eventMouseEnter : function(data) {
				console.log(data);
				console.log($(data));
				console.log(data.event._def);
				$(".bjTooltip").attr("data-toggle","tooltip");
			    $(".bjTooltip").attr("data-placement","top");
				$(".bjTooltip").attr("title",data.event._def.title);
				$(".bjTooltip").css("background-color","blue")
			},
			// 일정 - 마우스가 벗어날 경우
			eventMouseLeave : function(data) {

			}
		});
		// 렌더링
		calendar.render();
	});

	function view(id) {
		document.detailForm.selectedId.value = id;
		document.detailForm.action = "<c:url value='/resveEdit.do'/>";
		document.detailForm.submit();
	}

	$(function () {
		$('[data-toggle="tooltip"]').tooltip()
	})
</script>
</head>
<style>
.bjTooltip {
	background-color: red;
}

</style>
<body>
	<form:form commandName="resveVO" id="detailForm" name="detailForm"
		method="post">
		<input type="hidden" id="resveSn" name="selectedId" />

		<div class="container">
			<div class="jumbotron text-center alert-info"
				style="margin-top: 30px" role="alert">
				<h2>
					<b>ISG Beauty</b>
				</h2>
				<h4 class="control-label">예약 캘린더</h4>
			</div>

			<button type="button" style="margin-bottom: 10px;"
				class="btn btn-danger" onclick="home()">이전</button>

			<div id="calendar"></div>
		</div>

	</form:form>
</body>
</html>