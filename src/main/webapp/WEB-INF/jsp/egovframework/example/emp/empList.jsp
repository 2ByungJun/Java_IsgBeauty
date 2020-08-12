<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!-- CSS -->
<style>
.box {
    width: 50px;
    height: 50px;
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
<form:form commandName="searchVO" id="listForm" name="listForm" method="post">
		<!-- hidden -->
		<input type="hidden" name="selectedId" />

		<!-- body -->
		<div class="container">

			<!-- title -->
			<h2 style="text-align:center;"><b>직원관리</b></h2>

			<!-- top -->
			<div style="width:100%; display:inline-flex; padding-bottom:2px">
				<!-- button -->
				<div style="width: 50%; text-align:left;"><button type="button" class="btn btn-primary" onclick="empRegister()">직원 등록</button></div>

				<!-- search -->
				<div id="search" style="width: 50%;">
					<div class="input-group" style="float:right;">
						<form:input path="searchKeyword" type="text" id="serachKeyword" placeholder="이름 검색" style="width:200px" cssClass="txt form-control" onkeydown="if(event.keyCode==13) fnSelectList(1)" />
						<button class="btn btn-primary" type="button" onclick="javascript:fnSelectList(1)" style="font-size: 14px;"><i class="glyphicon glyphicon-search"></i></button>
					</div>
				</div>
			</div>

			<!-- body -->
			<div class="panel panel-default">

				<!-- table -->
				<div class="panel-body">
					<div class="table table-striped">
						<table id="table" class="table table-hover">
							<thead>
								<tr>
									<td style="width: 5%" align="center"><b>사진</b></td>
									<td style="width: 10%" align="center"><b>ID</b></td>
									<td style="width: 10%" align="center"><b>이름</b></td>
									<td style="width: 10%" align="center"><b>성별</b></td>
									<td style="width: 15%" align="center"><b>전화번호</b></td>
									<td style="width: 10%" align="center"><b>직책</b></td>
									<td style="width: 10%" align="center"><b>경력</b></td>
									<td style="width: 15%" align="center"><b>등록일</b></td>
									<td style="width: 15%" align="center"><b>수정일</b></td>
								</tr>
							</thead>
							<tbody id=tableList>
							</tbody>
						</table>
					</div>
				</div>

				<!-- paging -->
				<div class="text-center">
					<div id="paging">
					</div>
				</div>

			</div>
		</div>
</form:form>

<!-- JS -->
<script src="<c:url value='js/paging.js' />"></script>
<script type="text/javaScript" defer="defer">

	<%  String str = (String) session.getAttribute("empId"); %>
	$(document).ready(function() {
		 fnSelectList(1);
		 var welcomeHtml = '';
		 welcomeHtml += '<b>'+'[<%=str%>]' + '님 qwewe.</b>';
		 welcomeHtml += '<b>직원 관리 화면입니다.</b>';
		 $('#welcome').html(welcomeHtml);
	});

	function fnSelectList(pageNo){
		 var url  =  "<c:url value='/empList.json'/>";
		 var jsonData = {"pageIndex": pageNo, "searchKeyword": $("#serachKeyword").val()};
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
		    	var html = '';
		    	var imgHref = '';
				if(data.dataList.length==0){
					html += '<tr>';
					html += '	<td colspan="7" style="text-align:center">표시할 데이터가 없습니다.</td>';
					html += '</tr>';
				}else{
					$.each(data.dataList, function(index, item) {
						html += '<tr>';
						html += '<td align="center" class="listtd">' +
									'<div class="box" style="background: #BDBDBD;">' +
										'<img class="profile" src=<c:url value="/jfile/preview.do?fileId=' + item.fileId  + '"/>' + '>'
									'</div>' +
								'</td>';
						html += '<td align="center" class="bjMiddle listtd"><a href="javascript:view(\''+item.empId+'\')">' + item.empId + '</td>';
						html += '<td align="center" class="bjMiddle listtd">' + item.empNm + '</td>';
						html += '<td align="center" class="bjMiddle listtd" >' + sexd(item.sexdstn) + '</td>';
						html += '<td align="center" class="bjMiddle listtd" >' + item.telno + '</td>';
						html += '<td align="center" class="bjMiddle listtd" >' + pspofcd(item.pspofc) + '</td>';
						html += '<td align="center" class="bjMiddle listtd" >' + item.career + '년' + '</td>';
						html += '<td align="center" class="bjMiddle listtd" >' + item.registDt + '</td>';
						html += '<td align="center" class="bjMiddle listtd" >' + item.updtDt + '</td>';
						html += '</tr>';
					});
				}
				$('#tableList').html(html);
				$('.bjMiddle').css("vertical-align","middle");

				fn_createPaging(data.pages,"paging");
			}
			,error:function(e){
			   	console.log(e.status, e.statusText);
			   	alert("서버 오류 입니다. 관리자에게 문의하세요.")
			}
		});

	}

	function sexd(st) {
		if(st === "Male"){
			return "남성";
		}else{
			return "여성";
		}
	}

	function pspofcd(st) {
		if(st === "Admin"){
 			return "<b>♦관리자♦</b>";
		}else{
			return "디자이너";
		}
	}

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
</script>