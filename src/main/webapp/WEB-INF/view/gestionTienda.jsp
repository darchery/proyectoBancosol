<%@ page import="java.util.List" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.Tienda" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.TiendaCampanya" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Gestión de Tiendas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<%
    List<Tienda> tienda = (List<Tienda>) request.getAttribute("tiendas");
%>

<body>

<h1>Gestión de Tiendas</h1>

<table class="table table-striped table-bordered table-hover align-middle">

    <tr>
        <th>TIENDA</th>
        <th>CAMPANYA</th>
        <th>COORDINADOR</th>
        <th>CAPITAN</th>
    </tr>

    <%
        List<TiendaCampanya> asignaciones = (List<TiendaCampanya>) request.getAttribute("asignaciones");
        if (asignaciones != null) {
            for (TiendaCampanya tc : asignaciones) {
    %>
    <tr>
        <td><%= tc.getTienda().getNombreEstablecimiento() %></td>

        <td><%= tc.getCampanya().getNombreCampanya() %></td>

        <td>
            <%= (tc.getCoordinador() != null)
                    ? tc.getCoordinador().getNombre()
                    : "<span class='text-danger'>Sin asignar</span>" %>
        </td>

        <td>
            <%= (tc.getCapitan() != null)
                    ? tc.getCapitan().getNombre()
                    : "---" %>
        </td>
    </tr>
    <%
            }
        }
    %>

</table>

</body>
</html>