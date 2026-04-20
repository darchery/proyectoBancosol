package es.uma.tsaw.proyectobancosol.entity;

import lombok.Data;

import java.io.Serializable;
import javax.persistence.*;

@Entity
@Data
@Table(name = "VOLUNTARIO")
public class Voluntario implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ID_VOLUNTARIO", nullable = false)
    private Integer idVoluntario;

    @ManyToOne
    @JoinColumn(name = "ID_DIRECCION", referencedColumnName = "ID_DIRECCION")
    private Direccion direccion;

    @ManyToOne
    @JoinColumn(name = "ID_TIENDA", referencedColumnName = "ID_TIENDA")
    private Tienda tienda;

    @ManyToOne
    @JoinColumn(name = "ID_TURNO", referencedColumnName = "ID_TURNO")
    private TurnoPorDia turno;

    @ManyToOne
    @JoinColumn(name = "ID_USUARIO", referencedColumnName = "ID_USUARIO")
    private Usuario usuario;

    @ManyToOne
    @JoinColumn(name = "ID_PARTICIPACION", referencedColumnName = "ID_PARTICIPACION")
    private ParticipacionVoluntarios participacion;

    @Column(name = "HORARIOS", length = 200)
    private String horarios;

    @Override
    public String toString() {
        return "Voluntario[idVoluntario=" + idVoluntario + "]";
    }
}