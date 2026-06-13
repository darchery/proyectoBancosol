/**
 * Clase que representa la clave compuesta (embeddable) para la entidad CampanyaCadena.
 *
 * Autores:
 * - IA generativa: 100%
 */

package es.uma.tsaw.proyectobancosol.entity;

import java.io.Serializable;
import java.util.Objects;

public class CampanyaCadenaId implements Serializable {

    private Integer campanya;
    private Integer cadena;

    public CampanyaCadenaId() {}

    public CampanyaCadenaId(Integer campanya, Integer cadena) {
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
        CampanyaCadenaId that = (CampanyaCadenaId) o;
        return Objects.equals(campanya, that.campanya) &&
               Objects.equals(cadena, that.cadena);
    }

    @Override
    public int hashCode() {
        return Objects.hash(campanya, cadena);
    }
}
