package org.romero.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/psicologo")
public class PsicologoWebController {

    @GetMapping("/inicio")
    public String mostrarInicio() {
        return "psicologo/inicio";
    }
}