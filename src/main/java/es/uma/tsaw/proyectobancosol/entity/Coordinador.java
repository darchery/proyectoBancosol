package es.uma.tsaw.proyectobancosol.entity;

import lombok.Data;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.MapsId;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * Coordinador. Gestiona las tiendas y colaboradores asignados.
 * Una tienda tiene X coordinadores. Un coordinador se relaciona con sus asignaciones.
 * @author bancosol
 */
@Entity
@Data
@Table(name = "COORDINADOR")
public class Coordinador implements Serializable {

    @Id
    @Basic(optional = false)
    @Column(name = "ID_USUARIO", nullable = false)
    private Integer idUsuario;

    @MapsId
    @OneToOne
    @JoinColumn(name = "ID_USUARIO", referencedColumnName = "ID_USUARIO")
    private Usuario usuario;

    @JoinColumn(name = "ID_TIENDA", referencedColumnName = "ID_TIENDA")
    @ManyToOne
    private Tienda tienda;

    @Column(name = "NOMBRE_COMPLETO", length = 150)
    private String nombreCompleto;

    @Column(name = "CAPITAN")
    private Boolean capitan;

    @Column(name = "TELEFONO", length = 20)
    private String telefono;

    @Column(name = "EMAIL", length = 150)
    private String email;

    @Column(name = "OBSERVACIONES", length = 500)
    private String observaciones;

    @OneToMany(mappedBy = "coordinador")
    private List<AsignacionCoordinador> asignacionList;

    @Override
    public String toString() {
        return "es.bancosol.campanyas.entity.Coordinador[ idUsuario=" + idUsuario + " ]";
    }

}
