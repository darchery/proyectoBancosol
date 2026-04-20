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
 * Participación de una entidad colaboradora en una tienda dentro de una campaña.
 * El número de relaciones de voluntario indicará el número de voluntarios participando.
 * Cada participación tiene uno o más colaboradores y cada participación tiene un turno.
 * @author bancosol
 */
@Entity
@Data
@Table(name = "PARTICIPACION_VOLUNTARIOS")
public class ParticipacionVoluntarios implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ID_PARTICIPACION", nullable = false)
    private Integer idParticipacion;

    @JoinColumn(name = "ID_CAMPANYA", referencedColumnName = "ID_CAMPANYA")
    @ManyToOne(optional = false)
    private Campanya campanya;

    @JoinColumn(name = "ID_TIENDA", referencedColumnName = "ID_TIENDA")
    @ManyToOne(optional = false)
    private Tienda tienda;

    @JoinColumn(name = "ID_COLABORADOR", referencedColumnName = "ID_COLABORADOR")
    @ManyToOne(optional = false)
    private EntidadColaboradora colaborador;

    @OneToMany(mappedBy = "participacion")
    private List<TurnoPorDia> turnoList;

    @OneToMany(mappedBy = "participacion")
    private List<Voluntario> voluntarioList;

    @Override
    public String toString() {
        return "es.bancosol.campanyas.entity.ParticipacionVoluntarios[ idParticipacion=" + idParticipacion + " ]";
    }

}
