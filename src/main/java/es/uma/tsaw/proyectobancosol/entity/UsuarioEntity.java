/*
    IA: 90%
    Lucas: 10%
*/

package es.uma.tsaw.proyectobancosol.entity;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "usuario", schema = "public")
public class UsuarioEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idUsuario;  // cambiar de UUID a Integer

    @ManyToOne
    @JoinColumn(name = "id_rol")
    private RolEntity rolEntity;

    @Column(name = "nombre", nullable = false)
    private String nombre;

    @Column(name = "email", nullable = false, unique = true)
    private String email;

    @Column(name = "telefono", length = 20)
    private String telefono;

    @Column(name = "contrasenya", nullable = false)
    private String contrasenya;

    @Column(name = "nombre_usuario", nullable = false)
    private String nombreUsuario;

    public String tranformarContrasenya(String contrasenya) {
        String res = "";
        for (Character c : contrasenya.toCharArray()) {
            res += "*";
        }
        return res;
    }
}