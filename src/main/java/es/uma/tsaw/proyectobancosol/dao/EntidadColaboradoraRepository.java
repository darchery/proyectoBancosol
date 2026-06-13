// EntidadColaboradoraRepositorio.java
package es.uma.tsaw.proyectobancosol.dao;
import es.uma.tsaw.proyectobancosol.entity.EntidadColaboradoraEntity;
import org.springframework.data.jpa.repository.JpaRepository;
public interface EntidadColaboradoraRepository extends JpaRepository<EntidadColaboradoraEntity, Integer> {}