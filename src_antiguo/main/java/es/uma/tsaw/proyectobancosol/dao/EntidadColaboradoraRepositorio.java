// EntidadColaboradoraRepositorio.java
package es.uma.tsaw.proyectobancosol.dao;
import es.uma.tsaw.proyectobancosol.entity.EntidadColaboradora;
import org.springframework.data.jpa.repository.JpaRepository;
public interface EntidadColaboradoraRepositorio extends JpaRepository<EntidadColaboradora, Integer> {}