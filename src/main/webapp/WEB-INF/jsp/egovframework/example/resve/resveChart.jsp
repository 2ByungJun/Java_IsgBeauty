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

		<select type="text" class="form-control" id="year" name="year" onchange="createBarChart()">
			<c:forEach var="result" items="${years}" varStatus="status">
				<option value="${years.get(status.index)}">${years.get(status.index)}</option>
			</c:forEach>
		</select>

	<canvas id="myBarChart" style="width:80vw; height:50vh"></canvas>
	<script type="text/javaScript" language="javascript" defer="defer">
	var ctx = document.getElementById('myBarChart').getContext('2d');
	var barChart = new Chart(ctx, {
  	  	type: 'bar',
	    data: {},
	    options: {}
	});

	$(document).ready(function() {
		createBarChart(barChart);
	});


	function createBarChart(){

	  var url  =  "<c:url value='/resveChart.json'/>";
	  var jsonData = {"year": $("#year").val()};

	  $.ajax({
			headers: {
				Accept: "application/json;utf-8"
			}
			,contentType: "application/json;utf-8"
			,dataType: "json"
			,type: "POST"
			,url: url
			,data: JSON.stringify(jsonData)
			,success:function(data){
				console.log(data);

				var maleData = {
					    label: "남성",
					    data: data.maledatas,
					    lineTension: 0,
					    fill: false,
					    backgroundColor: 'rgb(111, 183, 214)'
					  };

				var femaleData = {
					    label: "여성",
					    data: data.femaledatas,
					    lineTension: 0,
					    fill: false,
					    backgroundColor: 'rgb(255, 99, 132)'
					  };
				var sexdstnData = {
						  labels: ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL','AUG','SEP','OCT','NOV','DEC'],
						  datasets: [maleData, femaleData]
						};
				barChart.data = sexdstnData;
				barChart.update();
			}
			,error:function(e){
			   	console.log(e.status, e.statusText);
			   	alert("서버 오류 입니다. 관리자에게 문의하세요.")
			}
		});
	}
	</script>

	<canvas id="myPieChart" style="width:80vw; height:50vh"></canvas>
	<script type="text/javaScript" language="javascript" defer="defer">
	var config = {
			type: 'pie',
			data: {
				datasets: [{
					data: [10,30,50],
					backgroundColor: ['orange', 'rgb(111, 183, 214)','rgba(240, 99, 132, 0.6)'],
					label: '시술별 기록'
				}],
				labels: [
					'Cut',
					'Perm',
					'Special']
			},
			options: {
				responsive: true
			}
		};



	var pieCtx = document.getElementById('myPieChart').getContext('2d');
	var pieChart = new Chart(pieCtx, config);





	/* $(document).ready(function() {
		createBarChart(pieChart);
	}); */


	function createPieChart(chart){

	  var url  =  "<c:url value='/resveChart.json'/>";
	  var jsonData = {"year": $("#year").val()};

	  $.ajax({
			headers: {
				Accept: "application/json;utf-8"
			}
			,contentType: "application/json;utf-8"
			,dataType: "json"
			,type: "POST"
			,url: url
			,data: JSON.stringify(jsonData)
			,success:function(data){
				console.log(data);
			}
			,error:function(e){
			   	console.log(e.status, e.statusText);
			   	alert("서버 오류 입니다. 관리자에게 문의하세요.")
			}
		});
	}
	</script>

	</div>