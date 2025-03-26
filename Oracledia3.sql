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



--Este tipo de consultas nos permiten mostrar algun resumen sobre un grupo determinado de los datos. 
--Utilizan funciones de agrupacion para conseguir el resumen. Las funciones deben tener un alias.

/*
COUNT (*): cuenta el numero de registros, incluyendo nulos. 
COUNT(CAMPO): cuenta el numero de registros sin nulos.
SUM (NUMERO): suma el total de un campo numero. 
AVG (NUMERO): recupera la media de un campo numerico.
MAX (CAMPO): devuelve el maximo valor de un campo.
MIN (CAMPO): devuelve el minimo valor de un campo. 
*/

--Ejemplo: numero de registros de la tabla doctor. 

select count(*) as NUMERO_DOC from DOCTOR;
select count(APELLIDO) as NUMERO_DOC from DOCTOR;


--PODEMOS COMBINAR SIN PROBOEMA VARIAS OPCIONES:
--EJEMPLO: NUMERO DE PERSONAS DE DOCTORES Y MAXIMO SALARIO
select count(*) as DOCTORES, max(SALARIO) AS MAXIMO from DOCTOR;

-- LOS DATOS RESULTANTES DE LAS FUNCIONES PODEMOS AGRUPARLOS POR ALGUN CAMPO/S DE LA TABLA
-- CUANDO QUEREMOS AGRUPAR UTILIZAMOS group by despues del from
-- TRUCO: DEBEMOS AGRUPAR POR CADA CAMPO QUE NO SEA UNA FUNCION
--EJEMPLO: QUIERO MOSTRAR CUANTOS DOCTORES EXISTEN POR CADA ESPECIALIDAD
select count(*) as DOCTORES, ESPECIALIDAD
from DOCTOR
group by ESPECIALIDAD;

--ejemplo: MOSTRAR NUMERO DE PERSONAS Y MAXIMO SALARIO DE LOS EMPLEADOS POR CADA DEPARTAMENTO Y OFICIO.

select count(*) as PERSONAS, max(SALARIO) as MAXIMO_SALARIO, 
DEPT_NO, OFICIO
from EMP
group by DEPT_NO, OFICIO;

--EJEMPLO: MOSTRAR EL NUMERO DE PERSONAS DE LA PLANTILLA
select count(*) as PERSONAS from PLANTILLA;
--EJEMPLO: MOSTRAR EL NUMERO DE PERSONAS EN CADA TURNO DE LA PLANTILLA
select count(*) as PERSONAS, TURNO from PLANTILLA group by TURNO;


--FILTRANDO EN CONSULTAS DE AGRUPACION TENEMOS DOS POSIBILIDADES:
-- WHERE: ANTES DEL GROUP BY 
-- HAVING: DESPUES DEL GROUP BY

--EJEMPLO: MOSTRAR CUANTOS EMPLEADOS TENEMOS POR CADA OFICIO QUE COBREN MAS DE 200.000
-- LO QUE TENGA EN EL SELECT UTILIZAMOS HAVING
select count(*) as EMPLEADOS, OFICIO
from EMP
where SALARIO > 200000
group by OFICIO;
select * from EMP; 


--HAVING: DESPUES DEL GRUOP BY Y PARA FILTRAR SOBRE EL CONJUNTO MOSTRAR CUANTOS EMPLEADOS TENEMOS POR CADA OFICIO
--Y QUE SEAN ANALISTA Y VENDEDOR
select count(*) as EMPLEADOS, OFICIO
from EMP
group by OFICIO
having OFICIO in ('ANALISTA','VENDEDOR');

select count(*) as EMPLEADOS, OFICIO
from EMP
where OFICIO in ('ANALISTA','VENDEDOR')
group by OFICIO;


--CUANDO NO PODEMOS DECIDIR Y ESTAMOS OBLIGADOS A UTILIZAR HAVING:
-- SI QUEREMOS FILTRAR POR UNA FUNCION DE AGRUPACION MOSTRAR CUANTOS EMPLEADOSTENEMOS POR CADA OFICIO SOLAMENTE DONDE TENGAMOS 2 O MAS EMPLEADOS DEL MISMO OFICIO

select count(*) as EMPLEADOS, OFICIO
from EMP 
group by OFICIO
having count(*) > 2;


--EJERCICIOS
 
