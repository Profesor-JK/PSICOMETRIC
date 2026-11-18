<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es" data-bs-theme="light">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Psicometric | Directorio de Tests</title>

  <link rel="icon" type="image/png" href="/img/icon.png?v=2">

  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">


  <link rel="stylesheet" href="/styles/comun.css">
  <link rel="stylesheet" href="/styles/estilodire.css">
</head>

<body class="bg-white d-flex flex-column min-vh-100">

<nav class="psico-nav">
  <div class="container psico-bar">
    <a class="psico-brand" href="/">
      <i class="bi bi-brain fs-4"></i>
      <span>Psicometric</span>
    </a>

    <button class="psico-toggler" id="psicoToggler" type="button" aria-controls="psicoMenu" aria-expanded="false" aria-label="Toggle navigation">
      <i class="bi bi-list"></i>
    </button>

    <div class="psico-menu" id="psicoMenu">
      <ul class="psico-links">
        <li><a class="psico-link" href="/">Inicio</a></li>
        <li><a class="psico-link active" aria-current="page" href="/directorio">Directorio de Tests</a></li>
        <li><a class="psico-link" href="/#comunidad">Psic&oacute;logos y Pacientes</a></li>
        <li><a class="psico-link" href="/info">&iquest;Qui&eacute;nes somos?</a></li>
      </ul>

      <div class="psico-actions">
        <a href="/login" class="psico-btn psico-btn-outline">Iniciar Sesi&oacute;n</a>
        <a href="/registro" class="psico-btn psico-btn-primary">Crear Cuenta</a>
      </div>
    </div>
  </div>
</nav>

<main class="flex-grow-1">
  <div class="container my-4 animate-fade-up">
    <div class="accordion" id="accordionTests">

      <!-- 1 -->
      <div class="accordion-item border-primary-subtle mb-3 animate-fade-up delay-1">
        <h2 class="accordion-header" id="headingUno">
          <button class="accordion-button fw-bold bg-primary-subtle text-dark" type="button" data-bs-toggle="collapse" data-bs-target="#collapseUno" aria-expanded="true" aria-controls="collapseUno">
            Prueba
          </button>
        </h2>
        <div id="collapseUno" class="accordion-collapse collapse show" aria-labelledby="headingUno" data-bs-parent="#accordionTests">
          <div class="accordion-body p-0">
            <div class="list-group list-group-flush">
              <a href="/test" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                <span>Test de Moss</span>
                <span class="badge bg-primary text-white rounded-pill">15 min</span>
              </a>
              <a href="/test" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                <span>XXXX-XXXX-XXXX</span>
                <span class="badge bg-primary text-white rounded-pill">20 min</span>
              </a>
              <a href="/test" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                <span>XXXX-XXXX-XXXX</span>
                <span class="badge bg-primary text-white rounded-pill">10 min</span>
              </a>
            </div>
          </div>
        </div>
      </div>

      <!-- 2 -->
      <div class="accordion-item mb-3 animate-fade-up delay-2" style="border-color: #e8dbf8;">
        <h2 class="accordion-header" id="headingDos">
          <button class="accordion-button collapsed fw-bold text-dark" type="button" data-bs-toggle="collapse" data-bs-target="#collapseDos" aria-expanded="false" aria-controls="collapseDos" style="--bs-accordion-active-bg: #f3ebfd; --bs-accordion-active-color: #6f42c1; --bs-accordion-btn-focus-box-shadow: 0 0 0 0.25rem rgba(111, 66, 193, 0.25);">
            Prueba
          </button>
        </h2>
        <div id="collapseDos" class="accordion-collapse collapse" aria-labelledby="headingDos" data-bs-parent="#accordionTests">
          <div class="accordion-body p-0">
            <div class="list-group list-group-flush">
              <a href="/test" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                <span>Test de Terman-Merril</span>
                <span class="badge text-white rounded-pill" style="background-color: #6f42c1;">25 min</span>
              </a>
              <a href="/test" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                <span>Test de Matrices Progresivas de Raven</span>
                <span class="badge text-white rounded-pill" style="background-color: #6f42c1;">15 min</span>
              </a>
              <a href="/test" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                <span>XXXX-XXXX-XXXX</span>
                <span class="badge text-white rounded-pill" style="background-color: #6f42c1;">30 min</span>
              </a>
            </div>
          </div>
        </div>
      </div>

      <!-- 3 -->
      <div class="accordion-item animate-fade-up delay-3" style="border-color: #f8d7da;">
        <h2 class="accordion-header" id="headingTres">
          <button class="accordion-button collapsed fw-bold text-dark" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTres" aria-expanded="false" aria-controls="collapseTres" style="--bs-accordion-active-bg: #fdecea; --bs-accordion-active-color: #dc3545; --bs-accordion-btn-focus-box-shadow: 0 0 0 0.25rem rgba(220, 53, 69, 0.25);">
            Prueba
          </button>
        </h2>
        <div id="collapseTres" class="accordion-collapse collapse" aria-labelledby="headingTres" data-bs-parent="#accordionTests">
          <div class="accordion-body p-0">
            <div class="list-group list-group-flush">
              <a href="/test" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                <span>Test de Terman-Merril</span>
                <span class="badge text-white rounded-pill" style="background-color: #FF0000;">25 min</span>
              </a>
              <a href="/test" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                <span>Test de Matrices Progresivas de Raven</span>
                <span class="badge text-white rounded-pill" style="background-color: #FF0000;">15 min</span>
              </a>
              <a href="/test" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                <span>XXXX-XXXX-XXXX</span>
                <span class="badge text-white rounded-pill" style="background-color: #FF0000;">30 min</span>
              </a>
            </div>
          </div>
        </div>
      </div>

    </div>
  </div>
</main>

<footer class="bg-white border-top py-4">
  <div class="container text-muted small">
    <div class="d-flex flex-column flex-md-row justify-content-between align-items-center gap-2">
      <span>&copy; 2026 Psicometric. Todos los derechos reservados.</span>
      <div class="hstack gap-3">
        <a href="/directorio" class="text-muted text-decoration-none">Directorio</a>
        <a href="/info" class="text-muted text-decoration-none">&iquest;Qui&eacute;nes somos?</a>
      </div>
    </div>
    <p class="mb-0 mt-3 text-center text-md-start">
      Esta plataforma es &uacute;nicamente una herramienta de apoyo; la evaluaci&oacute;n y las decisiones profesionales son responsabilidad de la psic&oacute;loga a cargo.
    </p>
  </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script src="/static/js/navbar.js"></script>

</body>
</html>