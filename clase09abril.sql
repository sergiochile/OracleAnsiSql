--Mostrar todos los apellidos de los empleados en Mayúsculas 
select UPPER(APELLIDO) as APELLIDO from EMP; 

--Construir una consulta para que salga la fecha de hoy con el siguiente formato: Martes 06 de Octubre de 2020 
select to_char(sysdate, 'Day DD "de" Month "de" YYYY') as FECHA from DUAL; -- Esto nos mostrara la fecha de hoy con el siguiente formato: Martes 06 de Octubre de 2020
select sysdate as FECHA_ACTUAL from DUAL; --ESTO MUESTRA LA FECHA ACTUAL DEL SISTEMA