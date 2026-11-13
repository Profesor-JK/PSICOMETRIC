package org.romero;

import org.romero.dao.PacienteRepository;
import org.romero.model.Paciente;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.ui.Model;
import org.springframework.stereotype.Controller;
import java.util.List;

@Controller
public class WebController {

    @Autowired
    private PacienteRepository pacienteRepository;

    @GetMapping({"/", "/prueba"})
    public String mostrarInicio(Model model) {
        List<Paciente> lista = pacienteRepository.findAll();
        model.addAttribute("pacientes", lista);
        return "index";
    }

    @GetMapping("/login")
    public String mostrarLogin() {
        return "login";
    }

    @GetMapping("/registro")
    public String mostrarRegistro() {
        return "registro";
    }

    @GetMapping("/test")
    public String mostrarTest() {
        return "Test";
    }

    @GetMapping("/info")
    public String mostrarInfo() {
        return "info";
    }

    @GetMapping("/directorio")
    public String mostrarDirectorio() {
        return "directorio";
    }
}
