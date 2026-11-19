package org.romero.Service;

import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class RavenService {

    public int calcularPuntuacionDirecta(List<String> respuestasCorrectas, List<String> respuestasUsuario) {
        if (respuestasCorrectas.size() != respuestasUsuario.size()) {
            throw new IllegalArgumentException("El número de respuestas no coincide con la plantilla.");
        }

        int aciertos = 0;
        for (int i = 0; i < respuestasCorrectas.size(); i++) {
            if (respuestasCorrectas.get(i).equalsIgnoreCase(respuestasUsuario.get(i))) {
                aciertos++;
            }
        }
        return aciertos;
    }

    public String interpretarRaven(int puntuacionDirecta) {
        // Baremo de ejemplo (debes ajustarlo según el manual que uses)
        if (puntuacionDirecta >= 55) {
            return "Superior";
        } else if (puntuacionDirecta >= 45) {
            return "Promedio Alto";
        } else if (puntuacionDirecta >= 35) {
            return "Promedio";
        } else if (puntuacionDirecta >= 25) {
            return "Promedio Bajo";
        } else {
            return "Inferior";
        }
    }
}