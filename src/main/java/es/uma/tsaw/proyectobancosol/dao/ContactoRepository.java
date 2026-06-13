/**
 * Repositorio JPA para la entidad Contacto.
 *
 * Autores:
 * - Daniela Calderón: 100%
 */

package es.uma.tsaw.proyectobancosol.dao;

import es.uma.tsaw.proyectobancosol.entity.ContactoEntity;
import es.uma.tsaw.proyectobancosol.entity.EntidadColaboradoraEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface ContactoRepository extends JpaRepository<ContactoEntity, Integer> {
    List<ContactoEntity> findByEntidad(EntidadColaboradoraEntity entidad);
}