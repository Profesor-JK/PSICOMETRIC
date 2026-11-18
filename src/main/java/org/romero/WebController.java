package org.romero;

import jakarta.servlet.http.HttpSession;
import org.romero.dao.PacienteRepository;
import org.romero.model.Paciente;
import org.romero.model.Psicologo;
import org.romero.Service.PsicologoService;
import org.romero.Service.PacienteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.ui.Model;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class WebController {
    @Autowired
    private PacienteRepository pacienteRepository;

    @Autowired
    private PacienteService pacienteService;
    @Autowired
    private PsicologoService psicologoService;

    @GetMapping({"/prueba"})
    public String mostrarPacientesWeb(Model model){
        List<Paciente> lista= pacienteRepository.findAll();
        model.addAttribute("pacientes", lista);
        System.out.println("Entrando");
        return "listaPacientes";
    }
    @GetMapping("/login")
    public String loginm(){
        return "login";
    }
    @GetMapping("/")
    public String mostrarMenu() {
        return "index";
    }
}
