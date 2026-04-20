<%@ page import="java.util.List" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.Coordinador" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Lista de Coordinadores</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<%
    List<Coordinador> coordinadores =  (List<Coordinador>) request.getAttribute("coordinador");
%>
<body>
<h1>Lista de Voluntarios</h1>

<table class="table table-striped table-bordered table-hover align-middle">
    <tr>
        <th>NOMBRE</th>
        <th>ENTIDAD</th>
        <th>DISTRITO</th>
        <th>TELEFONO</th>
        <th>CORREO ELECTRONICO</th>
        <th>TIENDAS</th>
        <th>USUARIO</th>
        <th>CONTRASEÑA</th>
    </tr>
    <%
        for (Coordinador c: coordinadores) {
    %>
    <tr>

        <td><%= c.getNombreCompleto() %> </td>
        <td><%= c.getTienda().getCadena()%> </td>
        <td><%= c.getTienda().getDistrito() %> </td>
        <td><%= c.getTelefono()%> </td>
        <td><%= c.getEmail() %></td>
        <td><%=c.getUsuario() %></td>
        <td><%=c.getUsuario().getContrasena() %></td>
    </tr>
    <%
        }
    %>

</table>

</body>
</html>
