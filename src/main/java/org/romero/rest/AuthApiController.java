package org.romero.rest;

import org.romero.dao.PacienteRepository;
import org.romero.dao.PsicologoRepository;
import org.romero.dao.TutorRepository;
import org.romero.model.Paciente;
import org.romero.model.Psicologo;
import org.romero.model.Tutor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Login para la app Android. Valida contra las mismas tablas que usa la web
 * (paciente, tutor, psicologo), asi la app y la web comparten la base de Azure.
 *
 * POST /api/auth/login
 * { "rol": "PACIENTE" | "TUTOR" | "PSICOLOGO", "correo": "...", "contrasena": "..." }
 */
@RestController
@RequestMapping("/api/auth")
public class AuthApiController {

    @Autowired private PacienteRepository pacienteRepository;
    @Autowired private TutorRepository tutorRepository;
    @Autowired private PsicologoRepository psicologoRepository;

    public static class LoginRequest {
        private String rol;
        private String correo;
        private String contrasena;
        public String getRol() { return rol; }
        public void setRol(String rol) { this.rol = rol; }
        public String getCorreo() { return correo; }
        public void setCorreo(String correo) { this.correo = correo; }
        public String getContrasena() { return contrasena; }
        public void setContrasena(String contrasena) { this.contrasena = contrasena; }
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginRequest req) {
        if (req == null || req.getRol() == null || req.getCorreo() == null || req.getContrasena() == null) {
            return error(HttpStatus.BAD_REQUEST, "Faltan datos");
        }
        String correo = req.getCorreo().trim();
        String pass = req.getContrasena();
        Map<String, Object> out = new LinkedHashMap<>();

        switch (req.getRol().trim().toUpperCase()) {
            case "PACIENTE": {
                Paciente p = pacienteRepository.findByCorreoPac(correo);
                if (p == null || !pass.equals(p.getContraPac())) return invalido();
                out.put("rol", "PACIENTE");
                out.put("id", p.getIdPaciente());
                out.put("nombre", p.getNombrePac() + " " + p.getApellidosPac());
                out.put("correo", p.getCorreoPac());
                break;
            }
            case "TUTOR": {
                Tutor t = tutorRepository.findByCorreoTut(correo);
                if (t == null || !pass.equals(t.getContraTut())) return invalido();
                out.put("rol", "TUTOR");
                out.put("id", t.getIdTutor());
                out.put("nombre", t.getNombreTut() + " " + t.getApellidosTut());
                out.put("correo", t.getCorreoTut());
                break;
            }
            case "PSICOLOGO": {
                Psicologo s = psicologoRepository.findByCorreopsic(correo);
                if (s == null || !pass.equals(s.getContrapsic())) return invalido();
                out.put("rol", "PSICOLOGO");
                out.put("id", s.getCedula());
                out.put("nombre", s.getNombre() + " " + s.getApellidospsic());
                out.put("correo", s.getCorropsic());
                break;
            }
            default:
                return error(HttpStatus.BAD_REQUEST, "Rol no valido");
        }
        out.put("ok", true);
        return ResponseEntity.ok(out);
    }

    private ResponseEntity<?> invalido() {
        return error(HttpStatus.UNAUTHORIZED, "Correo o contrasena incorrectos");
    }

    private ResponseEntity<?> error(HttpStatus status, String msg) {
        Map<String, Object> m = new LinkedHashMap<>();
        m.put("ok", false);
        m.put("mensaje", msg);
        return ResponseEntity.status(status).body(m);
    }
}
