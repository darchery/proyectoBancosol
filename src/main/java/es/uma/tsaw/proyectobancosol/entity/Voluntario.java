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
 * Voluntario individual dentro de una participación.
 * El número de voluntarios en una participación se determina por el número de
 * registros Voluntario asociados a esa ParticipacionVoluntarios.
 * Cada participación tiene un turno.
 * @author bancosol
 */
@Entity
@Data
@Table(name = "VOLUNTARIO")
public class Voluntario implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ID_VOLUNTARIO", nullable = false)
    private Integer idVoluntario;

    @JoinColumn(name = "ID_DIRECCION", referencedColumnName = "ID_DIRECCION")
    @ManyToOne
    private Direccion direccion;

    @JoinColumn(name = "ID_TIENDA", referencedColumnName = "ID_TIENDA")
    @ManyToOne
    private Tienda tienda;

    @JoinColumn(name = "ID_TURNO", referencedColumnName = "ID_TURNO")
    @ManyToOne
    private TurnoPorDia turno;

    @JoinColumn(name = "ID_USUARIO", referencedColumnName = "ID_USUARIO")
    @ManyToOne
    private Usuario usuario;

    @JoinColumn(name = "ID_PARTICIPACION", referencedColumnName = "ID_PARTICIPACION")
    @ManyToOne
    private ParticipacionVoluntarios participacion;

    @Column(name = "HORARIOS", length = 200)
    private String horarios;

    @Override
    public String toString() {
        return "es.bancosol.campanyas.entity.Voluntario[ idVoluntario=" + idVoluntario + " ]";
    }

}
