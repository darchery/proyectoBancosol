package es.uma.tsaw.proyectobancosol.entity;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "cadena", schema = "public")
public class Cadena {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idCadena;

    @Column(name = "nombre_cadena", nullable = false, length = 150)
    private String nombreCadena;

    @Column(name = "resenya_cadena", length = 150)
    private String resenyaCadena;

    @Column(name = "logo_url")
    private String logoUrl;
}