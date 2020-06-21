<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
		location.href = "<c:url value='/login.do'/>";
	}

	/* 글 등록 function */
	function saveEmp() {
		frm = document.detailForm;

		frm.action = "<c:url value= '/addEmp.do'/>";
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
</style>
<body>
	<form:form commandName="empVO" id="detailForm" name="detailForm"
		method="post">
		<div class="container">
			<div class="jumbotron text-center alert-success" role="alert"
				onclick="home()">
				<h2>
					<b>ISG Beauty</b>
				</h2>
				<p>
					<b>관리자 회원가입 화면입니다.</b>
				</p>
			</div>
		</div>

		<div class="container">
			<div class="row">
				<div class=" form-inline form-group">
					<label for="empId" class="col-sm-2 col-sm-offset-1 control-label">아이디*:</label>
					<div class="col-md-3">
						<input type="text" class="form-control" id="empId" name="empId">
					</div>

					<label for="empPassword"
						class="col-sm-2 col-sm-offset-1 control-label">비밀번호*:</label>
					<div class="col-md-3">
						<input type="text" class="form-control" id="empPassword"
							name="empPassword">
					</div>
				</div>

				<div class="form-inline form-group">
					<label for="empNm" class="col-sm-2 col-sm-offset-1 control-label">이름*:</label>
					<div class="col-md-3">
						<input type="text" class="form-control" id="empNm" name="empNm">
					</div>

					<label for="telno" class="col-sm-2 col-sm-offset-1 control-label">전화번호*:</label>
					<div class="col-md-3">
						<input type="text" class="form-control" id="telno" name="telno">
					</div>
				</div>

				<div class="form-inline form-group">
					<label for="sexdstn" class="col-sm-2 col-sm-offset-1 control-label">성별*:</label>
					<div class="col-md-3">
						<input type="text" class="form-control" id="sexdstn"
							name="sexdstn">
					</div>

					<label for="pspofc" class="col-sm-2 col-sm-offset-1 control-label">직책:</label>
					<div class="col-md-3">
						<input type="text" class="form-control" id="pspofc" name="pspofc">
					</div>
				</div>

				<div class="form-inline form-group">
					<label for="salary" class="col-sm-2 col-sm-offset-1 control-label">급여:</label>
					<div class="col-md-3">
						<input type="text" class="form-control" id="salary" name="salary">
					</div>

					<label for="career" class="col-sm-2 col-sm-offset-1 control-label">경력:</label>
					<div class="col-md-3">
						<input type="text" class="form-control" id="career" name="career">
					</div>
				</div>

				<div class="form-inline form-group">
					<label for="registId"
						class="col-sm-2 col-sm-offset-1 control-label">등록자*:</label>
					<div class="col-md-3">
						<input type="text" class="form-control" id="registId"
							name="registId">
					</div>

					<label for="updtId" class="col-sm-2 col-sm-offset-1 control-label">수정자:</label>
					<div class="col-md-3">
						<input type="text" class="form-control" id="updtId" name="updtId">
					</div>
				</div>
			</div>
		</div>

		<div class="container" style="text-align: center; margin-top:30px;">
			<button type="button" class="btn btn-success" onclick="saveEmp()">등록</button>
			<button type="button" class=" btn btn-info" onclick="home()">취소</button>
		</div>

	</form:form>
</body>
</html>