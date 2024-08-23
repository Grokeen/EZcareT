EXEC :IN_FROM_DATE := '2023-07-01';
EXEC :IN_TO_DATE := '2024-08-02' ;
EXEC :IN_SMSS_PSB_YN := 'Y';


SELECT /*+ HIS.PA.AC.PE.PS.HIPASSMOBILEAPPROVALMNG */
     TO_CHAR(A.APLC_DT,'YYYY-MM-DD')                                                                                 AS APLC_DT             /* 신청일자 */
   , A.PT_NO                                                                                                         AS PT_NO               /* 환자번호 */
   , B.PT_NM                                                                                                         AS PT_NM               /* 환자명 */
   , SUBSTR(PLS_DECRYPT_B64_ID(A.APCT_RRN, 800),1,6)||'-'||SUBSTR(PLS_DECRYPT_B64_ID(A.APCT_RRN, 800),7,1)||'******' AS APCT_RRN            /* 주민번호 */
   , DECODE(CNCL_DT,NULL,'Y','N' )                                                                                   AS SMSS_PSB_YN         /* 승인여부 */   
   , B.PME_CLS_CD                                                                                                    AS PME_CLS_CD          /* 환자급종 */
   , TO_CHAR(A.APY_STR_DT, 'YYYY-MM-DD')                                                                             AS APY_STR_DT          /* 시작일자 */
   , TO_CHAR(A.APY_END_DT, 'YYYY-MM-DD')                                                                             AS APY_END_DT          /* 종료일자 */
   , TRIM(A.CARD_CMP_NM)                                                                                             AS CARD_CMP_NM         /* 카드 회사 */
   , A.APCT_NM                                                                                                       AS APCT_NM             /* 카드 명의자 */
   , PLS_DECRYPT_B64_ID(A.CARD_NO, 100)                                                                              AS CARD_NO             /* 카드번호 */

  FROM
    HBIL.ACPETHCD A /*하이패스카드등록정보('HBIL.' 나중에 수정)*/
   ,PCTPCPAM B      /*환자정보*/
 WHERE 1 =1
   AND A.PT_NO = B.PT_NO
   AND (A.APLC_DT BETWEEN TO_DATE(:IN_FROM_DATE,'YYYY-MM-DD')
                      AND TO_DATE(:IN_TO_DATE,'YYYY-MM-DD'))   
                      
                      
                      
 ;
 AND (  (:IN_SMSS_PSB_YN IS NULL)
       OR (TO_DATE(:IN_FROM_DATE,'YYYY-MM-DD') IS NOT NULL 
          AND ( 
                A.PT_NO = B.PT_NO 
                OR ( A.APLC_DT BETWEEN TO_DATE(:IN_FROM_DATE,'YYYY-MM-DD') 
                                   AND TO_DATE(:IN_TO_DATE,'YYYY-MM-DD') ) 

                OR (SMSS_PSB_YN = :IN_SMSS_PSB_YN)
            )   
        )
    );
/*-----------------------------------------------------------------------------------*/
/*-----------------------------------------------------------------------------------*/
/*-----------------------------------------------------------------------------------*/
/*-----------------------------------------------------------------------------------*/
/*-----------------------------------------------------------------------------------*/
/*-----------------------------------------------------------------------------------*/
-- 테이블 조회
SELECT C.COMMENTS COMMENTS_TAB
--     , A.COLUMN_ID
--     , A.OWNER
     , A.TABLE_NAME
     , A.COLUMN_NAME
     , A.DATA_TYPE
     , B.COMMENTS COMMENTS_COL

     , A.DATA_LENGTH
     , DECODE(A.NULLABLE, 'N', 'Y', NULL) NOTNULL


  FROM ALL_TAB_COLUMNS A
     , ALL_COL_COMMENTS B
     , ALL_TAB_COMMENTS C

 WHERE A.TABLE_NAME = 'appatbat'
--   AND A.OWNER      = 'HBIL'
   AND A.OWNER      = B.OWNER
   AND A.TABLE_NAME = B.TABLE_NAME
   AND A.COLUMN_NAME= B.COLUMN_NAME
   AND A.TABLE_NAME = C.TABLE_NAME
   AND A.OWNER = C.OWNER
 ORDER BY COLUMN_ID

;

/*-----------------------------------------------------------------------------------*/
/*-----------------------------------------------------------------------------------*/
/*-----------------------------------------------------------------------------------*/
/*-----------------------------------------------------------------------------------*/
/*-----------------------------------------------------------------------------------*/
/*-----------------------------------------------------------------------------------*/
-- ASIS 화


<sql id="HIS.PA.AC.PE.PS.HipassMobileApprovalMng">
<!--
    Clss :  text
    Desc : 하이패스모바일승인조회
    Author : 김용록
    Create date : 2024-08-02
    Update date : 2024-08-02 
    as-is : .sql / pc_ap_HipssMobileAprvList
-->

PROCEDURE pc_ap_HipssMobileAprvList (  IN_FROM_DATE 		in  varchar2
                                    ,  IN_TO_DATE   		in  varchar2
                                    ,  IN_SMSS_PSB_YN   in  varchar2
	                                  ,  out_cursor     out sys_refcursor) 
