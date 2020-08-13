<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.egovframe.go.kr/tags/ext/jfile/jsp" prefix="jwork"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
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
	width: 200px;
	margin-top: 10px;
}
</style>

<!-- JSP -->
<form:form commandName="empVO" id="registerForm" name="registerForm" method="post">
		<!-- hidden -->
		<input type="hidden" name="fileId" id="fileId" />
		<input type="hidden" id="idCheck" name="idCheck" value="true">

		<!-- body -->
		<div class="container">

			<!-- title -->
			<h2 style="text-align: center;"><b>직원 등록</b></h2>

			<!-- contents -->
			<div style="width: 100%; display: inline-flex; padding-bottom: 2px; margin-top:px;">

				<!-- (15%) -->
				<div style="width: 15%"></div>

				<!-- file (35%) -->
				<div style="width: 35%; text-align: center; font-stretch: semi-condensed; padding: 40px">
						<label class="control-label">프로필 사진 등록</label>
						<div class="file-loading">
				    		<input id="input-res-1" name="input-res-1" type="file"  data-show-upload="false">
						</div>
				</div>

				<!-- (10%) -->
				<div style="width: 10%">
				</div>

				<!-- label (10%) -->
				<div style="width: 10%; text-align: center; display: grid">
					<label class="control-label">아이디 : </label>
					<label class="control-label">비밀번호:</label>
					<label class="control-label">이름:</label>
					<label class="control-label">전화번호:</label>
					<label class="control-label">성별:</label>
					<label class="control-label">직책:</label>
					<label class="control-label">급여(원):</label>
					<label class="control-label">경력(년):</label>
					<label class="control-label">등록자:</label>
					<label class="control-label">등록일:</label>
				</div>

				<!-- input (45%) -->
				<div style="width: 45%; text-align: left; display: grid">
					<!-- 아이디 -->
					<div style="display: inline-flex;"><input type="text" class="bjWidth form-control" maxlength="13" id="empId" name="empId" placeholder="아이디를 입력하세요" required></div>

					<!-- 비밀번호 -->
					<div style="display: inline-flex;"><input type="password" class="bjWidth form-control" maxlength="13" id="empPassword" name="empPassword" placeholder="비밀번호를 입력하세요" required></div>

					<!-- 이름 -->
					<div style="display: inline-flex;"><input type="text" class="bjWidth form-control" maxlength="4" id="empNm" name="empNm" placeholder="이름을 입력하세요" required></div>

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
							<option value="Designer">디자이너</option>
						</select>
					</div>

					<!-- 급여 -->
					<div style="display: inline-flex;"><input type="text" class="bjWidth form-control" id="salary" name="salary" maxlength="10" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" placeholder="급여를 입력하세요" required></div>

					<!-- 경력 -->
					<div style="display: inline-flex;"><input type="text" class="bjWidth form-control" id="career" name="career" maxlength="2" placeholder="경력을 입력하세요" required></div>

					<!-- 등록자 -->
					<div style="display: inline-flex;"><input type="text" class="bjWidth form-control" id="registId" name="registId" value="${empId}" readonly></div>

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

</form:form>

<!-- JS -->
<link rel="stylesheet" href="<c:url  value='fileinput/css/fileinput.min.css'/>">
<script src="<c:url value='fileinput/js/fileinput.js' />"></script>
<script type="text/javaScript" defer="defer">

	function home() {
		location.href = "<c:url value='/empList.do'/>";
	}


	/* FileUpload */
	$(document).ready(function() {
		$("#input-res-1").fileinput({
			uploadUrl : "/IsgBeauty/jfile/processUpload.do",
			enableResumableUpload : true,
			initialPreviewAsData : true,
			validataInitialCount : true,
			overwriteInitial: true,
			showRemove: false,
			uploadExtraData:function(){ return {fileId : $("#fileId").val()} },
			theme : 'explorer',
			deleteUrl : '/site/file-delete',
			fileActionSettings : {
				showZoom : function(config) {
					if (config.type === 'pdf' || config.type === 'image') {
						return true;
					}
					return false;
				}
			}
		});
	});

	/* 글 등록 function */
	$(function() {
		$("#registerForm").validate({
			submitHandler : function() {
				var jsonData = $("#registerForm").serializeJSON();
				var check = confirm("해당 직원을 등록하시겠습니까?");
				if (check) {
					 $.ajax({
							headers: {
								Accept: "application/json;utf-8"
							}
							,contentType: "application/json;utf-8"
							,dataType: "json"
							,type: "POST"
							,async:false
							,url: "<c:url value= '/empRegister.json'/>"
							,data: JSON.stringify(jsonData)
							,success:function(data){
								if( $("#input-res-1").fileinput("getFilesCount") == 0 ){
									alert("등록되었습니다.");
							 		home();
					 			}else {
									$("#fileId").val(data.fileId); // fileId 값을 받아오고
								 	$("#input-res-1").fileinput("upload").on('fileuploaded', function() {
								 		alert("등록되었습니다.");
								 		home();
								    });
					 			}

							}
							,error:function(e){
							   	alert("서버 오류 입니다. 관리자에게 문의하세요.")
							}
						});
				} else {
					alert("취소하셨습니다.");
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
				},
				salary : {
					required : true,
					digits : true
				},
				career : {
					required : true
				}
			},
			messages : {
				empId : {
					required : "필수 입력 항목입니다.",
					minlength : "아이디는 최소 3~13자입니다.",
					idchk : "이미 존재하는 ID입니다."
				},
				empPassword : {
					required : "필수 입력 항목입니다.",
					minlength : "비밀번호는 최소 4~13자리입니다."
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
		return res;
	})

	function inputPhoneNumber(obj) {

		var number = obj.value.replace(/[^0-9]/g, "");
		var phone = "";

		if (number.length < 4) {
			return number;
		} else if (number.length < 7) {
			phone += number.substr(0, 3);
			phone += "-";
			phone += number.substr(3);
		} else if (number.length < 11) {
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
		var url = "<c:url value='/IdChecking.json'/>";
		var jsonData = {
			"empId" : $("#empId").val()
		};
		var idchk;

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

	$.validator.addMethod("idchk", function(value, element) {
		if (empIdCheck()) {
			return true;
		} else {
			return false;
		}
	})

	function numkeyCheck(e) {
		var keyValue = event.keyCode;
		if (((keyValue < 48) || (keyValue > 57)))
			return false;
		else {
			return true;
		}
	}
</script>
