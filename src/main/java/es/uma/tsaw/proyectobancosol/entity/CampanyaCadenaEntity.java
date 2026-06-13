/**
 * Entidad JPA que representa la relación entre una campaña y una cadena (tabla de unión). Representa la participación de una cadena en una campaña
 *
 * Autores:
 * - IA generativa: 100%
 */

package es.uma.tsaw.proyectobancosol.entity;

import jakarta.persistence.*;
import lombok.Data;
import java.io.Serializable;

@Data
@Entity
@Table(name = "campanya_cadena", schema = "public")
@IdClass(CampanyaCadenaId.class)
public class CampanyaCadenaEntity implements Serializable {

    @Id
    private Integer campanya;

    @Id
    private Integer cadena;

    @ManyToOne
    @MapsId("campanya")
    @JoinColumn(name = "id_campanya", nullable = false)
    private CampanyaEntity campanyaEntity;

    @ManyToOne
    @MapsId("cadena")
    @JoinColumn(name = "id_cadena", nullable = false)
    private CadenaEntity cadenaEntity;
}
