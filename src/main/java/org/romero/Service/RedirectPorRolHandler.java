package org.romero.Service;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import java.io.IOException;
import java.util.Map;

/**
 * Después del login manda a cada rol a su pantalla.
 * Para agregar un rol nuevo solo se agrega una entrada al mapa (abierto a extensión).
 */
public class RedirectPorRolHandler implements AuthenticationSuccessHandler {

    private final Map<String, String> destinoPorRol;
    private final String destinoPorDefecto;

    public RedirectPorRolHandler(Map<String, String> destinoPorRol, String destinoPorDefecto) {
        this.destinoPorRol = destinoPorRol;
        this.destinoPorDefecto = destinoPorDefecto;
    }

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException {
        String destino = authentication.getAuthorities().stream()
                .map(GrantedAuthority::getAuthority)
                .map(destinoPorRol::get)
                .filter(d -> d != null)
                .findFirst()
                .orElse(destinoPorDefecto);
        response.sendRedirect(request.getContextPath() + destino);
    }
}
