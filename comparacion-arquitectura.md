# Comparativa Arquitectónica: Bancosol vs moviesTESAW

## Estado actual

| Aspecto | Bancosol (actual) | moviesTESAW (referencia) |
|---|---|---|
| **Sigue filosofía Service/DTO?** | ❌ No | ✅ Sí |
| **Capa Service** | No existe | `service/` — 4 Services |
| **DTOs** | No existen | `dto/` — 4 DTOs |
| **Mappers** | No existen | `mapper/` — 4 Mappers + clase abstracta |
| **Entidades en vista** | Sí, directo al Model | No, siempre van DTOs |
| **Lógica en controller** | Toda la lógica de negocio | Solo orquestación |

---

## 2. Estructura de packages

### moviesTESAW (proyecto de referencia)

```
src/main/java/es/tesaw/movies/
├── controller/
│   ├── AuthenticateController.java    ← solo inyecta Services
│   ├── MoviesController.java          ← solo inyecta Services
│   └── rest/
│       └── MoviesRestController.java  ← reusa el mismo MoviesService
├── service/
│   ├── AuthenticateService.java       ← lógica de login
│   ├── GenresService.java             ← listar géneros
│   ├── MoviesService.java             ← CRUD + filtros + lógica compleja
│   └── SpokenLanguagesService.java    ← listar idiomas
├── dto/
│   ├── Genre.java                     ← POJO plano (id, name)
│   ├── Movie.java                     ← POJO plano (todo lo que ve la vista)
│   ├── SpokenLanguage.java            ← POJO plano (id, name)
│   └── User.java                      ← POJO plano (id, name, username)
├── mapper/
│   ├── MapperDTO.java                 ← clase abstracta genérica <DTO, Entity>
│   ├── GenreMapper.java               ← Entity → DTO
│   ├── MovieMapper.java               ← Entity → DTO (convierte relaciones)
│   ├── SpokenLanguageMapper.java      ← Entity → DTO
│   └── UserMapper.java                ← Entity → DTO
├── entity/
│   ├── GenreEntity.java
│   ├── MovieEntity.java
│   ├── SpokenLanguageEntity.java
│   └── UserEditorEntity.java
└── dao/
    ├── GenreRepository.java
    ├── MoviesRepository.java
    ├── SpokenLanguageRepository.java
    └── UserEditorRepository.java
```

### Bancosol (proyecto actual)

```
src/main/java/es/uma/tsaw/proyectobancosol/
├── controller/
│   ├── AsignacionController.java          ← lógica + repos inline
│   ├── AutenticaController.java           ← lógica + repos inline
│   ├── CampaniaControlador.java           ← lógica + repos inline (y JSON manual)
│   ├── EntidadColaboradoraController.java ← lógica + repos inline
│   ├── TiendaCampanyaController.java      ← lógica + repos inline
│   ├── TiendaController.java              ← lógica + repos inline
│   └── UsuarioController.java             ← lógica + repos inline
├── entity/               ← 11 entidades JPA
├── dao/                  ← 10 repositorios
└── (no service/, no dto/, no mapper/)
```

---

## 3. Diferencias clave en el código

### DTOs vs Entidades en la vista

**moviesTESAW** — el controller nunca expone entidades:

```java
// MoviesController.java
List<Movie> pelis = this.moviesService.listarMovies();  // ← List<Movie> (DTO)
model.addAttribute("pelis", pelis);                      // ← DTO a la vista
```

**Bancosol** — el controller expone entidades directamente:

```java
// UsuarioController.java
List<Usuario> coordinadores = usuarioRepository.findUsuarioByRolID(2); // ← Entity
model.addAttribute("coordinadores", coordinadores);                     // ← Entity a la vista
```

### Services encapsulan la lógica

**moviesTESAW** — el Service hace toda la lógica y mapeo:

```java
// MoviesService.java
public List<Movie> listarMovies(String nombre, List<Integer> generosIds) {
    List<MovieEntity> lista;
    if ((nombre == null || nombre.isEmpty()) && generosIds == null) {
        lista = this.moviesRepository.findAll();
    } else if (generosIds == null) {
        lista = this.moviesRepository.filtrarPorPalabra(nombre);
    } else {
        lista = this.moviesRepository.filtrarPorPalabraYGeneros(nombre, generosIds);
    }
    return movieMapper.toDTOList(lista);  // ← mapea Entity → DTO
}
```

**Bancosol** — el controller hace la lógica directamente:

```java
// UsuarioController.java (en el controller, no en Service)
for (Usuario coordinador : coordinadores) {
    List<AsignacionVoluntario> asignaciones =
        asignacionVoluntarioRepository.findByUsuario(coordinador);
    // lógica de entidad/área...
}
```

