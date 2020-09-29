drop table Profesor;
drop table Asignatura;
drop table Alumno;
drop table Inscripcion;
drop table Curso;
drop table Sala;
drop table Mantenimiento;
drop table Funcionario;

-- Convenciones aplicada a todas las tablas:

--  Notacion atributos:
--      NOMBREATRIBUTO___TABLADEORIGEN

--  Notacion clave primaria:
--      PK_NOMBREATRIBUTO___TABLADEORIGEN

--  Notacion Foreign Key
--      FK_NOMBREATRIBUTO___TABLAORIGEN


create table Profesor(
    RUT_PROFESOR___PROFESOR varchar2(10) primary key,
    NOMBRE___PROFESOR varchar2(15) not null,
    PODER___PROFESOR varchar2(15) not null,
    AGENCIA___PROFESOR varchar2(15),
    TIPO___PROFESOR number(1) not null
);

insert into Profesor values ('199948421','Cerpa','Volar','DMAT',2);
insert into Profesor values ('189239819','Marti','Programar','INF',2);
insert into Profesor values ('128318328','Isabel','Dinamicas','DMAT',2);
insert into Profesor values ('012839128','Victor','Algebrita','DMAT',2);
insert into Profesor values ('873981722','Galvez','Risas','INF',2);

-- Select *from Profesor;

create table Asignatura(
    ID_ASIGNATURA___ASIGNATURA number(6) PRIMARY KEY,
    NOMBRE___ASIGNATURA varchar(20) not null,
    DESCRIPCION___ASIGNATURA varchar(256) not null
);

insert into Asignatura values (111111,'MATE 1','mucho texto');
insert into Asignatura values (222222,'MATE 2','mucho texto');
insert into Asignatura values (333333,'Progra','mucho texto');

-- Select *from Asignatura;

create table Curso(
    ID_CURSO___CURSO number(6) PRIMARY KEY,
    SEMESTRE___CURSO number(1) not null,
    ANIO___CURSO number(4) not null,
    RUT_PROFESOR___CURSO varchar(10),
    ID_ASIGNATURA___CURSO number(6),
    ID_SALA___CURSO number(6),
    foreign key (RUT_PROFESOR___CURSO) references Profesor (RUT_PROFESOR___PROFESOR),
    foreign key (ID_ASIGNATURA___CURSO) references Asignatura (ID_ASIGNATURA___ASIGNATURA),
    foreign key (ID_SALA___CURSO) references Sala (ID_Sala___Sala)
);

INSERT INTO Curso VALUES (1,1,2020,'199948421',111111);
INSERT INTO Curso VALUES (2,1,2020,'128318328',222222);
INSERT INTO Curso VALUES (3,2,2019,'012839128',111111);
INSERT INTO Curso VALUES (4,2,2017,'189239819',333333);

-- Select *from Curso;

create table Alumno(
    RUT_ALUMNO___ALUMNO varchar2(10) PRIMARY KEY,
    NOMBRE___ALUMNO varchar2(15) not null,
    PODER___ALUMNO varchar2(15) not null,
    LICENCIA___ALUMNO number(1) not null,
    INGRESO___ALUMNO number(4) not null
);

INSERT INTO Alumno VALUES ('199948458','Alan','Flojear',1,2017);
INSERT INTO Alumno VALUES ('199903891','Maxi','Enojarse',0,2017);
INSERT INTO Alumno VALUES ('191231881','Mario','Seriedad',1,2017);
INSERT INTO Alumno VALUES ('191892379','Benito','Autoestima',1,2016);
INSERT INTO Alumno VALUES ('191192132','Hugo','Pesado',0,2016);
INSERT INTO Alumno VALUES ('191198273','Cristobal','Autoestima',0,2016);

-- Select *from Alumno;

create table Inscripcion(
    ID_INSCRIPCION___INSCRIPCION number(6) primary key,
    NOTA___INSCRIPCION number(3) not null,
    RUT_ALUMNO___INSCRIPCION varchar2(10),
    ID_CURSO___INSCRIPCION number(6),
    foreign key (RUT_ALUMNO___INSCRIPCION) references Alumno (RUT_ALUMNO___ALUMNO),
    foreign key (ID_CURSO___INSCRIPCION) references Curso (ID_CURSO___CURSO)
);

ALTER TABLE Inscripcion
    add foreign key (ID_CURSO___INSCRIPCION) references Curso (ID_CURSO___CURSO);

