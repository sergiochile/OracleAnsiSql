select * from EMP where LOWER(oficio)='analista'; -- ESTO ES LO MISMO QUE HACER UN UPPER
UPDATE EMP SET OFICIO ='analiSTA' where emp_no=7902; -- ACTUALIZAMOS EL OFICIO DE UN EMPLEADO 

-- ESTAMOS PONIENDO VALORES ESTATICOS: 'analista'
--TAMBIEN PODRIAMOS INCLUIR VALORES DINAMICOS, POR LO QUE TENDRIAMOS QUE CONVERTIR LAS DOS COMPARACIONES
select * from EMP where UPPER(OFICIO)=UPPER('&dato'); --Esto ES LO MISMO QUE HACER UN LOWER
--En oracle tenemos la posibilidad de concatenar textos de una sola columna (campo calculado)
-- se utiliza el simbolo || para concatenar
-- Queremos mostrar una sola columna el apelidoo y oficio de los empleados
select APELLIDO ||  ' '  || OFICIO as DESCRIPCION from EMP; -- Esto nos mostrara el apellido y oficio de los empleados en una sola columna


-- la funcion initcap muestra cada palabra con una frase con la primera letra en mayuscula y el resto en minuscula.
select INITCAP(OFICIO) as INITC from EMP; -- Esto nos mostrara el oficio de los empleados con la primera letra en mayuscula y el resto en minuscula

select initcap(APELLIDO || ' ' || OFICIO) as DESCRIPCION from EMP; -- Esto nos mostrara el apellido y oficio de los empleados con la primera letra en mayuscula y el resto en minuscula

select concat('Nuestro empleado ES...', APELLIDO) as RESULTADO from EMP; -- Esto nos mostrara el apellido de los empleados con la frase "Nuestro empleado ES..." al inicio

--SUBSTR: EXTRAE UNA CADENA DE CARACTERES DE UNA CADENA DE TEXTO, RECUPERA UNA SUBCADENA DE UN TEXTO, ES MUY UTIL PARA LOGICA.
select SUBSTR('FLORERO', 1, 4 ) as DATO from DUAL; -- Esto nos mostrara la subcadena de la cadena FLORERO, comenzando desde la posicion 1 y con una longitud de 4 caracteres, por lo que nos mostrara FLORE

--MOSTRAR LOS EMPLEADOS CUYO APELLIDO COMINEZA CON S 
select * from EMP where APELLIDO like 's%'; -- Esto nos mostrara los empleados cuyo apellido comienza con la letra s
select substr(APELLIDO, 1, 1) as unaletra from EMP; -- Esto nos mostrara la primera letra de los apellidos de los empleados

-- MOSTRAR LOS EMPLEADOS CUYO APELLIDO COMINEZA CON S
select * from EMP where SUBSTR(APELLIDO, 1, 1) = 's'; -- Esto nos mostrara los empleados cuyo apellido comienza con la letra s

select LENGTH('LIBRO')as LONGITUD from DUAL; -- Esto nos mostrara la longitud de la cadena LIBRO, que es 5
--QUIERO MOSTRAR LOS EMPLEADOS CUYO APELLIDO SEA DE 4 LETRAS CON LIKE
select * from EMP where APELLIDO like '____'; -- Esto nos mostrara los empleados cuyo apellido tiene 4 letras
-- PERO ES MAS EFICIENTE FUNCIONES COMO LENGTH O LENGTH
select * from EMP where length(APELLIDO) = 4; -- Esto nos mostrara los empleados cuyo apellido tiene 4 letras

--INSTR BUSCA UN TEXTO Y DEVUELVE SU POSICION
select INSTR('ORACLE MOLA', 'M') AS POSICION from DUAL; -- Esto nos mostrara la posicion de la letra M en la cadena ORACLE MOLA, que es 8


--si deseamos validar un mail
select * from DUAL where INSTR('m@ail', '@') > 0; -- Esto nos mostrara la posicion de la letra @ en la cadena mail, que es 1

select LPAD('DEPT_NO', 5, '$') from EMP;

--FUNCIONES MATEMATICAS
--quiero redondear un numero
select ROUND(45.923) as REDONDEO from DUAL; -- Esto nos mostrara el numero 46, que es el resultado de redondear 45.923 a la unidad mas cercana
select ROUND(45.923, 2) as REDONDEO from DUAL; --Esto nos mostrara el numero 45.92, que es el resultado de redondear 45.923 a dos decimales

--TRUNC ELIMINA LOS DIGITOS INDICADOS
select TRUNC(45.923) as REDONDEO from DUAL; -- Esto nos mostrara el numero 45, que es el resultado de truncar 45.923 a la unidad mas cercana
select TRUNC(45.923, 2) as REDONDEO from DUAL; -- Esto nos mostrara el numero 45.92, que es el resultado de truncar 45.923 a dos decimales
select TRUNC(45.923, 2) as REDONDEO from DUAL; -- Esto nos mostrara el numero 45, que es el resultado de truncar 45.923 a la unidad mas cercana

