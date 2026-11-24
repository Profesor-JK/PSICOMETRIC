package org.romero.Service;

import org.romero.model.Consulta;
import java.time.LocalDateTime;
import java.util.List;

public interface ConsultaService {
    List<Consulta> getAllConsultas();
    Consulta findById(Integer id);
    void save(Consulta consulta);
    void deleteById(Integer id);
    List<Consulta> obtenerfecha(LocalDateTime fecha);
}