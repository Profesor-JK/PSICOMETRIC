package org.romero.dto;

public record PsicologoAdminDTO(String cedula, String nombre, String apellidos, String fechaNac,
                                String genero, String correo, String contrasena,
                                String titulo, String escuela) {
}
