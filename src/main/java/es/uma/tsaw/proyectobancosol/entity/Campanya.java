package es.uma.tsaw.proyectobancosol.entity;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDate;
import java.util.List;


@Data
@Entity
@Table(name = "campanya", schema = "prueba_s")
public class Campanya {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idCampanya;

    @Column(name = "nombre_campanya", nullable = false)
    private String nombreCampanya;

    @Column(name = "fecha_inicio")
    private LocalDate fechaInicio;

    @Column(name = "fecha_fin")
    private LocalDate fechaFin;

    @Column(name = "estado", length = 50)
    private String estado;

    @ManyToMany
    @JoinTable(
            name = "campanya_cadena",
            schema = "prueba_s",
            joinColumns = @JoinColumn(name = "id_campanya"),
            inverseJoinColumns = @JoinColumn(name = "id_cadena")
    )
    private List<Cadena> cadenasParticipantes;
}