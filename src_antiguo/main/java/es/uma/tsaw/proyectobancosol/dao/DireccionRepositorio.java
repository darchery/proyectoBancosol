// DireccionRepositorio.java
package es.uma.tsaw.proyectobancosol.dao;
import es.uma.tsaw.proyectobancosol.entity.Direccion;
import org.springframework.data.jpa.repository.JpaRepository;
public interface DireccionRepositorio extends JpaRepository<Direccion, Integer> {}