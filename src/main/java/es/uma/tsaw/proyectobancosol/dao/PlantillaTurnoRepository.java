/**
 * Repositorio JPA para la entidad PlantillaTurno.
 *
 * Autores:
 * - Daniela Calderón: 100%
 */

package es.uma.tsaw.proyectobancosol.dao;
import es.uma.tsaw.proyectobancosol.entity.PlantillaTurnoEntity;
import org.springframework.data.jpa.repository.JpaRepository;
public interface PlantillaTurnoRepository extends JpaRepository<PlantillaTurnoEntity, Integer> {}