package org.romero.Service; // O el paquete donde la tengas

import org.romero.dao.PacienteRepository;
import org.romero.dao.PsicologoRepository;
import org.romero.model.Paciente;
import org.romero.model.Psicologo;
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
    @Autowired
    private PsicologoRepository psicologoRepository;

    @Override
    public UserDetails loadUserByUsername(String correo) throws UsernameNotFoundException {


        System.out.println("Intento de log");
        System.out.println("Correo; "+correo);

        Paciente paciente = pacienteRepository.findByCorreoPac(correo);

        if (paciente != null) {
            return User.withUsername(paciente.getCorreoPac())
                    .password(paciente.getContraPac())
                    .roles("PACIENTE")
                    .build();

        }
        Psicologo psicologo = psicologoRepository.findByCorreopsic(correo);
        if (psicologo != null){
            return User.withUsername(psicologo.getCorropsic())
                    .password(psicologo.getContrapsic())
                    .roles("PSICOLOGO")
                    .build();
        }

        throw new UsernameNotFoundException("Usuario no encontrado");
    }
}