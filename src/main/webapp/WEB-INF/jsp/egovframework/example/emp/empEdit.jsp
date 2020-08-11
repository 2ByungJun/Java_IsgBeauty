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

<!-- fileInput -->
<link rel="stylesheet" href="<c:url  value='fileinput/css/fileinput.min.css'/>">
<script src="<c:url value='fileinput/js/fileinput.js' />"></script>

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
	align-self: center;
}

.bjInput {
	width: 200px;
	margin-top: 25px;
}

#divInline {
	align-items: center;
	display: inline-flex;
}

/***** img  *****/
.box {
    width: 200px;
    height: 200px;
    border-radius: 70%;
    overflow: hidden;
}
.profile {
    width: 100%;
    height: 100%;
    object-fit: cover;
}
</style>
<!-- JS -->
<script type="text/javaScript" language="javascript" defer="defer">

	/*  FileUpload */
	$(document).ready(function() {
		$("#input-res-1").fileinput({
			uploadUrl : "/IsgBeauty/jfile/processUpdate.do",
			enableResumableUpload : true,
			initialPreviewAsData : true,
			initialPreviewFileType: 'image',
			validataInitialCount : true,
			uploadExtraData: {
				fileId : "${result.fileId}"
			},
			uploadAsync: false,
			overwriteInitial: true,
			overwriteFile: true,
		    initialPreview: [
		        '<c:url value="/jfile/preview.do?fileId=${result.fileId}"/>" class="profile" name="myImg" id="myImg"',
		    ],
			theme : 'explorer',
			deleteUrl : '/IsgBeauty/jfile/imgDelete.do',
			deleteExtraData: {
				fileId : "${result.fileId}"
			},
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

	function home() {
		location.href = "<c:url value='/empList.do'/>";
	}
	function deleteMber(id) {
		var check;
		check = confirm("정말로 해당 직원을 삭제하시겠습니까?");

		if (check) {
			alert("삭제되었습니다.");
			document.detailForm.selectedId.value = id;
			document.detailForm.action = "<c:url value='/deleteEmp.do'/>";
			document.detailForm.submit();
		} else {
			alert("취소하셨습니다.");
		}
	}
	function view(id) {
		document.detailForm.selectedId.value = id;
		document.detailForm.action = "<c:url value='/empView.do'/>";
		document.detailForm.submit();
	}

	$(function() {
		$("#detailForm").validate({
			submitHandler : function() {
				var jsonData = {empId:$("#empId").val(), empPassword:$("#empPassword").val(), empNm:$("#empNm").val(), telno:$("#telno").val(), sexdstn:$("#sexdstn").val(), pspofc:$("#pspofc").val(),
						salary:$("#salary").val(), career:$("#career").val(), updtId:$("#updtId").val(), updtDt:$("#updtDt").val()}

				var check = confirm("해당 직원 정보를 수정하시겠습니까?");
				if (check) {
					 $.ajax({
							headers: {
								Accept: "application/json;utf-8"
							}
							,contentType: "application/json;utf-8"
							,dataType: "json"
							,type: "POST"
							,async:false
							,url: "<c:url value= '/empEdit.json'/>"
							,data: JSON.stringify(jsonData)
							,success:function(data){
								console.log(data);
								if( $("#input-res-1").fileinput("getFilesCount") == 0 ){
									alert("수정되었습니다.");
							 		home();
					 			}else {
									$("#fileId").val(data.fileId); // fileId 값을 받아오고
								 	$("#input-res-1").fileinput("upload").on('fileuploaded', function() {
								 		alert("수정되었습니다.");
								 		home();
								    });
					 			}
							}
							,error:function(e){
							   	console.log(e.status, e.statusText);
							   	alert("서버 오류 입니다. 관리자에게 문의하세요.")
							}
						});
				} else {
					alert("취소하셨습니다.");
				}

				$("#input-res-1").fileinput('upload');
			},
			rules: {
				empId: {
					required : true,
				},
				empPassword: {
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
				empId: {
					required : "필수 입력 항목입니다.",
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
				salary : {
					required : "필수 입력 항목입니다.",
					digits : "숫자만 입력할 수 있습니다."
				},
				career : {
					required : "필수 입력 항목입니다."
				}
			}, onkeyup : false, onfocusout : false
		});
	});

	function home() {
		location.href = "<c:url value='/empList.do'/>";
	}
	function deleteMber(id) {
		var check;
		check = confirm("정말로 해당 직원을 삭제하시겠습니까?");

		if (check) {
			alert("삭제되었습니다.");
			document.detailForm.selectedId.value = id;
			document.detailForm.action = "<c:url value='/deleteEmp.do'/>";
			document.detailForm.submit();
		} else {
			alert("취소하셨습니다.");
		}
	}
	function view(id) {
		document.detailForm.selectedId.value = id;
		document.detailForm.action = "<c:url value='/empView.do'/>";
		document.detailForm.submit();
	}

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
</script>

</head>
<body>
	<%
		Date now = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		String today = sf.format(now);
	%>

	<form:form commandName="empVO" id="detailForm" name="detailForm"
		method="post">
		<input type="hidden" name="selectedId" />
		<div class="container">
			<h2 style="text-align:center;">
					<b>'<c:out value="${result.empNm}" />'직원 수정 화면</b>
			</h2>

			<!-- Contents -->
			<div style="width: 100%; display: inline-flex; padding-bottom: 2px">

				<!-- Start(10%) -->
				<div style="width: 15%">
				</div>

				<!-- 2(35%) -->
				<div style="width: 35%; text-align: center; font-stretch: semi-condensed; padding: 40px">
					<!-- 이미지 -->
						<label class="control-label">프로필 사진 등록</label>
						<div class="file-loading">
				    		<input id="input-res-1" name="input-res-1" type="file"  data-show-upload="false">
						</div>
				</div>

				<!-- 3(10%) -->
				<div style="width: 10%">
				</div>

				<!-- Center(10%) -->
				<div style="width: 10%; text-align: center; display: grid;">
					<label class="bjLabel control-label">아이디 : </label>
					<label class="bjLabel control-label">패스워드 : </label>
					<label class="bjLabel control-label">이름:</label>
					<label class="bjLabel control-label">전화번호:</label>
					<label class="bjLabel control-label">성별:</label>
					<label class="bjLabel control-label">직책:</label>
					<label class="bjLabel control-label">급여:</label>
					<label class="bjLabel control-label">경력:</label>
				</div>

				<!-- End(60%) -->
				<div style="width: 60%; text-align: left; display: grid">
					<!-- 아이디 -->
					<div id="divInline">
						<input type="text" class="bjInput form-control" id="empId" name="empId" value="<c:out value="${result.empId}"/>" readonly required>
					</div>

					<!-- 패스워드 -->
					<div id="divInline">
						<input type="password" class="bjInput form-control" id="empPassword" name="empPassword" value="<c:out value="${result.empPassword}"/>" required>
					</div>

					<!-- 이름 -->
					<div id="divInline">
						<input type="text" class="bjInput form-control" id="empNm" name="empNm"
								value="<c:out value="${result.empNm}" />" required>
					</div>

					<!-- 전화번호 -->
					<div id="divInline">
						<input type="text" class="bjInput form-control" id="telno" name="telno" value="${result.telno}"
								placeholder="000-0000-0000" maxlength="13" onkeyup="inputPhoneNumber(this)" required>
					</div>

					<!-- 성별 -->
					<div id="divInline">
						<select type="text" class="bjInput form-control" id="sexdstn" name="sexdstn">
							<option value="${result.sexdstn}" selected="selected">
							<c:out value="${result.sexdstn}" /></option>
							<option value="Male">남성</option>
							<option value="Female">여성</option>
						</select>
					</div>

					<!-- 직책 -->
					<div id="divInline">
						<select type="text" class="bjInput form-control" id="pspofc" name="pspofc">
							<option value="${result.pspofc}" selected="selected"> <c:out value="${result.pspofc}" /></option>
							<option value="Admin">Admin</option>
							<option value="Designer">Designer</option>
						</select>
					</div>

					<!-- 급여 -->
					<div id="divInline">
						<input type="text" class="bjInput form-control" id="salary" name="salary" value="<c:out value="${result.salary}"/>" required>
					</div>

					<!-- 경력 -->
					<div id="divInline">
						<input type="career" class="bjInput form-control" id="career" name="career" value="<c:out value="${result.career}"/>" required>
					</div>

				</div>
			</div>
		</div>

		<!-- hidden -->
		<input type="hidden" id="registId" name="registId" value="${result.registId}"/>
		<input type="hidden" id="registDt" name="registDt" value="${result.registDt}"/>
		<input type="hidden" id="updtId" name="updtId" value="${empId}"/>
		<input type="hidden" id="updtDt" name="updtDt" value="<%=today%>"/>

		<!-- Button -->
		<div class="container" style="text-align: center; margin-top: 30px;">
			<button type="submit" class="btn btn-primary" onclick="">수정</button>
			<button type="button" class="btn btn-danger"
				onclick="deleteMber('${result.empId}')">삭제</button>
			<button type="button" class=" btn btn-info"
				onclick="view('${result.empId}')">이전</button>
		</div>

	</form:form>
</body>
</html>