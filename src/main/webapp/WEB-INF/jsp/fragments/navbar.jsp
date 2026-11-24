<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%-- Sesión real = hay usuario autenticado. Sin sesión (invitado) los dos roles son false. --%>
<c:set var="hayUsuario" value="${not empty pageContext.request.userPrincipal}" />
<c:set var="esPsicologo" value="${hayUsuario and pageContext.request.isUserInRole('PSICOLOGO')}" />
<c:set var="esPaciente" value="${hayUsuario and not esPsicologo and pageContext.request.isUserInRole('PACIENTE')}" />
<c:set var="esTutor" value="${hayUsuario and not esPsicologo and not esPaciente and pageContext.request.isUserInRole('TUTOR')}" />
<c:set var="esModerador" value="${hayUsuario and not esPsicologo and not esPaciente and not esTutor and pageContext.request.isUserInRole('MODERADOR')}" />
<c:set var="esInvitado" value="${not esPsicologo and not esPaciente and not esTutor and not esModerador}" />
<c:set var="inicioUrl" value="${esPsicologo ? '/psicologo/inicio' : (esPaciente ? '/paciente/inicio' : (esTutor ? '/tutor/tests' : (esModerador ? '/admin/psicologos' : '/')))}" />

<nav class="psico-nav">
    <div class="container psico-bar">
        <a class="psico-brand" href="${ctx}${inicioUrl}">
            <i class="bi bi-brain fs-4"></i>
            <span>Psicometric</span>
        </a>

        <button class="psico-toggler" id="psicoToggler" type="button" aria-controls="psicoMenu" aria-expanded="false" aria-label="Toggle navigation">
            <i class="bi bi-list"></i>
        </button>

        <div class="psico-menu" id="psicoMenu">
            <ul class="psico-links">
              <c:choose>
                <c:when test="${esTutor}">
                    <li><a class="psico-link ${param.activo == 'tutorTests' ? 'active' : ''}" href="${ctx}/tutor/tests">Ver tests</a></li>
                    <li><a class="psico-link ${param.activo == 'tutorActividad' ? 'active' : ''}" href="${ctx}/tutor/actividad">Ver actividad del paciente</a></li>
                </c:when>
                <c:when test="${esModerador}">
                    <li class="psico-dropdown">
                        <a class="psico-link psico-dropdown-toggle ${param.activo == 'adminPsicologos' ? 'active' : ''}" href="#" role="button" aria-expanded="false">Gestionar Psic&oacute;logos <i class="bi bi-chevron-down small"></i></a>
                        <ul class="psico-dropdown-menu">
                            <li><a class="psico-dropdown-item" href="${ctx}/admin/psicologos"><i class="bi bi-search"></i> Consultas</a></li>
                            <li><a class="psico-dropdown-item" href="${ctx}/admin/psicologos/nuevo"><i class="bi bi-plus-circle"></i> Altas</a></li>
                            <li><a class="psico-dropdown-item" href="${ctx}/admin/psicologos?modo=cambios"><i class="bi bi-pencil-square"></i> Cambios</a></li>
                            <li><a class="psico-dropdown-item" href="${ctx}/admin/psicologos?modo=bajas"><i class="bi bi-trash"></i> Bajas</a></li>
                        </ul>
                    </li>
                    <li class="psico-dropdown">
                        <a class="psico-link psico-dropdown-toggle ${param.activo == 'adminTutores' ? 'active' : ''}" href="#" role="button" aria-expanded="false">Gestionar Tutores <i class="bi bi-chevron-down small"></i></a>
                        <ul class="psico-dropdown-menu">
                            <li><a class="psico-dropdown-item" href="${ctx}/admin/tutores"><i class="bi bi-search"></i> Consultas</a></li>
                            <li><a class="psico-dropdown-item" href="${ctx}/admin/tutores/nuevo"><i class="bi bi-plus-circle"></i> Altas</a></li>
                            <li><a class="psico-dropdown-item" href="${ctx}/admin/tutores?modo=cambios"><i class="bi bi-pencil-square"></i> Cambios</a></li>
                            <li><a class="psico-dropdown-item" href="${ctx}/admin/tutores?modo=bajas"><i class="bi bi-trash"></i> Bajas</a></li>
                        </ul>
                    </li>
                    <li class="psico-dropdown">
                        <a class="psico-link psico-dropdown-toggle ${param.activo == 'adminPacientes' ? 'active' : ''}" href="#" role="button" aria-expanded="false">Gestionar Pacientes <i class="bi bi-chevron-down small"></i></a>
                        <ul class="psico-dropdown-menu">
                            <li><a class="psico-dropdown-item" href="${ctx}/admin/pacientes"><i class="bi bi-search"></i> Consultas</a></li>
                            <li><a class="psico-dropdown-item" href="${ctx}/admin/pacientes/nuevo"><i class="bi bi-plus-circle"></i> Altas</a></li>
                            <li><a class="psico-dropdown-item" href="${ctx}/admin/pacientes?modo=cambios"><i class="bi bi-pencil-square"></i> Cambios</a></li>
                            <li><a class="psico-dropdown-item" href="${ctx}/admin/pacientes?modo=bajas"><i class="bi bi-trash"></i> Bajas</a></li>
                        </ul>
                    </li>
                    <li class="psico-dropdown">
                        <a class="psico-link psico-dropdown-toggle ${param.activo == 'adminTests' ? 'active' : ''}" href="#" role="button" aria-expanded="false">Gestionar Tests <i class="bi bi-chevron-down small"></i></a>
                        <ul class="psico-dropdown-menu">
                            <li><a class="psico-dropdown-item" href="${ctx}/admin/tests"><i class="bi bi-search"></i> Consultas</a></li>
                            <li><a class="psico-dropdown-item" href="${ctx}/admin/tests/nuevo"><i class="bi bi-plus-circle"></i> Altas</a></li>
                            <li><a class="psico-dropdown-item" href="${ctx}/admin/tests?modo=cambios"><i class="bi bi-pencil-square"></i> Cambios</a></li>
                            <li><a class="psico-dropdown-item" href="${ctx}/admin/tests?modo=bajas"><i class="bi bi-trash"></i> Bajas</a></li>
                        </ul>
                    </li>
                </c:when>
                <c:otherwise>
                <li><a class="psico-link ${param.activo == 'inicio' ? 'active' : ''}" href="${ctx}${inicioUrl}">Inicio</a></li>
                <li><a class="psico-link ${param.activo == 'directorio' ? 'active' : ''}" href="${ctx}/directorio">Directorio de Tests</a></li>

                <c:if test="${esInvitado}">
                    <li><a class="psico-link" href="${ctx}/#comunidad">Psic&oacute;logos</a></li>
                </c:if>

                <c:if test="${esPsicologo}">
                    <li><a class="psico-link ${param.activo == 'creartest' ? 'active' : ''}" href="${ctx}/creartest">Crear test</a></li>
                    <li><a class="psico-link ${param.activo == 'respuestas' ? 'active' : ''}" href="${ctx}/psicologo/respuestas">Respuestas</a></li>
                </c:if>

                <c:if test="${esPaciente}">
                    <li><a class="psico-link ${param.activo == 'test' ? 'active' : ''}" href="${ctx}/test">Realizar test</a></li>
                    <li><a class="psico-link ${param.activo == 'historial' ? 'active' : ''}" href="${ctx}/paciente/historial">Mis tests</a></li>
                </c:if>

                <li><a class="psico-link ${param.activo == 'info' ? 'active' : ''}" href="${ctx}/info">&iquest;Qui&eacute;nes somos?</a></li>
                </c:otherwise>
              </c:choose>
            </ul>

            <div class="psico-actions">
                <c:choose>
                    <c:when test="${not esInvitado}">
                        <form action="${ctx}/logout" method="post" class="d-inline m-0">
                            <button type="submit" class="psico-btn ">Cerrar sesi&oacute;n</button>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <a href="${ctx}/login" class="psico-btn psico-btn-outline">Iniciar Sesi&oacute;n</a>
                        <a href="${ctx}/registro" class="psico-btn psico-btn-primary">Crear Cuenta</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</nav>