is wk_cursor  	returncursor;
begin
   begin
      open wk_cursor for
         SELECT * FROM ( /*+ HIS.PA.AC.PE.PS.HipassMobileApprovalMng */
            SELECT 
                 TO_CHAR(A.APLC_DT,'YYYY-MM-DD')                                                                                 AS APLC_DT             /* 신청일자 */
               , A.PT_NO                                                                                                         AS PT_NO               /* 환자번호 */
               , B.PT_NM                                                                                                         AS PT_NM               /* 환자명 */
               , SUBSTR(PLS_DECRYPT_B64_ID(A.APCT_RRN, 800),1,6)||'-'||SUBSTR(PLS_DECRYPT_B64_ID(A.APCT_RRN, 800),7,1)||'******' AS APCT_RRN            /* 주민번호 */
               , DECODE(CNCL_DT,NULL,'Y','N' )                                                                                   AS SMSS_PSB_YN         /* 승인여부 */
               , B.PME_CLS_CD                                                                                                    AS PME_CLS_CD          /* 환자급종 */
               , TO_CHAR(A.APY_STR_DT, 'YYYY-MM-DD')                                                                             AS APY_STR_DT          /* 시작일자 */
               , TO_CHAR(A.APY_END_DT, 'YYYY-MM-DD')                                                                             AS APY_END_DT          /* 종료일자 */
               , TRIM(A.CARD_CMP_NM)                                                                                             AS CARD_CMP_NM         /* 카드 회사 */
               , A.APCT_NM                                                                                                       AS APCT_NM             /* 카드 명의자 */
               , PLS_DECRYPT_B64_ID(A.CARD_NO, 100)                                                                              AS CARD_NO             /* 카드번호 */
            
              FROM
                HBIL.ACPETHCD A /*하이패스카드등록정보('HBIL.' 나중에 수정)*/
               ,PCTPCPAM B      /*환자정보*/
             WHERE 1 =1
             AND A.PT_NO = B.PT_NO
             AND A.APLC_DT BETWEEN TO_DATE(:IN_FROM_DATE,'YYYY-MM-DD')
                               AND TO_DATE(:IN_TO_DATE,'YYYY-MM-DD')
         ) WHERE SMSS_PSB_YN LIKE '%'|| :IN_SMSS_PSB_YN || '%';
		out_cursor := wk_cursor; 
				      	                         
	 exception
		  when others then
			   raise_application_error(-20500,'모바일 하이패스 승인 내역 조회 select error!');
	 end;	
end pc_ap_HipssMobileAprvList;


</sql>
-------------------------------------------------------------------------------------------------
-- TOBE 화
<sql id="HIS.PA.AC.PE.PS.HipassMobileApprovalMng">
<!--
    Clss :  text
    Desc : 하이패스모바일승인조회
    Author : 김용록
    Create date : 2024-08-02
    Update date : 2024-08-02 
    as-is : .sql / pc_ap_HipssMobileAprvList
-->
SELECT * FROM ( /*+ HIS.PA.AC.PE.PS.HipassMobileApprovalMng */
   SELECT 
        TO_CHAR(A.APLC_DT,'YYYY-MM-DD')                                                                                 AS APLC_DT             /* 신청일자 */
      , A.PT_NO                                                                                                         AS PT_NO               /* 환자번호 */
      , B.PT_NM                                                                                                         AS PT_NM               /* 환자명 */
      , SUBSTR(PLS_DECRYPT_B64_ID(A.APCT_RRN, 800),1,6)||'-'||SUBSTR(PLS_DECRYPT_B64_ID(A.APCT_RRN, 800),7,1)||'******' AS APCT_RRN            /* 주민번호 */
      , DECODE(CNCL_DT,NULL,'Y','N' )                                                                                   AS SMSS_PSB_YN         /* 승인여부 */
      , B.PME_CLS_CD                                                                                                    AS PME_CLS_CD          /* 환자급종 */
      , TO_CHAR(A.APY_STR_DT, 'YYYY-MM-DD')                                                                             AS APY_STR_DT          /* 시작일자 */
      , TO_CHAR(A.APY_END_DT, 'YYYY-MM-DD')                                                                             AS APY_END_DT          /* 종료일자 */
      , TRIM(A.CARD_CMP_NM)                                                                                             AS CARD_CMP_NM         /* 카드 회사 */
      , A.APCT_NM                                                                                                       AS APCT_NM             /* 카드 명의자 */
      , PLS_DECRYPT_B64_ID(A.CARD_NO, 100)                                                                              AS CARD_NO             /* 카드번호 */
   
     FROM
       HBIL.ACPETHCD A /*하이패스카드등록정보('HBIL.' 나중에 수정)*/
      ,PCTPCPAM      B /*환자정보*/
    WHERE 1 =1
      AND A.PT_NO = B.PT_NO
      AND A.APLC_DT BETWEEN TO_DATE(:IN_FROM_DATE,'YYYY-MM-DD')
                      AND TO_DATE(:IN_TO_DATE,'YYYY-MM-DD')
   ) WHERE SMSS_PSB_YN LIKE '%'|| :IN_SMSS_PSB_YN || '%'
</sql>