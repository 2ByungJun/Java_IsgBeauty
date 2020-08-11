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

<!-- moment 2.24.0 -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>

<!-- Today -->
<%
	Date now = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
	String today = sf.format(now);
%>

<!-- JS -->
<script type="text/javaScript" language="javascript" defer="defer">

	/***** 예약등록 *****/
	function resveRegister() {
		location.href = "<c:url value='/resveRegister.do'/>";
	}

	/***** Ajax 예약 데이터 *****/
	document
			.addEventListener(
					'DOMContentLoaded',
					function() {
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
									if (item.processSttus === 'N') {
										// 처리상태  : N
										calendar.addEvent({
											'title' : item.mberNm + '-'
													+ item.tretmentNm,
											'start' : item.resveDt + 'T'
													+ item.resveTime,
											'classNames' : [ "bjTool",
													"aa" + item.resveSn ],
											'resveSn' : item.resveSn,
											'mberNm' : item.mberNm,
											'resveDt' : item.resveDt,
											'resveTime' : item.resveTime,
											'tretmentNm' : item.tretmentNm,
											'processSttus' : "처리중",
											'registId' : item.registId,
											'registDt' : item.registDt
										})
									} else {
										// 처리상태 : Y
										calendar.addEvent({
											'title' : item.mberNm + '-'
													+ item.tretmentNm,
											'start' : item.resveDt + 'T'
													+ item.resveTime,
											'classNames' : [ "bjTool",
													"aa" + item.resveSn ],
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

						/***** Full Calendar *****/
						var calendar = new FullCalendar.Calendar(
								calendarEl,
								{
									initialView : 'dayGridMonth', // 월 달력
									// 달력 툴
									headerToolbar : {
										left : 'prev,next,today',
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
											$("#resveSn")
													.val(
															data.event.extendedProps.resveSn);
											resveEdit(data.event.extendedProps.resveSn);
										} else {
											// 취소
										}
									},
									// 일정 - 마우스 오버 이벤트
									eventMouseEnter : function(data) {
										console.log($(data));

										if (data.event._def.extendedProps.processSttus == '완료') {
											var topic = "\n♦ 예약자 : "
													+ data.event._def.extendedProps.mberNm
													+ '\n'
													+ "\n♦ 예약일 : "
													+ data.event._def.extendedProps.resveDt
													+ '\n'
													+ "\n♦ 예약시간 : "
													+ data.event._def.extendedProps.resveTime
													+ '\n'
													+ "\n♦ 시술 : "
													+ data.event._def.extendedProps.tretmentNm
													+ '\n'
													+ "\n♦ 처리상태 : "
													+ data.event._def.extendedProps.processSttus
													+ '\n';
										} else {
											var topic = "\n◇ 예약자 : "
													+ data.event._def.extendedProps.mberNm
													+ '\n'
													+ "\n◇ 예약일 : "
													+ data.event._def.extendedProps.resveDt
													+ '\n'
													+ "\n◇ 예약시간 : "
													+ data.event._def.extendedProps.resveTime
													+ '\n'
													+ "\n◇ 시술 : "
													+ data.event._def.extendedProps.tretmentNm
													+ '\n'
													+ "\n◇ 처리상태 : "
													+ data.event._def.extendedProps.processSttus
													+ '\n';
										}
										$('.bjTool').attr("data-toggle", topic);
										$('.bjTool').attr("title", topic);

										$(
												'.aa'
														+ data.event._def.extendedProps.resveSn)
												.css('color', 'green');
									},
									eventMouseLeave : function(data) {
										$(
												'.aa'
														+ data.event._def.extendedProps.resveSn)
												.css('color', '#337ab7');
									},
									customButtons : {
										myCustomButton : {
											text : 'custom!',
											click : function() {
												alert('clicked the custom button!');
											}
										}
									},
									 navLinks: true,
									 navLinkDayClick: function(date, jsEvent) {
									    dateClick(moment(date.toISOString()).format('YYYY-MM-DD'));
									 }
								});

						// 렌더링
						calendar.render();

						dayColor();
						$(".fc-button").click(function() {
							dayColor();
						});
					});

	/***** 예약 수정 *****/
	function resveEdit(id) {
		document.detailForm.selectedId.value = id;
		document.detailForm.action = "<c:url value='/resveEdit.do'/>";
		document.detailForm.submit();
	}

	/***** Calendar CSS *****/
	function dayColor() {
		// 토요일 & 일요일 색상
		$('.fc-day-sat .fc-daygrid-day-number').css("color", "#0000FF");
		$('.fc-day-sun .fc-daygrid-day-number').css("color", "#FF0000");
		// 타이틀 색상
		$('.fc-toolbar-title').css("color", "#000080");
		$('.fc-toolbar-title').css("font-size","xx-large");
	}

	/***** 예약 View 등록 *****/
	function dateClick(date) {
		document.detailForm.selectedDate.value = date;
		document.detailForm.action = "<c:url value='/resveViewRegister.do'/>";
		document.detailForm.submit();
	}

</script>
	<form:form commandName="resveVO" id="detailForm" name="detailForm"
		method="post">
		<input type="hidden" id="resveSn" name="selectedId" />
		<input type="hidden" id="resveDt" name="selectedDate" />

		<div class="container">
			<div id="calendar"></div>
		</div>
	</form:form>
