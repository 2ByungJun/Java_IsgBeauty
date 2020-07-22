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



	/* 글 등록 function */
	$(function() {
		$("#detailForm").validate({
			submitHandler : function() {
				var check = confirm("해당 직원을 등록하시겠습니까?");
				if (check) {
					alert("등록되었습니다.");
					frm = document.detailForm;
					frm.action = "<c:url value= '/addEmp.do'/>";
					frm.submit();
				} else {
					alert("취소하셨습니다.");
				}
			},
			rules: {
				empId: {
					required : true
				},
				empPassword: {
					required : true,
					minlength : 4
				},
				empNm: {
					required : true
				},
				telno: {
					required : true,
					minlength : 13
					/* digits : true */
				},
				salary: {
					required : true,
					digits : true
				},
				career: {
					required : true
				}
			},
			messages: {
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
					/* digits : "숫자만 입력할 수 있습니다." */
					minlength : "휴대폰 번호를 완전히 입력해주세요."
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

	function inputPhoneNumber(obj) {

	    var number = obj.value.replace(/[^0-9]/g, "");
	    var phone = "";

	    if(number.length < 4) {
	        return number;
	    } else if(number.length < 7) {
	        phone += number.substr(0, 3);
	        phone += "-";
	        phone += number.substr(3);
	    } else if(number.length < 11) {
	        phone += number.substr(0, 3);
	        phone += "-";
	        phone += number.substr(3, 3);
	        phone += "-";
	        phone += number.substr(6);
	    } else {
	        phone += number.substr(0, 3);
	        phone += "-";
	        phone += number.substr(3, 4);
	        phone += "-";
	        phone += number.substr(7);
	    }
	    obj.value = phone;
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
	<form:form commandName="empVO" id="detailForm" name="detailForm"
		method="post">
		<div class="container">
			<div class="jumbotron text-center alert-success"
				style="margin-top: 30px" role="alert" onclick="home()">
				<h2>
					<b>ISG Beauty</b>
				</h2>
				<p>
					<b>관리자/직원 등록 화면입니다.</b>
				</p>
			</div>
		</div>

		<div class="container">
			<div class="row">
				<div class=" form-inline form-group">
					<label for="empId" class="col-sm-2 col-sm-offset-1 control-label">아이디*:</label>
					<div class="col-md-3">
						<input type="text" class="form-control" id="empId" name="empId"
							required>
					</div>

					<label for="empPassword"
						class="col-sm-2 col-sm-offset-1 control-label">비밀번호*:</label>
					<div class="col-md-3">
						<input type="password" class="form-control" id="empPassword"
							name="empPassword" required>
					</div>
				</div>

				<div class="form-inline form-group">
					<label for="empNm" class="col-sm-2 col-sm-offset-1 control-label">이름*:</label>
					<div class="col-md-3">
						<input type="text" class="form-control" id="empNm" name="empNm"
							required>
					</div>

					<label for="telno" class="col-sm-2 col-sm-offset-1 control-label" >전화번호*:</label>
					<div class="col-md-3">
						<input type="text" class="form-control" id="telno" name="telno" maxlength="13" onkeyup="inputPhoneNumber(this)" required>
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

					<label for="pspofc" class="col-sm-2 col-sm-offset-1 control-label">직책:</label>
					<div class="col-md-3">
						<select type="text" class="form-control" id="pspofc" name="pspofc">
							<option value="Admin" selected="selected">Admin</option>
							<option value="Designer">Designer</option>
						</select>
					</div>
				</div>

				<div class="form-inline form-group">
					<label for="salary" class="col-sm-2 col-sm-offset-1 control-label">급여:</label>
					<div class="col-md-3">
						<input type="text" class="form-control" id="salary" name="salary"
							value="" required>
					</div>

					<label for="career" class="col-sm-2 col-sm-offset-1 control-label">경력:</label>
					<div class="col-md-3">
						<input type="text" class="form-control" id="career" name="career"
							value="" required>
					</div>
				</div>

				<div class="form-inline form-group">
					<label for="registId"
						class="col-sm-2 col-sm-offset-1 control-label">등록자*:</label>
					<div class="col-md-3">
						<input type="text" class="form-control" id="registId"
							name="registId" value="test" readonly>
					</div>

					<label for="updtId" class="col-sm-2 col-sm-offset-1 control-label">등록일:</label>
					<div class="col-md-3">
						<input type="date" class="form-control" id="registDt"
							name="registDt" value="<%=today%>" readonly>
					</div>
				</div>
			</div>
		</div>

		<div class="container" style="text-align: center; margin-top: 30px;">
			<button type="submit" class="btn btn-success" onclick="">등록</button>
			<button type="button" class=" btn btn-info" onclick="home()">취소</button>
		</div>

	</form:form>
</body>
</html>