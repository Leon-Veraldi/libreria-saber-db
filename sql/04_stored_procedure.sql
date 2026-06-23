-- ============================================================
--  STORED PROCEDURE: sp_reporte_ventas_cliente
--  Descripción: Genera un reporte completo de ventas por
--               cliente, mostrando libros comprados, totales
--               y cantidad de operaciones.
-- ============================================================

USE libreria_saber;

DELIMITER $$

DROP PROCEDURE IF EXISTS sp_reporte_ventas_cliente $$

CREATE PROCEDURE sp_reporte_ventas_cliente(
    IN  p_id_cliente    INT,
    IN  p_fecha_desde   DATE,
    IN  p_fecha_hasta   DATE,
    OUT p_total_gastado DECIMAL(10,2),
    OUT p_cant_compras  INT
)
BEGIN
    -- Variables locales
    DECLARE v_nombre_cliente VARCHAR(160);

    -- 1. Verificar que el cliente exista
    IF NOT EXISTS (SELECT 1 FROM cliente WHERE id_cliente = p_id_cliente) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: El cliente especificado no existe.';
    END IF;

    -- 2. Obtener nombre del cliente
    SELECT CONCAT(nombre, ' ', apellido)
    INTO   v_nombre_cliente
    FROM   cliente
    WHERE  id_cliente = p_id_cliente;

    -- 3. Calcular totales y asignar parámetros OUT
    SELECT COUNT(DISTINCT v.id_venta),
           COALESCE(SUM(v.total), 0)
    INTO   p_cant_compras,
           p_total_gastado
    FROM   venta v
    WHERE  v.id_cliente   = p_id_cliente
      AND  DATE(v.fecha_venta) BETWEEN p_fecha_desde AND p_fecha_hasta;

    -- 4. Detalle por libro comprado en el período
    SELECT
        v.id_venta                                  AS "ID Venta",
        DATE(v.fecha_venta)                         AS "Fecha",
        l.titulo                                    AS "Libro",
        CONCAT(a.nombre,' ',a.apellido)             AS "Autor",
        dv.cantidad                                 AS "Cant.",
        dv.precio_unitario                          AS "Precio Unit.",
        (dv.cantidad * dv.precio_unitario)          AS "Subtotal"
    FROM   venta         v
    JOIN   detalle_venta dv ON dv.id_venta = v.id_venta
    JOIN   libro         l  ON l.id_libro  = dv.id_libro
    JOIN   libro_autor   la ON la.id_libro = l.id_libro
    JOIN   autor         a  ON a.id_autor  = la.id_autor
    WHERE  v.id_cliente       = p_id_cliente
      AND  DATE(v.fecha_venta) BETWEEN p_fecha_desde AND p_fecha_hasta
    ORDER  BY v.fecha_venta, v.id_venta;

    -- 5. Mensaje resumen
    SELECT CONCAT(
        'Cliente: ', v_nombre_cliente,
        ' | Período: ', p_fecha_desde, ' al ', p_fecha_hasta,
        ' | Compras: ', p_cant_compras,
        ' | Total gastado: $', FORMAT(p_total_gastado, 2)
    ) AS "Resumen";

END $$

DELIMITER ;

-- ============================================================
--  EJECUCIÓN DEL PROCEDIMIENTO (ejemplo)
-- ============================================================

-- Llamada con variables de sesión para capturar los OUT
CALL sp_reporte_ventas_cliente(
    1,                    -- id_cliente (Lucía Fernández)
    '2025-01-01',         -- fecha_desde
    '2025-12-31',         -- fecha_hasta
    @total_gastado,       -- OUT: total gastado
    @cant_compras         -- OUT: cantidad de compras
);

-- Consulta de los valores OUT
SELECT
    @cant_compras  AS "Cantidad de Compras",
    @total_gastado AS "Total Gastado ($)";