--Encontrar el salario medio de los analistas, mostrando el número de los empleados con oficio analista. 
select count(*) as NUMEROEMPLEADOS, oficio, 
avg(salario) as SALARIOMEDIO from  
emp group by oficio having oficio ='ANALISTA';

--Encontrar el salario más alto, mas bajo y la diferencia entre ambos de todos los empleados con oficio EMPLEADO. 
select max(SALARIO) as MAXIMO, min(SALARIO) as MINIMO,
max (SALARIO) - min(SALARIO) as DIFERENCIA, OFICIO
from EMP
group by OFICIO
having OFICIO = 'EMPLEADO';

--Visualizar los salarios mayores para cada oficio. 
select oficio, max(salario) as SALARIOMAXIMO from emp group by oficio; 

--Visualizar el número de personas que realizan cada oficio en cada departamento ordenado por departamento. 
select count (*) as PERSONAS, OFICIO, DEPT_NO
from EMP
group by OFICIO, DEPT_NO
order by 1;

--Buscar aquellos departamentos con cuatro o más personas trabajando. 
select count(*) as PERSONAS, DEPT_NO
from EMP 
group by DEPT_NO
having count(*) >=4;

--Mostrar el número de directores que existen por departamento. 
select count(*) as NUMEROEMPLEADOS, dept_no  
from emp 
where oficio = 'DIRECTOR' 
group by dept_no; 

--Visualizar el número de enfermeros, enfermeras e interinos que hay en la plantilla, ordenados por la función.
select count (*) as TRABAJADORES, FUNCION
from PLANTILLA
group by FUNCION
having FUNCION in ('ENFERMERO','ENFERMERA','INTERINO');

--Visualizar departamentos, oficios y número de personas, para aquellos departamentos que tengan dos o más personas trabajando en el mismo oficio. 
select DEPT_NO, OFICIO, count(*)as PERSONAS
from EMP
group by DEPT_NO, OFICIO
having count (*) >=2;

--Calcular el salario medio, Diferencia, Máximo y Mínimo de cada oficio. Indicando el oficio y el número de empleados de cada oficio. 
select oficio, count(*) as EMPLEADOS 
, min(salario) as SALARIOMAXIMO 
, max(salario) as SALARIOMINIMO 
, max(salario) - min(salario) as DIFERENCIA 
, avg(salario) as MEDIA 
 from emp group by  oficio;

--Calcular el valor medio de las camas que existen para cada nombre de sala. Indicar el nombre de cada sala y el número de cada una de ellas. 
select avg(NUM_CAMA)as MEDIA_CAMAS, count(*) as NUMERO,
NOMBRE
from SALA
group by NOMBRE;

--Calcular el salario medio de la plantilla de la sala 6, según la función que realizan. Indicar la función y el número de empleados. 
select avg(SALARIO) as SALARIO_MEDIO, FUNCION, SALA_COD, count(*)PERSONAS
from PLANTILLA
where SALA_COD=6
group by FUNCION, SALA_COD;

 --Averiguar los últimos empleados que se dieron de alta en la empresa en cada uno de los oficios, ordenados por la fecha. 
select max(fecha_alt) AS FECHAMAXIMA,  
Oficio from emp 
group by oficio 
order by 1; 

--Mostrar el número de hombres y el número de mujeres que hay entre los enfermos. 
select count(*) as ENFERMOS, SEXO
from ENFERMO
group by SEXO;

--Mostrar la suma total del salario que cobran los empleados de la plantilla para cada función y turno. 
select funcion, Turno 
, sum(salario) as SUMASALARIAL  
from plantilla group by funcion, Turno;

--Calcular el número de salas que existen en cada hospital. 
select count(*) as N_SALAS, HOSPITAL_COD 
from SALA
group by  HOSPITAL_COD;

--Mostrar el número de enfermeras que existan por cada sala.  
select count(*) as ENFERMERAS,
SALA_COD
from PLANTILLA
where FUNCION= 'ENFERMERA'
group by SALA_COD;


-- CONSULTAS DE COMBINACION
-- NOS PERMITEN MOSTRAR DATOS DE VARIAS TABLAS QUE DEBEN ESTAR RELACIONADAS ENTRE SI MEDIANTE ALGUNA CLAVE.
-- 1) NECESITAMOS CAMPOS RELACION ENTRE LAS TABLAS
-- 2) DEBEMOS PONER EL NOMBRE DE CADA TABLA Y DE CADA CAMPO EN LA CONSULTA. 

