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
		location.href = "<c:url value='/junList.do'/>";
	}
	function add() {
		location.href = "<c:url value='/junMgmt.do'/>";
	}
	function opening() {
		location.href = "<c:url value='/opening.do'/>";
	}
	function view() {
		location.href = "<c:url value='/junView.do'/>";
	}
	function excelDownload() {
		location.href = "<c:url value='/junlistExcel.do'/>";
	}
	function setPwd(user_id) {
		if (user_id == "admin") {
			$('#password').val('manager');
		} else if (user_id == "guest") {
			$('#password').val('guest');
		} else if (user_id == "guest2") {
			$('$password').val('guest2');
		}
	}
	function check() {
		if ($('#user_id').val() == "") {
			alert("아이디를 입력하세요!");
			return false;
		}
		if ($('#password').val() == "") {
			alert("패스워드를 입력하세요!");
			return false;
		}
		return true;
	}
</script>
</head>
<body>
	<div class="container">
		<div class="jumbotron text-center alert" role="alert" onclick="home()">
			<h2>
				<b>ISG Beauty</b>
			</h2>
			<p>
				<b>미용실 회원 관리 사이트</b>
			</p>
		</div>
		<div class="row">
			<div class="alert" role="alert">


				<div class="col-sm-6">
					<button type="button" class="btn btn-info" onclick="">직원
						관리</button>
					<button type="button" class="btn btn-info" onclick="">예약
						현황</button>
				</div>
				<div class="col-sm-6">
					<div class="col-xs-6">
						<form>
							<div class="input-group">
								<input type="text" class="form-control" placeholder="Search">
								<div class="input-group-btn">
									<button class="btn btn-default" type="submit">
										<i class="glyphicon glyphicon-search"></i>
									</button>
								</div>
							</div>
						</form>
					</div>
					<div align="right">
						<button type="submit" class="btn btn-info">고객 등록</button>
						<button type="submit" class="btn btn-info">이전</button>
					</div>
				</div>
			</div>
		</div>



		<div class="panel panel-default">
			<div class="panel-body">
				<div class="table table-striped">
					<table id="table" class="table table-hover">
						<thead>
							<tr>
								<td style="width: 10%" align="center"><b>번호</b></td>
								<td style="width: 15%" align="center"><b>이름</b></td>
								<td style="width: 10%" align="center"><b>성별</b></td>
								<td style="width: 15%" align="center"><b>전화번호</b></td>
								<td style="width: 15%" align="center"><b>담당디자이너</b></td>
								<td style="width: 15%" align="center"><b>등록일</b></td>
								<td style="width: 15%" align="center"><b>수정일</b></td>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="result" items="${NaverEconomy}"
								varStatus="status">
								<tr>
									<td style="width: 15%" align="center" class="listtd"><c:out
											value="${result.idx}" />&nbsp;</td>

									<td style="width: 70%" align="left" class="listtd"><a
										href="${result.href}"><c:out value="${result.title}" />&nbsp;</a></td>


									<td style="width: 15%" align="center" class="listtd"><c:out
											value="${result.writer}" />&nbsp;</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>

			<div class="text-center">
				<ul class="pagination">
					<c:if test="${paging.prev}">
						<li class="page-item"><a class="page-link"
							href="${paging.makeQuery(paging.startPage - 1)}">이전</a></li>
					</c:if>

					<c:forEach begin="${paging.startPage}" end="${paging.endPage}"
						var="idx">
						<li class="page-item"><a class="page-link"
							href="${paging.makeQuery(idx)}">${idx}</a></li>
					</c:forEach>

					<c:if test="${paging.next && paging.endPage > 0}">
						<li class="page-item"><a class="page-link"
							href="${paging.makeQuery(paging.endPage + 1)}">다음</a></li>
					</c:if>
				</ul>
			</div>

		</div>

	</div>
</body>
</html>