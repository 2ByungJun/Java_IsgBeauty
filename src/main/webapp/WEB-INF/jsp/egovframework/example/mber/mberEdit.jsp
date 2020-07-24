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

<!-- Bootstrap JS -->
<link rel="stylesheet"
	href="<c:url  value='css/bootstrap/css/bootstrap.min.css'/>">
<script src="<c:url value='js/jquery-3.4.1.min.js' />"></script>
<script src="<c:url value='css/bootstrap/js/bootstrap.min.js'/>"></script>

<!-- Validation JS -->
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/additional-methods.min.js"></script>

<!-- JS -->
<script type="text/javaScript" language="javascript" defer="defer">
	/**** 고객 삭제 *****/
	function deleteMber(id) {
		var check;
		check = confirm("정말로 해당 고객님을 삭제하시겠습니까?");

		if (check) {
			document.detailForm.selectedId.value = id;
			document.detailForm.action = "<c:url value='/deleteMber.do'/>";
			document.detailForm.submit();
		} else {
			alert("취소하셨습니다.");
		}
	}

	/**** 고객 상세보기 *****/
	function view(id) {
		document.detailForm.selectedId.value = id;
		document.detailForm.action = "<c:url value='/mberView.do'/>";
		document.detailForm.submit();
	}

	/**** Validation *****/
	$(function() {
		$("#detailForm").validate({
			submitHandler : function() {
				var check = confirm("수정된 정보를 저장하시겠습니까?");
				if (check) {
					alert("저장되었습니다.");
					frm = document.detailForm;
					frm.action = "<c:url value= '/updateMber.do'/>";
					frm.submit();
				} else {
					alert("취소하셨습니다.");
				}
			},
			rules: {
				mberNm: {
					required : true
				},
				telno: {
					required : true,
					minlength : 12,
					regex : "^(010)[-\\s]?\\d{3,4}[-\\s]?\\d{4}$"
				},
				brthdy : {
					required : true
				}
			},
			messages: {
				mberNm : {
					required : "필수 입력 항목입니다."
				},
				telno : {
					required : "필수 입력 항목입니다.",
					minlength : "휴대폰 번호를 완전히 입력해주세요.",
					regex : "휴대폰 번호 양식을 제대로 입력해주세요."
				},
				brthdy : {
					required : "필수 입력 항목입니다."
				}
			}, onkeyup : false, onfocusout : false
		});
	});

	/**** 전화번호 정규식 *****/
	$.validator.addMethod("regex", function(value, element, regexp) {
		let re = new RegExp(regexp);
		let res = re.test(value);
		console.log(res, value, regexp, re)
		return res;
	});

	/**** 전화번호 Validation *****/
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

<!-- CSS -->
<style>
input.error {
	border: 1px solid red;
}

label.error {
	color: red;
	margin-top: 33px;
	margin-left: 10px;
}
.bjLabel {
	margin-top: 30px;
}

.bjInput {
	width: 200px;
	margin-top: 24px;
}
</style>
</head>

<body>
	<!-- Today -->
	<%
		Date now = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		String today = sf.format(now);
	%>

	<form:form commandName="mberVO" id="detailForm" name="detailForm"
		method="post">
		<input type="hidden" name="selectedId" />
		<div class="container">
			<h2 style="text-align: center;">
				<b><span style="color:#000080;">'<c:out value="${result.mberNm}" />'</span>님 수정화면</b>
			</h2>

			<!-- Contents -->
			<div style="width: 100%; display: inline-flex; padding-bottom: 2px">

				<!-- Start(35%) -->
				<div style="width: 35%;"></div>

				<!-- Center(10%) -->
				<div style="width: 10%; text-align: center; display: grid;">
					<label class="bjLabel control-label">이름 : </label>
					<label class="bjLabel control-label">담당 직원:</label>
					<label class="bjLabel control-label">전화 번호:</label>
					<label class="bjLabel control-label">성별:</label>
					<label class="bjLabel control-label">생년월일:</label>
					<label class="bjLabel control-label">등록자:</label>
					<label class="bjLabel control-label">등록일:</label>
				</div>

				<!-- End(60%) -->
				<div style="width: 60%; text-align: left; display: grid">
					<!-- 이름 -->
					<div style="display: inline-flex;">
							<input type="text" class="bjInput form-control" id="mberNm" name="mberNm"
								value="<c:out value="${result.mberNm}" />" required>
					</div>

					<!-- 담당 직원 -->
					<select type="text" class="bjInput form-control" id="eEmpId" name="eEmpId">
							<option value="${result.eEmpId}"><c:out value="${result.empNm}" /></option>
							<c:forEach var="listEmpNM" items="${listEmpNM}"
								varStatus="status">
								<option value="${listEmpNM.empId}">${listEmpNM.empNm}</option>
							</c:forEach>
						</select>

					<!-- 전화 번호 -->
					<div style="display: inline-flex;">
							<input type="text" class="bjInput form-control" id="telno" name="telno" value="${result.telno}"
								placeholder="000-0000-0000" maxlength="13" required onkeyup="inputPhoneNumber(this)">
					</div>

					<!-- 성별 -->
					<div style="display: inline-flex;">
						<select type="text" class="bjInput form-control" id="sexdstn"
							name="sexdstn">
							<option value="${result.sexdstn}"><c:out
									value="${result.sexdstn}" /></option>
							<option value="Male">Male</option>
							<option value="Female">Female</option>
						</select>
					</div>

					<!-- 생년월일 -->
					<div style="display: inline-flex;">
							<input type="text" class="bjInput form-control" id="brthdy" name="brthdy"
								value="${result.brthdy}" required>
					</div>

					<!-- 등록자 -->
					<div style="display: inline-flex;">
							<input type="text" class="bjInput form-control" id="registId"
								name="registId" value="<c:out value="${result.registId}" />"
								readonly>
					</div>

					<!-- 등록일 -->
					<div style="display: inline-flex;">
							<input type="date" class="bjInput form-control" id="registDt"
								name="registDt" value="<c:out value="${result.registDt}"/>"
								readonly>
					</div>
				</div>
			</div>

		</div>

		<!-- Button -->
		<div class="container" style="text-align: center; margin-top: 30px;">
			<button type="submit" class="btn btn-primary" onclick="">수정</button>
			<button type="button" class="btn btn-danger"
				onclick="deleteMber('${result.mberSn}')">삭제</button>
			<button type="button" class=" btn btn-info"
				onclick="view('${result.mberSn}')">이전</button>
		</div>

		<!-- hidden -->
		<input type="hidden" class="form-control" id="updtId" name="updtId"
			value="<c:out value="${result.updtId}"/>" readonly>
		<input type="hidden" class="form-control" id="mberSn" name="mberSn"
			value="<c:out value="${result.mberSn}" />" readonly>

	</form:form>
</body>
</html>

