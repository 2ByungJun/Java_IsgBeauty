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
		location.href = "<c:url value='/empList.do'/>";
	}
	function deleteEmp(id) {
		document.detailForm.selectedId.value = id;
		document.detailForm.action = "<c:url value='/deleteEmp.do'/>";
       	document.detailForm.submit();
	}

</script>
<style>
label {
	margin-top: 30px;
}

p {
	margin-top: 30px;
}
</style>
</head>
<body>
	<form:form commandName="empVO" id="detailForm" name="detailForm"
		method="post">
		<input type="hidden" name="selectedId" />
		<div class="container">
			<div class="jumbotron text-center alert-info" role="alert"
				onclick="home()">
				<h2>
					<b>ISG Beauty</b>
				</h2>
				<h4 for="empId" class="control-label">
					'
					<c:out value="${result.empNm}" />
					'직원 상세화면
				</h4>
			</div>
		</div>
		<div class="container">
			<div class="row">
				<div class="form-inline form-group">
					<label for="empId" class="col-sm-2 col-sm-offset-1 control-label">아이디:</label>
					<div class="col-sm-3">
						<p for="empId" class="control-label">
							<c:out value="${result.empId}" />
						</p>
					</div>

					<label for="empPassword" class="col-sm-2 col-sm-offset-1 control-label">비밀번호:</label>
					<div class="col-sm-3">
						<p for="empPassword" class="control-label" >
							<c:out value="${result.empPassword}" />
						</p>
					</div>
				</div>

				<div class="form-inline form-group">
					<label for="empNm" class="col-sm-2 col-sm-offset-1 control-label">이름:</label>
					<div class="col-sm-3">
						<p for="empNm" class="control-label">
							<c:out value="${result.empNm}" />
						</p>
					</div>

					<label for="telno"
						class="col-sm-2 col-sm-offset-1 control-label">전화번호:</label>
					<div class="col-sm-3">
						<p for="telno" class="control-label">
							<c:out value="${result.telno}" />
						</p>
					</div>
				</div>

				<div class="form-inline form-group">
					<label for="sexdstn" class="col-sm-2 col-sm-offset-1 control-label">성별:</label>
					<div class="col-sm-3">
						<p for="mberSn" class="control-label">
							<c:out value="${result.sexdstn}" />
						</p>
					</div>

					<label for="pspofc"
						class="col-sm-2 col-sm-offset-1 control-label">직책:</label>
					<div class="col-sm-3">
						<p for="pspofc" class="control-label">
							<c:out value="${result.pspofc}" />
						</p>
					</div>
				</div>

				<div class="form-inline form-group">
					<label for="salary" class="col-sm-2 col-sm-offset-1 control-label">급여:</label>
					<div class="col-sm-3">
						<p for="salary" class="control-label">
							<c:out value="${result.salary}" />
						</p>
					</div>

					<label for="career" class="col-sm-2 col-sm-offset-1 control-label">경력:</label>
					<div class="col-sm-3">
						<p for="career" class="control-label">
							<c:out value="${result.career}" />
						</p>
					</div>
				</div>

				<div class="form-inline form-group">
					<label for="registId" class="col-sm-2 col-sm-offset-1 control-label">등록자:</label>
					<div class="col-sm-3">
						<p for="registId" class="control-label">
							<c:out value="${result.registId}" />
						</p>
					</div>

					<label for="updtId" class="col-sm-2 col-sm-offset-1 control-label">수정자:</label>
					<div class="col-sm-3">
						<p for="updtId" class="control-label">
							<c:out value="${result.updtId}" />
						</p>
					</div>
				</div>
			</div>
		</div>

		<div class="container" style="text-align: center; margin-top: 30px;">
			<button type="button" class="btn btn-success" onclick="">수정</button>
			<button type="button" class="btn btn-danger" onclick="deleteEmp('${result.empId}')">삭제</button>
			<button type="button" class=" btn btn-info" onclick="home()">이전</button>
		</div>

	</form:form>
</body>
</html>