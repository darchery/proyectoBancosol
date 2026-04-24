package es.uma.tsaw.proyectobancosol.entity;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "direccion", schema = "prueba_s")
public class Direccion {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idDireccion;

    @Column(name = "distrito_local", length = 150)
    private String distritoLocal;

    @Column(name = "zona_geografica", length = 150)
    private String zonaGeografica;
}