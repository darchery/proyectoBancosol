package es.uma.tsaw.proyectobancosol.entity;

import lombok.Data;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * Asignación de un coordinador a una tienda dentro de una campaña.
 * Un coordinador se relaciona con sus asignaciones.
 * La asignación de tiendas a coordinadores es distinta en Primavera que en Gran Recogida.
 * @author bancosol
 */
@Entity
@Data
@Table(name = "ASIGNACION_COORDINADOR")
public class AsignacionCoordinador implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ID_ASIGNACION", nullable = false)
    private Integer idAsignacion;

    @JoinColumn(name = "ID_CAMPANYA", referencedColumnName = "ID_CAMPANYA")
    @ManyToOne(optional = false)
    private Campanya campanya;

    @JoinColumn(name = "ID_TIENDA", referencedColumnName = "ID_TIENDA")
    @ManyToOne(optional = false)
    private Tienda tienda;

    @JoinColumn(name = "ID_COORDINADOR", referencedColumnName = "ID_USUARIO")
    @ManyToOne(optional = false)
    private Coordinador coordinador;

    @Override
    public String toString() {
        return "es.bancosol.campanyas.entity.AsignacionCoordinador[ idAsignacion=" + idAsignacion + " ]";
    }

}
