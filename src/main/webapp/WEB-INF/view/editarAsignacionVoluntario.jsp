<%@ page import="java.util.List" %>
<%@ page import="es.uma.tsaw.proyectobancosol.dto.AsignacionVoluntarioDTO" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.TurnoActivo" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.EntidadColaboradora" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.Tienda" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Asignacion Voluntarios Editar/Añadir</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style_bancosol.css">
</head>

<body>

<%
    Integer idUsuario = (Integer) request.getAttribute("idUsuario");
    String nombreUsuario = (String) request.getAttribute("nombreUsuario");
    AsignacionVoluntarioDTO asignacion = (AsignacionVoluntarioDTO) request.getAttribute("asignacion");
    List<TurnoActivo> turnos = (List<TurnoActivo>) request.getAttribute("turnos");
    List<EntidadColaboradora> entidades = (List<EntidadColaboradora>) request.getAttribute("entidades");

    List<Tienda> tiendas = (List<Tienda>) request.getAttribute("tiendas");
    boolean esEdicion = (asignacion != null);

    // Valores actuales para pre-selección en edición
    Integer idTiendaActual = esEdicion ? asignacion.getIdTienda() : null;
    Integer idTurnoActual   = esEdicion ? asignacion.getIdTurno() : null;
    Integer idEntidadActual = esEdicion ? asignacion.getIdEntidad() : null;
%>

<h1><%= esEdicion ? "Editar" : "Añadir" %> Asignación</h1>
<p>Voluntario: <strong><%= nombreUsuario %></strong> (ID: <%= idUsuario %>)</p>

<form action="/voluntarios/guardar" method="post">

    <input type="hidden" name="idUsuario" value="<%= idUsuario %>">
    <input type="hidden" name="id"        value="<%= esEdicion ? asignacion.getIdAsignacion() : "" %>">
    <input type="hidden" name="idTurno"   id="idTurnoHidden" value="<%= idTurnoActual != null ? idTurnoActual : "" %>">

    <!-- TIENDA -->
    <label>Tienda:</label><br>
    <select id="selectTienda" onchange="filtrarTurnos()">
        <option value="">-- Selecciona una tienda --</option>
        <%
            for (Tienda tienda : tiendas) {
                boolean sel = idTiendaActual != null && idTiendaActual.equals(tienda.getIdTienda());
                String localidadTienda = tienda.getDireccion() != null
                        ? tienda.getDireccion().getZonaGeografica() : "";
        %>
        <option value="<%= tienda.getIdTienda() %>"
                data-localidad="<%= localidadTienda %>"
                <%= sel ? "selected" : "" %>>
            <%= tienda.getNombreEstablecimiento() %>
        </option>
        <%
            }
        %>
    </select>
    <br>

    <!-- LOCALIDAD (se rellena automáticamente) -->
    <label>Localidad:</label><br>
    <input type="text" id="localidad" readonly
           value="<%= esEdicion && asignacion.getLocalidad() != null ? asignacion.getLocalidad() : "" %>">
    <br><br>

    <!-- FRANJA (turnos filtrados por tienda) -->
    <label>Franja / Turno:</label><br>
    <select id="selectTurno" onchange="actualizarTurno()" required>
        <%
            for (TurnoActivo turno : turnos) {
                String dia = "";
                String franja = "";
                if (turno.getPlantillaTurno() != null) {
                    if (turno.getPlantillaTurno().getDiaSemana() != null)    dia    = turno.getPlantillaTurno().getDiaSemana();
                    if (turno.getPlantillaTurno().getFranjaHoraria() != null) franja = turno.getPlantillaTurno().getFranjaHoraria();
                }
                String fechaTurno = turno.getFechaExacta() != null ? turno.getFechaExacta().toString() : "";
                String label = dia + " " + franja + " · " + fechaTurno;
                int idTiendaTurno = turno.getTiendaCampanya().getTienda().getIdTienda();
                boolean sel = idTurnoActual != null && idTurnoActual.equals(turno.getIdTurnoActivo());
        %>
        <option value="<%= turno.getIdTurnoActivo() %>"
                data-tienda="<%= idTiendaTurno %>"
                data-fecha="<%= fechaTurno %>"
                <%= sel ? "selected" : "" %>>
            <%= label %>
        </option>
        <%
            }
        %>
    </select>
    <br>

    <!-- FECHA (se rellena automáticamente al elegir turno) -->
    <label>Fecha:</label><br>
    <input type="text" id="fecha" readonly
           value="<%= esEdicion && asignacion.getFecha() != null ? asignacion.getFecha() : "" %>">
    <br><br>

    <!-- ASISTENCIA -->
    <label>Asistencia:</label>
    <input type="checkbox" name="asistencia" value="true"
        <%= esEdicion && Boolean.TRUE.equals(asignacion.getAsistencia()) ? "checked" : "" %>>
    <br><br>

    <!-- ENTIDAD COLABORADORA -->
    <label>Entidad Colaboradora:</label><br>
    <select name="idEntidad" id="selectEntidad" onchange="actualizarIdEntidad()">
        <option value="">-- Sin entidad --</option>
        <%
            for (EntidadColaboradora entidad : entidades) {
                boolean sel = idEntidadActual != null && idEntidadActual.equals(entidad.getIdEntidad());
        %>
        <option value="<%= entidad.getIdEntidad() %>" <%= sel ? "selected" : "" %>>
            <%= entidad.getNombreEntidad() %>
        </option>
        <%
            }
        %>
    </select>
    <br>

    <!-- ID ENTIDAD (se rellena automáticamente) -->
    <label>ID Entidad:</label><br>
    <input type="text" id="idEntidadMostrado" readonly
           value="<%= esEdicion && asignacion.getIdEntidad() != null ? asignacion.getIdEntidad() : "" %>">
    <br><br>

    <button type="submit">Guardar</button>
    <a href="/voluntarios/listar?idUsuario=<%= idUsuario %>"><button type="button">Cancelar</button></a>

