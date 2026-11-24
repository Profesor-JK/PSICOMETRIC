package org.romero.dto;

public record TestAdminDTO(String nombre, String categoria, String duracionMin, String descripcion,
                           String instrucciones, String cedula, String idPacienteExclusivo, String activo) {
}
