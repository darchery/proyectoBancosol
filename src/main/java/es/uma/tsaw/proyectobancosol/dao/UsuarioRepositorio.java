package es.uma.tsaw.proyectobancosol.dao;

import es.uma.tsaw.proyectobancosol.entity.Rol;
import es.uma.tsaw.proyectobancosol.entity.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.UUID;

public interface UsuarioRepositorio extends JpaRepository<Usuario, UUID> {
    @Query("select u from Usuario u " +
            "where u.rol.idRol = :rolID")
    List<Usuario> findUsuarioByRolID(Integer rolID);
}