</form>

<script>
    // Al cargar la página, aplicar filtros si hay selección previa
    window.onload = function() {
        filtrarTurnos();
        actualizarIdEntidad();
    };

    // Filtra los turnos según la tienda seleccionada y actualiza localidad
    function filtrarTurnos() {
        const selectTienda  = document.getElementById("selectTienda");
        const selectTurno   = document.getElementById("selectTurno");
        const inputLocalidad = document.getElementById("localidad");

        const idTiendaSel = selectTienda.value;

        // Actualizar localidad
        const optTienda = selectTienda.options[selectTienda.selectedIndex];
        inputLocalidad.value = idTiendaSel ? optTienda.dataset.localidad : "";

        // Filtrar turnos
        const opciones = selectTurno.options;
        let primerVisible = null;

        for (let i = 0; i < opciones.length; i++) {
            const opt = opciones[i];
            if (opt.value === "") continue; // opción vacía siempre visible

            const visible = !idTiendaSel || opt.dataset.tienda === idTiendaSel;
            opt.style.display = visible ? "" : "none";

            if (visible && primerVisible === null) primerVisible = opt;
        }

        // Si el turno actualmente seleccionado no pertenece a esta tienda, limpiar
        const turnoActual = selectTurno.options[selectTurno.selectedIndex];
        if (turnoActual && turnoActual.value !== "" && turnoActual.dataset.tienda !== idTiendaSel) {
            selectTurno.value = "";
            document.getElementById("fecha").value = "";
            document.getElementById("idTurnoHidden").value = "";
        } else {
            actualizarTurno();
        }
    }

    // Actualiza fecha e idTurnoHidden al elegir un turno
    function actualizarTurno() {
        const selectTurno = document.getElementById("selectTurno");
        const opt = selectTurno.options[selectTurno.selectedIndex];
        document.getElementById("fecha").value = opt && opt.value ? opt.dataset.fecha : "";
        document.getElementById("idTurnoHidden").value = opt ? opt.value : "";
    }

    // Actualiza el campo de ID entidad al elegir una entidad
    function actualizarIdEntidad() {
        const selectEntidad = document.getElementById("selectEntidad");
        const val = selectEntidad.value;
        document.getElementById("idEntidadMostrado").value = val || "";
    }
</script>

</body>
</html>
