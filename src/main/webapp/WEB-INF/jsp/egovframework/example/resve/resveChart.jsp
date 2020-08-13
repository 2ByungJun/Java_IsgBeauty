<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>

<!-- JSP -->
<form:form commandName="chartVO" id="chartForm" name="chartForm" method="post">
	<!-- hidden -->
	<input type="hidden" id="dateType" value='y'/>
	<input type="hidden" id="day"/>
	<!-- header -->
	<div class="container" style="display: flex;">
		<!-- button -->
		 <div class="btn-group" role="group">
		     <button type="button" class="btn btn-primary button-class1" id="yearBtn">연간</button>
		     <button type="button" class="btn btn-default button-class2" id="monthBtn">월간</button>
	     </div>

		<!-- yearSelector -->
		<select class="form-control" id="year" name="year" onchange="createBarChart()" style = "width:100px; display: inline-flex; margin-left:15px;">
			<c:forEach var="result" items="${years}" varStatus="status">
				<option value="${years.get(status.index)}">${years.get(status.index)}</option>
			</c:forEach>
		</select>

		<!-- monthSelector -->
		<select class="form-control" id="month" name="month" onchange="createBarChart()" style = "width:100px; margin-left:2px; ">
			<% for(int i=1; i<13; i++) {%>
				<option value="<%=i%>"><%=i+"월"%></option>
			<%}%>
		</select>
	</div>

	<!-- body -->
	<div class="container">
		<div style="width:100%; display:flex;">

				<!-- barTitle -->
				<div style="width:65%; display:inline-flex; justify-content:center;"><h2 style="text-align: center;"><b>예약 통계</b></h2></div>

				<!-- pieTitle -->
				<div id="pieTitle" style="width:35%; display:inline-flex; justify-content:center; "><h2 style="text-align: center;"><b>시술 종류</b></h2></div>

		</div>

		<div style="width:100%; display:flex;">

			<!-- barChart -->
			<div style="width:65%; display:inline-flex; float:left;"><canvas id="myBarChart"></canvas></div>

			<!-- pieChart -->
			<div style="width:35%; display:inline-flex; align-self: center; justify-content: center; float:right;"><canvas id="myPieChart" style="">></canvas></div>

		</div>
	</div>
</form:form>

<!-- JS -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<script type="text/javaScript" defer="defer">
	$(document).ready(function() {
		createBarChart(barChart);
		$('#pieTitle').hide();
	});

	$("#month").hide();
	   $('.button-class1').click(function(){
	       if( $(this).hasClass('btn-default') ) {
	       	$(this).removeClass('btn-default');
	       	$(this).addClass('btn-primary');
	       	$("#monthBtn").removeClass('btn-primary');
	       	$("#monthBtn").addClass('btn-default');
	       	$("#dateType").val("y");
	       	$("#month").hide();
	      	    createBarChart(barChart);
	      	    pieChart.clear();
	      	    $('#pieTitle').hide();
	       }
	   });
	   $('.button-class2').click(function(){
	   	if( $(this).hasClass('btn-default') ) {
	       	$(this).removeClass('btn-default');
	       	$(this).addClass('btn-primary');
	       	$("#yearBtn").removeClass('btn-primary');
	       	$("#yearBtn").addClass('btn-default');
	       	$("#dateType").val("m");
	       	$("#month").show();
	       	createBarChart(barChart);
	       	pieChart.clear();
	       	$("#pieTitle").hide();
	       }
	   });

	$("#myBarChart").click(function(evt) {
		var activePoints = barChart.getElementsAtEvent(evt);

		 if($("#dateType").val() == 'y') {
			 $('#month').val(activePoints[0]._index+1);
		  } else {
			 $('#day').val(activePoints[0]._index+1);
		  }
		$('#pieTitle').show();
		createPieChart();
	});


var barConfig = {
		type: 'bar',
		data: {},
		options: {
			scales: {
				xAxes: [{
		        	    scaleLabel:{
		        		display:true,
		        		labelString:"월",
		        		fontSize:20,
		        		fontStyle:'bold'
		        	}
		        }],
		        yAxes: [{
		        	ticks: {
		        		suggestedMin: 0,
		                suggestedMax: 5,
						stepSize:1
		        	},
		        	scaleLabel:{
		        		display:true,
		        		labelString:"예약 건수",
		        		fontSize:20,
		        		fontStyle:'bold'
		        	}
		        }]
		    }
		}
	};

var ctx = document.getElementById('myBarChart').getContext('2d');
var barChart = new Chart(ctx, barConfig);

function createBarChart(){

			  var url  =  "<c:url value='/resveBarChart.json'/>";
			  var jsonData = {"year": $("#year").val(), "dateType": $("#dateType").val(), "month": $("#month").val()};
			  /* var jsonData = $("#chartForm").serializeJSON(); */

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
						var dataLabel = new Array();
						if($("#dateType").val() == "y") {
							dataLabel = ['1월', '2월', '3월', '4월', '5월', '6월', '7월','8월','9월','10월','11월','12월'];
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
				    backgroundColor: 'rgb(111, 183, 214)',
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
					data:  sexdstnData
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
		data:  {} ,
		options: {}
	};

var pieCtx = document.getElementById('myPieChart').getContext('2d');
var pieChart = new Chart(pieCtx, pieConfig);

function createPieChart(){

  var url  =  "<c:url value='/resvePieChart.json'/>";
  var jsonData = $("#chartForm").serializeJSON();

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
				options: {}
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
</script>

