package org.romero.Service.impl;

import org.romero.Service.FormateadorRespuesta;
import org.romero.model.Pregunta;
import org.romero.model.RespuestaIntento;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class FormateadorRespuestaAbierta implements FormateadorRespuesta {

    @Override
    public boolean soporta(String tipoPregunta) {
        return "abierta".equals(tipoPregunta);
    }

    @Override
    public List<String> formatear(Pregunta pregunta, List<RespuestaIntento> respuestas) {
        String texto = respuestas.get(0).getTexto();
        return List.of(texto == null ? "" : texto);
    }
}
