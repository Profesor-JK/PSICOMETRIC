package org.romero.Service.impl;

import org.romero.Service.PacienteService;
import org.romero.Service.TestService;
import org.romero.dao.IntentoRepository;
import org.romero.dao.TestRepository;
import org.romero.dto.TestDTO;
import org.romero.dto.TestDTO.EscalaDTO;
import org.romero.dto.TestDTO.OpcionDTO;
import org.romero.dto.TestDTO.PreguntaDTO;
import org.romero.dto.TestDTO.ResultadoDTO;
import org.romero.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;
import java.util.Set;

@Service
public class TestServiceImpl implements TestService {

    private static final Set<String> TIPOS = Set.of("unica", "multiple", "escala", "abierta");
    private static final Set<String> NIVELES = Set.of("success", "primary", "warning", "danger", "secondary");

    @Autowired
    private TestRepository testRepository;
    @Autowired
    private IntentoRepository intentoRepository;
    @Autowired
    private PacienteService pacienteService;


    @Override
    @Transactional
    public Test guardar(TestDTO dto, Integer cedulaPsicologo) {
        if (dto == null || vacio(dto.nombre())) {
            throw new IllegalArgumentException("Escribe el nombre del test.");
        }
        if (dto.preguntas() == null || dto.preguntas().isEmpty()) {
            throw new IllegalArgumentException("Agrega al menos una pregunta.");
        }

        Test test = new Test();
        test.setCedula(cedulaPsicologo);
        test.setNombre(dto.nombre().trim());
        test.setCategoria(limpiar(dto.categoria()));
        test.setDescripcion(limpiar(dto.descripcion()));
        test.setInstrucciones(limpiar(dto.instrucciones()));
        test.setDuracionMin(dto.duracionMin() != null && dto.duracionMin() > 0 ? dto.duracionMin().intValue() : null);

        if (dto.idPacienteExclusivo() != null) {
            if (pacienteService.findById(dto.idPacienteExclusivo()) == null) {
                throw new IllegalArgumentException("El paciente elegido para el test exclusivo ya no existe.");
            }
            test.setIdPacienteExclusivo(dto.idPacienteExclusivo());
        }

        int n = 1;
        for (PreguntaDTO pd : dto.preguntas()) {
            if (pd == null || vacio(pd.texto())) {
                throw new IllegalArgumentException("Pregunta " + n + ": falta el texto.");
            }
            String tipo = pd.tipo() == null ? "" : pd.tipo();
            if (!TIPOS.contains(tipo)) {
                throw new IllegalArgumentException("Pregunta " + n + ": tipo de pregunta no válido.");
            }

            Pregunta p = new Pregunta();
            p.setTest(test);
            p.setOrden(n);
            p.setTexto(pd.texto().trim());
            p.setTipo(tipo);
            p.setObligatoria(pd.obligatoria() == null || pd.obligatoria());

            if (tipo.equals("unica") || tipo.equals("multiple")) {
                List<OpcionDTO> ops = pd.opciones();
                if (ops == null || ops.size() < 2) {
                    throw new IllegalArgumentException("Pregunta " + n + ": agrega al menos 2 respuestas.");
                }
                int k = 1;
                for (OpcionDTO od : ops) {
                    if (od == null || vacio(od.texto())) {
                        throw new IllegalArgumentException("Pregunta " + n + ": hay respuestas vacías.");
                    }
                    Opcion o = new Opcion();
                    o.setPregunta(p);
                    o.setOrden(k++);
                    o.setTexto(od.texto().trim());
                    o.setPuntos(od.puntos() == null ? 0.0 : od.puntos());
                    p.getOpciones().add(o);
                }
            } else if (tipo.equals("escala")) {
                EscalaDTO e = pd.escala();
                if (e == null || e.min() == null || e.max() == null || e.min() >= e.max()) {
                    throw new IllegalArgumentException("Pregunta " + n + ": el mínimo de la escala debe ser menor que el máximo.");
                }
                p.setEscalaMin(e.min());
                p.setEscalaMax(e.max());
                p.setEtiquetaMin(limpiar(e.etiquetaMin()));
                p.setEtiquetaMax(limpiar(e.etiquetaMax()));
            }

            test.getPreguntas().add(p);
            n++;
        }

        if (dto.resultados() != null) {
            int r = 1;
            for (ResultadoDTO rd : dto.resultados()) {
                if (rd == null || rd.min() == null || rd.max() == null || rd.min() > rd.max()) {
                    throw new IllegalArgumentException("Resultado " + r + ": el mínimo es mayor que el máximo.");
                }
                if (vacio(rd.titulo())) {
                    throw new IllegalArgumentException("Resultado " + r + ": falta el título.");
                }
                RangoResultado rango = new RangoResultado();
                rango.setTest(test);
                rango.setMinimo(rd.min());
                rango.setMaximo(rd.max());
                rango.setTitulo(rd.titulo().trim());
                rango.setDescripcion(limpiar(rd.descripcion()));
                rango.setNivel(rd.nivel() != null && NIVELES.contains(rd.nivel()) ? rd.nivel() : "primary");
                test.getResultados().add(rango);
                r++;
            }
        }

        // El puntaje mínimo/máximo se calcula aquí (no se confía en el del navegador)
        double mn = 0, mx = 0;
        for (Pregunta p : test.getPreguntas()) {
            double[] rp = rangoPregunta(p);
            mn += rp[0];
            mx += rp[1];
        }
        test.setPuntajeMin(redondear(mn));
        test.setPuntajeMax(redondear(mx));

        return testRepository.save(test);
    }


