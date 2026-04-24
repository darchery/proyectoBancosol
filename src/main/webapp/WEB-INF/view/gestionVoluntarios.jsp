<%@ page import="java.util.List" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.AsignacionVoluntario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Lista de voluntarios</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<%
    List<AsignacionVoluntario> voluntarios =  (List<AsignacionVoluntario>) request.getAttribute("pelis");
%>
<body>
<h1>Lista de Asignaciones de Voluntarios</h1>

<table class="table table-striped table-bordered table-hover align-middle">
    <thead class="table-dark">
    <tr>
        <th>VOLUNTARIO</th>
        <th>ENTIDAD</th>
        <th>TIENDA (CAMPAÑA)</th>
        <th>FECHA</th>
        <th>HORARIO</th>
        <th>ASISTENCIA</th>
    </tr>
    </thead>
    <tbody>
        <%
            if (voluntarios != null) {
                for (AsignacionVoluntario a : voluntarios) {
        %>
    <tr>
        <td><%= a.getUsuario().getNombre() %></td>

        <td><%= (a.getEntidadColaboradora() != null) ? a.getEntidadColaboradora().getNombreEntidad() : "Individual" %></td>

        <td>
            <%= a.getTurnoActivo().getTiendaCampanya().getTienda().getNombreEstablecimiento() %>
            <br>
            <small class="text-muted">(<%= a.getTurnoActivo().getTiendaCampanya().getCampanya().getNombreCampanya() %>)</small>
        </td>

        <td><%= a.getTurnoActivo().getFechaExacta() %></td>

        <td>
            <%= a.getTurnoActivo().getHoraInicio() %> - <%= a.getTurnoActivo().getHoraFin() %>
        </td>

        <td>
                <span class="badge <%= a.getAsistencia() ? "bg-success" : "bg-warning" %>">
                    <%= a.getAsistencia() ? "Presente" : "Pendiente" %>
                </span>
        </td>
    </tr>
        <%
                }
            } else {
        %>
    <tr><td colspan="6" class="text-center">No hay voluntarios asignados.</td></tr>
        <%
            }
        %>
</table>

</body>
</html>
