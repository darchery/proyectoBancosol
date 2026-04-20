package es.uma.tsaw.proyectobancosol.entity;

import lombok.Data;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * Turno por día de una participación.
 * Si una persona participa varios días, tendrá varios turno_por_dia,
 * cada uno con su dia (enum) indicando qué día va.
 * @author bancosol
 */
@Entity
@Data
@Table(name = "TURNO_POR_DIA")
public class TurnoPorDia implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ID_TURNO", nullable = false)
    private Integer idTurno;

    @JoinColumn(name = "ID_PARTICIPACION", referencedColumnName = "ID_PARTICIPACION")
    @ManyToOne(optional = false)
    private ParticipacionVoluntarios participacion;

    @Enumerated(EnumType.STRING)
    @Column(name = "DIA")
    private Dia dia;

    @Enumerated(EnumType.STRING)
    @Column(name = "HORARIO")
    private Horario horario;

    @Column(name = "HORA_INICIO", length = 5)
    private String horaInicio;

    @Column(name = "HORA_FIN", length = 5)
    private String horaFin;

    @OneToMany(mappedBy = "turno")
    private List<Voluntario> voluntarioList;

    @Override
    public String toString() {
        return "es.bancosol.campanyas.entity.TurnoPorDia[ idTurno=" + idTurno + " ]";
    }

}
