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


			   //alert(totalPages);
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
		   var jsonData = {"pageIndex": pageNo, "searchKeyword": $("#serachKeyword").val()};

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