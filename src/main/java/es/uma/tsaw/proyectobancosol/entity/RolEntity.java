/**
 * Entidad JPA que representa un rol de usuario dentro del sistema.
 *
 * Autores:
 * - IA Generativa: 100%
 */

package es.uma.tsaw.proyectobancosol.entity;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "rol", schema = "public")
public class RolEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idRol;

    @Column(name = "nombre_rol", nullable = false, length = 50)
    private String nombreRol;
}