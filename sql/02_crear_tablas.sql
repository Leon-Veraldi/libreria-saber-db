-- ============================================================
--  CREACIÓN DE TABLAS
-- ============================================================

USE libreria_saber;

-- Tabla: EDITORIAL
CREATE TABLE editorial (
    id_editorial    INT           NOT NULL AUTO_INCREMENT,
    nombre          VARCHAR(100)  NOT NULL,
    pais_origen     VARCHAR(60)   NOT NULL,
    anio_fundacion  YEAR,
    email_contacto  VARCHAR(120),
    PRIMARY KEY (id_editorial)
);

-- Tabla: AUTOR
CREATE TABLE autor (
    id_autor        INT           NOT NULL AUTO_INCREMENT,
    nombre          VARCHAR(80)   NOT NULL,
    apellido        VARCHAR(80)   NOT NULL,
    nacionalidad    VARCHAR(60),
    fecha_nacimiento DATE,
    PRIMARY KEY (id_autor)
);

-- Tabla: LIBRO
CREATE TABLE libro (
    id_libro        INT           NOT NULL AUTO_INCREMENT,
    isbn            VARCHAR(20)   NOT NULL UNIQUE,
    titulo          VARCHAR(200)  NOT NULL,
    genero          VARCHAR(60)   NOT NULL,
    anio_publicacion YEAR,
    precio          DECIMAL(8,2)  NOT NULL,
    stock           INT           NOT NULL DEFAULT 0,
    id_editorial    INT           NOT NULL,
    PRIMARY KEY (id_libro),
    CONSTRAINT fk_libro_editorial
        FOREIGN KEY (id_editorial) REFERENCES editorial(id_editorial)
);

-- Tabla: LIBRO_AUTOR (relación N:M entre libro y autor)
CREATE TABLE libro_autor (
    id_libro        INT NOT NULL,
    id_autor        INT NOT NULL,
    PRIMARY KEY (id_libro, id_autor),
    CONSTRAINT fk_la_libro
        FOREIGN KEY (id_libro) REFERENCES libro(id_libro),
    CONSTRAINT fk_la_autor
        FOREIGN KEY (id_autor) REFERENCES autor(id_autor)
);

-- Tabla: CLIENTE
CREATE TABLE cliente (
    id_cliente      INT           NOT NULL AUTO_INCREMENT,
    nombre          VARCHAR(80)   NOT NULL,
    apellido        VARCHAR(80)   NOT NULL,
    email           VARCHAR(120)  NOT NULL UNIQUE,
    telefono        VARCHAR(20),
    fecha_registro  DATE          NOT NULL DEFAULT (CURRENT_DATE),
    PRIMARY KEY (id_cliente)
);

-- Tabla: VENTA
CREATE TABLE venta (
    id_venta        INT           NOT NULL AUTO_INCREMENT,
    fecha_venta     DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total           DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    id_cliente      INT           NOT NULL,
    PRIMARY KEY (id_venta),
    CONSTRAINT fk_venta_cliente
        FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- Tabla: DETALLE_VENTA
CREATE TABLE detalle_venta (
    id_detalle      INT           NOT NULL AUTO_INCREMENT,
    cantidad        INT           NOT NULL,
    precio_unitario DECIMAL(8,2)  NOT NULL,
    id_venta        INT           NOT NULL,
    id_libro        INT           NOT NULL,
    PRIMARY KEY (id_detalle),
    CONSTRAINT fk_dv_venta
        FOREIGN KEY (id_venta)  REFERENCES venta(id_venta),
    CONSTRAINT fk_dv_libro
        FOREIGN KEY (id_libro)  REFERENCES libro(id_libro)
);
