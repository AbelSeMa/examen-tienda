DROP TABLE IF EXISTS articulos CASCADE;

CREATE TABLE articulos (
    id          bigserial     PRIMARY KEY,
    codigo      varchar(13)   NOT NULL UNIQUE,
    descripcion varchar(255)  NOT NULL,
    precio      numeric(7, 2) NOT NULL,
    stock       int           NOT NULL
);

DROP TABLE IF EXISTS usuarios CASCADE;

CREATE TABLE usuarios (
    id       bigserial    PRIMARY KEY,
    usuario  varchar(255) NOT NULL UNIQUE,
    password varchar(255) NOT NULL,
    validado bool         NOT NULL
);

DROP TABLE IF EXISTS facturas CASCADE;

CREATE TABLE facturas (
    id         bigserial  PRIMARY KEY,
    created_at timestamp  NOT NULL DEFAULT localtimestamp(0),
    usuario_id bigint NOT NULL REFERENCES usuarios (id)
);

DROP TABLE IF EXISTS articulos_facturas CASCADE;

CREATE TABLE articulos_facturas (
    articulo_id bigint NOT NULL REFERENCES articulos (id),
    factura_id  bigint NOT NULL REFERENCES facturas (id),
    cantidad    int    NOT NULL,
    PRIMARY KEY (articulo_id, factura_id)
);

DROP TABLE IF EXISTS etiquetas CASCADE;

CREATE TABLE etiquetas (
    id      bigserial       PRIMARY KEY,
    nombre  varchar(255)    NOT NULL UNIQUE
);

DROP TABLE IF EXISTS articulos_etiquetas CASCADE;

CREATE TABLE articulos_etiquetas (
    id_articulo     bigint  NOT NULL REFERENCES articulos (id),
    id_etiqueta     bigint  NOT NULL REFERENCES etiquetas (id),
    PRIMARY KEY (id_articulo, id_etiqueta)
);

DROP TABLE IF EXISTS valoraciones CASCADE;

CREATE TABLE valoraciones (
    id_articulo     bigint      NOT NULL REFERENCES articulos (id),
    id_usuario      bigint      NOT NULL REFERENCES usuarios (id),
    valoracion      bigint      NOT NULL,
    PRIMARY KEY (id_articulo, id_usuario)

);

-- Carga inicial de datos de prueba:

INSERT INTO articulos (codigo, descripcion, precio, stock)
    VALUES ('18273892389', 'Bolso negro', 40.50, 20),
           ('83745828273', 'Zapato de tacón rojo', 50.99, 20),
           ('51736128495', 'Vestido corto estampado de flores', 91.30, 0),
           ('83746828273', 'Blusa de seda', 50.25, 20),
           ('51786128435', 'Camiseta levis mujer', 25.85, 20),
           ('83745228673', 'Zapatillas para la playa', 10.99, 20),
           ('51786198495', 'Bolso para la playa', 12.99, 20);

INSERT INTO usuarios (usuario, password, validado)
    VALUES ('admin', crypt('admin', gen_salt('bf', 10)), true),
           ('pepe', crypt('pepe', gen_salt('bf', 10)), false);

INSERT INTO etiquetas (nombre)
        VALUES ('verano'),
                ('invierno'),
                ('playa'),
                ('zapatos'),
                ('complementos'),
                ('ropa');


INSERT INTO articulos_etiquetas (id_articulo, id_etiqueta)
        VALUES (1, 5),
               (2, 4),
               (2, 2),
               (3, 1),
               (3, 3),
               (3, 6),
               (5, 6),
               (6, 3),
               (6, 5),
               (7, 5),
               (7, 3);


INSERT INTO valoraciones (id_articulo, id_usuario, valoracion)
        VALUES(1, 1, 5);
