-- ACT1: Descripción del estado de los pedidos
SELECT
    *,
    CASE estado
        WHEN 'Entregado' THEN 'Pedido Entregado'
        WHEN 'Enviado' THEN 'Pedido en camino'
        WHEN 'Pendiente' THEN 'Pedido pendiente'
        WHEN 'Rechazado' THEN 'Pedido Rechazado'
    END AS descripcion
FROM
    pedidos;

-- ACT2: Situación de los clientes respecto a ventas
SELECT
    *,
    CASE
        WHEN idEmpleado IS NULL THEN 'SIN REPRESENTANTE'
        ELSE 'CON REPRESENTANTE'
    END AS REPRESENTANTE
FROM
    clientes;

-- ACT3: Clasificación comercial de productos
SELECT
    nombre,
    CASE
        WHEN precio < 20 THEN 'ECONÓMICO'
        WHEN precio >= 20
        AND precio <= 100 THEN 'INTERMEDIOS'
        WHEN precio > 100 THEN 'GAMA ALTA'
    END AS GAMA
FROM
    productos;

-- ACT4: Estado operativo del stock
SELECT
    nombre,
    CASE
        WHEN stock = 0 THEN 'AUSENCIA DE EXISTENCIAS'
        WHEN stock < 20 THEN 'NIVELES CRITICOS'
        ELSE 'STOCK SUFICIENTE'
    END
FROM
    productos;

-- ACT5: Precio final y valoración
SELECT
    nombre,
    precio,
    precio * 1.21 AS IVA,
    CASE
        WHEN precio * 1.21 < 10 THEN 'ACCESIBLE'
        ELSE 'INVERSION'
    END
FROM
    productos;

-- ACT6: Prioridad de atención de pedidos
SELECT
    *
FROM
    pedidos
ORDER BY
    CASE estado
        WHEN 'Pendiente' THEN 1
        WHEN 'Enviado' THEN 2
        WHEN 'Entregado' THEN 3
        WHEN 'Rechazado' THEN 4
    END;

-- ACT7: Informe resumido de pedidos
SELECT
    CASE
        WHEN estado = 'Entregado' THEN 'ENTREGADOS'
        WHEN estado = 'Rechazado' THEN 'RECHAZADOS'
        WHEN estado = 'Enviado' THEN 'ENVIADOS'
        WHEN estado = 'Pendiente' THEN 'PENDIENTES'
        ELSE 'OTROS'
    END AS tipoEstado,
    COUNT(*) AS totalPedidos
FROM
    pedidos
GROUP BY
    tipoEstado;