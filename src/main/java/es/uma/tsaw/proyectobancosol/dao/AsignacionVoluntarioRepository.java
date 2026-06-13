/**
 * Repositorio JPA para la entidad AsignacionVoluntario.
 *
 * Autores:
 * - Marina Ruiz: 50%
 * - Daniela Calderón: 29%
 * - Lucas Díaz Ruiz: 21%
 */

package es.uma.tsaw.proyectobancosol.dao;
import es.uma.tsaw.proyectobancosol.entity.AsignacionVoluntarioEntity;
import es.uma.tsaw.proyectobancosol.entity.UsuarioEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AsignacionVoluntarioRepository extends JpaRepository<AsignacionVoluntarioEntity, Integer> {

    List<AsignacionVoluntarioEntity> findByTurnoActivoIdTurnoActivo(Integer idTurnoActivo);

    List<AsignacionVoluntarioEntity> findByUsuario(UsuarioEntity usuarioEntity);
}