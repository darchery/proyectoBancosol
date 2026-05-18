<%@ page import="es.uma.tsaw.proyectobancosol.entity.Tienda" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Gestión de Tiendas - Bancosol</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style_bancosol.css">
</head>

<body>
    <header class="main-header">
        <h1>Bancosol - Panel de Gestión</h1>
        <div>
            <a href="/" class="btn btn-secondary">Inicio</a>
        </div>
    </header>

    <main class="container">
        <h2>Gestión de tiendas</h2>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>DIRECCIÓN</th>
                    <th>NOMBRE</th>
                    <th>FRANQUICIA</th>
                    <th>Nº LINEALES</th>
                    <th>CP</th>
                    <th colspan="2" class="text-center">ACCIONES</th>
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
                    <td class="text-center">
                        <a href="/tiendas/editarCrear?id=<%=tienda.getIdTienda()%>" class="btn btn-sm btn-warning">Editar</a>
                    </td>
                    <td class="text-center">
                        <a href="/tiendas/borrar?id=<%=tienda.getIdTienda()%>" class="btn btn-sm btn-danger">Eliminar</a>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="8" class="text-center">No hay tiendas registradas</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>

        <div class="mt-20">
            <a href="/tiendas/editarCrear" class="btn btn-success">Añadir nueva tienda</a>
        </div>
    </main>
</body>
</html>
