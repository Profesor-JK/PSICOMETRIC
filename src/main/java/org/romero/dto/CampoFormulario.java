package org.romero.dto;

import java.util.List;

/** Describe un campo del formulario genérico de alta / cambio. */
public class CampoFormulario {

    public static class Opcion {
        private final String valor;
        private final String texto;
        public Opcion(String valor, String texto) { this.valor = valor; this.texto = texto; }
        public String getValor() { return valor; }
        public String getTexto() { return texto; }
    }

    private final String nombre;
    private final String etiqueta;
    private final String tipo;      // text | email | date | number | password | textarea | select
    private final boolean requerido;
    private final boolean soloLectura;
    private final String valor;
    private final List<Opcion> opciones;
    private final String ayuda;

    public CampoFormulario(String nombre, String etiqueta, String tipo, boolean requerido,
                           boolean soloLectura, String valor, List<Opcion> opciones, String ayuda) {
        this.nombre = nombre;
        this.etiqueta = etiqueta;
        this.tipo = tipo;
        this.requerido = requerido;
        this.soloLectura = soloLectura;
        this.valor = valor == null ? "" : valor;
        this.opciones = opciones;
        this.ayuda = ayuda;
    }

    public static CampoFormulario texto(String nombre, String etiqueta, String tipo, boolean requerido, String valor) {
        return new CampoFormulario(nombre, etiqueta, tipo, requerido, false, valor, null, null);
    }

    public static CampoFormulario seleccion(String nombre, String etiqueta, boolean requerido,
                                            String valor, List<Opcion> opciones) {
        return new CampoFormulario(nombre, etiqueta, "select", requerido, false, valor, opciones, null);
    }

    public String getNombre() { return nombre; }
    public String getEtiqueta() { return etiqueta; }
    public String getTipo() { return tipo; }
    public boolean isRequerido() { return requerido; }
    public boolean isSoloLectura() { return soloLectura; }
    public String getValor() { return valor; }
    public List<Opcion> getOpciones() { return opciones; }
    public String getAyuda() { return ayuda; }
}
