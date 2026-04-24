package es.uma.tsaw.proyectobancosol.entity;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "entidad_colaboradora", schema = "prueba_s")
public class EntidadColaboradora {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idEntidad;

    @ManyToOne
    @JoinColumn(name = "id_responsable")
    private Usuario responsable;

    @Column(name = "nombre_entidad", nullable = false)
    private String nombreEntidad;

    @Column(name = "tipo", length = 100)
    private String tipo;

    @Column(name = "ligado_bancosol")
    private Boolean ligadoBancosol = false;
}