package es.uma.tsaw.proyectobancosol.entity;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "tienda", schema = "public")
public class Tienda {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idTienda;

    @ManyToOne
    @JoinColumn(name = "id_cadena", nullable = false)
    private Cadena cadena;

    @ManyToOne
    @JoinColumn(name = "id_direccion")
    private Direccion direccion;

    @Column(name = "nombre_establecimiento", nullable = false)
    private String nombreEstablecimiento;

    @Column(name = "direccion")
    private String direccionEstablecimiento;

    @Column(name = "franquicia")
    private Boolean franquicia = false;

    @Column(name = "lineales", length = 10)
    private String lineales;

    @Column(name = "cp", length = 10)
    private String cp;

    // --- RELACIONES BIDIRECCIONALES (Opcionales pero útiles) ---
    // Si quieres saber desde una Tienda en qué campañas participa:
    @OneToMany(mappedBy = "tienda")
    private List<TiendaCampanya> tiendaCampanyasList;
}