package es.uma.tsaw.proyectobancosol.entity;

import jakarta.persistence.*;
import lombok.Data;
import java.util.UUID;

@Data
@Entity
@Table(name = "usuario", schema = "prueba_s")
public class Usuario {
    @Id
    @Column(name = "id_usuario", updatable = false, nullable = false)
    private UUID idUsuario; // No es autogenerado porque viene de Supabase Auth

    @ManyToOne
    @JoinColumn(name = "id_rol")
    private Rol rol;

    @Column(name = "nombre", nullable = false)
    private String nombre;

    @Column(name = "email", nullable = false, unique = true)
    private String email;

    @Column(name = "telefono", length = 20)
    private String telefono;
}