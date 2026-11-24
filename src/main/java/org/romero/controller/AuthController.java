package org.romero.controller;

import org.romero.Service.RegistroService;
import org.romero.dto.RegistroPacienteDTO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class AuthController {

    private final RegistroService registroService;

    public AuthController(RegistroService registroService) {
        this.registroService = registroService;
    }

    @GetMapping("/login")
    public String mostrarLogin() {
        return "login";
    }

    @GetMapping("/registro")
    public String mostrarRegistro() {
        return "registro";
    }

    @PostMapping("/registro")
    public String registrar(@ModelAttribute RegistroPacienteDTO form, Model model, RedirectAttributes ra) {
        try {
            registroService.registrarPaciente(form);
            ra.addFlashAttribute("exito", "Cuenta creada. Ya puedes iniciar sesión.");
            return "redirect:/login";
        } catch (IllegalArgumentException e) {
            model.addAttribute("error", e.getMessage());
            // se devuelve lo escrito, menos las contraseñas
            model.addAttribute("form", new RegistroPacienteDTO(form.nombre(), form.apellidos(), form.fechaNac(),
                    form.genero(), form.correo(), null, null));
            return "registro";
        }
    }
}
