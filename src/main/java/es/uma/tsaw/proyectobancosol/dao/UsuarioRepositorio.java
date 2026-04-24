// UsuarioRepositorio.java  ← UUID, no Integer!
package es.uma.tsaw.proyectobancosol.dao;
import es.uma.tsaw.proyectobancosol.entity.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.UUID;
public interface UsuarioRepositorio extends JpaRepository<Usuario, UUID> {}