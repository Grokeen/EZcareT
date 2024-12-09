/*
2024-11-25 01560758    가영책임 문의, 이 환자는 산정특례 받지 않는데 ACPPRGHD에 존재, 신청 불가하여 0156075x 백업 처리
2024-11-27 00288645    이전 거에 산정특례번호 삽입 후, 이 신청서는 0028864x로 백업 처리
2024-12-03 01331474    (재확인)MDRC_ID가 안 묶여있어 ACPPRGCD.MDRC_ID 를 0 -> 48587858 변경
           00328176    (재확인)MDRC_ID가 안 묶여있어 ACPPRGCD.MDRC_ID 를 0 -> 48580253 변경
           01486772    (재확인)6개월 전 미리 작성했기 때문에?
           01598621    성준책임 문의, 산정특례를 받지 않는데, 받는다 되어 있어 지금 정보는 ACPPRGCD,ACPPRGHD 0159862x 백업 처리
           00910538
           01708604     왜 떴나
           01663579    가영책임 문의, 팝업 때문에 신청을 못한다. [기등록된 공단등록정보가 확인되지 않아 신청서를 작성할 수 없습니다. 원무 수납창구에 산정특례 공단정보 등록요청 후, 신청서를 작성하시기 바랍니다.]
                                    -> 진료 이수미 파트장님께 어떤 경우에 뜨는지 문의              
                                    -> 스테이징에서 테스트했기 때문에 발생한 팝업, 실제로는 정상
*/

EXEC :IN_PT_NO := '01663579';


select A.SRIL_CFMT_NO
      ,a.aplc_icd10_cd_cnte
      ,a.mdrc_id  -- 55262939
      ,a.srpp_acpt_dt
      ,a.*
  from acpprghd a /* 중증산정특례신청서정보 테이블 */
where pt_no = :IN_PT_NO
ORDER BY APLC_DT DESC;

/*
   HIRA_MED_SBJT_CD
*/



select
       A.SRIL_CFMT_NO
      ,a.apy_str_dt
      ,a.apy_end_dt
      ,a.sril_cdoc_aplc_tp_cd
      ,a.pcor_icd10_cd_cnte
      ,a.mdrc_id   -- 55262939
      ,a.*
from acpprgcd a     /* 중증진료확인증정보 테이블 */
where pt_no = :IN_PT_NO
ORDER BY A.APY_STR_DT DESC;



SELECT
      A.PT_NO
     ,A.PCOR_ICD10_CD_CNTE
    -- ,A.PCOR_ICD10_CD_DUP_SEQ_CD
     ,A.LSH_DTM
     ,A.LSH_PRGM_NM
     ,A.*
FROM ACPPRGCH A      /* 중증진료확인증정보 히스토리 테이블 */
where pt_no = :IN_PT_NO
ORDER BY A.LSH_DTM DESC;




SELECT m.PT_NO
      ,M.REC_DTM
      ,PACT_DTM
      ,MDFM_CLS_CD
--      -,COUNT(MDRC_ID)
      ,m.*
  FROM MRDDRECM m  /* 진료기록기본 테이블 */
      ,pctpcpam p
 WHERE 1=1
   and m.pt_no = p.pt_no(+)
   and m.PT_NO = :IN_PT_NO
   AND m.MDFM_CLS_CD = 'D009'
   AND m.MDRC_WRT_STS_CD > 10
   AND m.MDRC_DC_TP_CD = 'C'  -- 진료기록중단구분코드
   AND m.LST_YN = 'Y'         -- 서명
   AND m.REC_DTM > '20180101'
   AND M.MDRC_FOM_SEQ = (SELECT MAX(M.MDRC_FOM_SEQ) OVER (PARTITION BY MDRC_ID ORDER BY M.MDRC_FOM_SEQ)
                           FROM DUAL)
ORDER BY M.REC_DTM DESC
;


select
      pt_nm
     , PLS_DECRYPT_B64_ID(pt_RRN, 800)     as ss
     , a.*
