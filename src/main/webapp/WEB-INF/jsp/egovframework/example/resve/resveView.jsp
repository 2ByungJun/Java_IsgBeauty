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
					if(item.processSttus === 'N'){
						// 처리상태  : N
						calendar.addEvent({
							'title' : item.mberNm + '-' + item.tretmentNm,
							'start' : item.resveDt + 'T' + item.resveTime,
							'classNames' : ["bjTool", "aa"+item.resveSn],
							'resveSn' : item.resveSn,
							'mberNm' : item.mberNm,
							'resveDt' : item.resveDt,
							'resveTime' : item.resveTime,
							'tretmentNm' : item.tretmentNm,
							'processSttus' : "처리중",
							'registId' : item.registId,
							'registDt' : item.registDt
						})
					}
					else{
						// 처리상태 : Y
						calendar.addEvent({
							'title' : item.mberNm + '-' + item.tretmentNm,
							'start' : item.resveDt + 'T' + item.resveTime,
							'classNames' : ["bjTool", "aa"+item.resveSn],
							'resveSn' : item.resveSn,
							'mberNm' : item.mberNm,
							'resveDt' : item.resveDt,
							'resveTime' : item.resveTime,
							'tretmentNm' : item.tretmentNm,
							'processSttus' : "완료",
							'registId' : item.registId,
							'registDt' : item.registDt,
							'color' : 'red'
						});
					}
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
			eventClick : function(data) {
				var check = confirm("예약을 변경하시겠습니까?");
				if (check) {
					$("#resveSn").val(data.event.extendedProps.resveSn);
					view(data.event.extendedProps.resveSn);
				} else {
					// 취소
				}
			},
			// 일정 - 마우스 오버 이벤트
			eventMouseEnter : function(data) {
				console.log($(data));

				if( data.event._def.extendedProps.processSttus == '완료'){
					var topic = "\n♦ 예약자 : " + data.event._def.extendedProps.mberNm
					+ '\n' + "\n♦ 예약일 : " + data.event._def.extendedProps.resveDt
					+ '\n' + "\n♦ 예약시간 : " + data.event._def.extendedProps.resveTime
					+ '\n' + "\n♦ 시술 : " + data.event._def.extendedProps.tretmentNm
					+ '\n' + "\n♦ 처리상태 : " + data.event._def.extendedProps.processSttus
					+ '\n';
				}else{
					var topic = "\n◇ 예약자 : " + data.event._def.extendedProps.mberNm
					+ '\n' + "\n◇ 예약일 : " + data.event._def.extendedProps.resveDt
					+ '\n' + "\n◇ 예약시간 : " + data.event._def.extendedProps.resveTime
					+ '\n' + "\n◇ 시술 : " + data.event._def.extendedProps.tretmentNm
					+ '\n' + "\n◇ 처리상태 : " + data.event._def.extendedProps.processSttus
					+ '\n';
				}
				$('.bjTool').attr("data-toggle", topic);
				$('.bjTool').attr("title", topic);

				$('.aa' + data.event._def.extendedProps.resveSn).css('color','green');
			},
			eventMouseLeave : function(data) {
				$('.aa' + data.event._def.extendedProps.resveSn).css('color','#337ab7');
			},
			customButtons: {
			    myCustomButton: {
			      text: 'custom!',
			      click: function() {
			        alert('clicked the custom button!');
			      }
			    }
			  },
		});

		// 렌더링
		calendar.render();

		dayColor();
		$(".fc-button").click(function() {
		       dayColor();
		});
	});

	function view(id) {
		document.detailForm.selectedId.value = id;
		document.detailForm.action = "<c:url value='/resveEdit.do'/>";
		document.detailForm.submit();
	}

	/***** Calendar CSS *****/
	function dayColor(){
		// 토요일 & 일요일 색상
		$('.fc-day-sat .fc-daygrid-day-number').css("color", "#0000FF");
		$('.fc-day-sun .fc-daygrid-day-number').css("color", "#FF0000");
	}

</script>
</head>
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