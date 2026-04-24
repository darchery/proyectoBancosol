// TiendaCampanyaRepositorio.java
package es.uma.tsaw.proyectobancosol.dao;
import es.uma.tsaw.proyectobancosol.entity.TiendaCampanya;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TiendaCampanyaRepositorio extends JpaRepository<TiendaCampanya, Integer> {
    List<TiendaCampanya> findByCampanyaIdCampanya(Integer idCampanya);
}