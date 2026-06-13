package es.uma.tsaw.proyectobancosol.entity;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "asignacion_voluntario", schema = "public")
public class AsignacionVoluntarioEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idAsignacion;

    @ManyToOne
    @JoinColumn(name = "id_turno_activo", nullable = false)
    private TurnoActivoEntity turnoActivoEntity;

    @ManyToOne
    @JoinColumn(name = "id_usuario", nullable = false)
    private UsuarioEntity usuarioEntity;

    @ManyToOne
    @JoinColumn(name = "id_entidad")
    private EntidadColaboradoraEntity entidadColaboradoraEntity;

    @Column(name = "asistencia")
    private Boolean asistencia = false;
}