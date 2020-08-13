<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
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

<!-- JSP -->
<form:form commandName="empVO" id="editForm" name="editForm" method="post">
		<!-- hidden -->
		<input type="hidden" id="registId" name="registId" value="${result.registId}"/>
		<input type="hidden" id="registDt" name="registDt" value="${result.registDt}"/>
		<input type="hidden" id="updtId" name="updtId" value="${empId}"/>
		<input type="hidden" id="updtDt" name="updtDt" value="<%=today%>"/>

		<!-- body -->
		<div class="container">

			<!-- title -->
			<h2 style="text-align:center;"><b><span style="color:#000080">'<c:out value="${result.empNm}" />'</span>직원 수정 화면</b></h2>

			<!-- contents -->
			<div style="width: 100%; display: inline-flex; padding-bottom: 2px">
				<!-- (10%) -->
				<div style="width: 15%"></div>

				<!-- file (35%) -->
				<div style="width: 35%; text-align: center; font-stretch: semi-condensed; padding: 40px">
					<label class="control-label">프로필 사진 등록</label>
					<div class="file-loading"><input id="input-res-1" name="input-res-1" type="file"  data-show-upload="false"></div>

					<div style="margin-top:5px;"><span style="color:#000080; font-size:smaller; margin-top:5px;">휴지통을 클릭 시, 등록된 이미지가 삭제됩니다.</span></div>
				</div>

				<!-- (10%) -->
				<div style="width: 10%"></div>

				<!-- label (10%) -->
				<div style="width: 10%; text-align: center; display: grid;">
					<label class="bjLabel control-label">아이디 : </label>
					<label class="bjLabel control-label">패스워드 : </label>
					<label class="bjLabel control-label">이름:</label>
					<label class="bjLabel control-label">전화번호:</label>
					<label class="bjLabel control-label">성별:</label>
					<label class="bjLabel control-label">직책(년):</label>
					<label class="bjLabel control-label">급여(원):</label>
					<label class="bjLabel control-label">경력:</label>
				</div>

				<!-- input (60%) -->
				<div style="width: 60%; text-align: left; display: grid">
					<!-- 아이디 -->
					<div id="divInline"><input type="text" class="bjInput form-control" id="empId" name="empId" maxlength="13" value="<c:out value="${result.empId}"/>" readonly required></div>

					<!-- 패스워드 -->
					<div id="divInline"><input type="password" class="bjInput form-control" id="empPassword" name="empPassword" maxlength="13" value="<c:out value="${result.empPassword}"/>" required></div>

					<!-- 이름 -->
					<div id="divInline"><input type="text" class="bjInput form-control" id="empNm" name="empNm" maxlength="4" value="<c:out value="${result.empNm}" />" required></div>

					<!-- 전화번호 -->
					<div id="divInline"><input type="text" class="bjInput form-control" id="telno" name="telno" value="${result.telno}" placeholder="000-0000-0000" maxlength="13" onkeyup="inputPhoneNumber(this)" required></div>

					<!-- 성별 -->
					<div id="divInline">
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

					<!-- 직책 -->
					<div id="divInline">
						<select class="bjInput form-control" id="pspofc" name="pspofc">
							<c:if test="${result.pspofc eq 'Admin'}">
								<option value="Admin" selected="selected">관리자</option>
								<option value="Designer">디자이너</option>
							</c:if>
							<c:if test="${result.pspofc eq 'Designer'}">
								<option value="Admin">관리자</option>
								<option value="Designer" selected="selected">디자이너</option>
							</c:if>

						</select>
					</div>

					<!-- 급여 -->
					<div id="divInline"><input type="text" class="bjInput form-control" id="salary" name="salary" maxlength="10" value="<c:out value="${result.salary}"/>" required></div>

					<!-- 경력 -->
					<div id="divInline"><input type="text" class="bjInput form-control" id="career" name="career" maxlength="2" value="<c:out value="${result.career}"/>" required></div>

				</div>
			</div>
		</div>

		<!-- button -->
		<div class="container" style="text-align: center; margin-top: 30px;">
			<button type="submit" class="btn btn-primary" onclick="">수정</button>
			<button type="button" class="btn btn-danger" onclick="deleteEmp()">삭제</button>
			<button type="button" class=" btn btn-info" onclick="view('${result.empId}')">이전</button>
		</div>

	</form:form>


<!-- JS -->
<link rel="stylesheet" href="<c:url  value='fileinput/css/fileinput.min.css'/>">
<script src="<c:url value='fileinput/js/fileinput.js' />"></script>
<script type="text/javaScript" defer="defer">

	/*  fileUpload */
	$(document).ready(function() {
		$("#input-res-1").fileinput({
			uploadUrl : "/IsgBeauty/jfile/processUpdate.do",
			enableResumableUpload : true,
			initialPreviewAsData : true,
			validataInitialCount : true,
			uploadAsync: false,
			overwriteInitial: true,
			showRemove: false,
			uploadExtraData: {
				fileId : "${result.fileId}"
			},
			initialPreviewFileType: 'image',
		    initialPreview: [
		        '<c:url value="/jfile/preview.do?fileId=${result.fileId}"/>" class="profile"',
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

	/*  empEdit */
	$(function() {
		$("#editForm").validate({
			submitHandler : function() {
				var jsonData = $("#editForm").serializeJSON();
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
							   	alert("서버 오류 입니다. 관리자에게 문의하세요.")
							}
						});
				}
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

	$.validator.addMethod("regex", function(value, element, regexp) {
		let re = new RegExp(regexp);
		let res = re.test(value);
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

	function home() {
		document.editForm.action = "<c:url value='/empList.do'/>";
		document.editForm.submit();
	}
	function deleteEmp() {
		var check = confirm("정말로 해당 직원을 삭제하시겠습니까?");
		if (check) {
			document.editForm.action = "<c:url value='/deleteEmp.do'/>";
			document.editForm.submit();
			alert("삭제되었습니다.");
		}
	}
	function view() {
		document.editForm.action = "<c:url value='/empView.do'/>";
		document.editForm.submit();
	}

</script>