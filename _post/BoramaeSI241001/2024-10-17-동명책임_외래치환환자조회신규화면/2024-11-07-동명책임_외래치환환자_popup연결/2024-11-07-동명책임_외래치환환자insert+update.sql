
EXEC :IN_PT_NO := '00653125';
EXEC :IN_PACT_ID := 'MI0065312520240217';
SELECT
      PT_NO
    , PACT_ID
    , CTN_TGPT_INPT_DT
    , CTN_TGPT_SEQ
    , TRAN_RMK
    , CMPT_WK_CMPL_YN
    , CMPT_WK_CMPL_DT
    , PRO_WK_STF_NO
    , PRO_DTM
    , BOBD_PT_NO
    , BIND_DTM
    , BIND_STF_NO
    , FSR_STF_NO
    , FSR_DTM
    , FSR_PRGM_NM
    , FSR_IP_ADDR
    , LSH_STF_NO
    , LSH_DTM
    , LSH_PRGM_NM
    , LSH_IP_ADDR
FROM ACPPRITD
WHERE
      PT_NO = :IN_PT_NO
--  AND PACT_ID = :IN_PACT_ID


;;;;


 SELECT
      TRAN_RMK
    , LSH_STF_NO
    , LSH_DTM
    , LSH_PRGM_NM
    , LSH_IP_ADDR
 FROM ACPPRITD
 WHERE
      PT_NO   = :IN_PT_NO
  AND PACT_ID = :IN_PACT_ID
;;;;;;;;

UPDATE ACPPRITD /*+ HIS.PA.AC.PI.PS.SelectOtptReplacePatientAsk_UPDATE */
    SET
      PT_NO          =:IN_PT_NO
    , PACT_ID        =:IN_PACT_ID
    , CTN_TGPT_INPT_DT=:IN_CTN_TGPT_INPT_DT
    , CTN_TGPT_SEQ   =:IN_CTN_TGPT_SEQ
    , TRAN_RMK       =:IN_TRAN_RMK
    , CMPT_WK_CMPL_YN=:IN_CMPT_WK_CMPL_YN
    , CMPT_WK_CMPL_DT=:IN_CMPT_WK_CMPL_DT
    , PRO_WK_STF_NO  =:IN_PRO_WK_STF_NO
    , PRO_DTM        =:IN_PRO_DTM
    , BOBD_PT_NO     =:IN_BOBD_PT_NO
    , BIND_DTM       =:IN_BIND_DTM
    , BIND_STF_NO    =:IN_BIND_STF_NO
    , LSH_STF_NO     =:IN_LSH_STF_NO
    , LSH_DTM        =:IN_LSH_DTM
    , LSH_PRGM_NM    =:IN_LSH_PRGM_NM
    , LSH_IP_ADDR    =:IN_LSH_IP_ADDR
 WHERE
      PT_NO   = :IN_PT_NO
  AND PACT_ID = :IN_PACT_ID

,,,,,

 UPDATE ACPPRITD
    SET
      TRAN_RMK       =:IN_TRAN_RMK
    , LSH_STF_NO     =:HIS_STF_NO
    , LSH_DTM        =SYSDATE
    , LSH_PRGM_NM    =:HIS_PRGM_NM
    , LSH_IP_ADDR    =:HIS_IP_ADDR
 WHERE
      PT_NO   = :IN_PT_NO
  AND PACT_ID = :IN_PACT_ID

 ;;;;;;;;;;;

INSERT INTO
    ACPPRITD ( /* 입원취소외래치환정보 테이블 */
          PT_NO
        , PACT_ID
        , CTN_TGPT_INPT_DT
        , CTN_TGPT_SEQ
        , TRAN_RMK
        , CMPT_WK_CMPL_YN
        , CMPT_WK_CMPL_DT
        , PRO_WK_STF_NO
        , PRO_DTM
        , BOBD_PT_NO
        , BIND_DTM
        , BIND_STF_NO
        , FSR_STF_NO
        , FSR_DTM
        , FSR_PRGM_NM
        , FSR_IP_ADDR
        , LSH_STF_NO
        , LSH_DTM
        , LSH_PRGM_NM
        , LSH_IP_ADDR

        )
VALUES (
          :IN_PT_NO
        , :IN_PACT_ID
        , TO_DATE(:IN_CTN_TGPT_INPT_DT)
                               /* 주의대상환자입력일자 */
        , :IN_CTN_TGPT_SEQ     /* 주의대상환자순번 */
        , :IN_TRAN_RMK         /* 치환비고 */
        , :IN_CMPT_WK_CMPL_YN  /* 전산작업완료여부 (not null) */
        , TO_DATE(:IN_CMPT_WK_CMPL_DT)
                               /* 전산작업완료일자 = 처리일시? */
        , :IN_PRO_WK_STF_NO    /* 처리작업직원번호 */
        , TO_DATE(:IN_PRO_DTM) /* 처리일시 = 전산작업완료일자? */
        , :IN_BOBD_PT_NO       /* 합본이전환자번호 */
        , TO_DATE(:IN_BIND_DTM)/* 합본일시 */
        , :IN_BIND_STF_NO      /* 합본직원번호 */
        , :HIS_STF_NO
        , SYSDATE
        , :HIS_PRGM_NM
        , :HIS_IP_ADDR
        , :HIS_STF_NO
        , SYSDATE
        , :HIS_PRGM_NM
        , :HIS_IP_ADDR
        )


;

,  A.LSH_STF_NO    = :HIS_STF_NO
    ,  A.LSH_DTM       = SYSDATE
    ,  A.LSH_PRGM_NM   = :HIS_PRGM_NM
    ,  A.LSH_IP_ADDR   = :HIS_IP_ADDR


             ;;;


-----------------------------------------------------------------------------------

select *
	from acpprgcd
where pt_no ='00899278'
--20241101		이원철	6005271716217	010-4658-5057	02-851-4815	08703	서울특별시 관악구 신사로22길 6 (신림동)	401호	1		1	1	01	2	20241023	V193	1	C61	01	1	0	0	0	0		0	0		0	0	0	0	0	0		0	0	0	0	0			서울특별시보라매병원	11100249	600527	105520	이정훈			이원철	01	20241031	20241101	1	01	2	20241023	V193	1	C61	01	1	0	0	0	0		1	01	2	20241023	V193	1	C61	01	1	0	0	0	0		1	01	2	20241023	V193	1	C61	01	1	0	0	0	0		비뇨의학과	Y	20241101
--박진희 670526-2804333 기등록자




;;;
select EDI_TRSM_YN, APY_END_DT, a.*
  from ACPPRGHD a
 where pt_no = '00571273'  ;

 select  *
  from ACPPRGHD a
 where pt_no = '00571273'  ;
;;;


edi_trsm_dt , edi_rcv_dt,

;;;
SELECT *  from ACPPRGCD
 where pt_no = '00571273' ;

;;;
select

pt_no,sril_cfmt_no,hlth_insc_no ,apy_str_dt ,apy_end_dt, cfmt_dt     , pcor_icd10_cd_cnte

 from ACPPRGCD
 where pt_no = '00571273' ;



-- 산정특례 번호 : 0121115134




;;;
---------------------------------------------------------------------------------------------------
SELECT *
  FROM CCCCCSTE
   WHERE COMN_GRP_CD ='260'
   ;;


   SELECT *
     FROM APSTATMT2
     WHERE MED_DTE = '20240905'




;;;
---------------------------------------------------------------------------------------------------
