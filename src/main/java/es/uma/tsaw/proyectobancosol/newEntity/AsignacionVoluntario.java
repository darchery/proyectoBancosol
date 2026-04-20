package es.uma.tsaw.proyectobancosol.newEntity;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "asignacion_voluntario", schema = "prueba_s")
public class AsignacionVoluntario {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idAsignacion;

    @ManyToOne
    @JoinColumn(name = "id_turno_activo", nullable = false)
    private TurnoActivo turnoActivo;

    @ManyToOne
    @JoinColumn(name = "id_usuario", nullable = false)
    private Usuario usuario;

    @ManyToOne
    @JoinColumn(name = "id_entidad")
    private EntidadColaboradora entidadColaboradora;

    @Column(name = "asistencia")
    private Boolean asistencia = false;
}