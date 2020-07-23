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
<script type="text/javaScript" language="javascript" defer="defer">
	function home() {
		location.href = "<c:url value='/mberList.do'/>";
	}

	function deleteMber(id) {
		var check;
		check = confirm("정말로 해당 고객님을 삭제하시겠습니까?");

		if (check) {
			document.detailForm.selectedId.value = id;
			document.detailForm.action = "<c:url value='/deleteMber.do'/>";
			document.detailForm.submit();
		} else {
			alert("취소하셨습니다.");
		}
	}

	function editMber(id) {
		document.detailForm.selectedId.value = id;
		document.detailForm.action = "<c:url value='/mberEdit.do'/>";
		document.detailForm.submit();
	}

	function resveRegister(id) {
		document.detailForm.selectedId.value = id;
		document.detailForm.action = "<c:url value='/resveRegister.do'/>";
		document.detailForm.submit();
	}

	$(function() {
		$("#detailForm").validate({
			submitHandler : function() {
				var check = confirm("해당 고객님을 등록하시겠습니까?(validation)");
				if (check) {
					alert("등록되었습니다.");
					frm = document.detailForm;
					frm.action = "<c:url value= '/addMber.do'/>";
					frm.submit();
				} else {
					alert("취소하셨습니다.");
				}
			},
			rules : {
				mberNm : {
					required : true
				},
				telno : {
					required : true,
				/* digits : true */
				},
				brthdy : {
					required : true,
					digits : true
				}
			},
			messages : {
				mberNm : {
					required : "필수 입력 항목입니다."
				},
				telno : {
					required : "필수 입력 항목입니다.",
				/* digits : "숫자만 입력할 수 있습니다." */
				},
				brthdy : {
					required : "필수 입력 항목입니다.",
					digits : "숫자만 입력할 수 있습니다."
				}
			}
		});
	});
</script>
<style>
label {
	margin-top: 30px;
}

p {
	margin-top: 30px;
}
</style>
</head>
<body>
	<form:form commandName="mberVO" id="detailForm" name="detailForm"
		method="post">
		<input type="hidden" name="selectedId" />
		<div class="container">
			<h2 style="text-align: center;">
				<b>'<c:out value="${result.mberNm}" />'고객님 상세화면
				</b>
			</h2>
		</div>

		<div class="container">
			<div class="row">
				<div class="form-inline form-group">
					<label for="mberNm" class="col-sm-2 col-sm-offset-1 control-label">이름:</label>
					<div class="col-sm-3">
						<p for="mberNm" class="control-label">
							<c:out value="${result.mberNm}" />
						</p>
					</div>

					<label for="eEmpId" class="col-sm-2 col-sm-offset-1 control-label">담당
						직원:</label>
					<div class="col-sm-3">
						<p for="eEmpId" class="control-label">
							<c:out value="${result.empNm}" />
						</p>
					</div>
				</div>

				<div class="form-inline form-group">
					<label for="brthdy" class="col-sm-2 col-sm-offset-1 control-label">생년월일:</label>
					<div class="col-sm-3">
						<p for="brthdy" class="control-label">
							<c:out value="${result.brthdy}" />
						</p>
					</div>

					<label for="telno" class="col-sm-2 col-sm-offset-1 control-label">전화번호:</label>
					<div class="col-sm-3">
						<p for="telno" class="control-label">
							<c:out value="${result.telno}" />
						</p>
					</div>
				</div>

				<div class="form-inline form-group">
					<label for="sexdstn" class="col-sm-2 col-sm-offset-1 control-label">성별:</label>
					<div class="col-sm-3">
						<p for="sexdstn" class="control-label">
							<c:out value="${result.sexdstn}" />
						</p>
					</div>

					<label for="sexdstn" style="opacity: 0.0;"
						class="col-sm-2 col-sm-offset-1 control-label">성별:</label>
					<div class="col-sm-3" style="opacity: 0.0;">
						<p for="sexdstn" class="control-label">틀을 맞춰주기 위함</p>
					</div>
				</div>

				<div class="form-inline form-group">
					<label for="registId"
						class="col-sm-2 col-sm-offset-1 control-label">등록자:</label>
					<div class="col-sm-3">
						<p for="registId" class="control-label">
							<c:out value="${result.registId}" />
						</p>
					</div>

					<label for="registDt"
						class="col-sm-2 col-sm-offset-1 control-label">등록일:</label>
					<div class="col-sm-3">
						<p for="registDt" class="control-label">
							<c:out value="${result.registDt}" />
						</p>
					</div>
				</div>

				<div class="form-inline form-group">
					<label for="updtId" class="col-sm-2 col-sm-offset-1 control-label">수정자:</label>
					<div class="col-sm-3">
						<p for="updtId" class="control-label">
							<c:out value="${result.updtId}" />
						</p>
					</div>

					<label for="updtDt" class="col-sm-2 col-sm-offset-1 control-label">수정일:</label>
					<div class="col-sm-3">
						<p for="updtDt" class="control-label">
							<c:out value="${result.updtDt}" />
						</p>
					</div>
				</div>

			</div>
		</div>

		<div class="container" style="text-align: center; margin-top: 30px;">
			<button type="button" class="btn btn-info"
				onclick="editMber('${result.mberSn}')">수정</button>
			<button type="button" class="btn btn-danger"
				onclick="deleteMber('${result.mberSn}')">삭제</button>
			<button type="button" class="btn btn-success"
				onclick="resveRegister('${result.mberSn}')">예약등록</button>
			<button type="button" class=" btn btn-info" onclick="home()">이전</button>
		</div>

	</form:form>
</body>
</html>