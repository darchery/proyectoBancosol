<%@ page import="es.uma.tsaw.proyectobancosol.entity.Tienda" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>PRUEBA - Tiendas - Bancosol</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<%
    List<Tienda> tiendas = (List<Tienda>) request.getAttribute("tiendas");
%>

<body>
<h1>Listado de Tiendas - Bancosol Alimentos</h1>
<table>
    <tr>
        <th>ID Tienda</th>
        <th>Direccion</th>
        <th>Nombre de establecimiento</th>
        <th>Franquicia</th>
        <th>Lineales</th>
        <th>Código postal</th>
    </tr>
    <%
        for(Tienda tienda : tiendas) {
    %>
    <tr>
        <td><%= tienda.getIdTienda() %></td>
        <td><%= tienda.getDireccionEstablecimiento() %></td>
        <td><%= tienda.getNombreEstablecimiento() %></td>
        <td><%= tienda.getFranquicia() %></td>
        <td><%= tienda.getLineales() %></td>
        <td><%= tienda.getCp() %></td>
    </tr>
    <%
        }
    %>
</table>
</body>
</html>