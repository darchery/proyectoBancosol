<%@ page import="java.util.List" %>
<%@ page import="es.uma.tsaw.proyectobancosol.dto.ContactoDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<ContactoDTO> contactos = (List<ContactoDTO>) request.getAttribute("contactos");
    Integer idEntidad = (Integer) request.getAttribute("idEntidad");
%>
<html>
<head>
    <title>Contactos de la Entidad</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">Contactos de la Entidad</h2>

    <table class="table table-striped table-bordered table-hover align-middle">
        <tr>
            <th>NOMBRE</th>
            <th>EMAIL</th>
            <th>TELÉFONO</th>
            <th>PRINCIPAL</th>
            <th colspan="2" class="text-center">ACCIONES</th>
        </tr>
        <%
            for (ContactoDTO c : contactos) {
        %>
        <tr>
            <td><%= c.getNombre() %></td>
            <td><%= c.getEmail() != null ? c.getEmail() : "" %></td>
            <td><%= c.getTelefono() != null ? c.getTelefono() : "" %></td>
            <td><%= Boolean.TRUE.equals(c.getEsPrincipal()) ? "✓" : "" %></td>
            <td class="text-center">
                <a href="/entidades/<%= idEntidad %>/contactos/editar?id=<%= c.getIdContacto() %>"
                   class="btn btn-sm btn-warning">Editar</a>
            </td>
            <td class="text-center">
                <a href="/entidades/<%= idEntidad %>/contactos/borrar?id=<%= c.getIdContacto() %>"
                   class="btn btn-sm btn-danger">Eliminar</a>
            </td>
        </tr>
        <% } %>
    </table>

    <div class="mt-3">
        <a href="/entidades/<%= idEntidad %>/contactos/nuevo" class="btn btn-success">Añadir contacto</a>
        <a href="/entidades" class="btn btn-secondary">Volver a entidades</a>
    </div>
</div>
</body>
</html>