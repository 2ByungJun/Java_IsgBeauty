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
		 <div class="btn-group" role="group">
		     <button type="button" class="btn btn-primary button-class1" id="yearBtn" onclick="createBarChart()">연간</button>
		     <button type="button" class="btn btn-default button-class2" id="monthBtn">월간</button>
	     </div>

		<select type="text" class="form-control" id="year" name="year" onchange="createBarChart()" style = "width:100px; display: inline-flex;">
			<c:forEach var="result" items="${years}" varStatus="status">
				<option value="${years.get(status.index)}">${years.get(status.index)}</option>
			</c:forEach>
		</select>
		<select type="text" class="form-control" id="month" name="month" onchange="createBarChart()" style = "width:100px; display: inline-flex;">
			<% for(int i=1; i<13; i++) {%>
			<option value="<%=i%>"><%=i+"월"%></option>
			<%}%>
		</select>
	</div>

	<div class="container">
		<div style="width:100%; display:flex;">

			<div style="width:70%; display:inline-flex;">
				<canvas id="myBarChart" style="width:80vw; height:50vh"></canvas>
			</div>
			<div style="width:30%; display:inline-flex; align-self: center; justify-content: center;">
				<canvas id="myPieChart" style="width:80vw; height:50vh;"></canvas>
			</div>
			<input type="hidden" id="dateType" value='y'/>
		</div>
	</div>

<script type="text/javaScript" language="javascript" defer="defer">
    $('.button-class1').click(function(){
        if( $(this).hasClass('btn-default') ) {
        	$(this).removeClass('btn-default');
        	$(this).addClass('btn-primary');
        	$("#monthBtn").removeClass('btn-primary');
        	$("#monthBtn").addClass('btn-default');
        	$("#dateType").val("y");
        }
    });
    $('.button-class2').click(function(){
    	if( $(this).hasClass('btn-default') ) {
        	$(this).removeClass('btn-default');
        	$(this).addClass('btn-primary');
        	$("#yearBtn").removeClass('btn-primary');
        	$("#yearBtn").addClass('btn-default');
        	$("#dateType").val("m");
        }
    });

	var barConfig = {
			type: 'bar',
			data:  {} ,
			options: {}
		};

	var ctx = document.getElementById('myBarChart').getContext('2d');
	var barChart = new Chart(ctx, barConfig);

	$(document).ready(function() {
		createBarChart(barChart);
	});

	function createBarChart(){

	  var url  =  "<c:url value='/resveBarChart.json'/>";
	  var jsonData = {"year": $("#year").val(), "dateType": $("#dateType").val(), "month": $("#month").val()};

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
				var dataLabel = new Array();
				if($("#dateType").val() == "y") {
					dataLabel = ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL','AUG','SEP','OCT','NOV','DEC'];
				} else {
					for(var i=0; i<31; i++) {
						dataLabel[i]=i+1;
					}
				}

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
						  labels: dataLabel,
						  datasets: [maleData, femaleData]
						};

				var updateBarConfig = {
						type: 'bar',
						data:  sexdstnData,
						options: {
							//responsive: true
						}
					};

				barChart.config = updateBarConfig;
				barChart.update();
			}
			,error:function(e){
			   	console.log(e.status, e.statusText);
			   	alert("서버 오류 입니다. 관리자에게 문의하세요.")
			}
		});
	}


	var pieConfig = {
			type: 'pie',
			data:  {/*
				datasets: [{
					data: [10,30,50],
					backgroundColor: ['orange', 'rgb(111, 183, 214)','rgba(240, 99, 132, 0.6)'],
					label: '시술별 기록'
				}],
				labels: [
					'Cut',
					'Perm',
					'Special']
				*/} ,
			options: {
				//responsive: true
			}
		};

	var pieCtx = document.getElementById('myPieChart').getContext('2d');
	var pieChart = new Chart(pieCtx, pieConfig);

	function createPieChart(index){

	  var url  =  "<c:url value='/resvePieChart.json'/>";
	  var jsonData = {"year": $("#year").val(), "month": index};

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
				console.log(data.piedatas);
				var arrayData = new Array();
				var arrayLabel = new Array();

				$.each(data.piedatas, function(index, item) {
					arrayData.push(item.cnt);
					arrayLabel.push(item.tretmentNm);
				});

				var updatePieConfig = {
					type: 'pie',
					data:  {
						datasets: [{
							data:arrayData,
							backgroundColor: ['orange', 'rgb(111, 183, 214)','rgba(240, 99, 132, 0.6)'],
							label: '시술별 기록'
						}],
						labels: arrayLabel
						} ,
					options: {
						//responsive: true
					}
				};

				pieChart.config = updatePieConfig;
				pieChart.update();
			}
			,error:function(e){
			   	console.log(e.status, e.statusText);
			   	alert("서버 오류 입니다. 관리자에게 문의하세요.")
			}
		});
	}

	$("#myBarChart").click(function(evt) {
		var activePoints = barChart.getElementsAtEvent(evt);
		createPieChart(activePoints[1]._index+1);
	});

	</script>

