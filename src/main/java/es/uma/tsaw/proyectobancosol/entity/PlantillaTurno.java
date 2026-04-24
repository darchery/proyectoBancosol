package es.uma.tsaw.proyectobancosol.entity;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "plantilla_turno", schema = "prueba_s")
public class PlantillaTurno {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idPlantilla;

    @Column(name = "dia_semana", length = 20)
    private String diaSemana;

    @Column(name = "franja_horaria", length = 50)
    private String franjaHoraria;
}