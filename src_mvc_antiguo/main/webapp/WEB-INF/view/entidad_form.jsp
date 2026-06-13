<%@ page import="es.uma.tsaw.proyectobancosol.entity.EntidadColaboradoraEntity" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.UsuarioEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.EntidadColaboradoraEntity" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.UsuarioEntity" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    EntidadColaboradoraEntity entidad = (EntidadColaboradoraEntity) request.getAttribute("entidad");
    List<UsuarioEntity> usuarioEntities = (List<UsuarioEntity>) request.getAttribute("usuarioEntities");
    boolean esEdicion = (entidad.getIdEntidad() != null);
%>
<html>
<head>
    <title><%= esEdicion ? "Editar" : "Crear" %> Entidad Colaboradora</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-5">
    <h2 class="mb-4"><%= esEdicion ? "Editar" : "Crear" %> Entidad Colaboradora</h2>

    <form action="/entidades/guardar" method="post">
        <% if (esEdicion) { %>
        <input type="hidden" name="idEntidad" value="<%= entidad.getIdEntidad() %>">
        <% } %>

        <div class="mb-3">
            <label class="form-label">Nombre de la Entidad:</label>
            <input class="form-control" type="text" name="nombreEntidad"
                   value="<%= (esEdicion ? entidad.getNombreEntidad() : "") %>" required />
        </div>

        <div class="mb-3">
            <label class="form-label">Tipo:</label>
            <input class="form-control" type="text" name="tipo"
                   value="<%= (esEdicion ? entidad.getTipo() : "") %>" />
        </div>

        <div class="mb-3">
            <label class="form-label">Coordinador Responsable:</label>
            <select name="responsableId" class="form-control">
                <option value="">-- Sin asignar --</option>
                <%
                    for (UsuarioEntity u : usuarioEntities) {
                        String selected = "";
                        if (esEdicion && entidad.getResponsable() != null &&
                                u.getIdUsuario().equals(entidad.getResponsable().getIdUsuario())) {
                            selected = "selected";
                        }
                %>
                <option value="<%= u.getIdUsuario() %>" <%= selected %>><%= u.getNombre() %></option>
                <%
                    }
                %>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">¿Ligado a Bancosol?:</label>
            <select name="ligadoBancosol" class="form-control">
                <option value="true" <%= (esEdicion && Boolean.TRUE.equals(entidad.getLigadoBancosol())) ? "selected" : "" %>>Sí</option>
                <option value="false" <%= (esEdicion && !Boolean.TRUE.equals(entidad.getLigadoBancosol())) ? "selected" : "" %>>No</option>
            </select>
        </div>

        <button type="submit" class="btn btn-primary">Guardar</button>
        <a href="/entidades" class="btn btn-secondary">Cancelar</a>
    </form>
</div>

</body>
</html>