### Mappers con herencia genérica

**moviesTESAW** tiene `MapperDTO<DTO, Entity>` abstracto con `toDTO()` y `toDTOList()`:

```java
// MapperDTO.java — clase base genérica
public abstract class MapperDTO<DTOClass, EntityClass> {
    public abstract DTOClass toDTO(EntityClass entityClass);

    public List<DTOClass> toDTOList(List<EntityClass> entities) { ... }
}

// MovieMapper.java — implementación concreta
@Component
public class MovieMapper extends MapperDTO<Movie, MovieEntity> {
    public Movie toDTO(MovieEntity movieEntity) {
        Movie movie = new Movie();
        movie.setId(movieEntity.getId());
        // ... mapeo campo a campo ...
        return movie;
    }
}
```

**Bancosol** no tiene nada equivalente.

### Services reusables desde múltiples controllers

**moviesTESAW** — `MoviesService` lo usan tanto `MoviesController` (web) como `MoviesRestController` (API REST):

```java
// MoviesRestController.java — reusa el mismo service
private final MoviesService moviesService;

@GetMapping("/")
public List<Movie> doInit() {
    return this.moviesService.listarMovies();  // mismo service que el web
}
```

**Bancosol** — si quisieras añadir una API REST, tendrías que duplicar toda la lógica.

---

## 4. Plan de migración paso a paso (para Bancosol)

### Fase 0: Setup — crear packages

```
src/main/java/es/uma/tsaw/proyectobancosol/
└── service/      (nuevo)
└── dto/          (nuevo)
└── mapper/       (nuevo, opcional pero recomendado)
```

### Fase 1: Crear `MapperDTO` abstracto (genérico)

```java
// mapper/MapperDTO.java
public abstract class MapperDTO<D, E> {
    public abstract D toDTO(E entity);
    public List<D> toDTOList(List<E> entities) {
        if (entities == null) return List.of();
        return entities.stream().map(this::toDTO).collect(Collectors.toList());
    }
}
```

### Fase 2: Crear DTOs (uno por cada vista o conjunto de datos)

Para cada entidad que se pasa a la vista, crear su DTO:

| Entidad actual | DTO necesario | Contiene |
|---|---|---|
| `Usuario` | `UsuarioDTO` | id, nombre, email, telefono, nombreRol |
| `Usuario` + enriquecimiento | `CoordinadorResumenDTO` | id, nombre, entidad, area, numTiendas |
| `Campanya` + cadenas | `CampanyaDTO` | id, nombre, tipo, estado, fechas, cadenas |
| `Tienda` + cadena + direccion | `TiendaDTO` | id, nombre, cadena, direccion, zona |
| `AsignacionVoluntario` | `AsignacionDTO` | id, turno, entidad, voluntario, asistencia |
| `EntidadColaboradora` | `EntidadDTO` | id, nombre, tipo, responsable, ligado |
| `TiendaCampanya` | `TiendaCampanyaDTO` | id, tienda, campaña, coordinador, capitán |
| `Usuario` (auth) | `SesionUsuarioDTO` | id, nombre, rol (para sesión HTTP) |

### Fase 3: Crear Mappers específicos

Para cada DTO, un Mapper que extienda `MapperDTO`:

```
mapper/
├── MapperDTO.java              ← abstracto genérico
├── UsuarioMapper.java          ← UsuarioEntity → UsuarioDTO
├── CampanyaMapper.java         ← CampanyaEntity → CampanyaDTO
├── TiendaMapper.java           ← TiendaEntity → TiendaDTO
├── AsignacionMapper.java       ← AsignacionEntity → AsignacionDTO
├── EntidadMapper.java          ← EntidadEntity → EntidadDTO
└── ...
```

Cada mapper mapea campo a campo y convierte relaciones JPA en IDs o strings planos (ej. `usuario.getRol().getNombreRol()` → `usuarioDTO.setNombreRol(...)`).

### Fase 4: Extraer lógica a Services

Para cada dominio, crear un Service que:

1. Inyecte los DAO que necesita
2. Inyecte su Mapper correspondiente
3. Implemente los casos de uso como métodos

