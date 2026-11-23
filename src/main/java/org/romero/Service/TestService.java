package org.romero.Service;

import org.romero.dto.TestDTO;
import org.romero.model.Intento;
import org.romero.model.Test;

import java.util.List;
import java.util.Map;

public interface TestService {
    Test guardar(TestDTO dto, Integer cedulaPsicologo);
    List<Test> findAllActivos();
    Test findById(Integer idTest);
    Intento resolver(Integer idTest, Integer idPaciente, Map<String, String[]> respuestas);
    Intento findIntento(Integer idIntento);
}
