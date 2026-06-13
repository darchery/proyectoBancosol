# COMPROBACIÓN DE FLUJO — Proyecto Bancosol

Guía paso a paso para probar **absolutamente todas las funcionalidades** del proyecto, incluyendo casos de éxito, casos de error y control de acceso por roles.

---

## Índice

1. [Preparación](#1-preparación)
2. [Autenticación](#2-autenticación)
3. [Menú principal](#3-menú-principal)
4. [Campañas](#4-campañas)
5. [Cadenas](#5-cadenas)
6. [Tiendas](#6-tiendas)
7. [Entidades Colaboradoras](#7-entidades-colaboradoras)
8. [Contactos](#8-contactos)
9. [Voluntarios y Asignaciones](#9-voluntarios-y-asignaciones)
10. [Usuarios (Coordinadores/Capitanes)](#10-usuarios-coordinadorescapitanes)
11. [Control de acceso por roles](#11-control-de-acceso-por-roles)
12. [Resumen de cobertura](#12-resumen-de-cobertura)

---

## 1. Preparación

### 1.1 Arrancar la aplicación

```bash
mvn spring-boot:run
```

La aplicación debe estar accesible en `http://localhost:8080`.

### 1.2 Credenciales de prueba

Basadas en los scripts SQL de seed (`usuario_rows.sql`, `rol_rows.sql`):

| Usuario | Rol | ID Rol |
|---------|-----|--------|
| admin | Administrador | 1 |
| (coordinador) | Coordinador | 2 |
| (capitan) | Capitán | 3 |
| (voluntario) | Voluntario | 4 |
| (entidad) | Entidad | 5 |
| (coordinador-capitan) | CoordinadorCapitán | 6 |

> **Nota:** Las contraseñas exactas dependen de los datos cargados en la BD. Consulta `scriptsBaseDatos/usuario_rows.sql`.

---

## 2. Autenticación

### 2.1 Acceder a la página de login

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | Navegar a `http://localhost:8080/` | Se muestra la página de login con formulario (usuario/contraseña) y el logo de Bancosol |

### 2.2 Inicio de sesión correcto

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | Introducir usuario `admin` y su contraseña | — |
| 2 | Hacer clic en "Iniciar sesión" | Redirige a `/menu` mostrando el menú principal |

### 2.3 Inicio de sesión incorrecto

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | Introducir usuario `admin` y contraseña `incorrecta` | — |
| 2 | Hacer clic en "Iniciar sesión" | Permanecer en `/` con mensaje de error visible |

### 2.4 Cerrar sesión

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | Estando en `/menu`, hacer clic en "Cerrar sesión" | Redirige a `/` (login) |
| 2 | Intentar navegar a `/menu` directamente | Vuelve a mostrar login (sesión inválida) |

---

## 3. Menú Principal

### 3.1 Acceder como administrador (rol 1)

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | Login como `admin` | — |
| 2 | Navegar a `/menu` | Ver todos los botones del menú: Gestión Campañas, Gestión Voluntarios, Entidades Colaboradoras, Gestión Tiendas, Coordinadores/Capitanes, Cerrar sesión |

### 3.2 Acceder como coordinador (rol 2)

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | Login como coordinador | — |
| 2 | Navegar a `/menu` | Ver solo: Gestión Voluntarios, Entidades Colaboradoras, Cerrar sesión (NO debe ver Campañas, Tiendas, ni Coordinadores/Capitanes) |

### 3.3 Acceder como coordinador-capitán (rol 6)

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | Login como coordinador-capitán | — |
| 2 | Navegar a `/menu` | Mismo menú que coordinador |

---

## 4. Campañas

### 4.1 Acceso a gestión de campañas

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | Login como `admin` | — |
| 2 | Navegar a `/menu` | — |
| 3 | Hacer clic en "Gestión Campañas" | Navegar a `/campanyas` mostrando: columna izquierda (tipo campaña + fechas), columna centro (cadenas disponibles), columna derecha (logo) y botones de acción |

### 4.2 Control de acceso (solo admin)

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | Login como coordinador (rol 2) | — |
| 2 | Navegar directamente a `/campanyas` | Redirige a `/sinPermisos` con mensaje "ACCESO DENEGADO" |

### 4.3 Generar campaña con datos seleccionados (rápida)

#### 4.3.1 Creación exitosa

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | En `/campanyas`, seleccionar tipo "Gran Recogida" | El radio button se marca |
| 2 | Introducir fecha de inicio (ej. 2028-01-15) | — |
| 3 | Introducir fecha de fin (ej. 2028-02-15) | — |
| 4 | Marcar 1 o más cadenas en la cuadrícula | Los checkboxes se marcan |
| 5 | Hacer clic en "Generar campaña con los datos seleccionados" | Redirige a `/campanyas` con mensaje verde: "Campaña 'GR 2028' generada correctamente" |

#### 4.3.2 Creación sin seleccionar tipo

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | En `/campanyas`, NO seleccionar tipo | — |
| 2 | Rellenar fechas | — |
| 3 | Hacer clic en "Generar campaña con los datos seleccionados" | El formulario no se envía (HTML5 validation evita envío si hay required vacío, o Spring devuelve 400) |

#### 4.3.3 Creación sin fechas

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | Seleccionar tipo | — |
| 2 | Dejar fechas vacías | — |
| 3 | Hacer clic en "Generar campaña con los datos seleccionados" | HTML5 validation impide el envío (campos `required`) |

#### 4.3.4 Creación duplicada (mismo nombre)

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | Seleccionar "Gran Recogida" con fecha 2026 | — |
| 2 | Hacer clic en generar | Redirige a `/campanyas` con mensaje rojo: "Ya existe una campaña llamada 'GR 2026'" (si ya existía de los datos semilla) |

### 4.4 Generar campaña desde cero (formulario completo)

#### 4.4.1 Creación exitosa

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | En `/campanyas`, hacer clic en "Generar campaña desde cero" | Navega a `/campanyas/generarCampanya` |
| 2 | Ver formulario vacío con campos: nombre, tipo, estado, fechas, cadenas | — |
| 3 | Rellenar: nombre = "primavera 2028", tipo = "primavera", estado = "ACTIVA", fechas, marcar cadenas | — |
| 4 | Hacer clic en "Guardar" | Redirige a `/campanyas` con mensaje verde |

#### 4.4.2 Edición de campaña existente desde historial

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | En `/campanyas`, hacer clic en "Ver historial" | Navega a `/campanyas/historial` |
| 2 | Ver tabla con todas las campañas (nombre, tipo, estado, fechas, acciones) | — |
| 3 | Hacer clic en "Editar" en cualquier fila | Navega a `/campanyas/generarCampanya?id=X` con el formulario pre-rellenado |
| 4 | Modificar algún campo (ej. estado a "FINALIZADA") | — |
| 5 | Hacer clic en "Guardar" | Redirige a `/campanyas` con mensaje verde: "Cambios guardados correctamente." |

#### 4.4.3 Edición desde formulario directo

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | Navegar directamente a `/campanyas/generarCampanya?id=1` | Formulario con datos de la campaña existente |
| 2 | Modificar y guardar | Mensaje verde |

#### 4.4.4 Intento de nombre duplicado

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | Crear campaña con nombre "GR 2026" (ya existe) | Mensaje rojo de error |
| 2 | Observar que el sistema rechaza el duplicado | — |

#### 4.4.5 Cancelar creación/edición

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | En formulario, hacer clic en "Cancelar" | Redirige a `/campanyas` |

### 4.5 Historial de campañas

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | En `/campanyas`, hacer clic en "Ver historial" | Navega a `/campanyas/historial` |
| 2 | Ver tabla completa con columnas: Nombre, Tipo, Estado, Fecha inicio, Fecha fin, Acciones | — |
| 3 | Verificar que cada fila tiene enlace "Editar" | — |
| 4 | Si no hay campañas, ver mensaje "No hay campañas registradas." | — |
| 5 | Hacer clic en "Volver a Gestión de Campañas" | Vuelve a `/campanyas` |

### 4.6 Borrar campaña

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | Navegar a `/campanyas/borrar?id=X` (X = ID existente) | Redirige a `/campanyas`, la campaña ya no aparece en historial |
| 2 | Navegar a `/campanyas/borrar?id=999` (ID inexistente) | Error 500 o redirección (depende del manejo de excepciones) |

---

## 5. Cadenas

### 5.1 Acceso desde gestión de campañas

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | En `/campanyas`, ver la columna central "Cadenas" | Lista de cadenas con checkboxes y botones Editar/Eliminar |

### 5.2 Crear nueva cadena

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | En `/campanyas`, hacer clic en "+ Añadir cadena" | Navega a `/cadenas/nueva` |
| 2 | Ver formulario con campos: nombre, reseña, URL logo | — |
| 3 | Rellenar: nombre = "Test Cadena", reseña = "Cadena de prueba", logo (opcional) | — |
| 4 | Hacer clic en "Guardar" | Redirige a `/campanyas`, la nueva cadena aparece en la cuadrícula con su checkbox |

### 5.3 Editar cadena existente

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | En `/campanyas`, hacer clic en "Editar" en cualquier cadena | Navega a `/cadenas/editar?id=X` con formulario pre-rellenado |
| 2 | Modificar nombre | — |
| 3 | Hacer clic en "Guardar" | Redirige a `/campanyas`, el nombre actualizado se refleja en la lista |

### 5.4 Borrar cadena

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | En `/campanyas`, hacer clic en "Eliminar" en una cadena sin campañas asociadas | Redirige a `/campanyas`, la cadena desaparece |
| 2 | Hacer clic en "Eliminar" en una cadena que sí tiene campañas asociadas (ej. Mercadona) | La cadena se elimina también (el servicio `CadenaService.borrar` elimina referencias de `cadenasParticipantes`) |

### 5.5 Control de acceso (cadenas)

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | Login como coordinador | — |
| 2 | Navegar a `/cadenas/nueva` | Redirige a `/sinPermisos` (solo admin) |

---

## 6. Tiendas

### 6.1 Listar tiendas

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | Login como `admin` | — |
| 2 | En `/menu`, hacer clic en "Gestión Tiendas" | Navega a `/tiendas` |
| 3 | Ver tabla con: ID Tienda, Cadena, Establecimiento, Dirección, Código Postal, Franquicia, Lineales, Acciones | — |
| 4 | Verificar que cada fila tiene botones "Editar" y "Borrar" | — |
| 5 | Ver botones: "Añadir Tienda" y "Volver al Menú" | — |

### 6.2 Crear nueva tienda

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | En `/tiendas`, hacer clic en "Añadir Tienda" | Navega a `/tiendas/editarCrear` |
| 2 | Rellenar: nombre establecimiento, dirección, seleccionar cadena del desplegable, CP, lineales, marcar/desmarcar franquicia | — |
| 3 | Hacer clic en "Guardar" | Redirige a `/tiendas`, la nueva tienda aparece en la tabla |

### 6.3 Editar tienda existente

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | En `/tiendas`, hacer clic en "Editar" | Navega a `/tiendas/editarCrear?id=X` |
| 2 | Modificar campos | — |
| 3 | Guardar | Redirige a `/tiendas` con datos actualizados |

### 6.4 Borrar tienda

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | En `/tiendas`, hacer clic en "Borrar" en una tienda sin dependencias | Redirige a `/tiendas`, tienda eliminada |
| 2 | En `/tiendas`, hacer clic en "Borrar" en una tienda con turnos/asignaciones asociadas | Puede fallar por FK (error 500) o eliminarse si hay cascade |

### 6.5 Control de acceso (tiendas)

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | Login como coordinador | — |
| 2 | Navegar a `/tiendas` | Redirige a `/sinPermisos` (solo admin) |

---

## 7. Entidades Colaboradoras

### 7.1 Listar entidades

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | Login como `admin` | — |
| 2 | En `/menu`, hacer clic en "Entidades Colaboradoras" | Navega a `/entidades` |
| 3 | Ver tabla con: ID, Entidad, Tipo, Domicilio, Distrito, Zona, Responsable, Contacto Principal, Teléfono, Acciones | — |
| 4 | Verificar botones: Ver Contactos, Editar, Borrar, Añadir Entidad, Volver al Menú | — |

### 7.2 Crear nueva entidad

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | En `/entidades`, hacer clic en "Añadir Entidad" | Navega a `/entidades/nueva` |
| 2 | Rellenar: nombre entidad, tipo, domicilio, distrito, zona, responsable (desplegable), ligado a Bancosol (sí/no) | — |
| 3 | Hacer clic en "Guardar" | Redirige a `/entidades`, nueva entidad visible en la tabla |

### 7.3 Editar entidad existente

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | En `/entidades`, hacer clic en "Editar" | Navega a `/entidades/editar?id=X` |
| 2 | Modificar campos | — |
| 3 | Guardar | Redirige a `/entidades` con cambios reflejados |

### 7.4 Borrar entidad

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | En `/entidades`, hacer clic en "Borrar" en una entidad sin dependencias | Redirige a `/entidades`, entidad eliminada |

### 7.5 Acceso como coordinador

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | Login como coordinador | — |
| 2 | Navegar a `/entidades` | **Sí puede ver** el listado (roles 1, 2, 6) |
| 3 | Hacer clic en "Ver Contactos" | **Sí puede ver** los contactos |
| 4 | Intentar navegar a `/entidades/nueva` | Redirige a `/sinPermisos` (solo admin) |

---

## 8. Contactos

### 8.1 Listar contactos de una entidad

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | En `/entidades`, hacer clic en "Ver Contactos" en cualquier fila | Navega a `/entidades/{id}/contactos` |
| 2 | Ver tabla con: Nombre, Email, Teléfono, Principal, Acciones (Editar, Borrar) | — |
| 3 | Ver botones: "Añadir Contacto", "Volver a Entidades" | — |

### 8.2 Crear nuevo contacto

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | En la lista de contactos, hacer clic en "Añadir Contacto" | Navega a `/entidades/{id}/contactos/nuevo` |
| 2 | Rellenar: nombre, email, teléfono, marcar "es principal" | — |
| 3 | Hacer clic en "Guardar" | Redirige a `/entidades/{id}/contactos`, el nuevo contacto aparece |

### 8.3 Editar contacto

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | En lista de contactos, hacer clic en "Editar" | Navega a `/entidades/{id}/contactos/editar?id=X` |
| 2 | Modificar datos | — |
| 3 | Guardar | Redirige a lista de contactos actualizada |

### 8.4 Borrar contacto

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | En lista de contactos, hacer clic en "Borrar" | Redirige a lista de contactos, contacto eliminado (solo admin puede borrar) |

---

## 9. Voluntarios y Asignaciones

### 9.1 Listar voluntarios

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | Login como `admin` o coordinador | — |
| 2 | En `/menu`, hacer clic en "Gestión Voluntarios" | Redirige a `/usuarios/voluntarios` |
| 3 | Ver tabla con: ID, Nombre, Email, Teléfono, Acciones ("Ver asignaciones") | — |
| 4 | Ver botón "Volver al menú" | — |

### 9.2 Ver asignaciones de un voluntario

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | En lista de voluntarios, hacer clic en "Ver asignaciones" | Navega a `/voluntarios/listar?idUsuario=X` |
| 2 | Ver tabla con: ID Asignación, Tienda, Localidad, Franja, Fecha, Asistencia, ID Entidad, Entidad Colaboradora, Editar, Borrar | — |

### 9.3 Añadir nueva asignación

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | En asignaciones del voluntario, hacer clic en "Añadir Asignación" | Navega a `/voluntarios/edit?idUsuario=X` |
| 2 | Ver formulario con: selector de turno (agrupado por tienda con formato "Tienda | Franja · Fecha"), checkbox asistencia, selector entidad colaboradora | — |
| 3 | Seleccionar un turno, marcar asistencia, seleccionar entidad | — |
| 4 | Hacer clic en "Guardar" | Redirige a `/voluntarios/listar?idUsuario=X`, nueva asignación visible en la tabla |

### 9.4 Editar asignación existente

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | En asignaciones, hacer clic en "Editar" en cualquier fila | Navega a `/voluntarios/edit?idUsuario=X&id=Y` con formulario pre-rellenado |
| 2 | Cambiar turno, modificar asistencia, cambiar entidad | — |
| 3 | Guardar | Redirige a lista de asignaciones con cambios |

### 9.5 Borrar asignación

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | En asignaciones, hacer clic en "Borrar" | Redirige a lista de asignaciones, asignación eliminada |

### 9.6 Cancelar edición/creación de asignación

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | En formulario de asignación, hacer clic en "Cancelar" | Redirige a `/voluntarios/listar?idUsuario=X` |

### 9.7 Voluntario sin asignaciones

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | Seleccionar un voluntario que no tenga asignaciones | Tabla vacía con mensaje "Voluntario sin asignaciones" |

### 9.8 Control de acceso (voluntarios)

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | Login como admin | Puede ver y gestionar asignaciones |
| 2 | Login como coordinador (rol 2) | Puede ver y gestionar asignaciones |
| 3 | Login como capitán (rol 3) | Navegar a `/voluntarios/listar` → redirige a `/sinPermisos` |
| 4 | Login como voluntario (rol 4) | Navegar a `/voluntarios/listar` → redirige a `/sinPermisos` |

---

## 10. Usuarios (Coordinadores/Capitanes)

### 10.1 Listar coordinadores y capitanes

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | Login como `admin` | — |
| 2 | En `/menu`, hacer clic en "Coordinadores/Capitanes" | Navega a `/usuarios/coordinadores-capitanes` |
| 3 | Ver tabla con: ID, Nombre, Email, Teléfono, Rol, Entidad, Área, Nº Tiendas, Acciones (Editar, Borrar) | — |
| 4 | Ver botones: "Añadir Coordinador", "Añadir Capitán", "Añadir Coordinador/Capitán", "Volver al Menú" | — |

### 10.2 Crear nuevo coordinador

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | En la lista, hacer clic en "Añadir Coordinador" | Navega a `/usuarios/editarCrear?idRol=2` |
| 2 | Rellenar: nombre, email, teléfono, contraseña | — |
| 3 | Hacer clic en "Guardar" | Redirige a `/usuarios/coordinadores-capitanes`, nuevo usuario visible |

### 10.3 Crear nuevo capitán

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | Hacer clic en "Añadir Capitán" | Navega a `/usuarios/editarCrear?idRol=3` |
| 2 | Rellenar datos | — |
| 3 | Guardar | Redirige a lista, nuevo capitán visible |

### 10.4 Crear nuevo coordinador-capitán (doble rol)

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | Hacer clic en "Añadir Coordinador/Capitán" | Navega a `/usuarios/editarCrear?idRol=6` |
| 2 | Rellenar datos | — |
| 3 | Guardar | Redirige a lista |

### 10.5 Editar usuario existente

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | En la lista, hacer clic en "Editar" | Navega a `/usuarios/editarCrear?id=X&idRol=Y` con formulario pre-rellenado |
| 2 | Modificar nombre, email, teléfono | — |
| 3 | Guardar | Redirige a lista, cambios reflejados |

### 10.6 Email duplicado al crear/editar

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | Crear usuario con email ya existente | Redirige de vuelta al formulario con mensaje de error |
| 2 | El formulario mantiene los datos introducidos (no se pierden) | — |

### 10.7 Borrar usuario

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | En la lista, hacer clic en "Borrar" en un usuario sin dependencias | Redirige a lista, usuario eliminado |
| 2 | Borrar un usuario que sea responsable de entidades o tenga asignaciones | El servicio `UsuarioService.borrar` desvincula sus relaciones antes de borrar |

### 10.8 Cancelar edición/creación de usuario

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | En formulario de usuario, hacer clic en "Cancelar" | Redirige a `/usuarios/coordinadores-capitanes` |

### 10.9 Control de acceso

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | Login como coordinador | — |
| 2 | Navegar a `/usuarios/coordinadores-capitanes` | Redirige a `/sinPermisos` (solo admin) |
| 3 | Navegar a `/usuarios/editarCrear?idRol=2` | Redirige a `/sinPermisos` |

---

## 11. Control de acceso por roles

### 11.1 Tabla completa de permisos

| Ruta | Admin (1) | Coord (2) | Capitán (3) | Voluntario (4) | Entidad (5) | CoordCap (6) |
|------|:---------:|:---------:|:-----------:|:--------------:|:-----------:|:------------:|
| `/` | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| `/menu` | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| `/sinPermisos` | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| `/campanyas*` | **✓** | ✗ | ✗ | ✗ | ✗ | ✗ |
| `/cadenas*` | **✓** | ✗ | ✗ | ✗ | ✗ | ✗ |
| `/tiendas*` | **✓** | ✗ | ✗ | ✗ | ✗ | ✗ |
| `/tiendacampanya*` | **✓** | ✗ | ✗ | ✗ | ✗ | ✗ |
| `/entidades` | ✓ | ✓ | ✗ | ✗ | ✗ | ✓ |
| `/entidades/nueva` | **✓** | ✗ | ✗ | ✗ | ✗ | ✗ |
| `/entidades/editar` | **✓** | ✗ | ✗ | ✗ | ✗ | ✗ |
| `/entidades/borrar` | **✓** | ✗ | ✗ | ✗ | ✗ | ✗ |
| `/entidades/{id}/contactos` | ✓ | ✓ | ✗ | ✗ | ✗ | ✓ |
| `/entidades/{id}/contactos/nuevo` | ✓ | ✓ | ✗ | ✗ | ✗ | ✓ |
| `/entidades/{id}/contactos/editar` | ✓ | ✓ | ✗ | ✗ | ✗ | ✓ |
| `/entidades/{id}/contactos/guardar` | ✓ | ✓ | ✗ | ✗ | ✗ | ✓ |
| `/entidades/{id}/contactos/borrar` | **✓** | ✗ | ✗ | ✗ | ✗ | ✗ |
| `/usuarios/voluntarios` | ✓ | ✓ | ✗ | ✗ | ✗ | ✓ |
| `/voluntarios/*` | ✓ | ✓ | ✗ | ✗ | ✗ | ✓ |
| `/usuarios/coordinadores-capitanes*` | **✓** | ✗ | ✗ | ✗ | ✗ | ✗ |

### 11.2 Probar acceso denegado con cada rol

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | Login como **capitán** | — |
| 2 | Navegar a cada ruta protegida | Debe obtener `/sinPermisos` en todas excepto `/`, `/menu`, `/salir` |
| 3 | Login como **voluntario** | — |
| 4 | Navegar a cada ruta protegida | Debe obtener `/sinPermisos` en todas excepto `/`, `/menu`, `/salir` |
| 5 | Login como **entidad** | — |
| 6 | Navegar a cada ruta protegida | Debe obtener `/sinPermisos` en todas excepto `/`, `/menu`, `/salir` |

### 11.3 Probar páginas de acceso denegado

| Paso | Acción | Resultado esperado |
|------|--------|--------------------|
| 1 | Login como voluntario | — |
| 2 | Navegar a `/campanyas` | Muestra `/sinPermisos` con título "ACCESO DENEGADO" en azul, botón para iniciar sesión y botón para volver al menú |
| 3 | Hacer clic en "Volver al Menú" | Navega a `/menu` |
| 4 | Hacer clic en "Iniciar sesión con otra cuenta" | Navega a `/` (login) |

---

## 12. Resumen de cobertura

### Funcionalidades cubiertas

| Funcionalidad | Éxito | Error | Acceso |
|:---|---:|:---:|:---:|
| Login | ✓ | ✓ | ✓ |
| Logout | ✓ | — | ✓ |
| Menú por roles | ✓ | — | ✓ |
| Campañas: crear rápida | ✓ | ✓ | ✓ |
| Campañas: crear desde formulario | ✓ | ✓ | ✓ |
| Campañas: editar | ✓ | ✓ | ✓ |
| Campañas: historial | ✓ | — | ✓ |
| Campañas: borrar | ✓ | — | ✓ |
| Cadenas: crear | ✓ | — | ✓ |
| Cadenas: editar | ✓ | — | ✓ |
| Cadenas: borrar | ✓ | — | ✓ |
| Tiendas: listar | ✓ | — | ✓ |
| Tiendas: crear | ✓ | — | ✓ |
| Tiendas: editar | ✓ | — | ✓ |
| Tiendas: borrar | ✓ | — | ✓ |
| Entidades: listar | ✓ | — | ✓ |
| Entidades: crear | ✓ | — | ✓ |
| Entidades: editar | ✓ | — | ✓ |
| Entidades: borrar | ✓ | — | ✓ |
| Contactos: listar | ✓ | — | ✓ |
| Contactos: crear | ✓ | — | ✓ |
| Contactos: editar | ✓ | — | ✓ |
| Contactos: borrar | ✓ | — | ✓ |
| Voluntarios: listar | ✓ | — | ✓ |
| Asignaciones: listar | ✓ | — | ✓ |
| Asignaciones: crear | ✓ | — | ✓ |
| Asignaciones: editar | ✓ | — | ✓ |
| Asignaciones: borrar | ✓ | — | ✓ |
| Usuarios (coords/caps): listar | ✓ | — | ✓ |
| Usuarios: crear | ✓ | ✓ | ✓ |
| Usuarios: editar | ✓ | ✓ | ✓ |
| Usuarios: borrar | ✓ | — | ✓ |
| Sin permisos | ✓ | — | ✓ |

### Totales

- **Casos de éxito:** 32
- **Casos de error:** 6
- **Casos de control de acceso:** 12
- **Total de comprobaciones:** ~50
