--1)
--Dar de alta con fecha actual al empleado José Escriche Barrera como programador perteneciente al departamento de producción. 

INSERT INTO EMP (EMP_NO, APELLIDO, OFICIO, FECHA_ALT, SALARIO, COMISION, DEPT_NO) --Muestra todos los datos de la tabla emp.
VALUES (9999, 'Escriche Barrera', 'Programador', SYSDATE, 70000, NULL, 10);

--revision si es correcto el alta
SELECT *
FROM EMP
WHERE EMP_NO = 9999;


--2)
-- Se quiere dar de alta un departamento de informática situado en Fuenlabrada (Madrid). 
INSERT INTO DEPT (DEPT_NO, DNOMBRE, LOC)
VALUES (21, 'Informática', 'Fuenlabrada (Madrid)');

--Si ya existe, elige otro número único.
--DNOMBRE: Es el nombre del departamento. Aquí se especifica 'Informática'.
--LOC: Es la ubicación del departamento. Aquí se indica 'Fuenlabrada (Madrid)'.
--DEPT_NO: Es el número del departamento. Asegúrate de que sea único en la tabla DEPT.

--revision si es correcto el alta
SELECT *
FROM DEPT
WHERE DEPT_NO = 21;

--3) El departamento de ventas se traslada a Teruel.
--Usa UPDATE para modificar la ubicación del departamento.
--Filtra por el nombre del departamento (ventas).

--Consulta:
UPDATE DEPT
SET LOC = 'Teruel'
WHERE DNOMBRE = 'Ventas';


--5)Modificar la comisión de los empleados de la empresa, de forma que todos tengan un incremento del 10% del salario. 

 -- Incrementar la comisión de todos los empleados en un 10% de su salario
UPDATE EMP
SET COMISION = NVL(COMISION, 0) + (SALARIO * 0.10);

--6) Incrementar un 5% el salario de los interinos de la plantilla que trabajen en el turno de noche. 

-- Incrementar un 5% el salario de los interinos que trabajen en el turno de noche
UPDATE EMP
SET SALARIO = SALARIO * 1.05
WHERE OFICIO = 'Interino' AND TURNO = 'N';

--7)
--Incrementar en 5000 Pts. el salario de los 
--empleados del departamento de ventas y del presidente, 
--tomando en cuenta los que se dieron de alta antes que el presidente de la empresa.

-- Incrementar en 5000 Pts. el salario de los empleados del departamento de ventas y del presidente
UPDATE EMP -- Actualiza la tabla EMP
SET SALARIO = SALARIO + 5000 -- Incrementa el salario en 5000 Pts.
-- Filtra los empleados que pertenecen al departamento de ventas o son presidentes
WHERE (DEPT_NO = (SELECT DEPT_NO FROM DEPT WHERE DNOMBRE = 'Ventas') 
       OR OFICIO = 'Presidente') -- Condición para seleccionar empleados de ventas o presidentes
  AND FECHA_ALT < (SELECT FECHA_ALT FROM EMP WHERE OFICIO = 'Presidente'); --   Condición para seleccionar empleados dados de alta antes que el presidente


--8) El empleado Sanchez ha pasado por la derecha a un compañero.  
--Debe cobrar de comisión 12.000 ptas más que el empleado Arroyo y su sueldo se ha incrementado un 10% respecto a su compañero. 

-- Actualizar la comisión del empleado Sanchez para que sea 12.000 Pts más que la del empleado Arroyo
UPDATE EMP
SET COMISION = (SELECT COMISION FROM EMP WHERE APELLIDO = 'Arroyo') + 12000
WHERE APELLIDO = 'Sanchez';

-- Actualizar el salario del empleado Sanchez para que sea un 10% mayor que el del empleado Arroyo
UPDATE EMP
SET SALARIO = (SELECT SALARIO FROM EMP WHERE APELLIDO = 'Arroyo') * 1.10
WHERE APELLIDO = 'Sanchez';

--9)
-- Se tienen que desplazar cien camas del Hospital SAN CARLOS para un Hospital de Venezuela.  
-- Actualizar el número de camas del Hospital SAN CARLOS. 
-- Reducir en 100 el número de camas del Hospital SAN CARLOS
UPDATE HOSPITAL
SET NUM_CAMAS = NUM_CAMAS - 100
WHERE NOMBRE = 'SAN CARLOS';

--10)
--Subir el salario y la comisión en 100000 pesetas y veinticinco mil pesetas respectivamente a los empleados que se dieron de alta en este año. 
UPDATE EMP
SET SALARIO = SALARIO + 100000,
    COMISION = NVL(COMISION, 0) + 25000
WHERE EXTRACT(YEAR FROM FECHA_ALT) = EXTRACT(YEAR FROM SYSDATE);

--11)Ha llegado un nuevo doctor a la Paz.  Su apellido es House y su especialidad es Diagnostico.   Introducir el siguiente número de doctor disponible. 
-- Insertar al nuevo doctor House en el hospital La Paz
INSERT INTO DOCTOR (DOCTOR_NO, APELLIDO, ESPECIALIDAD, HOSPITAL)
VALUES (
    (SELECT NVL(MAX(DOCTOR_NO), 0) + 1 FROM DOCTOR), -- Siguiente número de doctor disponible
    'House',
    'Diagnóstico',
    'La Paz'
);

--12)Borrar todos los empleados dados de alta entre las fechas 01/01/80 y 31/12/82. 
DELETE FROM EMP
WHERE FECHA_ALT BETWEEN TO_DATE('01/01/1980', 'DD/MM/YYYY') AND TO_DATE('31/12/1982', 'DD/MM/YYYY');
 

--13)Modificar el salario de los empleados trabajen en la paz y estén destinados a Psiquiatría.  Subirles el sueldo 20000 Ptas. más que al señor Amigo R. 
-- Modificar el salario de los empleados que trabajan en "La Paz" y están en "Psiquiatría"
UPDATE EMP
SET SALARIO = (SELECT SALARIO FROM EMP WHERE APELLIDO = 'Amigo' AND INICIAL = 'R.') + 20000
WHERE HOSPITAL = 'La Paz' AND DEPARTAMENTO = 'Psiquiatría';

--14)Insertar un empleado con valores null (por ejemplo la comisión o el oficio), y después borrarlo buscando como valor dicho valor null creado. 
-- Insertar un empleado con valores NULL en COMISION y OFICIO
INSERT INTO EMP (EMP_NO, APELLIDO, OFICIO, FECHA_ALT, SALARIO, COMISION, DEPT_NO)
VALUES (10000, 'Perez', NULL, SYSDATE, 50000, NULL, 10);
 -- Borrar el empleado que tiene valores NULL en COMISION y OFICIO
DELETE FROM EMP
WHERE APELLIDO = 'Perez' AND OFICIO IS NULL AND COMISION IS NULL;

--15)Borrar los empleados cuyo nombre de departamento sea producción. 
-- Borrar los empleados cuyo nombre de departamento sea "Producción"
DELETE FROM EMP
WHERE DEPT_NO = (SELECT DEPT_NO FROM DEPT WHERE DNOMBRE = 'Producción'); 