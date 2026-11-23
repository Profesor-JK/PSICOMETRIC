package org.romero.dao;

import org.romero.model.Intento;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface IntentoRepository extends JpaRepository<Intento, Integer> {
    List<Intento> findByIdPacienteOrderByFechaDesc(Integer idPaciente);
}
