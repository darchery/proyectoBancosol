<%--
Página JSP que muestra el formulario para crear o editar una entidad colaboradora.

Autores:
- Sergio Aldana: 74%
- Daniela Calderón: 26%

--%>

<%@ page import="es.uma.tsaw.proyectobancosol.dto.EntidadColaboradoraDTO" %>
<%@ page import="es.uma.tsaw.proyectobancosol.dto.UsuarioDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    EntidadColaboradoraDTO entidad = (EntidadColaboradoraDTO) request.getAttribute("entidad");
    List<UsuarioDTO> usuarios = (List<UsuarioDTO>) request.getAttribute("usuarios");
    boolean esEdicion = (entidad.getIdEntidad() != null);
%>
<html>
<head>
    <title><%= esEdicion ? "Editar" : "Crear" %> Entidad Colaboradora</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style_bancosol.css">
</head>
<body>
    <header class="main-header">
        <div class="logo-area">
            <img src="${pageContext.request.contextPath}/images/LOGO_BANCOSOL_FOOTER.png" alt="Bancosol Logo">
            <div>
                <h1><%= esEdicion ? "EDITAR" : "CREAR" %> ENTIDAD COLABORADORA</h1>
            </div>
        </div>
    </header>

    <main class="container">
        <div class="form-container">
            <form action="/entidades/guardar" method="post">
                <% if (esEdicion) { %>
                <input type="hidden" name="idEntidad" value="<%= entidad.getIdEntidad() %>">
                <input type="hidden" name="direccionId" value="<%= entidad.getDireccionId() %>">
                <% } %>

                <div class="form-group">
                    <label>Nombre de la Entidad:</label>
                    <input type="text" name="nombreEntidad"
                           value="<%= (esEdicion ? entidad.getNombreEntidad() : "") %>" required />
                </div>

                <div class="form-group">
                    <label>Tipo:</label>
                    <input type="text" name="tipo"
                           value="<%= (esEdicion ? entidad.getTipo() : "") %>" />
                </div>

                <div class="form-group">
                    <label>Domicilio:</label>
                    <input type="text" name="domicilio"
                           value="<%= (esEdicion && entidad.getDomicilio() != null ? entidad.getDomicilio() : "") %>" />
                </div>

                <div class="form-group">
                    <label>Distrito Local:</label>
                    <input type="text" name="distritoLocal"
                           value="<%= (esEdicion && entidad.getDistritoLocal() != null ? entidad.getDistritoLocal() : "") %>" />
                </div>

                <div class="form-group">
                    <label>Zona Geográfica:</label>
                    <input type="text" name="zonaGeografica"
                           value="<%= (esEdicion && entidad.getZonaGeografica() != null ? entidad.getZonaGeografica() : "") %>" />
                </div>

                <div class="form-group">
                    <label>Coordinador Responsable:</label>
                    <select name="responsableId">
                        <option value="">-- Sin asignar --</option>
                        <%
                            for (UsuarioDTO u : usuarios) {
                                String selected = "";
                                if (esEdicion && entidad.getResponsableId() != null &&
                                        u.getIdUsuario().equals(entidad.getResponsableId())) {
                                    selected = "selected";
                                }
                        %>
                        <option value="<%= u.getIdUsuario() %>" <%= selected %>><%= u.getNombre() %></option>
                        <% } %>
                    </select>
                </div>

                <div class="form-group">
                    <label>¿Ligado a Bancosol?:</label>
                    <select name="ligadoBancosol">
                        <option value="true" <%= (esEdicion && Boolean.TRUE.equals(entidad.getLigadoBancosol())) ? "selected" : "" %>>Sí</option>
                        <option value="false" <%= (esEdicion && !Boolean.TRUE.equals(entidad.getLigadoBancosol())) ? "selected" : "" %>>No</option>
                    </select>
                </div>

                <div class="actions-row">
                    <button type="submit" class="btn btn-primary">Guardar</button>
                    <a href="/entidades" class="btn btn-secondary">Cancelar</a>
                </div>
            </form>
        </div>
    </main>

    <footer>
        <p>&copy; 2026 Bancosol | Grupo 4</p>
    </footer>
</body>
</html>