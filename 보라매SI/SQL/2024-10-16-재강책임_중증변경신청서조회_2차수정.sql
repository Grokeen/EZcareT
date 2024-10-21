exec :IN_PT_NO := '';
EXEC :IN_REG_DT := '202410';

;;;
<sql id="HIS.PA.AC.PI.SelectSeriousIllnessModificationApplicationFormCancelAsk">

;
SELECT /*+ HIS.PA.AC.PI.SelectSeriousIllnessModificationApplicationFormCancelAsk */
       /* pkg_bil_srimd.pc_ap_apreghvt_resend_select2 */
        M.MDRC_ID                                                      AS MDRC_ID
       ,M.MDRC_FOM_SEQ                                                 AS MDRC_FOM_SEQ
       ,M.PT_NO                                                        AS PT_NO

       ,XBIL.FT_ACP_GET_PATNM(M.PT_NO)                                 AS PT_NM   -- 성명


       ,(SELECT
             PLS_DECRYPT_B64_ID(D.PT_RRN, 800)
           FROM PCTPCPAM D
         WHERE D.PT_NO = M.PT_NO)                                      AS SSN     -- 주민번호


       -- 2024-10-17 김용록 : 주소 조회 쿼리 변경
       , FT_PCT_GETCTAD(M.PT_NO,'0','51')                              AS ADDR   -- 주소

       ,CASE WHEN M.MDFM_ID = '2004772' THEN XMED.FT_MRD_GET_ELMT_INFO('MDFM_CPEM_NO', M.MDRC_ID, '274a54b9-3056-4e2b-b5b7-e971aa0364e7')
                                        ELSE XMED.FT_MRD_GET_ELMT_INFO('MDFM_CPEM_NO', M.MDRC_ID, 'fff59dde-db20-41b4-82d4-aca919a3bfbf')
       END                                                             AS CFSC_NO  -- 산정특례번호(REG_NO)



       ,CASE WHEN M.MDFM_ID = '2004772' THEN
               COALESCE(
                   (XMED.FT_MRD_GET_ELMT_INFO('MDFM_CPEM_NO', M.MDRC_ID, '216f5ec6-109b-4070-9178-a9f9a66cc239')),  -- 변경
                   (XMED.FT_MRD_GET_ELMT_INFO('MDFM_CPEM_NO', M.MDRC_ID, '54c7ca01-7033-4bca-8c57-7928c24b15a0')),  -- 판정오류
                   (XMED.FT_MRD_GET_ELMT_INFO('MDFM_CPEM_NO', M.MDRC_ID, '83895d42-e810-44eb-8da8-db9915ace6d6'))   -- 취소
               )
           ELSE '변경'
       END                                                             AS APLC_TP --신청구분(GBN)


       -- 2024-10-17 김용록 : 10월 조회 시, 변경전과 변경후 상병이 안 나오는데 확인 필요
       ,CASE WHEN M.MDFM_ID = '2004772' THEN XMED.FT_MRD_GET_ELMT_INFO('MDFM_CPEM_NO', M.MDRC_ID, '3bfd704e-0f5e-428e-834b-b01d2a1ef8c5')
                                        ELSE XMED.FT_MRD_GET_ELMT_INFO('MDFM_CPEM_NO', M.MDRC_ID, 'e499201f-62df-4ba7-ad80-613a7e5101ff')
       END                                                             AS CHG_FMR_SKNS   -- 변경전 상병(CONTS02)


       ,CASE WHEN M.MDFM_ID = '2004772' THEN XMED.FT_MRD_GET_ELMT_INFO('MDFM_CPEM_NO', M.MDRC_ID, '292febc3-cd47-4323-9f79-ad40e7d755d1')
                                        ELSE XMED.FT_MRD_GET_ELMT_INFO('MDFM_CPEM_NO', M.MDRC_ID, '68b32718-88ea-487c-967c-b597db67bba2')
       END                                                             AS CHG_AFT_SKNS     -- 변경후 상병(DZ_NO)



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
       END                                                             AS LIC_NO     -- 담당의사 면허번호
       ,M.REC_DTM                                                       AS CRT_DTE

       ,TO_DATE(:IN_REG_DT,'YYYY-MM')
       ,LAST_DAY(TO_DATE(:IN_REG_DT,'YYYY-MM'))

  FROM MRDDRECM M /* 진료기록기본 테이블 */

 WHERE 1=1
   AND M.PT_NO = NVL(:IN_PT_NO, M.PT_NO)

   -- MDFM ID 필터(진료서식ID)
   AND M.MDFM_ID IN ('2004772',
                     '2004779')

   -- 2024-10-17 김용록 : 기간 -> 월 조회로 변경
   AND TO_CHAR(M.REC_DTM,'YYYYMM') =  NVL(:IN_REG_DT, TO_CHAR(M.REC_DTM,'YYYYMM'))

   -- 2024-10-17 김용록 : 쿼리 속도가 느려 수정기록일시 주석 후, ROWNUM < 100 추가
   --AND M.MDF_REC_DTM >= TO_DATE('20100101', 'YYYYMMDD')   -- 수정기록일시 > 2010-01-01

   AND M.MDRC_DC_TP_CD = 'C'                              -- 삭제 안한 기록
   AND M.LST_YN = 'Y'                                     -- 최종여부 'Y'
   AND M.MDRC_WRT_STS_CD > 10                             -- 진료기록상태코드 > 10
   AND OLD_MDFM_ID IS NULL                                -- 마이그 된 기록들 제외

   -- 2024-10-17 김용록 : 쿼리 속도가 느려 수정기록일시 주석 후, ROWNUM < 100 추가
   AND ROWNUM < 100

 ;;;

 UNION ALL



 -- ASIS 기록들
 SELECT /* pkg_bil_srimd.pc_ap_apreghvt_resend_select2 */
       Z.DOC_NOTE_ID                                                              AS DOC_NOTE_ID /* 진료기록ID */
     , Z.RLS_NO                                                                   AS RLS_NO      /* 개정번호 */
     , Z.PT_NO                                                                    AS PT_NO
     , Z.PT_NM                                                                    AS PT_NM       --성명
     , SCP.DEC_STR('PE8',D.SSN)                                                   AS SSN         --주민번호
     , D.ADDR                                                                     AS ADDR        --주소
     , DECODE(Z.DOCNOTE_TYP_ID,'470',C.CONTS08,C.CONTS01)                         AS CFSC_NO     --산정특례 번호(REG_NO)
     , CASE WHEN Z.DOCNOTE_TYP_ID = '470' THEN DECODE(C.CONTS01,'2','판정오류'
                                                               ,'3','취소'
                                                               ,'변경')
            ELSE '변경'
       END                                                                        AS APLC_TP      --신청구분(GBN)


     , DECODE(Z.DOCNOTE_TYP_ID,'470',TRIM(C.CONTS03)
                                    ,TRIM(C.CONTS02))                             AS CHG_FMR_SKNS   -- 변경전 상병(CONTS02)

     , DECODE(Z.DOCNOTE_TYP_ID,'470',TRIM(C.CONTS04)
                                    ,TRIM(D.DZ_NO))                               AS CHG_AFT_SKNS     -- 변경후 상병(DZ_NO)


     , DECODE(Z.DOCNOTE_TYP_ID,'470','',TRIM(C.CONTS03))                          AS CONTS03    --1. 조직을 포함한 타검사를 통해 원발암 부위 변경  2. 기타
     , DECODE(Z.DOCNOTE_TYP_ID,'470','',TRIM(C.CONTS04))                          AS CONTS04    --기타 내용
     , D.DR_NM                                                                    AS ASDR_NM    --담당의사(DR_NM)
     , DECODE(Z.DOCNOTE_TYP_ID,'470',TO_CHAR(Z.CRT_DTE,'YYYY-MM-DD'),D.MED_DAY)   AS REG_DT     --신청일(REQ_DTE)
     , DECODE(Z.DOCNOTE_TYP_ID,'440','급여','보험')                                   AS INS_CLS   --439보험,440급여(PATTYPE)
     , DECODE(Z.PT_SECT,'I','입원','O','외래','E','응급')                              AS CTH_TP     -- 내원구분(PT_SECT)


     , DECODE(Z.DOCNOTE_TYP_ID,'470',C.CONTS41,C.CONTS05)                         AS RMK        --2017.09.15 신원석 비고입력추가 기록지가 뭐필요한지 간호/심사팀에서 입력한다고함 기록담당자 박은선 책임과 컬럼 협의함
     , DECODE(Z.DOCNOTE_TYP_ID,'470',C.CONTS42,C.CONTS06)                         AS CON_YN     --2017.09.15 신원석 원무확인 이미출력한 기록은 확인처리 하여 표시  기록담당자 박은선 책임과 컬럼 협의함
     , NVL2(DECODE(Z.DOCNOTE_TYP_ID,'470',C.CONTS41,C.CONTS05),'Y','N')           AS RMK_EN 		 /* 비고유무 */
     , NVL2(DECODE(Z.DOCNOTE_TYP_ID,'470',C.CONTS42,C.CONTS06),'Y','N')    				AS CMPL_EN 		 /* 완료유무 */


     , D.LIC_NO                                                                   AS LIC_NO     --담당의사면허번호
     , Z.CRT_DTE                                                                  AS CRT_DTE    /* 기록일자 */
  FROM ASIS_HEMR.MEDRNMAT Z       /* ASIS 진료기록메인 테이블 */
     , ASIS_HEMR.MEDNNPDT D       /* ASIS 진단서의뢰서 테이블 */
     , ASIS_HEMR.MEDNNCDT C       /* ASIS 진단서내용기록 테이블 */
 where 1=1
   AND Z.PT_NO          =  NVL(:IN_PT_NO,Z.PT_NO)

   AND Z.DC_YN          = 'C'   -- 삭제 안한 기록
   AND Z.DOC_NOTE_ID    = D.DOC_NOTE_ID
   AND Z.RLS_NO         = D.RLS_NO
   AND D.DOC_NOTE_ID    = C.DOC_NOTE_ID
   AND D.RLS_NO         = C.RLS_NO
   AND Z.DOCNOTE_TYP_ID IN ( '439' --건강보험 산정특례(암) 등록내역 변경신청서
                           , '440' --의료급여 산정특례(암) 등록내역 변경신청서
                           , '470' --건강보험 산정특례 등록내역 (변경/판정오류/취소) 신청서
                           )

   -- 2024-10-17 김용록 : 기간 -> 월 조회로 변경
   AND TO_CHAR(Z.CRT_DTE ,'YYYYMM') = NVL(:IN_REG_DT, TO_CHAR(Z.CRT_DTE ,'YYYYMM'))

   AND Z.EDIT_DTE      >= TO_DATE('20100101','YYYYMMDD')
   AND Z.RLS_NO         = (SELECT /*index_desc(medrnmat medrnmat_pk)*/
                                  RLS_NO
                             FROM ASIS_HEMR.MEDRNMAT /* ASIS 진료기록메인 테이블 */
                            WHERE DOC_NOTE_ID  = Z.DOC_NOTE_ID
                              AND ROWNUM <= 1
                           )
   AND Z.STT  >  10    /* 상태 > 10 */
 ORDER BY CRT_DTE, PT_NO
