// TurnoRepositorio.java
package es.uma.tsaw.proyectobancosol.dao;
import es.uma.tsaw.proyectobancosol.entity.TurnoActivo;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TurnoActivoRepositorio extends JpaRepository<TurnoActivo, Integer> {
}