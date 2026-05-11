<%@ page import="es.uma.tsaw.proyectobancosol.entity.Tienda" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.Cadena" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.Direccion" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title><%= ((Tienda)request.getAttribute("tienda")).getIdTienda() != null ? "Editar" : "Nueva" %> tienda</title>

    <%
        Tienda tienda = (Tienda) request.getAttribute("tienda");
        List<Cadena> cadenas = (List<Cadena>) request.getAttribute("cadenas");
        List<Direccion> direcciones = (List<Direccion>) request.getAttribute("direcciones");
    %>

</head>

<body>
    <h1><%= ((Tienda)request.getAttribute("tienda")).getIdTienda() != null ? "Editar" : "Nueva" %> tienda</h1>

    <form action="/tiendas/guardar" method="post">
        <% if (tienda.getIdTienda() != null) { %>
            <input type="hidden" name="idTienda" value="<%= tienda.getIdTienda() %>">
        <%
            }
        %>

        <div>
            <label for="nombreEstablecimiento">Nombre del establecimiento:</label>
            <input type="text" name="nombreEstablecimiento" id="nombreEstablecimiento" value="<%= tienda.getNombreEstablecimiento() != null ? tienda.getNombreEstablecimiento() : "" %>" required>
        </div>

        <div>
            <label for="direccionEstablecimiento">Dirección:</label>
            <input type="text" name="direccionEstablecimiento" id="direccionEstablecimiento" value="<%= tienda.getDireccionEstablecimiento() != null ? tienda.getDireccionEstablecimiento() : "" %>">
        </div>

        <div>
            <label for="cadenas">Cadena:</label><br/>
            <select name="idCadena" id="cadenas" required>
                <option value="">Selecciona una cadena...</option>
                <%
                    for (Cadena c : cadenas) {
                        String selected = "";
                        if(tienda.getCadena() != null && tienda.getCadena().getIdCadena().equals(c.getIdCadena())){
                            selected = "selected";
                        }
                %>
                    <option value="<%= c.getIdCadena() %>" <%=selected%>>
                        <%= c.getNombreCadena() %>
                    </option>
                <%
                    }
                %>
            </select>
        </div>

        <div>
            <label for="direcciones">Ubicación:</label><br>
            <select name="idDireccion" id="direcciones">
                <option value="">Ninguna...</option>
                <%
                    for (Direccion d : direcciones) {
                        String selected = "";
                        if(tienda.getDireccion() != null && tienda.getDireccion().getIdDireccion().equals(d.getIdDireccion())){
                            selected = "selected";
                        }
                %>
                    <option value="<%= d.getIdDireccion() %>" <%= selected %>>
                        <%= d.getZonaGeografica() %> - <%= d.getDistritoLocal() %>
                    </option>
                <% } %>
            </select>
        </div>

        <div>
            <label for="cp">Código Postal:</label>
            <input type="text" id="cp" name="cp" value="<%= tienda.getCp() != null ? tienda.getCp() : "" %>">
        </div>

        <div>
            <label for="lineales">Núm. lineales:</label><br>
            <input type="text" id="lineales" name="lineales" value="<%= tienda.getLineales() != null ? tienda.getLineales() : "" %>">
        </div>

        <div>

            <input type="checkbox" id="franquicia" name="franquicia" value="true" <%= (tienda.getFranquicia() != null && tienda.getFranquicia()) ? "checked" : "" %>>
            <label for="franquicia">Es una franquicia</label>
        </div>

        <div>
            <button type="submit">Guardar</button>
            <a href="/tiendas">Cancelar</a>
        </div>
    </form>
</body>
</html>