--MOD DEVUELVE EL RESTO DE LA DIVISION ENTRE DOS NUMEROS (M ENTRE N)
--AVERIGUAR SI EL NUMERO ES PAR
select MOD(99, 2) as RESTO from DUAL; -- Esto nos mostrara el resto de la division entre 10 y 2, que es 1
select MOD(98, 2) as RESTO from DUAL; -- Esto nos mostrara el resto de la division entre 10 y 2, que es 0

--MOSTRAR LOS EMPLEADOS CUYO SALARIO SEA PAR CON MOD
select * from EMP where MOD(SALARIO, 2) = 0; -- Esto nos mostrara los empleados cuyo salario es par

--TENEMOS UNA FUNCION PARA AVERIGUAR LA FECHA ACTUAL DE HOY EN EL SERVIDOR: SYSDATE
select SYSDATE as FECHA_ACTUAL from DUAL;
--VAMOS A AGREGAR 10 DIAS MAS A LA FECHA ACTUAL
select SYSDATE + 10 as FECHA_ACTUAL from DUAL; -- Esto nos mostrara la fecha actual mas 10 dias
--VAMOS AGREGAR 30 DIAS MAS A LA FECHA ACTUAL
select SYSDATE + 30 as FECHA_ACTUAL from DUAL; -- Esto nos mostrara la fecha actual mas 30 dias
--VAMOS A RESTAR 1500 DIAS A LA FECHA ACTUAL
select SYSDATE - 1500 as FECHA_ACTUAL from DUAL; -- Esto nos mostrara la fecha actual menos 1500 dias

--MONTH BETWEEN: DEVUELVE LA CANTIDAD DE MESES QUE HAY ENTRE LA FECHA 1 Y LA FECHA 2.LOGMNR$COL_GG_TABF_PUBLIC
--EJEMPLO: MOSTRAR CUANTOS MESES LLEVAN LOS EMPLEADOS DADO DE ALTA EN LA EMPRESA, VAMOS A REDONDIAR LA CANTIDAD DE MESES A DOS DIGITOS.
select APELLIDO, ROUND (MONTHS_BETWEEN(SYSDATE, FECHA_ALT)) as MESES from EMP; -- Esto nos mostrara el apellido de los empleados y la cantidad de meses que llevan en la empresa
--AGREGAMOS A LA FECHA ACTUAL, 5 MESES
select ADD_MONTHS(SYSDATE, 5) as FECHA_ACTUAL from DUAL; -- Esto nos mostrara la fecha actual mas 5 meses
--NEXT_DAY DEVUELVE EL SIGUIENTE DIA DE LA SEMANA QUE LE DIGAMOS
--MOSTRAR CUANDO ES EL PROXIMO LUNES


select NEXT_DAY(SYSDATE, 'MONDAY') as PROXIMO_LUNES from DUAL; -- Esto nos mostrara la fecha del proximo lunes

--LAST_DAY DEVUELVE EL ULTIMO DIA DEL MES DE UNA FECHA
select LAST_DAY(SYSDATE) as ULTIMO_DIA_MES from DUAL; -- Esto nos mostrara el ultimo dia del mes de la fecha actual


--EMPLEADOS REDONDEADOS LA FECHA AL MES
select APELLIDO, FECHA_ALT, ROUND(FECHA_ALT, 'MM') as RAUNDMES from EMP; -- Esto nos mostrara el apellido de los empleados y la fecha de alta redondeada al mes
select APELLIDO, FECHA_ALT, ROUND(FECHA_ALT, 'YY') as RAUNDMES from EMP; -- Esto nos mostrara el apellido de los empleados y la fecha de alta redondeada al año

--TRUNC A LA FECHA: TRUNCA LA FECHA DEPENDIENDOP DEL FORMATO, REDONDEA SIEMPRE A 01-XX-XX CUANDO ES MM Y A 01-01-XX CUANDO ES YY
select APELLIDO, FECHA_ALT, TRUNC(FECHA_ALT, 'YY') as TRUNCDELMES from EMP; -- Esto nos mostrara el apellido de los empleados y la fecha de alta truncada al mes
select APELLIDO, FECHA_ALT, TRUNC(FECHA_ALT, 'MM') as TRUNCDELAÑO from EMP; -- Esto nos mostrara el apellido de los empleados y la fecha de alta truncada al año

-- TO_CHAR: Convierte datos de tipo DATE o NUMBER a cadenas de caracteres. Se suele utilizar para visualizar las fechas 
-- o valores numéricos en un formato diferente a como están almacenadas en la base de datos.  

select APELLIDO, FECHA_ALT, TO_CHAR(FECHA_ALT, 'DD-MM-YYYY') as FORMATO FROM EMP; -- Esto nos mostrara el apellido de los empleados y la fecha de alta en formato DD-MM-YYYY

--FORMATO A NUMEROS:

