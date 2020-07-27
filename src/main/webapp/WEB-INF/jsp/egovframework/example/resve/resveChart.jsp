<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<canvas id="myChart" style="width:80vw; height:50vh"></canvas>
<script type="text/javaScript" language="javascript" defer="defer">

	var ctx = document.getElementById('myChart').getContext('2d');
	var chart = new Chart(ctx, {
	    type: 'line',
	    data: {
	        labels: ['1', '2', '3', '4', '5', '6', '7','8','9','10','11','12'],
	        datasets: [{
	            label: '2020년',
	            backgroundColor: 'rgb(255, 99, 132)',
	            borderColor: 'rgb(255, 99, 132)',
	            data: [0, 10, 5, 2, 20, 30, 45],
	         	fill: false,
	         	lineTension: 0
	        }]
	    },
	    options: {}
	});
</script>