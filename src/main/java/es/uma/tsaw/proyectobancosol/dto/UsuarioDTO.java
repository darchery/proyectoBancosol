package es.uma.tsaw.proyectobancosol.dto;
import lombok.Data;
@Data
public class UsuarioDTO {
    private Integer idUsuario;
    private String nombre;
    private String email;
    private String telefono;
    private String contrasenya;
    private String nombreUsuario;

    private Integer rolId;
    // posbile modificacion
    private String rolNombre;
}