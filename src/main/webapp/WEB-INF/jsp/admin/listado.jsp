<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="es" data-bs-theme="light">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Psicometric | Administraci&oacute;n: <c:out value="${titulo}"/></title>
  <link rel="icon" type="image/png" href="/img/icon.png">

  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

  <link rel="stylesheet" href="/styles/comun.css">
  <link rel="stylesheet" href="/styles/estilocrear.css">
</head>

<body class="bg-white d-flex flex-column min-vh-100">

<jsp:include page="/WEB-INF/jsp/fragments/navbar.jsp">
  <jsp:param name="activo" value="${seccion}"/>
</jsp:include>

<main class="flex-grow-1">
  <div class="container my-5">

    <c:if test="${not empty exito}">
      <div class="alert alert-success" role="alert"><c:out value="${exito}"/></div>
    </c:if>
    <c:if test="${not empty error}">
      <div class="alert alert-danger" role="alert"><c:out value="${error}"/></div>
    </c:if>

    <div class="d-flex justify-content-between align-items-end flex-wrap gap-2 mb-3">
      <div>
        <p class="text-uppercase text-muted small fw-semibold mb-1">
          <c:choose>
            <c:when test="${modo == 'cambios'}">Cambios</c:when>
            <c:when test="${modo == 'bajas'}">Bajas</c:when>
            <c:otherwise>Consultas</c:otherwise>
          </c:choose>
        </p>
        <h1 class="h3 fw-bold mb-0"><c:out value="${titulo}"/></h1>
      </div>
      <a href="${ctx}${ruta}/nuevo" class="btn btn-primary"><i class="bi bi-plus-circle me-1"></i>Alta</a>
    </div>

    <form method="get" action="${ctx}${ruta}" class="row g-2 mb-3">
      <input type="hidden" name="modo" value="${modo}">
      <div class="col-sm-8 col-md-6">
        <input type="search" name="q" value="<c:out value='${q}'/>" class="form-control" placeholder="Buscar...">
      </div>
      <div class="col-auto"><button type="submit" class="btn btn-outline-secondary">Buscar</button></div>
      <c:if test="${not empty q}"><div class="col-auto"><a href="${ctx}${ruta}?modo=${modo}" class="btn btn-link">Limpiar</a></div></c:if>
    </form>

    <c:choose>
      <c:when test="${empty filas}">
        <section class="seccion-card"><div class="seccion-body"><div class="estado-vacio"><i class="bi bi-inbox"></i><p class="mb-0">No hay registros.</p></div></div></section>
      </c:when>
      <c:otherwise>
        <div class="table-responsive">
          <table class="table table-hover align-middle">
            <thead class="table-light">
              <tr>
                <c:forEach var="col" items="${columnas}"><th><c:out value="${col}"/></th></c:forEach>
                <c:if test="${modo != 'consulta'}"><th class="text-end">Acci&oacute;n</th></c:if>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="f" items="${filas}">
                <tr>
                  <c:forEach var="celda" items="${f.celdas}"><td><c:out value="${celda}"/></td></c:forEach>
                  <c:if test="${modo == 'cambios'}">
                    <td class="text-end"><a href="${ctx}${ruta}/${f.id}/editar" class="btn btn-sm btn-outline-primary"><i class="bi bi-pencil-square me-1"></i>Editar</a></td>
                  </c:if>
                  <c:if test="${modo == 'bajas'}">
                    <td class="text-end">
                      <form method="post" action="${ctx}${ruta}/${f.id}/eliminar" class="d-inline m-0"
                            onsubmit="return confirm('¿Eliminar este registro? También se borrará todo lo que depende de él.');">
                        <button type="submit" class="btn btn-sm btn-outline-danger"><i class="bi bi-trash me-1"></i>Eliminar</button>
                      </form>
                    </td>
                  </c:if>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </c:otherwise>
    </c:choose>

  </div>
</main>

<footer class="bg-white border-top py-4">
  <div class="container text-muted small">
    <p class="mb-0 text-center text-md-start">Panel del moderador. Los cambios y bajas afectan directamente a los datos de la plataforma.</p>
  </div>
</footer>

<script src="/js/navbar.js"></script>
</body>
</html>
