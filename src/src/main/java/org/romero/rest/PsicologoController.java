package org.romero.rest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import org.romero.dao.PsicologoRepository;
import org.romero.model.Psicologo;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/cedula")
public class CedulaController {

    @Autowired
    private PsicologoRepository psicologoRepository;

    @GetMapping("/verificar/{numero}")
    public Map<String, Object> verificarCedula(@PathVariable String numero) {
        Map<String, Object> respuesta = new HashMap<>();

        try {
            Integer cedula = Integer.parseInt(numero);
            Psicologo psicologo = psicologoRepository.findByCedula(cedula);

            if (numero.length() < 7 || numero.length() > 8) {
                respuesta.put("valida", false);
                respuesta.put("mensaje", "Formato de cédula inválido");
                return respuesta;
            }

            if (psicologo == null) {
                respuesta.put("valida", false);
                respuesta.put("mensaje", "Cédula no encontrada en el Registro Nacional de Profesionistas");
                return respuesta;
            }

            respuesta.put("valida", true);
            respuesta.put("numero", numero);
            respuesta.put("nombre", psicologo.getNombre());
            respuesta.put("profesion", psicologo.getTitulo());
            respuesta.put("institucion", psicologo.getEscuela());
            respuesta.put("mensaje", "Cédula encontrada en el Registro Nacional de Profesionistas");

        } catch (NumberFormatException e) {
            respuesta.put("valida", false);
            respuesta.put("mensaje", "Formato de cédula inválido");
        }

        return respuesta;
    }
}