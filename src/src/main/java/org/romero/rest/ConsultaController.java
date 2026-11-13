package org.romero.rest;

import org.romero.Service.ConsultaService;
import org.romero.dto.ConsultaDTO;
import org.romero.model.Consulta;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/consultas") // Buena práctica poner una ruta base para el controlador
public class ConsultaController {

    // 1. Inyectamos el SERVICIO, no el repositorio
    @Autowired
    private ConsultaService consultaService;

    @PostMapping("/agendar")
    public ResponseEntity<?> agendarCita(@RequestBody ConsultaDTO request) {
        Map<String, Object> response = new HashMap<>();

        try {
            LocalDateTime fechaConsulta = LocalDateTime.parse(request.getFechaConsulta());
            LocalDateTime ahora = LocalDateTime.now();

            // 3. Validamos que sea en el futuro
            if (fechaConsulta.isBefore(ahora)) {
                response.put("error", "La fecha de la cita debe ser en el futuro.");
                return ResponseEntity.badRequest().body(response);
            }

            Consulta nuevaConsulta = new Consulta();
            nuevaConsulta.setFechaConsulta(fechaConsulta);
            nuevaConsulta.setIdPaciente(request.getIdpaciente());
            nuevaConsulta.setIdTutor(request.getIdtutor());
            // nuevaConsulta.setCedula(request.getCedulaPsicologo()); // Si lo tienes en el DTO

            consultaService.save(nuevaConsulta);

            response.put("mensaje", "Cita agendada exitosamente");
            response.put("idConsulta", nuevaConsulta.getIdConsulta()); // Útil para Android
            response.put("fecha", fechaConsulta.toString());

            return ResponseEntity.ok(response);

        } catch (Exception e) {
            response.put("error", "Formato de fecha inválido. Usa el formato ISO (YYYY-MM-DDTHH:MM:SS)");
            System.out.println("Error al agendar: " + e.getMessage());
            return ResponseEntity.badRequest().body(response);
        }
    }
}