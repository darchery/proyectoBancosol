# Guía de Arquitectura: DTO, Service y Mapper

Este documento describe la nueva estructura del proyecto BancoSol, siguiendo el modelo de referencia del profesor. El objetivo es separar las responsabilidades de la aplicación para que sea más robusta y fácil de mantener.

## 1. El Esquema de Funcionamiento

El flujo de datos se divide en capas:

```text
Vista (JSP) <──> Controller <──> SERVICE <──> Repository <──> Base de Datos
                   │               │
                   └─> DTO <───────┘ (Usa el MAPPER para convertir)
```

## 2. Definición de Componentes

### A. DTO (Data Transfer Object)
Objetos simples que transportan datos entre capas.
- **Ubicación:** `es.uma.tsaw.proyectobancosol.dto`
- **Regla:** No contienen anotaciones de JPA (`@Entity`, `@Table`). Solo atributos, getters y setters.
- **Propósito:** Desacoplar la base de datos de la interfaz de usuario.

### B. Mapper
Clases encargadas de convertir entidades en DTOs.
- **Ubicación:** `es.uma.tsaw.proyectobancosol.mapper`
- **Herencia:** Deben extender de `MapperDTO<DTO, Entity>`.
- **Propósito:** Centralizar la lógica de transformación (p.ej. convertir una relación compleja en un ID o un String).

### C. Service
Capa donde reside la lógica de negocio.
- **Ubicación:** `es.uma.tsaw.proyectobancosol.service`
- **Anotación:** `@Service`.
- **Propósito:** Manejar la lógica, validaciones y llamadas a repositorios. Los controladores solo llaman a servicios.

---

## 3. Ejemplo de Implementación (Tienda)

### Mapper (`TiendaMapper.java`)
```java
@Component
public class TiendaMapper extends MapperDTO<TiendaDTO, Tienda> {
    @Override
    public TiendaDTO toDTO(Tienda entidad) {
        TiendaDTO dto = new TiendaDTO();
        dto.setId(entidad.getId());
        dto.setNombre(entidad.getNombre());
        if (entidad.getCadena() != null) {
            dto.setNombreCadena(entidad.getCadena().getNombre());
        }
        return dto;
    }
}
```

### Service (`TiendaService.java`)
```java
@Service
@AllArgsConstructor
public class TiendaService {
    private final TiendaRepositorio repo;
    private final TiendaMapper mapper;

    public List<TiendaDTO> obtenerTodas() {
        return mapper.toDTOList(repo.findAll());
    }
}
```

---

## 4. Plan de Implementación para BancoSol

A continuación se detalla la estructura recomendada para la transición de las funcionalidades actuales.

### Resumen de Componentes

| Bloque Funcional | Service | Mapper | Responsabilidad Principal |
| :--- | :--- | :--- | :--- |
| **Usuarios** | `UsuarioService` | `UsuarioMapper` | Registro de voluntarios, login, roles y gestión de perfiles. |
| **Campaña** | `CampanyaService` | `CampanyaMapper` | Creación de campañas anuales y estados de las mismas. |
| **Tiendas** | `TiendaService` | `TiendaMapper` | Gestión de establecimientos, relación con Cadenas y Direcciones. |
| **Asignaciones** | `AsignacionService` | `AsignacionMapper` | Asignar voluntarios a tiendas/turnos y validar su asistencia. |
| **Entidades** | `EntidadService` | `EntidadMapper` | Gestión de empresas o colectivos colaboradores. |

### Detalle por Bloque

#### 1. Usuarios y Roles
- **DTOs:** `UsuarioDTO`, `RolDTO`. (Seguridad: El DTO no debe incluir la contraseña).
- **Service:** Lógica de `validarLogin`, `listarPorRol` y `registrarNuevoVoluntario`.
- **Mapper:** Transforma entidades en DTOs, simplificando la relación con el Rol.

#### 2. Tiendas y Cadenas
- **DTOs:** `TiendaDTO`, `CadenaDTO`.
- **Service:** Gestión de tiendas, búsqueda de direcciones y asociación con cadenas.
- **Mapper:** Aplanar la dirección (ej: convertir objeto `Direccion` en String legible).

#### 3. Asignaciones (Núcleo)
- **DTOs:** `AsignacionDTO`.
- **Service:** Validación de horarios, evitar solapamientos de voluntarios y control de asistencia.
- **Mapper:** Traducir IDs de tiendas/usuarios a nombres para visualización en tablas.

