package org.romero.rest;

import org.romero.DAO.PacienteRepository;
import org.romero.model.Paciente;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/api/pacientes") // Esta es la ruta que usarás en Android
public class PacienteController {

    @Autowired
    private PacienteRepository pacienteRepository;

    @GetMapping
    public List<Paciente> obtenerTodos() {
        return pacienteRepository.findAll();
    }

    @GetMapping("/{id}")
    public Paciente obtenerPorId(@PathVariable Integer id) {
        return pacienteRepository.findById(id).orElse(null);
    }

    @PostMapping
    public Paciente crearPaciente(@RequestBody Paciente paciente) {
        return pacienteRepository.save(paciente);
    }
}