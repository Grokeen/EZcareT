
EXEC :IN_OWNER      := 'HBIL';
EXEC :IN_COMMENT := '%입원%';
--EXEC :IN_TABLE_NAME := 'ACPPRODM';

SELECT C.TABLE_NAME
     , C.COMMENTS
--     , CASE
--           WHEN ROWNUM = 1 THEN 'NULL AS ' || RPAD(A.COLUMN_NAME, 30, ' ') || ' -- ' || LPAD( TO_CHAR(A.COLUMN_ID), 3, '0') || '. ' || B.COMMENTS
--           ELSE '     , NULL AS ' || RPAD(A.COLUMN_NAME, 30, ' ') || ' -- ' || LPAD( TO_CHAR(A.COLUMN_ID), 3, '0') || '. ' || B.COMMENTS
--       END   AS ABC
--     , A.COLUMN_ID
     , A.COLUMN_NAME

     , A.DATA_TYPE
     , B.COMMENTS
     , (CASE WHEN A.DATA_TYPE LIKE '%CHAR%' THEN A.DATA_LENGTH END) AS LENGTH
     , (SELECT 'Y'
          FROM ALL_CONSTRAINTS AA
             , ALL_CONS_COLUMNS BB


         WHERE AA.TABLE_NAME = A.TABLE_NAME
           AND AA.CONSTRAINT_TYPE ='P'
           AND AA.OWNER = BB.OWNER
           AND AA.CONSTRAINT_NAME = BB.CONSTRAINT_NAME
           AND BB.COLUMN_NAME = A.COLUMN_NAME)  PK
     , DECODE(NULLABLE, 'N', 'Y') NOTNULL
  FROM ALL_TAB_COLUMNS A
     , ALL_COL_COMMENTS B
     , ALL_TAB_COMMENTS C
 WHERE --A.TABLE_NAME = :IN_TABLE_NAME
 --AND
 C.COMMENTS = :IN_COMMENT
   AND A.OWNER      = :IN_OWNER
   AND A.OWNER      = B.OWNER
   AND A.TABLE_NAME = B.TABLE_NAME
   AND A.COLUMN_NAME= B.COLUMN_NAME
   AND A.OWNER = C.OWNER
   AND A.TABLE_NAME = C.TABLE_NAME
 ORDER BY COLUMN_ID

 ;;

SELECT *
  FROM ALL_COL_COMMENTS
 WHERE TABLE_NAME = 'ACPETHCD'

;;




select *
   from ACPETHCD
where  pt_no = '04889770'
   and rownum <10;
;;


SELECT *
  FROM ACPETHCD
where rownum < 10;


;;;

BEGIN

UPDATE ACPETHCD /*+ HIS.PA.AC.PE.PS.HipassMobileApprovalMngUpdate */
   SET   LSH_STF_NO = :HIS_STF_NO                                                  /* 최종변경하는직원번호 */
       , LSH_DTM  = SYSDATE                                                        /* 최종변경하는일시 */
       , LSH_PRGM_NM = :HIS_PRGM_NM                                                /* 최종변경하는프로그램명 */
       , LSH_IP_ADDR = :HIS_IP_ADDR                                                /* 최종변경하는IP주소 */
       , HPCD_CNCL_RSN_CD = NVL(:IN_HPCD_CNCL_RSN_CD,NULL)                         /* 취소코드 */
       , CNCL_DT = DECODE(:IN_CNCL_DT,NULL,NULL,TO_DATE(:IN_CNCL_DT,'YYYY-MM-DD')) /* 취소날짜 */
   WHERE  PT_NO = :IN_PT_NO                                                        /* 환자번호 */
     AND APY_STR_DT = TO_DATE(:IN_APY_STR_DT,'YYYY-MM-DD')                         /* 시작일자 */
     AND TKN_NO = :IN_TKN_NO                                                       /* 하이패스토큰번호 */


 IF NOT EXISTS (SELECT :IN_HPCD_CNCL_RSN_CD, :IN_CNCL_DT ,:IN_PT_NO,:IN_APY_STR_DT,:IN_TKN_NO FROM DUAL)

    ELSE
    BEGIN
        SELECT :IN_HPCD_CNCL_RSN_CD,:IN_CNCL_DT,:IN_PT_NO,:IN_APY_STR_DT,:IN_TKN_NO FROM DUAL
    END
END
