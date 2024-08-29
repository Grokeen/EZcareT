SELECT *
  FROM ACPPRPTD
   WHERE PT_NO = '00000001'
;

SELECT *
  FROM ACPPRODM
   WHERE PT_NO = '00000001'
     AND MED_RSV_DTM BETWEEN TRUNC(SYSDATE) AND SYSDATE
;


select to_date(REG_DT,'YYYY-MM-DD') ,  REG_DT, TO_CHAR(REG_DT,'YYYY-MM-DD'), to_date(TO_CHAR(REG_DT,'YYYY-MM-DD'),'YYYY-MM-DD')                                                            AS IN_REG_DT        /* O.등록일자 */

FROM ACPPRPTD where

reg_dt between TRUNC('2024-05-23') and TRUNC('2024-08-23')

--reg_dt between to_date('2024-05-23','YYYY-MM-DD') and to_date('2024-08-23','YYYY-MM-DD')


/* 경찰트라우마진료의뢰서 */
;;

select * from ACPPROSD;


TO_DATE(TO_CHAR(REG_DT,'YYYY-MM-DD'),'YYYY-MM-DD')                           AS IN_REG_DT        /* O.등록일자 */;
