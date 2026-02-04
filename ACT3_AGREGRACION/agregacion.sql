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

-- ACT6: Clientes por país
SELECT
    pais,
    COUNT(*)
FROM
    clientes
ORDER BY
    pais;

-- ACT7: Productos por gama
SELECT
    idGama,
    COUNT(*)
FROM
    productos
GROUP BY
    idGama;

-- ACT8: Stock medio por gama
SELECT
    idGama,
    AVG(stock) AS mediaStock
FROM
    productos
GROUP BY
    idGama;

-- ACT9: Pedidos por año y estado
SELECT
    YEAR (fecha) AS año,
    estado,
    COUNT(*) AS total
FROM
    pedidos
GROUP BY
    YEAR (fecha),
    estado;

-- ACT10: Pagos por cliente
SELECT
    idCliente,
    COUNT(cantidad) AS cantidad
FROM
    pagos
GROUP BY
    idCliente;

-- ACT11: Estados con alto volumen
SELECT
    ID,
    estado,
    COUNT(*)
FROM
    pedidos
GROUP BY
    estado
HAVING
    COUNT(*) > 10;

-- ACT12: Clientes con grandes pagos acumulados
SELECT
    idCliente,
    SUM(cantidad)
FROM
    pagos
GROUP BY
    idCliente
HAVING
    SUM(cantidad) > 500;

-- ACT13: Valor total del stock por gama
SELECT
    idGama,
    stock * precio as ValorTotal
from
    productos
GROUP by idGama;

-- ACT14: Pedido más reciente por cliente
Select
    idCliente,
    MAX(fecha) AS fecha_ultimo_pedido
from
    pedidos
group by
    idCliente
