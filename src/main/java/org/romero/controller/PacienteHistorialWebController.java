package org.romero.controller;

import org.romero.Service.IntentoPacienteService;
import org.romero.Service.PacienteService;
import org.romero.model.Paciente;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;

@Controller
@RequestMapping("/paciente/historial")
public class PacienteHistorialWebController {

    private final IntentoPacienteService intentoService;
    private final PacienteService pacienteService;

    public PacienteHistorialWebController(IntentoPacienteService intentoService,
                                          PacienteService pacienteService) {
        this.intentoService = intentoService;
        this.pacienteService = pacienteService;
    }

    @GetMapping
    public String historial(Principal principal, Model model, RedirectAttributes ra) {
        Paciente paciente = pacienteService.obtenerCorreo(principal.getName());
        if (paciente == null) {
            ra.addFlashAttribute("error", "No se encontró tu cuenta de paciente.");
            return "redirect:/paciente/inicio";
        }
        model.addAttribute("intentos", intentoService.listarIntentos(paciente.getIdPaciente()));
        return "paciente/historial";
    }
}
