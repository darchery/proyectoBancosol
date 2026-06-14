# Proyecto Bancosol

Sistema de gestión para el banco de alimentos **Bancosol**, desarrollado como proyecto de la asignatura **Tecnología de Servidor para Aplicaciones Web** (TSAW) — Universidad de Málaga.

## Tecnologías

- **Backend:** Java 17, Spring Boot 4.0.5, Spring MVC, Spring Data JPA
- **Frontend:** JSP (sin JavaScript), CSS
- **Base de datos:** PostgreSQL (Supabase)
- **Construcción:** Maven
- **Entorno:** `.env` con `dotenv-java` (carga variables antes de arrancar Spring)

## Arquitectura

El proyecto sigue una arquitectura en capas sin JavaScript en las vistas:

```
Controller → Service → Mapper → DTO → Repository → Entity → BD
                    ↓
                  JSP (Vista, sin JS)
```

### Capas

| Capa | Descripción |
|------|-------------|
| **Entity** | Modelo JPA que mapea las tablas de la BD. 12 entidades. |
| **Repository** | Acceso a datos mediante Spring Data JPA. 11 interfaces DAO. |
| **DTO** | Objetos de transferencia con datos formateados para la vista. 10 DTOs. |
| **Mapper** | Conversión Entity → DTO. Heredan de `MapperDTO<D,E>` abstracto. 10 mappers. |
| **Service** | Lógica de negocio y coordinación. 9 servicios. |
| **Controller** | Manejo de peticiones HTTP y carga del modelo. 9 controladores. |
| **JSP** | Vistas con scriptlets y JSTL. **Sin etiquetas `<script>` en ningún JSP.** Todo el dinamismo se resuelve en servidor. |

### Seguridad

Control de acceso por roles mediante `SecurityUtil.tieneRol(session, roles...)` (sin Spring Security):

| ID | Rol |
|----|------|
| 1 | Administrador |
| 2 | Coordinador |
| 3 | Capitán |
| 4 | Voluntario |
| 5 | Entidad |
| 6 | CoordinadorCapitán |

### Convenciones de código

- **Prefijo `do`:** Todos los métodos de controlador llevan el prefijo `do` (ej. `doGuardar`, `doListar`, `doBorrar`) para distinguirlos de métodos de utilidad.
- **`@RequestParam`:** Los controladores reciben parámetros individuales con `@RequestParam`, no DTOs completos con `@ModelAttribute`.
- **Sin JavaScript:** Todo el dinamismo se resuelve en servidor; las vistas JSP no contienen etiquetas `<script>`.

## Estructura del proyecto

```
src/
├── main/
│   ├── java/es/uma/tsaw/proyectobancosol/
│   │   ├── controller/         # 9 controladores
│   │   ├── dao/                # 11 repositorios JPA
│   │   ├── dto/                # 10 DTOs
│   │   ├── entity/             # 12 entidades JPA
│   │   ├── mapper/             # 10 mappers + base abstracta
│   │   ├── service/            # 9 servicios
│   │   ├── util/               # SecurityUtil (control de roles)
│   │   └── ProyectoBancosolApplication.java
│   ├── resources/
│   │   ├── application.properties
│   │   └── static/
│   │       ├── css/            # 7 hojas de estilo
│   │       └── images/         # Logotipos (2)
│   └── webapp/WEB-INF/view/    # 18 vistas JSP
scriptsBaseDatos/               # 15 scripts SQL
```

## Modelo de datos (12 entidades)

```
Rol
  └─ Usuario ──── AsignacionVoluntario ──── TurnoActivo ──── PlantillaTurno
                   └─ EntidadColaboradora ──── Contacto
                       └─ Direccion
Cadena ──── Campanya (ManyToMany)
              └─ TiendaCampanya ──── Tienda ──── Cadena
                  └─ Usuario (coordinador/capitan)
```

| Entidad | Tabla | Clave |
|---------|-------|-------|
| `UsuarioEntity` | `usuario` | FK → `RolEntity` |
| `RolEntity` | `rol` | — |
| `EntidadColaboradoraEntity` | `entidad_colaboradora` | FK → `UsuarioEntity` (responsable), `DireccionEntity`; 1:N → `ContactoEntity` |
| `ContactoEntity` | `contacto` | FK → `EntidadColaboradoraEntity` |
| `DireccionEntity` | `direccion` | — |
| `CadenaEntity` | `cadena` | — |
| `TiendaEntity` | `tienda` | FK → `CadenaEntity`, `DireccionEntity`; 1:N → `TiendaCampanyaEntity` |
| `CampanyaEntity` | `campanya` | M:N → `CadenaEntity` (join: `campanya_cadena`) |
| `TiendaCampanyaEntity` | `tienda_campanya` | FK → `TiendaEntity`, `CampanyaEntity`, `UsuarioEntity` (coord), `UsuarioEntity` (capitan) |
| `PlantillaTurnoEntity` | `plantilla_turno` | — |
| `TurnoActivoEntity` | `turno_activo` | FK → `TiendaCampanyaEntity`, `PlantillaTurnoEntity` |
| `AsignacionVoluntarioEntity` | `asignacion_voluntario` | FK → `TurnoActivoEntity`, `UsuarioEntity`, `EntidadColaboradoraEntity` |

