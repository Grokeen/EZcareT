-- 240624 ##############################################################################

select * from job_history a, employees b 
where a.employee_id= b.employee_id;


-- 깃허브 클론 : https://github.com/Grokeen/Grokeen

-- nvl : null이면, 0
select DEPARTMENT_ID, nvl(manager_id,0) from departments;


-- nvl2 : null이면, 0 아니면 1
select DEPARTMENT_ID, nvl2(manager_id,0,1) from departments;


-- coalesce : 비교해서 처음 나오는 null이 아닌 값 출력
select DEPARTMENT_ID, coalesce(MANAGER_ID,LOCATION_ID) from departments;

-- nullif : 둘이 비교해서 같은 값이면 null, 아니면 첫번째 인수 출력
select DEPARTMENT_ID, MANAGER_ID, LOCATION_ID, nullif(MANAGER_ID,LOCATION_ID) from departments;


-- case문과 decode문 



-- JOIN문 실습 --------------------------------------------------------------------------
-- EMP테이블에서 "커미션을 받는" 모든 사원의 이름, 부서명, 위치를 조회(emp,dept 테이블 사용)
select ename, job, deptno from emp e ,dept d
where 조건;

-- DALLAS에 근무하는 모든 사원의 이름, 직위, 부서번호, 부서이름을 조회(location,emp 테이블 사용)
select e.ename, e.job, e.deptno from emp e ;

-- 사원 이름 및 사원 벼너호를 해당 관리자 이름 및 관리자 번홍롸 함께 표시하고 열명은 EMPLOYEE, EMPTN(), MANAGER, MGRNO()로 조회(self join문제)


-- 전체 사원을 대상으로 급여를 많이 받는 사원 순으로 정렬 및 순번을 부여하여 순변, 이름, 급여를 10명 만 조회
SELECT rownum,first_name ||last_name as Ename, salary 
from employees e 
order by e.salary desc;


-- 집합연산자 실습
-- SYSTEM 유저로 로그인 후 dba_data_files과 dba_temp_files를 이용하여 모든 file_name를 조회
select file_name from dba_data_files
union all
select file_name from dba_temp_files ;



-- DCL실습
-- emp_backup 테이블에 emp테비블에서 부서 번호가 30번이 사원의 모든 데이터를 넣으시오
-- 내가 한 거 틀렸음 insert 써야 함
update emp_backup set
deptno=(select * from emp where deptno =30);
-- 정답
insert into emp_backup select * from emp where deptno ='30';

-- emp_backup 테이블에 ename이 turner인 사원의 comm 을 1000으로 바꾸고 조회하세요
-- 내가 한 거 틀렸음 
update emp_backup set ename =(
select * from emp_backup where ename = "turner");
select * from emp_backup where ename = "turner";
-- 정답, 다 못 적었음
-- update emp_backup set 



-- emp테이블에서 각 월별 입사한 사원 수 조회
select to_cahr(hiredate,'MM') from emp;



-- 240625 ##############################################################################
-- PL/SQL 실습
Declare
    v_fname Varchar2(20); -- 변수 선언
Begin
    select first_name
        into v_fname -- v_fname에 넣겠다.
    from employees
    where employee_id = 100;
end;
/ -- '/' 변수 마감할 때 표시
    
-- 프린트 실습
SET SERVEROUTPUT ON

DECLARE
    v_fname VARCHAR2(20);
BEGIN
    SELECT first_name
        INTO v_fname
    FROM employees
    WHERE employee_id = 100;
    
    DBMS_OUTPUT.PUT_LINE('The First Name of the Employee is ' || v_fname);
END;
/


-- 중첩 PL/SQL 실습
DECLARE 
    V_OUTER_VARIABLE VARCHAR2(20) := 'GOBAL VARIABLE';
BEGIN
        DECLARE
            V_INNER_VARIABLE VARCHAR2(20) := 'LOCAL VARIABLE';
        BEGIN
            DBMS_OUTPUT.PUT_LINE(V_INNER_VARIABLE);
            DBMS_OUTPUT.PUT_LINE(V_INNER_VARIABLE);
        END;
    DBMS_OUTPUT.PUT_LINE(V_OUTER_VARIABLE);
END;
/


-- 실습, DEPARRT
DECLARE
    V_MAX_DEPTNO NUMBER(20);
