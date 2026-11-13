package org.romero.Service.impl;

import org.romero.Service.PacienteService;
import org.romero.dao.PacienteRepository;
import org.romero.model.Paciente;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class PacienteServiceImpl implements PacienteService {
    @Autowired
    private PacienteRepository pacienteRepository;
    @Override
    public List<Paciente> findAll() {
        return pacienteRepository.findAll();
    }
    @Override
    public Paciente findById(Integer idPaciente) {
        return pacienteRepository.findById(idPaciente).orElse(null);
    }
    @Override
    public void save(Paciente paciente) {
        pacienteRepository.save(paciente);
    }
    @Override
    public void deleteById(Integer id ) {
        pacienteRepository.deleteById(id);
    }
    @Override
    public void update(Paciente paciente){
        pacienteRepository.save(paciente);
    }
    @Override
    public Paciente obtenerCorreo(String correo){
        return pacienteRepository.findByCorreoPac(correo);
    }

}
