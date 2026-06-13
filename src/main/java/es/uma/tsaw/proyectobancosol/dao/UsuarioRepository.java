/**
 * Repositorio JPA para la entidad Usuario.
 *
 * Autores:
 * - Lucas Díaz Ruiz: 34%
 * - Sergio Aldana: 33%
 * - Laia Díaz: 33%
 */

package es.uma.tsaw.proyectobancosol.dao;

import es.uma.tsaw.proyectobancosol.entity.UsuarioEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface UsuarioRepository extends JpaRepository<UsuarioEntity, Integer> {
    @Query("select u from UsuarioEntity u " +
            "where u.rol.idRol = :rolID")
    List<UsuarioEntity> findUsuarioByRolID(Integer rolID);

    @Query("select u from UsuarioEntity u where u.nombreUsuario = :nombreUsuario and u.contrasenya = :contrasenya")
    public UsuarioEntity autheticate (@Param("nombreUsuario")String nombreUsuario, @Param("contrasenya") String contrasenya);

    UsuarioEntity findByEmail(String email);
}