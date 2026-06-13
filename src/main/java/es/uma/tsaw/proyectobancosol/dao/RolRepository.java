// RolRepositorio.java
package es.uma.tsaw.proyectobancosol.dao;
import es.uma.tsaw.proyectobancosol.entity.RolEntity;
import org.springframework.data.jpa.repository.JpaRepository;
public interface RolRepository extends JpaRepository<RolEntity, Integer> {}