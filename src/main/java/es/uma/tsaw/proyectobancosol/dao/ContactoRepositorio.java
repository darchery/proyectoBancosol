package es.uma.tsaw.proyectobancosol.dao;

import es.uma.tsaw.proyectobancosol.entity.Contacto;
import es.uma.tsaw.proyectobancosol.entity.EntidadColaboradora;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface ContactoRepositorio extends JpaRepository<Contacto, Integer> {
    List<Contacto> findByEntidad(EntidadColaboradora entidad);
}