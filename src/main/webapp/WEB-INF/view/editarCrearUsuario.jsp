<%--
Página JSP que permite crear o editar un usuario del sistema.

Autores:
- Lucas Díaz Ruiz: 80%
- Sergio Aldana: 10%
- IA Generativa: 10%

--%>

<%@ page import="es.uma.tsaw.proyectobancosol.dto.RolDTO" %>
<%@ page import="es.uma.tsaw.proyectobancosol.dto.UsuarioDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    RolDTO rolEntity = (RolDTO) request.getAttribute("rol");
    UsuarioDTO usuario = (UsuarioDTO) request.getAttribute("usuario");
%>

<html>
<head>
    <title><%= usuario == null ? "Añadir" : "Editar"%> <%= rolEntity.getNombreRol()%></title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style_bancosol.css">
</head>
<body>
    <header class="main-header">
        <div class="logo-area">
            <img src="${pageContext.request.contextPath}/images/LOGO_BANCOSOL_FOOTER.png" alt="Bancosol Logo">
            <div>
                <h1><%= usuario == null ? "AÑADIR" : "EDITAR"%> <%= rolEntity.getNombreRol().toUpperCase()%></h1>
            </div>
        </div>
    </header>

    <main class="container">
        <div class="form-container">
            <%
                String error = (String) request.getAttribute("error");
                if ("email_duplicado".equals(error)) {
            %>
                <p class="msg-error">Ese email ya está registrado. Prueba con otro.</p>
            <%
                }
            %>

            <form action="/usuarios/guardar" method="post">
                <%
                    if (usuario != null) {
                %>
                    <input type="hidden" name="id" value="<%= usuario.getIdUsuario()%>">
                <%
                    }
                %>

                <input type="hidden" name="idRol" value="<%= rolEntity.getIdRol()%>">

                <div class="form-group">
                    <label>Nombre:</label>
                    <input value="<%= usuario != null ? usuario.getNombre() : ""%>" type="text" name="nombre" required>
                </div>

                <div class="form-group">
                    <label>Correo:</label>
                    <input value="<%= usuario != null ? usuario.getEmail() : ""%>" type="email" name="email" required>
                </div>

                <div class="form-group">
                    <label>Teléfono:</label>
                    <input value="<%= usuario != null ? usuario.getTelefono() : ""%>" type="text" name="telefono">
                </div>

                <div class="form-group">
                    <label>Contraseña:</label>
                    <input value="<%= usuario != null ? usuario.getContrasenya() : ""%>" type="password" name="contrasenya" required>
                </div>

                <div class="actions-row">
                    <button type="submit" class="btn btn-primary">Guardar</button>
                    <a href="/usuarios/coordinadores-capitanes" class="btn btn-secondary">Cancelar</a>
                </div>
            </form>
        </div>
    </main>

    <footer>
        <p>&copy; 2026 Bancosol | Grupo 4</p>
    </footer>
</body>
</html>