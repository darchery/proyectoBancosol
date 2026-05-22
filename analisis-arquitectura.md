# Análisis de Arquitectura: Proyecto Bancosol vs Filosofía Service/DTO

## Resumen

El proyecto **no sigue** la filosofía Service + DTO descrita en el PDF. Carece de capa de servicios y DTOs. Los controladores hacen lógica de negocio directamente y pasan entidades JPA a las vistas.

---

## 1. ¿Qué dice la filosofía Service/DTO?

| Capa | Responsabilidad |
|---|---|
| **DAO/Repository** | Acceso a datos (CRUD). Ya existe vía Spring Data JPA. |
| **Service** | Lógica de negocio (casos de uso). El controlador SOLO invoca servicios. |
| **DTO** | POJO con atributos + getters/setters. Transfiere datos entre Service y Controller. Las entidades JPA NO deben usarse en controller/vista. |
| **Controller** | Orquestación: recibe petición, llama a Service, pasa DTOs a la vista. |

---

## 2. ¿Qué hace el proyecto actualmente?

### ✅ Lo que SÍ cumple
- **Entidades JPA** correctamente definidas en `entity/`
- **Repositorios DAO** vía Spring Data JPA en `dao/`

### ❌ Lo que NO cumple

#### a) **No existe capa Service**
No hay package `service/`. Los controladores inyectan repositorios directamente y ejecutan lógica de negocio inline.

**Ejemplo concreto** (`CampaniaControlador.java:27-68`):
```java
// En el controlador: construye JSON manual, formatea fechas, lógica de presentación
List<Campanya> campanas = this.campanyaRepositorio.findAll();
StringBuilder sb = new StringBuilder("{");
for (int i = 0; i < campanas.size(); i++) {
    // ... lógica de negocio y formateo aquí ...
}
```

**Otro ejemplo** (`UsuarioController.java:38-148`):
```java
// En el controlador: lógica compleja de enriquecimiento de usuarios
for (Usuario coordinador : coordinadores) {
    List<AsignacionVoluntario> asignaciones =
        asignacionVoluntarioRepository.findByUsuario(coordinador);
    // ... lógica de entidad, área, distrito ...
}
```

#### b) **No existen DTOs**
No hay package `dto/`. Los controladores pasan entidades JPA directamente al `Model` de Thymeleaf.

**Ejemplos**:
```java
// Entidad JPA expuesta directamente en la vista
model.addAttribute("usuario", usuario);    // UsuarioController.java:170
model.addAttribute("entidad", entidad);    // EntidadColaboradoraController.java:70
model.addAttribute("tienda", tienda);      // TiendaController.java:55

// Y en listados:
model.addAttribute("tiendas", tiendas);           // TiendaController.java:38
model.addAttribute("coordinadores", coordinadores); // UsuarioController.java:146
```

#### c) **Controladores con lógica de negocio mezclada**
Al no haber servicios, los controladores hacen de todo:

| Controller | Responsabilidades actuales |
|---|---|
| `UsuarioController` | CRUD usuarios + enriquecer con entidad/área/tiendas |
| `CampaniaControlador` | CRUD campañas + CRUD cadenas + construir JSON manual + formateo fechas + gestión relaciones many-to-many |
| `TiendaController` | CRUD tiendas + búsquedas con relaciones |
| `AsignacionController` | CRUD asignaciones + lógica de turno/entidad/voluntario |
| `EntidadColaboradoraController` | CRUD entidades + búsqueda responsables |
| `TiendaCampanyaController` | Asignación responsables + listado |
| `AutenticaController` | Login/logout (correcto, es lógica de presentación) |

---

## 3. Diferencias clave

| Aspecto | Filosofía Service/DTO | Proyecto actual |
|---|---|---|
| **Capa Service** | Capa intermedia con lógica de negocio | No existe |
| **DTO** | Objetos planos para transferir datos | No existen |
| **Entidades en vista** | Prohibido | Se usan directamente |
| **Lógica en controller** | Solo orquestación, sin lógica | Toda la lógica está aquí |
| **Separación responsabilidades** | Controller → Service → DAO | Controller → DAO (salta Service) |
| **Testabilidad** | Service testeable sin levantar web | Difícil (lógica acoplada a controller) |
| **Reutilización** | Lógica reusable desde distintos controllers | Lógica duplicada o acoplada |

---

## 4. Plan de migración

### Fase 0: Crear estructura de packages

