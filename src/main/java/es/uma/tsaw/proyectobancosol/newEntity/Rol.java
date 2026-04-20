package es.uma.tsaw.proyectobancosol.newEntity;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "rol", schema = "prueba_s")
public class Rol {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idRol;

    @Column(name = "nombre_rol", nullable = false, length = 50)
    private String nombreRol;
}