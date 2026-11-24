(function () {
    'use strict';

    const estado = { preguntas: [], resultados: [] };
    let contadorId = 1;

    const TIPOS = {
        unica: 'Opción única',
        multiple: 'Selección múltiple',
        escala: 'Escala numérica',
        abierta: 'Respuesta abierta'
    };

    const NIVELES = {
        success: 'Verde (favorable)',
        primary: 'Azul (neutral)',
        warning: 'Amarillo (atención)',
        danger: 'Rojo (alerta)',
        secondary: 'Gris'
    };
    const ORDEN_NIVELES = ['success', 'primary', 'warning', 'danger'];

    const $ = function (sel) { return document.querySelector(sel); };

    const chkExclusivo = $('#testExclusivo');
    const bloqueExclusivo = $('#bloqueExclusivo');
    const selPaciente = $('#testPaciente');

    function esc(s) {
        return String(s == null ? '' : s).replace(/[&<>"']/g, function (c) {
            return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c];
        });
    }

    function num(v) {
        const n = parseFloat(v);
        return isNaN(n) ? 0 : n;
    }

    function fmt(n) {
        return Number.isInteger(n) ? String(n) : String(Math.round(n * 100) / 100);
    }

    function opcionesSelect(mapa, actual) {
        return Object.keys(mapa).map(function (k) {
            return '<option value="' + k + '"' + (k === actual ? ' selected' : '') + '>' + mapa[k] + '</option>';
        }).join('');
    }

    function nuevaPregunta() {
        return {
            id: contadorId++,
            texto: '',
            tipo: 'unica',
            obligatoria: true,
            opciones: [{ texto: '', puntos: 0 }, { texto: '', puntos: 1 }],
            escala: { min: 1, max: 5, etiquetaMin: '', etiquetaMax: '' }
        };
    }

    function nuevoResultado() {
        const total = rangoTotal();
        const ultimoMax = estado.resultados.length
            ? Math.max.apply(null, estado.resultados.map(function (r) { return num(r.max); }))
            : total[0] - 1;
        const min = ultimoMax + 1;
        return {
            min: min,
            max: Math.max(min, total[1]),
            titulo: '',
            descripcion: '',
            nivel: ORDEN_NIVELES[estado.resultados.length % ORDEN_NIVELES.length]
        };
    }

    function rangoPregunta(p) {
        let mn = 0, mx = 0;

        if (p.tipo === 'unica') {
            const v = p.opciones.map(function (o) { return num(o.puntos); });
            if (v.length) { mn = Math.min.apply(null, v); mx = Math.max.apply(null, v); }
            if (!p.obligatoria) { mn = Math.min(mn, 0); mx = Math.max(mx, 0); }
        } else if (p.tipo === 'multiple') {
            p.opciones.forEach(function (o) {
                const n = num(o.puntos);
                if (n < 0) mn += n; else mx += n;
            });
        } else if (p.tipo === 'escala') {
            const a = num(p.escala.min), b = num(p.escala.max);
            mn = Math.min(a, b); mx = Math.max(a, b);
            if (!p.obligatoria) { mn = Math.min(mn, 0); mx = Math.max(mx, 0); }
        }
        return [mn, mx];
    }

    function rangoTotal() {
        let mn = 0, mx = 0;
        estado.preguntas.forEach(function (p) {
            const r = rangoPregunta(p);
            mn += r[0]; mx += r[1];
        });
        return [mn, mx];
    }

    function htmlOpciones(p) {
        const icono = p.tipo === 'unica' ? 'bi-record-circle' : 'bi-check-square';
        const filas = p.opciones.map(function (o, j) {
            return '' +
                '<div class="opcion-row" data-j="' + j + '">' +
                '<i class="bi ' + icono + ' text-muted"></i>' +
                '<input type="text" class="form-control form-control-sm" data-campo="opTexto" placeholder="Respuesta ' + (j + 1) + '" value="' + esc(o.texto) + '">' +
                '<div class="input-group input-group-sm puntos-group">' +
                '<input type="number" step="any" min="0" class="form-control" data-campo="opPuntos" value="' + esc(o.puntos) + '" title="Puntos que suma esta respuesta">' +
                '<span class="input-group-text">pts</span>' +
                '</div>' +
                '<button type="button" class="btn btn-sm btn-outline-danger" data-accion="delOpcion" title="Quitar respuesta"><i class="bi bi-x-lg"></i></button>' +
                '</div>';
        }).join('');

        return '<div class="opciones">' + filas + '</div>' +
            '<button type="button" class="btn btn-sm btn-outline-primary mt-1" data-accion="addOpcion"><i class="bi bi-plus-lg me-1"></i>Agregar respuesta</button>';
    }

    function htmlEscala(p) {
        const e = p.escala;
        return '' +
            '<div class="row g-2">' +
            '<div class="col-6 col-md-3"><label class="form-label small mb-1">Valor mínimo</label>' +
            '<input type="number" step="any" min="0" class="form-control form-control-sm" data-campo="escMin" value="' + esc(e.min) + '"></div>' +
            '<div class="col-6 col-md-3"><label class="form-label small mb-1">Valor máximo</label>' +
            '<input type="number" step="any" min="0" class="form-control form-control-sm" data-campo="escMax" value="' + esc(e.max) + '"></div>' +
            '<div class="col-6 col-md-3"><label class="form-label small mb-1">Etiqueta mínimo</label>' +
            '<input type="text" class="form-control form-control-sm" data-campo="escEtMin" placeholder="Ej. Nunca" value="' + esc(e.etiquetaMin) + '"></div>' +
            '<div class="col-6 col-md-3"><label class="form-label small mb-1">Etiqueta máximo</label>' +
            '<input type="text" class="form-control form-control-sm" data-campo="escEtMax" placeholder="Ej. Siempre" value="' + esc(e.etiquetaMax) + '"></div>' +
            '</div>' +
            '<p class="small text-muted mt-2 mb-0">El usuario elige un valor entre el mínimo y el máximo, y ese valor se suma al puntaje.</p>';
    }

    function htmlPregunta(p, i) {
        let cuerpo;
        if (p.tipo === 'unica' || p.tipo === 'multiple') cuerpo = htmlOpciones(p);
        else if (p.tipo === 'escala') cuerpo = htmlEscala(p);
        else cuerpo = '<p class="small text-muted mb-0"><i class="bi bi-info-circle me-1"></i>Esta pregunta no suma puntos; la respuesta queda para tu revisión.</p>';

        return '' +
            '<div class="pregunta-card" data-i="' + i + '">' +
            '<div class="d-flex flex-wrap align-items-center gap-2 mb-3">' +
            '<span class="pregunta-num">' + (i + 1) + '</span>' +
            '<select class="form-select form-select-sm w-auto" data-campo="tipo">' + opcionesSelect(TIPOS, p.tipo) + '</select>' +
            '<div class="form-check form-switch mb-0 ms-1">' +
            '<input class="form-check-input" type="checkbox" role="switch" id="obl-' + p.id + '" data-campo="obligatoria"' + (p.obligatoria ? ' checked' : '') + '>' +
            '<label class="form-check-label small" for="obl-' + p.id + '">Pregunta Obligatoria</label>' +
            '</div>' +
            '<div class="btn-group btn-group-sm ms-auto">' +
            '<button type="button" class="btn btn-outline-secondary" data-accion="subir" title="Subir"><i class="bi bi-arrow-up"></i></button>' +
            '<button type="button" class="btn btn-outline-secondary" data-accion="bajar" title="Bajar"><i class="bi bi-arrow-down"></i></button>' +
            '<button type="button" class="btn btn-outline-secondary" data-accion="duplicar" title="Duplicar"><i class="bi bi-copy"></i></button>' +
            '<button type="button" class="btn btn-outline-danger" data-accion="eliminar" title="Eliminar"><i class="bi bi-trash"></i></button>' +
            '</div>' +
            '</div>' +
            '<textarea class="form-control mb-3" rows="2" data-campo="texto" placeholder="Escribe la pregunta">' + esc(p.texto) + '</textarea>' +
            cuerpo +
            '</div>';
    }

    function htmlResultado(r, i) {
        return '' +
            '<div class="resultado-card nivel-' + r.nivel + '" data-i="' + i + '">' +
            '<div class="d-flex flex-wrap align-items-center gap-2 mb-3">' +
            '<span class="badge text-bg-' + r.nivel + '">Resultado ' + (i + 1) + '</span>' +
            '<div class="input-group input-group-sm w-auto">' +
            '<span class="input-group-text">De</span>' +
            '<input type="number" step="any" min="0" class="form-control" style="width:90px" data-campo="min" value="' + esc(r.min) + '">' +
            '<span class="input-group-text">a</span>' +
            '<input type="number" step="any" min="0" class="form-control" style="width:90px" data-campo="max" value="' + esc(r.max) + '">' +
            '<span class="input-group-text">pts</span>' +
            '</div>' +
            '<select class="form-select form-select-sm w-auto" data-campo="nivel">' + opcionesSelect(NIVELES, r.nivel) + '</select>' +
            '<button type="button" class="btn btn-sm btn-outline-danger ms-auto" data-accion="delResultado" title="Eliminar resultado"><i class="bi bi-trash"></i></button>' +
            '</div>' +
            '<input type="text" class="form-control mb-2" data-campo="titulo" placeholder="Título del resultado (ej. Nivel alto)" value="' + esc(r.titulo) + '">' +
            '<textarea class="form-control" rows="3" data-campo="descripcion" placeholder="Texto que verá el usuario con este resultado">' + esc(r.descripcion) + '</textarea>' +
            '</div>';
    }

    function renderPreguntas() {
        $('#listaPreguntas').innerHTML = estado.preguntas.map(htmlPregunta).join('');
        $('#sinPreguntas').classList.toggle('d-none', estado.preguntas.length > 0);
        actualizarResumen();
    }

    // Redibuja SOLO una tarjeta (no toda la lista)
    function renderPregunta(i) {
        $('#listaPreguntas').children[i].outerHTML = htmlPregunta(estado.preguntas[i], i);
        actualizarResumen();
    }

    function renderResultado(i) {
        $('#listaResultados').children[i].outerHTML = htmlResultado(estado.resultados[i], i);
        actualizarResumen();
    }

    let tResumen = null, tRevision = null;
    function programarResumen() {
        clearTimeout(tResumen);
        tResumen = setTimeout(actualizarResumen, 150);
    }
    function programarRevision() {
        clearTimeout(tRevision);
        tRevision = setTimeout(renderRevision, 300);
    }

    function renderResultados() {
        $('#listaResultados').innerHTML = estado.resultados.map(htmlResultado).join('');
        actualizarResumen();
    }

    function actualizarResumen() {
        const t = rangoTotal();
        $('#resPreguntas').textContent = estado.preguntas.length;
        $('#resRangos').textContent = estado.resultados.length;
        $('#resMin').textContent = fmt(t[0]);
        $('#resMax').textContent = fmt(t[1]);
        $('#infoRangoPosible').textContent = 'Puntaje posible: ' + fmt(t[0]) + ' a ' + fmt(t[1]) + ' puntos.';
        renderRevision();
    }

    function validar() {
        const errores = [], avisos = [];

        if (!$('#testNombre').value.trim()) errores.push('Escribe el nombre del test.');
        if (!estado.preguntas.length) errores.push('Agrega al menos una pregunta.');
        if (chkExclusivo.checked && !selPaciente.value) errores.push('Elige el paciente para quien es exclusivo este test.');

        estado.preguntas.forEach(function (p, i) {
            const n = i + 1;
            if (!p.texto.trim()) errores.push('Pregunta ' + n + ': falta el texto.');
            if (p.tipo === 'unica' || p.tipo === 'multiple') {
                if (p.opciones.length < 2) errores.push('Pregunta ' + n + ': agrega al menos 2 respuestas.');
                if (p.opciones.some(function (o) { return !o.texto.trim(); })) errores.push('Pregunta ' + n + ': hay respuestas vacías.');
            }
            if (p.tipo === 'unica' || p.tipo === 'multiple') {
                if (p.opciones.some(function (o) { return num(o.puntos) < 0; })) errores.push('Pregunta ' + n + ': los puntos no pueden ser negativos.');
            }
            if (p.tipo === 'escala' && num(p.escala.min) < 0) errores.push('Pregunta ' + n + ': la escala no puede tener valores negativos.');
            if (p.tipo === 'escala' && num(p.escala.min) >= num(p.escala.max)) {
                errores.push('Pregunta ' + n + ': el mínimo de la escala debe ser menor que el máximo.');
            }
        });

        if (!estado.resultados.length) {
            avisos.push('Aún no defines resultados: el usuario no verá ninguna interpretación.');
        }

        estado.resultados.forEach(function (r, i) {
            const n = i + 1;
            if (num(r.min) < 0 || num(r.max) < 0) errores.push('Resultado ' + n + ': el puntaje no puede ser negativo.');
            if (num(r.min) > num(r.max)) errores.push('Resultado ' + n + ': el mínimo es mayor que el máximo.');
            if (!r.titulo.trim()) errores.push('Resultado ' + n + ': falta el título.');
        });

        const rangos = estado.resultados
            .map(function (r) { return { min: num(r.min), max: num(r.max) }; })
            .filter(function (r) { return r.min <= r.max; })
            .sort(function (a, b) { return a.min - b.min; });

        if (rangos.length && estado.preguntas.length) {
            const t = rangoTotal();
            let tope = rangos[0].max;
            let haySolape = false, hayHueco = false;

            if (rangos[0].min > t[0]) avisos.push('Los puntajes menores a ' + fmt(rangos[0].min) + ' no tienen resultado.');

            for (let k = 1; k < rangos.length; k++) {
                if (rangos[k].min <= tope) haySolape = true;
                else if (rangos[k].min - tope > 1) hayHueco = true;
                tope = Math.max(tope, rangos[k].max);
            }

            if (haySolape) avisos.push('Hay rangos que se solapan: un mismo puntaje daría dos resultados.');
            if (hayHueco) avisos.push('Hay huecos entre rangos: algunos puntajes no tendrían resultado.');
            if (tope < t[1]) avisos.push('Los puntajes mayores a ' + fmt(tope) + ' no tienen resultado.');
        }

        return { errores: errores, avisos: avisos };
    }

    function renderRevision() {
        const v = validar();
        const cont = $('#revision');

        if (!v.errores.length && !v.avisos.length) {
            cont.innerHTML = '<div class="revision-item ok"><i class="bi bi-check-circle-fill"></i><span>Todo listo para guardar.</span></div>';
            return;
        }

        const fila = function (clase, icono, msg) {
            return '<div class="revision-item ' + clase + '"><i class="bi ' + icono + '"></i><span>' + esc(msg) + '</span></div>';
        };

        cont.innerHTML =
            v.errores.map(function (m) { return fila('err', 'bi-x-circle-fill', m); }).join('') +
            v.avisos.map(function (m) { return fila('warn', 'bi-exclamation-triangle-fill', m); }).join('');
    }

    function construirJson() {
        const t = rangoTotal();
        return {
            nombre: $('#testNombre').value.trim(),
            categoria: $('#testCategoria').value.trim(),
            duracionMin: num($('#testDuracion').value),
            descripcion: $('#testDescripcion').value.trim(),
            instrucciones: $('#testInstrucciones').value.trim(),
            idPacienteExclusivo: chkExclusivo.checked && selPaciente.value ? parseInt(selPaciente.value, 10) : null,
            puntajeMinimo: t[0],
            puntajeMaximo: t[1],
            preguntas: estado.preguntas.map(function (p, i) {
                const conOpciones = p.tipo === 'unica' || p.tipo === 'multiple';
                return {
                    orden: i + 1,
                    texto: p.texto.trim(),
                    tipo: p.tipo,
                    obligatoria: p.obligatoria,
                    opciones: conOpciones
                        ? p.opciones.map(function (o) { return { texto: o.texto.trim(), puntos: num(o.puntos) }; })
                        : [],
                    escala: p.tipo === 'escala'
                        ? { min: num(p.escala.min), max: num(p.escala.max), etiquetaMin: p.escala.etiquetaMin, etiquetaMax: p.escala.etiquetaMax }
                        : null
                };
            }),
            resultados: estado.resultados.map(function (r) {
                return { min: num(r.min), max: num(r.max), titulo: r.titulo.trim(), descripcion: r.descripcion.trim(), nivel: r.nivel };
            })
        };
    }

    function mostrarJson() {
        const pre = $('#jsonPreview');
        pre.textContent = JSON.stringify(construirJson(), null, 2);
        pre.classList.remove('d-none');
    }

    // Ningún campo numérico de puntos acepta negativos: se bloquea el "-" y se limpia lo pegado.
    function sinNegativos(e) {
        const el = e.target;
        if (el.matches && el.matches('input[type="number"][min="0"]') && el.value.trim().charAt(0) === '-') {
            el.value = el.value.replace(/^\s*-+/, '');
        }
    }
    document.addEventListener('keydown', function (e) {
        if (e.key === '-' && e.target.matches && e.target.matches('input[type="number"][min="0"]')) e.preventDefault();
    });
    document.addEventListener('input', sinNegativos, true);   // captura: corre antes de los demás manejadores

    $('#listaPreguntas').addEventListener('input', function (e) {
        const campo = e.target.dataset.campo;
        if (!campo) return;

        const card = e.target.closest('.pregunta-card');
        const p = estado.preguntas[card.dataset.i];
        const fila = e.target.closest('.opcion-row');

        switch (campo) {
            case 'texto':       p.texto = e.target.value; break;
            case 'obligatoria': p.obligatoria = e.target.checked; break;
            case 'tipo':        p.tipo = e.target.value; renderPregunta(parseInt(card.dataset.i, 10)); return;
            case 'opTexto':     p.opciones[fila.dataset.j].texto = e.target.value; break;
            case 'opPuntos':    p.opciones[fila.dataset.j].puntos = e.target.value; break;
            case 'escMin':      p.escala.min = e.target.value; break;
            case 'escMax':      p.escala.max = e.target.value; break;
            case 'escEtMin':    p.escala.etiquetaMin = e.target.value; break;
            case 'escEtMax':    p.escala.etiquetaMax = e.target.value; break;
        }
        // Solo los puntos, la escala y "obligatoria" cambian el puntaje; el texto solo la revisión
        if (campo === 'opPuntos' || campo === 'escMin' || campo === 'escMax' || campo === 'obligatoria') programarResumen();
        else programarRevision();
    });

    $('#listaPreguntas').addEventListener('click', function (e) {
        const btn = e.target.closest('[data-accion]');
        if (!btn) return;

        const card = btn.closest('.pregunta-card');
        const i = parseInt(card.dataset.i, 10);
        const lista = estado.preguntas;
        const p = lista[i];

        switch (btn.dataset.accion) {
            case 'subir':
                if (i > 0) { const t = lista[i - 1]; lista[i - 1] = lista[i]; lista[i] = t; renderPreguntas(); }
                break;
            case 'bajar':
                if (i < lista.length - 1) { const t = lista[i + 1]; lista[i + 1] = lista[i]; lista[i] = t; renderPreguntas(); }
                break;
            case 'duplicar': {
                const copia = JSON.parse(JSON.stringify(p));
                copia.id = contadorId++;
                lista.splice(i + 1, 0, copia);
                renderPreguntas();
                break;
            }
            case 'eliminar':
                if (!p.texto.trim() || confirm('¿Eliminar esta pregunta?')) {
                    lista.splice(i, 1);
                    renderPreguntas();
                }
                break;
            case 'addOpcion': {
                p.opciones.push({ texto: '', puntos: 0 });
                renderPregunta(i);
                const inputs = $('#listaPreguntas').children[i].querySelectorAll('[data-campo="opTexto"]');
                inputs[inputs.length - 1].focus();
                break;
            }
            case 'delOpcion': {
                const j = parseInt(btn.closest('.opcion-row').dataset.j, 10);
                p.opciones.splice(j, 1);
                renderPregunta(i);
                break;
            }
        }
    });

    $('#btnAddPregunta').addEventListener('click', function () {
        const nueva = nuevaPregunta();
        estado.preguntas.push(nueva);
        $('#listaPreguntas').insertAdjacentHTML('beforeend', htmlPregunta(nueva, estado.preguntas.length - 1));
        $('#sinPreguntas').classList.add('d-none');
        actualizarResumen();
        const cards = $('#listaPreguntas').children;
        const ultima = cards[cards.length - 1];
        ultima.scrollIntoView({ behavior: 'smooth', block: 'center' });
        ultima.querySelector('[data-campo="texto"]').focus();
    });

    $('#listaResultados').addEventListener('input', function (e) {
        const campo = e.target.dataset.campo;
        if (!campo) return;

        const r = estado.resultados[e.target.closest('.resultado-card').dataset.i];
        r[campo] = e.target.value;

        if (campo === 'nivel') { renderResultado(parseInt(e.target.closest('.resultado-card').dataset.i, 10)); return; }
        if (campo === 'min' || campo === 'max') programarResumen();
        else programarRevision();
    });

    $('#listaResultados').addEventListener('click', function (e) {
        const btn = e.target.closest('[data-accion="delResultado"]');
        if (!btn) return;
        estado.resultados.splice(parseInt(btn.closest('.resultado-card').dataset.i, 10), 1);
        renderResultados();
    });

    $('#btnAddResultado').addEventListener('click', function () {
        estado.resultados.push(nuevoResultado());
        renderResultados();
        const cards = $('#listaResultados').children;
        cards[cards.length - 1].querySelector('[data-campo="titulo"]').focus();
    });

    // ---- Test exclusivo para un paciente: la lista se pide al servidor cada vez,
    //      así los pacientes recién registrados aparecen sin recargar la página.
    function cargarPacientes() {
        const previo = selPaciente.value;
        selPaciente.disabled = true;
        return fetch('/psicologo/pacientes', { credentials: 'same-origin', headers: { 'Accept': 'application/json' } })
            .then(function (res) {
                if (!res.ok) throw new Error('http ' + res.status);
                return res.json();
            })
            .then(function (lista) {
                selPaciente.innerHTML = '<option value="">Selecciona un paciente</option>' + lista.map(function (p) {
                    return '<option value="' + esc(p.idPaciente) + '">' + esc(p.nombre) + ' (' + esc(p.correo) + ')</option>';
                }).join('');
                if (previo) selPaciente.value = previo;
            })
            .catch(function () {
                selPaciente.innerHTML = '<option value="">No se pudo cargar la lista de pacientes</option>';
            })
            .then(function () {
                selPaciente.disabled = false;
                programarRevision();
            });
    }

    chkExclusivo.addEventListener('change', function () {
        bloqueExclusivo.classList.toggle('d-none', !chkExclusivo.checked);
        if (chkExclusivo.checked) cargarPacientes(); else selPaciente.value = '';
        programarRevision();
    });
    $('#btnRecargarPacientes').addEventListener('click', cargarPacientes);

    document.querySelectorAll('.campo-info').forEach(function (el) {
        el.addEventListener('input', programarRevision);
    });

    const btnVistaJson = $('#btnVistaJson');
    if (btnVistaJson) btnVistaJson.addEventListener('click', mostrarJson);

    function guardarEnServidor(url, datos) {
        const btn = $('#btnGuardar');
        const ok = $('#alertaGuardado');
        const err = $('#alertaError');
        ok.classList.add('d-none');
        err.classList.add('d-none');
        btn.disabled = true;

        fetch(url, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            credentials: 'same-origin',
            body: JSON.stringify(datos)
        })
            .then(function (res) {
                return res.json().catch(function () { return {}; }).then(function (cuerpo) {
                    return { ok: res.ok, cuerpo: cuerpo };
                });
            })
            .then(function (r) {
                if (r.ok) {
                    $('#msgGuardado').textContent = r.cuerpo.mensaje || 'Test guardado.';
                    ok.classList.remove('d-none');
                    ok.scrollIntoView({ behavior: 'smooth', block: 'center' });
                } else {
                    $('#msgError').textContent = r.cuerpo.error || 'No se pudo guardar el test.';
                    err.classList.remove('d-none');
                    btn.disabled = false;
                }
            })
            .catch(function () {
                $('#msgError').textContent = 'No se pudo conectar con el servidor. Revisa tu sesión e intenta de nuevo.';
                err.classList.remove('d-none');
                btn.disabled = false;
            });
    }

    $('#formTest').addEventListener('submit', function (e) {
        e.preventDefault();
        const v = validar();

        if (v.errores.length) {
            renderRevision();
            $('#revision').scrollIntoView({ behavior: 'smooth', block: 'center' });
            return;
        }

        guardarEnServidor(e.currentTarget.getAttribute('action'), construirJson());
    });

    estado.preguntas.push(nuevaPregunta());
    renderPreguntas();
    renderResultados();
})();