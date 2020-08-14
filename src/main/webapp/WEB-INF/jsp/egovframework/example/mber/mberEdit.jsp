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
<form:form commandName="mberVO" id="editForm" name="editForm" method="post">
	<!-- hidden -->
	<input type="hidden" id="updtId" name="updtId" value="">
	<input type="hidden" id="mberSn" name="mberSn" value="${result.mberSn}">

	<!-- body -->
	<div class="container">
		<!-- title -->
		<h2 style="text-align: center;"><b><span style="color:#000080;">'<c:out value="${result.mberNm}" />'</span>님 수정화면</b></h2>

		<!-- contents -->
		<div style="width: 100%; display: inline-flex; padding-bottom: 2px">

			<!-- (35%) -->
			<div style="width: 35%;"></div>

			<!-- label (10%) -->
			<div style="width: 10%; text-align: center; display: grid;">
				<label class="bjLabel control-label">*이름 : </label>
				<label class="bjLabel control-label">담당 직원:</label>
				<label class="bjLabel control-label">*전화 번호:</label>
				<label class="bjLabel control-label">*성별:</label>
				<label class="bjLabel control-label">*생년월일:</label>
				<label class="bjLabel control-label">등록자:</label>
				<label class="bjLabel control-label">등록일:</label>
			</div>

			<!-- input (60%) -->
			<div style="width: 60%; text-align: left; display: grid">
				<!-- 이름 -->
				<div style="display: inline-flex;"><input type="text" class="bjInput form-control" id="mberNm" name="mberNm" maxlength="4" value="<c:out value="${result.mberNm}" />" required></div>

				<!-- 담당 직원 -->
				<select class="bjInput form-control" id="eEmpId" name="eEmpId">
					<option value="${result.eEmpId}"><c:out value="${result.empNm}" /></option>
					<c:forEach var="listEmpNM" items="${listEmpNM}" varStatus="status">
						<option value="${listEmpNM.empId}">${listEmpNM.empNm}</option>
					</c:forEach>
				</select>

				<!-- 전화 번호 -->
				<div style="display: inline-flex;"><input type="text" class="bjInput form-control" id="telno" name="telno" value="${result.telno}" placeholder="000-0000-0000" maxlength="13" required onkeyup="inputPhoneNumber(this)"></div>

				<!-- 성별 -->
				<div style="display: inline-flex;">
					<select class="bjInput form-control" id="sexdstn" name="sexdstn">
						<c:if test="${result.sexdstn eq 'Male'}">
							<option value="Male" selected="selected">남성</option>
							<option value="Female">여성</option>
						</c:if>
						<c:if test="${result.sexdstn eq 'Female'}" >
							<option value="Male">남성</option>
							<option value="Female" selected="selected">여성</option>
						</c:if>
					</select>
				</div>

				<!-- 생년월일 -->
				<div style="display: inline-flex;"><input type="date" class="bjInput form-control" id="brthdy" name="brthdy" value="${result.brthdy}" required></div>

				<!-- 등록자 -->
				<div style="display: inline-flex;"><input type="text" class="bjInput form-control" id="registId" name="registId" value="<c:out value="${result.registId}" />" readonly></div>

				<!-- 등록일 -->
				<div style="display: inline-flex;"><input type="date" class="bjInput form-control" id="registDt" name="registDt" value="<c:out value="${result.registDt}"/>" readonly></div>

			</div>
		</div>
	</div>

	<!-- button -->
	<div class="container" style="text-align: center; margin-top: 30px;">
		<button type="submit" class="btn btn-primary" onclick="">수정</button>
		<button type="button" class="btn btn-danger" onclick="deleteMber()">삭제</button>
		<button type="button" class=" btn btn-info" onclick="view()">이전</button>
	</div>

</form:form>

<!-- JS -->
<script type="text/javaScript" defer="defer">
	/**** 고객 삭제 *****/
	function deleteMber() {
		var check;
		var jsonData = $("#editForm").serializeJSON();
		check = confirm("정말로 해당 고객님을 삭제하시겠습니까?");
		if (check) {
			$.ajax({
				headers: {
					Accept: "application/json;utf-8"
				}
				,contentType: "application/json;utf-8"
				,dataType: "json"
				,type: "POST"
				,async:false
				,url: "<c:url value= '/mberDelete.json'/>"
				,data: JSON.stringify(jsonData)
				,success:function(data){
						alert("삭제되었습니다.");
						document.editForm.action = "<c:url value='/mberList.do'/>";
						document.editForm.submit();
				}
				,error:function(e){
				   	alert("서버 오류 입니다. 관리자에게 문의하세요.")
				}
			});
		}
	}

	/**** 고객 상세보기 *****/
	function view() {
		document.editForm.action = "<c:url value='/mberView.do'/>";
		document.editForm.submit();
	}

	/**** Validation *****/
	$(function() {
		$("#editForm").validate({
			submitHandler : function() {
				var jsonData = $("#editForm").serializeJSON();
				var check = confirm("수정된 정보를 저장하시겠습니까?");
				if (check) {
					$.ajax({
						headers: {
							Accept: "application/json;utf-8"
						}
						,contentType: "application/json;utf-8"
						,dataType: "json"
						,type: "POST"
						,async:false
						,url: "<c:url value= '/mberEdit.json'/>"
						,data: JSON.stringify(jsonData)
						,success:function(data){
								alert("수정되었습니다.");
								view();
						}
						,error:function(e){
						   	alert("서버 오류 입니다. 관리자에게 문의하세요.")
						}
					});
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
</script>

