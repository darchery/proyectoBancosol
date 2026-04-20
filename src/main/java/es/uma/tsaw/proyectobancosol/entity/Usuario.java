package es.uma.tsaw.proyectobancosol.entity;

import lombok.Data;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Usuario del sistema. Se relaciona con todos los roles.
 * @author bancosol
 */
@Entity
@Data
@Table(name = "USUARIO")
public class Usuario implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ID_USUARIO", nullable = false)
    private Integer idUsuario;

    @Enumerated(EnumType.STRING)
    @Column(name = "TIPO_USUARIO", nullable = false)
    private TipoUsuario tipoUsuario;

    @Column(name = "NOMBRE", nullable = false, length = 100)
    private String nombre;

    @Column(name = "CONTRASENA", nullable = false, length = 255)
    private String contrasena;

    @Override
    public String toString() {
        return "es.bancosol.campanyas.entity.Usuario[ idUsuario=" + idUsuario + " ]";
    }

}
