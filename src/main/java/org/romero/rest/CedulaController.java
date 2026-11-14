package org.romero.rest;

import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/cedula")
public class CedulaController {

    // URL: http://localhost:8080/api/cedula/verificar/1234567
    @GetMapping("/verificar/{numero}")
    public Map<String, Object> verificarCedula(@PathVariable String numero) {
        Map<String, Object> respuesta = new HashMap<>();

        //7 o 8 digitos
        if (numero.length() >= 7 && numero.length() <= 8) {
            respuesta.put("valida", true);
            respuesta.put("numero", numero);
            respuesta.put("nombre", "Juan Pérez García");
            respuesta.put("profesion", "Licenciatura en Psicología");
            respuesta.put("institucion", "UNAM");
            respuesta.put("mensaje", "Cédula encontrada en el Registro Nacional de Profesionistas");
        } else {
            respuesta.put("valida", false);
            respuesta.put("mensaje", "Formato de cédula inválido o no encontrada");
        }

        return respuesta;
    }
}