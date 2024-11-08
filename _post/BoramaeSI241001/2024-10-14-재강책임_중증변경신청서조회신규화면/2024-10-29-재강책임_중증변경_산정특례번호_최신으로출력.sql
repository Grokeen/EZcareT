exec :IN_REG_DT := '202410';
exec :INPTNO := '00776940';
EXEC :MDFM_ID := '2004772';
;;;

                            SELECT
                                         *
                              FROM ACPPRGHD BI,MRDDRECM M
                             WHERE 1=1
                               AND BI.PT_NO= M.PT_NO(+)

                               AND M.PT_NO= :INPTNO
                               --AND BI.MDRC_ID = M.MDRC_ID  -- (현재는 MDIC_ID로 묶이지 않아, 최신 산정특례 번호를 임의로 출력 만 가능하게 해뒀으니, 추후 진료 쪽과 확인 후, 조정이 필요할 거 같습니다.)
                               AND SUBSTR(BI.APLC_ICD10_CD_CNTE,1,1) = SUBSTR(REPLACE(REPLACE((CASE WHEN M.MDFM_ID = '2004772' THEN XMED.FT_MRD_GET_ELMT_INFO('MDFM_CPEM_NO', M.MDRC_ID, '292febc3-cd47-4323-9f79-ad40e7d755d1')
                                                                                                                               ELSE XMED.FT_MRD_GET_ELMT_INFO('MDFM_CPEM_NO', M.MDRC_ID, '68b32718-88ea-487c-967c-b597db67bba2')
                                                                                               END),CHR(10),''),CHR(13),'') ,1,1)
                              -- AND
                               AND M.MDFM_ID IN ('2004772',   --  MDFM ID 필터(진료서식ID)
                                                 '2004779')
                             ORDER BY TO_CHAR(APLC_DT,'YYYYMMDD') DESC

;;;

SELECT PCOR_ICD10_CD_CNTE FROM ACPPRGCD WHERE ROWNUM < 10;

