<%@ page import="es.uma.tsaw.proyectobancosol.entity.TiendaEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.TiendaEntity" %>
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
        <h2>Gestión de tiendaEntities</h2>

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
                    List<TiendaEntity> tiendaEntities = (List<TiendaEntity>) request.getAttribute("tiendaEntities");
                    if (tiendaEntities != null) {
                        for(TiendaEntity tiendaEntity : tiendaEntities) {
                %>
                <tr>
                    <td><%= tiendaEntity.getIdTienda() %></td>
                    <td><%= tiendaEntity.getDireccionEstablecimiento() != null ? tiendaEntity.getDireccionEstablecimiento() : "-" %></td>
                    <td><%= tiendaEntity.getNombreEstablecimiento() %></td>
                    <td><%= (tiendaEntity.getFranquicia() != null && tiendaEntity.getFranquicia()) ? "Sí" : "No" %></td>
                    <td><%= tiendaEntity.getLineales() %></td>
                    <td><%= tiendaEntity.getCp() %></td>
                    <td class="text-center">
                        <a href="/tiendaEntities/editarCrear?id=<%=tiendaEntity.getIdTienda()%>" class="btn btn-sm btn-warning">Editar</a>
                    </td>
                    <td class="text-center">
                        <a href="/tiendaEntities/borrar?id=<%=tiendaEntity.getIdTienda()%>" class="btn btn-sm btn-danger">Eliminar</a>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="8" class="text-center">No hay tiendaEntities registradas</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>

        <div class="mt-20">
            <a href="/tiendaEntities/editarCrear" class="btn btn-success">Añadir nueva tiendaEntity</a>
        </div>
    </main>
</body>
</html>
