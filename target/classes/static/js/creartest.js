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
  const $ = (sel) => document.querySelector(sel);
  const ocultar = (el, si) => el.classList.toggle('d-none', si);
  const num = (v) => parseFloat(v) || 0;
  const fmt = (n) => String(Math.round(n * 100) / 100);
  const conOpciones = (p) => p.tipo === 'unica' || p.tipo === 'multiple';
  const esc = (s) => String(s == null ? '' : s).replace(/[&<>"']/g,
    (c) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]));
  const espera = (fn, ms) => {
    let t;
    return () => { clearTimeout(t); t = setTimeout(fn, ms); };
  };

  const opcionesSelect = (mapa, actual) => Object.keys(mapa)
    .map((k) => `<option value="${k}"${k === actual ? ' selected' : ''}>${mapa[k]}</option>`)
    .join('');

  const chkExclusivo = $('#testExclusivo');
  const selPaciente = $('#testPaciente');
  function rangoPregunta(p) {
    let mn = 0, mx = 0;
    const puntos = p.opciones.map((o) => num(o.puntos));

    if (p.tipo === 'unica' && puntos.length) {
      mn = Math.min(...puntos);
      mx = Math.max(...puntos);
    } else if (p.tipo === 'multiple') {
      puntos.forEach((n) => (n < 0 ? (mn += n) : (mx += n)));
    } else if (p.tipo === 'escala') {
      const a = num(p.escala.min), b = num(p.escala.max);
      mn = Math.min(a, b);
      mx = Math.max(a, b);
    }
    if (!p.obligatoria && (p.tipo === 'unica' || p.tipo === 'escala')) {
      mn = Math.min(mn, 0);
      mx = Math.max(mx, 0);
    }
    return [mn, mx];
  }

  function rangoTotal() {
    return estado.preguntas.reduce((t, p) => {
      const r = rangoPregunta(p);
      return [t[0] + r[0], t[1] + r[1]];
    }, [0, 0]);
  }
  const nuevaPregunta = () => ({
    id: contadorId++,
    texto: '',
    tipo: 'unica',
    obligatoria: true,
    opciones: [{ texto: '', puntos: 0 }, { texto: '', puntos: 1 }],
    escala: { min: 1, max: 5, etiquetaMin: '', etiquetaMax: '' }
  });

  function nuevoResultado() {
    const total = rangoTotal();
    const ultimoMax = estado.resultados.length
      ? Math.max(...estado.resultados.map((r) => num(r.max)))
      : total[0] - 1;
    const min = ultimoMax + 1;
    return {
      min,
      max: Math.max(min, total[1]),
      titulo: '',
      descripcion: '',
      nivel: ORDEN_NIVELES[estado.resultados.length % ORDEN_NIVELES.length]
    };
  }
  function htmlOpciones(p) {
    const icono = p.tipo === 'unica' ? 'bi-record-circle' : 'bi-check-square';
    const filas = p.opciones.map((o, j) => `
      <div class="opcion-row" data-j="${j}">
        <i class="bi ${icono} text-muted"></i>
        <input type="text" class="form-control form-control-sm" data-campo="opTexto" placeholder="Respuesta ${j + 1}" value="${esc(o.texto)}">
        <div class="input-group input-group-sm puntos-group">
          <input type="number" step="any" min="0" class="form-control" data-campo="opPuntos" value="${esc(o.puntos)}" title="Puntos que suma esta respuesta">
          <span class="input-group-text">pts</span>
        </div>
        <button type="button" class="btn btn-sm btn-outline-danger" data-accion="delOpcion" title="Quitar respuesta"><i class="bi bi-x-lg"></i></button>
      </div>`).join('');

    return `<div class="opciones">${filas}</div>
      <button type="button" class="btn btn-sm btn-outline-primary mt-1" data-accion="addOpcion"><i class="bi bi-plus-lg me-1"></i>Agregar respuesta</button>`;
  }

  function htmlEscala(p) {
    const e = p.escala;
    const campo = (titulo, tipo, nombre, valor, extra) => `
      <div class="col-6 col-md-3">
        <label class="form-label small mb-1">${titulo}</label>
        <input type="${tipo}" class="form-control form-control-sm" data-campo="${nombre}" value="${esc(valor)}" ${extra}>
      </div>`;
    const numero = 'step="any" min="0"';

    return `<div class="row g-2">
        ${campo('Valor mínimo', 'number', 'escMin', e.min, numero)}
        ${campo('Valor máximo', 'number', 'escMax', e.max, numero)}
        ${campo('Etiqueta mínimo', 'text', 'escEtMin', e.etiquetaMin, 'placeholder="Ej. Nunca"')}
        ${campo('Etiqueta máximo', 'text', 'escEtMax', e.etiquetaMax, 'placeholder="Ej. Siempre"')}
      </div>
      <p class="small text-muted mt-2 mb-0">El usuario elige un valor entre el mínimo y el máximo, y ese valor se suma al puntaje.</p>`;
  }

  function htmlPregunta(p, i) {
    let cuerpo = '<p class="small text-muted mb-0"><i class="bi bi-info-circle me-1"></i>Esta pregunta no suma puntos; la respuesta queda para tu revisión.</p>';
    if (conOpciones(p)) cuerpo = htmlOpciones(p);
    else if (p.tipo === 'escala') cuerpo = htmlEscala(p);

    const boton = (accion, titulo, icono, estilo) =>
      `<button type="button" class="btn btn-outline-${estilo}" data-accion="${accion}" title="${titulo}"><i class="bi bi-${icono}"></i></button>`;

    return `<div class="pregunta-card" data-i="${i}">
      <div class="d-flex flex-wrap align-items-center gap-2 mb-3">
        <span class="pregunta-num">${i + 1}</span>
        <select class="form-select form-select-sm w-auto" data-campo="tipo">${opcionesSelect(TIPOS, p.tipo)}</select>
        <div class="form-check form-switch mb-0 ms-1">
          <input class="form-check-input" type="checkbox" role="switch" id="obl-${p.id}" data-campo="obligatoria"${p.obligatoria ? ' checked' : ''}>
          <label class="form-check-label small" for="obl-${p.id}">Pregunta Obligatoria</label>
        </div>
        <div class="btn-group btn-group-sm ms-auto">
          ${boton('subir', 'Subir', 'arrow-up', 'secondary')}
          ${boton('bajar', 'Bajar', 'arrow-down', 'secondary')}
          ${boton('duplicar', 'Duplicar', 'copy', 'secondary')}
          ${boton('eliminar', 'Eliminar', 'trash', 'danger')}
        </div>
      </div>
      <textarea class="form-control mb-3" rows="2" data-campo="texto" placeholder="Escribe la pregunta">${esc(p.texto)}</textarea>
      ${cuerpo}
    </div>`;
  }

  function htmlResultado(r, i) {
    return `<div class="resultado-card nivel-${r.nivel}" data-i="${i}">
      <div class="d-flex flex-wrap align-items-center gap-2 mb-3">
        <span class="badge text-bg-${r.nivel}">Resultado ${i + 1}</span>
        <div class="input-group input-group-sm w-auto">
          <span class="input-group-text">De</span>
          <input type="number" step="any" min="0" class="form-control campo-puntos" data-campo="min" value="${esc(r.min)}">
          <span class="input-group-text">a</span>
          <input type="number" step="any" min="0" class="form-control campo-puntos" data-campo="max" value="${esc(r.max)}">
          <span class="input-group-text">pts</span>
        </div>
        <select class="form-select form-select-sm w-auto" data-campo="nivel">${opcionesSelect(NIVELES, r.nivel)}</select>
        <button type="button" class="btn btn-sm btn-outline-danger ms-auto" data-accion="delResultado" title="Eliminar resultado"><i class="bi bi-trash"></i></button>
      </div>
      <input type="text" class="form-control mb-2" data-campo="titulo" placeholder="Título del resultado (ej. Nivel alto)" value="${esc(r.titulo)}">
      <textarea class="form-control" rows="3" data-campo="descripcion" placeholder="Texto que verá el usuario con este resultado">${esc(r.descripcion)}</textarea>
    </div>`;
  }
  function renderPreguntas() {
    $('#listaPreguntas').innerHTML = estado.preguntas.map(htmlPregunta).join('');
    ocultar($('#sinPreguntas'), estado.preguntas.length > 0);
    actualizarResumen();
  }

  function renderResultados() {
    $('#listaResultados').innerHTML = estado.resultados.map(htmlResultado).join('');
    actualizarResumen();
  }
  function redibujar(contenedor, lista, html, i) {
    $(contenedor).children[i].outerHTML = html(lista[i], i);
    actualizarResumen();
  }
  const renderPregunta = (i) => redibujar('#listaPreguntas', estado.preguntas, htmlPregunta, i);
  const renderResultado = (i) => redibujar('#listaResultados', estado.resultados, htmlResultado, i);

  function actualizarResumen() {
    const t = rangoTotal();
    $('#resPreguntas').textContent = estado.preguntas.length;
    $('#resRangos').textContent = estado.resultados.length;
    $('#resMin').textContent = fmt(t[0]);
    $('#resMax').textContent = fmt(t[1]);
    $('#infoRangoPosible').textContent = `Puntaje posible: ${fmt(t[0])} a ${fmt(t[1])} puntos.`;
    renderRevision();
  }

  const programarResumen = espera(actualizarResumen, 150);
  const programarRevision = espera(renderRevision, 300);
  function validar() {
    const errores = [], avisos = [];

    if (!$('#testNombre').value.trim()) errores.push('Escribe el nombre del test.');
    if (!estado.preguntas.length) errores.push('Agrega al menos una pregunta.');
    if (chkExclusivo.checked && !selPaciente.value) errores.push('Elige el paciente para quien es exclusivo este test.');

    estado.preguntas.forEach((p, i) => {
      const n = `Pregunta ${i + 1}: `;
      if (!p.texto.trim()) errores.push(n + 'falta el texto.');

      if (conOpciones(p)) {
        if (p.opciones.length < 2) errores.push(n + 'agrega al menos 2 respuestas.');
        if (p.opciones.some((o) => !o.texto.trim())) errores.push(n + 'hay respuestas vacías.');
        if (p.opciones.some((o) => num(o.puntos) < 0)) errores.push(n + 'los puntos no pueden ser negativos.');
      }
      if (p.tipo === 'escala') {
        if (num(p.escala.min) < 0) errores.push(n + 'la escala no puede tener valores negativos.');
        if (num(p.escala.min) >= num(p.escala.max)) errores.push(n + 'el mínimo de la escala debe ser menor que el máximo.');
      }
    });

    if (!estado.resultados.length) avisos.push('Aún no defines resultados: el usuario no verá ninguna interpretación.');

    estado.resultados.forEach((r, i) => {
      const n = `Resultado ${i + 1}: `;
      if (num(r.min) < 0 || num(r.max) < 0) errores.push(n + 'el puntaje no puede ser negativo.');
      if (num(r.min) > num(r.max)) errores.push(n + 'el mínimo es mayor que el máximo.');
      if (!r.titulo.trim()) errores.push(n + 'falta el título.');
    });
    const rangos = estado.resultados
      .map((r) => ({ min: num(r.min), max: num(r.max) }))
      .filter((r) => r.min <= r.max)
      .sort((a, b) => a.min - b.min);

    if (rangos.length && estado.preguntas.length) {
      const t = rangoTotal();
      let tope = rangos[0].max;
      let haySolape = false, hayHueco = false;

      if (rangos[0].min > t[0]) avisos.push(`Los puntajes menores a ${fmt(rangos[0].min)} no tienen resultado.`);

      for (let k = 1; k < rangos.length; k++) {
        if (rangos[k].min <= tope) haySolape = true;
        else if (rangos[k].min - tope > 1) hayHueco = true;
        tope = Math.max(tope, rangos[k].max);
      }

      if (haySolape) avisos.push('Hay rangos que se solapan: un mismo puntaje daría dos resultados.');
      if (hayHueco) avisos.push('Hay huecos entre rangos: algunos puntajes no tendrían resultado.');
      if (tope < t[1]) avisos.push(`Los puntajes mayores a ${fmt(tope)} no tienen resultado.`);
    }

    return { errores, avisos };
  }

  function renderRevision() {
    const { errores, avisos } = validar();
    const fila = (clase, icono, msg) =>
      `<div class="revision-item ${clase}"><i class="bi ${icono}"></i><span>${esc(msg)}</span></div>`;

    $('#revision').innerHTML = (errores.length || avisos.length)
      ? errores.map((m) => fila('err', 'bi-x-circle-fill', m)).join('') +
        avisos.map((m) => fila('warn', 'bi-exclamation-triangle-fill', m)).join('')
      : fila('ok', 'bi-check-circle-fill', 'Todo listo para guardar.');
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
      preguntas: estado.preguntas.map((p, i) => ({
        orden: i + 1,
        texto: p.texto.trim(),
        tipo: p.tipo,
        obligatoria: p.obligatoria,
        opciones: conOpciones(p) ? p.opciones.map((o) => ({ texto: o.texto.trim(), puntos: num(o.puntos) })) : [],
        escala: p.tipo === 'escala'
          ? { min: num(p.escala.min), max: num(p.escala.max), etiquetaMin: p.escala.etiquetaMin, etiquetaMax: p.escala.etiquetaMax }
          : null
      })),
      resultados: estado.resultados.map((r) => ({
        min: num(r.min), max: num(r.max), titulo: r.titulo.trim(), descripcion: r.descripcion.trim(), nivel: r.nivel
      }))
    };
  }
  const esCampoPuntos = (el) => el.matches && el.matches('input[type="number"][min="0"]');

  document.addEventListener('keydown', (e) => {
    if (e.key === '-' && esCampoPuntos(e.target)) e.preventDefault();
  });
  document.addEventListener('input', (e) => {
    const el = e.target;
    if (esCampoPuntos(el) && el.value.trim().charAt(0) === '-') el.value = el.value.replace(/^\s*-+/, '');
  }, true);
  $('#listaPreguntas').addEventListener('input', (e) => {
    const campo = e.target.dataset.campo;
    if (!campo) return;

    const card = e.target.closest('.pregunta-card');
    const i = parseInt(card.dataset.i, 10);
    const p = estado.preguntas[i];
    const fila = e.target.closest('.opcion-row');
    const valor = e.target.value;

    switch (campo) {
      case 'texto':       p.texto = valor; break;
      case 'obligatoria': p.obligatoria = e.target.checked; break;
      case 'tipo':        p.tipo = valor; renderPregunta(i); return;
      case 'opTexto':     p.opciones[fila.dataset.j].texto = valor; break;
      case 'opPuntos':    p.opciones[fila.dataset.j].puntos = valor; break;
      case 'escMin':      p.escala.min = valor; break;
      case 'escMax':      p.escala.max = valor; break;
      case 'escEtMin':    p.escala.etiquetaMin = valor; break;
      case 'escEtMax':    p.escala.etiquetaMax = valor; break;
    }
    if (['opPuntos', 'escMin', 'escMax', 'obligatoria'].includes(campo)) programarResumen();
    else programarRevision();
  });

  $('#listaPreguntas').addEventListener('click', (e) => {
    const btn = e.target.closest('[data-accion]');
    if (!btn) return;

    const i = parseInt(btn.closest('.pregunta-card').dataset.i, 10);
    const lista = estado.preguntas;
    const p = lista[i];

    switch (btn.dataset.accion) {
      case 'subir':
      case 'bajar': {
        const j = i + (btn.dataset.accion === 'subir' ? -1 : 1);
        if (j >= 0 && j < lista.length) {
          [lista[i], lista[j]] = [lista[j], lista[i]];
          renderPreguntas();
        }
        break;
      }
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
      case 'delOpcion':
        p.opciones.splice(parseInt(btn.closest('.opcion-row').dataset.j, 10), 1);
        renderPregunta(i);
        break;
    }
  });

  $('#btnAddPregunta').addEventListener('click', () => {
    const nueva = nuevaPregunta();
    estado.preguntas.push(nueva);
    $('#listaPreguntas').insertAdjacentHTML('beforeend', htmlPregunta(nueva, estado.preguntas.length - 1));
    ocultar($('#sinPreguntas'), true);
    actualizarResumen();

    const ultima = $('#listaPreguntas').lastElementChild;
    ultima.scrollIntoView({ behavior: 'smooth', block: 'center' });
    ultima.querySelector('[data-campo="texto"]').focus();
  });
  $('#listaResultados').addEventListener('input', (e) => {
    const campo = e.target.dataset.campo;
    if (!campo) return;

    const i = parseInt(e.target.closest('.resultado-card').dataset.i, 10);
    estado.resultados[i][campo] = e.target.value;

    if (campo === 'nivel') renderResultado(i);
    else if (campo === 'min' || campo === 'max') programarResumen();
    else programarRevision();
  });

  $('#listaResultados').addEventListener('click', (e) => {
    const btn = e.target.closest('[data-accion="delResultado"]');
    if (!btn) return;
    estado.resultados.splice(parseInt(btn.closest('.resultado-card').dataset.i, 10), 1);
    renderResultados();
  });

  $('#btnAddResultado').addEventListener('click', () => {
    estado.resultados.push(nuevoResultado());
    renderResultados();
    $('#listaResultados').lastElementChild.querySelector('[data-campo="titulo"]').focus();
  });
  async function cargarPacientes() {
    const previo = selPaciente.value;
    selPaciente.disabled = true;
    try {
      const res = await fetch('/psicologo/pacientes', { credentials: 'same-origin', headers: { Accept: 'application/json' } });
      if (!res.ok) throw new Error('http ' + res.status);
      const lista = await res.json();

      selPaciente.innerHTML = '<option value="">Selecciona un paciente</option>' + lista.map((p) =>
        `<option value="${esc(p.idPaciente)}">${esc(p.nombre)} (${esc(p.correo)})</option>`).join('');
      if (previo) selPaciente.value = previo;
    } catch (err) {
      selPaciente.innerHTML = '<option value="">No se pudo cargar la lista de pacientes</option>';
    }
    selPaciente.disabled = false;
    programarRevision();
  }

  chkExclusivo.addEventListener('change', () => {
    ocultar($('#bloqueExclusivo'), !chkExclusivo.checked);
    if (chkExclusivo.checked) cargarPacientes();
    else selPaciente.value = '';
    programarRevision();
  });
  $('#btnRecargarPacientes').addEventListener('click', cargarPacientes);

  document.querySelectorAll('.campo-info').forEach((el) => el.addEventListener('input', programarRevision));

  const btnVistaJson = $('#btnVistaJson');
  if (btnVistaJson) {
    btnVistaJson.addEventListener('click', () => {
      const pre = $('#jsonPreview');
      pre.textContent = JSON.stringify(construirJson(), null, 2);
      ocultar(pre, false);
    });
  }
  async function guardarEnServidor(url, datos) {
    const btn = $('#btnGuardar');
    const ok = $('#alertaGuardado');
    const err = $('#alertaError');
    ocultar(ok, true);
    ocultar(err, true);
    btn.disabled = true;

    const fallo = (mensaje) => {
      $('#msgError').textContent = mensaje;
      ocultar(err, false);
      btn.disabled = false;
    };

    try {
      const res = await fetch(url, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        credentials: 'same-origin',
        body: JSON.stringify(datos)
      });
      const cuerpo = await res.json().catch(() => ({}));

      if (res.ok) {
        $('#msgGuardado').textContent = cuerpo.mensaje || 'Test guardado.';
        ocultar(ok, false);
        ok.scrollIntoView({ behavior: 'smooth', block: 'center' });
      } else {
        fallo(cuerpo.error || 'No se pudo guardar el test.');
      }
    } catch (e) {
      fallo('No se pudo conectar con el servidor. Revisa tu sesión e intenta de nuevo.');
    }
  }

  $('#formTest').addEventListener('submit', (e) => {
    e.preventDefault();

    if (validar().errores.length) {
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
