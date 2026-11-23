package org.romero.controller;

import org.romero.Service.IntentoPsicologoService;
import org.romero.Service.PsicologoService;
import org.romero.dto.IntentoDetalleDTO;
import org.romero.model.Psicologo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;

@Controller
@RequestMapping("/psicologo/respuestas")
public class PsicologoRespuestasWebController {

    private final IntentoPsicologoService intentoService;
    private final PsicologoService psicologoService;

    public PsicologoRespuestasWebController(IntentoPsicologoService intentoService,
                                            PsicologoService psicologoService) {
        this.intentoService = intentoService;
        this.psicologoService = psicologoService;
    }

    @GetMapping
    public String listar(@RequestParam(required = false) Integer idTest,
                         Principal principal, Model model, RedirectAttributes ra) {
        Psicologo psicologo = psicologoService.obtenerCorreopsic(principal.getName());
        if (psicologo == null) {
            ra.addFlashAttribute("error", "No se encontró tu cuenta de psicólogo.");
            return "redirect:/psicologo/inicio";
        }
        model.addAttribute("intentos", intentoService.listarIntentos(psicologo.getCedula(), idTest));
        model.addAttribute("tests", intentoService.listarTests(psicologo.getCedula()));
        model.addAttribute("idTestSeleccionado", idTest);
        return "psicologo/respuestas";
    }

    @GetMapping("/{idIntento}")
    public String detalle(@PathVariable Integer idIntento,
                          Principal principal, Model model, RedirectAttributes ra) {
        Psicologo psicologo = psicologoService.obtenerCorreopsic(principal.getName());
        if (psicologo == null) {
            ra.addFlashAttribute("error", "No se encontró tu cuenta de psicólogo.");
            return "redirect:/psicologo/inicio";
        }
        try {
            IntentoDetalleDTO detalle = intentoService.obtenerDetalle(psicologo.getCedula(), idIntento);
            model.addAttribute("detalle", detalle);
            return "psicologo/respuestaDetalle";
        } catch (IllegalArgumentException e) {
            ra.addFlashAttribute("error", e.getMessage());
            return "redirect:/psicologo/respuestas";
        }
    }
}
