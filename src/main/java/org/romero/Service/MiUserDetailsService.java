package org.romero.Service; // O el paquete donde la tengas

import org.romero.dao.PacienteRepository;
import org.romero.dao.PsicologoRepository;
import org.romero.dao.ModeradorRepository;
import org.romero.dao.TutorRepository;
import org.romero.model.Moderador;
import org.romero.model.Tutor;
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
    @Autowired
    private TutorRepository tutorRepository;
    @Autowired
    private ModeradorRepository moderadorRepository;

    @Override
    public UserDetails loadUserByUsername(String correo) throws UsernameNotFoundException {


        System.out.println("Intento de log");
        System.out.println("Correo; "+correo);

        Moderador moderador = moderadorRepository.findByUsuario(correo);
        if (moderador != null) {
            return User.withUsername(moderador.getUsuario())
                    .password(moderador.getContra())
                    .roles("MODERADOR")
                    .build();
        }

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

        Tutor tutor = tutorRepository.findByCorreoTut(correo);
        if (tutor != null) {
            return User.withUsername(tutor.getCorreoTut())
                    .password(tutor.getContraTut())
                    .roles("TUTOR")
                    .build();
        }

        throw new UsernameNotFoundException("Usuario no encontrado");
    }
}