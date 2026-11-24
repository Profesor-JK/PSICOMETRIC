package org.romero.Service;

import org.romero.model.Pregunta;
import org.romero.model.RespuestaIntento;

import java.util.List;


public interface FormateadorRespuesta {
    boolean soporta(String tipoPregunta);
    List<String> formatear(Pregunta pregunta, List<RespuestaIntento> respuestas);
}
