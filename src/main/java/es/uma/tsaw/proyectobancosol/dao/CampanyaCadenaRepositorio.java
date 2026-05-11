package es.uma.tsaw.proyectobancosol.dao;

import es.uma.tsaw.proyectobancosol.entity.CampanyaCadena;
import es.uma.tsaw.proyectobancosol.entity.CampanyaCadenaId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

/**
 * Repositorio para la entidad CampanyaCadena
 * Clave primaria compuesta: id_campanya + id_cadena
 * @author bancosol
 */
public interface CampanyaCadenaRepositorio extends JpaRepository<CampanyaCadena, CampanyaCadenaId> {

    /**
     * Encuentra todas las cadenas que participan en una campaña
     */
    @Query("SELECT cc FROM CampanyaCadena cc WHERE cc.campanya.idCampanya = :idCampanya")
    List<CampanyaCadena> findByCampanya(@Param("idCampanya") Integer idCampanya);

    /**
     * Encuentra todas las campañas en las que participa una cadena
     */
    @Query("SELECT cc FROM CampanyaCadena cc WHERE cc.cadena.idCadena = :idCadena")
    List<CampanyaCadena> findByCadena(@Param("idCadena") Integer idCadena);

    /**
     * Verifica si una cadena participa en una campaña
     */
    @Query("SELECT COUNT(cc) > 0 FROM CampanyaCadena cc WHERE cc.campanya.idCampanya = :idCampanya AND cc.cadena.idCadena = :idCadena")
    boolean existsByCampanyaAndCadena(@Param("idCampanya") Integer idCampanya, @Param("idCadena") Integer idCadena);
}
