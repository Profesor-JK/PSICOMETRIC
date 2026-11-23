package org.romero.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TestController {

    @GetMapping("/test")
    public String mostrarTest() {
        return "Test";
    }

    @GetMapping("/creartest")
    public String mostrarCrearTest() {
        return "creartest";
    }
}