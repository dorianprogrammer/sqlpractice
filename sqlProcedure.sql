CREATE OR REPLACE FUNCTION ConsultarPersonas() RETURNS void 
AS
$$
    DECLARE 
        rec record := NULL;
        contador integer := 0;

    BEGIN

        FOR rec IN SELECT * FROM "Persona" LOOP
           RAISE NOTICE 'La persona se llama %', rec.nombre;
        END LOOP
    
        RAISE NOTICE 'La cantidad de personas es: %', contador;

    END
$$
LANGUAGE PLPGSQL;


-- Para llamar a este proceso
SELECT ConsultarPersonas();
-- Borrar la funcion
DROP FUNCTION ConsultarPersonas(); 


-- Para que devuelva un valor
CREATE OR REPLACE FUNCTION ConsultarPersonas() RETURNS integr 
AS
$$
    DECLARE 
        rec record := NULL;
        contador integer := 0;

    BEGIN

        FOR rec IN SELECT * FROM "Persona" LOOP
           RAISE NOTICE 'La persona se llama %', rec.nombre;
            contador := contador + 1
        END LOOP
    
        RETURN contador;

    END
$$
LANGUAGE PLPGSQL;



-- Insertando un valor
CREATE OR REPLACE PROCEDURE InsertarPersona(varchar,varchar,varchar,varchar,varchar)
AS
$$
    INSERT INTO "Persona"(cedula, nombre, direccion, telefono, email)
        VALUES($1,$2,$3,$4,$5)
$$
LANGUAGE SQL;

CALL InsertarPersona("23423","OLGA CORTES", "LIBERIA","W45324534","SADF@ASDFSA.COM");


CREATE OR REPLACE PROCEDURE EliminarPersona(varchar)
AS
$$
    DELETE FROM "Persona" WHERE cedula = $1
$$
LANGUAGE SQL;


CALL EliminarPersona("F423423");


CREATE OR REPLACE PROCEDURE ActualizarNombre(varchar, varchar)
AS
$$
    UPDATE "Persona" SET nombre = $2 WHERE cedula = $1
$$
LANGUAGE SQL;

CALL ActualizarNombre('dasdas','CAMBIO NOMBRE');