BEGIN
    SELECT MAX(DEPARTMENT_ID)
    INTO V_MAX_DEPTNO
    FROM DEPARTMENTS;

    DBMS_OUTPUT.PUT_LINE(V_MAX_DEPTNO);
END;
/


-- PL/SQL 반복문 실습
DECLARE
    V_COUNTRYID LOCATION.COUNTRY_ID%TYPE := 'CA';
    V_LOC_ID LOCATION.LOCATION_ID%TYPE;
    V_NEW_CITY LOCATION.CITY%TYPE := 'MONTREEL';
    V_COUNTER NUMBER :=1;
BEGIN
    SELECT MAX(LOCATION_ID) INTO V_LOC_ID
    FROM LOCATIONS
    WHERE COUNTRY_ID = V_COUNTRYID;

    WHILE V_COUNTER<=3 LOOP
        INSERT INTO LOCATIONS(LOCATION_ID,CITY,COUNTRY_ID) 
        VALUES((V_LOC_ID+V_COUNTER), V_NEW_CITY , V_COUNTRYID);
        V_COUNTER :=V_COUNTER +1;
    END LOOP;
END;
/

-- DML, PL/SQL 실습
SELECT * FROM MESSAGES;
CREATE TABLE MESSAGES(RESULTS NUMBER);

DECLARE
    COUNTNUM NUMBER := 1;
BEGIN
    WHILE COUNTNUM <=10 LOOP
        IF COUNTNUM IN(6,8) THEN
            -- DBMS_OUTPUT.PUT_LINE(COUNTNUM);
            NULL; -- 이렇게 선언해도 되네
        ELSE
            INSERT INTO MESSAGES(RESULTS) 
            VALUES(COUNTNUM);
        END IF;

        COUNTNUM :=COUNTNUM +1;
    END LOOP;
    COMMIT;
END;
/

-- PL/SQL RECORD 실습 

DECLARE
    TYPE T_REC IS RECORD
        (V_SAL NUMBER(8),
        V_MINSAL NUMBER(8) DEFAULT 1000,
        H_HIRE_DATE EMPLOYEES.HIRE_DATE%TYPE,
        V_RECL EMPLOYEES%ROWTYPE); -- %ROWTYPE : 전체 행을 가져온다. 이점은 추가된 행의 ROW TYPE을 가져올 수 있다.
    V_MYREC T_REC;
BEGIN
    V_MYREC.V_SAL := V_MYREC.V_MINSAL +500;
    V_MYREC.H_HIRE_DATE := SYSDATE;

    SELECT *
        INTO V_MYREC.V_RECL
        FROM EMPLOYEES 
        WHERE EMPLOYEE_ID =100;
    
    DBMS_OUTPUT.PUT_LINE(V_MYREC.V_RECL.LAST_NAME ||' '|| 
    TO_CHAR( V_MYREC.H_HIRE_DATE)||' '||TO_CHAR(V_MYREC.V_SAL));
END;
/


-- PL/SQL ARRAYS 실습1
DECLARE
    TYPE DEPT_TABLE_TYPE IS TABLE OF
    DEPARTMENTS%ROWTYPE INDEX BY PLS_INTEGER;

    DEPT_TABLE DEPT_TABLE_TYPE;
    -- 
BEGIN
    SELECT * INTO DEPT_TABLE(1) 
    FROM DEPARTMENTS
    WHERE DEPARTMENT_ID =10;

    DBMS_OUTPUT.PUT_LINE(DEPT_TABLE(1).DEPARTMENT_ID ||' '|| 
    DEPT_TABLE(1).DEPARTMENT_NAME ||' '|| DEPT_TABLE(1).MANAGER_ID);
END;
/

-- PL/SQL ARRAYS 실습2
DECLARE
    TYPE EMP_TABLE_TYPE IS TABLE OF
    EMPLOYEES%ROWTYPE INDEX BY PLS_INTEGER;

    MY_EMP_TABLE EMP_TABLE_TYPE;
    MAX_COUNT NUMBER(3) :=104;
BEGIN
    FOR I IN 100.. MAX_COUNT LOOP
        SELECT *
        INTO MY_EMP_TABLE(I)
        FROM EMPLOYEES
        WHERE EMPLOYEE_ID =I;
    END LOOP;
    FOR I IN MY_EMP_TABLE.FIRST..MY_EMP_TABLE.LAST LOOP
        
        DBMS_OUTPUT.PUT_LINE(MY_EMP_TABLE(I).LAST_NAME);

    end loop;
END;
/