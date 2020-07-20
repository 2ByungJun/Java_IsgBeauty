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
		location.href = "<c:url value='/empList.do'/>";
	}
	function deleteMber(id) {
		var check;
		check = confirm("정말로 해당 직원을 삭제하시겠습니까?");

		if (check) {
			alert("삭제되었습니다.");
			document.detailForm.selectedId.value = id;
			document.detailForm.action = "<c:url value='/deleteEmp.do'/>";
			document.detailForm.submit();
		} else {
			alert("취소하셨습니다.");
		}
	}
	function view(id) {
		document.detailForm.selectedId.value = id;
		document.detailForm.action = "<c:url value='/empView.do'/>";
		document.detailForm.submit();
	}
	function update() {
		var check;
		check = confirm("변경된 사항들을 수정하시겠습니까?");

		if (check) {
			alert("변경되었습니다.");
			document.detailForm.action = "<c:url value= '/updateEmp.do'/>";
			document.detailForm.submit();
		} else {
			alert("취소하셨습니다.");
		}
	}
	$(function() {
		$("#detailForm").validate({
			submitHandler : function() {
				var check = confirm("수정된 정보를 저장하시겠습니까?");
				if (check) {
					alert("저장되었습니다.");
					frm = document.detailForm;
					frm.action = "<c:url value= '/updateEmp.do'/>";
					frm.submit();
				} else {
					alert("취소하셨습니다.");
				}
			},
			rules: {
				empId: {
					required : true,
				},
				empPassword: {
					required : true,
					minlength : 4
				},
				empNm : {
					required : true
				},
				telno : {
					required : true,
					digits : true
				},
				salary : {
					required : true,
					digits : true
				},
				career : {
					required : true
				}
			},
			messages : {
				empId: {
					required : "필수 입력 항목입니다.",
				},
				empPassword: {
					required : "필수 입력 항목입니다.",
					minlength : "비밀번호는 최소 4자리 이상입니다."
				},
				empNm : {
					required : "필수 입력 항목입니다."
				},
				telno : {
					required : "필수 입력 항목입니다.",
					digits : "숫자만 입력할 수 있습니다."
				},
				salary : {
					required : "필수 입력 항목입니다.",
					digits : "숫자만 입력할 수 있습니다."
				},
				career : {
					required : "필수 입력 항목입니다."
				}
			}
		});
	});
</script>
<style>
label {
	margin-top: 30px;
}

p {
	margin-top: 30px;
}

