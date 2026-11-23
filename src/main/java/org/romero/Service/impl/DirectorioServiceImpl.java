package org.romero.Service.impl;

import org.romero.Service.DirectorioService;
import org.romero.dao.TestRepository;
import org.romero.dto.CategoriaDirectorioDTO;
import org.romero.dto.TestDirectorioDTO;
import org.romero.model.Test;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.Collator;
import java.util.*;

@Service
public class DirectorioServiceImpl implements DirectorioService {

    static final String SIN_CATEGORIA = "Sin categoría";

    private final TestRepository testRepository;

    public DirectorioServiceImpl(TestRepository testRepository) {
        this.testRepository = testRepository;
    }

    @Override
    @Transactional(readOnly = true)
    public List<CategoriaDirectorioDTO> listarPorCategoria() {

        Map<String, String> nombres = new HashMap<>();
        Map<String, List<TestDirectorioDTO>> grupos = new HashMap<>();

        for (Test t : testRepository.findByActivoTrueOrderByFechaCreacionDesc()) {
            String limpia = t.getCategoria() == null ? "" : t.getCategoria().trim();
            String nombre = limpia.isEmpty() ? SIN_CATEGORIA : limpia;
            String clave = nombre.toLowerCase(Locale.ROOT);

            nombres.putIfAbsent(clave, nombre);
            grupos.computeIfAbsent(clave, k -> new ArrayList<>())
                  .add(new TestDirectorioDTO(t.getIdTest(), t.getNombre(), t.getDuracionMin()));
        }

        Collator collator = Collator.getInstance(new Locale("es", "MX"));
        List<String> claves = new ArrayList<>(grupos.keySet());
        claves.sort((a, b) -> {
            boolean aSin = a.equals(SIN_CATEGORIA.toLowerCase(Locale.ROOT));
            boolean bSin = b.equals(SIN_CATEGORIA.toLowerCase(Locale.ROOT));
            if (aSin != bSin) return aSin ? 1 : -1;
            return collator.compare(nombres.get(a), nombres.get(b));
        });

        List<CategoriaDirectorioDTO> resultado = new ArrayList<>();
        for (String clave : claves) {
            resultado.add(new CategoriaDirectorioDTO(nombres.get(clave), grupos.get(clave)));
        }
        return resultado;
    }
}
