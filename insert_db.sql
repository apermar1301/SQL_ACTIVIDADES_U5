-- 05-actividades-01-script.txt
-- Script DDL + DML para Actividades Prácticas 01 (UD5)

DROP DATABASE IF EXISTS insert_db;
CREATE DATABASE insert_db CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci;
USE insert_db;

CREATE TABLE oficinas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  codigoOficina VARCHAR(10) NOT NULL UNIQUE,
  ciudad VARCHAR(60) NOT NULL,
  pais VARCHAR(60) NOT NULL,
  codigoPostal VARCHAR(10),
  telefono VARCHAR(30),
  lineaDireccion1 VARCHAR(120)
);

CREATE TABLE empleados (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  apellido1 VARCHAR(50) NOT NULL,
  apellido2 VARCHAR(50),
  email VARCHAR(100) NOT NULL UNIQUE,
  puesto VARCHAR(60),
  idOficina INT NOT NULL,
  FOREIGN KEY (idOficina) REFERENCES oficinas(id)
);

CREATE TABLE clientes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombreCliente VARCHAR(80) NOT NULL,
  nombreContacto VARCHAR(80),
  telefono VARCHAR(30),
  ciudad VARCHAR(60),
  pais VARCHAR(60),
  idEmpleadoRepVentas INT,
  FOREIGN KEY (idEmpleadoRepVentas) REFERENCES empleados(id)
);

CREATE TABLE gamasProductos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  gama VARCHAR(60) NOT NULL UNIQUE,
  descripcionTexto VARCHAR(255)
);

CREATE TABLE productos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombreProducto VARCHAR(120) NOT NULL,
  precioVenta DECIMAL(10,2) NOT NULL,
  cantidadEnStock INT NOT NULL DEFAULT 0,
  idGama INT NOT NULL,
  FOREIGN KEY (idGama) REFERENCES gamasProductos(id)
);

CREATE TABLE pedidos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  fechaPedido DATE NOT NULL,
  estado VARCHAR(30) NOT NULL,
  idCliente INT NOT NULL,
  FOREIGN KEY (idCliente) REFERENCES clientes(id)
);

CREATE TABLE pagos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  formaPago VARCHAR(40) NOT NULL,
  cantidad DECIMAL(12,2) NOT NULL,
  fechaPago DATE NOT NULL,
  idCliente INT NOT NULL,
  FOREIGN KEY (idCliente) REFERENCES clientes(id)
);

INSERT INTO oficinas (codigoOficina, ciudad, pais, codigoPostal, telefono, lineaDireccion1) VALUES
('MAD-ES','Madrid','España','28001','+34 911 000 001','C/ Gran Vía, 1'),
('BCN-ES','Barcelona','España','08001','+34 931 000 002','C/ Pelai, 12'),
('SEV-ES','Sevilla','España','41001','+34 954 000 003','Av. de la Constitución, 3');

INSERT INTO empleados (nombre, apellido1, email, puesto, idOficina) VALUES
('Ana','García','ana.garcia@jardineria.es','Director Ventas',1),
('Javier','López','javier.lopez@jardineria.es','Representante Ventas',1),
('Marta','Sánchez','marta.sanchez@jardineria.es','Representante Ventas',2);

INSERT INTO clientes (nombreCliente, nombreContacto, telefono, ciudad, pais, idEmpleadoRepVentas) VALUES
('Jardines del Sur','Juan Pérez','+34 955 111 111','Sevilla','España',2),
('Urban Garden','John Smith','+34 913 444 444','Madrid','España',2),
('Barcelona Plants','Jordi Serra','+34 932 555 555','Barcelona','España',3),
('Viveros Mediterraneo','José Torres','+34 950 333 333','Almería','España',NULL);

INSERT INTO gamasProductos (gama, descripcionTexto) VALUES
('Herramientas','Herramientas de poda y cuidado'),
('Ornamentales','Plantas ornamentales'),
('Aromaticas','Plantas aromáticas'),
('Frutales','Árboles frutales');

INSERT INTO productos (nombreProducto, precioVenta, cantidadEnStock, idGama) VALUES
('Set de poda básico',49.90,120,1),
('Set profesional de jardinería',129.50,35,1),
('Maceta ornamental grande',22.00,80,2),
('Lavanda aromatica',6.50,300,3),
('Naranjo frutal',35.00,40,4);

INSERT INTO pedidos (fechaPedido, estado, idCliente) VALUES
('2009-02-10','Pendiente',1),
('2009-12-05','Pendiente',3),
('2010-03-15','Enviado',2);

INSERT INTO pagos (formaPago, cantidad, fechaPago, idCliente) VALUES
('Transferencia',35000.00,'2010-03-20',2),
('Transferencia',22000.00,'2009-12-10',3),
('Tarjeta',250.00,'2009-07-25',1);
