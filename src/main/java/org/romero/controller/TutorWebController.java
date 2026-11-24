package org.romero.controller;

import org.romero.Service.IntentoTutorService;
import org.romero.Service.TestTutorService;
import org.romero.Service.TutorService;
import org.romero.dto.IntentoDetalleDTO;
import org.romero.model.Tutor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;

/** Vista del tutor: solo "Ver tests" y "Ver actividad" de los pacientes a su cargo. */
@Controller
@RequestMapping("/tutor")
public class TutorWebController {

    private final TutorService tutorService;
    private final TestTutorService testService;
    private final IntentoTutorService intentoService;

    public TutorWebController(TutorService tutorService,
                              TestTutorService testService,
                              IntentoTutorService intentoService) {
        this.tutorService = tutorService;
        this.testService = testService;
        this.intentoService = intentoService;
    }

    @GetMapping
    public String raiz() {
        return "redirect:/tutor/tests";
    }

    @GetMapping("/tests")
    public String tests(Principal principal, Model model) {
        Tutor tutor = tutorService.obtenerPorCorreo(principal.getName());
        if (tutor == null) return "redirect:/login?error=true";
        model.addAttribute("tests", testService.listarTests(tutor.getIdTutor()));
        return "tutor/tests";
    }

    @GetMapping("/actividad")
    public String actividad(Principal principal, Model model) {
        Tutor tutor = tutorService.obtenerPorCorreo(principal.getName());
        if (tutor == null) return "redirect:/login?error=true";
        model.addAttribute("intentos", intentoService.listarActividad(tutor.getIdTutor()));
        return "tutor/actividad";
    }

    @GetMapping("/actividad/{idIntento}")
    public String detalle(@PathVariable Integer idIntento,
                          Principal principal, Model model, RedirectAttributes ra) {
        Tutor tutor = tutorService.obtenerPorCorreo(principal.getName());
        if (tutor == null) return "redirect:/login?error=true";
        try {
            IntentoDetalleDTO detalle = intentoService.obtenerDetalle(tutor.getIdTutor(), idIntento);
            model.addAttribute("detalle", detalle);
            return "tutor/actividadDetalle";
        } catch (IllegalArgumentException e) {
            ra.addFlashAttribute("error", e.getMessage());
            return "redirect:/tutor/actividad";
        }
    }
}
