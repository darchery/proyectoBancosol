package es.uma.tsaw.proyectobancosol.entity;

import java.io.Serializable;
import java.util.Objects;

/**
 * Clase para la clave primaria compuesta de CampanyaCadena
 * @author bancosol
 */
public class CampanyaCadenaIdEntity implements Serializable {

    private Integer campanya;
    private Integer cadena;

    public CampanyaCadenaIdEntity() {}

    public CampanyaCadenaIdEntity(Integer campanya, Integer cadena) {
        this.campanya = campanya;
        this.cadena = cadena;
    }

    public Integer getCampanya() {
        return campanya;
    }

    public void setCampanya(Integer campanya) {
        this.campanya = campanya;
    }

    public Integer getCadena() {
        return cadena;
    }

    public void setCadena(Integer cadena) {
        this.cadena = cadena;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        CampanyaCadenaIdEntity that = (CampanyaCadenaIdEntity) o;
        return Objects.equals(campanya, that.campanya) &&
               Objects.equals(cadena, that.cadena);
    }

    @Override
    public int hashCode() {
        return Objects.hash(campanya, cadena);
    }
}
