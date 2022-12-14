--CASO 1
SELECT CARRERAID AS "IDENTIFICACION DE LA CARRERA",
COUNT(CARRERAID) AS "TOTAL ALUMNOS MATRICULADOS",
'Le corresponden '||TRIM(TO_CHAR(30200*COUNT(CARRERAID),'$99G999G999'))||' del presupuesto total asignado para la publicidad' AS "MONTO POR PUBLICIDAD"
FROM ALUMNO
GROUP BY CARRERAID
ORDER BY COUNT(CARRERAID) DESC;

--CASO 2
SELECT CARRERAID AS CARRERA,
COUNT(CARRERAID) AS  "TOTAL DE ALUMNOS"
FROM ALUMNO
GROUP BY CARRERAID
HAVING COUNT(CARRERAID)>4
ORDER BY CARRERAID;

--CASO 3
SELECT TO_CHAR(RUN_JEFE,'09G999G999') AS "RUN JEFE SIN DV",
COUNT(RUN_JEFE) AS "TOTAL EMPLEADOS A SU CARGO",
TO_CHAR(MAX(SALARIO),'99G999G999') AS "SALARIO MAXIMO",
COUNT(RUN_JEFE)*10||'% del salario maximo' AS "PORCENTAJE DE BONIFICACION",
TO_CHAR(MAX(SALARIO)*((COUNT(RUN_JEFE)*10)/100),'$99G999G999') AS "BONIFICACION"
FROM EMPLEADO
WHERE RUN_JEFE IS NOT NULL
GROUP BY RUN_JEFE
ORDER BY COUNT(RUN_JEFE) ASC;

--CASO 4
SELECT ID_ESCOLARIDAD,
CASE WHEN ID_ESCOLARIDAD = 10 THEN 'BÁSICA'
WHEN ID_ESCOLARIDAD = 20 THEN 'MEDIA CIENTÍFICA HUMANISTA'
WHEN ID_ESCOLARIDAD = 30 THEN 'MEDIA TÉCNICO PROFESIONAL'
WHEN ID_ESCOLARIDAD = 40 THEN 'SUPERIOR CENTRO DE FORMACIÓN TÉCNICA'
WHEN ID_ESCOLARIDAD = 50 THEN 'SUPERIOR INSTITUTO PROFESIONAL'
WHEN ID_ESCOLARIDAD = 60 THEN 'SUPERIOR UNIVERSIDAD'
END AS "DESCRIPCION ESCOLARIDAD",
COUNT(ID_ESCOLARIDAD) AS "TOTAL DE EMPLEADOS",
TO_CHAR(MAX(SALARIO),'$99G999G999') AS "SALARIO MAXIMO",
TO_CHAR(MIN(SALARIO),'$99G999G999') AS "SALARIO MINIMO",
TO_CHAR(SUM(SALARIO),'$99G999G999') AS "SALARIO TOTAL",
TO_CHAR(ROUND(AVG(SALARIO)),'$99G999G999') AS "SALARIO PROMEDIO"
FROM EMPLEADO
GROUP BY ID_ESCOLARIDAD
ORDER BY COUNT(ID_ESCOLARIDAD) DESC;

--CASO 5
SELECT TITULOID AS "CODIGO DEL LIBRO",
COUNT(TITULOID) AS "TOTAL DE VECES SOLICITADO",
CASE WHEN COUNT(TITULOID)=1 THEN 'No se requiere nuevos ejemplares'
WHEN COUNT(TITULOID) BETWEEN 2 AND 3 THEN 'Se requiere comprar 1 nuevos ejemplares'
WHEN COUNT(TITULOID) BETWEEN 4 AND 5 THEN 'Se requiere comprar 2 nuevos ejemplares'
WHEN COUNT(TITULOID)>5 THEN 'Se requiere comprar 4 nuevos ejemplares'
END AS "SUGERENCIA"
FROM PRESTAMO
WHERE EXTRACT(YEAR FROM FECHA_INI_PRESTAMO)=2021
GROUP BY TITULOID
ORDER BY COUNT(TITULOID) DESC;

--CASO 6
SELECT TO_CHAR(RUN_EMP,'09G999G999') AS "RUN EMPLEADO",
to_char(FECHA_INI_PRESTAMO,'MM/yyyy') AS "MES PRESTAMO LIBRO",
COUNT(RUN_EMP) AS "TOTAL DE PRESTAMOS",
TO_CHAR(COUNT(RUN_EMP)*10000,'$99G999G999') AS "ASIGNACION POR PRESTAMO"
FROM PRESTAMO
WHERE EXTRACT(YEAR FROM FECHA_INI_PRESTAMO) = 2021
GROUP BY RUN_EMP,to_char(FECHA_INI_PRESTAMO,'MM/yyyy')
HAVING COUNT(*)>=3
ORDER BY to_char(FECHA_INI_PRESTAMO,'MM/yyyy') ASC,"ASIGNACION POR PRESTAMO" DESC,RUN_EMP DESC;