    @Override
    public List<Test> findPublicosActivos() {
        return testRepository.findByActivoTrueAndIdPacienteExclusivoIsNullOrderByFechaCreacionDesc();
    }

    @Override
    public List<Test> findDisponiblesParaPaciente(Integer idPaciente) {
        return testRepository.findDisponiblesParaPaciente(idPaciente);
    }

    @Override
    public Test findDisponible(Integer idTest, Integer idPaciente) {
        Test test = testRepository.findById(idTest).orElse(null);
        if (test == null || !Boolean.TRUE.equals(test.getActivo()) || !test.esVisibleParaPaciente(idPaciente)) {
            return null;
        }
        return test;
    }

    @Override
    public Test findById(Integer idTest) {
        return testRepository.findById(idTest).orElse(null);
    }

    @Override
    public Intento findIntento(Integer idIntento) {
        return intentoRepository.findById(idIntento).orElse(null);
    }

    @Override
    @Transactional
    public Intento resolver(Integer idTest, Integer idPaciente, Map<String, String[]> params) {
        Test test = testRepository.findById(idTest)
                .orElseThrow(() -> new IllegalArgumentException("El test no existe."));
        if (!Boolean.TRUE.equals(test.getActivo()) || !test.esVisibleParaPaciente(idPaciente)) {
            throw new IllegalArgumentException("Este test ya no está disponible.");
        }

        Intento intento = new Intento();
        intento.setTest(test);
        intento.setIdPaciente(idPaciente);

        double total = 0;

        for (Pregunta p : test.getPreguntas()) {
            String[] vals = params.get("p_" + p.getIdPregunta());

            if (sinRespuesta(vals)) {
                if (Boolean.TRUE.equals(p.getObligatoria())) {
                    throw new IllegalArgumentException("Falta responder la pregunta " + p.getOrden() + ".");
                }
                continue;
            }

            switch (p.getTipo()) {
                case "unica": {
                    Opcion o = buscarOpcion(p, vals[0]);
                    total += o.getPuntos();
                    intento.getRespuestas().add(respuestaOpcion(intento, p, o));
                    break;
                }
                case "multiple": {
                    Set<Integer> vistos = new java.util.HashSet<>();
                    for (String v : vals) {
                        if (v == null || v.isBlank()) continue;
                        Opcion o = buscarOpcion(p, v);
                        if (!vistos.add(o.getIdOpcion())) continue;   // evita sumar dos veces la misma
                        total += o.getPuntos();
                        intento.getRespuestas().add(respuestaOpcion(intento, p, o));
                    }
                    break;
                }
                case "escala": {
                    double valor;
                    try {
                        valor = Double.parseDouble(vals[0].trim());
                    } catch (NumberFormatException e) {
                        throw new IllegalArgumentException("Pregunta " + p.getOrden() + ": valor no válido.");
                    }
                    if (valor < p.getEscalaMin() || valor > p.getEscalaMax()) {
                        throw new IllegalArgumentException("Pregunta " + p.getOrden() + ": el valor está fuera de la escala.");
                    }
                    total += valor;
                    RespuestaIntento r = nuevaRespuesta(intento, p);
                    r.setValor(valor);
                    r.setPuntos(valor);
                    intento.getRespuestas().add(r);
                    break;
                }
                default: {   // abierta: no suma puntos
                    RespuestaIntento r = nuevaRespuesta(intento, p);
                    String texto = vals[0].trim();
                    r.setTexto(texto.length() > 2000 ? texto.substring(0, 2000) : texto);
                    r.setPuntos(0.0);
                    intento.getRespuestas().add(r);
                }
            }
        }

        total = redondear(total);
        intento.setPuntaje(total);

        for (RangoResultado rango : test.getResultados()) {
            if (total >= rango.getMinimo() && total <= rango.getMaximo()) {
                intento.setRango(rango);
                break;
            }
        }

        return intentoRepository.save(intento);
    }


