
EXEC :IN_FROM_DATE := '2023-12-01';
EXEC :IN_TO_DATE := '2024-08-19' ;
-- HIS.PA.AC.PI.PI.SelectPoliceTrauma   


<sql id="HIS.PA.AC.PI.PI.SelectPoliceTrauma">
<!--
    Clss :  [text|package|sp|plsql] (쿼리유형)
    Desc : 경찰트라우마진료의뢰서조회 SELECT
    Author : 김용록
    Create date : 2024-08-19
    Update date :  
    AS IS : pkg_bil_ptinf.pc_ap_appoltrt_select
-->
SELECT /*+  HIS.PA.AC.PI.PI.SelectPoliceTrauma */
    TO_CHAR(A.REG_DT,'YYYY-MM-DD')                                           AS REG_DT          /* 1.등록일자 */
   ,NVL(A.REG_SEQ,0)                                                         AS REG_SEQ         /* 2.순번 */
   ,NVL(A.PT_NO,'-')                                                         AS PT_NO           /* 3.환자번호 */
   ,NVL(B.PT_NM,'-')                                                         AS PT_NM           /* 4.환자명 */
   ,CASE WHEN PLS_DECRYPT_B64_ID(B.PT_RRN,800) IS NULL THEN '-'
         ELSE SUBSTR(PLS_DECRYPT_B64_ID(B.PT_RRN,800),0,6) || '-'
         || SUBSTR(PLS_DECRYPT_B64_ID(B.PT_RRN,800),7,1) || '******'
    END                                                                       AS PT_RRN          /* 5.주민번호 */
   ,DECODE(A.PACT_TP_CD,'I','입원','O','외래','E','응급',NULL,'-',A.PACT_TP_CD)    AS PACT_TP_CD      /* 6.입원외래 */

   ,NVL(C.DEPT_NM,'-')                                                        AS DEPT_NM         /* 7.진료과 */
   ,NVL(A.RMK_CNTE,'-')                                                       AS RMK_CNTE        /* 8.비교 */

FROM ACPPRPOT A, /* 경찰트라우마진료의뢰서 */
     PCTPCPAM B, /* 환자정보 */
     PDEDBMSM C  /* 부서기본(과정보) */
WHERE  A.PT_NO = B.PT_NO(+)
   AND A.MED_DEPT_CD = C.DEPT_CD(+)
   AND A.CNCL_DT IS NOT NULL
   AND(A.REG_DT BETWEEN NVL(:IN_FROM_DATE,'1958-08-01') AND NVL(:IN_TO_DATE,'2100-01-01'))
ORDER BY A.REG_DT DESC        
----------------------------------------------------------------------------------------------------------------------------------
-- imc77 통합예약관리
select /*+ pkg_bil_ptinf.pc_ap_appoltrt_select */
                to_char(a.req_dte,'yyyy-mm-dd')                 	req_dte
              , a.req_seq                                       	req_seq
              , a.pt_no                                         	pt_no
              , decode(nvl(a.pt_no,'*'),'*',a.pt_nm,c.pt_nm)    	pt_nm
--              , decode(nvl(a.pt_no,'*'),'*',a.ssn1,c.ssn1)
--                || '-' ||decode(nvl(a.pt_no,'*'),'*',DEC_SSN2(a.ssn2),DEC_SSN2(c.ssn2)) ssn     --2020.11.23 주민번호 뒷자리 체크  
              , decode(nvl(a.pt_no,'*'),'*',a.ssn1,c.ssn1)
                || '-' || substr(decode(nvl(a.pt_no,'*'),'*',DEC_SSN2(a.ssn2),DEC_SSN2(c.ssn2)),1,1) ||'******'  ssn    
              , decode(a.patsite,'O','외래','I','입원','응급')  	patsite
              , NULL         																			er_kit_yn
              , NULL																							ATK_GUBN
              , b.dept_nm                                       	dept_nm
              , a.rmk																							rmk
           from appoltrt a -- 경찰트라우마진료의뢰서
              , ccdepart b -- MRDDRITD 이미지템플릿정보(진료간호) / PDEDBMSM 부서기본
              , appatbat c -- 환자기본
          where a.req_dte between to_date(:in_from_dte,'yyyy-mm-dd')
                              and to_date(:in_to_dte,'yyyy-mm-dd')
            and a.med_dept = b.dept_cd (+)
            and a.pt_no    = c.pt_no   (+)
            and a.cncl_dte is null                  -- 2010-11-08 권욱주 추가 
          order by 1 desc,2;             
          
          
----------------------------------------------------------------------------------------------------------------------------------    
          
SELECT /*+  HIS.PA.AC.PI.PI.SelectPoliceTrauma */
    TO_CHAR(A.REG_DT,'YYYY-MM-DD')                                           AS REG_DT          /* 1.등록일자 */
   ,NVL(A.REG_SEQ,0)                                                         AS REG_SEQ         /* 2.순번 */
   ,NVL(A.PT_NO,'-')                                                         AS PT_NO           /* 3.환자번호 */
   ,NVL(B.PT_NM,'-')                                                         AS PT_NM           /* 4.환자명 */
   ,CASE WHEN PLS_DECRYPT_B64_ID(B.PT_RRN,800) IS NULL THEN '-'
         ELSE SUBSTR(PLS_DECRYPT_B64_ID(B.PT_RRN,800),0,6) || '-'
         || SUBSTR(PLS_DECRYPT_B64_ID(B.PT_RRN,800),7,1) || '******'
    END                                                                       AS PT_RRN          /* 5.주민번호 */
   ,DECODE(A.PACT_TP_CD,'I','입원','O','외래','E','응급',NULL,'-',A.PACT_TP_CD)    AS PACT_TP_CD      /* 6.입원외래 */

   ,NVL(C.DEPT_NM,'-')                                                        AS DEPT_NM         /* 7.진료과 */
   ,NVL(A.RMK_CNTE,'-')                                                       AS RMK_CNTE        /* 8.비교 */

FROM ACPPRPOT A, /* 경찰트라우마진료의뢰서 */
     PCTPCPAM B, /* 환자정보 */
     PDEDBMSM C  /* 부서기본(과정보) */
WHERE  A.PT_NO = B.PT_NO(+)
   AND A.MED_DEPT_CD = C.DEPT_CD(+)
   AND A.CNCL_DT IS NOT NULL
   AND(A.REG_DT BETWEEN NVL(:IN_FROM_DATE,'1958-08-01') AND NVL(:IN_TO_DATE,'2100-01-01'))
ORDER BY A.REG_DT DESC

         ;
 A, PCTPCPAM B, PDEDBMSM C;

SELECT * FROM ACPPROSD WHERE ROWNUM < 100;
SELECT * FROM CCCCCLTC WHERE ROWNUM < 10; AND COMN_GRP_CD =;