;;;;
select M.MDRC_ID
       ,M.PT_NO                                                        AS PT_NO




       ,CASE WHEN M.PT_NO = (CASE WHEN M.MDFM_ID = '2004772' THEN XMED.FT_MRD_GET_ELMT_INFO('MDFM_CPEM_NO', M.MDRC_ID, '274a54b9-3056-4e2b-b5b7-e971aa0364e7')
                                        ELSE XMED.FT_MRD_GET_ELMT_INFO('MDFM_CPEM_NO', M.MDRC_ID, 'fff59dde-db20-41b4-82d4-aca919a3bfbf')
                              END)
             THEN COALESCE(

                         (
                         -- 중증산정특례신청서정보 테이블 / 상병 앞자리로 비교
                         SELECT * FROM
                           (SELECT SRIL_CFMT_NO
                              FROM ACPPRGHD BI
                             WHERE 1=1
                               AND BI.PT_NO=M.PT_NO
                               --AND BI.MDRC_ID = M.MDRC_ID  -- (현재는 MDIC_ID로 묶이지 않아, 최신 산정특례 번호를 임의로 출력 만 가능하게 해뒀으니, 추후 진료 쪽과 확인 후, 조정이 필요할 거 같습니다.)
                               AND SUBSTR(BI.APLC_ICD10_CD_CNTE,1,1) = SUBSTR(REPLACE(REPLACE((CASE WHEN M.MDFM_ID = '2004772' THEN XMED.FT_MRD_GET_ELMT_INFO('MDFM_CPEM_NO', M.MDRC_ID, '292febc3-cd47-4323-9f79-ad40e7d755d1')
                                                                                                                               ELSE XMED.FT_MRD_GET_ELMT_INFO('MDFM_CPEM_NO', M.MDRC_ID, '68b32718-88ea-487c-967c-b597db67bba2')
                                                                                               END),CHR(10),''),CHR(13),'') ,1,1)
                             ORDER BY TO_CHAR(APLC_DT,'YYYYMMDD') DESC
                            )
                          WHERE ROWNUM=1
                          )


                      ,
                         (
                         -- 중증진료확인증정보 테이블 / 상병 앞자리로 비교
                         SELECT * FROM
                           (SELECT SRIL_CFMT_NO
                              FROM ACPPRGCD BI--ACPPRGHD BI
                             WHERE 1=1
                               AND BI.PT_NO=M.PT_NO
                               --AND BI.MDRC_ID = M.MDRC_ID  -- (현재는 MDIC_ID로 묶이지 않아, 최신 산정특례 번호를 임의로 출력 만 가능하게 해뒀으니, 추후 진료 쪽과 확인 후, 조정이 필요할 거 같습니다.)
                               AND SUBSTR(BI.PCOR_ICD10_CD_CNTE,1,1) = SUBSTR(REPLACE(REPLACE((CASE WHEN M.MDFM_ID = '2004772' THEN XMED.FT_MRD_GET_ELMT_INFO('MDFM_CPEM_NO', M.MDRC_ID, '292febc3-cd47-4323-9f79-ad40e7d755d1')
                                                                                                                               ELSE XMED.FT_MRD_GET_ELMT_INFO('MDFM_CPEM_NO', M.MDRC_ID, '68b32718-88ea-487c-967c-b597db67bba2')
                                                                                               END),CHR(10),''),CHR(13),'') ,1,1)
                             ORDER BY TO_CHAR(APY_STR_DT,'YYYYMMDD') DESC
                            )
                          WHERE ROWNUM=1
                          )

                      ,
                         (
                         -- 중증산정특례신청서정보 테이블
                         SELECT * FROM
                           (SELECT SRIL_CFMT_NO
                              FROM ACPPRGHD BI
                             WHERE 1=1
                               AND BI.PT_NO=M.PT_NO
                               --AND BI.MDRC_ID = M.MDRC_ID  -- (현재는 MDIC_ID로 묶이지 않아, 최신 산정특례 번호를 임의로 출력 만 가능하게 해뒀으니, 추후 진료 쪽과 확인 후, 조정이 필요할 거 같습니다.)
                             ORDER BY TO_CHAR(APLC_DT,'YYYYMMDD') DESC
                            )
                          WHERE ROWNUM=1
                          )


                      ,
                         (
                         -- 중증진료확인증정보 테이블
                         SELECT * FROM
                           (SELECT SRIL_CFMT_NO
                              FROM ACPPRGCD BI--ACPPRGHD BI
                             WHERE 1=1
                               AND BI.PT_NO=M.PT_NO
                               --AND BI.MDRC_ID = M.MDRC_ID  -- (현재는 MDIC_ID로 묶이지 않아, 최신 산정특례 번호를 임의로 출력 만 가능하게 해뒀으니, 추후 진료 쪽과 확인 후, 조정이 필요할 거 같습니다.)
                             ORDER BY TO_CHAR(APY_STR_DT,'YYYYMMDD') DESC
                            )
                          WHERE ROWNUM=1
                          )
                  )
             ELSE ( CASE WHEN M.MDFM_ID = '2004772' THEN XMED.FT_MRD_GET_ELMT_INFO('MDFM_CPEM_NO', M.MDRC_ID, '274a54b9-3056-4e2b-b5b7-e971aa0364e7')
                                        ELSE XMED.FT_MRD_GET_ELMT_INFO('MDFM_CPEM_NO', M.MDRC_ID, 'fff59dde-db20-41b4-82d4-aca919a3bfbf')
                     END)
         END      AS CFSC_NO






         ,(SELECT * FROM
               (SELECT SRIL_CFMT_NO
                  FROM ACPPRGHD BI
                 WHERE 1=1
                   AND BI.PT_NO=M.PT_NO
                   --AND BI.MDRC_ID = M.MDRC_ID  -- (현재는 MDIC_ID로 묶이지 않아, 최신 산정특례 번호를 임의로 출력 만 가능하게 해뒀으니, 추후 진료 쪽과 확인 후, 조정이 필요할 거 같습니다.)
                 ORDER BY TO_CHAR(APLC_DT,'YYYYMMDD') DESC)
             WHERE ROWNUM=1) as ss


  FROM MRDDRECM M /* 진료기록기본 테이블 */

 WHERE 1=1


   AND M.MDFM_ID IN ('2004772',   --  MDFM ID 필터(진료서식ID)
                     '2004779')

   -- 2024-10-17 김용록 : 기간 -> 월 조회로 변경
   AND M.REC_DTM BETWEEN TO_DATe(:IN_REG_DT ||'01','YYYYMMDD') AND LAST_DAY(TO_DATe(:IN_REG_DT ||'01','YYYYMMDD'))

   -- 2024-10-17 김용록 : 쿼리 속도가 느려 수정기록일시 주석
   --AND M.MDF_REC_DTM >= TO_DATE('20100101', 'YYYYMMDD')   -- 수정기록일시 > 2010-01-01

   AND M.MDRC_DC_TP_CD = 'C'                              -- 삭제 안한 기록
   AND M.LST_YN = 'Y'                                     -- 최종여부 'Y'
   AND M.MDRC_WRT_STS_CD > 10                             -- 진료기록상태코드 > 10
   AND OLD_MDFM_ID IS NULL                                -- 마이그 된 기록들 제외



 ;;;;


 SELECT * FROM ACPPRGCD WHERE PT_NO = '01894671';