| Service | Métodos principales | Lógica que absorbe del controller actual |
|---|---|---|
| `UsuarioService` | `listarCoordinadoresResumen()`, `guardar()`, `borrar()`, `buscar()` | Enriquecimiento con asignaciones + tiendas + distrito (UsuarioController:38-148) |
| `CampanyaService` | `listarConCadenas()`, `guardarTodo()`, `borrar()`, `buscar()` | Construcción JSON, gestión cadenas, parseo fechas (CampaniaControlador:27-194) |
| `TiendaService` | `listar()`, `guardar()`, `borrar()`, `buscar()` | Búsqueda con relaciones (TiendaController:37-80) |
| `AsignacionService` | `listarPorUsuario()`, `guardar()`, `borrar()` | Lógica turno/entidad (AsignacionController:38-120) |
| `EntidadService` | `listar()`, `guardar()`, `borrar()`, `buscar()` | CRUD + responsables (EntidadColaboradoraController:24-79) |
| `TiendaCampanyaService` | `asignarResponsables()`, `listarPorCampanya()` | Asignación coordinador/capitán (TiendaCampanyaController:29-48) |
| `AutenticacionService` | `login()`, `logout()` | Autenticación, mapeo a DTO de sesión (AutenticaController:30-43) |

### Fase 5: Refactorizar cada controller (de a uno)

Ejemplo concreto de cómo quedaría `UsuarioController` tras la migración:

```java
// DESPUÉS — UsuarioController refactorizado
@Controller
@AllArgsConstructor
@RequestMapping("/usuarios")
public class UsuarioController {

    private final UsuarioService usuarioService;

    @GetMapping("/coordinadores-capitanes")
    public String listarCoordinadores(Model model) {
        model.addAttribute("coordinadores",
            usuarioService.listarCoordinadoresResumen(2));  // rol coordinador
        model.addAttribute("capitanes",
            usuarioService.listarCoordinadoresResumen(3));  // rol capitán
        model.addAttribute("coordinadoresCapitanes",
            usuarioService.listarCoordinadoresResumen(6));  // rol coord+cap
        return "gestionCoordinadorCapitan";
    }

    @GetMapping("/voluntarios")
    public String listarVoluntarios(Model model) {
        model.addAttribute("voluntarios",
            usuarioService.listarVoluntarios());
        return "lista_voluntarios";
    }

    @GetMapping("/editarCrear")
    public String editarCrearUsuario(@RequestParam(value = "id", required = false) Integer id,
                                     @RequestParam(value = "idRol", required = true) Integer idRol,
                                     Model model) {
        model.addAttribute("usuario", usuarioService.buscarOCrear(id));
        model.addAttribute("rol", usuarioService.buscarRol(idRol));
        return "editarCrearUsuario";
    }

    @PostMapping("/guardar")
    public String guardarUsuario(@RequestParam(value = "id", required = false) Integer id,
                                 @RequestParam(value = "idRol", required = true) Integer idRol,
                                 @RequestParam(value = "nombre", required = false) String nombre,
                                 @RequestParam(value = "email", required = false) String email,
                                 @RequestParam(value = "telefono", required = false) String telefono,
                                 @RequestParam(value = "contrasenya", required = false) String contrasenya) {
        usuarioService.guardar(id, idRol, nombre, email, telefono, contrasenya);
        return "redirect:/usuarios/coordinadores-capitanes";
    }

    @GetMapping("/borrar")
    public String borrarUsuario(@RequestParam(value = "id", required = true) Integer id) {
        usuarioService.borrar(id);
        return "redirect:/usuarios/coordinadores-capitanes";
    }
}
```

### Fase 6: Adaptar vistas Thymeleaf

Buscar en los `.html` todas las referencias a propiedades de entidades JPA y cambiarlas por propiedades de DTO:

```html
<!-- ANTES: usa propiedad de entidad JPA con navegación de relaciones -->
<th:text="${usuario.rol.nombreRol}">
<td th:text="${coordinador.idUsuario}">

<!-- DESPUÉS: usa propiedad plana del DTO -->
<th:text="${usuario.nombreRol}">
<td th:text="${coordinador.id}">
```

También buscar atributos dinámicos como `entidad_${coordinador.idUsuario}` — en DTO pasarían como campos del propio DTO.

### Fase 7: Verificar y limpiar

- Eliminar `@Autowired` de repositorios en controllers
- Verificar que ningún controller importe `entity.*`
- Verificar que ningún `Model.addAttribute()` reciba una entidad
- Opcional: añadir `MoviesRestController`-like para exponer API REST reutilizando los mismos Services

---

## 5. Resumen visual del cambio

```
BANCO SOL (ANTES)                          BANCO SOL (DESPUÉS)

Controller                                  Controller
  ├── inyecta Repos                          ├── inyecta Services  ← SOLO orquesta
  ├── lógica de negocio inline               └── pasa DTOs a la vista
  ├── entidades al Model                          │
  └── ...                                        │
                                                 ▼
  (no service)                              Service
                                              ├── inyecta Repos    ← lógica aquí
                                              ├── inyecta Mapper
                                              └── devuelve DTOs
                                                    │
                                                    ▼
                                              DTOs planos a la vista
                                              (sin relaciones JPA expuestas)
```
