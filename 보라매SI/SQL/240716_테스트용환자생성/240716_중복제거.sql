UPDATE ACPPRORE A
   SET APCN_DTM = SYSDATE
 WHERE A.RPY_PACT_ID != (SELECT MAX(AA.PACT_ID)
                      FROM TEMPPTRSV B
                          , ACPPRODM AA
                      WHERE AA.PT_NO = B.PT_NO
                        AND B.MED_ADS_DT = AA.MED_DT
                        AND B.DR_STF_NO = AA.MEDR_STF_NO
                        AND A.PT_NO     = B.PT_NO
                        )
  AND EXISTS (SELECT *
                FROM TEMPPTRSV B
               WHERE A.PT_NO = B.PT_NO
              )
;

UPDATE ACPPRODM A
   SET APCN_DTM = SYSDATE
 WHERE A.PACT_ID != (SELECT MAX(AA.PACT_ID)
                      FROM TEMPPTRSV B
                          , ACPPRODM AA
                      WHERE AA.PT_NO = B.PT_NO
                        AND B.MED_ADS_DT = AA.MED_DT
                        AND B.DR_STF_NO = AA.MEDR_STF_NO
                        AND A.PT_NO     = B.PT_NO
                        )
  AND EXISTS (SELECT *
                FROM TEMPPTRSV B
               WHERE A.PT_NO = B.PT_NO
              )
;





--SELECT B.PACT_ID               AS PACT_ID
--     , A.ETC4                  AS 시나리오_NO
--     , A.PT_NO                 AS 환자번호
--     , A.PT_NM                 AS 환자명
--     , B.MEDR_STF_NO           AS 진료의사번
--     , A.MED_DEPT_CD           AS 진료과코드
--     , B.MED_RSV_DTM           AS 진료예약시간
--     , NVL2(C.PT_NO,'Y','N')   AS 입원지시여부
--	FROM TEMPPTRSV A
--     , ACPPRODM  B
--     , ACPPRARD  C
-- WHERE A.NEED_OTPT_RSV = 'N'
--   AND A.PACT_TP_CD = 'I'
--   AND A.PT_NO = B.PT_NO
--   AND B.MED_DT = A.MED_ADS_DT
--   AND C.ADIS_PACT_ID(+) = B.PACT_ID
