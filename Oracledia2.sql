-- Tamaño de letra
-- COMENTARIOS

/*
mas de una linea de comentario
Aqui todas las consultas. 
*/

-- No diferencia mayusculas o minusculas en las palabras clave.

SELECT * FROM EMP; 

/* ESTOS DOS SON LO MISMO, PERO LA SEGUNDA LINEA CARGA MAS RAPIDO */
SELECT * FROM DEPT;
SELECT DEPT_NO, DNOMBRE, LOC FROM DEPT;
/* 24/03/2025 */


/*25/03/2025*/

select * from EMP;
-- la mejor praxis es utilizar el nombre de los campos
-- control + enter, ejecuta la linea en la que estamos posicionados
select APELLIDO, OFICIO, SALARIO from EMP;
select DIR, FECHA_ALT, COMISION from EMP;
-- ORDENACION DE DATOS, SIEMPRE AL FINAL Y AFECTA AL SELECT

--LA ORDENACION SIEMPRE ES ASCENDENTE (orden alfabetico)
select * from EMP order by APELLIDO;
select * from EMP order by APELLIDO ASC;

--LA ORDENACION DESCENDENTE (SE USA DESC)
select * from EMP order by APELLIDO DESC;

-- ORDENAR POR MAS DE UN CAMPO.
select * from EMP order by dept_no, OFICIO;

-- !!IMPORTANTE. FILTRADO DE REGISTROS.
-- UTILIZAMOS LOS OPERADORES DE COMPARACION PARA LOS REGISTROS. 
-- la instruccion order by siempre tiene que ir al final de la consulta. 
/*
= IGUAL
>= MAYOR O IGUAL
<= MENOR O IGUAL
> MAYOR
< MENOR
<> DISTINTO
*/

-- Oracle por defecto difrencia entre mayusculas y minusculas en sus textos (string/varchar)
-- es posible desactivar (por defecto)
-- Todo lo que no sea un numero se escribe entre comillas simples '..'
-- Para filtrar se utiliza la palabra where y se escribe 1 sola vez en toda la consulta. 
-- Se escribiria despues del from.
-- Mostrar todos los empleados del departamento 10.

--EJEMPLO:
select * from EMP where dept_no=10;

--EJEMPLO: "MOSTRAR TODOS LOS EMPLEADOS CUYO OFICIO SEA DIRECTOR, COMO DIRECTOR NO LLEVA NUMERO TIENE QUE IR ENTRE COMILLAS SIMPLES. 
select * from EMP where OFICIO!='DIRECTOR'; 

--EJEMPLO: " MOSTRAR TODOS LOS EMPLEADOS CUYO OFICIO SEA DIFERENTE AL DIRECTOR
select * from EMP where OFICIO <>'DIRECTOR';



--Operadores relacionales, son los que nos permiten relacionar mas de una pregunta dentro de una consulta
/* 
OR --> MUESTRA LOS DATOS DE CADA FILTRO
AND --> TODOS LOS FILTROS DEBEN CUMPLIRSE
NOT --> NEGACION DE UNA CONDICION (SIEMPRE ENVITARLO)
*/

--EJEMPLO: MOSTRAR LOS EMPLEADOS DEL DEPARTAMENTO 10 Y QUE TENGAN DE OFICIO DIRECTOR. 
select * from EMP where DEPT_NO=10 AND OFICIO= 'DIRECTOR';

--EJEMPLO: UTILIZANDO OR MUESTRA TODOS LOS FILTROS UTILIZADOS. (DEPARTAMENTO 10 Y DIRECTORES)
select * from EMP where DEPT_NO=10 OR OFICIO= 'DIRECTOR';
--EJEMPLO: MOSTRAR EMPLEADOS DEL DEPARTAMENTO 10 Y DEL DEPARTAMENTO 20
select * from EMP where DEPT_NO=10 OR DEPT_NO=20;


-- TENEMOS OTROS OPERADORES A DEMAS DE LOS STANDARD
--BETWEEN MUESTRA LOS DATOS ENTRE UN RAGO INCLUSIVE


--EJEMPLO: MOSTRAR LOS EMPLEADOS CUYO SALARIO ESTE ENTRE 251000 Y 390000
select * from EMP where SALARIO between 251000 and 390000 order by SALARIO;

--EJEMPLO: PODEMOS HACER LO MISMO QUE ANTES PERO CON OPERADORES EFICIENTES SIN UTILIZANDO EL BETWEEN
select * from EMP where SALARIO >= 251000 and  SALARIO <= 390000 order by SALARIO;
 
