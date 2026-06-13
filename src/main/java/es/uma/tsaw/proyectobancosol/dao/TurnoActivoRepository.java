// TurnoRepositorio.java
package es.uma.tsaw.proyectobancosol.dao;
import es.uma.tsaw.proyectobancosol.entity.TurnoActivoEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TurnoActivoRepository extends JpaRepository<TurnoActivoEntity, Integer> {
}