;









;;; --------------------------------------------------------------------------------


SELECT
 XBIL.FT_ACP_GET_PATNM(M.PT_NO) AS PT_NM
 ,M.*

FROM MRDDRECM M
WHERE 1=1
   AND M.PT_NO = NVL(:IN_PT_NO, M.PT_NO)

   -- MDFM ID 필터(진료서식ID)
   AND M.MDFM_ID IN ('2004772',
                     '2004779')

   AND TO_CHAR(M.REC_DTM,'YYYYMM') =  NVL(:IN_REG_DT,TO_CHAR(M.REC_DTM,'YYYYMM'))
   AND M.MDRC_DC_TP_CD = 'C'
   --AND TO_NUMBER(TO_CHAR(M.MDF_REC_DTM,'YYYYMMDD')) >= 20100101
   AND OLD_MDFM_ID IS NULL
   AND M.LST_YN = 'Y'
   AND M.MDRC_WRT_STS_CD > 10
   AND ROWNUM < 100;
;;;   ----------------------------------------------------------------------------


SELECT XMED.FT_MRD_GET_ELMT_INFO('MDFM_CPEM_NO', '2004772', '216f5ec6-109b-4070-9178-a9f9a66cc239') FROM MRDDRECM WHERE ROWNUM < 10;




select *

  FROM MRDDRECM M /* 진료기록기본 테이블 */
     , PCTPCPAM D /* 환자기본 테이블 */



