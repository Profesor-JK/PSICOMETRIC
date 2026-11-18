package org.romero.rest;

import org.romero.dto.ConsultaDTO;
import org.romero.model.Consulta;
import org.romero.dao.ConsultaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/citas")
public class ConsultaController {

    @Autowired
    private ConsultaRepository consultaRepository;

    @PostMapping("/agendar")
    public ResponseEntity<?> agendarCita(@RequestBody ConsultaDTO request) {
        Map<String, Object> response = new HashMap<>();

        try {
            LocalDateTime FechaConsulta = LocalDateTime.parse(request.getFechaConsulta());

            LocalDateTime ahora = LocalDateTime.now();
            if (FechaConsulta.isBefore(ahora)) {
                response.put("error", "La fecha de la cita debe ser en el futuro.");
                return ResponseEntity.badRequest().body(response);
            }



            response.put("mensaje", "Cita agendada exitosamente");
            response.put("fecha", FechaConsulta.toString());
            return ResponseEntity.ok(response);

        } catch (Exception e) {
            response.put("error", "Formato de fecha inválido. Usa el formato ISO (YYYY-MM-DDTHH:MM:SS)");
            return ResponseEntity.badRequest().body(response);
        }
    }
}