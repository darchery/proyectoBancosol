/**
 * Repositorio JPA para la entidad Tienda.
 *
 * Autores:
 * - Sergio Aldana: 100%
 */

package es.uma.tsaw.proyectobancosol.dao;

import es.uma.tsaw.proyectobancosol.entity.TiendaEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface TiendaRepository extends JpaRepository<TiendaEntity, Integer> {

    @Query("SELECT t FROM TiendaEntity t LEFT JOIN FETCH t.cadenaEntity LEFT JOIN FETCH t.direccionEntity WHERE t.idTienda = :id")
    Optional<TiendaEntity> findByIdConRelaciones(@Param("id") Integer id);

}
