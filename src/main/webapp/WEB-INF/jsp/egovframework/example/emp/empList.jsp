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
	function empRegister() {
		location.href = "<c:url value='/empRegister.do'/>";
	}
    function view(id) {
    	document.listForm.selectedId.value = id;
       	document.listForm.action = "<c:url value='/empView.do'/>";
       	document.listForm.submit();
    }
	function fn_egov_link_page(pageNo) {
		document.listForm.pageIndex.value = pageNo;
		document.listForm.action = "<c:url value='/empList.do'/>";
		document.listForm.submit();
	}
	function fn_egov_selectList() {
		document.listForm.action = "<c:url value='/empList.do'/>";
		document.listForm.submit();
	}
</script>
</head>
<body>
	<form:form commandName="searchVO" id="listForm" name="listForm"
		method="post">
		<input type="hidden" name="selectedId" />
		<div class="container">
			<div class="jumbotron text-center alert-success" style="margin-top:30px" role="alert"
				onclick="home()">
				<h2>
					<b>ISG Beauty</b>
				</h2>
				<p>
					<b>직원 관리 화면입니다.</b>
				</p>
			</div>
			<div class="row">
				<div class="alert" role="alert">
					<div class="col-sm-6">
					</div>
					<div class="col-sm-6">
						<div class="col-xs-6">
							<div id="search">
								<div class="input-group">
									<form:input path="searchKeyword" type="text" placeholder="이름 검색" cssClass="txt form-control" style="width:70%"/>
									<button class="btn btn-default" style="font-size: 20px;">
										<a href="javascript:fn_egov_selectList();"> <i
											class="glyphicon glyphicon-search"></i>
										</a>
									</button>
								</div>
							</div>
						</div>
						<div align="right">
							<button type="button" class="btn btn-success" onclick="empRegister()">직원 등록</button>
							<button type="button" class="btn btn-info" onclick="home()">이전</button>
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
									<td style="width: 15%" align="center"><b>ID</b></td>
									<td style="width: 10%" align="center"><b>이름</b></td>
									<td style="width: 10%" align="center"><b>성별</b></td>
									<td style="width: 15%" align="center"><b>전화번호</b></td>
									<td style="width: 10%" align="center"><b>직책</b></td>
									<td style="width: 10%" align="center"><b>경력</b></td>
									<td style="width: 15%" align="center"><b>등록일</b></td>
									<td style="width: 15%" align="center"><b>수정일</b></td>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="result" items="${resultList}" varStatus="status">
									<tr>
										<td align="center" class="listtd"><c:out
												value="${result.empId}" /></td>
										<td align="center" class="listtd"><a
											href="javascript:view('<c:out 
													value="${result.empId}"/>')"><c:out
													value="${result.empNm}" /></a></td>
										<td align="center" class="listtd"><c:out
												value="${result.sexdstn}" />&nbsp;</td>
										<td align="center" class="listtd"><c:out
												value="${result.telno}" />&nbsp;</td>
										<td align="center" class="listtd"><c:out
												value="${result.pspofc}" />&nbsp;</td>
										<td align="center" class="listtd"><c:out
												value="${result.career}" />&nbsp;</td>
										<td align="center" class="listtd"><c:out
												value="${result.registDt}" />&nbsp;</td>
										<td align="center" class="listtd"><c:out
												value="${result.updtDt}" />&nbsp;</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
				<div class="text-center">
					<div id="paging">
						<ui:pagination paginationInfo="${paginationInfo}" type="image"
							jsFunction="fn_egov_link_page" />
						<form:hidden path="pageIndex" />
					</div>
				</div>
			</div>

		</div>
	</form:form>
</body>
</html>