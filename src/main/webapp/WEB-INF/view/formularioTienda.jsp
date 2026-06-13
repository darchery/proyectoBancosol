<%@ page import="es.uma.tsaw.proyectobancosol.dto.TiendaDTO" %>
<%@ page import="es.uma.tsaw.proyectobancosol.dto.CadenaDTO" %>
<%@ page import="es.uma.tsaw.proyectobancosol.dto.DireccionDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    TiendaDTO tiendaEntity = (TiendaDTO) request.getAttribute("tiendaEntity");
    List<CadenaDTO> cadenaEntities = (List<CadenaDTO>) request.getAttribute("cadenaEntities");
    List<DireccionDTO> direcciones = (List<DireccionDTO>) request.getAttribute("direcciones");
    boolean esEdicion = (tiendaEntity.getIdTienda() != null);
%>
<html>
<head>
    <title><%= esEdicion ? "Editar" : "Nueva" %> tiendaEntity - Bancosol</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style_bancosol.css">
</head>

<body>
    <header class="main-header">
        <div class="logo-area">
            <img src="${pageContext.request.contextPath}/images/LOGO_BANCOSOL_FOOTER.png" alt="Bancosol Logo">
            <div>
                <h1><%= esEdicion ? "EDITAR" : "NUEVA" %> TIENDA</h1>
            </div>
        </div>
    </header>

    <main class="container">
        <div class="form-container">

            <form action="/tiendaEntities/guardar" method="post">
                <% if (esEdicion) { %>
                    <input type="hidden" name="idTienda" value="<%= tiendaEntity.getIdTienda() %>">
                <% } %>

                <div class="form-group">
                    <label for="nombreEstablecimiento">Nombre del establecimiento:</label>
                    <input type="text" name="nombreEstablecimiento" id="nombreEstablecimiento" value="<%= tiendaEntity.getNombreEstablecimiento() != null ? tiendaEntity.getNombreEstablecimiento() : "" %>" required>
                </div>

                <div class="form-group">
                    <label for="direccionEstablecimiento">Dirección:</label>
                    <input type="text" name="direccionEstablecimiento" id="direccionEstablecimiento" value="<%= tiendaEntity.getDireccionEstablecimiento() != null ? tiendaEntity.getDireccionEstablecimiento() : "" %>">
                </div>

                <div class="form-group">
                    <label for="cadenaEntities">Cadena:</label>
                    <select name="idCadena" id="cadenaEntities" required>
                        <option value="">Selecciona una cadenaEntity...</option>
                        <%
                            for (CadenaDTO cad : cadenaEntities) {
                                String selected = (tiendaEntity.getCadenaId() != null && tiendaEntity.getCadenaId().equals(cad.getIdCadena())) ? "selected" : "";
                        %>
                            <option value="<%= cad.getIdCadena() %>" <%=selected%>>
                                <%= cad.getNombreCadena() %>
                            </option>
                        <% } %>
                    </select>
                </div>

                <div class="form-group">
                    <label for="direcciones">Ubicación (Zona Geográfica):</label>
                    <select name="idDireccion" id="direcciones">
                        <option value="">Ninguna...</option>
                        <%
                            for (DireccionDTO dir : direcciones) {
                                String selected = (tiendaEntity.getDireccionId() != null && tiendaEntity.getDireccionId().equals(dir.getIdDireccion())) ? "selected" : "";
                        %>
                            <option value="<%= dir.getIdDireccion() %>" <%= selected %>>
                                <%= dir.getZonaGeografica() %> - <%= dir.getDistritoLocal() %>
                            </option>
                        <% } %>
                    </select>
                </div>

                <div class="form-group">
                    <label for="cp">Código Postal:</label>
                    <input type="text" id="cp" name="cp" value="<%= tiendaEntity.getCp() != null ? tiendaEntity.getCp() : "" %>">
                </div>

                <div class="form-group">
                    <label for="lineales">Núm. lineales:</label>
                    <input type="text" id="lineales" name="lineales" value="<%= tiendaEntity.getLineales() != null ? tiendaEntity.getLineales() : "" %>">
                </div>

                <div class="form-group">
                    <label>
                        <input type="checkbox" id="franquicia" name="franquicia" value="true" <%= (tiendaEntity.getFranquicia() != null && tiendaEntity.getFranquicia()) ? "checked" : "" %>>
                        Es una franquicia
                    </label>
                </div>

                <div class="actions-row">
                    <button type="submit" class="btn btn-primary">Guardar</button>
                    <a href="/tiendaEntities" class="btn btn-secondary">Cancelar</a>
                </div>
            </form>
        </div>
    </main>

    <footer>
        <p>&copy; 2026 Bancosol | Grupo 4</p>
    </footer>
</body>
</html>