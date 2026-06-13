# Autoría del Proyecto Bancosol

Comentaciones de autoría para cada fichero del proyecto, siguiendo el formato especificado por el profesor.

---

## Miembros del equipo

| Nombre | Email |
|--------|-------|
| Lucas Díaz Ruiz | anestardiaz@gmail.com |
| Sergio Aldana | sergioaldanagonzalez@gmail.com |
| Marina Ruiz | mariinaruiizuni@gmail.com |
| Laia Díaz | laiadiaz@uma.es |
| Daniela Calderón | daniela.calderon@uma.es |

---

## Clases Java

### Capa de aplicación

#### `ProyectoBancosolApplication.java`
```java
/**
 * Clase principal de arranque de la aplicación Spring Boot.
 * Carga variables de entorno desde .env antes de iniciar el contexto de Spring.
 *
 * Autores:
 * - Lucas Díaz Ruiz: 100%
 */
```

---

### Controladores (`controller/`)

#### `AutenticaController.java`
```java
/**
 * Controlador que gestiona la autenticación de usuarioEntities (login/logout).
 *
 * Autores:
 * - Sergio Aldana: 100%
 */
```

#### `CampaniaControlador.java`
```java
/**
 * Controlador que gestiona las campañas de recogida.
 * Permite listar, crear, editar y eliminar campañas.
 *
 * Autores:
 * - Marina Ruiz: 100%
 */
```

#### `ContactoController.java`
```java
/**
 * Controlador que gestiona los contactos asociados a entidades colaboradoras.
 *
 * Autores:
 * - Daniela Calderón: 100%
 */
```

#### `EntidadColaboradoraController.java`
```java
/**
 * Controlador que gestiona las entidades colaboradoras.
 * Permite listar, crear, editar y eliminar entidades.
 *
 * Autores:
 * - Daniela Calderón: 100%
 */
```

#### `TiendaCampanyaController.java`
```java
/**
 * Controlador que gestiona la relación entre tiendaEntities y campañas.
 *
 * Autores:
 * - Sergio Aldana: 96%
 * - Lucas Díaz Ruiz: 4%
 */
```

#### `TiendaController.java`
```java
/**
 * Controlador que gestiona las tiendaEntities.
 * Permite listar, crear, editar y eliminar tiendaEntities.
 *
 * Autores:
 * - Sergio Aldana: 68%
 * - Laia Díaz: 32%
 */
```

#### `AsignacionController.java`
```java
/**
 * Controlador que gestiona la asignación de voluntarios a turnos.
 * Permite listar, crear, editar y eliminar asignaciones.
 *
 * Autores:
 * - Laia Díaz: 95%
 * - Sergio Aldana: 5%
 */
```

#### `UsuarioController.java`
```java
/**
 * Controlador que gestiona los usuarioEntities del sistema (voluntarios, coordinadores, capitanes, administradores).
 * Proporciona listado, creación, edición y eliminación de usuarioEntities.
 *
 * Autores:
 * - Lucas Díaz Ruiz: 90%
 * - Laia Díaz: 10%
 */
```

---

### Servicios (`service/`)

#### `AsignacionVoluntarioService.java`
```java
/**
 * Servicio que implementa la lógica de negocio para las asignaciones de voluntarios a turnos.
 *
 * Autores:
 * - Laia Díaz: 100%
 */
```

#### `CadenaService.java`
```java
/**
 * Servicio que implementa la lógica de negocio para las cadenaEntities de tiendaEntities.
 *
 * Autores:
 * - Sergio Aldana: 100%
 */
```

#### `CampanyaService.java`
```java
/**
 * Servicio que implementa la lógica de negocio para las campañas de recogida.
 *
 * Autores:
 * - Marina Ruiz: 100%
 */
```

#### `ContactoService.java`
```java
/**
 * Servicio que implementa la lógica de negocio para los contactos de entidades colaboradoras.
 *
 * Autores:
 * - Daniela Calderón: 100%
 */
```

