// AsignacionVoluntarioRepositorio.java
package es.uma.tsaw.proyectobancosol.dao;
import es.uma.tsaw.proyectobancosol.entity.AsignacionVoluntarioEntity;
import es.uma.tsaw.proyectobancosol.entity.UsuarioEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AsignacionVoluntarioRepository extends JpaRepository<AsignacionVoluntarioEntity, Integer> {

    List<AsignacionVoluntarioEntity> findByTurnoActivoIdTurnoActivo(Integer idTurnoActivo);

    List<AsignacionVoluntarioEntity> findByUsuario(UsuarioEntity usuarioEntity);
}