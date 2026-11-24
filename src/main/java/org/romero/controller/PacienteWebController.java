package org.romero.controller;

import org.romero.Service.PacienteService;
import org.romero.Service.TestService;
import org.romero.model.Paciente;
import org.romero.model.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.security.Principal;
import java.util.List;

@Controller
@RequestMapping("/paciente")
public class PacienteWebController {

    @Autowired
    private TestService testService;
    @Autowired
    private PacienteService pacienteService;

    @GetMapping("/inicio")
    public String mostrarInicio(Principal principal, Model model) {
        Paciente paciente = pacienteService.obtenerCorreo(principal.getName());
        List<Test> tests = paciente == null ? List.of() : testService.findDisponiblesParaPaciente(paciente.getIdPaciente());
        model.addAttribute("tests", tests.size() > 3 ? tests.subList(0, 3) : tests);
        return "paciente/inicio";
    }
}