#### `DireccionService.java`
```java
/**
 * Servicio que implementa la lógica de negocio para las direcciones.
 *
 * Autores:
 * - Sergio Aldana: 67%
 * - Daniela Calderón: 33%
 */
```

#### `EntidadColaboradoraService.java`
```java
/**
 * Servicio que implementa la lógica de negocio para las entidades colaboradoras.
 *
 * Autores:
 * - Daniela Calderón: 100%
 */
```

#### `TiendaService.java`
```java
/**
 * Servicio que implementa la lógica de negocio para las tiendaEntities.
 *
 * Autores:
 * - Sergio Aldana: 100%
 */
```

#### `UsuarioService.java`
```java
/**
 * Servicio que implementa la lógica de negocio para los usuarioEntities.
 * Gestiona autenticación, registro y operaciones CRUD.
 *
 * Autores:
 * - IA Generativa: 50%
 * - Lucas Díaz Ruiz: 50%
 */
```

---

### Repositorios (`dao/`)

#### `AsignacionVoluntarioRepositorio.java`
```java
/**
 * Repositorio JPA para la entidad AsignacionVoluntario.
 *
 * Autores:
 * - Marina Ruiz: 50%
 * - Daniela Calderón: 29%
 * - Lucas Díaz Ruiz: 21%
 */
```

#### `CadenaRepositorio.java`
```java
/**
 * Repositorio JPA para la entidad Cadena.
 *
 * Autores:
 * - Daniela Calderón: 100%
 */
```

#### `CampanyaRepositorio.java`
```java
/**
 * Repositorio JPA para la entidad Campanya.
 *
 * Autores:
 * - Marina Ruiz: 73%
 * - Daniela Calderón: 27%
 */
```

#### `CampanyaCadenaRepositorio.java`
```java
/**
 * Repositorio JPA para la entidad CampanyaCadena.
 *
 * Autores:
 * - Lucas Díaz Ruiz: 100%
 */
```

#### `ContactoRepositorio.java`
```java
/**
 * Repositorio JPA para la entidad Contacto.
 *
 * Autores:
 * - Daniela Calderón: 100%
 */
```

#### `DireccionRepositorio.java`
```java
/**
 * Repositorio JPA para la entidad Direccion.
 *
 * Autores:
 * - Daniela Calderón: 100%
 */
```

#### `EntidadColaboradoraRepositorio.java`
```java
/**
 * Repositorio JPA para la entidad EntidadColaboradora.
 *
 * Autores:
 * - Daniela Calderón: 100%
 */
```

#### `PlantillaTurnoRepositorio.java`
```java
/**
 * Repositorio JPA para la entidad PlantillaTurno.
 *
 * Autores:
 * - Daniela Calderón: 100%
 */
```

#### `RolRepositorio.java`
```java
/**
 * Repositorio JPA para la entidad Rol.
 *
 * Autores:
 * - Daniela Calderón: 100%
 */
```

#### `TiendaRepositorio.java`
```java
/**
 * Repositorio JPA para la entidad Tienda.
 *
 * Autores:
 * - Sergio Aldana: 100%
 */
```

#### `TiendaCampanyaRepositorio.java`
```java
/**
 * Repositorio JPA para la entidad TiendaCampanya.
 *
 * Autores:
 * - Laia Díaz: 50%
 * - Daniela Calderón: 33%
 * - Lucas Díaz Ruiz: 17%
 */
```

#### `TurnoActivoRepositorio.java`
```java
/**
 * Repositorio JPA para la entidad TurnoActivo.
 *
 * Autores:
 * - Laia Díaz: 56%
 * - Daniela Calderón: 44%
 */
```

#### `UsuarioRepositorio.java`
```java
/**
 * Repositorio JPA para la entidad Usuario.
 *
 * Autores:
 * - Lucas Díaz Ruiz: 33%
 * - Sergio Aldana: 33%
 * - Laia Díaz: 33%
 */
```

