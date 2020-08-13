<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!-- CSS -->
<style>
label {
	margin-top: 20px;
}

p {
	margin-top: 20px;
}
</style>


<!-- JSP -->
<form:form commandName="mberVO" id="detailForm" name="detailForm" method="post">
	<!-- hidden -->
	<input type="hidden" name="selectedId" />

	<!-- body -->
	<div class="container">
		<!-- title -->
		<h2 style="text-align: center;"><b><span style="color:#000080;">'<c:out value="${result.mberNm}"/>'</span>님 상세화면</b></h2>

		<!-- contents -->
		<div style="width: 100%; display: inline-flex; padding-bottom: 2px">

			<!-- (40%) -->
			<div style="width: 40%;"></div>

			<!-- label (10%) -->
			<div style="width: 10%; text-align: center; display: grid;">
				<label class="control-label">이름 : </label>
				<label class="control-label">담당 직원:</label>
				<label class="control-label">전화 번호:</label>
				<label class="control-label">성별:</label>
				<label class="control-label">생년월일:</label>
				<label class="control-label">등록자:</label>
				<label class="control-label">등록일:</label>
				<label class="control-label">수정자:</label>
				<label class="control-label">수정일:</label>
			</div>

			<!-- input (50%) -->
			<div style="width: 50%; text-align: left; display: grid">
				<!-- 이름 -->
				<div style="display: inline-flex;"><p class="control-label"><c:out value="${result.mberNm}" /></p></div>

				<!-- 담당 직원 -->
				<div style="display: inline-flex;"><p class="control-label"><c:out value="${result.empNm}" /></p></div>

				<!-- 전화 번호 -->
				<div style="display: inline-flex;"><p class="control-label"><c:out value="${result.telno}" /></p></div>

				<!-- 성별 -->
				<div style="display: inline-flex;">
					<c:if test="${result.sexdstn eq 'Male'}">
						<p class="control-label">
							남성
						</p>
					</c:if>
					<c:if test="${result.sexdstn eq 'Female'}">
						<p class="control-label">
							여성
						</p>
					</c:if>
				</div>

				<!-- 생년월일 -->
				<div style="display: inline-flex;"><p class="control-label"><c:out value="${result.brthdy}" /></p></div>

				<!-- 등록자 -->
				<div style="display: inline-flex;"><p class="control-label"><c:out value="${result.registId}" /></p></div>

				<!-- 등록일 -->
				<div style="display: inline-flex;"><p class="control-label"><c:out value="${result.registDt}" /></p></div>

				<!-- 수정자 -->
				<div style="display: inline-flex;"><p class="control-label"><c:out value="${result.registId}" /></p></div>

				<!-- 수정일 -->
				<div style="display: inline-flex;"><p class="control-label"><c:out value="${result.updtDt}" /></p></div>

			</div>
		</div>
	</div>

	<!-- button -->
	<div class="container" style="text-align: center; margin-top: 30px;">
		<button type="button" class="btn btn-primary" onclick="editMber('${result.mberSn}')">수정</button>
		<button type="button" class="btn btn-danger" onclick="deleteMber('${result.mberSn}')">삭제</button>
		<button type="button" class="btn btn-success" onclick="resveRegister('${result.mberSn}')">예약등록</button>
		<button type="button" class=" btn btn-info" onclick="home()">이전</button>
	</div>

</form:form>

<!-- JS -->
<script type="text/javaScript" defer="defer">
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