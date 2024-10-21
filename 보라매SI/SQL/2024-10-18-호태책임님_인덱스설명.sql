

SELECT * FROM MRDDRECM
WHERE MDRC_ID = '500129150'


-- 인덱스 4000,0000권,
-- 인덱스가 그 데이터 만 찝어온다. / 잡고있다.
-- 어딘가에서 먼저 타고 가져온다.

;;;
SELECT * FROM ACPPRODM
WHERE MED_DT = TRUNC(SYSDATE)
AND MED_YN = 'Y'
;;;


SELECT * FROM PCTPCPAM
WHERE PT_NM = '오호석'
;;


SELECT * FROM ALL_IND_COLUMNS WHERE TABLE_NAME = 'MRDDRECM'
ORDER BY TABLE_NAME, INDEX_NAME     , COLUMN_POSITION


;;; ----------------------------------------------------------------------------------------------------

SELECT
    TABLE_NAME, INDEX_NAME
   ,LISTAGG(COLUMN_NAME,',') WITHIN GROUP (ORDER BY COLUMN_POSITION) AS COLUMN_NAME
FROM ALL_IND_COLUMNS A
WHERE TABLE_NAME = 'MRDDRECM'
GROUP BY  TABLE_NAME, INDEX_NAME
ORDER BY TABLE_NAME, INDEX_NAME    -- , COLUMN_POSITION



;;; ----------------------------------------------------------------------------------------------------
;;;
MDRC_ID,MDRC_FOM_SEQ


 LST_YN
MDRC_DC_TP_CD
MDFM_CLS_CD
MED_DT
PT_MED_DEPT_CD
WRTR_DEPT_CD
REC_DTM
MDRC_WRT_STS_CD
MDFM_CLS_DTL_CD
MDRC_ID
PACT_DTM
MDFM_ID



;;;

WITH test_table AS
       (SELECT test_code
         FROM
              (SELECT 'A' AS test_code
                FROM DUAL
                  UNION
              SELECT 'B' AS test_code
                FROM DUAL
                  UNION
              SELECT 'C' AS test_code
                FROM DUAL
                  UNION
              SELECT 'D' AS test_code
                FROM DUAL
                  UNION
              SELECT 'E' AS test_code
                FROM DUAL
              )
       )

SELECT

 LISTAGG(test_code, '/') WITHIN GROUP (ORDER BY test_code)  AS test_code
FROM test_table

;
