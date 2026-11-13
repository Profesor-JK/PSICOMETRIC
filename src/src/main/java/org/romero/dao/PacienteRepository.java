package org.romero.dao;

import org.romero.model.Paciente;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PacienteRepository extends JpaRepository<Paciente, Integer> {

    @Override
    List<Paciente> findAll();
    Paciente findByIdPaciente(Integer idPaciente);
    Paciente save(Paciente paciente);
    void deleteById(Integer id);
    Paciente findByCorreoPac(String correo);
}