package org.romero.dto;

public record PacienteAdminDTO(String nombre, String apellidos, String fechaNac, String genero,
                               String correo, String contrasena, String idTutor) {
}
