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
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * Cadena de supermercados. Una cadena participa en muchas campañas.
 * @author bancosol
 */
@Entity
@Data
@Table(name = "CADENA")
public class Cadena implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ID_CADENA", nullable = false)
    private Integer idCadena;

    @Column(name = "NOMBRE_CADENA", nullable = false, length = 100)
    private String nombreCadena;

    @Column(name = "PARTICIPA_EN")
    private Boolean participaEn;

    @OneToMany(mappedBy = "cadena")
    private List<Tienda> tiendaList;

    @ManyToMany(mappedBy = "cadenaList")
    private List<Campanya> campanyaList;

    @Override
    public String toString() {
        return "es.bancosol.campanyas.entity.Cadena[ idCadena=" + idCadena + " ]";
    }

}
