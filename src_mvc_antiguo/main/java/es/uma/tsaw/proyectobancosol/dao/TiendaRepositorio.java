package es.uma.tsaw.proyectobancosol.dao;

import es.uma.tsaw.proyectobancosol.entity.Tienda;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface TiendaRepositorio extends JpaRepository<Tienda, Integer> {

    @Query("SELECT t FROM Tienda t LEFT JOIN FETCH t.cadena LEFT JOIN FETCH t.direccion WHERE t.idTienda = :id")
    Optional<Tienda> findByIdConRelaciones(@Param("id") Integer id);

}
