
EXEC :IN_PT_NO := '';
EXEC :IN_REG_DT := '202410';

SELECT /*+ HIS.PA.AC.PI.SelectSeriousIllnessModificationApplicationFormCancelAsk */
       /* pkg_bil_srimd.pc_ap_apreghvt_resend_select2 */
        TO_CHAR(M.MDRC_ID)                                             AS MDRC_ID
       ,TO_CHAR(M.MDRC_FOM_SEQ)                                        AS MDRC_FOM_SEQ
       ,M.PT_NO                                                        AS PT_NO

       ,XBIL.FT_ACP_GET_PATNM(M.PT_NO)                                 AS PT_NM   -- 성명


       ,(SELECT
             PLS_DECRYPT_B64_ID(D.PT_RRN, 800)
           FROM PCTPCPAM D
         WHERE D.PT_NO = M.PT_NO)                                      AS SSN     -- 주민번호


       -- 2024-10-17 김용록 : 주소 조회 쿼리 변경
       , FT_PCT_GETCTAD(M.PT_NO,'0','51')                              AS ADDR   -- 주소



		-- 2024-10-24 김용록 : 산정특례 번호기 환자번호로 나온다는 문의로 수정
       ,NVL((CASE WHEN M.MDFM_ID = '2004772' THEN XMED.FT_MRD_GET_ELMT_INFO('MDFM_CPEM_NO', M.MDRC_ID, '274a54b9-3056-4e2b-b5b7-e971aa0364e7')
                                        ELSE XMED.FT_MRD_GET_ELMT_INFO('MDFM_CPEM_NO', M.MDRC_ID, 'fff59dde-db20-41b4-82d4-aca919a3bfbf')
        END)
          ,(SELECT * FROM
               (SELECT SRIL_CFMT_NO
                  FROM ACPPRGHD BI
                 WHERE 1=1
                   AND BI.PT_NO=M.PT_NO
                   --AND BI.MDRC_ID = M.MDRC_ID  -- (현재는 MDIC_ID로 묶이지 않아, 최신 산정특례 번호를 임의로 출력 만 가능하게 해뒀으니, 추후 진료 쪽과 확인 후, 조정이 필요할 거 같습니다.)
                 ORDER BY TO_CHAR(APLC_DT,'YYYYMMDD') DESC)
             WHERE ROWNUM=1) )                                          AS CFSC_NO  -- 산정특례번호(REG_NO)



       ,CASE WHEN M.MDFM_ID = '2004772' THEN
               COALESCE(
                   (XMED.FT_MRD_GET_ELMT_INFO('MDFM_CPEM_NO', M.MDRC_ID, '216f5ec6-109b-4070-9178-a9f9a66cc239')),  -- 변경
                   (XMED.FT_MRD_GET_ELMT_INFO('MDFM_CPEM_NO', M.MDRC_ID, '54c7ca01-7033-4bca-8c57-7928c24b15a0')),  -- 판정오류
                   (XMED.FT_MRD_GET_ELMT_INFO('MDFM_CPEM_NO', M.MDRC_ID, '83895d42-e810-44eb-8da8-db9915ace6d6'))   -- 취소
               )
           ELSE '변경'
       END                                                             AS APLC_TP --신청구분(GBN)


       -- 2024-10-27 김용록 : 개행 제거 REPLACE 문 추가
       ,REPLACE(REPLACE((CASE WHEN M.MDFM_ID = '2004772' THEN XMED.FT_MRD_GET_ELMT_INFO('MDFM_CPEM_NO', M.MDRC_ID, '3bfd704e-0f5e-428e-834b-b01d2a1ef8c5')
                                        ELSE XMED.FT_MRD_GET_ELMT_INFO('MDFM_CPEM_NO', M.MDRC_ID, 'e499201f-62df-4ba7-ad80-613a7e5101ff')
       END),CHR(10),''),CHR(13),'')                                    AS CHG_FMR_SKNS   -- 변경전 상병(CONTS02)


       ,REPLACE(REPLACE((CASE WHEN M.MDFM_ID = '2004772' THEN XMED.FT_MRD_GET_ELMT_INFO('MDFM_CPEM_NO', M.MDRC_ID, '292febc3-cd47-4323-9f79-ad40e7d755d1')
                                        ELSE XMED.FT_MRD_GET_ELMT_INFO('MDFM_CPEM_NO', M.MDRC_ID, '68b32718-88ea-487c-967c-b597db67bba2')
       END),CHR(10),''),CHR(13),'')                                    AS CHG_AFT_SKNS     -- 변경후 상병(DZ_NO)




       ,CASE WHEN M.MDFM_ID = '2004779' THEN
              COALESCE(
                  (SELECT XMED.FT_MRD_GET_ELMT_INFO('MDFM_CPEM_NO', M.MDRC_ID, '860cce6c-2000-43f1-82a6-2e49265c8a54') FROM DUAL),  -- 조직을 포함한 타검사를 통해 원발암 부위 변경
                  (SELECT XMED.FT_MRD_GET_ELMT_INFO('MDFM_CPEM_NO', M.MDRC_ID, '9bc6b9b4-4198-45f4-a159-3609f935387c') FROM DUAL)  -- 기타
              )
            ELSE ''
       END                                                             AS CONTS03


       ,CASE WHEN M.MDFM_ID = '2004779' THEN XMED.FT_MRD_GET_ELMT_INFO('MDFM_CPEM_NO', M.MDRC_ID, '5DBECDB4-8B8E-48E9-9459-204F1D7B12C4')
                                        ELSE ''
       END                                                             AS CONTS04   -- 기타내용


       ,CASE WHEN M.MDFM_ID = '2004772' THEN XMED.FT_MRD_GET_ELMT_INFO('MDFM_CPEM_NO', M.MDRC_ID, '76b0387f-f9ad-4ba1-9656-fe8974dc5d73')
                                        ELSE XMED.FT_MRD_GET_ELMT_INFO('MDFM_CPEM_NO', M.MDRC_ID, '55c73207-1b64-4ea6-b22a-d78e5da81eeb')
       END                                                             AS ASDR_NM      --담당의사(DR_NM)


       ,TO_CHAR(M.REC_DTM,'YYYY-MM-DD')                                AS REG_DT     --신청일(REQ_DTE)

       -- 2024-10-17 김용록 : 여긴 작성된 주석 이상하니, 확인 필요
       ,DECODE(M.MDFM_ID, '2004772', '급여', '보험')                       AS INS_CLS    --2004772 보험 ,2004772 급여(PATTYPE)
       ,DECODE(M.PACT_TP_CD, 'I', '입원', 'O', '외래', 'E', '응급')         AS CTH_TP     -- 내원구분(PT_SECT)

       ,''                                                             AS RMK       -- 2017.09.15 신원석 비고입력추가 기록지가 뭐필요한지 간호/심사팀에서 입력한다고함 기록담당자 박은선 책임과 컬럼 협의함
       ,''                                                             AS CON_YN    -- 2017.09.15 신원석 원무확인 이미출력한 기록은 확인처리 하여 표시  기록담당자 박은선 책임과 컬럼 협의함
       ,'N'                       			                               AS RMK_EN 			/* 비고유무 */
       ,'N'    												                                 AS CMPL_EN 		/* 완료유무 */


       ,CASE WHEN M.MDFM_ID = '2004772' THEN XMED.FT_MRD_GET_ELMT_INFO('MDFM_CPEM_NO', M.MDRC_ID, '4e37dbdd-1b41-4d26-9536-992bc35aa1da')
                                        ELSE XMED.FT_MRD_GET_ELMT_INFO('MDFM_CPEM_NO', M.MDRC_ID, 'f4f17951-5203-43ac-b7db-e64de93e30e5')
       END                                                             AS LIC_NO      -- 담당의사 면허번호
       ,M.REC_DTM                                                      AS CRT_DTE     -- 기록일시

  FROM MRDDRECM M /* 진료기록기본 테이블 */

 WHERE 1=1


   AND M.MDFM_ID IN ('2004772',   --  MDFM ID 필터(진료서식ID)
                     '2004779')

   -- 2024-10-17 김용록 : 기간 -> 월 조회로 변경
   AND M.REC_DTM BETWEEN TO_DATE('20241001') AND TO_DATE('20241031')

   -- 2024-10-17 김용록 : 쿼리 속도가 느려 수정기록일시 주석
   --AND M.MDF_REC_DTM >= TO_DATE('20100101', 'YYYYMMDD')   -- 수정기록일시 > 2010-01-01

   AND M.MDRC_DC_TP_CD = 'C'                              -- 삭제 안한 기록
   AND M.LST_YN = 'Y'                                     -- 최종여부 'Y'
   AND M.MDRC_WRT_STS_CD > 10                             -- 진료기록상태코드 > 10
   AND OLD_MDFM_ID IS NULL                                -- 마이그 된 기록들 제외
