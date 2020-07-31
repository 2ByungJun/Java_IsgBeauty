		function fn_createPaging(pages,pageId) {
			   var page   = Number(pages.currentPageNo);
			   var totalPages  =  parseInt(pages.pageCount);
			   var pageSize  = Number(10);
			   $("#paging").children().remove();
			   var pagingHtml = '';

			   var pagingIndex = parseInt((page-1)/pageSize);
			   var pagingStart = (pagingIndex*pageSize)+1;
			   var pagingEnd  = (pagingIndex+1)*pageSize;

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

			   for (var i = pagingStart; i <= pagingEnd; i++) {
			    if(i == pagingStart){
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


