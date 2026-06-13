<%--
Página JSP que se muestra cuando un usuario intenta acceder a un recurso para el que no tiene permisos.

Autores:
- Sergio Aldana: 100%

--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sin permisos - Bancosol</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style_bancosol.css?v=2">
</head>
<body class="page-sinPermisos">

<header class="main-header">
    <div class="logo-area">
        <img src="${pageContext.request.contextPath}/images/LOGO_BANCOSOL_FOOTER.png" alt="Bancosol Logo">
        <div></div>
    </div>
</header>

<main class="container">
    <div class="form-container text-center">
        <h1>ACCESO DENEGADO</h1>
        <p class="mensaje-permisos">No tienes permisos para realizar esta acción.</p>

        <div class="actions-row text-center">
            <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Iniciar sesión con otra cuenta</a>
            <a href="${pageContext.request.contextPath}/menu" class="btn btn-secondary">Volver al menú</a>
        </div>
    </div>
</main>

<footer>
    <p>&copy; 2026 Bancosol | Grupo 4</p>
</footer>
</body>
</html>
