package org.romero.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import java.util.List;

@JsonIgnoreProperties(ignoreUnknown = true)
public record TestDTO(
        String nombre,
        String categoria,
        Double duracionMin,
        String descripcion,
        String instrucciones,
        List<PreguntaDTO> preguntas,
        List<ResultadoDTO> resultados) {

    @JsonIgnoreProperties(ignoreUnknown = true)
    public record PreguntaDTO(
            Integer orden,
            String texto,
            String tipo,
            Boolean obligatoria,
            List<OpcionDTO> opciones,
            EscalaDTO escala) {
    }

    @JsonIgnoreProperties(ignoreUnknown = true)
    public record OpcionDTO(String texto, Double puntos) {
    }

    @JsonIgnoreProperties(ignoreUnknown = true)
    public record EscalaDTO(Double min, Double max, String etiquetaMin, String etiquetaMax) {
    }

    @JsonIgnoreProperties(ignoreUnknown = true)
    public record ResultadoDTO(Double min, Double max, String titulo, String descripcion, String nivel) {
    }
}
