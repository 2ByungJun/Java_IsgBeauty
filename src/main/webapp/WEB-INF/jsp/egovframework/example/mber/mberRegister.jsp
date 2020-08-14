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
<form:form commandName="mberVO" id="registerForm" name="registerForm" method="post">

	<!-- body -->
	<div class="container">

		<!-- title -->
		<h2 style="text-align: center; margin-bottom: 40px;"><b>고객 등록</b></h2>

		<!-- contents -->
		<div style="width: 100%; display: inline-flex; padding-bottom: 2px">

			<!-- (35%) -->
			<div style="width: 35%;"></div>

			<!-- label (10%) -->
			<div style="width: 10%; text-align: center;">
				<label class="control-label">이름 : </label>
				<label class="control-label">담당 직원:</label>
				<label class="control-label">전화 번호:</label>
				<label class="control-label">성별:</label>
				<label class="control-label">생년월일:</label>
				<label class="control-label">등록자:</label>
				<label class="control-label">등록일:</label>
			</div>

			<!-- input (60%) -->
			<div style="width: 60%; text-align: left; display: grid">
				<!-- 이름 -->
				<div style="display: inline-flex;"><input type="text" class="bjWidth form-control" id="mberNm" name="mberNm" placeholder="이름을 입력하세요" maxlength="4" required></div>

				<!-- 담당 직원 -->
				<select class="bjWidth form-control" id="eEmpId" name="eEmpId">
					<c:forEach var="result" items="${listEmpNM}" varStatus="status">
						<option value="${result.empId}">${result.empNm}</option>
					</c:forEach>
				</select>

				<!-- 전화 번호 -->
				<div style="display: inline-flex;"><input type="text" class="bjWidth form-control" id="telno" name="telno" placeholder="000-0000-0000" maxlength="13" onkeyup="inputPhoneNumber(this)" required></div>

				<!-- 성별 -->
				<div style="display: inline-flex;">
					<select class="bjWidth form-control" id="sexdstn" name="sexdstn">
							<option value="Male" selected="selected">남성</option>
							<option value="Female">여성</option>
					</select>
				</div>

				<!-- 생년월일 -->
				<div style="display: inline-flex;"><input type="date" class="bjWidth form-control" id="brthdy" name="brthdy" ></div>

				<!-- 등록자 -->
				<div style="display: inline-flex;"><input type="text" class="bjWidth form-control" id="registId" name="registId" value="${registId}" readonly></div>

				<!-- 등록일 -->
				<div style="display: inline-flex;"><input type="date" class="bjWidth form-control" id="registDt" name="registDt" value="<%=today%>" readonly></div>

			</div>
		</div>
	</div>

	<!-- button -->
	<div class="container" style="text-align: center; margin-top: 30px">
		<button type="submit" class="btn btn-primary" onclick="">등록</button>
		<button type="button" class=" btn btn-info" onclick="mberList()">취소</button>
	</div>

</form:form>

<!-- JS -->
<script type="text/javaScript" defer="defer">
	function mberList() {
		location.href = "<c:url value='/mberList.do'/>";
	}

	/* 글 등록 function */
	$(function() {
		$("#registerForm").validate({
			submitHandler : function() {
				var jsonData = $("#registerForm").serializeJSON();
				var check = confirm("해당 고객님을 등록하시겠습니까?");
				if (check) {
					$.ajax({
						headers: {
							Accept: "application/json;utf-8"
						}
						,contentType: "application/json;utf-8"
						,dataType: "json"
						,type: "POST"
						,async:false
						,url: "<c:url value= '/mberRegister.json'/>"
						,data: JSON.stringify(jsonData)
						,success:function(data){
								alert("등록되었습니다.");
								mberList();
						}
						,error:function(e){
						   	alert("서버 오류 입니다. 관리자에게 문의하세요.")
						}
					});
				}
			},
			rules : {
				mberNm : {
					required : true
				},
				telno : {
					required : true,
					minlength : 12,
					regex : "^(010)[-\\s]?\\d{3,4}[-\\s]?\\d{4}$"
				},
				brthdy : {
					required : true
				}
			},
			messages : {
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
			},
			onkeyup : false,
			onfocusout : false
		});
	});

</script>