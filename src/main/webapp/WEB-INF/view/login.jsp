<%--
Página JSP que muestra el formulario de inicio de sesión.

Autores:
- Sergio Aldana: 67%
- IA generativa: 33%

--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Login - Bancosol</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style_bancosol.css">
</head>
<%
    String error = (String)request.getAttribute("error");
%>
<body class="login-page">

    <header class="main-header">
        <div class="logo-area">
            <img src="${pageContext.request.contextPath}/images/LOGO_BANCOSOL_FOOTER.png" alt="Bancosol Logo">
        </div>
    </header>

    <main>
        <div class="login-box">

            <h1>Iniciar sesión</h1>

            <%
                if (error != null) {
            %>
            <div class="login-error">
                <%= error %>
            </div>
            <%
                }
            %>

            <form action="/autentica" method="post">

                <label>Usuario</label>
                <input type="text" name="username" placeholder="Introduce tu usuario" required>

                <label>Contraseña</label>
                <input type="password" name="password" placeholder="Introduce tu contraseña" required>

                <button type="submit">Entrar</button>

            </form>

        </div>
    </main>

    <footer>
        <p>&copy; 2026 Bancosol | Grupo 4</p>
    </footer>
</body>
</html>