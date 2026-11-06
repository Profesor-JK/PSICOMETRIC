package org.romero.rest;

import org.romero.dao.PacienteRepository;
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

    // GET: Obtener todos los pacientes (Para listarlos en Android)
    @GetMapping
    public List<Paciente> obtenerTodos() {
        return pacienteRepository.findAll();
    }

    // GET: Obtener un paciente por ID
    @GetMapping("/{id}")
    public Paciente obtenerPorId(@PathVariable Integer id) {
        return pacienteRepository.findById(id).orElse(null);
    }

    // POST: Crear un nuevo paciente (Desde Android o desde Postman)
    @PostMapping
    public Paciente crearPaciente(@RequestBody Paciente paciente) {
        return pacienteRepository.save(paciente);
    }
}