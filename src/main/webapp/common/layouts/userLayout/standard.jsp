<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ include file="commonInclude.jsp"%>

<!-- CSS -->
<style>
.contents-wrap {
	min-height: 80vh;
	position: relative;
}

.footer {
	width: 100%;
	height: 100px;
	position: absolute;
	bottom: 0;
}
</style>

<form id="hiddenForm"></form>

		<!--========== HEADER ==========-->
        <tiles:insertAttribute name="top"/>

	    <!--========== END HEADER ==========-->
	     <main class="page-content contents-wrap" id="content">

	    <!--========== CONTENTS ==========-->
	    	<!-- 본문 -->
        	<tiles:insertAttribute name="content"/>

		    <!-- END 우측 컬럼 -->
	    	<!-- END 본문 -->
	    </main>
	    <!--========== END CONTENTS ==========-->

	    <!--========== FOOTER ==========-->
    	<tiles:insertAttribute name="footer"/>


<!-- JS -->
<script type="text/javaScript" language="javascript">
 $(document).ready(function() {
	});
</script>

