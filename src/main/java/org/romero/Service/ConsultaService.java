package org.romero.Service;

import org.romero.model.Consulta;
import java.time.LocalDateTime;
import java.util.List;

public interface ConsultaService {
    List<Consulta> getAllConsultas(); // Este es el nombre que le diste tú, está bien.
    Consulta findById(Integer id);
    void save(Consulta consulta);
    void deleteById(Integer id);
    List<Consulta> obtenerfecha(LocalDateTime fecha);
    // Ya no necesitas declarar "update" aquí, save() hace ambas cosas.
}