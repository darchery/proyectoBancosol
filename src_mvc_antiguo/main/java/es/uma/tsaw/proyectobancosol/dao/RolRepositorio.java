// RolRepositorio.java
package es.uma.tsaw.proyectobancosol.dao;
import es.uma.tsaw.proyectobancosol.entity.Rol;
import org.springframework.data.jpa.repository.JpaRepository;
public interface RolRepositorio extends JpaRepository<Rol, Integer> {}