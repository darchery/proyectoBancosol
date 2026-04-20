-- =============================================================
-- BANCOSOL ALIMENTOS - Gestión de Campañas
-- Script de creación de base de datos
-- Schema: CAMPANYAS
-- =============================================================

-- -------------------------------------------------------------
-- SCHEMA
-- -------------------------------------------------------------
CREATE SCHEMA CAMPANYAS;

-- -------------------------------------------------------------
-- DIRECCION
-- Zona geográfica y distrito. Usada por Tienda y Colaborador.
-- -------------------------------------------------------------
CREATE TABLE CAMPANYAS.DIRECCION (
    ID_DIRECCION   INTEGER       NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    ZONA_GEOGRAFICA VARCHAR(100),
    DISTRITO        VARCHAR(100),
    CONSTRAINT PK_DIRECCION PRIMARY KEY (ID_DIRECCION)
);

-- -------------------------------------------------------------
-- USUARIO
-- Usuarios del sistema. Se relaciona con todos los roles.
-- TipoUsuario: administrador | coordinador | capitan |
--              capitan_coordinador | responsable_entidad | responsable_tienda
-- -------------------------------------------------------------
CREATE TABLE CAMPANYAS.USUARIO (
    ID_USUARIO   INTEGER       NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    TIPO_USUARIO VARCHAR(30)   NOT NULL CHECK (TIPO_USUARIO IN (
                                    'administrador',
                                    'coordinador',
                                    'capitan',
                                    'capitan_coordinador',
                                    'responsable_entidad',
                                    'responsable_tienda'
                                )),
    NOMBRE       VARCHAR(100)  NOT NULL,
    CONTRASENA   VARCHAR(255)  NOT NULL,
    CONSTRAINT PK_USUARIO PRIMARY KEY (ID_USUARIO)
);

-- -------------------------------------------------------------
-- CADENA
-- Cadena de supermercados (Mercadona, Carrefour, Lidl...).
-- Una cadena participa en muchas campañas.
-- -------------------------------------------------------------
CREATE TABLE CAMPANYAS.CADENA (
    ID_CADENA      INTEGER      NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    NOMBRE_CADENA  VARCHAR(100) NOT NULL,
    PARTICIPA_EN   SMALLINT     DEFAULT 1,
    CONSTRAINT PK_CADENA PRIMARY KEY (ID_CADENA)
);

-- -------------------------------------------------------------
-- TIENDA
-- Tienda de una cadena. Pertenece a una cadena y tiene dirección.
-- Una tienda está asignada a un coordinador (vía AsignacionCoordinador).
-- -------------------------------------------------------------
CREATE TABLE CAMPANYAS.TIENDA (
    ID_TIENDA      INTEGER      NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    ID_CADENA      INTEGER      NOT NULL,
    ID_DIRECCION   INTEGER,
    PARTICIPA      SMALLINT     DEFAULT 1,
    FRANQUICIA     SMALLINT     DEFAULT 0,
    LINEALES       INTEGER,
    RESENA_CADENA  VARCHAR(200),
    DOMICILIO      VARCHAR(255),
    DISTRITO       VARCHAR(100),
    CLASIFICACION  VARCHAR(200),
    CONSTRAINT PK_TIENDA       PRIMARY KEY (ID_TIENDA),
    CONSTRAINT FK_TIENDA_CADENA    FOREIGN KEY (ID_CADENA)    REFERENCES CAMPANYAS.CADENA (ID_CADENA),
    CONSTRAINT FK_TIENDA_DIRECCION FOREIGN KEY (ID_DIRECCION) REFERENCES CAMPANYAS.DIRECCION (ID_DIRECCION)
);

-- -------------------------------------------------------------
-- COORDINADOR
-- Extiende Usuario (1:1). Gestiona tiendas y colaboradores asignados.
-- Una tienda tiene X coordinadores.
-- -------------------------------------------------------------
CREATE TABLE CAMPANYAS.COORDINADOR (
    ID_USUARIO      INTEGER      NOT NULL,
    ID_TIENDA       INTEGER,
    NOMBRE_COMPLETO VARCHAR(150),
    CAPITAN         SMALLINT     DEFAULT 0,
    TELEFONO        VARCHAR(20),
    EMAIL           VARCHAR(150),
    OBSERVACIONES   VARCHAR(500),
    CONSTRAINT PK_COORDINADOR        PRIMARY KEY (ID_USUARIO),
    CONSTRAINT FK_COORD_USUARIO      FOREIGN KEY (ID_USUARIO) REFERENCES CAMPANYAS.USUARIO (ID_USUARIO),
    CONSTRAINT FK_COORD_TIENDA       FOREIGN KEY (ID_TIENDA)  REFERENCES CAMPANYAS.TIENDA (ID_TIENDA)
);

