
/*
환자 지우는 쿼리
- PCTPCPAM
- PCTPCPTD
- ACPPRPID            

환자기본정보는 마지막에 삭제
   -> 안될 시, 요청

*/
exec :inptno := '02000829';


select *
from PCTPCPAM
where pt_no = :inptno;

select *
from PCTPCPTD
where pt_no = :inptno;

select *
from ACPPRPID
where pt_no = :inptno;
