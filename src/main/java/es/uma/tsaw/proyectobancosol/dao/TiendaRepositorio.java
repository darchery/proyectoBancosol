// TiendaRepositorio.java
package es.uma.tsaw.proyectobancosol.dao;
import es.uma.tsaw.proyectobancosol.entity.Tienda;
import org.springframework.data.jpa.repository.JpaRepository;
public interface TiendaRepositorio extends JpaRepository<Tienda, Integer> {}