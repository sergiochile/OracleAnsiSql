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