## Endpoints

### Públicos (sin autenticación)

| Método | Ruta | Acción |
|--------|------|--------|
| GET | `/` | Página de login |
| POST | `/autentica` | Autenticar usuario |
| GET | `/salir` | Cerrar sesión |
| GET | `/menu` | Menú principal |
| GET | `/sinPermisos` | Página de acceso denegado |

### Campañas (solo admin, rol 1)

| Método | Ruta | Acción | Vista |
|--------|------|--------|-------|
| GET | `/campanyas` | Listar campañas y cadenas | `gestionCampanyas` |
| GET | `/campanyas/generarCampanya` | Formulario crear/editar campaña | `formularioCampanya` |
| GET | `/campanyas/historial` | Historial de campañas | `historialCampanyas` |
| POST | `/campanyas/generarCampanyaConDatos` | Crear campaña rápida (tipo+fechas+cadenas) | redirect |
| POST | `/campanyas/guardar` | Guardar campaña desde formulario | redirect |
| GET | `/campanyas/borrar` | Borrar campaña | redirect |

### Cadenas (solo admin, rol 1)

| Método | Ruta | Acción | Vista |
|--------|------|--------|-------|
| GET | `/cadenas/nueva` | Formulario nueva cadena | `formularioCadena` |
| GET | `/cadenas/editar` | Formulario editar cadena | `formularioCadena` |
| POST | `/cadenas/guardar` | Guardar cadena | redirect |
| GET | `/cadenas/borrar` | Borrar cadena | redirect |

### Tiendas (solo admin, rol 1)

| Método | Ruta | Acción | Vista |
|--------|------|--------|-------|
| GET | `/tiendas` | Listar tiendas | `gestionTienda` |
| GET | `/tiendas/editarCrear` | Formulario crear/editar tienda | `formularioTienda` |
| POST | `/tiendas/guardar` | Guardar tienda | redirect |
| GET | `/tiendas/borrar` | Borrar tienda | redirect |

### Tienda-Campaña (solo admin, rol 1)

| Método | Ruta | Acción |
|--------|------|--------|
| POST | `/tiendacampanya/asignar-responsables` | Asignar coordinador/capitán a tienda-campaña |

### Entidades Colaboradoras (admin y coordinadores, roles 1, 2, 6)

| Método | Ruta | Acción | Vista |
|--------|------|--------|-------|
| GET | `/entidades` | Listar entidades | `gestionColaboradores` |
| GET | `/entidades/nueva` | Formulario nueva entidad | `formularioEntidadColaboradora` |
| GET | `/entidades/editar` | Formulario editar entidad | `formularioEntidadColaboradora` |
| POST | `/entidades/guardar` | Guardar entidad | redirect |
| GET | `/entidades/borrar` | Borrar entidad (solo admin) | redirect |

### Contactos (admin y coordinadores, roles 1, 2, 6)

| Método | Ruta | Acción | Vista |
|--------|------|--------|-------|
| GET | `/entidades/{id}/contactos` | Listar contactos | `formularioContactos` |
| GET | `/entidades/{id}/contactos/nuevo` | Nuevo contacto | `formularioContacto` |
| GET | `/entidades/{id}/contactos/editar` | Editar contacto | `formularioContacto` |
| POST | `/entidades/{id}/contactos/guardar` | Guardar contacto | redirect |
| GET | `/entidades/{id}/contactos/borrar` | Borrar contacto (solo admin) | redirect |

### Voluntarios (admin y coordinadores, roles 1, 2, 6)

| Método | Ruta | Acción | Vista |
|--------|------|--------|-------|
| GET | `/usuarios/voluntarios` | Listar voluntarios | `listarVoluntarios` |
| GET | `/voluntarios/listar` | Asignaciones de un voluntario | `gestionVoluntarios` |
| GET | `/voluntarios/edit` | Formulario crear/editar asignación | `editarAsignacionVoluntario` |
| POST | `/voluntarios/guardar` | Guardar asignación | redirect |
| GET | `/voluntarios/borrar` | Borrar asignación | redirect |

### Usuarios (solo admin, rol 1)

| Método | Ruta | Acción | Vista |
|--------|------|--------|-------|
| GET | `/usuarios/coordinadores-capitanes` | Listar coordinadores/capitanes | `gestionCoordinadorCapitan` |
| GET | `/usuarios/editarCrear` | Formulario crear/editar usuario | `editarCrearUsuario` |
| POST | `/usuarios/guardar` | Guardar usuario | redirect |
| GET | `/usuarios/borrar` | Borrar usuario | redirect |

