package org.romero.rest;

import org.romero.Service.PacienteService;
import org.romero.dto.PacienteResumenDTO;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/psicologo/pacientes")
public class PsicologoPacienteRestController {

    private final PacienteService pacienteService;

    public PsicologoPacienteRestController(PacienteService pacienteService) {
        this.pacienteService = pacienteService;
    }

    @GetMapping
    public List<PacienteResumenDTO> listar() {
        return pacienteService.listarResumenes();
    }
}