from pctpcpam a     /* 환자기본 테이블 */
where pt_no = :in_pt_no;



SELECT
    PKG_MOO_SRILRRNSCFSCINFASK.FT_MOO_GETSPECIALCASESTATUS(     -- 진료쪽 산정특례 팝업 프로시저
         PT_NO
        ,PME_CLS_CD
        ,MED_PACT_TP_CD
        ,MED_DEPT_CD
        ,MED_DT
        ,PACT_ID
        ,'20241203'       -- 조회조건일
        ,'TR')          -- 호출구분(TR:방종, null 그외)
                          as RESULT
FROM pctpcpam p
where p.pt_no = :in_pt_no


;



/*



*/

SELECT  /*+XMED.PKG_MOO_SRILRRNSCFSCINFASK.FT_MOO_GETSPECIALCASESTATUS_25*/
                '1' REG_GBN
            , APY_STR_DT
            , APY_END_DT
            , SRIL_CDOC_APLC_TP_CD
            , CFSC_CD
        FROM  ACPPRGHD  -- 중증산정특례신청서정보 (본원)
        WHERE  PT_NO     = :IN_PT_NO
        AND    HLTH_INS_MDC_TP_CD   = sPatType
        AND    APY_STR_DT <= dRareCheckDate
        AND    SRIL_CDOC_APLC_TP_CD   IN ('SC','TB','SS','TC','SD','21','23','14','LT')  -- 2016.03.31 극희귀 추가,  -- 2016.06.27 신규 결핵 추가, -- 2017.09.26 치매 추가   --2018.12 희귀:21 , 중증난치:23 추가 ,2019.01 기타염색체 추가
        AND    SRIL_APLC_CNCL_DTM   IS NULL                           -- 2021.06.17 잠복결핵 추가
          AND     APY_STR_DT   IS NOT NULL
          AND     APY_END_DT   IS NOT NULL


          union all
        select  '2' reg_gbn
            , APY_STR_DT
            , APY_END_DT
            , SRIL_CDOC_APLC_TP_CD
--            , CASE WHEN SRIL_CDOC_APLC_TP_CD IN ('TB', 'TC') THEN CASE WHEN SUBSTR(SRIL_CFMT_NO,1,2) IN ('05','11') THEN 'V206'
--                                                                       WHEN SUBSTR(SRIL_CFMT_NO,1,2) = '07'         THEN 'V246' ELSE ''
--                                                                  END
--                   WHEN SRIL_CDOC_APLC_TP_CD = 'SD' THEN FT_MOO_GET_DMTA_VCODE(sPatType, PCOR_ICD10_CD_CNTE, dDementiaCheckDate) -- 치매 V코드
--              END CFSC_CD

            -- 2018-07-09 타병원의 경우 V코드만 가지고 판단할수 없기에 V코드를 V246으로 통일하고 상병코드만 매칭시킨다.
            , CASE WHEN SRIL_CDOC_APLC_TP_CD IN ('TB', 'TC') THEN 'V246'
                   WHEN SRIL_CDOC_APLC_TP_CD = 'SD' THEN FT_MOO_GET_DMTA_VCODE(sPatType, PCOR_ICD10_CD_CNTE, dDementiaCheckDate) -- 치매 V코드
              END CFSC_CD

        from  ACPPRGCD -- 중증진료확인증정보 (타병원)
        WHERE  PT_NO     = :IN_PT_NO
        AND    HLTH_INS_MDC_TP_CD   = sPatType
        AND    APY_STR_DT   <= dRareCheckDate
        AND    SRIL_CDOC_APLC_TP_CD   IN ( 'SC','TB','SS','TC','SD','21','23','14','LT')
        AND    SRIL_APLC_CNCL_DTM   IS NULL
        AND     APY_STR_DT  IS NOT NULL
        AND     APY_END_DT    IS NOT NULL
        AND     OTHSP_PBL_YN = 'Y'   --타병원여부Y
            ORDER BY  SRIL_CDOC_APLC_TP_CD, APY_END_DT, REG_GBN DESC  ;




