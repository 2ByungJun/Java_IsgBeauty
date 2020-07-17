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


		$(document).ready(function() {
			 fnSelectList(1);
		});


		function fn_createPaging(pages,pageId) {
			   var page   = Number(pages.currentPageNo);
			   var totalPages  =  parseInt(pages.pageCount);
			   var pageSize  = Number(10);
			   $("#paging").children().remove();
			   var pagingHtml = '';

			   var pagingIndex = parseInt((page-1)/pageSize);
			   var pagingStart = (pagingIndex*pageSize)+1;
			   var pagingEnd  = (pagingIndex+1)*pageSize;


			   //alert(pages.totalPages);
			   if (pagingEnd > totalPages){
				   pagingEnd = totalPages;
			   }
			   var before = pagingStart - 1;
			   pagingHtml += '<ul class="pagination">';
			   if (page > pageSize) {
				   pagingHtml += ' <li class="prev"><a href=\"javascript:fnSelectList(1);\" class="first"><<</a><li><li class="prev"><a class="prev" href=\"javascript:fnSelectList(' + before + ');\"><</a></li>';
			   }else{
				   pagingHtml += '  <li class="disabled"><a href="#" ><<</a></li><li class="disabled"><a  href="#"><</a></li>';

			   }

			  // pagingHtml += '<span>';
			   for (var i = pagingStart; i <= pagingEnd; i++) {
			    if(i == pagingStart){
				     //pagingHtml += '<a href="#" class="first-num">'+ i +'</a>';
				     if (page == i) {
				      pagingHtml += '<li data-lp="'+ i +'" class="disabled"><a href="#" class="on" style="color: blue; font-weight: bolder;">'+ i +'</a></li>';
				     }else {
				      pagingHtml += '<li data-lp="'+ i +'"><a href=\"javascript:fnSelectList(' + i + ');">'+ i +'</a></li>';
				     }
			    }else{
			     if (page == i) {
			      pagingHtml += '<li data-lp="'+ i +'" class="disabled"><a href="#" class="on" style="color: blue; font-weight: bolder;">'+ i +'</a></li>';
			     } else {
			      pagingHtml += '<li data-lp="'+ i +'"><a href=\"javascript:fnSelectList(' + i + ');">'+ i +'</a></li>';
			     }
			    }
			   }

			   var after = pagingEnd + 1;
			   if (pagingEnd < totalPages) {
			    pagingHtml += ' <li class="next"><a href=\"javascript:fnSelectList(' + after + ');\" class="next">></a></li><li class="next"><a class="last" href=\"javascript:fnSelectList(' + totalPages + ');\">>></a></li>';
			   }else{
				   pagingHtml += ' <li class="disabled"><a href=\"#" >></a></li><li class="disabled"><a href=\"javascript:#">>></a></li>';
			   }
			   pagingHtml += '</ul>'
			   $("#"+pageId).empty().append(pagingHtml);
			 }



		function fnSelectList(pageNo){
		   var url  =  "<c:url value='/mberList.json'/>";
		   var jsonData = {"pageIndex": pageNo};

		   $("#listForm").serialize()

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
						html += '	<td colspan="5" style="text-align:center">표시할 데이터가 없습니다.</td>';
						html += '</tr>';
					}else{
						$.each(data.dataList, function(index, item) {
							html += '<tr>';

							html += '<td align="center" class="listtd" >'+(index+1+((pageNo-1)*10))+'</td>';
							html += '<td align="center" class="listtd"><a href="javascript:view(\''+item.mberSn+'\')">' + item.mberNm + '</td>';
							html += '<td align="center" class="listtd" >' + item.sexdstn + '</td>';
							html += '<td align="center" class="listtd" >' + item.telno + '</td>';
							html += '<td align="center" class="listtd" >' + item.eEmpId + '</td>';
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
	function logout() {
		location.href = "<c:url value='/login.do'/>";
	}
	function resve() {
		location.href = "<c:url value='/resveView.do'/>";
	}
	function view(id) {
		document.listForm.selectedId.value = id;
		document.listForm.action = "<c:url value='/mberView.do'/>";
		document.listForm.submit();
	}
	function fn_egov_link_page(pageNo) {
		document.listForm.pageIndex.value = pageNo;
		document.listForm.action = "<c:url value='/mberList.do'/>";
		document.listForm.submit();
	}
	function fn_egov_selectList() {
		document.listForm.action = "<c:url value='/mberList.do'/>";
		document.listForm.submit();
	}
</script>
</head>
<body>
	<form:form commandName="searchVO" id="listForm" name="listForm"
		method="post">
		<input type="hidden" name="selectedId" />
		<div class="container">
			<div class="jumbotron text-center alert-info" style="margin-top:30px" role="alert"
				onclick="home()">
				<h2>
					<b>ISG Beauty</b>
				</h2>
				<p>
					<b>고객 관리 화면입니다.</b>
				</p>
			</div>
			<div class="row">
				<div class="alert" role="alert">
					<div class="col-sm-6">
						<button type="button" class="btn btn-success"
							onclick="empManage()">직원 관리</button>
						<button type="button" class="btn btn-danger" onclick="resve()">예약
							현황</button>
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
							<button type="button" class="btn btn-info"
								onclick="mberRegister()">고객 등록</button>
							<button type="button" class="btn btn-info" onclick="logout()">로그아웃</button>
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
							<tbody id="tableList">
								<%-- <c:forEach var="result" items="${mberList}" varStatus="status">
									<tr>
										<td align="center" class="listtd"><c:out
												value="${status.count+(paginationInfo.currentPageNo-1)*10}" /></td>
										<td align="center" class="listtd"><a
											href="javascript:view('<c:out
													value="${result.mberSn}"/>')"><c:out
													value="${result.mberNm}" /></a></td>
										<td align="center" class="listtd"><c:out
												value="${result.sexdstn}" />&nbsp;</td>
										<td align="center" class="listtd"><c:out
												value="${result.telno}" />&nbsp;</td>
										<td align="center" class="listtd"><c:out
												value="${result.empNm}" />&nbsp;</td>
										<td align="center" class="listtd"><c:out
												value="${result.registDt}" />&nbsp;</td>
										<td align="center" class="listtd"><c:out
												value="${result.updtDt}" />&nbsp;</td>
									</tr>
								</c:forEach> --%>
							</tbody>
						</table>
					</div>
				</div>
				<div class="text-center">
					<div id="paging">
						<<%-- ui:pagination paginationInfo="${paginationInfo}" type="image"
							jsFunction="fn_egov_link_page" />
						<form:hidden path="pageIndex" /> --%>
					</div>
				</div>

			</div>
	</form:form>
</body>
</html>