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

<script type="text/javaScript" language="javascript" defer="defer">
	<%  String str = (String) session.getAttribute("empId"); %>


	$(document).ready(function() {
		 fnSelectList(1);
		 var welcomeHtml = '';
		 welcomeHtml += '<b>'+'[<%=str%>]' + '님 환영합니다.</b>';
		 welcomeHtml += '<b>고객 관리 화면입니다.</b>';
		 $('#welcome').html(welcomeHtml);
	});


	function fnSelectList(pageNo){
	  var url  =  "<c:url value='/mberList.json'/>";
	  var jsonData = {"pageIndex": pageNo, "searchKeyword": $("#searchKeyword").val()};

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

		    	var html = '';
				if(data.dataList.length==0){
					html += '<tr>';
					html += '	<td colspan="7" style="text-align:center">표시할 데이터가 없습니다.</td>';
					html += '</tr>';
				}else{
					$.each(data.dataList, function(index, item) {
						html += '<tr>';
						html += '<td align="right" class="listtd" >'+(index+1+((pageNo-1)*10))+'</td>';
						html += '<td align="center" class="listtd"><a href="javascript:view(\''+item.mberSn+'\')">' + item.mberNm + '</td>';
						html += '<td align="center" class="listtd" >' + item.sexdstn + '</td>';
						html += '<td align="center" class="listtd" >' + item.telno + '</td>';
						html += '<td align="center" class="listtd" >' + item.empNm + '</td>';
						html += '<td align="center" class="listtd" >' + item.registDt + '</td>';
						html += '<td align="center" class="listtd" >' + item.updtDt + '</td>';
						html += '</tr>';

					});
				}
				$('#tableList').html(html);

				fn_createPaging(data.pages,"paging");
			}
			,error:function(e){
			   	console.log(e.status, e.statusText);
			   	alert("서버 오류 입니다. 관리자에게 문의하세요.")
			}
		});

	}

	function home() {
		location.href = "<c:url value='/mberList.do'/>";
	}
	function empManage() {
		location.href = "<c:url value='/empList.do'/>";
	}
	function mberRegister() {
		location.href = "<c:url value='/mberRegister.do'/>";
	}
	function resve() {
		location.href = "<c:url value='/resveView.do'/>";
	}
	function view(id) {
		document.listForm.selectedId.value = id;
		document.listForm.action = "<c:url value='/mberView.do'/>";
		document.listForm.submit();
	}
	function logout() {
		check = confirm("로그아웃 하시겠습니까?");

		if (check) {
			location.href = "<c:url value='/logout.do'/>";
		} else {
			alert("취소하셨습니다.");
		}
	}
</script>
</head>
<body>
	<form:form commandName="searchVO" id="listForm" name="listForm"
		method="post">
		<input type="hidden" name="selectedId" />
		<div class="container">
			<h2 style="text-align: center;">
				<b>고객 관리</b>
			</h2>

			<div style="width:100%; display:inline-flex; padding-bottom:2px">
				<div style="width: 50%; text-align:left;">
					<button type="button" class="btn btn-primary" onclick="mberRegister()">고객
						등록</button>


				</div>

				<div id="search" style="width: 50%;">
					<div class="input-group" style="float:right;">
						<form:input path="searchKeyword" type="text" id="searchKeyword"
							placeholder="이름 검색" cssClass="txt form-control" style="width:200px;" />
						<button class="btn btn-primary" type="button" onclick="javascript:fnSelectList(1)" style="font-size: 14px;">
							<i class="glyphicon glyphicon-search"></i>
						</button>
					</div>
				</div>
			</div>

			<div class="panel panel-default">
				<div class="panel-body">
					<div class="table table-striped">
						<table id="table" class="table table-hover">
							<thead>
								<tr>
									<td style="width: 5%" align="right"><b>번호</b></td>
									<td style="width: 15%" align="center"><b>이름</b></td>
									<td style="width: 10%" align="center"><b>성별</b></td>
									<td style="width: 15%" align="center"><b>전화번호</b></td>
									<td style="width: 15%" align="center"><b>담당디자이너</b></td>
									<td style="width: 15%" align="center"><b>등록일</b></td>
									<td style="width: 15%" align="center"><b>수정일</b></td>
								</tr>
							</thead>
							<tbody id="tableList">
							</tbody>
						</table>
					</div>
				</div>
				<div class="text-center">
					<div id="paging"></div>
				</div>
			</div>
		</div>
	</form:form>
</body>
</html>