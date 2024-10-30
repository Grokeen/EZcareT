EXEC :IN_MDRC_ID := '500221925';
EXEC :IN_MDFM_ELMT_ID := '274a54b9-3056-4e2b-b5b7-e971aa0364e7';




      SELECT
                CASE WHEN (Z.ELMT_CCLS_CD = 5 OR Z.ELMT_CCLS_CD = 6) AND DBMS_LOB.COMPARE(Z.REC_VALUE, '1', 1, 1) = 0 THEN TO_CLOB(Z.MDFM_CPEM_CNTE)
                    ELSE Z.REC_VALUE
                END                         REC_VALUE
            --INTO V_REC_VALUE
            FROM


            (
              ;;;
             SELECT
                        M.MDFM_ID
                      , M.MDFM_FOM_SEQ
                      , N.MDFM_CPEM_ID
                      , N.REC_VAL_SEQ
                      , N.MDFM_CPEM_NO
                      , TO_CLOB(N.MDFM_ELMT_INPT_CNTE)        REC_VALUE
                      , M.ELMT_CCLS_CD
                      , M.MDFM_CPEM_CNTE
                FROM ( SELECT
                        M.MDFM_ID
                      , M.MDFM_FOM_SEQ
--                      , N.MDFM_CPEM_ID
--                      , N.REC_VAL_SEQ
--                      , N.MDFM_CPEM_NO
--                      , TO_CLOB(N.MDFM_ELMT_INPT_CNTE)        REC_VALUE
                      , A.ELMT_CCLS_CD
                      , A.MDFM_CPEM_CNTE
                      , M.MDRC_ID
                      , M.MDRC_FOM_SEQ
                      , A.MDFM_CPEM_ID
                       FROM MRDDRECM M/*, MRDDRECE N*/, MRFMFCID A
               WHERE M.MDRC_ID = :IN_MDRC_ID
                 AND M.LST_YN = 'Y'
                 AND M.MDRC_DC_TP_CD = 'C'
--                 AND M.MDRC_ID = N.MDRC_ID
--                 AND M.MDRC_FOM_SEQ = N.MDRC_FOM_SEQ
                 AND M.MDFM_ID = A.MDFM_ID
                 AND M.MDFM_FOM_SEQ = A.MDFM_FOM_SEQ
--                 AND N.MDFM_CPEM_ID = A.MDFM_CPEM_ID
                 AND A.MDFM_CPEM_NO = :IN_MDFM_ELMT_ID) M



                , MRDDRECE N
               WHERE M.MDRC_ID = N.MDRC_ID
                 AND M.MDRC_FOM_SEQ = N.MDRC_FOM_SEQ
                 AND M.MDFM_CPEM_ID = N.MDFM_CPEM_ID


               ;;;

              UNION ALL


              ;;;


              SELECT
                        M.MDFM_ID
                      , M.MDFM_FOM_SEQ
                      , N.MDFM_CPEM_ID
                      , N.REC_VAL_SEQ
                      , N.MDFM_CPEM_NO
                      , N.DCST_LDAT        REC_VALUE
                      , M.ELMT_CCLS_CD
                      , M.MDFM_CPEM_CNTE
                FROM (
                    SELECT
                        M.MDFM_ID
                      , M.MDFM_FOM_SEQ
--                      , N.MDFM_CPEM_ID
--                      , N.REC_VAL_SEQ
--                      , N.MDFM_CPEM_NO
--                      , TO_CLOB(N.MDFM_ELMT_INPT_CNTE)        REC_VALUE
                      , A.ELMT_CCLS_CD
                      , A.MDFM_CPEM_CNTE
                      , M.MDRC_ID
                      , M.MDRC_FOM_SEQ
                      , A.MDFM_CPEM_ID
                FROM MRDDRECM M/*, MRDDRECE N*/, MRFMFCID A
               WHERE M.MDRC_ID = :IN_MDRC_ID
                 AND M.LST_YN = 'Y'
                 AND M.MDRC_DC_TP_CD = 'C'
--                 AND M.MDRC_ID = N.MDRC_ID
--                 AND M.MDRC_FOM_SEQ = N.MDRC_FOM_SEQ
                 AND M.MDFM_ID = A.MDFM_ID
                 AND M.MDFM_FOM_SEQ = A.MDFM_FOM_SEQ
--                 AND N.MDFM_CPEM_ID = A.MDFM_CPEM_ID
                 AND A.MDFM_CPEM_NO = :IN_MDFM_ELMT_ID

                ) M


                , MRDDRLFE N
               WHERE M.MDRC_ID = N.MDRC_ID
                 AND M.MDRC_FOM_SEQ = N.MDRC_FOM_SEQ
                 AND M.MDFM_CPEM_ID = N.MDFM_CPEM_ID

              ;;;

            )     z




------------------------------------------------------------------------------------------------------------------------------------------------------------
;;;

-- 0123006366 값이 있어야 함


SELECT * FROM MRDDRECM WHERE PT_NO = '01894671';
SELECT * FROM AIF0601T WHERE rownum<10--PT_NO = '01894671';
;;




SELECT * FROM
               (SELECT *--SRIL_CFMT_NO
                  FROM ACPPRGHD BI
                 WHERE 1=1
                   AND BI.PT_NO='00776940'
                   --AND BI.MDRC_ID = M.MDRC_ID  -- (현재는 MDIC_ID로 묶이지 않아, 최신 산정특례 번호를 임의로 출력 만 가능하게 해뒀으니, 추후 진료 쪽과 확인 후, 조정이 필요할 거 같습니다.)
                 ORDER BY TO_CHAR(APLC_DT,'YYYYMMDD') DESC)
             WHERE ROWNUM=1;



;;;;
-- 중증산정특례신청서이력
SELECT * FROM ACPPRGHH WHERE SRIL_CFMT_NO = '0123006366';

-- 중증산정특례신청서이력
SELECT * FROM ACPPRGCD WHERE SRIL_CFMT_NO = '0123006366';

-- 중증산정특례신청서이력
SELECT * FROM ACPPRGHH WHERE SRIL_CFMT_NO = '0123006366';

-- 중증산정특례신청서이력
SELECT * FROM ACPPRGHH WHERE SRIL_CFMT_NO = '0123006366';
;;;;;
SELECT *
  FROM ALL_TAB_COLUMNS
 WHERE (LOW_VALUE LIKE '%0122172199%'
   OR HIGH_VALUE LIKE '%0122172199%'
   OR COLUMN_NAME LIKE '%SRIL_CFMT_NO%' )
--   AND LENGTH(TO_CHAR(COLUMN_NAME)) = 8
 ;;;

SELECT LENGTH('ACPPRGHD') FROM DUAL;

select * from ALL_TAB_COLUMNS where rownum <10;


SELECT * FROM ALL_TABLES WHERE ROWNUM < 10;
