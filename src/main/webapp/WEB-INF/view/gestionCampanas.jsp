<%--
Página JSP que muestra la gestión de campañas de recogida.

Autores:
- Marina Ruiz: 51%
- Sergio Aldana: 49%

--%>

<%@ page import="es.uma.tsaw.proyectobancosol.dto.CampanyaDTO" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.CadenaEntity" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<CampanyaDTO> campanas = (List<CampanyaDTO>) request.getAttribute("campanas");
    List<CadenaEntity> cadenaEntities = (List<CadenaEntity>) request.getAttribute("cadenas");
%>

<html>
<head>
    <title>Gestión de Campañas - Bancosol</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style_bancosol.css">
</head>
<body class="page-campanya">

<header class="main-header">
    <div class="logo-area">
        <img src="${pageContext.request.contextPath}/images/LOGO_BANCOSOL_FOOTER.png" alt="Bancosol Logo">
        <div>
            <h1>GESTIÓN DE CAMPAÑAS</h1>
        </div>
    </div>
</header>

<%
    String msg = (String) request.getAttribute("msg");
    if (msg != null) {
        boolean esError = msg.startsWith("error:");
        String texto = msg.substring(msg.indexOf(":") + 1);
        String cssClass = esError ? "msg-error" : "msg-ok";
%>
<div class="<%= cssClass %>" style="max-width:1200px;margin:10px auto 0;"><%= texto %></div>
<% } %>

<form method="post" action="campanas/guardarTodo">

    <input type="hidden" name="campanaEditId"      id="campanaEditId"      value="">
    <input type="hidden" name="campanaNombre"       id="campanaNombre"      value="">
    <input type="hidden" name="campanaEstado"       id="campanaEstado"      value="">
    <input type="hidden" name="campanaTipo"         id="campanaTipo"        value="">
    <input type="hidden" name="campanaFechaInicio"  id="campanaFechaInicio" value="">
    <input type="hidden" name="campanaFechaFin"     id="campanaFechaFin"    value="">

    <div class="management-container">

        <!-- ── COLUMNA IZQUIERDA: TIPO DE CAMPAÑA ── -->
        <div class="campanya-column">
            <div class="box">
                <h2>Tipo de campaña</h2>
                <div class="checkbox-grid" style="grid-template-columns:1fr;">
                    <div class="checkbox-item">
                        <input type="radio" name="tipoCampanyaSeleccionado" value="GR"
                               id="tipo_GR" onchange="seleccionarTipo('GR')">
                        <label for="tipo_GR">Gran Recogida</label>
                    </div>
                    <div class="checkbox-item">
                        <input type="radio" name="tipoCampanyaSeleccionado" value="primavera"
                               id="tipo_primavera" onchange="seleccionarTipo('primavera')">
                        <label for="tipo_primavera">Operación Primavera</label>
                    </div>
                </div>
            </div>

            <div class="actions-frame">
                <button type="button" onclick="generarCampana()">Generar campaña</button>
                <button type="button" onclick="verHistorial()">Ver historial</button>
                <button type="submit">Guardar cambios</button>
                <a href="/menu" class="btn-volver-menu">Menú Principal</a>
            </div>
        </div>

        <!-- ── COLUMNA CENTRAL: CADENAS ── -->
        <div class="box cadenas-box">
            <h2>Cadenas</h2>
            <div class="checkbox-grid">
                <%
                    if (cadenaEntities != null) {
                        for (CadenaEntity cad : cadenaEntities) {
                %>
                <div class="checkbox-item" id="fila_<%= cad.getIdCadena() %>">
                    <input type="checkbox" name="cadenaIds"
                           value="<%= cad.getIdCadena() %>"
                           id="cad_<%= cad.getIdCadena() %>">
                    <label for="cad_<%= cad.getIdCadena() %>"><%= cad.getNombreCadena() %></label>

                    <div class="cadena-btn-group">
                        <a href="campanas/cadenas/editar?id=<%= cad.getIdCadena() %>" class="btn-edit-cadena">Editar</a>
                        <button type="button"
                                onclick="if(confirm('¿Seguro que quieres eliminar la cadena &quot;<%= cad.getNombreCadena() %>&quot;?')) window.location.href='campanas/cadenas/borrar?id=<%= cad.getIdCadena() %>'">Eliminar</button>
                    </div>
                </div>
                <%
                        }
                    }
                %>
            </div>
            <div class="cadenas-actions">
                <a href="campanas/cadenas/nueva" class="add-cadena-link">+ Añadir cadena</a>
            </div>
        </div>

        <!-- ── COLUMNA DERECHA: ACCIONES ADICIONALES ── -->
        <div class="right-column">
            <div class="character-container">
                <img src="${pageContext.request.contextPath}/images/LOGO_BANCOSOL.png" alt="Bancosol">
            </div>
        </div>

    </div>

    <!-- ── HISTORIAL (oculto por defecto) ── -->
    <div id="divHistorial" class="modal-overlay">
        <div class="modal-content modal-historial">
            <div class="modal-header">
                <h2>Historial de campañas</h2>
                <button type="button" class="modal-close-btn" onclick="document.getElementById('divHistorial').style.display='none'">&times;</button>
            </div>
            <div class="modal-body">
                <table class="tabla-historial">
                    <thead>
                    <tr>
                        <th>Nombre</th>
                        <th>Tipo</th>
                        <th>Estado</th>
                        <th>Fecha inicio</th>
                        <th>Fecha fin</th>
                        <th>Acciones</th>
                    </tr>
                    </thead>
                    <tbody id="tbodyHistorial"></tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn-modal" onclick="document.getElementById('divHistorial').style.display='none'">Cerrar historial</button>
            </div>
        </div>
    </div>

    <!-- ── FORMULARIO NUEVA CAMPAÑA ── -->
    <div id="modalFechas" class="modal-overlay">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Nueva campaña</h2>
                <button type="button" class="modal-close-btn" onclick="cerrarModal()">&times;</button>
            </div>
            <div class="modal-body">
                <p id="modalTipoLabel"></p>

                <div class="form-group">
                    <label for="inputFechaInicio">Fecha de inicio:</label>
                    <input type="date" id="inputFechaInicio">
                </div>

                <div class="form-group">
                    <label for="inputFechaFin">Fecha de fin:</label>
                    <input type="date" id="inputFechaFin">
                </div>

                <p id="errorFechas" style="display:none;color:red;"></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn-modal" onclick="confirmarGeneracion()">Confirmar</button>
                <button type="button" class="btn-modal danger" onclick="cerrarModal()">Cancelar</button>
            </div>
        </div>
    </div>

