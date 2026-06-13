package es.uma.tsaw.proyectobancosol.dao;

import es.uma.tsaw.proyectobancosol.entity.CampanyaCadenaEntity;
import es.uma.tsaw.proyectobancosol.entity.CampanyaCadenaIdEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

/**
 * Repositorio para la entidad CampanyaCadena
 * Clave primaria compuesta: id_campanya + id_cadena
 * @author bancosol
 */
public interface CampanyaCadenaRepository extends JpaRepository<CampanyaCadenaEntity, CampanyaCadenaIdEntity> {

    /**
     * Encuentra todas las cadenas que participan en una campaña
     */
    @Query("SELECT cc FROM CampanyaCadenaEntity cc WHERE cc.campanyaEntity.idCampanya = :idCampanya")
    List<CampanyaCadenaEntity> findByCampanya(@Param("idCampanya") Integer idCampanya);

    /**
     * Encuentra todas las campañas en las que participa una cadena
     */
    @Query("SELECT cc FROM CampanyaCadenaEntity cc WHERE cc.cadenaEntity.idCadena = :idCadena")
    List<CampanyaCadenaEntity> findByCadena(@Param("idCadena") Integer idCadena);

    /**
     * Verifica si una cadena participa en una campaña
     */
    @Query("SELECT COUNT(cc) > 0 FROM CampanyaCadenaEntity cc WHERE cc.campanyaEntity.idCampanya = :idCampanya AND cc.cadenaEntity.idCadena = :idCadena")
    boolean existsByCampanyaAndCadena(@Param("idCampanya") Integer idCampanya, @Param("idCadena") Integer idCadena);
}
