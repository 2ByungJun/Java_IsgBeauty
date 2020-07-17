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
<link rel="stylesheet"
	href="<c:url  value='css/bootstrap/css/bootstrap.min.css'/>">
<script src="<c:url value='js/jquery-3.4.1.min.js' />"></script>
<script src="<c:url value='css/bootstrap/js/bootstrap.min.js'/>"></script>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/additional-methods.min.js"></script>
<script type="text/javaScript" language="javascript" defer="defer">
	function home() {
		location.href = "<c:url value='/mberList.do'/>";
	}

	function resveView() {
		location.href = "<c:url value='/resveView.do'/>";
	}
	
	/* Validation */
	$(function() {
		$("#detailForm").validate({
			submitHandler : function() {
				var check = confirm("예약하시겠습니까?");
				if (check) {
					alert("예약되었습니다.");
					frm = document.detailForm;
					frm.action = "<c:url value= '/addResve.do'/>";
					frm.submit();
				} else {
					alert("취소하셨습니다.");
					location.href = "<c:url value='/mberList.do'/>";
				}
			},
			rules : {
				tretmentNm : {
					required : true
				},
				resveDt : {
					required : true,
				},
				resveTime : {
					required : true,
				}
			},
			messages : {
				tretmentNm : {
					required : "필수 입력 항목입니다."
				},
				resveDt : {
					required : "필수 입력 항목입니다."
				},
				resveTime : {
					required : "필수 입력 항목입니다."
				}
			}
		});
	});
</script>
</head>
<style>
label {
	margin-top: 30px;
}

input {
	margin-top: 30px;
	width: 200px;
}

select {
	margin-top: 30px;
}
</style>
<body>
	<%
		Date now = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		String today = sf.format(now);
	%>

	<form:form commandName="mberVO" id="detailForm" name="detailForm"
		method="post">
		<div class="container">
			<div class="jumbotron text-center alert-info"
				style="margin-top: 30px" role="alert" onclick="home()">
				<h2>
					<b>ISG Beauty</b>
				</h2>
				<h4 class="control-label">${result.mberNm}님의예약님의 도와드립니다!</h4>
			</div>
		</div>

		<div class="container">

			<div class="form-inline form-group">
				<label for="mberNm" class="col-sm-2 col-sm-offset-1 control-label">예약자*:</label>
				<div class="col-xs-2">
					<input type="text" class="form-control"
						value="<c:out value="${result.mberNm}" />" readonly>
				</div>

				<label for="tretmentNm"
					class="col-sm-2 col-sm-offset-1 control-label">시술*:</label>
				<div class="col-md-2">
					<select class="form-control" id="tretmentNm" name="tretmentNm" required>
						<option value="cut">cut</option>
						<option value="perm">perm</option>
						<option value="special">special</option>
					</select>
				</div>
			</div>

			<div class="form-inline form-group">
				<label for="resveDt" class="col-sm-2 col-sm-offset-1 control-label">예약일시*:</label>
				<div class="col-md-2">
					<input type="date" class="form-control" id="resveDt" name="resveDt" required>
				</div>

				<label for="resveTime"
					class="col-sm-2 col-sm-offset-1 control-label">예약시간*:</label>
				<div class="col-md-2">
					<input type="time" class="form-control" id="resveTime"
						name="resveTime" required>
				</div>
			</div>

			<div class="form-inline form-group">
				<label for="registId" class="col-sm-2 col-sm-offset-1 control-label">등록자*:</label>
				<div class="col-md-2">
					<input type="text" class="form-control" id="registId"
						name="registId" value="test" readonly>
				</div>

				<label for="registDt" class="col-sm-2 col-sm-offset-1 control-label">등록일*:</label>
				<div class="col-md-2">
					<input type="date" class="form-control" id="registDt"
						name="registDt" value="<%=today%>" readonly>
				</div>
			</div>

			<input type="hidden" id="mberSn" name="mberSn"
				value="<c:out value="${result.mberSn}" />"> <input
				type="hidden" id="processSttus" name="processSttus" value="N">
		</div>

		<div class="container" style="text-align: center; margin-top: 30px">
			<button type="submit" class="btn btn-success" onclick="">예약등록</button>
			<button type="button" class="btn btn-info" onclick="home()">취소</button>
		</div>

	</form:form>
</body>
</html>
