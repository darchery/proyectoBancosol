// TiendaCampanyaRepositorio.java
package es.uma.tsaw.proyectobancosol.dao;
import es.uma.tsaw.proyectobancosol.entity.TiendaCampanya;
import es.uma.tsaw.proyectobancosol.entity.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TiendaCampanyaRepositorio extends JpaRepository<TiendaCampanya, Integer> {
    List<TiendaCampanya> findByCampanyaIdCampanya(Integer idCampanya);
    List<TiendaCampanya> findByCoordinador(Usuario coordinador);
}