package org.romero.rest;

import org.romero.Service.PacienteService;
import org.romero.dao.PacienteRepository;
import org.romero.model.Paciente;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/correo")
public class LoginController {

    @Autowired
    private PacienteService pacienteService;

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody Map<String, String> credenciales) {

        String correo = credenciales.get("correo");
        String contrasena = credenciales.get("contrasena");

        Paciente paciente = pacienteService.obtenerCorreo(correo);

        Map<String, Object> respuesta = new HashMap<>();

        if (paciente != null && paciente.getContraPac().equals(contrasena)) {
            respuesta.put("exito", true);
            respuesta.put("mensaje", "Bienvenido " + paciente.getNombrePac());
            respuesta.put("idPaciente", paciente.getIdPaciente());
            return ResponseEntity.ok(respuesta);
        } else {
            respuesta.put("exito", false);
            respuesta.put("mensaje", "Correo o contraseña incorrectos");
            return ResponseEntity.status(401).body(respuesta);
        }
    }
}