package es.uma.tsaw.proyectobancosol.entity;

import lombok.Data;
import jakarta.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


/**
 * Campaña de recogida (GR / Primavera). Una cadena participa en muchas campañas.
 * @author bancosol
 */
@Entity
@Data
@Table(name = "campanya", schema = "public")
public class CampanyaEntity implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_campanya", nullable = false)
    private Integer idCampanya;

    @Column(name = "nombre_campanya", length = 50)
    private String nombreCampanya;

    @Column(name = "tipo_campanya", length = 50)
    private String tipoCampanya;

    @Column(name = "fecha_inicio")
    @Temporal(TemporalType.DATE)
    private Date fechaInicio;

    @Column(name = "fecha_fin")
    @Temporal(TemporalType.DATE)
    private Date fechaFin;

    @Column(name = "estado", length = 50)
    private String estado;

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(
            name = "campanya_cadena",
            schema = "public",
            joinColumns = @JoinColumn(name = "id_campanya"),
            inverseJoinColumns = @JoinColumn(name = "id_cadena")
    )
    private List<CadenaEntity> cadenasParticipantes = new ArrayList<>();
}