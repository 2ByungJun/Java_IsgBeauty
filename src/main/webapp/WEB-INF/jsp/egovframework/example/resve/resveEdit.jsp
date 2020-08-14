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

<!-- JSP -->
<form:form commandName="resveVO" id="detailForm" name="detailForm" method="post">
	<!-- hidden -->
	<form:input path="resveSn" type="hidden" />

	<!-- body -->
	<div class="container">

		<!-- title -->
		<h2 style="text-align: center;"><b><span style="color:#000080;">'<c:out value="${resveVO.mberNm}" />'</span>고객님 예약변경</b></h2>

		<!-- contents -->
		<div style="width: 100%; display: inline-flex; padding-bottom: 2px">

			<!-- (35%) -->
			<div style="width: 35%;"></div>

			<!-- label (10%) -->
			<div style="width: 10%; text-align: center; display: grid;">
				<label class="bjLabel control-label">예약자 : </label>
				<label class="bjLabel control-label">시술:</label>
				<label class="bjLabel control-label">예약일시:</label>
				<label class="bjLabel control-label">예약시간:</label>
				<label class="bjLabel control-label">등록자:</label>
				<label class="bjLabel control-label">등록일:</label>
				<label class="bjLabel control-label">처리상태:</label>
			</div>

			<!-- input (60%) -->
			<div style="width: 60%; text-align: left; display: grid">
				<!-- 이름 -->
				<div style="display: inline-flex;"><form:input path="mberNm" class="bjInput form-control" readonly="true"/></div>

				<!-- 시술 -->
				<select class="bjInput form-control" id="tretmentNm" name="tretmentNm" required>
						<c:if test="${resveVO.tretmentNm eq 'cut'}">
							<option value="cut" selected="selected">컷트</option>
							<option value="perm">펌</option>
							<option value="special">특수</option>
						</c:if>
						<c:if test="${resveVO.tretmentNm eq 'perm'}">
							<option value="cut">컷트</option>
							<option value="perm" selected="selected">펌</option>
							<option value="special">특수</option>
						</c:if>
						<c:if test="${resveVO.tretmentNm eq 'special'}">
							<option value="cut">컷트</option>
							<option value="perm">펌</option>
							<option value="special" selected="selected">특수</option>
						</c:if>
				</select>

				<!-- 예약일시 -->
				<div style="display: inline-flex;"><form:input path="resveDt" type="date" class="bjInput form-control" required="true"/></div>

				<!-- 예약시간 -->
				<div style="display: inline-flex;"><form:input path="resveTime" type="time" class="bjInput form-control" required="true"/></div>

				<!-- 등록자 -->
				<div style="display: inline-flex;"><form:input path="registId" class="bjInput form-control" readonly="true"/></div>

				<!-- 등록일 -->
				<div style="display: inline-flex;"><form:input path="registDt" type="date" class="bjInput form-control" readonly="true"/></div>

				<!-- 처리상태 -->
				<select class="bjInput form-control" id="processSttus" name="processSttus">
						<c:if test="${resveVO.processSttus eq 'Y'}">
							<option value="Y" selected="selected">Y</option>
							<option value="N">N</option>
						</c:if>
						<c:if test="${resveVO.processSttus eq 'N'}">
							<option value="Y">Y</option>
							<option value="N" selected="selected">N</option>
						</c:if>
				</select>
			</div>
		</div>

	</div>

	<!-- button -->
	<div class="container" style="text-align: center; margin-top: 30px;">
		<button type="submit" class="btn btn-primary" onclick="">수정</button>
		<button type="button" class="btn btn-danger" onclick="deleteResve()">삭제</button>
		<button type="button" class="btn btn-info" onclick="resveView()">이전</button>
	</div>

</form:form>

<!-- JS -->
<script type="text/javaScript" defer="defer">
	function resveView() {
		document.detailForm.action = "<c:url value='/resveView.do'/>";
		document.detailForm.submit();
	}

	function deleteResve() {
		var check = confirm("정말로 해당 예약을 삭제하시겠습니까?");
		if (check) {
			document.detailForm.action = "<c:url value='/deleteResve.do'/>";
			document.detailForm.submit();
			alert("삭제되었습니다.");
		}
	}

	$(function() {
		$("#detailForm").validate({
			submitHandler : function() {
				var check = confirm("예약을 수정하시겠습니까?");
				if (check) {
					document.detailForm.action = "<c:url value= '/updateResve.do'/>";
					document.detailForm.submit();
					alert("수정되었습니다.");
				}
			}
		});
		$.extend($.validator.messages, {
			required : "필수 항목입니다."
		});
	});
</script>

