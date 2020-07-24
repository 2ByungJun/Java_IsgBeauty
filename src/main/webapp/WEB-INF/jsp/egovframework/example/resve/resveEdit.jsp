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
	function resveView() {
		location.href = "<c:url value='/resveView.do'/>";
	}

	function deleteResve(id) {
		var check;
		check = confirm("정말로 해당 예약을 삭제하시겠습니까?");

		if (check) {
			alert("삭제되었습니다.");
			document.detailForm.selectedId.value = id;
			document.detailForm.action = "<c:url value='/deleteResve.do'/>";
			document.detailForm.submit();
		} else {
			alert("취소하셨습니다.");
		}
	}

	$(function() {
		$("#detailForm").validate({
			submitHandler : function() {
				var check = confirm("예약을 수정하시겠습니까?");
				if (check) {
					alert("수정되었습니다.");
					frm = document.detailForm;
					frm.action = "<c:url value= '/updateResve.do'/>";
					frm.submit();
				} else {
					alert("취소하셨습니다.");
				}
			}
		});
		$.extend($.validator.messages, {
			required : "필수 항목입니다."
		});
	});
</script>
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
	<%
		Date now = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		String today = sf.format(now);
	%>

	<form:form commandName="resveVO" id="detailForm" name="detailForm"
		method="post">
		<input type="hidden" name="selectedId" />
		<div class="container">
			<h2 style="text-align: center;">
				<b><span style="color:#000080;">'<c:out value="${result.mberNm}" />'</span>고객님 예약변경
				</b>
			</h2>

			<!-- Contents -->
			<div style="width: 100%; display: inline-flex; padding-bottom: 2px">

				<!-- Start(35%) -->
				<div style="width: 35%;"></div>

				<!-- Center(10%) -->
				<div style="width: 10%; text-align: center; display: grid;">
					<label class="bjLabel control-label">예약자 : </label>
					<label class="bjLabel control-label">시술:</label>
					<label class="bjLabel control-label">예약일시:</label>
					<label class="bjLabel control-label">예약시간:</label>
					<label class="bjLabel control-label">등록자:</label>
					<label class="bjLabel control-label">등록일:</label>
					<label class="bjLabel control-label">처리상태:</label>
				</div>

				<!-- End(60%) -->
				<div style="width: 60%; text-align: left; display: grid">
					<!-- 이름 -->
					<div style="display: inline-flex;">
							<input type="text" class="bjInput form-control" value="<c:out value="${result.mberNm}" />" readonly>
					</div>

					<!-- 시술 -->
					<select class="bjInput form-control" id="tretmentNm" name="tretmentNm"
							required>
							<option value="${result.tretmentNm}" selected>${result.tretmentNm}</option>
							<option value="cut">cut</option>
							<option value="perm">perm</option>
							<option value="special">special</option>
						</select>

					<!-- 예약일시 -->
					<div style="display: inline-flex;">
							<input type="date" class="bjInput form-control" id="resveDt" name="resveDt" value="${result.resveDt}" required>
					</div>

					<!-- 예약시간 -->
					<div style="display: inline-flex;">
						<input type="time" class="bjInput form-control" id="resveTime" name="resveTime" value="${result.resveTime}" required>
					</div>

					<!-- 등록자 -->
					<div style="display: inline-flex;">
						<input type="text" class="bjInput form-control" id="registId" name="registId" value="${result.registId}" readonly>
					</div>

					<!-- 등록일 -->
					<div style="display: inline-flex;">
						<input type="date" class="bjInput form-control" id="registDt" name="registDt" value="${result.registDt}" readonly>
					</div>

					<!-- 처리상태 -->
					<select class="bjInput form-control" id="processSttus" name="processSttus">
							<option value="${result.processSttus}" selected>${result.processSttus}</option>
							<option value="Y">Y</option>
							<option value="N">N</option>
						</select>
				</div>
			</div>

		</div>

		<!-- Button -->
		<div class="container" style="text-align: center; margin-top: 30px;">
			<button type="submit" class="btn btn-primary" onclick="">수정</button>
			<button type="button" class="btn btn-danger"
				onclick="deleteResve('${result.resveSn}')">삭제</button>
			<button type="button" class=" btn btn-info" onclick="resveView()">이전</button>
		</div>

		<!-- Hidden -->
		<input type="hidden" class="form-control" id="resveSn" name="resveSn"
			value="<c:out value="${result.resveSn}" />" readonly>
	</form:form>
</body>
</html>

