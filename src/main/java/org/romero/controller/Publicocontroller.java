package org.romero.controller;

import org.romero.Service.PsicologoService;
import org.romero.Service.TestService;
import org.romero.model.Test;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class Publicocontroller {

    private static final int MAX_DESTACADOS = 3;

    private final TestService testService;
    private final PsicologoService psicologoService;

    public Publicocontroller(TestService testService, PsicologoService psicologoService) {
        this.testService = testService;
        this.psicologoService = psicologoService;
    }

    @GetMapping({"/", "/prueba"})
    public String mostrarInicio(Model model) {
        List<Test> publicos = testService.findPublicosActivos();
        model.addAttribute("tests", publicos.size() > MAX_DESTACADOS ? publicos.subList(0, MAX_DESTACADOS) : publicos);
        model.addAttribute("psicologos", psicologoService.findAll());
        return "index";
    }

    @GetMapping("/info")
    public String mostrarInfo() {
        return "info";
    }

}
