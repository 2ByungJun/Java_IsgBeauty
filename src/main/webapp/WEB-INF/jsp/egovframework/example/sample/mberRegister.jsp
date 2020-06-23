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
<script type="text/javaScript" language="javascript" defer="defer">
	function home() {
		location.href = "<c:url value='/mberList.do'/>";
	}

	/* 글 등록 function */
	function saveMber() {
		frm = document.detailForm;
		frm.action = "<c:url value= '/addMber.do'/>";
		frm.submit();
	}
</script>
</head>
<style>
label {
	margin-top: 30px;
}

input {
	margin-top: 30px;
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
			<div class="jumbotron text-center alert-info" role="alert"
				onclick="home()">
				<h2>
					<b>ISG Beauty</b>
				</h2>
				<p>
					<b>고객 등록 화면입니다.</b>
				</p>
			</div>
		</div>

		<div class="container">
			<div class="row">
				<div class=" form-inline form-group">
					<label for="mberSn" class="col-sm-2 col-sm-offset-1 control-label">순번*:</label>
					<div class="col-md-3">
						<input type="text" class="form-control" id="mberSn" name="mberSn" value="${mbertotCnt+1}" readonly>
					</div>

					<label for="eEmpId" class="col-sm-2 col-sm-offset-1 control-label">담당
						직원*:</label>
					<div class="col-md-3">
						<input type="text" class="form-control" id="eEmpId" name="eEmpId">
					</div>
				</div>

				<div class="form-inline form-group">
					<label for="mberNm" class="col-sm-2 col-sm-offset-1 control-label">이름*:</label>
					<div class="col-md-3">
						<input type="text" class="form-control" id="mberNm" name="mberNm">
					</div>

					<label for="telno" class="col-sm-2 col-sm-offset-1 control-label">전화번호*:</label>
					<div class="col-md-3">
						<input type="text" class="form-control" id="telno" name="telno">
					</div>
				</div>

				<div class="form-inline form-group">
					<label for="sexdstn" class="col-sm-2 col-sm-offset-1 control-label">성별*:</label>
					<div class="col-md-3">
						<select type="text" class="form-control" id="sexdstn"
							name="sexdstn">
							<option value="Male" selected="selected">Male</option>
							<option value="Female">Female</option>
						</select>
					</div>

					<label for="brthdy" class="col-sm-2 col-sm-offset-1 control-label">생년월일:</label>
					<div class="col-md-3">
						<input type="text" class="form-control" id="brthdy" name="brthdy">
					</div>
				</div>

				<div class="form-inline form-group">
					<label for="registId"
						class="col-sm-2 col-sm-offset-1 control-label">등록자*:</label>
					<div class="col-md-3">
						<input type="text" class="form-control" id="registId"
							name="registId" value="test" readonly >
					</div>

					<label for="registDt"
						class="col-sm-2 col-sm-offset-1 control-label">등록일*:</label>
					<div class="col-md-3">
						<input type="text" class="form-control" id="registDt"
							name="registDt" value="<%=today%>" readonly>
					</div>
				</div>

				<%-- <div class="form-inline form-group">
					<label for="updtId" class="col-sm-2 col-sm-offset-1 control-label">수정자:</label>
					<div class="col-md-3">
						<input type="text" class="form-control" id="updtId" name="updtId">
					</div>

					<label for="updtDt" class="col-sm-2 col-sm-offset-1 control-label">수정일:</label>
					<div class="col-md-3">
						<input type="text" class="form-control" id="registDt"
							name="registDt" value="<%=today%>">
					</div>
				</div> --%>
			</div>
		</div>

		<div class="container" style="text-align: center; margin-top: 30px">
			<button type="button" class="btn btn-info" onclick="saveMber()">등록</button>
			<button type="button" class=" btn btn-info" onclick="home()">취소</button>
		</div>

	</form:form>
</body>
</html>