-- -------------------------------------------------------------
-- CAMPANYA
-- Campaña de recogida. Tipo: GR (Gran Recogida) / primavera.
-- Una cadena participa en muchas campañas (relación N:M via CAMPANYA_CADENA).
-- -------------------------------------------------------------
CREATE TABLE CAMPANYAS.CAMPANYA (
    ID_CAMPANYA    INTEGER      NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    TIPO_CAMPANYA  VARCHAR(50),
    FECHA_INICIO   DATE,
    FECHA_FIN      DATE,
    ESTADO         VARCHAR(50),
    CONSTRAINT PK_CAMPANYA PRIMARY KEY (ID_CAMPANYA)
);

-- -------------------------------------------------------------
-- CAMPANYA_CADENA  (tabla puente N:M)
-- Una cadena participa en muchas campañas.
-- Una tienda participa en una campaña.
-- -------------------------------------------------------------
CREATE TABLE CAMPANYAS.CAMPANYA_CADENA (
    ID_CAMPANYA  INTEGER NOT NULL,
    ID_CADENA    INTEGER NOT NULL,
    CONSTRAINT PK_CAMPANYA_CADENA   PRIMARY KEY (ID_CAMPANYA, ID_CADENA),
    CONSTRAINT FK_CAMPCAD_CAMPANYA  FOREIGN KEY (ID_CAMPANYA) REFERENCES CAMPANYAS.CAMPANYA (ID_CAMPANYA),
    CONSTRAINT FK_CAMPCAD_CADENA    FOREIGN KEY (ID_CADENA)   REFERENCES CAMPANYAS.CADENA (ID_CADENA)
);

-- -------------------------------------------------------------
-- ASIGNACION_COORDINADOR
-- Asignación de un coordinador a una tienda dentro de una campaña.
-- La asignación es distinta en Primavera que en Gran Recogida.
-- Un coordinador se relaciona con sus asignaciones.
-- -------------------------------------------------------------
CREATE TABLE CAMPANYAS.ASIGNACION_COORDINADOR (
    ID_ASIGNACION  INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    ID_CAMPANYA    INTEGER NOT NULL,
    ID_TIENDA      INTEGER NOT NULL,
    ID_COORDINADOR INTEGER NOT NULL,
    CONSTRAINT PK_ASIGNACION         PRIMARY KEY (ID_ASIGNACION),
    CONSTRAINT FK_ASIG_CAMPANYA      FOREIGN KEY (ID_CAMPANYA)    REFERENCES CAMPANYAS.CAMPANYA (ID_CAMPANYA),
    CONSTRAINT FK_ASIG_TIENDA        FOREIGN KEY (ID_TIENDA)      REFERENCES CAMPANYAS.TIENDA (ID_TIENDA),
    CONSTRAINT FK_ASIG_COORDINADOR   FOREIGN KEY (ID_COORDINADOR) REFERENCES CAMPANYAS.COORDINADOR (ID_USUARIO)
);

-- -------------------------------------------------------------
-- ENTIDAD_COLABORADORA
-- Entidad que aporta voluntarios (ayuntamiento, colegio, familia...).
-- Cada colaborador puede tener múltiples personas de contacto.
-- Un colaborador está asignado a un coordinador.
-- -------------------------------------------------------------
CREATE TABLE CAMPANYAS.ENTIDAD_COLABORADORA (
    ID_COLABORADOR    INTEGER      NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    ID_DIRECCION      INTEGER,
    NOMBRE_COLABORADOR VARCHAR(200) NOT NULL,
    DOMICILIO         VARCHAR(255),
    LIGADO_A_BANCOSOL SMALLINT     DEFAULT 0,
    TIPO              VARCHAR(50),
    OBSERVACIONES     VARCHAR(500),
    NUMERO_VOLUNTARIOS INTEGER,
    CONSTRAINT PK_ENTIDAD_COLAB       PRIMARY KEY (ID_COLABORADOR),
    CONSTRAINT FK_COLAB_DIRECCION     FOREIGN KEY (ID_DIRECCION) REFERENCES CAMPANYAS.DIRECCION (ID_DIRECCION)
);

-- -------------------------------------------------------------
-- CONTACTO
-- Persona de contacto de una entidad colaboradora.
-- Cada colaborador puede tener múltiples contactos.
-- -------------------------------------------------------------
CREATE TABLE CAMPANYAS.CONTACTO (
    ID_CONTACTO    INTEGER      NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    ID_COLABORADOR INTEGER      NOT NULL,
    NOMBRE         VARCHAR(150),
    EMAIL          VARCHAR(150),
    TELEFONO       VARCHAR(20),
    CONSTRAINT PK_CONTACTO         PRIMARY KEY (ID_CONTACTO),
    CONSTRAINT FK_CONTACTO_COLAB   FOREIGN KEY (ID_COLABORADOR) REFERENCES CAMPANYAS.ENTIDAD_COLABORADORA (ID_COLABORADOR)
);