;;;   ----------------------------------------------------------------------------

exec :IN_PT_NO := '';
EXEC :IN_REG_DT := '202410';





--------------------------------------------------

 select
     XBIL.FT_ACP_GET_PATNM(M.PT_NO) AS PT_NM
    ,M.*

 FROM MRDDRECM M /* 진료기록기본 테이블 */

     -- 2024-10-17 김용록 : 주민번호 주석
     --, PCTPCPAM D /* 환자기본 테이블 */

 WHERE 1=1
   AND M.PT_NO = NVL(:IN_PT_NO, M.PT_NO)

   -- 2024-10-17 김용록 : 주민번호 주석
   --AND D.PT_NO = M.PT_NO

   -- MDFM ID 필터(진료서식ID)
   AND M.MDFM_ID IN ('2004772',
                     '2004779')

   -- 2024-10-17 김용록 : 기간 -> 월 조회로 변경
   --AND M.REC_DTM between v_from_dte and v_to_dte + .99999
   AND TO_CHAR(M.REC_DTM,'YYYYMM') =  NVL(:IN_REG_DT,TO_CHAR(M.REC_DTM,'YYYYMM'))

   --의미가 있나 이게
   --AND M.MDF_REC_DTM >= TO_DATE('20100101', 'YYYYMMDD')   -- 수정기록일시 > 2010-01-01
   AND M.MDRC_DC_TP_CD = 'C' -- 삭제 안한 기록
   AND M.LST_YN = 'Y' -- 최종여부 'Y'
   --AND M.MDRC_WRT_STS_CD > 10 -- 진료기록상태코드 > 10
   AND OLD_MDFM_ID IS NULL  ;
