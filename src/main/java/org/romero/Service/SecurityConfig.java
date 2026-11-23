package org.romero.Service;

import jakarta.servlet.DispatcherType;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.password.NoOpPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public PasswordEncoder passwordEncoder() {
        return NoOpPasswordEncoder.getInstance();
    }

    @Bean
    public AuthenticationSuccessHandler successHandler() {
        return (request, response, authentication) -> {
            boolean esPsicologo = authentication.getAuthorities().stream()
                    .anyMatch(a -> a.getAuthority().equals("ROLE_PSICOLOGO"));

            String destino = esPsicologo ? "/psicologo/inicio" : "/paciente/inicio";
            response.sendRedirect(request.getContextPath() + destino);
        };
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .csrf(csrf -> csrf.disable())
                .authorizeHttpRequests(auth -> auth
                        .dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.ERROR).permitAll()
                        .requestMatchers("/login", "/login.jsp", "/registro",
                                "/css/**", "/js/**", "/error").permitAll()
                        // roles
                        .requestMatchers("/creartest").hasRole("PSICOLOGO")
                        .requestMatchers("/psicologo/inicio").hasRole("PSICOLOGO")
                        .requestMatchers("/paciente/inicio").hasRole("PACIENTE")
                        .requestMatchers("/test").hasRole("PACIENTE")
                        .requestMatchers("/test/**").hasRole("PACIENTE")
                        .requestMatchers("/psicologo/tests/**").hasRole("PSICOLOGO")
                        .requestMatchers("/psicologo/respuestas", "/psicologo/respuestas/**").hasRole("PSICOLOGO")
                        .requestMatchers("/paciente/historial").hasRole("PACIENTE")
                        .anyRequest().authenticated()
                )
                .formLogin(form -> form
                        .loginPage("/login")
                        .loginProcessingUrl("/login")
                        .successHandler(successHandler())  
                        .failureUrl("/login?error=true")
                        .permitAll()
                )
                .logout(logout -> logout
                        .logoutUrl("/logout")
                        .logoutSuccessUrl("/login?logout")
                        .permitAll()
                );
        return http.build();
    }
}