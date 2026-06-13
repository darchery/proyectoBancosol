package es.uma.tsaw.proyectobancosol.entity;

import jakarta.persistence.*;
import lombok.Data;
import java.io.Serializable;

/**
 * Relación entre Campaña y Cadena (tabla de unión)
 * Representa la participación de una cadena en una campaña
 * @author bancosol
 */
@Data
@Entity
@Table(name = "campanya_cadena", schema = "public")
@IdClass(CampanyaCadenaIdEntity.class)
public class CampanyaCadenaEntity implements Serializable {

    @Id
    @ManyToOne
    @JoinColumn(name = "id_campanya", nullable = false)
    private CampanyaEntity campanyaEntity;

    @Id
    @ManyToOne
    @JoinColumn(name = "id_cadena", nullable = false)
    private CadenaEntity cadenaEntity;
}
