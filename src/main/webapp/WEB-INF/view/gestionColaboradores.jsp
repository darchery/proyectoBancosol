<%--
Página JSP que muestra la gestión de entidades colaboradoras.

Autores:
- Sergio Aldana: 84%
- Marina Ruiz: 9%
- Daniela Calderón: 7%

--%>

<%@ page import="java.util.List" %>
<%@ page import="es.uma.tsaw.proyectobancosol.dto.EntidadColaboradoraDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Lista de Entidades Colaboradoras</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style_bancosol.css">
</head>
<%
    List<EntidadColaboradoraDTO> entidadesColaboradoras = (List<EntidadColaboradoraDTO>) request.getAttribute("entidades");
%>
<body>
    <header class="main-header">
        <div class="logo-area">
            <img src="${pageContext.request.contextPath}/images/LOGO_BANCOSOL_FOOTER.png" alt="Bancosol Logo">
            <div>
                <h1>GESTIÓN DE COLABORADORES</h1>
            </div>
        </div>
    </header>

    <main class="dashboard">

    <div class="content-layout">

        <section class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ENTIDAD</th>
                        <th>DOMICILIO</th>
                        <th>LOCALIDAD</th>
                        <th>COLABORA EN</th>
                        <th>COORDINADOR</th>
                        <th>CONTACTO PRINCIPAL</th>
                        <th>OBSERVACIONES</th>
                        <th colspan="3" class="text-center">ACCIONES</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    for (EntidadColaboradoraDTO e : entidadesColaboradoras) {
                %>
                <tr>
                    <td><strong><%= e.getNombreEntidad() %></strong></td>
                    <td><%= e.getDomicilio() %></td>
                    <td><%= e.getDistritoLocal() %></td>
                    <td><%= e.getZonaGeografica() %></td>
                    <td><%= e.getNombreResponsable() %></td>
                    <td>
                        <%= (e.getNombreContactoPrincipal() != null ? e.getNombreContactoPrincipal() : "<em class='text-muted'>Sin contacto</em>") %>
                        <%= (e.getTelefonoContactoPrincipal() != null ? "(" + e.getTelefonoContactoPrincipal() + ")" : "") %>
                    </td>
                    <td><%= (e.getObservaciones() != null) ? e.getObservaciones() : "<em class='text-muted'>No hay observaciones</em>" %></td>
                    <td class="text-center">
                        <a href="/entidades/<%= e.getIdEntidad() %>/contactos" class="btn btn-sm btn-primary">Contactos</a>
                    </td>
                    <td class="text-center">
                        <a href="/entidades/editar?id=<%= e.getIdEntidad() %>" class="btn btn-sm btn-warning">Editar</a>
                    </td>
                    <td class="text-center">
                        <a href="/entidades/borrar?id=<%= e.getIdEntidad() %>" class="btn btn-sm btn-danger">Eliminar</a>
                    </td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>

            <div class="mt-20">
                <a href="/entidades/nueva" class="btn btn-success">Añadir nueva entidad</a>
            </div>
        </section>

        <aside class="details-panel">
            <div class="panel-header">ENTIDAD SELECCIONADA</div>
            <div id="vista-detalle">
                <div class="detail-row"><span>NOMBRE:</span><strong>---</strong></div>
                <div class="detail-row"><span>DOMICILIO:</span><strong>---</strong></div>
                <div class="detail-row"><span>LOCALIDAD:</span><strong>---</strong></div>
                <div class="detail-row"><span>COLABORA EN:</span><strong>---</strong></div>
                <div class="detail-row"><span>COORDINADOR:</span><strong>---</strong></div>
                <div class="detail-row"><span>CONTACTO:</span><strong>---</strong></div>
            </div>
            <div class="panel-section-header">OBSERVACIONES</div>
            <div class="detail-row"><strong>---</strong></div>
            <div class="action-buttons mt-10">
                <a href="/entidades/nueva" class="btn-volver-menu">Añadir colaborador</a>
                <a href="/menu" class="btn-volver-menu" style="grid-column:1/-1;">Menú Principal</a>
            </div>
        </aside>

    </div>

    </main>

    <footer>
        <p>&copy; 2026 Bancosol | Grupo 4</p>
    </footer>

<script>
    window.scrollTo(0, 0);
</script>
</body>
</html>