    private Opcion buscarOpcion(Pregunta p, String idTexto) {
        int id;
        try {
            id = Integer.parseInt(idTexto.trim());
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("Pregunta " + p.getOrden() + ": respuesta no válida.");
        }
        for (Opcion o : p.getOpciones()) {
            if (o.getIdOpcion() == id) return o;
        }
        throw new IllegalArgumentException("Pregunta " + p.getOrden() + ": respuesta no válida.");
    }

    private RespuestaIntento nuevaRespuesta(Intento intento, Pregunta p) {
        RespuestaIntento r = new RespuestaIntento();
        r.setIntento(intento);
        r.setIdPregunta(p.getIdPregunta());
        return r;
    }

    private RespuestaIntento respuestaOpcion(Intento intento, Pregunta p, Opcion o) {
        RespuestaIntento r = nuevaRespuesta(intento, p);
        r.setIdOpcion(o.getIdOpcion());
        r.setPuntos(o.getPuntos());
        return r;
    }


    private double[] rangoPregunta(Pregunta p) {
        double mn = 0, mx = 0;
        boolean obligatoria = Boolean.TRUE.equals(p.getObligatoria());

        switch (p.getTipo()) {
            case "unica":
                if (!p.getOpciones().isEmpty()) {
                    mn = Double.MAX_VALUE;
                    mx = -Double.MAX_VALUE;
                    for (Opcion o : p.getOpciones()) {
                        mn = Math.min(mn, o.getPuntos());
                        mx = Math.max(mx, o.getPuntos());
                    }
                }
                if (!obligatoria) { mn = Math.min(mn, 0); mx = Math.max(mx, 0); }
                break;
            case "multiple":
                for (Opcion o : p.getOpciones()) {
                    if (o.getPuntos() < 0) mn += o.getPuntos(); else mx += o.getPuntos();
                }
                break;
            case "escala":
                mn = Math.min(p.getEscalaMin(), p.getEscalaMax());
                mx = Math.max(p.getEscalaMin(), p.getEscalaMax());
                if (!obligatoria) { mn = Math.min(mn, 0); mx = Math.max(mx, 0); }
                break;
            default:
                break;
        }
        return new double[]{mn, mx};
    }

    private boolean sinRespuesta(String[] vals) {
        if (vals == null || vals.length == 0) return true;
        for (String v : vals) {
            if (v != null && !v.isBlank()) return false;
        }
        return true;
    }

    private boolean vacio(String s) {
        return s == null || s.trim().isEmpty();
    }

    private String limpiar(String s) {
        return vacio(s) ? null : s.trim();
    }

    private double redondear(double d) {
        return Math.round(d * 100.0) / 100.0;
    }
}