</form>

<footer>
    <p>&copy; 2026 Bancosol | Grupo 4</p>
</footer>

<script>

    var todasCampanas = [];
    <%
        if (campanas != null) {
            for (CampanyaDTO c : campanas) {
                String nombre = c.getNombreCampanya() != null ? c.getNombreCampanya().replace("\"","\\\"") : "";
                String estado = c.getEstado()         != null ? c.getEstado().replace("\"","\\\"")         : "";
                String tipo   = c.getTipoCampanya()   != null ? c.getTipoCampanya().replace("\"","\\\"")   : "";
                String fi     = c.getFechaInicio()    != null ? c.getFechaInicio()                         : "";
                String ff     = c.getFechaFin()       != null ? c.getFechaFin()                            : "";
    %>
    todasCampanas.push({ id: <%= c.getIdCampanya() %>, nombre: "<%= nombre %>", tipo: "<%= tipo %>", estado: "<%= estado %>", fechaInicio: "<%= fi %>", fechaFin: "<%= ff %>" });
    <%
            }
        }
    %>

    var tipoSeleccionado = null;

    function seleccionarTipo(tipo) {
        tipoSeleccionado = tipo;
    }

    function generarCampana() {
        if (!tipoSeleccionado) {
            alert('Selecciona un tipo de campaña.');
            return;
        }

        var etiquetas = { GR: 'Gran Recogida', primavera: 'Operación Primavera' };

        document.getElementById('modalTipoLabel').textContent =
            (etiquetas[tipoSeleccionado] || tipoSeleccionado);

        document.getElementById('inputFechaInicio').value = '';
        document.getElementById('inputFechaFin').value    = '';
        document.getElementById('errorFechas').style.display = 'none';
        document.getElementById('modalFechas').style.display = 'flex';
    }

    function confirmarGeneracion() {
        var fi  = document.getElementById('inputFechaInicio').value;
        var ff  = document.getElementById('inputFechaFin').value;
        var err = document.getElementById('errorFechas');

        if (!fi || !ff) {
            err.textContent = 'Ambas fechas son obligatorias.';
            err.style.display = 'block';
            return;
        }
        if (ff <= fi) {
            err.textContent = 'La fecha de fin debe ser posterior a la de inicio.';
            err.style.display = 'block';
            return;
        }

        var anyo = parseInt(fi.substring(0, 4), 10);
        var etiquetas = { GR: 'Gran Recogida', primavera: 'Operación Primavera' };

        var yaExiste = todasCampanas.some(function(c) {
            return c.tipo === tipoSeleccionado && c.nombre.indexOf(String(anyo)) !== -1;
        });

        if (yaExiste) {
            err.textContent = 'Ya existe una campaña de tipo "' + (etiquetas[tipoSeleccionado] || tipoSeleccionado) + '" para ' + anyo + '.';
            err.style.display = 'block';
            return;
        }

        document.getElementById('campanaNombre').value      = tipoSeleccionado + ' ' + anyo;
        document.getElementById('campanaTipo').value         = tipoSeleccionado;
        document.getElementById('campanaEstado').value      = 'ACTIVA';
        document.getElementById('campanaEditId').value      = '';
        document.getElementById('campanaFechaInicio').value = fi;
        document.getElementById('campanaFechaFin').value    = ff;

        cerrarModal();
        document.querySelector('form').submit();
    }

    function cerrarModal() {
        document.getElementById('modalFechas').style.display = 'none';
    }

    function verHistorial() {
        var tbody = document.getElementById('tbodyHistorial');
        tbody.innerHTML = '';

        if (todasCampanas.length === 0) {
            tbody.innerHTML = '<tr><td colspan="6"><em>No hay campañas registradas.</em></td></tr>';
        } else {
            todasCampanas.forEach(function(c) {
                var tr = document.createElement('tr');
                tr.innerHTML =
                    '<td>' + (c.nombre || '(sin nombre)') + '</td>' +
                    '<td>' + (c.tipo        || '') + '</td>' +
                    '<td>' + (c.estado      || '') + '</td>' +
                    '<td>' + (c.fechaInicio || '') + '</td>' +
                    '<td>' + (c.fechaFin    || '') + '</td>' +
                    '<td><a href="campanas/editar?id=' + c.id + '" class="btn-editar-historial" style="display:inline-block;text-decoration:none;">Editar</a></td>';
                tbody.appendChild(tr);
            });
        }

        document.getElementById('divHistorial').style.display = 'flex';
    }


</script>

</body>
</html>