select {
	margin-top: 30px;
}
</style>
</head>
<body>
	<%
		Date now = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		String today = sf.format(now);
	%>

	<form:form commandName="empVO" id="detailForm" name="detailForm"
		method="post">
		<input type="hidden" name="selectedId" />
		<div class="container">
			<div class="jumbotron text-center alert-success"
				style="margin-top: 30px" role="alert" onclick="home()">
				<h2>
					<b>ISG Beauty</b>
				</h2>
				<h4 for="empId" class="control-label">
					'
					<c:out value="${result.empNm}" />
					'님 수정화면
				</h4>
			</div>
		</div>
		<div class="container">
			<div class="row">
				<div class="form-inline form-group">
					<label for="empId" class="col-sm-2 col-sm-offset-1 control-label">아이디*:</label>
					<div class="col-sm-3">
						<p for="empId" class="control-label">
							<input type="text" class="form-control" id="empId" name="empId"
								value="<c:out value="${result.empId}"/>" required>
						</p>
					</div>

					<label for="empPassword"
						class="col-sm-2 col-sm-offset-1 control-label">비밀 번호:</label>
					<div class="col-sm-3">
						<p for="empPassword" class="control-label">
							<input type="password" class="form-control" id="empPassword"
								name="empPassword"
								value="<c:out value="${result.empPassword}" />" required>
						</p>
					</div>
				</div>

				<div class="form-inline form-group">
					<label for="empNm" class="col-sm-2 col-sm-offset-1 control-label">이름:</label>
					<div class="col-sm-3">
						<p for="empNm" class="control-label">
							<input type="text" class="form-control" id="empNm" name="empNm"
								value="<c:out value="${result.empNm}" />" required>
						</p>
					</div>

					<label for="telno" class="col-sm-2 col-sm-offset-1 control-label">전화번호:</label>
					<div class="col-sm-3">
						<p for="" telno"" class="control-label">
							<input type="text" class="form-control" id="telno" name="telno"
								value="<c:out value="${result.telno}" />" required>
						</p>
					</div>
				</div>

				<div class="form-inline form-group">
					<label for="sexdstn" class="col-sm-2 col-sm-offset-1 control-label">성별:</label>
					<div class="col-sm-3">
						<select type="text" class="form-control" id="sexdstn"
							name="sexdstn">
							<option value="${result.sexdstn}" selected="selected"><c:out
									value="${result.sexdstn}" /></option>
							<option value="Male">Male</option>
							<option value="Female">Female</option>
						</select>
					</div>

					<label for="pspofc" class="col-sm-2 col-sm-offset-1 control-label">직책:</label>
					<div class="col-sm-3">
						<select type="text" class="form-control" id="pspofc" name="pspofc">
							<option value="${result.pspofc}" selected="selected"><c:out
									value="${result.pspofc}" /></option>
							<option value="Admin">Admin</option>
							<option value="Designer">Designer</option>
						</select>
					</div>
				</div>

				<div class="form-inline form-group">
					<label for="salary" class="col-sm-2 col-sm-offset-1 control-label">급여:</label>
					<div class="col-sm-3">
						<p for="salary" class="control-label">
							<input type="text" class="form-control" id="salary" name="salary"
								value="<c:out value="${result.salary}"/>" required>
						</p>
					</div>

					<label for="career" class="col-sm-2 col-sm-offset-1 control-label">경력:</label>
					<div class="col-sm-3">
						<p for="career" class="control-label">
							<input type="career" class="form-control" id="career"
								name="career" value="<c:out value="${result.career}"/>" required>
						</p>
					</div>
				</div>

				<div class="form-inline form-group">
					<label for="registId"
						class="col-sm-2 col-sm-offset-1 control-label">등록자:</label>
					<div class="col-sm-3">
						<p for="registId" class="control-label">
							<input type="text" class="form-control" id="registId"
								name="registId" value="<c:out value="${result.registId}"/>"
								readonly>
						</p>
					</div>

					<label for="registDt"
						class="col-sm-2 col-sm-offset-1 control-label">등록일:</label>
					<div class="col-sm-3">
						<p for="registDt" class="control-label">
							<input type="date" class="form-control" id="registDt"
								name="registDt" value="<c:out value="${result.registDt}"/>"
								readonly>
						</p>
					</div>
				</div>
				<div class="form-inline form-group">
					<label for="registId"
						class="col-sm-2 col-sm-offset-1 control-label">수정자:</label>
					<div class="col-sm-3">
						<p for="updtId" class="control-label">
							<input type="text" class="form-control" id="updtId" name="updtId"
								value="<c:out value="${result.updtId}"/>" readonly>
						</p>
					</div>

					<label for="updtDt" class="col-sm-2 col-sm-offset-1 control-label">수정일:</label>
					<div class="col-sm-3">
						<p for="updtDt" class="control-label">
							<input type="date" class="form-control" id="updtDt" name="updtDt"
								value="<c:out value="<%=today%>"/>" readonly>
						</p>
					</div>
				</div>

			</div>
		</div>

		<div class="container" style="text-align: center; margin-top: 30px;">
			<button type="submit" class="btn btn-info" onclick="">수정</button>
			<button type="button" class="btn btn-danger"
				onclick="deleteMber('${result.empId}')">삭제</button>
			<button type="button" class=" btn btn-info"
				onclick="view('${result.empId}')">이전</button>
		</div>

	</form:form>
</body>
</html>