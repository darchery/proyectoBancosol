package es.uma.tsaw.proyectobancosol.entity;

import jakarta.persistence.*;
import lombok.Data;
import java.util.Date; // Necesario para el campo de fecha
import java.util.List;

@Data
@Entity
@Table(name = "entidad_colaboradora", schema = "public")
public class EntidadColaboradoraEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_entidad") // Asegúrate de que el nombre de columna coincida
    private Integer idEntidad;

    @ManyToOne
    @JoinColumn(name = "id_responsable")
    private UsuarioEntity responsable;

    @Column(name = "nombre_entidad", nullable = false)
    private String nombreEntidad;

    @Column(name = "tipo", length = 100)
    private String tipo;

    @Column(name = "ligado_bancosol")
    private Boolean ligadoBancosol = false;

    @ManyToOne
    @JoinColumn(name = "id_direccion")
    private DireccionEntity direccionEntity;

    @Column(name = "codigo_colaborador", length = 50)
    private String codigoColaborador;

    @Temporal(TemporalType.DATE)
    @Column(name = "fecha_alta")
    private Date fechaAlta;

    @Column(name = "estado_aprobacion")
    private Boolean estadoAprobacion = false;

    @Column(name = "observaciones", length = 255)
    private String observaciones;

    @OneToMany(mappedBy = "entidad", cascade = CascadeType.ALL)
    private List<ContactoEntity> contactoEntities;
}