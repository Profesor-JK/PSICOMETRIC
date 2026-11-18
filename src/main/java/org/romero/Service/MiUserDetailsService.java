package org.romero.Service; // O el paquete donde la tengas

import org.romero.dao.PacienteRepository;
import org.romero.model.Paciente;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class MiUserDetailsService implements UserDetailsService {
    @Autowired
    private PacienteRepository pacienteRepository;

    @Override
    public UserDetails loadUserByUsername(String correo) throws UsernameNotFoundException {


        System.out.println("Intento de log");
        System.out.println("Correo; "+correo);
        Paciente paciente = pacienteRepository.findByCorreoPac(correo);

        if (paciente == null) {;
            throw new UsernameNotFoundException("Usuario no encontrado");
        }

        return User.withUsername(paciente.getCorreoPac())
                .password(paciente.getContraPac())
                .roles("PACIENTE")
                .build();
    }
}