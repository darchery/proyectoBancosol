package es.uma.tsaw.proyectobancosol.entity;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDate;
import java.time.LocalTime;

@Data
@Entity
@Table(name = "turno_activo", schema = "prueba_s")
public class TurnoActivo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idTurnoActivo;

    @ManyToOne
    @JoinColumn(name = "id_tienda_campanya", nullable = false)
    private TiendaCampanya tiendaCampanya;

    @ManyToOne
    @JoinColumn(name = "id_plantilla", nullable = false)
    private PlantillaTurno plantillaTurno;

    @Column(name = "fecha_exacta", nullable = false)
    private LocalDate fechaExacta;

    @Column(name = "hora_inicio")
    private LocalTime horaInicio;

    @Column(name = "hora_fin")
    private LocalTime horaFin;

    @Column(name = "plazas_disponibles")
    private Integer plazasDisponibles = 0;
}