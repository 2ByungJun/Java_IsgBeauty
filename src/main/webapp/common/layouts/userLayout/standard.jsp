<!DOCTYPE html>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<html xml:lang="ko" lang="ko" xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="commonInclude.jsp"%>
 <meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
<title>GSIPA</title>
<link rel="shortcut icon" href="<c:url value='/resources/dist/favicons/favicon.ico'/>">
</head>

<script type="text/javaScript" language="javascript">
 $(document).ready(function() {
});

</script>
	<form id="hiddenForm"></form>

		<!--========== HEADER ==========-->
        <tiles:insertAttribute name="top"/>
	    <!--========== END HEADER ==========-->
	     <main class="page-content" id="content">
	    <!--========== CONTENTS ==========-->
	    	<!-- 본문 -->
        		<tiles:insertAttribute name="content"/>
		    	<!-- END 우측 컬럼 -->
	    	<!-- END 본문 -->
	    </main>
	    <!--========== END CONTENTS ==========-->
	    <!--========== FOOTER ==========-->
    	<tiles:insertAttribute name="footer"/>


</body>
</html>