INSERT INTO Inscripcion VALUES (1,88,'199948458',3); -- Alan
INSERT INTO Inscripcion VALUES (2,56, '199948458',1); -- Alan
INSERT INTO Inscripcion VALUES (3,78, '199948458',3); -- Alan
INSERT INTO Inscripcion VALUES (4,82, '191892379',4); -- Benito
INSERT INTO Inscripcion VALUES (1,100,'199948458',3);
INSERT INTO Inscripcion VALUES (2,56, '199948458',1);
INSERT INTO Inscripcion VALUES (3,44, '199948458',3);
INSERT INTO Inscripcion VALUES (4,11, '191892379',4);

-- Select *from Inscripcion;

create table Sala(
    ID_SALA___SALA number(6) PRIMARY KEY,
    CAPACIDAD___SALA number(3),
    DISPONIBILIDAD___SALA number(1),
    TIPO___SALA varchar2(15)
);

INSERT INTO Sala VALUES(1,60,1,'Teatro');
INSERT INTO Sala VALUES(2,60,1,'Teatro');
INSERT INTO Sala VALUES(3,160,1,'Circular');
INSERT INTO Sala VALUES(4,160,1,'Circular');

-- Select *from Sala;

create table Funcionario(
    RUT_FUNCIONARIO___FUNCIONARIO varchar2(10) PRIMARY KEY,
    NOMBRE___FUNCIONARIO varchar2(15),
    PODER___FUNCIONARIO varchar2(15)
);

INSERT INTO Funcionario VALUES ('8123490888','Darcy','Dios');

-- Select *from Funcionario;

create table Mantenimiento(
    RUT_FUNCIONARIO___MANTENIMIENTO varchar2(10),
    ID_SALA___MANTENIMIENTO number(6),
    FECHA___MANTENIMIENTO date,
    PRIMARY KEY (RUT_FUNCIONARIO___MANTENIMIENTO,ID_SALA___MANTENIMIENTO,FECHA___MANTENIMIENTO)
);

INSERT INTO Mantenimiento VALUES ('8123490888',1,'10/06/2020');
INSERT INTO Mantenimiento VALUES ('8123490888',2,'11/06/2020');
INSERT INTO Mantenimiento VALUES ('8123490888',3,'12/06/2020');
INSERT INTO Mantenimiento VALUES ('8123490888',4,'13/06/2020');

-- Select *from Mantenimiento;

-- Vistas
drop view vista_sidekick;

create view vista_sidekick as 
    select profesor.nombre___profesor as Profesor, alumno.nombre___alumno as Alumno,inscripcion.nota___inscripcion as Nota
        from Profesor
        join Curso on profesor.rut_profesor___profesor = RUT_PROFESOR___CURSO
        join Inscripcion on id_curso___curso = id_curso___inscripcion
        join Alumno on rut_alumno___alumno = rut_alumno___inscripcion
        where (Profesor.TIPO___PROFESOR = 2) and (Alumno.LICENCIA___ALUMNO = 1) and (Inscripcion.NOTA___INSCRIPCION  >= 55);

drop view vista_salas;

create view vista_salas as 
    select Sala.ID_SALA___SALA as Sala, Funcionario.NOMBRE___FUNCIONARIO as Funcionario, Mantenimiento.FECHA___MANTENIMIENTO as Fecha
        from Sala
        join Mantenimiento on mantenimiento.id_sala___mantenimiento = sala.id_sala___sala
        join Funcionario on Mantenimiento.RUT_FUNCIONARIO___MANTENIMIENTO = Funcionario.RUT_FUNCIONARIO___FUNCIONARIO
        order by Fecha;

-- drop view vista_poderes_aux;

create view vista_poderes_aux as
    select RUT_PROFESOR___PROFESOR  ,poder___profesor as poder from Profesor
    union
    select RUT_ALUMNO___ALUMNO, poder___alumno from Alumno
    union
    select RUT_FUNCIONARIO___FUNCIONARIO, poder___funcionario from Funcionario;

-- drop view vista_poderes;

create view vista_poderes as
    select poder,count(poder) as Total from vista_poderes_aux group by poder;
    
drop view vista_top_aux;

create view vista_top_aux as 
    select RUT_ALUMNO___INSCRIPCION, count(ID_CURSO___INSCRIPCION) as n_cursos
        from Inscripcion
        where NOTA___INSCRIPCION > 55 and NOTA___INSCRIPCION <90
        group by RUT_ALUMNO___INSCRIPCION;
        
