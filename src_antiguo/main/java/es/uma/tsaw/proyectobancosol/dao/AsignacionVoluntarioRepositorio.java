// AsignacionVoluntarioRepositorio.java
package es.uma.tsaw.proyectobancosol.dao;
import es.uma.tsaw.proyectobancosol.entity.AsignacionVoluntario;
import es.uma.tsaw.proyectobancosol.entity.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AsignacionVoluntarioRepositorio extends JpaRepository<AsignacionVoluntario, Integer> {

    List<AsignacionVoluntario> findByTurnoActivoIdTurnoActivo(Integer idTurnoActivo);

    List<AsignacionVoluntario> findByUsuario(Usuario usuario);
}