## Vistas JSP (18)

| JSP | Controladores | Propósito |
|-----|--------------|-----------|
| `login` | AutenticaController | Inicio de sesión |
| `menu` | AutenticaController | Menú principal con roles |
| `sinPermisos` | AutenticaController | Acceso denegado |
| `gestionCampanyas` | CampanyaController | Gestión campañas: crear rápida, seleccionar cadenas |
| `formularioCampanya` | CampanyaController | Formulario completo crear/editar campaña |
| `historialCampanyas` | CampanyaController | Historial de campañas |
| `formularioCadena` | CadenaController | Crear/editar cadena |
| `gestionTienda` | TiendaController | Listado de tiendas con CRUD |
| `formularioTienda` | TiendaController | Crear/editar tienda |
| `gestionColaboradores` | EntidadColaboradoraController | Listado de entidades colaboradoras |
| `formularioEntidadColaboradora` | EntidadColaboradoraController | Crear/editar entidad |
| `formularioContactos` | ContactoController | Listado de contactos por entidad |
| `formularioContacto` | ContactoController | Crear/editar contacto |
| `listarVoluntarios` | UsuarioController | Listado de voluntarios |
| `gestionVoluntarios` | AsignacionController | Asignaciones de un voluntario |
| `editarAsignacionVoluntario` | AsignacionController | Crear/editar asignación a turno |
| `gestionCoordinadorCapitan` | UsuarioController | Listado de coordinadores y capitanes |
| `editarCrearUsuario` | UsuarioController | Crear/editar usuario |

## CSS (7 archivos)

| Archivo | Propósito |
|---------|-----------|
| `style_bancosol.css` | Punto de entrada: importa los demás |
| `variables.css` | Reset global, custom properties (`--blue-bancosol`, `--blue-dark`, etc.), body base |
| `header.css` | Estilos del encabezado (`main-header`, `logo-area`) |
| `footer.css` | Estilos del pie de página |
| `login.css` | Página de login (`login-box`, `login-page`) |
| `welcome.css` | Menú principal (`welcome-box`, `menu-btn`, `boton-logout`) |
| `gestion.css` | Páginas de gestión: tablas, formularios, botones, modal, campañas, historial, sin permisos |

## Base de datos

Conexión mediante variables de entorno en `.env`:

```
DB_URL=jdbc:postgresql://<host>:5432/postgres
DB_USERNAME=<usuario>
DB_PASSWORD=<contraseña>
```

Configuración (application.properties):
- `spring.jpa.hibernate.ddl-auto=validate` — valúa el esquema contra entidades
- `spring.jpa.show-sql=true` — log de SQL en desarrollo

Scripts SQL en `scriptsBaseDatos/`:

| Script | Contenido |
|--------|-----------|
| `estructuraDatos.sql` | DDL completo (10 tablas, FKs) |
| `script_reset_limpio.txt` | Borrado seguro de datos + reinicio secuencias |
| `rol_rows.sql` | 6 roles |
| `cadena_rows.sql` | 6 cadenas (Mercadona, Carrefour, Dia, etc.) |
| `campanya_rows.sql` | 3 campañas (GR 2025, GR 2026, primavera 2026) |
| `campanya_cadena_rows.sql` | 8 relaciones M:N campaña-cadena |
| `direccion_rows.sql` | 5 direcciones (Málaga, Costa del Sol, Ronda) |
| `tienda_rows.sql` | 6 tiendas |
| `entidad_colaboradora_rows.sql` | 7 entidades (colegios, asociaciones, empresas) |
| `contacto_rows.sql` | 7 contactos |
| `usuario_rows.sql` | 9 usuarios (admin, coordinadores, capitán, voluntario, etc.) |
| `plantilla_turno_rows.sql` | 6 plantillas de turno |
| `tienda_campanya_rows.sql` | 8 relaciones tienda-campaña con responsables |
| `turno_activo_rows.sql` | 12 turnos activos |
| `asignacion_voluntario_rows.sql` | 8 asignaciones voluntario-turno |

## Ejecución

```bash
# Requisitos: Java 17+ y Maven
mvn spring-boot:run
```

La aplicación arranca en `http://localhost:8080`.

### Credenciales de prueba (según datos semilla)

| Usuario | Contraseña | Rol |
|---------|-----------|-----|
| admin | (según `usuario_rows.sql`) | Administrador |
| (otros) | (según `usuario_rows.sql`) | Coordinador, Capitán, Voluntario, etc. |

## Autores

- Sergio Aldana González
- Lucas Díaz Ruiz
- Marina Ruiz Sierras
- Daniela Marcela Calderón Flórez
- Laia Jing Díaz García

---

> Proyecto académico para la asignatura TSAW (Tecnología de Servidor para Aplicaciones Web) — Universidad de Málaga.
