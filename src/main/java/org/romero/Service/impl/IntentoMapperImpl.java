package org.romero.Service.impl;

import org.romero.Service.FormateadorRespuesta;
import org.romero.Service.IntentoMapper;
import org.romero.Service.PacienteService;
import org.romero.dto.IntentoDetalleDTO;
import org.romero.dto.IntentoResumenDTO;
import org.romero.dto.RespuestaDetalleDTO;
import org.romero.model.*;
import org.springframework.stereotype.Component;

import java.time.format.DateTimeFormatter;
import java.util.*;

@Component
public class IntentoMapperImpl implements IntentoMapper {

    private static final DateTimeFormatter FORMATO_FECHA = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");

    private final PacienteService pacienteService;
    private final List<FormateadorRespuesta> formateadores;

    public IntentoMapperImpl(PacienteService pacienteService, List<FormateadorRespuesta> formateadores) {
        this.pacienteService = pacienteService;
        this.formateadores = formateadores;
    }

    @Override
    public List<IntentoResumenDTO> aResumenes(List<Intento> intentos) {
        Map<Integer, String> nombres = new HashMap<>();
        List<IntentoResumenDTO> resultado = new ArrayList<>();
        for (Intento i : intentos) {
            resultado.add(aResumen(i, nombres));
        }
        return resultado;
    }

    @Override
    public IntentoDetalleDTO aDetalle(Intento intento) {
        IntentoResumenDTO resumen = aResumen(intento, new HashMap<>());

        Map<Integer, List<RespuestaIntento>> porPregunta = new HashMap<>();
        for (RespuestaIntento r : intento.getRespuestas()) {
            porPregunta.computeIfAbsent(r.getIdPregunta(), k -> new ArrayList<>()).add(r);
        }

        List<RespuestaDetalleDTO> detalle = new ArrayList<>();
        for (Pregunta p : intento.getTest().getPreguntas()) {
            List<RespuestaIntento> dadas = porPregunta.getOrDefault(p.getIdPregunta(), List.of());
            if (dadas.isEmpty()) {
                detalle.add(new RespuestaDetalleDTO(p.getOrden(), p.getTexto(), p.getTipo(),
                        false, List.of(), 0.0));
                continue;
            }
            double puntos = 0;
            for (RespuestaIntento r : dadas) puntos += r.getPuntos();
            detalle.add(new RespuestaDetalleDTO(p.getOrden(), p.getTexto(), p.getTipo(),
                    true, formatear(p, dadas), Math.round(puntos * 100.0) / 100.0));
        }

        RangoResultado rango = intento.getRango();
        return new IntentoDetalleDTO(resumen, rango == null ? null : rango.getDescripcion(), detalle);
    }

    private List<String> formatear(Pregunta pregunta, List<RespuestaIntento> respuestas) {
        return formateadores.stream()
                .filter(f -> f.soporta(pregunta.getTipo()))
                .findFirst()
                .map(f -> f.formatear(pregunta, respuestas))
                .orElse(List.of("(tipo de pregunta no soportado)"));
    }

    private IntentoResumenDTO aResumen(Intento i, Map<Integer, String> nombres) {
        Test t = i.getTest();
        RangoResultado rango = i.getRango();
        return new IntentoResumenDTO(
                i.getIdIntento(),
                t.getIdTest(),
                t.getNombre(),
                t.getCategoria(),
                i.getIdPaciente(),
                nombres.computeIfAbsent(i.getIdPaciente(), this::nombrePaciente),
                i.getFecha().format(FORMATO_FECHA),
                i.getPuntaje(),
                t.getPuntajeMin(),
                t.getPuntajeMax(),
                rango == null ? null : rango.getTitulo(),
                rango == null ? "secondary" : rango.getNivel());
    }

    private String nombrePaciente(Integer idPaciente) {
        Paciente p = pacienteService.findById(idPaciente);
        return p == null ? "Paciente eliminado" : p.getNombrePac() + " " + p.getApellidosPac();
    }
}
