package org.romero.Service.impl;

import org.romero.Service.FormateadorRespuesta;
import org.romero.model.Opcion;
import org.romero.model.Pregunta;
import org.romero.model.RespuestaIntento;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
public class FormateadorRespuestaOpcion implements FormateadorRespuesta {

    @Override
    public boolean soporta(String tipoPregunta) {
        return "unica".equals(tipoPregunta) || "multiple".equals(tipoPregunta);
    }

    @Override
    public List<String> formatear(Pregunta pregunta, List<RespuestaIntento> respuestas) {
        Map<Integer, String> textoPorOpcion = new HashMap<>();
        for (Opcion o : pregunta.getOpciones()) {
            textoPorOpcion.put(o.getIdOpcion(), o.getTexto());
        }
        List<String> resultado = new ArrayList<>();
        for (RespuestaIntento r : respuestas) {
            resultado.add(textoPorOpcion.getOrDefault(r.getIdOpcion(), "(opción eliminada)"));
        }
        return resultado;
    }
}
