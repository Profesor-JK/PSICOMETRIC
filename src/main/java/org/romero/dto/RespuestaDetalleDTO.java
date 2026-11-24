package org.romero.dto;

import java.util.List;

public class RespuestaDetalleDTO {

    private final Integer orden;
    private final String textoPregunta;
    private final String tipo;
    private final boolean respondida;
    private final List<String> respuestas;
    private final Double puntos;

    public RespuestaDetalleDTO(Integer orden, String textoPregunta, String tipo,
                               boolean respondida, List<String> respuestas, Double puntos) {
        this.orden = orden;
        this.textoPregunta = textoPregunta;
        this.tipo = tipo;
        this.respondida = respondida;
        this.respuestas = respuestas;
        this.puntos = puntos;
    }

    public Integer getOrden() { return orden; }
    public String getTextoPregunta() { return textoPregunta; }
    public String getTipo() { return tipo; }
    public boolean isRespondida() { return respondida; }
    public List<String> getRespuestas() { return respuestas; }
    public Double getPuntos() { return puntos; }
}
