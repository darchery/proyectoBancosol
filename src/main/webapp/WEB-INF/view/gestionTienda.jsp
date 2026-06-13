<%--
Página JSP que muestra la gestión de tiendaEntities.

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
                        List<TiendaDTO> tiendaEntities = (List<TiendaDTO>) request.getAttribute("tiendaEntities");
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
        </section>

        <aside class="details-panel">
            <div class="panel-header">TIENDA SELECCIONADA</div>
            <div id="vista-detalle">
                <div class="detail-row"><span>ID:</span><strong>---</strong></div>
                <div class="detail-row"><span>NOMBRE:</span><strong>---</strong></div>
                <div class="detail-row"><span>DOMICILIO:</span><strong>---</strong></div>
                <div class="detail-row"><span>FRANQUICIA:</span><strong>---</strong></div>
                <div class="detail-row"><span>LINEALES:</span><strong>---</strong></div>
                <div class="detail-row"><span>CP:</span><strong>---</strong></div>
            </div>
            <div class="action-buttons mt-10">
                <a href="/tiendaEntities/editarCrear" class="btn-volver-menu">Añadir tiendaEntity</a>
                <a href="/menu" class="btn-volver-menu" style="grid-column:1/-1;">Menú Principal</a>
            </div>
        </aside>

    </div>

    </main>

    <footer>
        <p>&copy; 2026 Bancosol | Grupo 4</p>
    </footer>
</body>
</html>