<%@ page import="java.util.List" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.Tienda" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Gestión de Tiendas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<%
    List<Tienda> tienda = (List<Tienda>) request.getAttribute("tiendas");

    List<String> coordPrimavera =
            (List<String>) request.getAttribute("coordinadoresPrimavera");

    List<String> coordGranRecogida =
            (List<String>) request.getAttribute("coordinadoresGranRecogida");
%>

<body>

<h1>Gestión de Tiendas</h1>

<table class="table table-striped table-bordered table-hover align-middle">

    <tr>
        <th>TIENDA</th>
        <th>P</th>
        <th>DOMICILIO</th>
        <th>LOCALIDAD</th>
        <th>LINEALES</th>
        <th>COORDINADOR PRIMAVERA</th>
        <th>COORDINADOR GRAN RECOGIDA</th>
    </tr>

    <%
        for (int i = 0; i < tienda.size(); i++) {
            Tienda t = tienda.get(i);
    %>

    <tr>
        <td><%= t.getIdTienda() %></td>
        <td>
            <input type="checkbox" disabled
                    <%= Boolean.TRUE.equals(t.getParticipa()) ? "checked" : "" %> />
        </td>
        <td><%= t.getDomicilio() %></td>
        <td> <%= (t.getDireccion() != null) ? t.getDireccion().toString() : "" %> </td>
        <td><%= t.getLineales() %></td>

        <td>
            <%= (coordPrimavera != null && i < coordPrimavera.size())
                    ? coordPrimavera.get(i)
                    : "-" %>
        </td>

        <td>
            <%= (coordGranRecogida != null && i < coordGranRecogida.size())
                    ? coordGranRecogida.get(i)
                    : "-" %>
        </td>

    </tr>

    <%
        }
    %>

</table>

</body>
</html>