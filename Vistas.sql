
-- CREATE THE VIEW
create view datos as select primer_nombre, segundo_apellido from empleados;

-- USING VIEW
select * from datos;

-- CREATE THE VIEW
create view datos2 (nombrePrimero, apellidoSegundo) as select primer_nombre, segundo_apellido from empleados;

-- USING VIEW
select * from datos2;