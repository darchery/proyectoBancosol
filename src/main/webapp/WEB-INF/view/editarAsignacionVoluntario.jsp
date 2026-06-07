<%@ page import="java.util.List" %>
<%@ page import="es.uma.tsaw.proyectobancosol.dto.AsignacionVoluntarioDTO" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.TurnoActivo" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.EntidadColaboradora" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.Tienda" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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

<html>
<head>
    <title>Asignacion Voluntarios Editar/Añadir</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style_bancosol.css">
</head>

<body>
    <header class="main-header">
        <div class="logo-area">
            <img src="${pageContext.request.contextPath}/images/LOGO_BANCOSOL_FOOTER.png" alt="Bancosol Logo">
            <div>
                <h1><%= esEdicion ? "EDITAR" : "AÑADIR" %> ASIGNACIÓN</h1>
            </div>
        </div>
    </header>

    <main class="container">
        <div class="form-container">

<p>Voluntario: <strong><%= nombreUsuario %></strong> (ID: <%= idUsuario %>)</p>

<form action="/voluntarios/guardar" method="post">

    <input type="hidden" name="idUsuario" value="<%= idUsuario %>">
    <input type="hidden" name="id"        value="<%= esEdicion ? asignacion.getIdAsignacion() : "" %>">
    <input type="hidden" name="idTurno"   id="idTurnoHidden" value="<%= idTurnoActual != null ? idTurnoActual : "" %>">

    <!-- TIENDA -->
    <div class="form-group">
        <label>Tienda:</label>
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
    </div>

    <!-- LOCALIDAD (se rellena automáticamente) -->
    <div class="form-group">
        <label>Localidad:</label>
        <input type="text" id="localidad" readonly
               value="<%= esEdicion && asignacion.getLocalidad() != null ? asignacion.getLocalidad() : "" %>">
    </div>

    <!-- FRANJA (turnos filtrados por tienda) -->
    <div class="form-group">
        <label>Franja / Turno:</label>
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
    </div>

    <!-- FECHA (se rellena automáticamente al elegir turno) -->
    <div class="form-group">
        <label>Fecha:</label>
        <input type="text" id="fecha" readonly
               value="<%= esEdicion && asignacion.getFecha() != null ? asignacion.getFecha() : "" %>">
    </div>

    <!-- ASISTENCIA -->
    <div class="form-group">
        <label>
            <input type="checkbox" name="asistencia" value="true"
                <%= esEdicion && Boolean.TRUE.equals(asignacion.getAsistencia()) ? "checked" : "" %>>
            Asistencia
        </label>
    </div>

    <!-- ENTIDAD COLABORADORA -->
    <div class="form-group">
        <label>Entidad Colaboradora:</label>
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
    </div>

    <!-- ID ENTIDAD (se rellena automáticamente) -->
    <div class="form-group">
        <label>ID Entidad:</label>
        <input type="text" id="idEntidadMostrado" readonly
               value="<%= esEdicion && asignacion.getIdEntidad() != null ? asignacion.getIdEntidad() : "" %>">
    </div>

    <div class="actions-row">
        <button type="submit" class="btn btn-primary">Guardar</button>
        <a href="/voluntarios/listar?idUsuario=<%= idUsuario %>" class="btn btn-secondary">Cancelar</a>
    </div>

</form>

        </div>
    </main>

    <footer>
        <p>&copy; 2026 Bancosol | Grupo 4</p>
    </footer>

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