<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ include file="/common/layouts/userLayout/commonInclude.jsp"%>

<style>
label {
	margin-top: 10px;
}

input {
	margin-top: 10px;
}

select {
	margin-top: 10px;
}

input.error {
	border: 1px solid red;
}

label.error {
	color: red;
}
</style>

<script type="text/javaScript" language="javascript" defer="defer">
	function home() {
		location.href = "<c:url value='/login.do'/>";
	}

	/* 글 등록 function */
	$(function() {
		$("#detailForm").validate({
			submitHandler : function() {
				if($("#snCheck").val()=="true") {
					var check = confirm("관리자를 등록하시겠습니까?");
					if (check) {
						document.detailForm.action = "<c:url value= '/addAdmin.do'/>";
						document.detailForm.submit();
						alert("등록되었습니다.");
					} else {
						alert("취소하셨습니다.");
					}
				} else {
					alert("시리얼 키를 확인해주세요.");
				}
			},
			rules: {
				empId: {
					required : true,
					minlength : 3,
					idchk: true
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
				snKey: {
					required : true,
					snchk: true
				}
			},
			messages: {
				empId: {
					required : "필수 입력 항목입니다.",
					minlength : "아이디는 최소 3글자 이상입니다.",
					idchk: "이미 존재하는 ID입니다."
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
				snKey: {
					required : "필수 입력 항목입니다.",
					snchk: "시리얼 키가 일치하지 않습니다."
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

	function snKeyCehck() {
		 var url  =  "<c:url value='/addAdminCheck.json'/>";
		 var jsonData = {"snKey": $("#snKey").val()};
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

				if(data.result=="true") {
					 $("#snCheck").val("true");
				} else {
					$("#snCheck").val("false");
				}

			}
			,error:function(e){
			   	console.log(e.status, e.statusText);
			   	alert("서버 오류 입니다. 관리자에게 문의하세요.");
			}
		});
	}

	function empIdCheck() {
		 if($("#empId").val() == '') {
			 alert("ID를 입력해주세요.");
			 return ;
		 }

		 var url  =  "<c:url value='/IdChecking.json'/>";
		 var jsonData = {"empId": $("#empId").val()};

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

					if(data.result=="true") {
						 $("#idCheck").val("true");
					} else {
						$("#idCheck").val("false");
					}

				}
				,error:function(e){
				   	console.log(e.status, e.statusText);
				   	alert("서버 오류 입니다. 관리자에게 문의하세요.");
				}
			});
	}

	$.validator.addMethod("idchk", function(value, element) {
		empIdCheck();
		if($("#idCheck").val() == "true") {
			return true;
		} else {
			return false;
		}
	})

	$.validator.addMethod("snchk", function(value, element) {
		snKeyCehck();
		if($("#snCheck").val() == "true") {
			return true;
		} else {
			return false;
		}
	})

</script>

<body>
	<%
		Date now = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		String today = sf.format(now);
	%>
	<form:form commandName="empVO" id="detailForm" name="detailForm"
		method="post">
		<div class="container">
			<header class="page-header">
			<div class="container">
			<div style="text-align: center;" alt="IsgBeauty 로고">
				<img src="<c:url value='images/logo.jpg' />">
			</div>
		</div>
		</header>
		</div>

		<div class="container">
			<div class="row">
				<div class=" form-inline form-group">
					<label for="empId" class="col-sm-2 col-sm-offset-1 control-label">아이디*:</label>
					<div class="col-md-3">
						<input type="text" class="form-control" id="empId" name="empId">
					</div>

					<label for="empPassword"
						class="col-sm-2 col-sm-offset-1 control-label">비밀번호*:</label>
					<div class="col-md-3">
						<input type="password" class="form-control" id="empPassword"
							name="empPassword">
					</div>
				</div>

				<div class="form-inline form-group">
					<label for="empNm" class="col-sm-2 col-sm-offset-1 control-label">이름*:</label>
					<div class="col-md-3">
						<input type="text" class="form-control" id="empNm" name="empNm">
					</div>

					<label for="telno" class="col-sm-2 col-sm-offset-1 control-label">전화번호*:</label>
					<div class="col-md-3">
						<input type="text" class="form-control" id="telno" name="telno"
						 placeholder="000-0000-0000" maxlength="13" required onkeyup="inputPhoneNumber(this)">
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
						<select type="text" class="form-control" id="pspofc" name="pspofc" disabled="disabled">
							<option value="Admin" selected="selected">Admin</option>
							<option value="Designer">Designer</option>
						</select>
					</div>
				</div>
				<div class="form-inline form-group">

					<label for="snKey"
						class="col-sm-2 col-sm-offset-1 control-label">시리얼 키*:</label>
					<div class="col-md-3">
						<input type="password" class="form-control" id="snKey"
							name="snKey" value="123456">
					</div>
					<label for="updtId" class="col-sm-2 col-sm-offset-1 control-label">등록일:</label>
					<div class="col-md-3">
						<input type="date" class="form-control" id="registDt"
							name="registDt" value="<%=today%>" readonly >
					</div>
				</div>



			</div>
		</div>
			<input type="hidden" class="form-control" id="registId"
						name="registId" value="IsgBeauty" readonly >
			<input type="hidden" id="snCheck" name="snCheck" value="false" readonly>
			<input type="hidden" id="idCheck" name="idCheck" value="false" readonly>
		<div class="container" style="text-align: center; margin-top: 30px;">
			<button type="submit" class="btn btn-success" onclick="" >등록</button>
			<button type="button" class=" btn btn-info" onclick="home()">취소</button>
		</div>
	</form:form>
	<jsp:include page="/common/layouts/userLayout/footer.jsp"></jsp:include>
</body>
</html>