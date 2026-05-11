<%@ page import="es.uma.tsaw.proyectobancosol.entity.Tienda" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Gestión de Tiendas - Bancosol</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

    <h1>Gestión de tiendas</h1>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>DIRECCIÓN</th>
                <th>NOMBRE</th>
                <th>FRANQUICIA</th>
                <th>Nº LINEALES</th>
                <th>CP</th>
                <th colspan="2"></th>
            </tr>
        </thead>
        <tbody>
            <%
                List<Tienda> tiendas = (List<Tienda>) request.getAttribute("tiendas");
                if (tiendas != null) {
                    for(Tienda tienda : tiendas) {
            %>
            <tr>
                <td><%= tienda.getIdTienda() %></td>
                <td><%= tienda.getDireccionEstablecimiento() != null ? tienda.getDireccionEstablecimiento() : "-" %></td>
                <td><%= tienda.getNombreEstablecimiento() %></td>
                <td><%= (tienda.getFranquicia() != null && tienda.getFranquicia()) ? "Sí" : "No" %></td>
                <td><%= tienda.getLineales() %></td>
                <td><%= tienda.getCp() %></td>
                <td>
                    <a href="/tiendas/editarCrear?id=<%=tienda.getIdTienda()%>">Editar</a>
                </td>
                <td>
                    <a href="/tiendas/borrar?id=<%=tienda.getIdTienda()%>">Eliminar</a>
                </td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="8">No hay tiendas registradas</td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>

    <form method="get" action="/tiendas/editarCrear">
        <button type="submit">Añadir tienda</button>
    </form>
</body>
</html>
