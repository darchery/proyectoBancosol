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
 * Persona de contacto de una entidad colaboradora.
 * Cada colaborador puede tener múltiples personas de contacto.
 * @author bancosol
 */
@Entity
@Data
@Table(name = "CONTACTO")
public class Contacto implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ID_CONTACTO", nullable = false)
    private Integer idContacto;

    @JoinColumn(name = "ID_COLABORADOR", referencedColumnName = "ID_COLABORADOR")
    @ManyToOne(optional = false)
    private EntidadColaboradora colaborador;

    @Column(name = "NOMBRE", length = 150)
    private String nombre;

    @Column(name = "EMAIL", length = 150)
    private String email;

    @Column(name = "TELEFONO", length = 20)
    private String telefono;

    @Override
    public String toString() {
        return "es.bancosol.campanyas.entity.Contacto[ idContacto=" + idContacto + " ]";
    }

}