---

### Entidades (`entity/`)

#### `AsignacionVoluntario.java`
```java
/**
 * Entidad JPA que representa la asignación de un voluntario a un turno activo.
 *
 * Autores:
 * - Sergio Aldana: 96%
 * - Lucas Díaz Ruiz: 4%
 */
```

#### `Cadena.java`
```java
/**
 * Entidad JPA que representa una cadenaEntity de tiendaEntities.
 *
 * Autores:
 * - Lucas Díaz Ruiz: 95%
 * - Sergio Aldana: 5%
 */
```

#### `Campanya.java`
```java
/**
 * Entidad JPA que representa una campaña de recogida de alimentos.
 *
 * Autores:
 * - Lucas Díaz Ruiz: 80%
 * - Sergio Aldana: 14%
 * - Marina Ruiz: 6%
 */
```

#### `CampanyaCadena.java`
```java
/**
 * Entidad JPA que representa la relación entre una campaña y una cadenaEntity.
 *
 * Autores:
 * - Lucas Díaz Ruiz: 100%
 */
```

#### `CampanyaCadenaId.java`
```java
/**
 * Clase que representa la clave compuesta (embeddable) para la entidad CampanyaCadena.
 *
 * Autores:
 * - Lucas Díaz Ruiz: 100%
 */
```

#### `Contacto.java`
```java
/**
 * Entidad JPA que representa un contactoEntity de una entidad colaboradora.
 *
 * Autores:
 * - Daniela Calderón: 100%
 */
```

#### `Direccion.java`
```java
/**
 * Entidad JPA que representa una dirección postal.
 *
 * Autores:
 * - Lucas Díaz Ruiz: 81%
 * - Daniela Calderón: 14%
 * - Sergio Aldana: 5%
 */
```

#### `EntidadColaboradora.java`
```java
/**
 * Entidad JPA que representa una entidad colaboradora de Bancosol.
 *
 * Autores:
 * - Lucas Díaz Ruiz: 51%
 * - Daniela Calderón: 47%
 * - Sergio Aldana: 2%
 */
```

#### `PlantillaTurno.java`
```java
/**
 * Entidad JPA que representa una plantilla de turno.
 *
 * Autores:
 * - Sergio Aldana: 95%
 * - Lucas Díaz Ruiz: 5%
 */
```

#### `Rol.java`
```java
/**
 * Entidad JPA que representa un rolEntity de usuarioEntity dentro del sistema.
 *
 * Autores:
 * - IA Generativa: 100%
 */
```

#### `Tienda.java`
```java
/**
 * Entidad JPA que representa una tiendaEntity.
 *
 * Autores:
 * - Sergio Aldana: 52%
 * - Lucas Díaz Ruiz: 48%
 */
```

#### `TiendaCampanya.java`
```java
/**
 * Entidad JPA que representa la relación entre una tiendaEntity y una campaña.
 *
 * Autores:
 * - Sergio Aldana: 100%
 */
```

#### `TurnoActivo.java`
```java
/**
 * Entidad JPA que representa un turno activo.
 *
 * Autores:
 * - Sergio Aldana: 97%
 * - Lucas Díaz Ruiz: 3%
 */
```

#### `Usuario.java`
```java
/**
 * Entidad JPA que representa un usuarioEntity del sistema.
 *
 * Autores:
 * - IA Generativa: 90%
 * - Lucas Díaz Ruiz: 10%
 */
```

---

### DTOs (`dto/`)

#### `AsignacionVoluntarioDTO.java`
```java
/**
 * DTO que transfiere los datos de una asignación de voluntario.
 *
 * Autores:
 * - Laia Díaz: 80%
 * - Lucas Díaz Ruiz: 20%
 */
```

#### `CadenaDTO.java`
```java
/**
 * DTO que transfiere los datos de una cadenaEntity de tiendaEntities.
 *
 * Autores:
 * - Lucas Díaz Ruiz: 100%
 */
```

