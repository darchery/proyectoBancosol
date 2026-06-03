/*
    IA: 90%
    Lucas: 10%
*/

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

    // Sólo son usados por listarCoordinadoresCapitanes
    private String entidad;
    private String area;
    private Integer numTiendas;

    public String tranformarContrasenya(String contrasenya) {
        String res = "";
        for (Character c : contrasenya.toCharArray()) {
            res += "*";
        }
        return res;
    }
}