package org.romero.Service;

import jakarta.servlet.DispatcherType;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.password.NoOpPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import java.util.Map;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public PasswordEncoder passwordEncoder() {
        return NoOpPasswordEncoder.getInstance();
    }

    @Bean
    public AuthenticationSuccessHandler successHandler() {
        return new RedirectPorRolHandler(Map.of(
                "ROLE_PSICOLOGO", "/psicologo/inicio",
                "ROLE_TUTOR", "/tutor/tests",
                "ROLE_MODERADOR", "/admin/psicologos",
                "ROLE_PACIENTE", "/paciente/inicio"), "/paciente/inicio");
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .csrf(csrf -> csrf.disable())
                .authorizeHttpRequests(auth -> auth
                        .dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.ERROR).permitAll()
                        .requestMatchers("/api/auth/**").permitAll()
                        .requestMatchers("/", "/prueba", "/directorio", "/info").permitAll()
                        .requestMatchers("/login", "/login.jsp", "/registro",
                                "/css/**", "/js/**", "/styles/**", "/img/**", "/error").permitAll()
                        .requestMatchers("/creartest").hasRole("PSICOLOGO")
                        .requestMatchers("/psicologo/inicio").hasRole("PSICOLOGO")
                        .requestMatchers("/paciente/inicio").hasRole("PACIENTE")
                        .requestMatchers("/test").hasRole("PACIENTE")
                        .requestMatchers("/test/**").hasRole("PACIENTE")
                        .requestMatchers("/psicologo/tests/**").hasRole("PSICOLOGO")
                        .requestMatchers("/psicologo/pacientes", "/psicologo/pacientes/**").hasAnyRole("PSICOLOGO", "MODERADOR")
                        .requestMatchers("/psicologo/respuestas", "/psicologo/respuestas/**").hasRole("PSICOLOGO")
                        .requestMatchers("/paciente/historial").hasRole("PACIENTE")
                        .requestMatchers("/tutor", "/tutor/**").hasRole("TUTOR")
                        .requestMatchers("/admin", "/admin/**").hasRole("MODERADOR")
                        .anyRequest().authenticated()
                )
                .formLogin(form -> form
                        .loginPage("/login")
                        .loginProcessingUrl("/login")
                        .successHandler(successHandler())  
                        .failureUrl("/login?error=true")
                        .permitAll()
                )
                .httpBasic(Customizer.withDefaults())
                .logout(logout -> logout
                        .logoutUrl("/logout")
                        .logoutSuccessUrl("/login?logout")
                        .permitAll()
                );
        return http.build();
    }
}