package org.romero.Service;

import org.romero.dto.TestTutorDTO;

import java.util.List;
public interface TestTutorService {
    List<TestTutorDTO> listarTests(Integer idTutor);
}
