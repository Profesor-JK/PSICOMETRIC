package org.romero.rest;

import org.romero.Service.PsicologoService;
import org.romero.Service.TestService;
import org.romero.dto.TestDTO;
import org.romero.model.Test;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

/** Alta de tests por el moderador: igual que la del psicólogo, pero eligiendo a quién pertenece. */
@RestController
@RequestMapping("/admin/tests")
public class AdminTestRestController {

    private final TestService testService;
    private final PsicologoService psicologoService;

    public AdminTestRestController(TestService testService, PsicologoService psicologoService) {
        this.testService = testService;
        this.psicologoService = psicologoService;
    }

    @PostMapping("/alta")
    public ResponseEntity<?> guardar(@RequestBody TestDTO dto, @RequestParam(required = false) Integer cedula) {
        Map<String, Object> response = new HashMap<>();

        if (cedula == null || psicologoService.findByCedula(cedula) == null) {
            response.put("error", "Elige el psicólogo al que pertenecerá el test.");
            return ResponseEntity.badRequest().body(response);
        }
        try {
            Test test = testService.guardar(dto, cedula);
            response.put("mensaje", "Test guardado. Ya está disponible para los pacientes.");
            response.put("idTest", test.getIdTest());
            return ResponseEntity.ok(response);
        } catch (IllegalArgumentException e) {
            response.put("error", e.getMessage());
            return ResponseEntity.badRequest().body(response);
        } catch (Exception e) {
            response.put("error", "No se pudo guardar el test. Intenta de nuevo.");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
}
