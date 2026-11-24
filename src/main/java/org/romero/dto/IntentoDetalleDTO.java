package org.romero.dto;

import java.util.List;

public class IntentoDetalleDTO {

    private final IntentoResumenDTO resumen;
    private final String descripcionRango;
    private final List<RespuestaDetalleDTO> respuestas;

    public IntentoDetalleDTO(IntentoResumenDTO resumen, String descripcionRango,
                             List<RespuestaDetalleDTO> respuestas) {
        this.resumen = resumen;
        this.descripcionRango = descripcionRango;
        this.respuestas = respuestas;
    }

    public IntentoResumenDTO getResumen() { return resumen; }
    public String getDescripcionRango() { return descripcionRango; }
    public List<RespuestaDetalleDTO> getRespuestas() { return respuestas; }
}
