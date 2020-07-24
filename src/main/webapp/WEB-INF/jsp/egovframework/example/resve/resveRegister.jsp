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
input.error {
	border: 1px solid red;
}

label {
	margin: 13px;
}

label.error {
	color: red;
}

.bjWidth {
	width:200px;
	margin-top:5px;
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

			<!-- Header -->
			<h2 style="text-align: center;">
				<b><span style="color:#000080;">'${result.mberNm}'</span>님의 예약 등록</b>
			</h2>

			<!-- Contents -->
			<div style="width: 100%; display: inline-flex; padding-bottom: 2px">

				<!-- Start(35%) -->
				<div style="width: 35%;"></div>

				<!-- Center(10%) -->
				<div style="width: 10%; text-align: center;">
					<label class="control-label">예약자 : </label>
					<label class="control-label">시술:</label>
					<label class="control-label">예약일시:</label>
					<label class="control-label">예약시간:</label>
					<label class="control-label">등록자:</label>
					<label class="control-label">등록일:</label>
				</div>

				<!-- End(60%) -->
				<div style="width: 60%; text-align: left; display: grid">
					<!-- 이름 -->
					<div style="display: inline-flex;">
						<input type="text" class="bjWidth form-control" value="<c:out value="${result.mberNm}" />" readonly>
					</div>

					<!-- 시술 -->
					<select class="bjWidth form-control" id="tretmentNm" name="tretmentNm" required>
							<option value="cut">cut</option>
							<option value="perm">perm</option>
							<option value="special">special</option>
					</select>

					<!-- 예약일시 -->
					<div style="display: inline-flex;">
						<input type="date" class="bjWidth form-control" id="resveDt" name="resveDt" required>
					</div>

					<!-- 예약시간 -->
					<div style="display: inline-flex;">
						<input type="time" class="bjWidth form-control" id="resveTime" name="resveTime" required>
					</div>

					<!-- 등록자 -->
					<div style="display: inline-flex;">
						<input type="text" class="bjWidth form-control" id="registId" name="registId" value="test" readonly>
					</div>

					<!-- 등록일 -->
					<div style="display: inline-flex;">
						<input type="date" class="bjWidth form-control" id="registDt" name="registDt" value="<%=today%>" readonly>
					</div>
				</div>
			</div>
		</div>

			<!-- hidden -->
			<input type="hidden" id="mberSn" name="mberSn" value="<c:out value="${result.mberSn}" />">
			<input type="hidden" id="processSttus" name="processSttus" value="N">

		<div class="container" style="text-align: center; margin-top: 30px">
			<button type="submit" class="btn btn-primary" onclick="">예약등록</button>
			<button type="button" class="btn btn-info" onclick="home()">취소</button>
		</div>

	</form:form>
</body>
</html>
