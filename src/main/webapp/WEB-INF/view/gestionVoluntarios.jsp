<%@ page import="java.util.List" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.Voluntario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Lista de películas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<%
    List<Voluntario> voluntarios =  (List<Voluntario>) request.getAttribute("pelis");
%>
<body>
<h1>Lista de Voluntarios</h1>

<table class="table table-striped table-bordered table-hover align-middle">
    <tr>
        <th>TIENDA</th>
        <th>DOMICILIO</th>
        <th>DIRECCION</th>
        <th>TURNO</th>
    </tr>
    <%
        for (Voluntario v: voluntarios) {
    %>
    <tr>

        <td><%= v.getTienda() %> </td>
        <td><%= v.getTienda().getDomicilio()%> </td>
        <td><%= v.getTienda().getDireccion() %> </td>
        <td><%= v.getTurno()%> </td>
    </tr>
    <%
        }
    %>

</table>

</body>
</html>
