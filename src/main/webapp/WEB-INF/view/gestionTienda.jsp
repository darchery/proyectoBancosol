<%--
Página JSP que muestra la gestión de tienda.

Autores:
- Sergio Aldana: 93%
- Laia Díaz: 7%

--%>

<%@ page import="es.uma.tsaw.proyectobancosol.dto.TiendaDTO"%>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Gestión de Tiendas - Bancosol</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style_bancosol.css">
</head>

<body>
    <header class="main-header">
        <div class="logo-area">
            <img src="${pageContext.request.contextPath}/images/LOGO_BANCOSOL_FOOTER.png" alt="Bancosol Logo">
            <div>
                <h1>GESTIÓN DE TIENDAS</h1>
            </div>
        </div>
    </header>

    <main class="dashboard">

    <div class="content-layout">

        <section class="table-container">
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
                        List<TiendaDTO> tiendaEntities = (List<TiendaDTO>) request.getAttribute("tiendas");
                        if (tiendaEntities != null) {
                            for(TiendaDTO tiendaEntity : tiendaEntities) {
                    %>
                    <tr>
                        <td><%= tiendaEntity.getIdTienda() %></td>
                        <td><%= tiendaEntity.getDireccionEstablecimiento() != null ? tiendaEntity.getDireccionEstablecimiento() : "-" %></td>
                        <td><%= tiendaEntity.getNombreEstablecimiento() %></td>
                        <td><%= (tiendaEntity.getFranquicia() != null && tiendaEntity.getFranquicia()) ? "Sí" : "No" %></td>
                        <td><%= tiendaEntity.getLineales() %></td>
                        <td><%= tiendaEntity.getCp() %></td>
                        <td class="text-center">
                            <a href="/tiendas/editarCrear?id=<%=tiendaEntity.getIdTienda()%>" class="btn btn-sm btn-warning">Editar</a>
                        </td>
                        <td class="text-center">
                            <a href="/tiendas/borrar?id=<%=tiendaEntity.getIdTienda()%>" class="btn btn-sm btn-danger">Eliminar</a>
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

            <div class="mt-20" style="display:flex;gap:10px;flex-wrap:wrap;">
                <a href="/tiendas/editarCrear" class="btn btn-success">Añadir nueva tienda</a>
                <a href="/menu" class="btn btn-secondary">Menú Principal</a>
            </div>
        </section>

    </div>

    </main>

    <footer>
        <p>&copy; 2026 Bancosol | Grupo 4</p>
    </footer>
</body>
</html>