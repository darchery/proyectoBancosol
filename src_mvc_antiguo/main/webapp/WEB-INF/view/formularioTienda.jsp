<%@ page import="java.util.List" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title><%= ((TiendaEntity)request.getAttribute("tiendaEntity")).getIdTienda() != null ? "Editar" : "Nueva" %> tiendaEntity</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style_bancosol.css">
</head>

<body>
    <header class="main-header">
        <h1>Bancosol - Panel de Gestión</h1>
        <div>
            <a href="/tiendaEntities" class="btn btn-secondary">Volver al listado</a>
        </div>
    </header>

    <main class="container">
        <div class="form-container">
            <h2><%= ((TiendaEntity)request.getAttribute("tiendaEntity")).getIdTienda() != null ? "Editar" : "Nueva" %> tiendaEntity</h2>

            <%
                TiendaEntity tiendaEntity = (TiendaEntity) request.getAttribute("tiendaEntity");
                List<CadenaEntity> cadenaEntities = (List<CadenaEntity>) request.getAttribute("cadenaEntities");
                List<DireccionEntity> direcciones = (List<DireccionEntity>) request.getAttribute("direcciones");
            %>

            <form action="/tiendaEntities/guardar" method="post">
                <% if (tiendaEntity.getIdTienda() != null) { %>
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
                            for (CadenaEntity c : cadenaEntities) {
                                String selected = (tiendaEntity.getCadenaEntity() != null && tiendaEntity.getCadenaEntity().getIdCadena().equals(c.getIdCadena())) ? "selected" : "";
                        %>
                            <option value="<%= c.getIdCadena() %>" <%=selected%>>
                                <%= c.getNombreCadena() %>
                            </option>
                        <% } %>
                    </select>
                </div>

                <div class="form-group">
                    <label for="direcciones">Ubicación (Zona Geográfica):</label>
                    <select name="idDireccion" id="direcciones">
                        <option value="">Ninguna...</option>
                        <%
                            for (DireccionEntity d : direcciones) {
                                String selected = (tiendaEntity.getDireccionEntity() != null && tiendaEntity.getDireccionEntity().getIdDireccion().equals(d.getIdDireccion())) ? "selected" : "";
                        %>
                            <option value="<%= d.getIdDireccion() %>" <%= selected %>>
                                <%= d.getZonaGeografica() %> - <%= d.getDistritoLocal() %>
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
</body>
</html>