-- -------------------------------------------------------------
-- PARTICIPACION_VOLUNTARIOS
-- Participación de una entidad colaboradora en una tienda
-- dentro de una campaña.
-- Cada participación tiene uno o más colaboradores.
-- El número de registros VOLUNTARIO asociados indica cuántos participan.
-- -------------------------------------------------------------
CREATE TABLE CAMPANYAS.PARTICIPACION_VOLUNTARIOS (
    ID_PARTICIPACION INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    ID_CAMPANYA      INTEGER NOT NULL,
    ID_TIENDA        INTEGER NOT NULL,
    ID_COLABORADOR   INTEGER NOT NULL,
    CONSTRAINT PK_PARTICIPACION         PRIMARY KEY (ID_PARTICIPACION),
    CONSTRAINT FK_PART_CAMPANYA         FOREIGN KEY (ID_CAMPANYA)    REFERENCES CAMPANYAS.CAMPANYA (ID_CAMPANYA),
    CONSTRAINT FK_PART_TIENDA           FOREIGN KEY (ID_TIENDA)      REFERENCES CAMPANYAS.TIENDA (ID_TIENDA),
    CONSTRAINT FK_PART_COLABORADOR      FOREIGN KEY (ID_COLABORADOR) REFERENCES CAMPANYAS.ENTIDAD_COLABORADORA (ID_COLABORADOR)
);

-- -------------------------------------------------------------
-- TURNO_POR_DIA
-- Turno de una participación para un día concreto.
-- Si una persona participa varios días, tendrá varios registros,
-- cada uno con su DIA (enum) indicando qué día va.
-- DIA:     Viernes | Sabado | Domingo
-- HORARIO: manyana | tarde | jornada_completa
-- -------------------------------------------------------------
CREATE TABLE CAMPANYAS.TURNO_POR_DIA (
    ID_TURNO         INTEGER     NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    ID_PARTICIPACION INTEGER     NOT NULL,
    DIA              VARCHAR(10) CHECK (DIA IN ('Viernes', 'Sabado', 'Domingo')),
    HORARIO          VARCHAR(20) CHECK (HORARIO IN ('manyana', 'tarde', 'jornada_completa')),
    HORA_INICIO      VARCHAR(5),
    HORA_FIN         VARCHAR(5),
    CONSTRAINT PK_TURNO_POR_DIA     PRIMARY KEY (ID_TURNO),
    CONSTRAINT FK_TURNO_PARTICIPACION FOREIGN KEY (ID_PARTICIPACION) REFERENCES CAMPANYAS.PARTICIPACION_VOLUNTARIOS (ID_PARTICIPACION)
);

-- -------------------------------------------------------------
-- VOLUNTARIO
-- Voluntario individual dentro de una participación.
-- El número de filas por participación indica cuántos voluntarios hay.
-- Cada participación tiene un turno.
-- -------------------------------------------------------------
CREATE TABLE CAMPANYAS.VOLUNTARIO (
    ID_VOLUNTARIO    INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    ID_DIRECCION     INTEGER,
    ID_TIENDA        INTEGER,
    ID_TURNO         INTEGER,
    ID_USUARIO       INTEGER,
    ID_PARTICIPACION INTEGER,
    HORARIOS         VARCHAR(200),
    CONSTRAINT PK_VOLUNTARIO           PRIMARY KEY (ID_VOLUNTARIO),
    CONSTRAINT FK_VOL_DIRECCION        FOREIGN KEY (ID_DIRECCION)     REFERENCES CAMPANYAS.DIRECCION (ID_DIRECCION),
    CONSTRAINT FK_VOL_TIENDA           FOREIGN KEY (ID_TIENDA)        REFERENCES CAMPANYAS.TIENDA (ID_TIENDA),
    CONSTRAINT FK_VOL_TURNO            FOREIGN KEY (ID_TURNO)         REFERENCES CAMPANYAS.TURNO_POR_DIA (ID_TURNO),
    CONSTRAINT FK_VOL_USUARIO          FOREIGN KEY (ID_USUARIO)       REFERENCES CAMPANYAS.USUARIO (ID_USUARIO),
    CONSTRAINT FK_VOL_PARTICIPACION    FOREIGN KEY (ID_PARTICIPACION) REFERENCES CAMPANYAS.PARTICIPACION_VOLUNTARIOS (ID_PARTICIPACION)
);
