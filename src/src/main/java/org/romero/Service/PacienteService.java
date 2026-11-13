package org.romero.Service;

import org.romero.model.Paciente;

import java.util.List;

public interface PacienteService {
    List<Paciente> findAll();
    Paciente findById(Integer idPaciente);
    void save(Paciente paciente);
    void deleteById(Integer id);
    void update(Paciente paciente);
    Paciente obtenerCorreo(String correo);
}
