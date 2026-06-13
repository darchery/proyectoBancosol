/**
 * Repositorio JPA para la entidad Cadena.
 *
 * Autores:
 * - Daniela Calderón: 100%
 */

package es.uma.tsaw.proyectobancosol.dao;
import es.uma.tsaw.proyectobancosol.entity.CadenaEntity;
import org.springframework.data.jpa.repository.JpaRepository;
public interface CadenaRepository extends JpaRepository<CadenaEntity, Integer> {}