package org.romero.controller;

import jakarta.servlet.http.HttpServletRequest;
import org.romero.Service.PacienteService;
import org.romero.Service.TestService;
import org.romero.model.Intento;
import org.romero.model.Paciente;
import org.romero.model.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;
import java.util.List;

@Controller
public class TestController {

    @Autowired
    private TestService testService;
    @Autowired
    private PacienteService pacienteService;

    @GetMapping("/creartest")
    public String mostrarCrearTest() {
        return "creartest";
    }

    @GetMapping("/test")
    public String mostrarTest(Principal principal, Model model) {
        Paciente paciente = pacienteService.obtenerCorreo(principal.getName());
        model.addAttribute("tests", paciente == null
                ? List.of()
                : testService.findDisponiblesParaPaciente(paciente.getIdPaciente()));
        return "Test";
    }

    @GetMapping("/test/{idTest}")
    public String resolverTest(@PathVariable Integer idTest, Principal principal, Model model, RedirectAttributes ra) {
        Paciente paciente = pacienteService.obtenerCorreo(principal.getName());
        Test test = paciente == null ? null : testService.findDisponible(idTest, paciente.getIdPaciente());
        if (test == null) {
            ra.addFlashAttribute("error", "El test que buscas no está disponible.");
            return "redirect:/test";
        }
        model.addAttribute("test", test);
        return "resolvertest";
    }
    @PostMapping("/test/{idTest}/enviar")
    public String enviarRespuestas(@PathVariable Integer idTest, HttpServletRequest request,
                                   Principal principal, RedirectAttributes ra) {
        Paciente paciente = pacienteService.obtenerCorreo(principal.getName());
        if (paciente == null) {
            ra.addFlashAttribute("error", "No se encontró tu cuenta de paciente.");
            return "redirect:/test";
        }
        try {
            Intento intento = testService.resolver(idTest, paciente.getIdPaciente(), request.getParameterMap());
            return "redirect:/test/resultado/" + intento.getIdIntento();
        } catch (IllegalArgumentException e) {
            ra.addFlashAttribute("error", e.getMessage());
            return "redirect:/test/" + idTest;
        }
    }

    @GetMapping("/test/resultado/{idIntento}")
    public String verResultado(@PathVariable Integer idIntento, Principal principal,
                               Model model, RedirectAttributes ra) {
        Paciente paciente = pacienteService.obtenerCorreo(principal.getName());
        Intento intento = testService.findIntento(idIntento);
        if (paciente == null || intento == null || !intento.getIdPaciente().equals(paciente.getIdPaciente())) {
            ra.addFlashAttribute("error", "No encontramos ese resultado.");
            return "redirect:/test";
        }
        model.addAttribute("intento", intento);
        model.addAttribute("test", intento.getTest());
        return "resultadotest";
    }
}
