package org.romero.dao;

import org.romero.model.Consulta;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository

public interface ConsultaRepository extends JpaRepository<Consulta, Integer> {
    List<Consulta> findByFechaConsulta(LocalDateTime fechaconsulta);
}
