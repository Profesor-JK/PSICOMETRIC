<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es" data-bs-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>¿Quiénes somos? | Psicometric</title>

    <link rel="icon" type="image/png" href="/img/icon.png?v=2">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <link rel="stylesheet" href="/styles/comun.css">
    <link rel="stylesheet" href="/styles/estiloinfo.css">
</head>

<body class="bg-white d-flex flex-column min-vh-100">

<jsp:include page="/WEB-INF/jsp/fragments/navbar.jsp">
    <jsp:param name="activo" value="directorio"/>
</jsp:include>

<main class="flex-grow-1">

    <section class="bg-dark text-white py-5">
        <div class="container text-center py-3">
            <h1 class="fw-bold display-5 animate-fade-up">¿Quiénes somos?</h1>
            <p class="lead text-white-50 mb-0 mx-auto animate-fade-up delay-1" style="max-width: 640px;">
                Conoce al equipo detrás de Psicometric y de qué trata nuestro proyecto.
            </p>
        </div>
    </section>

    <section class="container my-5">
        <div class="row g-4 align-items-stretch">
            <div class="col-lg-7 animate-fade-up delay-1">
                <h2 class="fw-bold mb-3">Sobre el proyecto</h2>
                <p class="text-secondary">
                    <strong>Psicometric</strong> es una herramienta para la psicología. Permite a los
                    psicólogos crear y aplicar sus propios tests, y a los usuarios resolverlos de forma
                    sencilla desde cualquier dispositivo.
                </p>
                <p class="text-secondary mb-0">
                    Una vez que el usuario termina un test, la plataforma muestra los resultados, para que
                    el psicólogo pueda revisarlos y dar seguimiento a cada caso.
                </p>
            </div>

            <div class="col-lg-5">
                <div class="vstack gap-3">
                    <div class="d-flex align-items-center gap-3 animate-fade-up delay-1">
                        <div class="icon-box bg-primary-subtle text-primary"><i class="bi bi-clipboard2-pulse"></i></div>
                        <div>
                            <div class="fw-semibold">Los psicólogos crean sus tests</div>
                            <div class="small text-secondary">Diseñan y gestionan sus evaluaciones.</div>
                        </div>
                    </div>
                    <div class="d-flex align-items-center gap-3 animate-fade-up delay-2">
                        <div class="icon-box bg-success-subtle text-success"><i class="bi bi-pencil-square"></i></div>
                        <div>
                            <div class="fw-semibold">Los usuarios los resuelven</div>
                            <div class="small text-secondary">Responden en línea, a su ritmo.</div>
                        </div>
                    </div>
                    <div class="d-flex align-items-center gap-3 animate-fade-up delay-3">
                        <div class="icon-box bg-warning-subtle text-warning-emphasis"><i class="bi bi-bar-chart-line"></i></div>
                        <div>
                            <div class="fw-semibold">Se muestran los resultados</div>
                            <div class="small text-secondary">Al finalizar, se presentan de forma clara.</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="container mb-5">
        <div class="alert alert-warning d-flex align-items-start gap-3 mb-0 shadow-sm" role="alert">
            <i class="bi bi-exclamation-triangle-fill fs-4"></i>
            <div>
                <h3 class="h6 fw-bold mb-1">Aviso importante</h3>
                <p class="mb-0">
                    Esta plataforma es únicamente una herramienta de apoyo; la evaluación y las decisiones
                    profesionales son responsabilidad de la psicóloga a cargo.
                </p>
            </div>
        </div>
    </section>

    <section class="bg-light py-5">
        <div class="container">
            <div class="text-center mb-4">
                <h2 class="fw-bold mb-1">Nuestro equipo</h2>
                <p class="text-secondary mb-0">Integrantes del grupo <strong>5IM9</strong></p>
            </div>

            <div class="row g-4 justify-content-center">
                <div class="col-sm-6 col-lg-3 animate-fade-up delay-1">
                    <div class="card card-hover h-100 text-center shadow-sm">
                        <div class="card-body p-4">
                            <div class="avatar-circle bg-primary-subtle text-primary mb-3">SB</div>
                            <h3 class="h6 fw-bold mb-1">Samuel Francisco Bueno Robles</h3>
                            <span class="badge bg-primary-subtle text-primary rounded-pill">5IM9</span>
                        </div>
                    </div>
                </div>

                <div class="col-sm-6 col-lg-3 animate-fade-up delay-2">
                    <div class="card card-hover h-100 text-center shadow-sm">
                        <div class="card-body p-4">
                            <div class="avatar-circle text-white mb-3" style="background-color: #6f42c1;">LC</div>
                            <h3 class="h6 fw-bold mb-1">Luis Roberto Cástulo Soto</h3>
                            <span class="badge rounded-pill" style="background-color: #f3ebfd; color: #6f42c1;">5IM9</span>
                        </div>
                    </div>
                </div>

                <div class="col-sm-6 col-lg-3 animate-fade-up delay-3">
                    <div class="card card-hover h-100 text-center shadow-sm">
                        <div class="card-body p-4">
                            <div class="avatar-circle bg-success-subtle text-success mb-3">ER</div>
                            <h3 class="h6 fw-bold mb-1">Erick Aaron Romero Ovalle</h3>
                            <span class="badge bg-success-subtle text-success rounded-pill">5IM9</span>
                        </div>
                    </div>
                </div>

                <div class="col-sm-6 col-lg-3 animate-fade-up delay-4">
                    <div class="card card-hover h-100 text-center shadow-sm">
                        <div class="card-body p-4">
                            <div class="avatar-circle bg-danger-subtle text-danger mb-3">AM</div>
                            <h3 class="h6 fw-bold mb-1">Alejandro Martinez Sanabria</h3>
                            <span class="badge bg-danger-subtle text-danger rounded-pill">5IM9</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

</main>

<footer class="bg-white border-top py-4">
    <div class="container text-muted small">
        <div class="d-flex flex-column flex-md-row justify-content-between align-items-center gap-2">
            <span>&copy; 2026 Psicometric. Todos los derechos reservados.</span>
            <div class="hstack gap-3">
                <a href="/directorio" class="text-muted text-decoration-none">Directorio</a>
                <a href="/info" class="text-muted text-decoration-none">¿Quiénes somos?</a>
            </div>
        </div>
        <p class="mb-0 mt-3 text-center text-md-start">
            Esta plataforma es únicamente una herramienta de apoyo; la evaluación y las decisiones profesionales son responsabilidad de la psicóloga a cargo.
        </p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script src="/static/js/navbar.js"></script>

</body>
</html>
