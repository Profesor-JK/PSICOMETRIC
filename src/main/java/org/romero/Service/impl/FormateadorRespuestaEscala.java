package org.romero.Service.impl;

import org.romero.Service.FormateadorRespuesta;
import org.romero.model.Pregunta;
import org.romero.model.RespuestaIntento;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class FormateadorRespuestaEscala implements FormateadorRespuesta {

    @Override
    public boolean soporta(String tipoPregunta) {
        return "escala".equals(tipoPregunta);
    }

    @Override
    public List<String> formatear(Pregunta pregunta, List<RespuestaIntento> respuestas) {
        RespuestaIntento r = respuestas.get(0);
        StringBuilder sb = new StringBuilder(numero(r.getValor()));
        if (pregunta.getEscalaMin() != null && pregunta.getEscalaMax() != null) {
            sb.append(" (escala de ").append(numero(pregunta.getEscalaMin()))
              .append(" a ").append(numero(pregunta.getEscalaMax())).append(")");
        }
        return List.of(sb.toString());
    }

    private String numero(Double d) {
        if (d == null) return "-";
        return d == Math.floor(d) ? String.valueOf(d.longValue()) : String.valueOf(d);
    }
}
