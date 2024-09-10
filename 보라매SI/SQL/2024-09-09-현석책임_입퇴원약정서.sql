
SELECT
   *
FROM EMBUMENT
WHERE MENU_NM LIKE '%설정%'
--   AND BUSINESS_TYP = 'AC'
;

-- AC_HIS.PA.AC.PE.AP.UI_/AdsWragReg ------------------------------------------------------------------------------------------
-- AC_HIS.PA.AC.PE.AP.UI_/AdsAgrmPtclAsk --------------------------------------------------------------------------------------

SELECT
   *
FROM ACPPRAAM
WHERE ROWNUM < 10
   AND TO_DATE(TO_CHAR(ADS_DT,'yyyy-mm-dd'),'YYYY-MM-DD') = TO_DATE('2024-09-09','yyyy-mm-dd');


-- ST_HIS.PA.ST.SM.CO.UI_/BadmSttsAskCdtnStu.xaml -----------------------------------------------------------------------------



SELECT
   *
FROM CCCCCSTE
WHERE DTRL1_NM IS NOT NULL
   AND DTRL2_NM IS NOT NULL
   AND DTRL3_NM IS NOT NULL
   AND DTRL4_NM IS NOT NULL
   AND DTRL5_NM IS NOT NULL
   AND DTRL6_NM IS NOT NULL
AND ROWNUM <10;




SELECT
     COMN_CD_NM
   , COMN_CD
FROM CCCCCSTE
WHERE COMN_GRP_CD IN('282','258','271','380');



/**/EXEC :COMMENTCONTANT := '';                              /**/
/**/EXEC :COLUMNNAME := 'PA_RMK_CNTE';                              /**/
/* ----------------------------------------------------------- */
/* ----------------------------------------------------------- */
/* ----------------------------------------------------------- */
/**/select     /*테이블 컬럼 사용 빈도 확인*/                    /**/
/**/   A.OWNER,                                              /**/
/**/   A.TABLE_NAME,                                         /**/
/**/   A.COLUMN_NAME,                                        /**/
/**/   A.COMMENTS,                                           /**/
/**/   B.DATA_TYPE ,                                         /**/
/**/   B.DATA_LENGTH                                         /**/
/**/from                                                     /**/
/**/   dba_col_comments A,                                   /**/
/**/   dba_tab_columns B                                     /**/
/**/where                                                    /**/
/**/   A.comments like '%'|| :COMMENTCONTANT ||'%'           /**/
/**/   AND A.column_name like '%'|| :COLUMNNAME ||'%'        /**/
/**/   AND A.TABLE_NAME like '%'|| :TABLENAME ||'%'          /**/
/**/   AND A.OWNER = B.OWNER                                 /**/
/**/   AND A.TABLE_NAME = B.TABLE_NAME                       /**/
/**/   AND A.COLUMN_NAME = B.COLUMN_NAME                     /**/
/**/;                                                        /**/
/* ----------------------------------------------------------- */
/* ----------------------------------------------------------- */
/* ----------------------------------------------------------- */
/**/EXEC :COMMENTCONTANT := '프린';                              /**/
/**/EXEC :COLUMNNAME := '';                              /**/
/**/EXEC :TABLENAME := '';                              /**/



-- SRPTRLGT : HSUP 권한 부족
SELECT * FROM CNLCNUSD WHERE ROWNUM < 10;;
          
-- CNLCNUSD  : 사용자 환경설정 정보 테이블
                                             

SELECT 
   USR_STF_NO              /* 직원번호 */
   ,RCP_PRNT_YN            /* 영수증출력여부 */         
   ,ACPT_RPY_YN            /* 접수수납여부 */
   ,PRTR_TOM_NM            /* 프린터기종명 */
   ,FSR_IP_ADDR            /* 최초등록IP주소 */
   ,


