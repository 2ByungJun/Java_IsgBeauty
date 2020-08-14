<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!-- JSP -->
<form:form commandName="resveVO" id="detailForm" name="detailForm" method="post">

	<!-- hidden -->
	<input type="hidden" id="resveSn" name="resveSn" />
	<input type="hidden" id="resveDt" name="resveDt" />

	<!-- calendar -->
	<div class="container" id="calendar"></div>

</form:form>

<!-- JS -->
<link rel="stylesheet" href="<c:url value='js/main.min.css'/>">
<script src="<c:url value='js/main.min.js'/>"></script>
<script src="<c:url value='js/locales-all.min.js'/>"></script>
<script type="text/javaScript" defer="defer">

	/***** 예약 수정페이지 이동 *****/
	function resveEdit() {
		document.detailForm.action = "<c:url value='/resveEdit.do'/>";
		document.detailForm.submit();
	}

	/***** 예약 등록페이지 이동 *****/
	function resveViewRegister() {
		document.detailForm.action = "<c:url value='/resveViewRegister.do'/>";
		document.detailForm.submit();
	}

	/***** calendarCSS *****/
	function dayColor() {
		$('.fc-day-sat .fc-daygrid-day-number').css("color", "#0000FF");
		$('.fc-day-sun .fc-daygrid-day-number').css("color", "#FF0000");
		$('.fc-toolbar-title').css("color", "#000080");
		$('.fc-toolbar-title').css("font-size","xx-large");
	}

	/***** fullCalendarAddData *****/
	document.addEventListener('DOMContentLoaded',function() {
			var calendarEl = document.getElementById('calendar');
			var calendar = fullCalendar(calendarEl);
			$.ajax({
				url : "<c:url value="/resveView.json"/>",
				type : "post",
				dataType : "json",
				data : [],
				contentType : "application/json",
				success : function(data) {
					$.each(data.resveList, function(index, item) {
						if (item.processSttus === 'N') {
							// 처리상태  : N
							calendar.addEvent({
								'title' : item.mberNm + '-' + item.tretmentNm,
								'start' : item.resveDt + 'T' + item.resveTime,
								'classNames' : [ "bjTool","aa" + item.resveSn ],
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
								'title' : item.mberNm + '-' + item.tretmentNm,
								'start' : item.resveDt + 'T' + item.resveTime,
								'classNames' : [ "bjTool", "aa" + item.resveSn ],
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

			// 렌더링
			calendar.render();
			dayColor();
			$(".fc-button").click(function() {
				dayColor();
			});
	});

	/***** fullCalendar *****/
	function fullCalendar(calendarEl){
		return new FullCalendar.Calendar(calendarEl,
				{
					initialView : 'dayGridMonth', // 월 달력
					headerToolbar : {			  // top
						left : 'prev,next,today',
						center : 'title',
						right : 'dayGridMonth,dayGridWeek,dayGridDay'
					},
					editable : true, 		// 드래그 수정 가능
					navLinks : true, 		// 클릭시, 달력-주 달력으로 넘어감
					dayMaxEventRows : true, // 셀 크기보다 많은 이벤트가 존재할 시, 'more'로 표기함
					views : {
						dayGrid : {
							dayMaxEventRows : 4
						}
					},
					locale : 'ko',
					eventClick : function(data) {
						var checkEdit = confirm("예약을 변경하시겠습니까?");
						if (checkEdit) {
							$("#resveSn").val(data.event.extendedProps.resveSn);
							resveEdit();
						}
					},
					eventMouseEnter : function(data) {	// mouseOver
						if (data.event._def.extendedProps.processSttus == '완료') {
							var topic = "\n♦ 예약자 : " + data.event._def.extendedProps.mberNm + '\n'
										+ "\n♦ 예약일 : " + data.event._def.extendedProps.resveDt + '\n'
										+ "\n♦ 예약시간 : " + data.event._def.extendedProps.resveTime + '\n'
										+ "\n♦ 시술 : " + data.event._def.extendedProps.tretmentNm + '\n'
										+ "\n♦ 처리상태 : " + data.event._def.extendedProps.processSttus + '\n';
						} else {
							var topic = "\n◇ 예약자 : " + data.event._def.extendedProps.mberNm + '\n'
										+ "\n◇ 예약일 : " + data.event._def.extendedProps.resveDt + '\n'
										+ "\n◇ 예약시간 : " + data.event._def.extendedProps.resveTime + '\n'
										+ "\n◇ 시술 : " + data.event._def.extendedProps.tretmentNm + '\n'
										+ "\n◇ 처리상태 : " + data.event._def.extendedProps.processSttus + '\n';
						}
						$('.bjTool').attr("data-toggle", topic);
						$('.bjTool').attr("title", topic);
						$('.aa'+ data.event._def.extendedProps.resveSn).css('color', 'green');
					},
					eventMouseLeave : function(data) { // mouseLeave
						$('.aa' + data.event._def.extendedProps.resveSn).css('color', '#337ab7');
					},
					dateClick: function(date, jsEvent) { // dayClick
						var checkDay = confirm("해당 날짜로 새로운 예약을 등록하시겠습니까?");
						if (checkDay) {
							$("#resveDt").val(date.dateStr);
							resveViewRegister();
						}
					}
				});
	}

</script>
