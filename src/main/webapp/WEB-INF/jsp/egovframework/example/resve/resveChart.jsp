<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>

	<div class="container">

		<select type="text" class="bjWidth form-control" id="year" name="year">
			<c:forEach var="result" items="${years}" varStatus="status">
				<option value="${years.get(status.index)}">${years.get(status.index)}</option>
			</c:forEach>
		</select>

	<canvas id="myChart" style="width:80vw; height:50vh"></canvas>
		<script type="text/javaScript" language="javascript" defer="defer">

			var ctx = document.getElementById('myChart').getContext('2d');
			var chart = new Chart(ctx, {
			    type: 'bar',
			    data: {
			        labels: ['1', '2', '3', '4', '5', '6', '7','8','9','10','11','12'],
			        datasets: [{
			            label: '2020년',
			            backgroundColor: 'rgb(255, 99, 132)',
			            borderColor: 'rgb(255, 99, 132)',
			            data: [5, 10, 5, 2, 20, 30, 45],
			         	fill: false,
			         	lineTension: 0
			        }]
			    },
			    options: {}
			});
		</script>

	</div>