/**
 * Entidad JPA que representa la relación entre una tienda y una campaña.
 *
 * Autores:
 * - IA generativa: 100%
 */

package es.uma.tsaw.proyectobancosol.entity;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "tienda_campanya", schema = "public")
public class TiendaCampanyaEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idTiendaCampanya;

    @ManyToOne
    @JoinColumn(name = "id_tienda", nullable = false)
    private TiendaEntity tiendaEntity;

    @ManyToOne
    @JoinColumn(name = "id_campanya", nullable = false)
    private CampanyaEntity campanyaEntity;

    @ManyToOne
    @JoinColumn(name = "id_coordinador")
    private UsuarioEntity coordinador;

    @ManyToOne
    @JoinColumn(name = "id_capitan")
    private UsuarioEntity capitan;
}