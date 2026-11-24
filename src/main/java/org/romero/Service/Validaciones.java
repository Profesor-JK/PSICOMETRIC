package org.romero.Service;

import java.sql.Date;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.Locale;
import java.util.Set;
import java.util.regex.Pattern;
public final class Validaciones {

    private static final Pattern CORREO = Pattern.compile("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$");
    private static final Set<String> GENEROS = Set.of("Masculino", "Femenino", "Otro");

    private Validaciones() {}

    public static String limpiar(String s) {
        return s == null ? "" : s.trim();
    }

    public static String requerido(String valor, String campo, int max) {
        String v = limpiar(valor);
        if (v.isEmpty()) throw new IllegalArgumentException(campo + " es obligatorio.");
        if (v.length() > max) throw new IllegalArgumentException(campo + " es demasiado largo (máximo " + max + " caracteres).");
        return v;
    }

    /** @return el texto limpio, o null si viene vacío */
    public static String opcional(String valor, String campo, int max) {
        String v = limpiar(valor);
        if (v.isEmpty()) return null;
        if (v.length() > max) throw new IllegalArgumentException(campo + " es demasiado largo (máximo " + max + " caracteres).");
        return v;
    }

    public static String correo(String valor) {
        String v = limpiar(valor);
        if (!CORREO.matcher(v).matches() || v.length() > 50) {
            throw new IllegalArgumentException("Escribe un correo válido (máximo 50 caracteres).");
        }
        return v;
    }

    /** @return la contraseña, o null si viene vacía y no es obligatoria (se conserva la actual) */
    public static String contrasena(String valor, boolean obligatoria) {
        String v = valor == null ? "" : valor;
        if (v.isEmpty() && !obligatoria) return null;
        if (v.length() < 4 || v.length() > 30) {
            throw new IllegalArgumentException("La contraseña debe tener entre 4 y 30 caracteres.");
        }
        return v;
    }

    public static String genero(String valor) {
        String v = limpiar(valor);
        if (!GENEROS.contains(v)) throw new IllegalArgumentException("Elige un género.");
        return v;
    }

    public static Date fecha(String valor, String campo) {
        try {
            LocalDate f = LocalDate.parse(limpiar(valor));
            if (f.isAfter(LocalDate.now()) || f.getYear() < 1900) {
                throw new IllegalArgumentException(campo + " no es válida.");
            }
            return Date.valueOf(f);
        } catch (DateTimeParseException e) {
            throw new IllegalArgumentException(campo + " no es válida.");
        }
    }

    public static Integer entero(String valor, String campo) {
        try {
            int n = Integer.parseInt(limpiar(valor));
            if (n <= 0) throw new IllegalArgumentException(campo + " debe ser un número positivo.");
            return n;
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException(campo + " debe ser un número válido.");
        }
    }

    /** @return el número, o null si viene vacío */
    public static Integer enteroOpcional(String valor, String campo) {
        return limpiar(valor).isEmpty() ? null : entero(valor, campo);
    }

    /** true si el filtro está vacío o aparece en alguno de los textos (sin distinguir mayúsculas). */
    public static boolean coincide(String filtro, String... textos) {
        String f = limpiar(filtro).toLowerCase(Locale.ROOT);
        if (f.isEmpty()) return true;
        for (String t : textos) {
            if (t != null && t.toLowerCase(Locale.ROOT).contains(f)) return true;
        }
        return false;
    }
}
