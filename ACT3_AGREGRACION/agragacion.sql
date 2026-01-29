-- ACT1: Número total de clientes
SELECT
    COUNT(*) AS totalClientes
FROM
    clientes;

-- ACT2: Total de pedidos
SELECT
    COUNT(*) AS totalPedidos
FROM
    pedidos;

-- ACT3: Importe total pagado
SELECT
    SUM(cantidad) AS total
FROM
    pagos;

-- ACT4: Pago medio
SELECT
    AVG(cantidad) AS pagoMedio
FROM
    pagos;

-- ACT5: Pedidos por estado
SELECT
    estado,
    COUNT(estado)
FROM
    pedidos;

GROUP BY
    estado;