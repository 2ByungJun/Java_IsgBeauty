<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>IsgBeauty 프로젝트</title>
<link rel="stylesheet"
	href="<c:url  value='css/bootstrap/css/bootstrap.min.css'/>">
<script src="<c:url value='js/jquery-3.4.1.min.js' />"></script>
<script src="<c:url value='css/bootstrap/js/bootstrap.min.js'/>"></script>
</head>
<script type="text/javaScript" language="javascript" defer="defer">


	$(document).ready(function() {

		<%  String str = (String) session.getAttribute("empId");
		 if(str != null) {
		%> location.href = "<c:url value='/mberList.do'/>";
		<% } %>
	});



	function login() {
		var url  =  "<c:url value='/loginCheck.json'/>";
		var jsonData = {"empId": $("#email").val(), "empPassword": $("#pwd").val()};

		$.ajax({
			headers: {
				Accept: "application/json;utf-8"
			}
			,contentType: "application/json;utf-8"
			,dataType: "json"
			,type: "POST"
			,url: url
			,data: JSON.stringify(jsonData)
			,success:function(data){
				console.log(data);
				if(data.result=="idError") {
					alert("아이디 혹은 비밀번호를 확인하세요.");
				}else if(data.result=="pwdError") {
					alert("아이디 혹은 비밀번호를 확인하세요.");
				}else {
					location.href = "<c:url value='/mberList.do'/>";
				}
			}
		})
	}


	function home() {
		location.href = "<c:url value='/mberList.do'/>";
	}
	function empRegister() {
		location.href = "<c:url value='/loginEmpRegister.do'/>";
	}
</script>
<body>
	<div class="container">
		<div class="jumbotron text-center alert-info" style="margin-top: 30px"
			role="alert">
			<h2>
				<b>ISG Beauty</b>
			</h2>
			<p>
				<b>로그인/직원 등록</b>
			</p>
		</div>
	</div>

		<form class="form-horizontal" style="align: center;"action="/action_page.php">
		<div class="form-group">
			<label class="control-label col-sm-4" for="email">ID:</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" id="email" name="email"
					placeholder="아이디를 입력해주세요">
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-4" for="pwd">Password:</label>
			<div class="col-sm-4">
				<input type="password" class="form-control" id="pwd" name="pwd"
					placeholder="비밀번호를 입력해주세요">
			</div>
		</div>
	</form>

</body>


<div class="container" style="text-align: center;">
	<button type="button" class="btn btn-info" onclick="login()">로그인</button>
	<button type="button" class=" btn btn-success" onclick="empRegister()">회원가입</button>
</div>


</body>
</html>