create view vista_top as 
    SELECT ID_CURSO___INSCRIPCION,
    (select RUT_ALUMNO___INSCRIPCION
        from Inscripcion
        where NOTA___INSCRIPCION > 55 and NOTA___INSCRIPCION <90
        group by RUT_ALUMNO___INSCRIPCION) as Alumnoss
    FROM Inscripcion;

    
--create view vista_top as 
--    SELECT * FROM  (<SELECT query that produces the data>)   
--        AS <alias for the source query>  
--    PIVOT  
--    (  
--        <aggregation function>(<column being aggregated>)  
--    FOR   
--        [<column that contains the values that will become column headers>]   
--            IN ( [first pivoted column], [second pivoted column],  
--        ... [last pivoted column])  );  
        
create view vista_profesores as
    select P.nombre___profesor ,count(C.ID_CURSO___CURSO) as n_cursos  
    from Profesor P
    join Curso C on C.RUT_PROFESOR___CURSO = P.rut_profesor___profesor
    group by P.nombre___profesor;
        
CREATE TRIGGER trigger_eliminar before DELETE ON Asignatura FOR EACH ROW 
    BEGIN
        delete from Inscripciones where ID_CURSO_INSCRIPCION = (select ID_CURSO___CURSO  INTO x_1 FROM Curso where ID_ASIGNATURA___CURSO =: OLD.ID_ASIGNATURA___ASIGNATURA);
        delete from Curso where ID_ASIGNATURA___CURSO =: OLD.ID_ASIGNATURA___ASIGNATURA;
    END;
    
CREATE TRIGGER TRIGGER_ELIMINAR before DELETE ON Asignatura FOR EACH ROW
    BEGIN
        delete from Inscripciones where ID_CURSO_INSCRIPCION = (select id_curso  INTO x_1 from Curso where id_asignatura =: OLD.id_asignatura);
        delete from Curso where ID_Asignatura =: OLD.ID_Asignatura;
    END;
    
CREATE TRIGGER trigger_profesor before insert on Profesor FOR EACH ROW
    Begin
        insert into Curso values(old.ID_CURSO___CURSO,old.SEMESTRE___CURSO,old.ANIO___CURSO,new.RUT_PROFESOR___CURSO,old.ID_ASIGNATURA___CURSO,old.ID_SALA___CURSO)
            
        
    End;
    
CREATE PROCEDURE procedure_mantenimiento
(
	ID_SALA IN NUMBER
)
IS
BEGIN
	-- declaro una variable en la cual guardare el ru del funcionario
	DECLARE funcionario varchar2(50) := '';         
	--obtengo primero la sala que a tenido mas tiempo sin realizar una mantención 
	select 	funcionario := RUT_FUNCIONARIO_MANTENIMIENTO from mantenimiento WHERE ROWNUM <=1 order by FECHA_MANTENIMIENTO ASC;
	-- INSERTO EL REGISTRO EN LA TABLA MANTENIMIENTO
	INSERT INTO MANTENIMIENTO(RUT_FUNCIONARIO_MANTENIMIENTO, ID_SALAMANTENIMIENTO,FECHA_MANTENIMIENTO) VALUES (:funcionario,ID_SALA, SYSDATE)
EXCEPTION
	-- ACA CAPTURAS EL ERROR
END;

CREATE PROCEDURE PROCEDURE_REPROBADOS 
(
	RUT_PROFESOR IN VARCHAR2(10)
)
IS
BEGIN
	-- obtengo al alumno, la nota y el nombre de la asignatura, no tengo el join de la tabla profesor porq como solo 
	--necesitamos preguntar por el rut podemos hacerlo directamente desde la tabla curso
	SELECT ALUMNO.NOMBRE__ALUMNO,INSCRIPCION.NOTA_INSCRIPCION,ASIGNATURA.NOMBRE__ASIGNATURA FROM ALUMNO 
	JOIN INSCRIPCION ON ALUMNO.RUT_ALUMNO__ALUMNO =INSCRIPCION.RUT_ALUMNO__INSCRIPCION
	JOIN CURSO ON CURSO.ID_CURSO__CURSO =INSCRIPCION.ID_CURSO__INSCRIPCION
	JOIN ASIGNATURA ON ASIGNATURA.ID_ASIGNATURA__ASIGNATURA =CURSO.ID_ASIGNATURA__CURSO
	WHERE CURSO.RUT_PROFESOR__CURSO = RUT_PROFESOR AND  Inscripcion.NOTA__INSCRIPCION  < 50
EXCEPTION

END;