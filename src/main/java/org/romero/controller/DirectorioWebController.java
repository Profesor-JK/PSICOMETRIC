package org.romero.controller;

import org.romero.Service.DirectorioService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DirectorioWebController {

    private final DirectorioService directorioService;

    public DirectorioWebController(DirectorioService directorioService) {
        this.directorioService = directorioService;
    }

    @GetMapping("/directorio")
    public String mostrarDirectorio(Model model) {
        model.addAttribute("categorias", directorioService.listarPorCategoria());
        return "directorio";
    }
}
