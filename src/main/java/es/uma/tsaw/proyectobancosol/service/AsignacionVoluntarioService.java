package es.uma.tsaw.proyectobancosol.service;

import es.uma.tsaw.proyectobancosol.dao.AsignacionVoluntarioRepositorio;
import es.uma.tsaw.proyectobancosol.dao.EntidadColaboradoraRepositorio;
import es.uma.tsaw.proyectobancosol.dao.TurnoActivoRepositorio;
import es.uma.tsaw.proyectobancosol.dao.UsuarioRepositorio;
import es.uma.tsaw.proyectobancosol.dto.AsignacionVoluntarioDTO;
import es.uma.tsaw.proyectobancosol.entity.AsignacionVoluntario;
import es.uma.tsaw.proyectobancosol.entity.EntidadColaboradora;
import es.uma.tsaw.proyectobancosol.entity.TurnoActivo;
import es.uma.tsaw.proyectobancosol.entity.Usuario;
import es.uma.tsaw.proyectobancosol.mapper.AsignacionVoluntarioMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor
public class AsignacionVoluntarioService {

    private final AsignacionVoluntarioRepositorio asignacionVoluntarioRepositorio;
    private final AsignacionVoluntarioMapper asignacionVoluntarioMapper;
    private final UsuarioRepositorio usuarioRepositorio;
    private final TurnoActivoRepositorio turnoActivoRepositorio;
    private final EntidadColaboradoraRepositorio entidadColaboradoraRepositorio;

    public List<AsignacionVoluntarioDTO> findByUsuario(Integer idUsuario) {
        Usuario usuario = usuarioRepositorio.findById(idUsuario).orElseThrow();
        return asignacionVoluntarioMapper.toDTOList(
                asignacionVoluntarioRepositorio.findByUsuario(usuario));
    }

    public AsignacionVoluntarioDTO findById(Integer id) {
        return asignacionVoluntarioRepositorio.findById(id)
                .map(asignacionVoluntarioMapper::toDTO)
                .orElse(null);
    }

    public void guardar(Integer idUsuario, Integer id,
                        Integer idTurno, Integer idEntidad, Boolean asistencia) {
        AsignacionVoluntario asignacion;

        if (id == null) {
            asignacion = new AsignacionVoluntario();
            asignacion.setUsuario(usuarioRepositorio.findById(idUsuario).orElseThrow());
        } else {
            asignacion = asignacionVoluntarioRepositorio.findById(id).orElseThrow();
        }

        TurnoActivo turno = turnoActivoRepositorio.findById(idTurno).orElseThrow();
        asignacion.setTurnoActivo(turno);

        EntidadColaboradora entidad = idEntidad != null
                ? entidadColaboradoraRepositorio.findById(idEntidad).orElse(null) : null;
        asignacion.setEntidadColaboradora(entidad);

        asignacion.setAsistencia(Boolean.TRUE.equals(asistencia));
        asignacionVoluntarioRepositorio.save(asignacion);
    }

    public void borrar(Integer id) {
        asignacionVoluntarioRepositorio.deleteById(id);
    }
}