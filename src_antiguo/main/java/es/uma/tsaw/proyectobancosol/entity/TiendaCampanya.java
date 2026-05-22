package es.uma.tsaw.proyectobancosol.entity;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "tienda_campanya", schema = "public")
public class TiendaCampanya {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idTiendaCampanya;

    @ManyToOne
    @JoinColumn(name = "id_tienda", nullable = false)
    private Tienda tienda;

    @ManyToOne
    @JoinColumn(name = "id_campanya", nullable = false)
    private Campanya campanya;

    @ManyToOne
    @JoinColumn(name = "id_coordinador")
    private Usuario coordinador;

    @ManyToOne
    @JoinColumn(name = "id_capitan")
    private Usuario capitan;
}