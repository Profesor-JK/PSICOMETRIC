<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<html>
<head>
    <title>Lista de Pacientes - PSICOMETRIC</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; background-color: #f4f4f9; }
        h1 { color: #333; }
        .card { background: white; padding: 15px; margin-bottom: 10px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .nombre { font-weight: bold; font-size: 18px; color: #0056b3; }
        .genero { color: #666; font-size: 14px; }
    </style>
</head>
<body>

    <h1>Lista de Pacientes (Desde JSP)</h1>

    <!-- Aquí recorremos la lista que enviamos desde el Controlador -->
    <c:forEach var="paciente" items="${pacientes}">
        <div class="card">
            <div class="nombre">${paciente.nombrePac} ${paciente.apellidosPac}</div>
            <div class="genero">Género: ${paciente.generoPsc}</div>
        </div>
    </c:forEach>

</body>
</html>