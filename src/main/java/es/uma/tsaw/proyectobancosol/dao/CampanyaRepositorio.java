package es.uma.tsaw.proyectobancosol.dao;

import es.uma.tsaw.proyectobancosol.entity.Campanya;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CampanyaRepositorio extends JpaRepository<Campanya, Integer> {

    List<Campanya> findByNombreCampanya(String nombreCampanya);
}