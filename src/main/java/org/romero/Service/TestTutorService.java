package org.romero.Service;

import org.romero.dto.TestTutorDTO;

import java.util.List;

/** Tests que ve un tutor: solo los de los pacientes a su cargo. */
public interface TestTutorService {
    List<TestTutorDTO> listarTests(Integer idTutor);
}
