package org.romero.Service;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import java.util.List;
import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

class RavenServiceTest {

    private RavenService ravenService;

    @BeforeEach
    void setUp() {
        ravenService = new RavenService();
    }

    @Test
    void calcularPuntuacionDirecta_TodosAciertos_Devuelve60() {
        // Given: 5 respuestas correctas y usuario responde lo mismo
        List<String> correctas = List.of("A1", "A2", "A3", "A4", "A5");
        List<String> usuario = List.of("A1", "A2", "A3", "A4", "A5");

        // When
        int resultado = ravenService.calcularPuntuacionDirecta(correctas, usuario);

        // Then
        assertThat(resultado).isEqualTo(5);
    }

    @Test
    void calcularPuntuacionDirecta_AlgunosErrores_DevuelveAciertosCorrectos() {
        List<String> correctas = List.of("A1", "A2", "A3", "A4", "A5");
        List<String> usuario = List.of("A1", "X2", "A3", "Y4", "A5"); // 2 errores

        int resultado = ravenService.calcularPuntuacionDirecta(correctas, usuario);

        assertThat(resultado).isEqualTo(3);
    }

    @Test
    void calcularPuntuacionDirecta_ListasDeDiferenteTamano_LanzaExcepcion() {
        List<String> correctas = List.of("A1", "A2");
        List<String> usuario = List.of("A1");

        assertThatThrownBy(() -> ravenService.calcularPuntuacionDirecta(correctas, usuario))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessageContaining("El número de respuestas no coincide");
    }

    @Test
    void interpretarRaven_PuntuacionAlta_DevuelveSuperior() {
        String resultado = ravenService.interpretarRaven(58);
        assertThat(resultado).isEqualTo("Superior");
    }

    @Test
    void interpretarRaven_PuntuacionBaja_DevuelveInferior() {
        String resultado = ravenService.interpretarRaven(20);
        assertThat(resultado).isEqualTo("Inferior");
    }
}