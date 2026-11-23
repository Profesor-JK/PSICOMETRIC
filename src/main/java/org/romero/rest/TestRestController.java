package org.romero.rest;

import org.romero.Service.TestService;
import org.romero.dao.PsicologoRepository;
import org.romero.dto.TestDTO;
import org.romero.model.Psicologo;
import org.romero.model.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/psicologo/tests")
public class TestRestController {

    @Autowired
    private TestService testService;
    @Autowired
    private PsicologoRepository psicologoRepository;

    @PostMapping("/guardar")
    public ResponseEntity<?> guardar(@RequestBody TestDTO dto, Principal principal) {
        Map<String, Object> response = new HashMap<>();

        Psicologo psicologo = psicologoRepository.findByCorreopsic(principal.getName());
        if (psicologo == null) {
            response.put("error", "No se encontró tu cuenta de psicólogo.");
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(response);
        }

        try {
            Test test = testService.guardar(dto, psicologo.getCedula());
            response.put("mensaje", "Test guardado. Ya está disponible para los pacientes.");
            response.put("idTest", test.getIdTest());
            return ResponseEntity.ok(response);
        } catch (IllegalArgumentException e) {
            response.put("error", e.getMessage());
            return ResponseEntity.badRequest().body(response);
        } catch (Exception e) {
            System.out.println("Error al guardar test: " + e.getMessage());
            response.put("error", "No se pudo guardar el test. Intenta de nuevo.");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
}
