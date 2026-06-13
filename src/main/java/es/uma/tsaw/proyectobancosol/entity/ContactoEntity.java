/**
 * Entidad JPA que representa un contacto de una entidad colaboradora.
 *
 * Autores:
 * - IA generativa: 100%
 */

package es.uma.tsaw.proyectobancosol.entity;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "contacto", schema = "public")
public class ContactoEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_contacto")
    private Integer idContacto;

    @ManyToOne
    @JoinColumn(name = "id_entidad", nullable = false)
    private EntidadColaboradoraEntity entidad;

    @Column(name = "nombre", length = 255)
    private String nombre;

    @Column(name = "email", length = 255)
    private String email;

    @Column(name = "telefono", length = 50)
    private String telefono;

    @Column(name = "es_principal")
    private Boolean esPrincipal = false;
}