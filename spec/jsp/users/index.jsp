<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ja" lang="ja">
<head>
    <c:set var="title"><%@include file="../common/head.jsp" %>aaa</c:set>
</head>
<body>
    <!-- aaa@include -->
    <div id="header">
        <%@include file="../common/header.jsp"%>
    </div>

    <!-- content -->
    <div id="content">
        <%@include file="user.jsp"%>
    </div>

    <!-- footer -->
    <div id="footer">
        <%@include file="../common/footer.jsp"%>
    </div>
</body>
</html>
