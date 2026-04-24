package es.uma.tsaw.proyectobancosol.newEntity;

import es.uma.tsaw.proyectobancosol.newEntity.Cadena;
import es.uma.tsaw.proyectobancosol.newEntity.Direccion;
import jakarta.persistence.*;
import lombok.Data;
import java.util.UUID;

@Data
@Entity
@Table(name = "tienda", schema = "prueba_s")
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
}