// DireccionRepositorio.java
package es.uma.tsaw.proyectobancosol.dao;
import es.uma.tsaw.proyectobancosol.entity.DireccionEntity;
import org.springframework.data.jpa.repository.JpaRepository;
public interface DireccionRepository extends JpaRepository<DireccionEntity, Integer> {}