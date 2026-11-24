package org.romero.dao;

import org.romero.model.Test;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TestRepository extends JpaRepository<Test, Integer> {
    List<Test> findByActivoTrueAndIdPacienteExclusivoIsNullOrderByFechaCreacionDesc();

    @Query("select t from Test t where t.activo = true " +
           "and (t.idPacienteExclusivo is null or t.idPacienteExclusivo = :idPaciente) " +
           "order by t.fechaCreacion desc")
    List<Test> findDisponiblesParaPaciente(@Param("idPaciente") Integer idPaciente);

    List<Test> findByCedulaOrderByFechaCreacionDesc(Integer cedula);

    List<Test> findByIdPacienteExclusivo(Integer idPaciente);
}
