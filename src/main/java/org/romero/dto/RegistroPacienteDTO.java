package org.romero.dto;

public record RegistroPacienteDTO(
        String nombre,
        String apellidos,
        String fechaNac,
        String genero,
        String correo,
        String contrasena,
        String confirmar) {
}
