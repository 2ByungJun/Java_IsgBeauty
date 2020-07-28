
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

<!-- Bootstrap -->
<link rel="stylesheet"
	href="<c:url  value='css/bootstrap/css/bootstrap.min.css'/>">
<script src="<c:url value='js/jquery-3.4.1.min.js' />"></script>
<script src="<c:url value='css/bootstrap/js/bootstrap.min.js'/>"></script>

<!-- Validation -->
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/additional-methods.min.js"></script>

<!-- fileInput -->
	<link rel="stylesheet" href="<c:url  value='fileinput/css/fileinput-rtl.css'/>">
	<link rel="stylesheet" href="<c:url  value='fileinput/css/fileinput-rtl.min.css'/>">
	<link rel="stylesheet" href="<c:url  value='fileinput/css/fileinput.css'/>">
	<link rel="stylesheet" href="<c:url  value='fileinput/css/fileinput.min.css'/>">
	<script src="<c:url value='fileinput/js/fileinput.js' />"></script>
	<script src="<c:url value='fileinput/js/fileinput.min.js' />"></script>

<!-- JS -->
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
					required : true,
					minlength : 3,
					idchk : true
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
					minlength : 12,
					regex : "^(010)[-\\s]?\\d{3,4}[-\\s]?\\d{4}$"
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
					minlength : "아이디는 최소 3글자 이상입니다.",
					idchk : "이미 존재하는 ID입니다."
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
					minlength : "휴대폰 번호를 완전히 입력해주세요.",
					regex : "휴대폰 번호 양식을 제대로 입력해주세요."
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

	$.validator.addMethod("regex", function(value, element, regexp) {
		let re = new RegExp(regexp);
		let res = re.test(value);
		console.log(res, value, regexp, re)
		return res;
	})

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

	function empIdCheck() {
		if ($("#empId").val() == '') {
			alert("ID를 입력해주세요.");
			return;
		}

		var url = "<c:url value='/IdChecking.json'/>";
		var jsonData = {
			"empId" : $("#empId").val()
		};

		$.ajax({
			headers : {
				Accept : "application/json;utf-8"
			},
			contentType : "application/json;utf-8",
			dataType : "json",
			type : "POST",
			url : url,
			data : JSON.stringify(jsonData),
			success : function(data) {
				console.log(data);

				if (data.result == "true") {
					$("#idCheck").val("true");
				} else {
					$("#idCheck").val("false");
				}

			},
			error : function(e) {
				console.log(e.status, e.statusText);
				alert("서버 오류 입니다. 관리자에게 문의하세요.");
			}
		});
	}

	$.validator.addMethod("idchk", function(value, element) {
		empIdCheck();
		if ($("#idCheck").val() == "true") {
			return true;
		} else {
			return false;
		}
	})

	function numkeyCheck(e) {
		var keyValue = event.keyCode;
		if( ((keyValue < 48) || (keyValue > 57)) )
			return false;
		else {
			return true;
			}
		}

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
	margin-top:10px;
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
			<h2 style="text-align:center;">
					<b>직원 등록</b>
			</h2>

			<!-- Contents -->
			<div style="width: 100%; display: inline-flex; padding-bottom: 2px">

				<!-- Start(35%) -->
				<div style="width: 35%;"></div>

				<!-- Center(10%) -->
				<div style="width: 10%; text-align: center; display: grid">
					<label class="control-label">아이디 : </label>
					<label class="control-label">비밀번호:</label>
					<label class="control-label">이름:</label>
					<label class="control-label">전화번호:</label>
					<label class="control-label">성별:</label>
					<label class="control-label">직책:</label>
					<label class="control-label">급여:</label>
					<label class="control-label">경력:</label>
					<label class="control-label">등록자:</label>
					<label class="control-label">등록일:</label>
				</div>

				<!-- End(60%) -->
				<div style="width: 60%; text-align: left; display: grid">
					<!-- 아이디 -->
					<div style="display: inline-flex;">
						<input type="text" class="bjWidth form-control" id="empId" name="empId" required>
					</div>

					<!-- 비밀번호 -->
					<div style="display: inline-flex;">
						<input type="password" class="bjWidth form-control" id="empPassword" name="empPassword" required>
					</div>

					<!-- 이름 -->
					<div style="display: inline-flex;">
						<input type="text" class="bjWidth form-control" id="empNm" name="empNm" required>
					</div>

					<!-- 전화번호 -->
					<div style="display: inline-flex;">
						<input type="text" class="bjWidth form-control" id="telno" name="telno" placeholder="000-0000-0000" maxlength="13" onkeyup="inputPhoneNumber(this)" required>
					</div>

					<!-- 성별 -->
					<div style="display: inline-flex;">
						<select type="text" class="bjWidth form-control" id="sexdstn"
							name="sexdstn">
							<option value="Male" selected="selected">Male</option>
							<option value="Female">Female</option>
						</select>
					</div>

					<!-- 직책 -->
					<div style="display: inline-flex;">
						<select type="text" class="bjWidth form-control" id="pspofc" name="pspofc">
							<option value="Admin" selected="selected">Admin</option>
							<option value="Designer">Designer</option>
						</select>
					</div>

					<!-- 급여 -->
					<div style="display: inline-flex;">
						<input type="text" class="bjWidth form-control" id="salary" name="salary" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" required>
					</div>

					<!-- 경력 -->
					<div style="display: inline-flex;">
						<input type="text" class="bjWidth form-control" id="career" name="career" required>
					</div>

					<!-- 등록자 -->
					<div style="display: inline-flex;">
						<input type="text" class="bjWidth form-control" id="registId" name="registId" value="${empId}" readonly>
					</div>

					<!-- 등록일 -->
					<div style="display: inline-flex;">
						<input type="date" class="bjWidth form-control" id="registDt" name="registDt" value="<%=today%>" readonly>
					</div>
				</div>
			</div>
		</div>

		<!-- 이미지 -->
		<div class="container" style="width:50%; text-align:center; font-stretch:semi-condensed;">
			<label class="control-label">프로필 사진</label>
			<input id="img" name="img" type="file" class="bjWidth file" multiple
    data-show-upload="false" data-show-caption="true" data-browse-on-zone-click="true">
		</div>

		<!-- Button -->
		<div class="container" style="text-align: center; margin-top: 30px;">
			<button type="submit" class="btn btn-primary" onclick="">등록</button>
			<button type="button" class=" btn btn-info" onclick="home()">취소</button>
		</div>
		<!-- ID Check input -->
		<input type="hidden" id="idCheck" name="idCheck" value="false" readonly>

	</form:form>
</body>
</html>