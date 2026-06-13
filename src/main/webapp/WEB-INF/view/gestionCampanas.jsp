<%@ page import="es.uma.tsaw.proyectobancosol.dto.CampanyaDTO" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.CadenaEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.CadenaEntity" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<CampanyaDTO> campanas = (List<CampanyaDTO>) request.getAttribute("campanas");
    List<CadenaEntity> cadenaEntities = (List<CadenaEntity>)      request.getAttribute("cadenaEntities");
    String cadenasJson         = (String) request.getAttribute("cadenasJson");
    String campanasJson        = (String) request.getAttribute("campanasJson");
%>

<html>
<head>
    <title>Gestión de Campañas - Bancosol</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style_bancosol.css">
</head>
<body class="page-campanyaEntity">

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
            <div class="campanyaEntity-column">
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
            <div class="box cadenaEntities-box">
                <h2>Cadenas
                    <span id="campanaSeleccionadaLabel" style="font-weight:normal;font-size:0.85em;"></span>
                </h2>
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
                        <input type="hidden" name="cadenasBorrar"
                               value="<%= cad.getIdCadena() %>"
                               id="borrar_<%= cad.getIdCadena() %>"
                               disabled>
                        <div class="cadenaEntity-btn-group">
                            <a href="campanas/cadenaEntities/editar?id=<%= cad.getIdCadena() %>" class="btn-edit-cadenaEntity">Editar</a>
                            <button type="button" onclick="marcarParaBorrar(<%= cad.getIdCadena() %>)">Eliminar</button>
                        </div>
                    </div>
                    <%
                            }
                        }
                    %>
                </div>
                <div class="cadenaEntities-actions">
                    <a href="campanas/cadenaEntities/nueva" class="add-cadenaEntity-link">+ Añadir cadenaEntity</a>
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
            <div class="modal-content">
                <div class="modal-header">
                    <h2>Historial de campañas</h2>
                    <button type="button" class="modal-close-btn" onclick="document.getElementById('divHistorial').style.display='none'">&times;</button>
                </div>
                <div class="modal-body">
                    <table>
                        <thead>
                        <tr>
                            <th>Nombre</th>
                            <th>Tipo</th>
                            <th>Estado</th>
                            <th>Fecha inicio</th>
                            <th>Fecha fin</th>
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

    var cadenasporCampana = <%= cadenasJson  != null ? cadenasJson  : "{}" %>;
    var datosCampanas     = <%= campanasJson != null ? campanasJson : "{}" %>;

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

        var anyo = new Date().getFullYear();
        var etiquetas = { GR: 'Gran Recogida', primavera: 'Operación Primavera' };

        var yaExiste = todasCampanas.some(function(c) {
            return c.tipo === tipoSeleccionado && c.nombre.indexOf(String(anyo)) !== -1;
        });

        if (yaExiste) {
            alert('Ya existe una campaña de tipo "' + (etiquetas[tipoSeleccionado] || tipoSeleccionado) + '" para ' + anyo + '.');
            return;
        }

        document.getElementById('modalTipoLabel').textContent =
            (etiquetas[tipoSeleccionado] || tipoSeleccionado) + ' ' + anyo;

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

        var anyo = new Date().getFullYear();
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
            tbody.innerHTML = '<tr><td colspan="5"><em>No hay campañas registradas.</em></td></tr>';
        } else {
            todasCampanas.forEach(function(c) {
                var tr = document.createElement('tr');
                tr.innerHTML =
                    '<td><a href="#" onclick="seleccionarCampana(' + c.id + '); return false;">' + (c.nombre || '(sin nombre)') + '</a></td>' +
                    '<td>' + (c.tipo        || '') + '</td>' +
                    '<td>' + (c.estado      || '') + '</td>' +
                    '<td>' + (c.fechaInicio || '') + '</td>' +
                    '<td>' + (c.fechaFin    || '') + '</td>';
                tbody.appendChild(tr);
            });
        }

        document.getElementById('divHistorial').style.display = 'flex';
    }

    function seleccionarCampana(id) {
        var datos = datosCampanas[id];
        if (!datos) return;

        document.getElementById('campanaEditId').value       = id;
        document.getElementById('campanaNombre').value       = datos.nombre;
        document.getElementById('campanaTipo').value         = datos.tipo;
        document.getElementById('campanaEstado').value       = datos.estado;
        document.getElementById('campanaFechaInicio').value  = datos.fechaInicio;
        document.getElementById('campanaFechaFin').value     = datos.fechaFin;

        document.getElementById('campanaSeleccionadaLabel').textContent =
            '— editando: ' + (datos.nombre || '(sin nombre)');

        var ids = cadenasporCampana[id] || [];
        document.querySelectorAll('input[name="cadenaIds"]').forEach(function(cb) {
            cb.checked = ids.indexOf(parseInt(cb.value)) !== -1;
        });
    }

    function marcarParaBorrar(idCadena) {
        document.getElementById('fila_'   + idCadena).style.display = 'none';
        document.getElementById('cad_'    + idCadena).checked = false;
        document.getElementById('borrar_' + idCadena).disabled = false;
    }

</script>

</body>
</html>