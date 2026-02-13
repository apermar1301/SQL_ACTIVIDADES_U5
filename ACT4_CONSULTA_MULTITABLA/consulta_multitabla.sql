-- ACT1: Pedidos con datos del cliente
SELECT
    p.id,
    p.fecha,
    p.estado,
    c.nombre AS cliente
FROM
    pedidos AS p
    INNER JOIN clientes AS c ON p.idCliente = c.id;

-- ACT2: Clientes que han realizado pedidos
SELECT DISTINCT
    c.id,
    c.nombre
FROM
    clientes AS c
    INNER JOIN pedidos AS p ON c.id = p.idCliente;

-- ACT3: Productos y su Categoría
SELECT
    p.nombre AS producto,
    g.nombre AS gama
FROM
    productos AS p
    INNER JOIN gamas AS g ON g.ig = p.idGama;

-- ACT4: Clientes con o sin pedidos
SELECT
    c.nombre,
    COUNT(p.*)
FROM
    clientes AS p
    LEFT JOIN pedidos ON c.id = p.idCliente;

-- ACT5: Clientes sin pedidos
SELECT
    c.nombre
FROM
    clientes c
    LEFT JOIN pedidos p ON c.id = p.idCliente
WHERE
    p.ID IS NULL;

-- ACT6: Oficina y sus empleados
SELECT
    e.nombre,
    e.apellido1,
    e.apellido2,
    o.ciudad,
    o.telefono
FROM
    empleados e
    LEFT JOIN oficinas o ON o.id = e.idOficina;

-- ACT7: Pedidos con cliente y representante de ventas
SELECT
    p.id AS idPedido,
    c.nombre AS nombreCliente,
    e.nombre AS nombreRepresentante
FROM
    pedidos p
    INNER JOIN clientes c ON p.idCliente = c.id
    LEFT JOIN empleados e ON c.idEmpleado = e.id
ORDER BY
    p.id;

-- ACT8: Ubicación de los empleados
SELECT
    e.nombre AS nombreEmpleado,
    e.puesto AS puestoEmpleado,
    o.ciudad AS ciudadOficina,
    o.pais AS paisOficina
FROM
    empleados e
    LEFT JOIN oficinas o ON e.idOficina = o.id;

-- ACT9: Contenido de los pedidos (Relación N:M)
SELECT
    dp.idPedido AS idPedido,
    pr.nombre AS nombreProducto,
    dp.cantidad AS cantidad,
    dp.precioUnidad AS precioUnitario
FROM
    detallesPedidos dp
    INNER JOIN productos pr ON dp.idProducto = pr.id
    INNER JOIN pedidos pe ON dp.idPedido = pe.id;

-- ACT10: Historial de Pagos completo
SELECT
    p.fecha AS fechaPago,
    p.cantidad AS cantidadPago,
    c.nombre AS nombreCliente
FROM
    pagos p
    INNER JOIN clientes c ON p.idCLiente = c.id;

-- ACT11: Pagos y Representantes
SELECT
    p.id,
    c.nombre AS nombreCliente,
    e.nombre AS nombreRepresentante
FROM
    pagos p
    INNER JOIN clientes c ON p.idCliente = c.id
    LEFT JOIN empleados e ON c.idEmpleado = e.id
ORDER BY
    p.id;

-- ACT12: Número de pedidos por cliente
SELECT
    c.id AS idCliente,
    c.nombre AS nombreCliente,
    COUNT(p.id) AS totalPedidos
FROM
    clientes c
    LEFT JOIN pedidos p ON c.id = p.idCliente
GROUP BY
    c.id,
    c.nombre
ORDER BY
    totalPedidos DESC;

-- ACT13: Importe total pagado por cliente
SELECT
    c.nombre AS nombreCliente,
    SUM(p.cantidad) AS totalPagado
FROM
    pagos p
    INNER JOIN clientes c ON p.idCliente = c.id
GROUP BY
    c.id,
    c.nombre