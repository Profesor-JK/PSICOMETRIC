package org.romero.Service.impl;

import org.romero.Service.RegistroService;
import org.romero.dao.PacienteRepository;
import org.romero.dao.PsicologoRepository;
import org.romero.dto.RegistroPacienteDTO;
import org.romero.model.Paciente;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Date;
import java.time.DateTimeException;
import java.time.LocalDate;
import java.util.Set;
import java.util.regex.Pattern;

@Service
public class RegistroServiceImpl implements RegistroService {

    private static final Pattern CORREO = Pattern.compile("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$");
    private static final Set<String> GENEROS = Set.of("Masculino", "Femenino", "Otro");

    private final PacienteRepository pacienteRepository;
    private final PsicologoRepository psicologoRepository;

    public RegistroServiceImpl(PacienteRepository pacienteRepository, PsicologoRepository psicologoRepository) {
        this.pacienteRepository = pacienteRepository;
        this.psicologoRepository = psicologoRepository;
    }

    @Override
    @Transactional
    public Paciente registrarPaciente(RegistroPacienteDTO dto) {
        if (dto == null) throw new IllegalArgumentException("Completa el formulario.");

        String nombre = limpiar(dto.nombre());
        String apellidos = limpiar(dto.apellidos());
        String genero = limpiar(dto.genero());
        String correo = limpiar(dto.correo());
        String contrasena = dto.contrasena() == null ? "" : dto.contrasena();

        if (nombre.isEmpty() || apellidos.isEmpty()) throw new IllegalArgumentException("Escribe tu nombre y tus apellidos.");
        if (nombre.length() > 45) throw new IllegalArgumentException("El nombre es demasiado largo (máximo 45 caracteres).");
        if (apellidos.length() > 50) throw new IllegalArgumentException("Los apellidos son demasiado largos (máximo 50 caracteres).");
        if (!GENEROS.contains(genero)) throw new IllegalArgumentException("Elige un género.");
        if (!CORREO.matcher(correo).matches() || correo.length() > 50) throw new IllegalArgumentException("Escribe un correo válido (máximo 50 caracteres).");
        if (contrasena.length() < 6 || contrasena.length() > 30) throw new IllegalArgumentException("La contraseña debe tener entre 6 y 30 caracteres.");
        if (!contrasena.equals(dto.confirmar())) throw new IllegalArgumentException("Las contraseñas no coinciden.");

        LocalDate nacimiento = parsearFecha(dto.fechaNac());

            if (pacienteRepository.findByCorreoPac(correo) != null || psicologoRepository.findByCorreopsic(correo) != null) {
            throw new IllegalArgumentException("Ese correo ya está registrado.");
        }

        Paciente p = new Paciente();
        p.setNombrePac(nombre);
        p.setApellidosPac(apellidos);
        p.setFechaNacPac(Date.valueOf(nacimiento));
        p.setGeneroPsc(genero);
        p.setCorreoPac(correo);
        p.setContraPac(contrasena);
        return pacienteRepository.save(p);
    }

    private LocalDate parsearFecha(String texto) {
        try {
            LocalDate f = LocalDate.parse(limpiar(texto));
            if (f.isAfter(LocalDate.now()) || f.getYear() < 1900) throw new IllegalArgumentException("La fecha de nacimiento no es válida.");
            return f;
        } catch (DateTimeException e) {
            throw new IllegalArgumentException("Escribe tu fecha de nacimiento.");
        }
    }

    private String limpiar(String s) {
        return s == null ? "" : s.trim();
    }
}
