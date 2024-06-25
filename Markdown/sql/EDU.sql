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
select hiredate from emp;



-- 240625 ##############################################################################