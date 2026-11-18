package org.romero;

import org.romero.dao.PacienteRepository;
import org.romero.model.Paciente;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

public class UsuarioDetails implements UserDetailsService {
    @Autowired
    private PacienteRepository pacienteRepository;

    @Override
    public UserDetails loadUserByUsername(String correo) throws UsernameNotFoundException {
        Paciente paciente = pacienteRepository.findByCorreoPac(correo);
        if (paciente == null) {
            throw new UsernameNotFoundException("Usuario no encontrado");
        }

        return User.withUsername(paciente.getCorreoPac())
                .password(paciente.getContraPac()) // En texto plano por ahora
                .roles("PACIENTE")
                .build();
    }
}
