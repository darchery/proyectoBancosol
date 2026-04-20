package es.uma.tsaw.proyectobancosol.entity;

import lombok.Data;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * Tienda de una cadena. Una tienda pertenece a una cadena y está asignada a un coordinador.
 * @author bancosol
 */
@Entity
@Data
@Table(name = "TIENDA")
public class Tienda implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ID_TIENDA", nullable = false)
    private Integer idTienda;

    @JoinColumn(name = "ID_CADENA", referencedColumnName = "ID_CADENA")
    @ManyToOne(optional = false)
    private Cadena cadena;

    @JoinColumn(name = "ID_DIRECCION", referencedColumnName = "ID_DIRECCION")
    @ManyToOne
    private Direccion direccion;

    @Column(name = "PARTICIPA")
    private Boolean participa;

    @Column(name = "FRANQUICIA")
    private Boolean franquicia;

    @Column(name = "LINEALES")
    private Integer lineales;

    @Column(name = "RESENA_CADENA", length = 200)
    private String resenaCadena;

    @Column(name = "DOMICILIO", length = 255)
    private String domicilio;

    @Column(name = "DISTRITO", length = 100)
    private String distrito;

    @Column(name = "CLASIFICACION", length = 200)
    private String clasificacion;

    @OneToMany(mappedBy = "tienda")
    private List<Coordinador> coordinadorList;

    @OneToMany(mappedBy = "tienda")
    private List<AsignacionCoordinador> asignacionList;

    @OneToMany(mappedBy = "tienda")
    private List<ParticipacionVoluntarios> participacionList;

    @Override
    public String toString() {
        return "es.bancosol.campanyas.entity.Tienda[ idTienda=" + idTienda + " ]";
    }

}
