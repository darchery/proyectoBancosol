<%@ page import="es.uma.tsaw.proyectobancosol.entity.Tienda" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.Cadena" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.Direccion" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title><%= ((Tienda)request.getAttribute("tienda")).getIdTienda() != null ? "Editar" : "Nueva" %> tienda</title>
    <link rel="stylesheet" href="/css/style_bancosol.css">
</head>

<body>
    <header class="main-header">
        <h1>Bancosol - Panel de Gestión</h1>
        <div>
            <a href="/tiendas" class="btn btn-secondary">Volver al listado</a>
        </div>
    </header>

    <main class="container">
        <div class="form-container">
            <h2><%= ((Tienda)request.getAttribute("tienda")).getIdTienda() != null ? "Editar" : "Nueva" %> tienda</h2>

            <%
                Tienda tienda = (Tienda) request.getAttribute("tienda");
                List<Cadena> cadenas = (List<Cadena>) request.getAttribute("cadenas");
                List<Direccion> direcciones = (List<Direccion>) request.getAttribute("direcciones");
            %>

            <form action="/tiendas/guardar" method="post">
                <% if (tienda.getIdTienda() != null) { %>
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
                            for (Cadena c : cadenas) {
                                String selected = (tienda.getCadena() != null && tienda.getCadena().getIdCadena().equals(c.getIdCadena())) ? "selected" : "";
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
                            for (Direccion d : direcciones) {
                                String selected = (tienda.getDireccion() != null && tienda.getDireccion().getIdDireccion().equals(d.getIdDireccion())) ? "selected" : "";
                        %>
                            <option value="<%= d.getIdDireccion() %>" <%= selected %>>
                                <%= d.getZonaGeografica() %> - <%= d.getDistritoLocal() %>
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
</body>
</html>
