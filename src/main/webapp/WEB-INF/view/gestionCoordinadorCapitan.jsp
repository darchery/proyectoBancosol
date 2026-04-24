<%@ page import="java.util.List" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.Usuario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Lista de Coordinadores</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<%
    List<Usuario> coordinadores =  (List<Usuario>) request.getAttribute("coordinador");
%>
<body>
<h1>Lista de Voluntarios</h1>

<table class="table table-striped table-bordered table-hover align-middle">
    <tr>
        <th>NOMBRE</th>
        <th>TELÉFONO</th>
        <th>CORREO ELECTRÓNICO</th>
        <th>ROL</th>
        <th>ID SISTEMA</th>
    </tr>
    <%
        for (Usuario c: coordinadores) {
    %>
    <tr>
        <td><strong><%= c.getNombre() %></strong></td>
        <td><%= (c.getTelefono() != null) ? c.getTelefono() : "-" %></td>
        <td><%= c.getEmail() %></td>
        <td>
                <span class="badge bg-info text-dark">
                    <%= (c.getRol() != null) ? c.getRol().getNombreRol() : "Sin Rol" %>
                </span>
        </td>

        <td><small class="text-muted"><%= c.getIdUsuario() %></small></td>
    </tr>
    <%
        }
    %>

</table>

</body>
</html>
