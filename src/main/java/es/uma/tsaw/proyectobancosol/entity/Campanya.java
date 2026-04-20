package es.uma.tsaw.proyectobancosol.entity;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

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

    @JoinTable(name = "CAMPANYA_CADENA",
        joinColumns = {
            @JoinColumn(name = "ID_CAMPANYA", referencedColumnName = "ID_CAMPANYA")},
        inverseJoinColumns = {
            @JoinColumn(name = "ID_CADENA", referencedColumnName = "ID_CADENA")})
    @ManyToMany
    private List<Cadena> cadenaList;

    @OneToMany(mappedBy = "campanya")
    private List<AsignacionCoordinador> asignacionList;

    @OneToMany(mappedBy = "campanya")
    private List<ParticipacionVoluntarios> participacionList;

    @Override
    public String toString() {
        return "es.bancosol.campanyas.entity.Campanya[ idCampanya=" + idCampanya + " ]";
    }

}
