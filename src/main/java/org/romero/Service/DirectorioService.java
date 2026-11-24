package org.romero.Service;

import org.romero.dto.CategoriaDirectorioDTO;

import java.util.List;

public interface DirectorioService {
    List<CategoriaDirectorioDTO> listarPorCategoria();
}
