# Proyecto Bancosol

Sistema de gestión para el banco de alimentos **Bancosol**, desarrollado como proyecto de la asignatura **Tecnología de Servidor para Aplicaciones Web**.

## Tecnologías

- **Backend:** Java 17, Spring Boot 4.0.5, Spring MVC, Spring Data JPA
- **Frontend:** JSP, CSS, JavaScript
- **Base de datos:** PostgreSQL (Supabase)
- **Base de datos local:** H2 (para desarrollo)
- **Construcción:** Maven
- **Entorno:** `.env` con `dotenv-java`

## Arquitectura

El proyecto sigue una arquitectura en capas:

```
Controller → Service → Mapper → DTO → Repository → Entity → BD
                    ↓
                  JSP (Vista)
```

- **Entity** → Modelo JPA que mapea las tablas de la BD
- **Repository** → Acceso a datos (Spring Data JPA)
- **DTO** → Objetos de transferencia con datos formateados para la vista
- **Mapper** → Conversión Entity → DTO
- **Service** → Lógica de negocio y coordinación
- **Controller** → Manejo de peticiones HTTP y carga del modelo
- **JSP** → Vistas con JSTL y scriplets

## Base de datos

La conexión se configura mediante variables de entorno definidas en `.env`:

```
DB_URL=jdbc:postgresql://<host>:5432/postgres
DB_USERNAME=<usuario>
DB_PASSWORD=<contraseña>
```

Los scripts SQL de inicialización se encuentran en `scriptsBaseDatos/`:

| Script | Contenido |
|--------|-----------|
| `estructuraDatos.sql` | DDL completo con tablas, claves y restricciones |
| `script_reset_limpio.txt` | Borrado seguro de datos + reinicio de secuencias |
| `*_rows.sql` (13 archivos) | Datos de prueba para cada tabla |

## Ejecución

```bash
# Requisitos: Java 17+ y Maven
mvn spring-boot:run
```

La aplicación arranca en `http://localhost:8080`.

## Estructura del proyecto

```
src/main/java/es/uma/tsaw/proyectobancosol/
├── controller/         # Controladores MVC (8)
├── dao/                # Repositorios JPA (13)
├── dto/                # Objetos de transferencia (12)
├── entity/             # Entidades JPA (14)
├── mapper/             # Conversores Entity→DTO (10)
├── service/            # Lógica de negocio (8)
└── ProyectoBancosolApplication.java

src/main/webapp/WEB-INF/view/   # Vistas JSP (15)
src/main/resources/
├── application.properties
└── static/
    ├── css/            # Hojas de estilo (7)
    └── images/         # Logotipos (2)

scriptsBaseDatos/       # Scripts SQL (15)
```

## Funcionalidades

| Ruta | Vista | Descripción |
|------|-------|-------------|
| `/` | `login.jsp` | Inicio de sesión |
| `/menu` | `menu.jsp` | Menú principal |
| `/campanas` | `gestionCampanas.jsp` | Gestión de campañas y cadenas |
| `/entidades` | `gestionColaboradores.jsp` | Entidades colaboradoras |
| `/entidades/{id}/contactos` | `formularioContactos.jsp` | Contactos por entidad |
| `/tiendas` | `gestionTienda.jsp` | Gestión de tiendas |
| `/usuarios/coordinadores-capitanes` | `gestionCoordinadorCapitan.jsp` | Coordinadores y capitanes |
| `/usuarios/voluntarios` | `listarVoluntarios.jsp` | Listado de voluntarios |
| `/voluntarios/listar` | `gestionVoluntarios.jsp` | Asignaciones por voluntario |

## Entidades principales

- **Usuario** (roles: Administrador, Coordinador, Capitán, Voluntario, Entidad, CoordinadorCapitán)
- **Campanya** (Gran Recogida / Operación Primavera)
- **Cadena** (supermercados colaboradores)
- **Tienda** (establecimientos asociados a cadenas)
- **EntidadColaboradora** (organizaciones que participan)
- **TurnoActivo** / **PlantillaTurno** (turnos y plantillas)
- **AsignacionVoluntario** (voluntarios asignados a turnos)

## Autores

- Sergio Aldana González
- Lucas Díaz Ruiz
- Marina Ruiz Sierras
- Daniela Marcela Calderón Flórez
- Laia Jing Díaz García

---

> Proyecto académico para la asignatura TSAW (Tecnología de Servidor para Aplicaciones Web) — Universidad de Málaga.
