<%@ page import="es.uma.tsaw.proyectobancosol.dto.ContactoDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    ContactoDTO contacto = (ContactoDTO) request.getAttribute("contacto");
    Integer idEntidad = (Integer) request.getAttribute("idEntidad");
    boolean esEdicion = (contacto.getIdContacto() != null);
%>
<html>
<head>
    <title><%= esEdicion ? "Editar" : "Añadir" %> Contacto</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4"><%= esEdicion ? "Editar" : "Añadir" %> Contacto</h2>

    <form action="/entidades/<%= idEntidad %>/contactos/guardar" method="post">
        <% if (esEdicion) { %>
        <input type="hidden" name="idContacto" value="<%= contacto.getIdContacto() %>">
        <% } %>

        <div class="mb-3">
            <label class="form-label">Nombre:</label>
            <input class="form-control" type="text" name="nombre"
                   value="<%= (esEdicion && contacto.getNombre() != null ? contacto.getNombre() : "") %>" required />
        </div>

        <div class="mb-3">
            <label class="form-label">Email:</label>
            <input class="form-control" type="email" name="email"
                   value="<%= (esEdicion && contacto.getEmail() != null ? contacto.getEmail() : "") %>" />
        </div>

        <div class="mb-3">
            <label class="form-label">Teléfono:</label>
            <input class="form-control" type="text" name="telefono"
                   value="<%= (esEdicion && contacto.getTelefono() != null ? contacto.getTelefono() : "") %>" />
        </div>

        <div class="mb-3 form-check">
            <input class="form-check-input" type="checkbox" name="esPrincipal" value="true"
                    <%= (esEdicion && Boolean.TRUE.equals(contacto.getEsPrincipal())) ? "checked" : "" %> />
            <label class="form-check-label">¿Es contacto principal?</label>
        </div>

        <button type="submit" class="btn btn-primary">Guardar</button>
        <a href="/entidades/<%= idEntidad %>/contactos" class="btn btn-secondary">Cancelar</a>
    </form>
</div>
</body>
</html>