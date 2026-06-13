/**
 * Servicio que implementa la lógica de negocio para las asignaciones de voluntarios a turnos.
 *
 * Autores:
 * - Laia Díaz: 100%
 */

package es.uma.tsaw.proyectobancosol.service;

import es.uma.tsaw.proyectobancosol.dao.AsignacionVoluntarioRepository;
import es.uma.tsaw.proyectobancosol.dao.EntidadColaboradoraRepository;
import es.uma.tsaw.proyectobancosol.dao.TurnoActivoRepository;
import es.uma.tsaw.proyectobancosol.dao.UsuarioRepository;
import es.uma.tsaw.proyectobancosol.dto.AsignacionVoluntarioDTO;
import es.uma.tsaw.proyectobancosol.entity.AsignacionVoluntarioEntity;
import es.uma.tsaw.proyectobancosol.entity.EntidadColaboradoraEntity;
import es.uma.tsaw.proyectobancosol.entity.TurnoActivoEntity;
import es.uma.tsaw.proyectobancosol.entity.UsuarioEntity;
import es.uma.tsaw.proyectobancosol.mapper.AsignacionVoluntarioMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor
public class AsignacionVoluntarioService {

    private final AsignacionVoluntarioRepository asignacionVoluntarioRepository;
    private final AsignacionVoluntarioMapper asignacionVoluntarioMapper;
    private final UsuarioRepository usuarioRepository;
    private final TurnoActivoRepository turnoActivoRepository;
    private final EntidadColaboradoraRepository entidadColaboradoraRepository;

    public List<AsignacionVoluntarioDTO> findByUsuario(Integer idUsuario) {
        UsuarioEntity usuarioEntity = usuarioRepository.findById(idUsuario).orElseThrow();
        return asignacionVoluntarioMapper.toDTOList(
                asignacionVoluntarioRepository.findByUsuario(usuarioEntity));
    }

    public AsignacionVoluntarioDTO findById(Integer id) {
        return asignacionVoluntarioRepository.findById(id)
                .map(asignacionVoluntarioMapper::toDTO)
                .orElse(null);
    }

    public void guardar(Integer idUsuario, Integer id,
                        Integer idTurno, Integer idEntidad, Boolean asistencia) {
        AsignacionVoluntarioEntity asignacion;

        if (id == null) {
            asignacion = new AsignacionVoluntarioEntity();
            asignacion.setUsuarioEntity(usuarioRepository.findById(idUsuario).orElseThrow());
        } else {
            asignacion = asignacionVoluntarioRepository.findById(id).orElseThrow();
        }

        TurnoActivoEntity turno = turnoActivoRepository.findById(idTurno).orElseThrow();
        asignacion.setTurnoActivoEntity(turno);

        EntidadColaboradoraEntity entidad = idEntidad != null
                ? entidadColaboradoraRepository.findById(idEntidad).orElse(null) : null;
        asignacion.setEntidadColaboradoraEntity(entidad);

        asignacion.setAsistencia(Boolean.TRUE.equals(asistencia));
        asignacionVoluntarioRepository.save(asignacion);
    }

    public void borrar(Integer id) {
        asignacionVoluntarioRepository.deleteById(id);
    }
}