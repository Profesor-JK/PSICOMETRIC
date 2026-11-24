package org.romero.dao;

import org.romero.model.Intento;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface IntentoRepository extends JpaRepository<Intento, Integer> {


    @EntityGraph(attributePaths = {"test", "rango"})
    List<Intento> findByIdPacienteOrderByFechaDesc(Integer idPaciente);

    @EntityGraph(attributePaths = {"test", "rango"})
    List<Intento> findByTest_CedulaOrderByFechaDesc(Integer cedula);

    @EntityGraph(attributePaths = {"test", "rango"})
    List<Intento> findByTest_CedulaAndTest_IdTestOrderByFechaDesc(Integer cedula, Integer idTest);

    @EntityGraph(attributePaths = {"test", "rango"})
    List<Intento> findByIdPacienteInOrderByFechaDesc(java.util.Collection<Integer> idsPaciente);

    long countByIdPacienteAndTest_IdTest(Integer idPaciente, Integer idTest);

    void deleteByIdPaciente(Integer idPaciente);

    void deleteByTest_IdTest(Integer idTest);
}
