<%@ page import="java.util.List" %>
<%@ page import="es.uma.tsaw.proyectobancosol.dto.ContactoDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<ContactoDTO> contactos = (List<ContactoDTO>) request.getAttribute("contactos");
    Integer idEntidad = (Integer) request.getAttribute("idEntidad");
%>
<html>
<head>
    <title>Contactos de la Entidad</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style_bancosol.css">
</head>
<body>
    <header class="main-header">
        <div class="logo-area">
            <img src="${pageContext.request.contextPath}/images/LOGO_BANCOSOL_FOOTER.png" alt="Bancosol Logo">
            <div>
                <h1>CONTACTOS DE LA ENTIDAD</h1>
            </div>
        </div>
    </header>

    <main class="dashboard">

    <div class="content-layout">

        <section class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>NOMBRE</th>
                        <th>EMAIL</th>
                        <th>TELÉFONO</th>
                        <th>PRINCIPAL</th>
                        <th colspan="2" class="text-center">ACCIONES</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    for (ContactoDTO c : contactos) {
                %>
                <tr>
                    <td><%= c.getNombre() %></td>
                    <td><%= c.getEmail() != null ? c.getEmail() : "" %></td>
                    <td><%= c.getTelefono() != null ? c.getTelefono() : "" %></td>
                    <td><%= Boolean.TRUE.equals(c.getEsPrincipal()) ? "✓" : "" %></td>
                    <td class="text-center">
                        <a href="/entidades/<%= idEntidad %>/contactos/editar?id=<%= c.getIdContacto() %>" class="btn btn-sm btn-warning">Editar</a>
                    </td>
                    <td class="text-center">
                        <a href="/entidades/<%= idEntidad %>/contactos/borrar?id=<%= c.getIdContacto() %>" class="btn btn-sm btn-danger">Eliminar</a>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>

            <div class="mt-20">
                <a href="/entidades/<%= idEntidad %>/contactos/nuevo" class="btn btn-success">Añadir contactoEntity</a>
                <a href="/entidades" class="btn btn-secondary">Volver a entidades</a>
            </div>
        </section>

        <aside class="details-panel">
            <div class="panel-header">CONTACTO SELECCIONADO</div>
            <div id="vista-detalle">
                <div class="detail-row"><span>NOMBRE:</span><strong>---</strong></div>
                <div class="detail-row"><span>EMAIL:</span><strong>---</strong></div>
                <div class="detail-row"><span>TELÉFONO:</span><strong>---</strong></div>
                <div class="detail-row"><span>PRINCIPAL:</span><strong>---</strong></div>
            </div>
            <div class="action-buttons mt-10">
                <a href="/entidades/<%= idEntidad %>/contactos/nuevo" class="btn-volver-menu">Añadir contactoEntity</a>
                <a href="/entidades" class="btn-volver-menu" style="grid-column:1/-1;">Volver a entidades</a>
            </div>
        </aside>

    </div>

    </main>

    <footer>
        <p>&copy; 2026 Bancosol | Grupo 4</p>
    </footer>
</body>
</html>