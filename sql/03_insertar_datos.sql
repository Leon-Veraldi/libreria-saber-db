-- ============================================================
--  INSERCIÓN DE DATOS DE PRUEBA
-- ============================================================

USE libreria_saber;

-- EDITORIALES
INSERT INTO editorial (nombre, pais_origen, anio_fundacion, email_contacto) VALUES
('Planeta',         'España',    1949, 'contacto@planeta.es'),
('Sudamericana',    'Argentina', 1939, 'info@sudamericana.com.ar'),
('Siglo XXI',       'México',    1965, 'ventas@sigloxxieditores.com'),
('Alfaguara',       'España',    1964, 'info@alfaguara.com'),
('Emecé',           'Argentina', 1939, 'contacto@emece.com.ar');

-- AUTORES
INSERT INTO autor (nombre, apellido, nacionalidad, fecha_nacimiento) VALUES
('Gabriel',   'García Márquez', 'Colombiana',  '1927-03-06'),
('Jorge Luis', 'Borges',        'Argentina',   '1899-08-24'),
('Julio',      'Cortázar',      'Argentina',   '1914-08-26'),
('Isabel',     'Allende',       'Chilena',     '1942-08-02'),
('Mario',      'Vargas Llosa',  'Peruana',     '1936-03-28');

-- LIBROS
INSERT INTO libro (isbn, titulo, genero, anio_publicacion, precio, stock, id_editorial) VALUES
('978-84-376-0494-7', 'Cien años de soledad',      'Realismo mágico', 1967, 1850.00, 15, 4),
('978-84-204-8933-2', 'El aleph',                   'Cuento',          1949,  980.00, 10, 2),
('978-84-663-2710-6', 'Rayuela',                    'Novela',          1963, 1200.00,  8, 2),
('978-84-397-2235-9', 'La casa de los espíritus',  'Novela histórica', 1982, 1450.00, 12, 4),
('978-84-204-8956-1', 'La ciudad y los perros',    'Novela',           1963, 1100.00,  6, 2),
('978-84-204-6765-1', 'Ficciones',                 'Cuento',           1944,  890.00,  9, 2);

-- RELACIONES LIBRO-AUTOR
INSERT INTO libro_autor (id_libro, id_autor) VALUES
(1, 1), -- Cien años -> García Márquez
(2, 2), -- El aleph -> Borges
(3, 3), -- Rayuela -> Cortázar
(4, 4), -- La casa -> Allende
(5, 5), -- La ciudad -> Vargas Llosa
(6, 2); -- Ficciones -> Borges

-- CLIENTES
INSERT INTO cliente (nombre, apellido, email, telefono, fecha_registro) VALUES
('Lucía',    'Fernández', 'lucia.fernandez@email.com', '11-4523-8891', '2025-01-10'),
('Martín',   'Gómez',     'martin.gomez@email.com',    '11-3341-2200', '2025-02-15'),
('Valentina','López',     'vali.lopez@email.com',      '11-5567-9900', '2025-03-01'),
('Facundo',  'Herrera',   'facu.herrera@email.com',    '11-2210-4455', '2025-04-20'),
('Camila',   'Ramos',     'camila.ramos@email.com',    '11-6678-3312', '2025-05-05');

-- VENTAS
INSERT INTO venta (fecha_venta, total, id_cliente) VALUES
('2025-06-01 10:30:00', 3700.00, 1),
('2025-06-02 14:00:00', 1200.00, 2),
('2025-06-10 09:15:00', 2450.00, 3),
('2025-06-15 16:45:00', 1850.00, 4),
('2025-06-20 11:00:00', 1870.00, 5);

-- DETALLES DE VENTA
INSERT INTO detalle_venta (cantidad, precio_unitario, id_venta, id_libro) VALUES
(1, 1850.00, 1, 1), -- Venta 1: Cien años
(1, 1100.00, 1, 5), -- Venta 1: La ciudad y los perros
(1,  750.00, 1, 6), -- Venta 1: Ficciones
(1, 1200.00, 2, 3), -- Venta 2: Rayuela
(1, 1450.00, 3, 4), -- Venta 3: La casa de los espíritus
(1, 1000.00, 3, 2), -- Venta 3: El aleph
(1, 1850.00, 4, 1), -- Venta 4: Cien años
(1,  980.00, 5, 2), -- Venta 5: El aleph
(1,  890.00, 5, 6); -- Venta 5: Ficciones
