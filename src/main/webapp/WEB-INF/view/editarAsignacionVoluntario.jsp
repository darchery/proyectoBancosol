<%--
Página JSP que permite editar o crear una asignación de voluntario a un turno.

Autores:
    - Sergio Aldana: 25%
    - Laia Díaz: 75%
--%>

<%@ page import="java.util.List" %>
<%@ page import="es.uma.tsaw.proyectobancosol.dto.AsignacionVoluntarioDTO" %>
<%@ page import="es.uma.tsaw.proyectobancosol.dto.TiendaDTO" %>
<%@ page import="es.uma.tsaw.proyectobancosol.dto.EntidadColaboradoraDTO" %>
<%@ page import="es.uma.tsaw.proyectobancosol.dto.TurnoActivoDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Integer idUsuario = (Integer) request.getAttribute("idUsuario");
    AsignacionVoluntarioDTO asignacion = (AsignacionVoluntarioDTO) request.getAttribute("asignacion");
    List<TurnoActivoDTO> turnos = (List<TurnoActivoDTO>) request.getAttribute("turnos");
    List<EntidadColaboradoraDTO> entidades = (List<EntidadColaboradoraDTO>) request.getAttribute("entidades");

    List<TiendaDTO> tiendas = (List<TiendaDTO>) request.getAttribute("tiendas");

    // Valores actuales para pre-selección en edición
    boolean esEdicion = (asignacion != null);
    Integer idTurnoActual   = esEdicion ? asignacion.getIdTurno() : null;
    Integer idEntidadActual = esEdicion ? asignacion.getIdEntidad() : null;

    java.util.Map<Integer, String> tiendaMap = new java.util.HashMap<>();
    if (tiendas != null) {
        for (TiendaDTO t : tiendas) {
            tiendaMap.put(t.getIdTienda(), t.getNombreEstablecimiento());
        }
    }
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

            <form action="/voluntarios/guardar" method="post">

                <input  type="hidden"
                        name="idUsuario"
                        value="<%= idUsuario %>">

                <input  type="hidden"
                        name="id"
                        value="<%= esEdicion ? asignacion.getIdAsignacion() : "" %>">

                <div class="form-group">

                    <label>Franja / Turno:</label>

                    <select name="idTurno" required>
                        <option value="">Seleccione un turno</option>
                        <%
                            for (TurnoActivoDTO turno : turnos) {
                                String tiendaName = tiendaMap.get(turno.getIdTienda());
                                if (tiendaName == null) tiendaName = "Otras ubicaciones";

                                String diaFranja = turno.getDiaFranja();
                                String fechaTurno = turno.getFecha() != null ? turno.getFecha() : "";
                        %>
                        <option value="<%= turno.getIdTurnoActivo() %>"
                                <%= ( idTurnoActual != null && idTurnoActual.equals(turno.getIdTurnoActivo()) ) ? "selected" : "" %>>
                            <%= tiendaName %> | <%= diaFranja %> &#183; <%= fechaTurno %>
                        </option>
                        <%
                            }
                        %>
                    </select>
                </div>

                <!-- ASISTENCIA -->
                <div class="form-group">

                    <label>
                        <input  type="checkbox"
                                name="asistencia"
                                value="true"
                            <%= esEdicion && Boolean.TRUE.equals(asignacion.getAsistencia()) ? "checked" : "" %>>
                        Asistencia
                    </label>

                </div>

                <div class="form-group">

                    <label>Entidad Colaboradora:</label>

                    <select name="idEntidad">
                        <option value="">Seleccione una entidad</option>
                        <%
                            for (EntidadColaboradoraDTO entidad : entidades) {
                        %>

                        <option value="<%= entidad.getIdEntidad() %>"
                                <%= ( idEntidadActual != null && idEntidadActual.equals(entidad.getIdEntidad()) ) ? "selected" : "" %>>
                            <%= entidad.getNombreEntidad() %>
                        </option>

                        <%
                            }
                        %>
                    </select>

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

</body>

</html>
