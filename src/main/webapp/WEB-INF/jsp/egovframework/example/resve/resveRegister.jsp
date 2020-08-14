<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
	Date now = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
	String today = sf.format(now);
%>

<!-- CSS -->
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


<!-- JSP -->
<form:form commandName="mberVO" id="detailForm" name="detailForm" method="post">
	<!-- hidden -->
	<input type="hidden" id="mberSn" name="mberSn" value="<c:out value="${result.mberSn}" />">
	<input type="hidden" id="processSttus" name="processSttus" value="N">

	<!-- body -->
	<div class="container">

		<!-- title -->
		<h2 style="text-align: center;"><b><span style="color:#000080;">'${result.mberNm}'</span>님의 예약 등록</b></h2>

		<!-- contents -->
		<div style="width: 100%; display: inline-flex; padding-bottom: 2px">

			<!-- (35%) -->
			<div style="width: 35%;"></div>

			<!-- label (10%) -->
			<div style="width: 10%; text-align: center;">
				<label class="control-label">예약자 : </label>
				<label class="control-label">시술:</label>
				<label class="control-label">*예약일시:</label>
				<label class="control-label">*예약시간:</label>
				<label class="control-label">등록자:</label>
				<label class="control-label">등록일:</label>
			</div>

			<!-- input (60%) -->
			<div style="width: 60%; text-align: left; display: grid">
				<!-- 이름 -->
				<div style="display: inline-flex;"><input type="text" class="bjWidth form-control" value="<c:out value="${result.mberNm}" />" readonly></div>

				<!-- 시술 -->
				<select class="bjWidth form-control" id="tretmentNm" name="tretmentNm" required>
						<option value="cut">컷팅</option>
						<option value="perm">펌</option>
						<option value="special">특수</option>
				</select>

				<!-- 예약일시 -->
				<div style="display: inline-flex;"><input type="date" class="bjWidth form-control" id="resveDt" name="resveDt" required></div>

				<!-- 예약시간 -->
				<div style="display: inline-flex;"><input type="time" class="bjWidth form-control" id="resveTime" name="resveTime" required></div>

				<!-- 등록자 -->
				<div style="display: inline-flex;"><input type="text" class="bjWidth form-control" id="registId" name="registId" value="${empId}" readonly></div>

				<!-- 등록일 -->
				<div style="display: inline-flex;"><input type="date" class="bjWidth form-control" id="registDt" name="registDt" value="<%=today%>" readonly></div>
			</div>
		</div>
	</div>

	<!-- button -->
	<div class="container" style="text-align: center; margin-top: 30px">
		<button type="submit" class="btn btn-primary" onclick="">예약등록</button>
		<button type="button" class="btn btn-info" onclick="mberList()">취소</button>
	</div>

</form:form>

<!-- JS -->
<script type="text/javaScript" defer="defer">
	function mberList() {
		document.detailForm.action = "<c:url value= '/mberList.do'/>";
		document.detailForm.submit();
	}

	/* Validation */
	$(function() {
		$("#detailForm").validate({
			submitHandler : function() {
				var check = confirm("예약하시겠습니까?");
				if (check) {
					document.detailForm.action = "<c:url value= '/addResve.do'/>";
					document.detailForm.submit();
					alert("예약되었습니다.");
				} else {
					document.detailForm.action = "<c:url value= '/mberList.do'/>";
					document.detailForm.submit();
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
