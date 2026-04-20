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
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * Dirección geográfica. Un colaborador tiene una dirección.
 * @author bancosol
 */
@Entity
@Data
@Table(name = "DIRECCION")
public class Direccion implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ID_DIRECCION", nullable = false)
    private Integer idDireccion;

    @Column(name = "ZONA_GEOGRAFICA", length = 100)
    private String zonaGeografica;

    @Column(name = "DISTRITO", length = 100)
    private String distrito;

    @OneToMany(mappedBy = "direccion")
    private List<Tienda> tiendaList;

    @OneToMany(mappedBy = "direccion")
    private List<EntidadColaboradora> colaboradorList;

    @Override
    public String toString() {
        return "es.bancosol.campanyas.entity.Direccion[ idDireccion=" + idDireccion + " ]";
    }

}