select TABLA1.CAMPO1, TABLA1.CAMPO2
, TABLA2.CAMPO1, TABLA2.CAMPO2
from TABLA1
inner join TABLA2
on TABLA1.CAMPO_RELACION = TABLA2.CAMPO_RELACION;

--MOSTRAR EL APELLIDO, OFICIO DE EMPLEADOS JUNTO A SU NOMBRE DE DEPARTAMENTO Y LOCALIDAD

select EMP.APELLIDO, EMP.OFICIO
, DEPT.DNOMBRE, DEPT.LOC
from EMP
inner join DEPT
on EMP.DEPT_NO = DEPT.DEPT_NO;

-- PODEMOS REALIZAR POR SUEPESTO NUESTROS WHERE. EN EL EJEMPLO SOLO MOSTRARIAMOS LOS DATOS DE MADRID
select EMP.APELLIDO, EMP.OFICIO
, DEPT.DNOMBRE, DEPT.LOC
from EMP
inner join DEPT
on EMP.DEPT_NO = DEPT.DEPT_NO
where DEPT.LOC='MADRID';

-- NO ES OBLIGATORIO INCLUIR EL NOMBRE DE LA TABLA ANTES DEL CAMPO A MOSTRAR EN EL SELECT.( NO RECOMENDABLE)
select EMP.APELLIDO, OFICIO
, DEPT.DNOMBRE, DEPT.LOC
from EMP
inner join DEPT
on EMP.DEPT_NO = DEPT.DEPT_NO;

-- PODEMOS INCLUIR ALIAS A LOS NOMBRES DE LAS TABLAS PARA LLAMARLAS ASI A LO LARGO DE LA CONSULTA, ES UTIL CUANDO TENEMOS TABLAS CON NOMBRES LARGOS.

select E.APELLIDO, E.OFICIO
, D.DNOMBRE, D.LOC
from EMP E
inner join DEPT D
on E.DEPT_NO = D.DEPT_NO order by d.LOC; 

--TENEMOS MULTIPLES TIPOS DE JOIN EN LAS BASES DE DATOS. 
-- inner: Combina los resultados de las dos tablas.
--left Join: Indica que muestre todos los resultados de la tabla de la izquierda 
--Right Join: Indica que muestre todos los resultados de la tabla de la derecha 
--Full Join: Indica que combine todos los campos aunque los resultados sean diferentes. 
--Cross Join: Muestra un producto cartesiano combinando todos los resultados de las dos tablas. 

select DISTINCT DEPT_NO from EMP;
select * from DEPT;

--TENEMOS UN DEPARTAMENTO: 40, PRODUCCION, GRANADA SIN EMPLADOS

--VAMOS A CREAR UN NUYEVO EMPLEADO QUE NO TENGA DEPARTAMENTO.
select EMP.APELLIDO, DEPT.DNOMBRE, DEPT.LOC
from EMP
left join DEPT
on EMP.DEPT_NO = DEPT.DEPT_NO;

--LA TABLA DE LA DERECHA ES DESPUES DEL JOIN
select EMP.APELLIDO, DEPT.DNOMBRE, DEPT.LOC
from EMP
right join DEPT
on EMP.DEPT_NO = DEPT.DEPT_NO;

--CROSS: PRODUCTO CARTESIANO, NO LLEVA ON
select EMP.APELLIDO, DEPT.DNOMBRE, DEPT.LOC
from EMP
cross join DEPT;

--MOSTRAR MEDIA SALARIAL DE LOS DOCTORES POR HOSPITAL

select avg(salario) as MEDIA, HOSPITAL_COD 
from DOCTOR
group by HOSPITAL_COD;

SELECT * FROM HOSPITAL;

-- MOSTRAR EL NOMBRE DEL HOSTPITAL
select avg(doctor.salario) as MEDIA, HOSPITAL.NOMBRE 
from DOCTOR
inner join HOSPITAL
on DOCTOR.HOSPITAL_COD = HOSPITAL.HOSPITAL_COD
group by HOSPITAL.NOMBRE;

--MOSTRAR EL NUMERO DE EMPLEADOS QUE EXISTEN POR CADA LOCALIDAD
select count (*) as EMPLEADOS
, DEPT.LOC
from EMP
inner join DEPT
on EMP.DEPT_NO = DEPT.DEPT_NO
group by DEPT.LOC;