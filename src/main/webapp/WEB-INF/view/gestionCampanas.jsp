<%@ page import="es.uma.tsaw.proyectobancosol.entity.Campanya" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.Cadena" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<Campanya> campanas = (List<Campanya>) request.getAttribute("campanas");
    List<Cadena> cadenas = (List<Cadena>) request.getAttribute("cadenas");
%>

<html>
<head>
    <title>Gestión de Campañas - Bancosol</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<h1>Gestión de Campañas</h1>

<form method="post" action="campanas/generarCampana">

    <!-- CAMPAÑAS -->
    <h2>Campaña</h2>
    <%
        for (Campanya camp : campanas) {
    %>
    <input type="radio" name="campanaId" value="<%= camp.getIdCampanya() %>">
    <%= camp.getNombre_campanya() %> (<%= camp.getEstado() %>)<br>
    <%
        }
    %>

    <br>

    <!-- CADENAS -->
    <h2>Cadenas</h2>
    <%
        for (Cadena cad : cadenas) {
    %>
    <input type="checkbox" name="cadenaIds" value="<%= cad.getIdCadena() %>">
    <%= cad.getNombreCadena() %><br>
    <%
        }
    %>

    <br>

    <!-- BOTONES CADENA -->

    <button type="button" onclick="window.location.href='campanas/cadenas/nueva'">
        Añadir cadena
    </button>

    &nbsp;

    <button type="button" onclick="window.location.href='campanas/cadenas/editar'" id="linkEditarCadena">
        Modificar cadena
    </button>

    &nbsp;

    <button type="button" onclick="window.location.href='campanas/cadenas/borrar'" id="linkBorrarCadena">
        Eliminar cadena
    </button>

    &nbsp;

    <button type="button" onclick="window.location.href='campanas'">
        Cancelar
    </button>

    &nbsp;

    <input type="submit" name="accion" value="Guardar cambios">
    <br><br>
    <input type="submit" name="accion" value="Generar campaña">

</form>

<a href="/">Salir</a>

<script>
    // Añade el id seleccionado a los enlaces de editar/borrar cadena
    document.querySelectorAll('input[name="cadenaIds"]').forEach(function(cb) {
        cb.addEventListener('change', function() {
            var checked = document.querySelectorAll('input[name="cadenaIds"]:checked');
            if (checked.length === 1) {
                var id = checked[0].value;
                document.getElementById('linkEditarCadena').href = 'campanas/cadenas/editar?id=' + id;
                document.getElementById('linkBorrarCadena').href = 'campanas/cadenas/borrar?id=' + id;
            }
        });
    });

    // Añade el id seleccionado a los enlaces de editar/borrar campaña
    document.querySelectorAll('input[name="campanaId"]').forEach(function(rb) {
        rb.addEventListener('change', function() {
            var id = this.value;
            document.getElementById('linkEditarCampanya').href = 'campanas/editar?id=' + id;
            document.getElementById('linkBorrarCampanya').href = 'campanas/borrar?id=' + id;
        });
    });
</script>

</body>
</html>
