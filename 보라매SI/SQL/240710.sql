/*모바일 하이패스 */
SELECT *
FROM EMBUMENT
WHERE MENU_NM LIKE '%환자%' AND MENU_NM LIKE '%정보%'
order by MENU_ID desc;

SELECT *
FROM EMBUMENT
where Business_typ like '%PA%'
order by MENU_ID desc ;


-- -----------------------------------------------------------------------------------------------------------------------------------------------------
/* 11개  : 신청일자(dmd_no), 환자번호(dmd_acpt_no), 환자명, 주민번호, 승인여부(dmd_pact_tp_cd) , 환자급종, 시작일자, 종료일자, 카드회사, 카드 명의자, 카드번호*/
/*신청일자 (범위)-> 조회*/

-- 테이블 컬럼 정보 조회
SELECT *
FROM ALL_IND_COLUMNS
WHERE TABLE_NAME like 'ACPETHCD';


select *
from  AIMIPRQS ;

-- 테이블 조회
SELECT *
FROM ALL_TABLES
WHERE TABLE_NAME LIKE 'ACPETHCD';




-- ?여기서 부터 시작
/* 11개  :
신청일자(dmd_no),
환자번호(dmd_acpt_no),

환자명,
주민번호,

승인여부(dmd_pact_tp_cd) ,
환자급종(DMD_TP_CD),

시작일자(첫 진료),
종료일자(마지막 진료),

카드회사,
카드 명의자,
카드번호*/
select  count(*) from (SELECT    /* HIS.PA.AI.IC.AR.SelAcceptCardinalNumberAsk */
--? c는 consultation이고, d는 day 상담 날짜 -> 수진날

          A.DMD_PACT_TP_CD                              DMD_PACT_TP_CD            -- 진료 여부???
      ,   A.MED_YM                                      MED_YM                    -- 진료 연월?
      ,   A.DMD_TP_CD                                   DMD_TP_CD                 -- 진료 타입? -> 환자 급종?
      ,   A.INS_KND_CD                                  INS_KND_CD                -- 보험 종류 코드?
      ,   A.HIRA_MTFL_CD                                HIRA_MTFL_CD              -- 건강보험 의료치료비 목록?
      ,   A.SHIP_SEQ                                    SHIP_SEQ                  --
      ,   A.DMD_NO                                      DMD_NO                    -- 신청일자
      ,   A.DMD_ACPT_NO                                 DMD_ACPT_NO               -- 환자번호
   FROM  AIMIPRQS A
WHERE   A.SCRG_CLSN_YN = 'Y' -- 진료 접수 승인 여부
	) a
;





-- -----------------------------------------------------------------------------------------------------------------------------------------------------
-- ?테이블을 잘못 썼다. "ACPETHCD(하이패스카드정보)" 테이블
EXEC :IN_FROM_DATE := '2023-03-01';
EXEC :IN_TO_DATE := '2024-07-10' ;

/* 11개  :
신청일자(dmd_no),
환자번호(dmd_acpt_no),

환자명,
주민번호,

승인여부(dmd_pact_tp_cd) ,
환자급종(DMD_TP_CD),

시작일자(첫 진료),
종료일자(마지막 진료),

카드회사,
카드 명의자,
카드번호*/
SELECT
       TO_CHAR(A.APLC_DT,'YYYY-MM-DD') AS			 APLC_DT                                		/* 신청일자 */
     , A.PT_NO                                 PT_NO                               		/* 환자번호 */
	   , B.PT_NM         PT_NM                            						/* 환자명 */
     , PLS_DECRYPT_B64_ID(A.APCT_RRN, 800) AS APCT_RRN	/* 주민번호 */
     , A.SMSS_PSB_YN    SMSS_PSB_YN                            		/* 승인여부???? */
     , B.PME_CLS_CD  PME_CLS_CD                                  /* 환자급종 */
     , TO_CHAR(A.APY_STR_DT, 'YYYY-MM-DD')           APY_STR_DT                      		/* 시작일자 */
     , A.APY_END_DT         APY_END_DT                        		/* 종료일자 */
     , A.CARD_CMP_NM         CARD_CMP_NM                       		/* 카드 회사 */
     , A.APCT_NM                APCT_NM                   		/* 카드 명의자 */
	   , PLS_DECRYPT_B64_ID(A.CARD_NO, 100) AS CARD_NO 	/* 카드번호 */
  FROM ACPETHCD A
     , PCTPCPAM B
 WHERE A.PT_NO = B.PT_NO
   AND A.APLC_DT BETWEEN TO_DATE(:IN_FROM_DATE,'YYYY-MM-DD')
                     AND TO_DATE(:IN_TO_DATE,'YYYY-MM-DD')
   AND ROWNUM < 10

  ;

select *
from ACPETHCD
where rownum <100;

