<%--
Página JSP que muestra la gestión de voluntarios.

Autores:
- Sergio Aldana: 79%
- Laia Díaz: 21%

--%>

<%@ page import="java.util.List" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.AsignacionVoluntarioEntity" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.UsuarioEntity" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="es.uma.tsaw.proyectobancosol.dto.AsignacionVoluntarioDTO" %>


<html>
<head>
    <title>Asignaciones del Voluntario</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style_bancosol.css">
</head>

<body>
    <header class="main-header">
        <div class="logo-area">
            <img src="${pageContext.request.contextPath}/images/LOGO_BANCOSOL_FOOTER.png" alt="Bancosol Logo">
            <div>
                <h1>ASIGNACIÓN DE VOLUNTARIOS</h1>
            </div>
        </div>
    </header>

    <main class="dashboard">

    <%
        Integer idUsuario = (Integer) request.getAttribute("idUsuario");
        String nombreUsuario = (String) request.getAttribute("nombreUsuario");
        List<AsignacionVoluntarioDTO> asignaciones = (List<AsignacionVoluntarioDTO>) request.getAttribute("asignaciones");
    %>

    <%--
    <p class="usuario-badge">
        Voluntario: <strong><%= nombreUsuario %></strong>
        &nbsp;|&nbsp; ID: <%= idUsuario %>
    </p>
    --%>

    <div class="content-layout">

        <section class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID ASIGNACION</th>
                        <th>TIENDA</th>
                        <th>LOCALIDAD</th>
                        <th>FRANJA</th>
                        <th>FECHA</th>
                        <th>ASISTENCIA</th>
                        <th>ID ENTIDAD</th>
                        <th>ENTIDAD COLABORADORA</th>
                        <th colspan="2">ACCIONES</th>
                    </tr>
                </thead>

                <tbody>

                <%
                    if (asignaciones == null || asignaciones.isEmpty()) {
                %>
                    <tr><td colspan="10">Voluntario sin asignaciones</td></tr>
                <%
                } else {

                    for (AsignacionVoluntarioDTO av : asignaciones) {
                %>

                <tr>
                    <td><%= av.getIdAsignacion() %></td>
                    <td><%= av.getNombreTienda() %></td>
                    <td><%= av.getLocalidad() != null ? av.getLocalidad() : "-" %></td>
                    <td><%= av.getDiaFranja() != null ? av.getDiaFranja() : "-" %></td>
                    <td><%= av.getFecha() != null ? av.getFecha() : "-" %></td>
                    <td><%= Boolean.TRUE.equals(av.getAsistencia()) ? "Sí" : "No" %></td>
                    <td><%= av.getIdEntidad() != null ? av.getIdEntidad() : "-" %></td>
                    <td><%= av.getNombreEntidad() != null ? av.getNombreEntidad() : "-" %></td>
                    <td><a href="/voluntarios/edit?idUsuario=<%= idUsuario %>&id=<%= av.getIdAsignacion() %>" class="btn btn-sm btn-warning">Editar</a></td>
                    <td><a href="/voluntarios/borrar?id=<%= av.getIdAsignacion() %>&idUsuario=<%= idUsuario %>" class="btn btn-sm btn-danger">Borrar</a></td>
                </tr>

                <%
                    }} //else y for
                %>

                </tbody>
            </table>
            <div class="mt-20" style="display:flex;gap:10px;flex-wrap:wrap;">
                <a href="/voluntarios/edit?idUsuario=<%= idUsuario %>" class="btn btn-primary">Añadir Asignación</a>
                <a href="/menu" class="btn btn-secondary">Menú Principal</a>
            </div>
        </section>

    </div>

    </main>

    <footer>
        <p>&copy; 2026 Bancosol | Grupo 4</p>
    </footer>
</body>
</html>