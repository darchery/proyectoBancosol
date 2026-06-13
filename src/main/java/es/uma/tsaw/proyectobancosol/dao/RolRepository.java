/**
 * Repositorio JPA para la entidad Rol.
 *
 * Autores:
 * - Daniela Calderón: 100%
 */

package es.uma.tsaw.proyectobancosol.dao;
import es.uma.tsaw.proyectobancosol.entity.RolEntity;
import org.springframework.data.jpa.repository.JpaRepository;
public interface RolRepository extends JpaRepository<RolEntity, Integer> {}