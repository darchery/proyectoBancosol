<%@ page import="es.uma.tsaw.proyectobancosol.dto.TiendaDTO" %>
<%@ page import="es.uma.tsaw.proyectobancosol.dto.CadenaDTO" %>
<%@ page import="es.uma.tsaw.proyectobancosol.dto.DireccionDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    TiendaDTO tienda = (TiendaDTO) request.getAttribute("tienda");
    List<CadenaDTO> cadenas = (List<CadenaDTO>) request.getAttribute("cadenas");
    List<DireccionDTO> direcciones = (List<DireccionDTO>) request.getAttribute("direcciones");
    boolean esEdicion = (tienda.getIdTienda() != null);
%>
<html>
<head>
    <title><%= esEdicion ? "Editar" : "Nueva" %> tienda - Bancosol</title>
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

            <form action="/tiendas/guardar" method="post">
                <% if (esEdicion) { %>
                    <input type="hidden" name="idTienda" value="<%= tienda.getIdTienda() %>">
                <% } %>

                <div class="form-group">
                    <label for="nombreEstablecimiento">Nombre del establecimiento:</label>
                    <input type="text" name="nombreEstablecimiento" id="nombreEstablecimiento" value="<%= tienda.getNombreEstablecimiento() != null ? tienda.getNombreEstablecimiento() : "" %>" required>
                </div>

                <div class="form-group">
                    <label for="direccionEstablecimiento">Dirección:</label>
                    <input type="text" name="direccionEstablecimiento" id="direccionEstablecimiento" value="<%= tienda.getDireccionEstablecimiento() != null ? tienda.getDireccionEstablecimiento() : "" %>">
                </div>

                <div class="form-group">
                    <label for="cadenas">Cadena:</label>
                    <select name="idCadena" id="cadenas" required>
                        <option value="">Selecciona una cadena...</option>
                        <%
                            for (CadenaDTO cad : cadenas) {
                                String selected = (tienda.getCadenaId() != null && tienda.getCadenaId().equals(cad.getIdCadena())) ? "selected" : "";
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
                                String selected = (tienda.getDireccionId() != null && tienda.getDireccionId().equals(dir.getIdDireccion())) ? "selected" : "";
                        %>
                            <option value="<%= dir.getIdDireccion() %>" <%= selected %>>
                                <%= dir.getZonaGeografica() %> - <%= dir.getDistritoLocal() %>
                            </option>
                        <% } %>
                    </select>
                </div>

                <div class="form-group">
                    <label for="cp">Código Postal:</label>
                    <input type="text" id="cp" name="cp" value="<%= tienda.getCp() != null ? tienda.getCp() : "" %>">
                </div>

                <div class="form-group">
                    <label for="lineales">Núm. lineales:</label>
                    <input type="text" id="lineales" name="lineales" value="<%= tienda.getLineales() != null ? tienda.getLineales() : "" %>">
                </div>

                <div class="form-group">
                    <label>
                        <input type="checkbox" id="franquicia" name="franquicia" value="true" <%= (tienda.getFranquicia() != null && tienda.getFranquicia()) ? "checked" : "" %>>
                        Es una franquicia
                    </label>
                </div>

                <div class="actions-row">
                    <button type="submit" class="btn btn-primary">Guardar</button>
                    <a href="/tiendas" class="btn btn-secondary">Cancelar</a>
                </div>
            </form>
        </div>
    </main>

    <footer>
        <p>&copy; 2026 Bancosol | Grupo 4</p>
    </footer>
</body>
</html>