#### `CampanyaDTO.java`
```java
/**
 * DTO que transfiere los datos de una campaña.
 *
 * Autores:
 * - Lucas Díaz Ruiz: 100%
 */
```

#### `ContactoDTO.java`
```java
/**
 * DTO que transfiere los datos de un contactoEntity.
 *
 * Autores:
 * - Daniela Calderón: 100%
 */
```

#### `DireccionDTO.java`
```java
/**
 * DTO que transfiere los datos de una dirección.
 *
 * Autores:
 * - Lucas Díaz Ruiz: 100%
 */
```

#### `EntidadColaboradoraDTO.java`
```java
/**
 * DTO que transfiere los datos de una entidad colaboradora.
 *
 * Autores:
 * - Lucas Díaz Ruiz: 71%
 * - Daniela Calderón: 29%
 */
```

#### `PlantillaTurnoDTO.java`
```java
/**
 * DTO que transfiere los datos de una plantilla de turno.
 *
 * Autores:
 * - Lucas Díaz Ruiz: 100%
 */
```

#### `RolDTO.java`
```java
/**
 * DTO que transfiere los datos de un rolEntity.
 *
 * Autores:
 * - IA Generativa: 100%
 */
```

#### `TiendaCampanyaDTO.java`
```java
/**
 * DTO que transfiere los datos de la relación tiendaEntity-campaña.
 *
 * Autores:
 * - Lucas Díaz Ruiz: 100%
 */
```

#### `TiendaDTO.java`
```java
/**
 * DTO que transfiere los datos de una tiendaEntity.
 *
 * Autores:
 * - Lucas Díaz Ruiz: 100%
 */
```

#### `TurnoActivoDTO.java`
```java
/**
 * DTO que transfiere los datos de un turno activo.
 *
 * Autores:
 * - Lucas Díaz Ruiz: 100%
 */
```

#### `UsuarioDTO.java`
```java
/**
 * DTO que transfiere los datos de un usuarioEntity.
 *
 * Autores:
 * - IA Generativa: 90%
 * - Lucas Díaz Ruiz: 10%
 */
```

---

### Mapeadores (`mapper/`)

#### `AsignacionVoluntarioMapper.java`
```java
/**
 * Mapper que convierte entre entidad AsignacionVoluntario y su DTO.
 *
 * Autores:
 * - Laia Díaz: 100%
 */
```

#### `CadenaMapper.java`
```java
/**
 * Mapper que convierte entre entidad Cadena y su DTO.
 *
 * Autores:
 * - Sergio Aldana: 100%
 */
```

#### `CampanyaMapper.java`
```java
/**
 * Mapper que convierte entre entidad Campanya y su DTO.
 *
 * Autores:
 * - Marina Ruiz: 100%
 */
```

#### `ContactoMapper.java`
```java
/**
 * Mapper que convierte entre entidad Contacto y su DTO.
 *
 * Autores:
 * - Daniela Calderón: 100%
 */
```

#### `DireccionMapper.java`
```java
/**
 * Mapper que convierte entre entidad Direccion y su DTO.
 *
 * Autores:
 * - Sergio Aldana: 100%
 */
```

#### `EntidadColaboradoraMapper.java`
```java
/**
 * Mapper que convierte entre entidad EntidadColaboradora y su DTO.
 *
 * Autores:
 * - Daniela Calderón: 100%
 */
```

#### `MapperDTO.java`
```java
/**
 * Clase abstracta base para todos los mapeadores DTO-Entidad.
 * Proporciona el método genérico toDTOList() basado en Streams.
 * Basado en proyectos de clase del profesor.
 *
 * Autores:
 * - Proyectos de clase del profesor: 100%
 */
```

#### `RolMapper.java`
```java
/**
 * Mapper que convierte entre entidad Rol y su DTO.
 *
 * Autores:
 * - Lucas Díaz Ruiz: 100%
 */
```

