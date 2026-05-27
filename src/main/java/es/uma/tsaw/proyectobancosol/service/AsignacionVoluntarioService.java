package es.uma.tsaw.proyectobancosol.service;

import es.uma.tsaw.proyectobancosol.dao.AsignacionVoluntarioRepositorio;
import es.uma.tsaw.proyectobancosol.dto.AsignacionVoluntarioDTO;
import es.uma.tsaw.proyectobancosol.mapper.AsignacionVoluntarioMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AsignacionVoluntarioService {

    private AsignacionVoluntarioRepositorio asignacionVoluntarioRepository;
    private AsignacionVoluntarioMapper userMapper;

    public List<AsignacionVoluntarioDTO> findAll() {
        return AsignacionVoluntarioService.this.asignacionVoluntarioRepository.findAll()
                .stream()
                .map(userMapper::toDTO)
                .toList();
    }

    public AsignacionVoluntarioDTO findById(Integer id) {
        return asignacionVoluntarioRepository.findById(id)
                .map(userMapper::toDTO)
                .orElse(null);
    }
}
