/**
 * Repositorio JPA para la entidad TiendaCampanya.
 *
 * Autores:
 * - Laia Díaz: 50%
 * - Daniela Calderón: 33%
 * - Lucas Díaz Ruiz: 17%
 */

package es.uma.tsaw.proyectobancosol.dao;
import es.uma.tsaw.proyectobancosol.entity.TiendaCampanyaEntity;
import es.uma.tsaw.proyectobancosol.entity.UsuarioEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TiendaCampanyaRepository extends JpaRepository<TiendaCampanyaEntity, Integer> {
    List<TiendaCampanyaEntity> findByCoordinador(UsuarioEntity coordinador);
}