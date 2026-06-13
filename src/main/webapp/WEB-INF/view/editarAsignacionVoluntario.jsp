<%--
Página JSP que permite editar o crear una asignación de voluntario a un turno.

Autores:
    - Sergio Aldana: 5%
    - Laia Díaz: 65%
    - IA Generativa: 30% (usado exclusivamente para el dinamismo de js)
--%>

<%@ page import="java.util.List" %>
<%@ page import="es.uma.tsaw.proyectobancosol.dto.AsignacionVoluntarioDTO" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Integer idUsuario = (Integer) request.getAttribute("idUsuario");
    String nombreUsuario = (String) request.getAttribute("nombreUsuario");
    AsignacionVoluntarioDTO asignacion = (AsignacionVoluntarioDTO) request.getAttribute("asignacion");
    List<TurnoActivoEntity> turnos = (List<TurnoActivoEntity>) request.getAttribute("turnos");
    List<EntidadColaboradoraEntity> entidades = (List<EntidadColaboradoraEntity>) request.getAttribute("entidades");

    List<TiendaEntity> tiendaEntities = (List<TiendaEntity>) request.getAttribute("tiendas");
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

            <form action="/voluntarios/guardar" method="post">

                <input  type="hidden"
                        name="idUsuario"
                        value="<%= idUsuario %>">

                <input  type="hidden"
                        name="id"
                        value="<%= esEdicion ? asignacion.getIdAsignacion() : "" %>">

                <input  type="hidden"
                        name="idTurno" id="idTurnoHidden"
                        value="<%= idTurnoActual != null ? idTurnoActual : "" %>">

                <!-- TIENDA -->
                <div class="form-group">

                    <label>Tienda:</label>

                    <select id="selectTienda" onchange="filtrarTurnos()">
                        <%
                            for (TiendaEntity tienda : tiendaEntities) {
                        %>

                        <option value="<%= tienda.getIdTienda() %>"
                                <%= ( idTiendaActual != null && idTiendaActual.equals(tienda.getIdTienda()) ) ? "selected" : "" %>>
                            <%= tienda.getNombreEstablecimiento() %>
                        </option>

                        <%
                            }
                        %>
                    </select>

                </div>


                <!-- FRANJA (turnos filtrados por tiendaEntity) -->
                <div class="form-group">

                    <label>Franja / Turno:</label>

                    <select id="selectTurno" onchange="actualizarTurno()" required>
                        <%
                            for (TurnoActivoEntity turno : turnos) {

                                PlantillaTurnoEntity plantilla = turno.getPlantillaTurnoEntity();

                                String dia = "";
                                String franja = "";

                                if (plantilla != null) {
                                    if (plantilla.getDiaSemana() != null)
                                        dia = plantilla.getDiaSemana();
                                    if (plantilla.getFranjaHoraria() != null)
                                        franja = plantilla.getFranjaHoraria();
                                }

                                String fechaTurno = turno.getFechaExacta() != null ? turno.getFechaExacta().toString() : "";

                                int idTiendaTurno = turno.getTiendaCampanyaEntity().getTiendaEntity().getIdTienda();
                        %>

                        <option value="<%= turno.getIdTurnoActivo() %>"
                                data-tienda="<%= idTiendaTurno %>"
                                data-fecha="<%= fechaTurno %>"
                                <%= ( idTurnoActual != null && idTurnoActual.equals(turno.getIdTurnoActivo()) ) ? "selected" : "" %>>
                            <%= dia %> <%= franja %> · <%= fechaTurno %>
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

                <!-- ENTIDAD COLABORADORA -->
                <div class="form-group">

                    <label>Entidad Colaboradora:</label>

                    <select name="idEntidad" id="selectEntidad" onchange="actualizarIdEntidad()">
                        <%
                            for (EntidadColaboradoraEntity entidad : entidades) {
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

    <script>
        window.onload = function () {
            filtrarTurnos();
        };

        function filtrarTurnos() {
            const idTiendaSel = document.getElementById("selectTienda").value;
            const selectTurno = document.getElementById("selectTurno");

            // Mostrar/ocultar turnos según tienda seleccionada
            Array.from(selectTurno.options).forEach(opt => {
                if (!opt.value) return; // opción vacía siempre visible
                opt.style.display = (!idTiendaSel || opt.dataset.tienda === idTiendaSel) ? "" : "none";
            });

            // Si el turno seleccionado ya no corresponde a la tienda, limpiar
            const turnoSel = selectTurno.options[selectTurno.selectedIndex];
            if (turnoSel && turnoSel.value && turnoSel.dataset.tienda !== idTiendaSel) {
                selectTurno.value = "";
                document.getElementById("idTurnoHidden").value = "";
            } else {
                actualizarTurno();
            }
        }

        function actualizarTurno() {
            const opt = document.getElementById("selectTurno").options[document.getElementById("selectTurno").selectedIndex];
            document.getElementById("idTurnoHidden").value = opt && opt.value ? opt.value : "";
        }
    </script>

</body>

</html>