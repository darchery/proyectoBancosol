package es.uma.tsaw.proyectobancosol.entity;

import lombok.Data;
import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;


/**
 * Campaña de recogida (GR / Primavera). Una cadena participa en muchas campañas.
 * @author bancosol
 */
@Entity
@Data
@Table(name = "CAMPANYA")
public class Campanya implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ID_CAMPANYA", nullable = false)
    private Integer idCampanya;

    @Column(name = "TIPO_CAMPANYA", length = 50)
    private String tipoCampanya;

    @Column(name = "FECHA_INICIO")
    @Temporal(TemporalType.DATE)
    private Date fechaInicio;

    @Column(name = "FECHA_FIN")
    @Temporal(TemporalType.DATE)
    private Date fechaFin;

    @Column(name = "ESTADO", length = 50)
    private String estado;

    @ManyToMany
    @JoinTable(
            name = "campanya_cadena",
            schema = "public",
            joinColumns = @JoinColumn(name = "id_campanya"),
            inverseJoinColumns = @JoinColumn(name = "id_cadena")
    )
    private List<Cadena> cadenasParticipantes;
}