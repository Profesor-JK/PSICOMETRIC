package org.romero.controller;

import org.romero.Service.PacienteService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class Publicocontroller {

    private final PacienteService pacienteService;

    public Publicocontroller(PacienteService pacienteService) {
        this.pacienteService = pacienteService;
    }

    @GetMapping({"/", "/prueba"})
    public String mostrarInicio(Model model) {
        model.addAttribute("pacientes", pacienteService.findAll());
        return "index";
    }

    @GetMapping("/info")
    public String mostrarInfo() {
        return "info";
    }

}