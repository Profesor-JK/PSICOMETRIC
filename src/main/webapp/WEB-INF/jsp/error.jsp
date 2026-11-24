<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Error</title>
</head>
<body>
<h1>Ha ocurrido un error</h1>
<p>Por favor, intenta de nuevo.</p>
<a href="/login">Volver al inicio de sesión</a>
<hr>
<pre style="background:#f5f5f5;padding:10px;white-space:pre-wrap;">
Código HTTP : <c:out value="${requestScope['jakarta.servlet.error.status_code']}"/>
URL         : <c:out value="${requestScope['jakarta.servlet.error.request_uri']}"/>
Mensaje     : <c:out value="${requestScope['jakarta.servlet.error.message']}"/>
Excepción   : <c:out value="${requestScope['jakarta.servlet.error.exception']}"/>
Causa       : <c:out value="${requestScope['jakarta.servlet.error.exception'].cause}"/>
    </pre>
</body>
</html>
