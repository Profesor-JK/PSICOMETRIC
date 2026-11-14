package org.romero.rest;

import org.romero.Service.PsicologoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import org.romero.model.Psicologo;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/cedula")
public class PsicologoController {

    @Autowired
    private PsicologoService psicologoService;

    @GetMapping("/verificar/{numero}")
    public Map<String, Object> verificarCedula(@PathVariable String numero) {
        Map<String, Object> respuesta = new HashMap<>();
        if (numero.length() < 7 || numero.length() > 8) {
            respuesta.put("valida", false);
            respuesta.put("mensaje", "Cantidad de digitos incorrecta");
        }
        try {
            Integer cedula = Integer.parseInt(numero);
            Psicologo psicologo = psicologoService.findByCedula(cedula);
            if (psicologo != null) {
                respuesta.put("valida", true);
                respuesta.put("numero", psicologo.getCedula());
                respuesta.put("nombre", psicologo.getNombre() + " " + psicologo.getApellidospsic());
                respuesta.put("profesion", psicologo.getTitulo());
                respuesta.put("institucion", psicologo.getEscuela());
                respuesta.put("mensaje", "Cédula encontrada en el Registro Nacional de Profesionistas");
            } else {
                respuesta.put("valida", false);
                respuesta.put("mensaje", "Cédula no encontrada en la base de datos");
            }


        } catch (NumberFormatException e) {
            respuesta.put("valida", false);
            respuesta.put("mensaje", "El formato de la cédula debe ser numérico");
        }
        return respuesta;
    }
}