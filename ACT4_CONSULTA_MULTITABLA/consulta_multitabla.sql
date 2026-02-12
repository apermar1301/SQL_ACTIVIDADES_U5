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
Select
    p.nombre as producto,
    g.nombre as gama
from
    productos as p
    inner join gamas as g on g.ig = p.idGama;

-- ACT4: Clientes con o sin pedidos
Select
    c.nombre,
    count(p.*)
from
    clientes as p
    left join pedidos on c.id = p.idCliente;