package org.romero.controller;

import jakarta.servlet.http.HttpServletRequest;
import org.romero.Service.TestService;
import org.romero.dao.PacienteRepository;
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

@Controller
public class TestController {

    @Autowired
    private TestService testService;
    @Autowired
    private PacienteRepository pacienteRepository;

    @GetMapping("/creartest")
    public String mostrarCrearTest() {
        return "creartest";
    }

    /** Lista de tests publicados por los psicólogos. */
    @GetMapping("/test")
    public String mostrarTest(Model model) {
        model.addAttribute("tests", testService.findAllActivos());
        return "Test";
    }

    @GetMapping("/test/{idTest}")
    public String resolverTest(@PathVariable Integer idTest, Model model, RedirectAttributes ra) {
        Test test = testService.findById(idTest);
        if (test == null || !Boolean.TRUE.equals(test.getActivo())) {
            ra.addFlashAttribute("error", "El test que buscas no está disponible.");
            return "redirect:/test";
        }
        model.addAttribute("test", test);
        return "resolvertest";
    }

    /** Recibe las respuestas, calcula el puntaje y guarda el intento. */
    @PostMapping("/test/{idTest}/enviar")
    public String enviarRespuestas(@PathVariable Integer idTest, HttpServletRequest request,
                                   Principal principal, RedirectAttributes ra) {
        Paciente paciente = pacienteRepository.findByCorreoPac(principal.getName());
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
        Paciente paciente = pacienteRepository.findByCorreoPac(principal.getName());
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
