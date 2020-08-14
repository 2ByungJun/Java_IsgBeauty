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
	margin: 10px;
}

label.error {
	color: red;
}

.bjWidth {
	width:200px;
	margin-top: 3px;
	margin-bottom: 2px;
}
</style>

<!-- JSP -->
<form id="loginForm" name="loginForm" method="post">
	<!-- hidden -->
	<input type="hidden" class="form-control" id="registId" name="registId" value="IsgBeauty">

	<div class="container">

		<!-- title -->
		<h2 style="text-align: center;"><b>관리자 등록</b></h2>

		<!-- contents -->
		<div style="width: 100%; display: inline-flex; padding-bottom: 2px">

			<!-- (35%) -->
			<div style="width: 35%;"></div>

			<!-- label (10%) -->
			<div style="width: 10%; text-align: center; display: grid">
				<label class="control-label">아이디 : </label>
				<label class="control-label">비밀번호:</label>
				<label class="control-label">이름:</label>
				<label class="control-label">전화번호:</label>
				<label class="control-label">성별:</label>
				<label class="control-label">직책:</label>
				<label class="control-label">시리얼키:</label>
				<label class="control-label">등록일:</label>
			</div>

			<!-- input (60%) -->
			<div style="width: 60%; text-align: left; display: grid">
				<!-- 아이디 -->
				<div style="display: inline-flex;"><input type="text" class="bjWidth form-control" id="empId" name="empId" placeholder="아이디를 입력하세요"></div>

				<!-- 비밀번호 -->
				<div style="display: inline-flex;"><input type="password" class="bjWidth form-control" id="empPassword"name="empPassword" placeholder="비밀번호를 입력하세요"></div>

				<!-- 이름 -->
				<div style="display: inline-flex;"><input type="text" class="bjWidth form-control" id="empNm" name="empNm" placeholder="이름을 입력하세요"></div>

				<!-- 전화번호 -->
				<div style="display: inline-flex;"><input type="text" class="bjWidth form-control" id="telno" name="telno" placeholder="000-0000-0000" maxlength="13" onkeyup="inputPhoneNumber(this)" required></div>

				<!-- 성별 -->
				<div style="display: inline-flex;">
					<select class="bjWidth form-control" id="sexdstn" name="sexdstn">
						<option value="Male" selected="selected">남성</option>
						<option value="Female">여성</option>
					</select>
				</div>

				<!-- 직책 -->
				<div style="display: inline-flex;">
					<select class="bjWidth form-control" id="pspofc" name="pspofc">
						<option value="Admin" selected="selected">관리자</option>
					</select>
				</div>

				<!-- 등록일 -->
				<div style="display: inline-flex;"><input type="date" class="bjWidth form-control" id="registDt" name="registDt" value="<%=today%>" readonly></div>
			</div>
		</div>
	</div>

	<!-- button -->
	<div class="container" style="text-align: center; margin-top: 30px;">
		<button type="submit" class="btn btn-primary" onclick="">등록</button>
		<button type="button" class=" btn btn-info" onclick="home()">취소</button>
	</div>

</form>

<!-- JS -->
<script type="text/javaScript" defer="defer">

	function home() {
		location.href = "<c:url value='/login.do'/>";
	}

	/* 글 등록 function */
	$(function() {
		$("#loginForm").validate(
			{
				submitHandler : function() {
					var jsonData = $("#loginForm").serializeJSON();
					var check = confirm("관리자를 등록하시겠습니까?");
					if (check) {
						 $.ajax({
								headers: {
									Accept: "application/json;utf-8"
								}
								,contentType: "application/json;utf-8"
								,dataType: "json"
								,type: "POST"
								,async:false
								,url:  "<c:url value='/addAdmin.json'/>"
								,data: JSON.stringify(jsonData)
								,success:function(data){
									alert("등록되었습니다. 가입한 정보로 로그인 해 주세요.");
									home();
								}
								,error:function(e){
								   	alert("서버 오류 입니다. 관리자에게 문의하세요.");
								}
							});
					}
				},
				rules : {
					empId : {
						required : true,
						minlength : 3,
						idchk : true
					},
					empPassword : {
						required : true,
						minlength : 4
					},
					empNm : {
						required : true
					},
					telno : {
						required : true,
						minlength : 12,
						regex : "^(010)[-\\s]?\\d{3,4}[-\\s]?\\d{4}$"
					}/* ,
					snKey : {
						required : true,
						snchk : true
					} */
				},
				messages : {
					empId : {
						required : "필수 입력 항목입니다.",
						minlength : "아이디는 최소 3글자 이상입니다.",
						idchk : "이미 존재하는 ID입니다."
					},
					empPassword : {
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
					}
					/* snKey : {
						required : "필수 입력 항목입니다.",
						snchk : "시리얼 키가 일치하지 않습니다."
					} */
				}
			});
	});


	function snKeyCehck() {
		var url = "<c:url value='/addAdminCheck.json'/>";
		var jsonData = {
			"snKey" : $("#snKey").val()
		};
		var snchk;
		$.ajax({
			headers : {
				Accept : "application/json;utf-8"
			},
			contentType : "application/json;utf-8",
			dataType : "json",
			type : "POST",
			url : url,
			async : false,
			data : JSON.stringify(jsonData),
			success : function(data) {
				if (data.result == "true") {
					snchk=true;
				} else {
					snchk=false;
				}
			},
			error : function(e) {
				alert("서버 오류 입니다. 관리자에게 문의하세요.");
			}
		});
		return snchk;
	}

	function empIdCheck() {
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
			async : false,
			data : JSON.stringify(jsonData),
			success : function(data) {
				if (data.result == "true") {
					idchk = true;
				} else {
					idchk = false;
				}

			},
			error : function(e) {
				alert("서버 오류 입니다. 관리자에게 문의하세요.");
			}
		});
		return idchk;
	}

</script>