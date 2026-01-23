-- ACT1: Nombres de clientes en mayúscula
SELECT
    nombre,
    UPPER(nombre) AS nombreMayuscula
FROM
    clientes;

-- ACT2: Normalización de ciudades
SELECT
    nombre,
    LOWER(ciudad) AS ciudadMinuscula
FROM
    clientes;

-- ACT3: Nombre completo de empleados
SELECT
    concat (nombre, ' ', apellido1, ' ', apellido2) AS nombreCompleto
FROM
    empleados;

-- ACT4: Dirección completa de oficinas
SELECT
    concat (direccion, ', ', ciudad, ', ', cp, ', ', pais) AS direccion
FROM
    oficinas;

-- ACT5: Abreviatura de ciudad
SELECT
    nombre,
    ciudad,
    UPPER(LEFT (ciudad, 3)) AS ciudadAbr
FROM
    clientes;

-- ACT6: Logitud del nombre de los productos
select nombre, length(nombre) as nombreLongitud from clientes;

-- ACT7: Precio con IVA
Select nombre, round(precio*1.21,2) as 'precio+IVA' from productos;

-- ACT8: Precio sin decimales
Select nombre, truncate(precio,0) as precioTruncado from productos;

-- ACT9: Resto del stock
select nombre, MOD(precio, 10) as 'RESTO: stock/10' from productos; 

-- ACT10: Mees de los pedidos
SET lc_time_names = 'es_ES'; 
select id, monthname(fecha) as mes from pedidos;

-- ACT11: Fecha actual en los pedidos
Select nombre, fecha as fechaPedido, curdate() fechaActual from pedidos;