--EJEMPLO: MOSTRAR LOS EMPLEADOS QUE NO SEAN DIRECTORES (HAY QUE INTENTAR DE EVITAR LAS NEGACIONES) 
select * from EMP where NOT OFICIO = 'DIRECTOR';

--EJEMPLO: PODEMOS RELAACION LA CONSULTA CON UN OPERADOR EN VEZ QUE LA NEGACION "NOT"
select * from EMP where OFICIO <> 'DIRECTOR';



-- EXISTE UN OPERADOR PARA BUSCAR COICIDENCIAS EN TEXTOS
-- LO QUE NOS PERMITE MEDIATE CARACTERES ESPECIALES HACER FILTROS EN TEXTOS
/* 

% busca cualquier caracter y longitud
_ Busca cualquier caracter
? Busca un caracter numerico

*/
-- Ejemplo: MOSTRAR TODOS LOS EMPLEADOS CUYO APELLIDO empiece  en s
select * from EMP where APELLIDO like 's%';
--  Ejemplo: MOSTRAR TODOS LOS EMPLEADOS CUYO APELLIDO COMIENZA en s
select * from EMP where APELLIDO like 's';
--ejemplo, busca un apellido que comience en s y termine en a
select * from EMP where APELLIDO like 's%a';
--ejemplo, busca todos empleados cuyo apellido sea de 4 letras
select * from EMP where APELLIDO like '____';


--Existe otro operador para buscar coicidencias de igualdad en un mismo
--CAMPO: in (valor1, valor2)


--ejemplo: Mostrar todos los empleados del departamento 10, 20. 30, 55, 65, 77
select * from EMP where DEPT_NO = 10 OR DEPT_NO= 20 or DEPT_NO = 30 or DEPT_NO= 65 OR DEPT_NO= 77;

--Podemos simplificar el ejemplo anterior con el operador in
--Ejemplo:
select * from EMP where DEPT_NO in (10,20,30,55,65,77);

--Tenemos el operador not in que realiza lo mismo que in pero recupera los datos que no coincidan
--Ejemplo: Mostrar todos los empleados que no esten en el departamento 10 y 20
select * from EMP where not DEPT_NO in (10,20); --negacion del NOT PERO ANTES DE LA CONDICION (NO USAR)
select * from EMP where DEPT_NO not in (10,20); -- lo mismo pero no negando, usamos el operador not in

--CAMPOS CALCULADOS: ES UNA HERRAMIENTA EN UNA CONSULTA, SIEMPRE DEBE TENER UN ALIAS, EN NESTRO EJEMPLO USAMOS TOTAL
--SIRVE PARA GENERAR CAMPOS QUE NO EXISTAN EN LA TABLA Y LOS PODEMOS CALCULAR. MEDIANTE UN SELECT
-- UN CAMPO CALCULADO ES SOLO PARA EL CURSOR(LO QUE APARECE EN CONSOLA)

--EJEMPLO: MOSTRAR TODOS LOS EMPLEADOS CUYO SALARIO SEA MAYOR A 344500
select APELLIDO, SALARIO, COMISION, (SALARIO + COMISION) as TOTAL from EMP 
where (SALARIO + COMISION) >= 344500;

--EJEMPLO: Vamos a mostrar el apellido, salario, comision y el salario total (salario + comision)
select APELLIDO, SALARIO, COMISION, (SALARIO + COMISION) as TOTAL from EMP;

--EJEMPLO QUEREMOS LA CONSULTA ORIGINAL Y ORDENAR POR ELLA
select APELLIDO, SALARIO, COMISION, (SALARIO + COMISION) as TOTAL from EMP
order by TOTAL; 

--CLAUSULA DISTINCT: SE UTILIZA PARA EL SELECT Y LO QUE REALIZA ES ELIMINAR REPETIDOS DE LA CONSULTA.
--EJEMPLO: MOSTRAR OFICIOS DE LOS EMPLEADOS
select OFICIO from EMP;

--EJEMPLOS: BUSCAMOS SOLO LOS OFICIOS QUE HAY.
select DISTINCT OFICIO from EMP;

--EJEMPLO: MOSTRAR LOS DIFERENTES OFICIOS Y APELLIDOS DE LOS EMPLEADOS.
select distinct OFICIO, APELLIDO from EMP;








