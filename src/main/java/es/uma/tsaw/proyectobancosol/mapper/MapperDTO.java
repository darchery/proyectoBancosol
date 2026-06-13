/**
 * Clase abstracta base para todos los mapeadores DTO-Entidad.
 * Proporciona el método genérico toDTOList() basado en Streams.
 *
 * Autores:
 * - Proyectos de clase del profesor: 100%
 */

package es.uma.tsaw.proyectobancosol.mapper;

import java.util.List;
import java.util.stream.Collectors;

public abstract class MapperDTO<DTOClass, EntityClass> {
    public abstract DTOClass toDTO (EntityClass entityClass);

    public List<DTOClass> toDTOList(List<EntityClass> entities) {
        if (entities == null) {
            return List.of();
        }

        return entities.stream()
                .map(this::toDTO)
                .collect(Collectors.toList());
    }
}