select to_char(7586,'0000L')as ZERO from DUAL; -- Esto nos mostrara el numero 7586 con ceros a la izquierda y una L al final
select to_char(7586,'0000$')as ZERO from DUAL; -- Esto nos mostrara el numero 7586 con ceros a la izquierda y un signo de dolar al final
--HORA DEL SISTEMA
select TO_CHAR(SYSDATE, 'HH24:MI:SS') as HORALOCAL from DUAL; -- Esto nos mostrara la hora del sistema en formato HH24:MI:SS

--SI DESEAMOS INCLUIR TEXTO ENTRE TO_CHAR Y LOS FORMATOS, SE UTILIZAN "" DENTRO DE LAS SIMPLES

select TO_CHAR(SYSDATE,'"Hoy es" DD " de "MONTH"' )as FORMATO from DUAL; -- Esto nos mostrara la fecha actual en formato "Hoy es" DD " de "MONTH" con el mes en letras

--FUNCIONES DE CONVERSION
select '08/04/2025'  as FECHA from DUAL; -- Esto nos mostrara la fecha 08/04/2025 como una cadena de caracteres
select TO_DATE('08/04/2025') +2 as FECHA from DUAL; -- Esto nos mostrara la fecha 08/04/2025 como una fecha y le sumamos 2 dias
select '12' + 2 as RESULTADO from DUAL; -- Esto nos mostrara el resultado de la suma entre 12 y 2, que es 14
select TO_NUMBER('12') + 2 as RESULTADO from DUAL; -- Esto nos mostrara el resultado de la suma entre 12 y 2, que es 14



--FUNCIONES GENERALES 
--NVL  Se utiliza para convertir los valores nulos a un valor especificado, SIRVE PARA EVITAR LOS NULL, LOS SUSTITUYE POR UN VALOR QUE LE DIGAMOS
--SI NO ENCUENTRA EL VALOR QUE LE DIGAMOS, DEVUELVE NULL
--POREJEMPLO: QUIERO MOSTRAR APELIIDO, SALARIO Y COMISION DE TODOS LOS EMPLEADOS

select APELLIDO, SALARIO, COMISION from EMP; -- Esto nos mostrara el apellido, salario y comision de todos los empleados
--PODEMOS INDICAR QUE EL LUGAR DE PONER NULL PONGA OTRO VALOR, EL VALOR TIENE QUE SER CORRESPONDIENTE A LA COLUMNA
--SI LA COLUMNA ES NUMERICA, EL VALOR TIENE QUE SER NUMERICO, SI LA COLUMNA ES DE TEXTO, EL VALOR TIENE QUE SER TEXTO

select APELLIDO, SALARIO, NVL(COMISION, -1)as COMISION from EMP; -- Esto nos mostrara el apellido, salario y comision de todos los empleados, 
--y si la comision es nula, pondra -1 en su lugar.

--MOSTRAR APELLIDO, SALARIO + COMISION DE TODOS LOS EMPLEADOS

select APELLIDO, SALARIO + NVL(COMISION, 0) as SALARIO from EMP; -- Esto nos mostrara el apellido y el salario de todos los empleados,

--MOSTRAR EL TURNO EN PALABRA ('MAÑANA', 'TARDE', 'NOCHE') DE LA PLANTILLA DE EMPLEADOS.-

select APELLIDO, TURNO FROM PLANTILLA; -- Esto nos mostrara el apellido y el turno de todos los empleados

select APELLIDO, decode(TURNO, 'M', 'MAÑANA', 'N', 'NOCHE') as TURNO from PLANTILLA; -- Esto nos mostrara el apellido y el turno de todos los empleados,
--y si el turno es M, pondra MAÑANA, si el turno es N, pondra NOCHE, y si no es ninguno de los dos, pondra NULL.

--FUNCIONES ANIDADAS 
--Las funciones a nivel fila pueden anidarse hasta cualquier nivel y son ejecutadas desde el nivel central hasta el exterior.

--ejemplo: QUIERO SABER LA FECHA DEL PROXIMO MIERCOLES QUE JUEGA EL REAL MADRID

select NEXT_DAY(SYSDATE, 'WEDNESDAY') as CHAMPIONS from DUAL; -- Esto nos mostrara la fecha del proximo miercoles que juega el real madrid
--si el real madrid juega el miercoles, nos mostrara la fecha del proximo miercoles.
--PERO QUIERO VER LA FECHA COMPLETA QUE NO ME ENTERO, QUIERO VER EL MIERCOLES 09 DE ABRIL JUEGA EL MADRID
select to_char(next_day((SYSDATE+2), 'WEDNESDAY'), 'dd day "de" Month "juega el madrid"') as CHAMPIONS from DUAL; -- Esto nos mostrara la fecha del proximo miercoles que juega el real madrid en formato dd day "de" Month "juega el madrid"
--si el real madrid juega el miercoles, nos mostrara la fecha del proximo miercoles.

-- https://oracle411.moodlecloud.com/ 
-- Usuario9
-- Contraseña= Curso12345

/*

/*