#### `TiendaMapper.java`
```java
/**
 * Mapper que convierte entre entidad Tienda y su DTO.
 *
 * Autores:
 * - Sergio Aldana: 100%
 */
```

#### `UsuarioMapper.java`
```java
/**
 * Mapper que convierte entre entidad Usuario y su DTO.
 *
 * Autores:
 * - Lucas Díaz Ruiz: 100%
 */
```

---

## Páginas JSP

### `login.jsp`
```jsp
<%--
Página JSP que muestra el formulario de inicio de sesión.

Autores:
- Sergio Aldana: 100%

--%>
```

### `menu.jsp`
```jsp
<%--
Página JSP que muestra el menú principal de la aplicación con acceso a los distintos módulos.

Autores:
- Sergio Aldana: 100%

--%>
```

### `cadena_form.jsp`
```jsp
<%--
Página JSP que muestra el formulario para crear o editar una cadenaEntity de tiendaEntities.

Autores:
- Sergio Aldana: 75%
- Marina Ruiz: 25%

--%>
```

### `contacto_form.jsp`
```jsp
<%--
Página JSP que muestra el formulario para crear o editar un contactoEntity de entidad colaboradora.

Autores:
- Sergio Aldana: 69%
- Daniela Calderón: 31%

--%>
```

### `contactos_form.jsp`
```jsp
<%--
Página JSP que muestra el listado de contactos de una entidad colaboradora.

Autores:
- Sergio Aldana: 83%
- Daniela Calderón: 17%

--%>
```

### `editarAsignacionVoluntario.jsp`
```jsp
<%--
Página JSP que permite editar o crear una asignación de voluntario a un turno.

Autores:
- Sergio Aldana: 51%
- Laia Díaz: 49%

--%>
```

### `editarCrearUsuario.jsp`
```jsp
<%--
Página JSP que permite crear o editar un usuarioEntity del sistema.

Autores:
- Lucas Díaz Ruiz: 80%
- Sergio Aldana: 10%
- IA Generativa: 10%

--%>
```

### `formularioEntidadColaboradora.jsp`
```jsp
<%--
Página JSP que muestra el formulario para crear o editar una entidad colaboradora.

Autores:
- Sergio Aldana: 74%
- Daniela Calderón: 26%

--%>
```

### `formularioTienda.jsp`
```jsp
<%--
Página JSP que muestra el formulario para crear o editar una tiendaEntity.

Autores:
- Sergio Aldana: 100%

--%>
```

### `gestionCampanas.jsp`
```jsp
<%--
Página JSP que muestra la gestión de campañas de recogida.

Autores:
- Marina Ruiz: 51%
- Sergio Aldana: 49%

--%>
```

### `gestionColaboradores.jsp`
```jsp
<%--
Página JSP que muestra la gestión de entidades colaboradoras.

Autores:
- Sergio Aldana: 84%
- Marina Ruiz: 9%
- Daniela Calderón: 7%

--%>
```

### `gestionCoordinadorCapitan.jsp`
```jsp
<%--
Página JSP que muestra la gestión de coordinadores y capitanes.

Autores:
- Lucas Díaz Ruiz: 90%
- Sergio Aldana: 10%

--%>
```

### `gestionTienda.jsp`
```jsp
<%--
Página JSP que muestra la gestión de tiendaEntities.

Autores:
- Sergio Aldana: 93%
- Laia Díaz: 7%

--%>
```

### `gestionVoluntarios.jsp`
```jsp
<%--
Página JSP que muestra la gestión de voluntarios.

Autores:
- Sergio Aldana: 79%
- Laia Díaz: 21%

--%>
```

### `lista_voluntarios.jsp`
```jsp
<%--
Página JSP que muestra el listado de voluntarios disponibles.

Autores:
- Sergio Aldana: 100%

--%>
```
