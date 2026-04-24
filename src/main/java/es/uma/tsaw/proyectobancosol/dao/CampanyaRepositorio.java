// CampanyaRepositorio.java
package es.uma.tsaw.proyectobancosol.dao;
import es.uma.tsaw.proyectobancosol.entity.Campanya;
import org.springframework.data.jpa.repository.JpaRepository;
public interface CampanyaRepositorio extends JpaRepository<Campanya, Integer> {}