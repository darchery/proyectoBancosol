package es.uma.tsaw.proyectobancosol.dao;

import es.uma.tsaw.proyectobancosol.entity.CampanyaEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CampanyaRepository extends JpaRepository<CampanyaEntity, Integer> {

    List<CampanyaEntity> findByNombreCampanya(String nombreCampanya);
}