```
src/main/java/es/uma/tsaw/proyectobancosol/
├── controller/      # (ya existe)
├── service/         # NUEVO
│   ├── UsuarioService.java
│   ├── CampanyaService.java
│   ├── TiendaService.java
│   ├── AsignacionService.java
│   ├── EntidadColaboradoraService.java
│   └── TiendaCampanyaService.java
├── dto/             # NUEVO
│   ├── UsuarioDTO.java
│   ├── UsuarioResumenDTO.java         # para listados
│   ├── CampanyaDTO.java
│   ├── TiendaDTO.java
│   ├── AsignacionDTO.java
│   └── ...
├── entity/          # (ya existe)
└── dao/             # (ya existe)
```

### Fase 1: Crear DTOs (por cada necesidad de vista)

Ejemplo de `UsuarioDTO`:
```java
package es.uma.tsaw.proyectobancosol.dto;

import lombok.Data;

@Data
public class UsuarioDTO {
    private Integer idUsuario;
    private String nombre;
    private String email;
    private String telefono;
    private String nombreRol;
    private String entidadColaboradora;
    private String area;
    private int tiendasAsignadas;
}
```

### Fase 2: Crear Services (mover lógica de negocio)

Cada Service:
- Inyecta los DAO que necesita
- Implementa métodos de caso de uso
- Convierte entre entidad y DTO

Ejemplo `UsuarioService`:
```java
@Service
@AllArgsConstructor
public class UsuarioService {
    private final UsuarioRepositorio usuarioRepo;
    private final AsignacionVoluntarioRepositorio asignacionRepo;
    private final TiendaCampanyaRepositorio tiendaCampanyaRepo;
    private final RolRepositorio rolRepo;

    public List<UsuarioResumenDTO> listarCoordinadoresConDatos() {
        List<Usuario> coordinadores = usuarioRepo.findUsuarioByRolID(2);
        return coordinadores.stream().map(this::aResumenDTO).toList();
    }

    public UsuarioDTO guardarUsuario(Integer id, String nombre, String email,
                                     String telefono, String contrasenya, Integer idRol) {
        Usuario usuario = (id == null) ? new Usuario()
                         : usuarioRepo.findById(id).orElseThrow();
        // ... lógica de negocio ...
        usuarioRepo.save(usuario);
        return aDTO(usuario);
    }

    private UsuarioResumenDTO aResumenDTO(Usuario u) { /* mapeo */ }
}
```

### Fase 3: Refactorizar Controladores

Cada controller pasa de:
```java
// ANTES - con repositorios y lógica inline
public class UsuarioController {
    @Autowired UsuarioRepositorio usuarioRepo;
    @GetMapping("/coordinadores-capitanes")
    public String listar(Model model) {
        List<Usuario> lista = usuarioRepo.findUsuarioByRolID(2);
        // lógica de enriquecimiento aquí...
        model.addAttribute("coordinadores", lista);
        return "vista";
    }
}
```

a:
```java
// DESPUÉS - solo orquestación
public class UsuarioController {
    private final UsuarioService usuarioService;

    @GetMapping("/coordinadores-capitanes")
    public String listar(Model model) {
        model.addAttribute("coordinadores",
            usuarioService.listarCoordinadoresConDatos());
        return "vista";
    }
}
```

### Fase 4: Adaptar vistas Thymeleaf

Cambiar referencias de atributos de entidad a atributos de DTO.

Ejemplo:
```html
<!-- ANTES: accede a propiedad de entidad JPA -->
<th:text="${usuario.rol.nombreRol}">

<!-- DESPUÉS: accede a propiedad de DTO -->
<th:text="${usuario.nombreRol}">
```

### Fase 5: Autenticación (opcional)

`AutenticaController` podría seguir usando entidad `Usuario` en sesión (es un caso fronterizo aceptable), o crear un `SesionDTO`.

---

## 5. Beneficios esperados

1. **Testabilidad**: Services se testean con JUnit + Mockito, sin levantar el contexto web.
2. **Mantenibilidad**: Lógica de negocio en un solo sitio, no dispersa en controllers.
3. **Seguridad**: No se exponen relaciones JPA completas (ej. `usuario.getRol().getNombreRol()` y lazy loading) a la vista.
4. **Claridad**: Controllers delgados, fáciles de leer.
5. **Reutilización**: Un Service puede ser usado por varios controllers (ej. API REST + Web).

---

## 6. Notas adicionales

- **Lombok `@Data` en entidades**: Usar `@Getter/@Setter/@ToString` es más seguro que `@Data` (evita `equals/hashCode` problemáticos con lazy loading). Podría revisarse.
- **`@Autowired` en campos**: Mejor usar constructor injection (`@RequiredArgsConstructor`) como ya hacen algunos controllers.
- **Construcción manual de JSON** en `CampaniaControlador`: Eso debería ir en un Service o en un helper dedicado, no en el controller.
