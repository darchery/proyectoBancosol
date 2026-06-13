<%@ page import="es.uma.tsaw.proyectobancosol.dto.ContactoDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    ContactoDTO contactoEntity = (ContactoDTO) request.getAttribute("contactoEntity");
    Integer idEntidad = (Integer) request.getAttribute("idEntidad");
    boolean esEdicion = (contactoEntity.getIdContacto() != null);
%>
<html>
<head>
    <title><%= esEdicion ? "Editar" : "Añadir" %> Contacto</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style_bancosol.css">
</head>
<body>
    <header class="main-header">
        <div class="logo-area">
            <img src="${pageContext.request.contextPath}/images/LOGO_BANCOSOL_FOOTER.png" alt="Bancosol Logo">
            <div>
                <h1><%= esEdicion ? "EDITAR" : "AÑADIR" %> CONTACTO</h1>
            </div>
        </div>
    </header>

    <main class="container">
        <div class="form-container">
            <form action="/entidades/<%= idEntidad %>/contactos/guardar" method="post">
                <% if (esEdicion) { %>
                <input type="hidden" name="idContacto" value="<%= contactoEntity.getIdContacto() %>">
                <% } %>

                <div class="form-group">
                    <label>Nombre:</label>
                    <input type="text" name="nombre"
                           value="<%= (esEdicion && contactoEntity.getNombre() != null ? contactoEntity.getNombre() : "") %>" required />
                </div>

                <div class="form-group">
                    <label>Email:</label>
                    <input type="email" name="email"
                           value="<%= (esEdicion && contactoEntity.getEmail() != null ? contactoEntity.getEmail() : "") %>" />
                </div>

                <div class="form-group">
                    <label>Teléfono:</label>
                    <input type="text" name="telefono"
                           value="<%= (esEdicion && contactoEntity.getTelefono() != null ? contactoEntity.getTelefono() : "") %>" />
                </div>

                <div class="form-group">
                    <label>
                        <input type="checkbox" name="esPrincipal" value="true"
                                <%= (esEdicion && Boolean.TRUE.equals(contactoEntity.getEsPrincipal())) ? "checked" : "" %> />
                        ¿Es contactoEntity principal?
                    </label>
                </div>

                <div class="actions-row">
                    <button type="submit" class="btn btn-primary">Guardar</button>
                    <a href="/entidades/<%= idEntidad %>/contactos" class="btn btn-secondary">Cancelar</a>
                </div>
            </form>
        </div>
    </main>

    <footer>
        <p>&copy; 2026 Bancosol | Grupo 4</p>
    </footer>
</body>
</html>