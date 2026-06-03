/*
    Lucas: 33%%
    Sergio: 33%
    Laia: 33%
*/

package es.uma.tsaw.proyectobancosol.dao;

import es.uma.tsaw.proyectobancosol.entity.Rol;
import es.uma.tsaw.proyectobancosol.entity.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface UsuarioRepositorio extends JpaRepository<Usuario, Integer> {
    @Query("select u from Usuario u " +
            "where u.rol.idRol = :rolID")
    List<Usuario> findUsuarioByRolID(Integer rolID);

    @Query("select u from Usuario u where u.nombreUsuario = :nombreUsuario and u.contrasenya = :contrasenya")
    public Usuario autheticate (@Param("nombreUsuario")String nombreUsuario, @Param("contrasenya") String contrasenya);

    Usuario findByEmail(String email);
}