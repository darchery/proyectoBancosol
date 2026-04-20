package es.uma.tsaw.proyectobancosol.entity;

import lombok.Data;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
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
 * Entidad colaboradora (ayuntamiento, colegio, familia, voluntario independiente...).
 * Cada colaborador puede tener múltiples personas de contacto.
 * Un colaborador está asignado a un coordinador.
 * @author bancosol
 */
@Entity
@Data
@Table(name = "ENTIDAD_COLABORADORA")
public class EntidadColaboradora implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ID_COLABORADOR", nullable = false)
    private Integer idColaborador;

    @JoinColumn(name = "ID_DIRECCION", referencedColumnName = "ID_DIRECCION")
    @ManyToOne
    private Direccion direccion;

    @Column(name = "NOMBRE_COLABORADOR", nullable = false, length = 200)
    private String nombreColaborador;

    @Column(name = "DOMICILIO", length = 255)
    private String domicilio;

    @Column(name = "LIGADO_A_BANCOSOL")
    private Boolean ligadoABancosol;

    @Column(name = "TIPO", length = 50)
    private String tipo;

    @Column(name = "OBSERVACIONES", length = 500)
    private String observaciones;

    @Column(name = "NUMERO_VOLUNTARIOS")
    private Integer numeroVoluntarios;

    @OneToMany(mappedBy = "colaborador", cascade = CascadeType.ALL)
    private List<Contacto> contactoList;

    @OneToMany(mappedBy = "colaborador")
    private List<ParticipacionVoluntarios> participacionList;

    @Override
    public String toString() {
        return "es.bancosol.campanyas.entity.EntidadColaboradora[ idColaborador=" + idColaborador + " ]";
    }

}
