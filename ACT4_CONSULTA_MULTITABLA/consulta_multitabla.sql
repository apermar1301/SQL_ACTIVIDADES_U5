

-- Pedidos con datos del cliente
select
    p.id,
    p.fecha,
    p.estado,
    c.nombre as cliente
from
    pedidos as p
inner join clientes as c
    on p.idCliente = c.id